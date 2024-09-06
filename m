Return-Path: <linux-kernel+bounces-317980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EB85E96E6A5
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 02:11:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 754771F244B1
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 00:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B0A0322A;
	Fri,  6 Sep 2024 00:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f3pLeH+1"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2305111CA0
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 00:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725581486; cv=none; b=Awin45dhP/4i0SMfJjyovSxGJH/M+2dRj9+HpC2eMJOVxA9wahqqg9Yrad7IrqU/xq60tAUWn8W33udVKutOMtzEczfmAI0quwqYPN0MS0Wpv8neshgJxO67BwtlJoUth2xCCvFHzGpEMysQvP5ilnCjXqjwbOcM6FCC3wch3kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725581486; c=relaxed/simple;
	bh=cQGTDKyTZYbzAmEp36nB/7fT2beTR3QOox6VwozUcW0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bH88wHUChpamjq71fE1f4hc99lVVQzsbxCK8g4PWSR5nD9XhIH49z3sjTsjRIDkXotG5kKb7XGh7RvwY0DGkUp4f0G7hsF4RBDnaPXOnjrrR3vfse86hkcqTfbW4ZVH+/ni6RvB1h2mAak1YaI6dtoOZel4Hj53bsRxAtLrXV1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f3pLeH+1; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-714287e4083so1189609b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 17:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725581484; x=1726186284; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ywsxeCwLk01Zemkk/XL229z2/fbHB1/7YpgelTeC42M=;
        b=f3pLeH+1jb2zUd3TDXTWzQ4jOd+Yq0MZo5VJL4Gtphb9GL6ZCzdOCEX0TM9HzlCzL7
         rBGbiOdtvzLiax9cgqcERXqb9eB3L1Gu4+YSgXEQKYz2tA+O7urjuquJoXxta87sI067
         kFqveVk0JldT4191AVUn4t7zg0XmGNUJO6V+uEaYGw2N5SV9izphoFdGoTQ0ZRoXjjjE
         EbKIu4yXTenTojXwAawGoypvgqylqbPWRut2eORKsZbp6KlTGsp1jhzm4+zwXTd7UVaW
         4LTVw+5UVJjvhXOCzfCgrY3+L5b4A/IRC/IoXfLzhqKSIeQlCADVY5c4sY2CxywLIdp2
         FaXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725581484; x=1726186284;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ywsxeCwLk01Zemkk/XL229z2/fbHB1/7YpgelTeC42M=;
        b=ENHfkB9kthOu53hfAH1Hew51XEjzFd8dGLjAG3fOT9tcL8LFKE4hNJQloJcy/yOOdU
         beXD3pWuXNx0tLw9+Kqjo5oEk7Q5N5aWsNTcSpzYUmwUgsq0TCNESCzGyOpbLtfN3ibo
         zbkC2begp0OSbOsK2Fj1kCoXpU3dJlR0uZpnE1i3hXqxVLqo+1X3faaZ0LZ3ClnRkjX3
         XTqB2dIrUn9OEvy+/3La2P4mVCHsdnVmeooqI9JQ09TOMMeQQw2R5dziXSxeUb1q5IYP
         XYvMM0IN1h59xQcAWeJPWYq+CwvN4+t2JPDAJKJRedlU0Cu3t7wlxn2uxTky5FcmsK1n
         Fcdg==
X-Forwarded-Encrypted: i=1; AJvYcCWn1xiCExhyIwrpju1bl/dDMSCde6kN7HzXKgZaQraueLIhNwsEXoziuaN/rD9QyeJD1FtqAs9mZhjXwQU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+rOdsgWhdUBnAH4wi2oNwK7rbLQCLtWokR0qLurPKClM+2Ydv
	Fz9hnNs49M2EfVSs84F/IPQ0WiuOviTHcp3fFH3EzHrcr4TUpuzD
X-Google-Smtp-Source: AGHT+IFsT4gnjeGJ6BsOu0cQW9p32ygkcd0pzMLcI1W+NEiU9e52v6MkwZke3r/as0onruSbW4ToHQ==
X-Received: by 2002:a05:6a20:cf83:b0:1ce:d418:a42c with SMTP id adf61e73a8af0-1cf1d0eff88mr747550637.19.1725581484279;
        Thu, 05 Sep 2024 17:11:24 -0700 (PDT)
Received: from Barrys-MBP.hub ([2407:7000:8942:5500:cd42:f8ae:5222:5ab7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206aea3548dsm33447445ad.140.2024.09.05.17.11.15
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 05 Sep 2024 17:11:23 -0700 (PDT)
From: Barry Song <21cnbao@gmail.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org
Cc: hanchuanhua@oppo.com,
	baolin.wang@linux.alibaba.com,
	chrisl@kernel.org,
	david@redhat.com,
	hannes@cmpxchg.org,
	hch@infradead.org,
	hughd@google.com,
	kaleshsingh@google.com,
	kasong@tencent.com,
	linux-kernel@vger.kernel.org,
	mhocko@suse.com,
	minchan@kernel.org,
	nphamcs@gmail.com,
	ryan.roberts@arm.com,
	ryncsn@gmail.com,
	senozhatsky@chromium.org,
	shakeel.butt@linux.dev,
	shy828301@gmail.com,
	surenb@google.com,
	v-songbaohua@oppo.com,
	willy@infradead.org,
	xiang@kernel.org,
	ying.huang@intel.com,
	yosryahmed@google.com
Subject: [PATCH v8 2/3] mm: add nr argument in mem_cgroup_swapin_uncharge_swap() helper to support large folios
Date: Fri,  6 Sep 2024 12:10:46 +1200
Message-Id: <20240906001047.1245-3-21cnbao@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20240906001047.1245-1-21cnbao@gmail.com>
References: <20240906001047.1245-1-21cnbao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Barry Song <v-songbaohua@oppo.com>

With large folios swap-in, we might need to uncharge multiple entries all
together, add nr argument in mem_cgroup_swapin_uncharge_swap().

For the existing two users, just pass nr=1.

Signed-off-by: Barry Song <v-songbaohua@oppo.com>
Acked-by: Chris Li <chrisl@kernel.org>
Cc: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: David Hildenbrand <david@redhat.com>
Cc: Gao Xiang <xiang@kernel.org>
Cc: "Huang, Ying" <ying.huang@intel.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Kairui Song <kasong@tencent.com>
Cc: Kairui Song <ryncsn@gmail.com>
Cc: Kalesh Singh <kaleshsingh@google.com>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Nhat Pham <nphamcs@gmail.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Yang Shi <shy828301@gmail.com>
Cc: Yosry Ahmed <yosryahmed@google.com>
---
 include/linux/memcontrol.h | 5 +++--
 mm/memcontrol.c            | 7 ++++---
 mm/memory.c                | 2 +-
 mm/swap_state.c            | 2 +-
 4 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 2ef94c74847d..34d2da05f2f1 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -699,7 +699,8 @@ int mem_cgroup_hugetlb_try_charge(struct mem_cgroup *memcg, gfp_t gfp,
 
 int mem_cgroup_swapin_charge_folio(struct folio *folio, struct mm_struct *mm,
 				  gfp_t gfp, swp_entry_t entry);
-void mem_cgroup_swapin_uncharge_swap(swp_entry_t entry);
+
+void mem_cgroup_swapin_uncharge_swap(swp_entry_t entry, unsigned int nr_pages);
 
 void __mem_cgroup_uncharge(struct folio *folio);
 
@@ -1206,7 +1207,7 @@ static inline int mem_cgroup_swapin_charge_folio(struct folio *folio,
 	return 0;
 }
 
-static inline void mem_cgroup_swapin_uncharge_swap(swp_entry_t entry)
+static inline void mem_cgroup_swapin_uncharge_swap(swp_entry_t entry, unsigned int nr)
 {
 }
 
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index bda6f75d22ff..c0d36ca20332 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -4559,14 +4559,15 @@ int mem_cgroup_swapin_charge_folio(struct folio *folio, struct mm_struct *mm,
 
 /*
  * mem_cgroup_swapin_uncharge_swap - uncharge swap slot
- * @entry: swap entry for which the page is charged
+ * @entry: the first swap entry for which the pages are charged
+ * @nr_pages: number of pages which will be uncharged
  *
  * Call this function after successfully adding the charged page to swapcache.
  *
  * Note: This function assumes the page for which swap slot is being uncharged
  * is order 0 page.
  */
-void mem_cgroup_swapin_uncharge_swap(swp_entry_t entry)
+void mem_cgroup_swapin_uncharge_swap(swp_entry_t entry, unsigned int nr_pages)
 {
 	/*
 	 * Cgroup1's unified memory+swap counter has been charged with the
@@ -4586,7 +4587,7 @@ void mem_cgroup_swapin_uncharge_swap(swp_entry_t entry)
 		 * let's not wait for it.  The page already received a
 		 * memory+swap charge, drop the swap entry duplicate.
 		 */
-		mem_cgroup_uncharge_swap(entry, 1);
+		mem_cgroup_uncharge_swap(entry, nr_pages);
 	}
 }
 
diff --git a/mm/memory.c b/mm/memory.c
index 42674c0748cb..cdf03b39a92c 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4100,7 +4100,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 					ret = VM_FAULT_OOM;
 					goto out_page;
 				}
-				mem_cgroup_swapin_uncharge_swap(entry);
+				mem_cgroup_swapin_uncharge_swap(entry, 1);
 
 				shadow = get_shadow_from_swap_cache(entry);
 				if (shadow)
diff --git a/mm/swap_state.c b/mm/swap_state.c
index a042720554a7..4669f29cf555 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -522,7 +522,7 @@ struct folio *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
 	if (add_to_swap_cache(new_folio, entry, gfp_mask & GFP_RECLAIM_MASK, &shadow))
 		goto fail_unlock;
 
-	mem_cgroup_swapin_uncharge_swap(entry);
+	mem_cgroup_swapin_uncharge_swap(entry, 1);
 
 	if (shadow)
 		workingset_refault(new_folio, shadow);
-- 
2.34.1


