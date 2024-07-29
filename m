Return-Path: <linux-kernel+bounces-265920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A76093F7B5
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 16:25:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47E8B282F1A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 14:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35035188CBC;
	Mon, 29 Jul 2024 14:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="VipG2C4a"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF74187322;
	Mon, 29 Jul 2024 14:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722262894; cv=none; b=ql8UtaLsD5PGbeKqfXAKc9EdMU4Ek47TaV77pxEBdpXLUaU9xB4+H5vq0llGCwQe51psBog8Su+VdrLtK8Pjincd4MTV0+4sjyZ85Htp67FfKJsIoasg6pAwe5sHgZkQzKQAmtNTqJ1JL1JFGEGK/svCtnZSnWMZ4SzXsvksAXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722262894; c=relaxed/simple;
	bh=OnUT+weMoARbi3PLgkOC/9mGcDDyHIB1IEe9qJsCElM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a861Skk3aickkmFF2zCvvYfd/lwTs6i3cBti5A8QO1kmVhS5muktm/81qyMWCw4/KuH/qU0tAcDREd9ObYhJb4Sn2afqEjxavugWyG57ycENgtAit7NzMWKO6s2F320IphNMzLaWD5xHjLAs9qz+tZasmkVpbN+15vFLD3G4qPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=VipG2C4a; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 83FC524000A;
	Mon, 29 Jul 2024 14:21:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1722262891;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lrvHrWOWhKVyILAF7ZtiWAvLgdtBWWhrCvOa0CPkMcA=;
	b=VipG2C4ag8eBoUEcumbokRh8d6rRhS28xNhPp+JpNLbQYtW5LOFPNeRyI7iQsNlhjP9eGR
	Ewvs29hsUc5dCXEdCLQ3SK80TQU0ufXG5gcxO+jdgCmoCxogP9eyhqbz0dU8dXGivstNgt
	4N0KC4DjyoYD46ICcEZRJtF5XzxPx9trAzpWxDDz9fKcecDeXfmakB7wkjp8MFEn5mkmFZ
	x8d30d+Lu4M/DDjZ0mKsoRGkOALpCloml+7sEYW2Fpf2ZnMtxsST0/V2KPjWmCzIfZJMot
	371knE/l6MAi229RPMmtXe5EoCItJpUoU7UQNRZDOadpH+yKXL3IP3VrSgGTMA==
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
Subject: [PATCH v1 22/36] soc: fsl: cpm1: qmc: Add missing spinlock comment
Date: Mon, 29 Jul 2024 16:20:51 +0200
Message-ID: <20240729142107.104574-23-herve.codina@bootlin.com>
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

checkpatch.pl raises the following issue
  CHECK: spinlock_t definition without comment

Add the missing comments.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 drivers/soc/fsl/qe/qmc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/fsl/qe/qmc.c b/drivers/soc/fsl/qe/qmc.c
index 2d54d7400d2d..3736a8e4575e 100644
--- a/drivers/soc/fsl/qe/qmc.c
+++ b/drivers/soc/fsl/qe/qmc.c
@@ -196,7 +196,7 @@ struct qmc_chan {
 	u64	rx_ts_mask;
 	bool is_reverse_data;
 
-	spinlock_t	tx_lock;
+	spinlock_t	tx_lock; /* Protect Tx related data */
 	cbd_t __iomem *txbds;
 	cbd_t __iomem *txbd_free;
 	cbd_t __iomem *txbd_done;
@@ -204,7 +204,7 @@ struct qmc_chan {
 	u64	nb_tx_underrun;
 	bool	is_tx_stopped;
 
-	spinlock_t	rx_lock;
+	spinlock_t	rx_lock; /* Protect Rx related data */
 	cbd_t __iomem *rxbds;
 	cbd_t __iomem *rxbd_free;
 	cbd_t __iomem *rxbd_done;
-- 
2.45.0


