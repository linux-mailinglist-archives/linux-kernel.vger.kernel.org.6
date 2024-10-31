Return-Path: <linux-kernel+bounces-391455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D1829B8733
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 00:36:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85EA41C21AA4
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 23:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54D411D63E3;
	Thu, 31 Oct 2024 23:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uNjIqqfz"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4CA31946BC
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 23:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730417781; cv=none; b=XA1oSr+zwl/snwnQ009qt3oKH7ss/IQwEMpA5ueDWlDhB2SBJXi8w/iiHOUzB3Wcyay61yflbJ5wqltGP1eFZCIxnLSQOY/uCtvvP/bRE4ymOgPqWo+x9YPNdeUvOZxr1Fyrs913yKu5jSwhcxgaxiDEalVhS/DQ9h3S66jbiGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730417781; c=relaxed/simple;
	bh=v1bWGzIgr5HoVPSGZ05TIQB77ZhxeI020bOJmlDY2Gk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=mzBbH4M/GS4gwPaVuYZ7dUOErSjcUlRM8pjVXKe5mtYF9Hy8k/z72v4jJXOHcEZV+OTe4eKG+nII+NOmd0Rml79JMXITAxPB/kYhudZq7odbPtKIx5LdLfjyyL4TAS28DTBnWp7P9OJi182yQeKuG+vFA7dixVDOlzK9fNKfsGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uNjIqqfz; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e2939e25402so2522437276.2
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 16:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730417775; x=1731022575; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5Y5D0344T4ayqAf+xnFFDFs3+CjHFh6YQW8dHgLsJq4=;
        b=uNjIqqfzCq50bs7hyDxKcU0kM9CCxIIsjPb86P3FCb9eB2aj3Cnp/eHZ/y/qU9LQR2
         j2l9y+IptbjoiI/4zSRxq/EqM7eKPFfH+onYqLg5t3uPodBM18PdbfU8P4QlkEk3Qlqz
         WXFYBuzRK4joC3xR6k2bksXcgf6OgwE/buFWsJ6aJHMKF7hB4wzEtM3XFcpxbQKasc3h
         LqC/YxwUxywyt11xvJcCj9QNumld0jx0aviD7DG2v25a9tJ5JUi5lHZKcGr2gEdZLUdY
         hvvmz25mzYsKgNhgegCFUU9vkSo9aRkoBS7EhCi0UMeyzzL4P9sv+Y3UFcI0mHTL06Gy
         rQHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730417775; x=1731022575;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5Y5D0344T4ayqAf+xnFFDFs3+CjHFh6YQW8dHgLsJq4=;
        b=i6u3mNk2o4uJPq+N3ZhMDn7BIYEptNSpNZLyqvuc3R+adHe+F9ZafUE4PxbNZRdGBG
         dp15ryhWEqrrXdtmaKVXka0Y3/6K1R50tLu2bdWLXgKsHe6MaIoxupcb9MrtOm8pHAKA
         OkoDz6tYBT0nDnzyhwy5i9RMkCiAQz+5VQaEdXDnZg6HpkPs+CdvpK5eyqdavjDQMGCJ
         w4+S2tuXm6P8jFqDezht5gUW8tIZYivxJPMfR2yMvdzYIungWqetwC9SAnUj//o4zoMF
         TnyrJ+ys18wWpM9beqAABl6i+uUsMZBxQgreVFLd6VFUhzBqYjtLnjdPttCcVcUfTn0H
         qjJw==
X-Forwarded-Encrypted: i=1; AJvYcCWitm1TFI7gwKQf3ty2wEA4p0UKFmeEeNzBw0tdRf0CsBGgHyevjWgWxwUhOlSjYEK18gPVIAI9kj0puhY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/ZmnL11MRYcD2hIH7o4SOky/UWZTmPqLfY1wjCNfYyGdrJWem
	IlPWCUKq5/9E++SJEf2GnvA2/2ZSbyQTbeCGw1EL7raBb0/bEt3XEQIV5TyysF2EbXCbZeEme3q
	Ixw==
X-Google-Smtp-Source: AGHT+IEIPLPP597svzD0H12j4/MSctqmVJ3Xh8xaOC80ggktFHpli3fTeTvFXGthn4t8CrEyjVrHgptevoM=
X-Received: from surenb-desktop.mtv.corp.google.com ([2a00:79e0:2e3f:8:1498:a594:2b5d:75e5])
 (user=surenb job=sendgmr) by 2002:a25:dc4e:0:b0:e29:6e61:3db4 with SMTP id
 3f1490d57ef6-e3302527b97mr1145276.2.1730417774819; Thu, 31 Oct 2024 16:36:14
 -0700 (PDT)
Date: Thu, 31 Oct 2024 16:36:11 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <20241031233611.3833002-1-surenb@google.com>
Subject: [PATCH v2 1/1] alloc_tag: avoid execmem_vmap() when !MMU
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: arnd@kernel.org, arnd@arndb.de, rppt@kernel.org, pasha.tatashin@soleen.com, 
	mcgrof@kernel.org, song@kernel.org, mhiramat@kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, surenb@google.com, 
	kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"

With CONFIG_MMU=n __get_vm_area_node() is not available. Add CONFIG_MMU
dependency for memory allocation tagging since it uses __get_vm_area_node()
via execmem_vmap().

Fixes: 57bc3834fb6f ("alloc_tag: populate memory for module tags as needed")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202410250808.dQGyYjlk-lkp@intel.com/
Closes: https://lore.kernel.org/oe-lkp/202410251525.9f85854d-oliver.sang@intel.com
Closes: https://lore.kernel.org/oe-kbuild-all/202410261016.IO7C6Cml-lkp@intel.com/
Closes: https://lore.kernel.org/oe-kbuild-all/202410270919.LebQlmxD-lkp@intel.com/
Suggested-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Cc: Arnd Bergmann <arnd@arndb.de>
---
Replaces old version with the same name in mm-unstable (current SHA 88e136f0950d)

Changes since v1 [1]
- drop support for (CONFIG_MEM_ALLOC_PROFILING && !CONFIG_MMU) to simplify the
change, per Mike Rapoport

[1] https://lore.kernel.org/all/20241028202935.1047017-1-surenb@google.com/

 include/linux/execmem.h |  2 ++
 lib/Kconfig.debug       |  1 +
 mm/execmem.c            | 32 ++++++++++++++++----------------
 3 files changed, 19 insertions(+), 16 deletions(-)

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
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 7312ae7c3cc5..6798bbbcbd32 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -993,6 +993,7 @@ config CODE_TAGGING
 config MEM_ALLOC_PROFILING
 	bool "Enable memory allocation profiling"
 	default n
+	depends on MMU
 	depends on PROC_FS
 	depends on !DEBUG_FORCE_WEAK_PER_CPU
 	select CODE_TAGGING
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
-- 
2.47.0.163.g1226f6d8fa-goog


