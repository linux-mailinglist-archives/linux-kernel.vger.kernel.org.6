Return-Path: <linux-kernel+bounces-514039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13825A35196
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 23:50:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA6FD16A0BF
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 22:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1788B2753F6;
	Thu, 13 Feb 2025 22:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3SEA9xGr"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A370270EB3
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 22:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739486858; cv=none; b=jJaGcUavdoJvxShkrDiWY1y+fL2Opi/nOnjVX5SDvtGQyrpKu8Sxk01nUDBEgMqboszs2yozjRRFvOO869kHmJH+kNB3FbpbARS2JeZgCJxyMF9y7Y9RUSQVW5FyjpOZdQiP0+2WTUKiBGOc9w9tSVnkIZt/EPpFQhE9EGHwaFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739486858; c=relaxed/simple;
	bh=ZS+q2FOJ4YzNtq2i12+Nw5i6j6+GhULqmdiyVBu4ei8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mp+fwSOteYt5pkkjdUgHlepxJOSASIKGbjlMVt2WwKslj24OWapInYiUF8K3K1a6DprGEKix0B65106CC1kmT4i/n9JWOlAfWmmhktMQ1l3MVd+remGckGl+2o1coWQPRdc/sKR5Z9zn+nxIE+QYbbZAMW19JDk65GwV/ZzJip4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3SEA9xGr; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-220d8aa893dso18006555ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 14:47:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739486856; x=1740091656; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=HXs3qm65Mw4fWBObt4HCubdoJZ7UfWSFf9bCMyPuZ5Q=;
        b=3SEA9xGr6Q/n7UkACnVx2iR20sFY+wieZepwr7u/JP5jeuTk4d8TJ09tVGGe6ewyGV
         FORnsQxWRRSkWgaBL+4egQugrCFZsoCp2OeHOcJ/CDkyNkFlw/q5iMus28/NMlkxc8Xy
         jEx1P7XLJpW8o8vGDCAaWVq6UnKDaR7I9WgUtnP0PSM+MrrtPHwTWKfCu68xdyG5kX7I
         VhtrOcU+LvgQcnbvp150kxaymTKkyXUxdMayvs4rRAmZgNkECvSMtgdrc5+Ufmn45kMO
         MjB2qGf4RITKgSXeNZzRVx2sEVIFgGN3f7CVv6qB+Qh51Zi7j923lmxM185YsQS2Y2+z
         wpPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739486856; x=1740091656;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HXs3qm65Mw4fWBObt4HCubdoJZ7UfWSFf9bCMyPuZ5Q=;
        b=Mun1G1RyIi0Uc7C8dQ0rhURS/BPoSQVe+OuWKI6stJgp3odFL3rmALo+QcSWYmp0S4
         qFTp1G9BwfEP4ioOBHn+fW7Rh2/imZBDw4Y9XDDNBEpMyfqgWazxo3oHwU3OGj2752wF
         njWdHu7+on+3pLAk1K1mxQz2lLRP6rzNV0S5x2pzj8yVwoxfvHWcBCoFPGExgb6W2Tvj
         MAn51YrRIBaNkEsdZVfG8TotAVFs0eJDVz2mCquNV4f1rxcBtXoq7OWHd4jiNZuwOUrz
         KjIAeT4NRe3StnHu3MILcw8RE4ujnJcc7GZAQwuF9gll/iswH7BNGC9wBpBmDp4Dor25
         0SPw==
X-Forwarded-Encrypted: i=1; AJvYcCWKv1ZjbS9Z3OcoFwi3r0TXBeDElC2asTZTEr7Wkw6241PYmaoHs6Ekc17NlHtWEkP+3CMQ73BuqHoiCSE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuYwzuspUZcn3ZqoQ0ImZ1AGHBdKfb7v9mhjdLObhb6HLuTolc
	fUVs/n3qp3fK23GNQ3YiNyZvzLTy/xzQ8XfxHrUfX/6z2139YVt2HPcYtuVAWM8M+TH4O8Ja5sH
	hCA==
X-Google-Smtp-Source: AGHT+IFEeHfewJkwAt0Xqt/tC1plnftNTUCWIl49bO9ckcrGnetyW/ghDc1KfOz7C3qqfgR140G3l01rzEw=
X-Received: from plblc14.prod.google.com ([2002:a17:902:fa8e:b0:212:48d4:bf16])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:dac4:b0:21f:9107:fca3
 with SMTP id d9443c01a7336-220d20e90a3mr71286775ad.30.1739486856011; Thu, 13
 Feb 2025 14:47:36 -0800 (PST)
Date: Thu, 13 Feb 2025 14:46:55 -0800
In-Reply-To: <20250213224655.1680278-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250213224655.1680278-1-surenb@google.com>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <20250213224655.1680278-19-surenb@google.com>
Subject: [PATCH v10 18/18] docs/mm: document latest changes to vm_lock
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

Change the documentation to reflect that vm_lock is integrated into vma
and replaced with vm_refcnt.
Document newly introduced vma_start_read_locked{_nested} functions.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Reviewed-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
Changes since v9 [1]:
- Updated documenation, per Lorenzo Stoakes
- Add Reviewed-by, per Lorenzo Stoakes

[1] https://lore.kernel.org/all/20250111042604.3230628-18-surenb@google.com/

 Documentation/mm/process_addrs.rst | 44 ++++++++++++++++++------------
 1 file changed, 26 insertions(+), 18 deletions(-)

diff --git a/Documentation/mm/process_addrs.rst b/Documentation/mm/process_addrs.rst
index 81417fa2ed20..e6756e78b476 100644
--- a/Documentation/mm/process_addrs.rst
+++ b/Documentation/mm/process_addrs.rst
@@ -716,9 +716,14 @@ calls :c:func:`!rcu_read_lock` to ensure that the VMA is looked up in an RCU
 critical section, then attempts to VMA lock it via :c:func:`!vma_start_read`,
 before releasing the RCU lock via :c:func:`!rcu_read_unlock`.
 
-VMA read locks hold the read lock on the :c:member:`!vma->vm_lock` semaphore for
-their duration and the caller of :c:func:`!lock_vma_under_rcu` must release it
-via :c:func:`!vma_end_read`.
+In cases when the user already holds mmap read lock, :c:func:`!vma_start_read_locked`
+and :c:func:`!vma_start_read_locked_nested` can be used. These functions do not
+fail due to lock contention but the caller should still check their return values
+in case they fail for other reasons.
+
+VMA read locks increment :c:member:`!vma.vm_refcnt` reference counter for their
+duration and the caller of :c:func:`!lock_vma_under_rcu` must drop it via
+:c:func:`!vma_end_read`.
 
 VMA **write** locks are acquired via :c:func:`!vma_start_write` in instances where a
 VMA is about to be modified, unlike :c:func:`!vma_start_read` the lock is always
@@ -726,9 +731,9 @@ acquired. An mmap write lock **must** be held for the duration of the VMA write
 lock, releasing or downgrading the mmap write lock also releases the VMA write
 lock so there is no :c:func:`!vma_end_write` function.
 
-Note that a semaphore write lock is not held across a VMA lock. Rather, a
-sequence number is used for serialisation, and the write semaphore is only
-acquired at the point of write lock to update this.
+Note that when write-locking a VMA lock, the :c:member:`!vma.vm_refcnt` is temporarily
+modified so that readers can detect the presense of a writer. The reference counter is
+restored once the vma sequence number used for serialisation is updated.
 
 This ensures the semantics we require - VMA write locks provide exclusive write
 access to the VMA.
@@ -738,7 +743,7 @@ Implementation details
 
 The VMA lock mechanism is designed to be a lightweight means of avoiding the use
 of the heavily contended mmap lock. It is implemented using a combination of a
-read/write semaphore and sequence numbers belonging to the containing
+reference counter and sequence numbers belonging to the containing
 :c:struct:`!struct mm_struct` and the VMA.
 
 Read locks are acquired via :c:func:`!vma_start_read`, which is an optimistic
@@ -779,28 +784,31 @@ release of any VMA locks on its release makes sense, as you would never want to
 keep VMAs locked across entirely separate write operations. It also maintains
 correct lock ordering.
 
-Each time a VMA read lock is acquired, we acquire a read lock on the
-:c:member:`!vma->vm_lock` read/write semaphore and hold it, while checking that
-the sequence count of the VMA does not match that of the mm.
+Each time a VMA read lock is acquired, we increment :c:member:`!vma.vm_refcnt`
+reference counter and check that the sequence count of the VMA does not match
+that of the mm.
 
-If it does, the read lock fails. If it does not, we hold the lock, excluding
-writers, but permitting other readers, who will also obtain this lock under RCU.
+If it does, the read lock fails and :c:member:`!vma.vm_refcnt` is dropped.
+If it does not, we keep the reference counter raised, excluding writers, but
+permitting other readers, who can also obtain this lock under RCU.
 
 Importantly, maple tree operations performed in :c:func:`!lock_vma_under_rcu`
 are also RCU safe, so the whole read lock operation is guaranteed to function
 correctly.
 
-On the write side, we acquire a write lock on the :c:member:`!vma->vm_lock`
-read/write semaphore, before setting the VMA's sequence number under this lock,
-also simultaneously holding the mmap write lock.
+On the write side, we set a bit in :c:member:`!vma.vm_refcnt` which can't be
+modified by readers and wait for all readers to drop their reference count.
+Once there are no readers, the VMA's sequence number is set to match that of
+the mm. During this entire operation mmap write lock is held.
 
 This way, if any read locks are in effect, :c:func:`!vma_start_write` will sleep
 until these are finished and mutual exclusion is achieved.
 
-After setting the VMA's sequence number, the lock is released, avoiding
-complexity with a long-term held write lock.
+After setting the VMA's sequence number, the bit in :c:member:`!vma.vm_refcnt`
+indicating a writer is cleared. From this point on, VMA's sequence number will
+indicate VMA's write-locked state until mmap write lock is dropped or downgraded.
 
-This clever combination of a read/write semaphore and sequence count allows for
+This clever combination of a reference counter and sequence count allows for
 fast RCU-based per-VMA lock acquisition (especially on page fault, though
 utilised elsewhere) with minimal complexity around lock ordering.
 
-- 
2.48.1.601.g30ceb7b040-goog


