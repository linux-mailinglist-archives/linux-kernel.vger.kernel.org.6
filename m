Return-Path: <linux-kernel+bounces-424198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D4A89DB188
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 03:41:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E54C5282383
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 02:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99C6E5A79B;
	Thu, 28 Nov 2024 02:41:53 +0000 (UTC)
Received: from unicom146.biz-email.net (unicom146.biz-email.net [210.51.26.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41AF3433B1
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 02:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.26.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732761713; cv=none; b=OHnax5qd0kI4CuQXNjpX8nkjUANzeHn/rDNaeol5UHUwOLlqqmSFpyTPYqPqYQXDqRpoFVNGfLscE4biUx9Mqj0cWJtj+QFaTrA9XOhpE8tmmdBIbyJyWmsu7wVCemBtPdciTZ/AEEiaIbUmz7yRnzwdmI1+naIcN5aU1zHzK2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732761713; c=relaxed/simple;
	bh=jyfqwyfB+B0TaWJtWfyYs8o23WNwLYhM5xw7upDqr0s=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BYNawj3DvSHVyUAeUIBr1P0to7YUFIUS9LSlYElVf57NhrLh6fvslxgV/JDh8rjW3SaijFalI/0R2tbU6YkAvT1F4GMInyTWvUzrEljVkqi2k+0fCVGDtOZMIsUEYUDCHdyYnjapVVU7O9EVVIgZxC1cNVLCya88lH3729fLKSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.26.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from unicom146.biz-email.net
        by unicom146.biz-email.net ((D)) with ASMTP (SSL) id YDQ00128;
        Thu, 28 Nov 2024 10:40:28 +0800
Received: from jtjnmail201607.home.langchao.com (10.100.2.7) by
 jtjnmail201606.home.langchao.com (10.100.2.6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 28 Nov 2024 10:40:29 +0800
Received: from localhost.localdomain (10.94.11.239) by
 jtjnmail201607.home.langchao.com (10.100.2.7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 28 Nov 2024 10:40:28 +0800
From: Charles Han <hanchunchao@inspur.com>
To: <myungjoo.ham@samsung.com>, <cw00.choi@samsung.com>,
	<stanley_chang@realtek.com>
CC: <linux-kernel@vger.kernel.org>, Charles Han <hanchunchao@inspur.com>
Subject: [PATCH] extcon: realtek: Add NULL pointer check in extcon_rtk_type_c_probe
Date: Thu, 28 Nov 2024 10:40:26 +0800
Message-ID: <20241128024026.21213-1-hanchunchao@inspur.com>
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
tUid: 20241128104028c90ede65137042cf8d5687703a52e855
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

devm_kzalloc() can return a NULL pointer on failure,but this
returned value in extcon_rtk_type_c_probe() is not checked.
Add NULL check in extcon_rtk_type_c_probe(), to handle kernel NULL
pointer dereference error.

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


