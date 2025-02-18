Return-Path: <linux-kernel+bounces-520046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F243A3A51A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 19:17:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60FD318910D1
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 18:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0943027292A;
	Tue, 18 Feb 2025 18:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZT10D1ik"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C586B271289
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 18:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739902634; cv=none; b=h2N53LyLAWT9pZSzTO1YBuUqP4P/EUVX4zv81pd/8kdBjPIMlewcBjWNBHkp6RHO35LdBxXCmdQMTFDZG6EV0lgD1DFb9b/zmKFJSfGC6R8HGqXJimXjYJY9AsYe6sysZP5YKJ3ll4nrcojn5peS8XP6LG6wK10N41+DYVFrjP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739902634; c=relaxed/simple;
	bh=7QCKvHatqASxyFcMrO3kKSxrzfRv5Kcl97se1/aixNE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HArKd8UxjYjsbr8BdC+OmRIgKD/bt0BnaRHP9vnkEiOjz5MJhXd5Lk7NiXTpzTmpFLoZv0w3jcAKy/04oUVNUlDjdRVqJL/r8izxvhA5lnwf2x0YaI6GhvYVTbjZSfgRjTKkHI5k91ap9jhRJ86DjHH1FWIK74nc5kXGI08vLcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--fvdl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZT10D1ik; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--fvdl.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2fc2fee4425so13708395a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 10:17:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739902630; x=1740507430; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4zNW6laAXeBJ4XvKs0ISVQpTV4GK6Euoa4r/dFwlt3c=;
        b=ZT10D1ik4B3gCv2E8UPGKGb/Ue5emd8h2Wu3FvK0oxmTF9yoOsZqr3VUPu7Kcokdyp
         7juFDkI/VYjDBUV3ZOEUNJkpuKRJuBg8qOX5NThQi9uJ280TsIXQxmNmTT2Ip5NicsuB
         XNErPhd66xaN3fB9k1zXUW/aTxYPO2k6rb8UJLwVS6O3qRrbnfY4yQe6n9CRVJ1QJZC1
         aVKttrv/CD41QBSx67ATmRpalcOUYArIbkf8vsX8vA/9HtBWEwkOsybs8Bnz2xsKdsPC
         fuwJ6nvya0Gc3H4FO5/aWu1NwlwUoYlt4ydqinEMpto1NhSAjZSxYbGpGBWdvMp8PdUj
         9hJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739902630; x=1740507430;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4zNW6laAXeBJ4XvKs0ISVQpTV4GK6Euoa4r/dFwlt3c=;
        b=CROUGixZkq700URD/AR5pD7hoy9LS7dKzOD+wKY6xh44IDfy67ltG/73ZFiukBPSAW
         TldBRphm5hsieNp3yd9oFjRcpvPAFm55OsKOtsDvL5fo4xRXAtNGFKia/MD3pO/PV0CZ
         FJvQg+opP87rRoCQzv/nLpJiICybgoYlPqIMp1FXSjTyB1d7gNfN3Qal4Dfo6aAc+S0B
         f3W1fsw5756rm/smBI7evNdTNoji5SB2tfK2EX76uVmqHb1U/diuxNJPRucHkWOPjKEY
         yNze+dFNxXeLomhL27f91DCnBTELi82kwCQyMxl+IqcPZItJYOc5zhKY899JjDYPetxo
         mvGA==
X-Forwarded-Encrypted: i=1; AJvYcCWfYHetn3SSrGdUZgc/DhfX+5EDRRPf/qUZA5vL3WdcCpOpWJPgDti0lc5i9P/KV1Dif5hxw1IPprAehY4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKKpskJdVPMwgk6w6bBEmuwRnjghmku53rK7CFBtpIuyb6zto2
	6EKk973yr6qos1CoundXFQCvPNv4YQg9DGjHNGzBfB49Tt62oNxLahaUpOjVA3PujJmzcQ==
X-Google-Smtp-Source: AGHT+IFDz0E+0MOsaQwNMhq4mrumn6NDDTkI3VcULN43g1FJxnYlC5s+Qw3+dqWyOooQw8QQrK9M1/01
X-Received: from pfbf10.prod.google.com ([2002:a05:6a00:ad8a:b0:730:8970:1f9c])
 (user=fvdl job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2343:b0:732:623d:beee
 with SMTP id d2e1a72fcca58-7329de48488mr477117b3a.2.1739902629974; Tue, 18
 Feb 2025 10:17:09 -0800 (PST)
Date: Tue, 18 Feb 2025 18:16:30 +0000
In-Reply-To: <20250218181656.207178-1-fvdl@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250218181656.207178-1-fvdl@google.com>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <20250218181656.207178-3-fvdl@google.com>
Subject: [PATCH v4 02/27] mm, cma: support multiple contiguous ranges, if requested
From: Frank van der Linden <fvdl@google.com>
To: akpm@linux-foundation.org, muchun.song@linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Cc: yuzhao@google.com, usamaarif642@gmail.com, joao.m.martins@oracle.com, 
	roman.gushchin@linux.dev, Frank van der Linden <fvdl@google.com>
Content-Type: text/plain; charset="UTF-8"

Currently, CMA manages one range of physically contiguous memory.
Creation of larger CMA areas with hugetlb_cma may run in to gaps
in physical memory, so that they are not able to allocate that
contiguous physical range from memblock when creating the CMA
area.

This can happen, for example, on an AMD system with > 1TB of memory,
where there will be a gap just below the 1TB (40bit DMA) line. If
you have set aside most of memory for potential hugetlb CMA allocation,
cma_declare_contiguous_nid will fail.

hugetlb_cma doesn't need the entire area to be one physically
contiguous range. It just cares about being able to get physically
contiguous chunks of a certain size (e.g. 1G), and it is fine
to have the CMA area backed by multiple physical ranges, as
long as it gets 1G contiguous allocations.

Multi-range support is implemented by introducing an array of
ranges, instead of just one big one. Each range has its own bitmap.
Effectively, the allocate and release operations work as before,
just per-range. So, instead of going through one large bitmap, they
now go through a number of smaller ones.

The maximum number of supported ranges is 8, as defined in
CMA_MAX_RANGES.

Since some current users of CMA expect a CMA area to just use one
physically contiguous range, only allow for multiple ranges if a
new interface, cma_declare_contiguous_nid_multi, is used. The other
interfaces will work like before, creating only CMA areas with
1 range.

cma_declare_contiguous_nid_multi works as follows, mimicking the
default "bottom-up, above 4G" reservation approach:

0) Try cma_declare_contiguous_nid, which will use only one
   region. If this succeeds, return. This makes sure that for
   all the cases that currently work, the behavior remains
   unchanged even if the caller switches from
   cma_declare_contiguous_nid to cma_declare_contiguous_nid_multi.
1) Select the largest free memblock ranges above 4G, with
   a maximum number of CMA_MAX_RANGES.
2) If we did not find at most CMA_MAX_RANGES that add
   up to the total size requested, return -ENOMEM.
3) Sort the selected ranges by base address.
4) Reserve them bottom-up until we get what we wanted.

Signed-off-by: Frank van der Linden <fvdl@google.com>
---
 Documentation/admin-guide/mm/cma_debugfs.rst |  10 +-
 include/linux/cma.h                          |   3 +
 mm/cma.c                                     | 594 +++++++++++++++----
 mm/cma.h                                     |  27 +-
 mm/cma_debug.c                               |  56 +-
 5 files changed, 550 insertions(+), 140 deletions(-)

diff --git a/Documentation/admin-guide/mm/cma_debugfs.rst b/Documentation/admin-guide/mm/cma_debugfs.rst
index 7367e6294ef6..4120e9cb0cd5 100644
--- a/Documentation/admin-guide/mm/cma_debugfs.rst
+++ b/Documentation/admin-guide/mm/cma_debugfs.rst
@@ -12,10 +12,16 @@ its CMA name like below:
 
 The structure of the files created under that directory is as follows:
 
- - [RO] base_pfn: The base PFN (Page Frame Number) of the zone.
+ - [RO] base_pfn: The base PFN (Page Frame Number) of the CMA area.
+        This is the same as ranges/0/base_pfn.
  - [RO] count: Amount of memory in the CMA area.
  - [RO] order_per_bit: Order of pages represented by one bit.
- - [RO] bitmap: The bitmap of page states in the zone.
+ - [RO] bitmap: The bitmap of allocated pages in the area.
+        This is the same as ranges/0/base_pfn.
+ - [RO] ranges/N/base_pfn: The base PFN of contiguous range N
+        in the CMA area.
+ - [RO] ranges/N/bitmap: The bit map of allocated pages in
+        range N in the CMA area.
  - [WO] alloc: Allocate N pages from that CMA area. For example::
 
 	echo 5 > <debugfs>/cma/<cma_name>/alloc
diff --git a/include/linux/cma.h b/include/linux/cma.h
index d15b64f51336..863427c27dc2 100644
--- a/include/linux/cma.h
+++ b/include/linux/cma.h
@@ -40,6 +40,9 @@ static inline int __init cma_declare_contiguous(phys_addr_t base,
 	return cma_declare_contiguous_nid(base, size, limit, alignment,
 			order_per_bit, fixed, name, res_cma, NUMA_NO_NODE);
 }
+extern int __init cma_declare_contiguous_multi(phys_addr_t size,
+			phys_addr_t align, unsigned int order_per_bit,
+			const char *name, struct cma **res_cma, int nid);
 extern int cma_init_reserved_mem(phys_addr_t base, phys_addr_t size,
 					unsigned int order_per_bit,
 					const char *name,
diff --git a/mm/cma.c b/mm/cma.c
index 95a8788e54d3..6ac9173d3a7d 100644
--- a/mm/cma.c
+++ b/mm/cma.c
@@ -18,6 +18,7 @@
 
 #include <linux/memblock.h>
 #include <linux/err.h>
+#include <linux/list.h>
 #include <linux/mm.h>
 #include <linux/sizes.h>
 #include <linux/slab.h>
@@ -35,9 +36,16 @@ struct cma cma_areas[MAX_CMA_AREAS];
 unsigned int cma_area_count;
 static DEFINE_MUTEX(cma_mutex);
 
+static int __init __cma_declare_contiguous_nid(phys_addr_t base,
+			phys_addr_t size, phys_addr_t limit,
+			phys_addr_t alignment, unsigned int order_per_bit,
+			bool fixed, const char *name, struct cma **res_cma,
+			int nid);
+
 phys_addr_t cma_get_base(const struct cma *cma)
 {
-	return PFN_PHYS(cma->base_pfn);
+	WARN_ON_ONCE(cma->nranges != 1);
+	return PFN_PHYS(cma->ranges[0].base_pfn);
 }
 
 unsigned long cma_get_size(const struct cma *cma)
@@ -63,9 +71,10 @@ static unsigned long cma_bitmap_aligned_mask(const struct cma *cma,
  * The value returned is represented in order_per_bits.
  */
 static unsigned long cma_bitmap_aligned_offset(const struct cma *cma,
+					       const struct cma_memrange *cmr,
 					       unsigned int align_order)
 {
-	return (cma->base_pfn & ((1UL << align_order) - 1))
+	return (cmr->base_pfn & ((1UL << align_order) - 1))
 		>> cma->order_per_bit;
 }
 
@@ -75,46 +84,57 @@ static unsigned long cma_bitmap_pages_to_bits(const struct cma *cma,
 	return ALIGN(pages, 1UL << cma->order_per_bit) >> cma->order_per_bit;
 }
 
-static void cma_clear_bitmap(struct cma *cma, unsigned long pfn,
-			     unsigned long count)
+static void cma_clear_bitmap(struct cma *cma, const struct cma_memrange *cmr,
+			     unsigned long pfn, unsigned long count)
 {
 	unsigned long bitmap_no, bitmap_count;
 	unsigned long flags;
 
-	bitmap_no = (pfn - cma->base_pfn) >> cma->order_per_bit;
+	bitmap_no = (pfn - cmr->base_pfn) >> cma->order_per_bit;
 	bitmap_count = cma_bitmap_pages_to_bits(cma, count);
 
 	spin_lock_irqsave(&cma->lock, flags);
-	bitmap_clear(cma->bitmap, bitmap_no, bitmap_count);
+	bitmap_clear(cmr->bitmap, bitmap_no, bitmap_count);
 	cma->available_count += count;
 	spin_unlock_irqrestore(&cma->lock, flags);
 }
 
 static void __init cma_activate_area(struct cma *cma)
 {
-	unsigned long base_pfn = cma->base_pfn, pfn;
+	unsigned long pfn, base_pfn;
+	int allocrange, r;
 	struct zone *zone;
+	struct cma_memrange *cmr;
+
+	for (allocrange = 0; allocrange < cma->nranges; allocrange++) {
+		cmr = &cma->ranges[allocrange];
+		cmr->bitmap = bitmap_zalloc(cma_bitmap_maxno(cma, cmr),
+					    GFP_KERNEL);
+		if (!cmr->bitmap)
+			goto cleanup;
+	}
 
-	cma->bitmap = bitmap_zalloc(cma_bitmap_maxno(cma), GFP_KERNEL);
-	if (!cma->bitmap)
-		goto out_error;
+	for (r = 0; r < cma->nranges; r++) {
+		cmr = &cma->ranges[r];
+		base_pfn = cmr->base_pfn;
 
-	/*
-	 * alloc_contig_range() requires the pfn range specified to be in the
-	 * same zone. Simplify by forcing the entire CMA resv range to be in the
-	 * same zone.
-	 */
-	WARN_ON_ONCE(!pfn_valid(base_pfn));
-	zone = page_zone(pfn_to_page(base_pfn));
-	for (pfn = base_pfn + 1; pfn < base_pfn + cma->count; pfn++) {
-		WARN_ON_ONCE(!pfn_valid(pfn));
-		if (page_zone(pfn_to_page(pfn)) != zone)
-			goto not_in_zone;
-	}
+		/*
+		 * alloc_contig_range() requires the pfn range specified
+		 * to be in the same zone. Simplify by forcing the entire
+		 * CMA resv range to be in the same zone.
+		 */
+		WARN_ON_ONCE(!pfn_valid(base_pfn));
+		zone = page_zone(pfn_to_page(base_pfn));
+		for (pfn = base_pfn + 1; pfn < base_pfn + cmr->count; pfn++) {
+			WARN_ON_ONCE(!pfn_valid(pfn));
+			if (page_zone(pfn_to_page(pfn)) != zone)
+				goto cleanup;
+		}
 
-	for (pfn = base_pfn; pfn < base_pfn + cma->count;
-	     pfn += pageblock_nr_pages)
-		init_cma_reserved_pageblock(pfn_to_page(pfn));
+		for (pfn = base_pfn; pfn < base_pfn + cmr->count;
+		     pfn += pageblock_nr_pages)
+			init_cma_reserved_pageblock(pfn_to_page(pfn));
+	}
 
 	spin_lock_init(&cma->lock);
 
@@ -125,13 +145,19 @@ static void __init cma_activate_area(struct cma *cma)
 
 	return;
 
-not_in_zone:
-	bitmap_free(cma->bitmap);
-out_error:
+cleanup:
+	for (r = 0; r < allocrange; r++)
+		bitmap_free(cma->ranges[r].bitmap);
+
 	/* Expose all pages to the buddy, they are useless for CMA. */
 	if (!cma->reserve_pages_on_error) {
-		for (pfn = base_pfn; pfn < base_pfn + cma->count; pfn++)
-			free_reserved_page(pfn_to_page(pfn));
+		for (r = 0; r < allocrange; r++) {
+			cmr = &cma->ranges[r];
+			for (pfn = cmr->base_pfn;
+			     pfn < cmr->base_pfn + cmr->count;
+			     pfn++)
+				free_reserved_page(pfn_to_page(pfn));
+		}
 	}
 	totalcma_pages -= cma->count;
 	cma->available_count = cma->count = 0;
@@ -154,6 +180,43 @@ void __init cma_reserve_pages_on_error(struct cma *cma)
 	cma->reserve_pages_on_error = true;
 }
 
+static int __init cma_new_area(const char *name, phys_addr_t size,
+			       unsigned int order_per_bit,
+			       struct cma **res_cma)
+{
+	struct cma *cma;
+
+	if (cma_area_count == ARRAY_SIZE(cma_areas)) {
+		pr_err("Not enough slots for CMA reserved regions!\n");
+		return -ENOSPC;
+	}
+
+	/*
+	 * Each reserved area must be initialised later, when more kernel
+	 * subsystems (like slab allocator) are available.
+	 */
+	cma = &cma_areas[cma_area_count];
+	cma_area_count++;
+
+	if (name)
+		snprintf(cma->name, CMA_MAX_NAME, name);
+	else
+		snprintf(cma->name, CMA_MAX_NAME,  "cma%d\n", cma_area_count);
+
+	cma->available_count = cma->count = size >> PAGE_SHIFT;
+	cma->order_per_bit = order_per_bit;
+	*res_cma = cma;
+	totalcma_pages += cma->count;
+
+	return 0;
+}
+
+static void __init cma_drop_area(struct cma *cma)
+{
+	totalcma_pages -= cma->count;
+	cma_area_count--;
+}
+
 /**
  * cma_init_reserved_mem() - create custom contiguous area from reserved memory
  * @base: Base address of the reserved area
@@ -172,13 +235,9 @@ int __init cma_init_reserved_mem(phys_addr_t base, phys_addr_t size,
 				 struct cma **res_cma)
 {
 	struct cma *cma;
+	int ret;
 
 	/* Sanity checks */
-	if (cma_area_count == ARRAY_SIZE(cma_areas)) {
-		pr_err("Not enough slots for CMA reserved regions!\n");
-		return -ENOSPC;
-	}
-
 	if (!size || !memblock_is_region_reserved(base, size))
 		return -EINVAL;
 
@@ -195,25 +254,261 @@ int __init cma_init_reserved_mem(phys_addr_t base, phys_addr_t size,
 	if (!IS_ALIGNED(base | size, CMA_MIN_ALIGNMENT_BYTES))
 		return -EINVAL;
 
+	ret = cma_new_area(name, size, order_per_bit, &cma);
+	if (ret != 0)
+		return ret;
+
+	cma->ranges[0].base_pfn = PFN_DOWN(base);
+	cma->ranges[0].count = cma->count;
+	cma->nranges = 1;
+
+	*res_cma = cma;
+
+	return 0;
+}
+
+/*
+ * Structure used while walking physical memory ranges and finding out
+ * which one(s) to use for a CMA area.
+ */
+struct cma_init_memrange {
+	phys_addr_t base;
+	phys_addr_t size;
+	struct list_head list;
+};
+
+/*
+ * Work array used during CMA initialization.
+ */
+static struct cma_init_memrange memranges[CMA_MAX_RANGES] __initdata;
+
+static bool __init revsizecmp(struct cma_init_memrange *mlp,
+			      struct cma_init_memrange *mrp)
+{
+	return mlp->size > mrp->size;
+}
+
+static bool __init basecmp(struct cma_init_memrange *mlp,
+			   struct cma_init_memrange *mrp)
+{
+	return mlp->base < mrp->base;
+}
+
+/*
+ * Helper function to create sorted lists.
+ */
+static void __init list_insert_sorted(
+	struct list_head *ranges,
+	struct cma_init_memrange *mrp,
+	bool (*cmp)(struct cma_init_memrange *lh, struct cma_init_memrange *rh))
+{
+	struct list_head *mp;
+	struct cma_init_memrange *mlp;
+
+	if (list_empty(ranges))
+		list_add(&mrp->list, ranges);
+	else {
+		list_for_each(mp, ranges) {
+			mlp = list_entry(mp, struct cma_init_memrange, list);
+			if (cmp(mlp, mrp))
+				break;
+		}
+		__list_add(&mrp->list, mlp->list.prev, &mlp->list);
+	}
+}
+
+/*
+ * Create CMA areas with a total size of @total_size. A normal allocation
+ * for one area is tried first. If that fails, the biggest memblock
+ * ranges above 4G are selected, and allocated bottom up.
+ *
+ * The complexity here is not great, but this function will only be
+ * called during boot, and the lists operated on have fewer than
+ * CMA_MAX_RANGES elements (default value: 8).
+ */
+int __init cma_declare_contiguous_multi(phys_addr_t total_size,
+			phys_addr_t align, unsigned int order_per_bit,
+			const char *name, struct cma **res_cma, int nid)
+{
+	phys_addr_t start, end;
+	phys_addr_t size, sizesum, sizeleft;
+	struct cma_init_memrange *mrp, *mlp, *failed;
+	struct cma_memrange *cmrp;
+	LIST_HEAD(ranges);
+	LIST_HEAD(final_ranges);
+	struct list_head *mp, *next;
+	int ret, nr = 1;
+	u64 i;
+	struct cma *cma;
+
 	/*
-	 * Each reserved area must be initialised later, when more kernel
-	 * subsystems (like slab allocator) are available.
+	 * First, try it the normal way, producing just one range.
 	 */
-	cma = &cma_areas[cma_area_count];
+	ret = __cma_declare_contiguous_nid(0, total_size, 0, align,
+			order_per_bit, false, name, res_cma, nid);
+	if (ret != -ENOMEM)
+		goto out;
 
-	if (name)
-		snprintf(cma->name, CMA_MAX_NAME, name);
-	else
-		snprintf(cma->name, CMA_MAX_NAME,  "cma%d\n", cma_area_count);
+	/*
+	 * Couldn't find one range that fits our needs, so try multiple
+	 * ranges.
+	 *
+	 * No need to do the alignment checks here, the call to
+	 * cma_declare_contiguous_nid above would have caught
+	 * any issues. With the checks, we know that:
+	 *
+	 * - @align is a power of 2
+	 * - @align is >= pageblock alignment
+	 * - @size is aligned to @align and to @order_per_bit
+	 *
+	 * So, as long as we create ranges that have a base
+	 * aligned to @align, and a size that is aligned to
+	 * both @align and @order_to_bit, things will work out.
+	 */
+	nr = 0;
+	sizesum = 0;
+	failed = NULL;
 
-	cma->base_pfn = PFN_DOWN(base);
-	cma->available_count = cma->count = size >> PAGE_SHIFT;
-	cma->order_per_bit = order_per_bit;
+	ret = cma_new_area(name, total_size, order_per_bit, &cma);
+	if (ret != 0)
+		goto out;
+
+	align = max_t(phys_addr_t, align, CMA_MIN_ALIGNMENT_BYTES);
+	/*
+	 * Create a list of ranges above 4G, largest range first.
+	 */
+	for_each_free_mem_range(i, nid, MEMBLOCK_NONE, &start, &end, NULL) {
+		if (start < SZ_4G)
+			continue;
+
+		start = ALIGN(start, align);
+		if (start >= end)
+			continue;
+
+		end = ALIGN_DOWN(end, align);
+		if (end <= start)
+			continue;
+
+		size = end - start;
+		size = ALIGN_DOWN(size, (PAGE_SIZE << order_per_bit));
+		if (!size)
+			continue;
+		sizesum += size;
+
+		pr_debug("consider %016llx - %016llx\n", (u64)start, (u64)end);
+
+		/*
+		 * If we don't yet have used the maximum number of
+		 * areas, grab a new one.
+		 *
+		 * If we can't use anymore, see if this range is not
+		 * smaller than the smallest one already recorded. If
+		 * not, re-use the smallest element.
+		 */
+		if (nr < CMA_MAX_RANGES)
+			mrp = &memranges[nr++];
+		else {
+			mrp = list_last_entry(&ranges,
+					      struct cma_init_memrange, list);
+			if (size < mrp->size)
+				continue;
+			list_del(&mrp->list);
+			sizesum -= mrp->size;
+			pr_debug("deleted %016llx - %016llx from the list\n",
+				(u64)mrp->base, (u64)mrp->base + size);
+		}
+		mrp->base = start;
+		mrp->size = size;
+
+		/*
+		 * Now do a sorted insert.
+		 */
+		list_insert_sorted(&ranges, mrp, revsizecmp);
+		pr_debug("added %016llx - %016llx to the list\n",
+		    (u64)mrp->base, (u64)mrp->base + size);
+		pr_debug("total size now %llu\n", (u64)sizesum);
+	}
+
+	/*
+	 * There is not enough room in the CMA_MAX_RANGES largest
+	 * ranges, so bail out.
+	 */
+	if (sizesum < total_size) {
+		cma_drop_area(cma);
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	/*
+	 * Found ranges that provide enough combined space.
+	 * Now, sorted them by address, smallest first, because we
+	 * want to mimic a bottom-up memblock allocation.
+	 */
+	sizesum = 0;
+	list_for_each_safe(mp, next, &ranges) {
+		mlp = list_entry(mp, struct cma_init_memrange, list);
+		list_del(mp);
+		list_insert_sorted(&final_ranges, mlp, basecmp);
+		sizesum += mlp->size;
+		if (sizesum >= total_size)
+			break;
+	}
+
+	/*
+	 * Walk the final list, and add a CMA range for
+	 * each range, possibly not using the last one fully.
+	 */
+	nr = 0;
+	sizeleft = total_size;
+	list_for_each(mp, &final_ranges) {
+		mlp = list_entry(mp, struct cma_init_memrange, list);
+		size = min(sizeleft, mlp->size);
+		if (memblock_reserve(mlp->base, size)) {
+			/*
+			 * Unexpected error. Could go on to
+			 * the next one, but just abort to
+			 * be safe.
+			 */
+			failed = mlp;
+			break;
+		}
+
+		pr_debug("created region %d: %016llx - %016llx\n",
+		    nr, (u64)mlp->base, (u64)mlp->base + size);
+		cmrp = &cma->ranges[nr++];
+		cmrp->base_pfn = PHYS_PFN(mlp->base);
+		cmrp->count = size >> PAGE_SHIFT;
+
+		sizeleft -= size;
+		if (sizeleft == 0)
+			break;
+	}
+
+	if (failed) {
+		list_for_each(mp, &final_ranges) {
+			mlp = list_entry(mp, struct cma_init_memrange, list);
+			if (mlp == failed)
+				break;
+			memblock_phys_free(mlp->base, mlp->size);
+		}
+		cma_drop_area(cma);
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	cma->nranges = nr;
 	*res_cma = cma;
-	cma_area_count++;
-	totalcma_pages += cma->count;
 
-	return 0;
+out:
+	if (ret != 0)
+		pr_err("Failed to reserve %lu MiB\n",
+			(unsigned long)total_size / SZ_1M);
+	else
+		pr_info("Reserved %lu MiB in %d range%s\n",
+			(unsigned long)total_size / SZ_1M, nr,
+			nr > 1 ? "s" : "");
+
+	return ret;
 }
 
 /**
@@ -241,6 +536,26 @@ int __init cma_declare_contiguous_nid(phys_addr_t base,
 			phys_addr_t alignment, unsigned int order_per_bit,
 			bool fixed, const char *name, struct cma **res_cma,
 			int nid)
+{
+	int ret;
+
+	ret = __cma_declare_contiguous_nid(base, size, limit, alignment,
+			order_per_bit, fixed, name, res_cma, nid);
+	if (ret != 0)
+		pr_err("Failed to reserve %ld MiB\n",
+				(unsigned long)size / SZ_1M);
+	else
+		pr_info("Reserved %ld MiB at %pa\n",
+				(unsigned long)size / SZ_1M, &base);
+
+	return ret;
+}
+
+static int __init __cma_declare_contiguous_nid(phys_addr_t base,
+			phys_addr_t size, phys_addr_t limit,
+			phys_addr_t alignment, unsigned int order_per_bit,
+			bool fixed, const char *name, struct cma **res_cma,
+			int nid)
 {
 	phys_addr_t memblock_end = memblock_end_of_DRAM();
 	phys_addr_t highmem_start;
@@ -273,10 +588,9 @@ int __init cma_declare_contiguous_nid(phys_addr_t base,
 	/* Sanitise input arguments. */
 	alignment = max_t(phys_addr_t, alignment, CMA_MIN_ALIGNMENT_BYTES);
 	if (fixed && base & (alignment - 1)) {
-		ret = -EINVAL;
 		pr_err("Region at %pa must be aligned to %pa bytes\n",
 			&base, &alignment);
-		goto err;
+		return -EINVAL;
 	}
 	base = ALIGN(base, alignment);
 	size = ALIGN(size, alignment);
@@ -294,10 +608,9 @@ int __init cma_declare_contiguous_nid(phys_addr_t base,
 	 * low/high memory boundary.
 	 */
 	if (fixed && base < highmem_start && base + size > highmem_start) {
-		ret = -EINVAL;
 		pr_err("Region at %pa defined on low/high memory boundary (%pa)\n",
 			&base, &highmem_start);
-		goto err;
+		return -EINVAL;
 	}
 
 	/*
@@ -309,18 +622,16 @@ int __init cma_declare_contiguous_nid(phys_addr_t base,
 		limit = memblock_end;
 
 	if (base + size > limit) {
-		ret = -EINVAL;
 		pr_err("Size (%pa) of region at %pa exceeds limit (%pa)\n",
 			&size, &base, &limit);
-		goto err;
+		return -EINVAL;
 	}
 
 	/* Reserve memory */
 	if (fixed) {
 		if (memblock_is_region_reserved(base, size) ||
 		    memblock_reserve(base, size) < 0) {
-			ret = -EBUSY;
-			goto err;
+			return -EBUSY;
 		}
 	} else {
 		phys_addr_t addr = 0;
@@ -357,10 +668,8 @@ int __init cma_declare_contiguous_nid(phys_addr_t base,
 		if (!addr) {
 			addr = memblock_alloc_range_nid(size, alignment, base,
 					limit, nid, true);
-			if (!addr) {
-				ret = -ENOMEM;
-				goto err;
-			}
+			if (!addr)
+				return -ENOMEM;
 		}
 
 		/*
@@ -373,75 +682,67 @@ int __init cma_declare_contiguous_nid(phys_addr_t base,
 
 	ret = cma_init_reserved_mem(base, size, order_per_bit, name, res_cma);
 	if (ret)
-		goto free_mem;
-
-	pr_info("Reserved %ld MiB at %pa on node %d\n", (unsigned long)size / SZ_1M,
-		&base, nid);
-	return 0;
+		memblock_phys_free(base, size);
 
-free_mem:
-	memblock_phys_free(base, size);
-err:
-	pr_err("Failed to reserve %ld MiB on node %d\n", (unsigned long)size / SZ_1M,
-	       nid);
 	return ret;
 }
 
 static void cma_debug_show_areas(struct cma *cma)
 {
 	unsigned long next_zero_bit, next_set_bit, nr_zero;
-	unsigned long start = 0;
+	unsigned long start;
 	unsigned long nr_part;
-	unsigned long nbits = cma_bitmap_maxno(cma);
+	unsigned long nbits;
+	int r;
+	struct cma_memrange *cmr;
 
 	spin_lock_irq(&cma->lock);
 	pr_info("number of available pages: ");
-	for (;;) {
-		next_zero_bit = find_next_zero_bit(cma->bitmap, nbits, start);
-		if (next_zero_bit >= nbits)
-			break;
-		next_set_bit = find_next_bit(cma->bitmap, nbits, next_zero_bit);
-		nr_zero = next_set_bit - next_zero_bit;
-		nr_part = nr_zero << cma->order_per_bit;
-		pr_cont("%s%lu@%lu", start ? "+" : "", nr_part,
-			next_zero_bit);
-		start = next_zero_bit + nr_zero;
+	for (r = 0; r < cma->nranges; r++) {
+		cmr = &cma->ranges[r];
+
+		start = 0;
+		nbits = cma_bitmap_maxno(cma, cmr);
+
+		pr_info("range %d: ", r);
+		for (;;) {
+			next_zero_bit = find_next_zero_bit(cmr->bitmap,
+							   nbits, start);
+			if (next_zero_bit >= nbits)
+				break;
+			next_set_bit = find_next_bit(cmr->bitmap, nbits,
+						     next_zero_bit);
+			nr_zero = next_set_bit - next_zero_bit;
+			nr_part = nr_zero << cma->order_per_bit;
+			pr_cont("%s%lu@%lu", start ? "+" : "", nr_part,
+				next_zero_bit);
+			start = next_zero_bit + nr_zero;
+		}
+		pr_info("\n");
 	}
 	pr_cont("=> %lu free of %lu total pages\n", cma->available_count,
 			cma->count);
 	spin_unlock_irq(&cma->lock);
 }
 
-static struct page *__cma_alloc(struct cma *cma, unsigned long count,
-				unsigned int align, gfp_t gfp)
+static int cma_range_alloc(struct cma *cma, struct cma_memrange *cmr,
+				unsigned long count, unsigned int align,
+				struct page **pagep, gfp_t gfp)
 {
 	unsigned long mask, offset;
 	unsigned long pfn = -1;
 	unsigned long start = 0;
 	unsigned long bitmap_maxno, bitmap_no, bitmap_count;
-	unsigned long i;
+	int ret = -EBUSY;
 	struct page *page = NULL;
-	int ret = -ENOMEM;
-	const char *name = cma ? cma->name : NULL;
-
-	trace_cma_alloc_start(name, count, align);
-
-	if (!cma || !cma->count || !cma->bitmap)
-		return page;
-
-	pr_debug("%s(cma %p, name: %s, count %lu, align %d)\n", __func__,
-		(void *)cma, cma->name, count, align);
-
-	if (!count)
-		return page;
 
 	mask = cma_bitmap_aligned_mask(cma, align);
-	offset = cma_bitmap_aligned_offset(cma, align);
-	bitmap_maxno = cma_bitmap_maxno(cma);
+	offset = cma_bitmap_aligned_offset(cma, cmr, align);
+	bitmap_maxno = cma_bitmap_maxno(cma, cmr);
 	bitmap_count = cma_bitmap_pages_to_bits(cma, count);
 
 	if (bitmap_count > bitmap_maxno)
-		return page;
+		goto out;
 
 	for (;;) {
 		spin_lock_irq(&cma->lock);
@@ -453,14 +754,14 @@ static struct page *__cma_alloc(struct cma *cma, unsigned long count,
 			spin_unlock_irq(&cma->lock);
 			break;
 		}
-		bitmap_no = bitmap_find_next_zero_area_off(cma->bitmap,
+		bitmap_no = bitmap_find_next_zero_area_off(cmr->bitmap,
 				bitmap_maxno, start, bitmap_count, mask,
 				offset);
 		if (bitmap_no >= bitmap_maxno) {
 			spin_unlock_irq(&cma->lock);
 			break;
 		}
-		bitmap_set(cma->bitmap, bitmap_no, bitmap_count);
+		bitmap_set(cmr->bitmap, bitmap_no, bitmap_count);
 		cma->available_count -= count;
 		/*
 		 * It's safe to drop the lock here. We've marked this region for
@@ -469,7 +770,7 @@ static struct page *__cma_alloc(struct cma *cma, unsigned long count,
 		 */
 		spin_unlock_irq(&cma->lock);
 
-		pfn = cma->base_pfn + (bitmap_no << cma->order_per_bit);
+		pfn = cmr->base_pfn + (bitmap_no << cma->order_per_bit);
 		mutex_lock(&cma_mutex);
 		ret = alloc_contig_range(pfn, pfn + count, MIGRATE_CMA, gfp);
 		mutex_unlock(&cma_mutex);
@@ -478,7 +779,7 @@ static struct page *__cma_alloc(struct cma *cma, unsigned long count,
 			break;
 		}
 
-		cma_clear_bitmap(cma, pfn, count);
+		cma_clear_bitmap(cma, cmr, pfn, count);
 		if (ret != -EBUSY)
 			break;
 
@@ -490,6 +791,38 @@ static struct page *__cma_alloc(struct cma *cma, unsigned long count,
 		/* try again with a bit different memory target */
 		start = bitmap_no + mask + 1;
 	}
+out:
+	*pagep = page;
+	return ret;
+}
+
+static struct page *__cma_alloc(struct cma *cma, unsigned long count,
+		       unsigned int align, gfp_t gfp)
+{
+	struct page *page = NULL;
+	int ret = -ENOMEM, r;
+	unsigned long i;
+	const char *name = cma ? cma->name : NULL;
+
+	trace_cma_alloc_start(name, count, align);
+
+	if (!cma || !cma->count)
+		return page;
+
+	pr_debug("%s(cma %p, name: %s, count %lu, align %d)\n", __func__,
+		(void *)cma, cma->name, count, align);
+
+	if (!count)
+		return page;
+
+	for (r = 0; r < cma->nranges; r++) {
+		page = NULL;
+
+		ret = cma_range_alloc(cma, &cma->ranges[r], count, align,
+				       &page, gfp);
+		if (ret != -EBUSY || page)
+			break;
+	}
 
 	/*
 	 * CMA can allocate multiple page blocks, which results in different
@@ -508,7 +841,8 @@ static struct page *__cma_alloc(struct cma *cma, unsigned long count,
 	}
 
 	pr_debug("%s(): returned %p\n", __func__, page);
-	trace_cma_alloc_finish(name, pfn, page, count, align, ret);
+	trace_cma_alloc_finish(name, page ? page_to_pfn(page) : 0,
+			       page, count, align, ret);
 	if (page) {
 		count_vm_event(CMA_ALLOC_SUCCESS);
 		cma_sysfs_account_success_pages(cma, count);
@@ -551,20 +885,31 @@ struct folio *cma_alloc_folio(struct cma *cma, int order, gfp_t gfp)
 bool cma_pages_valid(struct cma *cma, const struct page *pages,
 		     unsigned long count)
 {
-	unsigned long pfn;
+	unsigned long pfn, end;
+	int r;
+	struct cma_memrange *cmr;
+	bool ret;
 
-	if (!cma || !pages)
+	if (!cma || !pages || count > cma->count)
 		return false;
 
 	pfn = page_to_pfn(pages);
+	ret = false;
 
-	if (pfn < cma->base_pfn || pfn >= cma->base_pfn + cma->count) {
-		pr_debug("%s(page %p, count %lu)\n", __func__,
-						(void *)pages, count);
-		return false;
+	for (r = 0; r < cma->nranges; r++) {
+		cmr = &cma->ranges[r];
+		end = cmr->base_pfn + cmr->count;
+		if (pfn >= cmr->base_pfn && pfn < end) {
+			ret = pfn + count <= end;
+			break;
+		}
 	}
 
-	return true;
+	if (!ret)
+		pr_debug("%s(page %p, count %lu)\n",
+				__func__, (void *)pages, count);
+
+	return ret;
 }
 
 /**
@@ -580,19 +925,32 @@ bool cma_pages_valid(struct cma *cma, const struct page *pages,
 bool cma_release(struct cma *cma, const struct page *pages,
 		 unsigned long count)
 {
-	unsigned long pfn;
+	struct cma_memrange *cmr;
+	unsigned long pfn, end_pfn;
+	int r;
+
+	pr_debug("%s(page %p, count %lu)\n", __func__, (void *)pages, count);
 
 	if (!cma_pages_valid(cma, pages, count))
 		return false;
 
-	pr_debug("%s(page %p, count %lu)\n", __func__, (void *)pages, count);
-
 	pfn = page_to_pfn(pages);
+	end_pfn = pfn + count;
+
+	for (r = 0; r < cma->nranges; r++) {
+		cmr = &cma->ranges[r];
+		if (pfn >= cmr->base_pfn &&
+		    pfn < (cmr->base_pfn + cmr->count)) {
+			VM_BUG_ON(end_pfn > cmr->base_pfn + cmr->count);
+			break;
+		}
+	}
 
-	VM_BUG_ON(pfn + count > cma->base_pfn + cma->count);
+	if (r == cma->nranges)
+		return false;
 
 	free_contig_range(pfn, count);
-	cma_clear_bitmap(cma, pfn, count);
+	cma_clear_bitmap(cma, cmr, pfn, count);
 	cma_sysfs_account_release_pages(cma, count);
 	trace_cma_release(cma->name, pfn, pages, count);
 
diff --git a/mm/cma.h b/mm/cma.h
index 3dd3376ae980..5f39dd1aac91 100644
--- a/mm/cma.h
+++ b/mm/cma.h
@@ -10,19 +10,35 @@ struct cma_kobject {
 	struct cma *cma;
 };
 
+/*
+ * Multi-range support. This can be useful if the size of the allocation
+ * is not expected to be larger than the alignment (like with hugetlb_cma),
+ * and the total amount of memory requested, while smaller than the total
+ * amount of memory available, is large enough that it doesn't fit in a
+ * single physical memory range because of memory holes.
+ */
+struct cma_memrange {
+	unsigned long base_pfn;
+	unsigned long count;
+	unsigned long *bitmap;
+#ifdef CONFIG_CMA_DEBUGFS
+	struct debugfs_u32_array dfs_bitmap;
+#endif
+};
+#define CMA_MAX_RANGES 8
+
 struct cma {
-	unsigned long   base_pfn;
 	unsigned long   count;
 	unsigned long	available_count;
-	unsigned long   *bitmap;
 	unsigned int order_per_bit; /* Order of pages represented by one bit */
 	spinlock_t	lock;
 #ifdef CONFIG_CMA_DEBUGFS
 	struct hlist_head mem_head;
 	spinlock_t mem_head_lock;
-	struct debugfs_u32_array dfs_bitmap;
 #endif
 	char name[CMA_MAX_NAME];
+	int nranges;
+	struct cma_memrange ranges[CMA_MAX_RANGES];
 #ifdef CONFIG_CMA_SYSFS
 	/* the number of CMA page successful allocations */
 	atomic64_t nr_pages_succeeded;
@@ -39,9 +55,10 @@ struct cma {
 extern struct cma cma_areas[MAX_CMA_AREAS];
 extern unsigned int cma_area_count;
 
-static inline unsigned long cma_bitmap_maxno(struct cma *cma)
+static inline unsigned long cma_bitmap_maxno(struct cma *cma,
+		struct cma_memrange *cmr)
 {
-	return cma->count >> cma->order_per_bit;
+	return cmr->count >> cma->order_per_bit;
 }
 
 #ifdef CONFIG_CMA_SYSFS
diff --git a/mm/cma_debug.c b/mm/cma_debug.c
index 89236f22230a..fdf899532ca0 100644
--- a/mm/cma_debug.c
+++ b/mm/cma_debug.c
@@ -46,17 +46,26 @@ DEFINE_DEBUGFS_ATTRIBUTE(cma_used_fops, cma_used_get, NULL, "%llu\n");
 static int cma_maxchunk_get(void *data, u64 *val)
 {
 	struct cma *cma = data;
+	struct cma_memrange *cmr;
 	unsigned long maxchunk = 0;
-	unsigned long start, end = 0;
-	unsigned long bitmap_maxno = cma_bitmap_maxno(cma);
+	unsigned long start, end;
+	unsigned long bitmap_maxno;
+	int r;
 
 	spin_lock_irq(&cma->lock);
-	for (;;) {
-		start = find_next_zero_bit(cma->bitmap, bitmap_maxno, end);
-		if (start >= bitmap_maxno)
-			break;
-		end = find_next_bit(cma->bitmap, bitmap_maxno, start);
-		maxchunk = max(end - start, maxchunk);
+	for (r = 0; r < cma->nranges; r++) {
+		cmr = &cma->ranges[r];
+		bitmap_maxno = cma_bitmap_maxno(cma, cmr);
+		end = 0;
+		for (;;) {
+			start = find_next_zero_bit(cmr->bitmap,
+						   bitmap_maxno, end);
+			if (start >= bitmap_maxno)
+				break;
+			end = find_next_bit(cmr->bitmap, bitmap_maxno,
+					    start);
+			maxchunk = max(end - start, maxchunk);
+		}
 	}
 	spin_unlock_irq(&cma->lock);
 	*val = (u64)maxchunk << cma->order_per_bit;
@@ -159,24 +168,41 @@ DEFINE_DEBUGFS_ATTRIBUTE(cma_alloc_fops, NULL, cma_alloc_write, "%llu\n");
 
 static void cma_debugfs_add_one(struct cma *cma, struct dentry *root_dentry)
 {
-	struct dentry *tmp;
+	struct dentry *tmp, *dir, *rangedir;
+	int r;
+	char rdirname[12];
+	struct cma_memrange *cmr;
 
 	tmp = debugfs_create_dir(cma->name, root_dentry);
 
 	debugfs_create_file("alloc", 0200, tmp, cma, &cma_alloc_fops);
 	debugfs_create_file("free", 0200, tmp, cma, &cma_free_fops);
-	debugfs_create_file("base_pfn", 0444, tmp,
-			    &cma->base_pfn, &cma_debugfs_fops);
 	debugfs_create_file("count", 0444, tmp, &cma->count, &cma_debugfs_fops);
 	debugfs_create_file("order_per_bit", 0444, tmp,
 			    &cma->order_per_bit, &cma_debugfs_fops);
 	debugfs_create_file("used", 0444, tmp, cma, &cma_used_fops);
 	debugfs_create_file("maxchunk", 0444, tmp, cma, &cma_maxchunk_fops);
 
-	cma->dfs_bitmap.array = (u32 *)cma->bitmap;
-	cma->dfs_bitmap.n_elements = DIV_ROUND_UP(cma_bitmap_maxno(cma),
-						  BITS_PER_BYTE * sizeof(u32));
-	debugfs_create_u32_array("bitmap", 0444, tmp, &cma->dfs_bitmap);
+	rangedir = debugfs_create_dir("ranges", tmp);
+	for (r = 0; r < cma->nranges; r++) {
+		cmr = &cma->ranges[r];
+		snprintf(rdirname, sizeof(rdirname), "%d", r);
+		dir = debugfs_create_dir(rdirname, rangedir);
+		debugfs_create_file("base_pfn", 0444, dir,
+			    &cmr->base_pfn, &cma_debugfs_fops);
+		cmr->dfs_bitmap.array = (u32 *)cmr->bitmap;
+		cmr->dfs_bitmap.n_elements =
+			DIV_ROUND_UP(cma_bitmap_maxno(cma, cmr),
+					BITS_PER_BYTE * sizeof(u32));
+		debugfs_create_u32_array("bitmap", 0444, dir,
+				&cmr->dfs_bitmap);
+	}
+
+	/*
+	 * Backward compatible symlinks to range 0 for base_pfn and bitmap.
+	 */
+	debugfs_create_symlink("base_pfn", tmp, "ranges/0/base_pfn");
+	debugfs_create_symlink("bitmap", tmp, "ranges/0/bitmap");
 }
 
 static int __init cma_debugfs_init(void)
-- 
2.48.1.601.g30ceb7b040-goog


