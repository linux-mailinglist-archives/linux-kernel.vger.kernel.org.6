Return-Path: <linux-kernel+bounces-407143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 480C09C695C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 07:35:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 074FD2837EC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 06:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C8FB186287;
	Wed, 13 Nov 2024 06:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZxHkiJxJ"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D52D17DFFC;
	Wed, 13 Nov 2024 06:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731479674; cv=none; b=lRXSBZBkaUX0r3smDdo2sxkYj54pIvTNvFwPiG3Ko/npuHpPgDkay9La5iZAnJYPCJG+D9nc6aIMhhuShB3Y2+px42J+BZkOblT75OaL90wwqdW2LaLgcQ4/1CPb1+orPRxiatnb1e9GpV6CEnYnF1e+CxnUZ7oKkMPLwl4sVHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731479674; c=relaxed/simple;
	bh=u6USrT5QHkktxnpZO9F2eXwOMPdhcCXOiK3Kq3oRn1k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=q15SDB5ESIo4VXFVswi/vUpwgbPs4Hcwg8PdXKESx29eo95H1vzT9+X0QraStc/a2ahaQ65kC7IFgUQto4+QhqTqEATII09k6zboh7tviN3BFbxqWeWVxpdEBmXOHOYY46E5UsKWjLav+KPPNGVO9Rp2zLm/lipZc9CJbaFLKN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZxHkiJxJ; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-720d5ada03cso6583648b3a.1;
        Tue, 12 Nov 2024 22:34:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731479673; x=1732084473; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mhwi6lR5jSeMorI1q9+9/fyDjvgvyzKkd/GXuwiJiG4=;
        b=ZxHkiJxJINmd5x4+JEd07BigFFIrOE9jPKM3GVgUtSFvNE/2kAf3+xRvAx/RLBwUUe
         M2Hp8XZ8au7KHzI57j5Mp+vwmUjETgjfgIEv1+P+D+fnDnd5nQEKq1w7+68femPYRwZV
         Xyqc+RW2rR7Ces2PUGAu85gd3q4JFHNYxz2M7biLVknOkAwUipTyyyvhdkpskEm7HDnL
         PmNXDoJl8yKz+ZnOQWay660PqYFaaGw5sgQdAxEdD06Eb1PDXXRVUJKw9IjLO2swe7ja
         OHKT2mMXFdR3aZBD6G5FJwYBm3tl1gLW9ar5lb4c9y03IhndzX1uuDshbKLD+8JUFrxv
         KPkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731479673; x=1732084473;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mhwi6lR5jSeMorI1q9+9/fyDjvgvyzKkd/GXuwiJiG4=;
        b=j5knhKg5OV4XPHUGrugpTrhjBU6gbPQxveghNqPSLh3bVaAjn6GrnkAUx5v7mf2Ut7
         NMo2t2ZjUOW9EV4fdofcGqXzrqs6exr8gx3TFgqmroVW7+Cdn3QXQq2iNQxK8LRbYke+
         AHy7E0koCZ59KLJcclj22w5THwiVVG6Gh3mzIdazkp6yJiDMvIuynCAe95b2OHtvub78
         clEv+Rku64Kq6yE3QcjvU37Mp2ghuobHYAh7chpbFxbIwLIf2X08De2AXrFa5BgVysz3
         ZSrmokikjZ4b1C5Xc33iqCbtHiPjPAE9aA76Nf2zLPq+96MMLJwAPZCxLf737hXHmoML
         pT/w==
X-Forwarded-Encrypted: i=1; AJvYcCWRjPzcj8M2W1A7F769GX5xaJAzHVadd0ul3DZvvJTGW+ATAhfadyUCTBV/Anp0TEcobKEkBapz9JvK853s@vger.kernel.org, AJvYcCWTiZmR4GxtRpaKWi5EcyKMbElOW8dUv0+d9/UxKkVDUyUTinetQhn8hkowNX2i/kwttHwVUTgieFU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyucYKJHL5+9sZSxqDbdqUrpzG6w4ZcAr+iRkLtvDZIGpySBCQ
	xlgzEBrQAVnGqLoXxxFr9YQ1mI+2VAEIYrtx5GV8a6bnu0dIquGY
X-Google-Smtp-Source: AGHT+IFL6fOAF6QgANLZskZQw5gNajXV1ayjOAmlkn6RqV6YD9hZshkwFtAhkaV8MsatlC6dChbvcQ==
X-Received: by 2002:a05:6a00:b86:b0:71e:60fc:ad11 with SMTP id d2e1a72fcca58-72457a2a33fmr2225412b3a.16.1731479672734;
        Tue, 12 Nov 2024 22:34:32 -0800 (PST)
Received: from localhost.localdomain ([2600:1700:3bdc:8c10:a:e04f:e712:3f95])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72458bab30asm747572b3a.190.2024.11.12.22.34.31
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 12 Nov 2024 22:34:31 -0800 (PST)
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
Subject: [RFC PATCH 2/2] dmapool: Documentation: use the kernel-doc comment
Date: Tue, 12 Nov 2024 22:34:25 -0800
Message-Id: <20241113063425.21042-3-yesanishhere@gmail.com>
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

In an effort to modernize the documentation for
dma api, move the api explanation to kernel-doc comment
in the source code and use the kernel-doc here in
the documentation.

Signed-off-by: anish kumar <yesanishhere@gmail.com>
---
 Documentation/core-api/dma-api.rst | 66 ++++++------------------------
 1 file changed, 12 insertions(+), 54 deletions(-)

diff --git a/Documentation/core-api/dma-api.rst b/Documentation/core-api/dma-api.rst
index 8e3cce3d0a23..8e89f328ba54 100644
--- a/Documentation/core-api/dma-api.rst
+++ b/Documentation/core-api/dma-api.rst
@@ -86,65 +86,23 @@ not __get_free_pages().  Also, they understand common hardware constraints
 for alignment, like queue heads needing to be aligned on N-byte boundaries.
 
 
-::
-
-	struct dma_pool *
-	dma_pool_create(const char *name, struct device *dev,
-			size_t size, size_t align, size_t alloc);
-
-dma_pool_create() initializes a pool of DMA-coherent buffers
-for use with a given device.  It must be called in a context which
-can sleep.
-
-The "name" is for diagnostics (like a struct kmem_cache name); dev and size
-are like what you'd pass to dma_alloc_coherent().  The device's hardware
-alignment requirement for this type of data is "align" (which is expressed
-in bytes, and must be a power of two).  If your device has no boundary
-crossing restrictions, pass 0 for alloc; passing 4096 says memory allocated
-from this pool must not cross 4KByte boundaries.
-
-::
-
-	void *
-	dma_pool_zalloc(struct dma_pool *pool, gfp_t mem_flags,
-		        dma_addr_t *handle)
-
-Wraps dma_pool_alloc() and also zeroes the returned memory if the
-allocation attempt succeeded.
-
+.. kernel-doc:: mm/dmapool.c
+    :identifiers: dma_pool_create
 
-::
-
-	void *
-	dma_pool_alloc(struct dma_pool *pool, gfp_t gfp_flags,
-		       dma_addr_t *dma_handle);
-
-This allocates memory from the pool; the returned memory will meet the
-size and alignment requirements specified at creation time.  Pass
-GFP_ATOMIC to prevent blocking, or if it's permitted (not
-in_interrupt, not holding SMP locks), pass GFP_KERNEL to allow
-blocking.  Like dma_alloc_coherent(), this returns two values:  an
-address usable by the CPU, and the DMA address usable by the pool's
-device.
-
-::
+.. kernel-doc:: mm/dmapool.c
+    :identifiers: dma_pool_alloc
 
-	void
-	dma_pool_free(struct dma_pool *pool, void *vaddr,
-		      dma_addr_t addr);
+dma_pool_zalloc wraps dma_pool_alloc() and also zeroes the returned memory
+if the allocation attempt succeeded.
 
-This puts memory back into the pool.  The pool is what was passed to
-dma_pool_alloc(); the CPU (vaddr) and DMA addresses are what
-were returned when that routine allocated the memory being freed.
+.. kernel-doc:: mm/dmapool.c
+    :identifiers: dma_pool_create
 
-::
-
-	void
-	dma_pool_destroy(struct dma_pool *pool);
+.. kernel-doc:: mm/dmapool.c
+    :identifiers: dma_pool_free
 
-dma_pool_destroy() frees the resources of the pool.  It must be
-called in a context which can sleep.  Make sure you've freed all allocated
-memory back to the pool before you destroy it.
+.. kernel-doc:: mm/dmapool.c
+    :identifiers: dma_pool_destroy
 
 
 Part Ic - DMA addressing limitations
-- 
2.39.5 (Apple Git-154)


