Return-Path: <linux-kernel+bounces-278674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B784D94B35E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 01:06:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6A791C21168
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 23:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86D8C1553A7;
	Wed,  7 Aug 2024 23:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t27E7d5E"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5FC9364A0;
	Wed,  7 Aug 2024 23:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723071961; cv=none; b=AgG0bK10Pm55vN4rk4uM/ZnalYhoVrcC3A2JTXU+ODCAvtFGjC0nQlSY6fXjl4jVmFn2QKMHSy+ddYzowKB+q27Y2TagViGOwgjMcftiUo8dWAitmo7aVzXbqGXWuxibDWJkqEhZzGRSunXztJ4BnwtDE/m814QoYK3tnzN22wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723071961; c=relaxed/simple;
	bh=GqC03HYz1QIoZZN2BxxWw4qrgRFiRx6dJLC5Z+R1O1E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bbQNVzKwCkHgCM77qIvkmj3B0utvBTyzCzvQ+oTPx5OO95NdhkioTxGwm7np3Z7HQs8CMVE/podYS9ZlDUl7s4s8JWHsoFWKMr4v+NA3+cNx6bzGk50ikMb+DFNeeqt34H/3uD5T7Vei8+ggiDHreMs7cu2JJTYfmzbHSD87FQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t27E7d5E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C2CFC32781;
	Wed,  7 Aug 2024 23:05:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723071961;
	bh=GqC03HYz1QIoZZN2BxxWw4qrgRFiRx6dJLC5Z+R1O1E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t27E7d5ESi6oOV1ynTRVZYjRNxkWun+ZsW3zxWkZDcclHNWfXawanTMdo+mYntFWg
	 7Wf85IgSv5AuSWdG3nocHDEmcyNQXoLYxwpYkXkpW+OtU5ef2nylDKexQ4jy1a87I3
	 bo4PcObVmKSmhkDB17G5DaFwYS1wBmTRWSZKNtPsT+fWp8kEio1hSXUGck6v9uircB
	 DZCTm762Z0xv0IuIselegRad2GSo65PYeGN+6n4yier14m9ywWBo30sX1HTZrrvoWq
	 oQFlkElRPvkU3hkInj9KrtokcY0kkasMzR+YVJIZ1r5TOZa4i+TSbizVj7aIytRvID
	 Td3m5GYol4PMQ==
Date: Thu, 8 Aug 2024 01:05:52 +0200
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
Message-ID: <ZrP90NR1lOpDrQ0X@pollux>
References: <20240805152004.5039-1-dakr@kernel.org>
 <20240805152004.5039-5-dakr@kernel.org>
 <fe982cb6-4910-4ba2-ae4d-892514c9e7f7@proton.me>
 <ZrJxkwF2Y59xln1e@pollux.localdomain>
 <8ab83e4b-9c72-4a5d-974a-7f123753e7fe@proton.me>
 <ZrNIaAcGkGU0d8I3@pollux>
 <9e22d4ab-eff2-4c69-8a2f-f55a8eaeb892@proton.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e22d4ab-eff2-4c69-8a2f-f55a8eaeb892@proton.me>

On Wed, Aug 07, 2024 at 08:15:41PM +0000, Benno Lossin wrote:
> > So, that's not permitted. `free` can't be called with a dangling pointer. The
> > kernel free functions (*1) can't handle it, and I can't detect it, since a
> > dangling pointer does not have a descrete value.
> 
> That is true, but only if we do not have access to the old layout of the
> allocation. If we add `old_layout` as a parameter, then we can handle
> dangling pointers.

Then we'd need `free` to be `fn free(ptr: NonNull<u8>, layout: Layout)` just to
compare whether `ptr.as_ptr() == layout.align() as _`. Same for `realloc`, but
that's less weird.

It's also not that we safe code with that. `Box`, `Vec`, any other user, still
would have to create the `Layout` before they call `A::free`.

> > Surely, we could also let the caller pass the old alignment, but this all sounds
> > complicated for something that is very trivial for the caller to take care of,
> > i.e. just don't try to free something that was never actually allocated.
> > 
> > It can also lead to subtle bugs, e.g. what if someone calls `Box::from_raw` for
> > a ZST with some other random pointer? Currently, that doesn't hurt us, which for
> > robustness, seems to be a good thing.
> 
> I think we should forbid that. To me it's just plain wrong to take a
> random integer literal and cast it to a ZST. IIRC it even is UB if that
> points to a previously allocated object that has been freed (but I don't
> remember where I read it...).

I think my argument about robustness still holds even if we forbid it.

The documentation says "For operations of size zero, every pointer is valid,
including the null pointer." [1]

[1] https://doc.rust-lang.org/std/ptr/index.html

> 
> Also if we use the size of the old layout instead of comparing alignment
> with the address of the pointer, then we avoid this issue.

That is just another problem when passing the old `Layout` (or maybe just the
old size as usize). Neither do we need the old size, nor do we honor it with any
kernel allocator. This has the following implications:

(1) We never see any error if the old size that is passed is garbage (unless
    it's non-zero, when it should be zero and vice versa), which is bad.

(2) We'd need `free` to be `fn free(ptr: NonNull<u8>, size: usize)`, which is
    confusing, because it implies that an actual free relies on this size for
    freeing the memory.

If we want to avoid (1) and (2), we'd need to make it
`fn free(ptr: NonNull<u8>, zero: bool)` instead, but then also the caller can
just check this boolean and conditionally call `free`.

I don't really see why it's better to let `free` do the `if !zero` check. 

