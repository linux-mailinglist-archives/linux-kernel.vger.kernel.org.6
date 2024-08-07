Return-Path: <linux-kernel+bounces-277666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B075194A47A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 11:37:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69685282114
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 09:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61EDC1D0DEE;
	Wed,  7 Aug 2024 09:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HqcvzCp1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A061C1B86C2;
	Wed,  7 Aug 2024 09:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723023380; cv=none; b=hd/1Xm80EZCI+LLHWiyTo72WiYt7MVauT5cFJTr3QI/LWiccwhBuiqRu/ON4u7+c0K3P1YQZzpsEk4idUTBcTgllIHyLqlXfwLjg3Ujcruqaq2xeDJyg4TJxHYC0FA56umt/JdP/bRFTpJgv6b1rvRtjCSOOzYDVCaj8Ejs3ecw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723023380; c=relaxed/simple;
	bh=MYz62clIgHy/rY3ccEC0c02OjnEEQ3ROZZvdicm6dg0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZejnsnAMf6alNLqxOok4ZlMVkgB/hrwiC7t6tdfSpTqOpcj1cC94QxiNVkX6+4C3/ZQGuQfnJ0IbO9Jtax3mYjDT00NW2JIO2z1kMkIxaGxys/UpafGsmLDWewKq/P06E7rSS7SUifrz0a49C7HZFmXOZcUvG7t7g97C6cKtTDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HqcvzCp1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 722E2C32782;
	Wed,  7 Aug 2024 09:36:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723023380;
	bh=MYz62clIgHy/rY3ccEC0c02OjnEEQ3ROZZvdicm6dg0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HqcvzCp1RTxGSapevYDjxnD+PZT53GM3ixPnK9kxpR5pbi7P/cEacnMrllT9W5LyV
	 WcLw+NGPV4SYz4aYxz0ms7prWFDGwsJeiQGKyN2HEIeCn3W2/V56GFTJQ+qDkLVW8E
	 0z1PMejbDQ8IU2WQmN/3kK2w4tZXlrQeAJs8YQu6tJWT3irTRH44iAieU08RQpcJMx
	 GTYws4Kny5zHdF2jZiV3N07X47lbxeAgMRiJaJpWf+tGWEng6lDLqbAR+zRGWMyXqI
	 v/0IrS6geI8jZYpHXoSFLwMk3VfHi+Yse0CGua3lCUzvBXpfa/7XPyFF9rxrrzbZ8M
	 1yxxVrsmME/ng==
Date: Wed, 7 Aug 2024 11:36:12 +0200
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
Subject: Re: [PATCH v4 01/28] rust: alloc: add `Allocator` trait
Message-ID: <ZrNADDlM-RPS0Sze@pollux>
References: <20240805152004.5039-1-dakr@kernel.org>
 <20240805152004.5039-2-dakr@kernel.org>
 <470b5f70-b592-43a7-81ba-c7f1c852b9f3@proton.me>
 <ZrJrzYXM9RffF4kf@pollux.localdomain>
 <52b1a806-48c7-4ae2-b78c-ca0e8bf5e1d7@proton.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52b1a806-48c7-4ae2-b78c-ca0e8bf5e1d7@proton.me>

On Tue, Aug 06, 2024 at 08:04:30PM +0000, Benno Lossin wrote:
> >>> +    /// instance. The alignment encoded in `layout` must be smaller than or equal to the alignment
> >>> +    /// requested in the previous `alloc` or `realloc` call of the same allocation.
> >>> +    ///
> >>> +    /// Additionally, `ptr` is allowed to be `None`; in this case a new memory allocation is
> >>> +    /// created.
> >>> +    ///
> >>> +    unsafe fn realloc(
> >>> +        ptr: Option<NonNull<u8>>,
> >>> +        layout: Layout,
> >>> +        flags: Flags,
> >>> +    ) -> Result<NonNull<[u8]>, AllocError>;
> >>> +
> >>> +    /// Free an existing memory allocation.
> >>> +    ///
> >>> +    /// # Safety
> >>> +    ///
> >>> +    /// `ptr` must point to an existing and valid memory allocation created by this `Allocator`
> >>> +    /// instance.
> >>
> >> Additionally, you need "The memory allocation at `ptr` must never again
> >> be read from or written to.".
> > 
> > I'm fine adding it, but I wonder if technically this is really required? The
> > condition whether the pointer is ever accessed again in any way is not relevant
> > in terms of being a precondition for `free` not causing UB, right?
> 
> I don't see how else we would find the mistake in the following code:
> 
>     let ptr = Box::into_raw(Box::<i32, Kmalloc>::new(42));
>     // SAFETY: `ptr` came from `Box::into_raw` and thus is pointing to a
>     // valid and existing memory allocation allocated by `Kmalloc`.
>     unsafe { Kmalloc::free(ptr) };
>     // SAFETY: `ptr` came from `Box::into_raw` and thus is pointing at a
>     // valid `i32`.
>     let v = unsafe { ptr.read() };

Sure, but what I mean is that my understanding is that the "Safety" section in a
comment describes the requirements of the function it documents. I.e. `free`
itself doesn't care whether the pointer is read or writted ever again.

Or in other words, what are the rules where this belongs to? E.g. why not
document this exact aspect in the safety section of `Allocator`?

> 
> Also see the `from_raw` for our `Arc`:
> 
>     /// Recreates an [`Arc`] instance previously deconstructed via [`Arc::into_raw`].
>     ///
>     /// # Safety
>     ///
>     /// `ptr` must have been returned by a previous call to [`Arc::into_raw`]. Additionally, it
>     /// must not be called more than once for each previous call to [`Arc::into_raw`].
>     pub unsafe fn from_raw(ptr: *const T) -> Self {
> 
> That also requires that the function must not be called more than once.
> This reminds me, I forgot to say that about `Box::from_raw`.

Indeed, I also wonder if we ever have cases where C code gives us ownership of a
memory allocation of a certain type that fulfills the requirements we have for
a `Box`, such that Rust code is tempted to pass it to `Box::from_raw`.

It sounds a bit scary design wise, but in theory it's possible.

> 
> ---
> Cheers,
> Benno
> 

