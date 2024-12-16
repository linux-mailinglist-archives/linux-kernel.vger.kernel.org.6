Return-Path: <linux-kernel+bounces-448002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC2A49F39BB
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 20:26:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90D2B1886AFC
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 19:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B575620B1F6;
	Mon, 16 Dec 2024 19:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a4oaNIN0"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9274E20ADEC
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 19:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734377078; cv=none; b=kHGbmGfglGjb03Sw+C7dPRpa5rL7WG7UAoO16gbRdtjy58t9Nl/lCkxVeoLZQgWdt/k7qs75Mi61LJdsgxPx4j43xK7/5iavNWH+Uc8IRIwF5T5XLlRKcvhQMkdzqozB3gOr1eukmyuTKMoTJ2JP0+7nhHab/yHux5++IZWjtkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734377078; c=relaxed/simple;
	bh=xnU2+nk7SpTe6JV+i63325HLgR21aNoQ+OOoHR3eG1s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=l4n0vB//+X2Mf85BG0mZ748vTIbRwac0G7c9AeO1l3bPTToO5DKe8lj5Rq341KgnZTW5owdjzDIijZMyOgGuct6mzlkYVAEhnA7pEuZsVdntVzwf2gdfZrtj9ns+PPJnbr7/TZcV3EAJ99G6RKF0TjmC9Csc39+a8Mrf0WbEdIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=a4oaNIN0; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-7fbbb61a67cso2659267a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 11:24:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734377076; x=1734981876; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1gkuZWwQBkEGAXVOS6gJMPBIIwpS2AmmvzoNNuLoLbs=;
        b=a4oaNIN0Hm/6mh34emTGvwo7Fi8sgKg7GNsvt/OyBeG6gO5aQVSLQg9GhZR6DMbemw
         sCtn+hlQDuCBtYqnZ8NNViTE7FBXQG5RYYpvSpmp2ARbW+vIACqDUBWvpOV9OoAREPGS
         ba3BSx2/KkGBspNf3QtAsLBDor04WQyWQttpfKdv9osX1gAMuPfW9BR1Hyw10d/YfxFm
         7mBYht/k49ZQgApfR9DR4so2zi4NBvrn1N2AXoduagINDh7PpT2UOVDgNC/1pNhkt7mH
         58mNiJpWDuvfh/id5IpaZWyM1AEsrNHz5Yw677umBpc/cqbn3hwGzBuElFP9U0NkucQZ
         IONQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734377076; x=1734981876;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1gkuZWwQBkEGAXVOS6gJMPBIIwpS2AmmvzoNNuLoLbs=;
        b=Hm3YEtWgTXWbr7YhHsvYD+FiA6N9DYkkKapUXXex0ecg4t+1WkRCCAXtLSZ3Smxfq+
         5Wm1+pvCgsNhUUHsepcKjgEI4M29/UweG0qml22RpMkd+4FC4rFJJy4VYTGGIdV+YJUk
         J4gllc7yoRDYwNcEWD1r4RhVEGnHOY2uORBcQ37tUGVQMUW6o1gUK7uD/wLlsIcmAPkQ
         yPfq1VT9/MRR7vvXIOJafGkWKbaQab2cyPuiT0M+k1NEntwYIEDP5vUNiH1Vqz+iXmYP
         Z1oBqeRhN5bQp0dtfYCKOusyRoGuEbI6ADw0zgJsw4LL/vfy4fPSFzeZ1JAgpQkNolAf
         BYWQ==
X-Forwarded-Encrypted: i=1; AJvYcCW7u0yzyYlUA/ObzfSJnQVaJ+fXs6TZ4QtLcI8ARMJ+SGWTG689R3RiS5IB2cjAMuvO6fh+fFuD7GjW0RA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+HAc6veoFy1ajRYBFhPfScsVyPi3RKiHQFnoZ+B6Hbwwdcw/1
	g2r1N+D5il3dlu54zlXlsEFXxcdinZJ7R6a5SgUEq+Udyf/y5WQotG6k3hNfM8CkaJZM5U3dXha
	XuA==
X-Google-Smtp-Source: AGHT+IFRpgE3svFkQGxxP8t9jtfuJXCqP6DbanV+kjCkw5VL6vSIPipGx+mrpM9/g8/yEqYCZ44EecENvBs=
X-Received: from pjbsp4.prod.google.com ([2002:a17:90b:52c4:b0:2ee:4679:4a6b])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2744:b0:2ef:33a4:ae6e
 with SMTP id 98e67ed59e1d1-2f2d7d9fd46mr1314965a91.12.1734377075865; Mon, 16
 Dec 2024 11:24:35 -0800 (PST)
Date: Mon, 16 Dec 2024 11:24:09 -0800
In-Reply-To: <20241216192419.2970941-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241216192419.2970941-1-surenb@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241216192419.2970941-7-surenb@google.com>
Subject: [PATCH v6 06/16] mm: allow vma_start_read_locked/vma_start_read_locked_nested
 to fail
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

With upcoming replacement of vm_lock with vm_refcnt, we need to handle a
possibility of vma_start_read_locked/vma_start_read_locked_nested failing
due to refcount overflow. Prepare for such possibility by changing these
APIs and adjusting their users.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Cc: Lokesh Gidra <lokeshgidra@google.com>
---
 include/linux/mm.h |  6 ++++--
 mm/userfaultfd.c   | 17 ++++++++++++-----
 2 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 689f5a1e2181..0ecd321c50b7 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -747,10 +747,11 @@ static inline bool vma_start_read(struct vm_area_struct *vma)
  * not be used in such cases because it might fail due to mm_lock_seq overflow.
  * This functionality is used to obtain vma read lock and drop the mmap read lock.
  */
-static inline void vma_start_read_locked_nested(struct vm_area_struct *vma, int subclass)
+static inline bool vma_start_read_locked_nested(struct vm_area_struct *vma, int subclass)
 {
 	mmap_assert_locked(vma->vm_mm);
 	down_read_nested(&vma->vm_lock.lock, subclass);
+	return true;
 }
 
 /*
@@ -759,10 +760,11 @@ static inline void vma_start_read_locked_nested(struct vm_area_struct *vma, int
  * not be used in such cases because it might fail due to mm_lock_seq overflow.
  * This functionality is used to obtain vma read lock and drop the mmap read lock.
  */
-static inline void vma_start_read_locked(struct vm_area_struct *vma)
+static inline bool vma_start_read_locked(struct vm_area_struct *vma)
 {
 	mmap_assert_locked(vma->vm_mm);
 	down_read(&vma->vm_lock.lock);
+	return true;
 }
 
 static inline void vma_end_read(struct vm_area_struct *vma)
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index bc9a66ec6a6e..79e8ae676f75 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -85,7 +85,8 @@ static struct vm_area_struct *uffd_lock_vma(struct mm_struct *mm,
 	mmap_read_lock(mm);
 	vma = find_vma_and_prepare_anon(mm, address);
 	if (!IS_ERR(vma))
-		vma_start_read_locked(vma);
+		if (!vma_start_read_locked(vma))
+			vma = ERR_PTR(-EAGAIN);
 
 	mmap_read_unlock(mm);
 	return vma;
@@ -1483,10 +1484,16 @@ static int uffd_move_lock(struct mm_struct *mm,
 	mmap_read_lock(mm);
 	err = find_vmas_mm_locked(mm, dst_start, src_start, dst_vmap, src_vmap);
 	if (!err) {
-		vma_start_read_locked(*dst_vmap);
-		if (*dst_vmap != *src_vmap)
-			vma_start_read_locked_nested(*src_vmap,
-						SINGLE_DEPTH_NESTING);
+		if (!vma_start_read_locked(*dst_vmap)) {
+			if (*dst_vmap != *src_vmap) {
+				if (!vma_start_read_locked_nested(*src_vmap,
+							SINGLE_DEPTH_NESTING)) {
+					vma_end_read(*dst_vmap);
+					err = -EAGAIN;
+				}
+			}
+		} else
+			err = -EAGAIN;
 	}
 	mmap_read_unlock(mm);
 	return err;
-- 
2.47.1.613.gc27f4b7a9f-goog


