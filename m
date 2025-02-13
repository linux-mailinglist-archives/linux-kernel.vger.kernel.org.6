Return-Path: <linux-kernel+bounces-514025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A81BA35178
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 23:47:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FB4F188FAF1
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 22:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DABC2271276;
	Thu, 13 Feb 2025 22:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wItkdLpa"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF66270ED8
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 22:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739486830; cv=none; b=JpsyjqqmASRpQfRdvKUZwiHA+s3RKtYM69Fo9UMy+zOh8jeeRRkQ7dznz+BjFFpBih9h6PgsOZkdEWfLqW+RKTzp/KBlcDkPbWsiwJLovL0aIxMeMBGq3I6T4yo5GBj980YLSa5MM5SXgWqUhJjET35mK4X6Y84p7jea9AQ0PYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739486830; c=relaxed/simple;
	bh=eAoyMkZ3PdTwAaRTTe6AgBUYiwXhMeA9ce78rcSc1YE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HZ3M8sd/2YD4DVuxVZ7wcymCmhWZaR/3w79nrLKfHWMBHtTnR6U2C2MehK4lRiPeickQyhzMzMJF6fRB3m9dTIi+tkoz8+37ybS4Tenh8RFP9tEUqPiCIBKu7lqiAmC4R7zyIx0Zme1dEX8tdpsrXD9pY9G3O4f0rPBSmXutEts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wItkdLpa; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2fc1eabf4f7so1701442a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 14:47:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739486828; x=1740091628; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jH+IjsWoi1CDqDTbyIn4LxmH0nN4gQ/NWbFp+/jF/ZM=;
        b=wItkdLpa5UdbKG6TkBhgJPZXAYbQtNII5PVm8nxCEizvhUvExpKD+JcN37u4V58SGl
         cOUoz6Yddg5MfSWIASZx0/T3HZQFO590CqyE+ArM5O8GvbcyFol9HpzMEkkhzjM52zN8
         5zcc4vEZdedRQYPQCLzfFqQerJKsJ+2fPnAHyuAjwcpwBJdy91QZffYN5Cn9fUaCtZrE
         2FCMeUH0XID6HHQezrx1Y6hfrFzTJ+JRvAjtOiegO4mPEytxh01Pf1cp2f/NixVYo+tm
         EwnfN9T4BZbbaBuBYbXo77iIftIEk9aldDA7chMMtHpiUQEY7/KSf3w7wvgdaZ3aVCij
         rvtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739486828; x=1740091628;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jH+IjsWoi1CDqDTbyIn4LxmH0nN4gQ/NWbFp+/jF/ZM=;
        b=PTfsijrrIY61q0f9FzuC5Jz2Vp2SdzCiuq+/gugDy8CHn5+GVkPO74TekY21X9jNP3
         t537+jq3/QjSedoH2uo0iYFX7EiRBYensdUNENafOaa/i2sr4zN1nU9WgsnRP2Q0yUJt
         EcJZqsjZF2yju1cnwD4+YQbNkt0kEXJ7ew9n4mTH01hFfT47EiFZjccAXgQEVlb4tyrp
         QB/7VOjE1Hl+RAO10LOo/RK/oLDY/6p5AI/fpM/h9sV0Z9qCannlmXIoQQx4LekJjCBH
         zdstTjspuvceiPquCi3wTdmJ2PMH36Ok3yZHoF7G8IJceYpmVlZMeYm7eZIG+wsdVjGw
         Az8Q==
X-Forwarded-Encrypted: i=1; AJvYcCXTWB8iOFPfg4BEl7iN1qJDLaFXuq8U2VKFhtK4sUnyVBOAcp6SnVVS2IYnY3TujrXcJHt9gFPYdNLoYBw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yws1cSp5GIOI++QZLSLbD7fA302xKvRTg26s6F6Cj1zwK2Gg9W9
	NfHNNCbEJLUb+NKpLSg1BjYTppV2Qpx0ZnErNn/eRfBFFggG4e+FpPUgQcwBBf+mPZCU2f1DHLv
	MQg==
X-Google-Smtp-Source: AGHT+IFAejlKUMRiGK6lse6cj9gDccmhauhvLNb8QCnLKB76TP7y/Vj9rouXSbsWYDlN1QYS+niVoTXiz0o=
X-Received: from pjk14.prod.google.com ([2002:a17:90b:558e:b0:2ef:7352:9e97])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:e7d0:b0:2ef:e0bb:1ef2
 with SMTP id 98e67ed59e1d1-2fc0e98dc7dmr6643326a91.19.1739486828102; Thu, 13
 Feb 2025 14:47:08 -0800 (PST)
Date: Thu, 13 Feb 2025 14:46:41 -0800
In-Reply-To: <20250213224655.1680278-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250213224655.1680278-1-surenb@google.com>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <20250213224655.1680278-5-surenb@google.com>
Subject: [PATCH v10 04/18] mm: introduce vma_iter_store_attached() to use with
 attached vmas
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

vma_iter_store() functions can be used both when adding a new vma and
when updating an existing one. However for existing ones we do not need
to mark them attached as they are already marked that way. With
vma->detached being a separate flag, double-marking a vmas as attached
or detached is not an issue because the flag will simply be overwritten
with the same value. However once we fold this flag into the refcount
later in this series, re-attaching or re-detaching a vma becomes an
issue since these operations will be incrementing/decrementing a
refcount.
Introduce vma_iter_store_new() and vma_iter_store_overwrite() to replace
vma_iter_store() and avoid re-attaching a vma during vma update. Add
assertions in vma_mark_attached()/vma_mark_detached() to catch invalid
usage. Update vma tests to check for vma detached state correctness.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
Changes since v9 [1]:
- Change VM_BUG_ON_VMA() to WARN_ON_ONCE() in vma_assert_{attached|detached},
per Lorenzo Stoakes
- Rename vma_iter_store() into vma_iter_store_new(), per Lorenzo Stoakes
- Expand changelog, per Lorenzo Stoakes
- Update vma tests to check for vma detached state correctness,
per Lorenzo Stoakes

[1] https://lore.kernel.org/all/20250111042604.3230628-5-surenb@google.com/

 include/linux/mm.h               | 14 +++++++++++
 mm/nommu.c                       |  4 +--
 mm/vma.c                         | 12 ++++-----
 mm/vma.h                         | 11 +++++++--
 tools/testing/vma/vma.c          | 42 +++++++++++++++++++++++++-------
 tools/testing/vma/vma_internal.h | 10 ++++++++
 6 files changed, 74 insertions(+), 19 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index cd5ee61e98f2..1b8e72888124 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -821,8 +821,19 @@ static inline void vma_assert_locked(struct vm_area_struct *vma)
 		vma_assert_write_locked(vma);
 }
 
+static inline void vma_assert_attached(struct vm_area_struct *vma)
+{
+	WARN_ON_ONCE(vma->detached);
+}
+
+static inline void vma_assert_detached(struct vm_area_struct *vma)
+{
+	WARN_ON_ONCE(!vma->detached);
+}
+
 static inline void vma_mark_attached(struct vm_area_struct *vma)
 {
+	vma_assert_detached(vma);
 	vma->detached = false;
 }
 
@@ -830,6 +841,7 @@ static inline void vma_mark_detached(struct vm_area_struct *vma)
 {
 	/* When detaching vma should be write-locked */
 	vma_assert_write_locked(vma);
+	vma_assert_attached(vma);
 	vma->detached = true;
 }
 
@@ -866,6 +878,8 @@ static inline void vma_end_read(struct vm_area_struct *vma) {}
 static inline void vma_start_write(struct vm_area_struct *vma) {}
 static inline void vma_assert_write_locked(struct vm_area_struct *vma)
 		{ mmap_assert_write_locked(vma->vm_mm); }
+static inline void vma_assert_attached(struct vm_area_struct *vma) {}
+static inline void vma_assert_detached(struct vm_area_struct *vma) {}
 static inline void vma_mark_attached(struct vm_area_struct *vma) {}
 static inline void vma_mark_detached(struct vm_area_struct *vma) {}
 
diff --git a/mm/nommu.c b/mm/nommu.c
index baa79abdaf03..8b31d8396297 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -1191,7 +1191,7 @@ unsigned long do_mmap(struct file *file,
 	setup_vma_to_mm(vma, current->mm);
 	current->mm->map_count++;
 	/* add the VMA to the tree */
-	vma_iter_store(&vmi, vma);
+	vma_iter_store_new(&vmi, vma);
 
 	/* we flush the region from the icache only when the first executable
 	 * mapping of it is made  */
@@ -1356,7 +1356,7 @@ static int split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
 
 	setup_vma_to_mm(vma, mm);
 	setup_vma_to_mm(new, mm);
-	vma_iter_store(vmi, new);
+	vma_iter_store_new(vmi, new);
 	mm->map_count++;
 	return 0;
 
diff --git a/mm/vma.c b/mm/vma.c
index 498507d8a262..f72b73f57451 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -320,7 +320,7 @@ static void vma_complete(struct vma_prepare *vp, struct vma_iterator *vmi,
 		 * us to insert it before dropping the locks
 		 * (it may either follow vma or precede it).
 		 */
-		vma_iter_store(vmi, vp->insert);
+		vma_iter_store_new(vmi, vp->insert);
 		mm->map_count++;
 	}
 
@@ -700,7 +700,7 @@ static int commit_merge(struct vma_merge_struct *vmg)
 			      vmg->__adjust_middle_start ? vmg->middle : NULL);
 	vma_set_range(vma, vmg->start, vmg->end, vmg->pgoff);
 	vmg_adjust_set_range(vmg);
-	vma_iter_store(vmg->vmi, vmg->target);
+	vma_iter_store_overwrite(vmg->vmi, vmg->target);
 
 	vma_complete(&vp, vmg->vmi, vma->vm_mm);
 
@@ -1707,7 +1707,7 @@ int vma_link(struct mm_struct *mm, struct vm_area_struct *vma)
 		return -ENOMEM;
 
 	vma_start_write(vma);
-	vma_iter_store(&vmi, vma);
+	vma_iter_store_new(&vmi, vma);
 	vma_link_file(vma);
 	mm->map_count++;
 	validate_mm(mm);
@@ -2386,7 +2386,7 @@ static int __mmap_new_vma(struct mmap_state *map, struct vm_area_struct **vmap)
 
 	/* Lock the VMA since it is modified after insertion into VMA tree */
 	vma_start_write(vma);
-	vma_iter_store(vmi, vma);
+	vma_iter_store_new(vmi, vma);
 	map->mm->map_count++;
 	vma_link_file(vma);
 
@@ -2862,7 +2862,7 @@ int expand_upwards(struct vm_area_struct *vma, unsigned long address)
 				anon_vma_interval_tree_pre_update_vma(vma);
 				vma->vm_end = address;
 				/* Overwrite old entry in mtree. */
-				vma_iter_store(&vmi, vma);
+				vma_iter_store_overwrite(&vmi, vma);
 				anon_vma_interval_tree_post_update_vma(vma);
 
 				perf_event_mmap(vma);
@@ -2942,7 +2942,7 @@ int expand_downwards(struct vm_area_struct *vma, unsigned long address)
 				vma->vm_start = address;
 				vma->vm_pgoff -= grow;
 				/* Overwrite old entry in mtree. */
-				vma_iter_store(&vmi, vma);
+				vma_iter_store_overwrite(&vmi, vma);
 				anon_vma_interval_tree_post_update_vma(vma);
 
 				perf_event_mmap(vma);
diff --git a/mm/vma.h b/mm/vma.h
index bffb56afce5f..55be77ff042f 100644
--- a/mm/vma.h
+++ b/mm/vma.h
@@ -413,9 +413,10 @@ static inline struct vm_area_struct *vma_iter_load(struct vma_iterator *vmi)
 }
 
 /* Store a VMA with preallocated memory */
-static inline void vma_iter_store(struct vma_iterator *vmi,
-				  struct vm_area_struct *vma)
+static inline void vma_iter_store_overwrite(struct vma_iterator *vmi,
+					    struct vm_area_struct *vma)
 {
+	vma_assert_attached(vma);
 
 #if defined(CONFIG_DEBUG_VM_MAPLE_TREE)
 	if (MAS_WARN_ON(&vmi->mas, vmi->mas.status != ma_start &&
@@ -438,7 +439,13 @@ static inline void vma_iter_store(struct vma_iterator *vmi,
 
 	__mas_set_range(&vmi->mas, vma->vm_start, vma->vm_end - 1);
 	mas_store_prealloc(&vmi->mas, vma);
+}
+
+static inline void vma_iter_store_new(struct vma_iterator *vmi,
+				      struct vm_area_struct *vma)
+{
 	vma_mark_attached(vma);
+	vma_iter_store_overwrite(vmi, vma);
 }
 
 static inline unsigned long vma_iter_addr(struct vma_iterator *vmi)
diff --git a/tools/testing/vma/vma.c b/tools/testing/vma/vma.c
index c7ffa71841ca..11f761769b5b 100644
--- a/tools/testing/vma/vma.c
+++ b/tools/testing/vma/vma.c
@@ -74,10 +74,22 @@ static struct vm_area_struct *alloc_vma(struct mm_struct *mm,
 	ret->vm_end = end;
 	ret->vm_pgoff = pgoff;
 	ret->__vm_flags = flags;
+	vma_assert_detached(ret);
 
 	return ret;
 }
 
+/* Helper function to allocate a VMA and link it to the tree. */
+static int attach_vma(struct mm_struct *mm, struct vm_area_struct *vma)
+{
+	int res;
+
+	res = vma_link(mm, vma);
+	if (!res)
+		vma_assert_attached(vma);
+	return res;
+}
+
 /* Helper function to allocate a VMA and link it to the tree. */
 static struct vm_area_struct *alloc_and_link_vma(struct mm_struct *mm,
 						 unsigned long start,
@@ -90,7 +102,7 @@ static struct vm_area_struct *alloc_and_link_vma(struct mm_struct *mm,
 	if (vma == NULL)
 		return NULL;
 
-	if (vma_link(mm, vma)) {
+	if (attach_vma(mm, vma)) {
 		vm_area_free(vma);
 		return NULL;
 	}
@@ -108,6 +120,7 @@ static struct vm_area_struct *alloc_and_link_vma(struct mm_struct *mm,
 /* Helper function which provides a wrapper around a merge new VMA operation. */
 static struct vm_area_struct *merge_new(struct vma_merge_struct *vmg)
 {
+	struct vm_area_struct *vma;
 	/*
 	 * For convenience, get prev and next VMAs. Which the new VMA operation
 	 * requires.
@@ -116,7 +129,11 @@ static struct vm_area_struct *merge_new(struct vma_merge_struct *vmg)
 	vmg->prev = vma_prev(vmg->vmi);
 	vma_iter_next_range(vmg->vmi);
 
-	return vma_merge_new_range(vmg);
+	vma = vma_merge_new_range(vmg);
+	if (vma)
+		vma_assert_attached(vma);
+
+	return vma;
 }
 
 /*
@@ -125,7 +142,12 @@ static struct vm_area_struct *merge_new(struct vma_merge_struct *vmg)
  */
 static struct vm_area_struct *merge_existing(struct vma_merge_struct *vmg)
 {
-	return vma_merge_existing_range(vmg);
+	struct vm_area_struct *vma;
+
+	vma = vma_merge_existing_range(vmg);
+	if (vma)
+		vma_assert_attached(vma);
+	return vma;
 }
 
 /*
@@ -260,8 +282,8 @@ static bool test_simple_merge(void)
 		.pgoff = 1,
 	};
 
-	ASSERT_FALSE(vma_link(&mm, vma_left));
-	ASSERT_FALSE(vma_link(&mm, vma_right));
+	ASSERT_FALSE(attach_vma(&mm, vma_left));
+	ASSERT_FALSE(attach_vma(&mm, vma_right));
 
 	vma = merge_new(&vmg);
 	ASSERT_NE(vma, NULL);
@@ -285,7 +307,7 @@ static bool test_simple_modify(void)
 	struct vm_area_struct *init_vma = alloc_vma(&mm, 0, 0x3000, 0, flags);
 	VMA_ITERATOR(vmi, &mm, 0x1000);
 
-	ASSERT_FALSE(vma_link(&mm, init_vma));
+	ASSERT_FALSE(attach_vma(&mm, init_vma));
 
 	/*
 	 * The flags will not be changed, the vma_modify_flags() function
@@ -351,7 +373,7 @@ static bool test_simple_expand(void)
 		.pgoff = 0,
 	};
 
-	ASSERT_FALSE(vma_link(&mm, vma));
+	ASSERT_FALSE(attach_vma(&mm, vma));
 
 	ASSERT_FALSE(expand_existing(&vmg));
 
@@ -372,7 +394,7 @@ static bool test_simple_shrink(void)
 	struct vm_area_struct *vma = alloc_vma(&mm, 0, 0x3000, 0, flags);
 	VMA_ITERATOR(vmi, &mm, 0);
 
-	ASSERT_FALSE(vma_link(&mm, vma));
+	ASSERT_FALSE(attach_vma(&mm, vma));
 
 	ASSERT_FALSE(vma_shrink(&vmi, vma, 0, 0x1000, 0));
 
@@ -1522,11 +1544,11 @@ static bool test_copy_vma(void)
 
 	vma = alloc_and_link_vma(&mm, 0x3000, 0x5000, 3, flags);
 	vma_new = copy_vma(&vma, 0, 0x2000, 0, &need_locks);
-
 	ASSERT_NE(vma_new, vma);
 	ASSERT_EQ(vma_new->vm_start, 0);
 	ASSERT_EQ(vma_new->vm_end, 0x2000);
 	ASSERT_EQ(vma_new->vm_pgoff, 0);
+	vma_assert_attached(vma_new);
 
 	cleanup_mm(&mm, &vmi);
 
@@ -1535,6 +1557,7 @@ static bool test_copy_vma(void)
 	vma = alloc_and_link_vma(&mm, 0, 0x2000, 0, flags);
 	vma_next = alloc_and_link_vma(&mm, 0x6000, 0x8000, 6, flags);
 	vma_new = copy_vma(&vma, 0x4000, 0x2000, 4, &need_locks);
+	vma_assert_attached(vma_new);
 
 	ASSERT_EQ(vma_new, vma_next);
 
@@ -1576,6 +1599,7 @@ static bool test_expand_only_mode(void)
 	ASSERT_EQ(vma->vm_pgoff, 3);
 	ASSERT_TRUE(vma_write_started(vma));
 	ASSERT_EQ(vma_iter_addr(&vmi), 0x3000);
+	vma_assert_attached(vma);
 
 	cleanup_mm(&mm, &vmi);
 	return true;
diff --git a/tools/testing/vma/vma_internal.h b/tools/testing/vma/vma_internal.h
index f93f7f74f97b..34277842156c 100644
--- a/tools/testing/vma/vma_internal.h
+++ b/tools/testing/vma/vma_internal.h
@@ -470,6 +470,16 @@ static inline void vma_lock_init(struct vm_area_struct *vma)
 	vma->vm_lock_seq = UINT_MAX;
 }
 
+static inline void vma_assert_attached(struct vm_area_struct *vma)
+{
+	WARN_ON_ONCE(vma->detached);
+}
+
+static inline void vma_assert_detached(struct vm_area_struct *vma)
+{
+	WARN_ON_ONCE(!vma->detached);
+}
+
 static inline void vma_assert_write_locked(struct vm_area_struct *);
 static inline void vma_mark_attached(struct vm_area_struct *vma)
 {
-- 
2.48.1.601.g30ceb7b040-goog


