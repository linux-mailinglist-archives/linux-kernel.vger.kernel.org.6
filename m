Return-Path: <linux-kernel+bounces-376861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D45C59AB6D0
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 21:31:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB87F1C23027
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 19:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2604A1CCEE7;
	Tue, 22 Oct 2024 19:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EBUrrd5B"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E551CBE94
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 19:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729625423; cv=none; b=KejGwevdPyySnT1Nrh4Hj6PU0VtsAgWdWlpWVnjniZ7vhl+s1oqJZ16OXyLvtrvKdHNpXgScep9wHW2/Plkr4YhOn74j3Cr/YjnGNkvvAIlFEwA2sJ40R8K1ctejQaAjDItdfGhEjnNlfP8RKARrhRsdiUXxLmF4QygPNwaBYnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729625423; c=relaxed/simple;
	bh=inyKL2bXI4Pog2z3kT057qmprXz4EMSTSmEr5aXOJUU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R1FNKUy/wgucd93Voli9nlAJRsaFL3XcsxHKLulp3H6TGze89e/Yf4Zsp+YM54ytDbSYk7vShgbWQkhqZ5k3cCS6xCiN7WD8UKkQYN9WtaOil+PCYc+jTFIyv+5rWV5txtU2QzOk3zS9YVaeCc23YghUV6dLL+9mT2rNrzuRumU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EBUrrd5B; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-20ce5e3b116so48009255ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 12:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729625421; x=1730230221; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6X+VEn+3kCPXJIqxEfgPvCWyrBXaWqi+AOuTj72rupI=;
        b=EBUrrd5BlYzrxQ2JEdY3z8NH4M0PunmolWD3FGWt4nDwCAPmuh1A3GWh9PPsy3iXxl
         cssKdmzE0xf4yraOoz52cm0kbumCaz8tFoGXiG8cq5ZXBng0Q4rlIq7riP9J9F815ODe
         XxtCtVIXyoAn677nWLIjj7+RryplBD7KXPxtpQH8qBxH0KR7O54hoVcc33+DHY+ifVJg
         u5YtwXT3cjWsD6Z8MYBB1ofXzvKqAjdZDSnlgb2viQ4EFI1/q4Yq9eOkvzSF20gMzmlG
         EP4JrbMKaPLiAYwRXOMA/u/dyAPMXRWgyMAfNvgmvWepRdXp+4ymyS1gyqMcpokKTl8d
         fNGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729625421; x=1730230221;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6X+VEn+3kCPXJIqxEfgPvCWyrBXaWqi+AOuTj72rupI=;
        b=D2lt55vIXKk3FlSeOO8oFTry4RCjimYChBMHwkylZpz1txDVgfZ46xZVw7kCMnAqcp
         Jirvz/TkkTzroxAMmY00Tyw74oHkiv8X6qzfxy37woDaEg0S4c02X6ib8nB4J6G0Ihga
         4IcJzbvP3IS3uGvDNcRJYmtSDcrwZtD8iScvgnLOLlYgugAcZfmXM3a99JsORc+SjbAv
         vSwrhk9M+r8Lg9i8shurse0y+K2iwKCj3Mr2N+1fs66Z9cU+N4rw9DrXF0HUU0NuqFMu
         MJzGJV+BHIHIqy06xekJbRyluYWEVgvs4AioRVdp4Qcrjg3AqE3Cfj4FVRv5qYK17zQl
         q4xQ==
X-Forwarded-Encrypted: i=1; AJvYcCWbDeGsHofddYvKu3wG8nd7gVFbSMTiXup9RylbOmf6cQsDVjwD1JQG24NOSi0iAXk4WuHxQ/sNgWtcq74=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1ebWYCoXw0Uf+b9/LS5MqIASBdYolOsoKefgvI0hhTh3E3y94
	9h6mPEpdH5I0ESls7/GozGyXurgMS0cz1XyutqUPkL8+VruxLZrh
X-Google-Smtp-Source: AGHT+IFwn5W3d+VVRyPS+Ks6t1Wg9f/VfrmjaEp3PoLGs96xVemWYbaZI0DuQ0MSgKZGu5ZlHrzEeA==
X-Received: by 2002:a17:902:e74f:b0:20c:7898:a8f4 with SMTP id d9443c01a7336-20fab2d9835mr2557925ad.60.1729625420908;
        Tue, 22 Oct 2024 12:30:20 -0700 (PDT)
Received: from KASONG-MC4.tencent.com ([106.37.123.36])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e7f0d9f05sm45895305ad.186.2024.10.22.12.30.17
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 22 Oct 2024 12:30:20 -0700 (PDT)
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
Subject: [PATCH 10/13] mm, swap: simplify percpu cluster updating
Date: Wed, 23 Oct 2024 03:24:48 +0800
Message-ID: <20241022192451.38138-11-ryncsn@gmail.com>
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

Instead of using a returning argument, we can simply store the next
cluster offset to the fixed percpu location, which reduce the stack
usage and simplify the function:

Object size:
./scripts/bloat-o-meter mm/swapfile.o mm/swapfile.o.new
add/remove: 0/0 grow/shrink: 0/2 up/down: 0/-271 (-271)
Function                                     old     new   delta
get_swap_pages                              2847    2733    -114
alloc_swap_scan_cluster                      894     737    -157
Total: Before=30833, After=30562, chg -0.88%

Stack usage:
Before:
swapfile.c:1190:5:get_swap_pages       240    static

After:
swapfile.c:1185:5:get_swap_pages       216    static

Signed-off-by: Kairui Song <kasong@tencent.com>
---
 include/linux/swap.h |  4 ++--
 mm/swapfile.c        | 57 ++++++++++++++++++++------------------------
 2 files changed, 28 insertions(+), 33 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index a3b5d74b095a..0e6c6bb385f0 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -276,9 +276,9 @@ enum swap_cluster_flags {
  * The first page in the swap file is the swap header, which is always marked
  * bad to prevent it from being allocated as an entry. This also prevents the
  * cluster to which it belongs being marked free. Therefore 0 is safe to use as
- * a sentinel to indicate next is not valid in percpu_cluster.
+ * a sentinel to indicate an entry is not valid.
  */
-#define SWAP_NEXT_INVALID	0
+#define SWAP_ENTRY_INVALID	0
 
 #ifdef CONFIG_THP_SWAP
 #define SWAP_NR_ORDERS		(PMD_ORDER + 1)
diff --git a/mm/swapfile.c b/mm/swapfile.c
index a19ee8d5ffd0..f529e2ce2019 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -743,11 +743,14 @@ static void cluster_alloc_range(struct swap_info_struct *si, struct swap_cluster
 	ci->count += nr_pages;
 }
 
-static unsigned int alloc_swap_scan_cluster(struct swap_info_struct *si, unsigned long offset,
-					    unsigned int *foundp, unsigned int order,
+/* Try use a new cluster for current CPU and allocate from it. */
+static unsigned int alloc_swap_scan_cluster(struct swap_info_struct *si,
+					    unsigned long offset,
+					    unsigned int order,
 					    unsigned char usage)
 {
-	unsigned long start = offset & ~(SWAPFILE_CLUSTER - 1);
+	unsigned int next = SWAP_ENTRY_INVALID, found = SWAP_ENTRY_INVALID;
+	unsigned long start = ALIGN_DOWN(offset, SWAPFILE_CLUSTER);
 	unsigned long end = min(start + SWAPFILE_CLUSTER, si->max);
 	unsigned int nr_pages = 1 << order;
 	bool need_reclaim, ret;
@@ -756,10 +759,8 @@ static unsigned int alloc_swap_scan_cluster(struct swap_info_struct *si, unsigne
 	ci = &si->cluster_info[offset / SWAPFILE_CLUSTER];
 	lockdep_assert_held(&ci->lock);
 
-	if (end < nr_pages || ci->count + nr_pages > SWAPFILE_CLUSTER) {
-		offset = SWAP_NEXT_INVALID;
+	if (end < nr_pages || ci->count + nr_pages > SWAPFILE_CLUSTER)
 		goto out;
-	}
 
 	for (end -= nr_pages; offset <= end; offset += nr_pages) {
 		need_reclaim = false;
@@ -773,10 +774,8 @@ static unsigned int alloc_swap_scan_cluster(struct swap_info_struct *si, unsigne
 			 * cluster has no flag set, and change of list
 			 * won't cause fragmentation.
 			 */
-			if (!cluster_is_usable(ci, order)) {
-				offset = SWAP_NEXT_INVALID;
+			if (!cluster_is_usable(ci, order))
 				goto out;
-			}
 			if (cluster_is_free(ci))
 				offset = start;
 			/* Reclaim failed but cluster is usable, try next */
@@ -784,20 +783,17 @@ static unsigned int alloc_swap_scan_cluster(struct swap_info_struct *si, unsigne
 				continue;
 		}
 		cluster_alloc_range(si, ci, offset, usage, order);
-		*foundp = offset;
-		if (ci->count == SWAPFILE_CLUSTER) {
-			offset = SWAP_NEXT_INVALID;
-			goto out;
-		}
+		found = offset;
 		offset += nr_pages;
+		if (ci->count < SWAPFILE_CLUSTER && offset <= end)
+			next = offset;
 		break;
 	}
-	if (offset > end)
-		offset = SWAP_NEXT_INVALID;
 out:
 	relocate_cluster(si, ci);
 	unlock_cluster(ci);
-	return offset;
+	__this_cpu_write(si->percpu_cluster->next[order], next);
+	return found;
 }
 
 /* Return true if reclaimed a whole cluster */
@@ -866,8 +862,8 @@ static unsigned long cluster_alloc_swap_entry(struct swap_info_struct *si, int o
 		if (cluster_is_usable(ci, order)) {
 			if (cluster_is_free(ci))
 				offset = cluster_offset(si, ci);
-			offset = alloc_swap_scan_cluster(si, offset, &found,
-							 order, usage);
+			found = alloc_swap_scan_cluster(si, offset,
+							order, usage);
 		} else {
 			unlock_cluster(ci);
 		}
@@ -878,8 +874,8 @@ static unsigned long cluster_alloc_swap_entry(struct swap_info_struct *si, int o
 new_cluster:
 	ci = cluster_isolate_lock(si, &si->free_clusters);
 	if (ci) {
-		offset = alloc_swap_scan_cluster(si, cluster_offset(si, ci),
-						 &found, order, usage);
+		found = alloc_swap_scan_cluster(si, cluster_offset(si, ci),
+						order, usage);
 		/*
 		 * Allocation from free cluster must never fail and
 		 * cluster lock must remain untouched.
@@ -896,8 +892,8 @@ static unsigned long cluster_alloc_swap_entry(struct swap_info_struct *si, int o
 		unsigned int frags = 0, frags_existing;
 
 		while ((ci = cluster_isolate_lock(si, &si->nonfull_clusters[order]))) {
-			offset = alloc_swap_scan_cluster(si, cluster_offset(si, ci),
-							 &found, order, usage);
+			found = alloc_swap_scan_cluster(si, cluster_offset(si, ci),
+							order, usage);
 			/*
 			 * With `fragmenting` set to true, it will surely take
 			 * the cluster off nonfull list
@@ -917,8 +913,8 @@ static unsigned long cluster_alloc_swap_entry(struct swap_info_struct *si, int o
 			 * per-CPU usage, but either way they could contain
 			 * usable (eg. lazy-freed swap cache) slots.
 			 */
-			offset = alloc_swap_scan_cluster(si, cluster_offset(si, ci),
-							 &found, order, usage);
+			found = alloc_swap_scan_cluster(si, cluster_offset(si, ci),
+							order, usage);
 			if (found)
 				goto done;
 			frags++;
@@ -944,21 +940,20 @@ static unsigned long cluster_alloc_swap_entry(struct swap_info_struct *si, int o
 		 */
 		while ((ci = cluster_isolate_lock(si, &si->frag_clusters[o]))) {
 			atomic_long_dec(&si->frag_cluster_nr[o]);
-			offset = alloc_swap_scan_cluster(si, cluster_offset(si, ci),
-							 &found, order, usage);
+			found = alloc_swap_scan_cluster(si, cluster_offset(si, ci),
+							0, usage);
 			if (found)
 				goto done;
 		}
 
 		while ((ci = cluster_isolate_lock(si, &si->nonfull_clusters[o]))) {
-			offset = alloc_swap_scan_cluster(si, cluster_offset(si, ci),
-							 &found, order, usage);
+			found = alloc_swap_scan_cluster(si, cluster_offset(si, ci),
+							0, usage);
 			if (found)
 				goto done;
 		}
 	}
 done:
-	__this_cpu_write(si->percpu_cluster->next[order], offset);
 	local_unlock(&si->percpu_cluster->lock);
 
 	return found;
@@ -3150,7 +3145,7 @@ static struct swap_cluster_info *setup_clusters(struct swap_info_struct *si,
 
 		cluster = per_cpu_ptr(si->percpu_cluster, cpu);
 		for (i = 0; i < SWAP_NR_ORDERS; i++)
-			cluster->next[i] = SWAP_NEXT_INVALID;
+			cluster->next[i] = SWAP_ENTRY_INVALID;
 		local_lock_init(&cluster->lock);
 	}
 
-- 
2.47.0


