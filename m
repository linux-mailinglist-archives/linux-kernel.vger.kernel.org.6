Return-Path: <linux-kernel+bounces-288095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D8F5E953432
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 16:24:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 659BD1F291BC
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 14:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FC6D1AD400;
	Thu, 15 Aug 2024 14:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hrokymxa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B886A1AC437;
	Thu, 15 Aug 2024 14:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723731794; cv=none; b=ZOeHh6Osu9Yh+h9k6qoY63OhieRAzMG48TKsygI4Q8/4X9rmWLymZjI7QCUGpRKTxl906SOjDhFU1FnAKfvANAzkwS5eE/OdvvhaGNPIRQ3DhrBRx1qT3b3pjLql3xAYJJl3Yajocr1Sj/bxert5NeM5chc4dqPrKqx4yeNfsDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723731794; c=relaxed/simple;
	bh=ZICUfqW3ibLnp1tG3YkER08ff+Zhm0tKGhwrShQiyvg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FBxiJCit+DGvRj6EJmEeghHXFhgZYi8r5H0YuXMfmlzQOp8pNNsrbJ5/7Q28rvc6ZSuAVVVu10lMtdDzDjJQhBDGyIxXiKpoov2508CqcPGyYQmr1grjpBN8/bK/lQIFUYlh1NT99W2NMXrWVvgqH7IhaXipT2eCpsRuhI6FzUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hrokymxa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96176C32786;
	Thu, 15 Aug 2024 14:23:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723731794;
	bh=ZICUfqW3ibLnp1tG3YkER08ff+Zhm0tKGhwrShQiyvg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HrokymxamxMNOr/rIg/O/ihcm9ydAtLZNCV8EtB4nD6/GRac43Zn9YWH1wmI4m/Up
	 dv/SjEjMNXUGY5g7k1L50DYUbSfvs4oCT+DOSykiL2NAT7eElnEgV+wTo0U8GjaXEk
	 Wb5gEcxdNVytXkLc7z5L0lDnxPH4B31H1l2+KT6531S1RfNeo6jOP/pVkmmAk9hMZS
	 GfU6IoTl3nN9Jedr83EPgcIbv4pP0OMq5ZNDw2sgBmLkY9hjok6nSp6U1nmx4fwO0c
	 loF1iJtBrdFXkvQASm0qOwQTohZRTg4x7wiLn6xCePFkugZjR/kYVPnOJ3OfQwGu1V
	 HeMEHkWXO+G1A==
Date: Thu, 15 Aug 2024 16:23:06 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Benno Lossin <benno.lossin@proton.me>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com,
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
	a.hindborg@samsung.com, aliceryhl@google.com,
	akpm@linux-foundation.org, daniel.almeida@collabora.com,
	faith.ekstrand@collabora.com, boris.brezillon@collabora.com,
	lina@asahilina.net, mcanal@igalia.com, zhiw@nvidia.com,
	cjia@nvidia.com, jhubbard@nvidia.com, airlied@redhat.com,
	ajanulgu@redhat.com, lyude@redhat.com, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v5 06/26] rust: alloc: implement `Vmalloc` allocator
Message-ID: <Zr4PSuIOpiE-8OkJ@cassiopeiae>
References: <20240812182355.11641-1-dakr@kernel.org>
 <20240812182355.11641-7-dakr@kernel.org>
 <c9d57e77-8748-4e58-a39b-7a23f750ceda@proton.me>
 <Zr0r6sSFMSQIpHEX@cassiopeiae>
 <Zr072oSej9KIc1S6@cassiopeiae>
 <5dfe8bae-2c1e-47d4-9fb4-373b7d714c4f@proton.me>
 <Zr30pNwc5aanRaqj@cassiopeiae>
 <01a46c6d-0107-4455-8c87-af43426752ff@proton.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01a46c6d-0107-4455-8c87-af43426752ff@proton.me>

On Thu, Aug 15, 2024 at 01:44:27PM +0000, Benno Lossin wrote:
> On 15.08.24 14:29, Danilo Krummrich wrote:
> > On Thu, Aug 15, 2024 at 06:48:19AM +0000, Benno Lossin wrote:
> >> On 15.08.24 01:20, Danilo Krummrich wrote:
> >>> On Thu, Aug 15, 2024 at 12:13:06AM +0200, Danilo Krummrich wrote:
> >>>>
> >>>>>
> >>>>>> +        ptr: Option<NonNull<u8>>,
> >>>>>> +        layout: Layout,
> >>>>>> +        flags: Flags,
> >>>>>> +    ) -> Result<NonNull<[u8]>, AllocError> {
> >>>>>> +        // TODO: Support alignments larger than PAGE_SIZE.
> >>>>>> +        if layout.align() > bindings::PAGE_SIZE {
> >>>>>> +            pr_warn!("Vmalloc does not support alignments larger than PAGE_SIZE yet.\n");
> >>>>>> +            return Err(AllocError);
> >>>>>
> >>>>> I think here we should first try to use `build_error!`, most often the
> >>>>> alignment will be specified statically, so it should get optimized away.
> >>>>
> >>>> Sure, we can try that first.
> >>>
> >>> I think I spoke too soon here. I don't think `build_error!` or `build_assert!`
> >>> can work here, it would also fail the build when the compiler doesn't know the
> >>> value of the alignment, wouldn't it? I remember that I wasn't overly happy about
> >>> failing this on runtime either when I first thought about this case, but I also
> >>> couldn't think of something better.
> >>
> >> Yes, it might fail even though the alignment at runtime will be fine.
> >> But that's why I suggested trying `build_error!`(or `build_assert!`)
> >> first, if nobody hits the case where the compiler cannot figure it out,
> >> then we can keep it. If there are instances, where it fails, but the
> >> alignment would be fine at runtime, then we can change it to the above.
> >> (I would add such a comment above the assert).
> > 
> > Unfortunately, it already does fail with just the test cases.
> 
> Aw that's sad.
> 
> > Anyway, even if it would have been fine, I don't think it would have been nice
> > for a future user to run into a build error even though the alignment is
> > perfectlly within bounds.
> 
> I think it would have been better compared to failing with a warning at
> runtime.

Generally, yes. But I think it's not acceptable to make calls fail that should
actually succeed.

> 
> >>> In the end it's rather unlikely to ever hit this case, and probably even more
> >>> unlikely to hit it for a sane reason.
> >>
> >> Yeah, but I still prefer the build to fail, rather than emitting a warn
> >> message that can be overlooked at runtime.
> >>
> >>>>> How difficult will it be to support this? (it is a weird requirement,
> >>>>> but I dislike just returning an error...)
> >>>>
> >>>> It's not difficult to support at all. But it requires a C API taking an
> >>>> alignment argument (same for `KVmalloc`).
> >>
> >> I see, that's good to know.
> >>
> >>>> Coming up with a vrealloc_aligned() is rather trivial. kvrealloc_aligned() would
> >>>> be a bit weird though, because the alignment argument could only be really
> >>>> honored if we run into the vrealloc() case. For the krealloc() case it'd still
> >>>> depend on the bucket size that is selected for the requested size.
> >>
> >> Yeah... Maybe some more logic on the Rust side can help with that.
> > 
> > Only if we reimplement `KVmalloc` in Rust, However, there are quite some special
> > cases in __kvmalloc_node_noprof(), i.e. fixup page flags, sanity check the size
> > on kmalloc failure, fail on certain page flags, etc.
> > 
> > I don't really want to duplicate this code, unless we absolutely have to.
> 
> I am under the (probably wrong) impression that kvmalloc has some size
> check and selects vmalloc or kmalloc depending on that. 

Basically, yes. But as mentioned above, there are quite some corner cases [1].

> I think that we
> could check the size and if it is going to allocate via kmalloc, then we
> adjust the size for alignment as usual

We don't need this adjustment any longer, see commit ad59baa31695 ("slab, rust:
extend kmalloc() alignment guarantees to remove Rust padding").

> and if it is going to select
> vmalloc, then we can just pass the alignment (if the vmalloc alignment
> patch is done first).

Yeah, but as mentioned, I'd prefer to do this in C, such that we don't need to
open code everything the C code already does.

[1] https://elixir.bootlin.com/linux/v6.11-rc3/source/mm/util.c#L628
> 
> >>>> Adding the C API, I'm also pretty sure someone's gonna ask what we need an
> >>>> alignment larger than PAGE_SIZE for and if we have a real use case for that.
> >>>> I'm not entirely sure we have a reasonable answer for that.
> >>
> >> We could argue that we can remove an "ugly hack" (when we don't have the
> >> build assert, if we do have that, I don't mind not supporting it), but I
> >> agree that finding a user will be difficult.
> > 
> > I'd argue it's not really a hack to fail on something that's not supported
> > (yet). Allocations can (almost) always fail, this is just another case.
> 
> I guess since this is a deterministic failure, it's better than other
> failures. But I would still say this is hacky.
> 
> ---
> Cheers,
> Benno
> 

