Return-Path: <linux-kernel+bounces-525102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87506A3EACD
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 03:36:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E43B3B58EC
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 02:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A68D13A3F7;
	Fri, 21 Feb 2025 02:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W5EzY6vZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E0A3C2F
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 02:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740105378; cv=none; b=Tibf6TWB78Ac9UZu6KZUErZvYHCKQ7903VU+cjALEJ77xvCL/JwRALMjw1VS8WQbui0BhbmDgICUsHYQ5fxANQMXP/i6nh9ikdHBHQs1k/MrbYh5yP3X2TnI6OiCG1vNhobCVhq0LoIHKd/RqOlwbS14sL8Lqi0KMUJ83/yYH5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740105378; c=relaxed/simple;
	bh=WFIuMo5pTGBiHHYSjJUhVurH/1rAlmn11CxpWCw4GZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L8TT/F/AJOX70qnQykQbvTraJi6MCRb98Jy0oIgnbwebxJuVnAtHv08sIG7uUKAVK7gWn/9HdNji4tKmix27IfcjyXb7muGqqlxMYT32W/GCJh8bPacHLQqX4WTRdbWisE92QzFmV2hGS27mahp6gFYzjqYjFWDDA8vxdj8KnPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W5EzY6vZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AC97C4CED1;
	Fri, 21 Feb 2025 02:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740105376;
	bh=WFIuMo5pTGBiHHYSjJUhVurH/1rAlmn11CxpWCw4GZY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W5EzY6vZyIp8BdSy+igShiXGpN/XGQh1WOuMxNLgvEAgZ7len5UpeefOCZKvMn2J9
	 aD8LwSWfEfjQf7gk+9EVhSrJDzEZvl0VEHYObIGQDS+1xZfpj7OuACo9LCnfrvB2U4
	 Tdlhy/T3Q43qEexDcyuCVyBPUZ8mNF798pke+B+j3sLXSntkH51FKe2e8TLtUsFIzf
	 G9vXjOSL9lRsz0kEOiJLlGMwgfoWF930vdEQfsyIC9/S/csAPDEAAkWUH8GRMO+URN
	 G4b9z46x5fU5pPN6mW1U0l9s+4u8Im8lawhr5Q6szIQTbJKrjK+V+6juvGjIzmFJct
	 FlMmiJ9T9WTdQ==
Date: Thu, 20 Feb 2025 18:36:14 -0800
From: Dennis Zhou <dennis@kernel.org>
To: Michal Hocko <mhocko@suse.com>
Cc: Tejun Heo <tj@kernel.org>, Filipe Manana <fdmanana@suse.com>,
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm, percpu: do not consider sleepable allocations atomic
Message-ID: <Z7fmnsHTU49eYEaU@snowbird>
References: <20250206122633.167896-1-mhocko@kernel.org>
 <Z6u5OJIQBw8QLGe_@slm.duckdns.org>
 <Z6zS4Dtyway78Gif@tiehlicka>
 <Z6zlC3juT46dLHr9@slm.duckdns.org>
 <Z60KQCuPCueqRwzc@tiehlicka>
 <Z60S4NMUzzKbW5HY@slm.duckdns.org>
 <Z60VE9SJHXEtfIbw@snowbird>
 <Z69mygllBATJ6dsm@tiehlicka>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z69mygllBATJ6dsm@tiehlicka>

On Fri, Feb 14, 2025 at 04:52:42PM +0100, Michal Hocko wrote:
> On Wed 12-02-25 13:39:31, Dennis Zhou wrote:
> > Hello,
> > 
> > On Wed, Feb 12, 2025 at 11:30:08AM -1000, Tejun Heo wrote:
> > > Hello,
> > > 
> > > On Wed, Feb 12, 2025 at 09:53:20PM +0100, Michal Hocko wrote:
> > > ...
> > > > > Hmm... you'd a better judge on whether that'd be okay or not but it does
> > > > > bother me that we might be increasing the chance of allocation failures for
> > > > > GFP_KERNEL users at least under memory pressure.
> > > > 
> > > > Nope, this will not change the allocation failure mode. Reclaim
> > > > constrains do not change the failure mode they just change how much the
> > > > allocation might struggle to reclaim to succeed. 
> > > >
> > > > My undocumented assumption (another dept on my end) is that pcp
> > > > allocations are no hot paths. So the worst case is that GFP_KERNEL
> > > > pcp_allocation could have been satisfied _easier_ (i.e. faster) because
> > > > it could have reclaimed fs/io caches and now it needs to rely on kswapd
> > > > to do that on memory tight situations. On the other hand we have a
> > > > situation when NOIO/FS allocations fail prematurely so there is
> > > > certainly some pros and cons.
> > > 
> > > I'm having a hard time following. Are you saying that it won't increase the
> > > likelihood of allocation failures even under memory pressure but that it
> > > might just make allocations take longer to succeed?
> > > 
> > > NOFS/IO prevents allocation attempt from entering fs/io reclaim paths,
> > > right? It would still trigger kswapd for reclaim but can the allocation
> > > attempt wait for that to finish? If so, wouldn't that constitute a
> > > dependency cycle all the same?
> > > 
> > > All in all, percpu allocations taking longer under memory pressure is fine.
> > > Becoming more prone to allocation failures, especially for GFP_KERNEL
> > > callers, probably isn't great.
> > > 
> > 
> > Wait, I think I'm interpreting this change differently. This is
> > preventing the worker from allocating backing pages via GFP_KERNEL. It
> > isn't preventing an allocation via alloc_percpu() from being GFP_KERNEL
> > and providing those flags down to the backing page code. alloc_percpu()
> > for GFP_KERNEL allocations will populate the pages before returning.
> 
> Correct.
>  
> > I'm reading this as potentially making atomic percpu allocations fail as
> > we might be low on backing pages. This change makes the worker now need
> > to wait for kswapd to give it pages. Consequently, if there are a lot of
> > allocations coming in when it's low, we might burn a bit of cpu from the
> > worker now.
> 
> Yes, this is potential side effect. On the other hand NOFS/NOIO requests
> wouldn't be considered atomic anymore and they wouldn't fail that
> easily. Maybe that is an odd case not worth the additional worker
> overhead. As I've said I am not familiar with the pcp internals to know
> how often the worker is really required
> 

I've thought about this in the back of my head for the past few weeks. I
think I have 2 questions about this change.

1. Back to what TJ said earlier about probing. I feel like GFP_KERNEL
   allocations should be okay because that more or less is control plane
   time? I'm not sure dropping PR_SET_IO_FLUSHER is all that big of a
   work around?

2. This change breaks the feedback loop as we discussed above.
   Historically we've targeted 2-4 free pages worth of percpu memory.
   This is done by kicking the percpu work off. That does GFP_KERNEL
   allocations and if that requires reclaim then it goes and does it.
   However, now we're saying kswapd is going to work in parallel while
   we try to get pages in the worker thread.

   Given you're more versed in the reclaim side. I presume it must be
   pretty bad if we're failing to get order-0 pages even if we have
   NOFS/NOIO set?

   My feeling is that we should add back some knowledge of the
   dependency so if the worker fails to get pages, it doesn't reschedule
   immediately. Maybe it's as simple as adding a sleep in the worker or
   playing with delayed work...

Thanks,
Dennis

