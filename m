Return-Path: <linux-kernel+bounces-520044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96BD6A3A515
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 19:17:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F7AA18916CC
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 18:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BE3F27127C;
	Tue, 18 Feb 2025 18:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JmrUrCZs"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A7726AA94
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 18:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739902630; cv=none; b=rVUty204lNK3zrwRGGkbeC9J8AxsQMRKHnBW+Iy18J59u3YpBAs7ZqXbNFBt2cfbMHlK6h70uk5UI5AaytfGmhZyFTrHM+o5k8OZ3gzzArYCpjn0R4InBJbDCezk7SnnX3ej5AVF37SDqDNEhgpj7R+j7D+hJpVxZlso5ZpFEA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739902630; c=relaxed/simple;
	bh=Gk1Ovclg+uwRXUdufYrBruyoP79K0+Q5gmZuqPBwVRE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=j/I7/72yVSVNRva1Q9LISNzfuzVGVd6Er+SkLoSVPLAjJpBYcSLgaJihgBW0AiMPTaOiGRQXlDW8VH3VudrLRK/eB8x51BJtCnPrLuVNy4bqUcTCocr05UQvsv+QDdcHWmd8zFsjVlotGzp2MrHYUkqugHVNVrCBJSakDDRFLUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--fvdl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JmrUrCZs; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--fvdl.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2fc2b258e82so9921273a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 10:17:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739902628; x=1740507428; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YFMDP9y7jE/B7rMGFu3HCD39n6UMlP9JUwWE0fLegnI=;
        b=JmrUrCZsy1frvTasNHOTx/0++sOdMxTFjBhFSucvLBpzVwU0JGXyfZGRgl4R+37TUl
         Ef96lfEO0+fV574hRS1uZsPyYNS5cvNmGr12YnYG3d6CwUKlbNZvVn4VGdiqlwyfGfSn
         BlfiD0cHOupyBJTPRVFl7qQwUCk/wUMQWfGwIZ8lGStQpJTqkUNN2Cx02J8paWMigC2I
         BRU+fAwsnIK83+OITQsyi3LFN5hTwbP+cKyJlYdW2J0r6wcXCCsMq653ryESKeeKTgUF
         rZeSnEYNsZjJTO5M3xBzC1ncW3jG2tCh82dAksGTEZRQEs9hUabQOqHx0Bx2AgIAai0q
         7TSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739902628; x=1740507428;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YFMDP9y7jE/B7rMGFu3HCD39n6UMlP9JUwWE0fLegnI=;
        b=qFKHrRrBtvQODmBIgPu8WeuInwQNW5bEviZTqDWsMDnLW1H/B3N4wxBhyvE5/X8tXA
         YupUip9KCEfp33Va2VYZ+5Uy/IWZeQvxeVNhS+iFCT8IlZuIy/o/apjAJAmOMbNjkpzY
         hUxvDKwyzj7t5IQnqnuAt1wX/V0ott5d7kPnWenlVbumSDbF9bJaimMw+qt9BNOtoYH0
         w7LlrEveCNzsWsKmDiM66nab0tdoEU9Bva818MsWW4J8nWIaAWOIaEjhixK2ctrK2x8T
         y6VYKLonjl/Y4cZu7U+ioYLfHj0g3bkLBlWBR2Bh38nusEUExAOdK7cvw/Xb87axrLdk
         rahQ==
X-Forwarded-Encrypted: i=1; AJvYcCWITN1A+q+vMx315hzuQ2enUxsKx8NOkwb4VOyITyRmOAIPou7j2LVXnYMDf5dasmwBe1A9mgI4eda74Sg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHFuGfrqmb6yxWf9CV2RrvpkX3hXuH1dYHlNkACKSgaWCvi5xi
	eTnZeHj02WpEq+UNIsnnP9I0mm8BfHtGeju/28U9g6mPs3WbyzEBjpGfo2iNg/A2DMmpYg==
X-Google-Smtp-Source: AGHT+IFKNXDQlFw3p4kB+WyHMQa70HsCZ8AgEKV5M11liys6mRWRTzYQbQMsUg+5jC7sM7FrCTb3toTw
X-Received: from pfbji12.prod.google.com ([2002:a05:6a00:8f0c:b0:730:50c0:136d])
 (user=fvdl job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1301:b0:730:8a0a:9f06
 with SMTP id d2e1a72fcca58-7329df4e95dmr405449b3a.16.1739902628294; Tue, 18
 Feb 2025 10:17:08 -0800 (PST)
Date: Tue, 18 Feb 2025 18:16:29 +0000
In-Reply-To: <20250218181656.207178-1-fvdl@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250218181656.207178-1-fvdl@google.com>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <20250218181656.207178-2-fvdl@google.com>
Subject: [PATCH v4 01/27] mm/cma: export total and free number of pages for
 CMA areas
From: Frank van der Linden <fvdl@google.com>
To: akpm@linux-foundation.org, muchun.song@linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Cc: yuzhao@google.com, usamaarif642@gmail.com, joao.m.martins@oracle.com, 
	roman.gushchin@linux.dev, Frank van der Linden <fvdl@google.com>, 
	Oscar Salvador <osalvador@suse.de>
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
2.48.1.601.g30ceb7b040-goog


