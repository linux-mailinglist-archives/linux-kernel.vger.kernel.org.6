Return-Path: <linux-kernel+bounces-274664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE53A947B42
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 14:52:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D5A71C20E3F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 12:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA54D158DDC;
	Mon,  5 Aug 2024 12:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jSuRu8Qw"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3FC1553BD
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 12:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722862336; cv=none; b=tVkTjp6SXKpkFO331yKYFZhcpSAOox0ZD9++wHJyU6pjM0G2k/CGo5kDC0U6E5gT7hnWJhZRr4JDyWPCmaPdZlv+QWNzo58I784k4fzZDWfLezr9VB6kmHejbHC0nGW6HHSlxPKl0TvEsdcqeqfHVo68EvT9IHNEcjH+1zjs8TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722862336; c=relaxed/simple;
	bh=MWjl5CHOtPJ+y+F3Ajk9ABVkQ1dUm6I4TJr96LZ3VDg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=SlS+0XnTe3lx7UvOcJbx07lJE56q69yZQk/rb4TtXMD3DZemrw3kpJm35qg0cf13Mvz+c8HWOQDkXqCF9NNPtl92uEn6va1O+aFZWUOMQuNY+3gd9umwrmNx9RydaB5qVDWv+fiDsMZXQpyY3ZtkvCnsOCc1unrNRyb9R/cNW6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jSuRu8Qw; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5a28b61b880so12840a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 05:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722862332; x=1723467132; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iFF3dav9yqLjo0TF+kMn3kLYM5TWdwyUTbXMx4bI3W4=;
        b=jSuRu8QwZw626hwzoyL5pHeQJlOaKiwkzmAYHUp/yZMECuuExGd/iLIPtZi7WtJV7b
         5kDbkE6wU9AL8Wsy5Gpe3QGQCAVE8iyxFvjABf7FmGnHABg1cSYr4nGeXP24rMm+FScB
         //BVUoPrGlUGuINHfAAMLU6/p+FxpGVy/0CU8LPtpgz0mAGCG3/bxu+Nf0IgY3Oas9ob
         Lz4Kl7CO8pcj9q+kJsnAoGPidbMMPGxAa3RU+kVUlqopgFhzgPSrJ3ahhpJJCXjA68T1
         G3qiheVnWN6dFS7FXYFA2hce1DNWU58TH5HKmIed8VS4S3XT90YX4+n5OReB7tED0tXN
         mMWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722862332; x=1723467132;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iFF3dav9yqLjo0TF+kMn3kLYM5TWdwyUTbXMx4bI3W4=;
        b=rRQ8bPIxk3H1kztIiOqahhLuJ/V43uZvnMwEDsk4gZuhqIXCO0ZJrp3vg3lAghyVZg
         /1IAc2AxarJT0/uVFcNImWDgalb9liOEj9uBfvLZ5iD6tbkeZ3+QXI1P00aQmYueBII3
         Z9sYzUfrlu/1ULPf/vxjMVuToW35f8tDGRnD8FUzaxwaLdykxEha206heLuZs//WYPku
         DW7wk4Hz7sIj+kpeTkzjhNzHKtPMh0GGZ84LxeAk+KXoCt+dCIri4kDqPfmC5MdsHrnS
         vylVt4eX3fvNWOgMwt5n4ffkm/DElI0g6boSZWmi73Nv1Vycy5eReWviA0ROJIDCra2Z
         3OEg==
X-Forwarded-Encrypted: i=1; AJvYcCXk05vd9ufpUdA8ExfBZ0z39bPdytspzzSovUXmCDIS5IXAQQxDGA0NzIFmeWwXs/Kbek3TEphF0mcIhd2BrQWEnMc+auDqmQOwCWjQ
X-Gm-Message-State: AOJu0YzrbAhtslsOQAaKBeowmc+zOPTMx+tFhgGYqEoodZlwhEZu4Ml6
	8tJOho9VP17EfysBvXmlhHrkhPIeX9yluaRHqNKXhaSytpVQ3nZgd7pJ0pvN+LbFY8ICs12bWTS
	xzkT9
X-Google-Smtp-Source: AGHT+IG4/26WzDopprFPE7meuJ2PeY5a6Pyu8HGXYYV2gD7rPHmYXMwsFQ95W3PHgu9F8FoWIi0JoA==
X-Received: by 2002:a05:6402:2684:b0:5aa:19b1:ffc7 with SMTP id 4fb4d7f45d1cf-5b9c4a18619mr248206a12.2.1722862331691;
        Mon, 05 Aug 2024 05:52:11 -0700 (PDT)
Received: from localhost ([2a00:79e0:9d:4:ca74:8a49:a6f6:b872])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36bbd05b92esm9932069f8f.85.2024.08.05.05.52.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 05:52:11 -0700 (PDT)
From: Jann Horn <jannh@google.com>
Date: Mon, 05 Aug 2024 14:52:03 +0200
Subject: [PATCH] mm: fix (harmless) type confusion in lock_vma_under_rcu()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240805-fix-vma-lock-type-confusion-v1-1-9f25443a9a71@google.com>
X-B4-Tracking: v=1; b=H4sIAPPKsGYC/x2MWw5AMBAAryL7bZN6BlcRH0272KCVFiHi7srnJ
 DNzgyfH5KGJbnB0sGdrAiRxBGqUZiBkHRhSkeaiEgX2fOKxSJytmnC7VkJlTb9/HQpZF6WudZZ
 IgnBYHQX9v7fd87wlDPD0bQAAAA==
To: Andrew Morton <akpm@linux-foundation.org>, 
 Suren Baghdasaryan <surenb@google.com>
Cc: Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, Jann Horn <jannh@google.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722862327; l=5226;
 i=jannh@google.com; s=20240730; h=from:subject:message-id;
 bh=MWjl5CHOtPJ+y+F3Ajk9ABVkQ1dUm6I4TJr96LZ3VDg=;
 b=TWd/79YsLdDZZKgn1Jz6osa0+ZPcWmB2/fiJKUY5M99IObxmRNEi05oVj7U30iEKYVBXTtGQ4
 8VjaRetHUt8BF5g0WHqWgJqczrOPR7vixIhO+L4L2ybGirAof1h1xNw
X-Developer-Key: i=jannh@google.com; a=ed25519;
 pk=AljNtGOzXeF6khBXDJVVvwSEkVDGnnZZYqfWhP1V+C8=

There is a (harmless) type confusion in lock_vma_under_rcu():
After vma_start_read(), we have taken the VMA lock but don't know yet
whether the VMA has already been detached and scheduled for RCU freeing.
At this point, ->vm_start and ->vm_end are accessed.

vm_area_struct contains a union such that ->vm_rcu uses the same memory as
->vm_start and ->vm_end; so accessing ->vm_start and ->vm_end of a detached
VMA is illegal and leads to type confusion between union members.

Fix it by reordering the vma->detached check above the address checks, and
document the rules for RCU readers accessing VMAs.

This will probably change the number of observed VMA_LOCK_MISS events
(since previously, trying to access a detached VMA whose ->vm_rcu has been
scheduled would bail out when checking the fault address against the
rcu_head members reinterpreted as VMA bounds).

Fixes: 50ee32537206 ("mm: introduce lock_vma_under_rcu to be used from arch-specific code")
Signed-off-by: Jann Horn <jannh@google.com>
---
sidenote: I'm not entirely sure why we handle detached VMAs and moved
VMAs differently here (detached VMAs retry, moved VMAs bail out), but
that's kinda out of scope of this patch.
---
 include/linux/mm_types.h | 15 +++++++++++++--
 mm/memory.c              | 14 ++++++++++----
 2 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 485424979254..498cdf3121d0 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -657,58 +657,69 @@ struct vma_numab_state {
 
 /*
  * This struct describes a virtual memory area. There is one of these
  * per VM-area/task. A VM area is any part of the process virtual memory
  * space that has a special rule for the page-fault handlers (ie a shared
  * library, the executable area etc).
+ *
+ * Only explicitly marked struct members may be accessed by RCU readers before
+ * getting a stable reference.
  */
 struct vm_area_struct {
 	/* The first cache line has the info for VMA tree walking. */
 
 	union {
 		struct {
 			/* VMA covers [vm_start; vm_end) addresses within mm */
 			unsigned long vm_start;
 			unsigned long vm_end;
 		};
 #ifdef CONFIG_PER_VMA_LOCK
 		struct rcu_head vm_rcu;	/* Used for deferred freeing. */
 #endif
 	};
 
-	struct mm_struct *vm_mm;	/* The address space we belong to. */
+	/*
+	 * The address space we belong to.
+	 * Unstable RCU readers are allowed to read this.
+	 */
+	struct mm_struct *vm_mm;
 	pgprot_t vm_page_prot;          /* Access permissions of this VMA. */
 
 	/*
 	 * Flags, see mm.h.
 	 * To modify use vm_flags_{init|reset|set|clear|mod} functions.
 	 */
 	union {
 		const vm_flags_t vm_flags;
 		vm_flags_t __private __vm_flags;
 	};
 
 #ifdef CONFIG_PER_VMA_LOCK
-	/* Flag to indicate areas detached from the mm->mm_mt tree */
+	/*
+	 * Flag to indicate areas detached from the mm->mm_mt tree.
+	 * Unstable RCU readers are allowed to read this.
+	 */
 	bool detached;
 
 	/*
 	 * Can only be written (using WRITE_ONCE()) while holding both:
 	 *  - mmap_lock (in write mode)
 	 *  - vm_lock->lock (in write mode)
 	 * Can be read reliably while holding one of:
 	 *  - mmap_lock (in read or write mode)
 	 *  - vm_lock->lock (in read or write mode)
 	 * Can be read unreliably (using READ_ONCE()) for pessimistic bailout
 	 * while holding nothing (except RCU to keep the VMA struct allocated).
 	 *
 	 * This sequence counter is explicitly allowed to overflow; sequence
 	 * counter reuse can only lead to occasional unnecessary use of the
 	 * slowpath.
 	 */
 	int vm_lock_seq;
+	/* Unstable RCU readers are allowed to read this. */
 	struct vma_lock *vm_lock;
 #endif
 
 	/*
 	 * For areas with an address space and backing store,
 	 * linkage into the address_space->i_mmap interval tree.
diff --git a/mm/memory.c b/mm/memory.c
index 34f8402d2046..3f4232b985a1 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5996,23 +5996,29 @@ struct vm_area_struct *lock_vma_under_rcu(struct mm_struct *mm,
 	if (!vma)
 		goto inval;
 
 	if (!vma_start_read(vma))
 		goto inval;
 
-	/* Check since vm_start/vm_end might change before we lock the VMA */
-	if (unlikely(address < vma->vm_start || address >= vma->vm_end))
-		goto inval_end_read;
-
 	/* Check if the VMA got isolated after we found it */
 	if (vma->detached) {
 		vma_end_read(vma);
 		count_vm_vma_lock_event(VMA_LOCK_MISS);
 		/* The area was replaced with another one */
 		goto retry;
 	}
+	/*
+	 * At this point, we have a stable reference to a VMA: The VMA is
+	 * locked and we know it hasn't already been isolated.
+	 * From here on, we can access the VMA without worrying about which
+	 * fields are accessible for RCU readers.
+	 */
+
+	/* Check since vm_start/vm_end might change before we lock the VMA */
+	if (unlikely(address < vma->vm_start || address >= vma->vm_end))
+		goto inval_end_read;
 
 	rcu_read_unlock();
 	return vma;
 
 inval_end_read:
 	vma_end_read(vma);

---
base-commit: de9c2c66ad8e787abec7c9d7eff4f8c3cdd28aed
change-id: 20240805-fix-vma-lock-type-confusion-0a956d9d31ae
-- 
Jann Horn <jannh@google.com>


