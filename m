Return-Path: <linux-kernel+bounces-384085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F09F29B2417
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 06:24:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8010F2818F4
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 05:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C1D918C031;
	Mon, 28 Oct 2024 05:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="o2Iqs6Jt"
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA638646
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 05:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730093064; cv=none; b=TYt2ONy3j1r+0mdtyRULE2YCT8XYsNLHwtHLu2/V2jsxIUCzJbZHLRGT8PzDmBQy+TXfwOLgLCIccNwQBzc9s/B0WYdm6GqWRrcY/BOa+fqBJ4X/lbmZL5vuG4ar99AMlD6TadQmNKSCQ3PY/n4MYntzBtgUFzKrmdnFBqCdK3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730093064; c=relaxed/simple;
	bh=ObbtlVLic1lw8goR74YlBuydOPp6zQZAy36KCamphyg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qCSeW1avdMZY7oxsVjfAO/S6z2R04tbT9WjOFQ9QdJNIp6n+0Oah0zYnHBrgrO4rXnkK9uhof7vqK+H7s6bdo6x11k+ML4r+lc6Z+GqmyKXPnkkV3LzIMoUHrDyixsb4LjHL2GztRLHJSwFTosq/nL5T2rXepmdzQYLDf/6A730=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=o2Iqs6Jt; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sun, 27 Oct 2024 22:24:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1730093055;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vKZnBJgkLTis6WvRFORsBrAnvo1jFKMJKIcz0ymTvdQ=;
	b=o2Iqs6JtXSYHLBrFRFXW3kT3XWOcfmAqgYRd7O/2nx/1zujWHjLpxdWT9xLf0jh2qA093q
	vaxucCZvB90DEXRk0mi/tmDcg79HploTxSXMX9lSSqecDOB2W8ZCQZPPWrBr26GaIqEP4O
	Gx0QdGL8Eu0EApGnx13PDbW/nh+aPFY=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Gregory Price <gourry@gourry.net>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, kernel-team@meta.com, 
	akpm@linux-foundation.org, ying.huang@intel.com, weixugc@google.com, 
	dave.hansen@linux.intel.com, osalvador@suse.de, shy828301@gmail.com, stable@vger.kernel.org
Subject: Re: [PATCH] vmscan,migrate: fix double-decrement on node stats when
 demoting pages
Message-ID: <mjfsmy5naqj2oimgelvual6zpfinbugmbqy7kmbs2c2f7ll5jr@z4rl5zzdvrat>
References: <20241025141724.17927-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241025141724.17927-1-gourry@gourry.net>
X-Migadu-Flow: FLOW_OUT

On Fri, Oct 25, 2024 at 10:17:24AM GMT, Gregory Price wrote:
> When numa balancing is enabled with demotion, vmscan will call
> migrate_pages when shrinking LRUs.  Successful demotions will
> cause node vmstat numbers to double-decrement, leading to an
> imbalanced page count.  The result is dmesg output like such:
> 
> $ cat /proc/sys/vm/stat_refresh
> 
> [77383.088417] vmstat_refresh: nr_isolated_anon -103212
> [77383.088417] vmstat_refresh: nr_isolated_file -899642
> 
> This negative value may impact compaction and reclaim throttling.
> 
> The double-decrement occurs in the migrate_pages path:
> 
> caller to shrink_folio_list decrements the count
>   shrink_folio_list
>     demote_folio_list
>       migrate_pages
>         migrate_pages_batch
>           migrate_folio_move
>             migrate_folio_done
>               mod_node_page_state(-ve) <- second decrement
> 
> This path happens for SUCCESSFUL migrations, not failures. Typically
> callers to migrate_pages are required to handle putback/accounting for
> failures, but this is already handled in the shrink code.
> 
> When accounting for migrations, instead do not decrement the count
> when the migration reason is MR_DEMOTION. As of v6.11, this demotion
> logic is the only source of MR_DEMOTION.
> 
> Signed-off-by: Gregory Price <gourry@gourry.net>
> Fixes: 26aa2d199d6f2 ("mm/migrate: demote pages during reclaim")
> Cc: stable@vger.kernel.org

Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>

This patch looks good for stable backports. For future I wonder if
instead of migrate_pages(), the caller providing the isolated folios,
manages the isolated stats (increments and decrements) similar to how
reclaim does it.

> ---
>  mm/migrate.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 923ea80ba744..e3aac274cf16 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1099,7 +1099,7 @@ static void migrate_folio_done(struct folio *src,
>  	 * not accounted to NR_ISOLATED_*. They can be recognized
>  	 * as __folio_test_movable
>  	 */
> -	if (likely(!__folio_test_movable(src)))
> +	if (likely(!__folio_test_movable(src)) && reason != MR_DEMOTION)
>  		mod_node_page_state(folio_pgdat(src), NR_ISOLATED_ANON +
>  				    folio_is_file_lru(src), -folio_nr_pages(src));
>  
> -- 
> 2.43.0
> 

