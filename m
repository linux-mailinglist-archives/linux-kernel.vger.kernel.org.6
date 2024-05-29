Return-Path: <linux-kernel+bounces-194140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F6118D374F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 15:14:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACC961F26BAE
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 13:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA31A171A4;
	Wed, 29 May 2024 13:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="tLQoOJKs"
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370A312E6D;
	Wed, 29 May 2024 13:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716988473; cv=none; b=iHLRwJD44J6yHxdddYp894CdM++Y/Py7v/e9fJsjU5IFfp9bkbkVvw6DiPUvuIAKjTQJIinudvoTy4sNsrl/sph+tiw0qlJXXeLFJRnLVOVpUX8VBPWdgpk9O7N+wcyBLAS0SMgShz1yMi1ay/yC/vB/920PkEbVzNLzqUIBzNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716988473; c=relaxed/simple;
	bh=D6uvCJwTtk5Cbd18j/JhzPCic+D2E8pDqvPZDrXgE7s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kDTZJBBKez62ER4ydpvLvrl5O+yhUlThZA5OoYvBWJ9EwCu2wYjL+/dVJsFlTokG+qmP+MCyXX+z9mRZ2pBMBUQWM/v7H9PVzZv4dhDA+TtoShNB4nZJognxEUPriD+dTgZO8pjcPO+LS6YQdfSCLo3Y6uE8CkHjIFlRzW2YQCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=tLQoOJKs; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44TC5DY8025649;
	Wed, 29 May 2024 15:14:07 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	l0oXcm12v+rFJ11i7f5mmmBdsn+8CEkH3Wl0SsAmO0c=; b=tLQoOJKs8tyhCkjV
	IGYLqsoyVs57Y+HT1APThZJ27Y9o3HiuEV09YCZXrDHADVUrSWULZ0WRn23mb6MI
	TlEXIc9pOXs1leP427/cKBHfKPbmMdxRVvxEJL+2ylqlwD0xezH/pAV/NptiiswC
	ytajf+9nsdqiZ2Bssk99MZIcavD9NcmPw8xYja7atjKXGdsVWR/Sh0fY6imwyVHM
	eiHEBu561NlGT0OrFIl+zHHDv7DC8t5R7gZ2s3imjWuIhfcyXig6OLy84xrm4F1T
	PX98SRRbLs8xdMilkar5qxHm/XpDNcLdcCu5Ii8fMoq60l4vwHjSrsktHMqfg6KG
	gRwu1w==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3yb9yk10c4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 May 2024 15:14:07 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 098AF40045;
	Wed, 29 May 2024 15:14:03 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 365A921B528;
	Wed, 29 May 2024 15:13:14 +0200 (CEST)
Received: from localhost (10.48.87.209) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 29 May
 2024 15:13:13 +0200
From: <gabriel.fernandez@foss.st.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin
	<mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Maxime Ripard <mripard@kernel.org>,
        Gabriel Fernandez
	<gabriel.fernandez@foss.st.com>,
        Dan Carpenter <dan.carpenter@linaro.or6g>
CC: <devicetree@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-clk@vger.kernel.org>
Subject: [RESEND PATCH v2 2/3] clk: stm32mp25: add security clocks
Date: Wed, 29 May 2024 15:13:09 +0200
Message-ID: <20240529131310.260954-3-gabriel.fernandez@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240529131310.260954-1-gabriel.fernandez@foss.st.com>
References: <20240529131310.260954-1-gabriel.fernandez@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-29_10,2024-05-28_01,2024-05-17_01

From: Gabriel Fernandez <gabriel.fernandez@foss.st.com>

Add ck_icn_p_iwdg1, ck_icn_p_pka, ck_icn_p_rng, ck_icn_p_saes,
ck_icn_p_serc clocks.
They could be configured for non secured world.

Signed-off-by: Gabriel Fernandez <gabriel.fernandez@foss.st.com>
---
 drivers/clk/stm32/clk-stm32mp25.c | 34 +++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/clk/stm32/clk-stm32mp25.c b/drivers/clk/stm32/clk-stm32mp25.c
index 65a2d6bac271..52f0e8a12926 100644
--- a/drivers/clk/stm32/clk-stm32mp25.c
+++ b/drivers/clk/stm32/clk-stm32mp25.c
@@ -888,6 +888,11 @@ static struct clk_stm32_gate ck_icn_p_is2m = {
 };
 
 /* IWDG */
+static struct clk_stm32_gate ck_icn_p_iwdg1 = {
+	.gate_id = GATE_IWDG1,
+	.hw.init = CLK_HW_INIT_INDEX("ck_icn_p_iwdg1", ICN_APB3, &clk_stm32_gate_ops, 0),
+};
+
 static struct clk_stm32_gate ck_icn_p_iwdg2 = {
 	.gate_id = GATE_IWDG2,
 	.hw.init = CLK_HW_INIT_INDEX("ck_icn_p_iwdg2", ICN_APB3, &clk_stm32_gate_ops, 0),
@@ -1008,6 +1013,24 @@ static struct clk_stm32_gate ck_icn_p_pcie = {
 	.hw.init = CLK_HW_INIT_INDEX("ck_icn_p_pcie", ICN_LS_MCU, &clk_stm32_gate_ops, 0),
 };
 
+/* PKA */
+static struct clk_stm32_gate ck_icn_p_pka = {
+	.gate_id = GATE_PKA,
+	.hw.init = CLK_HW_INIT_INDEX("ck_icn_p_pka", ICN_LS_MCU, &clk_stm32_gate_ops, 0),
+};
+
+/* RNG */
+static struct clk_stm32_gate ck_icn_p_rng = {
+	.gate_id = GATE_RNG,
+	.hw.init = CLK_HW_INIT_INDEX("ck_icn_p_rng", ICN_LS_MCU, &clk_stm32_gate_ops, 0),
+};
+
+/* SAES */
+static struct clk_stm32_gate ck_icn_p_saes = {
+	.gate_id = GATE_SAES,
+	.hw.init = CLK_HW_INIT_INDEX("ck_icn_p_saes", ICN_LS_MCU, &clk_stm32_gate_ops, 0),
+};
+
 /* SAI */
 static struct clk_stm32_gate ck_icn_p_sai1 = {
 	.gate_id = GATE_SAI1,
@@ -1084,6 +1107,12 @@ static struct clk_stm32_gate ck_ker_sdmmc3 = {
 	.hw.init = CLK_HW_INIT_INDEX("ck_ker_sdmmc3", FLEXGEN_53, &clk_stm32_gate_ops, 0),
 };
 
+/* SERC */
+static struct clk_stm32_gate ck_icn_p_serc = {
+	.gate_id = GATE_SERC,
+	.hw.init = CLK_HW_INIT_INDEX("ck_icn_p_serc", ICN_APB3, &clk_stm32_gate_ops, 0),
+};
+
 /* SPDIF */
 static struct clk_stm32_gate ck_icn_p_spdifrx = {
 	.gate_id = GATE_SPDIFRX,
@@ -1607,8 +1636,11 @@ static const struct clock_config stm32mp25_clock_cfg[] = {
 	STM32_GATE_CFG(CK_BUS_MDF1,		ck_icn_p_mdf1,		SEC_RIFSC(54)),
 	STM32_GATE_CFG(CK_BUS_OSPIIOM,		ck_icn_p_ospiiom,	SEC_RIFSC(111)),
 	STM32_GATE_CFG(CK_BUS_HASH,		ck_icn_p_hash,		SEC_RIFSC(95)),
+	STM32_GATE_CFG(CK_BUS_RNG,		ck_icn_p_rng,		SEC_RIFSC(92)),
 	STM32_GATE_CFG(CK_BUS_CRYP1,		ck_icn_p_cryp1,		SEC_RIFSC(96)),
 	STM32_GATE_CFG(CK_BUS_CRYP2,		ck_icn_p_cryp2,		SEC_RIFSC(97)),
+	STM32_GATE_CFG(CK_BUS_SAES,		ck_icn_p_saes,		SEC_RIFSC(94)),
+	STM32_GATE_CFG(CK_BUS_PKA,		ck_icn_p_pka,		SEC_RIFSC(93)),
 	STM32_GATE_CFG(CK_BUS_ADF1,		ck_icn_p_adf1,		SEC_RIFSC(55)),
 	STM32_GATE_CFG(CK_BUS_SPI8,		ck_icn_p_spi8,		SEC_RIFSC(29)),
 	STM32_GATE_CFG(CK_BUS_LPUART1,		ck_icn_p_lpuart1,	SEC_RIFSC(40)),
@@ -1676,11 +1708,13 @@ static const struct clock_config stm32mp25_clock_cfg[] = {
 	STM32_GATE_CFG(CK_BUS_SPI5,		ck_icn_p_spi5,		SEC_RIFSC(26)),
 	STM32_GATE_CFG(CK_BUS_SPI6,		ck_icn_p_spi6,		SEC_RIFSC(27)),
 	STM32_GATE_CFG(CK_BUS_SPI7,		ck_icn_p_spi7,		SEC_RIFSC(28)),
+	STM32_GATE_CFG(CK_BUS_IWDG1,		ck_icn_p_iwdg1,		SEC_RIFSC(98)),
 	STM32_GATE_CFG(CK_BUS_IWDG2,		ck_icn_p_iwdg2,		SEC_RIFSC(99)),
 	STM32_GATE_CFG(CK_BUS_IWDG3,		ck_icn_p_iwdg3,		SEC_RIFSC(100)),
 	STM32_GATE_CFG(CK_BUS_IWDG4,		ck_icn_p_iwdg4,		SEC_RIFSC(101)),
 	STM32_GATE_CFG(CK_BUS_WWDG1,		ck_icn_p_wwdg1,		SEC_RIFSC(103)),
 	STM32_GATE_CFG(CK_BUS_VREF,		ck_icn_p_vref,		SEC_RIFSC(106)),
+	STM32_GATE_CFG(CK_BUS_SERC,		ck_icn_p_serc,		SEC_RIFSC(110)),
 	STM32_GATE_CFG(CK_BUS_HDP,		ck_icn_p_hdp,		SEC_RIFSC(57)),
 	STM32_GATE_CFG(CK_BUS_IS2M,		ck_icn_p_is2m,		MP25_RIF_RCC_IS2M),
 	STM32_GATE_CFG(CK_BUS_DSI,		ck_icn_p_dsi,		SEC_RIFSC(81)),
-- 
2.25.1


