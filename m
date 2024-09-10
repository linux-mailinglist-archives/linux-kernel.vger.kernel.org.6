Return-Path: <linux-kernel+bounces-323978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D0E697465C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 01:26:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B03B41F274FD
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 23:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B32CF1AC885;
	Tue, 10 Sep 2024 23:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c56a4Lah"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6D81AB535;
	Tue, 10 Sep 2024 23:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726010754; cv=none; b=cD+b3OEKwkaRYrZz2ptRl4fVfspamtW8JwNvkgcaHOzHi65k1Jhi4Z+WuzfbjJRd2Czbrq6b3p8S2JxogphDWH/m03MOwgPYKZJLhxjCBtYi/MWjrVwGDMDT6H5OVQRRG/TDEIXd602PGK+5eOKjQjrRswAiTuSuHR2Q9LHZnxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726010754; c=relaxed/simple;
	bh=jWbTVGJQQJ9or0giI5ucycy3BO0lPAlGG7IxUJVCoG0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sUZj+unyZ80KkdKtLQkX35ClQ5Z1GvuXZHGluiWXgoTEY0/H0VnPTABZTH8pu0HXDuzk45+NPuBvukm9fbgecFlZMeJL0AVUvWdtoVZJWPUXmh1x+gLTdBzOZYpcgSs/ZgaRuV9eGLrdBBkIzbznLCwHAL6xEFA200WOdkjOhFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c56a4Lah; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC5FDC4CEC3;
	Tue, 10 Sep 2024 23:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726010753;
	bh=jWbTVGJQQJ9or0giI5ucycy3BO0lPAlGG7IxUJVCoG0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c56a4LahYMixLImso+PUxaJI0z2WGqSqY+LG6P6j9Fk0X/bMfxBHugfQbq6LLPri9
	 Vjn0TzBdxtHVoqgZsWEcND1v4XDSYZb0G2+VB0T0Sqxs9dxBbQ1rq1qZUdXu1I+q3m
	 mBqlsWOAuteFOW/Dff3mK3meyhnAuh0y1oygcsQkv3cQgDIJ4R8Ck8JQ83PdDZsVon
	 leFPMLjiiFYPAdtErLaNSrrYOBq2mwh1k01N+czjsCiK1cGxVYt3aRGPPw923OdbJx
	 Uee5SdbZHGtyz+Dz4PVFdFQqud8Y/KGgWzddDKva4Nj0MUbS0qELl4qNXQfHez4jDd
	 kHmI4tMUkrsTA==
Date: Wed, 11 Sep 2024 01:25:46 +0200
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
Subject: Re: [PATCH v6 09/26] rust: alloc: implement kernel `Box`
Message-ID: <ZuDVekRzfeBkWmKz@pollux>
References: <20240816001216.26575-1-dakr@kernel.org>
 <20240816001216.26575-10-dakr@kernel.org>
 <0146cb78-5a35-4d6b-bc75-fed1fc0c270c@proton.me>
 <ZuCEneJeXcRo5qs8@pollux>
 <19d81a27-9600-4990-867c-624104e3ad83@proton.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19d81a27-9600-4990-867c-624104e3ad83@proton.me>

On Tue, Sep 10, 2024 at 07:49:42PM +0000, Benno Lossin wrote:
> On 10.09.24 19:40, Danilo Krummrich wrote:
> > On Sat, Aug 31, 2024 at 05:39:07AM +0000, Benno Lossin wrote:
> >> On 16.08.24 02:10, Danilo Krummrich wrote:
> >>> +/// # Examples
> >>> +///
> >>> +/// ```
> >>> +/// let b = KBox::<u64>::new(24_u64, GFP_KERNEL)?;
> >>> +///
> >>> +/// assert_eq!(*b, 24_u64);
> >>> +/// # Ok::<(), Error>(())
> >>> +/// ```
> >>> +///
> >>> +/// ```
> >>> +/// # use kernel::bindings;
> >>> +/// const SIZE: usize = bindings::KMALLOC_MAX_SIZE as usize + 1;
> >>> +/// struct Huge([u8; SIZE]);
> >>> +///
> >>> +/// assert!(KBox::<Huge>::new_uninit(GFP_KERNEL | __GFP_NOWARN).is_err());
> >>> +/// ```
> >>
> >> It would be nice if you could add something like "KBox can't handle big
> >> allocations:" above this example, so that people aren't confused why
> >> this example expects an error.
> > 
> > I don't think that's needed, it's implied by
> > `SIZE == bindings::KMALLOC_MAX_SIZE + 1`.
> > 
> > Surely, we could add it nevertheless, but it's not very precise to just say "big
> > allocations". And I think this isn't the place for lengthy explanations of
> > `Kmalloc` behavior.
> 
> Fair point, nevertheless I find examples a bit more useful, when the
> intention behind them is not only given as code.
> 
> >>> +///
> >>> +/// ```
> >>> +/// # use kernel::bindings;
> >>> +/// const SIZE: usize = bindings::KMALLOC_MAX_SIZE as usize + 1;
> >>> +/// struct Huge([u8; SIZE]);
> >>> +///
> >>> +/// assert!(KVBox::<Huge>::new_uninit(GFP_KERNEL).is_ok());
> >>> +/// ```
> >>
> >> Similarly, you could then say above this one "Instead use either `VBox`
> >> or `KVBox`:"
> >>
> >>> +///
> >>> +/// # Invariants
> >>> +///
> >>> +/// The [`Box`]' pointer is always properly aligned and either points to memory allocated with `A`
> >>
> >> Please use `self.0` instead of "[`Box`]'".
> >>
> >>> +/// or, for zero-sized types, is a dangling pointer.
> >>
> >> Probably "dangling, well aligned pointer.".
> > 
> > Does this add any value? For ZSTs everything is "well aligned", isn't it?
> 
> ZSTs can have alignment and then unaligned pointers do exist for them
> (and dereferencing them is UB!):

Where is this documented? The documentation says:

"For operations of size zero, *every* pointer is valid, including the null
pointer. The following points are only concerned with non-zero-sized accesses."
[1]

[1] https://doc.rust-lang.org/std/ptr/index.html

> 
>     #[repr(align(64))]
>     struct Token;
> 
>     fn main() {
>         let t = 64 as *mut Token;
>         let t = unsafe { t.read() }; // this is fine.
>         let t = 4 as *mut Token;
>         let t = unsafe { t.read() }; // this is UB, see below for miri's output
>     }
> 
> Miri complains:
> 
>     error: Undefined Behavior: accessing memory based on pointer with alignment 4, but alignment 64 is required
>      --> src/main.rs:8:22
>       |
>     8 |     let t = unsafe { t.read() }; // this is UB, see below for miri's output
>       |                      ^^^^^^^^ accessing memory based on pointer with alignment 4, but alignment 64 is required
>       |
>       = help: this indicates a bug in the program: it performed an invalid operation, and caused Undefined Behavior
>       = help: see https://doc.rust-lang.org/nightly/reference/behavior-considered-undefined.html for further information
>       = note: BACKTRACE:
>       = note: inside `main` at src/main.rs:8:22: 8:30

`read` explicitly asks for non-null and properly aligned even if `T` has size
zero.

> 
> >>> +#[repr(transparent)]
> >>> +pub struct Box<T: ?Sized, A: Allocator>(NonNull<T>, PhantomData<A>);
> 
> 
> >>> +impl<T, A> Box<T, A>
> >>> +where
> >>> +    T: ?Sized,
> >>> +    A: Allocator,
> >>> +{
> >>> +    /// Creates a new `Box<T, A>` from a raw pointer.
> >>> +    ///
> >>> +    /// # Safety
> >>> +    ///
> >>> +    /// For non-ZSTs, `raw` must point at an allocation allocated with `A`that is sufficiently
> >>> +    /// aligned for and holds a valid `T`. The caller passes ownership of the allocation to the
> >>> +    /// `Box`.
> >>
> >> You don't say what must happen for ZSTs.
> > 
> > Because we don't require anything for a ZST, do we?
> 
> We require a non-null, well aligned pointer (see above).

We indeed do, gonna add it.

> 
> ---
> Cheers,
> Benno
> 
> >>> +    #[inline]
> >>> +    pub const unsafe fn from_raw(raw: *mut T) -> Self {
> >>> +        // INVARIANT: Validity of `raw` is guaranteed by the safety preconditions of this function.
> >>> +        // SAFETY: By the safety preconditions of this function, `raw` is not a NULL pointer.
> >>> +        Self(unsafe { NonNull::new_unchecked(raw) }, PhantomData::<A>)
> >>> +    }
> 

