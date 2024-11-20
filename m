Return-Path: <linux-kernel+bounces-415081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 996579D3156
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 01:09:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 022EBB21CDB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 00:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 779BF1BC58;
	Wed, 20 Nov 2024 00:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HUxDAShG"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1EE914AA9
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 00:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732061320; cv=none; b=Y1fmxBPqmh7s+MMtEuoleiNfwR3GHlqJN4TZBmYUvw5pDG8FlKc179Ec0Txr1IDY0MyT7gxvU+ZSVwq4rMkvuhCu9uAv+IgTGA4SGiggio8w0t26GFfCEsEmnutnYJB/AFZE5BlAITFDGSIxiwvQiophNOpUs0FY9SsJbm9b+XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732061320; c=relaxed/simple;
	bh=jrfr4RcUu3VId0skjHL6ylHM/kjkS/nTfX1rjyeuf1o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aV8UBS/0av7VUB7YWPatAZQE9TNmBZyBLsCiCsOWP8MgwMA8Rh6+10NBZ8XjFSbfhuaE2j67h+6CQpBEREWyJ8aV9oSCbQAgc5qeQZII+bbHOwG49VvyBx1g3VnTDeTklfIOVzENxkqE+3tvVvpdl1GaqHxFR7C8XBYifoh2vHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HUxDAShG; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6ea258fe4b6so73896577b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 16:08:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732061318; x=1732666118; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=b7bh6sSGESOsY9pdAptx272UcEa/Ygad7puDmCEq6Kg=;
        b=HUxDAShGQPOEdK2z1jrUfrPCUCrDtfGZ3Fx5yK1Ne4jF+7L6H4M/KuNcQVIDiIN7aV
         VL1N7YMscI8WwDIS+UQYjWXFRN8rxWVv8YcuZ1Ps3nWHVieRtyJkDjBuRfEWgBUjNqzv
         +dmm480X5VoRfbrJ2WEf0Y8Wsg1EoeoTo4t1YDIirw4daLQ+GCOqVVo9Vk+/ktnsbIdn
         ND5odhK+AFUZ55/SX50Jx6vZZOvs/YEHu12KkyGc0s1J560MD18fdS/5aBx+0e50Gpk7
         Z8p6Lpkyybo1UoIRIGCPjtCOqdZuJLhxEIS8UM+/ozyPCEssKvKBNVAC4pcr7hnUfN9+
         spYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732061318; x=1732666118;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b7bh6sSGESOsY9pdAptx272UcEa/Ygad7puDmCEq6Kg=;
        b=ZIS2VhNbdtOLS7XDiLHy9FGpGbxurZAuPeO7Y9FNIGRn4ctpnyYwcPUhxwFxppH/PQ
         wCJAwu8tuSkYX/DMmZPpdqt2fpR0cE57kFZQX52Q2EB5exYIC91z6rCGPNvzdTQclQWI
         2CAKdHOvl+plXS6EoHV/n1V9Ci66Fz70ATgoRt5AebrGMY0BjKD20iQ9rfTH1QPllpjg
         yLPcGOQq03pUO/JjSCNhcIm5skPLOqlUkfARz0Z/CJculSnCKAfDILO1U96p6mkEX7nz
         zaYp9OiQDDcJU/l/l6gWtrU5JYR32+NMVkdHhE7Vpwp3pHivl9IMkdsR6SLV0p7XQaE2
         l28w==
X-Forwarded-Encrypted: i=1; AJvYcCUWdlhTYFW3ttK2RPEqF9BzRPWIRqIgDfcSIozj2RMZ88cfPEIx6Vf9fuMkqtmpkVuXtz1dm9VGrn10Op4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUgOKchyDDJ2EyTv6wFvB9fNI3k8dxxJX4eU8HxPHUnM34nQwY
	Xp1msYOnIhILySFa9+Hir2HktlTOEiw7DteWNUV2OIBMVlpIXdTeLyAJTXHU+Ty+lecySWSk7F8
	6TQ==
X-Google-Smtp-Source: AGHT+IGtVg+pmzlMfUNmBABZ8fcc/vYjedj6yHOltiegFss4vfkD05ygP4e5H1ECoxnohN55I5GlusLW3iM=
X-Received: from surenb-desktop.mtv.corp.google.com ([2a00:79e0:2e3f:8:af45:bbc1:fc75:e695])
 (user=surenb job=sendgmr) by 2002:a05:690c:5811:b0:6e3:8562:fbf with SMTP id
 00721157ae682-6eebd2b241fmr6217b3.3.1732061317506; Tue, 19 Nov 2024 16:08:37
 -0800 (PST)
Date: Tue, 19 Nov 2024 16:08:24 -0800
In-Reply-To: <20241120000826.335387-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241120000826.335387-1-surenb@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241120000826.335387-4-surenb@google.com>
Subject: [PATCH v4 3/5] mm: mark vma as detached until it's added into vma tree
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: willy@infradead.org, liam.howlett@oracle.com, lorenzo.stoakes@oracle.com, 
	mhocko@suse.com, vbabka@suse.cz, hannes@cmpxchg.org, mjguzik@gmail.com, 
	oliver.sang@intel.com, mgorman@techsingularity.net, david@redhat.com, 
	peterx@redhat.com, oleg@redhat.com, dave@stgolabs.net, paulmck@kernel.org, 
	brauner@kernel.org, dhowells@redhat.com, hdanton@sina.com, hughd@google.com, 
	minchan@google.com, jannh@google.com, shakeel.butt@linux.dev, 
	souravpanda@google.com, pasha.tatashin@soleen.com, corbet@lwn.net, 
	linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	kernel-team@android.com, surenb@google.com
Content-Type: text/plain; charset="UTF-8"

Current implementation does not set detached flag when a VMA is first
allocated. This does not represent the real state of the VMA, which is
detached until it is added into mm's VMA tree. Fix this by marking new
VMAs as detached and resetting detached flag only after VMA is added
into a tree.
Introduce vma_mark_attached() to make the API more readable and to
simplify possible future cleanup when vma->vm_mm might be used to
indicate detached vma and vma_mark_attached() will need an additional
mm parameter.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 include/linux/mm.h               | 27 ++++++++++++++++++++-------
 kernel/fork.c                    |  4 ++++
 mm/memory.c                      |  2 +-
 mm/vma.c                         |  6 +++---
 mm/vma.h                         |  2 ++
 tools/testing/vma/vma_internal.h | 17 ++++++++++++-----
 6 files changed, 42 insertions(+), 16 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 737c003b0a1e..dd1b6190df28 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -808,12 +808,21 @@ static inline void vma_assert_locked(struct vm_area_struct *vma)
 		vma_assert_write_locked(vma);
 }
 
-static inline void vma_mark_detached(struct vm_area_struct *vma, bool detached)
+static inline void vma_mark_attached(struct vm_area_struct *vma)
+{
+	vma->detached = false;
+}
+
+static inline void vma_mark_detached(struct vm_area_struct *vma)
 {
 	/* When detaching vma should be write-locked */
-	if (detached)
-		vma_assert_write_locked(vma);
-	vma->detached = detached;
+	vma_assert_write_locked(vma);
+	vma->detached = true;
+}
+
+static inline bool is_vma_detached(struct vm_area_struct *vma)
+{
+	return vma->detached;
 }
 
 static inline void release_fault_lock(struct vm_fault *vmf)
@@ -844,8 +853,8 @@ static inline void vma_end_read(struct vm_area_struct *vma) {}
 static inline void vma_start_write(struct vm_area_struct *vma) {}
 static inline void vma_assert_write_locked(struct vm_area_struct *vma)
 		{ mmap_assert_write_locked(vma->vm_mm); }
-static inline void vma_mark_detached(struct vm_area_struct *vma,
-				     bool detached) {}
+static inline void vma_mark_attached(struct vm_area_struct *vma) {}
+static inline void vma_mark_detached(struct vm_area_struct *vma) {}
 
 static inline struct vm_area_struct *lock_vma_under_rcu(struct mm_struct *mm,
 		unsigned long address)
@@ -878,7 +887,10 @@ static inline void vma_init(struct vm_area_struct *vma, struct mm_struct *mm)
 	vma->vm_mm = mm;
 	vma->vm_ops = &vma_dummy_vm_ops;
 	INIT_LIST_HEAD(&vma->anon_vma_chain);
-	vma_mark_detached(vma, false);
+#ifdef CONFIG_PER_VMA_LOCK
+	/* vma is not locked, can't use vma_mark_detached() */
+	vma->detached = true;
+#endif
 	vma_numab_state_init(vma);
 	vma_lock_init(vma);
 }
@@ -1073,6 +1085,7 @@ static inline int vma_iter_bulk_store(struct vma_iterator *vmi,
 	if (unlikely(mas_is_err(&vmi->mas)))
 		return -ENOMEM;
 
+	vma_mark_attached(vma);
 	return 0;
 }
 
diff --git a/kernel/fork.c b/kernel/fork.c
index 7823797e31d2..f0cec673583c 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -465,6 +465,10 @@ struct vm_area_struct *vm_area_dup(struct vm_area_struct *orig)
 	data_race(memcpy(new, orig, sizeof(*new)));
 	vma_lock_init(new);
 	INIT_LIST_HEAD(&new->anon_vma_chain);
+#ifdef CONFIG_PER_VMA_LOCK
+	/* vma is not locked, can't use vma_mark_detached() */
+	new->detached = true;
+#endif
 	vma_numab_state_init(new);
 	dup_anon_vma_name(orig, new);
 
diff --git a/mm/memory.c b/mm/memory.c
index 209885a4134f..d0197a0c0996 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -6279,7 +6279,7 @@ struct vm_area_struct *lock_vma_under_rcu(struct mm_struct *mm,
 		goto inval;
 
 	/* Check if the VMA got isolated after we found it */
-	if (vma->detached) {
+	if (is_vma_detached(vma)) {
 		vma_end_read(vma);
 		count_vm_vma_lock_event(VMA_LOCK_MISS);
 		/* The area was replaced with another one */
diff --git a/mm/vma.c b/mm/vma.c
index 8a454a7bbc80..73104d434567 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -295,7 +295,7 @@ static void vma_complete(struct vma_prepare *vp, struct vma_iterator *vmi,
 
 	if (vp->remove) {
 again:
-		vma_mark_detached(vp->remove, true);
+		vma_mark_detached(vp->remove);
 		if (vp->file) {
 			uprobe_munmap(vp->remove, vp->remove->vm_start,
 				      vp->remove->vm_end);
@@ -1220,7 +1220,7 @@ static void reattach_vmas(struct ma_state *mas_detach)
 
 	mas_set(mas_detach, 0);
 	mas_for_each(mas_detach, vma, ULONG_MAX)
-		vma_mark_detached(vma, false);
+		vma_mark_attached(vma);
 
 	__mt_destroy(mas_detach->tree);
 }
@@ -1295,7 +1295,7 @@ static int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
 		if (error)
 			goto munmap_gather_failed;
 
-		vma_mark_detached(next, true);
+		vma_mark_detached(next);
 		nrpages = vma_pages(next);
 
 		vms->nr_pages += nrpages;
diff --git a/mm/vma.h b/mm/vma.h
index 388d34748674..2e680f357ace 100644
--- a/mm/vma.h
+++ b/mm/vma.h
@@ -162,6 +162,7 @@ static inline int vma_iter_store_gfp(struct vma_iterator *vmi,
 	if (unlikely(mas_is_err(&vmi->mas)))
 		return -ENOMEM;
 
+	vma_mark_attached(vma);
 	return 0;
 }
 
@@ -385,6 +386,7 @@ static inline void vma_iter_store(struct vma_iterator *vmi,
 
 	__mas_set_range(&vmi->mas, vma->vm_start, vma->vm_end - 1);
 	mas_store_prealloc(&vmi->mas, vma);
+	vma_mark_attached(vma);
 }
 
 static inline unsigned long vma_iter_addr(struct vma_iterator *vmi)
diff --git a/tools/testing/vma/vma_internal.h b/tools/testing/vma/vma_internal.h
index 11c2c38ca4e8..2fed366d20ef 100644
--- a/tools/testing/vma/vma_internal.h
+++ b/tools/testing/vma/vma_internal.h
@@ -414,13 +414,17 @@ static inline void vma_lock_init(struct vm_area_struct *vma)
 	vma->vm_lock_seq = UINT_MAX;
 }
 
+static inline void vma_mark_attached(struct vm_area_struct *vma)
+{
+	vma->detached = false;
+}
+
 static inline void vma_assert_write_locked(struct vm_area_struct *);
-static inline void vma_mark_detached(struct vm_area_struct *vma, bool detached)
+static inline void vma_mark_detached(struct vm_area_struct *vma)
 {
 	/* When detaching vma should be write-locked */
-	if (detached)
-		vma_assert_write_locked(vma);
-	vma->detached = detached;
+	vma_assert_write_locked(vma);
+	vma->detached = true;
 }
 
 extern const struct vm_operations_struct vma_dummy_vm_ops;
@@ -431,7 +435,8 @@ static inline void vma_init(struct vm_area_struct *vma, struct mm_struct *mm)
 	vma->vm_mm = mm;
 	vma->vm_ops = &vma_dummy_vm_ops;
 	INIT_LIST_HEAD(&vma->anon_vma_chain);
-	vma_mark_detached(vma, false);
+	/* vma is not locked, can't use vma_mark_detached() */
+	vma->detached = true;
 	vma_lock_init(vma);
 }
 
@@ -457,6 +462,8 @@ static inline struct vm_area_struct *vm_area_dup(struct vm_area_struct *orig)
 	memcpy(new, orig, sizeof(*new));
 	vma_lock_init(new);
 	INIT_LIST_HEAD(&new->anon_vma_chain);
+	/* vma is not locked, can't use vma_mark_detached() */
+	new->detached = true;
 
 	return new;
 }
-- 
2.47.0.338.g60cca15819-goog


