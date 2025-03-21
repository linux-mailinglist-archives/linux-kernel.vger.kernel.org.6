Return-Path: <linux-kernel+bounces-570982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12E79A6B784
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 10:35:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DFD0189ACDD
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 09:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CFCA1F03D9;
	Fri, 21 Mar 2025 09:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="4U0PB6XM"
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E080D1F1906;
	Fri, 21 Mar 2025 09:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742549686; cv=none; b=qFYj0OLz10IfwiV5w6gAmBmI4mEMLhDIyPNLc5QRYuPYItxJs9xxOczIgZwZHqZ+0g8yz0AOWp+ob/6BYw89egp0Nw6VXKr2i0yjz5MVuGXbMYUGWaKbBwc5Ayp8TvDCsyXIF5TxThLy5rwzh2OocAP98u4oBRZDMJb9p+aVg8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742549686; c=relaxed/simple;
	bh=pNCuaRq20ihRDPIs6gWBbwsMGTzuOJxHjP1yYRN8ZiQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=I5QqWkia3Dd8DWURAwR+Ok/Y6sEYPfrfseJYUM0KVMFFtWWgHRe+loa7p2GM2fNk8CFqxTkBEGPE9Za0rYdfsdKCIdZV90AHQbIoBwUcXTNVJUBxo4Ttj7JwczxRfA1JZZmXxakn+/4LjIbKpdiCc5er+oGXyz8w9kUBl6cMdB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=4U0PB6XM; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52L58g15007292;
	Fri, 21 Mar 2025 10:34:34 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	WwkG1pZIiujSvSdNAeNRVIU4m+oKTZ5N+BMPOnssFpU=; b=4U0PB6XM2gh6OPAB
	VWn4O85SC8oaCqO50cshe0tpqfsQjZZnKS6qvjK/e8HsPiqQON2lC3VTOtAUTOkv
	2FH6d+C73xhTLrY1b19GXJFHIxeeiKV0MZvI3WNKpKzzz40oSymjII4G7ykg32H5
	29/m7IaBnSyQlZVZ3WjMAPK5P3s1Jo0PfNi532XwiQSSmIpLgE/+OGxcTLKeX9f4
	ZEOEUZzrlBx0x+XetBUS2hyhp1Tnui0da8Dmy09xLqstoBlJPXo/QxLhbBigxnxM
	WBwR760FX/2RH4cJ0ConLI64dGpP8RbbNL1EyFQotfHa2KJuTk17HgXeEz169Eyu
	T0BrUQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 45gh76vnq8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Mar 2025 10:34:34 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 1FEF540061;
	Fri, 21 Mar 2025 10:33:21 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 0C4A37BD057;
	Fri, 21 Mar 2025 10:32:32 +0100 (CET)
Received: from localhost (10.252.27.50) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 21 Mar
 2025 10:32:31 +0100
From: Patrice Chotard <patrice.chotard@foss.st.com>
Date: Fri, 21 Mar 2025 10:32:27 +0100
Subject: [PATCH v6 7/7] arm64: defconfig: Enable STM32 Octo Memory Manager
 and OcstoSPI driver
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250321-upstream_ospi_v6-v6-7-37bbcab43439@foss.st.com>
References: <20250321-upstream_ospi_v6-v6-0-37bbcab43439@foss.st.com>
In-Reply-To: <20250321-upstream_ospi_v6-v6-0-37bbcab43439@foss.st.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin
	<mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon
	<will@kernel.org>
CC: <christophe.kerello@foss.st.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        Patrice Chotard
	<patrice.chotard@foss.st.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: SAFCAS1NODE2.st.com (10.75.90.13) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-21_03,2025-03-20_01,2024-11-22_01

Enable STM32 OctoSPI driver.
Enable STM32 Octo Memory Manager (OMM) driver which is needed
for OSPI usage on STM32MP257F-EV1 board.

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---
 arch/arm64/configs/defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index bde1287ad9a7a1341162b817873eb651bb310d52..3674d9138bae6deba19c0d13586aa6e1de6750c5 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -580,6 +580,7 @@ CONFIG_SPI_QUP=y
 CONFIG_SPI_QCOM_GENI=m
 CONFIG_SPI_S3C64XX=y
 CONFIG_SPI_SH_MSIOF=m
+CONFIG_SPI_STM32_OSPI=m
 CONFIG_SPI_SUN6I=y
 CONFIG_SPI_TEGRA210_QUAD=m
 CONFIG_SPI_TEGRA114=m
@@ -1518,6 +1519,7 @@ CONFIG_EXTCON_USB_GPIO=y
 CONFIG_EXTCON_USBC_CROS_EC=y
 CONFIG_FSL_IFC=y
 CONFIG_RENESAS_RPCIF=m
+CONFIG_STM32_OMM=m
 CONFIG_IIO=y
 CONFIG_EXYNOS_ADC=y
 CONFIG_IMX8QXP_ADC=m

-- 
2.25.1


