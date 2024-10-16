Return-Path: <linux-kernel+bounces-367569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A76699A03EC
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 10:16:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BCDA2877E2
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 08:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A00421D14EC;
	Wed, 16 Oct 2024 08:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oqR5qsdi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1078D1C4A2B
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 08:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729066558; cv=none; b=p0Td0IvcRdzP0+Nbgzr99+0SL60A/yIffD9UiUpeyj+VlRTXsFQhd57yfk2c9cFIonbi3IMu/7y3kTnuetwc8E6LmasJr4ycmgSkPW2R4yfEIdC3bolvE3LNE+Czsj3ux9jFVWPkBNlyfhNZuz9KMbziCJAFMGCAwB8WlvJZrXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729066558; c=relaxed/simple;
	bh=paOfskxnn7huquWUaZ1z3Ki63NJ44tEyCzZcQM3Eqsk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jgYWAtXzgn6P5TdLaHUP1XtjS4yIxsZJh+vTinp22+w90xus+VEIASFGK31Sft7YB/sFGYMoOd0+LUcvq0KFgACY9D5VRxbn0UaKWeaGAOw7tRUFwT4kajA2Xi/cG6IljZPyc4y3u5VeIshKI+eEoKsaL0055alS36801MPmWh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oqR5qsdi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B789EC4CECE;
	Wed, 16 Oct 2024 08:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729066557;
	bh=paOfskxnn7huquWUaZ1z3Ki63NJ44tEyCzZcQM3Eqsk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oqR5qsdiN7DIXQ1uMZ2eyas6EtLCo3X6jIjqexMT8BSRUy1XXhOXyfZcTSG3RKp7g
	 OEfLbQO6KkfWnF+6qpR0k7oPiSw0TGLA1HBs/qH9WvhgkBp+LH7TRhtgkZUbSEZ5as
	 c0xbLCpAVblXpFTlmYqoQDg6gyjwPf2VCQIlm1uMJSC/jUWlXrn7rlb/CpcOjhUNEJ
	 Yvh3xrA739UxCYNkgt5fKt4Qu06DhXJg8IPDR4203yI4Ipuu9FnpvaRPCGbus0zNTu
	 6ApGrPDperlLMvdjPZ0rGqeZ1Ct4y88CSLBxF48jwr2SoUgPLD7mBIIOjtKNm9hK4d
	 PjRUNZB+3Tv3Q==
Date: Wed, 16 Oct 2024 11:12:18 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, yuji2.ishikawa@toshiba.co.jp
Subject: Re: [PATCH RFC] mm: numa_clear_kernel_node_hotplug: Add NUMA_NO_NODE
 check for node id
Message-ID: <Zw91Ynr53eGwj91r@kernel.org>
References: <1729057030-4625-1-git-send-email-nobuhiro1.iwamatsu@toshiba.co.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1729057030-4625-1-git-send-email-nobuhiro1.iwamatsu@toshiba.co.jp>

On Wed, Oct 16, 2024 at 02:37:10PM +0900, Nobuhiro Iwamatsu wrote:
> The acquired memory blocks for reserved may include blocks outside of
> memory management. In this case, the nid variable is set to NUMA_NO_NODE
> (-1), so an error occurs in node_set().
> This adds a check to numa_clear_kernel_node_hotplug that skips node_set
> when nid is set to NUMA_NO_NODE.
> 
> Fixes: 87482708210f ("mm: introduce numa_memblks")
> Suggested-by: Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>
> Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
> Cc: Mike Rapoport (Microsoft) <rppt@kernel.org>
> ---
>  mm/numa_memblks.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/numa_memblks.c b/mm/numa_memblks.c
> index be52b93a9c58..b982f9260872 100644
> --- a/mm/numa_memblks.c
> +++ b/mm/numa_memblks.c
> @@ -349,7 +349,7 @@ static void __init numa_clear_kernel_node_hotplug(void)
>  	for_each_reserved_mem_region(mb_region) {
>  		int nid = memblock_get_region_node(mb_region);
>  
> -		if (nid != MAX_NUMNODES)
> +		if (nid != NUMA_NO_NODE && nid != MAX_NUMNODES)

We have numa_valid_node() check for this, please use that.
Otherwise

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

>  			node_set(nid, reserved_nodemask);
>  	}
>  
> -- 
> 2.45.2
> 
> 

-- 
Sincerely yours,
Mike.

