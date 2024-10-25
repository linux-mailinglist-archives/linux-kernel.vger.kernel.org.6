Return-Path: <linux-kernel+bounces-381112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2E979AFA82
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 08:59:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B884D28296D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 06:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91AEB1B6CF4;
	Fri, 25 Oct 2024 06:59:33 +0000 (UTC)
Received: from unicom145.biz-email.net (unicom145.biz-email.net [210.51.26.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6BCF1B0F14
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 06:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.26.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729839573; cv=none; b=GR5kbb/hg1cTDkJfBYxqXegVbneLjZjb7q97j/USFiifDB4xcKbfuQP+d1n4v1qSqBVSLRTWbh4F3SfSQn75Wb5SjZwmkNba2NbT5l8mojLCGeyhM1OHddqAYrCaFjG6vFtAXGh3hz5Vdv9zL4Sjs7JRaB98gq6NI4jbvhpIbz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729839573; c=relaxed/simple;
	bh=Ewa3o6bHgK7MFSicZm63l4qyXqNv/RuAai6txUM9vA4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OvN3LU8YlO29sW4aSkJHWRASQhNVRgSyLE7I5BvBNuJQWfdPWNz3C4VIYvAk/R+514fHcMfDo2tLt/qP+ZiPTa0XDUX87SUBeBjwT0wCq0M/SZy7exO5jAWndOXY8mdVurhNczFBaJH9ARJ1IRY6N6xo//nqOKKMtVTTI6GxJMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.26.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from unicom145.biz-email.net
        by unicom145.biz-email.net ((D)) with ASMTP (SSL) id VGG00015;
        Fri, 25 Oct 2024 14:59:15 +0800
Received: from jtjnmail201607.home.langchao.com (10.100.2.7) by
 jtjnmail201623.home.langchao.com (10.100.2.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 25 Oct 2024 14:59:15 +0800
Received: from localhost.localdomain (10.94.19.204) by
 jtjnmail201607.home.langchao.com (10.100.2.7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 25 Oct 2024 14:59:14 +0800
From: Charles Han <hanchunchao@inspur.com>
To: <stanley_chang@realtek.com>, <vkoul@kernel.org>, <kishon@kernel.org>,
	<gregkh@linuxfoundation.org>
CC: <u.kleine-koenig@baylibre.com>, <linux-phy@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Charles Han <hanchunchao@inspur.com>
Subject: [PATCH] phy: realtek: usb: fix NULL deref in rtk_usb2phy_probe
Date: Fri, 25 Oct 2024 14:59:12 +0800
Message-ID: <20241025065912.143692-1-hanchunchao@inspur.com>
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
tUid: 20241025145915850c3bc1032dc40d09b9ab1aae06b497
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

In rtk_usb2phy_probe() devm_kzalloc() may return NULL
but this returned value is not checked.

Fixes: 134e6d25f6bd ("phy: realtek: usb: Add driver for the Realtek SoC USB 2.0 PHY")
Signed-off-by: Charles Han <hanchunchao@inspur.com>
---
 drivers/phy/realtek/phy-rtk-usb2.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/phy/realtek/phy-rtk-usb2.c b/drivers/phy/realtek/phy-rtk-usb2.c
index c3e131a64131..248550ef98ca 100644
--- a/drivers/phy/realtek/phy-rtk-usb2.c
+++ b/drivers/phy/realtek/phy-rtk-usb2.c
@@ -1023,6 +1023,8 @@ static int rtk_usb2phy_probe(struct platform_device *pdev)
 
 	rtk_phy->dev			= &pdev->dev;
 	rtk_phy->phy_cfg = devm_kzalloc(dev, sizeof(*phy_cfg), GFP_KERNEL);
+	if (!rtk_phy->phy_cfg)
+		return -ENOMEM;
 
 	memcpy(rtk_phy->phy_cfg, phy_cfg, sizeof(*phy_cfg));
 
-- 
2.31.1


