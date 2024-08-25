Return-Path: <linux-kernel+bounces-300554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80C0295E508
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 22:10:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34F122815A2
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 20:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 255B8157A6C;
	Sun, 25 Aug 2024 20:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c0pYPWKf"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B6D801
	for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 20:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724616600; cv=none; b=bFpwj2QjAKij+o0DVSOlbzCz+bU2+3XnAVtbMd+wmun0tVVOhfUb4eOiifGb6Tkj4t8iM342Gz9edtfQfizX9m+U9wGHIV444YHYSIhCO3ZFDSC6vDDw65jSCqMZG7MhRh0hiJ3l3Ca57oBeehd8WunJ/rZaF0zY0unnVBi2iqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724616600; c=relaxed/simple;
	bh=q57ET+f6ygnmgbWmR7czSsxa8EjuSqc+Z5cLEQWTYUo=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=JzKQQEbbgU5Bx9dH/AwJD5eD0UNR+r4dRnId5vhHXaPed0Fbk5UMs5mrlgyhA9ACF47l8tu+uwaM3+K2pOjVNfR1mWHSsnr6GEit+TV4kBttwAMp5hNso/S6gUQWvjjKNCGi26kDu5x3GftIaQweCHm8RZKGxiNNPhFvpRakzFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=c0pYPWKf; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-7cd9d408040so2476274a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 13:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724616598; x=1725221398; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CWHFnrQEGj5Ht1yOFJDGh50JpswZV3cRjQ1W+u6fDyo=;
        b=c0pYPWKfSDnOSOEFrhhWvzyLvhkn7MW1L3EHBqoDgP97lDPjqk+Hl/vmcCgD9By35o
         S5/+pRshYtt5k94N+Mp/sPgvxypVFA5vyVVWg2C2ThPUUPsXh/JNM5/IOfI+6k4QTbq3
         BCYLb5iNvZy+b0h5KBNxPCNSy61GRCyqOTvJvFGhGSDLZ32+g3rQbPP35wYG16Fwplfj
         6k+/79hIAR3Fwe7hyRYwLX9S4KjudUwbh5DyIoRAztJW43WvAG+AeyrbIOtD8tMlx+iK
         NVicPzfCWZFVZ2AC09Bcs/GwKnSkqZ7VWpDi946uQK6IDRR160H7ws3X+vZDJcplcKGT
         L4eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724616598; x=1725221398;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CWHFnrQEGj5Ht1yOFJDGh50JpswZV3cRjQ1W+u6fDyo=;
        b=aFccAxdli6V9EwHhthRdU0xsf3Fn6Ju5HAMmYk3mImGsx+7n/6OzY4dcTIbLncSr6Y
         kQycS/8Q6dBDDe0WzJJzDqXFgLheSXr90CMVzY6gHxjwbRR1mSuGE0T1uMSQ6UzpaIkb
         pUsejKrW1Lu/VGpTueERT9OkSBYdzlPDnVafTTKvGkBjWSJ+mnCY604ormALYnj9Porz
         Do9o9cpEObcOaZBHPWBn1LKaEnkGbUbUvVTA9+5wd7oajuombnaQ9oPU8DFMPdTjEztA
         x0qWg9RAqRcSJSFgPpYETSIEyDa94f5eGp+S6DKmyIayMJW9hGuuc3jyizqnMCvK+bCg
         6rQg==
X-Forwarded-Encrypted: i=1; AJvYcCUqoZsMj0kAuO83QsktFSvgFjnIW/5PpF/yQEFS6xrAIDjE64Vc33k1Zqfngg8rApgAxee/60wquVOzmaI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyF8NNH2303uWncQcBIosUbvQ4dlS2qkbFVhDgUV4gazA1yvnzf
	uNywAII1W3BvtP4+OS5sKfkz29vFzGHZ61SMq9UpZMGyN1YC03j+1wAgRCxRUQ==
X-Google-Smtp-Source: AGHT+IE4JlewYcwKbLYTy17wMYrbgSoNDCjG32TUPtDDFX/hpSki7y2PWuwuX7h5hECFwzqxG/TRSg==
X-Received: by 2002:a17:903:2310:b0:203:a22f:6b09 with SMTP id d9443c01a7336-203a22f6b2emr111839355ad.13.1724616597825;
        Sun, 25 Aug 2024 13:09:57 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-203855dbefbsm56949855ad.136.2024.08.25.13.09.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Aug 2024 13:09:56 -0700 (PDT)
Date: Sun, 25 Aug 2024 13:09:46 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: Andrew Morton <akpm@linux-foundation.org>, Barry Song <21cnbao@gmail.com>
cc: chrisl@kernel.org, david@redhat.com, hughd@google.com, 
    justinjiang@vivo.com, kaleshsingh@google.com, kasong@tencent.com, 
    linux-kernel@vger.kernel.org, linux-mm@kvack.org, ryan.roberts@arm.com, 
    v-songbaohua@oppo.com, ying.huang@intel.com, yosryahmed@google.com
Subject: Re: [PATCH v3 2/2] mm: attempt to batch free swap entries for
 zap_pte_range()
In-Reply-To: <20240815215308.55233-1-21cnbao@gmail.com>
Message-ID: <33f34a88-0130-5444-9b84-93198eeb50e7@google.com>
References: <CACePvbUOgPLyCPzQMvH8sNZj_=FayR9Y7A4sGBEyk4ubW1Uo_w@mail.gmail.com> <20240815215308.55233-1-21cnbao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 16 Aug 2024, Barry Song wrote:
> Subject: [PATCH] mm: check all swaps belong to same swap_cgroup in
>  swap_pte_batch()
> 
> Right now, it is possible two folios are contiguous in swap slots
> but they don't belong to one memcg. In this case, even we return
> a large nr, we can't really batch free all slots.
> 
> Reported-by: Yosry Ahmed <yosryahmed@google.com>
> Reported-by: Chris Li <chrisl@kernel.org>
> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> ---
>  mm/internal.h | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/internal.h b/mm/internal.h
> index adbf8c88c9df..d1f1e221212d 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -15,6 +15,7 @@
>  #include <linux/rmap.h>
>  #include <linux/swap.h>
>  #include <linux/swapops.h>
> +#include <linux/swap_cgroup.h>
>  #include <linux/tracepoint-defs.h>
>  
>  /* Internal core VMA manipulation functions. */
> @@ -275,18 +276,22 @@ static inline int swap_pte_batch(pte_t *start_ptep, int max_nr, pte_t pte)
>  {
>  	pte_t expected_pte = pte_next_swp_offset(pte);
>  	const pte_t *end_ptep = start_ptep + max_nr;
> +	swp_entry_t entry = pte_to_swp_entry(pte);
>  	pte_t *ptep = start_ptep + 1;
> +	unsigned short cgroup_id;
>  
>  	VM_WARN_ON(max_nr < 1);
>  	VM_WARN_ON(!is_swap_pte(pte));
> -	VM_WARN_ON(non_swap_entry(pte_to_swp_entry(pte)));
> +	VM_WARN_ON(non_swap_entry(entry));
>  
> +	cgroup_id = lookup_swap_cgroup_id(entry);
>  	while (ptep < end_ptep) {
>  		pte = ptep_get(ptep);
>  
>  		if (!pte_same(pte, expected_pte))
>  			break;
> -
> +		if (lookup_swap_cgroup_id(pte_to_swp_entry(pte)) != cgroup_id)
> +			break;
>  		expected_pte = pte_next_swp_offset(expected_pte);
>  		ptep++;
>  	}
> -- 

[PATCH] mm: check all swaps belong to same swap_cgroup in swap_pte_batch() fix

mm-unstable swap_pte_batch() adds a new usage of lookup_swap_cgroup_id(),
which crashes if CONFIG_MEMCG kernel booted with "cgroup_disable=memory":
it now needs a mem_cgroup_disabled() check.

Fixes: 92b50df44566 ("mm: check all swaps belong to same swap_cgroup in swap_pte_batch()")
Signed-off-by: Hugh Dickins <hughd@google.com>
---
 mm/swap_cgroup.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/swap_cgroup.c b/mm/swap_cgroup.c
index db6c4a26cf59..da1278f0563b 100644
--- a/mm/swap_cgroup.c
+++ b/mm/swap_cgroup.c
@@ -161,6 +161,8 @@ unsigned short swap_cgroup_record(swp_entry_t ent, unsigned short id,
  */
 unsigned short lookup_swap_cgroup_id(swp_entry_t ent)
 {
+	if (mem_cgroup_disabled())
+		return 0;
 	return lookup_swap_cgroup(ent, NULL)->id;
 }
 
-- 
2.35.3

