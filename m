Return-Path: <linux-kernel+bounces-265909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3461A93F79D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 16:23:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2610282BC5
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 14:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B47DC15F3EA;
	Mon, 29 Jul 2024 14:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="CnY8G57e"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390D8155CBF;
	Mon, 29 Jul 2024 14:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722262887; cv=none; b=gdv+Df4+PRtaSe7WinKOeqGaKeTv5JgxeiDDQulcw+hnFWPOzvXuW2iEpB+P38lBPTwKNiiveFsi+xrqb8KUPAFt9o69nApLP2RU0pQeBkpQWsBvM9GzmNbEtfaUYinOMVdOZJqBu7Rxis0W1HUbcKexCy04MFUMTtTV9jF+zWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722262887; c=relaxed/simple;
	bh=OJyToP+QF7QkYczPiPj9YbCemg26h7ZUCaF4FWTBHjE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rNdGmbDNEkgXbaLg5tf493bvNYlqZFDr4GpXtPvWeJSpMwLENMBlwhcTadk6DYq+HlE4Yix8JvhHYB/N/e9kODZyxBf0QWpRCwHVTF9rFoA4ODIpb/UFPF8MnJmSHhJDwxC//du6TDxt/YSnOe9gk5qolVncFpCbs4JkmfSNkL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=CnY8G57e; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id D372424000F;
	Mon, 29 Jul 2024 14:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1722262878;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FedGXBbxZS85QIbKrUIqDEcBbjDFn92tK2MtTO/ElYU=;
	b=CnY8G57e0PMrwfbcG0o8Elu/4FFDMoT43zSFYBbRZLLift4Mx9Z3vEP7DLtyuMgRWVR+aB
	HrKuNSH9Xks5C14fy3G6GjN0F2cIPlOTuh2nheJd0/Px/N/UViq1LXzEE2FOEpuR6b2bb/
	KRkTAKd/FsPIIna6oezk0ytLr4wKyISrHEnEE6cNwy+9mF775SZn6LEDPtANcYZczWZhHG
	AOD2Y/pRQLHSmUd+VLY54yif3nQQBgxwJPKyROGfCZinIAT/emh23ftt3m6Ugtu6D5Qard
	YIGSEGhmGuRO/YNh47wNgGd5UCEar8APBCNtn1CskvfAnhkB352AkEjvFhrKpw==
From: Herve Codina <herve.codina@bootlin.com>
To: Herve Codina <herve.codina@bootlin.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Qiang Zhao <qiang.zhao@nxp.com>,
	Li Yang <leoyang.li@nxp.com>,
	Mark Brown <broonie@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH v1 04/36] soc: fsl: cpm1: tsa: Use BIT(), GENMASK() and FIELD_PREP() macros
Date: Mon, 29 Jul 2024 16:20:33 +0200
Message-ID: <20240729142107.104574-5-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240729142107.104574-1-herve.codina@bootlin.com>
References: <20240729142107.104574-1-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

checkpatch.pl signals the following improvement for tsa.c
  CHECK: Prefer using the BIT macro

Follow its suggestion and convert the code to BIT() and related macros.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 drivers/soc/fsl/qe/tsa.c | 127 +++++++++++++++++++++------------------
 1 file changed, 68 insertions(+), 59 deletions(-)

diff --git a/drivers/soc/fsl/qe/tsa.c b/drivers/soc/fsl/qe/tsa.c
index 53968ea84c88..dc4dda17dab8 100644
--- a/drivers/soc/fsl/qe/tsa.c
+++ b/drivers/soc/fsl/qe/tsa.c
@@ -9,6 +9,7 @@
 
 #include "tsa.h"
 #include <dt-bindings/soc/cpm1-fsl,tsa.h>
+#include <linux/bitfield.h>
 #include <linux/clk.h>
 #include <linux/io.h>
 #include <linux/module.h>
@@ -19,47 +20,52 @@
 
 
 /* TSA SI RAM routing tables entry */
-#define TSA_SIRAM_ENTRY_LAST		(1 << 16)
-#define TSA_SIRAM_ENTRY_BYTE		(1 << 17)
-#define TSA_SIRAM_ENTRY_CNT(x)		(((x) & 0x0f) << 18)
-#define TSA_SIRAM_ENTRY_CSEL_MASK	(0x7 << 22)
-#define TSA_SIRAM_ENTRY_CSEL_NU		(0x0 << 22)
-#define TSA_SIRAM_ENTRY_CSEL_SCC2	(0x2 << 22)
-#define TSA_SIRAM_ENTRY_CSEL_SCC3	(0x3 << 22)
-#define TSA_SIRAM_ENTRY_CSEL_SCC4	(0x4 << 22)
-#define TSA_SIRAM_ENTRY_CSEL_SMC1	(0x5 << 22)
-#define TSA_SIRAM_ENTRY_CSEL_SMC2	(0x6 << 22)
+#define TSA_SIRAM_ENTRY_LAST		BIT(16)
+#define TSA_SIRAM_ENTRY_BYTE		BIT(17)
+#define TSA_SIRAM_ENTRY_CNT_MASK	GENMASK(21, 18)
+#define TSA_SIRAM_ENTRY_CNT(x)		FIELD_PREP(TSA_SIRAM_ENTRY_CNT_MASK, x)
+#define TSA_SIRAM_ENTRY_CSEL_MASK	GENMASK(24, 22)
+#define TSA_SIRAM_ENTRY_CSEL_NU		FIELD_PREP_CONST(TSA_SIRAM_ENTRY_CSEL_MASK, 0x0)
+#define TSA_SIRAM_ENTRY_CSEL_SCC2	FIELD_PREP_CONST(TSA_SIRAM_ENTRY_CSEL_MASK, 0x2)
+#define TSA_SIRAM_ENTRY_CSEL_SCC3	FIELD_PREP_CONST(TSA_SIRAM_ENTRY_CSEL_MASK, 0x3)
+#define TSA_SIRAM_ENTRY_CSEL_SCC4	FIELD_PREP_CONST(TSA_SIRAM_ENTRY_CSEL_MASK, 0x4)
+#define TSA_SIRAM_ENTRY_CSEL_SMC1	FIELD_PREP_CONST(TSA_SIRAM_ENTRY_CSEL_MASK, 0x5)
+#define TSA_SIRAM_ENTRY_CSEL_SMC2	FIELD_PREP_CONST(TSA_SIRAM_ENTRY_CSEL_MASK, 0x6)
 
 /* SI mode register (32 bits) */
 #define TSA_SIMODE	0x00
-#define   TSA_SIMODE_SMC2			0x80000000
-#define   TSA_SIMODE_SMC1			0x00008000
-#define   TSA_SIMODE_TDMA(x)			((x) << 0)
-#define   TSA_SIMODE_TDMB(x)			((x) << 16)
-#define     TSA_SIMODE_TDM_MASK			0x0fff
-#define     TSA_SIMODE_TDM_SDM_MASK		0x0c00
-#define       TSA_SIMODE_TDM_SDM_NORM		0x0000
-#define       TSA_SIMODE_TDM_SDM_ECHO		0x0400
-#define       TSA_SIMODE_TDM_SDM_INTL_LOOP	0x0800
-#define       TSA_SIMODE_TDM_SDM_LOOP_CTRL	0x0c00
-#define     TSA_SIMODE_TDM_RFSD(x)		((x) << 8)
-#define     TSA_SIMODE_TDM_DSC			0x0080
-#define     TSA_SIMODE_TDM_CRT			0x0040
-#define     TSA_SIMODE_TDM_STZ			0x0020
-#define     TSA_SIMODE_TDM_CE			0x0010
-#define     TSA_SIMODE_TDM_FE			0x0008
-#define     TSA_SIMODE_TDM_GM			0x0004
-#define     TSA_SIMODE_TDM_TFSD(x)		((x) << 0)
+#define   TSA_SIMODE_SMC2			BIT(31)
+#define   TSA_SIMODE_SMC1			BIT(15)
+#define   TSA_SIMODE_TDMA_MASK			GENMASK(11, 0)
+#define   TSA_SIMODE_TDMA(x)			FIELD_PREP(TSA_SIMODE_TDMA_MASK, x)
+#define   TSA_SIMODE_TDMB_MASK			GENMASK(27, 16)
+#define   TSA_SIMODE_TDMB(x)			FIELD_PREP(TSA_SIMODE_TDMB_MASK, x)
+#define     TSA_SIMODE_TDM_MASK			GENMASK(11, 0)
+#define     TSA_SIMODE_TDM_SDM_MASK		GENMASK(11, 10)
+#define       TSA_SIMODE_TDM_SDM_NORM		FIELD_PREP_CONST(TSA_SIMODE_TDM_SDM_MASK, 0x0)
+#define       TSA_SIMODE_TDM_SDM_ECHO		FIELD_PREP_CONST(TSA_SIMODE_TDM_SDM_MASK, 0x1)
+#define       TSA_SIMODE_TDM_SDM_INTL_LOOP	FIELD_PREP_CONST(TSA_SIMODE_TDM_SDM_MASK, 0x2)
+#define       TSA_SIMODE_TDM_SDM_LOOP_CTRL	FIELD_PREP_CONST(TSA_SIMODE_TDM_SDM_MASK, 0x3)
+#define     TSA_SIMODE_TDM_RFSD_MASK		GENMASK(9, 8)
+#define     TSA_SIMODE_TDM_RFSD(x)		FIELD_PREP(TSA_SIMODE_TDM_RFSD_MASK, x)
+#define     TSA_SIMODE_TDM_DSC			BIT(7)
+#define     TSA_SIMODE_TDM_CRT			BIT(6)
+#define     TSA_SIMODE_TDM_STZ			BIT(5)
+#define     TSA_SIMODE_TDM_CE			BIT(4)
+#define     TSA_SIMODE_TDM_FE			BIT(3)
+#define     TSA_SIMODE_TDM_GM			BIT(2)
+#define     TSA_SIMODE_TDM_TFSD_MASK		GENMASK(1, 0)
+#define     TSA_SIMODE_TDM_TFSD(x)		FIELD_PREP(TSA_SIMODE_TDM_TFSD_MASK, x)
 
 /* SI global mode register (8 bits) */
 #define TSA_SIGMR	0x04
-#define TSA_SIGMR_ENB			(1<<3)
-#define TSA_SIGMR_ENA			(1<<2)
-#define TSA_SIGMR_RDM_MASK		0x03
-#define   TSA_SIGMR_RDM_STATIC_TDMA	0x00
-#define   TSA_SIGMR_RDM_DYN_TDMA	0x01
-#define   TSA_SIGMR_RDM_STATIC_TDMAB	0x02
-#define   TSA_SIGMR_RDM_DYN_TDMAB	0x03
+#define TSA_SIGMR_ENB			BIT(3)
+#define TSA_SIGMR_ENA			BIT(2)
+#define TSA_SIGMR_RDM_MASK		GENMASK(1, 0)
+#define   TSA_SIGMR_RDM_STATIC_TDMA	FIELD_PREP_CONST(TSA_SIGMR_RDM_MASK, 0x0)
+#define   TSA_SIGMR_RDM_DYN_TDMA	FIELD_PREP_CONST(TSA_SIGMR_RDM_MASK, 0x1)
+#define   TSA_SIGMR_RDM_STATIC_TDMAB	FIELD_PREP_CONST(TSA_SIGMR_RDM_MASK, 0x2)
+#define   TSA_SIGMR_RDM_DYN_TDMAB	FIELD_PREP_CONST(TSA_SIGMR_RDM_MASK, 0x3)
 
 /* SI status register (8 bits) */
 #define TSA_SISTR	0x06
@@ -69,30 +75,33 @@
 
 /* SI clock route register (32 bits) */
 #define TSA_SICR	0x0C
-#define   TSA_SICR_SCC2(x)		((x) << 8)
-#define   TSA_SICR_SCC3(x)		((x) << 16)
-#define   TSA_SICR_SCC4(x)		((x) << 24)
-#define     TSA_SICR_SCC_MASK		0x0ff
-#define     TSA_SICR_SCC_GRX		(1 << 7)
-#define     TSA_SICR_SCC_SCX_TSA	(1 << 6)
-#define     TSA_SICR_SCC_RXCS_MASK	(0x7 << 3)
-#define       TSA_SICR_SCC_RXCS_BRG1	(0x0 << 3)
-#define       TSA_SICR_SCC_RXCS_BRG2	(0x1 << 3)
-#define       TSA_SICR_SCC_RXCS_BRG3	(0x2 << 3)
-#define       TSA_SICR_SCC_RXCS_BRG4	(0x3 << 3)
-#define       TSA_SICR_SCC_RXCS_CLK15	(0x4 << 3)
-#define       TSA_SICR_SCC_RXCS_CLK26	(0x5 << 3)
-#define       TSA_SICR_SCC_RXCS_CLK37	(0x6 << 3)
-#define       TSA_SICR_SCC_RXCS_CLK48	(0x7 << 3)
-#define     TSA_SICR_SCC_TXCS_MASK	(0x7 << 0)
-#define       TSA_SICR_SCC_TXCS_BRG1	(0x0 << 0)
-#define       TSA_SICR_SCC_TXCS_BRG2	(0x1 << 0)
-#define       TSA_SICR_SCC_TXCS_BRG3	(0x2 << 0)
-#define       TSA_SICR_SCC_TXCS_BRG4	(0x3 << 0)
-#define       TSA_SICR_SCC_TXCS_CLK15	(0x4 << 0)
-#define       TSA_SICR_SCC_TXCS_CLK26	(0x5 << 0)
-#define       TSA_SICR_SCC_TXCS_CLK37	(0x6 << 0)
-#define       TSA_SICR_SCC_TXCS_CLK48	(0x7 << 0)
+#define   TSA_SICR_SCC2_MASK		GENMASK(15, 8)
+#define   TSA_SICR_SCC2(x)		FIELD_PREP(TSA_SICR_SCC2_MASK, x)
+#define   TSA_SICR_SCC3_MASK		GENMASK(23, 16)
+#define   TSA_SICR_SCC3(x)		FIELD_PREP(TSA_SICR_SCC3_MASK, x)
+#define   TSA_SICR_SCC4_MASK		GENMASK(31, 24)
+#define   TSA_SICR_SCC4(x)		FIELD_PREP(TSA_SICR_SCC4_MASK, x)
+#define     TSA_SICR_SCC_MASK		GENMASK(7, 0)
+#define     TSA_SICR_SCC_GRX		BIT(7)
+#define     TSA_SICR_SCC_SCX_TSA	BIT(6)
+#define     TSA_SICR_SCC_RXCS_MASK	GENMASK(5, 3)
+#define       TSA_SICR_SCC_RXCS_BRG1	FIELD_PREP_CONST(TSA_SICR_SCC_RXCS_MASK, 0x0)
+#define       TSA_SICR_SCC_RXCS_BRG2	FIELD_PREP_CONST(TSA_SICR_SCC_RXCS_MASK, 0x1)
+#define       TSA_SICR_SCC_RXCS_BRG3	FIELD_PREP_CONST(TSA_SICR_SCC_RXCS_MASK, 0x2)
+#define       TSA_SICR_SCC_RXCS_BRG4	FIELD_PREP_CONST(TSA_SICR_SCC_RXCS_MASK, 0x3)
+#define       TSA_SICR_SCC_RXCS_CLK15	FIELD_PREP_CONST(TSA_SICR_SCC_RXCS_MASK, 0x4)
+#define       TSA_SICR_SCC_RXCS_CLK26	FIELD_PREP_CONST(TSA_SICR_SCC_RXCS_MASK, 0x5)
+#define       TSA_SICR_SCC_RXCS_CLK37	FIELD_PREP_CONST(TSA_SICR_SCC_RXCS_MASK, 0x6)
+#define       TSA_SICR_SCC_RXCS_CLK48	FIELD_PREP_CONST(TSA_SICR_SCC_RXCS_MASK, 0x7)
+#define     TSA_SICR_SCC_TXCS_MASK	GENMASK(2, 0)
+#define       TSA_SICR_SCC_TXCS_BRG1	FIELD_PREP_CONST(TSA_SICR_SCC_TXCS_MASK, 0x0)
+#define       TSA_SICR_SCC_TXCS_BRG2	FIELD_PREP_CONST(TSA_SICR_SCC_TXCS_MASK, 0x1)
+#define       TSA_SICR_SCC_TXCS_BRG3	FIELD_PREP_CONST(TSA_SICR_SCC_TXCS_MASK, 0x2)
+#define       TSA_SICR_SCC_TXCS_BRG4	FIELD_PREP_CONST(TSA_SICR_SCC_TXCS_MASK, 0x3)
+#define       TSA_SICR_SCC_TXCS_CLK15	FIELD_PREP_CONST(TSA_SICR_SCC_TXCS_MASK, 0x4)
+#define       TSA_SICR_SCC_TXCS_CLK26	FIELD_PREP_CONST(TSA_SICR_SCC_TXCS_MASK, 0x5)
+#define       TSA_SICR_SCC_TXCS_CLK37	FIELD_PREP_CONST(TSA_SICR_SCC_TXCS_MASK, 0x6)
+#define       TSA_SICR_SCC_TXCS_CLK48	FIELD_PREP_CONST(TSA_SICR_SCC_TXCS_MASK, 0x7)
 
 /* Serial interface RAM pointer register (32 bits) */
 #define TSA_SIRP	0x10
-- 
2.45.0


