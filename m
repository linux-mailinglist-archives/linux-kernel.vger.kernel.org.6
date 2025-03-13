Return-Path: <linux-kernel+bounces-559316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D060CA5F243
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 12:24:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EC3B1890971
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 11:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68A8D266191;
	Thu, 13 Mar 2025 11:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kloenk.dev header.i=@kloenk.dev header.b="o9XOb28U"
Received: from gimli.kloenk.de (gimli.kloenk.de [49.12.72.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D487B1E8325;
	Thu, 13 Mar 2025 11:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.12.72.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741865077; cv=none; b=ogvD8KJKIXGFIv1lZ9hoqz+70YMrX5sjqfJQPOiAn4PG4oXpHY/Lgemjpcw/3ncnGzqB/laYlvJS6zmj501nJUSQe9Ed9+8VjdHBrILsyuPjeQHrqAYM8dHMK6vTwUIvB0NZ3IcTEFq0E+Nz4q1IKOUF5Hi220cgmV700joT6bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741865077; c=relaxed/simple;
	bh=M8MfpkzBK+QuuBiw77xJtMZAqV2FLi/iPiXKGGpQVz0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NXsyfEX9kaxFZgk6KViiEhRuunbLbn8EiTCZ3JoIz/nSLRNuhfKjRBolsS1Dev13tptaaj6b6myFr8mhdnFxmuKpfGI95Po20xVIiNbPdsRRumB1RD5mgdFTsjhZsu8rlE6An+mc57obXw6YQwI4R9atWDW0zbVjnRvIbJXLMbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kloenk.dev; spf=pass smtp.mailfrom=kloenk.dev; dkim=pass (1024-bit key) header.d=kloenk.dev header.i=@kloenk.dev header.b=o9XOb28U; arc=none smtp.client-ip=49.12.72.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kloenk.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kloenk.dev
From: Fiona Behrens <me@kloenk.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kloenk.dev; s=mail;
	t=1741865073; bh=358kCQRfQ9nI7dbrHfqIs5um/4vIyZLgVmCBk3AJWaM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=o9XOb28UmexJTluixcW9c8DHfE+30BBLV+S2O6Xr3vNkr/6/yk7Fks8oV+LqPrr8W
	 jke8ZgCWw/X16HNB9RpwB0v0QY+Tpat0/rZJkNnIkEAeYc3hGbo3LbHgVvn9I37j61
	 H6otCVy60OcaGDZFt9aeehPe/zMjG4HNMIdfdzEs=
To: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>,  Alex Gaynor <alex.gaynor@gmail.com>,
  Boqun Feng <boqun.feng@gmail.com>,  Gary Guo <gary@garyguo.net>,
  =?utf-8?Q?Bj=C3=B6rn?=
 Roy Baron <bjorn3_gh@protonmail.com>,  Andreas Hindborg
 <a.hindborg@kernel.org>,  Alice Ryhl <aliceryhl@google.com>,  Trevor Gross
 <tmgross@umich.edu>,  rust-for-linux@vger.kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 19/22] rust: pin-init: miscellaneous synchronization
 with the user-space version
In-Reply-To: <20250308110339.2997091-20-benno.lossin@proton.me> (Benno
	Lossin's message of "Sat, 08 Mar 2025 11:05:27 +0000")
References: <20250308110339.2997091-1-benno.lossin@proton.me>
	<20250308110339.2997091-20-benno.lossin@proton.me>
Date: Thu, 13 Mar 2025 12:24:33 +0100
Message-ID: <m2o6y5xjf2.fsf@kloenk.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Benno Lossin <benno.lossin@proton.me> writes:

> Remove the last differences between the kernel version and the
> user-space version.
>
> Signed-off-by: Benno Lossin <benno.lossin@proton.me>
> Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
> Tested-by: Andreas Hindborg <a.hindborg@kernel.org>

Reviewed-by: Fiona Behrens <me@kloenk.dev>

> ---
>  rust/pin-init/internal/src/lib.rs | 5 ++---
>  rust/pin-init/src/__internal.rs   | 2 +-
>  rust/pin-init/src/lib.rs          | 2 --
>  3 files changed, 3 insertions(+), 6 deletions(-)
>
> diff --git a/rust/pin-init/internal/src/lib.rs b/rust/pin-init/internal/src/lib.rs
> index 30e145f80bc0..babe5e878550 100644
> --- a/rust/pin-init/internal/src/lib.rs
> +++ b/rust/pin-init/internal/src/lib.rs
> @@ -14,6 +14,8 @@
>  //
>  // Remove once we have `proc_macro2` in the kernel.
>  #![allow(clippy::useless_conversion)]
> +// Documentation is done in the pin-init crate instead.
> +#![allow(missing_docs)]
>  
>  use proc_macro::TokenStream;
>  
> @@ -30,19 +32,16 @@
>  mod pinned_drop;
>  mod zeroable;
>  
> -#[allow(missing_docs)]
>  #[proc_macro_attribute]
>  pub fn pin_data(inner: TokenStream, item: TokenStream) -> TokenStream {
>      pin_data::pin_data(inner.into(), item.into()).into()
>  }
>  
> -#[allow(missing_docs)]
>  #[proc_macro_attribute]
>  pub fn pinned_drop(args: TokenStream, input: TokenStream) -> TokenStream {
>      pinned_drop::pinned_drop(args.into(), input.into()).into()
>  }
>  
> -#[allow(missing_docs)]
>  #[proc_macro_derive(Zeroable)]
>  pub fn derive_zeroable(input: TokenStream) -> TokenStream {
>      zeroable::derive(input.into()).into()
> diff --git a/rust/pin-init/src/__internal.rs b/rust/pin-init/src/__internal.rs
> index 7f7744d48575..557b5948cddc 100644
> --- a/rust/pin-init/src/__internal.rs
> +++ b/rust/pin-init/src/__internal.rs
> @@ -14,7 +14,7 @@
>  ///
>  /// [nomicon]: https://doc.rust-lang.org/nomicon/subtyping.html
>  /// [this table]: https://doc.rust-lang.org/nomicon/phantom-data.html#table-of-phantomdata-patterns
> -pub(super) type Invariant<T> = PhantomData<fn(*mut T) -> *mut T>;
> +pub(crate) type Invariant<T> = PhantomData<fn(*mut T) -> *mut T>;
>  
>  /// Module-internal type implementing `PinInit` and `Init`.
>  ///
> diff --git a/rust/pin-init/src/lib.rs b/rust/pin-init/src/lib.rs
> index a00288133ae3..45880ffa81bb 100644
> --- a/rust/pin-init/src/lib.rs
> +++ b/rust/pin-init/src/lib.rs
> @@ -349,8 +349,6 @@
>  ///     }
>  /// }
>  /// ```
> -///
> -/// [`pin_init!`]: crate::pin_init
>  pub use ::pin_init_internal::pin_data;
>  
>  /// Used to implement `PinnedDrop` safely.

