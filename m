Return-Path: <linux-kernel+bounces-406645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45AEB9C61BD
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 20:47:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C41B81F2329F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 19:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABAEE21A4AD;
	Tue, 12 Nov 2024 19:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HmlfB1xy"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D6D21A4A0
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 19:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731440819; cv=none; b=lGDhtOiFXcSCPBTtAP1B6s2ld/ZNZmJV4dq5k7T6QbdpCeZa3AA/HubVVWqJzCNvkvWExnWF4L8D1hK8gKnNvZqKP4L6zh6QADjwjUMfUBvYS4oLNfVnL+kq/jC+P0PGVkJy9vc+SXLI5LIe46QpfMsgyZe9uw/3oChsGVbzUd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731440819; c=relaxed/simple;
	bh=qxeLmq5SNV6xSo9lXu8LAIi2QsWfzz7BIVAPK9HS898=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=D5M1MRqH2n7Vk4qmjJ9uWnNqNFuOiuv7GUDIIOyMiL+gJU/c65VB15/pNfZSF0IrM7FTXvWfPhHmfUin1pjs1FidVS7TahN7ecJAaUJgGAM/B/fsLgrHJWFNkQInFgJalSb4iCEaZtFdUQXGnt2UJvwaIp1xoNguRFZ9NwqGg6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HmlfB1xy; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e59dc7df64so109697b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 11:46:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731440816; x=1732045616; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+O3HT96xjOpyZyOfTy1XSWvtoYhqZSjPLYRvhqOFff8=;
        b=HmlfB1xyYxNhBCZ0xFWm2lqsKd/Sv1KLKZoZYmbtWMKys1dzj1OYVwYgHuulvEKA08
         MsENDn1NFqqpqWOmUpPoceehADdZ+L6bW7Qz+2Ru0bEVbZ63vSWxsHXNFqLxEQN67q/K
         EjjuUSL/0N2PA32mIMQiGbWKq5N0bZ3G94PmO8nkNEnP3R5ptH7C6gXKWQ5sgvsRTl9O
         t7g3AqmFNOradWVHSCdzl7t/tvQ9bB3Qm5My0eb3WtsqZljyZPcIVsENpWpx2y2LdQ37
         1Br3G3Z1NLuHPZx+uW/4jA/IQj/veOB3kn6SXjBoguFYMdU/szB7/Qna+HvgHm28CRoj
         L/3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731440816; x=1732045616;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+O3HT96xjOpyZyOfTy1XSWvtoYhqZSjPLYRvhqOFff8=;
        b=TrhlxZSfNPIJZiWxCP4pNl7qL7UYHXeQI+wCcaqOWhapw8wO5MlSTFP+FHZ4XmSDAD
         pL2iTHoBie6V2C9XNsHuswYsxngNUp0sFUq+2K6v76xfYFktzbWAsCaLOT0hiG5M/boJ
         mDJqJC2IM5HLtnpLDUx1ZPvpOrPDV7HltyqvdEjgSgIdOp2uSpvStHuVaRbP2mgCKZvF
         rSrTq3fK0dRiCoEjgfFP6P6ecVK7gOyeBijO/zAsWP4vOQXrgriGowYfBavSVkOUQ3YI
         pItSv4vAyhz3hOppCK9V1A1BNZdUdqLPF2UWUqkchieKJb95Z/LobTPN71b+fNpGCH2u
         usRQ==
X-Forwarded-Encrypted: i=1; AJvYcCX8M4enGr+plEBm52KW96ZHu4jLVoigAMzC+Q9xqxTga55w0dpwPLYsrE4FIPdjsg7+eeKXXLiTonnh7WI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHOMxYt/4fOi7L4B5Bm1vzrHQZ9Xg7rfXzchbwJA8bKqPlDAmy
	9dX74ha2kqW9LqiP0moUBGsj+A54nNcV+7iaZnMkkSW++90ivf7F14voNeAdWFR3rYqCmCFkytN
	V0A==
X-Google-Smtp-Source: AGHT+IHOEk82i1GQQA1lcKwQVafHXzM7QcBOoBI0xQdYABDX0Xu7GKWAPVcRoNYH7FkpwH/Uu3J2wrcQokM=
X-Received: from surenb-desktop.mtv.corp.google.com ([2a00:79e0:2e3f:8:cad5:5dc6:1298:ec42])
 (user=surenb job=sendgmr) by 2002:a05:690c:8008:b0:6ec:b10d:5745 with SMTP id
 00721157ae682-6ecb10d5a0bmr28207b3.3.1731440816377; Tue, 12 Nov 2024 11:46:56
 -0800 (PST)
Date: Tue, 12 Nov 2024 11:46:34 -0800
In-Reply-To: <20241112194635.444146-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241112194635.444146-1-surenb@google.com>
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Message-ID: <20241112194635.444146-5-surenb@google.com>
Subject: [PATCH v2 4/5] mm: make vma cache SLAB_TYPESAFE_BY_RCU
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: willy@infradead.org, liam.howlett@oracle.com, lorenzo.stoakes@oracle.com, 
	mhocko@suse.com, vbabka@suse.cz, hannes@cmpxchg.org, mjguzik@gmail.com, 
	oliver.sang@intel.com, mgorman@techsingularity.net, david@redhat.com, 
	peterx@redhat.com, oleg@redhat.com, dave@stgolabs.net, paulmck@kernel.org, 
	brauner@kernel.org, dhowells@redhat.com, hdanton@sina.com, hughd@google.com, 
	minchan@google.com, jannh@google.com, shakeel.butt@linux.dev, 
	souravpanda@google.com, pasha.tatashin@soleen.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kernel-team@android.com, surenb@google.com
Content-Type: text/plain; charset="UTF-8"

To enable SLAB_TYPESAFE_BY_RCU for vma cache we need to ensure that
object reuse before RCU grace period is over will be detected inside
lock_vma_under_rcu().
lock_vma_under_rcu() enters RCU read section, finds the vma at the
given address, locks the vma and checks if it got detached or remapped
to cover a different address range. These last checks are there
to ensure that the vma was not modified after we found it but before
locking it. Vma reuse introduces a possibility that in between those
events of finding and locking the vma, it can get detached, reused,
added into a tree and be marked as attached. Current checks will help
detecting cases when:
- vma was reused but not yet added into the tree (detached check)
- vma was reused at a different address range (address check)
If vma is covering a new address range which still includes the address
we were looking for, it's not a problem unless the reused vma was added
into a different address space. Therefore checking that vma->vm_mm is
still the same is the the only missing check to detect vma reuse.
Add this missing check into lock_vma_under_rcu() and change vma cache
to include SLAB_TYPESAFE_BY_RCU. This will facilitate vm_area_struct
reuse and will minimize the number of call_rcu() calls.
Adding vm_freeptr into vm_area_struct avoids bloating that structure.
lock_vma_under_rcu() checks of the detached flag guarantees that vma
is valid and attached to a tree, therefore unioning vm_freeptr with
vm_start/vm_end is not an issue even though lock_vma_under_rcu() is
using them.
As part of this change freeptr_t declaration is moved into mm_types.h
to avoid circular dependencies between mm_types.h and slab.h.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 include/linux/mm_types.h | 10 +++++++---
 include/linux/slab.h     |  6 ------
 kernel/fork.c            | 29 +++++++++++++----------------
 mm/memory.c              |  2 +-
 4 files changed, 21 insertions(+), 26 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 5c4bfdcfac72..37580cc7bec0 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -32,6 +32,12 @@
 struct address_space;
 struct mem_cgroup;
 
+/*
+ * freeptr_t represents a SLUB freelist pointer, which might be encoded
+ * and not dereferenceable if CONFIG_SLAB_FREELIST_HARDENED is enabled.
+ */
+typedef struct { unsigned long v; } freeptr_t;
+
 /*
  * Each physical page in the system has a struct page associated with
  * it to keep track of whatever it is we are using the page for at the
@@ -673,9 +679,7 @@ struct vm_area_struct {
 			unsigned long vm_start;
 			unsigned long vm_end;
 		};
-#ifdef CONFIG_PER_VMA_LOCK
-		struct rcu_head vm_rcu;	/* Used for deferred freeing. */
-#endif
+		freeptr_t vm_freeptr; /* Pointer used by SLAB_TYPESAFE_BY_RCU */
 	};
 
 	/*
diff --git a/include/linux/slab.h b/include/linux/slab.h
index b35e2db7eb0e..cb45db2402ac 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -212,12 +212,6 @@ enum _slab_flag_bits {
 #define SLAB_NO_OBJ_EXT		__SLAB_FLAG_UNUSED
 #endif
 
-/*
- * freeptr_t represents a SLUB freelist pointer, which might be encoded
- * and not dereferenceable if CONFIG_SLAB_FREELIST_HARDENED is enabled.
- */
-typedef struct { unsigned long v; } freeptr_t;
-
 /*
  * ZERO_SIZE_PTR will be returned for zero sized kmalloc requests.
  *
diff --git a/kernel/fork.c b/kernel/fork.c
index 7823797e31d2..946c3f9a9342 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -478,25 +478,15 @@ void __vm_area_free(struct vm_area_struct *vma)
 	kmem_cache_free(vm_area_cachep, vma);
 }
 
-#ifdef CONFIG_PER_VMA_LOCK
-static void vm_area_free_rcu_cb(struct rcu_head *head)
+void vm_area_free(struct vm_area_struct *vma)
 {
-	struct vm_area_struct *vma = container_of(head, struct vm_area_struct,
-						  vm_rcu);
-
+#ifdef CONFIG_PER_VMA_LOCK
+	/* The vma should be detached while being destroyed. */
+	VM_BUG_ON_VMA(!is_vma_detached(vma), vma);
 	/* The vma should not be locked while being destroyed. */
 	VM_BUG_ON_VMA(rwsem_is_locked(&vma->vm_lock.lock), vma);
-	__vm_area_free(vma);
-}
 #endif
-
-void vm_area_free(struct vm_area_struct *vma)
-{
-#ifdef CONFIG_PER_VMA_LOCK
-	call_rcu(&vma->vm_rcu, vm_area_free_rcu_cb);
-#else
 	__vm_area_free(vma);
-#endif
 }
 
 static void account_kernel_stack(struct task_struct *tsk, int account)
@@ -3115,6 +3105,11 @@ void __init mm_cache_init(void)
 
 void __init proc_caches_init(void)
 {
+	struct kmem_cache_args args = {
+		.use_freeptr_offset = true,
+		.freeptr_offset = offsetof(struct vm_area_struct, vm_freeptr),
+	};
+
 	sighand_cachep = kmem_cache_create("sighand_cache",
 			sizeof(struct sighand_struct), 0,
 			SLAB_HWCACHE_ALIGN|SLAB_PANIC|SLAB_TYPESAFE_BY_RCU|
@@ -3131,9 +3126,11 @@ void __init proc_caches_init(void)
 			sizeof(struct fs_struct), 0,
 			SLAB_HWCACHE_ALIGN|SLAB_PANIC|SLAB_ACCOUNT,
 			NULL);
-	vm_area_cachep = KMEM_CACHE(vm_area_struct,
-			SLAB_HWCACHE_ALIGN|SLAB_NO_MERGE|SLAB_PANIC|
+	vm_area_cachep = kmem_cache_create("vm_area_struct",
+			sizeof(struct vm_area_struct), &args,
+			SLAB_HWCACHE_ALIGN|SLAB_PANIC|SLAB_TYPESAFE_BY_RCU|
 			SLAB_ACCOUNT);
+
 	mmap_init();
 	nsproxy_cache_init();
 }
diff --git a/mm/memory.c b/mm/memory.c
index d0197a0c0996..9c414c81f14a 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -6279,7 +6279,7 @@ struct vm_area_struct *lock_vma_under_rcu(struct mm_struct *mm,
 		goto inval;
 
 	/* Check if the VMA got isolated after we found it */
-	if (is_vma_detached(vma)) {
+	if (is_vma_detached(vma) || vma->vm_mm != mm) {
 		vma_end_read(vma);
 		count_vm_vma_lock_event(VMA_LOCK_MISS);
 		/* The area was replaced with another one */
-- 
2.47.0.277.g8800431eea-goog


