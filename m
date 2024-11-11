Return-Path: <linux-kernel+bounces-404749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 113D29C482A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 22:37:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6EEAEB37FAA
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 21:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 393241F426F;
	Mon, 11 Nov 2024 20:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Roi810DX"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E42C1EBA05
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 20:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731358515; cv=none; b=Z9NUlp62LFqkImJEnHDpWDwpRkG1Pmgux1lP0dYtfe8zt81FY4Ekg2A7poWolvLb/ebWeRwkRKi12zxnneWZCkCG5kZyHs36SrMhZsQFBK71jw3rV4/TfmtpxkANepBX8MPGAtKZvYUQG0CNDgnS6gTw6KHqhfGjdOa4DXio80o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731358515; c=relaxed/simple;
	bh=C8mwSaQ8Its/aWvWsxyeJgOzWgBQWhPS8Ji8jwToFzg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=f7MmPHQy2+WQwojX2l03kgGY70l54sAFOkQ4ic5OWmHUkwTvoCDiYwmIHLp7Yk8ICMX04it3NNNd59syvvqpeXFufppXMNQWYgQv9hInv+0E/9TCCZFXWjkWbfO3f/W0o63GXTEKW1CfILjyFuw+HI6v6ztIIPiMHYqteUkPscc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Roi810DX; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e2971589916so7842872276.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 12:55:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731358512; x=1731963312; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=c6L2TsxMW3xdptYp+SxjhxiQb9Rn3imOm+Hs2oG6vZc=;
        b=Roi810DXtrY8vb58LPyGPngm13kyemggIfcBJzu7McA/b6bvgpq8uEckqfwGzvBtvb
         Si7LB2B7bxTjQYq253/eGRr9AdfzWNUTiotNOzhNeL8fh1fog9Gq0hGA3pP3ACbKQUJF
         +txc0DouLWBgHXwhLwc098OiRDmqLYubuVgRuxWdZNN2M+O03ylXC94QXVfN39sTyG9M
         nh56ffqokO7GKEYDsxi9TO/mLR4QOdowXiJ1puRLzkaPF/aLgMea9HC27zcTMQuDSRiv
         k2ag6N/DUD3J5JPTPLK8TJGF2eup18dhwGIFLDFScmAiqR0FwS+bLWGqpJyAgUFo4uOJ
         Gq7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731358512; x=1731963312;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c6L2TsxMW3xdptYp+SxjhxiQb9Rn3imOm+Hs2oG6vZc=;
        b=sANzXGlLORA+lBOIVLv4hrFwQku4sy6UYLaDgC9O7ZibOpENMgHFG6v537Kcm1z4Xf
         YfmSHz0oysXOGQBQJOVOM88O2FlIBDZbvGCe2tM1odghY4Xknd+l6W2QdfXQgD0FIhkh
         yezff3Tl1rN0gpUhYcU7Fcr6Aei9A5dex/OwZsMJDSBkybmdmgYLEPYOqnoeAeWvFynK
         jbUAUr+rhLRtnuzSXVtHD7Eaz++pdgMeXqqb7YnZdc3kKZCUXwse0X1xBINhpGHBkOyZ
         KParE2i1sa/gfyZvcKXbr8gXwJQ8uR+tXsGcHYFb5MsvZllaVA3sO2T/R4Au4P5aUzX0
         g2LQ==
X-Forwarded-Encrypted: i=1; AJvYcCW12dHDUbmt+mVZV/VyrnF62qUR9B7iRSFnlgCQA4j+ytMIumSNfAgLE/fZb/De65sgxRMjUEikZVOvaH0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCIB60b8n9Az1TIClY2kAM3/qioHq9YPpTxy9t01TiEH/aZTQb
	8vRHxzSQ26PmlNg39Ip3OnsHg9wm/G2yc/4tpU9IZZ8Se0oZ5VUQkNuM3PqgkBJWV2jjlCUDoX2
	qHg==
X-Google-Smtp-Source: AGHT+IFtRvBKCg21ZonSdl0i6oAaNOlWcK8osbIXD1VUy6Zm+UF4tEaZT/nKAdEJtdzHD4gxQkKcsjXP+Js=
X-Received: from surenb-desktop.mtv.corp.google.com ([2a00:79e0:2e3f:8:53af:d9fa:522d:99b1])
 (user=surenb job=sendgmr) by 2002:a25:af4b:0:b0:e33:104c:fac8 with SMTP id
 3f1490d57ef6-e337f8d7427mr11316276.7.1731358512081; Mon, 11 Nov 2024 12:55:12
 -0800 (PST)
Date: Mon, 11 Nov 2024 12:55:03 -0800
In-Reply-To: <20241111205506.3404479-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241111205506.3404479-1-surenb@google.com>
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Message-ID: <20241111205506.3404479-2-surenb@google.com>
Subject: [PATCH 1/4] mm: introduce vma_start_read_locked{_nested} helpers
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


