Return-Path: <linux-kernel+bounces-412015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B76629D0268
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 09:10:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3865B24A4D
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 08:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34D6912C530;
	Sun, 17 Nov 2024 08:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r6d2k7S2"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0930084A5B
	for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2024 08:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731830981; cv=none; b=kF97dUO1d2rZwp22tkFvS04bdgxhvmfmgwutO1xOvfTHag/FhIWV3MxjsmCGrq1d6IUd5rxgcDv/dtI0hjlO32/6vG00Ofzso4JkzrlNhhbicEgdhdPlqKSIznupl5lzD8hqaTdzhBwohrlhTsRGhMyg4aeKJVvfBlqoRc3gHt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731830981; c=relaxed/simple;
	bh=8wju+b7uaLmVu0APJU3rHR7dESQZvzmF8mBUVYwqEm8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mNrksJNd1WJHxKC1zSN0+ioUR3HAj8a0nUliXediBbd/6o33NONkg33dPOd3Ej+Wv4Bt5Ef5BlGoZQ5N22V/Ru4svcbcuuMfccK0bB3lYxtTOgZSpWMFH2AJDiFcElv+X/V7iqNoY6qgON7rDzXeAW4V0a7NLwgaMcjC1kCweCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=r6d2k7S2; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e387e8e8426so1262687276.1
        for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2024 00:09:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731830979; x=1732435779; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CZkyrFrgAwaR5MxHWX7P6WpGLYaVbagX6YvpJwNn5k0=;
        b=r6d2k7S2tTsh1PbLwKEuNtdpNl0tYMi40vxoL/Z8KtsAStXwQYHNqmoR5011EGS1ky
         ONqt9XXzGocuzrMD1megWm2y87fN92hWCxWGgR5T7mwZEafPp44UqFQt+AfzDcUZWsho
         zrygkwG+tcF6cGWKk+bGayPwezgMV2XoNgT2DIrP4POaMdPeK1jlMyITW5x3j0uwsPhx
         sbTEgpY/xgIPZo+GerwJJjYSbgDFDIRdFucY4AJr+Z2bw9s5P5nt3FWgFZ3UFjDeFY7e
         3qNMOjI9Z/X4drjDrk4ODk4m9i0BbFhwNX1nV2G6m38QvrNdvRNozspro0O+cdU1UV+n
         rr8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731830979; x=1732435779;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CZkyrFrgAwaR5MxHWX7P6WpGLYaVbagX6YvpJwNn5k0=;
        b=ZjT7Ys3H9YwRUpJBSjdvTiHwwp/AZ6udw0WEZdqUV6jT7Xhgw77DgrEvAH/PaZYPDU
         ggVGIWvbAWSICEiRbKYMqtQuEqpayhEOHlV3AgHjWuzZHP4cPeekgNBnYMqn1/WEgMqo
         px1WMsY+maRjg/uCtrw6Wv+u46TR8lcY2FziJ2BIvF2Mvp1QfP5HmIfjz+1UwuQwedrM
         g+6X1VvlzXz26cUQERWRWBoFsLve+5JES1qf0U1Hl34QwdfhyB5fiD1MibQa11YWxJ5B
         m4f+DZSCz/F6/1VCfGsPQ7wWwKjYUR0rYzYHW6ez1YEp/N6eQ6kcGEYoR7eIAdjyoOPU
         hVBw==
X-Forwarded-Encrypted: i=1; AJvYcCVr7r+7J8tenVeJIKtFdD+6A4OzUU7sT5YdoZvIPRqWk/zWvopFGbw2b+W2USmcIQogDXe/4vBA1Wnbmzs=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywm9/nJyoXXhEZ9moX77RSAy3yIRpArU4HTt+vVYm0iIQZHiHBA
	8Drt97HA7h+L3DtI502GUKex6NTFduYM+2YcFiIO+Vgb6OmhzoNGX+zbF+tLXhJT5vgOSlfMRvM
	H9Q==
X-Google-Smtp-Source: AGHT+IH7Nd8pXV7CscbKL6Oe02lMMMIInGW3q+Det1fKSUjvn9CktAIAKXjQIOt60hBNRgC9PV8ouBWRm4Y=
X-Received: from surenb-desktop.mtv.corp.google.com ([2a00:79e0:2e3f:8:bafc:6633:f766:6415])
 (user=surenb job=sendgmr) by 2002:a25:9d85:0:b0:e2e:317a:d599 with SMTP id
 3f1490d57ef6-e3824ac0065mr340301276.2.1731830978836; Sun, 17 Nov 2024
 00:09:38 -0800 (PST)
Date: Sun, 17 Nov 2024 00:09:27 -0800
In-Reply-To: <20241117080931.600731-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241117080931.600731-1-surenb@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241117080931.600731-2-surenb@google.com>
Subject: [PATCH v3 1/5] mm: introduce vma_start_read_locked{_nested} helpers
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
---
 include/linux/mm.h | 24 ++++++++++++++++++++++++
 mm/userfaultfd.c   | 22 +++++-----------------
 2 files changed, 29 insertions(+), 17 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index fecd47239fa9..1ba2e480ae63 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -722,6 +722,30 @@ static inline bool vma_start_read(struct vm_area_struct *vma)
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
index 60a0be33766f..87db4b32b82a 100644
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
@@ -1476,14 +1468,10 @@ static int uffd_move_lock(struct mm_struct *mm,
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


