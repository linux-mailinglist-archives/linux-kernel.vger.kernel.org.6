Return-Path: <linux-kernel+bounces-529756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B0DC6A42A92
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 19:04:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 590D97AA935
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 18:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BDD4266196;
	Mon, 24 Feb 2025 18:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iaNFLy0N"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F93526618C
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 18:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740420188; cv=none; b=CrqQ6vKCW+PtcLi1QXuVnycLyTekYtO6ppLDLPEfmIftdiR130JzJnmuoWdfVc+vq2wnPKf2A53zEoRh8uWK5yRy1E/WTLG+hWRJL/gA9TWJJG08IOa3k6B0spIPdbUFr1B7HMMjCXfeGqvV9g2fWjIjBnKU7ccWDF0+4unKZMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740420188; c=relaxed/simple;
	bh=5V8CRRxEKwAvlne0up0DL89xDRbM4OY8DNb00/7ZeuQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qF40iWXrIJ2fwWNqJsOEXyv2FRAVSQPef+f/ZgoSvbUYVW5PorSRkrSOV9EM94oR/JiEWy54U8TkLKn2Ptl832Uy4QDKRwhAglVTkDg2NGIalnL8SdN83ziQN4S/j2BmOAe1hWkpkGH/znxseeE8kBEoCsYFlXuKvEMcgLvyrQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iaNFLy0N; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-220c92c857aso81040795ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 10:03:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740420185; x=1741024985; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XyR+PRc/eBOLkBnPi/9fuJnUVozTaiV4/upc2f3YPZU=;
        b=iaNFLy0NPfFmaM8jG7VdBO2McQ9kKsJO+uHgYTgWGCjcYMtPZo1zTJNSm8OsmoNiD+
         r0CYUW+7TS60DsPPhBhMrQqcboIkyrvBplbfV2ZmV2ANH1RMsWpwUm23IPbdRcttbVBo
         1r+kz2s7bvgDL4aq+pZAm75gcGoXBqCIgXxK8xSqi0CLpN3sRcjwCBE6lXcL4aP5O/c4
         HKRz8+w1x0PhaYC+WZ7vAc6/Ie/gmc10dqw6Ryeay81KCvuIg1XIV1wF/qlfFmstzCij
         RfLzjMl1EeINwU7YQv1O1JlRuIz5MZF9BxkDDSQxti6+62EM5UOs5Th9NBMv9k0t0p5m
         82qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740420185; x=1741024985;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XyR+PRc/eBOLkBnPi/9fuJnUVozTaiV4/upc2f3YPZU=;
        b=CP/C29vsjhXHsKPeSQhwYj2U+lc1rqUL8dqU3WiIW+Ctjq+Xsu+LYos52yaNzy99ri
         wbSysM+lRi0MA95T2tFbD3A8fUwX97YhnFQ9reQzN/tagmLP7BabUfcxdNS3ETVXm7Hw
         ldaKBp7X1hk6K2Qly2RiTdEBvPgI5Zzq7de0Vn/BNR++lDnYhtjR9Dihz1mHeKbsZGug
         774dUa6TiPwPenp2HzzDZkgwYvPmKTSp9oyZW8tyH8U2ef32QRtVd2ZDcoz7pJ7kwVCZ
         KAFc+K6BGET10x1mon9zS4O7h+fOvsvuiFKpjjuUh/htXePQtr8DD2m4lSWQx4EVxwCz
         x3Ng==
X-Forwarded-Encrypted: i=1; AJvYcCVS7yEfCxKreEgjk59IVquM3diklS9zy4VkatO1qcqSbUGnvD5cakylE7f3LGphVWGLExlKSns4EK0Zqmk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUS6iITMsCY2paO7NdW0wOmP4rZfsEF7LeO7nn9nqKLMgChatY
	ifaotsUFDoh6P5n8QUcI/G3r1xXYafNdu8HNMRdgDgL1gr5rZDeH
X-Gm-Gg: ASbGnct9UlNSAk613qQ16+BwExbjP0YhInUfHN49/8s7mHDdupSRizceekrYZ5J64Bw
	z9LDBddLQ5qv0qGD0czbRKaM+D9o7rmvnqkPv1Z9++i9+lMCYJZe/3ThMSK6Y6by1mre/15nu5R
	sfsRBsxvbDQGxRns5Sq/LA/IdwccgAXcpS3i9gK20e/3W3DVGCBh5iUmCXkKDtrI0TWL17F3Y4E
	xH9aYU90E96JimIhWlRldl9a2hh7TAGdJ/OnhCbwc27r9IY0pZU3K8gYmDeUWPkKUYBh6VKlN8G
	mblUj5VDoDwChG9IEMxKlLNHVHeK0sL9gRxGXj9LuTsT
X-Google-Smtp-Source: AGHT+IEWFKdxJ4VlDrM+6lJej0/o+uztgn5SKjZ2meUIah0cwkjkOUeetzc3bGXlgudO6SvyG97xhQ==
X-Received: by 2002:a17:903:2312:b0:221:1eac:bf7a with SMTP id d9443c01a7336-2218c765b1amr310546725ad.24.1740420185393;
        Mon, 24 Feb 2025 10:03:05 -0800 (PST)
Received: from KASONG-MC4.tencent.com ([1.203.117.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d556e15esm184834695ad.190.2025.02.24.10.03.01
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 24 Feb 2025 10:03:04 -0800 (PST)
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
Subject: [PATCH v2 4/7] mm, swap: don't update the counter up-front
Date: Tue, 25 Feb 2025 02:02:09 +0800
Message-ID: <20250224180212.22802-5-ryncsn@gmail.com>
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

The counter update before allocation design was useful to avoid
unnecessary scan when device is full, so it will abort early if the
counter indicates the device is full. But that is an uncommon case,
and now scanning of a full device is very fast, so the up-front update
is not helpful any more.

Remove it and simplify the slot allocation logic.

Signed-off-by: Kairui Song <kasong@tencent.com>
---
 mm/swapfile.c | 18 ++----------------
 1 file changed, 2 insertions(+), 16 deletions(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 6f2de59c6355..db836670c334 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1201,22 +1201,10 @@ int get_swap_pages(int n_goal, swp_entry_t swp_entries[], int entry_order)
 	int order = swap_entry_order(entry_order);
 	unsigned long size = 1 << order;
 	struct swap_info_struct *si, *next;
-	long avail_pgs;
 	int n_ret = 0;
 	int node;
 
 	spin_lock(&swap_avail_lock);
-
-	avail_pgs = atomic_long_read(&nr_swap_pages) / size;
-	if (avail_pgs <= 0) {
-		spin_unlock(&swap_avail_lock);
-		goto noswap;
-	}
-
-	n_goal = min3((long)n_goal, (long)SWAP_BATCH, avail_pgs);
-
-	atomic_long_sub(n_goal * size, &nr_swap_pages);
-
 start_over:
 	node = numa_node_id();
 	plist_for_each_entry_safe(si, next, &swap_avail_heads[node], avail_lists[node]) {
@@ -1250,10 +1238,8 @@ int get_swap_pages(int n_goal, swp_entry_t swp_entries[], int entry_order)
 	spin_unlock(&swap_avail_lock);
 
 check_out:
-	if (n_ret < n_goal)
-		atomic_long_add((long)(n_goal - n_ret) * size,
-				&nr_swap_pages);
-noswap:
+	atomic_long_sub(n_ret * size, &nr_swap_pages);
+
 	return n_ret;
 }
 
-- 
2.48.1


