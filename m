Return-Path: <linux-kernel+bounces-577585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29638A71F29
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 20:30:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B04B33A3C3A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 19:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3529253B43;
	Wed, 26 Mar 2025 19:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H4Ob30Ax"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD511F416F
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 19:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743017353; cv=none; b=gBxuUYPvvf6wA25yuBxZthFKoUOsy/9id05BFEn1OyRJTfgoxOZdrzyguio19Ypo58HucZvbKbSf1e8FB4uLMAQgXGTRbZBbQgoVYOmzo0y2n2CJ3DlH1gjTOITZV8ziFVvYzMCetJKijhJ2z+GuKhokPf5ksI3VUo5+FyCnFvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743017353; c=relaxed/simple;
	bh=fsm4/swelvXW96SQIxi75KS0V72OLyJnZi8zkA0ewxo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SUALK8j0tA/kXG7kHylBYEFXSCASKW90/lstBUwzpAggtm4kEdwUdhdMcIW4P3VwDHjjJW/I1KpI9M89D/Lf8jFogjBJ5A6F+qgYhfD1hSbFVd+eLfL6Kuh5GUxzKfkwqbAEILHEw9xF1+kJHy478NqwykInFoysSBbmGx425Sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H4Ob30Ax; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0AB7C4CEE2;
	Wed, 26 Mar 2025 19:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743017352;
	bh=fsm4/swelvXW96SQIxi75KS0V72OLyJnZi8zkA0ewxo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H4Ob30AxxE8pcmhK5XDYw7dnctJwcwk3XpLSPbny9Xi4N3gCvijUJFTXe/1TOSuIH
	 DmRuaVVJLr6BLIq0r74M7A24glNIVd74ShwiilwkVN2+7cQ8eHVsQl9S+BbxgVaswO
	 UybsBLMK7oWC4EOu4LBaWn39Yg2F2H3E32RuEcMpqAnoiHiXnTd4auD1aKHtuj774e
	 1dXBlFcWwEv0RYu4x2B0wNPAK5TwepsdQxcT9+/YQ4iBtfjT/DkipFyvHviUpQmblH
	 BM4jgCcn61CH+b8KWgeC02UJ05h5ipKTC0I+A/zvpI2PlLV7v3VpjHnDc9KJG1/Wh3
	 tHxHO6xHVCsTQ==
Date: Wed, 26 Mar 2025 15:29:10 -0400
From: Mike Rapoport <rppt@kernel.org>
To: Ye Liu <ye.liu@linux.dev>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Ye Liu <liuye@kylinos.cn>
Subject: Re: [PATCH] mm/show_mem: Optimize si_meminfo_node by reducing
 redundant code
Message-ID: <Z-RVhrZuybsQj7l0@kernel.org>
References: <20250325073803.852594-1-ye.liu@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250325073803.852594-1-ye.liu@linux.dev>

On Tue, Mar 25, 2025 at 03:38:03PM +0800, Ye Liu wrote:
> From: Ye Liu <liuye@kylinos.cn>
> 
> Refactors the si_meminfo_node() function by reducing redundant code and
> improving readability.
> 
> Moved the calculation of managed_pages inside the existing loop that
> processes pgdat->node_zones, eliminating the need for a separate loop.
> 
> Simplified the logic by removing unnecessary preprocessor conditionals.
> 
> Ensured that both totalram, totalhigh, and other memory statistics are
> consistently set without duplication.
> 
> This change results in cleaner and more efficient code without altering
> functionality.
> 
> Signed-off-by: Ye Liu <liuye@kylinos.cn>
> ---
>  mm/show_mem.c | 16 +++++-----------
>  1 file changed, 5 insertions(+), 11 deletions(-)
> 
> diff --git a/mm/show_mem.c b/mm/show_mem.c
> index 6af13bcd2ab3..ad373b4b6e39 100644
> --- a/mm/show_mem.c
> +++ b/mm/show_mem.c
> @@ -94,26 +94,20 @@ void si_meminfo_node(struct sysinfo *val, int nid)
>  	unsigned long free_highpages = 0;
>  	pg_data_t *pgdat = NODE_DATA(nid);
>  
> -	for (zone_type = 0; zone_type < MAX_NR_ZONES; zone_type++)
> -		managed_pages += zone_managed_pages(&pgdat->node_zones[zone_type]);
> -	val->totalram = managed_pages;
> -	val->sharedram = node_page_state(pgdat, NR_SHMEM);
> -	val->freeram = sum_zone_node_page_state(nid, NR_FREE_PAGES);
> -#ifdef CONFIG_HIGHMEM
>  	for (zone_type = 0; zone_type < MAX_NR_ZONES; zone_type++) {
>  		struct zone *zone = &pgdat->node_zones[zone_type];
> -
> +		managed_pages += zone_managed_pages(zone);

nit: don't remove the empty line after the declaration

>  		if (is_highmem(zone)) {
>  			managed_highpages += zone_managed_pages(zone);

Looks like highmem pages get counted twice, no?

>  			free_highpages += zone_page_state(zone, NR_FREE_PAGES);
>  		}
>  	}
> +
> +	val->totalram = managed_pages;
> +	val->sharedram = node_page_state(pgdat, NR_SHMEM);
> +	val->freeram = sum_zone_node_page_state(nid, NR_FREE_PAGES);
>  	val->totalhigh = managed_highpages;
>  	val->freehigh = free_highpages;
> -#else
> -	val->totalhigh = managed_highpages;
> -	val->freehigh = free_highpages;
> -#endif
>  	val->mem_unit = PAGE_SIZE;
>  }
>  #endif
> -- 
> 2.25.1
> 
> 

-- 
Sincerely yours,
Mike.

