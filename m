Return-Path: <linux-kernel+bounces-208202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B0A1B90223D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 15:00:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C1491F20FF6
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 13:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C28C84E1F;
	Mon, 10 Jun 2024 13:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="w65KCt/Q"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B938681737
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 12:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718024401; cv=none; b=SQAZ6Zk8Q7Epq4cOclhwHLva/icN2o9jSun5pnrJZDQzWag4aqKBXl4ZDDAzH3rnfxP5ErDeKMi2Jk10mB5ROGvIzHcrtfxzaQRfEcJ8HaO7eRU7kqGWGFPKOwooBPqL8jh6TxsMm/TcPCH68zPeNbuFU2ZtIq0QCxG1wqCayko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718024401; c=relaxed/simple;
	bh=dSAjAr+wnVBnPTSFTNHMmjz+ASjCbSOA7VVnEQUNfXY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dIb5JYeJtN8wrA2stn85WYPI6i9l4HRuYyn/yuUN6u4q+FxMEMnGx2I0ch61fFAS1gNWP4lj3Aqces6NxykrSFTNKarmPfiEYmOHClJNvNBRfaqNoetgMrqbnNzKqFKifkbPFE19pGls0j+MU/CRrUtUXtZpHrtqSlvQa6g1MxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=w65KCt/Q; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45ACxRU0084552;
	Mon, 10 Jun 2024 07:59:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1718024367;
	bh=1kI9jO4Og9q9o5G7/v9MhM9iAwKUZEKqE2cN+f2H3R8=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=w65KCt/QGgwO19pvFYFW7u2HomvVgOdyOKkUk+aLeGsE9HCGcZSLXhQr9ASiLBc2I
	 Q7vwNm7RMQ3UU6gNtJwWXLFhBmuHSC8eCcNdKN4/XuEzcILa4CwWSVGxZ4q87p/DRp
	 j3+4SqTpJ9t9D7IjBLaxFUFPIQLdv0/BQJ3ERoCc=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45ACxRwG040406
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 10 Jun 2024 07:59:27 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 10
 Jun 2024 07:59:27 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 10 Jun 2024 07:59:27 -0500
Received: from lelvsmtp5.itg.ti.com ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45ACxP7W064068;
	Mon, 10 Jun 2024 07:59:26 -0500
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
Subject: [PATCH 3/6] ARM: orion5x: Switch to new sys-off handler API
Date: Mon, 10 Jun 2024 07:59:21 -0500
Message-ID: <20240610125924.86003-3-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240610125924.86003-1-afd@ti.com>
References: <20240610125924.86003-1-afd@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Kernel now supports chained power-off handlers. Use
register_platform_power_off() that registers a platform level power-off
handler. Legacy pm_power_off() will be removed once all drivers and archs
are converted to the new sys-off API.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 arch/arm/mach-orion5x/board-mss2.c             | 2 +-
 arch/arm/mach-orion5x/dns323-setup.c           | 6 +++---
 arch/arm/mach-orion5x/kurobox_pro-setup.c      | 2 +-
 arch/arm/mach-orion5x/mv2120-setup.c           | 2 +-
 arch/arm/mach-orion5x/net2big-setup.c          | 2 +-
 arch/arm/mach-orion5x/terastation_pro2-setup.c | 2 +-
 arch/arm/mach-orion5x/ts209-setup.c            | 2 +-
 arch/arm/mach-orion5x/ts409-setup.c            | 2 +-
 8 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-orion5x/board-mss2.c b/arch/arm/mach-orion5x/board-mss2.c
index b0f16d223adf5..9e3d69891d2f6 100644
--- a/arch/arm/mach-orion5x/board-mss2.c
+++ b/arch/arm/mach-orion5x/board-mss2.c
@@ -82,5 +82,5 @@ static void mss2_power_off(void)
 void __init mss2_init(void)
 {
 	/* register mss2 specific power-off method */
-	pm_power_off = mss2_power_off;
+	register_platform_power_off(mss2_power_off);
 }
diff --git a/arch/arm/mach-orion5x/dns323-setup.c b/arch/arm/mach-orion5x/dns323-setup.c
index 062109efa0ecc..fcd38ff7ca459 100644
--- a/arch/arm/mach-orion5x/dns323-setup.c
+++ b/arch/arm/mach-orion5x/dns323-setup.c
@@ -700,7 +700,7 @@ static void __init dns323_init(void)
 		if (gpio_request(DNS323_GPIO_POWER_OFF, "POWEROFF") != 0 ||
 		    gpio_direction_output(DNS323_GPIO_POWER_OFF, 0) != 0)
 			pr_err("DNS-323: failed to setup power-off GPIO\n");
-		pm_power_off = dns323a_power_off;
+		register_platform_power_off(dns323a_power_off);
 		break;
 	case DNS323_REV_B1:
 		/* 5182 built-in SATA init */
@@ -717,7 +717,7 @@ static void __init dns323_init(void)
 		if (gpio_request(DNS323_GPIO_POWER_OFF, "POWEROFF") != 0 ||
 		    gpio_direction_output(DNS323_GPIO_POWER_OFF, 0) != 0)
 			pr_err("DNS-323: failed to setup power-off GPIO\n");
-		pm_power_off = dns323b_power_off;
+		register_platform_power_off(dns323b_power_off);
 		break;
 	case DNS323_REV_C1:
 		/* 5182 built-in SATA init */
@@ -727,7 +727,7 @@ static void __init dns323_init(void)
 		if (gpio_request(DNS323C_GPIO_POWER_OFF, "POWEROFF") != 0 ||
 		    gpio_direction_output(DNS323C_GPIO_POWER_OFF, 0) != 0)
 			pr_err("DNS-323: failed to setup power-off GPIO\n");
-		pm_power_off = dns323c_power_off;
+		register_platform_power_off(dns323c_power_off);
 
 		/* Now, -this- should theoretically be done by the sata_mv driver
 		 * once I figure out what's going on there. Maybe the behaviour
diff --git a/arch/arm/mach-orion5x/kurobox_pro-setup.c b/arch/arm/mach-orion5x/kurobox_pro-setup.c
index acba066180801..339b10891808f 100644
--- a/arch/arm/mach-orion5x/kurobox_pro-setup.c
+++ b/arch/arm/mach-orion5x/kurobox_pro-setup.c
@@ -373,7 +373,7 @@ static void __init kurobox_pro_init(void)
 	i2c_register_board_info(0, &kurobox_pro_i2c_rtc, 1);
 
 	/* register Kurobox Pro specific power-off method */
-	pm_power_off = kurobox_pro_power_off;
+	register_platform_power_off(kurobox_pro_power_off);
 }
 
 #ifdef CONFIG_MACH_KUROBOX_PRO
diff --git a/arch/arm/mach-orion5x/mv2120-setup.c b/arch/arm/mach-orion5x/mv2120-setup.c
index b7327a6128353..5b0249f109cde 100644
--- a/arch/arm/mach-orion5x/mv2120-setup.c
+++ b/arch/arm/mach-orion5x/mv2120-setup.c
@@ -238,7 +238,7 @@ static void __init mv2120_init(void)
 	if (gpio_request(MV2120_GPIO_POWER_OFF, "POWEROFF") != 0 ||
 	    gpio_direction_output(MV2120_GPIO_POWER_OFF, 1) != 0)
 		pr_err("mv2120: failed to setup power-off GPIO\n");
-	pm_power_off = mv2120_power_off;
+	register_platform_power_off(mv2120_power_off);
 }
 
 /* Warning: HP uses a wrong mach-type (=526) in their bootloader */
diff --git a/arch/arm/mach-orion5x/net2big-setup.c b/arch/arm/mach-orion5x/net2big-setup.c
index 6ad9740b426b6..4afd9b4c71a94 100644
--- a/arch/arm/mach-orion5x/net2big-setup.c
+++ b/arch/arm/mach-orion5x/net2big-setup.c
@@ -423,7 +423,7 @@ static void __init net2big_init(void)
 
 	if (gpio_request(NET2BIG_GPIO_POWER_OFF, "power-off") == 0 &&
 	    gpio_direction_output(NET2BIG_GPIO_POWER_OFF, 0) == 0)
-		pm_power_off = net2big_power_off;
+		register_platform_power_off(net2big_power_off);
 	else
 		pr_err("net2big: failed to configure power-off GPIO\n");
 
diff --git a/arch/arm/mach-orion5x/terastation_pro2-setup.c b/arch/arm/mach-orion5x/terastation_pro2-setup.c
index 23a5521c68336..a9f01859d1012 100644
--- a/arch/arm/mach-orion5x/terastation_pro2-setup.c
+++ b/arch/arm/mach-orion5x/terastation_pro2-setup.c
@@ -349,7 +349,7 @@ static void __init tsp2_init(void)
 	i2c_register_board_info(0, &tsp2_i2c_rtc, 1);
 
 	/* register Terastation Pro II specific power-off method */
-	pm_power_off = tsp2_power_off;
+	register_platform_power_off(tsp2_power_off);
 }
 
 MACHINE_START(TERASTATION_PRO2, "Buffalo Terastation Pro II/Live")
diff --git a/arch/arm/mach-orion5x/ts209-setup.c b/arch/arm/mach-orion5x/ts209-setup.c
index bab8ba0e01ab9..de9092e992c56 100644
--- a/arch/arm/mach-orion5x/ts209-setup.c
+++ b/arch/arm/mach-orion5x/ts209-setup.c
@@ -314,7 +314,7 @@ static void __init qnap_ts209_init(void)
 	i2c_register_board_info(0, &qnap_ts209_i2c_rtc, 1);
 
 	/* register tsx09 specific power-off method */
-	pm_power_off = qnap_tsx09_power_off;
+	register_platform_power_off(qnap_tsx09_power_off);
 }
 
 MACHINE_START(TS209, "QNAP TS-109/TS-209")
diff --git a/arch/arm/mach-orion5x/ts409-setup.c b/arch/arm/mach-orion5x/ts409-setup.c
index 8131982c10d97..725688aa5cba7 100644
--- a/arch/arm/mach-orion5x/ts409-setup.c
+++ b/arch/arm/mach-orion5x/ts409-setup.c
@@ -312,7 +312,7 @@ static void __init qnap_ts409_init(void)
 	platform_device_register(&ts409_leds);
 
 	/* register tsx09 specific power-off method */
-	pm_power_off = qnap_tsx09_power_off;
+	register_platform_power_off(qnap_tsx09_power_off);
 }
 
 MACHINE_START(TS409, "QNAP TS-409")
-- 
2.39.2


