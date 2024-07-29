Return-Path: <linux-kernel+bounces-265910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE42A93F79C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 16:23:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DBE11F22F42
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 14:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADAE815F32D;
	Mon, 29 Jul 2024 14:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="o5lKmqVd"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9812C15625A;
	Mon, 29 Jul 2024 14:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722262888; cv=none; b=KNEj97PaRAuLh/Nroi7Sg/X3DpVtwJ5fOnHSV9GLMLFtnaLzZ4Nr+cMM2krLbSX7YpPjd80dwMX2daFv6fTLxCywF9/f64p9oMdN8OQqfhnHGVdQ611X3bOpcqFk2rRqhDVuWkcuHIfjBAeWrB1TVAr2IgHLIlcg42JpEj4jHlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722262888; c=relaxed/simple;
	bh=0vmFJIBk5XfMjPrXtpv+7Y1SABvbs6sbNptSdJcW5wU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KHz/mwSOHbD6KcnzGpMpaL9obbATJn+3WjhVIkWcrrQFTd3S1aKYRINKeoheU+ZQw6VbPh73rMqzUYJEgscnCuVyBFZDwr5JJtcS/DYtUu+5+yrQMgakcn2nGRe17P1Snnp6gfhBpy1CKfRtlwcaaE3UxvwpFp/kQ/QFNnNwyEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=o5lKmqVd; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 5C639240014;
	Mon, 29 Jul 2024 14:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1722262883;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uvdVdoMDvhGGx9jdQpRy50lSt7vOk/dQvY6e1fABxmk=;
	b=o5lKmqVdeRM+7if1sO1CjOQxzdwGvRmmdPEEjYAR4O2QicIjDraRWa5Ek0odiT7BgohF8u
	1a9td+DZx28wOteZ1VK+uuf7aMNpb8CuMFAJ7oRCk7f89rituOaA31HmcYIGHfEht4z+at
	xhe+aIhzDgOMsNhU4mVfCmCN796d6ERNSjdO8LqhAXYgHkhj5FTseNG3/ePOFNOgvoA+Ce
	MQA5OT624rii66F9Xmk62awEaR8qmnfV4PbZ/hItuRzOpCdcg3MhV2yhwODqL7O7i2vH3O
	8PiuemPzNRFhOT57vm00pstU6Amny3FIp6m2EVcF5U2XqSj68prwTI4fLq9dmQ==
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
Subject: [PATCH v1 12/36] soc: fsl: cpm1: tsa: Isolate specific CPM1 part from tsa_serial_{dis}connect()
Date: Mon, 29 Jul 2024 16:20:41 +0200
Message-ID: <20240729142107.104574-13-herve.codina@bootlin.com>
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

Current code handles the CPM1 version of TSA. Connecting and
disconnecting the SCC to/from the TSA consists in handling SICR register
which is CPM1 specific. The connection and disconnection operation in
the QUICC Engine (QE) version are slightly different.

In order to prepare the support for the QE version, clearly identify
SICR register as specific to CPM1 and isolate its handling done in
connect and disconnect functions.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 drivers/soc/fsl/qe/tsa.c | 103 ++++++++++++++++-----------------------
 1 file changed, 43 insertions(+), 60 deletions(-)

diff --git a/drivers/soc/fsl/qe/tsa.c b/drivers/soc/fsl/qe/tsa.c
index 239b71187e07..48a176cece86 100644
--- a/drivers/soc/fsl/qe/tsa.c
+++ b/drivers/soc/fsl/qe/tsa.c
@@ -67,34 +67,34 @@
 #define   TSA_CPM1_SIGMR_RDM_DYN_TDMAB		FIELD_PREP_CONST(TSA_CPM1_SIGMR_RDM_MASK, 0x3)
 
 /* SI clock route register (32 bits) */
-#define TSA_SICR	0x0C
-#define   TSA_SICR_SCC2_MASK		GENMASK(15, 8)
-#define   TSA_SICR_SCC2(x)		FIELD_PREP(TSA_SICR_SCC2_MASK, x)
-#define   TSA_SICR_SCC3_MASK		GENMASK(23, 16)
-#define   TSA_SICR_SCC3(x)		FIELD_PREP(TSA_SICR_SCC3_MASK, x)
-#define   TSA_SICR_SCC4_MASK		GENMASK(31, 24)
-#define   TSA_SICR_SCC4(x)		FIELD_PREP(TSA_SICR_SCC4_MASK, x)
-#define     TSA_SICR_SCC_MASK		GENMASK(7, 0)
-#define     TSA_SICR_SCC_GRX		BIT(7)
-#define     TSA_SICR_SCC_SCX_TSA	BIT(6)
-#define     TSA_SICR_SCC_RXCS_MASK	GENMASK(5, 3)
-#define       TSA_SICR_SCC_RXCS_BRG1	FIELD_PREP_CONST(TSA_SICR_SCC_RXCS_MASK, 0x0)
-#define       TSA_SICR_SCC_RXCS_BRG2	FIELD_PREP_CONST(TSA_SICR_SCC_RXCS_MASK, 0x1)
-#define       TSA_SICR_SCC_RXCS_BRG3	FIELD_PREP_CONST(TSA_SICR_SCC_RXCS_MASK, 0x2)
-#define       TSA_SICR_SCC_RXCS_BRG4	FIELD_PREP_CONST(TSA_SICR_SCC_RXCS_MASK, 0x3)
-#define       TSA_SICR_SCC_RXCS_CLK15	FIELD_PREP_CONST(TSA_SICR_SCC_RXCS_MASK, 0x4)
-#define       TSA_SICR_SCC_RXCS_CLK26	FIELD_PREP_CONST(TSA_SICR_SCC_RXCS_MASK, 0x5)
-#define       TSA_SICR_SCC_RXCS_CLK37	FIELD_PREP_CONST(TSA_SICR_SCC_RXCS_MASK, 0x6)
-#define       TSA_SICR_SCC_RXCS_CLK48	FIELD_PREP_CONST(TSA_SICR_SCC_RXCS_MASK, 0x7)
-#define     TSA_SICR_SCC_TXCS_MASK	GENMASK(2, 0)
-#define       TSA_SICR_SCC_TXCS_BRG1	FIELD_PREP_CONST(TSA_SICR_SCC_TXCS_MASK, 0x0)
-#define       TSA_SICR_SCC_TXCS_BRG2	FIELD_PREP_CONST(TSA_SICR_SCC_TXCS_MASK, 0x1)
-#define       TSA_SICR_SCC_TXCS_BRG3	FIELD_PREP_CONST(TSA_SICR_SCC_TXCS_MASK, 0x2)
-#define       TSA_SICR_SCC_TXCS_BRG4	FIELD_PREP_CONST(TSA_SICR_SCC_TXCS_MASK, 0x3)
-#define       TSA_SICR_SCC_TXCS_CLK15	FIELD_PREP_CONST(TSA_SICR_SCC_TXCS_MASK, 0x4)
-#define       TSA_SICR_SCC_TXCS_CLK26	FIELD_PREP_CONST(TSA_SICR_SCC_TXCS_MASK, 0x5)
-#define       TSA_SICR_SCC_TXCS_CLK37	FIELD_PREP_CONST(TSA_SICR_SCC_TXCS_MASK, 0x6)
-#define       TSA_SICR_SCC_TXCS_CLK48	FIELD_PREP_CONST(TSA_SICR_SCC_TXCS_MASK, 0x7)
+#define TSA_CPM1_SICR	0x0C
+#define   TSA_CPM1_SICR_SCC2_MASK		GENMASK(15, 8)
+#define   TSA_CPM1_SICR_SCC2(x)			FIELD_PREP(TSA_CPM1_SICR_SCC2_MASK, x)
+#define   TSA_CPM1_SICR_SCC3_MASK		GENMASK(23, 16)
+#define   TSA_CPM1_SICR_SCC3(x)			FIELD_PREP(TSA_CPM1_SICR_SCC3_MASK, x)
+#define   TSA_CPM1_SICR_SCC4_MASK		GENMASK(31, 24)
+#define   TSA_CPM1_SICR_SCC4(x)			FIELD_PREP(TSA_CPM1_SICR_SCC4_MASK, x)
+#define     TSA_CPM1_SICR_SCC_MASK		GENMASK(7, 0)
+#define     TSA_CPM1_SICR_SCC_GRX		BIT(7)
+#define     TSA_CPM1_SICR_SCC_SCX_TSA		BIT(6)
+#define     TSA_CPM1_SICR_SCC_RXCS_MASK		GENMASK(5, 3)
+#define       TSA_CPM1_SICR_SCC_RXCS_BRG1	FIELD_PREP_CONST(TSA_CPM1_SICR_SCC_RXCS_MASK, 0x0)
+#define       TSA_CPM1_SICR_SCC_RXCS_BRG2	FIELD_PREP_CONST(TSA_CPM1_SICR_SCC_RXCS_MASK, 0x1)
+#define       TSA_CPM1_SICR_SCC_RXCS_BRG3	FIELD_PREP_CONST(TSA_CPM1_SICR_SCC_RXCS_MASK, 0x2)
+#define       TSA_CPM1_SICR_SCC_RXCS_BRG4	FIELD_PREP_CONST(TSA_CPM1_SICR_SCC_RXCS_MASK, 0x3)
+#define       TSA_CPM1_SICR_SCC_RXCS_CLK15	FIELD_PREP_CONST(TSA_CPM1_SICR_SCC_RXCS_MASK, 0x4)
+#define       TSA_CPM1_SICR_SCC_RXCS_CLK26	FIELD_PREP_CONST(TSA_CPM1_SICR_SCC_RXCS_MASK, 0x5)
+#define       TSA_CPM1_SICR_SCC_RXCS_CLK37	FIELD_PREP_CONST(TSA_CPM1_SICR_SCC_RXCS_MASK, 0x6)
+#define       TSA_CPM1_SICR_SCC_RXCS_CLK48	FIELD_PREP_CONST(TSA_CPM1_SICR_SCC_RXCS_MASK, 0x7)
+#define     TSA_CPM1_SICR_SCC_TXCS_MASK		GENMASK(2, 0)
+#define       TSA_CPM1_SICR_SCC_TXCS_BRG1	FIELD_PREP_CONST(TSA_CPM1_SICR_SCC_TXCS_MASK, 0x0)
+#define       TSA_CPM1_SICR_SCC_TXCS_BRG2	FIELD_PREP_CONST(TSA_CPM1_SICR_SCC_TXCS_MASK, 0x1)
+#define       TSA_CPM1_SICR_SCC_TXCS_BRG3	FIELD_PREP_CONST(TSA_CPM1_SICR_SCC_TXCS_MASK, 0x2)
+#define       TSA_CPM1_SICR_SCC_TXCS_BRG4	FIELD_PREP_CONST(TSA_CPM1_SICR_SCC_TXCS_MASK, 0x3)
+#define       TSA_CPM1_SICR_SCC_TXCS_CLK15	FIELD_PREP_CONST(TSA_CPM1_SICR_SCC_TXCS_MASK, 0x4)
+#define       TSA_CPM1_SICR_SCC_TXCS_CLK26	FIELD_PREP_CONST(TSA_CPM1_SICR_SCC_TXCS_MASK, 0x5)
+#define       TSA_CPM1_SICR_SCC_TXCS_CLK37	FIELD_PREP_CONST(TSA_CPM1_SICR_SCC_TXCS_MASK, 0x6)
+#define       TSA_CPM1_SICR_SCC_TXCS_CLK48	FIELD_PREP_CONST(TSA_CPM1_SICR_SCC_TXCS_MASK, 0x7)
 
 struct tsa_entries_area {
 	void __iomem *entries_start;
@@ -159,7 +159,7 @@ static inline void tsa_clrsetbits32(void __iomem *addr, u32 clr, u32 set)
 	tsa_write32(addr, (tsa_read32(addr) & ~clr) | set);
 }
 
-int tsa_serial_connect(struct tsa_serial *tsa_serial)
+static int tsa_cpm1_serial_connect(struct tsa_serial *tsa_serial, bool connect)
 {
 	struct tsa *tsa = tsa_serial_get_tsa(tsa_serial);
 	unsigned long flags;
@@ -168,16 +168,16 @@ int tsa_serial_connect(struct tsa_serial *tsa_serial)
 
 	switch (tsa_serial->id) {
 	case FSL_CPM_TSA_SCC2:
-		clear = TSA_SICR_SCC2(TSA_SICR_SCC_MASK);
-		set = TSA_SICR_SCC2(TSA_SICR_SCC_SCX_TSA);
+		clear = TSA_CPM1_SICR_SCC2(TSA_CPM1_SICR_SCC_MASK);
+		set = TSA_CPM1_SICR_SCC2(TSA_CPM1_SICR_SCC_SCX_TSA);
 		break;
 	case FSL_CPM_TSA_SCC3:
-		clear = TSA_SICR_SCC3(TSA_SICR_SCC_MASK);
-		set = TSA_SICR_SCC3(TSA_SICR_SCC_SCX_TSA);
+		clear = TSA_CPM1_SICR_SCC3(TSA_CPM1_SICR_SCC_MASK);
+		set = TSA_CPM1_SICR_SCC3(TSA_CPM1_SICR_SCC_SCX_TSA);
 		break;
 	case FSL_CPM_TSA_SCC4:
-		clear = TSA_SICR_SCC4(TSA_SICR_SCC_MASK);
-		set = TSA_SICR_SCC4(TSA_SICR_SCC_SCX_TSA);
+		clear = TSA_CPM1_SICR_SCC4(TSA_CPM1_SICR_SCC_MASK);
+		set = TSA_CPM1_SICR_SCC4(TSA_CPM1_SICR_SCC_SCX_TSA);
 		break;
 	default:
 		dev_err(tsa->dev, "Unsupported serial id %u\n", tsa_serial->id);
@@ -185,39 +185,22 @@ int tsa_serial_connect(struct tsa_serial *tsa_serial)
 	}
 
 	spin_lock_irqsave(&tsa->lock, flags);
-	tsa_clrsetbits32(tsa->si_regs + TSA_SICR, clear, set);
+	tsa_clrsetbits32(tsa->si_regs + TSA_CPM1_SICR, clear,
+			 connect ? set : 0);
 	spin_unlock_irqrestore(&tsa->lock, flags);
 
 	return 0;
 }
+
+int tsa_serial_connect(struct tsa_serial *tsa_serial)
+{
+	return tsa_cpm1_serial_connect(tsa_serial, true);
+}
 EXPORT_SYMBOL(tsa_serial_connect);
 
 int tsa_serial_disconnect(struct tsa_serial *tsa_serial)
 {
-	struct tsa *tsa = tsa_serial_get_tsa(tsa_serial);
-	unsigned long flags;
-	u32 clear;
-
-	switch (tsa_serial->id) {
-	case FSL_CPM_TSA_SCC2:
-		clear = TSA_SICR_SCC2(TSA_SICR_SCC_MASK);
-		break;
-	case FSL_CPM_TSA_SCC3:
-		clear = TSA_SICR_SCC3(TSA_SICR_SCC_MASK);
-		break;
-	case FSL_CPM_TSA_SCC4:
-		clear = TSA_SICR_SCC4(TSA_SICR_SCC_MASK);
-		break;
-	default:
-		dev_err(tsa->dev, "Unsupported serial id %u\n", tsa_serial->id);
-		return -EINVAL;
-	}
-
-	spin_lock_irqsave(&tsa->lock, flags);
-	tsa_clrsetbits32(tsa->si_regs + TSA_SICR, clear, 0);
-	spin_unlock_irqrestore(&tsa->lock, flags);
-
-	return 0;
+	return tsa_cpm1_serial_connect(tsa_serial, false);
 }
 EXPORT_SYMBOL(tsa_serial_disconnect);
 
-- 
2.45.0


