Return-Path: <linux-kernel+bounces-265928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CD1693F7C9
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 16:27:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC65F28286D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 14:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2984418E741;
	Mon, 29 Jul 2024 14:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="hKlLMA4I"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5538018A94E;
	Mon, 29 Jul 2024 14:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722262900; cv=none; b=nKlXb3mPq2MoTkixx9fjwPh5khrH9ZdJQK+4fNzkA13HjDEYpuDmbhsRP8TNqaXTC4u2ZGbsMU6yD42fpWK3axr2Q7Zae1TQtU0/1ACb8SOi6hPpRJkqgfxhdcmEIVkPpcLCiv23SHQ7ehVBEvk7ZRxXjAxZK+5A35dXBnwpz9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722262900; c=relaxed/simple;
	bh=8ksQKBK3nAiioJdXAHF0iPGZ2MhIMi5zRV7/4DTbtl8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XRC3qW3j2KwT+z4YYiGv5JIzoSmXIRkSs2zcV6x8hgEMtQ6uDlmTb3BZKg3d0Wkmy0AONp5p9DMMxLHROrIiz5jaehVixj01/FZTf1942L1N4Q0jkMibx8prOvMY+q5qmZsdSPFPQ8veGJDFU70e+dw60Rw9lecAl6wxqoLkCqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=hKlLMA4I; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 2D9C224000C;
	Mon, 29 Jul 2024 14:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1722262896;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bhHLsIpdGYfQTXJIMda4RgH3fpRoHJARlbP68m37GfE=;
	b=hKlLMA4IU2x2n4HBnN8iY1/eRzSEa9AHf091qccnEmtNIN3SS8Cy9pAUkPFlMnxxogYPJH
	KaEwDYnak3jkd4o7iDYstR9YRCS3Z4P4oH1r7MH+HwNRbwG151zDrYaYJsvI3DCEFd62jn
	qprtEcjYOP3Fob+Y9itQgMJpBWwaaXkkzzQ0a0s8xXjKvWxbxDIeimJEfgYNSOjQqZSu7h
	k1oYN0go0dSGnLEE46HSRIv47MTW75qkL1vU4eMhGPNZDgPrb24V3Z3dzIAZkheQOZnbvM
	HAwdvDtENW1Hh9PxdjVQfBqIQv/Q/hEczZsoE0Oy/SmLRDJ1XCVm4j75hQTDjA==
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
Subject: [PATCH v1 30/36] soc: fsl: cpm1: qmc: Rename SCC_GSMRL_MODE_QMC
Date: Mon, 29 Jul 2024 16:20:59 +0200
Message-ID: <20240729142107.104574-31-herve.codina@bootlin.com>
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

Current code handles CPM1 version of QMC. Even if GSMRL is specific to
the CPM1 version, the exact same purpose and format register (GUMRL) is
present in the QUICC Engine (QE) version of QMC. Compared to the QE
version, the values defined for the mode bitfield are different and the
0x0A value defined for the QMC mode is CPM1 specific.

In order to prepare the support for the QE version, rename this bitfield
value to clearly identify it as CPM1 specific.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 drivers/soc/fsl/qe/qmc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/fsl/qe/qmc.c b/drivers/soc/fsl/qe/qmc.c
index 63af2608c3cd..062477b7426e 100644
--- a/drivers/soc/fsl/qe/qmc.c
+++ b/drivers/soc/fsl/qe/qmc.c
@@ -27,7 +27,7 @@
 #define SCC_GSMRL_ENR		BIT(5)
 #define SCC_GSMRL_ENT		BIT(4)
 #define SCC_GSMRL_MODE_MASK	GENMASK(3, 0)
-#define SCC_GSMRL_MODE_QMC	FIELD_PREP_CONST(SCC_GSMRL_MODE_MASK, 0x0A)
+#define SCC_CPM1_GSMRL_MODE_QMC	FIELD_PREP_CONST(SCC_GSMRL_MODE_MASK, 0x0A)
 
 /* SCC general mode register low (32 bits) */
 #define SCC_GSMRH	0x04
@@ -1642,7 +1642,7 @@ static int qmc_cpm1_init_scc(struct qmc *qmc)
 	qmc_write32(qmc->scc_regs + SCC_GSMRH, val);
 
 	/* enable QMC mode */
-	qmc_write32(qmc->scc_regs + SCC_GSMRL, SCC_GSMRL_MODE_QMC);
+	qmc_write32(qmc->scc_regs + SCC_GSMRL, SCC_CPM1_GSMRL_MODE_QMC);
 
 	/* Disable and clear interrupts */
 	qmc_write16(qmc->scc_regs + SCC_SCCM, 0x0000);
-- 
2.45.0


