Return-Path: <linux-kernel+bounces-435764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EBF49E7BFE
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 23:52:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE40528346E
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 22:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D3EB213E8B;
	Fri,  6 Dec 2024 22:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1xafacCX"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9368C213E64
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 22:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733525535; cv=none; b=TQfoqZccY2Y+ewyxI15gZsEe1ZRnbywes/yjDe0F1spfwXdONbESBapozIHnwSaQto1wcQ1/LiTGa0PMWoab+EweKgZfhMMuka1swgXDfF1vvQCffQ7Vf+MrzAWXpUkcuV6WwpmlRMjYJpzjyijWN+CFxEWRhgA2SwAPc1xL0oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733525535; c=relaxed/simple;
	bh=XcgvtnPc0ZtjSlSdejhrnXMo9S3SS+IQQAWD3AyzvMI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QCY5egwjgazOu3C8GFgjpz6PdlL8SAMaRvj7asQh8MboyfRUyrFJn+feYorsuI8QlgR+liBLOxqUHRvrEk2a1sB6nOLPmaZgmoYHDzGpaxKX4ZqQYBss7xXS9BGRKwZ1zmIPdERi1NdVixqbA/Kyl8S19NKNbP1hPS3BZdagkXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1xafacCX; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2ee86953aeaso2515896a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2024 14:52:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733525533; x=1734130333; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/Y40baPUGWax4wYRQAtfppaknEh3um9zBwyBL9xV1Y4=;
        b=1xafacCXcH8ZKA3IN1fS+FompP40vgnyM3qlXuDjILXY0yTwKBF3RfXNpdvWR+zXLa
         rnA4E5a5bcKYxP9ePw1PyDoF8IsmpI/jRXj3VKgJx3Se5FEasW48lpqwJNVGAjP+vde9
         jwhisL3eTVbcmSdeUbMXeH4SHMfMtfdHNAZXMpBQzUeABFs28BC7rVdNMFRKoebmG52U
         bg7mpIfBShyJjcuMCRrinwpcUvvH9P/FJQgVcTUUDXptHRcfjpqQPCufPJrUNxGHM/Xi
         4GLZL5cfKBH0ZmA9aQoOFTsjo9PwrYNsFTzNn1uuoWIyy59kFh0sjZI5x7d2JjkyNwH5
         exNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733525533; x=1734130333;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/Y40baPUGWax4wYRQAtfppaknEh3um9zBwyBL9xV1Y4=;
        b=p9SJzCvn+5HJr1TwKGmZ96/rJUJNSZJ5i2mR6GC9qxiSmJadGgZL5Bt6oYOqpkPbrm
         NQ9knhDN/3tBdJCDxZczlbNa8ULaAsPmmZMhVEffZv/xPdT2MaUmj4QPXmuAOFAPlE7V
         x9R0/uJPnZcmJzsoPJpcrkskxwCVHvK4wW19NoNcM44AGQSAmnVBiMhEy4ZnfMEn0dXj
         KrwWbwM2vgD8YpMkAZN5TMgf8T+skcijMhTCkHCcqDw+E1rYSTmkiN291Da2obbqFCpT
         jE9pBiwf0iqiOgbGLpEhVxHMZucSkQ+FdKEDzHDwVMyb/JLd4xw5+2pGSTX5e4TGnbfr
         jFfQ==
X-Forwarded-Encrypted: i=1; AJvYcCV6zUJZhr03c/pOdN15orVlhujck5wiS29o91Nx0IQbIjVrAiMqpX3TiPzOETTe/RmFvL3UWKi8aTd7YxQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNytxtlIjnnSqf71IQNngXvpKfOTHA82tep9hcE5L2xaMXWFEw
	EfJ+UjE2E3a4MsOpqdGLQ1RKLS6ZgLatutmuXC9FNqrN1dc7Cqu+CKydYWMc3eHy1qjOSCep8pI
	RAg==
X-Google-Smtp-Source: AGHT+IHCd2OHlcBdUGfCCxX6+VS5I4FF5b82AKepICjOdPKRrERfe6SXg3caG61pXASigp7AKy6oYeA6ikU=
X-Received: from pjbmf7.prod.google.com ([2002:a17:90b:1847:b0:2e1:8750:2b46])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2d43:b0:2ee:ba84:5cac
 with SMTP id 98e67ed59e1d1-2ef6955f863mr7322434a91.7.1733525533068; Fri, 06
 Dec 2024 14:52:13 -0800 (PST)
Date: Fri,  6 Dec 2024 14:52:00 -0800
In-Reply-To: <20241206225204.4008261-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241206225204.4008261-1-surenb@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241206225204.4008261-4-surenb@google.com>
Subject: [PATCH v5 3/6] mm: mark vma as detached until it's added into vma tree
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
Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 include/linux/mm.h               | 27 ++++++++++++++++++++-------
 kernel/fork.c                    |  4 ++++
 mm/memory.c                      |  2 +-
 mm/vma.c                         |  6 +++---
 mm/vma.h                         |  2 ++
 tools/testing/vma/vma_internal.h | 17 ++++++++++++-----
 6 files changed, 42 insertions(+), 16 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index ee71a504ef88..2bf38c1e9cca 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -820,12 +820,21 @@ static inline void vma_assert_locked(struct vm_area_struct *vma)
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
@@ -856,8 +865,8 @@ static inline void vma_end_read(struct vm_area_struct *vma) {}
 static inline void vma_start_write(struct vm_area_struct *vma) {}
 static inline void vma_assert_write_locked(struct vm_area_struct *vma)
 		{ mmap_assert_write_locked(vma->vm_mm); }
-static inline void vma_mark_detached(struct vm_area_struct *vma,
-				     bool detached) {}
+static inline void vma_mark_attached(struct vm_area_struct *vma) {}
+static inline void vma_mark_detached(struct vm_area_struct *vma) {}
 
 static inline struct vm_area_struct *lock_vma_under_rcu(struct mm_struct *mm,
 		unsigned long address)
@@ -890,7 +899,10 @@ static inline void vma_init(struct vm_area_struct *vma, struct mm_struct *mm)
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
@@ -1085,6 +1097,7 @@ static inline int vma_iter_bulk_store(struct vma_iterator *vmi,
 	if (unlikely(mas_is_err(&vmi->mas)))
 		return -ENOMEM;
 
+	vma_mark_attached(vma);
 	return 0;
 }
 
diff --git a/kernel/fork.c b/kernel/fork.c
index 21660a9ad97a..71990f46aa4e 100644
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
index f823906a4a0f..b252f19b28c9 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -6372,7 +6372,7 @@ struct vm_area_struct *lock_vma_under_rcu(struct mm_struct *mm,
 		goto inval;
 
 	/* Check if the VMA got isolated after we found it */
-	if (vma->detached) {
+	if (is_vma_detached(vma)) {
 		vma_end_read(vma);
 		count_vm_vma_lock_event(VMA_LOCK_MISS);
 		/* The area was replaced with another one */
diff --git a/mm/vma.c b/mm/vma.c
index a06747845cac..cdc63728f47f 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -327,7 +327,7 @@ static void vma_complete(struct vma_prepare *vp, struct vma_iterator *vmi,
 
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
index 295d44ea54db..32d99b2963df 100644
--- a/mm/vma.h
+++ b/mm/vma.h
@@ -156,6 +156,7 @@ static inline int vma_iter_store_gfp(struct vma_iterator *vmi,
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
index 568c18d24d53..0cdc5f8c3d60 100644
--- a/tools/testing/vma/vma_internal.h
+++ b/tools/testing/vma/vma_internal.h
@@ -465,13 +465,17 @@ static inline void vma_lock_init(struct vm_area_struct *vma)
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
@@ -484,7 +488,8 @@ static inline void vma_init(struct vm_area_struct *vma, struct mm_struct *mm)
 	vma->vm_mm = mm;
 	vma->vm_ops = &vma_dummy_vm_ops;
 	INIT_LIST_HEAD(&vma->anon_vma_chain);
-	vma_mark_detached(vma, false);
+	/* vma is not locked, can't use vma_mark_detached() */
+	vma->detached = true;
 	vma_lock_init(vma);
 }
 
@@ -510,6 +515,8 @@ static inline struct vm_area_struct *vm_area_dup(struct vm_area_struct *orig)
 	memcpy(new, orig, sizeof(*new));
 	vma_lock_init(new);
 	INIT_LIST_HEAD(&new->anon_vma_chain);
+	/* vma is not locked, can't use vma_mark_detached() */
+	new->detached = true;
 
 	return new;
 }
-- 
2.47.0.338.g60cca15819-goog


