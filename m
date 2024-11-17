Return-Path: <linux-kernel+bounces-412017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAED79D026C
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 09:10:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A82D4284E9E
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 08:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAAA2145FE8;
	Sun, 17 Nov 2024 08:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4ofDZfoI"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C4373D551
	for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2024 08:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731830988; cv=none; b=DhsHTVmNhF6WIJvk+ObcEd9mp7vKxOmRNhQJM0x3fV07m5ZLw4T+sx02lPIjS//ADlNMMMfJr7S8LZ0Dtok8eql1zI93Vz2KSA07/sY3HtmNiZDwZrLVbYdsuSNl8gd2nC7BcpLVZMFr2J8LBKcW3YDUKT5c5YekOI3TdgsIPy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731830988; c=relaxed/simple;
	bh=jrfr4RcUu3VId0skjHL6ylHM/kjkS/nTfX1rjyeuf1o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bFRipHZUDopOxuGyn1AjjEEyBiv58iYDpUqj0xwhbsicSxWs5YmYSSe4EZjuM/bYHXr1gedJrG0OrF2mWtZUsYThtjWLIbZ81d3UmTSUiEIZVfNCsM9kvkYYSI6AMyoVyvaKwJty7UfsHafwQU3VWPY/8dNurt0hDVdGHpVJDAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4ofDZfoI; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e388c4bd92bso741280276.1
        for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2024 00:09:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731830986; x=1732435786; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=b7bh6sSGESOsY9pdAptx272UcEa/Ygad7puDmCEq6Kg=;
        b=4ofDZfoIbCltQmh3wgN46QJAh32w9IycdHUW5mkKFYGfKiLUPfpWiazviTTklA/sOO
         2iSeTmmYCq28Qp31+x6B2JY51debFC1xZHNMQJ1rQFL9VHg2A3dZMOFNQBf0sthliX6n
         hZKPDSVw4TQYI4hHMI9wtrlk+1glCAgLzVMD0XUMLsWF0nuq4jG+MUybYKiHvZMZoZRo
         HoQE4jx2839RUHhglRfMiex2hPgnenHq38VPQOSGO9U5t849vuCVoFJM+fP8DaZn3ySI
         i6+9mJjzlZff0T2+G2ZmrU+BncRZE9IqoyR2e1oqsnV/zzQFTirWpEYztae13wddPg3A
         7PBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731830986; x=1732435786;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b7bh6sSGESOsY9pdAptx272UcEa/Ygad7puDmCEq6Kg=;
        b=MhRUc0KXB9dwrYR9H/KTUkQ2cwvQWeglakJIfcki9HShPO+Ol342NCH+1bht/uAzyf
         dKLdUfMQyHMyej4T4QXekIVkoAXDCCb7QUHqCZImqTWrOWLil4SKpiPV52LHPND6vXk8
         FP+4x+zeBJshtswuJhM7xbs+u890FbmmsYBdvbrtGZ8yuJNFy2dpJsDc7CCKgNyktVc5
         24snXPtDVXiPjW02jRpcQgnqZhMh+ipsrlsVFW0y+3WYeIBG4U6aAnWlEUsfmep2n0OQ
         8Ueo8BghbzXwYBKdvz5Jde6cJ3w97cK0PFiiz/rpETup1bKy+G0Fb5tBbW+5st0OLTBc
         nDOA==
X-Forwarded-Encrypted: i=1; AJvYcCVBumnoX3FtmaJBPUcURxI/wQJm4z4WcXT5W8FaCmFYJer8VOz6CHEtulBFgh/HlmZkCBUlJsK9Z7s8kxg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzpch60xioeZSWin6IVWHgaLrT4fsJdw9EkyZGnyZeVWQVq/ZlI
	OVvOpgqGe1P5i1M4ok4OfwOweGByf2HVYwptVpCaYr8rBCKE8tL+i2d4g2Vh1mkAleqsfRn8Mdf
	Frw==
X-Google-Smtp-Source: AGHT+IGF2YWbcHToc+T5cvIS4jQysZu9n+W2Aar36xDvDbuGFhbNn0TYu5GxTnL5QmwYgoOaAYtUUxzh9nI=
X-Received: from surenb-desktop.mtv.corp.google.com ([2a00:79e0:2e3f:8:bafc:6633:f766:6415])
 (user=surenb job=sendgmr) by 2002:a25:ab48:0:b0:e28:e6a1:fc53 with SMTP id
 3f1490d57ef6-e382639f42amr153411276.5.1731830986067; Sun, 17 Nov 2024
 00:09:46 -0800 (PST)
Date: Sun, 17 Nov 2024 00:09:29 -0800
In-Reply-To: <20241117080931.600731-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241117080931.600731-1-surenb@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241117080931.600731-4-surenb@google.com>
Subject: [PATCH v3 3/5] mm: mark vma as detached until it's added into vma tree
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


