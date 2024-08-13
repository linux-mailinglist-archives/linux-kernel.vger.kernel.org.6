Return-Path: <linux-kernel+bounces-284644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2910595037E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 13:21:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9144B25063
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 11:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6268D198A3B;
	Tue, 13 Aug 2024 11:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="Gl1wMffK"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F2E1990D6;
	Tue, 13 Aug 2024 11:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723548080; cv=none; b=Kj6atBtmJm/ZOb83B2KeHFVDtbGjEuInTAfPzoamuw2SPx24sJv2T7cM6t/8t5qSCaS7BvqrtKtlZwLtd415lzf+alq7DVScyP2RE7szjuKlLnWIpMDLoGnQ9PspyWIN/uVqEGt1UQgv5VYxJGx8/PBzGJELrhZnny495BKzA1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723548080; c=relaxed/simple;
	bh=WIDKRXnB5dD8bRyiwymV+WyrLDv4V9uYu5Jl2LOM7LE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=V/4Njnd0YWhNACnE9My+9orMV78GIWweI+3/m3qf1JvI1ie00Rsjid/GLepjBfgrKlLh/bAcYJ3BxCEbNrmrBLAF3fYRC5s91Rd4Q2wllsgvZByS7hOnAk4tNoCzJVUHqtiyBk5T5OKjnowrLfgUp9ghR6ujxuTliqucD4Ms5to=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=Gl1wMffK; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47D5nOat007280;
	Tue, 13 Aug 2024 06:21:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PODMain02222019; bh=SW5DGwoKCYblww+u
	zOxxC65pi6IoUBD349suAcii0og=; b=Gl1wMffK3CjIbo6Va08ivmrBdLTAQ4AJ
	ByevUmJ+J9iKeVmBClytcj5yZBnNPHrSE0JYU8ILtFJa2gCXu0eqEZvu+2TP/hpl
	iJOP4sbTpSPqhwmFppfYyONErBUUs3H+JZ63gWYdys8rq5d+caerJ2U9qkfs6Ga9
	VMZ5K8iA+V6tXN4IgymygK1zXNB0MknuiP7MkK0xL/a6ffbbm/OXNWNGWwvVixXO
	UaR0II8sD6jsnxqNE0cBJaZG92jSYRCYqYYeeokBgJtEq2MM/7s/xZyYR39Ft0vV
	eCUPFf3D4Hp4j+ZlZyaJ6IqX5uHdn7sBvZbPvUzH7LH7nmAwveZbEA==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 40x4mhk35g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Aug 2024 06:21:09 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 13 Aug
 2024 12:21:07 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Tue, 13 Aug 2024 12:21:07 +0100
Received: from EDIN4L06LR3.ad.cirrus.com (EDIN4L06LR3.ad.cirrus.com [198.61.68.170])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 412AB820241;
	Tue, 13 Aug 2024 11:21:07 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: <hdegoede@redhat.com>
CC: <platform-driver-x86@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Richard Fitzgerald
	<rf@opensource.cirrus.com>
Subject: [PATCH] platform/x86: serial-multi-instantiate: Don't require both I2C and SPI
Date: Tue, 13 Aug 2024 12:21:05 +0100
Message-ID: <20240813112105.21218-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: i6UyuKpEQEGnDXQdLiFvdN-QVBtwysAT
X-Proofpoint-GUID: i6UyuKpEQEGnDXQdLiFvdN-QVBtwysAT
X-Proofpoint-Spam-Reason: safe

Change the Kconfig dependency to (I2C || SPI) so that it doesn't
require both bus subsystems to be enabled. Make a few small changes to
the code so that the code for a bus is only called if the bus is being
built.

When SPI support was added to serial-multi-instantiate it created a
dependency that both CONFIG_I2C and CONFIG_SPI must be enabled.
Typically they are, but there's no reason why this should be a
requirement. A specific kernel build could have only I2C devices or
only SPI devices. It should be possible to use serial-multi-instantiate
if only I2C or only SPI is enabled.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 drivers/platform/x86/Kconfig                  |  2 +-
 .../platform/x86/serial-multi-instantiate.c   | 32 ++++++++++++++-----
 2 files changed, 25 insertions(+), 9 deletions(-)

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 665fa9524986..c286742b34ba 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -999,7 +999,7 @@ config TOPSTAR_LAPTOP
 
 config SERIAL_MULTI_INSTANTIATE
 	tristate "Serial bus multi instantiate pseudo device driver"
-	depends on I2C && SPI && ACPI
+	depends on (I2C || SPI) && ACPI
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


