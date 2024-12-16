Return-Path: <linux-kernel+bounces-447997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34CE79F39AF
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 20:24:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68EE016CCB6
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 19:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 517C72080F1;
	Mon, 16 Dec 2024 19:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CPEHp+Gl"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CDE8206F35
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 19:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734377067; cv=none; b=My1YLWT8p2Euf35atBExKQhnyN2i1rtJVM8hvgnPc7XzPrkddJnT3/kBwMNtWK/6U5RoyMeA7LIaNkmhcSmFwVofGKlxKGmgQiEC3Us7dKEvtB/VfqHu8uq/D9QLyJFFe5W/7MIMdvu5T1d8YSUtT4L96U49hYuyN4oLQfv/7ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734377067; c=relaxed/simple;
	bh=ZuhVNkkcxX9XPqzBdhxdevat7/UtnVBp6WiY/j9FpKE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sDL/bFtm6GXVojriwcxoO+7UspHIIc+LMcysiHIzqHvSXB0UhBqXr4jhPhXBfQJRaU90IYpWzzmjh1NYyeh/V8YT25NfiPLYz21/ajlT76OdF2XrTdodd9t8FKdFRr3w6Cdz+BcuY7kiM4eCt9/lk1Fs03R8L+ro5jw0DkZAG/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CPEHp+Gl; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-725eb1e9139so6564702b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 11:24:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734377065; x=1734981865; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NdPtaL44NpTjP9eS1K5KVvptksJqAFYIrPxgR/8blQY=;
        b=CPEHp+Glaf1mdGuw1Hmj22UTVdsJELco1PEoU2WWGYqk2G/Ypzdzva1D1/EBpwwZhP
         mR8tKWw3z5rlp4852r7WFYfa1qK648yfInvuAAJ8vkMg2blFiKSJSMsE5ClL1jV+2sv1
         4muu+HI/eUCdxuRcG/+V38OdcrMF7FEcfP8g+ZZuD+4iX3a1NVXSoW0oJIzax+NtdVJf
         6Bn5VbwzB4PD2HvYXubSYOGQ+bGlSRbS/Ctwjzn8dFQnkHgYdOiP38yImqueWjKoDV1a
         ucmZAMkkcV/LJxupJinzBLaGgpj7d1OIonstHtYov5a4j83tH+zsdj5DtTLD78DEZX4d
         GM4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734377065; x=1734981865;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NdPtaL44NpTjP9eS1K5KVvptksJqAFYIrPxgR/8blQY=;
        b=Ty3z9ApleyYq/d2GO9F9w798Y0clrn3HnyoB8Dyx/c7hiUvIOFYUPQAXQ+BSOTyS8G
         dYjr2MqX2JGiVCaTgxX2L0OK2L/eqQntY/1V6JPTiUAzO2LHJQqhNgQpXj0CKJXIKM7h
         NlyWzQoXDCa+b6VzPI65Vd2jkfweBi69QmcQM3bJrtfCDG+nBol2D12koSLuyUj35WRS
         oa7WhiBE242Iz7kWpbcDYIsQqsfDOnkn046A4FTfKbrzHMjcaUc3Rd3qZ2BbGgWF150w
         atUsEhzgTaB5GMuuYSgqNFGMUKzXWX+v1hxtq/4v52IkbSvylkIl58H7asZh1xTxGPuX
         /U6Q==
X-Forwarded-Encrypted: i=1; AJvYcCU4ecRht8/xeBsjsqE4oN5GwT/Z6P8NJegrkn9X1OTZGwrHhx0zwaznwqQzwmyh/xP1dosIY1gjN9MILK4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvpWr0wG6LxRnCbzoy3nYnVvIxE16T0Oe9Z7m2Rt8nXT+EHXdW
	m5ti3ccQ8tKmE2SmRGknZXlYrM1k4a/OwckCKT8K8AQEav9bjRn8n6db+cTrpPzX5kK77g5WRyo
	TgQ==
X-Google-Smtp-Source: AGHT+IGebkhkuPAK7qZirmEWQkyXcqUHZOWu2H7W9h1+nHtKbr+4oTQtJb1gp01e4aHBI2bniuiuItfkaYg=
X-Received: from pfbbs2.prod.google.com ([2002:a05:6a00:4442:b0:725:e2fd:dcf9])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4305:b0:725:973f:9d53
 with SMTP id d2e1a72fcca58-7290c19ec16mr16656092b3a.15.1734377065528; Mon, 16
 Dec 2024 11:24:25 -0800 (PST)
Date: Mon, 16 Dec 2024 11:24:04 -0800
In-Reply-To: <20241216192419.2970941-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241216192419.2970941-1-surenb@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241216192419.2970941-2-surenb@google.com>
Subject: [PATCH v6 01/16] mm: introduce vma_start_read_locked{_nested} helpers
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

Introduce helper functions which can be used to read-lock a VMA when
holding mmap_lock for read.  Replace direct accesses to vma->vm_lock with
these new helpers.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
---
 include/linux/mm.h | 24 ++++++++++++++++++++++++
 mm/userfaultfd.c   | 22 +++++-----------------
 2 files changed, 29 insertions(+), 17 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 1352147a2648..3815a43ba504 100644
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
2.47.1.613.gc27f4b7a9f-goog


