Return-Path: <linux-kernel+bounces-520054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 596C4A3A524
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 19:19:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DD70188A81A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 18:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED630280A47;
	Tue, 18 Feb 2025 18:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RzTr+aeQ"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5F3274251
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 18:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739902644; cv=none; b=M4Ze2pnayD9hPXh8XymQthCmEZtZRna2faNV2nHIMf3bKpx8dsalWKUxDOArhEg3ZPMAbaT6x0O45DsWEGJ527ZNhffISoPZmMu3dBiBbzgph3SK1t7i4JtVuGhjozgQWd1wPzL7bw3QgCUjhC1wQeWPqxUGPmc7MXV4WlZQsrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739902644; c=relaxed/simple;
	bh=BCxzqr31p85hbHRxB2dAX5Pn+Ag8FeMtQ06PzZUCrWU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oe6eMZ1P0kcsEUrPiW0XVg2pZv0GPY0BwP4qewIlJHSqQ+MjVEHQB6k7j37SFGs5z/zSnLpUvf4+TacACjoQlpd0wMwz/fNWqq7WL5WV+0vuUscO61Vm850Y1z+mYdrC1uMlOQZ3ZM/v9B2qCf4SWeMp4A5P4rdtF5jYFNpyiOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--fvdl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RzTr+aeQ; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--fvdl.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-220ff7d7b67so79715235ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 10:17:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739902642; x=1740507442; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QHuPJqfQqZyD3xPuHYnDsZ7VFtOe3jnvWOipytOApzk=;
        b=RzTr+aeQlkI04vXhBhrIPwWQToPPuJfVRufoT61SprGNQ8HHTUgRtBBkmpmitcpJLL
         abyfHjcq+cCR7u8VOXlE0cJEZRo0y/s8KwwBXge2ASIdc8yBDOJcHMdixxm/UBbunWhi
         VR/jxpYb6gUD167h3w/S2pqO1pOeonS1IVsEGEnP7a3dx1RwoINZHYRDckTq4tNI6Hik
         Jsx3QsE7Y+r9O7yHO6mFTl9uSxa8xoFK4hh7l3/EO9L6YqGZQnejBbDhJTw9xBmCn/04
         coHy8t7CxBKkA9AkYRbETBz43jRZOmyVWqMcLWfXMHhgOoHH+FfSZE+IcaNwIT53WNif
         ljWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739902642; x=1740507442;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QHuPJqfQqZyD3xPuHYnDsZ7VFtOe3jnvWOipytOApzk=;
        b=KxjXXqeXNlVWseDQrYXSbhIPZUKmQMykJx18lSgyF9m1NG0HSJykKOUeROxzB0x1Ni
         LK62P01IceK5a6SBWhSPIGVG9/XCi8ArsljCjgmTulpO83+uOdugP6CA0rWC21yMQLCH
         fTYZhHTrOtG52B2/tZSL7z8TPy/xWVRAFwgt5mz0l2NnxbAnwvOwjmQg7JiqiHWq2UKk
         9PMhbx0xFKZbRamoag+XCXGUgZxuL6dIB8/Kk+84klewhC6IL2KnvyIrQh8yM6Vj7L0A
         BtU4p3F3liiukyZvZ+/WdQlq5v1HRUNaM7UfLuuDUWE/Moqa3P4A34McGn/Joqwqoot+
         qC4Q==
X-Forwarded-Encrypted: i=1; AJvYcCVL80u+4pnWNfLsUzZqT94B3oMijuTuuy5bCbWRAiEuNsP7KJFIMk1MqZT+8j5PosDQa2kXrERZsvN2DaA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAlFVK5EXc4NJVdNKAVVEIPevP0Llydv1LAAKmHO+IuO+C0PXb
	1lgAG4nCFbqR/m+F2SuaqXukXoXcd6JDjiDSLps/M9DSsmYcSd6FW0j6NosfEQkg0A6p8w==
X-Google-Smtp-Source: AGHT+IF/tqrjIncWta5fdpCjLPTmY2z8K3edM8w7NT9CYkwW5Spjl+Yw51aD9LiAbauV0zFCuvILnlVC
X-Received: from pfaq11.prod.google.com ([2002:a05:6a00:a88b:b0:730:9a11:69a3])
 (user=fvdl job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:880c:b0:1ee:b583:1b44
 with SMTP id adf61e73a8af0-1eeb5831c62mr11114718637.4.1739902642566; Tue, 18
 Feb 2025 10:17:22 -0800 (PST)
Date: Tue, 18 Feb 2025 18:16:38 +0000
In-Reply-To: <20250218181656.207178-1-fvdl@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250218181656.207178-1-fvdl@google.com>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <20250218181656.207178-11-fvdl@google.com>
Subject: [PATCH v4 10/27] mm/sparse: allow for alternate vmemmap section init
 at boot
From: Frank van der Linden <fvdl@google.com>
To: akpm@linux-foundation.org, muchun.song@linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Cc: yuzhao@google.com, usamaarif642@gmail.com, joao.m.martins@oracle.com, 
	roman.gushchin@linux.dev, Frank van der Linden <fvdl@google.com>
Content-Type: text/plain; charset="UTF-8"

Add functions that are called just before the per-section memmap
is initialized and just before the memmap page structures are
initialized. They are called sparse_vmemmap_init_nid_early and
sparse_vmemmap_init_nid_late, respectively.

This allows for mm subsystems to add calls to initialize memmap
and page structures in a specific way, if using SPARSEMEM_VMEMMAP.
Specifically, hugetlb can pre-HVO bootmem allocated pages that
way, so that no time and resources are wasted on allocating vmemmap
pages, only to free them later (and possibly unnecessarily running
the system out of memory in the process).

Refactor some code and export a few convenience functions for
external use.

In sparse_init_nid, skip any sections that are already initialized,
e.g. they have been initialized by sparse_vmemmap_init_nid_early
already.

The hugetlb code to use these functions will be added in a later
commit.

Export section_map_size, as any alternate memmap init code
will want to use it.

THe config option to enable this is SPARSEMEM_VMEMMAP_PREINIT,
which is dependent on and architecture-specific option,
ARCH_WANT_SPARSEMEM_VMEMMAP_PREINIT. This is done because
a section flag is used, and the number of flags available
is architecture-dependent (see mmzone.h). Architecures can
decide if there is room for the flag and enable the option.
Fortunately, as of right now, all sparse vmemmap using
architectures do have room.

Signed-off-by: Frank van der Linden <fvdl@google.com>
---
 include/linux/mm.h     |  1 +
 include/linux/mmzone.h | 35 +++++++++++++++++
 mm/Kconfig             |  8 ++++
 mm/bootmem_info.c      |  4 +-
 mm/mm_init.c           |  3 ++
 mm/sparse-vmemmap.c    | 23 +++++++++++
 mm/sparse.c            | 87 ++++++++++++++++++++++++++++++++----------
 7 files changed, 139 insertions(+), 22 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 6dfc41b461af..df83653ed6e3 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3828,6 +3828,7 @@ static inline void print_vma_addr(char *prefix, unsigned long rip)
 #endif
 
 void *sparse_buffer_alloc(unsigned long size);
+unsigned long section_map_size(void);
 struct page * __populate_section_memmap(unsigned long pfn,
 		unsigned long nr_pages, int nid, struct vmem_altmap *altmap,
 		struct dev_pagemap *pgmap);
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 9540b41894da..44ecb2f90db4 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -1933,6 +1933,9 @@ enum {
 	SECTION_IS_EARLY_BIT,
 #ifdef CONFIG_ZONE_DEVICE
 	SECTION_TAINT_ZONE_DEVICE_BIT,
+#endif
+#ifdef CONFIG_SPARSEMEM_VMEMMAP_PREINIT
+	SECTION_IS_VMEMMAP_PREINIT_BIT,
 #endif
 	SECTION_MAP_LAST_BIT,
 };
@@ -1944,6 +1947,9 @@ enum {
 #ifdef CONFIG_ZONE_DEVICE
 #define SECTION_TAINT_ZONE_DEVICE	BIT(SECTION_TAINT_ZONE_DEVICE_BIT)
 #endif
+#ifdef CONFIG_SPARSEMEM_VMEMMAP_PREINIT
+#define SECTION_IS_VMEMMAP_PREINIT	BIT(SECTION_IS_VMEMMAP_PREINIT_BIT)
+#endif
 #define SECTION_MAP_MASK		(~(BIT(SECTION_MAP_LAST_BIT) - 1))
 #define SECTION_NID_SHIFT		SECTION_MAP_LAST_BIT
 
@@ -1998,6 +2004,30 @@ static inline int online_device_section(struct mem_section *section)
 }
 #endif
 
+#ifdef CONFIG_SPARSEMEM_VMEMMAP_PREINIT
+static inline int preinited_vmemmap_section(struct mem_section *section)
+{
+	return (section &&
+		(section->section_mem_map & SECTION_IS_VMEMMAP_PREINIT));
+}
+
+void sparse_vmemmap_init_nid_early(int nid);
+void sparse_vmemmap_init_nid_late(int nid);
+
+#else
+static inline int preinited_vmemmap_section(struct mem_section *section)
+{
+	return 0;
+}
+static inline void sparse_vmemmap_init_nid_early(int nid)
+{
+}
+
+static inline void sparse_vmemmap_init_nid_late(int nid)
+{
+}
+#endif
+
 static inline int online_section_nr(unsigned long nr)
 {
 	return online_section(__nr_to_section(nr));
@@ -2035,6 +2065,9 @@ static inline int pfn_section_valid(struct mem_section *ms, unsigned long pfn)
 }
 #endif
 
+void sparse_init_early_section(int nid, struct page *map, unsigned long pnum,
+			       unsigned long flags);
+
 #ifndef CONFIG_HAVE_ARCH_PFN_VALID
 /**
  * pfn_valid - check if there is a valid memory map entry for a PFN
@@ -2116,6 +2149,8 @@ void sparse_init(void);
 #else
 #define sparse_init()	do {} while (0)
 #define sparse_index_init(_sec, _nid)  do {} while (0)
+#define sparse_vmemmap_init_nid_early(_nid, _use) do {} while (0)
+#define sparse_vmemmap_init_nid_late(_nid) do {} while (0)
 #define pfn_in_present_section pfn_valid
 #define subsection_map_init(_pfn, _nr_pages) do {} while (0)
 #endif /* CONFIG_SPARSEMEM */
diff --git a/mm/Kconfig b/mm/Kconfig
index 1b501db06417..f984dd928ce7 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -489,6 +489,14 @@ config SPARSEMEM_VMEMMAP
 	  SPARSEMEM_VMEMMAP uses a virtually mapped memmap to optimise
 	  pfn_to_page and page_to_pfn operations.  This is the most
 	  efficient option when sufficient kernel resources are available.
+
+config ARCH_WANT_SPARSEMEM_VMEMMAP_PREINIT
+	bool
+
+config SPARSEMEM_VMEMMAP_PREINIT
+	bool "Early init of sparse memory virtual memmap"
+	depends on SPARSEMEM_VMEMMAP && ARCH_WANT_SPARSEMEM_VMEMMAP_PREINIT
+	default y
 #
 # Select this config option from the architecture Kconfig, if it is preferred
 # to enable the feature of HugeTLB/dev_dax vmemmap optimization.
diff --git a/mm/bootmem_info.c b/mm/bootmem_info.c
index 95f288169a38..b0e2a9fa641f 100644
--- a/mm/bootmem_info.c
+++ b/mm/bootmem_info.c
@@ -88,7 +88,9 @@ static void __init register_page_bootmem_info_section(unsigned long start_pfn)
 
 	memmap = sparse_decode_mem_map(ms->section_mem_map, section_nr);
 
-	register_page_bootmem_memmap(section_nr, memmap, PAGES_PER_SECTION);
+	if (!preinited_vmemmap_section(ms))
+		register_page_bootmem_memmap(section_nr, memmap,
+				PAGES_PER_SECTION);
 
 	usage = ms->usage;
 	page = virt_to_page(usage);
diff --git a/mm/mm_init.c b/mm/mm_init.c
index d2dee53e95dd..9f1e41c3dde6 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -1862,6 +1862,9 @@ void __init free_area_init(unsigned long *max_zone_pfn)
 		}
 	}
 
+	for_each_node_state(nid, N_MEMORY)
+		sparse_vmemmap_init_nid_late(nid);
+
 	calc_nr_kernel_pages();
 	memmap_init();
 
diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index 3287ebadd167..8751c46c35e4 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -470,3 +470,26 @@ struct page * __meminit __populate_section_memmap(unsigned long pfn,
 
 	return pfn_to_page(pfn);
 }
+
+#ifdef CONFIG_SPARSEMEM_VMEMMAP_PREINIT
+/*
+ * This is called just before initializing sections for a NUMA node.
+ * Any special initialization that needs to be done before the
+ * generic initialization can be done from here. Sections that
+ * are initialized in hooks called from here will be skipped by
+ * the generic initialization.
+ */
+void __init sparse_vmemmap_init_nid_early(int nid)
+{
+}
+
+/*
+ * This is called just before the initialization of page structures
+ * through memmap_init. Zones are now initialized, so any work that
+ * needs to be done that needs zone information can be done from
+ * here.
+ */
+void __init sparse_vmemmap_init_nid_late(int nid)
+{
+}
+#endif
diff --git a/mm/sparse.c b/mm/sparse.c
index 133b033d0cba..ee0234a77c7f 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -408,13 +408,13 @@ static void __init check_usemap_section_nr(int nid,
 #endif /* CONFIG_MEMORY_HOTREMOVE */
 
 #ifdef CONFIG_SPARSEMEM_VMEMMAP
-static unsigned long __init section_map_size(void)
+unsigned long __init section_map_size(void)
 {
 	return ALIGN(sizeof(struct page) * PAGES_PER_SECTION, PMD_SIZE);
 }
 
 #else
-static unsigned long __init section_map_size(void)
+unsigned long __init section_map_size(void)
 {
 	return PAGE_ALIGN(sizeof(struct page) * PAGES_PER_SECTION);
 }
@@ -495,6 +495,44 @@ void __weak __meminit vmemmap_populate_print_last(void)
 {
 }
 
+static void *sparse_usagebuf __meminitdata;
+static void *sparse_usagebuf_end __meminitdata;
+
+/*
+ * Helper function that is used for generic section initialization, and
+ * can also be used by any hooks added above.
+ */
+void __init sparse_init_early_section(int nid, struct page *map,
+				      unsigned long pnum, unsigned long flags)
+{
+	BUG_ON(!sparse_usagebuf || sparse_usagebuf >= sparse_usagebuf_end);
+	check_usemap_section_nr(nid, sparse_usagebuf);
+	sparse_init_one_section(__nr_to_section(pnum), pnum, map,
+			sparse_usagebuf, SECTION_IS_EARLY | flags);
+	sparse_usagebuf = (void *)sparse_usagebuf + mem_section_usage_size();
+}
+
+static int __init sparse_usage_init(int nid, unsigned long map_count)
+{
+	unsigned long size;
+
+	size = mem_section_usage_size() * map_count;
+	sparse_usagebuf = sparse_early_usemaps_alloc_pgdat_section(
+				NODE_DATA(nid), size);
+	if (!sparse_usagebuf) {
+		sparse_usagebuf_end = NULL;
+		return -ENOMEM;
+	}
+
+	sparse_usagebuf_end = sparse_usagebuf + size;
+	return 0;
+}
+
+static void __init sparse_usage_fini(void)
+{
+	sparse_usagebuf = sparse_usagebuf_end = NULL;
+}
+
 /*
  * Initialize sparse on a specific node. The node spans [pnum_begin, pnum_end)
  * And number of present sections in this node is map_count.
@@ -503,47 +541,54 @@ static void __init sparse_init_nid(int nid, unsigned long pnum_begin,
 				   unsigned long pnum_end,
 				   unsigned long map_count)
 {
-	struct mem_section_usage *usage;
 	unsigned long pnum;
 	struct page *map;
+	struct mem_section *ms;
 
-	usage = sparse_early_usemaps_alloc_pgdat_section(NODE_DATA(nid),
-			mem_section_usage_size() * map_count);
-	if (!usage) {
+	if (sparse_usage_init(nid, map_count)) {
 		pr_err("%s: node[%d] usemap allocation failed", __func__, nid);
 		goto failed;
 	}
+
 	sparse_buffer_init(map_count * section_map_size(), nid);
+
+	sparse_vmemmap_init_nid_early(nid);
+
 	for_each_present_section_nr(pnum_begin, pnum) {
 		unsigned long pfn = section_nr_to_pfn(pnum);
 
 		if (pnum >= pnum_end)
 			break;
 
-		map = __populate_section_memmap(pfn, PAGES_PER_SECTION,
-				nid, NULL, NULL);
-		if (!map) {
-			pr_err("%s: node[%d] memory map backing failed. Some memory will not be available.",
-			       __func__, nid);
-			pnum_begin = pnum;
-			sparse_buffer_fini();
-			goto failed;
+		ms = __nr_to_section(pnum);
+		if (!preinited_vmemmap_section(ms)) {
+			map = __populate_section_memmap(pfn, PAGES_PER_SECTION,
+					nid, NULL, NULL);
+			if (!map) {
+				pr_err("%s: node[%d] memory map backing failed. Some memory will not be available.",
+				       __func__, nid);
+				pnum_begin = pnum;
+				sparse_usage_fini();
+				sparse_buffer_fini();
+				goto failed;
+			}
+			sparse_init_early_section(nid, map, pnum, 0);
 		}
-		check_usemap_section_nr(nid, usage);
-		sparse_init_one_section(__nr_to_section(pnum), pnum, map, usage,
-				SECTION_IS_EARLY);
-		usage = (void *) usage + mem_section_usage_size();
 	}
+	sparse_usage_fini();
 	sparse_buffer_fini();
 	return;
 failed:
-	/* We failed to allocate, mark all the following pnums as not present */
+	/*
+	 * We failed to allocate, mark all the following pnums as not present,
+	 * except the ones already initialized earlier.
+	 */
 	for_each_present_section_nr(pnum_begin, pnum) {
-		struct mem_section *ms;
-
 		if (pnum >= pnum_end)
 			break;
 		ms = __nr_to_section(pnum);
+		if (!preinited_vmemmap_section(ms))
+			ms->section_mem_map = 0;
 		ms->section_mem_map = 0;
 	}
 }
-- 
2.48.1.601.g30ceb7b040-goog


