Return-Path: <linux-kernel+bounces-514028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04D7FA35181
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 23:48:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 536981620E3
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 22:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA0A127425C;
	Thu, 13 Feb 2025 22:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gFTq+RN9"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B038327129F
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 22:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739486836; cv=none; b=GbW9eRae53n3KwIo4G8Sn9HSUFIUud1BlZqDEZRvJZBAvo8xhGJNjhOuXqaLCVeNXifqUj1qlg18aIx0wnURFmKPUKh0lk7sd3AQvgGbEOamA1MwWE1KQfqk7Hr/1pTi4DDhvNIB/wE+NGZbY2MHA7iyMThU/KzpkjgHudbBRTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739486836; c=relaxed/simple;
	bh=JhPdcuk4AGpU93OVpkaMGB6F3cd+gFPx66MB+rFF950=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YWdPd3Jh4ibP+nWJDiLEF7a2Vf6O71+YIIWQtBRFlIlS7w1O0U0HwWoLOD8ocLNx+EIOKFvpHUzYZHbrQLKBrcGc3mn9LVlO5YVo3Pra9mBTFN9Amg2lYRWMhg6Cvu6gtUkMhdTz7xAksnmiQPKxZfOXnHp6sBkxfRDnlOGCxM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gFTq+RN9; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-21fb94c7fc6so29875675ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 14:47:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739486834; x=1740091634; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8lnVYcB8HwzzUuW9qEx+Yoh+VM8+OMN/pADhYBeUDVo=;
        b=gFTq+RN9EKpCzcXhSXt1fQwnI9nLa4aj+w4+MlXgVKkVKvOD6TI4HIz7vf6ONp8Yg7
         rtqCCptndANKS5nzZw1B9Wa2zt58ZLAJsiNB0LNJZ6TJQNmzFNKitwa3FfgG7aeVtQ2i
         20dUX/c3ytQkDzo3ZtY2JIpRAZwnC92bW0j1ujF9xp2fhASgHGyUzZ+CWmnILpwvHsGV
         iPmQTaRFqeSo9mlH1HIhu2CRZbQEPToGfUAGpUIZ+83RBI0L1Y1Ci47xtU0SHK0CyNuq
         4Wbio3sfkzUKDqdGIUHKxg1yhm5D6h9trJx8nVKTze3eXMbtpMVIr5eAuWV0ZHOnW6aq
         y7bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739486834; x=1740091634;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8lnVYcB8HwzzUuW9qEx+Yoh+VM8+OMN/pADhYBeUDVo=;
        b=psRT7zWGuAx2VYddubHI2t/qRwFCY6DIEmj50pB1OCxkJTiU7HA4XzfKeBdslMZgFv
         jGNY2GoWdycMlHBYXAOc7R+7cZZB2ygueCYvus/8/J4dL8MKYyvEDhg0LjxhSzRsGOwD
         WdK7OR6C8iEP6QEI9mARFG3+x/HqY4SRTtdMs2vUg6bcbQXSZYhydCMBXOT0rNtRIJKf
         65kRT63jXNMkV2tj9BYKjTjHATZtK1izhfzZ+YHtWBrGQOVCoal5/0LD/OsgHJeZ1D17
         +37fvzS+0VSX6RDHoCbYQwrio/2I50M47emmQxRyfKyWiFnAVFc45qXUDJKaAB1f7Uvm
         sdlQ==
X-Forwarded-Encrypted: i=1; AJvYcCW49iHSq1YgO64t4TFwWuJvQF7cKCyj/ZPtYbNMPHrktrQcVI9KGZT0yhzvRIFLJ8qnlk5uUzytEpnnBY4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCb0kpwvwqmCrHqLJk74p3Jq24z3i9OPQd5bicsFd0WLEt7naq
	cE5JGI/dqxHlbOdI+0IiqUW180ton17ovGa1879j3nKs6+cxhxQMJemX7satBcvcJrSL2EII/0O
	+kw==
X-Google-Smtp-Source: AGHT+IFvP7Rtv2Mvdra3Yg1NiqesqrI7PbBRDKrXPHHWmHQO1TyYtp4d3ffasZylr6rr8GVtjs5kwYbmVJQ=
X-Received: from pfbgd3.prod.google.com ([2002:a05:6a00:8303:b0:730:8c7f:979])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:c997:b0:1ee:3b53:b77f
 with SMTP id adf61e73a8af0-1ee6b4013abmr9718076637.37.1739486834016; Thu, 13
 Feb 2025 14:47:14 -0800 (PST)
Date: Thu, 13 Feb 2025 14:46:44 -0800
In-Reply-To: <20250213224655.1680278-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250213224655.1680278-1-surenb@google.com>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <20250213224655.1680278-8-surenb@google.com>
Subject: [PATCH v10 07/18] mm: allow vma_start_read_locked/vma_start_read_locked_nested
 to fail
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

With upcoming replacement of vm_lock with vm_refcnt, we need to handle a
possibility of vma_start_read_locked/vma_start_read_locked_nested failing
due to refcount overflow. Prepare for such possibility by changing these
APIs and adjusting their users.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Cc: Lokesh Gidra <lokeshgidra@google.com>
---
Changes since v9 [1]:
- Refactor the code, per Lorenzo Stoakes
- Remove Vlastimil's Acked-by since code is changed

[1] https://lore.kernel.org/all/20250111042604.3230628-8-surenb@google.com/

 include/linux/mm.h |  6 ++++--
 mm/userfaultfd.c   | 30 +++++++++++++++++++++++-------
 2 files changed, 27 insertions(+), 9 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 1b8e72888124..7fa7c39162fd 100644
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
index 4527c385935b..867898c4e30b 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -84,8 +84,12 @@ static struct vm_area_struct *uffd_lock_vma(struct mm_struct *mm,
 
 	mmap_read_lock(mm);
 	vma = find_vma_and_prepare_anon(mm, address);
-	if (!IS_ERR(vma))
-		vma_start_read_locked(vma);
+	if (!IS_ERR(vma)) {
+		bool locked = vma_start_read_locked(vma);
+
+		if (!locked)
+			vma = ERR_PTR(-EAGAIN);
+	}
 
 	mmap_read_unlock(mm);
 	return vma;
@@ -1482,12 +1486,24 @@ static int uffd_move_lock(struct mm_struct *mm,
 
 	mmap_read_lock(mm);
 	err = find_vmas_mm_locked(mm, dst_start, src_start, dst_vmap, src_vmap);
-	if (!err) {
-		vma_start_read_locked(*dst_vmap);
-		if (*dst_vmap != *src_vmap)
-			vma_start_read_locked_nested(*src_vmap,
-						SINGLE_DEPTH_NESTING);
+	if (err)
+		goto out;
+
+	if (!vma_start_read_locked(*dst_vmap)) {
+		err = -EAGAIN;
+		goto out;
 	}
+
+	/* Nothing further to do if both vmas are locked. */
+	if (*dst_vmap == *src_vmap)
+		goto out;
+
+	if (!vma_start_read_locked_nested(*src_vmap, SINGLE_DEPTH_NESTING)) {
+		/* Undo dst_vmap locking if src_vmap failed to lock */
+		vma_end_read(*dst_vmap);
+		err = -EAGAIN;
+	}
+out:
 	mmap_read_unlock(mm);
 	return err;
 }
-- 
2.48.1.601.g30ceb7b040-goog


