Return-Path: <linux-kernel+bounces-368621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10B9F9A1275
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 21:25:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4DADAB23A65
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 19:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BFED215F4D;
	Wed, 16 Oct 2024 19:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="amaHU/tY"
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4312141CB
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 19:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729106716; cv=none; b=RAHz2/6M2x9Wj6h1KncYmUh7ZEXNB6F/nWDaLTbzkAcjkNA7bH/p+dInPB2a5CfBmjJ4HOE8mO36M2vySByr0mN+wMEJZFYedTUEg8TiAzaPufA8YmJASs5/8wZRwtsQ7gOf8rdmjEf/ErPSKJnPCb9jn2ziB0bIoEoUDfJDYlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729106716; c=relaxed/simple;
	bh=rLKKQNdoNnZ4UTvW+UG2w5DmYKje0EiIGyVUNfkrTC0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FhQqHzy3pH8n8wQZDHEt3WqjOh30yxbDg1p8dNNF+0LbtpjeV5E4hXL1+QYQAY/z5bWESaDpEzNjXha98+5M0fcZza1vx9eTwq3vNb1H6eSE38cJY7LNMUa/7vzth1nUmDnJ4LembBb06Lt5/1fi3i+StJxrLXdLsTkAKkkpuoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=amaHU/tY; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7157d323709so77813a34.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 12:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1729106714; x=1729711514; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dBo6zWcPK+3VP3Pj2DhU6SEkNl/D37D0T08p/JVF3UI=;
        b=amaHU/tYMXX9U1kUDE4602xt0R7oOruijN+vo+7JqTIwYppyFOtikAhA/x45uUQccG
         EvfrdlHwm5MKCN/2C/UubmcUEPK/Y/uWDk1bjK3B3Qb27djHrspS7h/xUENj6st8EMw9
         viaYgyAif1a0LenO2Qnb6AvDphx/NbVDNcNg0bfVHGYCiHBLqZEVUghH+cm6BZlze5vy
         9wr4YJwjd9Acfxmj9aantRadPqF8BpVvXRRHCppwopDAEdsqjxE9Hl5tTsYvgSZanmxL
         cnORH5p0+2tr5X0fj+Mq5uNJuAVTsa1Cs6dXIYqo4kpK0cNxu7jxSjRsLz/1i+SOXVGt
         4JmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729106714; x=1729711514;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dBo6zWcPK+3VP3Pj2DhU6SEkNl/D37D0T08p/JVF3UI=;
        b=IvROdx1oyrN4kjcYCMdNOBPvaYvWRYFeDgHoLgRQZyx+zqf7U/awOE4ZZVi02oN+VZ
         Oqujlb17k+46g90YtgBouWbXV2DDSnes01M2KZyiVbQh/hq4V4kQdgqLszqFlKmN9OZG
         0nEy3rQtCYKHX3nhe9ujHW5hjo1FRtgXP0BqvXZlrUuRO7UYD1zRBWgw1H4a8TBRyAbA
         8WKJ2GsjJpSmRtTCWVuI/48ifvAXJfIiUy5RmqukfqEd824GlDCKNv/vetqG93SBSeDR
         oDfNLCqGelgu/yK6hXcG1ghZwKS/IW6WQGlRpM5a+2jwyjWcw6hLpuu4RGbvjeoi+q9X
         IaNg==
X-Forwarded-Encrypted: i=1; AJvYcCVoF9XhoMgOimYRqNj0QFTMcnmo5qTk9wqcKk6CxOR51w/jRC8MWz6xu+UDtFafrbjdHkXCwpSmca/EtLk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2GRQaLcyIbV7k16hpZJiQChnyI4LIFCbkxaRitw6JvKgWcogZ
	jN5mVXj+yM40nkaNVF4bL+Hm7Cv+Ugcdhe2+PhTepkU38O9Ucps6uz0AgcSp2hA=
X-Google-Smtp-Source: AGHT+IHgEaZY8iMsb9K6bD0HeyumMxOtRYAvr41KKGuerxwMHdKgbYwRirurzLA7V5zk8rmjifacXA==
X-Received: by 2002:a05:6358:618a:b0:1b8:688e:6ea3 with SMTP id e5c5f4694b2df-1c3784dedc0mr449907255d.18.1729106714352;
        Wed, 16 Oct 2024 12:25:14 -0700 (PDT)
Received: from PC2K9PVX.TheFacebook.com (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4607b38ce69sm20271651cf.90.2024.10.16.12.25.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 12:25:14 -0700 (PDT)
From: Gregory Price <gourry@gourry.net>
To: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-mm@kvack.org
Cc: dan.j.williams@intel.com,
	ira.weiny@intel.com,
	david@redhat.com,
	dave.hansen@linux.intel.com,
	luto@kernel.org,
	peterz@infradead.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	hpa@zytor.com,
	rafael@kernel.org,
	lenb@kernel.org,
	rppt@kernel.org,
	akpm@linux-foundation.org,
	alison.schofield@intel.com,
	Jonathan.Cameron@huawei.com,
	rrichter@amd.com,
	ytcoode@gmail.com,
	haibo1.xu@intel.com,
	dave.jiang@intel.com
Subject: [PATCH v2 1/3] mm/memblock: implement memblock_advise_size_order and probe functions
Date: Wed, 16 Oct 2024 15:24:43 -0400
Message-ID: <20241016192445.3118-2-gourry@gourry.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241016192445.3118-1-gourry@gourry.net>
References: <20241016192445.3118-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hotplug memory sources may have opinions on what the memblock size
should be - usually for alignment purposes.  For example, CXL memory
extents can be as small as 256MB with a matching physical alignment.

Implement memblock_advise_size_order for use during early init, prior
to allocator and smp init, for software to advise the system as to what
the preferred block size should be.

The probe function is meant for arch_init code to fetch this value
once during memblock size calculation. Use of the advisement value
is arch-specific, and no guarantee is made that it will be used.

Calls to either function after probe results in -EBUSY to signal that
advisement is ignored or that memblock_get_size_bytes should be used.

Suggested-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Gregory Price <gourry@gourry.net>
---
 include/linux/memblock.h |  2 ++
 mm/memblock.c            | 49 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 51 insertions(+)

diff --git a/include/linux/memblock.h b/include/linux/memblock.h
index fc4d75c6cec3..efb1f7cfbd58 100644
--- a/include/linux/memblock.h
+++ b/include/linux/memblock.h
@@ -111,6 +111,8 @@ static inline void memblock_discard(void) {}
 #endif
 
 void memblock_allow_resize(void);
+int memblock_advise_size_order(int order);
+int memblock_probe_size_order(void);
 int memblock_add_node(phys_addr_t base, phys_addr_t size, int nid,
 		      enum memblock_flags flags);
 int memblock_add(phys_addr_t base, phys_addr_t size);
diff --git a/mm/memblock.c b/mm/memblock.c
index 3b9dc2d89b8a..e0bdba011564 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -2009,6 +2009,55 @@ void __init memblock_allow_resize(void)
 	memblock_can_resize = 1;
 }
 
+/*
+ * @order: bit-order describing the preferred minimum block size
+ *
+ * Intended for use by early-boot software prior to smp and allocator init to
+ * advise the architecture what the minimum block size should be. Should only
+ * be called during arch init before allocator and smp init.
+ *
+ * This value can only decrease after it has been initially set, the intention
+ * is to identify the smallest supported alignment across all opinions.
+ *
+ * Use of this advisement value is arch-specific.
+ *
+ * Returns: 0 on success, -EINVAL if order is <=0, and -EBUSY if already probed
+ */
+static int memblock_sz_order;
+#define MEMBLOCK_SZO_PROBED (-1)
+int memblock_advise_size_order(int order)
+{
+	if (order <= 0)
+		return -EINVAL;
+
+	if (memblock_sz_order == MEMBLOCK_SZO_PROBED)
+		return -EBUSY;
+
+	if (memblock_sz_order)
+		memblock_sz_order = min(order, memblock_sz_order);
+	else
+		memblock_sz_order = order;
+
+	return 0;
+}
+
+/*
+ * memblock_probe_size_order is intended for arch init code to probe one time,
+ * for a suggested memory block size.  After the first call, the result will
+ * always be -EBUSY. A late user should call memory_block_size_bytes instead to
+ * determine the actual block size in use.
+ *
+ * Should only be called during arch init prior to allocator and smp init.
+ *
+ * Returns: block size order, 0 if never set, or -EBUSY if previously probed.
+ */
+int memblock_probe_size_order(void)
+{
+	int rv = xchg(&memblock_sz_order, -1);
+
+	return (rv == -1) ? -EBUSY : rv;
+}
+
 static int __init early_memblock(char *p)
 {
 	if (p && strstr(p, "debug"))
-- 
2.43.0


