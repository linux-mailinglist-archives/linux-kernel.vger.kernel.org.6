Return-Path: <linux-kernel+bounces-170338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 020F48BD564
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 21:25:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96C7C1F22D73
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 19:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87CC715956B;
	Mon,  6 May 2024 19:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="T9cbPrAc"
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E6515921C
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 19:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715023525; cv=none; b=G1GU9HpMxwlZNBAxUyT3W1iiyfSDiLEBnfFolQOU7TjQCvfNTcmcuCI9i/YlRgBhoszweg6kv+2PNJpPz1hZVAD3uXPcRqj8lXFndwzYcN9faZME7Afvswj9EdlSnOxrrWR9i3v92YAkRxM5IBe05QdWCSfGH/9rgEwKSfrnPyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715023525; c=relaxed/simple;
	bh=262GQmeTYIr1CgyTlhpiy51LdD2LjO0oEukrAEOG+OY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IkS5kPlG42sl2RdmgjEWoJLx38nGLDh7lzKt/K5acpliKGz3CutSC48OuKlCudRvS/MI9e6QjL3Q1IAj6JN65FcQ4FR8wQ919LD6M4qKShhUcr39SyYZiQGZ9fgrSM+nWUWqfUgEStnmfvd5093NrdykZSKOvBNr78jU/VHVqMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=T9cbPrAc; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 6 May 2024 12:25:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1715023521;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gxbtAlVeF1/sUOU5uEW9t+ZyL4fh7ysXOylZq3pXva4=;
	b=T9cbPrAcYBtaXsosnsqLQXaQuAZ+LPyXYpdVTa780mNBy7ZSsC/zltH2S8h0boDI8LfmXy
	sYcDHXn7NMzZ/dlEFAT3/vWtFvdyybg5Lm7dAwyNVsC+0AncWVvtNaY/QUEVU4t9kiA8TM
	QIlxXVrydo0sNa2WAvWZF0Z6pIfVM0M=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+9319a4268a640e26b72b@syzkaller.appspotmail.com
Subject: Re: [PATCH] mm: do not update memcg stats for
 NR_{FILE/SHMEM}_PMDMAPPED
Message-ID: <xhytcu3lz2qm7qt2cfkp26z5h57k2ehpd7zw4jugywituldykh@spysi6qb2e3z>
References: <20240506170024.202111-1-yosryahmed@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240506170024.202111-1-yosryahmed@google.com>
X-Migadu-Flow: FLOW_OUT

On Mon, May 06, 2024 at 05:00:24PM +0000, Yosry Ahmed wrote:
> Do not use __lruvec_stat_mod_folio() when updating NR_FILE_PMDMAPPED and
> NR_SHMEM_PMDMAPPED as these stats are not maintained per-memcg. Use
> __mod_node_page_state() instead, which updates the global per-node stats
> only.
> 
> Reported-by: syzbot+9319a4268a640e26b72b@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/lkml/0000000000001b9d500617c8b23c@google.com
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>

I think we can put Fixes either for 443c077dc2ec ("memcg: cleanup
__mod_memcg_lruvec_state") or ad86c0f0e089 ("memcg: warn for unexpected
events and stats").

> ---
>  mm/rmap.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/rmap.c b/mm/rmap.c
> index 12be4241474ab..c2cfb750d2535 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -1435,13 +1435,14 @@ static __always_inline void __folio_add_file_rmap(struct folio *folio,
>  		struct page *page, int nr_pages, struct vm_area_struct *vma,
>  		enum rmap_level level)
>  {
> +	pg_data_t *pgdat = folio_pgdat(folio);
>  	int nr, nr_pmdmapped = 0;
>  
>  	VM_WARN_ON_FOLIO(folio_test_anon(folio), folio);
>  
>  	nr = __folio_add_rmap(folio, page, nr_pages, level, &nr_pmdmapped);
>  	if (nr_pmdmapped)
> -		__lruvec_stat_mod_folio(folio, folio_test_swapbacked(folio) ?
> +		__mod_node_page_state(pgdat, folio_test_swapbacked(folio) ?
>  			NR_SHMEM_PMDMAPPED : NR_FILE_PMDMAPPED, nr_pmdmapped);
>  	if (nr)
>  		__lruvec_stat_mod_folio(folio, NR_FILE_MAPPED, nr);
> @@ -1493,6 +1494,7 @@ static __always_inline void __folio_remove_rmap(struct folio *folio,
>  		enum rmap_level level)
>  {
>  	atomic_t *mapped = &folio->_nr_pages_mapped;
> +	pg_data_t *pgdat = folio_pgdat(folio);
>  	int last, nr = 0, nr_pmdmapped = 0;
>  	bool partially_mapped = false;
>  	enum node_stat_item idx;
> @@ -1540,13 +1542,14 @@ static __always_inline void __folio_remove_rmap(struct folio *folio,
>  	}
>  
>  	if (nr_pmdmapped) {
> +		/* NR_{FILE/SHMEM}_PMDMAPPED are not maintained per-memcg */
>  		if (folio_test_anon(folio))
> -			idx = NR_ANON_THPS;
> -		else if (folio_test_swapbacked(folio))
> -			idx = NR_SHMEM_PMDMAPPED;
> +			__lruvec_stat_mod_folio(folio, NR_ANON_THPS, -nr_pmdmapped);
>  		else
> -			idx = NR_FILE_PMDMAPPED;
> -		__lruvec_stat_mod_folio(folio, idx, -nr_pmdmapped);
> +			__mod_node_page_state(pgdat,
> +					folio_test_swapbacked(folio) ?
> +					NR_SHMEM_PMDMAPPED : NR_FILE_PMDMAPPED,
> +					nr_pmdmapped);

After the above fixed, you can add:

Acked-by: Shakeel Butt <shakeel.butt@linux.dev>


