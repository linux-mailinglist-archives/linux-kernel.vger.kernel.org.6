Return-Path: <linux-kernel+bounces-278978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BC1094B751
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 09:14:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 430731F227F4
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 07:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40D9118C332;
	Thu,  8 Aug 2024 07:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="AEQQ5Agk"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 125A7189B84;
	Thu,  8 Aug 2024 07:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723101115; cv=none; b=SsrKz9WlGPDdm6z33CcXlaWf3Aw09NxE+wyLHagBRgxa7oQ01w7PZHu95vvaxnuai0haGPCUUEZytiirvyRwnZaJ/8LhhoKrHw3PNLjSzyzIhhyE1POfubdPrJ3B6zLYz1yvIEFP8Di9VUJEXMYujM+FwZ+3voU5MhnvHcbI/E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723101115; c=relaxed/simple;
	bh=P+pmlVzFnK87hESczcZph1T5K4wJhP5XFmPR1rv2yNI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QBpCBEoIMufAJNPBWQuj9i6LWw8bPABZZBYw29YmUx+taxNm7XIVLYtHX5w/iQUDSiG/u7peWHYzJKYzHz21pg+gZcPDSDK1GBVIX8YyfSebA+g8FuESum04SVJXqN56DBAcexnOkmosQhF/jqVp7BPB97otc5T7XAxGYR4LdZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=AEQQ5Agk; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 1A1B8C0009;
	Thu,  8 Aug 2024 07:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1723101111;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=usDe5saxjtuJSjAyDJrinAqDsazax42/56S/Us4E84U=;
	b=AEQQ5AgkXwm2omQ4xULWm/XIBU9nBxdluen/JMN0hBYOe64ckKXO3P9jwC6+yub4J4ijK8
	mqpLObsM9r+q7kDPUHi67+gSVElhmfx8nbA6F/S/jozIBgMvk+iWYXx2NSM9KQuIti3yyr
	LzcwHROd8TW1/IlmNU1Hy8+UNMH0CEmMeXoUKaV4zlqed0yE750mXL9T25i0Tetmcla/tu
	BSRb3ImCR7KdOjEi0VgCMdLEGdiHkoijsKACkFBxxfuOTnQwNj6YxZCXmsEEx4N14CchEh
	y/M+vv/yF9z896gH6I21Rs/eqLXRAaDTcZqUsR0MWqVV92/Bc1rsoUmyHZcciA==
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
Subject: [PATCH v2 17/36] soc: fsl: cpm1: qmc: Rename QMC_TSA_MASK
Date: Thu,  8 Aug 2024 09:11:10 +0200
Message-ID: <20240808071132.149251-18-herve.codina@bootlin.com>
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

QMC_TSA_MASK is a bitfield. The value defined is a specific value of
this bitfield and correspond to the use of 8bit resolution for the
routing entry.

Be accurate and rename the defined constant to reflect this point.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 drivers/soc/fsl/qe/qmc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/soc/fsl/qe/qmc.c b/drivers/soc/fsl/qe/qmc.c
index 916395745850..721e0770510c 100644
--- a/drivers/soc/fsl/qe/qmc.c
+++ b/drivers/soc/fsl/qe/qmc.c
@@ -77,7 +77,7 @@
 /* TSA entry (16bit entry in TSATRX and TSATTX) */
 #define QMC_TSA_VALID		(1 << 15)
 #define QMC_TSA_WRAP		(1 << 14)
-#define QMC_TSA_MASK		(0x303F)
+#define QMC_TSA_MASK_8BIT	(0x303F)
 #define QMC_TSA_CHANNEL(x)	((x) << 6)
 
 /* Tx buffer descriptor base address (16 bits, offset from MCBASE) */
@@ -641,7 +641,7 @@ static int qmc_chan_setup_tsa_64rxtx(struct qmc_chan *chan, const struct tsa_ser
 		return -EINVAL;
 	}
 
-	val = QMC_TSA_VALID | QMC_TSA_MASK | QMC_TSA_CHANNEL(chan->id);
+	val = QMC_TSA_VALID | QMC_TSA_MASK_8BIT | QMC_TSA_CHANNEL(chan->id);
 
 	/* Check entries based on Rx stuff*/
 	for (i = 0; i < info->nb_rx_ts; i++) {
@@ -677,7 +677,7 @@ static int qmc_chan_setup_tsa_32rx(struct qmc_chan *chan, const struct tsa_seria
 
 	/* Use a Rx 32 entries table */
 
-	val = QMC_TSA_VALID | QMC_TSA_MASK | QMC_TSA_CHANNEL(chan->id);
+	val = QMC_TSA_VALID | QMC_TSA_MASK_8BIT | QMC_TSA_CHANNEL(chan->id);
 
 	/* Check entries based on Rx stuff */
 	for (i = 0; i < info->nb_rx_ts; i++) {
@@ -713,7 +713,7 @@ static int qmc_chan_setup_tsa_32tx(struct qmc_chan *chan, const struct tsa_seria
 
 	/* Use a Tx 32 entries table */
 
-	val = QMC_TSA_VALID | QMC_TSA_MASK | QMC_TSA_CHANNEL(chan->id);
+	val = QMC_TSA_VALID | QMC_TSA_MASK_8BIT | QMC_TSA_CHANNEL(chan->id);
 
 	/* Check entries based on Tx stuff */
 	for (i = 0; i < info->nb_tx_ts; i++) {
-- 
2.45.0


