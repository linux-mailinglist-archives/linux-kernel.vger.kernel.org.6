Return-Path: <linux-kernel+bounces-532457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE5B8A44DFA
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 21:46:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 288AC189A518
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 20:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3110919F41C;
	Tue, 25 Feb 2025 20:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TgUdjRhs"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5D84A1E
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 20:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740516379; cv=none; b=AXi21B/8WKkMXwy/U741fvCT72PEzUvR1fVzX6FXwKKZNvITivMIsq+0qQ96Zfk1NE8gelfEviepDV6XDZBKGIlkd5aZlqbEzw9zFa1MK6aq7aQdsTOibXvjaBQw6poNm53OmY5F8+wgVFq/TJnkj2YA9FgsjCDlOIDeF1fKmJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740516379; c=relaxed/simple;
	bh=Lb1zaIqiZM+uYmK0y6FfmW9Ae8kp+1CY4PP6GUnValA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=V1+V9lMsLBvu+9xlJCkAVQr+dc3wzXOHBLmfuCVIvQ7bsObXiDGwnXCBm25cfBGEadE7TZaOuZA7nLej2B/SxgMC5Bg18UUgi5qOCnp9Rq1YmIl3Un8PG4r20cQFPanBADp4QRR0khRhpYSlFpKzfZ9rdkIcTVfvT8FD5rUKzLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TgUdjRhs; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2f83e54432dso20002261a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 12:46:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740516377; x=1741121177; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AwsNt/V6C0SEvs4Dnf61cWDTvftwNiiIlb4RnaXcmjM=;
        b=TgUdjRhsqg+Wzi9VKw1yTdJOgd3ZBdu2X8Dz4YXT7ifkbQRt1iYsbLy2VJNj5C4hli
         0zz2MTMSRgTfKBbnM0LW3rAt4fezPofjP8B9UeYqHOod+jX2rKe2ahC+r0aL/3PPK3a7
         773KxrfpyV66pr/mkQqyJ7Rw/L/MKHnCXYNx8fL6RA1ninYYWtzMzgvjJpj+QEtN7KcE
         i2BO8m0bynN6i59Aanu0X9wpkMynY+xPhC9f+JJQ0ltnWjE7nFwJ+t+k+kJtnaVwDWB/
         8kg73xB1nWD69KSKH44wAWKW63VuHDfFMIRcy8zhCP01hezOqL+qv53KieKh7wreqfCl
         sWBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740516377; x=1741121177;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AwsNt/V6C0SEvs4Dnf61cWDTvftwNiiIlb4RnaXcmjM=;
        b=jPDNwutBcYYpyUeJod/ZBdWtgTSjybb6Nabl2rr5J9+LwGqUk3AXgu52aMIRf6wKic
         lVRnAYFxXn8JRvRbMnEvl83CxPqE/AhO44ZoqZ95ZQHuhSheIdOEOYlCgsPfWdTZYkLf
         F1WTsly2uU3UdBFtq2dXL4FOWvkbEXsHFHFkeOmLuukIpq85mF/4xv8ujlyhozgAdqQM
         FPqKOfz6zoTtzoVh+i0pd+JGuJAF3xMrGAORyTBbhvANFPtzU8k7i5iDUrd3Y6eEqyyE
         OebDXyCafZ7mdB5DAW/KduyygBVguqMx6TvV7ot1uPtRJ3fwQUaCzyqp+th2OocaYLSC
         GEtw==
X-Forwarded-Encrypted: i=1; AJvYcCUL32BRbNNXnXeyY9rWd8h2EMm619Vbg+HEKc7eZ742SqlLaYH5aj85Pr0ehp6c8I3in3XOkKulNMa/naQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDn6PP68b00mzKOwrojOBCPXS26CGZ+tZoXQ7e5K3dmtw3WcEg
	H2fbnARMRn19ju6X7096EB/b8i2nbESGBU5Qlc4qOIhYLNyAvgHO6I8jDm17FuBPe+UpMaHWxfq
	QjQ==
X-Google-Smtp-Source: AGHT+IG3nnnvmkG+wxrHTInj2Ig69F87Y7hW6VG7poXUtHgZo3oQOVU0yNovmqwt3N1ta/wB/S58PbVD86Y=
X-Received: from pfwp47.prod.google.com ([2002:a05:6a00:26ef:b0:730:7a22:c567])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:aa7:8895:0:b0:732:6480:2bed
 with SMTP id d2e1a72fcca58-7348bdd348dmr1042646b3a.13.1740516377355; Tue, 25
 Feb 2025 12:46:17 -0800 (PST)
Date: Tue, 25 Feb 2025 12:46:13 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.658.g4767266eb4-goog
Message-ID: <20250225204613.2316092-1-surenb@google.com>
Subject: [PATCH 1/1] userfaultfd: do not block on locking a large folio with
 raised refcount
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: lokeshgidra@google.com, aarcange@redhat.com, 21cnbao@gmail.com, 
	v-songbaohua@oppo.com, david@redhat.com, peterx@redhat.com, 
	willy@infradead.org, Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com, 
	hughd@google.com, jannh@google.com, kaleshsingh@google.com, surenb@google.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Lokesh recently raised an issue about UFFDIO_MOVE getting into a deadlock
state when it goes into split_folio() with raised folio refcount.
split_folio() expects the reference count to be exactly
mapcount + num_pages_in_folio + 1 (see can_split_folio()) and fails with
EAGAIN otherwise. If multiple processes are trying to move the same
large folio, they raise the refcount (all tasks succeed in that) then
one of them succeeds in locking the folio, while others will block in
folio_lock() while keeping the refcount raised. The winner of this
race will proceed with calling split_folio() and will fail returning
EAGAIN to the caller and unlocking the folio. The next competing process
will get the folio locked and will go through the same flow. In the
meantime the original winner will be retried and will block in
folio_lock(), getting into the queue of waiting processes only to repeat
the same path. All this results in a livelock.
An easy fix would be to avoid waiting for the folio lock while holding
folio refcount, similar to madvise_free_huge_pmd() where folio lock is
acquired before raising the folio refcount.
Modify move_pages_pte() to try locking the folio first and if that fails
and the folio is large then return EAGAIN without touching the folio
refcount. If the folio is single-page then split_folio() is not called,
so we don't have this issue.
Lokesh has a reproducer [1] and I verified that this change fixes the
issue.

[1] https://github.com/lokeshgidra/uffd_move_ioctl_deadlock

Reported-by: Lokesh Gidra <lokeshgidra@google.com>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 mm/userfaultfd.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 867898c4e30b..f17f8290c523 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -1236,6 +1236,7 @@ static int move_pages_pte(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd,
 		 */
 		if (!src_folio) {
 			struct folio *folio;
+			bool locked;
 
 			/*
 			 * Pin the page while holding the lock to be sure the
@@ -1255,12 +1256,26 @@ static int move_pages_pte(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd,
 				goto out;
 			}
 
+			locked = folio_trylock(folio);
+			/*
+			 * We avoid waiting for folio lock with a raised refcount
+			 * for large folios because extra refcounts will result in
+			 * split_folio() failing later and retrying. If multiple
+			 * tasks are trying to move a large folio we can end
+			 * livelocking.
+			 */
+			if (!locked && folio_test_large(folio)) {
+				spin_unlock(src_ptl);
+				err = -EAGAIN;
+				goto out;
+			}
+
 			folio_get(folio);
 			src_folio = folio;
 			src_folio_pte = orig_src_pte;
 			spin_unlock(src_ptl);
 
-			if (!folio_trylock(src_folio)) {
+			if (!locked) {
 				pte_unmap(&orig_src_pte);
 				pte_unmap(&orig_dst_pte);
 				src_pte = dst_pte = NULL;

base-commit: 801d47bd96ce22acd43809bc09e004679f707c39
-- 
2.48.1.658.g4767266eb4-goog


