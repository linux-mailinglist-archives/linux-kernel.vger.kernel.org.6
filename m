Return-Path: <linux-kernel+bounces-435762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EEEA39E7BFA
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 23:52:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC56C16D6B1
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 22:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EB4E212F93;
	Fri,  6 Dec 2024 22:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cvxbFSAz"
Received: from mail-oa1-f73.google.com (mail-oa1-f73.google.com [209.85.160.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22BD5212F97
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 22:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733525532; cv=none; b=DS9P4xnIb+TRLwnay5oNn+q3JWZOoI38gmdh1hT+3RGOnfIa+IK6/OT+iQ4BqlDJF6FlPUpgzyUpzAo1HF3dGLRcZG0VDQ/wZSpD3O2c/tqmPcMIASmwY6HbYWOcmIhJF7vnuxExXLkX+hEKa1kYEzN9t1YV7/0CVgzxkIbxcdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733525532; c=relaxed/simple;
	bh=2j1BzXPRuP+UhOQHpNJNISGx3R6QvDIWF84DWtljS3M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JXhSqG+gKbhucOWdeAHTVle191OzWCZfLA1w5L9FM85fzwaSTUadQdp4K4wZ/qReQwOrsZ45gCsJomJlpdl5hJrV+5AsWwVBurZY/3TK+I6NXntUzOZ611hpso/b2HWdCZdW22j9swTDdh2J8GVtd6Bs0ANDQWYh9dfkeI4q6M4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cvxbFSAz; arc=none smtp.client-ip=209.85.160.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-oa1-f73.google.com with SMTP id 586e51a60fabf-29e4d2c28ffso2316052fac.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2024 14:52:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733525529; x=1734130329; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2XVlPHpEZtu9xIw4Qap8alaO3+SGpEYwVQX0iy/v7kQ=;
        b=cvxbFSAzZLVRrz8SUlDqgxhO83eb/7TedstGzq+UVNvkXX5ZepC6ZLryjDTCEzs4e8
         xp/INd9YzpTgg2DQ31jIx9RNC2xe6cHmntP046FqHuXZ3WHQhC6wxRZviw6cAzNAG/4N
         KFjGVJZCf5w6BxI8qsexkwuDcl1sqoq7lYxJtDrWabgkCGnc5J+bB0f6oI3Adibg0LTT
         YU3iaqA/favaw5L3HkT3h0tdsvnLBJV2yhyAVC39oTxQPDhbu5/PIv8asP00cAPLh4R8
         ra7uLfARMuaB75oJ2sR/+cb68b76/IPRKCA5SUQD+asic7ucQwE3Bq3b+Fa/h9jTok4G
         6LWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733525529; x=1734130329;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2XVlPHpEZtu9xIw4Qap8alaO3+SGpEYwVQX0iy/v7kQ=;
        b=jNxIN77tGvWZ06EP2oK7GtjEtlmjQlUq1RAufVOb22NevRTNAqB83eHz+E42upVrZ0
         Mg4eWIFFuaNnR8Z6DqKpwyoX0zSkNBQjHRNqVeOUEBrg28wbtmAVpI/dajp+TEghbcxV
         4dWPwG3quAS5FH1MoXAVO0MR9oect/v7nCEwtP11OTVSF0xvEIRmo0GwEoNgivJ6h9zQ
         HaEwfP045Y1DwgFIy8leUpq6jZ5RBeoZdn6bi3cd1DqoGl/BL13Fa5DpJk1qfpdbHnnU
         6c5CpyBdxj2WCn5fAHtDWDhTJMdVp4v/OdWPn4hrYA2uUtMmPZMUMssLcXAoJ42TkC74
         ncvA==
X-Forwarded-Encrypted: i=1; AJvYcCVd7XOZA1WI6wP4wJ+WsXWCdObnZ5altnDy2c1X5gPaklFngXAezyOv4e2eiejlF+bnqAOJ/ByDIjMWLzc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTPNocbf3qoMAP1VPFIPCHep8GUET63NufF/6ybR8XCvAJXH53
	oHfDAHDlMmKpSgiTTJ0H3bngd5A29Lcfj0pKiIi7NZ3LPPDpOQ2SUKrkF6S6wHuu5k03fejIgI4
	wGA==
X-Google-Smtp-Source: AGHT+IE3XhAvDScGGmsUTdbbULESWT7yEme/wNWVflifCM9618rjWWcRcIta7LlU8v32EA39xFZwUHCJlPc=
X-Received: from oacpd2.prod.google.com ([2002:a05:6871:7a82:b0:297:2483:5994])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6808:e8c:b0:3ea:5161:f71
 with SMTP id 5614622812f47-3eb19ce52a7mr4865569b6e.20.1733525529219; Fri, 06
 Dec 2024 14:52:09 -0800 (PST)
Date: Fri,  6 Dec 2024 14:51:58 -0800
In-Reply-To: <20241206225204.4008261-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241206225204.4008261-1-surenb@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241206225204.4008261-2-surenb@google.com>
Subject: [PATCH v5 1/6] mm: introduce vma_start_read_locked{_nested} helpers
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

Introduce helper functions which can be used to read-lock a VMA when
holding mmap_lock for read. Replace direct accesses to vma->vm_lock
with these new helpers.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>
---
 include/linux/mm.h | 24 ++++++++++++++++++++++++
 mm/userfaultfd.c   | 22 +++++-----------------
 2 files changed, 29 insertions(+), 17 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 187e42339d8e..c4a001972223 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -734,6 +734,30 @@ static inline bool vma_start_read(struct vm_area_struct *vma)
 	return true;
 }
 
+/*
+ * Use only while holding mmap read lock which guarantees that locking will not
+ * fail (nobody can concurrently write-lock the vma). vma_start_read() should
+ * not be used in such cases because it might fail due to mm_lock_seq overflow.
+ * This functionality is used to obtain vma read lock and drop the mmap read lock.
+ */
+static inline void vma_start_read_locked_nested(struct vm_area_struct *vma, int subclass)
+{
+	mmap_assert_locked(vma->vm_mm);
+	down_read_nested(&vma->vm_lock->lock, subclass);
+}
+
+/*
+ * Use only while holding mmap read lock which guarantees that locking will not
+ * fail (nobody can concurrently write-lock the vma). vma_start_read() should
+ * not be used in such cases because it might fail due to mm_lock_seq overflow.
+ * This functionality is used to obtain vma read lock and drop the mmap read lock.
+ */
+static inline void vma_start_read_locked(struct vm_area_struct *vma)
+{
+	mmap_assert_locked(vma->vm_mm);
+	down_read(&vma->vm_lock->lock);
+}
+
 static inline void vma_end_read(struct vm_area_struct *vma)
 {
 	rcu_read_lock(); /* keeps vma alive till the end of up_read */
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 8e16dc290ddf..bc9a66ec6a6e 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -84,16 +84,8 @@ static struct vm_area_struct *uffd_lock_vma(struct mm_struct *mm,
 
 	mmap_read_lock(mm);
 	vma = find_vma_and_prepare_anon(mm, address);
-	if (!IS_ERR(vma)) {
-		/*
-		 * We cannot use vma_start_read() as it may fail due to
-		 * false locked (see comment in vma_start_read()). We
-		 * can avoid that by directly locking vm_lock under
-		 * mmap_lock, which guarantees that nobody can lock the
-		 * vma for write (vma_start_write()) under us.
-		 */
-		down_read(&vma->vm_lock->lock);
-	}
+	if (!IS_ERR(vma))
+		vma_start_read_locked(vma);
 
 	mmap_read_unlock(mm);
 	return vma;
@@ -1491,14 +1483,10 @@ static int uffd_move_lock(struct mm_struct *mm,
 	mmap_read_lock(mm);
 	err = find_vmas_mm_locked(mm, dst_start, src_start, dst_vmap, src_vmap);
 	if (!err) {
-		/*
-		 * See comment in uffd_lock_vma() as to why not using
-		 * vma_start_read() here.
-		 */
-		down_read(&(*dst_vmap)->vm_lock->lock);
+		vma_start_read_locked(*dst_vmap);
 		if (*dst_vmap != *src_vmap)
-			down_read_nested(&(*src_vmap)->vm_lock->lock,
-					 SINGLE_DEPTH_NESTING);
+			vma_start_read_locked_nested(*src_vmap,
+						SINGLE_DEPTH_NESTING);
 	}
 	mmap_read_unlock(mm);
 	return err;
-- 
2.47.0.338.g60cca15819-goog


