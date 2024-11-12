Return-Path: <linux-kernel+bounces-406642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D8279C61BB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 20:47:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5C20284EEC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 19:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E232219CAD;
	Tue, 12 Nov 2024 19:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="z/bxvFf6"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23CF9219CA4
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 19:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731440805; cv=none; b=Y9hgWg7qTaJ4jUFikEZKAnx3ajdwCoiNOim+pmB4UR524oxA6cSQadRo6MlUOsktohgmOfL84GeM7sV9PyI2k2kkaUQ7tXEXZj8K3Fldpx55QKjRX5TwFTD20s6cLDmxj8VmmS7VjcgXaZ3Z1lxoRGb8AEBVKNAPuwvXdZWh8Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731440805; c=relaxed/simple;
	bh=C8mwSaQ8Its/aWvWsxyeJgOzWgBQWhPS8Ji8jwToFzg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XgJOrZe1v6i36QFvshtaxHoJPxXGU0saBQFMYpAvoUvtby/UWUXCgq0OTwTf8alpWI44aXtUAy3XtbVcvqXqtZEfHQdMSCrB6jkFI06gCFcCFsP/xHNuqMvp0pIrQOboBKDzXOGWECvs8NSLrzj0JCceJiCvHmqTPTVd4uIX9bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=z/bxvFf6; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6ea7c5805ccso92190907b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 11:46:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731440803; x=1732045603; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=c6L2TsxMW3xdptYp+SxjhxiQb9Rn3imOm+Hs2oG6vZc=;
        b=z/bxvFf6E/r+jc8KmZsi5qg1qhh5CalcYSv59QH6RzIUNKG6b+dwQDwyncE6QP1Rdq
         1LgRTR2OrtTrTtPYzsuUrPfIGDGmt3FXMKckKLsa/e9lYDGMUtZ2BUipCWbK7Ogn10A6
         aWrqu7A7lPjbr1Z8mQn2kUHIqnWqOpt6TCvWrzdNmAq8ddoZxtl/JGHin0t1T1h8zkUK
         sX+H6ljKBy/wiOmjoGfWCbzWcjpZwHR10CrEJSoMVjRDrbfQR5NZcY2K3WjbOqilGhiP
         THrhfNlj9TIBeMWZjWJi9T9ldxlG0V0eH66MZ/awT9vJqhR5KBvZcvCUuN1nltpjbUdg
         xnBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731440803; x=1732045603;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c6L2TsxMW3xdptYp+SxjhxiQb9Rn3imOm+Hs2oG6vZc=;
        b=sWiJXg98/wnfaqN4PEQq9s02jUTf1ZYD/M4llDJH6NR53YZx3q9g3jfpEcrgcLOvzP
         oeYgvqTDQswAPQ+GKm+TE2jYN14XGiDynLfTl8omXDksCIQtK677TJEz0l4gXGs87e4L
         edRHpCrqWiSHOo7oGUO8JYlg4Th662dzpzgs1RJg7PN/1TkesYbeNnAU6iHzo+FgxQb+
         R00CdGm+fAjBNzhC6EP6eMNSbz3rM9BAPHvHhCD2+nlMJz8znTOXT26zZA4UF4AHBnrg
         fniaPMNGdG7243LJKrFXWVACfoAcoFqPBrpCIsDvyQqxkrqTDiuITI98TrMGJ7fCJGwx
         eNdA==
X-Forwarded-Encrypted: i=1; AJvYcCU6R9nOXvF7Vy1gosLTb1ulUjmlZjAG41lBsVUgje3STXI1uMWbMGwK3g6yA3rjajxE7n5195VXUnZWPCY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQ5K+kbt6ycy5JGIM2JPSLjxkG3K5Jt4hU1rHj4M2/v63czWrq
	PjB5ETkEc3abnhOqs9XmMG+aBm8pC8pgiD9Qi1qAUbhGYTtrUpT6WpMXLU3aFCmLNu17zTFCM9k
	diw==
X-Google-Smtp-Source: AGHT+IH3ogaKA/6SIpqGiWEzmqcQ3qZ/Nx5QjPItSCKNvMM699jDmgRp92hUZbCEx3dlegBqK4JNX36Bnsw=
X-Received: from surenb-desktop.mtv.corp.google.com ([2a00:79e0:2e3f:8:cad5:5dc6:1298:ec42])
 (user=surenb job=sendgmr) by 2002:a05:690c:6e88:b0:6e2:371f:4aef with SMTP id
 00721157ae682-6ecb344400cmr3697b3.3.1731440803073; Tue, 12 Nov 2024 11:46:43
 -0800 (PST)
Date: Tue, 12 Nov 2024 11:46:31 -0800
In-Reply-To: <20241112194635.444146-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241112194635.444146-1-surenb@google.com>
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Message-ID: <20241112194635.444146-2-surenb@google.com>
Subject: [PATCH v2 1/5] mm: introduce vma_start_read_locked{_nested} helpers
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: willy@infradead.org, liam.howlett@oracle.com, lorenzo.stoakes@oracle.com, 
	mhocko@suse.com, vbabka@suse.cz, hannes@cmpxchg.org, mjguzik@gmail.com, 
	oliver.sang@intel.com, mgorman@techsingularity.net, david@redhat.com, 
	peterx@redhat.com, oleg@redhat.com, dave@stgolabs.net, paulmck@kernel.org, 
	brauner@kernel.org, dhowells@redhat.com, hdanton@sina.com, hughd@google.com, 
	minchan@google.com, jannh@google.com, shakeel.butt@linux.dev, 
	souravpanda@google.com, pasha.tatashin@soleen.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kernel-team@android.com, surenb@google.com
Content-Type: text/plain; charset="UTF-8"

Introduce helper functions which can be used to read-lock a VMA when
holding mmap_lock for read. Replace direct accesses to vma->vm_lock
with these new helpers.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 include/linux/mm.h | 20 ++++++++++++++++++++
 mm/userfaultfd.c   | 14 ++++++--------
 2 files changed, 26 insertions(+), 8 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index fecd47239fa9..01ce619f3d17 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -722,6 +722,26 @@ static inline bool vma_start_read(struct vm_area_struct *vma)
 	return true;
 }
 
+/*
+ * Use only while holding mmap_read_lock which guarantees that nobody can lock
+ * the vma for write (vma_start_write()) from under us.
+ */
+static inline void vma_start_read_locked_nested(struct vm_area_struct *vma, int subclass)
+{
+	mmap_assert_locked(vma->vm_mm);
+	down_read_nested(&vma->vm_lock->lock, subclass);
+}
+
+/*
+ * Use only while holding mmap_read_lock which guarantees that nobody can lock
+ * the vma for write (vma_start_write()) from under us.
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
index 60a0be33766f..55019c11b5a8 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -86,13 +86,11 @@ static struct vm_area_struct *uffd_lock_vma(struct mm_struct *mm,
 	vma = find_vma_and_prepare_anon(mm, address);
 	if (!IS_ERR(vma)) {
 		/*
+		 * While holding mmap_lock we can't fail
 		 * We cannot use vma_start_read() as it may fail due to
-		 * false locked (see comment in vma_start_read()). We
-		 * can avoid that by directly locking vm_lock under
-		 * mmap_lock, which guarantees that nobody can lock the
-		 * vma for write (vma_start_write()) under us.
+		 * false locked (see comment in vma_start_read()).
 		 */
-		down_read(&vma->vm_lock->lock);
+		vma_start_read_locked(vma);
 	}
 
 	mmap_read_unlock(mm);
@@ -1480,10 +1478,10 @@ static int uffd_move_lock(struct mm_struct *mm,
 		 * See comment in uffd_lock_vma() as to why not using
 		 * vma_start_read() here.
 		 */
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
2.47.0.277.g8800431eea-goog


