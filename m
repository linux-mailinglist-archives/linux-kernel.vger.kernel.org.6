Return-Path: <linux-kernel+bounces-539151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AEA19A4A193
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 19:30:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 248C67AB241
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 18:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82281276034;
	Fri, 28 Feb 2025 18:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P6RYC5Be"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD772755F6
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 18:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740767392; cv=none; b=g15z/Iys1HfqBebOND5LMM3FkpoI6SJqsz0WC49893DvNRTwWIdIc8jfy30acky+PPO/0jehg1GA3aTg5Ho7SIyROl34bhDyguZ1ilwBByyCGHMODE8wjkODfSLE29ykGfm1ndeH6EwInafzYvnN9j+DfZd7bPC59pX6nfCY5lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740767392; c=relaxed/simple;
	bh=vHaXUAlNn8PozCDKoY9kUl2s51Y98UGyKOdNrWvNRpU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OdDKgH2T5W2mnFXA8DiafFh3tUEogflFclDcXrg3AqYfk0YcFyt3fQN6q5ymHeK69h9s0sP0R7naRL91XDSZDxkxkz4Su5rvC15KJe/Bjm8G50XuTGVx/4NPJoAt1TtrGsIx5CnoYEbQAn0u+WezzoqqeasWNzL8VQMZqyhayjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--fvdl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=P6RYC5Be; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--fvdl.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2fc1eabf4f7so5260838a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 10:29:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740767390; x=1741372190; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kKtMLmlpe+m6qN9ca3/progHrAqe0123z61YwAW9d3s=;
        b=P6RYC5BeX37Yoyf8kX1eUMYMvp+VTHvM0Do8l06m0GuBzK0rE1HgtoQeZDpiXoqcYy
         8JlFByDOaLuw7Z2gV+EVC1uuGt010klvdTLCQ6Qa02U3x+AtVOxCdvhm5VK0AaS+fBZ7
         JQj8rX2y6IeFZRTBnMPVKtPHQ56BS9+/o/KHdQ+1f9q4FsF37K1fDHI8r9xq2LMtz8tI
         oJ2SDonS6lj3tleJ8U6+Q5DyZIg30+DL8/Ml3BvHErUvjZWbTYnan6x/+o0XSmcCyGVi
         pnt5nYgNxo8MOhSti38fIBakC5sVHnbz5dD4ouOt9GHjLKVHip5wzgs9D8klo1htT1Kx
         Q71g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740767390; x=1741372190;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kKtMLmlpe+m6qN9ca3/progHrAqe0123z61YwAW9d3s=;
        b=Wpq1+0aaaCAan/p1VZQ9luI2jsfHYy7NlToWylxNlvAo7kPo4I5w8ewOmQCc4R46OV
         DXUlbFnjTsHex4hRAAeZahwTz0+PaHIpm00C2o3gyK+qUtQZy9x0Q14DCZfEsRYQv4yp
         XPK+Of/zMKWeu4h57G7zrwZmoFEc+twoyeUjPMdRMwX2DSIptAychuS72GDMY4XH4h4R
         EHFz8ogb/TqXlPd3QG5e+oLgdcs2nc4lvNRAHjrqNkaj1GT53RZu0+H3MEeYNWlw8M1S
         7oxCoE0cl7tyvE1m9Vh46SVc+9oyUSdkD3ZnIYJUZWovFHnIkKeOnRIliiuCai6wVrOK
         XQVg==
X-Forwarded-Encrypted: i=1; AJvYcCUeDJmWw7kbFSVRzkvMEH4S77vFJdtXSKRho3OdEPdnyFamvfx0+zUBJsxXC/+IA8oqE+JIEXAVdUVazG4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwACuuUbIWm6TA3jd0v3/xK6x1C4iqEYGhY8jBidNj5wCRde7TP
	qh8Nxx56fAlg4AGr4fvMuV0pxVIynRo98Gf+qkAgAG33EHsa8FtOe7TtxD4h5vdg6FsbAA==
X-Google-Smtp-Source: AGHT+IHqJuYtYkzOhZDMCMvoR+05mDEEDRM0zr7QytAhww8Je1Y3UD1lMlTzOEV4CRBkoQI5L703TwyQ
X-Received: from pjbsr11.prod.google.com ([2002:a17:90b:4e8b:b0:2ef:82a8:7171])
 (user=fvdl job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3a89:b0:2ef:e0bb:1ef2
 with SMTP id 98e67ed59e1d1-2febab71ec6mr6563503a91.19.1740767390505; Fri, 28
 Feb 2025 10:29:50 -0800 (PST)
Date: Fri, 28 Feb 2025 18:29:02 +0000
In-Reply-To: <20250228182928.2645936-1-fvdl@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250228182928.2645936-1-fvdl@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250228182928.2645936-2-fvdl@google.com>
Subject: [PATCH v5 01/27] mm/cma: export total and free number of pages for
 CMA areas
From: Frank van der Linden <fvdl@google.com>
To: akpm@linux-foundation.org, muchun.song@linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Cc: yuzhao@google.com, usamaarif642@gmail.com, joao.m.martins@oracle.com, 
	roman.gushchin@linux.dev, ziy@nvidia.com, david@redhat.com, 
	Frank van der Linden <fvdl@google.com>, Oscar Salvador <osalvador@suse.de>
Content-Type: text/plain; charset="UTF-8"

In addition to the number of allocations and releases, system
management software may like to be aware of the size of CMA
areas, and how many pages are available in it. This information
is currently not available, so export it in total_page and
available_pages, respectively.

The name 'available_pages' was picked over 'free_pages' because
'free' implies that the pages are unused. But they might not
be, they just haven't been used by cma_alloc

The number of available pages is tracked regardless of
CONFIG_CMA_SYSFS, allowing for a few minor shortcuts in
the code, avoiding bitmap operations.

Reviewed-by: Oscar Salvador <osalvador@suse.de>
Signed-off-by: Frank van der Linden <fvdl@google.com>
---
 Documentation/ABI/testing/sysfs-kernel-mm-cma | 13 +++++++++++
 mm/cma.c                                      | 22 ++++++++++++++-----
 mm/cma.h                                      |  1 +
 mm/cma_debug.c                                |  5 +----
 mm/cma_sysfs.c                                | 20 +++++++++++++++++
 5 files changed, 51 insertions(+), 10 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-cma b/Documentation/ABI/testing/sysfs-kernel-mm-cma
index dfd755201142..aaf2a5d8b13b 100644
--- a/Documentation/ABI/testing/sysfs-kernel-mm-cma
+++ b/Documentation/ABI/testing/sysfs-kernel-mm-cma
@@ -29,3 +29,16 @@ Date:		Feb 2024
 Contact:	Anshuman Khandual <anshuman.khandual@arm.com>
 Description:
 		the number of pages CMA API succeeded to release
+
+What:		/sys/kernel/mm/cma/<cma-heap-name>/total_pages
+Date:		Jun 2024
+Contact:	Frank van der Linden <fvdl@google.com>
+Description:
+		The size of the CMA area in pages.
+
+What:		/sys/kernel/mm/cma/<cma-heap-name>/available_pages
+Date:		Jun 2024
+Contact:	Frank van der Linden <fvdl@google.com>
+Description:
+		The number of pages in the CMA area that are still
+		available for CMA allocation.
diff --git a/mm/cma.c b/mm/cma.c
index de5bc0c81fc2..95a8788e54d3 100644
--- a/mm/cma.c
+++ b/mm/cma.c
@@ -86,6 +86,7 @@ static void cma_clear_bitmap(struct cma *cma, unsigned long pfn,
 
 	spin_lock_irqsave(&cma->lock, flags);
 	bitmap_clear(cma->bitmap, bitmap_no, bitmap_count);
+	cma->available_count += count;
 	spin_unlock_irqrestore(&cma->lock, flags);
 }
 
@@ -133,7 +134,7 @@ static void __init cma_activate_area(struct cma *cma)
 			free_reserved_page(pfn_to_page(pfn));
 	}
 	totalcma_pages -= cma->count;
-	cma->count = 0;
+	cma->available_count = cma->count = 0;
 	pr_err("CMA area %s could not be activated\n", cma->name);
 }
 
@@ -206,7 +207,7 @@ int __init cma_init_reserved_mem(phys_addr_t base, phys_addr_t size,
 		snprintf(cma->name, CMA_MAX_NAME,  "cma%d\n", cma_area_count);
 
 	cma->base_pfn = PFN_DOWN(base);
-	cma->count = size >> PAGE_SHIFT;
+	cma->available_count = cma->count = size >> PAGE_SHIFT;
 	cma->order_per_bit = order_per_bit;
 	*res_cma = cma;
 	cma_area_count++;
@@ -390,7 +391,7 @@ static void cma_debug_show_areas(struct cma *cma)
 {
 	unsigned long next_zero_bit, next_set_bit, nr_zero;
 	unsigned long start = 0;
-	unsigned long nr_part, nr_total = 0;
+	unsigned long nr_part;
 	unsigned long nbits = cma_bitmap_maxno(cma);
 
 	spin_lock_irq(&cma->lock);
@@ -402,12 +403,12 @@ static void cma_debug_show_areas(struct cma *cma)
 		next_set_bit = find_next_bit(cma->bitmap, nbits, next_zero_bit);
 		nr_zero = next_set_bit - next_zero_bit;
 		nr_part = nr_zero << cma->order_per_bit;
-		pr_cont("%s%lu@%lu", nr_total ? "+" : "", nr_part,
+		pr_cont("%s%lu@%lu", start ? "+" : "", nr_part,
 			next_zero_bit);
-		nr_total += nr_part;
 		start = next_zero_bit + nr_zero;
 	}
-	pr_cont("=> %lu free of %lu total pages\n", nr_total, cma->count);
+	pr_cont("=> %lu free of %lu total pages\n", cma->available_count,
+			cma->count);
 	spin_unlock_irq(&cma->lock);
 }
 
@@ -444,6 +445,14 @@ static struct page *__cma_alloc(struct cma *cma, unsigned long count,
 
 	for (;;) {
 		spin_lock_irq(&cma->lock);
+		/*
+		 * If the request is larger than the available number
+		 * of pages, stop right away.
+		 */
+		if (count > cma->available_count) {
+			spin_unlock_irq(&cma->lock);
+			break;
+		}
 		bitmap_no = bitmap_find_next_zero_area_off(cma->bitmap,
 				bitmap_maxno, start, bitmap_count, mask,
 				offset);
@@ -452,6 +461,7 @@ static struct page *__cma_alloc(struct cma *cma, unsigned long count,
 			break;
 		}
 		bitmap_set(cma->bitmap, bitmap_no, bitmap_count);
+		cma->available_count -= count;
 		/*
 		 * It's safe to drop the lock here. We've marked this region for
 		 * our exclusive use. If the migration fails we will take the
diff --git a/mm/cma.h b/mm/cma.h
index 8485ef893e99..3dd3376ae980 100644
--- a/mm/cma.h
+++ b/mm/cma.h
@@ -13,6 +13,7 @@ struct cma_kobject {
 struct cma {
 	unsigned long   base_pfn;
 	unsigned long   count;
+	unsigned long	available_count;
 	unsigned long   *bitmap;
 	unsigned int order_per_bit; /* Order of pages represented by one bit */
 	spinlock_t	lock;
diff --git a/mm/cma_debug.c b/mm/cma_debug.c
index 602fff89b15f..89236f22230a 100644
--- a/mm/cma_debug.c
+++ b/mm/cma_debug.c
@@ -34,13 +34,10 @@ DEFINE_DEBUGFS_ATTRIBUTE(cma_debugfs_fops, cma_debugfs_get, NULL, "%llu\n");
 static int cma_used_get(void *data, u64 *val)
 {
 	struct cma *cma = data;
-	unsigned long used;
 
 	spin_lock_irq(&cma->lock);
-	/* pages counter is smaller than sizeof(int) */
-	used = bitmap_weight(cma->bitmap, (int)cma_bitmap_maxno(cma));
+	*val = cma->count - cma->available_count;
 	spin_unlock_irq(&cma->lock);
-	*val = (u64)used << cma->order_per_bit;
 
 	return 0;
 }
diff --git a/mm/cma_sysfs.c b/mm/cma_sysfs.c
index f50db3973171..97acd3e5a6a5 100644
--- a/mm/cma_sysfs.c
+++ b/mm/cma_sysfs.c
@@ -62,6 +62,24 @@ static ssize_t release_pages_success_show(struct kobject *kobj,
 }
 CMA_ATTR_RO(release_pages_success);
 
+static ssize_t total_pages_show(struct kobject *kobj,
+					  struct kobj_attribute *attr, char *buf)
+{
+	struct cma *cma = cma_from_kobj(kobj);
+
+	return sysfs_emit(buf, "%lu\n", cma->count);
+}
+CMA_ATTR_RO(total_pages);
+
+static ssize_t available_pages_show(struct kobject *kobj,
+					  struct kobj_attribute *attr, char *buf)
+{
+	struct cma *cma = cma_from_kobj(kobj);
+
+	return sysfs_emit(buf, "%lu\n", cma->available_count);
+}
+CMA_ATTR_RO(available_pages);
+
 static void cma_kobj_release(struct kobject *kobj)
 {
 	struct cma *cma = cma_from_kobj(kobj);
@@ -75,6 +93,8 @@ static struct attribute *cma_attrs[] = {
 	&alloc_pages_success_attr.attr,
 	&alloc_pages_fail_attr.attr,
 	&release_pages_success_attr.attr,
+	&total_pages_attr.attr,
+	&available_pages_attr.attr,
 	NULL,
 };
 ATTRIBUTE_GROUPS(cma);
-- 
2.48.1.711.g2feabab25a-goog


