Return-Path: <linux-kernel+bounces-376852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FC5A9AB6C6
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 21:30:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3D551F23813
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 19:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CBC21CB520;
	Tue, 22 Oct 2024 19:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B6j1lzet"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0D01CB33F
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 19:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729625389; cv=none; b=ZggpioXtyR9b7J2k79fjZCO7yqOF0eHRtj0EeboMH3lcv9K9yKOytVxoz+Za7beGZLqaWmNFX0OE8EBMBsdYOS+BgB+f52REAi74sid/BfU4ArtiMrsNOzXJ0KfHSPvT1rtREohia9uuGKWAvYo2UhgbCFXGJNbh5qG74rlaFMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729625389; c=relaxed/simple;
	bh=0GlaNclLZLStjoTYzK1VGaVvWuPsSM+r/LE8FU/4tI4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PW0dv6h26sv+eUIRxE+hJQtsML7U7kDziBNPJAr8N1LvbYv4N8cfXwKjDEo1DuLpOlK1IWRVcL5zGpgyu3DKCoctP5vFp7zHqojQmkC9SHuKKmBysRlpT+nkCQLJT8yTykGGyufHerPEhZfsxF0dcJ+htvTM9q4ohWgcGYG4lxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B6j1lzet; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-20cdb889222so58305585ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 12:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729625387; x=1730230187; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/mi3lQ6T07AhjXuuW+YLZdNW4Sf4NNrHXlGjygFJG4M=;
        b=B6j1lzetQ9K/IR5rRA+uxzBIQ2sB9TBNhv8xvQ2cAwzwH3EXDjllvGXr6ckqgAJL65
         2+OTsOxu3RdOQC9q5NkQS3kN75hjnpx7km1zW1nqQvt9Ub2+oSxW5yyel6q51P+1CkHA
         kYy+Yje+j3Q3eB2raaLsyNmsmeBkOY4KR9R/EFJMrudLFdJVqzbrWlahqUjWDoZVpbM7
         gpmLyQyWTMr1C5ZZfEw8G1ec7IHBVWKUG8rBQjjNQ+SDTiTzkw5RvHIqojmE1MGjCmZX
         FspI5HOQypW2EYhcAwOoadJzDwtR8tYp+YbZ1XH0WmBCP5ZxVPrNEzrd5sWJV2YZnqsy
         7Mrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729625387; x=1730230187;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/mi3lQ6T07AhjXuuW+YLZdNW4Sf4NNrHXlGjygFJG4M=;
        b=WRc1Xa1Y/RMK+Z4roPVAkmFjwqhZMZdO+LeBeWftBbmSo4u4m1gtFAI4BHThKrq+gR
         /uOmsKSojUM1e/51reRz1XbrQda9o80bYXPjg6b6Gz/4pXdF9hjA3tkSVkN86wa0sFEG
         Rnba75ZMBhkG8GKlihWRpNGigLbePIiXiZrxvWMNXZZAl2B3Of95ADCvnfWRz7m+1nCe
         NMxSVknBLGUKdynLpZZcmRj9PLB46/jt5h7dxjG4aQlVLl3U7+XEg4Ay/qUmWRsMkLBQ
         pn2ljkd78sGOp24GbYjWjOk6HstMnmqXs9Q59snznM4aiDxCifWLtGWnZlu+xx3PE3uF
         6C7w==
X-Forwarded-Encrypted: i=1; AJvYcCX32VLnfKUFJCnXKkQxgwYVzDJ+QzcGO9i8JXd4B8XU6/ox6SUM2FokjOaJhA5av3cNGc+So2AnGMSTYV8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrgEY2V4Mryv0hLNozfkTP0ReF4B4/1h5bmiimy88wJkpOcauZ
	8imevhjUSuPoM2oqh7TECNEtM/H/zOaqUo7p8iOQXId2ktHv0e7L
X-Google-Smtp-Source: AGHT+IHYM0AqePAeT91a9awvzQB5jl0p+WmH3l4Mu0GnxO1LklkU59Sg3M8q1ydkMmTY3kKflEy/Lg==
X-Received: by 2002:a17:903:2447:b0:20c:ce1f:13bd with SMTP id d9443c01a7336-20fa9e2488dmr2805955ad.18.1729625387386;
        Tue, 22 Oct 2024 12:29:47 -0700 (PDT)
Received: from KASONG-MC4.tencent.com ([106.37.123.36])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e7f0d9f05sm45895305ad.186.2024.10.22.12.29.44
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 22 Oct 2024 12:29:46 -0700 (PDT)
From: Kairui Song <ryncsn@gmail.com>
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Chris Li <chrisl@kernel.org>,
	Barry Song <v-songbaohua@oppo.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Hugh Dickins <hughd@google.com>,
	Yosry Ahmed <yosryahmed@google.com>,
	"Huang, Ying" <ying.huang@intel.com>,
	Tim Chen <tim.c.chen@linux.intel.com>,
	Nhat Pham <nphamcs@gmail.com>,
	linux-kernel@vger.kernel.org,
	Kairui Song <kasong@tencent.com>
Subject: [PATCH 01/13] mm, swap: minor clean up for swap entry allocation
Date: Wed, 23 Oct 2024 03:24:39 +0800
Message-ID: <20241022192451.38138-2-ryncsn@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241022192451.38138-1-ryncsn@gmail.com>
References: <20241022192451.38138-1-ryncsn@gmail.com>
Reply-To: Kairui Song <kasong@tencent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kairui Song <kasong@tencent.com>

Direct reclaim can skip the whole folio after reclaimed a set of
folio based slots. Also simplify the code for allocation, reduce
indention.

Signed-off-by: Kairui Song <kasong@tencent.com>
---
 mm/swapfile.c | 59 +++++++++++++++++++++++++--------------------------
 1 file changed, 29 insertions(+), 30 deletions(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 46bd4b1a3c07..1128cea95c47 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -604,23 +604,28 @@ static bool cluster_reclaim_range(struct swap_info_struct *si,
 				  unsigned long start, unsigned long end)
 {
 	unsigned char *map = si->swap_map;
-	unsigned long offset;
+	unsigned long offset = start;
+	int nr_reclaim;
 
 	spin_unlock(&ci->lock);
 	spin_unlock(&si->lock);
 
-	for (offset = start; offset < end; offset++) {
+	do {
 		switch (READ_ONCE(map[offset])) {
 		case 0:
-			continue;
+			offset++;
+			break;
 		case SWAP_HAS_CACHE:
-			if (__try_to_reclaim_swap(si, offset, TTRS_ANYWAY | TTRS_DIRECT) > 0)
-				continue;
-			goto out;
+			nr_reclaim = __try_to_reclaim_swap(si, offset, TTRS_ANYWAY | TTRS_DIRECT);
+			if (nr_reclaim > 0)
+				offset += nr_reclaim;
+			else
+				goto out;
+			break;
 		default:
 			goto out;
 		}
-	}
+	} while (offset < end);
 out:
 	spin_lock(&si->lock);
 	spin_lock(&ci->lock);
@@ -826,35 +831,30 @@ static unsigned long cluster_alloc_swap_entry(struct swap_info_struct *si, int o
 							 &found, order, usage);
 			frags++;
 			if (found)
-				break;
+				goto done;
 		}
 
-		if (!found) {
+		/*
+		 * Nonfull clusters are moved to frag tail if we reached
+		 * here, count them too, don't over scan the frag list.
+		 */
+		while (frags < si->frag_cluster_nr[order]) {
+			ci = list_first_entry(&si->frag_clusters[order],
+					      struct swap_cluster_info, list);
 			/*
-			 * Nonfull clusters are moved to frag tail if we reached
-			 * here, count them too, don't over scan the frag list.
+			 * Rotate the frag list to iterate, they were all failing
+			 * high order allocation or moved here due to per-CPU usage,
+			 * this help keeping usable cluster ahead.
 			 */
-			while (frags < si->frag_cluster_nr[order]) {
-				ci = list_first_entry(&si->frag_clusters[order],
-						      struct swap_cluster_info, list);
-				/*
-				 * Rotate the frag list to iterate, they were all failing
-				 * high order allocation or moved here due to per-CPU usage,
-				 * this help keeping usable cluster ahead.
-				 */
-				list_move_tail(&ci->list, &si->frag_clusters[order]);
-				offset = alloc_swap_scan_cluster(si, cluster_offset(si, ci),
-								 &found, order, usage);
-				frags++;
-				if (found)
-					break;
-			}
+			list_move_tail(&ci->list, &si->frag_clusters[order]);
+			offset = alloc_swap_scan_cluster(si, cluster_offset(si, ci),
+							 &found, order, usage);
+			frags++;
+			if (found)
+				goto done;
 		}
 	}
 
-	if (found)
-		goto done;
-
 	if (!list_empty(&si->discard_clusters)) {
 		/*
 		 * we don't have free cluster but have some clusters in
@@ -892,7 +892,6 @@ static unsigned long cluster_alloc_swap_entry(struct swap_info_struct *si, int o
 				goto done;
 		}
 	}
-
 done:
 	cluster->next[order] = offset;
 	return found;
-- 
2.47.0


