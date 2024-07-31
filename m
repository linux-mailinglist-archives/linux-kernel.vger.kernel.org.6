Return-Path: <linux-kernel+bounces-269262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 43C86942FF4
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 15:19:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2612B24033
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 13:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B1161B0136;
	Wed, 31 Jul 2024 13:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="ZH/9l8+q"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 471801AD9C3
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 13:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722431932; cv=none; b=ZmXs2oHoGtToiHXhNQO7zduiHgnzh8eKPy6LtkbugN5a1E0jPCG3A4wZp2dcwgFwcfHTOwtVcKr6xWJerZ7ecUerbjMAw93LjoYL6iA1ojKw5nhN9FPStriEPubeMRiI1r0BDmdwn1h03/BOQ1QIPr0x4ZH85XFPoDVGgrjjg9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722431932; c=relaxed/simple;
	bh=1/qx34Nij3yLpgUt8LZJc0FFqYmOJwwjjy6Tq87FyPM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=kpF2HgbcZa5qsFaWiJphQ4PuRcdpNGJnigbWu+mn94bFBQ1+txiWSplrdwjEa1tDKMsxfUDYOQuann2VznAvw9iyjvxrJTVfvemBCs5i00Ian94yfXctHwyenN5uNFRIkwOYa+j4Uy8BNdj8EFKmxXsHCggTn6Ct9q0Gxemkp8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=ZH/9l8+q; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1fc6ee64512so40789315ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 06:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1722431929; x=1723036729; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z52FQ6IMmQxAE0Vu/r8CqKepvmtrEbW9y0jq8OJjDbo=;
        b=ZH/9l8+qTh/4qpXx5juxoKs+OaWFk2XKA6FxokjA5qYiqJl++O8voGoWp/DB91/nkY
         ae+v3qhvO8c4MmpL2xyN2utuMQ3QevTf4ozd76xoslJcqAsP9Bhr8FNRqXBgyeSFdqaY
         cCb5jdUyRnNcftGdN9uTPSbpm+P+qexSN2GHJJiFE4E1HDQzlj+4wfI5I6H7jWfziwZN
         5YRncl2Ty7u9IW8XZeZ173eJuwv+mudLH0xlvjaMszIUrtP0xSOYbTqkPzfDwk+TJawg
         NtL+D9PK7Xcjy4B2HvSM+mi+wiOqHZZzKt6FQ3uRpAEdthSogFrCLY7e8rfEgetqzMi/
         gDLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722431929; x=1723036729;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z52FQ6IMmQxAE0Vu/r8CqKepvmtrEbW9y0jq8OJjDbo=;
        b=H4exrUEiQqxooGhAfibO9HwzhLKzF6J7rNvJez0I1hhUE27F062cIZoUZCgkeRwG25
         /7JXBLCHG5bi6FEiZwsh+KEh8EcD2VGc9Wjsk+Matnfc9qlyPGDH84/PBd3LGY5I551m
         zH+mO44BuaUt/sqeVIwJnPQpRJ7WykaUvfsv0nDNLEGsHFThMITOhsOzwnIdssXDtJvU
         ieXf41VOtAeqbf3xvRDaixJj+H+db72LBx1bLfCm8FiQ37w+9Rjbl7rzSVVKmaPba/db
         qqzn1nHfk6t+PR+CUfu4N6BJUS4G/ybsvCwiGfFvMuQYg6aToau559C2Z7CbCTn1euph
         27gw==
X-Gm-Message-State: AOJu0YxlMlyHFFk3lmFE//zr+Zq4b9FJR3mj0Ca62tR16TzI7D8JhRas
	yNpvBMA3BlAIcTDvxfLOUQz6/gg+40L1xEp2Npussraeme05y8t7EVTGmVy2obX7Dpje7/q+w4c
	O
X-Google-Smtp-Source: AGHT+IHk6p338B3z/LMD67jKEhthxgFyTy4dmKHEjcuKSs/OjJuAe/i+B64QU7Up/EyJLhqvqrNlbQ==
X-Received: by 2002:a17:902:c411:b0:1fc:6faf:671b with SMTP id d9443c01a7336-1ff04834571mr102147715ad.27.1722431929386;
        Wed, 31 Jul 2024 06:18:49 -0700 (PDT)
Received: from bytedance ([61.213.176.5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7ff680bsm119728425ad.298.2024.07.31.06.18.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 06:18:48 -0700 (PDT)
Date: Wed, 31 Jul 2024 21:18:43 +0800
From: Zhaoyu Liu <liuzhaoyu.zackary@bytedance.com>
To: liuzhaoyu.zackary@bytedance.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] mm: swap: allocate folio only first time in
 __read_swap_cache_async()
Message-ID: <20240731131843.GA2096265@bytedance>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

It should be checked by filemap_get_folio() if SWAP_HAS_CACHE was
marked while reading a share swap page. It would re-allocate a folio
if the swap cache was not ready now. We save the new folio to avoid
page allocating again.

Signed-off-by: Zhaoyu Liu <liuzhaoyu.zackary@bytedance.com>
---
 mm/swap_state.c | 58 ++++++++++++++++++++++++++-----------------------
 1 file changed, 31 insertions(+), 27 deletions(-)

diff --git a/mm/swap_state.c b/mm/swap_state.c
index a1726e49a5eb..65370d148175 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -435,6 +435,8 @@ struct folio *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
 {
 	struct swap_info_struct *si;
 	struct folio *folio;
+	struct folio *new_folio = NULL;
+	struct folio *result = NULL;
 	void *shadow = NULL;
 
 	*new_page_allocated = false;
@@ -463,16 +465,19 @@ struct folio *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
 		 * else swap_off will be aborted if we return NULL.
 		 */
 		if (!swap_swapcount(si, entry) && swap_slot_cache_enabled)
-			goto fail_put_swap;
+			goto put_and_return;
 
 		/*
-		 * Get a new folio to read into from swap.  Allocate it now,
-		 * before marking swap_map SWAP_HAS_CACHE, when -EEXIST will
-		 * cause any racers to loop around until we add it to cache.
+		 * Get a new folio to read into from swap.  Allocate it now if
+		 * new_folio not exist, before marking swap_map SWAP_HAS_CACHE,
+		 * when -EEXIST will cause any racers to loop around until we
+		 * add it to cache.
 		 */
-		folio = folio_alloc_mpol(gfp_mask, 0, mpol, ilx, numa_node_id());
-		if (!folio)
-                        goto fail_put_swap;
+		if (!new_folio) {
+			new_folio = folio_alloc_mpol(gfp_mask, 0, mpol, ilx, numa_node_id());
+			if (!new_folio)
+				goto put_and_return;
+		}
 
 		/*
 		 * Swap entry may have been freed since our caller observed it.
@@ -480,10 +485,8 @@ struct folio *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
 		err = swapcache_prepare(entry);
 		if (!err)
 			break;
-
-		folio_put(folio);
-		if (err != -EEXIST)
-			goto fail_put_swap;
+		else if (err != -EEXIST)
+			goto put_and_return;
 
 		/*
 		 * Protect against a recursive call to __read_swap_cache_async()
@@ -494,7 +497,7 @@ struct folio *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
 		 * __read_swap_cache_async() in the writeback path.
 		 */
 		if (skip_if_exists)
-			goto fail_put_swap;
+			goto put_and_return;
 
 		/*
 		 * We might race against __delete_from_swap_cache(), and
@@ -509,36 +512,37 @@ struct folio *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
 	/*
 	 * The swap entry is ours to swap in. Prepare the new folio.
 	 */
+	__folio_set_locked(new_folio);
+	__folio_set_swapbacked(new_folio);
 
-	__folio_set_locked(folio);
-	__folio_set_swapbacked(folio);
-
-	if (mem_cgroup_swapin_charge_folio(folio, NULL, gfp_mask, entry))
+	if (mem_cgroup_swapin_charge_folio(new_folio, NULL, gfp_mask, entry))
 		goto fail_unlock;
 
 	/* May fail (-ENOMEM) if XArray node allocation failed. */
-	if (add_to_swap_cache(folio, entry, gfp_mask & GFP_RECLAIM_MASK, &shadow))
+	if (add_to_swap_cache(new_folio, entry, gfp_mask & GFP_RECLAIM_MASK, &shadow))
 		goto fail_unlock;
 
 	mem_cgroup_swapin_uncharge_swap(entry);
 
 	if (shadow)
-		workingset_refault(folio, shadow);
+		workingset_refault(new_folio, shadow);
 
-	/* Caller will initiate read into locked folio */
-	folio_add_lru(folio);
+	/* Caller will initiate read into locked new_folio */
+	folio_add_lru(new_folio);
 	*new_page_allocated = true;
+	folio = new_folio;
 got_folio:
-	put_swap_device(si);
-	return folio;
+	result = folio;
+	goto put_and_return;
 
 fail_unlock:
-	put_swap_folio(folio, entry);
-	folio_unlock(folio);
-	folio_put(folio);
-fail_put_swap:
+	put_swap_folio(new_folio, entry);
+	folio_unlock(new_folio);
+put_and_return:
 	put_swap_device(si);
-	return NULL;
+	if (!(*new_page_allocated) && new_folio)
+		folio_put(new_folio);
+	return result;
 }
 
 /*
-- 
2.25.1


