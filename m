Return-Path: <linux-kernel+bounces-546384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E5B6A4F9E9
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 10:25:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 512537A4979
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 09:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 571D920468F;
	Wed,  5 Mar 2025 09:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kloenk.dev header.i=@kloenk.dev header.b="saqFg3mH"
Received: from gimli.kloenk.de (gimli.kloenk.de [49.12.72.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 520C02040B0;
	Wed,  5 Mar 2025 09:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.12.72.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741166741; cv=none; b=d4zqNjFWSSTlIns9t3zdIAea6iR9cHRlfMRQ1W/gccjv+xAHHSkotGADq+MqJs8oZzdtFpRc0itnW8H1mrp6gmnQyVb+bUGkc+WqBJt4XATFEg4SNBYGxhbKaRvcgFcp1PX1p6j22EpLJsafbpLcWVVe/FsgrLixYlBiHaOLkwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741166741; c=relaxed/simple;
	bh=lXe7PxbXutFWoKIuABpqkkHsfNh/Br24G2qZ4CJ0yBY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=I1UlJmEC4rt+uWQh+m7+kVdRbfOHNkeAUj4yPQ9jstUOKUPbTgUXlWQWT14uhjqVBFoOSEQVEhxJPoK0TcSKuBYbqJyY3WgwBAKthXxNijVu82qTKK+ASiWnjpPj3fBj4eimExIThKULNbihHuUlC0PlmyrDS7KHMV0Cp+99HV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kloenk.dev; spf=pass smtp.mailfrom=kloenk.dev; dkim=pass (1024-bit key) header.d=kloenk.dev header.i=@kloenk.dev header.b=saqFg3mH; arc=none smtp.client-ip=49.12.72.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kloenk.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kloenk.dev
From: Fiona Behrens <me@kloenk.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kloenk.dev; s=mail;
	t=1741166738; bh=QXYgIxqWlPIwqYUUQYh3vNQyN/YQCtCLqp2fKiHx0No=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=saqFg3mHlmgvGie97P4EXVZtBfFPMdmGGS8gZ8InJX9SH0wO/i/2UNPzql3shqePA
	 Lvcc6W0L3+vkwZq9Gx9ddmgbiIswtUBj2MJPjXCalPV2P7YIw/deoL+vvfz/KmXBfH
	 DJsrFT6kUTjTswWVhEg3cQbZWewZUiEUFkX5qzjM=
To: Benno Lossin <benno.lossin@proton.me>
Cc: Danilo Krummrich <dakr@kernel.org>,  Miguel Ojeda <ojeda@kernel.org>,
  Alex Gaynor <alex.gaynor@gmail.com>,  Boqun Feng <boqun.feng@gmail.com>,
  Gary Guo <gary@garyguo.net>,  =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,
  Andreas Hindborg <a.hindborg@kernel.org>,  Alice Ryhl
 <aliceryhl@google.com>,  Trevor Gross <tmgross@umich.edu>,
  rust-for-linux@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/22] rust: add `ZeroableOption` and implement it
 instead of `Zeroable` for `Option<Box<T, A>>`
In-Reply-To: <20250304225245.2033120-11-benno.lossin@proton.me> (Benno
	Lossin's message of "Tue, 04 Mar 2025 22:54:31 +0000")
References: <20250304225245.2033120-1-benno.lossin@proton.me>
	<20250304225245.2033120-11-benno.lossin@proton.me>
Date: Wed, 05 Mar 2025 10:25:38 +0100
Message-ID: <m2a59zhlrh.fsf@kloenk.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Benno Lossin <benno.lossin@proton.me> writes:

> When making pin-init its own crate, `Zeroable` will no longer be defined
> by the kernel crate and thus implementing it for `Option<Box<T, A>>` is
> no longer possible due to the orphan rule.
> For this reason introduce a new `ZeroableOption` trait that circumvents
> this problem.
>
> Signed-off-by: Benno Lossin <benno.lossin@proton.me>

Reviewed-by: Fiona Behrens <me@kloenk.dev>

> ---
>  rust/kernel/alloc/kbox.rs |  4 ++--
>  rust/pin-init/src/lib.rs  | 11 +++++++++++
>  2 files changed, 13 insertions(+), 2 deletions(-)
>
> diff --git a/rust/kernel/alloc/kbox.rs b/rust/kernel/alloc/kbox.rs
> index 9861433559dc..07150c038e3f 100644
> --- a/rust/kernel/alloc/kbox.rs
> +++ b/rust/kernel/alloc/kbox.rs
> @@ -15,7 +15,7 @@
>  use core::ptr::NonNull;
>  use core::result::Result;
>  
> -use crate::init::{InPlaceWrite, Init, PinInit, Zeroable};
> +use crate::init::{InPlaceWrite, Init, PinInit, ZeroableOption};
>  use crate::init_ext::InPlaceInit;
>  use crate::types::ForeignOwnable;
>  
> @@ -104,7 +104,7 @@
>  //
>  // In this case we are allowed to use `T: ?Sized`, since all zeros is the `None` variant and there
>  // is no problem with a VTABLE pointer being null.
> -unsafe impl<T: ?Sized, A: Allocator> Zeroable for Option<Box<T, A>> {}
> +unsafe impl<T: ?Sized, A: Allocator> ZeroableOption for Box<T, A> {}
>  
>  // SAFETY: `Box` is `Send` if `T` is `Send` because the `Box` owns a `T`.
>  unsafe impl<T, A> Send for Box<T, A>
> diff --git a/rust/pin-init/src/lib.rs b/rust/pin-init/src/lib.rs
> index 5fd8fa7c2ce9..fd2c4fdd0ca4 100644
> --- a/rust/pin-init/src/lib.rs
> +++ b/rust/pin-init/src/lib.rs
> @@ -1297,6 +1297,17 @@ pub unsafe trait PinnedDrop: __internal::HasPinData {
>  /// ```
>  pub unsafe trait Zeroable {}
>  
> +/// Marker trait for types that allow `Option<Self>` to be set to all zeroes in order to write
> +/// `None` to that location.
> +///
> +/// # Safety
> +///
> +/// The implementer needs to ensure that `unsafe impl Zeroable for Option<Self> {}` is sound.

is sound does sound a bit vague, but also don't have ideas.

Thanks
Fiona

> +pub unsafe trait ZeroableOption {}
> +
> +// SAFETY: by the safety requirement of `ZeroableOption`, this is valid.
> +unsafe impl<T: ZeroableOption> Zeroable for Option<T> {}
> +
>  /// Create a new zeroed T.
>  ///
>  /// The returned initializer will write `0x00` to every byte of the given `slot`.

