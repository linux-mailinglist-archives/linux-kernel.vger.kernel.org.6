Return-Path: <linux-kernel+bounces-561921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62943A618A1
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 18:53:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98313461197
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 17:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3F732046B7;
	Fri, 14 Mar 2025 17:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vO4TWI+0"
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25267204598
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 17:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741974780; cv=none; b=N9t1gn6AOqy04vnZjwxVlyaIp5yAklsaXZpkpnyKIoMSlmPuGl1seZGYmfRDT0BtX1AvSVRFvWnU5Xb7qkrSNKjLWRmtOZAmnnOlETj99qHcINh/vQRdHjn+vmYgNNmhYD5pV9QTqEX7D++gRttFzeYCmUjz8izO6hUS1gqxdB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741974780; c=relaxed/simple;
	bh=pIdfr+mnSivW8NvdUSNhSOSRiQRPUbQLfADhY1DggAQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fHt4kkqUObHXggZg19fWlVGgYJ7OaHbvma8Rtzd7uuLcsoa3NHcCIkyRmKAW5ng6X0y23ypbU0WXPDKJ6miRse2CsMVXLlaScX75FpH2Gg0VLANh1X8tQzNDlgfpzQR4DswCsVxxpen26NgtQL2fWsv4e4KaZPzAiL7xlt1FzS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vO4TWI+0; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 14 Mar 2025 17:52:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741974774;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0dZqFzBvOCItadkQGv2XNoVXPrvgIGe2XFsi8JmjxZQ=;
	b=vO4TWI+0GHsa2DTPqlsPpujAEUMgMrVuNOvN/6wbUF1Mq6keTs8cBRVunNgv9Jvlwdq8NO
	kL7+p5isUZYzJTo8TObTy3EG8V0Tvf9FDVbotCW6kxzlTSqQEJEIllT/fackhLWZWtR0c8
	DXD0CEkIjRozdCBoY6kTLpGbQP68VP4=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@suse.com>,
	Zhongkun He <hezhongkun.hzk@bytedance.com>,
	akpm@linux-foundation.org, muchun.song@linux.dev,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] mm: vmscan: skip the file folios in proactive reclaim
 if swappiness is MAX
Message-ID: <Z9Rs8ZtgkupXpFYn@google.com>
References: <20250314033350.1156370-1-hezhongkun.hzk@bytedance.com>
 <Z9PuXMlHycL6Gco0@tiehlicka>
 <Z9P2nZ6b75FRMhCp@tiehlicka>
 <20250314141833.GA1316033@cmpxchg.org>
 <Z9RB-gHgtXRc86ro@tiehlicka>
 <20250314165739.GB1316033@cmpxchg.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250314165739.GB1316033@cmpxchg.org>
X-Migadu-Flow: FLOW_OUT

On Fri, Mar 14, 2025 at 12:57:39PM -0400, Johannes Weiner wrote:
> On Fri, Mar 14, 2025 at 03:49:30PM +0100, Michal Hocko wrote:
> > On Fri 14-03-25 10:18:33, Johannes Weiner wrote:
> > > On Fri, Mar 14, 2025 at 10:27:57AM +0100, Michal Hocko wrote:
> > [...]
> > > > I have just noticed that you have followed up [1] with a concern that
> > > > using swappiness in the whole min-max range without any heuristics turns
> > > > out to be harder than just relying on the min and max as extremes.
> > > > What seems to be still missing (or maybe it is just me not seeing that)
> > > > is why should we only enforce those extreme ends of the range and still
> > > > preserve under-defined semantic for all other swappiness values in the
> > > > pro-active reclaim.
> > > 
> > > I'm guess I'm not seeing the "under-defined" part.
> > 
> > What I meant here is that any other value than both ends of swappiness
> > doesn't have generally predictable behavior unless you know specific
> > details of the current memory reclaim heuristics in get_scan_count.
> > 
> > > cache_trim_mode is
> > > there to make sure a streaming file access pattern doesn't cause
> > > swapping.
> > 
> > Yes, I am aware of the purpose.
> > 
> > > He has a special usecase to override cache_trim_mode when he
> > > knows a large amount of anon is going cold. There is no way we can
> > > generally remove it from proactive reclaim.
> > 
> > I believe I do understand the requirement here. The patch offers
> > counterpart to noswap pro-active reclaim and I do not have objections to
> > that.
> > 
> > The reason I brought this up is that everything in between 0..200 is
> > kinda gray area. We've had several queries why swappiness=N doesn't work
> > as expected and the usual answer was because of heuristics. Most people
> > just learned to live with that and stopped fine tuning vm_swappiness.
> > Which is good I guess.
> 
> You're still oversimplifying and then dismissing. The heuristics don't
> make swappiness meaningless, they make it useful in the first place.
> 
>   This control is used to define the rough relative IO cost of swapping
>   and filesystem paging, as a value between 0 and 200.
> 
> This is clearly defined, and implemented as such. cache_trim_mode is
> predicated on the *absence* of paging and caching benefits: A linear,
> use-once file access pattern that *does not* benefit from additional
> cache space. Kicking out anon for that purpose would be wrong under
> pretty much any circumstance. That's why it "overrides" swappiness:
> swappiness cannot apply when swapping at all would be nonsense.
> 
> Proactive reclaimers like ours rely on this. We use swappiness to
> express exactly what it says on the tin: the relative cost between
> thrashing file vs anon. We use it quite effectively to manage anon
> write rates for flash wear management e.g. Obviously that doesn't mean
> we want to swap when somebody streams through a large file set.
> 
> Zhongkun's case is a significant exception. He just wants to get rid
> of known-cold anon set. This level of insight into userspace access
> patterns is rare in practice. You could argue that MADV_PAGEOUT might
> be more suitable for that.

We have a similar use case at Google where we have a known-cold anon set
and we proactively reclaim it. This is why we previously proposed
type=anon/file/.., but swappiness is more flexible for use cases like
the one Johannes describes above.

> But I also don't necessarily see a problem
> with making swappiness=200 do it; although we might have to teach our
> proactive reclaimer to auto-tune between 1 and 199 then.

Would it be better if we don't use the existing swappiness=200 for this?

We can support something like memory.reclaim X swappiness=max instead to
achieve the "anon only" mode without affecting the existing semantics of
swappiness at all. I have a feeling I may have already proposed that at
some point.

In the kernel, we can define a new value (say 201 or 1000) that means
anon only and set it in memory_reclaim() when "max" is specified. We can
then explicitly check for this value in get_scan_count() (we probably
also need to handle MGLRU?).

From a user perspective the swappiness semantics remain unchanged, and
you do not need to teach your proactive reclaim to auto tune up to 199
of 200. We just support a new swappiness mode specific to proactive
reclaim.

WDYT?


