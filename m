Return-Path: <linux-kernel+bounces-514024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BE55A35176
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 23:47:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3707316BF2B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 22:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42DDD270EDC;
	Thu, 13 Feb 2025 22:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Qmx/QaSc"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8CC1270ECA
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 22:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739486828; cv=none; b=qcstt1KSMZ4/+2rQjO39+Cw+uFsIQ2Z4uwJweFBrVaJrNHGzR6sItBELN6HY1U3d/8O/YlsJ1bWw9XRIMBaCZ8On+gE4JULrQTS0Ate2kWBZo+GpOk+OD3yuQsXlttkKRno1G9SZEf5J7t3UQ/n8EqZXErfAcV0kaGwmcIBNpcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739486828; c=relaxed/simple;
	bh=1wvMLI0NBniwlQu60PYpOeJQ3NRJ5/21wehA42VzWGw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OH921lx6YjtV2tVsNLO4Q9uH7aiNl5Le9rvncDLGsE9GoXeeydIQNHYyaTtsGE1OyCcR/LCvRMjnVpIJAc41eIeNTGK9GQW2aJSCDEJwyArjPXsVx5pi1XbyU+G7uQK2OrAWcdPE0VSynF98TpQmP27hXNLw0jiZTFc5pQSELTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Qmx/QaSc; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-220e1593b85so16022145ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 14:47:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739486826; x=1740091626; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=IpC5RSofcM0ZStaR556vDop/rdew408+n2xS+qUK8/0=;
        b=Qmx/QaScaUPEU4CHocLbhQmjHpcOE91fyYeTGDG2wtBOUfv7DuSpcM4pD0L8pKyVb2
         KBvblQJcOUWpIqo3G9YwqwvHizCOUtqbf7bKMfyOUWbmAYXfInKZ3Q4alnZbL4qwuTT3
         aNH1d4KhQ2e5sLbBLvs+nQcpi3wT2IviKMklIcxrO1ov5VZb8tffiGDmyaypvQ+2QV9U
         kkNjKZYgNXnn5ldT291o9cQeDpJTDcaN5rB+LBbz7Hl/0TWzKv9U0swm7XWvDQB8d0km
         rbNDsnS/lB+MTDQHMVVnTUtMT3Uf3x63RXOGxpw3nj3eaBDzKVW4ISoYw9VzI0+qALkH
         x/oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739486826; x=1740091626;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IpC5RSofcM0ZStaR556vDop/rdew408+n2xS+qUK8/0=;
        b=mvf3GeekxdkxXbnWmhTbsoPw873fKVbhjgQb1R2KCcFaEK8GmBwKoP8GoP4BdtvCX7
         Ew9wZ46XsTMJNA5GQZbZmWWeqKjgqD8LLwS72gxlZT7NUHP1SNJhnABAO8HjjrDGu0uy
         1pcXXnMURxK8v3rh9jp/KHZwJpzWESh7JkDDibNCefsyjT/evvxxTow7iAy8/ASfXtA7
         NS5QFyVGn0l7/NimXCwbVOlpsPzM1HPWR+1MRskSN7o6oaEjq4BoMqgQbF1SmQkjpxen
         //P3ZlvPAHTr7W4EsUuwKxUBaTPmaymyYOXFgs8F5Xldl/gp9TuyNcNLkGp+sAZUZshi
         BqIg==
X-Forwarded-Encrypted: i=1; AJvYcCXobUu/8VfoHnsp+ahkN1sj7QkzG8G0J5LUEewjeBgH0zkPJxHGZiOgwXPTjrT+1YQIr8Reyr0EfjcDOUM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5wYS47K5Zc3VTch8KhPaI+hSdfvZrJdl+1RCQOPwYcxb+GjBY
	T4YKbTuyqnNmCxlzSd/ks+XjwlmX/9r2jYV5gFLMqmOcz1sWYWm2eDCeQ8t/jv+MueShFBVPHSp
	Aug==
X-Google-Smtp-Source: AGHT+IFlXfVeKvLwc31ADPhBrs1WWy20ACeukrGHKQSKrbfZQq/alc0hc5JcyIHneAFIaVwEe3JXjLuYCE8=
X-Received: from pfbbi29.prod.google.com ([2002:a05:6a00:311d:b0:730:83d2:d6a3])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:50a:b0:1ee:69cb:4b42
 with SMTP id adf61e73a8af0-1ee6b399cd4mr12028188637.32.1739486826085; Thu, 13
 Feb 2025 14:47:06 -0800 (PST)
Date: Thu, 13 Feb 2025 14:46:40 -0800
In-Reply-To: <20250213224655.1680278-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250213224655.1680278-1-surenb@google.com>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <20250213224655.1680278-4-surenb@google.com>
Subject: [PATCH v10 03/18] mm: mark vma as detached until it's added into vma tree
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
	kernel-team@android.com, surenb@google.com, 
	"Liam R. Howlett" <Liam.Howlett@Oracle.com>
Content-Type: text/plain; charset="UTF-8"

Current implementation does not set detached flag when a VMA is first
allocated.  This does not represent the real state of the VMA, which is
detached until it is added into mm's VMA tree.  Fix this by marking new
VMAs as detached and resetting detached flag only after VMA is added into
a tree.

Introduce vma_mark_attached() to make the API more readable and to
simplify possible future cleanup when vma->vm_mm might be used to indicate
detached vma and vma_mark_attached() will need an additional mm parameter.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Reviewed-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 include/linux/mm.h               | 27 ++++++++++++++++++++-------
 kernel/fork.c                    |  4 ++++
 mm/memory.c                      |  2 +-
 mm/vma.c                         |  6 +++---
 mm/vma.h                         |  2 ++
 tools/testing/vma/vma_internal.h | 17 ++++++++++++-----
 6 files changed, 42 insertions(+), 16 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index e75fae95b48d..cd5ee61e98f2 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -821,12 +821,21 @@ static inline void vma_assert_locked(struct vm_area_struct *vma)
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
@@ -857,8 +866,8 @@ static inline void vma_end_read(struct vm_area_struct *vma) {}
 static inline void vma_start_write(struct vm_area_struct *vma) {}
 static inline void vma_assert_write_locked(struct vm_area_struct *vma)
 		{ mmap_assert_write_locked(vma->vm_mm); }
-static inline void vma_mark_detached(struct vm_area_struct *vma,
-				     bool detached) {}
+static inline void vma_mark_attached(struct vm_area_struct *vma) {}
+static inline void vma_mark_detached(struct vm_area_struct *vma) {}
 
 static inline struct vm_area_struct *lock_vma_under_rcu(struct mm_struct *mm,
 		unsigned long address)
@@ -891,7 +900,10 @@ static inline void vma_init(struct vm_area_struct *vma, struct mm_struct *mm)
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
@@ -1086,6 +1098,7 @@ static inline int vma_iter_bulk_store(struct vma_iterator *vmi,
 	if (unlikely(mas_is_err(&vmi->mas)))
 		return -ENOMEM;
 
+	vma_mark_attached(vma);
 	return 0;
 }
 
diff --git a/kernel/fork.c b/kernel/fork.c
index bdbabe73fb29..5bf3e407c795 100644
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
index a8d6dbd03668..e600a5ff3c7a 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -6414,7 +6414,7 @@ struct vm_area_struct *lock_vma_under_rcu(struct mm_struct *mm,
 		goto inval;
 
 	/* Check if the VMA got isolated after we found it */
-	if (vma->detached) {
+	if (is_vma_detached(vma)) {
 		vma_end_read(vma);
 		count_vm_vma_lock_event(VMA_LOCK_MISS);
 		/* The area was replaced with another one */
diff --git a/mm/vma.c b/mm/vma.c
index 39146c19f316..498507d8a262 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -341,7 +341,7 @@ static void vma_complete(struct vma_prepare *vp, struct vma_iterator *vmi,
 
 	if (vp->remove) {
 again:
-		vma_mark_detached(vp->remove, true);
+		vma_mark_detached(vp->remove);
 		if (vp->file) {
 			uprobe_munmap(vp->remove, vp->remove->vm_start,
 				      vp->remove->vm_end);
@@ -1238,7 +1238,7 @@ static void reattach_vmas(struct ma_state *mas_detach)
 
 	mas_set(mas_detach, 0);
 	mas_for_each(mas_detach, vma, ULONG_MAX)
-		vma_mark_detached(vma, false);
+		vma_mark_attached(vma);
 
 	__mt_destroy(mas_detach->tree);
 }
@@ -1313,7 +1313,7 @@ static int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
 		if (error)
 			goto munmap_gather_failed;
 
-		vma_mark_detached(next, true);
+		vma_mark_detached(next);
 		nrpages = vma_pages(next);
 
 		vms->nr_pages += nrpages;
diff --git a/mm/vma.h b/mm/vma.h
index e55e68abfbe3..bffb56afce5f 100644
--- a/mm/vma.h
+++ b/mm/vma.h
@@ -205,6 +205,7 @@ static inline int vma_iter_store_gfp(struct vma_iterator *vmi,
 	if (unlikely(mas_is_err(&vmi->mas)))
 		return -ENOMEM;
 
+	vma_mark_attached(vma);
 	return 0;
 }
 
@@ -437,6 +438,7 @@ static inline void vma_iter_store(struct vma_iterator *vmi,
 
 	__mas_set_range(&vmi->mas, vma->vm_start, vma->vm_end - 1);
 	mas_store_prealloc(&vmi->mas, vma);
+	vma_mark_attached(vma);
 }
 
 static inline unsigned long vma_iter_addr(struct vma_iterator *vmi)
diff --git a/tools/testing/vma/vma_internal.h b/tools/testing/vma/vma_internal.h
index 4506e6fb3c6f..f93f7f74f97b 100644
--- a/tools/testing/vma/vma_internal.h
+++ b/tools/testing/vma/vma_internal.h
@@ -471,12 +471,16 @@ static inline void vma_lock_init(struct vm_area_struct *vma)
 }
 
 static inline void vma_assert_write_locked(struct vm_area_struct *);
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
 }
 
 extern const struct vm_operations_struct vma_dummy_vm_ops;
@@ -489,7 +493,8 @@ static inline void vma_init(struct vm_area_struct *vma, struct mm_struct *mm)
 	vma->vm_mm = mm;
 	vma->vm_ops = &vma_dummy_vm_ops;
 	INIT_LIST_HEAD(&vma->anon_vma_chain);
-	vma_mark_detached(vma, false);
+	/* vma is not locked, can't use vma_mark_detached() */
+	vma->detached = true;
 	vma_lock_init(vma);
 }
 
@@ -515,6 +520,8 @@ static inline struct vm_area_struct *vm_area_dup(struct vm_area_struct *orig)
 	memcpy(new, orig, sizeof(*new));
 	vma_lock_init(new);
 	INIT_LIST_HEAD(&new->anon_vma_chain);
+	/* vma is not locked, can't use vma_mark_detached() */
+	new->detached = true;
 
 	return new;
 }
-- 
2.48.1.601.g30ceb7b040-goog


