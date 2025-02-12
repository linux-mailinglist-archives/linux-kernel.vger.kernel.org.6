Return-Path: <linux-kernel+bounces-511680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 348C0A32E3C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 19:14:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF8A81677ED
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 18:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 778A325D55D;
	Wed, 12 Feb 2025 18:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a8M8aasG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE6F25D527
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 18:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739384076; cv=none; b=ajruL9G/X2TwX8SmZEPD1uuDCppQlQPTrH70rLtq4U+Gmkt+IwnhjzWg3GuxHHPSv6dtC1ZQYV+dbEG2T3/dltfmtuNvSfr3iRKp73vJFpxghXcIr0bynjVLCnZD2aLmQL2wwG+yAxyf/y1HhLJ94I8ndPxy33jBsA/ZykOSeK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739384076; c=relaxed/simple;
	bh=OzqjcEyZwG+WEGrwy6I+hrxWZBXusE11+Xm5A2cAxMs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZmW492v+irrVIoQ4iYiPdWmg9aPnaDiOFMg0BqrFzfSRlaeeGAaZVlbg4QnI3kpeC7MHYnLK1AlN5T1ZkmjyWbJijP4lOut77AkysyNBi26XM5PTIlWXGi+Gr3vTmaxTxiSlxlwGmNcKmFKZvaZcc3Ibzlj8/AQlwJwY5FkFSV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a8M8aasG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2140FC4CEDF;
	Wed, 12 Feb 2025 18:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739384076;
	bh=OzqjcEyZwG+WEGrwy6I+hrxWZBXusE11+Xm5A2cAxMs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a8M8aasGpl3m9DKYMQ+BCoXPdsaLq01KB5xDLVxqjhQyvrn/edXaft3pTcazDVeks
	 7yrRN3p7tyNIf6+vXJkfUXtHLb+rdQdmrLKTRGQZGiIMUd2Yfihfs0GRu1UNpSxPE8
	 rFH6UtErLR2QoIE+2k0T0ufH1wHkdwIJ8t6FJITBPtANns9djmuL2QG8z+LF3uAmy7
	 nH+7pXLBln7MjLq6abTTUZ6IbFb8PSxn1BtCzT+Rp1F9tkdTEfOQMNt6Q8pUa9NRwS
	 9X+XueWj94yeOpnxk7eTvAn2RawKcm+ehgO4DC0ak1OMu8dv6DxJZRnKiGN4Ad9gfn
	 tbw9oR8No68cA==
Date: Wed, 12 Feb 2025 08:14:35 -1000
From: Tejun Heo <tj@kernel.org>
To: Michal Hocko <mhocko@suse.com>
Cc: Dennis Zhou <dennis@kernel.org>, Filipe Manana <fdmanana@suse.com>,
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm, percpu: do not consider sleepable allocations atomic
Message-ID: <Z6zlC3juT46dLHr9@slm.duckdns.org>
References: <20250206122633.167896-1-mhocko@kernel.org>
 <Z6u5OJIQBw8QLGe_@slm.duckdns.org>
 <Z6zS4Dtyway78Gif@tiehlicka>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6zS4Dtyway78Gif@tiehlicka>

Hello,

On Wed, Feb 12, 2025 at 05:57:04PM +0100, Michal Hocko wrote:
...
> I have gone with masking because that seemed easier to review and more
> robust solution. vmalloc does support NOFS/NOIO contexts these days (it
> will just uses scoped masking in those cases). Propagating the gfp

I see. Nice.

> throughout the worker code path is likely possible, but I haven't really
> explored that in detail to be sure. Would that be preferable even if the
> fix would be more involved?

Longer term, yeah, I think so.

> > Also, doesn't the above always prevent percpu allocations from doing fs/io
> > reclaims? 
> 
> Yes it does. Probably worth mentioning in the changelog. These
> allocations should be rare so having a constrained reclaim didn't really
> seem problematic to me. There should be kswapd running in the background
> with the full reclaim power.

Hmm... you'd a better judge on whether that'd be okay or not but it does
bother me that we might be increasing the chance of allocation failures for
GFP_KERNEL users at least under memory pressure.

> > ie. Shouldn't the masking only be used if the passed in gfp
> > doesn't allow fs/io?
> 
> This is a good question. I have to admit that my understanding might be
> incorrect but wouldn't it be possible that we could get the lock
> dependency chain if GFP_KERNEL and scoped NOFS alloc_pcp calls are
> competing? 
> 
> 					fs/io lock
> 					pcpu_alloc_noprof(NOFS/NOIO)
> pcpu_alloc_noprof(GFP_KERNEL)
>   pcpu_schedule_balance_work
>     pcpu_alloc_mutex
>     					  pcpu_alloc_mutex
>       allocation_deadlock throgh fs/io lock
> 
> This is currently not possible because constrained allocations only do
> trylock.

Right, the current locking in expansion path is really simple because it was
assuming everyone would be doing GFP_KERNEL allocation. We'd have to break
up the locking so that allocations are done outside locking, which hopefully
shouldn't be too complicated.

Thanks.

-- 
tejun

