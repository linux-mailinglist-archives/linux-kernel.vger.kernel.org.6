Return-Path: <linux-kernel+bounces-228306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC6CD915DE1
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 07:00:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 979C2283B38
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 05:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9728A144303;
	Tue, 25 Jun 2024 05:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fgqqLzkC"
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680B6748F
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 05:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719291629; cv=none; b=FIbe3su6QMgSQyXrzMmeaG8H/Ng/D0DykhSlAKqBI4+aamISC0IROls89FHA9FSfwvLpqoYVEyKRotgm0MucjJfAtRz032dCe8ZndkgFCdZwqLoz9ThiPKdHKU9lvugBf/2nQPPidCC7yRoOt56zenWbgOs9xwq2m4Y3pMYgEU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719291629; c=relaxed/simple;
	bh=5t2ubRi5VmxFm/P/ukvKQIcpPlii7ycreR0xtreEVe0=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=QkgRrN6CPzwQq1ZMPnMdzAhT1bSCcR52Kf+d37gmsDCHq8MQv4G+7uHepJ+mMLmkekER6/UK95urKlmuoBfAsXHpeLiPXNTdmlXOrCB3Ms64O00tJPzxjHmtFiUkkaoHq7PmbjtqTBBfOhma0nltfgRAOZHCLcmb1NbTFCASoxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fgqqLzkC; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e02c4168e09so4769105276.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 22:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719291627; x=1719896427; darn=vger.kernel.org;
        h=mime-version:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DI1Xy5KDlgelochwTug5ga0AHKmpmKH+0sr3zq1dLns=;
        b=fgqqLzkCBstGaOTofYKrGAM0vWzYgOwYPBMZLg19ic+PPOGNIatjZQuU4aKPbMCTvq
         00ymIXhlq5D/IBktzkFrdTmq/Ab4/w1ff13FQoYHfdXdIjc9Dh4c0AtfO4l93rQPiIQ3
         YN5lvdcygohbrOD5fazs9+sZBECEn2QNNVvfA4ekAXBck/pDL/Aq/sNGrsdiTzGKBzom
         Ax3M9jrOBthTPHArp+6eDsC2w+7KNG/hnsFv8DH7t879crQ6I+XJMmrO8XOU96/0kzfA
         PkrKPUjQkDbsLyPi5f2smn6ocDIuKKXbiqhFajs3hcslKBGQjbZzyNxtwCwZT0A2h/T2
         UtEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719291627; x=1719896427;
        h=mime-version:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DI1Xy5KDlgelochwTug5ga0AHKmpmKH+0sr3zq1dLns=;
        b=XGoswDuVvmui0eiUSFejkasH5dva2HAXnSNPnE4v8RgVOsD7LEPYpiHxxZEXOmAEVy
         mqjA1iFzTIaJ826PLqrFTiWP0grqn3c8NJim37bzd0j7Cdc8xQQXYXytrWSznGrgnqws
         xd3spRL1jSCKnyMMzWlRd5PUQ6j5nlM/7EuqXmd+iR6TmCkl2ErUg7FGnoRa8mFsTrUQ
         7W0x7OOtKTH2sUqGVDHC5uZODe2ias8WztHnCu2jfWYUQxPdcYvYGAXYLxDZiL8BGmmg
         qK/GQNzfPfiOqryNgIQxhRqFs7s3bELRnUZ6cb4vEzesOloWKMkVAROku8RrHh8FfQB9
         Amsw==
X-Forwarded-Encrypted: i=1; AJvYcCXoLQogtMHDcE70AWu7vd+aZtzjlxY58zI0j4+64zncMGHFEC8uYeG2mAXssYo9UWfPjSpwh/g8yHm3/FRrY1yVrIOONdatG+29wiOY
X-Gm-Message-State: AOJu0Yz/LMSGH/lz3qLgEs4qePMGyqMOKTcAOH26XEN6LCMCEZjkE0hv
	VYRECLZ87D1Y79hpIYOshGKBaiPJqFQWZUQcDaKkqT+8OMKR2t0Ru7310mEyZA==
X-Google-Smtp-Source: AGHT+IGFk1PurXMG31Uk5SzyO+Em8L43BwfcrQN6GFSqRW5nktZuFr13rpp8empsxKSUmBQgdPrnjw==
X-Received: by 2002:a25:d805:0:b0:e02:c7c9:732d with SMTP id 3f1490d57ef6-e0303fea29amr5275327276.60.1719291627156;
        Mon, 24 Jun 2024 22:00:27 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e02e6116b08sm3739945276.13.2024.06.24.22.00.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 22:00:26 -0700 (PDT)
Date: Mon, 24 Jun 2024 22:00:24 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
cc: Barry Song <21cnbao@gmail.com>, Hugh Dickins <hughd@google.com>, 
    baolin.wang@linux.alibaba.com, chrisl@kernel.org, david@redhat.com, 
    linux-kernel@vger.kernel.org, linux-mm@kvack.org, mhocko@suse.com, 
    ryan.roberts@arm.com, shy828301@gmail.com, surenb@google.com, 
    v-songbaohua@oppo.com, willy@infradead.org, ying.huang@intel.com, 
    yosryahmed@google.com, yuanshuai@oppo.com, yuzhao@google.com
Subject: [PATCH mm-unstable] mm: folio_add_new_anon_rmap() careful
 __folio_set_swapbacked()
Message-ID: <f3599b1d-8323-0dc5-e9e0-fdb3cfc3dd5a@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

Commit "mm: use folio_add_new_anon_rmap() if folio_test_anon(folio)==
false" has extended folio_add_new_anon_rmap() to use on non-exclusive
folios, already visible to others in swap cache and on LRU.

That renders its non-atomic __folio_set_swapbacked() unsafe: it risks
overwriting concurrent atomic operations on folio->flags, losing bits
added or restoring bits cleared.  Since it's only used in this risky
way when folio_test_locked and !folio_test_anon, many such races are
excluded; but, for example, isolations by folio_test_clear_lru() are
vulnerable, and setting or clearing active.

It could just use the atomic folio_set_swapbacked(); but this function
does try to avoid atomics where it can, so use a branch instead: just
avoid setting swapbacked when it is already set, that is good enough.
(Swapbacked is normally stable once set: lazyfree can undo it, but
only later, when found anon in a page table.)

This fixes a lot of instability under compaction and swapping loads:
assorted "Bad page"s, VM_BUG_ON_FOLIO()s, apparently even page double
frees - though I've not worked out what races could lead to the latter.

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 mm/rmap.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/rmap.c b/mm/rmap.c
index df1a43295c85..5394c1178bf1 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1408,7 +1408,9 @@ void folio_add_new_anon_rmap(struct folio *folio, struct vm_area_struct *vma,
 	VM_WARN_ON_FOLIO(folio_test_hugetlb(folio), folio);
 	VM_BUG_ON_VMA(address < vma->vm_start ||
 			address + (nr << PAGE_SHIFT) > vma->vm_end, vma);
-	__folio_set_swapbacked(folio);
+
+	if (!folio_test_swapbacked(folio))
+		__folio_set_swapbacked(folio);
 	__folio_set_anon(folio, vma, address, exclusive);
 
 	if (likely(!folio_test_large(folio))) {
-- 
2.35.3


