Return-Path: <linux-kernel+bounces-534719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1E2EA46A42
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 19:55:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E548C16D451
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 18:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B9BB239097;
	Wed, 26 Feb 2025 18:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TvBT2RBT"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CAF4238171
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 18:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740596119; cv=none; b=QWzWzWoi2ePL9FPSIeQjnGGucSVUBMza396Y6EUtvF0S9y5SzrmjGKpfq02YjlEaApnBG/YXuWOBJ5kePOMaz+nx4mbWdTJ10iymCgBW12fwF3qQfRLPos6gjqdgFYGArMnvppo2PVDsAhwUoeyWFdYbQ4tYLsbQ6ZkLcu6sibc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740596119; c=relaxed/simple;
	bh=DFxYwmAu0gMhoxnx+btdSl7Kr+kO5+f1+DLTpvLY7K4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=h+jVNKAcaxW28FoiMMPJ+Tyi2vC3UqBDCJALexPIRmYaqXB8X/sGABWl0BXWZf3n7I57dfL9/4nzbrHOSjhW0HWnlcbhcoSIEqmOsWVpVWSp+nbIz5N0Es/oorD1NqvgetUM1SNhllilwrguoCkrGknbmL35mi67/Y37Rsu4MJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TvBT2RBT; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2fc1e7efdffso474376a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 10:55:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740596117; x=1741200917; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Qq/w9efOrw1qEDi9Bk8gaY9sQUDKf8Mk4VZDdis8uDc=;
        b=TvBT2RBT1nNEo9iB+0Igy/rWstsF1zvdj5KmKyBekWtHQ45bD08fY3vALVfIS+BBwd
         jPQSxrwe9EiitGKwcnPoqrH7/u/V0QyisA3MyZJWQ4dmKQ9Q//app03giSFub+oRVE/f
         76ACM4VxXkNptr1SPzHh2lEj4DrtIi8Tagngzs/73PBV1g9WDcyduHr+RCeud7/i90V1
         J8JZF+aQ7+gfWL+zfKfwDX/pNX7aA7emtCuJPR7JYbuScqfT4utCI6Ci0ofzHEoURmLA
         xzwMNk+mo6HwSB64/eNHRfe7usMqiNebhcxMW/5SUvqXiwGV6qSHnyVlKvpXWEWPB8Th
         fpYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740596117; x=1741200917;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qq/w9efOrw1qEDi9Bk8gaY9sQUDKf8Mk4VZDdis8uDc=;
        b=ufFou9zMK3lyCQCfuXG+4wOXG4FGuB8p0LsmY4ipdmzE1VjfzK+7PPeD4XZ8G+JcD4
         2jqHjHe954Jb9lPw/9bLew99IjOCH8upsl3HWEamASclpRcs1kTH+fY4BTZ5cSqhpwTL
         JEUST6c3J1gFtzBQ8PRMo4Cjb4LXQKzqtVWwqWTJBS7ztAzzXxz/Uarmyqm3QH6cbHcS
         fUw0YI5CE00w+ehQi+4z4wwWyh5SN6OkWDFYxera/wv4M2YyWSfIDEd5iRYEm1bIDXAd
         wXU7YgBr1fQmeu2cUhjBJ/qDFmo9yaTJAyiJJF3NMw4XHl1TFF7BFy2ol9Abu3KLI7s7
         Unrw==
X-Forwarded-Encrypted: i=1; AJvYcCX9aPC5ihvUW/VpDOSILJAxpIVlUfD+CuMoB0uNiT8ojpzdoyh6MyafIUWwMt4MB3f/A8EkijPDv5nfrBw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBhyDhfNu5Fk2FdEmyde80Aq2UWf4EDMKSuWMIE0Rpq1Nzyxb7
	HwLsacOiIKTvjdF+vXOrxnaJFc8UcS3PGwp2acPIVJNJPej7FK12NDqg/ieeur6RSiAvPDjRc0G
	xhQ==
X-Google-Smtp-Source: AGHT+IEvcJQuoFon8k2xY5GFl4e5CXCv9wO73DmNtMZqod2CTTLE14+eDEJfscr06yWzvuu3MNI7/Hu/V4g=
X-Received: from pjbqb10.prod.google.com ([2002:a17:90b:280a:b0:2e0:915d:d594])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2590:b0:2fa:d95:4501
 with SMTP id 98e67ed59e1d1-2fe68ae7111mr15283755a91.18.1740596117509; Wed, 26
 Feb 2025 10:55:17 -0800 (PST)
Date: Wed, 26 Feb 2025 10:55:09 -0800
In-Reply-To: <20250226185510.2732648-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250226185510.2732648-1-surenb@google.com>
X-Mailer: git-send-email 2.48.1.658.g4767266eb4-goog
Message-ID: <20250226185510.2732648-3-surenb@google.com>
Subject: [PATCH 2/2] userfaultfd: fix PTE unmapping stack-allocated PTE copies
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: lokeshgidra@google.com, aarcange@redhat.com, 21cnbao@gmail.com, 
	v-songbaohua@oppo.com, david@redhat.com, peterx@redhat.com, 
	willy@infradead.org, Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com, 
	hughd@google.com, jannh@google.com, kaleshsingh@google.com, surenb@google.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Current implementation of move_pages_pte() copies source and destination
PTEs in order to detect concurrent changes to PTEs involved in the move.
However these copies are also used to unmap the PTEs, which will fail if
CONFIG_HIGHPTE is enabled because the copies are allocated on the stack.
Fix this by using the actual PTEs which were kmap()ed.

Fixes: adef440691ba ("userfaultfd: UFFDIO_MOVE uABI")
Reported-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Cc: stable@vger.kernel.org
---
 mm/userfaultfd.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index e0f1e38ac5d8..dda1c9a3662a 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -1290,8 +1290,8 @@ static int move_pages_pte(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd,
 			spin_unlock(src_ptl);
 
 			if (!locked) {
-				pte_unmap(&orig_src_pte);
-				pte_unmap(&orig_dst_pte);
+				pte_unmap(src_pte);
+				pte_unmap(dst_pte);
 				src_pte = dst_pte = NULL;
 				/* now we can block and wait */
 				folio_lock(src_folio);
@@ -1307,8 +1307,8 @@ static int move_pages_pte(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd,
 		/* at this point we have src_folio locked */
 		if (folio_test_large(src_folio)) {
 			/* split_folio() can block */
-			pte_unmap(&orig_src_pte);
-			pte_unmap(&orig_dst_pte);
+			pte_unmap(src_pte);
+			pte_unmap(dst_pte);
 			src_pte = dst_pte = NULL;
 			err = split_folio(src_folio);
 			if (err)
@@ -1333,8 +1333,8 @@ static int move_pages_pte(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd,
 				goto out;
 			}
 			if (!anon_vma_trylock_write(src_anon_vma)) {
-				pte_unmap(&orig_src_pte);
-				pte_unmap(&orig_dst_pte);
+				pte_unmap(src_pte);
+				pte_unmap(dst_pte);
 				src_pte = dst_pte = NULL;
 				/* now we can block and wait */
 				anon_vma_lock_write(src_anon_vma);
@@ -1352,8 +1352,8 @@ static int move_pages_pte(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd,
 		entry = pte_to_swp_entry(orig_src_pte);
 		if (non_swap_entry(entry)) {
 			if (is_migration_entry(entry)) {
-				pte_unmap(&orig_src_pte);
-				pte_unmap(&orig_dst_pte);
+				pte_unmap(src_pte);
+				pte_unmap(dst_pte);
 				src_pte = dst_pte = NULL;
 				migration_entry_wait(mm, src_pmd, src_addr);
 				err = -EAGAIN;
@@ -1396,8 +1396,8 @@ static int move_pages_pte(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd,
 			src_folio = folio;
 			src_folio_pte = orig_src_pte;
 			if (!folio_trylock(src_folio)) {
-				pte_unmap(&orig_src_pte);
-				pte_unmap(&orig_dst_pte);
+				pte_unmap(src_pte);
+				pte_unmap(dst_pte);
 				src_pte = dst_pte = NULL;
 				/* now we can block and wait */
 				folio_lock(src_folio);
-- 
2.48.1.658.g4767266eb4-goog


