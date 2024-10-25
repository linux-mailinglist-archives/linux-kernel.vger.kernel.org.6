Return-Path: <linux-kernel+bounces-381411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 885E59AFEC2
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 11:47:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA5511C213A1
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 09:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35A091D3633;
	Fri, 25 Oct 2024 09:47:09 +0000 (UTC)
Received: from unicom146.biz-email.net (unicom146.biz-email.net [210.51.26.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819AE12FB1B
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 09:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.26.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729849628; cv=none; b=dEj14rOp94llg8A3C/l/BTu5qUa3VxgD+SL2C+XbJAdD9PcK1nsERg9E0fLAy0DZ9Q0Oh/zerb6sf5/capCXZj7H5+m7gRTs2+1ZfJM4dwDNG8x6e/OlASuFPxvPMBYoaeCiCo0V1bDSKNtBO5zROcwMEB2ClLiYwq8qyMOSoU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729849628; c=relaxed/simple;
	bh=XDLgBvKsETXqAR3dxS3p599wKKcS2nz21XKup0ObEPw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BRY64fzZ/Gtb8DOA5ipEfxrA7LyuWjblJQXbqDiy/Y2sXQW4FcqJGkptZ0WmvuqBF0QunkmWPqv9kM2KSaPNdv0Q+dZmMltN6LsKqv3QbgoNLIcC351TTihIxOEmG3jAIF8Jt9m+LoF5WYQ7qQblX5p3ne71gNqNGamCPUIlNeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.26.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from unicom146.biz-email.net
        by unicom146.biz-email.net ((D)) with ASMTP (SSL) id WLU00151;
        Fri, 25 Oct 2024 17:46:51 +0800
Received: from jtjnmail201607.home.langchao.com (10.100.2.7) by
 jtjnmail201611.home.langchao.com (10.100.2.11) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 25 Oct 2024 17:46:52 +0800
Received: from localhost.localdomain (10.94.19.204) by
 jtjnmail201607.home.langchao.com (10.100.2.7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 25 Oct 2024 17:46:52 +0800
From: Charles Han <hanchunchao@inspur.com>
To: <stanley_chang@realtek.com>, <myungjoo.ham@samsung.com>,
	<cw00.choi@samsung.com>
CC: <linux-kernel@vger.kernel.org>, Charles Han <hanchunchao@inspur.com>
Subject: [PATCH] extcon: realtek: fix NULL deref check in extcon_rtk_type_c_probe
Date: Fri, 25 Oct 2024 17:46:50 +0800
Message-ID: <20241025094650.253599-1-hanchunchao@inspur.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: Jtjnmail201614.home.langchao.com (10.100.2.14) To
 jtjnmail201607.home.langchao.com (10.100.2.7)
tUid: 202410251746512ec169933b9b7889252f923db7329132
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

In extcon_rtk_type_c_probe() devm_kzalloc() may return NULL but this
returned value is not checked.

Fixes: 8a590d7371f0 ("extcon: add Realtek DHC RTD SoC Type-C driver")
Signed-off-by: Charles Han <hanchunchao@inspur.com>
---
 drivers/extcon/extcon-rtk-type-c.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/extcon/extcon-rtk-type-c.c b/drivers/extcon/extcon-rtk-type-c.c
index 19a01e663733..2820c7e82481 100644
--- a/drivers/extcon/extcon-rtk-type-c.c
+++ b/drivers/extcon/extcon-rtk-type-c.c
@@ -1369,6 +1369,8 @@ static int extcon_rtk_type_c_probe(struct platform_device *pdev)
 	}
 
 	type_c->type_c_cfg = devm_kzalloc(dev, sizeof(*type_c_cfg), GFP_KERNEL);
+	if (!type_c->type_c_cfg)
+		return -ENOMEM;
 
 	memcpy(type_c->type_c_cfg, type_c_cfg, sizeof(*type_c_cfg));
 
-- 
2.31.1


