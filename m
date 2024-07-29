Return-Path: <linux-kernel+bounces-265915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4C1E93F7A5
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 16:24:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E21C1F21AC8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 14:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C876A155A58;
	Mon, 29 Jul 2024 14:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="oBQJem4o"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE73815E5AE;
	Mon, 29 Jul 2024 14:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722262891; cv=none; b=sNd/0QiyD7YGyLjbV/NDhPzd+BsVvi3z766bU6Y+vFxlaMyPbOrVeRbPMEO+V7nDlO6GdbABIVTkpFYHgMfuNZvlMWPF6Uroc7NJK0qWlLxZw5Jx29yY7QvIv7TqfxAd6ti6KAIfG2k2bvxieICCYJFtbSNDb/dK4Als9FOXLDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722262891; c=relaxed/simple;
	bh=P+pmlVzFnK87hESczcZph1T5K4wJhP5XFmPR1rv2yNI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ItDMYG8sLv/vx9uEAnW/i2BTNzonIHELW9GZsgsmD8E+c6ywj+13UI1zAvZbFfF6OcdHsbpKV913qEJfi6TkYi6IAaDNCtp7TqpH4/SvuuSUesuU/vINn6b/EeJwrGsd6yeqWPbRa+C+e0um0RHNJyqSL1LQKLb3rkwhS5bgM40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=oBQJem4o; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id E13D7240006;
	Mon, 29 Jul 2024 14:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1722262887;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=usDe5saxjtuJSjAyDJrinAqDsazax42/56S/Us4E84U=;
	b=oBQJem4oR/YEugzkh8A/1zsWi6kLEdAfBmpi+W07UIBZg09wnteviVZQSQGfAHBVH5ur4X
	E9VX7AVVtgv1jLu29qTw3t3I2cZK65CvKmxMoYXms3a0HwZrXojwNK+XYxqECodvhK1SEI
	Faf43B/q74NxERmyykn57TXFKA++ZRV616bn3x8xOrnymfWp1K48BTIrZpUyvS2FkLpuvL
	MUIVQACDXqT/inIx76s6qeDhsEC79xkKbHgTLvt4QDkU6q9Fx6IoWVyF058jEEsGjTrOSV
	54taMjmlvjh/aEAMxfuxbY1qaYKqipcGCBIPExJeB44M4k1q6dVyChtuB8cq1A==
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
Subject: [PATCH v1 17/36] soc: fsl: cpm1: qmc: Rename QMC_TSA_MASK
Date: Mon, 29 Jul 2024 16:20:46 +0200
Message-ID: <20240729142107.104574-18-herve.codina@bootlin.com>
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


