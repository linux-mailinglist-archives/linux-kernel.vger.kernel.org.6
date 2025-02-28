Return-Path: <linux-kernel+bounces-539157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9045A4A19D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 19:31:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2742E3BD343
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 18:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD62927FE7F;
	Fri, 28 Feb 2025 18:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zFtv06DN"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A886280A32
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 18:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740767403; cv=none; b=sLWN61pZtTfQxaqw6N/vHqKnQFWNXopDFsVCpOAbvPWRjzRfbVTtaQVUN9poOXgKsescsdXzNvg2pRGb6eteByA7ioJqqIg/1yNtD5xy3bLIaAtIpRJ9jgk/Qmvf/c7BeQbopo4EG7AlBLoMpYajuLs964o7mv+oNgVw7B4a14U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740767403; c=relaxed/simple;
	bh=N1ZEZ5EWBTufz6p6TrAGf/BGfWFVXcbKgteQC44BnMY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MDBDQ6OcmaYImruvpogHmbqDI0msDZQND6qhMWZKZkEqomIU3VHqDsi9AnQZmPgAc/jCY09OntsP2BBYm97ciOo91usoWaXr/S+ttBIh2oHf5YwAH7qvCOf27iOM4ABnztjGJS/5ZDmIxBdw35rWYPdGNceL9ESYTnXAm/wLOYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--fvdl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zFtv06DN; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--fvdl.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-22326da4c8eso46079235ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 10:30:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740767401; x=1741372201; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=e4fT3nl83EuvMS99kJHXSYdNG4GrpqXQFI3hJuJeA/Y=;
        b=zFtv06DNA65JtfHIrkIP81WhpjCJb3hdGwaGhaHzlFBPdDB6aP1wI9lNybsd5rEXui
         JmQuEgJVqXfWrJbu416yXoAnOvCl6ImnsWFSySkj+G3TwL1spda97eMR7KRNILvsRP4G
         LlVNsxfvFss0gnqB3ZKcTbSO0BVDanS9Z5YhPj/YGunSP64cqwsQi1Yq1/8dYXdpn0Q7
         2EFnrZozoLieJkaXpslqsToO0aix5SxwchyJ+lfot/uzvluZNX0Gfp6loTvLgIdPRCRL
         gGb5MGwD1jrpxgiGzL47rJtxoOWfSSfzyJFrLrLpi7dMZrhtOn8nYR7mzOCN7RJFbLwc
         oVkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740767401; x=1741372201;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e4fT3nl83EuvMS99kJHXSYdNG4GrpqXQFI3hJuJeA/Y=;
        b=iOHMyy9JOMTKOY0bgbmnbJlr8ec69NYXcgWwDQrg+CsLWEV1/noBpeKX3R71t3TcyN
         j4YGacv8YS5P1NtrqJkgmpebzuYlTvkJYcJaqABbRUV7wrpU8vTeTsspt7NHmWhKMSYB
         RYd0kiKzu6psBoWNyX3LM2fz1NxKvfHn39LHIba+Z/tbEL4DWLy6VN+N/f/JtJAzZLbH
         GPzp7bY3SdsAG6TdR2fmw5LYlO8dFAobZ78u+85KPzFhQvjK1Rb4u/DqGGIS/PkidCZv
         ryinV+vVU+LIF8m9OxbZFENON5nfNGLOX8ILPNmaKIhyZCVy13ONM4e0UUvKrdTXokW3
         1emw==
X-Forwarded-Encrypted: i=1; AJvYcCVssH1uSiPoOnoB2U/w161OLDZeidJQJ/5LihcCYEDiFmm6Ae1xBJVedBbXrBi8WU7XwP0MWY5nwY4jIvQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDunNIfPEs1wqOZliiiGyMj//dJkh9ydhlULtxP2kFxX8yp8Bp
	oVpFrHzPWdCfs0nHFcSVeGaJI21eb8phGoAtvX21n0j9YejVGy+CJTy1WwMM9v+rQtIFVQ==
X-Google-Smtp-Source: AGHT+IGUAIYvgIF+BtbI5pOnkTpsWOz6nQUUqftXrAjuMRZR1VXxhKSR8/d7Qe0qOmWXJT+LI7VzDoQF
X-Received: from pge11.prod.google.com ([2002:a05:6a02:2d0b:b0:ad5:4ccd:a656])
 (user=fvdl job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:2449:b0:1ee:d418:f754
 with SMTP id adf61e73a8af0-1f2f4e5a4b3mr8377121637.40.1740767400717; Fri, 28
 Feb 2025 10:30:00 -0800 (PST)
Date: Fri, 28 Feb 2025 18:29:08 +0000
In-Reply-To: <20250228182928.2645936-1-fvdl@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250228182928.2645936-1-fvdl@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250228182928.2645936-8-fvdl@google.com>
Subject: [PATCH v5 07/27] mm/hugetlb: convert cmdline parameters from setup to early
From: Frank van der Linden <fvdl@google.com>
To: akpm@linux-foundation.org, muchun.song@linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Cc: yuzhao@google.com, usamaarif642@gmail.com, joao.m.martins@oracle.com, 
	roman.gushchin@linux.dev, ziy@nvidia.com, david@redhat.com, 
	Frank van der Linden <fvdl@google.com>
Content-Type: text/plain; charset="UTF-8"

Convert the cmdline parameters (hugepagesz, hugepages,
default_hugepagesz and hugetlb_free_vmemmap) to early
parameters.

Since parse_early_param might run before MMU setups
on some platforms (powerpc), validation of huge page
sizes as specified in command line parameters would
fail. So instead, for the hstate-related values,
just record the them and parse them on demand, from
hugetlb_bootmem_alloc.

The allocation of hugetlb bootmem pages is now done in
hugetlb_bootmem_alloc, which is called explicitly at the
start of mm_core_init().  core_initcall would be too late,
as that happens with memblock already torn down.

This change will allow earlier allocation and initialization
of bootmem hugetlb pages later on.

No functional change intended.

Signed-off-by: Frank van der Linden <fvdl@google.com>
---
 .../admin-guide/kernel-parameters.txt         |  14 +-
 include/linux/hugetlb.h                       |   6 +
 mm/hugetlb.c                                  | 133 ++++++++++++++----
 mm/hugetlb_vmemmap.c                          |   6 +-
 mm/mm_init.c                                  |   3 +
 5 files changed, 126 insertions(+), 36 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index fb8752b42ec8..ae21d911d1c7 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1861,7 +1861,7 @@
 	hpet_mmap=	[X86, HPET_MMAP] Allow userspace to mmap HPET
 			registers.  Default set by CONFIG_HPET_MMAP_DEFAULT.
 
-	hugepages=	[HW] Number of HugeTLB pages to allocate at boot.
+	hugepages=	[HW,EARLY] Number of HugeTLB pages to allocate at boot.
 			If this follows hugepagesz (below), it specifies
 			the number of pages of hugepagesz to be allocated.
 			If this is the first HugeTLB parameter on the command
@@ -1873,12 +1873,12 @@
 				<node>:<integer>[,<node>:<integer>]
 
 	hugepagesz=
-			[HW] The size of the HugeTLB pages.  This is used in
-			conjunction with hugepages (above) to allocate huge
-			pages of a specific size at boot.  The pair
-			hugepagesz=X hugepages=Y can be specified once for
-			each supported huge page size. Huge page sizes are
-			architecture dependent.  See also
+			[HW,EARLY] The size of the HugeTLB pages.  This is
+			used in conjunction with hugepages (above) to
+			allocate huge pages of a specific size at boot. The
+			pair hugepagesz=X hugepages=Y can be specified once
+			for each supported huge page size. Huge page sizes
+			are architecture dependent. See also
 			Documentation/admin-guide/mm/hugetlbpage.rst.
 			Format: size[KMG]
 
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index ec8c0ccc8f95..9cd7c9dacb88 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -174,6 +174,8 @@ struct address_space *hugetlb_folio_mapping_lock_write(struct folio *folio);
 extern int sysctl_hugetlb_shm_group;
 extern struct list_head huge_boot_pages[MAX_NUMNODES];
 
+void hugetlb_bootmem_alloc(void);
+
 /* arch callbacks */
 
 #ifndef CONFIG_HIGHPTE
@@ -1250,6 +1252,10 @@ static inline bool hugetlbfs_pagecache_present(
 {
 	return false;
 }
+
+static inline void hugetlb_bootmem_alloc(void)
+{
+}
 #endif	/* CONFIG_HUGETLB_PAGE */
 
 static inline spinlock_t *huge_pte_lock(struct hstate *h,
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 0592c076cd36..1a200f89e21a 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -40,6 +40,7 @@
 #include <asm/page.h>
 #include <asm/pgalloc.h>
 #include <asm/tlb.h>
+#include <asm/setup.h>
 
 #include <linux/io.h>
 #include <linux/hugetlb.h>
@@ -62,6 +63,24 @@ static unsigned long hugetlb_cma_size __initdata;
 
 __initdata struct list_head huge_boot_pages[MAX_NUMNODES];
 
+/*
+ * Due to ordering constraints across the init code for various
+ * architectures, hugetlb hstate cmdline parameters can't simply
+ * be early_param. early_param might call the setup function
+ * before valid hugetlb page sizes are determined, leading to
+ * incorrect rejection of valid hugepagesz= options.
+ *
+ * So, record the parameters early and consume them whenever the
+ * init code is ready for them, by calling hugetlb_parse_params().
+ */
+
+/* one (hugepagesz=,hugepages=) pair per hstate, one default_hugepagesz */
+#define HUGE_MAX_CMDLINE_ARGS	(2 * HUGE_MAX_HSTATE + 1)
+struct hugetlb_cmdline {
+	char *val;
+	int (*setup)(char *val);
+};
+
 /* for command line parsing */
 static struct hstate * __initdata parsed_hstate;
 static unsigned long __initdata default_hstate_max_huge_pages;
@@ -69,6 +88,20 @@ static bool __initdata parsed_valid_hugepagesz = true;
 static bool __initdata parsed_default_hugepagesz;
 static unsigned int default_hugepages_in_node[MAX_NUMNODES] __initdata;
 
+static char hstate_cmdline_buf[COMMAND_LINE_SIZE] __initdata;
+static int hstate_cmdline_index __initdata;
+static struct hugetlb_cmdline hugetlb_params[HUGE_MAX_CMDLINE_ARGS] __initdata;
+static int hugetlb_param_index __initdata;
+static __init int hugetlb_add_param(char *s, int (*setup)(char *val));
+static __init void hugetlb_parse_params(void);
+
+#define hugetlb_early_param(str, func) \
+static __init int func##args(char *s) \
+{ \
+	return hugetlb_add_param(s, func); \
+} \
+early_param(str, func##args)
+
 /*
  * Protects updates to hugepage_freelists, hugepage_activelist, nr_huge_pages,
  * free_huge_pages, and surplus_huge_pages.
@@ -3484,6 +3517,8 @@ static void __init hugetlb_hstate_alloc_pages(struct hstate *h)
 
 		for (i = 0; i < MAX_NUMNODES; i++)
 			INIT_LIST_HEAD(&huge_boot_pages[i]);
+		h->next_nid_to_alloc = first_online_node;
+		h->next_nid_to_free = first_online_node;
 		initialized = true;
 	}
 
@@ -4546,8 +4581,6 @@ void __init hugetlb_add_hstate(unsigned int order)
 	for (i = 0; i < MAX_NUMNODES; ++i)
 		INIT_LIST_HEAD(&h->hugepage_freelists[i]);
 	INIT_LIST_HEAD(&h->hugepage_activelist);
-	h->next_nid_to_alloc = first_online_node;
-	h->next_nid_to_free = first_online_node;
 	snprintf(h->name, HSTATE_NAME_LEN, "hugepages-%lukB",
 					huge_page_size(h)/SZ_1K);
 
@@ -4572,6 +4605,42 @@ static void __init hugepages_clear_pages_in_node(void)
 	}
 }
 
+static __init int hugetlb_add_param(char *s, int (*setup)(char *))
+{
+	size_t len;
+	char *p;
+
+	if (hugetlb_param_index >= HUGE_MAX_CMDLINE_ARGS)
+		return -EINVAL;
+
+	len = strlen(s) + 1;
+	if (len + hstate_cmdline_index > sizeof(hstate_cmdline_buf))
+		return -EINVAL;
+
+	p = &hstate_cmdline_buf[hstate_cmdline_index];
+	memcpy(p, s, len);
+	hstate_cmdline_index += len;
+
+	hugetlb_params[hugetlb_param_index].val = p;
+	hugetlb_params[hugetlb_param_index].setup = setup;
+
+	hugetlb_param_index++;
+
+	return 0;
+}
+
+static __init void hugetlb_parse_params(void)
+{
+	int i;
+	struct hugetlb_cmdline *hcp;
+
+	for (i = 0; i < hugetlb_param_index; i++) {
+		hcp = &hugetlb_params[i];
+
+		hcp->setup(hcp->val);
+	}
+}
+
 /*
  * hugepages command line processing
  * hugepages normally follows a valid hugepagsz or default_hugepagsz
@@ -4591,7 +4660,7 @@ static int __init hugepages_setup(char *s)
 	if (!parsed_valid_hugepagesz) {
 		pr_warn("HugeTLB: hugepages=%s does not follow a valid hugepagesz, ignoring\n", s);
 		parsed_valid_hugepagesz = true;
-		return 1;
+		return -EINVAL;
 	}
 
 	/*
@@ -4645,24 +4714,16 @@ static int __init hugepages_setup(char *s)
 		}
 	}
 
-	/*
-	 * Global state is always initialized later in hugetlb_init.
-	 * But we need to allocate gigantic hstates here early to still
-	 * use the bootmem allocator.
-	 */
-	if (hugetlb_max_hstate && hstate_is_gigantic(parsed_hstate))
-		hugetlb_hstate_alloc_pages(parsed_hstate);
-
 	last_mhp = mhp;
 
-	return 1;
+	return 0;
 
 invalid:
 	pr_warn("HugeTLB: Invalid hugepages parameter %s\n", p);
 	hugepages_clear_pages_in_node();
-	return 1;
+	return -EINVAL;
 }
-__setup("hugepages=", hugepages_setup);
+hugetlb_early_param("hugepages", hugepages_setup);
 
 /*
  * hugepagesz command line processing
@@ -4681,7 +4742,7 @@ static int __init hugepagesz_setup(char *s)
 
 	if (!arch_hugetlb_valid_size(size)) {
 		pr_err("HugeTLB: unsupported hugepagesz=%s\n", s);
-		return 1;
+		return -EINVAL;
 	}
 
 	h = size_to_hstate(size);
@@ -4696,7 +4757,7 @@ static int __init hugepagesz_setup(char *s)
 		if (!parsed_default_hugepagesz ||  h != &default_hstate ||
 		    default_hstate.max_huge_pages) {
 			pr_warn("HugeTLB: hugepagesz=%s specified twice, ignoring\n", s);
-			return 1;
+			return -EINVAL;
 		}
 
 		/*
@@ -4706,14 +4767,14 @@ static int __init hugepagesz_setup(char *s)
 		 */
 		parsed_hstate = h;
 		parsed_valid_hugepagesz = true;
-		return 1;
+		return 0;
 	}
 
 	hugetlb_add_hstate(ilog2(size) - PAGE_SHIFT);
 	parsed_valid_hugepagesz = true;
-	return 1;
+	return 0;
 }
-__setup("hugepagesz=", hugepagesz_setup);
+hugetlb_early_param("hugepagesz", hugepagesz_setup);
 
 /*
  * default_hugepagesz command line input
@@ -4727,14 +4788,14 @@ static int __init default_hugepagesz_setup(char *s)
 	parsed_valid_hugepagesz = false;
 	if (parsed_default_hugepagesz) {
 		pr_err("HugeTLB: default_hugepagesz previously specified, ignoring %s\n", s);
-		return 1;
+		return -EINVAL;
 	}
 
 	size = (unsigned long)memparse(s, NULL);
 
 	if (!arch_hugetlb_valid_size(size)) {
 		pr_err("HugeTLB: unsupported default_hugepagesz=%s\n", s);
-		return 1;
+		return -EINVAL;
 	}
 
 	hugetlb_add_hstate(ilog2(size) - PAGE_SHIFT);
@@ -4751,17 +4812,33 @@ static int __init default_hugepagesz_setup(char *s)
 	 */
 	if (default_hstate_max_huge_pages) {
 		default_hstate.max_huge_pages = default_hstate_max_huge_pages;
-		for_each_online_node(i)
-			default_hstate.max_huge_pages_node[i] =
-				default_hugepages_in_node[i];
-		if (hstate_is_gigantic(&default_hstate))
-			hugetlb_hstate_alloc_pages(&default_hstate);
+		/*
+		 * Since this is an early parameter, we can't check
+		 * NUMA node state yet, so loop through MAX_NUMNODES.
+		 */
+		for (i = 0; i < MAX_NUMNODES; i++) {
+			if (default_hugepages_in_node[i] != 0)
+				default_hstate.max_huge_pages_node[i] =
+					default_hugepages_in_node[i];
+		}
 		default_hstate_max_huge_pages = 0;
 	}
 
-	return 1;
+	return 0;
+}
+hugetlb_early_param("default_hugepagesz", default_hugepagesz_setup);
+
+void __init hugetlb_bootmem_alloc(void)
+{
+	struct hstate *h;
+
+	hugetlb_parse_params();
+
+	for_each_hstate(h) {
+		if (hstate_is_gigantic(h))
+			hugetlb_hstate_alloc_pages(h);
+	}
 }
-__setup("default_hugepagesz=", default_hugepagesz_setup);
 
 static unsigned int allowed_mems_nr(struct hstate *h)
 {
diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index 7735972add01..5b484758f813 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -444,7 +444,11 @@ DEFINE_STATIC_KEY_FALSE(hugetlb_optimize_vmemmap_key);
 EXPORT_SYMBOL(hugetlb_optimize_vmemmap_key);
 
 static bool vmemmap_optimize_enabled = IS_ENABLED(CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP_DEFAULT_ON);
-core_param(hugetlb_free_vmemmap, vmemmap_optimize_enabled, bool, 0);
+static int __init hugetlb_vmemmap_optimize_param(char *buf)
+{
+	return kstrtobool(buf, &vmemmap_optimize_enabled);
+}
+early_param("hugetlb_free_vmemmap", hugetlb_vmemmap_optimize_param);
 
 static int __hugetlb_vmemmap_restore_folio(const struct hstate *h,
 					   struct folio *folio, unsigned long flags)
diff --git a/mm/mm_init.c b/mm/mm_init.c
index 2630cc30147e..d2dee53e95dd 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -30,6 +30,7 @@
 #include <linux/crash_dump.h>
 #include <linux/execmem.h>
 #include <linux/vmstat.h>
+#include <linux/hugetlb.h>
 #include "internal.h"
 #include "slab.h"
 #include "shuffle.h"
@@ -2641,6 +2642,8 @@ static void __init mem_init_print_info(void)
  */
 void __init mm_core_init(void)
 {
+	hugetlb_bootmem_alloc();
+
 	/* Initializations relying on SMP setup */
 	BUILD_BUG_ON(MAX_ZONELISTS > 2);
 	build_all_zonelists(NULL);
-- 
2.48.1.711.g2feabab25a-goog


