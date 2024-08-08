Return-Path: <linux-kernel+bounces-278986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4874294B763
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 09:16:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 005171F24C12
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 07:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 632CF18E058;
	Thu,  8 Aug 2024 07:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="pLVpExoq"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728C018CC0D;
	Thu,  8 Aug 2024 07:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723101121; cv=none; b=eI6Hr9CZLdRGz/QqdwKHqdKmTDR9A3SD6QmKhasG/sULBs/ENZF1tvYPwoNO6lm5ZHcKkz5+0kD4S/eu4XjQITq8WSDals3W3kAhI0VTLQTafcyfv46222HkPDJpub81Odp46uPj56GJDzZKuErHhkh0mktHKkaYv0oFAia3ubY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723101121; c=relaxed/simple;
	bh=OnUT+weMoARbi3PLgkOC/9mGcDDyHIB1IEe9qJsCElM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JvZgnxWVniLSah9MPG3Enj7fwloeSi5uEGrsgyWViN4ojbS22XqEEiVkiiKP8K2fFgrFHyWGcAxSI6GEfw6AvkKJEiZmOjt9AJMcSVB2EixJfRRLSqE3QI5CaFLVBCvvd/eao+gIl9NPMbZB4xdhNFJg1GBmNIdSJrwvIj+RDnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=pLVpExoq; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id DE0C6C000C;
	Thu,  8 Aug 2024 07:11:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1723101115;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lrvHrWOWhKVyILAF7ZtiWAvLgdtBWWhrCvOa0CPkMcA=;
	b=pLVpExoquveiObLx7pXqXamoPmD5qsxOVt+baRDmQ3WMIPIPIQlXwgVvk+Cd7L9ZG3FEz7
	3M/+QVlLK74DGYEguG9P1I2ZEujHl55qJTIf5pm1SreHGEM698cGEWdmU9WOPj6efQzIBT
	2FdyDD22xMUJYiPe0e0AfzEUH+XMb++6CRfAs8g6f1VvIy4KBzWt9srW0EyaBEgl9v42Zo
	yqAUX5CJFvDHQwh+NIVbfq65q3gm+8/DAQOz6tqvR5vy51g6x3HkN77NnXoBjPn8MD2VDX
	ZhjuZPo5WUaT33A3JcUDnak0i4dNHmoy+ow7mnr1K2KWH5o/ubFcuPYGO4bm1w==
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
Subject: [PATCH v2 22/36] soc: fsl: cpm1: qmc: Add missing spinlock comment
Date: Thu,  8 Aug 2024 09:11:15 +0200
Message-ID: <20240808071132.149251-23-herve.codina@bootlin.com>
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


