Return-Path: <linux-kernel+bounces-544059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B0174A4DCF7
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 12:50:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BA7F18937C8
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 11:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D86B2201019;
	Tue,  4 Mar 2025 11:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bu8m1ybA"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7456020102F
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 11:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741088988; cv=none; b=QnUWePFPPjYqqxMm+Fmy4Px8Wa4q1YkuGVP3VTDxkQlo56/I41YzOypoEY8UYbRXiInh1+YMlvmH2jFljMtdyiUtnuu/gzRQHq7mlDTQ4c8L69jtplm3maXxAwU5praH5T1hqrmQEDXgvuyzTOBa+B4DTHrpHgMiwsDMpvmHTsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741088988; c=relaxed/simple;
	bh=eg6Y94/WepNbFgn/OKKuz+YnQMqsdVsuq0LV73sgTeg=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Cf46eVuVaffklsZN+3TlUDst1C2b6NXiJstxnM/TjZtDYCl1FoNlzjGMYkipj+G+mcy9ftaJ5s8mibPL7hQNcj1ocJpath0UQ9XpVaLOo3kHsQWxPlAuB9dEgokdPd/g8czs/3IZhexCQIXDMowt4qbhFAvTuytM9Zvps1Qq97A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bu8m1ybA; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2233622fdffso103552015ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 03:49:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741088986; x=1741693786; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fPlb+RHpjvuAHo7jM9mxzGvumfLeY4uukzr0IOz2olo=;
        b=bu8m1ybAy9B9gSRrcaiAOWs1Z2Vf1cA0InayPZfgx0w+QY7y60ACnMhNlKYZ0HAr65
         vK2zsfkLDOEbSI9SyFb12zRKm2vxq/6yj2wEza6D4AJsWuD/6+/PTItwFoEtch+nyUGj
         e1+H+/B6650TGSFLrKtKqrAutMWe4aDbhn8mgQP6I3ZAz7sbi9XFgz41Eq6JS4CrdY13
         v3u76nGUOnY6bR0d5oGIS5YzNV/co15JW+HmDqaXeMHQy3MKxPy3JCru4ZExgdvaXLNT
         ptKDMWqYIxmFxPrhBCkxww4KR11O5FTvBQ5xdc2utkOfZqOZ33KiPC7AJ0zE7PktALP2
         iu8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741088986; x=1741693786;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fPlb+RHpjvuAHo7jM9mxzGvumfLeY4uukzr0IOz2olo=;
        b=Wmrk7R21KQIBPHH0ElMN9r7Gp9w2D+jhPCsEA1DkMRgC35eoQ0HGAdYQgZ4pHm0S9Q
         tvDKlxHCR5OdngKygj1EP7Ts5XbB/2JmhniwcGRG+XLdZXma4Oj7Pm06fiJxWqm0GuVT
         2lM7Yai70F6wtGFRKYxWJlKmVAyaERmZMFmFg52fIrAOqmCFB4IJhhUDIB7Mx72pWHeA
         VzQsNwxE63J/rXme54gNRsI3hB7qqc90XKLSTPrunXV0nvOWZRTrHA4cTepEGhi6gbSs
         N2EPsuIY3qhyK2ls+PRWRtVYQXis+vN8IdDNZNnzcYplNpZnLrdkLcfJUOMFrHBxTe1z
         If7g==
X-Forwarded-Encrypted: i=1; AJvYcCXv6NCcftbyhMP81rORB99sNzhZX1sfYLlZ6GHYkqmqGxZ0M5tiN9yEW0Eo4rFq43cP+oqfbCHOfAtvdtI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywsgk+ileam+NCKs1zGNsjSG3dg384gyL7DfTIaDzjQCdsxR/YG
	6JHXxOqORkn9VvTglnUc4InjK/sU+2wiZpde8I01lyttdt8KpLzLsy1GvMPgMg==
X-Gm-Gg: ASbGncs+WLly9IEa7ZW+c9gY3QC9BkEWxHFFHBC/VZDKD17hm+o4KMbQKINDjuwZFv9
	PAHmj4BiC3uXzIu3Teg7xw5I0qp7rSntWRTRtGRegnmrR8x/UWCGF+WTD9ba+J00u352FRas/9K
	T84fpccq+aYFkMkX3Ueg6x0028Fwvp4TZ+fSA22iHYMxnHLvFpRTs8WCAEqx+5R4wymt3GSaZG7
	INAPV2T3rYbNltsh3AkM2Y3y3doNq0WU4LQF1lgl9dO8fKTnJXf/MRigVTA/718YsBMFKb9EiTU
	3A0f+1H1wVYMpbWMy1RASPtAw1Bv3H/lAcOfd6ubC743YejymcnYE17mZ8E5KSmPvJAla/R50wm
	qHwLGPOVn2q/i+BB4YM/mvCOoe4e9
X-Google-Smtp-Source: AGHT+IHnUPMc2gQCmddqJdZbbCKqjAWO12cSIqW4RrCn3vAmDjlonjV/HmPGvIt1+pbSRHmaOhbgoA==
X-Received: by 2002:a05:6a00:4f81:b0:736:5545:5b84 with SMTP id d2e1a72fcca58-7365545674fmr13070813b3a.3.1741088985318;
        Tue, 04 Mar 2025 03:49:45 -0800 (PST)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73638ab100asm6602885b3a.58.2025.03.04.03.49.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 03:49:44 -0800 (PST)
Date: Tue, 4 Mar 2025 03:49:32 -0800 (PST)
From: Hugh Dickins <hughd@google.com>
To: Zi Yan <ziy@nvidia.com>
cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
    "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, 
    "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
    Ryan Roberts <ryan.roberts@arm.com>, Hugh Dickins <hughd@google.com>, 
    David Hildenbrand <david@redhat.com>, 
    Yang Shi <yang@os.amperecomputing.com>, Miaohe Lin <linmiaohe@huawei.com>, 
    Kefeng Wang <wangkefeng.wang@huawei.com>, Yu Zhao <yuzhao@google.com>, 
    John Hubbard <jhubbard@nvidia.com>, 
    Baolin Wang <baolin.wang@linux.alibaba.com>, 
    linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
    Kairui Song <kasong@tencent.com>, Liu Shixin <liushixin2@huawei.com>
Subject: Re: [PATCH v9 2/8] mm/huge_memory: add two new (not yet used)
 functions for folio_split()
In-Reply-To: <20250226210032.2044041-3-ziy@nvidia.com>
Message-ID: <2fae27fe-6e2e-3587-4b68-072118d80cf8@google.com>
References: <20250226210032.2044041-1-ziy@nvidia.com> <20250226210032.2044041-3-ziy@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 26 Feb 2025, Zi Yan wrote:

> This is a preparation patch, both added functions are not used yet.
> 
> The added __split_unmapped_folio() is able to split a folio with its
> mapping removed in two manners: 1) uniform split (the existing way), and
> 2) buddy allocator like split.
> 
> The added __split_folio_to_order() can split a folio into any lower order.
> For uniform split, __split_unmapped_folio() calls it once to split the
> given folio to the new order.  For buddy allocator split,
> __split_unmapped_folio() calls it (folio_order - new_order) times and each
> time splits the folio containing the given page to one lower order.
> 
> Signed-off-by: Zi Yan <ziy@nvidia.com>

Sorry, I'm tired and don't really want to be writing this yet, but the
migrate "hotfix" has tipped my hand, and I need to get this out to you
before more days pass.

I'd been unable to complete even a single iteration of my "kernel builds
on huge tmpfs while swapping to SSD" testing during this current 6.14-rc
mm.git cycle (6.14-rc itself fine) - until the last week, when some
important fixes have come in, so I'm no longer getting I/O errors from
ext4-on-loop0-on-huge-tmpfs, and "Huh VM_FAULT_OOM leaked" warnings: good.

But I still can't get beyond a few iterations, a few minutes: there's
some corruption of user data, which usually manifests as a kernel build
failing because fixdep couldn't find some truncated-on-the-left pathname.

While it definitely bisected to your folio_split() series, it's quite
possible that you're merely exposing an existing bug to wider use.

I've spent the last few days trying to track this down, but still not
succeeded: I'm still getting much the same corruption.  But have been
folding in various fixes as I found them, even though they have not
solved the main problem at all.  I'll return to trying to debug the
corruption "tomorrow".

I think (might be wrong, I'm in a rush) my mods are all to this
"add two new (not yet used) functions for folio_split()" patch:
please merge them in if you agree.

1. From source inspection, it looks like a folio_set_order() was missed.

2. Why is swapcache only checked when folio_test_anon? I can see that
   you've just copied that over from the old __split_huge_page(), but
   it seems wrong to me here and there - I guess a relic from before
   shmem could swap out a huge page.

3. Doing folio_next() inside the for(;;) is unsafe in those configs
   which have to look up zone etc, I got an oops from the "new_folio"
   loop; didn't hit an oops from the "release" loop but fixed that too.

4. While correcting anon versus mapping versus swap_cache, shortened
   the lines by avoiding origin_folio->mapping and &release->page.

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 mm/huge_memory.c | 39 ++++++++++++++++++++-------------------
 1 file changed, 20 insertions(+), 19 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 0e45937c0d91..9ce3906672b9 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3612,7 +3612,9 @@ static void __split_folio_to_order(struct folio *folio, int new_order)
 		folio_xchg_last_cpupid(new_folio, folio_last_cpupid(folio));
 	}
 
-	if (!new_order)
+	if (new_order)
+		folio_set_order(folio, new_order);
+	else
 		ClearPageCompound(&folio->page);
 }
 
@@ -3682,7 +3684,9 @@ static int __split_unmapped_folio(struct folio *folio, int new_order,
 	int ret = 0;
 	bool stop_split = false;
 
-	if (folio_test_anon(folio) && folio_test_swapcache(folio)) {
+	if (folio_test_swapcache(folio)) {
+		VM_BUG_ON(mapping);
+
 		/* a swapcache folio can only be uniformly split to order-0 */
 		if (!uniform_split || new_order != 0)
 			return -EINVAL;
@@ -3750,9 +3754,8 @@ static int __split_unmapped_folio(struct folio *folio, int new_order,
 		 * is new_order, since the folio will be worked on in next
 		 * iteration.
 		 */
-		for (release = folio, next = folio_next(folio);
-		     release != end_folio;
-		     release = next, next = folio_next(next)) {
+		for (release = folio; release != end_folio; release = next) {
+			next = folio_next(release);
 			/*
 			 * for buddy allocator like split, the folio containing
 			 * page will be split next and should not be released,
@@ -3784,32 +3787,31 @@ static int __split_unmapped_folio(struct folio *folio, int new_order,
 			lru_add_page_tail(origin_folio, &release->page,
 						lruvec, list);
 
-			/* Some pages can be beyond EOF: drop them from page cache */
+			/* Some pages can be beyond EOF: drop them from cache */
 			if (release->index >= end) {
-				if (shmem_mapping(origin_folio->mapping))
+				if (shmem_mapping(mapping))
 					nr_dropped += folio_nr_pages(release);
 				else if (folio_test_clear_dirty(release))
 					folio_account_cleaned(release,
-						inode_to_wb(origin_folio->mapping->host));
+						inode_to_wb(mapping->host));
 				__filemap_remove_folio(release, NULL);
 				folio_put(release);
-			} else if (!folio_test_anon(release)) {
-				__xa_store(&origin_folio->mapping->i_pages,
-						release->index, &release->page, 0);
+			} else if (mapping) {
+				__xa_store(&mapping->i_pages,
+						release->index, release, 0);
 			} else if (swap_cache) {
 				__xa_store(&swap_cache->i_pages,
 						swap_cache_index(release->swap),
-						&release->page, 0);
+						release, 0);
 			}
 		}
 	}
 
 	unlock_page_lruvec(lruvec);
 
-	if (folio_test_anon(origin_folio)) {
-		if (folio_test_swapcache(origin_folio))
-			xa_unlock(&swap_cache->i_pages);
-	} else
+	if (swap_cache)
+		xa_unlock(&swap_cache->i_pages);
+	if (mapping)
 		xa_unlock(&mapping->i_pages);
 
 	/* Caller disabled irqs, so they are still disabled here */
@@ -3828,9 +3830,8 @@ static int __split_unmapped_folio(struct folio *folio, int new_order,
 	 * For buddy allocator like split, the first after-split folio is left
 	 * for caller to unlock.
 	 */
-	for (new_folio = origin_folio, next = folio_next(origin_folio);
-	     new_folio != next_folio;
-	     new_folio = next, next = folio_next(next)) {
+	for (new_folio = origin_folio; new_folio != next_folio; new_folio = next) {
+		next = folio_next(new_folio);
 		if (new_folio == page_folio(lock_at))
 			continue;
 
-- 
2.43.0

