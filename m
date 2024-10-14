Return-Path: <linux-kernel+bounces-364249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C6FF99CEE9
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 16:48:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96A69288731
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 14:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 493FB1B85C5;
	Mon, 14 Oct 2024 14:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="1giDSbRI"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F461B86CC
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 14:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728917209; cv=none; b=TZZ8WLgtqAb2Sk5Wav/R85hrB0cHP/pFJV011Cs6U3txBQ6wH8peS3V0FVFV1yvnxB23s1zmiQ+lK/Xl2dWnMSiGFEiDAIWPdDut3UL9lhyWDDjQVrIo0m6nfxTKqevsBgaz8ZS4zdENBgI8D5yqE5TSXyBhTrYoMS2Xg4/P+mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728917209; c=relaxed/simple;
	bh=akOrnwMxU1E+pwTvSLuA6uay2+uLOtYLzBzVtaJT254=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mZfs5g4BLbb8kR5pOXaUM1pneKFVnLIVTpNO/4BknV1UlQ+4J4ZzVOjy+dzWmsrdHvrFSBsacTD2iX9GWJaGXHiXPX3rTFy2ksUzCyhlsXQO1jrgqmUGefIspb3Sz4YDYFSgZsH7iNKelNa/Ey0huPTdTOmj0xH7SfiOOa0Hc4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=1giDSbRI; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=1T5XN3Ad/p+ISzu/CubQt2zgNgVaBnPeOZ/AyvyGbXk=; b=1giDSbRI7J77m4euuSSqn1y2Ym
	iUNlwG8W+qu5QGFOEF5cNtvOTS7AcHligmimGQLo/z2S77JVm1qvGDLmxpO5yfWVVG9vwxyD57Fhx
	qGdd7WLV4jHgcGLM20VAez1Bh6PVF4fRCJ1n4K3pZr+fHepDq2KR1h1gr0gii5lR06LJYNGBkuzlA
	qC1Bee9/XV+w/LHMby2ZWnIx8dGMUudeB7nn23PEmaHbt9hSrSypI6s0EGAgLBk+8mjujB43wt4+x
	WbiugSxpifk++V5eA2WPGHsEuX94LVpnzby8t8PlbQoTH0sf7ZQuG+bUWesQvdyXv9rKzjZmQBI+/
	tcm7B6AA==;
Received: from 2a02-8389-2341-5b80-350d-7b06-b28a-173d.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:350d:7b06:b28a:173d] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t0MLO-00000005XRf-46jW;
	Mon, 14 Oct 2024 14:46:47 +0000
From: Christoph Hellwig <hch@lst.de>
To: stefani@seibold.net
Cc: jassisinghbrar@gmail.com,
	jirislaby@kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] kfifo: don't include dma-mapping.h in kfifo.h
Date: Mon, 14 Oct 2024 16:46:43 +0200
Message-ID: <20241014144643.51917-1-hch@lst.de>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Nothing in kfifo.h needs dma-mapping.h.  Drop the include to
reduce include bloat.

Fixes: d52b761e4b1a ("kfifo: add kfifo_dma_out_prepare_mapped()")
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/mailbox/omap-mailbox.c | 1 +
 include/linux/kfifo.h          | 1 -
 samples/kfifo/dma-example.c    | 1 +
 3 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mailbox/omap-mailbox.c b/drivers/mailbox/omap-mailbox.c
index 6797770474a55d..680243751d625f 100644
--- a/drivers/mailbox/omap-mailbox.c
+++ b/drivers/mailbox/omap-mailbox.c
@@ -15,6 +15,7 @@
 #include <linux/slab.h>
 #include <linux/kfifo.h>
 #include <linux/err.h>
+#include <linux/io.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
diff --git a/include/linux/kfifo.h b/include/linux/kfifo.h
index 564868bdce898b..fd743d4c4b4bdc 100644
--- a/include/linux/kfifo.h
+++ b/include/linux/kfifo.h
@@ -37,7 +37,6 @@
  */
 
 #include <linux/array_size.h>
-#include <linux/dma-mapping.h>
 #include <linux/spinlock.h>
 #include <linux/stddef.h>
 #include <linux/types.h>
diff --git a/samples/kfifo/dma-example.c b/samples/kfifo/dma-example.c
index 48df719dac8c6d..8076ac410161a3 100644
--- a/samples/kfifo/dma-example.c
+++ b/samples/kfifo/dma-example.c
@@ -9,6 +9,7 @@
 #include <linux/kfifo.h>
 #include <linux/module.h>
 #include <linux/scatterlist.h>
+#include <linux/dma-mapping.h>
 
 /*
  * This module shows how to handle fifo dma operations.
-- 
2.45.2


