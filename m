Return-Path: <linux-kernel+bounces-547692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AB62A50C70
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 21:26:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A933B170F7E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 20:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 701D12561A1;
	Wed,  5 Mar 2025 20:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rya/Xoqz"
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A9125332F
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 20:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741206359; cv=none; b=ifcq4ySbizPCOJ8+kxBq4BtB4DTkp1XmS+bN1O9oarl4MV0Vt9/zP8+1PBtNb59HNh4pCw5C7plmc3p8GdDVdFPw+tR/KcpXPHdBltLj7YagbVKnGcUuzzVEIOkyaqLuuF9R5UTw8R1GbC70C4isxw8iUHl8REsOq2vWDzfeHVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741206359; c=relaxed/simple;
	bh=E7Ph37HLPnLYBW5e+trrwrWyurq/c5f24rfdoBGBvBw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wh8tK0LKAEH8COwrJFG1vmB3E3+EDdkmBNt0aB6m/GoUU6pZ/3/pLbZpcl/ncwDm3N6Bs5DFwHoPMckFZZeHbC6NKnYC3Y+zcVU+aXsrA/W8ay1LtASS3y1sBZl3P9ednEVf+oorVRvug2qqkp11KSJR5F8JZoyuuHQhwwafOec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rya/Xoqz; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 5 Mar 2025 12:25:51 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741206355;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fwgrm2L/15Tg6ALap1GvUzptrkdyaVeJITaCdfXsz3o=;
	b=rya/Xoqze+07g8TcY+VGyxWhPoUyvkJXnG/JF5LlCx3/Z/QU50WSXxtfpFpqVxGKw9miJg
	Go8CM6KcoceSQcV5kGqdtYF6cJxqapvikFTVQAw2fydQjgq+Gsfj8D3o8mqp4qdmSM8lWh
	hpz1NM3MDREt5qVMQN5qJzXu2CPycvY=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: SeongJae Park <sj@kernel.org>
Cc: "Liam R. Howlett" <howlett@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, kernel-team@meta.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC PATCH 01/16] mm/madvise: use is_memory_failure() from
 madvise_do_behavior()
Message-ID: <exnrnqek3ktgprxzuf27osu6olcnvjzwdlt23a3mm5y2qstl2t@x4ud2xoyguff>
References: <20250305181611.54484-1-sj@kernel.org>
 <20250305181611.54484-2-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250305181611.54484-2-sj@kernel.org>
X-Migadu-Flow: FLOW_OUT

On Wed, Mar 05, 2025 at 10:15:56AM -0800, SeongJae Park wrote:
> To reduce redundant open-coded checks of CONFIG_MEMORY_FAILURE and
> MADV_{HWPOISON,SOFT_OFFLINE} in madvise_[un]lock(), is_memory_failure()
> has introduced.  madvise_do_behavior() is still doing the same
> open-coded check, though.  Use is_memory_failure() instead.
> 
> Signed-off-by: SeongJae Park <sj@kernel.org>
> ---
>  mm/madvise.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/mm/madvise.c b/mm/madvise.c
> index 388dc289b5d1..dbc8fec05cc6 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -1640,10 +1640,8 @@ static int madvise_do_behavior(struct mm_struct *mm,
>  	unsigned long end;
>  	int error;
>  
> -#ifdef CONFIG_MEMORY_FAILURE
> -	if (behavior == MADV_HWPOISON || behavior == MADV_SOFT_OFFLINE)
> +	if (is_memory_failure(behavior))
>  		return madvise_inject_error(behavior, start, start + len_in);

You might want to either define empty madvise_inject_error() for
!CONFIG_MEMORY_FAILURE or keep CONFIG_MEMORY_FAILURE here.

> -#endif
>  	start = untagged_addr_remote(mm, start);
>  	end = start + len;
>  
> -- 
> 2.39.5

