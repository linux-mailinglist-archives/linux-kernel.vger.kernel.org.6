Return-Path: <linux-kernel+bounces-269277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D6FAC9430DF
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 15:31:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32A8A1F2174F
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 13:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 954E21B0125;
	Wed, 31 Jul 2024 13:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="jMQjRHfV"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459EE2208E
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 13:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722432670; cv=none; b=ipTFD3KVna9pIbb0mYTYKzkmEv83w63WmJDR9NGUEeKjJbhAb71y9lb5SwaROsMmn7FI2Z8YgvgtQeFvVKsYIlGDX9i62WLl6f9kUZ3e4HE6ycO8PIBcoaIVAAkYHy+mHccpWFYLzzjCVOn0+Yf0k1TlV3uccwXcED6gNjBhqqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722432670; c=relaxed/simple;
	bh=1/qx34Nij3yLpgUt8LZJc0FFqYmOJwwjjy6Tq87FyPM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=M9C49VZCOEd7zZAJdM0o8Ukaih3C8X2j8z2Dr7K968VIOCfh5vNOLl0MFusShvJpP2zK1xf3DV4SSCA0KMSU0cO+l2ie/1pspy6qkS+d6i9yHuFQOhzC2gZzwsp77a0Q/60hyM9nR1IBe7DAUjXc8caI2EySJ8tV9wRd697QWKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=jMQjRHfV; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-70d18112b60so786360b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 06:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1722432667; x=1723037467; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z52FQ6IMmQxAE0Vu/r8CqKepvmtrEbW9y0jq8OJjDbo=;
        b=jMQjRHfVN9JcOkIjQxs/novwwjt9ankiVHWyS9fY9Sll/vPw+pyn070wGGJdsT7aDZ
         Whw7Cuw5dcn9oUcxKPC41lHoy2QBS5F8AUrCtoj+nPc1oXVnlvNh6ro2lBqQapIG9t8q
         9yozJxiMlR14+B4YsbLxY8346sCdfwKMKdvFzl19CRkzCF92Hd0xlR5CjrhkElabZJDW
         Og2bwczyaUkLi60Yfe6/n92eOSv96HKdric2EzDbUCOF3d5RdJyDcsmi8i0eNjwFFbQN
         qehZA/B0MWzuX6JEqNzLKNW/EHlMTNF5NAQliDT8PR0jU6/b28Yd16FYAPn+S2WkQaOH
         QECA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722432667; x=1723037467;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z52FQ6IMmQxAE0Vu/r8CqKepvmtrEbW9y0jq8OJjDbo=;
        b=ZxIyj4BXFuUlZjkUqhrdGin1HM0Lr7Lm0iFiZfx55msNsSWOTAM8pXTjHfnvHBbLqX
         Rcmc/itjndxKD0I5J0JaWmMU83HXn+NleQCCZmN0OcB9rjN1E6zE2B8ZA74Bj4Qbi9WS
         4axGe6Wn4GnhWQjVedGA/EIqahND3RLLEquVODaXL7PMgQwsWrGav+3+apIEXnEQ55NE
         E416cy2G0gJPMcQhiT07KWiZwBf3tJFelTxrD/absG2bH9pSrlpREiYhS+lvZ7vLIUiH
         mBeT5pyiwhUlJ1mFXHT/cfRnXyqTN8bVVGLM2sZUs8Ncm7h9GC3voYnnb+5+RgBMstlK
         dkjg==
X-Forwarded-Encrypted: i=1; AJvYcCUQ42/tqXgnXDMyeL+H5XnbyvcchI86bFhNcXyov2CStXHhcDwXLD9cujnAURTqNEnK2w/DKIluzK1VrTWybXECXhv/Ik9ROo+S8Ja1
X-Gm-Message-State: AOJu0YzUCuKsWRy62W4p+rOI5IabJmxvbBXk5UQIywTBjERqvAluc9rb
	PAiQnyX7c9WsPr5WrrGJ0QHBlZNVDZ+56jyAJyNZVZ2WX4zk/FPNQ3QrW9Y5Bzg=
X-Google-Smtp-Source: AGHT+IF93ibecEsrYcc1mRikbveAvCcWnsS0go9P9hn4E6LK6lktVWBPrpHsI1u0MoKg5zsWOyR1kw==
X-Received: by 2002:aa7:9088:0:b0:704:2516:8d17 with SMTP id d2e1a72fcca58-70efe449177mr7721685b3a.8.1722432667231;
        Wed, 31 Jul 2024 06:31:07 -0700 (PDT)
Received: from bytedance ([61.213.176.6])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70ead819d68sm9967873b3a.122.2024.07.31.06.31.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 06:31:06 -0700 (PDT)
Date: Wed, 31 Jul 2024 21:31:01 +0800
From: Zhaoyu Liu <liuzhaoyu.zackary@bytedance.com>
To: akpm@linux-foundation.org, kasong@tencent.com, willy@infradead.org,
	cerasuolodomenico@gmail.com
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mm: swap: allocate folio only first time in
 __read_swap_cache_async()
Message-ID: <20240731133101.GA2096752@bytedance>
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


