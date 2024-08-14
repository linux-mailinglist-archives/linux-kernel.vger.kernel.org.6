Return-Path: <linux-kernel+bounces-286109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 01593951690
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 10:26:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 716831F229C6
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 08:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19D14136E18;
	Wed, 14 Aug 2024 08:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nzGBW8yq"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB2413D28F
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 08:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723623987; cv=none; b=tgwSTctNYF42TAwOy3JO6bto0sWb6l8PKzON2a5SJXo3qfzQ2AVlF2/JiPlj5bhZudgfo9h/F2BgmRy9r46x1Iy0O7EC72MFNAGp8eN9yxLAp+20uaqURekDh0dRO/q8xzQ88DqzKNSdcJWpVz1azM7XTGGaqeOSNyHBB92apEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723623987; c=relaxed/simple;
	bh=62pL2XjU9NZjEXg6FHYVpk82cjgBud+cWc/FILW1Ruo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EBsvQDLeAqHLydf5evDQZTQywGVScm97TVgtx1rFT27lX816jI89emCUghkPdp+e8c0J8NeuiwgQ2auP1i3OKLBL3IgB9cdhzQsDL4BXv4gadCqu2oXjh9W9PXTM6YaXT3j4qCRCBDeNxEgM2czj56Ud2UWPguaFGBSXG+/G67I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nzGBW8yq; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-36dd8a35722so2440266f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 01:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723623983; x=1724228783; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+0MBDb5+vXEVzKIZLapFfRuEtH5IYfsSmO/Hh3Pyjq4=;
        b=nzGBW8yqu0zCMppQHBwkec+JW1E5NPrywHoDR1IoRs7kgcowXA/PwW4rbDy1M2I48q
         2LlcUtzBDGBeGNO6tIWvTLh6VcZQhMnFi+RvFPXa3g/2QNBTeq9nSveqI7OBIxNfk6UA
         mcvEQL9varBrA9pCL147HKYiqREvDyhoJoXLnaAxn4fjS0N1nBXpX3R9lZpjj8B67tqJ
         LscLklZCBPdBWxEMF7BPLXDt6/eyqfsVLhLXjpsd1BxJHpmySdnfFMtJtAe9vbOUsrD4
         +YbtIgMugQMtpJCYTfa4ti8odhv9tU/QVzsvFZtxP0LYmmhq6pr4oFL8jfQTVPlvohfA
         XiZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723623983; x=1724228783;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+0MBDb5+vXEVzKIZLapFfRuEtH5IYfsSmO/Hh3Pyjq4=;
        b=U8/73HJ1EayaY34ZdAag4L/K212Ou0EfnL8JjqpDzsmz5HOFqxjbiuhRIkx+THXX4l
         S43Dvvd9jOZz0UmdSknTvi6grMuoGiMS3JpT/gNgM30k4ZqY/GO+P047CbssCHim+qMe
         Tow3lyMkve6lVdDGTu7FutDIc61wpKIg9zat2wxp9J6NCTD/xneWumoZgpNScJByMKX0
         z2h8qrH7diXkiKoOAJ0q0qfl+MqtPSPjdbhArsRELsilP/23DTIKqFl5dW0+HPcAKd3m
         aSCIDvVxeswn1wll+dyfI9K4Zm/bx262tC6dmZVpxlefxZuZgeh0D0s+Ptqi0ATQC0Cq
         Td/w==
X-Forwarded-Encrypted: i=1; AJvYcCW/UKZaCkrb1McA85bblM5DwxtrcvNTwy5h0dSh1NlcorKEMNhAopN7vRrL9/9HzQwjAM4p59QmSYMSXKO2KMSJrtaBIaR9WhSfqi3O
X-Gm-Message-State: AOJu0YyG4RUa7TfO8AXCOX6rrQs8dxeELU4Cu0lKbHcmm8QwUrvYI2HE
	eZjCrcCzWRDyDeJzlndb3fS9aR9uaVuTy9mPSenk0YU8KV1y0fEESA3YPLCclS8UUIKlmVzrdUS
	tgPkbE6A7gZceSllwFkrbUVAKNMz5fg8oK0GE
X-Google-Smtp-Source: AGHT+IHCm0scg6mxW0JEpekgZhvKx5QWQ3ad6jquJgs9Up2YmI7n5FfGy3MiFPjp1CZznyAwqTEgCkSzOHAEpNW6ylk=
X-Received: by 2002:a5d:5e13:0:b0:371:79f0:2cf6 with SMTP id
 ffacd0b85a97d-37179f02ef3mr583706f8f.11.1723623983239; Wed, 14 Aug 2024
 01:26:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240812182355.11641-1-dakr@kernel.org> <20240812182355.11641-10-dakr@kernel.org>
In-Reply-To: <20240812182355.11641-10-dakr@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 14 Aug 2024 10:26:10 +0200
Message-ID: <CAH5fLgiyDtMWKe0db+uvKGPoPRepjiSxddSrBh8jF1N1COpdDg@mail.gmail.com>
Subject: Re: [PATCH v5 09/26] rust: alloc: implement kernel `Box`
To: Danilo Krummrich <dakr@kernel.org>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com, 
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	benno.lossin@proton.me, a.hindborg@samsung.com, akpm@linux-foundation.org, 
	daniel.almeida@collabora.com, faith.ekstrand@collabora.com, 
	boris.brezillon@collabora.com, lina@asahilina.net, mcanal@igalia.com, 
	zhiw@nvidia.com, cjia@nvidia.com, jhubbard@nvidia.com, airlied@redhat.com, 
	ajanulgu@redhat.com, lyude@redhat.com, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 12, 2024 at 8:25=E2=80=AFPM Danilo Krummrich <dakr@kernel.org> =
wrote:
>
> `Box` provides the simplest way to allocate memory for a generic type
> with one of the kernel's allocators, e.g. `Kmalloc`, `Vmalloc` or
> `KVmalloc`.
>
> In contrast to Rust's `Box` type, the kernel `Box` type considers the
> kernel's GFP flags for all appropriate functions, always reports
> allocation failures through `Result<_, AllocError>` and remains
> independent from unstable features.
>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
>  rust/kernel/alloc.rs      |   6 +
>  rust/kernel/alloc/kbox.rs | 423 ++++++++++++++++++++++++++++++++++++++
>  rust/kernel/prelude.rs    |   2 +-
>  3 files changed, 430 insertions(+), 1 deletion(-)
>  create mode 100644 rust/kernel/alloc/kbox.rs
>
> diff --git a/rust/kernel/alloc.rs b/rust/kernel/alloc.rs
> index 295107777a12..ed46b69204d0 100644
> --- a/rust/kernel/alloc.rs
> +++ b/rust/kernel/alloc.rs
> @@ -5,6 +5,7 @@
>  #[cfg(not(any(test, testlib)))]
>  pub mod allocator;
>  pub mod box_ext;
> +pub mod kbox;
>  pub mod vec_ext;
>
>  #[cfg(any(test, testlib))]
> @@ -13,6 +14,11 @@
>  #[cfg(any(test, testlib))]
>  pub use self::allocator_test as allocator;
>
> +pub use self::kbox::Box;
> +pub use self::kbox::KBox;
> +pub use self::kbox::KVBox;
> +pub use self::kbox::VBox;
> +
>  /// Indicates an allocation error.
>  #[derive(Copy, Clone, PartialEq, Eq, Debug)]
>  pub struct AllocError;
> diff --git a/rust/kernel/alloc/kbox.rs b/rust/kernel/alloc/kbox.rs
> new file mode 100644
> index 000000000000..67bdfc0712d2
> --- /dev/null
> +++ b/rust/kernel/alloc/kbox.rs
> @@ -0,0 +1,423 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Implementation of [`Box`].
> +
> +use super::{AllocError, Allocator, Flags};
> +use core::fmt;
> +use core::marker::PhantomData;
> +use core::mem::ManuallyDrop;
> +use core::mem::MaybeUninit;
> +use core::ops::{Deref, DerefMut};
> +use core::pin::Pin;
> +use core::ptr::NonNull;
> +use core::result::Result;
> +
> +use crate::init::{InPlaceInit, Init, PinInit};
> +use crate::types::ForeignOwnable;
> +
> +/// The kernel's [`Box`] type - a heap allocation for a single value of =
type `T`.
> +///
> +/// This is the kernel's version of the Rust stdlib's `Box`. There are a=
 couple of differences,
> +/// for example no `noalias` attribute is emitted and partially moving o=
ut of a `Box` is not
> +/// supported.
> +///
> +/// `Box` works with any of the kernel's allocators, e.g. [`super::alloc=
ator::Kmalloc`],
> +/// [`super::allocator::Vmalloc`] or [`super::allocator::KVmalloc`]. The=
re are aliases for `Box`
> +/// with these allocators ([`KBox`], [`VBox`], [`KVBox`]).
> +///
> +/// When dropping a [`Box`], the value is also dropped and the heap memo=
ry is automatically freed.
> +///
> +/// # Examples
> +///
> +/// ```
> +/// let b =3D KBox::<u64>::new(24_u64, GFP_KERNEL)?;
> +///
> +/// assert_eq!(*b, 24_u64);
> +///
> +/// # Ok::<(), Error>(())

This is a minor nit, but when hiding lines in examples you should
avoid having the rendered docs have empty lines at the beginning/end.
There are also several examples of this below with the
kernel::bindings import.

> +/// ```
> +///
> +/// ```
> +/// # use kernel::bindings;
> +///
> +/// const SIZE: usize =3D bindings::KMALLOC_MAX_SIZE as usize + 1;
> +/// struct Huge([u8; SIZE]);
> +///
> +/// assert!(KBox::<Huge>::new_uninit(GFP_KERNEL | __GFP_NOWARN).is_err()=
);
> +/// ```
> +///
> +/// ```
> +/// # use kernel::bindings;
> +///
> +/// const SIZE: usize =3D bindings::KMALLOC_MAX_SIZE as usize + 1;
> +/// struct Huge([u8; SIZE]);
> +///
> +/// assert!(KVBox::<Huge>::new_uninit(GFP_KERNEL).is_ok());
> +/// ```
> +///
> +/// # Invariants
> +///
> +/// The [`Box`]' pointer always properly aligned and either points to me=
mory allocated with `A` or,
> +/// for zero-sized types, is a dangling pointer.
> +pub struct Box<T: ?Sized, A: Allocator>(NonNull<T>, PhantomData<A>);

I was about to say this needs a PhantomData<T> too, but I guess it
isn't necessary anymore.
https://doc.rust-lang.org/nomicon/phantom-data.html#generic-parameters-and-=
drop-checking

> +// SAFETY: `Box` is `Send` if `T` is `Send` because the data referenced =
by `self.0` is unaliased.

Instead of "unaliased" I would probably just say "because the Box owns a T"=
.

> +
> +// SAFETY: `Box` is `Sync` if `T` is `Sync` because the data referenced =
by `self.0` is unaliased.
> +unsafe impl<T, A> Sync for Box<T, A>
> +where
> +    T: Send + ?Sized,
> +    A: Allocator,

This needs to say `T: Sync` instead of `T: Send`. That matches the std Box.

> +
> +impl<T, A> Box<T, A>
> +where
> +    T: ?Sized,
> +    A: Allocator,
> +{
> +    /// Creates a new `Box<T, A>` from a raw pointer.
> +    ///
> +    /// # Safety
> +    ///
> +    /// `raw` must point to valid memory, previously be allocated with `=
A`, and provide at least
> +    /// the size of type `T`. For ZSTs `raw` must be a dangling pointer.

Hmm. I don't love this wording. How about this?

For non-ZSTs, `raw` must point at a live allocation allocated with `A`
that is sufficiently aligned for and holds a valid `T`. The caller
passes ownership of the allocation to the `Box`. For ZSTs, the pointer
must be non-null and aligned.

> +impl<T, A> From<Box<T, A>> for Pin<Box<T, A>>
> +where
> +    T: ?Sized,
> +    A: Allocator,
> +{
> +    /// Converts a `Box<T, A>` into a `Pin<Box<T, A>>`. If `T` does not =
implement [`Unpin`], then
> +    /// `*b` will be pinned in memory and can't be moved.
> +    ///
> +    /// See [`Box::into_pin`] for more details.
> +    fn from(b: Box<T, A>) -> Self {
> +        Box::into_pin(b)

I still think it makes more sense to match std and only provide From
and not an into_pin, but it's not a blocker.

Alice

