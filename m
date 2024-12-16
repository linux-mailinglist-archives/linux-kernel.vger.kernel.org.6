Return-Path: <linux-kernel+bounces-448010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A0BC9F39D1
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 20:28:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10024167134
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 19:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCE6020D50C;
	Mon, 16 Dec 2024 19:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wD0+YLwe"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B20AD20D4F4
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 19:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734377094; cv=none; b=OAMnqK2+X8zjY/ubxFJXMdteAh4cw8tgecTQ3HaGvFFd2iXOfccABL540vFGi3E47ZbWwDooOsmvlsTtWmCxPCjCXK0ZYbyOlVf8lVtOHW4r27kaozESuJeaVc9QG3WGcA0B3vOkfGTz0a31j0IHYw4bT29YIW5QJ1NgBRiUhys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734377094; c=relaxed/simple;
	bh=5aDrPziR1EBUYF3aYwfa2DjR/XNJQIfQktb62k8eAEg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DXyO6CDJrl9LxNsoYCssrhapskweLxyTcJpqFdoNZBm7na0tZEig6gtGB6mMlzM77WQd2F6PAWuuB7YKYD1/1BSOi+gOv7iPgZxiM2jjkhAuOzv2gz6e5LmOg+771dKeZbxQN0ZxQPvk82dB26KdKlgaG1my9eNnRqt3n211avc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wD0+YLwe; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-7f8af3950ecso3104576a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 11:24:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734377092; x=1734981892; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=t5fnSRoB5oFCIXa/V8gP+VbtOpDmgl8LzmUTLWBvDvo=;
        b=wD0+YLwe3dA+iyPuTaoxkA0OACDyK+rEXriDHf8LH4SREMNESHoRxsHvpY4ju2WIjU
         qiSxEwtiVqquyT1BgyXJNafzkK/OcHJ53auCtuimnI6YiFuREJEtLSHcFt8uDg3yApg4
         2bt63ybUZUlLqKGK2hP55xbO2QzhP3tZ9zO7wEW+Dt9sCnSONXXDrCOstReS0ITOwjqr
         e+prRXmmeDGHMFDR6SvqPkVtIl0zN4JzHAbXPy3CSO8UJXthk7lZr4QA6c1XLCEpXXCk
         UyjHIK+FAZPmu05Rgju1f8OBFnkf/ytOvuZoqcziAH9X2NhWEopQgA4TLnqwr639wC0K
         qrDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734377092; x=1734981892;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t5fnSRoB5oFCIXa/V8gP+VbtOpDmgl8LzmUTLWBvDvo=;
        b=UL0Z3iwfj+ZHjFj/Ipdtox+CeMTIhef4Vi2MNEWFxnphfbZC+hHOIMnc+pUswGN0Rn
         EKNzut0D00Y/Atko+Q+oDehWgSycI0VXRjVkTSos7yYj+1VOFFl9Ms6nB3VxxRsmM/jH
         dK+iQwAxCR7+wfDVLVrqlEuXgDRdh5ZlMgcGZK1Te28VKp3chn2ayrao+3Oo98n7aU5+
         oshupgiFlSIDh6/y3woOCNeiU3DE8Ti/caYJqarKS1qEF2y5CZ7OK6xnYyP7HROPPGpO
         RujKRkMNvl+lPGqi8kUWIxmzv23qE6jKmMHpB+Ni3hczmVGSvet9BFFK17tT3v8mL5A0
         2AAg==
X-Forwarded-Encrypted: i=1; AJvYcCVj64oPz32SJCYdk71JlVJZp2NbWpPASAXxs3/6+ddXq5wbW+vI8G3k9c4QFRyQBiF8xt2IGNy/zbwFdGI=@vger.kernel.org
X-Gm-Message-State: AOJu0YycEm2fMyzRCb1ZBBXlxWFi7Hm+kcIvKtFNk6oKK6Xx/MxLPh2m
	2Vvj/wav8FzM8/vXeBPnjyTPgJMq168BHHVK3Oc1yDc3m4DtgLgm1+zV69f0R5QS7homteTebsh
	IPg==
X-Google-Smtp-Source: AGHT+IGeGCIjsB3KXvsuHWb/nocj10tzreW4ZVMNCmw0sPpWQ78cfKvuNdThF2i3rD3x89K8u/6hh2RJEJY=
X-Received: from pggk15.prod.google.com ([2002:a63:d10f:0:b0:801:d768:c174])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:8885:b0:1e2:5cf:c8d6
 with SMTP id adf61e73a8af0-1e205cfcb77mr10415260637.36.1734377091912; Mon, 16
 Dec 2024 11:24:51 -0800 (PST)
Date: Mon, 16 Dec 2024 11:24:17 -0800
In-Reply-To: <20241216192419.2970941-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241216192419.2970941-1-surenb@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241216192419.2970941-15-surenb@google.com>
Subject: [PATCH v6 14/16] mm: prepare lock_vma_under_rcu() for vma reuse possibility
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: peterz@infradead.org, willy@infradead.org, liam.howlett@oracle.com, 
	lorenzo.stoakes@oracle.com, mhocko@suse.com, vbabka@suse.cz, 
	hannes@cmpxchg.org, mjguzik@gmail.com, oliver.sang@intel.com, 
	mgorman@techsingularity.net, david@redhat.com, peterx@redhat.com, 
	oleg@redhat.com, dave@stgolabs.net, paulmck@kernel.org, brauner@kernel.org, 
	dhowells@redhat.com, hdanton@sina.com, hughd@google.com, 
	lokeshgidra@google.com, minchan@google.com, jannh@google.com, 
	shakeel.butt@linux.dev, souravpanda@google.com, pasha.tatashin@soleen.com, 
	klarasmodin@gmail.com, corbet@lwn.net, linux-doc@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel-team@android.com, 
	surenb@google.com
Content-Type: text/plain; charset="UTF-8"

Once we make vma cache SLAB_TYPESAFE_BY_RCU, it will be possible for a vma
to be reused and attached to another mm after lock_vma_under_rcu() locks
the vma. lock_vma_under_rcu() should ensure that vma_start_read() is using
the original mm and after locking the vma it should ensure that vma->vm_mm
has not changed from under us.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 include/linux/mm.h | 10 ++++++----
 mm/memory.c        |  7 ++++---
 2 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 361f26dedab1..bfd01ae07660 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -725,8 +725,10 @@ static inline void vma_refcount_put(struct vm_area_struct *vma)
  * Try to read-lock a vma. The function is allowed to occasionally yield false
  * locked result to avoid performance overhead, in which case we fall back to
  * using mmap_lock. The function should never yield false unlocked result.
+ * False locked result is possible if mm_lock_seq overflows or if vma gets
+ * reused and attached to a different mm before we lock it.
  */
-static inline bool vma_start_read(struct vm_area_struct *vma)
+static inline bool vma_start_read(struct mm_struct *mm, struct vm_area_struct *vma)
 {
 	int oldcnt;
 
@@ -737,7 +739,7 @@ static inline bool vma_start_read(struct vm_area_struct *vma)
 	 * we don't rely on for anything - the mm_lock_seq read against which we
 	 * need ordering is below.
 	 */
-	if (READ_ONCE(vma->vm_lock_seq) == READ_ONCE(vma->vm_mm->mm_lock_seq.sequence))
+	if (READ_ONCE(vma->vm_lock_seq) == READ_ONCE(mm->mm_lock_seq.sequence))
 		return false;
 
 
@@ -762,7 +764,7 @@ static inline bool vma_start_read(struct vm_area_struct *vma)
 	 * This pairs with RELEASE semantics in vma_end_write_all().
 	 */
 	if (oldcnt & VMA_STATE_LOCKED ||
-	    unlikely(vma->vm_lock_seq == raw_read_seqcount(&vma->vm_mm->mm_lock_seq))) {
+	    unlikely(vma->vm_lock_seq == raw_read_seqcount(&mm->mm_lock_seq))) {
 		vma_refcount_put(vma);
 		return false;
 	}
@@ -918,7 +920,7 @@ struct vm_area_struct *lock_vma_under_rcu(struct mm_struct *mm,
 #else /* CONFIG_PER_VMA_LOCK */
 
 static inline void vma_lock_init(struct vm_area_struct *vma) {}
-static inline bool vma_start_read(struct vm_area_struct *vma)
+static inline bool vma_start_read(struct mm_struct *mm, struct vm_area_struct *vma)
 		{ return false; }
 static inline void vma_end_read(struct vm_area_struct *vma) {}
 static inline void vma_start_write(struct vm_area_struct *vma) {}
diff --git a/mm/memory.c b/mm/memory.c
index 534e279f98c1..2131d9769bb4 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -6405,7 +6405,7 @@ struct vm_area_struct *lock_vma_under_rcu(struct mm_struct *mm,
 	if (!vma)
 		goto inval;
 
-	if (!vma_start_read(vma))
+	if (!vma_start_read(mm, vma))
 		goto inval;
 
 	/*
@@ -6415,8 +6415,9 @@ struct vm_area_struct *lock_vma_under_rcu(struct mm_struct *mm,
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
2.47.1.613.gc27f4b7a9f-goog


