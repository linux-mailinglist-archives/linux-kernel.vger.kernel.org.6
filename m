Return-Path: <linux-kernel+bounces-515458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2891CA36525
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 19:01:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CBA81899303
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 17:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89F7A269829;
	Fri, 14 Feb 2025 17:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ahq49GGB"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC3C2690CA
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 17:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739555924; cv=none; b=nrgUmaJvtkgHKJITdEVu2Hg37OmA09AhAfYANfzHvYWOP8WTy6QqLhZES81mm4pGqX18LVsiAFzJi+JTSayVfdgGAnsRqhltC+3oE1IcZAI0krRVOVb2EJmlgNkzjsgBw4KszypApf/nPErk9seoHVyH9pOyl5mjXSFwv7VUqrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739555924; c=relaxed/simple;
	bh=P1p2DBstkV7u3NrrbXOQ8L3JsE56K0gM7QEH7jio2EU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qAYG7P9KNA0pPCXrpPIPGQLRhoOCZQRJHWP4xgp0svl2Y5lcSjW9MaVwAwDmlDvfwfu/idk0fJqPP1xgMMxyXv1Z6s0r7EPVLcNE9k8QOH0xSDltLC+jktB+SoDHyRpk/YWmVY622c5X8iaj6FaLFl550JrSX8G1hPlMr8AAp1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ahq49GGB; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-21f44e7eae4so45771865ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 09:58:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739555922; x=1740160722; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=J7iAvbK5JG/d4lmxGQvSkQ18V+/XQNNBtKhwiIbpkLY=;
        b=Ahq49GGBQknk8vVa8nOsxf9cbFBaKooRucOEDlhT8s8AjfKyrRniSvNMlK5q8kP9lr
         18QKDU0QaLu+cKzC3SLDhYofdmZ8ytRlpzEUHjkgKXmd45ZuEmcHYEZx+6JFNrlpoGHF
         f0dsW2nKHL48RTgD7uPzProxugbMx33flszgoNJe7wghwX0rY96AHiNM839IVgF8C4Im
         0NeV5awAaUOSjWtWMg0PvCXzZKPbtgiMf3Z6JVbG41MnZQ5dEqrIUVHSzFqGE5Tqjzgw
         ZNKYoCWOSgzhx1YxYC973gOXtXG2YoMBRNdbAkcngKl6u3YfQmrw0yyytK+FAZrM6dmt
         V+oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739555922; x=1740160722;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J7iAvbK5JG/d4lmxGQvSkQ18V+/XQNNBtKhwiIbpkLY=;
        b=guAwiTRsGVfDZXGZXWQOvL8yyyLx7kBIuk0bbAPp8LhABHB68Fsz2YOT+zAbTDV6el
         1vVM5vIbIncrhw1nskjSXsJzAMbUIJscvOc5hhPCZHzIvPiP2TRC8ZKipfSgRmRtq94p
         S8l3DxCR+W9LfJq7pUKzU8/QlyFsNTfXsu1OLa28xPlphBvZaVuFe4qv8BfDhB70/tMr
         QJubUvNHv3cKaxfXM403JaqYR2B77BDT+NJGjzyDtdTmtBQtrM72v1tq9eb96b1X/zxL
         TwpY8H024vy0Q3aJiKXOhI8LJ0ec8s9HGDL0LaS8xa+HOT1Zo1UuEaHDgGm8ylUuAuPp
         0zww==
X-Forwarded-Encrypted: i=1; AJvYcCU3hTPD8lVJi5RMDeRWuRUDI8vxcEnG4co08ACabvbtfJm4JYHbMWRVATMEraFG/DnQYW+pTBYsQvUaj9Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6hABlZT/kgdsS/rqu5jEAtk9JrfP1T76BD49qh5ctmh40yRHN
	Pje06hHTE/qhlRBNDfDxHHu6Qne/VUAhMBjJMj/G6lNKODc9JJzv
X-Gm-Gg: ASbGnctZMnCaHM9BnPZooViRWdApg9YdYW3GXEC/QXG9mImffnmL/BbYK2mlUz0klR5
	qlmvXUKl28lRSTR9Crcyq7um8w+FNi3yIPPyr9w2cSYtg4SwVerP4cFi8HzaXTUSMgf9/wwt+pN
	pUJZhSvrAIT21vbUGjbNrI6uqx5HOM2nmyLAELwBSDCCntOysaQgYh7ypiuJmWRSFgfJIa+qAkv
	faZCIyJObfSSHam3pyNTXFew/+oaIIzcZoz9Sz4woKwFeDJ+2sn+/CfEXee6FX3qrPHDT4IJrfq
	PwgIfJ5SOkRvus6Q/N30eFB15fQiiueX7vjJ
X-Google-Smtp-Source: AGHT+IH9ha70sbHLOmBa5PHjMDHnw1Ok3lpm5sqNiv2eKZSkk6HsPl/5KsZl/aumE/hwSF+8y4tPBg==
X-Received: by 2002:a17:902:ea11:b0:220:f4db:98b4 with SMTP id d9443c01a7336-22104012399mr3146705ad.24.1739555922552;
        Fri, 14 Feb 2025 09:58:42 -0800 (PST)
Received: from KASONG-MC4.tencent.com ([106.37.120.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d55943b5sm31216605ad.246.2025.02.14.09.58.37
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 14 Feb 2025 09:58:42 -0800 (PST)
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
	Kalesh Singh <kaleshsingh@google.com>,
	linux-kernel@vger.kernel.org,
	Kairui Song <kasong@tencent.com>
Subject: [PATCH 4/7] mm, swap: don't update the counter up-front
Date: Sat, 15 Feb 2025 01:57:06 +0800
Message-ID: <20250214175709.76029-5-ryncsn@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250214175709.76029-1-ryncsn@gmail.com>
References: <20250214175709.76029-1-ryncsn@gmail.com>
Reply-To: Kairui Song <kasong@tencent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kairui Song <kasong@tencent.com>

The counter update before allocation was useful to avoid unnecessary
scan when device is full, so it will abort early if the counter
indicated the device is full. But that is an uncommon case, and now
scanning of a full device is very fast, so the up-front update is not
helpful any more.

Remove it and simplify the slot allocation logic.

Signed-off-by: Kairui Song <kasong@tencent.com>
---
 mm/swapfile.c | 18 ++----------------
 1 file changed, 2 insertions(+), 16 deletions(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 449e388a6fec..ae3bd0a862fc 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1208,22 +1208,10 @@ int get_swap_pages(int n_goal, swp_entry_t swp_entries[], int entry_order)
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
@@ -1257,10 +1245,8 @@ int get_swap_pages(int n_goal, swp_entry_t swp_entries[], int entry_order)
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


