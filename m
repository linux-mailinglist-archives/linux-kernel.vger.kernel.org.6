Return-Path: <linux-kernel+bounces-560037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12C6EA5FCE8
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 18:02:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B838F175DA0
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 17:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 150D626B081;
	Thu, 13 Mar 2025 17:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="npYIFgEt"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE25E26AAA2
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 17:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741885287; cv=none; b=OOz7NGpo7UcdC71N0syE9MFMYMcdgRhPpB/4o5FJh/RAnsos4LPBUB1IwtD0Jwjx4h4AXQJ1z/P7dWQSF1xTbNzbGxmqtnjmdANOS/+2NFub/AgS7GLFeL6d2DBDQiQSL+FqdHpyJuZ1wvfJMITmGN5GlPd/tunAPwE9mwWQGzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741885287; c=relaxed/simple;
	bh=NFp+Q2uV9XDHr257rWXEdLfhEuoHWCUowjBWvgSEjKc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J2ZQmyN2bBISE69jj7i5tLeDF15tHdR6LP+w4RAkyHS/2A+su4t8s4xxQ/ibJoJ3q0T6j9l4rky6gcCTssyVRmLlFPYapFilRiVazNaaHnQKeRu6lBnvFpnMYVHkc8pRHaNsxGliUQXIKzH8MgamzVDl2Ts4NU3UeFQYd1aWe3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=npYIFgEt; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-22337bc9ac3so25561525ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 10:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741885285; x=1742490085; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CBQw+jqSF0UF2k99azwHt4J3S+nAnROIiT87OqHHQ/M=;
        b=npYIFgEt8vmNJF6mKAXSqOpJhbumUFhDMxYfNS4g5amQ3HVIzchbuLC27ia3e7eWNu
         UppE7lMzPGScTvVJ9kwEP2JObeLSCms2I2f1PK1nuwiA07b1r0ACPIcPjaeH+XhUBD4x
         2pKwCVriG0VjHNEg6uoiC/uu0tr1V/N6CiL9ahR798wc4JSw+DXNIZ2YirlsBnl91c5R
         307G/h9w8mQ1j86CwW4XeTcEUcCGQi3XSeR7gpdv9LJ7jP4GGSqAC+wek83aqGLsAMx+
         9sVqaCm5TALCvi71CiEKQHE1XAmWbumFvWYvQPeqq4EoBuH2yA4S8mbERwfTT4bhMYMt
         zOXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741885285; x=1742490085;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CBQw+jqSF0UF2k99azwHt4J3S+nAnROIiT87OqHHQ/M=;
        b=qDhggab2MwSCkQZwzfIyMOvLGi2aFH7AaoTyypFQIEIi69/3Ix/fiWelS2vH98S3+D
         HAy+i1l/lrGb6aFWLjQT+ku9JoqwPSGvclE5+xswU2UJbUGD8S4xjxisHGEpa1eghRx1
         BIcpnYuzg7Akh7Zdd4SMQwg5QdxBeHxRaMYUqyeWrBE8wAK0z0eQ7Zu+JM/a4BmO8E0a
         u21p6XJAAL7a5iKH+/rUfVwVMx1MxZUDEVZqpHjVFL1DNhBOu5Ti1UhypBpeFwL0HzCh
         GDDcVZkUa7JUABa6CeGHVJyN4GdI7X+2W0DfZLYCAOp/GF6P0Dng2WXtAOoaVEgprqlS
         GSMQ==
X-Forwarded-Encrypted: i=1; AJvYcCVwWwE9HDAldRyckJlgwryhNSHj61YI2FT3VsZJ8DNbdcyQw3ZwL06QFUJumSEGfPEoedsI00i3HEatWGI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxX4dxKfblueYtDkQgqyL06yI7xdkw9YxNhECgh2gfEk63DKLWo
	OztuAzsaIuNu5gntOrwXmFJqJJYMo8nWZTuXEbayn+8ZTC6gbb4p
X-Gm-Gg: ASbGncvvtnbmrFgJ62FHx96dxJOWuJe0FScGKEhCufHTNtK0z+6SPqLAJZQRW5RniG5
	e21V0nITa30l19eaOHAtrUFrbPpu1xGPHtLXnApg8zV3Lzn0E1lI1lxjTPuA0fQ0JrIFb8SA2+E
	l+9WCJkdS3Zmw+zgbrb8UNEWnj0vQMPoqXK3m5ZPxudm1EPDepO/ifuFie0uBd0haFVNUnue7nf
	PzIViUNvgWZSp3RNfgTnOGKF069UmWVKLY/iBiDm22utSlfpm9TSHWbPKX7WNJZnHPRquS7ABk7
	2Cl8rwS6e09/u0hKDhXG7fsi4ARpCT1vT4YpEPNSAKE9mNoNEiOzblffG8egN/VdRL20AXub94i
	D
X-Google-Smtp-Source: AGHT+IGt3mQfnAVqFY2K3f10aCR6eUv3elLxAx9cwot21o1/wrOdRjDlzZvktfS1qoxjfYK8Kmbx8g==
X-Received: by 2002:a05:6a00:88f:b0:736:ab48:5b0 with SMTP id d2e1a72fcca58-736eb7b2f97mr15996283b3a.2.1741885284743;
        Thu, 13 Mar 2025 10:01:24 -0700 (PDT)
Received: from KASONG-MC4.tencent.com ([106.37.123.220])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7371167df0esm1613529b3a.93.2025.03.13.10.01.19
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 13 Mar 2025 10:01:24 -0700 (PDT)
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
Subject: [PATCH v3 2/7] mm, swap: drop the flag TTRS_DIRECT
Date: Fri, 14 Mar 2025 00:59:30 +0800
Message-ID: <20250313165935.63303-3-ryncsn@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250313165935.63303-1-ryncsn@gmail.com>
References: <20250313165935.63303-1-ryncsn@gmail.com>
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

But now we have already removed slot cache usage on freeing, so this flag
has no effect now.

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


