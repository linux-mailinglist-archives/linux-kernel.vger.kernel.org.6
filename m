Return-Path: <linux-kernel+bounces-514022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62CF1A35172
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 23:47:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E314E3AAAE7
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 22:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55D36270EA7;
	Thu, 13 Feb 2025 22:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qKcVF4q/"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C6BF245AFC
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 22:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739486823; cv=none; b=etqdHzpjBsmAif2JBOjEjjk46z1j9sQPDWiU7koEQwZYY+f3saUO/DlZ2btzjPy5+WYDnEHpSg+Kb4NZioKGN3wk7ZM1OkvSwt/mTutE6ylLqfBdvebq5fNMmrcns1tu180qt2iACy6YQGhcvDHRyvMicaBuYZJg5Wr7WSMz8Kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739486823; c=relaxed/simple;
	bh=DnHwwceX94T6CFAGCwdOIkJAjmpCwFYCPBayU0ptLsM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=edKKtQw5xz5+uI5mRjjl8W4lb8j2F+1NC6IedeerVPzHwjU84yZ3m8SZ8G+nzc3wov8lCCwHeOZXVhIMJbJkxPd0gOJ1x3FBvCb19DfKuZvDb+D7WoIKtAPYXWwTFk2Pl9AoRiQlHJYleUxEyuFnIH7OpqfU0MNLP+/9HPQ+RHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qKcVF4q/; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-21f6cd48c56so21398645ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 14:47:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739486821; x=1740091621; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZTYk4jMv74ux8pRXqzfOQIPTG5wd2Gv112zjF6xUHQA=;
        b=qKcVF4q/5JcwevH7gLqvXH9DAd4s9lKN7kuCXV2eXtxgpCYHOHxgVdMxz5l6RzPeft
         Dv+lENIk1QpAptdKelxPzloLOtBHMa4XrwBuVF2BnnMtTtBXtyrfTdYShinnYx8DVI4Q
         mt5bIrGtdj+98tw4y/OUmrLKY3PbE5XEyopFOUJFY2wsvG5bal43dvH8xMLVEmXfkx+U
         emKgaTd5i3FRKhZntFIxXPOIgM9OuKOsqQMdSpKIf0r3zasFFcXA5ojgtNb821GrAyJq
         iIkfM0fKwOck5RZeF1U+CfcuC+PuGcGygRf1EVEsVsD5o9ymGAQGZcWSH4hOAroUM6he
         72vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739486821; x=1740091621;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZTYk4jMv74ux8pRXqzfOQIPTG5wd2Gv112zjF6xUHQA=;
        b=C6y4PCLd0A3n0zpD1J2S4wqeVDWZL55QajQsk/wtfOy1Xp11O6XFafrAeYJ1wMfP7P
         0PrrbqJ0t0QRHk86AY24IT/BEkZvV29yZPeyWZvoGpMSudnNz0wV8sznHiBuDSCtDy0S
         Cg18MLkr6Abzbk+fGz0VN/M1R6LEzv67ritnD21vNinLjg1nDtcI+F3ik+l8nB5ViUgM
         37xOjXAnBTPJHYmIw6fV8DuE6ZOz4KYIdhiOjNZaHSdkIBqT6DHAkbyNIcvh9iGzv4oq
         lvQbtzQLOZLUC1sj2SkJM8qJ4avg1ttRE5VkUuF3/oqoUEAJG6IbrXGFJuryQsjZph6P
         R21w==
X-Forwarded-Encrypted: i=1; AJvYcCV8RFZ8VpZSo2OB3U2odg3PY3BVi02ZfkyuAEPwXYjr/4JDaf2/dsOLvo3iKx7PGuKquQ521cBJofXz3jE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkPuDlmF7CUvnv2DfJuLf5YlG+OT+FzSgBZHvf/Lgboh2TJ1xZ
	w7nUJtAbGw7EvJUjOdZ3qikfA/35AhJIKi+VlfVW2LQX3hI4cO6j9fL32y99ntfmiFC40cCjAMS
	lag==
X-Google-Smtp-Source: AGHT+IGoxbQEHrRgpcds0LXGn7Wsw+mSSdilT5DRw00yKSF5iCDYNJNuQzJz7chpHTNiW9yQ8A9B90jlKU8=
X-Received: from pgcu129.prod.google.com ([2002:a63:7987:0:b0:ad5:53f5:6975])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:112:b0:1ee:7b6c:e2f4
 with SMTP id adf61e73a8af0-1ee7b6ce592mr3099897637.26.1739486821322; Thu, 13
 Feb 2025 14:47:01 -0800 (PST)
Date: Thu, 13 Feb 2025 14:46:38 -0800
In-Reply-To: <20250213224655.1680278-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250213224655.1680278-1-surenb@google.com>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <20250213224655.1680278-2-surenb@google.com>
Subject: [PATCH v10 01/18] mm: introduce vma_start_read_locked{_nested} helpers
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

Introduce helper functions which can be used to read-lock a VMA when
holding mmap_lock for read.  Replace direct accesses to vma->vm_lock with
these new helpers.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Reviewed-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 include/linux/mm.h | 24 ++++++++++++++++++++++++
 mm/userfaultfd.c   | 22 +++++-----------------
 2 files changed, 29 insertions(+), 17 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 838097542939..16b3cd3de29a 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -735,6 +735,30 @@ static inline bool vma_start_read(struct vm_area_struct *vma)
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
index af3dfc3633db..4527c385935b 100644
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
2.48.1.601.g30ceb7b040-goog


