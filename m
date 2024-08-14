Return-Path: <linux-kernel+bounces-286505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38BB8951BD5
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 15:30:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB5341F237BD
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 13:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 529511B1431;
	Wed, 14 Aug 2024 13:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="JdSFVG29"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E29143C41;
	Wed, 14 Aug 2024 13:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723642193; cv=none; b=X46xOVh4Z9UTGRMTDB2OPuDNxqWEMquzhn1z0W1tb6+B/de14UtIAtkD4pVB1XQoqLra2ZZE9Nzxme3JZ4GzCG6JsA5oSvN6DVrFwzY7iX4YPn57/BeCcLBX9jfYTBOezvHLew9vTcmrM2Va7qeDf1N1+G9WLhhj86Ptrpb//Jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723642193; c=relaxed/simple;
	bh=WDmSsz2aZOWSTppZxRLL6okooBJsolyTCZFR/EAZ/Pk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EZTlpcQ81Tn5XMSJHXkMPTG0EfIfbvgO8+QnAicfExUDZ43bklmV2U34TRA1o++OQaRscofiQbAzE+gA/kVDxoqacHSzf/P1aizeNWdMeIwesGcjBZ8eGXLDDC48b+nRTuo9/fDjz4ruzQmgPcj/hxwPBkHos0cRb0Esdukx9zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=JdSFVG29; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47E4gOeY023234;
	Wed, 14 Aug 2024 08:29:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PODMain02222019; bh=KZdwnnHCQp5ppsW6
	QjV9ToXJ1lg70Yu6pZxfow8SGHI=; b=JdSFVG29vD81wp2nbsnRtUB3Vkob9iUp
	xnGwIEwdKUhMuLkVGj1j1Fon+jYT8pIYK8D1jPkEGzhCzbooCR2CXgNKdV32kRz6
	EUPGobwlo/n/0mxxr9OlX/6Cfeg7q4Ikoap9qjNBFitOh7BKJ7QaMJY09hSt7Nm8
	T79hHLKTzYJC7QfGqxhuz8BkvSqh4x3pqJotzduW+Tw6RW5dG0dUCDj7iQRsxI8V
	V79XOCN/hIzW7Z0wRAviPW7tyPhU72gTIzx6GeeAQMKp6Xtawni4SBOCkJRAhPxk
	rWq8gYH/stbeGEKaposVJQauJqAksJLl029dlbMqT5u7r98vw4gnNA==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 40x4mhmm84-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Aug 2024 08:29:41 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 14 Aug
 2024 14:29:39 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Wed, 14 Aug 2024 14:29:39 +0100
Received: from ediswws06.ad.cirrus.com (ediswws06.ad.cirrus.com [198.90.208.18])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 6AE2A820241;
	Wed, 14 Aug 2024 13:29:39 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: <hdegoede@redhat.com>, <ilpo.jarvinen@linux.intel.com>
CC: <platform-driver-x86@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: [PATCH v2] platform/x86: serial-multi-instantiate: Don't require both I2C and SPI
Date: Wed, 14 Aug 2024 14:29:39 +0100
Message-ID: <20240814132939.308696-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: GOHkx99hCzRy_cPIqnbt-YnTbvwfYU4y
X-Proofpoint-GUID: GOHkx99hCzRy_cPIqnbt-YnTbvwfYU4y
X-Proofpoint-Spam-Reason: safe

Change the Kconfig dependency so that it doesn't require both I2C and SPI
subsystems to be built. Make a few small changes to the code so that the
code for a bus is only called if the bus is being built.

When SPI support was added to serial-multi-instantiate it created a
dependency that both CONFIG_I2C and CONFIG_SPI must be enabled.
Typically they are, but there's no reason why this should be a
requirement. A specific kernel build could have only I2C devices
or only SPI devices. It should be possible to use serial-multi-instantiate
if only I2C or only SPI is enabled.

The dependency formula used is:

  depends on (I2C && !SPI) || (!I2C && SPI) || (I2C && SPI)

The advantage of this approach is that if I2C=m or SPI=m then
SERIAL_MULTI_INSTANTIATE is limited to n/m.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
Changes from V1:
Use a different 'depends on' formula so that serial-multi-instantiate
must be built as a module if any dependencies are a module.

 drivers/platform/x86/Kconfig                  |  3 +-
 .../platform/x86/serial-multi-instantiate.c   | 32 ++++++++++++++-----
 2 files changed, 26 insertions(+), 9 deletions(-)

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 665fa9524986..0dcf4d8eac56 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -999,7 +999,8 @@ config TOPSTAR_LAPTOP
 
 config SERIAL_MULTI_INSTANTIATE
 	tristate "Serial bus multi instantiate pseudo device driver"
-	depends on I2C && SPI && ACPI
+	depends on ACPI
+	depends on (I2C && !SPI) || (!I2C && SPI) || (I2C && SPI)
 	help
 	  Some ACPI-based systems list multiple devices in a single ACPI
 	  firmware-node. This driver will instantiate separate clients
diff --git a/drivers/platform/x86/serial-multi-instantiate.c b/drivers/platform/x86/serial-multi-instantiate.c
index 3be016cfe601..7c04cc9e5891 100644
--- a/drivers/platform/x86/serial-multi-instantiate.c
+++ b/drivers/platform/x86/serial-multi-instantiate.c
@@ -83,11 +83,15 @@ static int smi_get_irq(struct platform_device *pdev, struct acpi_device *adev,
 
 static void smi_devs_unregister(struct smi *smi)
 {
+#if IS_REACHABLE(CONFIG_I2C)
 	while (smi->i2c_num--)
 		i2c_unregister_device(smi->i2c_devs[smi->i2c_num]);
+#endif
 
-	while (smi->spi_num--)
-		spi_unregister_device(smi->spi_devs[smi->spi_num]);
+	if (IS_REACHABLE(CONFIG_SPI)) {
+		while (smi->spi_num--)
+			spi_unregister_device(smi->spi_devs[smi->spi_num]);
+	}
 }
 
 /**
@@ -258,9 +262,15 @@ static int smi_probe(struct platform_device *pdev)
 
 	switch (node->bus_type) {
 	case SMI_I2C:
-		return smi_i2c_probe(pdev, smi, node->instances);
+		if (IS_REACHABLE(CONFIG_I2C))
+			return smi_i2c_probe(pdev, smi, node->instances);
+
+		return -ENODEV;
 	case SMI_SPI:
-		return smi_spi_probe(pdev, smi, node->instances);
+		if (IS_REACHABLE(CONFIG_SPI))
+			return smi_spi_probe(pdev, smi, node->instances);
+
+		return -ENODEV;
 	case SMI_AUTO_DETECT:
 		/*
 		 * For backwards-compatibility with the existing nodes I2C
@@ -270,10 +280,16 @@ static int smi_probe(struct platform_device *pdev)
 		 * SpiSerialBus nodes that were previously ignored, and this
 		 * preserves that behavior.
 		 */
-		ret = smi_i2c_probe(pdev, smi, node->instances);
-		if (ret != -ENOENT)
-			return ret;
-		return smi_spi_probe(pdev, smi, node->instances);
+		if (IS_REACHABLE(CONFIG_I2C)) {
+			ret = smi_i2c_probe(pdev, smi, node->instances);
+			if (ret != -ENOENT)
+				return ret;
+		}
+
+		if (IS_REACHABLE(CONFIG_SPI))
+			return smi_spi_probe(pdev, smi, node->instances);
+
+		return -ENODEV;
 	default:
 		return -EINVAL;
 	}
-- 
2.39.2


