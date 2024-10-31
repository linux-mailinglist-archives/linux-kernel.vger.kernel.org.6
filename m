Return-Path: <linux-kernel+bounces-390195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B407A9B76C0
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 09:51:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34A491F21A13
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 08:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10CFF170A3D;
	Thu, 31 Oct 2024 08:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AkcCsDr4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9B68F5C;
	Thu, 31 Oct 2024 08:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730364654; cv=none; b=cjYkRGxIrttJnAggrNSztI1JhStHgoxkHB3p0VG/+7cYO+c6wSdRoYmuiSi/eirZ4JInTgwKGDZZlg+PIMiazuFvmbwWRm7VNUjtnnj4C8/4cTvfzWcc7UDqKQT333JSCDmVYt5G+jbhqE5u4/4jekKoQCMEKvCFrwWiJoggd70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730364654; c=relaxed/simple;
	bh=Wp6h48K5Mas/khvzIEO4XGwslNSUiOVt92KuQpVuUVs=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=SXuq0h39DF214ViWue56aDcbVmx0zgbsaQTgW+PCLmrtyziyE7dPlpc8Hfigmn1Y5MJEONtxB7l3OZB+R0vm8jqth+ttaN+13eOURSUZH1VMbSdMx0lJEypjN7PvUJOFhDD7RVtgV9enTauF7Dk2phgkbFPGKDqvWk5U8GqrtkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AkcCsDr4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48349C4CED2;
	Thu, 31 Oct 2024 08:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730364654;
	bh=Wp6h48K5Mas/khvzIEO4XGwslNSUiOVt92KuQpVuUVs=;
	h=From:To:Cc:Subject:In-Reply-To:Date:References:From;
	b=AkcCsDr4R0FNuE4nWCwB2FYFsHuOrcgH0ptDwJM3e9KpgKpWbGnOKjafGPbKVrGFQ
	 LfKDxATtTOZDvqha8SOdEtel1Cv3K8Q4SlRe2JwWlpTYz44NWL9bDW9DMTPNqwvGeo
	 cDA35kR/ENBKfd7cHit0G0EGfgeZh0hO8BhADPaVSkIwrzaQflLy1VM5696QeFUKtX
	 mackjdOF9kcIGHKuOY24vV1bRWGr3G1uo9psOn4Vf57uQ0uqZLhIV3lD9okHTWkS6b
	 7+83nzzOzdmLMNOcVOBWzG0wPcFN9bpOM5KIbKqSl6Ny77+b9Z6X6G2dkJrUApEhn/
	 O/RdkKPQM5PUg==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Tamir Duberstein" <tamird@gmail.com>
Cc: "Miguel Ojeda" <ojeda@kernel.org>,  "Alex Gaynor"
 <alex.gaynor@gmail.com>,  "Boqun Feng" <boqun.feng@gmail.com>,  "Gary Guo"
 <gary@garyguo.net>,  =?us-ascii?Q?=3D=3Futf-8=3FQ=3FBj=3DC3=3DB6rn=3F=3D?=
 Roy Baron
 <bjorn3_gh@protonmail.com>,  "Benno
 Lossin" <benno.lossin@proton.me>,  "Alice Ryhl" <aliceryhl@google.com>,
  "Trevor Gross" <tmgross@umich.edu>,  "Danilo Krummrich"
 <dakr@kernel.org>,  <rust-for-linux@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/5] rust: types: avoid `as` casts, narrow unsafe scope
In-Reply-To: <20241030-borrow-mut-v1-2-8f0ceaf78eaf@gmail.com> (Tamir
	Duberstein's message of "Wed, 30 Oct 2024 16:46:39 -0400")
Date: Thu, 31 Oct 2024 09:41:25 +0100
Message-ID: <87frocpsui.fsf@kernel.org>
References: <20241030-borrow-mut-v1-0-8f0ceaf78eaf@gmail.com>
	<KJyhrgAd_z6Zh0U1iafSryM8P_vhgxML3COlPRUtks83dD0fidaO7EfCaNWqQLhVcN0hqekp3v6qmakvURvCsA==@protonmail.internalid>
	<20241030-borrow-mut-v1-2-8f0ceaf78eaf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Tamir,

"Tamir Duberstein" <tamird@gmail.com> writes:

> Replace `as` casts with `cast{,_const,_mut}` which are a bit safer.
>
> Reduce the scope of unsafe blocks and add missing safety comments where
> an unsafe block has been split into several unsafe blocks.
>
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> ---
>  rust/kernel/alloc/kbox.rs | 32 +++++++++++++++----------
>  rust/kernel/sync/arc.rs   | 59 +++++++++++++++++++++++++++++------------------
>  rust/kernel/types.rs      |  5 ++--
>  3 files changed, 59 insertions(+), 37 deletions(-)
>
> diff --git a/rust/kernel/alloc/kbox.rs b/rust/kernel/alloc/kbox.rs
> index d69c32496b86a2315f81cafc8e6771ebb0cf10d1..7a5fdf7b660fb91ca2a8e5023d69d629b0d66062 100644
> --- a/rust/kernel/alloc/kbox.rs
> +++ b/rust/kernel/alloc/kbox.rs
> @@ -182,12 +182,12 @@ impl<T, A> Box<MaybeUninit<T>, A>
>      ///
>      /// Callers must ensure that the value inside of `b` is in an initialized state.
>      pub unsafe fn assume_init(self) -> Box<T, A> {
> -        let raw = Self::into_raw(self);
> +        let raw = Self::into_raw(self).cast();
>
>          // SAFETY: `raw` comes from a previous call to `Box::into_raw`. By the safety requirements
>          // of this function, the value inside the `Box` is in an initialized state. Hence, it is
>          // safe to reconstruct the `Box` as `Box<T, A>`.
> -        unsafe { Box::from_raw(raw.cast()) }
> +        unsafe { Box::from_raw(raw) }

I don't think this change makes sense, and it also does not do what the
commit message says. The patch has quite a few changes of this pattern,
and I think you should drop those changes from the patch.

I _do_ think changing `as _` to `ptr::cast` makes sense.

>      }
>
>      /// Writes the value and converts to `Box<T, A>`.
> @@ -247,10 +247,10 @@ pub fn pin(x: T, flags: Flags) -> Result<Pin<Box<T, A>>, AllocError>
>
>      /// Forgets the contents (does not run the destructor), but keeps the allocation.
>      fn forget_contents(this: Self) -> Box<MaybeUninit<T>, A> {
> -        let ptr = Self::into_raw(this);
> +        let ptr = Self::into_raw(this).cast();
>
>          // SAFETY: `ptr` is valid, because it came from `Box::into_raw`.
> -        unsafe { Box::from_raw(ptr.cast()) }
> +        unsafe { Box::from_raw(ptr) }
>      }
>
>      /// Drops the contents, but keeps the allocation.
> @@ -356,19 +356,21 @@ impl<T: 'static, A> ForeignOwnable for Box<T, A>
>      type Borrowed<'a> = &'a T;
>
>      fn into_foreign(self) -> *const core::ffi::c_void {
> -        Box::into_raw(self) as _
> +        Box::into_raw(self).cast_const().cast()

But since we are at it, why not be more explicit and do `cast::<core::ffi:c_void>`?

<cut>

> @@ -347,9 +352,11 @@ unsafe fn borrow<'a>(ptr: *const core::ffi::c_void) -> ArcBorrow<'a, T> {
>      }
>
>      unsafe fn from_foreign(ptr: *const core::ffi::c_void) -> Self {
> +        let ptr = ptr.cast_mut().cast();
> +
>          // SAFETY: The safety requirements of this function ensure that `ptr` comes from a previous
>          // call to `Self::into_foreign`.
> -        let inner = unsafe { NonNull::new_unchecked(ptr as _) };
> +        let inner = unsafe { NonNull::new_unchecked(ptr) };
>
>          // SAFETY: By the safety requirement of this function, we know that `ptr` came from
>          // a previous call to `Arc::into_foreign`, which guarantees that `ptr` is valid and
> @@ -376,10 +383,14 @@ fn as_ref(&self) -> &T {
>
>  impl<T: ?Sized> Clone for Arc<T> {
>      fn clone(&self) -> Self {
> +        // SAFETY: By the type invariant, there is necessarily a reference to the object, so it is
> +        // safe to dereference it.

I think it could be "By the type invariant and the existence of `&self`,
it is safe to create a shared reference to the object pointed to by
`self.ptr`."

<cut>

> diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
> index fae80814fa1c5e0f11933f2f15e173f0e3a10fe0..e8b7ff1387381e50d7963978e57b1d567113b035 100644
> --- a/rust/kernel/types.rs
> +++ b/rust/kernel/types.rs
> @@ -418,7 +418,7 @@ pub unsafe fn from_raw(ptr: NonNull<T>) -> Self {
>      /// }
>      ///
>      /// let mut data = Empty {};
> -    /// let ptr = NonNull::<Empty>::new(&mut data as *mut _).unwrap();
> +    /// let ptr = NonNull::new(&mut data).unwrap();
>      /// # // SAFETY: TODO.
>      /// let data_ref: ARef<Empty> = unsafe { ARef::from_raw(ptr) };
>      /// let raw_ptr: NonNull<Empty> = ARef::into_raw(data_ref);
> @@ -450,8 +450,9 @@ fn deref(&self) -> &Self::Target {
>  impl<T: AlwaysRefCounted> From<&T> for ARef<T> {
>      fn from(b: &T) -> Self {
>          b.inc_ref();
> +        let b = b.into();
>          // SAFETY: We just incremented the refcount above.
> -        unsafe { Self::from_raw(NonNull::from(b)) }
> +        unsafe { Self::from_raw(b) }

I think this change makes the code _less_ readable.


Best regards,
Andreas


