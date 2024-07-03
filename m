Return-Path: <linux-kernel+bounces-239967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B32E6926752
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 19:42:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B5711F2677F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 17:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 098B318509A;
	Wed,  3 Jul 2024 17:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="deV2mL2h"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7800E17B50C
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 17:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720028552; cv=none; b=s3D8f0tLr157apMlzsC6yG1B2JPkxSQguacDrYxxO8qkpxKmiXggdRvXJbfVyrfxkFNItvl7YUtHVsW/Rvs8w4o+pvH3bIZt9mtcE5AzrQFQ4kYCREeyy7Tg3XhKkjRBhRK+vRQpLMiCmDhC91jsI/0Q5Z2/ScfE5nZrFixOEp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720028552; c=relaxed/simple;
	bh=HLZ4mpGCqa4K37zneCCqxcinEXBYwu2salBgrPOLw+g=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=LUNWUIsP9fU72iReYiP9xDcrjkyQk9tNFytAUKUYtWZkwxTwqG/xW6X1BLqCs+/VCQmDM74TIuE4JYdS7DCKtBqg7ivsC138iGwUV9p+++LjROogkfoCtm3G3RtqAL/ssHk18xSTkNN0caELqYeW3HjdUKaIXdRvtM3xUXN+mL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=deV2mL2h; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e03654427f6so9679705276.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 10:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720028549; x=1720633349; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cHmmenAJD4Xuv33/PGus2uArSA74vyhiLTN2TNueFk0=;
        b=deV2mL2heJHBfKiyrVzzvjR49LVqJDzIC1/rfHFGaGDneWIZPTeuu9452D0z8BpWtD
         Xp/q9asABuBX0dGrtX7QgdVu1/l5g/hDWm6kV21HHLroFYw8HRclJMpurMUhLaSnxw4l
         RoPlsG7zkqdgh8Pczi28Y+vXlBXsdZqB8KtVuNqAaks1rC3UZjSQdsSTDCu0eOeajeLS
         qMepmuILdweR4/7u+Kel+7rW/lyIsjzY9m4WTYz+L8ICNuXedcC/I/gzeeBJZEbFoCEU
         QNHq86tILhlW8xjsglBfnf4F+dLBayFOb4UzMlzOF0FlIGnjQzGlRDrgF509BCMZq+L3
         AmAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720028549; x=1720633349;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cHmmenAJD4Xuv33/PGus2uArSA74vyhiLTN2TNueFk0=;
        b=nXFGhuk2J2PNJQvlkI32P9xR6FkNds/gH2tDNuMmZtHWvpCtUKwijeeDGcqs9tkv1s
         wlgQubA3RdJQ20YQVx2lLXPZdXLNjUrQ05mX3gLzEws+DkPK4IhdBZaPPYYfEEZ2ikye
         LPWWXHNtCLc4SvI+/MyeO8e/0gq/8AixxzQfR4kinXDWRJaOIRNWQbCPxpF2jJZpVhiJ
         5IfftHSZx79OYm/RQo4jRbDtXGNqUas6sr/jTDHcyqdiTfD5QDXNn0EpfkowDsQS2YIR
         PSqLCehbddG9mRdzV3XyjRCojna/5nTf60bIE31qTlpVH1RmRUR/4Y52EUUc9dlvjwpX
         cZ0A==
X-Forwarded-Encrypted: i=1; AJvYcCURDQIav9fJkbxozw/zbYpnNWuxyWbiVMJz8Ya2Bg7F99LsabQMTM5tDrTbrleNDmNYH1NeyHccfDWpYPjuolx6c+9WQKkmPAfmlbB9
X-Gm-Message-State: AOJu0YzRRORku4Qp3iIgkvJe0UFT6hANDR/dpzOBN9syDtttS3tUI5Tn
	ISLCmDuQEphbGdG+XQ+1KHWiPQvbpDYh3hjbZwKJDzDSBcaovD3je+2B9a/U3nX3I5SXruvAf7D
	UBg==
X-Google-Smtp-Source: AGHT+IFqhs8YAXy71fS/OG8wb/RazDJEP/UmJcIZGBEuKGVV5zkwlO2Qnshi5IQglkMDLXF+R6xYdSLhDko=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:7049:5206:eaa8:8edd])
 (user=surenb job=sendgmr) by 2002:a25:dd46:0:b0:dfa:b328:475d with SMTP id
 3f1490d57ef6-e036ec80d10mr192889276.12.1720028549451; Wed, 03 Jul 2024
 10:42:29 -0700 (PDT)
Date: Wed,  3 Jul 2024 10:42:25 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Message-ID: <20240703174225.3891393-1-surenb@google.com>
Subject: [PATCH 1/1] mm: add comments for allocation helpers explaining why
 they are macros
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: kent.overstreet@linux.dev, jack@suse.cz, thorsten.blum@toblux.com, 
	christian.koenig@amd.com, hch@lst.de, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, surenb@google.com
Content-Type: text/plain; charset="UTF-8"

A number of allocation helper functions were converted into macros to
account them at the call sites. Add a comment for each converted
allocation helper explaining why it has to be a macro and why we
typecast the return value wherever required.
The patch also moves acpi_os_acquire_object() closer to other allocation
helpers to group them together under the same comment.
The patch has no functional changes.

Fixes: 2c321f3f70bc ("mm: change inlined allocation helpers to account at the call site")
Suggested-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 fs/nfs/iostat.h                   |  4 ++++
 include/acpi/platform/aclinuxex.h |  9 ++++++---
 include/linux/bpf.h               |  4 ++++
 include/linux/dma-fence-chain.h   |  4 ++++
 include/linux/hid_bpf.h           |  5 +++++
 include/linux/jbd2.h              | 10 ++++++++++
 include/linux/skbuff.h            |  8 ++++++++
 include/linux/skmsg.h             |  5 +++++
 8 files changed, 46 insertions(+), 3 deletions(-)

diff --git a/fs/nfs/iostat.h b/fs/nfs/iostat.h
index b17a9eb9b148..49862c95b224 100644
--- a/fs/nfs/iostat.h
+++ b/fs/nfs/iostat.h
@@ -46,6 +46,10 @@ static inline void nfs_add_stats(const struct inode *inode,
 	nfs_add_server_stats(NFS_SERVER(inode), stat, addend);
 }
 
+/*
+ * This specialized allocator has to be a macro for its allocations to be
+ * accounted separately (to have a separate alloc_tag).
+ */
 #define nfs_alloc_iostats()	alloc_percpu(struct nfs_iostats)
 
 static inline void nfs_free_iostats(struct nfs_iostats __percpu *stats)
diff --git a/include/acpi/platform/aclinuxex.h b/include/acpi/platform/aclinuxex.h
index 62cac266a1c8..eeff40295b4b 100644
--- a/include/acpi/platform/aclinuxex.h
+++ b/include/acpi/platform/aclinuxex.h
@@ -46,6 +46,9 @@ acpi_status acpi_os_terminate(void);
  * Interrupts are off during resume, just like they are for boot.
  * However, boot has  (system_state != SYSTEM_RUNNING)
  * to quiet __might_sleep() in kmalloc() and resume does not.
+ *
+ * These specialized allocators have to be macros for their allocations to be
+ * accounted separately (to have separate alloc_tag).
  */
 #define acpi_os_allocate(_size)	\
 		kmalloc(_size, irqs_disabled() ? GFP_ATOMIC : GFP_KERNEL)
@@ -53,14 +56,14 @@ acpi_status acpi_os_terminate(void);
 #define acpi_os_allocate_zeroed(_size)	\
 		kzalloc(_size, irqs_disabled() ? GFP_ATOMIC : GFP_KERNEL)
 
+#define acpi_os_acquire_object(_cache)	\
+		kmem_cache_zalloc(_cache, irqs_disabled() ? GFP_ATOMIC : GFP_KERNEL)
+
 static inline void acpi_os_free(void *memory)
 {
 	kfree(memory);
 }
 
-#define acpi_os_acquire_object(_cache)	\
-		kmem_cache_zalloc(_cache, irqs_disabled() ? GFP_ATOMIC : GFP_KERNEL)
-
 static inline acpi_thread_id acpi_os_get_thread_id(void)
 {
 	return (acpi_thread_id) (unsigned long)current;
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 5e694a308081..4cef340737c4 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2261,6 +2261,10 @@ void *bpf_map_kvcalloc(struct bpf_map *map, size_t n, size_t size,
 void __percpu *bpf_map_alloc_percpu(const struct bpf_map *map, size_t size,
 				    size_t align, gfp_t flags);
 #else
+/*
+ * These specialized allocators have to be macros for their allocations to be
+ * accounted separately (to have separate alloc_tag).
+ */
 #define bpf_map_kmalloc_node(_map, _size, _flags, _node)	\
 		kmalloc_node(_size, _flags, _node)
 #define bpf_map_kzalloc(_map, _size, _flags)			\
diff --git a/include/linux/dma-fence-chain.h b/include/linux/dma-fence-chain.h
index ad9e2506c2f4..68c3c1e41014 100644
--- a/include/linux/dma-fence-chain.h
+++ b/include/linux/dma-fence-chain.h
@@ -85,6 +85,10 @@ dma_fence_chain_contained(struct dma_fence *fence)
  * dma_fence_chain_alloc
  *
  * Returns a new struct dma_fence_chain object or NULL on failure.
+ *
+ * This specialized allocator has to be a macro for its allocations to be
+ * accounted separately (to have a separate alloc_tag). The typecast is
+ * intentional to enforce typesafety.
  */
 #define dma_fence_chain_alloc()	\
 		((struct dma_fence_chain *)kmalloc(sizeof(struct dma_fence_chain), GFP_KERNEL))
diff --git a/include/linux/hid_bpf.h b/include/linux/hid_bpf.h
index eec2592dec12..99a3edb6cf07 100644
--- a/include/linux/hid_bpf.h
+++ b/include/linux/hid_bpf.h
@@ -152,6 +152,11 @@ static inline int hid_bpf_connect_device(struct hid_device *hdev) { return 0; }
 static inline void hid_bpf_disconnect_device(struct hid_device *hdev) {}
 static inline void hid_bpf_destroy_device(struct hid_device *hid) {}
 static inline void hid_bpf_device_init(struct hid_device *hid) {}
+/*
+ * This specialized allocator has to be a macro for its allocations to be
+ * accounted separately (to have a separate alloc_tag). The typecast is
+ * intentional to enforce typesafety.
+ */
 #define call_hid_bpf_rdesc_fixup(_hdev, _rdesc, _size)	\
 		((u8 *)kmemdup(_rdesc, *(_size), GFP_KERNEL))
 
diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
index ab04c1c27fae..a280f42c8c76 100644
--- a/include/linux/jbd2.h
+++ b/include/linux/jbd2.h
@@ -1588,6 +1588,11 @@ void jbd2_journal_put_journal_head(struct journal_head *jh);
  */
 extern struct kmem_cache *jbd2_handle_cache;
 
+/*
+ * This specialized allocator has to be a macro for its allocations to be
+ * accounted separately (to have a separate alloc_tag). The typecast is
+ * intentional to enforce typesafety.
+ */
 #define jbd2_alloc_handle(_gfp_flags)	\
 		((handle_t *)kmem_cache_zalloc(jbd2_handle_cache, _gfp_flags))
 
@@ -1602,6 +1607,11 @@ static inline void jbd2_free_handle(handle_t *handle)
  */
 extern struct kmem_cache *jbd2_inode_cache;
 
+/*
+ * This specialized allocator has to be a macro for its allocations to be
+ * accounted separately (to have a separate alloc_tag). The typecast is
+ * intentional to enforce typesafety.
+ */
 #define jbd2_alloc_inode(_gfp_flags)	\
 		((struct jbd2_inode *)kmem_cache_alloc(jbd2_inode_cache, _gfp_flags))
 
diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 1c2902eaebd3..fd51f2de51da 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -3400,6 +3400,10 @@ static inline struct page *__dev_alloc_pages_noprof(gfp_t gfp_mask,
 }
 #define __dev_alloc_pages(...)	alloc_hooks(__dev_alloc_pages_noprof(__VA_ARGS__))
 
+/*
+ * This specialized allocator has to be a macro for its allocations to be
+ * accounted separately (to have a separate alloc_tag).
+ */
 #define dev_alloc_pages(_order) __dev_alloc_pages(GFP_ATOMIC | __GFP_NOWARN, _order)
 
 /**
@@ -3416,6 +3420,10 @@ static inline struct page *__dev_alloc_page_noprof(gfp_t gfp_mask)
 }
 #define __dev_alloc_page(...)	alloc_hooks(__dev_alloc_page_noprof(__VA_ARGS__))
 
+/*
+ * This specialized allocator has to be a macro for its allocations to be
+ * accounted separately (to have a separate alloc_tag).
+ */
 #define dev_alloc_page()	dev_alloc_pages(0)
 
 /**
diff --git a/include/linux/skmsg.h b/include/linux/skmsg.h
index c9efda9df285..d9b03e0746e7 100644
--- a/include/linux/skmsg.h
+++ b/include/linux/skmsg.h
@@ -414,6 +414,11 @@ void sk_psock_stop_verdict(struct sock *sk, struct sk_psock *psock);
 int sk_psock_msg_verdict(struct sock *sk, struct sk_psock *psock,
 			 struct sk_msg *msg);
 
+/*
+ * This specialized allocator has to be a macro for its allocations to be
+ * accounted separately (to have a separate alloc_tag). The typecast is
+ * intentional to enforce typesafety.
+ */
 #define sk_psock_init_link()	\
 		((struct sk_psock_link *)kzalloc(sizeof(struct sk_psock_link),	\
 						 GFP_ATOMIC | __GFP_NOWARN))

base-commit: 8a9c6c40432e265600232b864f97d7c675e8be52
-- 
2.45.2.803.g4e1b14247a-goog


