Return-Path: <linux-kernel+bounces-529754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DB57A42A90
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 19:03:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91A287AA28B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 18:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C474B265CAB;
	Mon, 24 Feb 2025 18:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k7ZLOxlb"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94102265CAD
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 18:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740420180; cv=none; b=bcYVueU8CRZJPm7LKjy1hvBGBKpfXeTPxL5sn//ZQA27+I5IbFqw6HqQFIeXWpAQbj7AuniqMQb3mcQRhrNqq1OTFjo4McXYaozf7oK6C2J/nViyGow1JE76Ln+TAeLhpxq24ked1Av1yG5c4N/rWenbyKuvhrFaM+KHU/82oy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740420180; c=relaxed/simple;
	bh=p1n4Qyp/95Qy6I9u2yFOetoChLo/IYiV09Xs8fzmKP0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m5znLvA4X1kP4A0dtIX1m3XiS2O7zQtYGVC1kz30fj78st7RMg1GYiCzvjbfD2Q5wqvFTn7w+7ZFjUQNpeZpBl6PFqUqtIWk9MAhJQYg0tR8S8nCJFrgj3o2XIKTSYAAV9hPjzCbSVisEjiGMLsf5EWVWprVF0Hf2L0VwgBvmHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k7ZLOxlb; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-220c8f38febso100586525ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 10:02:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740420178; x=1741024978; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QRxfoQL+pBTLKNCpBu9kbqbY4X297q/ZVa8ZHPjqplw=;
        b=k7ZLOxlbR6Z9okjkPwE9lsF9YDRcEmHq38k5nTQv8pNBRpiR73nUdCxEdTR4zwpjs/
         B8W3Z4YEYZiOIcPRD5KMdKY5W0C4hSCgNj4uNm9/1TlCIbqakiFCqYfDOlgwyjvb7FGZ
         T/TomqU9qjaP36EaF9WabUHdjGRXqxbBv1Jo+CXUikJ/o2bA3zCmbgHkXa2RzzLZArt2
         fs0x4Enmm7PFUsMLfsHbe4DHAKq8waZ+1JATOsobyYBSLXa/YN4GsuOSW/AsF2e7ic2Z
         8ga/kfZAVjgAlZN22FE+dOOmz4e7EDvQ95fDJbdmWMVLCLJ15QlC4135JK1BGVBZuY2B
         gKGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740420178; x=1741024978;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QRxfoQL+pBTLKNCpBu9kbqbY4X297q/ZVa8ZHPjqplw=;
        b=KYwnmBFMcZo0zqEc1eiiKb/NjLt58loIxHrMcCj7nYUUQsPd46whHsNduLunoCjzHh
         GSHvfwAl2KmzhCJfopuwys1RZZCf8WlKG6v8iHMKYcMdg/f7jBRKMBXWaxpIivBLyF0l
         GSerHVx99JTcOG2uyoiRf9v/0N5gOOJ3K9/rDeAz78Fh1UjiybDY07BatRaB3ym/numI
         I/vUra1ZCrpVdiNlZZ/fx1zKf10uOisXUBhuOKcrOJNsio7kaYjUxePyU8e6+6fd+kKZ
         YoumB3AH0kxpW/C9tjchJNVmL1c08kdVCwndXam4EpHu8GzZob+4HUDmNO3bTmNcx75K
         +ddg==
X-Forwarded-Encrypted: i=1; AJvYcCUHotET50lUwbB5zDXkYrLRld8GiyqcBhmhsIPJRen8vUjq2tnb85Fbgw88r1O5Exf+R7ACUIhhGRS82Qo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOegcfrRfAof/AtIj35Eg5HITrqsSUUOeBwESg98eh1zxiVAEj
	x3jXWYU0H4MW1lh78yXEnygUELeJ/RB9BXZTlPWAL+JWobZbEPuq
X-Gm-Gg: ASbGncvnFos/jTsgK7+PBUnAMZ3Bf2cwshgjkVsvSVmu6v7MrOdFJ91DdbPWFDoYGKh
	albljXenO3ebD9SfM71LqwLvWlHsHkulaGHC6WT1e406LCOJwJzJYFGUXgEVnq4SRkmVtibpPU8
	xB+UNG5vCjTQ2uE8tWU64iNUeqZKV7Tz48RZylsYslG6zztF+xy7VzaXw33s/83oXTOJHAXvhhD
	gwRT5yM+xKRcbRdR2RnMHpp2JYZCWP7yQgx8yPgE0DSw5WnAXD6Inm5+EmtUv9LO2UtqxbEMEOK
	UngqtHvl3YwgOycOn3T1xk4Q/kKWJRfrhnuXKmQr3zzn
X-Google-Smtp-Source: AGHT+IH2vkZ4qNq/k2BTmYvnntomhPccNa7QFOZ5vqVX7VxUA99Ns1FNfhFZfIv+cr8MOTzBlLBrlw==
X-Received: by 2002:a17:902:d2cd:b0:220:c911:3f60 with SMTP id d9443c01a7336-221a00260e0mr232172315ad.47.1740420177678;
        Mon, 24 Feb 2025 10:02:57 -0800 (PST)
Received: from KASONG-MC4.tencent.com ([1.203.117.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d556e15esm184834695ad.190.2025.02.24.10.02.54
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 24 Feb 2025 10:02:57 -0800 (PST)
From: Kairui Song <ryncsn@gmail.com>
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Chris Li <chrisl@kernel.org>,
	Barry Song <v-songbaohua@oppo.com>,
	Hugh Dickins <hughd@google.com>,
	Yosry Ahmed <yosryahmed@google.com>,
	"Huang, Ying" <ying.huang@linux.alibaba.com>,
	Baoquan He <bhe@redhat.com>,
	Nhat Pham <nphamcs@gmail.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Kalesh Singh <kaleshsingh@google.com>,
	Matthew Wilcox <willy@infradead.org>,
	linux-kernel@vger.kernel.org,
	Kairui Song <kasong@tencent.com>
Subject: [PATCH v2 2/7] mm, swap: drop the flag TTRS_DIRECT
Date: Tue, 25 Feb 2025 02:02:07 +0800
Message-ID: <20250224180212.22802-3-ryncsn@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250224180212.22802-1-ryncsn@gmail.com>
References: <20250224180212.22802-1-ryncsn@gmail.com>
Reply-To: Kairui Song <kasong@tencent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kairui Song <kasong@tencent.com>

This flag exists temporarily to allow the allocator to bypass the slot
cache during freeing, so reclaiming one slot will free the slot
immediately.

But now we have already removed slot cache usage on freeing, so this
flag has no effect now.

Signed-off-by: Kairui Song <kasong@tencent.com>
Reviewed-by: Baoquan He <bhe@redhat.com>
---
 mm/swapfile.c | 23 +++--------------------
 1 file changed, 3 insertions(+), 20 deletions(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 5618cd1c4b03..6f2de59c6355 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -158,8 +158,6 @@ static long swap_usage_in_pages(struct swap_info_struct *si)
 #define TTRS_UNMAPPED		0x2
 /* Reclaim the swap entry if swap is getting full */
 #define TTRS_FULL		0x4
-/* Reclaim directly, bypass the slot cache and don't touch device lock */
-#define TTRS_DIRECT		0x8
 
 static bool swap_only_has_cache(struct swap_info_struct *si,
 			      unsigned long offset, int nr_pages)
@@ -257,23 +255,8 @@ static int __try_to_reclaim_swap(struct swap_info_struct *si,
 	if (!need_reclaim)
 		goto out_unlock;
 
-	if (!(flags & TTRS_DIRECT)) {
-		/* Free through slot cache */
-		delete_from_swap_cache(folio);
-		folio_set_dirty(folio);
-		ret = nr_pages;
-		goto out_unlock;
-	}
-
-	xa_lock_irq(&address_space->i_pages);
-	__delete_from_swap_cache(folio, entry, NULL);
-	xa_unlock_irq(&address_space->i_pages);
-	folio_ref_sub(folio, nr_pages);
+	delete_from_swap_cache(folio);
 	folio_set_dirty(folio);
-
-	ci = lock_cluster(si, offset);
-	swap_entry_range_free(si, ci, entry, nr_pages);
-	unlock_cluster(ci);
 	ret = nr_pages;
 out_unlock:
 	folio_unlock(folio);
@@ -697,7 +680,7 @@ static bool cluster_reclaim_range(struct swap_info_struct *si,
 			offset++;
 			break;
 		case SWAP_HAS_CACHE:
-			nr_reclaim = __try_to_reclaim_swap(si, offset, TTRS_ANYWAY | TTRS_DIRECT);
+			nr_reclaim = __try_to_reclaim_swap(si, offset, TTRS_ANYWAY);
 			if (nr_reclaim > 0)
 				offset += nr_reclaim;
 			else
@@ -849,7 +832,7 @@ static void swap_reclaim_full_clusters(struct swap_info_struct *si, bool force)
 			if (READ_ONCE(map[offset]) == SWAP_HAS_CACHE) {
 				spin_unlock(&ci->lock);
 				nr_reclaim = __try_to_reclaim_swap(si, offset,
-								   TTRS_ANYWAY | TTRS_DIRECT);
+								   TTRS_ANYWAY);
 				spin_lock(&ci->lock);
 				if (nr_reclaim) {
 					offset += abs(nr_reclaim);
-- 
2.48.1


