Return-Path: <linux-kernel+bounces-520050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B81EDA3A51E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 19:18:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6ECD41892779
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 18:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7828027FE71;
	Tue, 18 Feb 2025 18:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yrHSrx6n"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9139327425C
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 18:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739902640; cv=none; b=uEKlX5N4w7dPuPCS06/usZCNDohHePpjAPfjZyNk+r0nBqKt8qA4FNQRJ5I0eKC490XojSHEdygzFVgaWiksBrtLeOcJi28cCWZ181ZmDkWt8pJCvInRVpT2obwSRvIbWDJ0oMOGiGmMTDOHa/U9NBk8nEyVhDIJ7zMvbxgA9sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739902640; c=relaxed/simple;
	bh=ALw0U8OqyPV9/O+UnOpEwvwgepNHzoI24eLYizT7Oak=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qnpQGNik6lO49HxLS4FydI0NDNcR7ZxVv3Zi5/11Nb4YGI1+Xq6XlW09DbwfImnXADXL/INErvtVVeCb8DkUVDCmlTqNCjKlxu8uLdeG9T8S+GjTl9ZNBNeRyi2S1F4rZg+PEDoBlmInZzknvn9+BbaFw34O2dYlPjOqRNH1O/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--fvdl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yrHSrx6n; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--fvdl.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2fc5a9f18afso5558077a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 10:17:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739902638; x=1740507438; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UzfWv9BqKfCaTLcusLA/6ZlD1dELHDMIUuMG+2mtrpE=;
        b=yrHSrx6nKrhsAQnohg9W9MleBKdhbVJVWpJtT//GZyV2L9SKqzmBmxv+ccVpeCbCdq
         RqVgE6qLkdrAcu/rk5Exnbaen9IWMX2Lg478EvtIaPgtWcYy3phVgZhBbHk0unPv3g2A
         AumqlcZj7wCjtxw3mmSo4FP0yZGKlJ4xhjxss6Rmejn7KmVz4f4t4s5eFgbA6xJPSZKL
         LmBZ5OH6Bl5Rpp2MFYJFmAzlFosYSvS57TzVBOWmFo8iZ9DOorf+6tPHwruutZxGVYKd
         U/29NOZGEGAA9nojbNJDh83rDU2azkEZY+5ciCf0MXRya24wWnhIZ3COiWa6YvW64Lcl
         8Osw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739902638; x=1740507438;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UzfWv9BqKfCaTLcusLA/6ZlD1dELHDMIUuMG+2mtrpE=;
        b=hVAxN88lLZd98AuYwD0MU4wssrkFaYqwwosb+G8rsJsyMTFxbwiXctuiXqxJ4w3YZX
         OMiyoEVixGbgykozxDmtXthYZtUxz9HJ5+k9z98V+XqAsrd37GBhxsoDTnB0NFEhbNzk
         id54hGKiaMtwYBO1F4gYHf6FJR8X90LWWmAqUTA+c+vVl56+HXQ4PNQxL3o3HMgHdsda
         IXhiKUg6TmPq5dtxItwTiTwAqXijEKOcWj2dE46mUDYR2vz9/VmzoBsTqKYlleP/NJXC
         5Gob6RqPekMV2E7XlC63UuXgnRIUfXVFRtzKMYKtNgWUqCMFxFEpcC+OBk+42pzH+VKi
         NDPg==
X-Forwarded-Encrypted: i=1; AJvYcCUgOVepkht1UT6FMw3wfitHwXEfpf54/6MQXjRHyMWihwlBos1JYs9py/n+oX1LsIWARBjFrb9frG2hHHg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZQLTvxbHAFFr+BoxKIoX/FUJz/pij6utU6DZX1kdNYhKofclb
	PBb2hxQbcOQbL1zoiQchByC6VkCCCUDNW+YqPtjZOMdOMx9GbMTf6zoH64Up8fQfPUBsYg==
X-Google-Smtp-Source: AGHT+IHa8Y+sJQ8IwQWCMO2RNbH8G/VryDlpbdJULvNEszvFgqi1s498qDm7c8r07sVjg2DWswKH4xZf
X-Received: from pfbga22.prod.google.com ([2002:a05:6a00:6216:b0:730:8ca0:1f9b])
 (user=fvdl job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2e97:b0:730:87cf:a7cd
 with SMTP id d2e1a72fcca58-7329de6ecbdmr585107b3a.8.1739902637790; Tue, 18
 Feb 2025 10:17:17 -0800 (PST)
Date: Tue, 18 Feb 2025 18:16:35 +0000
In-Reply-To: <20250218181656.207178-1-fvdl@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250218181656.207178-1-fvdl@google.com>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <20250218181656.207178-8-fvdl@google.com>
Subject: [PATCH v4 07/27] mm/hugetlb: convert cmdline parameters from setup to early
From: Frank van der Linden <fvdl@google.com>
To: akpm@linux-foundation.org, muchun.song@linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Cc: yuzhao@google.com, usamaarif642@gmail.com, joao.m.martins@oracle.com, 
	roman.gushchin@linux.dev, Frank van der Linden <fvdl@google.com>
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
2.48.1.601.g30ceb7b040-goog


