Return-Path: <linux-kernel+bounces-278983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8038994B75B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 09:15:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE84D2858C5
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 07:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0353918CBF3;
	Thu,  8 Aug 2024 07:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="EIDeIhSI"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4828118B474;
	Thu,  8 Aug 2024 07:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723101118; cv=none; b=pKWcnDt4reZ8OdDhIgpE1+zw5tJKetpFq++dVH2yOPwdXvN0845JeHyIoJkWsA4983sujX4bnGGzbb2U0trp9d3rlTIs/osyqUw4NExEXY2OdFJ4ni1OzKQ+59TRINMh6gpPrVc2m/1rJlpFHK2fGjPcM6VuW07y6zY6/LG/NUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723101118; c=relaxed/simple;
	bh=EfqIxpeHcxquG/A6osWSWsmqDV5LJmj/1Fp0aeEDa5s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KytJm11uql68of/2kavHGiR0WZxGtxfRN+UFfVsRaCz0sDbo3BJioDk8RfSxUlOo8XPQZRnMdbP8VbOr1K5KT6UOrRkiexbNYEzBRc1RTMgmUgEN5ZBxIkim+iP1Y61BOoPusebhU3ZD34if2NHizfs2sWyvf+0UXHqAThJH2b4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=EIDeIhSI; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 2281DC000D;
	Thu,  8 Aug 2024 07:11:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1723101114;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hvpSGkwLO+E6MOzmOnoPAe/sppi5mCag/x8MKSW8BQ8=;
	b=EIDeIhSINh2XqEI/SlxP2AcmXxXEW1kfknbLBOkOCZwd8ja8SCAZBNZkw8LIYb7A8R6yMS
	p4+uGEaX7BgX/IkEOIWmV/rETzXealaVE1PaGUw2uIeQv+j7oMTU5xHyBN/A5QJnsqroSE
	Xw5UbQ4KM1C7Z4y2aaXwYuFs8FlskZRm3g4xlxja6zQE7doDHuWrlkCRa3urimY0oQ1v3u
	GYZAMQjTZ8EATxFklm2zGDsSfiwaeVEPhrbh+eZo68Du9LwrBEAVH0oWARfI0r9lk1SrdK
	7nbYm6I9zT00BSo01NiliF7DsT/kVyWLcdYiIt+fzaGZ0udFgOQo5LimNVC7Dw==
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
Subject: [PATCH v2 21/36] soc: fsl: cpm1: qmc: Fix 'transmiter' typo
Date: Thu,  8 Aug 2024 09:11:14 +0200
Message-ID: <20240808071132.149251-22-herve.codina@bootlin.com>
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

checkpatch.pl raises the following issue
  CHECK: 'transmiter' may be misspelled - perhaps 'transmitter'?

Indeed, fix it.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 drivers/soc/fsl/qe/qmc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/fsl/qe/qmc.c b/drivers/soc/fsl/qe/qmc.c
index 04466e735302..2d54d7400d2d 100644
--- a/drivers/soc/fsl/qe/qmc.c
+++ b/drivers/soc/fsl/qe/qmc.c
@@ -1715,7 +1715,7 @@ static int qmc_probe(struct platform_device *pdev)
 	if (ret < 0)
 		goto err_disable_intr;
 
-	/* Enable transmiter and receiver */
+	/* Enable transmitter and receiver */
 	qmc_setbits32(qmc->scc_regs + SCC_GSMRL, SCC_GSMRL_ENR | SCC_GSMRL_ENT);
 
 	platform_set_drvdata(pdev, qmc);
@@ -1742,7 +1742,7 @@ static void qmc_remove(struct platform_device *pdev)
 {
 	struct qmc *qmc = platform_get_drvdata(pdev);
 
-	/* Disable transmiter and receiver */
+	/* Disable transmitter and receiver */
 	qmc_setbits32(qmc->scc_regs + SCC_GSMRL, 0);
 
 	/* Disable interrupts */
-- 
2.45.0


