Return-Path: <linux-kernel+bounces-511934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8B4BA331B0
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 22:39:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7450716778B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 21:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E606F2036E2;
	Wed, 12 Feb 2025 21:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B6ImokNv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D58E1D5143
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 21:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739396374; cv=none; b=ltoyyRw+YskyIPgTYW5JSpFT97oaUgIo5w5mICY7sM3GB/Zc4AMyL5C8mYGp28DHBNMMy2DDqAfoC3vhewhTQvp2vSj6qhIwqlcAKN7zyyyAeQEu/PJCltMxiRGaS/Kd9iIsEpTy+CzqVgr5sdtoMWXoz63hUPmX39BT0ogdmx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739396374; c=relaxed/simple;
	bh=pr2yrsafDhKUbtC2sixLFWxb8O5IOm3xFSNn9pYZMqU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=laUOqR0WS2HhJCr6CVYhevM8P87Hc8K6w9BBIiuRHWQnCIacuhxXvpsKa+4jurxt17KHkY7cFn8PEuQMEmPhh+4WOREar3QbKw5O4zQQ+VBJ5S3s6SpnjOzBrNVf4tds4QaGmnhiPLii8oBXaSApCQ2vOQ3+MWFzCMRFGNYR2kQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B6ImokNv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DDC1C4CEDF;
	Wed, 12 Feb 2025 21:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739396373;
	bh=pr2yrsafDhKUbtC2sixLFWxb8O5IOm3xFSNn9pYZMqU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B6ImokNvTjA9xoS+RjGXSZKju3LmNxYpdf3UN6RbR5m5CsDG6wpql0Rp57Ngs0atP
	 Zw+0wGtL0G6S+YTTn4n1m/fvAs3cQLmG1KiH4VwDdCxNmiOo8TROoSWieVssw0gqun
	 9CgRCAuOLulr+PKOaPI616kMTQHxMQA68QIZho6q45jAckZhc6A7H2k0RFXcRSzi30
	 e4dWdqgn9P8H6JG1Kly9gP+O9q6YmToRAg8avqcbBwSIc0SUirDoDCe1vn2827aNOq
	 osZZFPEwW8ii0ZsPWcDcMyzNPy9xdHPfxlSOaxHRspM0kVE4RugY3NulixUo+5vSgT
	 vnxr4X2Nl/JFg==
Date: Wed, 12 Feb 2025 13:39:31 -0800
From: Dennis Zhou <dennis@kernel.org>
To: Tejun Heo <tj@kernel.org>
Cc: Michal Hocko <mhocko@suse.com>, Filipe Manana <fdmanana@suse.com>,
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm, percpu: do not consider sleepable allocations atomic
Message-ID: <Z60VE9SJHXEtfIbw@snowbird>
References: <20250206122633.167896-1-mhocko@kernel.org>
 <Z6u5OJIQBw8QLGe_@slm.duckdns.org>
 <Z6zS4Dtyway78Gif@tiehlicka>
 <Z6zlC3juT46dLHr9@slm.duckdns.org>
 <Z60KQCuPCueqRwzc@tiehlicka>
 <Z60S4NMUzzKbW5HY@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z60S4NMUzzKbW5HY@slm.duckdns.org>

Hello,

On Wed, Feb 12, 2025 at 11:30:08AM -1000, Tejun Heo wrote:
> Hello,
> 
> On Wed, Feb 12, 2025 at 09:53:20PM +0100, Michal Hocko wrote:
> ...
> > > Hmm... you'd a better judge on whether that'd be okay or not but it does
> > > bother me that we might be increasing the chance of allocation failures for
> > > GFP_KERNEL users at least under memory pressure.
> > 
> > Nope, this will not change the allocation failure mode. Reclaim
> > constrains do not change the failure mode they just change how much the
> > allocation might struggle to reclaim to succeed. 
> >
> > My undocumented assumption (another dept on my end) is that pcp
> > allocations are no hot paths. So the worst case is that GFP_KERNEL
> > pcp_allocation could have been satisfied _easier_ (i.e. faster) because
> > it could have reclaimed fs/io caches and now it needs to rely on kswapd
> > to do that on memory tight situations. On the other hand we have a
> > situation when NOIO/FS allocations fail prematurely so there is
> > certainly some pros and cons.
> 
> I'm having a hard time following. Are you saying that it won't increase the
> likelihood of allocation failures even under memory pressure but that it
> might just make allocations take longer to succeed?
> 
> NOFS/IO prevents allocation attempt from entering fs/io reclaim paths,
> right? It would still trigger kswapd for reclaim but can the allocation
> attempt wait for that to finish? If so, wouldn't that constitute a
> dependency cycle all the same?
> 
> All in all, percpu allocations taking longer under memory pressure is fine.
> Becoming more prone to allocation failures, especially for GFP_KERNEL
> callers, probably isn't great.
> 

Wait, I think I'm interpreting this change differently. This is
preventing the worker from allocating backing pages via GFP_KERNEL. It
isn't preventing an allocation via alloc_percpu() from being GFP_KERNEL
and providing those flags down to the backing page code. alloc_percpu()
for GFP_KERNEL allocations will populate the pages before returning.

I'm reading this as potentially making atomic percpu allocations fail as
we might be low on backing pages. This change makes the worker now need
to wait for kswapd to give it pages. Consequently, if there are a lot of
allocations coming in when it's low, we might burn a bit of cpu from the
worker now.

We could take the time to split out pcpu_alloc_mutex and pcpu_lock more
to provide finer grain / concurrrent allocations. But I don't currently
have a justification for it.

> > As I've said I am no pcp allocator expert so I cannot really make proper
> > judgment calls. I can improve the changelog or move from scope to
> > specific gfp flags but I do not feel like I am positioned to make deeper
> > changes to the subsystem.
> 
> I don't think deciding whether always using NOIO/FS is a good idea requires
> knowing the percpu allocator that well. It's just depending on the
> underlying page allocator for that part.
> 
> Thanks.
> 
> -- 
> tejun

Thanks,
Dennis

