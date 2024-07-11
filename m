Return-Path: <linux-kernel+bounces-248813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B28692E255
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 10:31:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40ABC1F212CC
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 08:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E551A158A29;
	Thu, 11 Jul 2024 08:30:16 +0000 (UTC)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB7D13D509;
	Thu, 11 Jul 2024 08:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720686616; cv=none; b=cpLXbDq1v6D8YCNN7qztBUR4Smd0WJyrudukVSeeU0MJ9uIyx4vvGe7RO9y29sIMv9QfVwwOObT1zVgUPQ6MFcG0GG0pzwem12ff8jvkdLtoultB1TNMZO6wnHJ7TsRW/yrIiL49XxYljFEdmrICxzxaa2LUa1IlbD9jA6cSgPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720686616; c=relaxed/simple;
	bh=ri5rhI/ohmf1w1XgqnQBe4P2Cp3TA9WQJCo5knIxro0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=kq/hZ1Fu+k3jN/0+VO+jRv4Suo09BPfu/T9e2YYSeae/12kpyKRQDvPNoUgbq0Pu6DmO4sFXMhDYCAel986Xu3wfAAFcYZUhoAUzj9fPuhp3uIzlsPXOqnI97uUQkjugZi5vmRCwN771YKWvKFU+6dBp869/9j6zrp5Pd10zNoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva020.nxp.com (localhost [127.0.0.1])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 6ACFF1A1BED;
	Thu, 11 Jul 2024 10:30:13 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 320371A1BEE;
	Thu, 11 Jul 2024 10:30:13 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 35E2C183AC99;
	Thu, 11 Jul 2024 16:30:11 +0800 (+08)
From: Richard Zhu <hongxing.zhu@nxp.com>
To: tj@kernel.org,
	dlemoal@kernel.org,
	cassel@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	festevam@gmail.com
Cc: linux-ide@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	kernel@pengutronix.de,
	Richard Zhu <hongxing.zhu@nxp.com>
Subject: [PATCH v1 3/4] ata: ahci_imx: Enlarge RX water mark for i.MX8QM SATA
Date: Thu, 11 Jul 2024 16:11:57 +0800
Message-Id: <1720685518-20190-4-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1720685518-20190-1-git-send-email-hongxing.zhu@nxp.com>
References: <1720685518-20190-1-git-send-email-hongxing.zhu@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The RXWM(RxWaterMark) sets the minimum number of free location within
the RX FIFO before the watermark is exceeded which in turn will cause
the Transport Layer to instruct the Link Layer to transmit HOLDS to
the transmitting end.

Based on the default RXWM vaulue 0x20, RX FIFO overflow might be
observed on i.MX8QM MEK board, when some Gen3 SATA disks are used.

The FIFO overflow will result in CRC error, internal error and protocol
error, then the SATA link is not stable anymore.

To fix this issue, enlarge RX water mark setting from 0x20 to 0x29.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 drivers/ata/ahci_imx.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/ata/ahci_imx.c b/drivers/ata/ahci_imx.c
index 0e9fddd02ee5f..9147cd14f587e 100644
--- a/drivers/ata/ahci_imx.c
+++ b/drivers/ata/ahci_imx.c
@@ -45,6 +45,10 @@ enum {
 	/* Clock Reset Register */
 	IMX_CLOCK_RESET				= 0x7f3f,
 	IMX_CLOCK_RESET_RESET			= 1 << 0,
+	/* IMX8QM SATA specific control registers */
+	IMX8QM_SATA_AHCI_VEND_PTC			= 0xc8,
+	IMX8QM_SATA_AHCI_VEND_PTC_RXWM_MASK		= 0x7f,
+	IMX8QM_SATA_AHCI_VEND_PTC_RXWM			= 0x29,
 };
 
 enum ahci_imx_type {
@@ -466,6 +470,12 @@ static int imx8_sata_enable(struct ahci_host_priv *hpriv)
 	phy_power_off(imxpriv->cali_phy0);
 	phy_exit(imxpriv->cali_phy0);
 
+	/* RxWaterMark setting */
+	val = readl(hpriv->mmio + IMX8QM_SATA_AHCI_VEND_PTC);
+	val &= ~IMX8QM_SATA_AHCI_VEND_PTC_RXWM_MASK;
+	val |= IMX8QM_SATA_AHCI_VEND_PTC_RXWM;
+	writel(val, hpriv->mmio + IMX8QM_SATA_AHCI_VEND_PTC);
+
 	return 0;
 
 err_sata_phy_power_on:
-- 
2.37.1


