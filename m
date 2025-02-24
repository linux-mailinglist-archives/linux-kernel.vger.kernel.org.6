Return-Path: <linux-kernel+bounces-529753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 536FAA42A8F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 19:03:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69939174AEF
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 18:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC13326562A;
	Mon, 24 Feb 2025 18:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KBdfQgaG"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E2B8265603
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 18:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740420176; cv=none; b=g1j6gEgqffIvFvrZdd6ccAFS8Qs9yk+BOaNMN4XPEVAk82ol1eeJ0sTaqc0cQjtI6hwpBeZYxkr8g6YyRTBMzosep5bshJBjw6qsszkWGo/kI/mQTW/vVsUtAyK/MBI6ffSQjfnTUHOnwmBh63hiBqrC2hahUuDAjNpzJ44WrNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740420176; c=relaxed/simple;
	bh=+73Mwgn0zfHYZeYevkhdnQ9HGxEviarda0EUfAnj/Hc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EaMmJ0mKKgd32+GxOq4VpeKDx1EUOf7FmJ4BZ/GrkwjduZVsNz6O8+tMWo079F2jHPcyNe2AnL6ufqRRecmJIXjgArk1Mh0s/+Fhlek0WzP3gvNZJ+ZAQLlmbO3aY2H211iLEylNPtrkCIHZTSjuXTpYeNyRg0QIwpo36NH0Syc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KBdfQgaG; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-22185cddbffso96388925ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 10:02:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740420174; x=1741024974; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xwT//N+9nfh7P5Px11klS6FaPMqYvLp+fVr/05Baw3w=;
        b=KBdfQgaGLaO7NtHUYMr8TnZV0/F6zrG7sNg3yDtPSWRhFriY2Ljo783DnES8jM6UXX
         tGGaxn095NxJjSKvgfYIzVlk0a6zt3vkH2PuzMsJA7kTX0qMxpiaRtBQOA2jAFS2+DTh
         nbaQ/kd2nRb8U+FpRjSM061smgrj5A1n8kwaSodUkY2Tbscg7mJQyRf0SsknQsuUS+yT
         XHKYobW1r5W3YOZt0lTx8Wik5Lwk9sBkVNBwaTLJGjmTSNQFpEtpPuVdVigdu2edYd67
         gqoYkgDU0x2t8C6Luik7MWe3PdAEq3/cn6UnvT4QzrRS4JzgQZFaabT4REP4WRuBSSM4
         mxJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740420174; x=1741024974;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xwT//N+9nfh7P5Px11klS6FaPMqYvLp+fVr/05Baw3w=;
        b=i1/OMxfrw/eHH6kI17ljwijbHuSrAoZXo51In2nvGDZHGz/ADtmFlNSGTzn0J1TMAH
         IOLddsd4ofgEZ9W0AJR3qcnrmFnaSErwk2H5QtGJvhyoP7KItyttIdgHPKL3NayPdDf6
         WN6WXtFrcM4t22NzaUsemnhPABUT5CVzJJBw4kwFnhx1gVx2tNOtN1KtbnTJXL6G6sy/
         +LR2spveAutvWcbmp+0qsI2bWW2iiHa5PMtGG0VNI20Z6P+6yWRio4UWTqlTrF5DM6Xj
         K1IuWtz0Ye87uPOkukD9aqcm8LNTGPjDfEZSBP/RzibqnDDQdv4W73wUr81i2WAF9QJh
         MT+g==
X-Forwarded-Encrypted: i=1; AJvYcCWBf0Kz+IglatFN3EyT58cI6EJXzFCX6SeJ5lyTRLhsmkn8hdiDhnqSMNfBDHE5dy2n+kHwMVS9RgGakZI=@vger.kernel.org
X-Gm-Message-State: AOJu0YznVuKgZIXyVGoeV1OrBWRVMNQBYgjS2xUZP5PBO3VKunwentMO
	izE9zULpIVB9hiVZhNiXqId/0Aq0syiv59FYa/kJX+gp11j1JtiA
X-Gm-Gg: ASbGncu0qZjgvtcyNY04YTXAxGPrkbR224bF0gyGJ6rOYAJzdp0IOCH/2BQlRoIh1K9
	4eBXHm7N9x6liEmKmjxmVdpMq0nAFvADG3hVUiWP9L0ofU+pC4BR9Vdk3Gq6bscu4oeiZEku9EZ
	OAbFUGmvlVwgUc37kSDRo0KIusnB8Ey78wUxbPrWTdyo9pnO4Rhpp0eI7DAAxD+Z2VfnNwSvyQW
	SkEYuutR7imwImphnZbEx9E5lc6pRUMjq+OjKaHipCtO+533eDzZ+CgggYvkBAMQSUobp5SmZIj
	VLfELrhpQRu5CKVWCljVAtDzKOc420Exi2JGZgTwF9yE
X-Google-Smtp-Source: AGHT+IHg1obCVKFszbKO58ucl3S2uuTMPf5zZW6roBu4cVs9S04wje26rUs4hychmcu7wQV7//msbA==
X-Received: by 2002:a17:902:d2c1:b0:21a:7e04:7021 with SMTP id d9443c01a7336-221a001fb74mr213193225ad.24.1740420173812;
        Mon, 24 Feb 2025 10:02:53 -0800 (PST)
Received: from KASONG-MC4.tencent.com ([1.203.117.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d556e15esm184834695ad.190.2025.02.24.10.02.50
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 24 Feb 2025 10:02:53 -0800 (PST)
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
Subject: [PATCH v2 1/7] mm, swap: avoid reclaiming irrelevant swap cache
Date: Tue, 25 Feb 2025 02:02:06 +0800
Message-ID: <20250224180212.22802-2-ryncsn@gmail.com>
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

Swap allocator will do swap cache reclaim to recycle HAS_CACHE slots for
allocation. It initiates the reclaim from the offset to be reclaimed and
looks up the corresponding folio. The lookup process is lockless, so it's
possible the folio will be removed from the swap cache and given
a different swap entry before the reclaim locks the folio. If
it happens, the reclaim will end up reclaiming an irrelevant folio, and
return wrong return value.

This shouldn't cause any problem with correctness or stability, but
it is indeed confusing and unexpected, and will increase fragmentation,
decrease performance.

Fix this by checking whether the folio is still pointing to the offset
the allocator want to reclaim before reclaiming it.

Signed-off-by: Kairui Song <kasong@tencent.com>
Reviewed-by: Baoquan He <bhe@redhat.com>
---
 mm/swapfile.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index a7f60006c52c..5618cd1c4b03 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -210,6 +210,7 @@ static int __try_to_reclaim_swap(struct swap_info_struct *si,
 	int ret, nr_pages;
 	bool need_reclaim;
 
+again:
 	folio = filemap_get_folio(address_space, swap_cache_index(entry));
 	if (IS_ERR(folio))
 		return 0;
@@ -227,8 +228,16 @@ static int __try_to_reclaim_swap(struct swap_info_struct *si,
 	if (!folio_trylock(folio))
 		goto out;
 
-	/* offset could point to the middle of a large folio */
+	/*
+	 * Offset could point to the middle of a large folio, or folio
+	 * may no longer point to the expected offset before it's locked.
+	 */
 	entry = folio->swap;
+	if (offset < swp_offset(entry) || offset >= swp_offset(entry) + nr_pages) {
+		folio_unlock(folio);
+		folio_put(folio);
+		goto again;
+	}
 	offset = swp_offset(entry);
 
 	need_reclaim = ((flags & TTRS_ANYWAY) ||
-- 
2.48.1


