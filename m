Return-Path: <linux-kernel+bounces-172888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A70258BF831
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 10:11:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3391B2187D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 08:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E06D53FE3F;
	Wed,  8 May 2024 08:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gA1++mlU"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05703B7A0
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 08:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715155858; cv=none; b=rG731aQhWAvYdQkqj2og+6OU9hHJRnV2TJx/hvYrKTYAyuraha+SkPwPPHNhgQXNlAeoVZte59lYEhcok+1bfKjnfPWWh4EyGtjfzBQVDaPL1NM+pqRdKSmZEd6eln+Ht8doeVNujBa3ud84luOIb51Fj4Ep/0MmMhr1jPLfIuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715155858; c=relaxed/simple;
	bh=/on5X/cY4M8emv68YO5Q8B0COsehn7OYyz7t0+eXzto=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uck8m7p/XxYNmT+GOH9pzkegsTTaeO6HMSJVSQYnw4ov8hDVchw3fkQsKzJbRdfMbWO+2Uz2bakMDA6SJKWleA6PP5M+BdHV6mSWij1Kr2Mtpn2CwZc+4/zb2IVWsvfgLfu3B1RMesQ0mHmCs+DQwEY/Hyw7JGCsjWfytebcGxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gA1++mlU; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715155856; x=1746691856;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=/on5X/cY4M8emv68YO5Q8B0COsehn7OYyz7t0+eXzto=;
  b=gA1++mlUTTskrDvSlSOwlbQj7O811GMEAZTNr8lIyb1KtKEz5fCsLAGT
   8dntkWHXPRzB6pPOSZo0Yj1Tea7p0eqI3CXX1K9kLjuyhk1HwQeLlGFAT
   zfkIJVw9TmVoHC4pxqVmlPCujNZ9K6tOgq4ChZynSymFg7rtiLB/JaHU8
   XzXk4LOHsa4HfhIZ4lqRgebul+pnNERm9TNyjQ5f6ZA/qCS9qg7fnbhjT
   cn2X8mwfBk3VYom9wdsnlgcBm0K9K9/Z3Jm31iWjnSMUWzujSwv/NHw+X
   N5KaGSh6nBeKf3MtObk8iwwBwNKFHj2rLCL6u8cY3Bc9xvWwHTHFv7vhq
   A==;
X-CSE-ConnectionGUID: 8RJBdDFVRLiPGwQGDXoYAw==
X-CSE-MsgGUID: 01pBGfnSTeOX1vC0W9sMjg==
X-IronPort-AV: E=McAfee;i="6600,9927,11066"; a="10845312"
X-IronPort-AV: E=Sophos;i="6.08,144,1712646000"; 
   d="scan'208";a="10845312"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2024 01:10:56 -0700
X-CSE-ConnectionGUID: kAvrKWCvRniONnhB8OO5sg==
X-CSE-MsgGUID: CRmLOhA8ROSKgO52UJ0qTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,144,1712646000"; 
   d="scan'208";a="29384745"
Received: from unknown (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2024 01:10:51 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org,  linux-mm@kvack.org,
  baolin.wang@linux.alibaba.com,  chrisl@kernel.org,  david@redhat.com,
  hanchuanhua@oppo.com,  hannes@cmpxchg.org,  hughd@google.com,
  kasong@tencent.com,  linux-kernel@vger.kernel.org,  ryan.roberts@arm.com,
  surenb@google.com,  v-songbaohua@oppo.com,  willy@infradead.org,
  xiang@kernel.org,  yosryahmed@google.com,  yuzhao@google.com,
  ziy@nvidia.com
Subject: Re: [PATCH v3 3/6] mm: introduce pte_move_swp_offset() helper which
 can move offset bidirectionally
In-Reply-To: <20240503005023.174597-4-21cnbao@gmail.com> (Barry Song's message
	of "Fri, 3 May 2024 12:50:20 +1200")
References: <20240503005023.174597-1-21cnbao@gmail.com>
	<20240503005023.174597-4-21cnbao@gmail.com>
Date: Wed, 08 May 2024 16:08:59 +0800
Message-ID: <87ttj8iv38.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Barry Song <21cnbao@gmail.com> writes:

> From: Barry Song <v-songbaohua@oppo.com>
>
> There could arise a necessity to obtain the first pte_t from a swap
> pte_t located in the middle. For instance, this may occur within the
> context of do_swap_page(), where a page fault can potentially occur in
> any PTE of a large folio. To address this, the following patch introduces
> pte_move_swp_offset(), a function capable of bidirectional movement by
> a specified delta argument. Consequently, pte_increment_swp_offset()
> will directly invoke it with delta = 1.
>
> Suggested-by: "Huang, Ying" <ying.huang@intel.com>
> Signed-off-by: Barry Song <v-songbaohua@oppo.com>

LGTM, Thanks!  Feel free to add

Reviewed-by: "Huang, Ying" <ying.huang@intel.com>

in the future version.

> ---
>  mm/internal.h | 25 +++++++++++++++++++++----
>  1 file changed, 21 insertions(+), 4 deletions(-)
>
> diff --git a/mm/internal.h b/mm/internal.h
> index c5552d35d995..cfe4aed66a5c 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -211,18 +211,21 @@ static inline int folio_pte_batch(struct folio *folio, unsigned long addr,
>  }
>  
>  /**
> - * pte_next_swp_offset - Increment the swap entry offset field of a swap pte.
> + * pte_move_swp_offset - Move the swap entry offset field of a swap pte
> + *	 forward or backward by delta
>   * @pte: The initial pte state; is_swap_pte(pte) must be true and
>   *	 non_swap_entry() must be false.
> + * @delta: The direction and the offset we are moving; forward if delta
> + *	 is positive; backward if delta is negative
>   *
> - * Increments the swap offset, while maintaining all other fields, including
> + * Moves the swap offset, while maintaining all other fields, including
>   * swap type, and any swp pte bits. The resulting pte is returned.
>   */
> -static inline pte_t pte_next_swp_offset(pte_t pte)
> +static inline pte_t pte_move_swp_offset(pte_t pte, long delta)
>  {
>  	swp_entry_t entry = pte_to_swp_entry(pte);
>  	pte_t new = __swp_entry_to_pte(__swp_entry(swp_type(entry),
> -						   (swp_offset(entry) + 1)));
> +						   (swp_offset(entry) + delta)));
>  
>  	if (pte_swp_soft_dirty(pte))
>  		new = pte_swp_mksoft_dirty(new);
> @@ -234,6 +237,20 @@ static inline pte_t pte_next_swp_offset(pte_t pte)
>  	return new;
>  }
>  
> +
> +/**
> + * pte_next_swp_offset - Increment the swap entry offset field of a swap pte.
> + * @pte: The initial pte state; is_swap_pte(pte) must be true and
> + *	 non_swap_entry() must be false.
> + *
> + * Increments the swap offset, while maintaining all other fields, including
> + * swap type, and any swp pte bits. The resulting pte is returned.
> + */
> +static inline pte_t pte_next_swp_offset(pte_t pte)
> +{
> +	return pte_move_swp_offset(pte, 1);
> +}
> +
>  /**
>   * swap_pte_batch - detect a PTE batch for a set of contiguous swap entries
>   * @start_ptep: Page table pointer for the first entry.

--
Best Regards,
Huang, Ying

