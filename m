Return-Path: <linux-kernel+bounces-278974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 561F694B74A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 09:14:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB4331F2210D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 07:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3224418A6DB;
	Thu,  8 Aug 2024 07:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="nfQjrNes"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 220B3188CD6;
	Thu,  8 Aug 2024 07:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723101112; cv=none; b=IFInKoBsss4YhO8AJbv4bdQ1vGIRMl8KxTVIK4/RZpBXiVxqOHOmaLcU8rAg0gcRc8AhuUAUVnI76jh3aZxh0AgHVSBgGzYEUn0FKznm6SnaLdERQ1NtoZTLMDZZaUzVCFHRtGKC3c+w0bVsUfWCamEYLRWEBe4NJGpMlTI4E/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723101112; c=relaxed/simple;
	bh=0vmFJIBk5XfMjPrXtpv+7Y1SABvbs6sbNptSdJcW5wU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JUPRoRoGYBitbOdCSm/H3/nT9kwKh3YhoXfEy1W7hrpJbUvi0lsPv23gVhyKIorw8o/QWCE2UaE6ytLfhgFPKYVgjezcnqAAfLtkTiEwNLrVs8kf8AUTE1iIPKjrtSJLyBf+6jjtKRm8DPSYlI7XAwNDuYnLDjzH6La2Hkza600=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=nfQjrNes; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 2A574C0019;
	Thu,  8 Aug 2024 07:11:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1723101107;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uvdVdoMDvhGGx9jdQpRy50lSt7vOk/dQvY6e1fABxmk=;
	b=nfQjrNesHdDa5sTAQTkLhGciJXnUi+I5xnVX/KVFm1PFsdRWF9kmGbDHX9VX56fbp5Lpix
	rlujP0/mL0ISQABC+FDevDnbBwZZYALkwN4k8shflIUlNyO/2ytuUKaHa15bPgBGuJHDIE
	Hha5D0kbglsGE87K+moiWukE5ANhz5kiSMjpQqyO+nsoHmQHvqRJ2hSaeH/PD1BibPAb8F
	1Mov4844acpdGCeYShegkaYFdyuWM6PEZGX2YmcohxIWLYIDYudg/0dyfQVMiALj/PtMqL
	NkyddDagwnfqxkl+uKFtPE6aRAInRCAE+usTa9ct4PohTAUzG/4rnA7+D5FT/Q==
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
Subject: [PATCH v2 12/36] soc: fsl: cpm1: tsa: Isolate specific CPM1 part from tsa_serial_{dis}connect()
Date: Thu,  8 Aug 2024 09:11:05 +0200
Message-ID: <20240808071132.149251-13-herve.codina@bootlin.com>
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


