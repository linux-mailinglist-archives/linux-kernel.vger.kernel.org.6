Return-Path: <linux-kernel+bounces-378552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 248C09AD22F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 19:09:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBD072872C6
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 17:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5FC11CFECE;
	Wed, 23 Oct 2024 17:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Iq53X5Zt"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF1D91D0173
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 17:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729703292; cv=none; b=mJc08jakGu2gPCABjKOvVXYc3jF0+d5CYMxF2Ca/i62JTBJ/6ysEmX+VxdkVuK3SxUcZlE0eqPAcZEa9bBtqkSyIWkRyUL2eCnnmfr3C8MC5PVmCQDFqvs1foRhNg0c/2uZpsNTrpxDT1xZTbn0/U5y2StLflHBnjfrbYwxXtZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729703292; c=relaxed/simple;
	bh=rSPNRF2fLgd2fBpGTA6Y9m3Pra5kFODk3NqDZER5+jw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=k7oVnToyCt+D7aT9pHUawQv95A4RCFsFA71TZnXz6eWHOKD+o9KBb2tScxRNhRXpTCoaftsPRyFyrBaAaTIQm7dke4A/HtxI9w5BDEpfe9hY/R7I2MxB+l9PMIw0cDe+IjJ+pgo4Fb7R+rWeCvPkupltio9b+hkTS97uKIAzhoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Iq53X5Zt; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e3204db795so104968077b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 10:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729703290; x=1730308090; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=H2ux1AvVUg/u2T/gNvjmDC0vmkvp+tl4Ubd3hF2zga4=;
        b=Iq53X5ZtpUJMTtXIkO10di2uXOkdtqAqzUyER7tElcfV0RXgZJTp261b3h59k42JAa
         VSnCOr5T01ko8qcFIBUbq+Qn/pgU9PYGKIuFuo4t9Yl/jMWba7OM0xspPVAvEN/BqL3a
         kUkugYZYHIBsFWha6owlmPZ24SmYFe1buLhNw2KGzKTMF+hH9ZiUlhv5ugTIneUgFvxz
         rHGrHDuHHGgiE4z0l7ixQ9BaaRD/EPKlbz+U/YO6DT3XqnENGuxG0S/DI79JfJq9O3Ig
         piepwR9Ffk1CDAl5ZzxR4pWI58CSnyWNMLsSGNKJZUNlX8kZUGcSmYXXQAPgd43Swgrw
         umzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729703290; x=1730308090;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H2ux1AvVUg/u2T/gNvjmDC0vmkvp+tl4Ubd3hF2zga4=;
        b=MXZPwSHiKe+3vT/5Xud5Y7mRGP5czZBzNSoeg1I16WDtq24KfkCqON7L5PwXagpdKt
         Tj602IPLXzXVU8l4ZEhzcedVLVMKaguhfPnQYj1+gj6fhI9UuIwj+BTTBAMpGpW9kZCm
         23aubMXn/9rZmt9FBO0Bn+h8sDxCszmM6tXySdIoq2ZebWMPPPrTwYYZriFzP1/lNLC2
         25BMGoIm0/sve4BsUNiwnuMUuAyi0G2K3mQuPjSbYnEiQCUXcCTrDYZEN1pYmnHkD1tL
         CsB4PDo5pWsyzdXTizavKGoqpxEbU1h1EsvwgIVaP1f+94Qp+2Xax+t1ua+Rp+XqlSxz
         +5ug==
X-Forwarded-Encrypted: i=1; AJvYcCX8vQwGhs5Zsut/3B0EvF/kAFFtJnWUFpw8Fsk8tcDR2VthVps4qW4TSNcwJqB9VAHmAdBPQGoYDxZSefE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlztuD2YDJ+mQBDscR8tgahToi04pGf7suE4pFE9SJybV90Vgl
	Rb1i1B40gHxwil3uzwFvdeHME2DghMdEbVqLUpk1FsAMFDmzYpzc4+KSB9noDqxb7XERGRtuTKb
	urA==
X-Google-Smtp-Source: AGHT+IGGx5cwUMRbaaaRLBx9ozQm5nYkieFYXts2XJ8fpTDFGg4nxvLC1BvVBA4+mhBqSvprWgkBELkrSzs=
X-Received: from surenb-desktop.mtv.corp.google.com ([2a00:79e0:2e3f:8:a087:59b9:198a:c44c])
 (user=surenb job=sendgmr) by 2002:a05:690c:4b03:b0:6b0:d571:3540 with SMTP id
 00721157ae682-6e7f0f97164mr929077b3.6.1729703289927; Wed, 23 Oct 2024
 10:08:09 -0700 (PDT)
Date: Wed, 23 Oct 2024 10:07:57 -0700
In-Reply-To: <20241023170759.999909-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241023170759.999909-1-surenb@google.com>
X-Mailer: git-send-email 2.47.0.105.g07ac214952-goog
Message-ID: <20241023170759.999909-5-surenb@google.com>
Subject: [PATCH v4 4/6] alloc_tag: populate memory for module tags as needed
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: kent.overstreet@linux.dev, corbet@lwn.net, arnd@arndb.de, 
	mcgrof@kernel.org, rppt@kernel.org, paulmck@kernel.org, thuth@redhat.com, 
	tglx@linutronix.de, bp@alien8.de, xiongwei.song@windriver.com, 
	ardb@kernel.org, david@redhat.com, vbabka@suse.cz, mhocko@suse.com, 
	hannes@cmpxchg.org, roman.gushchin@linux.dev, dave@stgolabs.net, 
	willy@infradead.org, liam.howlett@oracle.com, pasha.tatashin@soleen.com, 
	souravpanda@google.com, keescook@chromium.org, dennis@kernel.org, 
	jhubbard@nvidia.com, urezki@gmail.com, hch@infradead.org, petr.pavlu@suse.com, 
	samitolvanen@google.com, da.gomez@samsung.com, yuzhao@google.com, 
	vvvvvv@google.com, rostedt@goodmis.org, iamjoonsoo.kim@lge.com, 
	rientjes@google.com, minchan@google.com, kaleshsingh@google.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-mm@kvack.org, 
	maple-tree@lists.infradead.org, linux-modules@vger.kernel.org, 
	kernel-team@android.com, surenb@google.com
Content-Type: text/plain; charset="UTF-8"

The memory reserved for module tags does not need to be backed by
physical pages until there are tags to store there. Change the way
we reserve this memory to allocate only virtual area for the tags
and populate it with physical pages as needed when we load a module.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 include/linux/execmem.h | 10 ++++++
 include/linux/vmalloc.h |  3 ++
 lib/alloc_tag.c         | 73 ++++++++++++++++++++++++++++++++++++-----
 mm/execmem.c            | 16 +++++++++
 mm/internal.h           |  6 ++++
 mm/vmalloc.c            |  4 +--
 6 files changed, 101 insertions(+), 11 deletions(-)

diff --git a/include/linux/execmem.h b/include/linux/execmem.h
index 1517fa196bf7..5a5e2917f870 100644
--- a/include/linux/execmem.h
+++ b/include/linux/execmem.h
@@ -139,6 +139,16 @@ void *execmem_alloc(enum execmem_type type, size_t size);
  */
 void execmem_free(void *ptr);
 
+/**
+ * execmem_vmap - create virtual mapping for EXECMEM_MODULE_DATA memory
+ * @size: size of the virtual mapping in bytes
+ *
+ * Maps virtually contiguous area in the range suitable for EXECMEM_MODULE_DATA.
+ *
+ * Return: the area descriptor on success or %NULL on failure.
+ */
+struct vm_struct *execmem_vmap(size_t size);
+
 /**
  * execmem_update_copy - copy an update to executable memory
  * @dst:  destination address to update
diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
index 27408f21e501..31e9ffd936e3 100644
--- a/include/linux/vmalloc.h
+++ b/include/linux/vmalloc.h
@@ -202,6 +202,9 @@ extern int remap_vmalloc_range_partial(struct vm_area_struct *vma,
 extern int remap_vmalloc_range(struct vm_area_struct *vma, void *addr,
 							unsigned long pgoff);
 
+int vmap_pages_range(unsigned long addr, unsigned long end, pgprot_t prot,
+		     struct page **pages, unsigned int page_shift);
+
 /*
  * Architectures can set this mask to a combination of PGTBL_P?D_MODIFIED values
  * and let generic vmalloc and ioremap code know when arch_sync_kernel_mappings()
diff --git a/lib/alloc_tag.c b/lib/alloc_tag.c
index d9f51169ffeb..061e43196247 100644
--- a/lib/alloc_tag.c
+++ b/lib/alloc_tag.c
@@ -8,14 +8,15 @@
 #include <linux/proc_fs.h>
 #include <linux/seq_buf.h>
 #include <linux/seq_file.h>
+#include <linux/vmalloc.h>
 
 #define ALLOCINFO_FILE_NAME		"allocinfo"
 #define MODULE_ALLOC_TAG_VMAP_SIZE	(100000UL * sizeof(struct alloc_tag))
 
 #ifdef CONFIG_MEM_ALLOC_PROFILING_ENABLED_BY_DEFAULT
-static bool mem_profiling_support __meminitdata = true;
+static bool mem_profiling_support = true;
 #else
-static bool mem_profiling_support __meminitdata;
+static bool mem_profiling_support;
 #endif
 
 static struct codetag_type *alloc_tag_cttype;
@@ -154,7 +155,7 @@ size_t alloc_tag_top_users(struct codetag_bytes *tags, size_t count, bool can_sl
 	return nr;
 }
 
-static void __init shutdown_mem_profiling(void)
+static void shutdown_mem_profiling(void)
 {
 	if (mem_alloc_profiling_enabled())
 		static_branch_disable(&mem_alloc_profiling_key);
@@ -179,6 +180,7 @@ static void __init procfs_init(void)
 #ifdef CONFIG_MODULES
 
 static struct maple_tree mod_area_mt = MTREE_INIT(mod_area_mt, MT_FLAGS_ALLOC_RANGE);
+static struct vm_struct *vm_module_tags;
 /* A dummy object used to indicate an unloaded module */
 static struct module unloaded_mod;
 /* A dummy object used to indicate a module prepended area */
@@ -252,6 +254,33 @@ static bool find_aligned_area(struct ma_state *mas, unsigned long section_size,
 	return false;
 }
 
+static int vm_module_tags_populate(void)
+{
+	unsigned long phys_size = vm_module_tags->nr_pages << PAGE_SHIFT;
+
+	if (phys_size < module_tags.size) {
+		struct page **next_page = vm_module_tags->pages + vm_module_tags->nr_pages;
+		unsigned long addr = module_tags.start_addr + phys_size;
+		unsigned long more_pages;
+		unsigned long nr;
+
+		more_pages = ALIGN(module_tags.size - phys_size, PAGE_SIZE) >> PAGE_SHIFT;
+		nr = alloc_pages_bulk_array_node(GFP_KERNEL | __GFP_NOWARN,
+						 NUMA_NO_NODE, more_pages, next_page);
+		if (nr < more_pages ||
+		    vmap_pages_range(addr, addr + (nr << PAGE_SHIFT), PAGE_KERNEL,
+				     next_page, PAGE_SHIFT) < 0) {
+			/* Clean up and error out */
+			for (int i = 0; i < nr; i++)
+				__free_page(next_page[i]);
+			return -ENOMEM;
+		}
+		vm_module_tags->nr_pages += nr;
+	}
+
+	return 0;
+}
+
 static void *reserve_module_tags(struct module *mod, unsigned long size,
 				 unsigned int prepend, unsigned long align)
 {
@@ -310,8 +339,18 @@ static void *reserve_module_tags(struct module *mod, unsigned long size,
 	if (IS_ERR(ret))
 		return ret;
 
-	if (module_tags.size < offset + size)
+	if (module_tags.size < offset + size) {
+		int grow_res;
+
 		module_tags.size = offset + size;
+		grow_res = vm_module_tags_populate();
+		if (grow_res) {
+			shutdown_mem_profiling();
+			pr_err("Failed to allocate memory for allocation tags in the module %s. Memory allocation profiling is disabled!\n",
+			       mod->name);
+			return ERR_PTR(grow_res);
+		}
+	}
 
 	return (struct alloc_tag *)(module_tags.start_addr + offset);
 }
@@ -372,12 +411,23 @@ static void replace_module(struct module *mod, struct module *new_mod)
 
 static int __init alloc_mod_tags_mem(void)
 {
-	/* Allocate space to copy allocation tags */
-	module_tags.start_addr = (unsigned long)execmem_alloc(EXECMEM_MODULE_DATA,
-							      MODULE_ALLOC_TAG_VMAP_SIZE);
-	if (!module_tags.start_addr)
+	/* Map space to copy allocation tags */
+	vm_module_tags = execmem_vmap(MODULE_ALLOC_TAG_VMAP_SIZE);
+	if (!vm_module_tags) {
+		pr_err("Failed to map %lu bytes for module allocation tags\n",
+			MODULE_ALLOC_TAG_VMAP_SIZE);
+		module_tags.start_addr = 0;
 		return -ENOMEM;
+	}
 
+	vm_module_tags->pages = kmalloc_array(get_vm_area_size(vm_module_tags) >> PAGE_SHIFT,
+					sizeof(struct page *), GFP_KERNEL | __GFP_ZERO);
+	if (!vm_module_tags->pages) {
+		free_vm_area(vm_module_tags);
+		return -ENOMEM;
+	}
+
+	module_tags.start_addr = (unsigned long)vm_module_tags->addr;
 	module_tags.end_addr = module_tags.start_addr + MODULE_ALLOC_TAG_VMAP_SIZE;
 
 	return 0;
@@ -385,8 +435,13 @@ static int __init alloc_mod_tags_mem(void)
 
 static void __init free_mod_tags_mem(void)
 {
-	execmem_free((void *)module_tags.start_addr);
+	int i;
+
 	module_tags.start_addr = 0;
+	for (i = 0; i < vm_module_tags->nr_pages; i++)
+		__free_page(vm_module_tags->pages[i]);
+	kfree(vm_module_tags->pages);
+	free_vm_area(vm_module_tags);
 }
 
 #else /* CONFIG_MODULES */
diff --git a/mm/execmem.c b/mm/execmem.c
index 576a57e2161f..5c0f9f2d6f83 100644
--- a/mm/execmem.c
+++ b/mm/execmem.c
@@ -368,6 +368,22 @@ void execmem_free(void *ptr)
 		vfree(ptr);
 }
 
+struct vm_struct *execmem_vmap(size_t size)
+{
+	struct execmem_range *range = &execmem_info->ranges[EXECMEM_MODULE_DATA];
+	struct vm_struct *area;
+
+	area = __get_vm_area_node(size, range->alignment, PAGE_SHIFT, VM_ALLOC,
+				  range->start, range->end, NUMA_NO_NODE,
+				  GFP_KERNEL, __builtin_return_address(0));
+	if (!area && range->fallback_start)
+		area = __get_vm_area_node(size, range->alignment, PAGE_SHIFT, VM_ALLOC,
+					  range->fallback_start, range->fallback_end,
+					  NUMA_NO_NODE, GFP_KERNEL, __builtin_return_address(0));
+
+	return area;
+}
+
 void *execmem_update_copy(void *dst, const void *src, size_t size)
 {
 	return text_poke_copy(dst, src, size);
diff --git a/mm/internal.h b/mm/internal.h
index 508f7802dd2b..f1ce0e10bed8 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1219,6 +1219,12 @@ int numa_migrate_check(struct folio *folio, struct vm_fault *vmf,
 void free_zone_device_folio(struct folio *folio);
 int migrate_device_coherent_folio(struct folio *folio);
 
+struct vm_struct *__get_vm_area_node(unsigned long size,
+				     unsigned long align, unsigned long shift,
+				     unsigned long flags, unsigned long start,
+				     unsigned long end, int node, gfp_t gfp_mask,
+				     const void *caller);
+
 /*
  * mm/gup.c
  */
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 74c0a5eae210..7ed39d104201 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -653,7 +653,7 @@ int vmap_pages_range_noflush(unsigned long addr, unsigned long end,
  * RETURNS:
  * 0 on success, -errno on failure.
  */
-static int vmap_pages_range(unsigned long addr, unsigned long end,
+int vmap_pages_range(unsigned long addr, unsigned long end,
 		pgprot_t prot, struct page **pages, unsigned int page_shift)
 {
 	int err;
@@ -3106,7 +3106,7 @@ static void clear_vm_uninitialized_flag(struct vm_struct *vm)
 	vm->flags &= ~VM_UNINITIALIZED;
 }
 
-static struct vm_struct *__get_vm_area_node(unsigned long size,
+struct vm_struct *__get_vm_area_node(unsigned long size,
 		unsigned long align, unsigned long shift, unsigned long flags,
 		unsigned long start, unsigned long end, int node,
 		gfp_t gfp_mask, const void *caller)
-- 
2.47.0.105.g07ac214952-goog


