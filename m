Return-Path: <linux-kernel+bounces-361821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 425DE99AD69
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 22:17:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 869FA286D5B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 20:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A9FF1D0F7D;
	Fri, 11 Oct 2024 20:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="cO6EiQcc"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08CD01CEAD1
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 20:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728677843; cv=none; b=uZ26WQqz1JAIuvzW30Z4xk4Jqpre0wDk4fM+VZ6EUqMMSiAgywSeXxzLFKxNl4OGdh2j6m3Yi3kkjIHxNxDjJ4d/OgDW6ToU2ZNoWnNZw/FCjx8qRkCQXyEaRCOJc8YFAW1OnwA8X1Y7pGHBzh0aSG4ekXj9cIbZnpPh6/e3jO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728677843; c=relaxed/simple;
	bh=nuJrTRgLsjQExs+N87GmazFylclUiz4XenNuLHwBWV4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TqKHb5HHp0bDwaSDTWxKz7eZT5Nf9unh6PjqYXSqZZWEpFAolARsz0IDJovOuv4XGC2ygHt638zu6xLhQXHLyH1vrf6nPp75pczo693il59fusqJqB186XOlK+knzrVprfTBKayXHuScdA1frm9Wzswre9Fmfgz5KqprwskByB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=cO6EiQcc; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 49BKGmpq029272;
	Fri, 11 Oct 2024 15:16:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1728677808;
	bh=E1t2slHF8kd+FV4537/57jAGsLGmbZ2/z9jipE7qiaU=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=cO6EiQccwunGVaaLhOQuDvy7+HkSBag7zmv2w2vvMRoDuHuPkFxcA7L9uAFEb4da8
	 L/Gr94by7cJ+owKLrerV9+bEl3BraFW4aS705mELdiI9A8SiDUpo7IM9fW+vEPJpFl
	 WXyrZ1QOvy01aNRnhuGnY0GCrCOfsKb+aXkldYHU=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 49BKGmNo028957
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 11 Oct 2024 15:16:48 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 11
 Oct 2024 15:16:48 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 11 Oct 2024 15:16:48 -0500
Received: from fllvsmtp7.itg.ti.com ([10.249.42.149])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49BKGkCI102075;
	Fri, 11 Oct 2024 15:16:47 -0500
From: Andrew Davis <afd@ti.com>
To: Andre Przywara <andre.przywara@arm.com>,
        Russell King
	<linux@armlinux.org.uk>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer
	<s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
        Sebastian
 Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory Clement
	<gregory.clement@bootlin.com>,
        Daniel Mack <daniel@zonque.org>,
        Haojian
 Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <imx@lists.linux.dev>, Andrew Davis <afd@ti.com>
Subject: [PATCH v3 2/6] ARM: imx: Switch to new sys-off handler API
Date: Fri, 11 Oct 2024 15:16:41 -0500
Message-ID: <20241011201645.797394-3-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241011201645.797394-1-afd@ti.com>
References: <20241011201645.797394-1-afd@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Kernel now supports chained power-off handlers. Use
register_platform_power_off() that registers a platform level power-off
handler. Legacy pm_power_off() will be removed once all drivers and archs
are converted to the new sys-off API.

Signed-off-by: Andrew Davis <afd@ti.com>
Acked-by: Shawn Guo <shawnguo@kernel.org>
---
 arch/arm/mach-imx/pm-imx6.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-imx/pm-imx6.c b/arch/arm/mach-imx/pm-imx6.c
index b36f05b54cc76..a671ca498f887 100644
--- a/arch/arm/mach-imx/pm-imx6.c
+++ b/arch/arm/mach-imx/pm-imx6.c
@@ -634,13 +634,11 @@ static void imx6_pm_stby_poweroff(void)
 
 static int imx6_pm_stby_poweroff_probe(void)
 {
-	if (pm_power_off) {
-		pr_warn("%s: pm_power_off already claimed  %p %ps!\n",
-			__func__, pm_power_off, pm_power_off);
+	if (register_platform_power_off(imx6_pm_stby_poweroff)) {
+		pr_warn("%s: platform power off already claimed!\n", __func__);
 		return -EBUSY;
 	}
 
-	pm_power_off = imx6_pm_stby_poweroff;
 	return 0;
 }
 
-- 
2.39.2


