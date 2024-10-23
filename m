Return-Path: <linux-kernel+bounces-377393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CDA39ABE32
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 07:53:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E5FB285535
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 05:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A934B14601F;
	Wed, 23 Oct 2024 05:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gLGvh40o"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90457482
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 05:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729662803; cv=none; b=fhEP/WsSLEloJ5oa8CRto/X1MmNv8g8xEYYaG9NhXnFupvoVSfpiV4TK70uXfkU9c8gMsqqTUHvIU1gUZx6vXpLfmn0T5B45glvYWkqMf6WqOCOuwRlH1YVMmGnAGwl4nnFh0XIwUXVx39HiRhjQH6J4eTpwpqQfFatcU8nrmxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729662803; c=relaxed/simple;
	bh=JIk710m8zU0D9LGGYbNLhXd68aDlZgkonBoygLCRcOk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oF9fCrDvAn06a4MApjW3xPRXCWwTdlJo5UIWltTKEfI/aUMOKjhrFPtNyOIFD+pkCFymeICHYBo/NdM0pKk1wwm6cP6VHz+e8zyDwUQ0C9mYWnlDCp5u7SiqWqwt8C4FT/bGjuteDO1EluqSSJhI8XPpemaEKYflMb2ealS6F2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=gLGvh40o; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=ucsdSOT11keOenZNlOJngPjRbeeVuK4G70KuReZyTnI=; b=gLGvh40oeMyrrXwPXIW909Em6W
	f32ytTAHRwY2lold/u5PwAbxE1NAM2GXdvkhGX9lwK44sbQJ9M1INtln1ZaeO2f0w5iDdC8XXXKB6
	HSUn6/hos9GhYOMmQzNWwqGiZOTnRYbLJTBZ+X1rp8cLT43B/3RRdTflCQoaLWJzJjImBU0ynEFb2
	mPz6aKW4LPRqrQAb8BraxPd73M6iGvx7dZui3S10QvKp8Hf0aqu6celSVxb40lPzr4YjS5BipU+yE
	heoNEMKxkxQUBOzELY3G3fn8RQj7YfQDQJv2i6I5JklaR2hGuDZ+uv8uZfti+JwluJOpkDqT3P11V
	r2CIQVsA==;
Received: from 2a02-8389-2341-5b80-8c6c-e123-fc47-94a5.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:8c6c:e123:fc47:94a5] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t3UJ5-0000000D7Qb-2V4S;
	Wed, 23 Oct 2024 05:53:20 +0000
From: Christoph Hellwig <hch@lst.de>
To: jassisinghbrar@gmail.com
Cc: stefani@seibold.net,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] kfifo: don't include dma-mapping.h in kfifo.h
Date: Wed, 23 Oct 2024 07:53:04 +0200
Message-ID: <20241023055317.313234-1-hch@lst.de>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Nothing in kfifo.h directly needs dma-mapping.h, only two macros
use DMA_MAPPING_ERROR when actually instantiated.  Drop the
dma-mapping.h include to reduce include bloat.

Add an explicity <linux/io.h> include to drivers/mailbox/omap-mailbox.c
as that file uses __raw_readl and __raw_writel through a complicated
include chain involving <linux/dma-mapping.h>

Fixes: d52b761e4b1a ("kfifo: add kfifo_dma_out_prepare_mapped()")
Signed-off-by: Christoph Hellwig <hch@lst.de>
---

Changes since v1:
 - improve the commit log

 drivers/mailbox/omap-mailbox.c | 1 +
 include/linux/kfifo.h          | 1 -
 samples/kfifo/dma-example.c    | 1 +
 3 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mailbox/omap-mailbox.c b/drivers/mailbox/omap-mailbox.c
index 6797770474a5..680243751d62 100644
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
index 564868bdce89..fd743d4c4b4b 100644
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
index 48df719dac8c..8076ac410161 100644
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


