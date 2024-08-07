Return-Path: <linux-kernel+bounces-277715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F73994A530
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 12:12:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B6FA1F231C6
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 10:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EBB11D54C9;
	Wed,  7 Aug 2024 10:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BSKBiUUS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67CCD1D4148;
	Wed,  7 Aug 2024 10:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723025520; cv=none; b=cs0fdlpR6wqSbm9iv6LSbQy7aZgHeQ6h/xr3F8yJYFOISW+c2wP8zoVqmNb6f7JcaTkSqYtmXvrypaU+N+JNiMLFeaDnbkwoukYLVqFM2OPA/5MSmTC5W/29F/oMAYxufwCChmoeQD1gUkB4oRVwSWOmXrqSrvNmmZKGknrb3CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723025520; c=relaxed/simple;
	bh=M0SbNtS/0JfWwDqJNR3EdILvxpwAPf3TXVnbsoOysAA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JQvOtNbbAw6E8qy4Nyio1DXzd/yf6N+3cQIiE+D+a+EqFZPIIchYxmy+2laYzz+2Ecco9IjHBM5+0cvX0rM/4Ji3716pjUfzt7XVZcUJbDorskqGwSwxVoqxv9QJgH+co/JEmnx6l6TyC183bcsEHttyILbqdTln6+FcLEfRAPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BSKBiUUS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16A92C32782;
	Wed,  7 Aug 2024 10:11:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723025520;
	bh=M0SbNtS/0JfWwDqJNR3EdILvxpwAPf3TXVnbsoOysAA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BSKBiUUSlonZrGmt70BVsFlJVmxAppSYsWIuLFKXs/Q6Z6nnm/pEKiYP880ExpwaL
	 lVW6yqHDKAxj2QDJ9gZvaRn7DtHH3Dq8HnH638ELdxr7l/MKsUVRVosJoYOaAa7DD/
	 BtLz/RoEDO/TTtf4QOC5O2M6kW6wGMjJxnsOQugx0q18KMP8p+t8C3SzrU6i0LKIIm
	 w64gyBWvn99m068u0VshAx3H6b/td7/XiJkNN1GsGGC2qHjSVBMe0jc6yiH8QfshCW
	 nmbx6xPPiUzkcJI9Kojj6nY7G9NDuGCoypkbzXTdTvSTSeYrKLAfsTuaV8qxNribEa
	 UFgh15NrcP+0w==
Date: Wed, 7 Aug 2024 12:11:52 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Benno Lossin <benno.lossin@proton.me>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com,
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
	a.hindborg@samsung.com, aliceryhl@google.com,
	akpm@linux-foundation.org, daniel.almeida@collabora.com,
	faith.ekstrand@collabora.com, boris.brezillon@collabora.com,
	lina@asahilina.net, mcanal@igalia.com, zhiw@nvidia.com,
	acurrid@nvidia.com, cjia@nvidia.com, jhubbard@nvidia.com,
	airlied@redhat.com, ajanulgu@redhat.com, lyude@redhat.com,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH v4 04/28] rust: alloc: implement `Allocator` for `Kmalloc`
Message-ID: <ZrNIaAcGkGU0d8I3@pollux>
References: <20240805152004.5039-1-dakr@kernel.org>
 <20240805152004.5039-5-dakr@kernel.org>
 <fe982cb6-4910-4ba2-ae4d-892514c9e7f7@proton.me>
 <ZrJxkwF2Y59xln1e@pollux.localdomain>
 <8ab83e4b-9c72-4a5d-974a-7f123753e7fe@proton.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8ab83e4b-9c72-4a5d-974a-7f123753e7fe@proton.me>

On Wed, Aug 07, 2024 at 07:14:13AM +0000, Benno Lossin wrote:
> On 06.08.24 20:55, Danilo Krummrich wrote:
> > On Tue, Aug 06, 2024 at 04:51:28PM +0000, Benno Lossin wrote:
> >> On 05.08.24 17:19, Danilo Krummrich wrote:
> >>> +        let raw_ptr = unsafe {
> >>> +            // If `size == 0` and `ptr != NULL` the memory behind the pointer is freed.
> >>> +            self.0(ptr.cast(), size, flags.0).cast()
> >>> +        };
> >>> +
> >>> +        let ptr = if size == 0 {
> >>> +            NonNull::dangling()
> >>
> >> If we call `realloc(Some(ptr), <layout with size = 0>, ...)`, then this
> >> leaks the pointer returned by the call to `self.0` above. I don't know
> >> what the return value of the different functions are that can appear in
> >> `self.0`, do they return NULL?
> > 
> > That is fine, we don't care about the return value. All `ReallocFunc` free the
> > memory behind `ptr` if called with a size of zero. But to answer the question,
> > they return either NULL or ZERO_SIZE_PTR.
> 
> I see, then it's fine. I think it would help if we know the exact
> behavior of `kmalloc` & friends (either add a link to C docs or write it
> down on `ReallocFunc`).
> 
> >> What about the following sequence:
> >>
> >>     let ptr = realloc(None, <layout with size = 0>, ...);
> >>     let ptr = realloc(Some(ptr), <layout with size = 0>, ...);
> >>
> >> Then the above call to `self.0` is done with a dangling pointer, can the
> >> functions that appear in `self.0` handle that?
> > 
> > This would be incorrect.
> > 
> > Calling `realloc(Some(ptr), <layout with size = 0>, ...)` frees the memory
> > behind `ptr`. This is guranteed behavior for all `ReallocFunc`s, i.e.
> > krealloc(), vrealloc(), kvrealloc().
> 
> Note that I don't use `ptr` afterwards, the code snippet above is
> equivalent to this:
> 
>     let ptr = Kmalloc::alloc(<layout with size = 0>, ...);
>     unsafe { Kmalloc::free(ptr) };
> 
> internally exactly the realloc calls that I put above should be called.

I think I misunderstood what you mean here.

So, that's not permitted. `free` can't be called with a dangling pointer. The
kernel free functions (*1) can't handle it, and I can't detect it, since a
dangling pointer does not have a descrete value.

We can decide for a specific dangling pointer to be allowed, i.e. the dangling
pointer returned by `alloc` for a zero sized allocation is always
`dangling<u8>`, so we can assert that `free` is only allowed to be called with
what was previously returned by `alloc` or `free` and therefore disallow
dangling pointers with a different alignment.

Surely, we could also let the caller pass the old alignment, but this all sounds
complicated for something that is very trivial for the caller to take care of,
i.e. just don't try to free something that was never actually allocated.

It can also lead to subtle bugs, e.g. what if someone calls `Box::from_raw` for
a ZST with some other random pointer? Currently, that doesn't hurt us, which for
robustness, seems to be a good thing.

I think it's better to just let `Box` and `Vec` figure out if calling `free` is
the right thing to do. The code for that is simple and obvious, i.e. check if
`T` is a ZST.

*1: kfree() can handle dangling pointers up to 16 bytes aligned, see
ZERO_OR_NULL_PTR(x).

> 
> ---
> Cheers,
> Benno
> 

