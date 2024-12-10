Return-Path: <linux-kernel+bounces-439350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 380CF9EADFB
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 11:30:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BABE61889138
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 10:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17EFF2080DD;
	Tue, 10 Dec 2024 10:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GvwWD1uV"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D71199E9D
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 10:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733826603; cv=none; b=FYQgBad3ymjY9da4rkTc47l+zDkbezwmsih95OIFD/DTlREoPb6U0hjFtElaR4SQB5aDslZR6+44agOpxMmTzWLHMnowV3Z5r2m5fodm9N5dniqaRE0Jgz1gbY8P5UeC0E+m3gyDDwfSeUVxoLWQC+qGSrXLsb9Ls7TVCR/BBzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733826603; c=relaxed/simple;
	bh=yVB6IwJ6pkT1sqfa7Wjge8LAJzeDnNo12yXtNQ/hXqU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OX2q5PZWUBOjUgd1agvg0rc2WrS35BJITP++NSqWNw230AdSGu9sepxCFYnodSVLw18kiHN06SPvG9o/IFADLSPQaWtRYCDHU47liMVuCUpAm7psFU3n1ify5MjeM2DnB1ux6P9/ty9AHLeRpXjvDypJbr6lm6ShzAJj2+xRMqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GvwWD1uV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733826600;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jf3UvXO36r9NLrYYxU7q1kcbqObQ8HDR+wPuMnn0UoE=;
	b=GvwWD1uVduTL1q0NQJeb477HnmPTDR1fZLUKDbeJqUya0umDHuIhluhd4290Fyj7YO5nNt
	g+ZIZk32UWeasPdkZxUxx56xpOWNPk1QC0ueZV5UAbo+wcWv9Z1iHrEsx3TiZ4LpmGR5Gl
	xTvJnemfdivhRxMI5CgBVy53FCGDMew=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-262-7jpgDqjeMoq1BP6yTtJvaQ-1; Tue, 10 Dec 2024 05:29:59 -0500
X-MC-Unique: 7jpgDqjeMoq1BP6yTtJvaQ-1
X-Mimecast-MFC-AGG-ID: 7jpgDqjeMoq1BP6yTtJvaQ
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-38639b4f19cso1404853f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 02:29:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733826598; x=1734431398;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jf3UvXO36r9NLrYYxU7q1kcbqObQ8HDR+wPuMnn0UoE=;
        b=XHARzRMjc42DHaZDdYSdk0FHRy8dhlS7rSdYUJdSdTwmZO6a68/LiE8cpsgbeieirW
         ceYSj87IGiJFJswjky8IUmtMTLOcA9PTc56rn9eSnH+JA7p87IMHoxt2FrRLciIAeAJR
         n4CQ5SnbbQBoC2KsUowQ4TV1AfGRjfYPIt0kpEQi/mSn5MDjXBlsKCydHfS7Vo9Vlxve
         D+cGY7+tON1Kkh/a6eSCOiEP0JCcLJCjMVI1+4V5AQmdAEiReim2EqNXkA5gwPQzg96R
         XCf5AXZeK1kBaYmSK9884+J+/J1XDRzdvJB284Dm56YkRHoISgTGptFRM8Dvv9ZT1mk3
         dn9g==
X-Gm-Message-State: AOJu0Yxn0rS/zQvSNBpyU8qrSxAsQf9M1HX5ysEX7WRAA8d5FZtAT1rE
	TB9sqWV49Rc9UOIXzBQRsohN1zFtTqSk+irmWAxEs8S3ssuvNCnyQtm6DdGiFmkZsE/HoKBl/O4
	MKNk5rCwDTy+I9HG6VTENWWm1FiYzPekj6dFRKH46i+D34DBZc/l8opFg7EAOhWeqhzC6N5cKlc
	DgQO5MTPGCZb1eqq5MjVF1L/qHMNvgZidegd5Zr5uQhA==
X-Gm-Gg: ASbGncuZAZyVzrIJSMENDl6asHl3XVq6maQESCC3sRx4uBY/VO5PTQY8WG/MaT2dPEj
	MRCMIJT2nXpJxFe2IZL19MpQnU6u8g+9XuzeXotdDclIrSN41QufGGqWTtjpucK2LtOoGXaCe6K
	xINkeOz/l2uzT1Jr0257ItcOdgHDmG4OL2kcaeaowC9+6xrexdc/NrkfQFvVu028zYVrkc8L95u
	5L8gSbBAxaF882aHVgwEECfEU+pUWiQUbrdWFCwPpPX2F/njC5m6G5G2I58Z10tbqOwbLKsNOoN
	y4YASbUxCcCazHp1GmImVd4XwIRuS5PHC9WxcEM=
X-Received: by 2002:a05:6000:1869:b0:386:3213:5ba1 with SMTP id ffacd0b85a97d-386453e10ffmr3815869f8f.24.1733826597801;
        Tue, 10 Dec 2024 02:29:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE4tL+BSJEProxIsBDXYemaeIdRcoyVh5g8pjiVMDG9elzVPaoUP+MwbGvNobUYYHOAByApkA==
X-Received: by 2002:a05:6000:1869:b0:386:3213:5ba1 with SMTP id ffacd0b85a97d-386453e10ffmr3815841f8f.24.1733826597377;
        Tue, 10 Dec 2024 02:29:57 -0800 (PST)
Received: from localhost (p200300cbc723b8009a604b4649f987f3.dip0.t-ipconnect.de. [2003:cb:c723:b800:9a60:4b46:49f9:87f3])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-38621fbbc08sm15768883f8f.86.2024.12.10.02.29.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Dec 2024 02:29:56 -0800 (PST)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Zi Yan <ziy@nvidia.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Yu Zhao <yuzhao@google.com>
Subject: [PATCH v2 1/2] mm/page_alloc: conditionally split > pageblock_order pages in free_one_page() and move_freepages_block_isolate()
Date: Tue, 10 Dec 2024 11:29:52 +0100
Message-ID: <20241210102953.218122-2-david@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241210102953.218122-1-david@redhat.com>
References: <20241210102953.218122-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Let's special-case for the common scenarios that:

(a) We are freeing pages <= pageblock_order
(b) We are freeing a page <= MAX_PAGE_ORDER and all pageblocks match
    (especially, no mixture of isolated and non-isolated pageblocks)

When we encounter a > MAX_PAGE_ORDER page, it can only come from
alloc_contig_range(), and we can process MAX_PAGE_ORDER chunks.

When we encounter a >pageblock_order <= MAX_PAGE_ORDER page,
check whether all pageblocks match, and if so (common case), don't
split them up just for the buddy to merge them back.

This makes sure that when we free MAX_PAGE_ORDER chunks to the buddy,
for example during system startups, memory onlining, or when isolating
consecutive pageblocks via alloc_contig_range()/memory offlining, that
we don't unnecessarily split up what we'll immediately merge again,
because the migratetypes match.

Rename split_large_buddy() to __free_one_page_maybe_split(), to make it
clearer what's happening, and handle in it only natural buddy orders,
not the alloc_contig_range(__GFP_COMP) special case: handle that in
free_one_page() only.

In the future, we might want to assume that all pageblocks are equal if
zone->nr_isolate_pageblock  == 0; however, that will require some
zone->nr_isolate_pageblock accounting changes, such that we are
guaranteed to see zone->nr_isolate_pageblock != 0 when there is an
isolated pageblock.

Reviewed-by: Zi Yan <ziy@nvidia.com>
Acked-by: Yu Zhao <yuzhao@google.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/page_alloc.c | 73 +++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 59 insertions(+), 14 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index a52c6022c65cb..444e4bcb9c7c6 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1225,27 +1225,53 @@ static void free_pcppages_bulk(struct zone *zone, int count,
 	spin_unlock_irqrestore(&zone->lock, flags);
 }
 
-/* Split a multi-block free page into its individual pageblocks. */
-static void split_large_buddy(struct zone *zone, struct page *page,
-			      unsigned long pfn, int order, fpi_t fpi)
+static bool pfnblock_migratetype_equal(unsigned long pfn,
+		unsigned long end_pfn, int mt)
 {
-	unsigned long end = pfn + (1 << order);
+	VM_WARN_ON_ONCE(!IS_ALIGNED(pfn | end_pfn, pageblock_nr_pages));
 
+	while (pfn != end_pfn) {
+		struct page *page = pfn_to_page(pfn);
+
+		if (unlikely(mt != get_pfnblock_migratetype(page, pfn)))
+			return false;
+		pfn += pageblock_nr_pages;
+	}
+	return true;
+}
+
+static void __free_one_page_maybe_split(struct zone *zone, struct page *page,
+		unsigned long pfn, int order, fpi_t fpi_flags)
+{
+	const unsigned long end_pfn = pfn + (1 << order);
+	int mt = get_pfnblock_migratetype(page, pfn);
+
+	VM_WARN_ON_ONCE(order > MAX_PAGE_ORDER);
 	VM_WARN_ON_ONCE(!IS_ALIGNED(pfn, 1 << order));
 	/* Caller removed page from freelist, buddy info cleared! */
 	VM_WARN_ON_ONCE(PageBuddy(page));
 
-	if (order > pageblock_order)
-		order = pageblock_order;
+	/*
+	 * With CONFIG_MEMORY_ISOLATION, we might be freeing MAX_ORDER_NR_PAGES
+	 * pages that cover pageblocks with different migratetypes; for example
+	 * only some migratetypes might be MIGRATE_ISOLATE. In that (unlikely)
+	 * case, fallback to freeing individual pageblocks so they get put
+	 * onto the right lists.
+	 */
+	if (!IS_ENABLED(CONFIG_MEMORY_ISOLATION) ||
+	    likely(order <= pageblock_order) ||
+	    pfnblock_migratetype_equal(pfn + pageblock_nr_pages, end_pfn, mt)) {
+		__free_one_page(page, pfn, zone, order, mt, fpi_flags);
+		return;
+	}
 
 	do {
-		int mt = get_pfnblock_migratetype(page, pfn);
-
-		__free_one_page(page, pfn, zone, order, mt, fpi);
-		pfn += 1 << order;
-		if (pfn == end)
+		__free_one_page(page, pfn, zone, pageblock_order, mt, fpi_flags);
+		pfn += pageblock_nr_pages;
+		if (pfn == end_pfn)
 			break;
 		page = pfn_to_page(pfn);
+		mt = get_pfnblock_migratetype(page, pfn);
 	} while (1);
 }
 
@@ -1256,7 +1282,26 @@ static void free_one_page(struct zone *zone, struct page *page,
 	unsigned long flags;
 
 	spin_lock_irqsave(&zone->lock, flags);
-	split_large_buddy(zone, page, pfn, order, fpi_flags);
+	if (likely(order <= MAX_PAGE_ORDER)) {
+		__free_one_page_maybe_split(zone, page, pfn, order, fpi_flags);
+	} else if (IS_ENABLED(CONFIG_CONTIG_ALLOC)) {
+		const unsigned long end_pfn = pfn + (1 << order);
+
+		/*
+		 * The only way we can end up with order > MAX_PAGE_ORDER is
+		 * through alloc_contig_range(__GFP_COMP).
+		 */
+		do {
+			__free_one_page_maybe_split(zone, page, pfn,
+						    MAX_PAGE_ORDER, fpi_flags);
+			pfn += MAX_ORDER_NR_PAGES;
+			if (pfn == end_pfn)
+				break;
+			page = pfn_to_page(pfn);
+		} while (1);
+	} else {
+		WARN_ON_ONCE(1);
+	}
 	spin_unlock_irqrestore(&zone->lock, flags);
 
 	__count_vm_events(PGFREE, 1 << order);
@@ -1792,7 +1837,7 @@ bool move_freepages_block_isolate(struct zone *zone, struct page *page,
 		del_page_from_free_list(buddy, zone, order,
 					get_pfnblock_migratetype(buddy, pfn));
 		set_pageblock_migratetype(page, migratetype);
-		split_large_buddy(zone, buddy, pfn, order, FPI_NONE);
+		__free_one_page_maybe_split(zone, buddy, pfn, order, FPI_NONE);
 		return true;
 	}
 
@@ -1803,7 +1848,7 @@ bool move_freepages_block_isolate(struct zone *zone, struct page *page,
 		del_page_from_free_list(page, zone, order,
 					get_pfnblock_migratetype(page, pfn));
 		set_pageblock_migratetype(page, migratetype);
-		split_large_buddy(zone, page, pfn, order, FPI_NONE);
+		__free_one_page_maybe_split(zone, page, pfn, order, FPI_NONE);
 		return true;
 	}
 move:
-- 
2.47.1


