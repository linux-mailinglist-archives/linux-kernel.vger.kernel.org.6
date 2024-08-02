Return-Path: <linux-kernel+bounces-272549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A63B0945DC6
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 14:21:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 278DC1F23A53
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 12:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F33091DF67F;
	Fri,  2 Aug 2024 12:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CwEok+Vb"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90771DF66B
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 12:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722601267; cv=none; b=mwJ+0PCoWBMSGJtvqykoQBc4HsleuOquj9TDYDmj1j9x4LZ1CZM+H3MlrlQZpXSiFdAX+wbbv7yawpWtbD/i3lN/Rd6w9IoDhiOtMefc9YggG385dhyoiWj0MS1MwcFx1xqPPCM8BNxj2UcB4zryyXOXFqJZqlMdu3dZeDvUy30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722601267; c=relaxed/simple;
	bh=tzHAhwAyy8PSrLYUP3BLqNXDLKH7z9/YewVeZXL15oQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Uf6ZsIKMK8IlmyR/oFcN5TkQEZ4I/6xCSUZ+W1eXGotiGBE/kZaKKcSvhrevVeZ2p45cBjJ7hancW2pA2yltWKb+Wf38Mekl4B1t/DVM7t4Qy0JLgcjmCcL+ygH264khLWabp1oYzcEqL2KaXNDZcUhWVeaVrZkd6ioBI3Qijpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CwEok+Vb; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1fc65329979so69690415ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2024 05:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722601265; x=1723206065; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SZw+mrWAtNO8gx3RRID0EOwy0TVTv1NvTSzmaII/3QU=;
        b=CwEok+VbfHIY/985JberV5te8k8yzW7YyZoYZtoJoruJN2emkhpoTMSbwvl7YhImto
         FQTqork/IKhuayFf5ekS6+g6Ep+tP2ILBJ51vIynI0uYtLEj9o4s/h6+t4Uhw7EmEP8w
         Lfm8WvwoZFP6I8hLWia4JeX7pgUjOMhfMWSJebNCXGGThhYe1T6EZ1gEcW+OhVYXpEoJ
         TjFIZMeGlKX9vVAW9J1HE0bAJfTQ4IA0r9ZRuWTwYbeAp7r2gfZH5Jh8F+sdw/KRyYF5
         4M+jBDKKDYg+pe5Fg4Omo96XqJRg6m42arqvT2Q3Wp+zQ9UwzpGeAns3uRR9oJZpuJJ2
         3LXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722601265; x=1723206065;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SZw+mrWAtNO8gx3RRID0EOwy0TVTv1NvTSzmaII/3QU=;
        b=G8VCLZJnWLvPgEhTrOby6AjXLn/kkKbi2GvCs4whdCIwWknLkhn5BCLVDdHURCdfUU
         isGojIFTPQSC/jYA5OUQa3XLqImN/n0roAva9I/g3Z65/M7AH7GLMbdJ6Z/awmyTlucp
         D7kzSt7oYAtDpXJcLIFFqxE/C+qxCWP07xLIMlNyNYI4sP+4on9ifxjfaWnL/Iav7mmI
         mCDZEwJ+TJNUJeCsOhWdCEIR3mndtGekzKuMQsTx+o4o6qbPJEip0ioJu4OPaVlEtRuH
         L+YRJlynr3+LBKAAAlLaMv2zMoCu189ishosbuxxGirbVUh0JiWcunwyV/ttuAvJO5d+
         Wbdw==
X-Forwarded-Encrypted: i=1; AJvYcCXIWaJkS9eo6dwYU05YYwFN7IQwyKRasHjKUaRqPa5ABVayKMxUYGmvmMwXA04Guzys/J99xSOhZZDRU7GDOZ2BMCvkGvPcz/LZzmSr
X-Gm-Message-State: AOJu0YxyR4ufMA0v0sgmuML1cMqYE9Cv3kVX0/pwQsrSaXon0JEZ/9Hr
	deoF5+MKp1U0YOa77BYe8t4Jqh/3Tbsfc2X1vQuZ/hnWvQQObmLC
X-Google-Smtp-Source: AGHT+IH1pVDAT1Yc267JouGX6+3PsrKXzfDOleAEismvtPezwW0HljZJprD4nR6qZc1Oy9FTD3tnXg==
X-Received: by 2002:a17:902:db07:b0:1fd:9e44:e5e9 with SMTP id d9443c01a7336-1ff5744c810mr42469645ad.53.1722601264728;
        Fri, 02 Aug 2024 05:21:04 -0700 (PDT)
Received: from localhost.localdomain ([2407:7000:8942:5500:aaa1:59ff:fe57:eb97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff590600e4sm15841875ad.144.2024.08.02.05.20.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 05:21:04 -0700 (PDT)
From: Barry Song <21cnbao@gmail.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org
Cc: baolin.wang@linux.alibaba.com,
	chrisl@kernel.org,
	david@redhat.com,
	hannes@cmpxchg.org,
	hughd@google.com,
	kaleshsingh@google.com,
	kasong@tencent.com,
	linux-kernel@vger.kernel.org,
	mhocko@suse.com,
	minchan@kernel.org,
	nphamcs@gmail.com,
	ryan.roberts@arm.com,
	senozhatsky@chromium.org,
	shakeel.butt@linux.dev,
	shy828301@gmail.com,
	surenb@google.com,
	v-songbaohua@oppo.com,
	willy@infradead.org,
	xiang@kernel.org,
	ying.huang@intel.com,
	yosryahmed@google.com,
	hch@infradead.org
Subject: [PATCH v6 1/2] mm: add nr argument in mem_cgroup_swapin_uncharge_swap() helper to support large folios
Date: Sat,  3 Aug 2024 00:20:30 +1200
Message-Id: <20240802122031.117548-2-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240802122031.117548-1-21cnbao@gmail.com>
References: <20240726094618.401593-1-21cnbao@gmail.com>
 <20240802122031.117548-1-21cnbao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Barry Song <v-songbaohua@oppo.com>

With large folios swap-in, we might need to uncharge multiple entries
all together, add nr argument in mem_cgroup_swapin_uncharge_swap().

For the existing two users, just pass nr=1.

Signed-off-by: Barry Song <v-songbaohua@oppo.com>
---
 include/linux/memcontrol.h | 5 +++--
 mm/memcontrol.c            | 7 ++++---
 mm/memory.c                | 2 +-
 mm/swap_state.c            | 2 +-
 4 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 1b79760af685..44f7fb7dc0c8 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -682,7 +682,8 @@ int mem_cgroup_hugetlb_try_charge(struct mem_cgroup *memcg, gfp_t gfp,
 
 int mem_cgroup_swapin_charge_folio(struct folio *folio, struct mm_struct *mm,
 				  gfp_t gfp, swp_entry_t entry);
-void mem_cgroup_swapin_uncharge_swap(swp_entry_t entry);
+
+void mem_cgroup_swapin_uncharge_swap(swp_entry_t entry, unsigned int nr_pages);
 
 void __mem_cgroup_uncharge(struct folio *folio);
 
@@ -1181,7 +1182,7 @@ static inline int mem_cgroup_swapin_charge_folio(struct folio *folio,
 	return 0;
 }
 
-static inline void mem_cgroup_swapin_uncharge_swap(swp_entry_t entry)
+static inline void mem_cgroup_swapin_uncharge_swap(swp_entry_t entry, unsigned int nr)
 {
 }
 
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index b889a7fbf382..5d763c234c44 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -4572,14 +4572,15 @@ int mem_cgroup_swapin_charge_folio(struct folio *folio, struct mm_struct *mm,
 
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
@@ -4599,7 +4600,7 @@ void mem_cgroup_swapin_uncharge_swap(swp_entry_t entry)
 		 * let's not wait for it.  The page already received a
 		 * memory+swap charge, drop the swap entry duplicate.
 		 */
-		mem_cgroup_uncharge_swap(entry, 1);
+		mem_cgroup_uncharge_swap(entry, nr_pages);
 	}
 }
 
diff --git a/mm/memory.c b/mm/memory.c
index 4c8716cb306c..4cf4902db1ec 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4102,7 +4102,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 					ret = VM_FAULT_OOM;
 					goto out_page;
 				}
-				mem_cgroup_swapin_uncharge_swap(entry);
+				mem_cgroup_swapin_uncharge_swap(entry, 1);
 
 				shadow = get_shadow_from_swap_cache(entry);
 				if (shadow)
diff --git a/mm/swap_state.c b/mm/swap_state.c
index 293ff1afdca4..1159e3225754 100644
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


