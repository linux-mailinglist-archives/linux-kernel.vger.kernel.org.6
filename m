Return-Path: <linux-kernel+bounces-514037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FA20A35193
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 23:50:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D10916072E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 22:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FFEE22D7B0;
	Thu, 13 Feb 2025 22:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o76BVUCG"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9DFC28136A
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 22:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739486854; cv=none; b=LumxogqlkPSgm/5kHMeT7Tyz6DOrOXt+TF0urbIHc8bspBLqQkp962FDXczHzdDBuJvqSnaSC4Oob4swX7PaskqonO+9PxdWdJfsSnWvWDg+onUogKw8sjZt+hFHVonI+6BBKEMddPLZoeLvxopaIvcy3/1UxLfW7ZuI2yEzYr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739486854; c=relaxed/simple;
	bh=PUJSTy45dtpyUmxXxenkiNMkF+uifqCqHqbn1BfbXCI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Pbfz+CoaMkQ3HkcQHmrCwQYgAq9A1N6EENSTVjgXfEmZT5bmSzgSgHQA5wIF1Ur38r9DGH1ElSupCuxF268cR6spSOu9H4InYWCmnRoiaVv8I7gAWmfqX1nz6hjubKlIn6cq5qTE7uJAe90Gl5ztH15sjY/lvNReMVvVhBPXEms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=o76BVUCG; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2fa57c42965so3266887a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 14:47:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739486852; x=1740091652; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3PBMMH2moGlibOV+gRj99WpX+TZ+10z7I1DXCC5PdQ8=;
        b=o76BVUCGJCk47Z1ErORyJfPR++QMfO2WsB1YmhK7DedLiyQa3Soe495iIjVeLw4ifq
         Ug3kT43T2uiHGrtpZkHjO4TWMVgP42xMDva07jNf64eEDnBtx6rl/RVFUn/IJU0gtmmg
         9/WqxB94fCPCBN/nNiu7n2GonrsJXnq9b8jDWRMSSQp9cZLltoONRp9dhdoM2DpTzRHt
         2BHXQ88tJzP0kSCf+X2lZlN/cnZwP3690jUB/fHMm+xlDueoSb744qUL/Uey7jn76s4i
         lKP33ZTl7k0XDjjFm7YPNflGtNSRvgeLnbk4YbbT8zK8Ea/MEumt1XdsyEZ8oBbdpcCP
         bjKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739486852; x=1740091652;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3PBMMH2moGlibOV+gRj99WpX+TZ+10z7I1DXCC5PdQ8=;
        b=ocqg0J75//3kTMEETm6wY1jjGL8PllzLiICyRCMw20Wy71YCkIHzMrKO1qOCPvw5P0
         VOxKaEVnpnUIFPcu+Lk8oxWe7lfpyg8VkVgUpbBjtcVew/3u3p8Rjalh/ODj0qmFE3pY
         QS7bNzuMPvKrL3ntX2hnJsNehQW01mIB4yvJeLl7JF6/HFFS0f/cnQ+30h91y1vcr+gz
         BfJBAW+qrLEZmm0OcdK4s0yiequuQbiyulfSssZxtZstqJFFEf7xAhViAF3oytNbDzZk
         aILvGWzsuTVn6WrFLieGJubU1wx44ZGiopwCTRqrM9YFCj25coluHRCJAzsvEvTw0VAP
         M/Cg==
X-Forwarded-Encrypted: i=1; AJvYcCUKRHfm8rtM8OmBPgPPaoFFDuCl3rRro4OG4SyGjp9gPS/pfJbwdlYiyhgbsPFs3SBdmKHnEp0CGNXkIao=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpfrZ2rn8L1vCT7KGcKOe2vRLTn4PMXZKP5EaNqN0NXxaLjUrh
	fH6Umk41qAjCgKEPnUxWoSIV8yj8zlnd4i75Xxuy77IQDoqQpKm0DJPlQ9abC4T1BwnR1NniChP
	yWg==
X-Google-Smtp-Source: AGHT+IGMj8N9UltRndmqK4fcmCOY71dV/ZTT0TWqfMv3mL8UIMVUEmmB9CXosWINwjoG+HVa2iESOUWrDew=
X-Received: from pfblc21.prod.google.com ([2002:a05:6a00:4f55:b0:730:9378:98c1])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:2585:b0:1ea:e81c:60fa
 with SMTP id adf61e73a8af0-1ee5c78b20bmr13938165637.20.1739486852080; Thu, 13
 Feb 2025 14:47:32 -0800 (PST)
Date: Thu, 13 Feb 2025 14:46:53 -0800
In-Reply-To: <20250213224655.1680278-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250213224655.1680278-1-surenb@google.com>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <20250213224655.1680278-17-surenb@google.com>
Subject: [PATCH v10 16/18] mm: prepare lock_vma_under_rcu() for vma reuse possibility
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

Once we make vma cache SLAB_TYPESAFE_BY_RCU, it will be possible for a vma
to be reused and attached to another mm after lock_vma_under_rcu() locks
the vma. lock_vma_under_rcu() should ensure that vma_start_read() is using
the original mm and after locking the vma it should ensure that vma->vm_mm
has not changed from under us.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
---
 include/linux/mm.h | 12 ++++++++----
 mm/memory.c        |  7 ++++---
 2 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 327cf5944569..88693568c9ef 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -739,10 +739,13 @@ static inline void vma_refcount_put(struct vm_area_struct *vma)
  * Try to read-lock a vma. The function is allowed to occasionally yield false
  * locked result to avoid performance overhead, in which case we fall back to
  * using mmap_lock. The function should never yield false unlocked result.
+ * False locked result is possible if mm_lock_seq overflows or if vma gets
+ * reused and attached to a different mm before we lock it.
  * Returns the vma on success, NULL on failure to lock and EAGAIN if vma got
  * detached.
  */
-static inline struct vm_area_struct *vma_start_read(struct vm_area_struct *vma)
+static inline struct vm_area_struct *vma_start_read(struct mm_struct *mm,
+						    struct vm_area_struct *vma)
 {
 	int oldcnt;
 
@@ -753,7 +756,7 @@ static inline struct vm_area_struct *vma_start_read(struct vm_area_struct *vma)
 	 * we don't rely on for anything - the mm_lock_seq read against which we
 	 * need ordering is below.
 	 */
-	if (READ_ONCE(vma->vm_lock_seq) == READ_ONCE(vma->vm_mm->mm_lock_seq.sequence))
+	if (READ_ONCE(vma->vm_lock_seq) == READ_ONCE(mm->mm_lock_seq.sequence))
 		return NULL;
 
 	/*
@@ -780,7 +783,7 @@ static inline struct vm_area_struct *vma_start_read(struct vm_area_struct *vma)
 	 * after it has been unlocked.
 	 * This pairs with RELEASE semantics in vma_end_write_all().
 	 */
-	if (unlikely(vma->vm_lock_seq == raw_read_seqcount(&vma->vm_mm->mm_lock_seq))) {
+	if (unlikely(vma->vm_lock_seq == raw_read_seqcount(&mm->mm_lock_seq))) {
 		vma_refcount_put(vma);
 		return NULL;
 	}
@@ -914,7 +917,8 @@ struct vm_area_struct *lock_vma_under_rcu(struct mm_struct *mm,
 #else /* CONFIG_PER_VMA_LOCK */
 
 static inline void vma_lock_init(struct vm_area_struct *vma, bool reset_refcnt) {}
-static inline struct vm_area_struct *vma_start_read(struct vm_area_struct *vma)
+static inline struct vm_area_struct *vma_start_read(struct mm_struct *mm,
+						    struct vm_area_struct *vma)
 		{ return NULL; }
 static inline void vma_end_read(struct vm_area_struct *vma) {}
 static inline void vma_start_write(struct vm_area_struct *vma) {}
diff --git a/mm/memory.c b/mm/memory.c
index 528407c0d7cf..6378a873e7c1 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -6492,7 +6492,7 @@ struct vm_area_struct *lock_vma_under_rcu(struct mm_struct *mm,
 	if (!vma)
 		goto inval;
 
-	vma = vma_start_read(vma);
+	vma = vma_start_read(mm, vma);
 	if (IS_ERR_OR_NULL(vma)) {
 		/* Check if the VMA got isolated after we found it */
 		if (PTR_ERR(vma) == -EAGAIN) {
@@ -6512,8 +6512,9 @@ struct vm_area_struct *lock_vma_under_rcu(struct mm_struct *mm,
 	 * fields are accessible for RCU readers.
 	 */
 
-	/* Check since vm_start/vm_end might change before we lock the VMA */
-	if (unlikely(address < vma->vm_start || address >= vma->vm_end))
+	/* Check if the vma we locked is the right one. */
+	if (unlikely(vma->vm_mm != mm ||
+		     address < vma->vm_start || address >= vma->vm_end))
 		goto inval_end_read;
 
 	rcu_read_unlock();
-- 
2.48.1.601.g30ceb7b040-goog


