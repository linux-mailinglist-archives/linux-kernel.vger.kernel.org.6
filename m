Return-Path: <linux-kernel+bounces-381123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FC839AFAA3
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 09:09:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14F3C1F23CBF
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 07:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C58131B218C;
	Fri, 25 Oct 2024 07:09:10 +0000 (UTC)
Received: from ssh248.corpemail.net (ssh248.corpemail.net [210.51.61.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C52667A0D
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 07:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.61.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729840150; cv=none; b=KDk0ATI3uuxQbi+3uaeyeZ2zeJAmkwEKRkkM8q+9cT4vJwROWsF+3YBQZusXy8NVSv02DO/HuJ4rLjuzrPIBOFxRM7HIqcxtrRkYeAE314ftbdImK4lqtM001aLayClZfLaZQ6UFAIOtODrGv9K9W8dVdmsHH8G6j0w2VymjU/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729840150; c=relaxed/simple;
	bh=5Zdlxy1Y/+lrg50jrZkUOZ5+B/B8UJaqimxISIwsong=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=h+j2AAq6spDHUJ3ZJ4QsBltotzSdPf2EGDBr98q//oaeG7UdBPh5ScUxRsdNc262utXsvW4KumEyPEd3/pQFoK2mGqQjhrl+hUNXtIcf0IH09Dec0C3Q//6TcXFvLIpN1MmRXxMgMJgi8i02k30x30U+VIXPwPlR+tM5d8UhfII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.61.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from ssh248.corpemail.net
        by ssh248.corpemail.net ((D)) with ASMTP (SSL) id VHG00144;
        Fri, 25 Oct 2024 15:07:44 +0800
Received: from jtjnmail201607.home.langchao.com (10.100.2.7) by
 jtjnmail201622.home.langchao.com (10.100.2.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 25 Oct 2024 15:07:46 +0800
Received: from localhost.localdomain (10.94.19.204) by
 jtjnmail201607.home.langchao.com (10.100.2.7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 25 Oct 2024 15:07:46 +0800
From: Charles Han <hanchunchao@inspur.com>
To: <stanley_chang@realtek.com>, <vkoul@kernel.org>, <kishon@kernel.org>,
	<gregkh@linuxfoundation.org>
CC: <johan+linaro@kernel.org>, <u.kleine-koenig@baylibre.com>,
	<linux-phy@lists.infradead.org>, <linux-kernel@vger.kernel.org>, Charles Han
	<hanchunchao@inspur.com>
Subject: [PATCH] phy: realtek: usb: fix NULL deref in rtk_usb3phy_probe
Date: Fri, 25 Oct 2024 15:07:44 +0800
Message-ID: <20241025070744.149070-1-hanchunchao@inspur.com>
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
tUid: 2024102515074420f08e701335df5e366a5b17e873c955
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

In rtk_usb3phy_probe() devm_kzalloc() may return NULL
but this returned value is not checked.

Fixes: adda6e82a7de ("phy: realtek: usb: Add driver for the Realtek SoC USB 3.0 PHY")
Signed-off-by: Charles Han <hanchunchao@inspur.com>
---
 drivers/phy/realtek/phy-rtk-usb3.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/phy/realtek/phy-rtk-usb3.c b/drivers/phy/realtek/phy-rtk-usb3.c
index 0cef29a7ddd9..cce453686db2 100644
--- a/drivers/phy/realtek/phy-rtk-usb3.c
+++ b/drivers/phy/realtek/phy-rtk-usb3.c
@@ -577,6 +577,8 @@ static int rtk_usb3phy_probe(struct platform_device *pdev)
 
 	rtk_phy->dev			= &pdev->dev;
 	rtk_phy->phy_cfg = devm_kzalloc(dev, sizeof(*phy_cfg), GFP_KERNEL);
+	if (!rtk_phy->phy_cfg)
+		return -ENOMEM;
 
 	memcpy(rtk_phy->phy_cfg, phy_cfg, sizeof(*phy_cfg));
 
-- 
2.31.1


