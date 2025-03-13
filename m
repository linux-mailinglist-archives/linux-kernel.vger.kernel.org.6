Return-Path: <linux-kernel+bounces-559314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9849FA5F23F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 12:23:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8D2717E538
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 11:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D579226619A;
	Thu, 13 Mar 2025 11:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kloenk.dev header.i=@kloenk.dev header.b="CrSw37as"
Received: from gimli.kloenk.de (gimli.kloenk.de [49.12.72.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191E51D7984;
	Thu, 13 Mar 2025 11:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.12.72.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741864980; cv=none; b=M3ackeZ5Jq6o1UIqdggZQl8QBuqf95gWsFGhYfvl5qCXiFUA8DC1bK8ihkucm/yzyvvOZeFBORbBsBbRLqKZcV8OX5eTDvRbEYDMuc3YsYKF7rkCB0Gke6xENe9h8D/hBUN1qjgn6sUHfZnoxKUbSPzwj9yz6vC10tEYBJ7JTus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741864980; c=relaxed/simple;
	bh=XY+iNNACdBsMNypqI8/Hgwk7dDdT2rxt/fpEeetk9SM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eipe9riwkZTJ4PO2nX2sxTbjsEAzDDDq2aH+hr+0NJVqtQ27K3ByjdfYaRQj63JGhdo53EOImoxkz8jAG/U3gZHI3LhjLd38Cs4OzvLe0wwqDppacUNEpeXjr1D5ULa5tIsV+fUhJljN+JfPZaesl5IV3i+geSCP3IUgYKQ+oDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kloenk.dev; spf=pass smtp.mailfrom=kloenk.dev; dkim=pass (1024-bit key) header.d=kloenk.dev header.i=@kloenk.dev header.b=CrSw37as; arc=none smtp.client-ip=49.12.72.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kloenk.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kloenk.dev
From: Fiona Behrens <me@kloenk.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kloenk.dev; s=mail;
	t=1741864973; bh=jSXSMSPF0QFuoZukFVRkPbDl46MFQbzURRYuYJ5wXt4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=CrSw37asf6/iFodL/wjtvKlMgUKSF9zkaUaxcsP6zHkmrGE1+J/OBGPKbkHYn+U1m
	 2Tc2m5mSDjDd2sIf3EvmzDobOXUNsijIwCfX6OxspfQsmaJ2WoNAd+1WB3f7AD8xDr
	 7WUJC9B6pMdMc2RKIoAD1LzJ5qgkj8hV/xy4NLmg=
To: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>,  Alex Gaynor <alex.gaynor@gmail.com>,
  Boqun Feng <boqun.feng@gmail.com>,  Gary Guo <gary@garyguo.net>,
  =?utf-8?Q?Bj=C3=B6rn?=
 Roy Baron <bjorn3_gh@protonmail.com>,  Andreas Hindborg
 <a.hindborg@kernel.org>,  Alice Ryhl <aliceryhl@google.com>,  Trevor Gross
 <tmgross@umich.edu>,  rust-for-linux@vger.kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 18/22] rust: pin-init: internal: synchronize with
 user-space version
In-Reply-To: <20250308110339.2997091-19-benno.lossin@proton.me> (Benno
	Lossin's message of "Sat, 08 Mar 2025 11:05:22 +0000")
References: <20250308110339.2997091-1-benno.lossin@proton.me>
	<20250308110339.2997091-19-benno.lossin@proton.me>
Date: Thu, 13 Mar 2025 12:22:52 +0100
Message-ID: <m2tt7xxjhv.fsf@kloenk.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Benno Lossin <benno.lossin@proton.me> writes:

> Synchronize the internal macros crate with the user-space version that
> uses the quote crate [1] instead of a custom `quote!` macro. The imports
> in the different version are achieved using `cfg` on the kernel config
> value. This cfg is always set in the kernel and never set in the
> user-space version.
>
> Since the quote crate requires the proc_macro2 crate, imports also need
> to be adjusted and `.into()` calls have to be inserted.
>
> Link: https://crates.io/crates/quote [1]
> Signed-off-by: Benno Lossin <benno.lossin@proton.me>
> Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
> Tested-by: Andreas Hindborg <a.hindborg@kernel.org>

Reviewed-by: Fiona Behrens <me@Kloenk.dev>

> ---
>  rust/pin-init/internal/src/helpers.rs     |  3 +++
>  rust/pin-init/internal/src/lib.rs         | 16 +++++++++++++---
>  rust/pin-init/internal/src/pin_data.rs    |  3 +++
>  rust/pin-init/internal/src/pinned_drop.rs |  3 +++
>  rust/pin-init/internal/src/zeroable.rs    |  3 +++
>  5 files changed, 25 insertions(+), 3 deletions(-)
>
> diff --git a/rust/pin-init/internal/src/helpers.rs b/rust/pin-init/internal/src/helpers.rs
> index 78521ba19d0b..236f989a50f2 100644
> --- a/rust/pin-init/internal/src/helpers.rs
> +++ b/rust/pin-init/internal/src/helpers.rs
> @@ -1,5 +1,8 @@
>  // SPDX-License-Identifier: Apache-2.0 OR MIT
>  
> +#[cfg(not(kernel))]
> +use proc_macro2 as proc_macro;
> +
>  use proc_macro::{TokenStream, TokenTree};
>  
>  /// Parsed generics.
> diff --git a/rust/pin-init/internal/src/lib.rs b/rust/pin-init/internal/src/lib.rs
> index c201b8a53915..30e145f80bc0 100644
> --- a/rust/pin-init/internal/src/lib.rs
> +++ b/rust/pin-init/internal/src/lib.rs
> @@ -7,6 +7,13 @@
>  //! `pin-init` proc macros.
>  
>  #![cfg_attr(not(RUSTC_LINT_REASONS_IS_STABLE), feature(lint_reasons))]
> +// Allow `.into()` to convert
> +// - `proc_macro2::TokenStream` into `proc_macro::TokenStream` in the user-space version.
> +// - `proc_macro::TokenStream` into `proc_macro::TokenStream` in the kernel version.
> +//   Clippy warns on this conversion, but it's required by the user-space version.
> +//
> +// Remove once we have `proc_macro2` in the kernel.
> +#![allow(clippy::useless_conversion)]
>  
>  use proc_macro::TokenStream;
>  
> @@ -14,6 +21,9 @@
>  #[path = "../../../macros/quote.rs"]
>  #[macro_use]
>  mod quote;
> +#[cfg(not(kernel))]
> +#[macro_use]
> +extern crate quote;
>  
>  mod helpers;
>  mod pin_data;
> @@ -23,17 +33,17 @@
>  #[allow(missing_docs)]
>  #[proc_macro_attribute]
>  pub fn pin_data(inner: TokenStream, item: TokenStream) -> TokenStream {
> -    pin_data::pin_data(inner, item)
> +    pin_data::pin_data(inner.into(), item.into()).into()
>  }
>  
>  #[allow(missing_docs)]
>  #[proc_macro_attribute]
>  pub fn pinned_drop(args: TokenStream, input: TokenStream) -> TokenStream {
> -    pinned_drop::pinned_drop(args, input)
> +    pinned_drop::pinned_drop(args.into(), input.into()).into()
>  }
>  
>  #[allow(missing_docs)]
>  #[proc_macro_derive(Zeroable)]
>  pub fn derive_zeroable(input: TokenStream) -> TokenStream {
> -    zeroable::derive(input)
> +    zeroable::derive(input.into()).into()
>  }
> diff --git a/rust/pin-init/internal/src/pin_data.rs b/rust/pin-init/internal/src/pin_data.rs
> index 9b974498f4a8..87d4a7eb1d35 100644
> --- a/rust/pin-init/internal/src/pin_data.rs
> +++ b/rust/pin-init/internal/src/pin_data.rs
> @@ -1,5 +1,8 @@
>  // SPDX-License-Identifier: Apache-2.0 OR MIT
>  
> +#[cfg(not(kernel))]
> +use proc_macro2 as proc_macro;
> +
>  use crate::helpers::{parse_generics, Generics};
>  use proc_macro::{Group, Punct, Spacing, TokenStream, TokenTree};
>  
> diff --git a/rust/pin-init/internal/src/pinned_drop.rs b/rust/pin-init/internal/src/pinned_drop.rs
> index 386f52f73c06..c824dd8b436d 100644
> --- a/rust/pin-init/internal/src/pinned_drop.rs
> +++ b/rust/pin-init/internal/src/pinned_drop.rs
> @@ -1,5 +1,8 @@
>  // SPDX-License-Identifier: Apache-2.0 OR MIT
>  
> +#[cfg(not(kernel))]
> +use proc_macro2 as proc_macro;
> +
>  use proc_macro::{TokenStream, TokenTree};
>  
>  pub(crate) fn pinned_drop(_args: TokenStream, input: TokenStream) -> TokenStream {
> diff --git a/rust/pin-init/internal/src/zeroable.rs b/rust/pin-init/internal/src/zeroable.rs
> index 0cf6732f27dc..acc94008c152 100644
> --- a/rust/pin-init/internal/src/zeroable.rs
> +++ b/rust/pin-init/internal/src/zeroable.rs
> @@ -1,5 +1,8 @@
>  // SPDX-License-Identifier: GPL-2.0
>  
> +#[cfg(not(kernel))]
> +use proc_macro2 as proc_macro;
> +
>  use crate::helpers::{parse_generics, Generics};
>  use proc_macro::{TokenStream, TokenTree};

