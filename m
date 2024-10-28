Return-Path: <linux-kernel+bounces-385795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C4589B3BD1
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 21:35:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89D31B21336
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 20:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16A061E04B8;
	Mon, 28 Oct 2024 20:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SIR3BX2q"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F7F1DEFCF
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 20:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730147382; cv=none; b=B9vvjTa3Ki/P5U3IAAtpD464a58ZiVjAG8SXNgLG2VBfqVv2ECYQbArEbSdPurtTRV/FvdqiSxPX0p8e9DIKfaymn9dWpLPuhMpbwT9tsuwY5FG0wew6s8L4ZTvAzHDFLVIE/BFbIyOrlD8yx1yT+c8xZQxoxOdrLpF3l9x0iik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730147382; c=relaxed/simple;
	bh=P6v0cdPfw66hmjGX2sdc0T3leUGPwZoOYr4NwyjrwGc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=SRBvuOMf5q2S6aWWMjuskgaJ+ZZhsxghdl/N9eFhYm4sDvLxoFK9jP37VF2UicbeKHyQVgxPxMkvBXaLFtg3mNfLZclscxgCdXXUU/KZfk/CVH5IgzY1uDiTHdh9leWQIM6tqlWyDbAc1smVwBXrZymiWuuFtYAJeiKR9Y4g9/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SIR3BX2q; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e31d9c8efcso88057807b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 13:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730147379; x=1730752179; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AQu7lVPjZfxagsQISUssNV39w+zFZe7vUI/ZMaqhOHY=;
        b=SIR3BX2qMo+UBPvhHVzGsje6TmltsFuOd/JYvDBAnH2YQ4sMI3kN2MMj/GytlH8tUb
         /AutlEjekA9RoOPnd1CQZBN9NTS17kLI7LImKA0IXBlGVxrlBUJxwjayBLuegVWtiV4/
         zjSIkVmAhzNzdFZVPqTrDE6E8zv6tOBPzs1iwbgHbpAhqff7ciuntWfay2gjw0LhQbIw
         YC+ideX1Y8yJyNXJ2kinZoZL3dcCFjgo8rkYHnN3sSUCjpHPYYzI3N9p4FSXVrLzaHxC
         0BY1rMoVgKYs0RwT8x7oMENdHWNILp20UX1BJu11BkHTcsqp0BkgzAL4LVQPYS2u6qct
         xOyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730147379; x=1730752179;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AQu7lVPjZfxagsQISUssNV39w+zFZe7vUI/ZMaqhOHY=;
        b=J3rLCXjmeQw+GVxoSnDFFrVFe4SFKb6MDt53lThTmBduq8rcMFXyq0+kK0ZndfbxMa
         MbK2FLKCEptYuJwVxCmgYf0SkfESCKbQXQlU4nB4RfzTGrJqsM7HHDdWztPF5wS1SL4x
         3jp9B8ZGpEB1yKYjzcTfZv16XeUtXiQHBPirdixBtVU6xxE504/JGUQF3SGyy5wn3fJ0
         WaXZCO4Ym50XHGQje0Vzrgre7DigFdNPQhrWIRqs4eUmE8hA+7IHpU/fI0oazmGyjK7n
         k2yNSIv2xcYo3LHHHTM5IBHMPtVNMPnVSlGkyvFe1khkRGHhouarIqB1a4GusAFXrIlq
         5IFg==
X-Forwarded-Encrypted: i=1; AJvYcCV6MpiSuSDjAig1RsHuzmmIaczx+lRUJ4wus7FKlzWHCS09f0yainmHPaOHxXhQAg3m4DIlU/ScYluT8Us=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3mnDPGQgsafs5CXpPibRd6hw2ZX00CcCF/byeYyUAujYm6Haf
	l1TSUjw65UgiZ2tUfUF6pxoi1bZ5p6ibns3ckuoqdYxJAdWnDnG9LbCnH7b3ntFRmXkLdM9gqyI
	bkg==
X-Google-Smtp-Source: AGHT+IHCn/Js3lcT5veuAC24+CSLFRcHwssAV+kTrC2tEk8mKNMzHsJA6QhYnulIRBhR9Zrky3OLa9mceqs=
X-Received: from surenb-desktop.mtv.corp.google.com ([2a00:79e0:2e3f:8:1cfe:d46c:cf07:a219])
 (user=surenb job=sendgmr) by 2002:a81:f10a:0:b0:648:fc8a:cd23 with SMTP id
 00721157ae682-6e9d893d125mr2401967b3.2.1730147379090; Mon, 28 Oct 2024
 13:29:39 -0700 (PDT)
Date: Mon, 28 Oct 2024 13:29:35 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <20241028202935.1047017-1-surenb@google.com>
Subject: [PATCH 1/1] alloc_tag: avoid execmem_vmap() when !MMU
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: arnd@kernel.org, arnd@arndb.de, rppt@kernel.org, pasha.tatashin@soleen.com, 
	mcgrof@kernel.org, song@kernel.org, mhiramat@kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, surenb@google.com, 
	kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"

With CONFIG_MMU=n __get_vm_area_node() is not available and memory for the
allocation tags cannot be populated as needed. For this case, populate the
required memory at initialization time.

Fixes: 57bc3834fb6f ("alloc_tag: populate memory for module tags as needed")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202410250808.dQGyYjlk-lkp@intel.com/
Closes: https://lore.kernel.org/oe-lkp/202410251525.9f85854d-oliver.sang@intel.com
Closes: https://lore.kernel.org/oe-kbuild-all/202410261016.IO7C6Cml-lkp@intel.com/
Closes: https://lore.kernel.org/oe-kbuild-all/202410270919.LebQlmxD-lkp@intel.com/
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Mike Rapoport (Microsoft) <rppt@kernel.org>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 include/linux/execmem.h |  2 ++
 lib/alloc_tag.c         | 23 ++++++++++++++++++++++-
 mm/execmem.c            | 32 ++++++++++++++++----------------
 3 files changed, 40 insertions(+), 17 deletions(-)

diff --git a/include/linux/execmem.h b/include/linux/execmem.h
index 5a5e2917f870..64130ae19690 100644
--- a/include/linux/execmem.h
+++ b/include/linux/execmem.h
@@ -139,6 +139,7 @@ void *execmem_alloc(enum execmem_type type, size_t size);
  */
 void execmem_free(void *ptr);
 
+#ifdef CONFIG_MMU
 /**
  * execmem_vmap - create virtual mapping for EXECMEM_MODULE_DATA memory
  * @size: size of the virtual mapping in bytes
@@ -148,6 +149,7 @@ void execmem_free(void *ptr);
  * Return: the area descriptor on success or %NULL on failure.
  */
 struct vm_struct *execmem_vmap(size_t size);
+#endif
 
 /**
  * execmem_update_copy - copy an update to executable memory
diff --git a/lib/alloc_tag.c b/lib/alloc_tag.c
index c1ddac2d29f0..1c74942e6dfd 100644
--- a/lib/alloc_tag.c
+++ b/lib/alloc_tag.c
@@ -268,7 +268,6 @@ void __init alloc_tag_sec_init(void)
 #ifdef CONFIG_MODULES
 
 static struct maple_tree mod_area_mt = MTREE_INIT(mod_area_mt, MT_FLAGS_ALLOC_RANGE);
-static struct vm_struct *vm_module_tags;
 /* A dummy object used to indicate an unloaded module */
 static struct module unloaded_mod;
 /* A dummy object used to indicate a module prepended area */
@@ -391,6 +390,9 @@ static bool find_aligned_area(struct ma_state *mas, unsigned long section_size,
 	return false;
 }
 
+#ifdef CONFIG_MMU
+static struct vm_struct *vm_module_tags;
+
 static int vm_module_tags_populate(void)
 {
 	unsigned long phys_size = vm_module_tags->nr_pages << PAGE_SHIFT;
@@ -417,6 +419,13 @@ static int vm_module_tags_populate(void)
 
 	return 0;
 }
+#else
+static int vm_module_tags_populate(void)
+{
+	/* Memory was already allocated */
+	return 0;
+}
+#endif
 
 static void *reserve_module_tags(struct module *mod, unsigned long size,
 				 unsigned int prepend, unsigned long align)
@@ -561,6 +570,7 @@ static void replace_module(struct module *mod, struct module *new_mod)
 
 static int __init alloc_mod_tags_mem(void)
 {
+#ifdef CONFIG_MMU
 	/* Map space to copy allocation tags */
 	vm_module_tags = execmem_vmap(MODULE_ALLOC_TAG_VMAP_SIZE);
 	if (!vm_module_tags) {
@@ -578,6 +588,13 @@ static int __init alloc_mod_tags_mem(void)
 	}
 
 	module_tags.start_addr = (unsigned long)vm_module_tags->addr;
+#else
+	/* Allocate space to copy allocation tags */
+	module_tags.start_addr = (unsigned long)execmem_alloc(EXECMEM_MODULE_DATA,
+							      MODULE_ALLOC_TAG_VMAP_SIZE);
+	if (!module_tags.start_addr)
+		return -ENOMEM;
+#endif
 	module_tags.end_addr = module_tags.start_addr + MODULE_ALLOC_TAG_VMAP_SIZE;
 	/* Ensure the base is alloc_tag aligned when required for indexing */
 	module_tags.start_addr = alloc_tag_align(module_tags.start_addr);
@@ -587,6 +604,7 @@ static int __init alloc_mod_tags_mem(void)
 
 static void __init free_mod_tags_mem(void)
 {
+#ifdef CONFIG_MMU
 	int i;
 
 	module_tags.start_addr = 0;
@@ -594,6 +612,9 @@ static void __init free_mod_tags_mem(void)
 		__free_page(vm_module_tags->pages[i]);
 	kfree(vm_module_tags->pages);
 	free_vm_area(vm_module_tags);
+#else
+	execmem_free((void *)module_tags.start_addr);
+#endif
 }
 
 #else /* CONFIG_MODULES */
diff --git a/mm/execmem.c b/mm/execmem.c
index 5c0f9f2d6f83..317b6a8d35be 100644
--- a/mm/execmem.c
+++ b/mm/execmem.c
@@ -64,6 +64,22 @@ static void *execmem_vmalloc(struct execmem_range *range, size_t size,
 
 	return p;
 }
+
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
 #else
 static void *execmem_vmalloc(struct execmem_range *range, size_t size,
 			     pgprot_t pgprot, unsigned long vm_flags)
@@ -368,22 +384,6 @@ void execmem_free(void *ptr)
 		vfree(ptr);
 }
 
-struct vm_struct *execmem_vmap(size_t size)
-{
-	struct execmem_range *range = &execmem_info->ranges[EXECMEM_MODULE_DATA];
-	struct vm_struct *area;
-
-	area = __get_vm_area_node(size, range->alignment, PAGE_SHIFT, VM_ALLOC,
-				  range->start, range->end, NUMA_NO_NODE,
-				  GFP_KERNEL, __builtin_return_address(0));
-	if (!area && range->fallback_start)
-		area = __get_vm_area_node(size, range->alignment, PAGE_SHIFT, VM_ALLOC,
-					  range->fallback_start, range->fallback_end,
-					  NUMA_NO_NODE, GFP_KERNEL, __builtin_return_address(0));
-
-	return area;
-}
-
 void *execmem_update_copy(void *dst, const void *src, size_t size)
 {
 	return text_poke_copy(dst, src, size);

base-commit: 92409df3e00a17d6fd5bb27732fa186749725ed5
-- 
2.47.0.163.g1226f6d8fa-goog


