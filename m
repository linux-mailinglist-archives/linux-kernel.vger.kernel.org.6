Return-Path: <linux-kernel+bounces-320449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11E79970A95
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 01:22:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3023F1C20AE1
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 23:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D70214D71D;
	Sun,  8 Sep 2024 23:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TF4mhsFg"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7620217A59B
	for <linux-kernel@vger.kernel.org>; Sun,  8 Sep 2024 23:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725837714; cv=none; b=liEQ/TcdTCUKdyDDHz9Cc106xmDzavT9WsXYvFP0XJJpLNHxzPiKisyBCoafQh5Th09NQo2/PzjELgEJt1mqa0JSTsyjLsDsf6ap3Uy1g3r4QnWPvuQbPVOSdVOsmWaVudwgTn+PRh/y5yzSRFjEy/f8TEMt4HpC2/QwJFkcqwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725837714; c=relaxed/simple;
	bh=s5cN/CR30bvQrW0O19dF2kIQlH/i6E72paHAZrCWM3k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XkUognxSPsTalEKzQcVq4Os979Tn/rareWEgQ7RrLWApktY5sbZcfp/tsCfekmgM3VrMpxwq8Ed65Rzc8N7Xjtz5GBEA3NnKf01Toki/Y+wbBdX7M3sxydNW/Nhdxn9JedcySQvIM59FeegdDZHNMrouy0dHtyG3awhGk83Sd1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TF4mhsFg; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-718e9c8bd83so538872b3a.1
        for <linux-kernel@vger.kernel.org>; Sun, 08 Sep 2024 16:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725837712; x=1726442512; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OlYXV3Fv3CqOaRAKUuC/QzTZ9pL0veLk2T3qfKeSJ+c=;
        b=TF4mhsFgG9w2umPnQfVFVeOF5/g+1ZcMPYWtmvhk4hN3SC+JmTpfHLmP8nhYf8fTBV
         FGfqjG/m+u3eO1jTSeYMQlFx50I8sCcz5JRqBbzSGeLcLbYWWO5n/W+dB80BD2m/YkaM
         8xEt02VlFaijiafC2eKCiCHA6wcbQasAb6gYEah3kTqOzSfCIwfufDieqZ6kttsH8DP6
         e5tgcEnUJ7HueTM1O4+pARVZ+l9gC5J57/roW2Kr7ZzjwzJbii+o4rWvuENB5sKw8cZn
         YpCToFgYzNeJMAIUqAx6paLYL2XPp/DJngwHCskFMXbwT8CQUIREOSiaPe7f3y/5Hsy2
         WqKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725837712; x=1726442512;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OlYXV3Fv3CqOaRAKUuC/QzTZ9pL0veLk2T3qfKeSJ+c=;
        b=Q0NIXfVT6IlxG0uuwCpi9hnpOJYpfEdMpeT6zWfr98BNz24efpCfn+CyVJ/SSiWLng
         PlE+Oz7VyF04gGe9jTby+hilM34ZSTcjrNHxFzXpJHdhGzEJq+0MnnMwFeBj2j+XFXVf
         6zuGXFS7rH3+fKzrJhNMObmBbbZy70uUhMFuOWxwJUi4mJxclZA8lMD9aIa4i8kzoUyg
         DTcGsEYo5MehWJFHy4rwHI37raW5PZ2qsxVnKmIpIAUoJWqzPOOZV/E3NLTSRaF8mTt2
         UBzS08m3YCA4xxtgmYjwGEmwNhXdN9GOcTC/LurcCnBdlfdzsOIQu/Z0OZCiq02//MuB
         uQXw==
X-Forwarded-Encrypted: i=1; AJvYcCWtUnlgCZxHwNJqrSzfNBj4xXoXOQ6/PhHLKvQCYYrgq4g+JF06WmCr6eAJzTTs3qOgjgD9OhJTfgauCvQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxt/rNCrgJHzdQ0cT2osIngAPNABgqV7IqMeOzo7j/hceAw+lc5
	MRD2IKq+9VSIqByQk0AXu32tAZPyOqibeEzmO7wd8PWmIgxoHbWN
X-Google-Smtp-Source: AGHT+IGL5o84rj87mdfLAxsPpLUvBk6PXR77RV9OsfYtgvZ14Unfm2nHOrZAzsQDfp012KISjhaCqw==
X-Received: by 2002:a62:a503:0:b0:717:92d8:ca5c with SMTP id d2e1a72fcca58-71792d8cadamr17178636b3a.3.1725837711653;
        Sun, 08 Sep 2024 16:21:51 -0700 (PDT)
Received: from Barrys-MBP.hub ([2407:7000:8942:5500:ecbd:b95f:f7b2:8158])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-718e58c703asm2447643b3a.82.2024.09.08.16.21.43
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 08 Sep 2024 16:21:51 -0700 (PDT)
From: Barry Song <21cnbao@gmail.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org
Cc: baolin.wang@linux.alibaba.com,
	chrisl@kernel.org,
	david@redhat.com,
	hanchuanhua@oppo.com,
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
Subject: [PATCH v9 2/3] mm: add nr argument in mem_cgroup_swapin_uncharge_swap() helper to support large folios
Date: Mon,  9 Sep 2024 11:21:18 +1200
Message-Id: <20240908232119.2157-3-21cnbao@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20240908232119.2157-1-21cnbao@gmail.com>
References: <20240908232119.2157-1-21cnbao@gmail.com>
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
Reviewed-by: Yosry Ahmed <yosryahmed@google.com>
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


