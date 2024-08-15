Return-Path: <linux-kernel+bounces-287921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A43D5952E42
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 14:29:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EC321F2655F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 12:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38A3417C9BD;
	Thu, 15 Aug 2024 12:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j4Rtufy2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7324E17C9AA;
	Thu, 15 Aug 2024 12:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723724975; cv=none; b=YKhKVwG97CMp15HqT12czMA1mlwjdSaaRQ73dhsp4HS2dRRvmJvxnd6LCq+n/OfxnJ2G4rxljjRtM42e7vVW51eYs4KlMkebSu8uxJfsTlMKvyLnNjpGeqJS7UDv7bhQccymYcWmwoToYSRjfDIoCRTVgPunGCBl2wp7L6xAhQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723724975; c=relaxed/simple;
	bh=01x6idmt70HEhMW6DRE96TN1pZTJ32rMEyQEqY3UF1s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ohtUxMgGlJxajeW/J1dP+Ludggc9Sw5mlahSKymBgC+eZ4mZ6DByIb/exFiJtRo5k/yg8f3g8W0dSGnSygU9tYFpX8esnVGJzJ17CcypsqvlYe9WZ98bm+FhMDkVPZR37c6uIoCakWrskZO74eELzRsfKjq16vjri+0mLyTlxxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j4Rtufy2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40B46C32786;
	Thu, 15 Aug 2024 12:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723724975;
	bh=01x6idmt70HEhMW6DRE96TN1pZTJ32rMEyQEqY3UF1s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j4Rtufy20A/OQeu3YE6pPxD+MmHPkEeVZCXka2ArAUXtG6psKTFS5kbAeCV9zEpll
	 iXIUhQ5wQYuIvf7CasINkIZJO8CzwXvLaPDD2mWj6/ioFLNXiF/cfQjLnQn9vUmUCC
	 kcao4kf7qa4xwxITI/gqDW0eu9s6IFm5/LJQ/J7vDckgwt0mic+AxBf5ZjS1acGE4Z
	 i1ShWNJArYmmjkO+xAX4OFdgfc9jjdy+bBjCjSPMghaccCu57RO/MvuaMG6nnmNYxr
	 HOzhzZ0qxyYxE30yMWda5HlMxXcagtF9efIpgNbDh5LpJ0XWwDLp9Rar3SSIaNpHmy
	 f31yaT7tijLBg==
Date: Thu, 15 Aug 2024 14:29:24 +0200
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
Message-ID: <Zr30pNwc5aanRaqj@cassiopeiae>
References: <20240812182355.11641-1-dakr@kernel.org>
 <20240812182355.11641-7-dakr@kernel.org>
 <c9d57e77-8748-4e58-a39b-7a23f750ceda@proton.me>
 <Zr0r6sSFMSQIpHEX@cassiopeiae>
 <Zr072oSej9KIc1S6@cassiopeiae>
 <5dfe8bae-2c1e-47d4-9fb4-373b7d714c4f@proton.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5dfe8bae-2c1e-47d4-9fb4-373b7d714c4f@proton.me>

On Thu, Aug 15, 2024 at 06:48:19AM +0000, Benno Lossin wrote:
> On 15.08.24 01:20, Danilo Krummrich wrote:
> > On Thu, Aug 15, 2024 at 12:13:06AM +0200, Danilo Krummrich wrote:
> >>
> >>>
> >>>> +        ptr: Option<NonNull<u8>>,
> >>>> +        layout: Layout,
> >>>> +        flags: Flags,
> >>>> +    ) -> Result<NonNull<[u8]>, AllocError> {
> >>>> +        // TODO: Support alignments larger than PAGE_SIZE.
> >>>> +        if layout.align() > bindings::PAGE_SIZE {
> >>>> +            pr_warn!("Vmalloc does not support alignments larger than PAGE_SIZE yet.\n");
> >>>> +            return Err(AllocError);
> >>>
> >>> I think here we should first try to use `build_error!`, most often the
> >>> alignment will be specified statically, so it should get optimized away.
> >>
> >> Sure, we can try that first.
> > 
> > I think I spoke too soon here. I don't think `build_error!` or `build_assert!`
> > can work here, it would also fail the build when the compiler doesn't know the
> > value of the alignment, wouldn't it? I remember that I wasn't overly happy about
> > failing this on runtime either when I first thought about this case, but I also
> > couldn't think of something better.
> 
> Yes, it might fail even though the alignment at runtime will be fine.
> But that's why I suggested trying `build_error!`(or `build_assert!`)
> first, if nobody hits the case where the compiler cannot figure it out,
> then we can keep it. If there are instances, where it fails, but the
> alignment would be fine at runtime, then we can change it to the above.
> (I would add such a comment above the assert).

Unfortunately, it already does fail with just the test cases.

Anyway, even if it would have been fine, I don't think it would have been nice
for a future user to run into a build error even though the alignment is
perfectlly within bounds.

> 
> > In the end it's rather unlikely to ever hit this case, and probably even more
> > unlikely to hit it for a sane reason.
> 
> Yeah, but I still prefer the build to fail, rather than emitting a warn
> message that can be overlooked at runtime.
> 
> >>> How difficult will it be to support this? (it is a weird requirement,
> >>> but I dislike just returning an error...)
> >>
> >> It's not difficult to support at all. But it requires a C API taking an
> >> alignment argument (same for `KVmalloc`).
> 
> I see, that's good to know.
> 
> >> Coming up with a vrealloc_aligned() is rather trivial. kvrealloc_aligned() would
> >> be a bit weird though, because the alignment argument could only be really
> >> honored if we run into the vrealloc() case. For the krealloc() case it'd still
> >> depend on the bucket size that is selected for the requested size.
> 
> Yeah... Maybe some more logic on the Rust side can help with that.

Only if we reimplement `KVmalloc` in Rust, However, there are quite some special
cases in __kvmalloc_node_noprof(), i.e. fixup page flags, sanity check the size
on kmalloc failure, fail on certain page flags, etc.

I don't really want to duplicate this code, unless we absolutely have to.

> 
> >> Adding the C API, I'm also pretty sure someone's gonna ask what we need an
> >> alignment larger than PAGE_SIZE for and if we have a real use case for that.
> >> I'm not entirely sure we have a reasonable answer for that.
> 
> We could argue that we can remove an "ugly hack" (when we don't have the
> build assert, if we do have that, I don't mind not supporting it), but I
> agree that finding a user will be difficult.

I'd argue it's not really a hack to fail on something that's not supported
(yet). Allocations can (almost) always fail, this is just another case.

> 
> >> I got some hacked up patches for that, but I'd rather polish and send them once
> >> we actually need it.
> 
> Sure, just wanted to check why you don't want to do it this series.
> 
> ---
> Cheers,
> Benno
> 

