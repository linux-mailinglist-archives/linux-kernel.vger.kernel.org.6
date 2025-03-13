Return-Path: <linux-kernel+bounces-559306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3285AA5F228
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 12:16:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C439E19C1F3A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 11:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6895266185;
	Thu, 13 Mar 2025 11:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kloenk.dev header.i=@kloenk.dev header.b="fU+//4vS"
Received: from gimli.kloenk.de (gimli.kloenk.de [49.12.72.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8335C1D7984;
	Thu, 13 Mar 2025 11:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.12.72.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741864607; cv=none; b=FpoMRckuPLl9mRuOTFubxKZc4opxO7+npzLW7vyY98IHaViwPgU/xrcCvZtzFRa996voWGrl4AoKDtuO4+abRFnV4hsNXXYkLswShCzFlwjVR5mW4FO3i879bDk0yfh/zOw5MpT10KpS+CjgwN7JcNKNcFRVAI3YJUxkWpBj38c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741864607; c=relaxed/simple;
	bh=AhTgMZNp4D2is04ByAJUqKTuWT82jhpRXpZRSKPmoxE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EyCfWxuVNcfdAbck14dnLaMhjfX25TzYMNksupRyxxr6c7KphrHHzIH3BtzBC2cZzh/tWXXKwAuTrTGHzXAg1xsBai3JGX1LAmj11fhINmNCgRuOKEzV2sx58GvXpTRBS2o+DzdRseWf4iZg6wV4xWvaCrtteQSXDa8ofJYV7KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kloenk.dev; spf=pass smtp.mailfrom=kloenk.dev; dkim=pass (1024-bit key) header.d=kloenk.dev header.i=@kloenk.dev header.b=fU+//4vS; arc=none smtp.client-ip=49.12.72.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kloenk.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kloenk.dev
From: Fiona Behrens <me@kloenk.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kloenk.dev; s=mail;
	t=1741864597; bh=60ZND3jJQUMY3L36GWenEamlL5JvgMG9LnAmaBbzKyQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=fU+//4vScitbpQMWN8/BnpKcAA5hiWm/YxRf1cwfo3DGCME7+q7s42LUp/xItfxW7
	 RCWGwt//xeQuDYeZEiNHLhF431ZJJ9Lx2VnLRQkjxjN4drVOldk5i+yffDfXJTamIY
	 o0I1ha6VjzwuvI6b1W7bS+b7xK9xlr6u9szKI/3o=
To: Benno Lossin <benno.lossin@proton.me>
Cc: Danilo Krummrich <dakr@kernel.org>,  Miguel Ojeda <ojeda@kernel.org>,
  Alex Gaynor <alex.gaynor@gmail.com>,  Boqun Feng <boqun.feng@gmail.com>,
  Gary Guo <gary@garyguo.net>,  =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,
  Andreas Hindborg <a.hindborg@kernel.org>,  Alice Ryhl
 <aliceryhl@google.com>,  Trevor Gross <tmgross@umich.edu>,
  rust-for-linux@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 09/22] rust: pin-init: move impl `Zeroable` for
 `Opaque` and `Option<KBox<T>>` into the kernel crate
In-Reply-To: <20250308110339.2997091-10-benno.lossin@proton.me> (Benno
	Lossin's message of "Sat, 08 Mar 2025 11:04:38 +0000")
References: <20250308110339.2997091-1-benno.lossin@proton.me>
	<20250308110339.2997091-10-benno.lossin@proton.me>
Date: Thu, 13 Mar 2025 12:16:36 +0100
Message-ID: <m2zfhpxjsb.fsf@kloenk.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Benno Lossin <benno.lossin@proton.me> writes:

> In order to make pin-init a standalone crate, move kernel-specific code
> directly into the kernel crate. Since `Opaque<T>` and `KBox<T>` are part
> of the kernel, move their `Zeroable` implementation into the kernel
> crate.
>
> Signed-off-by: Benno Lossin <benno.lossin@proton.me>
> Tested-by: Andreas Hindborg <a.hindborg@kernel.org>

Reviewed-by: Fiona Behrens <me@kloenk.dev>

> ---
>  rust/kernel/alloc/kbox.rs | 8 +++++++-
>  rust/kernel/types.rs      | 5 ++++-
>  rust/pin-init/src/lib.rs  | 8 +-------
>  3 files changed, 12 insertions(+), 9 deletions(-)
>
> diff --git a/rust/kernel/alloc/kbox.rs b/rust/kernel/alloc/kbox.rs
> index 39a3ea7542da..9861433559dc 100644
> --- a/rust/kernel/alloc/kbox.rs
> +++ b/rust/kernel/alloc/kbox.rs
> @@ -15,7 +15,7 @@
>  use core::ptr::NonNull;
>  use core::result::Result;
>  
> -use crate::init::{InPlaceWrite, Init, PinInit};
> +use crate::init::{InPlaceWrite, Init, PinInit, Zeroable};
>  use crate::init_ext::InPlaceInit;
>  use crate::types::ForeignOwnable;
>  
> @@ -100,6 +100,12 @@
>  /// ```
>  pub type KVBox<T> = Box<T, super::allocator::KVmalloc>;
>  
> +// SAFETY: All zeros is equivalent to `None` (option layout optimization guarantee).
> +//
> +// In this case we are allowed to use `T: ?Sized`, since all zeros is the `None` variant and there
> +// is no problem with a VTABLE pointer being null.
> +unsafe impl<T: ?Sized, A: Allocator> Zeroable for Option<Box<T, A>> {}
> +
>  // SAFETY: `Box` is `Send` if `T` is `Send` because the `Box` owns a `T`.
>  unsafe impl<T, A> Send for Box<T, A>
>  where
> diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
> index 2bbaab83b9d6..9f75bd3866e8 100644
> --- a/rust/kernel/types.rs
> +++ b/rust/kernel/types.rs
> @@ -2,7 +2,7 @@
>  
>  //! Kernel types.
>  
> -use crate::init::{self, PinInit};
> +use crate::init::{self, PinInit, Zeroable};
>  use core::{
>      cell::UnsafeCell,
>      marker::{PhantomData, PhantomPinned},
> @@ -309,6 +309,9 @@ pub struct Opaque<T> {
>      _pin: PhantomPinned,
>  }
>  
> +// SAFETY: `Opaque<T>` allows the inner value to be any bit pattern, including all zeros.
> +unsafe impl<T> Zeroable for Opaque<T> {}
> +
>  impl<T> Opaque<T> {
>      /// Creates a new opaque value.
>      pub const fn new(value: T) -> Self {
> diff --git a/rust/pin-init/src/lib.rs b/rust/pin-init/src/lib.rs
> index f88465e0bb76..aad6486d33fc 100644
> --- a/rust/pin-init/src/lib.rs
> +++ b/rust/pin-init/src/lib.rs
> @@ -211,10 +211,7 @@
>  //! [`pin_data`]: ::macros::pin_data
>  //! [`pin_init!`]: crate::pin_init!
>  
> -use crate::{
> -    alloc::KBox,
> -    types::{Opaque, ScopeGuard},
> -};
> +use crate::{alloc::KBox, types::ScopeGuard};
>  use core::{
>      cell::UnsafeCell,
>      convert::Infallible,
> @@ -1342,8 +1339,6 @@ macro_rules! impl_zeroable {
>  
>      // SAFETY: Type is allowed to take any value, including all zeros.
>      {<T>} MaybeUninit<T>,
> -    // SAFETY: Type is allowed to take any value, including all zeros.
> -    {<T>} Opaque<T>,
>  
>      // SAFETY: `T: Zeroable` and `UnsafeCell` is `repr(transparent)`.
>      {<T: ?Sized + Zeroable>} UnsafeCell<T>,
> @@ -1358,7 +1353,6 @@ macro_rules! impl_zeroable {
>      //
>      // In this case we are allowed to use `T: ?Sized`, since all zeros is the `None` variant.
>      {<T: ?Sized>} Option<NonNull<T>>,
> -    {<T: ?Sized>} Option<KBox<T>>,
>  
>      // SAFETY: `null` pointer is valid.
>      //

