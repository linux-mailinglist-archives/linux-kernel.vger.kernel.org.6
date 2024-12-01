Return-Path: <linux-kernel+bounces-426526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FF249DF469
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 03:40:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2750228141C
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 02:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7098FEAD8;
	Sun,  1 Dec 2024 02:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Jb+hZ8T4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE542DF42
	for <linux-kernel@vger.kernel.org>; Sun,  1 Dec 2024 02:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733020819; cv=none; b=pCFMj25i/U8z+c0b8Z67TUX5dIAxsHIebiJMwxEVafcE6ZZfrAN1chsgPByiZNM6M/UKYe1VJYJngugfqqJqy5ZFdXWYcasdoRcgq0LCr1JdjhlAenoKBS+wMeV1XrmwajORI1x4zi3ZzH+e7Wjx/+BavUwPqqLeji9Lfe5WJPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733020819; c=relaxed/simple;
	bh=LHF1g6N03INHLhmSoxcGvEMY+E3fwJL7iBE1QdZFklA=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=M3lL716IFd9+ZxSkznG1SZIRQKZHaktTeRSACXZs0AyJustzzggL7om2muojCQskPk3gRu8ihx3cbHKOh1Qq7VXXtAx37uQc6hJbNyqqM0X8B+RmvYS/ZutLyMSyB0r4Qu9l9zNDWm5sogRw50A3X3L7zi7jQqCt95Cx+72Y6W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Jb+hZ8T4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CA61C4CECC;
	Sun,  1 Dec 2024 02:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1733020818;
	bh=LHF1g6N03INHLhmSoxcGvEMY+E3fwJL7iBE1QdZFklA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Jb+hZ8T4MSfmF5G0y14DPiO3Mhq5J0qHUrmIpKQbmcGMq4FjOe938Bujj+xZ5FEy2
	 EQCBhZKqHMXlzPSyThaN/WFVEmS9GpHpKoTp4B4kxMO7DBGiK3ON7na2nBqmftPDy2
	 IyK5FKc61XX+ubMOqBn3fygMsUxnd32hH4t+NTKk=
Date: Sat, 30 Nov 2024 18:40:17 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Seiji Nishikawa <snishika@redhat.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 mgorman@techsingularity.net
Subject: Re: [PATCH] mm: vmscan: account for free pages to prevent infinite
 Loop in throttle_direct_reclaim()
Message-Id: <20241130184017.7290e756a5f2199b463a7172@linux-foundation.org>
In-Reply-To: <20241130161236.433747-2-snishika@redhat.com>
References: <20241129043936.316481-1-snishika@redhat.com>
	<20241130161236.433747-1-snishika@redhat.com>
	<20241130161236.433747-2-snishika@redhat.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun,  1 Dec 2024 01:12:34 +0900 Seiji Nishikawa <snishika@redhat.com> wrote:

> The kernel hangs due to a task stuck in throttle_direct_reclaim(),
> caused by a node being incorrectly deemed balanced despite pressure in
> certain zones, such as ZONE_NORMAL. This issue arises from
> zone_reclaimable_pages() returning 0 for zones without reclaimable file-
> backed or anonymous pages, causing zones like ZONE_DMA32 with sufficient
> free pages to be skipped.
> 
> The lack of swap or reclaimable pages results in ZONE_DMA32 being
> ignored during reclaim, masking pressure in other zones. Consequently,
> pgdat->kswapd_failures remains 0 in balance_pgdat(), preventing fallback
> mechanisms in allow_direct_reclaim() from being triggered, leading to an
> infinite loop in throttle_direct_reclaim().
> 
> This patch modifies zone_reclaimable_pages() to account for free pages
> (NR_FREE_PAGES) when no other reclaimable pages exist. This ensures
> zones with sufficient free pages are not skipped, enabling proper
> balancing and reclaim behavior.

We'll want to backport a fix for this into -stable kernels.  For that
it's best to be able to identify a suitable Fixes: target, to tell
others whether their kernel needs the fix.  Are you able to help
identify that commit?

Thanks.

> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -374,7 +374,14 @@ unsigned long zone_reclaimable_pages(struct zone *zone)
>  	if (can_reclaim_anon_pages(NULL, zone_to_nid(zone), NULL))
>  		nr += zone_page_state_snapshot(zone, NR_ZONE_INACTIVE_ANON) +
>  			zone_page_state_snapshot(zone, NR_ZONE_ACTIVE_ANON);
> -
> +	/*
> +	 * If there are no reclaimable file-backed or anonymous pages, 
> +	 * ensure zones with sufficient free pages are not skipped. 
> +	 * This prevents zones like DMA32 from being ignored in reclaim 
> +	 * scenarios where they can still help alleviate memory pressure.
> +	 */
> +	if (nr == 0)
> +	    nr = zone_page_state_snapshot(zone, NR_FREE_PAGES);
>  	return nr;
>  }
>  
> -- 
> 2.47.0

