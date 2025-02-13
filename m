Return-Path: <linux-kernel+bounces-514034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0430AA3518A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 23:49:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85EBB7A3891
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 22:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4920A280A3A;
	Thu, 13 Feb 2025 22:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2tdpIUvf"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93589280A25
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 22:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739486849; cv=none; b=gjC7vc4dy2oNtBJdkkciEoy7xQREVa8uDdbqiUaYIN9Qu52V3yg+T/ekZxeofBX8OI/6/DJFr/u7W5hPLo3IFxQUrz+ezPVKHsARzHasBwjNS6ys5gcitaSvLj3K5LqXFiScs6dB65qA+NN0fTeJ8bPBh37yoEKdb1L1kmmFF8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739486849; c=relaxed/simple;
	bh=r9UnP2J9gPwMql3KM31oVxbeTh6TkWqpKwsWUGtheZ8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=t9WZ7fqB6Ezbsj7CHxlNix0Yz8QW1IbFs6PHwx/r1EQp1ljFeKcDrzyl7uszYWkPaj5ywffo4VRkEo3/cmfOgRKStCvljq31aRpQxfkBa3Co6T0Kx79eBWUiQR2LfZ8sZ62vgBVistruRi9pT3IVCTcMPShWQgQ1w7EqXM4RsOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2tdpIUvf; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2fc1cb0c2cbso2917170a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 14:47:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739486846; x=1740091646; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=p2XHEc7Lc99pXt/+24Q50pb3G2smdSAP5b2ttcYEcJw=;
        b=2tdpIUvfcSvCPNil8p321yyyb4x6P46eUT/Pioq9k5oYqlGabBU+BCPW+aR9BhgxV4
         wh9aD1BU9pO7f8EPgix7kJUx/WM6SkBgLJDQUGgcKK/jGKccH/Jy5sZLEUBgNvTgR5Lj
         1oaTqDgmuvDUOkWd2+dcB2ogPJ9fQH6mB86IwfnobQ8Q4TOrf4lOYuUz7j1p0+S5O+yv
         prt05ugF/MZxrGUbPssTdxZ9PfYz4FhuNwJk91S+8neR3e3OcqhQdApm3bQGLdJw4drR
         WH2kzgpXY8DIqxeSW7Nv1jd5n0hivXFiMdl/w357vhteyKb6GFEO/Q92WWjFHRxJIibq
         +CSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739486846; x=1740091646;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p2XHEc7Lc99pXt/+24Q50pb3G2smdSAP5b2ttcYEcJw=;
        b=HmCO1+NiOK2BZ0rxBHWttkwInM8QCVZttnMJ2bnVGsPUa0tyBC6tXPtxUv43513436
         hJ7JNJmaEYLPQXmauPHlSVDfE3xWq3pUrcxFMrjKsLAFZ1cW4f16N1w6cRTfOaJ7bRWz
         gkrZBL3VENYg1ZDC0MAOlNU/rytA4UvqhTxpNTSFscpf4edHoxNYvgVf6HE5tueu6d8X
         DOEb/sr/kt69kg7zlM70d43ZE/EnjrstsyENbK7MRzZAQMa3IV0UppTPMBt2R1aByj+z
         8osCMOBB32mTqzFZdpmZLiKGzWVW+kgo9wa2ynDMNf+Q+v0XYretx7sCh3l6mM5F7VvI
         2F6g==
X-Forwarded-Encrypted: i=1; AJvYcCUnSjs5t1P9x/QVLQSwRrofiZ1ccXoSHfJSlg9809qW1DKXzSduC64JnxfgUV76u1sVXsGJh5dbcDiRl1I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfKXLoyDAAsUcqkGSPYxtiP5phFTxVfnq8dTeFUTO/2QekGZTY
	9u+dRTTcTgQAFPE/bCRTLEX2aTCwm7R0rmV1tFpIwnCt3VdNyyYl+egXiBD761SEMuopCnNcorh
	NYQ==
X-Google-Smtp-Source: AGHT+IHxvu/76zqwjXOeUtKeapkgzxoZmdl37UyKOvAGkMpiwzZvuuSG6bTHkHJu7fwwbTV32aeg1MBY6BY=
X-Received: from pjap1.prod.google.com ([2002:a17:90a:e41:b0:2fc:c98:ea47])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1e47:b0:2ee:74a1:fba2
 with SMTP id 98e67ed59e1d1-2fc0e5b92e1mr6734995a91.20.1739486845903; Thu, 13
 Feb 2025 14:47:25 -0800 (PST)
Date: Thu, 13 Feb 2025 14:46:50 -0800
In-Reply-To: <20250213224655.1680278-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250213224655.1680278-1-surenb@google.com>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <20250213224655.1680278-14-surenb@google.com>
Subject: [PATCH v10 13/18] mm: move lesser used vma_area_struct members into
 the last cacheline
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: peterz@infradead.org, willy@infradead.org, liam.howlett@oracle.com, 
	lorenzo.stoakes@oracle.com, david.laight.linux@gmail.com, mhocko@suse.com, 
	vbabka@suse.cz, hannes@cmpxchg.org, mjguzik@gmail.com, oliver.sang@intel.com, 
	mgorman@techsingularity.net, david@redhat.com, peterx@redhat.com, 
	oleg@redhat.com, dave@stgolabs.net, paulmck@kernel.org, brauner@kernel.org, 
	dhowells@redhat.com, hdanton@sina.com, hughd@google.com, 
	lokeshgidra@google.com, minchan@google.com, jannh@google.com, 
	shakeel.butt@linux.dev, souravpanda@google.com, pasha.tatashin@soleen.com, 
	klarasmodin@gmail.com, richard.weiyang@gmail.com, corbet@lwn.net, 
	linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	kernel-team@android.com, surenb@google.com
Content-Type: text/plain; charset="UTF-8"

Move several vma_area_struct members which are rarely or never used
during page fault handling into the last cacheline to better pack
vm_area_struct. As a result vm_area_struct will fit into 3 as opposed
to 4 cachelines. New typical vm_area_struct layout:

struct vm_area_struct {
    union {
        struct {
            long unsigned int vm_start;              /*     0     8 */
            long unsigned int vm_end;                /*     8     8 */
        };                                           /*     0    16 */
        freeptr_t          vm_freeptr;               /*     0     8 */
    };                                               /*     0    16 */
    struct mm_struct *         vm_mm;                /*    16     8 */
    pgprot_t                   vm_page_prot;         /*    24     8 */
    union {
        const vm_flags_t   vm_flags;                 /*    32     8 */
        vm_flags_t         __vm_flags;               /*    32     8 */
    };                                               /*    32     8 */
    unsigned int               vm_lock_seq;          /*    40     4 */

    /* XXX 4 bytes hole, try to pack */

    struct list_head           anon_vma_chain;       /*    48    16 */
    /* --- cacheline 1 boundary (64 bytes) --- */
    struct anon_vma *          anon_vma;             /*    64     8 */
    const struct vm_operations_struct  * vm_ops;     /*    72     8 */
    long unsigned int          vm_pgoff;             /*    80     8 */
    struct file *              vm_file;              /*    88     8 */
    void *                     vm_private_data;      /*    96     8 */
    atomic_long_t              swap_readahead_info;  /*   104     8 */
    struct mempolicy *         vm_policy;            /*   112     8 */
    struct vma_numab_state *   numab_state;          /*   120     8 */
    /* --- cacheline 2 boundary (128 bytes) --- */
    refcount_t          vm_refcnt (__aligned__(64)); /*   128     4 */

    /* XXX 4 bytes hole, try to pack */

    struct {
        struct rb_node     rb (__aligned__(8));      /*   136    24 */
        long unsigned int  rb_subtree_last;          /*   160     8 */
    } __attribute__((__aligned__(8))) shared;        /*   136    32 */
    struct anon_vma_name *     anon_name;            /*   168     8 */
    struct vm_userfaultfd_ctx  vm_userfaultfd_ctx;   /*   176     8 */

    /* size: 192, cachelines: 3, members: 18 */
    /* sum members: 176, holes: 2, sum holes: 8 */
    /* padding: 8 */
    /* forced alignments: 2, forced holes: 1, sum forced holes: 4 */
} __attribute__((__aligned__(64)));

Memory consumption per 1000 VMAs becomes 48 pages:

    slabinfo after vm_area_struct changes:
     <name>           ... <objsize> <objperslab> <pagesperslab> : ...
     vm_area_struct   ...    192   42    2 : ...

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
Changes since v9 [1]:
- Update vm_area_struct for tests, per Lorenzo Stoakes
- Add Reviewed-by, per Lorenzo Stoakes

[1] https://lore.kernel.org/all/20250111042604.3230628-13-surenb@google.com/

 include/linux/mm_types.h         | 38 +++++++++++++++-----------------
 tools/testing/vma/vma_internal.h | 37 +++++++++++++++----------------
 2 files changed, 36 insertions(+), 39 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 48ddfedfff83..63ab51699120 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -735,17 +735,6 @@ struct vm_area_struct {
 	 */
 	unsigned int vm_lock_seq;
 #endif
-
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
@@ -765,14 +754,6 @@ struct vm_area_struct {
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
@@ -785,7 +766,6 @@ struct vm_area_struct {
 #ifdef CONFIG_NUMA_BALANCING
 	struct vma_numab_state *numab_state;	/* NUMA Balancing state */
 #endif
-	struct vm_userfaultfd_ctx vm_userfaultfd_ctx;
 #ifdef CONFIG_PER_VMA_LOCK
 	/* Unstable RCU readers are allowed to read this. */
 	refcount_t vm_refcnt ____cacheline_aligned_in_smp;
@@ -793,6 +773,24 @@ struct vm_area_struct {
 	struct lockdep_map vmlock_dep_map;
 #endif
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
diff --git a/tools/testing/vma/vma_internal.h b/tools/testing/vma/vma_internal.h
index ba838097d3f6..b385170fbb8f 100644
--- a/tools/testing/vma/vma_internal.h
+++ b/tools/testing/vma/vma_internal.h
@@ -279,16 +279,6 @@ struct vm_area_struct {
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
@@ -308,14 +298,6 @@ struct vm_area_struct {
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
@@ -328,11 +310,28 @@ struct vm_area_struct {
 #ifdef CONFIG_NUMA_BALANCING
 	struct vma_numab_state *numab_state;	/* NUMA Balancing state */
 #endif
-	struct vm_userfaultfd_ctx vm_userfaultfd_ctx;
 #ifdef CONFIG_PER_VMA_LOCK
 	/* Unstable RCU readers are allowed to read this. */
 	refcount_t vm_refcnt;
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
 
 struct vm_fault {};
-- 
2.48.1.601.g30ceb7b040-goog


