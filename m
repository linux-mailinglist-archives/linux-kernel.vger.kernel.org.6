Return-Path: <linux-kernel+bounces-407142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A198F9C695A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 07:34:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 321D51F238CB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 06:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD15018133F;
	Wed, 13 Nov 2024 06:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b8XT0P+k"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D551176AB6;
	Wed, 13 Nov 2024 06:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731479673; cv=none; b=jQF9EkXaOU8EKWVJSnCtug37MvMsgSBqlGXcKegnlQQbeKJRHYlu4D+eWogfW7S/okRafiCMPYaijuYDavqDBMkgo9HNOiN7JCSJ0iz2krhx2otKIGu/mtXbUGKjyXVtPAqr9xaPgThuNSNCgFc4RcPBaTlNEjRpKiQiME5A/hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731479673; c=relaxed/simple;
	bh=DI/iIvB4rwyLB2a5O39A/ozr7x++k2RqeWLIVVwWYds=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=G836Dbjpz1i+weucUMDSayAIwita1GgrIzBf7GGQmzU8Uu42akVmdYEBMTXD6beXSnFXvB41c+1O/ouA/FeL4/A2ggDNru45GVf9hFuZcZ6oGq+1dIqpaQWGlrRLv6wAgFzXMtn67N+6NkbZaUoU+N5vFwAw7IZ3UvGtsfEimJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b8XT0P+k; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7205b6f51f3so5339153b3a.1;
        Tue, 12 Nov 2024 22:34:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731479671; x=1732084471; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3mOVTHykOcvikJTDU2tzo0bBXcz8e9l/HyWBKYXvXrc=;
        b=b8XT0P+kJvHzOseuGjzsSwPRpl8HQJEjBO9Hs6mcEJyQf5hwvisdVPyRSXT/g1yCPS
         urjFt0AIxPKJzjo4C+tPxcAE8EDTWxWITqFZxYEPYttJBGPpEEbW6K6vyzUexd+hZnnK
         szEDWnT/kwjp62FUgJ78Z04eRiuN9v9pyNwkU3d7ouHqjMVfYWbQI1pGn+EPecvGhuly
         4Khump3sqdgCCy1YHOvaDCnf45D2FyY6Y5Geo6cGsmGgTZ7sWP8zwHYK00GD/cuFrTkC
         tKDpz8kfFSgLC4xma/vdin3YOd34eZ2e5YkKtqa+nkTOvY+PkTMQLNtQtp+Tj7KgLy/a
         3C0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731479671; x=1732084471;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3mOVTHykOcvikJTDU2tzo0bBXcz8e9l/HyWBKYXvXrc=;
        b=rSedhJTjI1/MgYnvjm3DbFMdCQyDaB4ZrMxuB2uXvLg3tqbXVHuu4ErhyZLAcvAJ6b
         Zs/JWpmhJlhAmzup1vEq/C10llk8QwWPpG5sbDKiYdPoqdRre/1j8Xo8ywPZG3Dk/v0X
         lzEZnIv+HHJGYuaSqrmwOJFryx/AQxslnATFR6P48oS9BNnJB89idYKTX1lsfrEmsLvC
         UqZNtZRvo/Hb9AG3MEwT/2aSZdzCDZPMUNqQMKnDoOp/PLm1/2L3USv4Cq6D6ftvEAmN
         hs06gF7G7Q8tw+EPptRkYXBCUzn9MqCSOGn37Ej7+r0gDnkcdRGkxfr6G8SNu8UXQEGk
         tQvA==
X-Forwarded-Encrypted: i=1; AJvYcCVCQx8/rAMBYztTMHR+gmey0TniIviktHbXR+xU/86PAhjD7EpW6SvDSVSjbyFX/XO7GoatLP7b/6s=@vger.kernel.org, AJvYcCXuuBOoHMLlL/+lhgLwM9gHm3Ev4OSbsfwHVpLEBZUvnhQIIJBF/bo9DhKJhVpSbipDPrCq/yK5ZO25OaCA@vger.kernel.org
X-Gm-Message-State: AOJu0Yz95CGiWD0BJX8h4ltV7a0rYh6IZP0S3dQKHyaL/ENoapX7Yeh0
	AKuhWBNhf4ec6kpXfDwJOQi+pO0+UIJzhkeK7uXDRirOog2eqf3qh/K9yqLKa50=
X-Google-Smtp-Source: AGHT+IGo6AnEUeeQERM8eGIbcsc4sk0h9fnmY1pHTDcq32vu2oL2fudCT+Ti39A9/93PNahND16a+A==
X-Received: by 2002:a05:6a00:3a14:b0:70d:2a88:a483 with SMTP id d2e1a72fcca58-7241313d95emr27792105b3a.0.1731479670861;
        Tue, 12 Nov 2024 22:34:30 -0800 (PST)
Received: from localhost.localdomain ([2600:1700:3bdc:8c10:a:e04f:e712:3f95])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72458bab30asm747572b3a.190.2024.11.12.22.34.29
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 12 Nov 2024 22:34:30 -0800 (PST)
From: anish kumar <yesanishhere@gmail.com>
To: corbet@lwn.net,
	tj@kernel.org,
	akpm@linux-foundation.org,
	ptesarik@suse.com,
	xavier_qy@163.com,
	vbabka@suse.cz,
	tintinm2017@gmail.com
Cc: linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	anish kumar <yesanishhere@gmail.com>
Subject: [RFC PATCH 1/2] dmapool: Improve dma api kernel-doc comments
Date: Tue, 12 Nov 2024 22:34:24 -0800
Message-Id: <20241113063425.21042-2-yesanishhere@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241113063425.21042-1-yesanishhere@gmail.com>
References: <20241113063425.21042-1-yesanishhere@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move explanatory content from the documentation
to source code comment written in kernel-doc format.
This allows kernel-doc to generate more comprehensive
and accurate documentation. Additionally, improving
the kernel-doc comment describes the api behaviour
and usage better.

Signed-off-by: anish kumar <yesanishhere@gmail.com>
---
 mm/dmapool.c | 40 ++++++++++++++++++++++++++++------------
 1 file changed, 28 insertions(+), 12 deletions(-)

diff --git a/mm/dmapool.c b/mm/dmapool.c
index f0bfc6c490f4..8b32a52becd6 100644
--- a/mm/dmapool.c
+++ b/mm/dmapool.c
@@ -207,11 +207,16 @@ static void pool_block_push(struct dma_pool *pool, struct dma_block *block,
  * @boundary: returned blocks won't cross this power of two boundary
  * Context: not in_interrupt()
  *
- * Given one of these pools, dma_pool_alloc()
- * may be used to allocate memory.  Such memory will all have "consistent"
- * DMA mappings, accessible by the device and its driver without using
- * cache flushing primitives.  The actual size of blocks allocated may be
- * larger than requested because of alignment.
+ * This api initializes a pool of DMA-coherent buffers for use with a given
+ * device. It must be called in a context which can sleep. The device's
+ * hardware alignment requirement for this type of data is "align". If your
+ * device has no boundary crossing restrictions, pass 0 for alloc; passing
+ * 4096 says memory allocated from this pool must not cross 4KByte boundaries.
+ *
+ * Given one of these pools, dma_pool_alloc() may be used to allocate memory.
+ * Such memory will all have "consistent" DMA mappings, accessible by the
+ * device and its driver without using cache flushing primitives.  The actual
+ * size of blocks allocated may be larger than requested because of alignment.
  *
  * If @boundary is nonzero, objects returned from dma_pool_alloc() won't
  * cross that size boundary.  This is useful for devices which have
@@ -356,6 +361,7 @@ static struct dma_page *pool_alloc_page(struct dma_pool *pool, gfp_t mem_flags)
  *
  * Caller guarantees that no more memory from the pool is in use,
  * and that nothing will try to use the pool after this call.
+ * It must be called in a context which can sleep.
  */
 void dma_pool_destroy(struct dma_pool *pool)
 {
@@ -392,14 +398,24 @@ void dma_pool_destroy(struct dma_pool *pool)
 EXPORT_SYMBOL(dma_pool_destroy);
 
 /**
- * dma_pool_alloc - get a block of consistent memory
- * @pool: dma pool that will produce the block
- * @mem_flags: GFP_* bitmask
- * @handle: pointer to dma address of block
+ * dma_pool_alloc - Get a block of consistent memory from a DMA pool
+ * @pool:       DMA pool that will produce the block
+ * @mem_flags:  GFP_* bitmask specifying memory allocation flags
+ * @handle:     Pointer to a DMA address that will hold the address of the block
+ *
+ * Return: The kernel virtual address of a currently unused block of memory,
+ *         and reports its DMA address through the handle. If such a memory
+ *         block can't be allocated, %NULL is returned.
+ *
+ * This function allocates memory from the specified DMA pool. The returned
+ * memory will meet the size and alignment requirements specified when the
+ * pool was created. Pass GFP_ATOMIC to prevent blocking, or if permitted
+ * (not in interrupt context, and not holding SMP locks), pass GFP_KERNEL
+ * to allow blocking.
  *
- * Return: the kernel virtual address of a currently unused block,
- * and reports its dma address through the handle.
- * If such a memory block can't be allocated, %NULL is returned.
+ * Similar to dma_alloc_coherent(), this function returns two addresses:
+ *  - A CPU-accessible virtual address
+ *  - A DMA address usable by the pool's associated device.
  */
 void *dma_pool_alloc(struct dma_pool *pool, gfp_t mem_flags,
 		     dma_addr_t *handle)
-- 
2.39.5 (Apple Git-154)


