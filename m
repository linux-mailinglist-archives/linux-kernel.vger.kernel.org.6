Return-Path: <linux-kernel+bounces-265924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 172B393F7C0
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 16:26:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FE421C21E70
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 14:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9268518A958;
	Mon, 29 Jul 2024 14:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Am3RTP+E"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B4EC188CC6;
	Mon, 29 Jul 2024 14:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722262897; cv=none; b=BlRyShEIgCMru7U0ex044fdN1jaGTbWKdy4qLpNefZJVTy/wMFB7eMVGq22nzOKkCIJOI8Icxpdix8K3R296Rr9mWJ6vFw59egg58+7RUTdm6BRpyJJb5Y8T/yrLV7bP2fMH9rYCDUJHv2Tp1wnNhwYa92zUpJ4+jLgf9oIZh+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722262897; c=relaxed/simple;
	bh=tkwQM16J8c7lvQQMH50Lukingw3n0HwfaWpUYBiCEtE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QSjLEvJ79aX6mA8s546ncaksk1S2XSuK4y9kYWaMYBOnne3nrBgKcxqRjtLGLSG+4wLd61VAot5v180mUHE59YggG+AOUm4C30BNnuC8vyhLF5U7TPgbhE3nyzPacX9eKeGAfBFlwFgYduy/fNTysym/be/hMBAX9Up5VPLSxho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Am3RTP+E; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 69BFC240011;
	Mon, 29 Jul 2024 14:21:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1722262894;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WRWRYsao//QuuKGXh5Qe/5pgiQSleHHmlQQU/Eyhza0=;
	b=Am3RTP+E4YbrCY3oEaeF8ad51Rk6rJhX/K0bOFF+TBcf1blrWvfyVZxrbyTnXrO7bj0RtT
	D36SK0I7KdtNWfJeB++moMP294tqZJXPuExUkfULbK6dFyqN0psggIJPH+Y/X/+zgS1RBC
	X1pZeuy1rV5KyPlllHqQofMBM137LfFzg66aaedwqKZ+f/IBF0Si0yy81DvnUxK7FEW0ZJ
	JDZanzz6sdTQfpN8lsWWRTKcl+yzWCpgPgg+UyGLWyCfh6MyNoJBgYdcpFwXTY3B8bA8KT
	grCRYsMoGAmjc/TUnClnvSkR8eHb+L0H4mjw+iZwmLcIhtMa4neFuLnxgmixFA==
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
Subject: [PATCH v1 26/36] soc: fsl: cpm1: qmc: Introduce qmc_init_resource() and its CPM1 version
Date: Mon, 29 Jul 2024 16:20:55 +0200
Message-ID: <20240729142107.104574-27-herve.codina@bootlin.com>
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

Current code handles the CPM1 version of QMC. Resources initialisations
(i.e. retrieving base addresses and offsets of different parts) will
be slightly different in the QUICC Engine (QE) version. Indeed, in QE
version, some resources need to be allocated and are no more "staticaly"
defined.

In order to prepare the support for QE version, introduce
qmc_init_resource() to initialize those resources and isolate the CPM1
specific operations in a specific function.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 drivers/soc/fsl/qe/qmc.c | 47 ++++++++++++++++++++++++++--------------
 1 file changed, 31 insertions(+), 16 deletions(-)

diff --git a/drivers/soc/fsl/qe/qmc.c b/drivers/soc/fsl/qe/qmc.c
index 8dd0f8fc7b08..eacc7dd2be53 100644
--- a/drivers/soc/fsl/qe/qmc.c
+++ b/drivers/soc/fsl/qe/qmc.c
@@ -1593,11 +1593,38 @@ static irqreturn_t qmc_irq_handler(int irq, void *priv)
 	return IRQ_HANDLED;
 }
 
+static int qmc_cpm1_init_resources(struct qmc *qmc, struct platform_device *pdev)
+{
+	struct resource *res;
+
+	qmc->scc_regs = devm_platform_ioremap_resource_byname(pdev, "scc_regs");
+	if (IS_ERR(qmc->scc_regs))
+		return PTR_ERR(qmc->scc_regs);
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "scc_pram");
+	if (!res)
+		return -EINVAL;
+	qmc->scc_pram_offset = res->start - get_immrbase();
+	qmc->scc_pram = devm_ioremap_resource(qmc->dev, res);
+	if (IS_ERR(qmc->scc_pram))
+		return PTR_ERR(qmc->scc_pram);
+
+	qmc->dpram  = devm_platform_ioremap_resource_byname(pdev, "dpram");
+	if (IS_ERR(qmc->dpram))
+		return PTR_ERR(qmc->dpram);
+
+	return 0;
+}
+
+static int qmc_init_resources(struct qmc *qmc, struct platform_device *pdev)
+{
+	return qmc_cpm1_init_resources(qmc, pdev);
+}
+
 static int qmc_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
 	unsigned int nb_chans;
-	struct resource *res;
 	struct qmc *qmc;
 	int irq;
 	int ret;
@@ -1620,21 +1647,9 @@ static int qmc_probe(struct platform_device *pdev)
 				     "Failed to get TSA serial\n");
 	}
 
-	qmc->scc_regs = devm_platform_ioremap_resource_byname(pdev, "scc_regs");
-	if (IS_ERR(qmc->scc_regs))
-		return PTR_ERR(qmc->scc_regs);
-
-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "scc_pram");
-	if (!res)
-		return -EINVAL;
-	qmc->scc_pram_offset = res->start - get_immrbase();
-	qmc->scc_pram = devm_ioremap_resource(qmc->dev, res);
-	if (IS_ERR(qmc->scc_pram))
-		return PTR_ERR(qmc->scc_pram);
-
-	qmc->dpram  = devm_platform_ioremap_resource_byname(pdev, "dpram");
-	if (IS_ERR(qmc->dpram))
-		return PTR_ERR(qmc->dpram);
+	ret = qmc_init_resources(qmc, pdev);
+	if (ret)
+		return ret;
 
 	/* Parse channels informationss */
 	ret = qmc_of_parse_chans(qmc, np);
-- 
2.45.0


