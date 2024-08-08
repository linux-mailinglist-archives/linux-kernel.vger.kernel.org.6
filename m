Return-Path: <linux-kernel+bounces-278973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3850794B746
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 09:13:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BFD31C22D03
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 07:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C72D18A6AA;
	Thu,  8 Aug 2024 07:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="flcINJit"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22067188CD5;
	Thu,  8 Aug 2024 07:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723101112; cv=none; b=HXQ9xgfRjwNQtJwAWjdAUBKofT7LEp1RAqLMvSsK/DYl6X3HoNhiHFyctAGFSVgO5WecalARsZabsV+NdFfT1q9xSwTYZcEAu+RZU4uqzWcjhYvJgKTK9vFoW3hl1SU0P8S16R15LHMD5Pv1iol0WyWZffeKi6TLmWulSjcu3B0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723101112; c=relaxed/simple;
	bh=UdmTmJDtmijEO1fc+tdwkqDQEHTXO8qK4x3LO2Zj4tg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PF2mdi4qgowg9hs5rKxusWGeuIhlCOxAVRscQNcXiPoSE7gtKHgJ5T6uJtmVXI+HC8KmJsPkZkdo5AdJJEez8R4CAGv8Kr2eHqpL4OSFUtpQx9p+KNRPX+PYbPsXxRcjiRK3hqvpRPIs7t/WmLhlI6ABhfE3PUV629XSEYY6NBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=flcINJit; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 64917C0004;
	Thu,  8 Aug 2024 07:11:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1723101107;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y0c0Y9aM9tPVnaugg+JBgsxyaPRjLvE5XFJiybzMlz4=;
	b=flcINJit/MBMiS1jEIfOUFlLOS4QEYBXBUdbSYLwtVx+z1IvRDsXjQqzi3Rc7ABIX+PC8b
	7VwoqGsOl4JrZ1gClTK1U9wR2SqQjtXjDf+gWDFvUi2xwlwpWfutqPoM5PEVq9DjSdwPH6
	cnNW7cMW401pTFnom2WSHEobI2RqRC1bah2TOkRZbvcFn9Ipc4nrHuFt3VZR85vGYZHaHN
	NTCQLK8BfSkSTBpNQq43FEcqjPkfzHcVzEk+Ny2yPXRcDwTGWTWPMycXtgWpm+K5fAX3Su
	TuGsUIxZqFzncAFV1Iuw7sPNOD8FaP4ILx+DN8DIOxBs0OiO5aehdst+loSh9g==
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
Subject: [PATCH v2 11/36] soc: fsl: cpm1: tsa: Introduce tsa_setup() and its CPM1 compatible version
Date: Thu,  8 Aug 2024 09:11:04 +0200
Message-ID: <20240808071132.149251-12-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240808071132.149251-1-herve.codina@bootlin.com>
References: <20240808071132.149251-1-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

Current code handles the CPM1 version of TSA. Setting up TSA consists in
handling SIMODE and SIGMR registers. These registers are CPM1 specific.

Setting up the QUICC Engine (QE) version of TSA is slightly different.

In order to prepare the support for QE version, clearly identify these
registers as CPM1 compatible and isolate their handling in a CPM1
specific function.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 drivers/soc/fsl/qe/tsa.c | 93 +++++++++++++++++++++++-----------------
 1 file changed, 54 insertions(+), 39 deletions(-)

diff --git a/drivers/soc/fsl/qe/tsa.c b/drivers/soc/fsl/qe/tsa.c
index bf7354ebaca4..239b71187e07 100644
--- a/drivers/soc/fsl/qe/tsa.c
+++ b/drivers/soc/fsl/qe/tsa.c
@@ -32,14 +32,14 @@
 #define TSA_CPM1_SIRAM_ENTRY_CSEL_SMC2	FIELD_PREP_CONST(TSA_CPM1_SIRAM_ENTRY_CSEL_MASK, 0x6)
 
 /* SI mode register (32 bits) */
-#define TSA_SIMODE	0x00
-#define   TSA_SIMODE_SMC2			BIT(31)
-#define   TSA_SIMODE_SMC1			BIT(15)
-#define   TSA_SIMODE_TDMA_MASK			GENMASK(11, 0)
-#define   TSA_SIMODE_TDMA(x)			FIELD_PREP(TSA_SIMODE_TDMA_MASK, x)
-#define   TSA_SIMODE_TDMB_MASK			GENMASK(27, 16)
-#define   TSA_SIMODE_TDMB(x)			FIELD_PREP(TSA_SIMODE_TDMB_MASK, x)
-#define     TSA_SIMODE_TDM_MASK			GENMASK(11, 0)
+#define TSA_CPM1_SIMODE		0x00
+#define   TSA_CPM1_SIMODE_SMC2			BIT(31)
+#define   TSA_CPM1_SIMODE_SMC1			BIT(15)
+#define   TSA_CPM1_SIMODE_TDMA_MASK		GENMASK(11, 0)
+#define   TSA_CPM1_SIMODE_TDMA(x)		FIELD_PREP(TSA_CPM1_SIMODE_TDMA_MASK, x)
+#define   TSA_CPM1_SIMODE_TDMB_MASK		GENMASK(27, 16)
+#define   TSA_CPM1_SIMODE_TDMB(x)		FIELD_PREP(TSA_CPM1_SIMODE_TDMB_MASK, x)
+#define     TSA_CPM1_SIMODE_TDM_MASK		GENMASK(11, 0)
 #define     TSA_SIMODE_TDM_SDM_MASK		GENMASK(11, 10)
 #define       TSA_SIMODE_TDM_SDM_NORM		FIELD_PREP_CONST(TSA_SIMODE_TDM_SDM_MASK, 0x0)
 #define       TSA_SIMODE_TDM_SDM_ECHO		FIELD_PREP_CONST(TSA_SIMODE_TDM_SDM_MASK, 0x1)
@@ -49,22 +49,22 @@
 #define     TSA_SIMODE_TDM_RFSD(x)		FIELD_PREP(TSA_SIMODE_TDM_RFSD_MASK, x)
 #define     TSA_SIMODE_TDM_DSC			BIT(7)
 #define     TSA_SIMODE_TDM_CRT			BIT(6)
-#define     TSA_SIMODE_TDM_STZ			BIT(5)
+#define     TSA_CPM1_SIMODE_TDM_STZ		BIT(5)
 #define     TSA_SIMODE_TDM_CE			BIT(4)
 #define     TSA_SIMODE_TDM_FE			BIT(3)
 #define     TSA_SIMODE_TDM_GM			BIT(2)
 #define     TSA_SIMODE_TDM_TFSD_MASK		GENMASK(1, 0)
 #define     TSA_SIMODE_TDM_TFSD(x)		FIELD_PREP(TSA_SIMODE_TDM_TFSD_MASK, x)
 
-/* SI global mode register (8 bits) */
-#define TSA_SIGMR	0x04
-#define TSA_SIGMR_ENB			BIT(3)
-#define TSA_SIGMR_ENA			BIT(2)
-#define TSA_SIGMR_RDM_MASK		GENMASK(1, 0)
-#define   TSA_SIGMR_RDM_STATIC_TDMA	FIELD_PREP_CONST(TSA_SIGMR_RDM_MASK, 0x0)
-#define   TSA_SIGMR_RDM_DYN_TDMA	FIELD_PREP_CONST(TSA_SIGMR_RDM_MASK, 0x1)
-#define   TSA_SIGMR_RDM_STATIC_TDMAB	FIELD_PREP_CONST(TSA_SIGMR_RDM_MASK, 0x2)
-#define   TSA_SIGMR_RDM_DYN_TDMAB	FIELD_PREP_CONST(TSA_SIGMR_RDM_MASK, 0x3)
+/* CPM SI global mode register (8 bits) */
+#define TSA_CPM1_SIGMR	0x04
+#define TSA_CPM1_SIGMR_ENB			BIT(3)
+#define TSA_CPM1_SIGMR_ENA			BIT(2)
+#define TSA_CPM1_SIGMR_RDM_MASK			GENMASK(1, 0)
+#define   TSA_CPM1_SIGMR_RDM_STATIC_TDMA	FIELD_PREP_CONST(TSA_CPM1_SIGMR_RDM_MASK, 0x0)
+#define   TSA_CPM1_SIGMR_RDM_DYN_TDMA		FIELD_PREP_CONST(TSA_CPM1_SIGMR_RDM_MASK, 0x1)
+#define   TSA_CPM1_SIGMR_RDM_STATIC_TDMAB	FIELD_PREP_CONST(TSA_CPM1_SIGMR_RDM_MASK, 0x2)
+#define   TSA_CPM1_SIGMR_RDM_DYN_TDMAB		FIELD_PREP_CONST(TSA_CPM1_SIGMR_RDM_MASK, 0x3)
 
 /* SI clock route register (32 bits) */
 #define TSA_SICR	0x0C
@@ -656,13 +656,45 @@ static void tsa_init_si_ram(struct tsa *tsa)
 		tsa_write32(tsa->si_ram + i, TSA_CPM1_SIRAM_ENTRY_LAST);
 }
 
+static int tsa_cpm1_setup(struct tsa *tsa)
+{
+	u32 val;
+
+	/* Set SIMODE */
+	val = 0;
+	if (tsa->tdm[0].is_enable)
+		val |= TSA_CPM1_SIMODE_TDMA(tsa->tdm[0].simode_tdm);
+	if (tsa->tdm[1].is_enable)
+		val |= TSA_CPM1_SIMODE_TDMB(tsa->tdm[1].simode_tdm);
+
+	tsa_clrsetbits32(tsa->si_regs + TSA_CPM1_SIMODE,
+			 TSA_CPM1_SIMODE_TDMA(TSA_CPM1_SIMODE_TDM_MASK) |
+			 TSA_CPM1_SIMODE_TDMB(TSA_CPM1_SIMODE_TDM_MASK),
+			 val);
+
+	/* Set SIGMR */
+	val = (tsa->tdms == BIT(TSA_TDMA)) ?
+		TSA_CPM1_SIGMR_RDM_STATIC_TDMA : TSA_CPM1_SIGMR_RDM_STATIC_TDMAB;
+	if (tsa->tdms & BIT(TSA_TDMA))
+		val |= TSA_CPM1_SIGMR_ENA;
+	if (tsa->tdms & BIT(TSA_TDMB))
+		val |= TSA_CPM1_SIGMR_ENB;
+	tsa_write8(tsa->si_regs + TSA_CPM1_SIGMR, val);
+
+	return 0;
+}
+
+static int tsa_setup(struct tsa *tsa)
+{
+	return tsa_cpm1_setup(tsa);
+}
+
 static int tsa_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
 	struct resource *res;
 	struct tsa *tsa;
 	unsigned int i;
-	u32 val;
 	int ret;
 
 	tsa = devm_kzalloc(&pdev->dev, sizeof(*tsa), GFP_KERNEL);
@@ -696,26 +728,9 @@ static int tsa_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	/* Set SIMODE */
-	val = 0;
-	if (tsa->tdm[0].is_enable)
-		val |= TSA_SIMODE_TDMA(tsa->tdm[0].simode_tdm);
-	if (tsa->tdm[1].is_enable)
-		val |= TSA_SIMODE_TDMB(tsa->tdm[1].simode_tdm);
-
-	tsa_clrsetbits32(tsa->si_regs + TSA_SIMODE,
-			 TSA_SIMODE_TDMA(TSA_SIMODE_TDM_MASK) |
-			 TSA_SIMODE_TDMB(TSA_SIMODE_TDM_MASK),
-			 val);
-
-	/* Set SIGMR */
-	val = (tsa->tdms == BIT(TSA_TDMA)) ?
-		TSA_SIGMR_RDM_STATIC_TDMA : TSA_SIGMR_RDM_STATIC_TDMAB;
-	if (tsa->tdms & BIT(TSA_TDMA))
-		val |= TSA_SIGMR_ENA;
-	if (tsa->tdms & BIT(TSA_TDMB))
-		val |= TSA_SIGMR_ENB;
-	tsa_write8(tsa->si_regs + TSA_SIGMR, val);
+	ret = tsa_setup(tsa);
+	if (ret)
+		return ret;
 
 	platform_set_drvdata(pdev, tsa);
 
-- 
2.45.0


