Return-Path: <linux-kernel+bounces-404753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B6DE79C47D6
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 22:15:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA774B376CE
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 21:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67FD31F7080;
	Mon, 11 Nov 2024 20:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0Ep/fl7n"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0E31F6692
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 20:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731358521; cv=none; b=oQYUSpo4ObqfWEA7+0KzuXaitD28UU2St01xZuwX6NsoS2UNLl2HFVt4O59BDcqOAI/IuotCXDJWpfIMTi0mc/2K0SgjrMsE5QJnj2TL9iAcrAWYLt7kWbvXL5Fkc9MbQBuDbcNSHI11ZzD2dZEeKE2JWBeb1oH2ZaAjlt5E0ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731358521; c=relaxed/simple;
	bh=uX6t1+V+VWD9TPr8MaOqU9mwvP8DvU6pbc0DsbnErqI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XmWpD4Txr8xqkHxx6MoRH3uBuSs/9n6+5TJk2MrykX7TeoiBY6/9cgzqoEZAA7dDit4q8lmniL/ryarR0Rf5X/ZiqsBT17aYpuS6TGM+HAQCyV0z+opLiI8/9ClfBOZ1yI1gT7OoladgdLpnmIhTIU/hgN6d3blcFYwA9WK5CFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0Ep/fl7n; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e33152c8225so10007122276.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 12:55:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731358519; x=1731963319; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=akNUNHRHwFgLbLvzRySURA4LLcUajIyMqiu+hcl7K7Q=;
        b=0Ep/fl7n+5y5UYg5kNDRcQfH7L0ChD/RLAJMwgzG8n09KSJim+JgsGNR4cHFyaO6AX
         f8x7w0yHc0Hx5z5Qh4ybw4/i2bRK/ZVhFkZlqCYrI8EEiEC1x/BZhBKF82d04XdPc0SK
         rDwilq0tQinXEqi2dxySBQtUWiHN+5FEbRNuQx+jLgt+lUMQPIuPirzy0hwlhiRXcEGE
         VHkGGpO5jmjZHuTVArFdTHljY5KpRMqY87VK+2V8HoDwE6/jHQcwvlIV4BfPjXdzleyz
         dgEe4+sXrDMQP250AafQJQjZombVbA4JmsPtQgxGV972JXFMDDMQJQemjNGer3vc2Ybv
         iwqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731358519; x=1731963319;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=akNUNHRHwFgLbLvzRySURA4LLcUajIyMqiu+hcl7K7Q=;
        b=mNWG/BJJZkyn9As7NAL5bFLUs8Q6HR2s6+e1+C8m/K5xV9pkuw/+Sd2jwh1deu3863
         2Y0BfBUH585uSD4SRQ+Hxk5Q0fk/8otvIQyBTEyduxLh73E+UmkF3KTEPLTyDgX/zi4T
         tYHR5u5wVDMTqbrUNF2o5fuQvE2UfrP9saRkyB4iN0gwFafu7jMfictqbSPqvdAOBW4P
         2m4SN13zsUo06/drg0I3MATrzVXA25SY851oNYtDt9yPIEtQmEsIoRfhxUtjkdHoq4ow
         Ks73H4KzWohTMRpnQ+2uMqN7VBjxO7CCOEMm3+d5/UUY400Av2pYxrMmpvoI9iDAfZNE
         wx7g==
X-Forwarded-Encrypted: i=1; AJvYcCU5wiu/OYEekiOBNWXKdyzfQPdch5KJeUDg3EcgdT2hgbVyHjuN8LBqzQthqSC2NiC3tSM6/CqNFC8GqJw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVyPyvpaHhI230+ygWG0deL/LL965pnEjJHamOquc7Jm3DNj7M
	MELiUeBxbpuoivSK0iSP8amhLDX7NVNwX9KnkK2ttLlNSXh/EHNIrWHNnzytd4QNhiSPE4b5LnV
	B2Q==
X-Google-Smtp-Source: AGHT+IHpj1lpqX7UFCEsgQvhYlvsKEu/LqdCTRcWojtEX3DucdiIWzMOj6Fj6hWiR/dHK1I4p9BRUvnrioQ=
X-Received: from surenb-desktop.mtv.corp.google.com ([2a00:79e0:2e3f:8:53af:d9fa:522d:99b1])
 (user=surenb job=sendgmr) by 2002:a25:bcc2:0:b0:e2b:e955:d58a with SMTP id
 3f1490d57ef6-e337f8fa240mr13216276.7.1731358518983; Mon, 11 Nov 2024 12:55:18
 -0800 (PST)
Date: Mon, 11 Nov 2024 12:55:06 -0800
In-Reply-To: <20241111205506.3404479-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241111205506.3404479-1-surenb@google.com>
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Message-ID: <20241111205506.3404479-5-surenb@google.com>
Subject: [PATCH 4/4] mm: move lesser used vma_area_struct members into the
 last cacheline
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

Move several vma_area_struct members which are rarely or never used
during page fault handling into the last cacheline to better pack
vm_area_struct. As a result vm_area_struct will fit into 3 cachelines
as opposed to 4 cachelines before this change. New vm_area_struct layout:

struct vm_area_struct {
	union {
		struct {
			long unsigned int vm_start;      /*     0     8 */
			long unsigned int vm_end;        /*     8     8 */
		};                                       /*     0    16 */
		struct callback_head vm_rcu ;            /*     0    16 */
	} __attribute__((__aligned__(8)));               /*     0    16 */
	struct mm_struct *         vm_mm;                /*    16     8 */
	pgprot_t                   vm_page_prot;         /*    24     8 */
	union {
		const vm_flags_t   vm_flags;             /*    32     8 */
		vm_flags_t         __vm_flags;           /*    32     8 */
	};                                               /*    32     8 */
	bool                       detached;             /*    40     1 */

	/* XXX 3 bytes hole, try to pack */

	unsigned int               vm_lock_seq;          /*    44     4 */
	struct list_head           anon_vma_chain;       /*    48    16 */
	/* --- cacheline 1 boundary (64 bytes) --- */
	struct anon_vma *          anon_vma;             /*    64     8 */
	const struct vm_operations_struct  * vm_ops;     /*    72     8 */
	long unsigned int          vm_pgoff;             /*    80     8 */
	struct file *              vm_file;              /*    88     8 */
	void *                     vm_private_data;      /*    96     8 */
	atomic_long_t              swap_readahead_info;  /*   104     8 */
	struct mempolicy *         vm_policy;            /*   112     8 */

	/* XXX 8 bytes hole, try to pack */

	/* --- cacheline 2 boundary (128 bytes) --- */
	struct vma_lock       vm_lock (__aligned__(64)); /*   128     4 */

	/* XXX 4 bytes hole, try to pack */

	struct {
		struct rb_node     rb (__aligned__(8));  /*   136    24 */
		long unsigned int  rb_subtree_last;      /*   160     8 */
	} __attribute__((__aligned__(8))) shared;        /*   136    32 */
	struct vm_userfaultfd_ctx  vm_userfaultfd_ctx;   /*   168     0 */

	/* size: 192, cachelines: 3, members: 17 */
	/* sum members: 153, holes: 3, sum holes: 15 */
	/* padding: 24 */
	/* forced alignments: 3, forced holes: 2, sum forced holes: 12 */
} __attribute__((__aligned__(64)));


Memory consumption per 1000 VMAs becomes 48 pages:

    slabinfo after vm_area_struct changes:
     <name>           ... <objsize> <objperslab> <pagesperslab> : ...
     vm_area_struct   ...    192   42    2 : ...


Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 include/linux/mm_types.h | 37 ++++++++++++++++++-------------------
 1 file changed, 18 insertions(+), 19 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 789bccc05520..c3755b680911 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -733,16 +733,6 @@ struct vm_area_struct {
 	unsigned int vm_lock_seq;
 #endif
 
-	/*
-	 * For areas with an address space and backing store,
-	 * linkage into the address_space->i_mmap interval tree.
-	 *
-	 */
-	struct {
-		struct rb_node rb;
-		unsigned long rb_subtree_last;
-	} shared;
-
 	/*
 	 * A file's MAP_PRIVATE vma can be in both i_mmap tree and anon_vma
 	 * list, after a COW of one of the file pages.	A MAP_SHARED vma
@@ -762,14 +752,6 @@ struct vm_area_struct {
 	struct file * vm_file;		/* File we map to (can be NULL). */
 	void * vm_private_data;		/* was vm_pte (shared mem) */
 
-#ifdef CONFIG_ANON_VMA_NAME
-	/*
-	 * For private and shared anonymous mappings, a pointer to a null
-	 * terminated string containing the name given to the vma, or NULL if
-	 * unnamed. Serialized by mmap_lock. Use anon_vma_name to access.
-	 */
-	struct anon_vma_name *anon_name;
-#endif
 #ifdef CONFIG_SWAP
 	atomic_long_t swap_readahead_info;
 #endif
@@ -782,11 +764,28 @@ struct vm_area_struct {
 #ifdef CONFIG_NUMA_BALANCING
 	struct vma_numab_state *numab_state;	/* NUMA Balancing state */
 #endif
-	struct vm_userfaultfd_ctx vm_userfaultfd_ctx;
 #ifdef CONFIG_PER_VMA_LOCK
 	/* Unstable RCU readers are allowed to read this. */
 	struct vma_lock vm_lock ____cacheline_aligned_in_smp;
 #endif
+	/*
+	 * For areas with an address space and backing store,
+	 * linkage into the address_space->i_mmap interval tree.
+	 *
+	 */
+	struct {
+		struct rb_node rb;
+		unsigned long rb_subtree_last;
+	} shared;
+#ifdef CONFIG_ANON_VMA_NAME
+	/*
+	 * For private and shared anonymous mappings, a pointer to a null
+	 * terminated string containing the name given to the vma, or NULL if
+	 * unnamed. Serialized by mmap_lock. Use anon_vma_name to access.
+	 */
+	struct anon_vma_name *anon_name;
+#endif
+	struct vm_userfaultfd_ctx vm_userfaultfd_ctx;
 } __randomize_layout;
 
 #ifdef CONFIG_NUMA
-- 
2.47.0.277.g8800431eea-goog


