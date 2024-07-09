Return-Path: <linux-kernel+bounces-246423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B78A92C18C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 19:02:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DED551F21F5B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 17:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F379A1AE09C;
	Tue,  9 Jul 2024 16:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f2xKq/1N"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 836F519DF99
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 16:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720542663; cv=none; b=OZP03/DBnbBOOsZGXBF4h/UKUn3NhWRJblCAoF/P462cg3cFAUsjj6mZNWSko5E7j9FpDJxpLXTJXShxB+Fq86Wnn4TT9DObGdoV2vK1TcFHdxsoEsENUMnmDoGEX4EXonpsXr1AYAHMLGwMuaX0pT8VpoujBXb1D4+bIQ80gUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720542663; c=relaxed/simple;
	bh=c7TKWwx45VFG+NDZyawZua5dXbumLhUVdqxhJnoKZwc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=RK+wMZx2oy0SZcIiM+KSJLwDp5qP2H3Dffkr3/0GErC//B6P2Sd3x+sgl4OFyojR2hKrGmD/PwKFzs2e35Cp8/HoUzLNYhLFU4Y9MK/WIbIoXsvHcs1vvuTvO/5qATPwpIKZAq0IX/k1ucwzD8QYirne5koQJVb7uzKMf5TKHos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--fvdl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f2xKq/1N; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--fvdl.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-1fb019a1227so36458325ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 09:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720542661; x=1721147461; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=y5RiI1/WftUv65TYOiAp8vcGWTeflD92QLbJN57DRJo=;
        b=f2xKq/1NQm95CCCiSrsPwGriUAkBRYGRl4asCkeUBJ0y1R8rTzP/iKEsSCbsCVUPlx
         S05rpouWuPeMHEYFlzoIHkMxB0EsY5FNmSk6pjPEOn00+GIRsDY/m36pUCw4cNexFST6
         HrZo7pxl+yz2Gg0C9WYvxrHYyppL9GNGjjXlGtAkPLYIwhI00hcXfy1/XAaRwPkBfRMj
         CuqP0rqQM1rnJ4RoGD0BqzsR0wz3/JRkmBu8F8+AYfroTnqD2Oa1pTvcZCA0gOz+wiJZ
         8sfFE/0J8fw8GSFZWenzW2mW8Qt6gYGMPdNQO3OnZxrY+ip3TkeXODYYhWJA29CoQ9kH
         BPfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720542661; x=1721147461;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y5RiI1/WftUv65TYOiAp8vcGWTeflD92QLbJN57DRJo=;
        b=jvXML/ltmww7NOX0nApOVJ3W8VQDKLVm/tH+fLODX7t917PbjU67z73VfXzKWUPoyV
         +nOjHAK0mrahzHjfx1LjBTjxqRyX6R1n9+aOd/b/D2HPm+/yMckufvGu3DHZ8Xt+GSG8
         nlfn3kfyEf8QdNouYdz9UwFbtDIbp6zX4+T1Vt8lfm/9Ih7UAvfowLQ5nQhkKekrVkto
         l26Xqbor1zYY14zdHGxvL5/zsZZvEzNwbiwLAYfrNjcVYMkzaC7q+3h3v29GphL6f4iD
         q3Tjke+p0cHvHYgsWzM5HEHtiDvGI61n7+YqlaZVmue/golZAk/DUrr5w6395WsJQDoI
         /SDA==
X-Gm-Message-State: AOJu0YybnokXL4YNrM8IPTbSG6n26FrAZMb6CTJpHKhR0wfDhIiakT7o
	V3W6DpzwICPZ35P8fYnDWU3O8Iqvm/chigyXxuBj84u8fPBvtCRUFZLBRek85rSoDG2XTA==
X-Google-Smtp-Source: AGHT+IHEPNf6YF/D2lxxo9kzhmYN4T17VfbjdCiJCEulS4pSavl/ccl7H7van8HjCkisBPeqdHwld2D+
X-Received: from fvdl-cloudtop.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:46ab])
 (user=fvdl job=sendgmr) by 2002:a17:902:e5ca:b0:1fb:4a21:8d37 with SMTP id
 d9443c01a7336-1fbb6d69c6dmr2309225ad.11.1720542660621; Tue, 09 Jul 2024
 09:31:00 -0700 (PDT)
Date: Tue,  9 Jul 2024 16:30:53 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Message-ID: <20240709163053.2514760-1-fvdl@google.com>
Subject: [PATCH] mm/cma: export total and free number of pages for CMA areas
From: Frank van der Linden <fvdl@google.com>
To: linux-mm@kvack.org, akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, Frank van der Linden <fvdl@google.com>
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

Signed-off-by: Frank van der Linden <fvdl@google.com>
---
 Documentation/ABI/testing/sysfs-kernel-mm-cma | 13 ++++++++++++
 mm/cma.c                                      | 18 +++++++++++------
 mm/cma.h                                      |  1 +
 mm/cma_debug.c                                |  5 +----
 mm/cma_sysfs.c                                | 20 +++++++++++++++++++
 5 files changed, 47 insertions(+), 10 deletions(-)

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
index 3e9724716bad..727e8c04d53a 100644
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
 	return;
 }
@@ -198,7 +199,7 @@ int __init cma_init_reserved_mem(phys_addr_t base, phys_addr_t size,
 		snprintf(cma->name, CMA_MAX_NAME,  "cma%d\n", cma_area_count);
 
 	cma->base_pfn = PFN_DOWN(base);
-	cma->count = size >> PAGE_SHIFT;
+	cma->available_count = cma->count = size >> PAGE_SHIFT;
 	cma->order_per_bit = order_per_bit;
 	*res_cma = cma;
 	cma_area_count++;
@@ -382,7 +383,7 @@ static void cma_debug_show_areas(struct cma *cma)
 {
 	unsigned long next_zero_bit, next_set_bit, nr_zero;
 	unsigned long start = 0;
-	unsigned long nr_part, nr_total = 0;
+	unsigned long nr_part;
 	unsigned long nbits = cma_bitmap_maxno(cma);
 
 	spin_lock_irq(&cma->lock);
@@ -394,12 +395,12 @@ static void cma_debug_show_areas(struct cma *cma)
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
 
@@ -446,6 +447,10 @@ struct page *cma_alloc(struct cma *cma, unsigned long count,
 
 	for (;;) {
 		spin_lock_irq(&cma->lock);
+		if (count > cma->available_count) {
+			spin_unlock_irq(&cma->lock);
+			break;
+		}
 		bitmap_no = bitmap_find_next_zero_area_off(cma->bitmap,
 				bitmap_maxno, start, bitmap_count, mask,
 				offset);
@@ -454,6 +459,7 @@ struct page *cma_alloc(struct cma *cma, unsigned long count,
 			break;
 		}
 		bitmap_set(cma->bitmap, bitmap_no, bitmap_count);
+		cma->available_count -= count;
 		/*
 		 * It's safe to drop the lock here. We've marked this region for
 		 * our exclusive use. If the migration fails we will take the
diff --git a/mm/cma.h b/mm/cma.h
index ad61cc6dd439..d111f3d51868 100644
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
2.45.2.803.g4e1b14247a-goog


