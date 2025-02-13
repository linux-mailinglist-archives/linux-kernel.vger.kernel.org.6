Return-Path: <linux-kernel+bounces-514030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 81593A35183
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 23:49:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A616818814F5
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 22:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7DE627FE70;
	Thu, 13 Feb 2025 22:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g+5+IuDc"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8AD0274271
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 22:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739486840; cv=none; b=GquX+6VEUD23toFMStJAP5YAeQKMtATL+hsnzRRCAe7Q0fCvRf2fkmB4amWjMrDcE/vHR7W1b0trY2jaEvHU/ywYn2Fo6Btrv+4neXjudx9x5wmQO0Hud/kGYiTojMbx/8Z0Mn40UzxP7OaCIBfOUfABxsz30T0Qb2VIc8sCfFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739486840; c=relaxed/simple;
	bh=Y4hMd1vQU5kJmXf3djw5SF9D6KSEwo+wW27aKEsq5PI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Q2t1m2Ka39NOSoTHTJ0SqFjXhmfEtBLzaoRbHQMGlb++SUR2aWulmpJYmV8QYMIccnizHRu5ZiXCNaH/NV9MZOaBWU2qAPDHnljeZVMuVT4fEGcNumvn2a90sU6aVWhdBLziqN50wIQxPcKw4Tal+kZDCrskt2Toy6R4g4MrE94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=g+5+IuDc; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2fc1c7c8396so1868133a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 14:47:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739486838; x=1740091638; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YNoCxF31vK1w52ANaPw+siaL/yNI9CD2wHk/1nIOSYo=;
        b=g+5+IuDcL2JDSdwxIS2lyLPKLwz9qSKJ6G/fDejQTqxKb552in/KKjFqBX3Z10WUEI
         RljhEmJxkdxAskjo+LHrrhI0SkX1lcPRyAyua/e58b6+JPHhlUQ0PZx1UAZhc011o4OQ
         Y4TPF7Vmnlxa0NsHrBtjwHrRKsnrfYJtOQzyIFPQ/ZDhQ1hPnBMq4LqXCuXRhzUmFA1+
         JavTXxwF/3vHOkxQJ7VGH3VazWShFib2S16v4ZbEXxNXkTKaEfKnz5cvp2W9l2rkkw+h
         pdyih6g/Tw6PRKAhMXKX0YLm4HXq3EfMa22yjK67KMhH6mxSkwxUN2Ak1ZhUDtduNByD
         56Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739486838; x=1740091638;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YNoCxF31vK1w52ANaPw+siaL/yNI9CD2wHk/1nIOSYo=;
        b=NjgOrvA/BXixg47PF6FxOBHbEphXMT6mI8KZSBW7IWmXbnJGoMqrteXE1vVQnwVqZ2
         dXJO+1uzHoCixcOwyWW4xLkZpE2VbwUchM3glfZf11KjwFdQNp4eqMgGagjJpDMifFMY
         lpQwAuTtKrgxnu3D6JVxi1FNxlBmr6ZyxnqEg2TVJKbvFJofiANijCds0xfHDpHRuMIY
         TTTcb3R/fZJa8Y8EQs4XlkvGKc7tjFTlKeysBlj+DCcGbAVI1Vm2IyZgzVkVeYj/T80P
         b5h/5Q7sepVjCMblstNXKZkQX6ogoAj8gMhLo+a+95uWqa971f42bLEKknbTpH8URP1F
         ovBw==
X-Forwarded-Encrypted: i=1; AJvYcCU/vxI77wsn3Wsd7WfBG9aexKtgS1rRNOK25jQl+Ewgfy5XZLs2SUcbO9EjHrjbzp27T9/XUyUnVwL96do=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyo2kzBkF4YNnnTYvmZJ1EdLkcu+Px1Iiqdp0R+X2xHIzA2+5D8
	0Hh98zObyDBjUeXxn5mRi4mflNlPUHzEYNjZtSPL1WqOiWSV3c3GkLoEgb9YAfX4nnoWF4BQ9Lm
	7nQ==
X-Google-Smtp-Source: AGHT+IErQJcr8UIFZH8RFb6dXrkV59J3DVPaTleZ6Gt1R/Rh5Le0xTpOCinKGJEwYZoy9GO+2bPedgwmiK8=
X-Received: from pjm4.prod.google.com ([2002:a17:90b:2fc4:b0:2ea:5613:4d5d])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:54c4:b0:2ee:ab29:1a65
 with SMTP id 98e67ed59e1d1-2fbf5bc07e4mr13915594a91.4.1739486838053; Thu, 13
 Feb 2025 14:47:18 -0800 (PST)
Date: Thu, 13 Feb 2025 14:46:46 -0800
In-Reply-To: <20250213224655.1680278-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250213224655.1680278-1-surenb@google.com>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <20250213224655.1680278-10-surenb@google.com>
Subject: [PATCH v10 09/18] mm: uninline the main body of vma_start_write()
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

vma_start_write() is used in many places and will grow in size very soon.
It is not used in performance critical paths and uninlining it should
limit the future code size growth.
No functional changes.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
Changes since v9 [1]:
- Add Reviewed-by, per Lorenzo Stoakes

[1] https://lore.kernel.org/all/20250111042604.3230628-10-surenb@google.com/

 include/linux/mm.h | 12 +++---------
 mm/memory.c        | 14 ++++++++++++++
 2 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 7fa7c39162fd..557d66e187ff 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -787,6 +787,8 @@ static bool __is_vma_write_locked(struct vm_area_struct *vma, unsigned int *mm_l
 	return (vma->vm_lock_seq == *mm_lock_seq);
 }
 
+void __vma_start_write(struct vm_area_struct *vma, unsigned int mm_lock_seq);
+
 /*
  * Begin writing to a VMA.
  * Exclude concurrent readers under the per-VMA lock until the currently
@@ -799,15 +801,7 @@ static inline void vma_start_write(struct vm_area_struct *vma)
 	if (__is_vma_write_locked(vma, &mm_lock_seq))
 		return;
 
-	down_write(&vma->vm_lock.lock);
-	/*
-	 * We should use WRITE_ONCE() here because we can have concurrent reads
-	 * from the early lockless pessimistic check in vma_start_read().
-	 * We don't really care about the correctness of that early check, but
-	 * we should use WRITE_ONCE() for cleanliness and to keep KCSAN happy.
-	 */
-	WRITE_ONCE(vma->vm_lock_seq, mm_lock_seq);
-	up_write(&vma->vm_lock.lock);
+	__vma_start_write(vma, mm_lock_seq);
 }
 
 static inline void vma_assert_write_locked(struct vm_area_struct *vma)
diff --git a/mm/memory.c b/mm/memory.c
index e600a5ff3c7a..3d9c5141193f 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -6393,6 +6393,20 @@ struct vm_area_struct *lock_mm_and_find_vma(struct mm_struct *mm,
 #endif
 
 #ifdef CONFIG_PER_VMA_LOCK
+void __vma_start_write(struct vm_area_struct *vma, unsigned int mm_lock_seq)
+{
+	down_write(&vma->vm_lock.lock);
+	/*
+	 * We should use WRITE_ONCE() here because we can have concurrent reads
+	 * from the early lockless pessimistic check in vma_start_read().
+	 * We don't really care about the correctness of that early check, but
+	 * we should use WRITE_ONCE() for cleanliness and to keep KCSAN happy.
+	 */
+	WRITE_ONCE(vma->vm_lock_seq, mm_lock_seq);
+	up_write(&vma->vm_lock.lock);
+}
+EXPORT_SYMBOL_GPL(__vma_start_write);
+
 /*
  * Lookup and lock a VMA under RCU protection. Returned VMA is guaranteed to be
  * stable and not isolated. If the VMA is not found or is being modified the
-- 
2.48.1.601.g30ceb7b040-goog


