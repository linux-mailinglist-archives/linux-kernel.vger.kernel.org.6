Return-Path: <linux-kernel+bounces-577665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D103FA72004
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 21:27:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 186F37A63D8
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 20:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E42D259C98;
	Wed, 26 Mar 2025 20:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="UPsmt8j8"
Received: from mail-10630.protonmail.ch (mail-10630.protonmail.ch [79.135.106.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE80258CF3
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 20:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743020811; cv=none; b=cEFY7/pUlUBbqOr867WPNId8sMxEmo5+FzYjSljCbiVnBfLYQS4zdyNNQScaKjrnC5uoQnbHP5i/5RfQIL+ELTIQn/vN8LvGw5+a5IUhfY2jfBCl2Wjcy/OWk+Z8uqKPMUM1VLvHT29gGAAEUUUCxZBj9hi1ajCdtjGb67v/aAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743020811; c=relaxed/simple;
	bh=KPbfgYyTws0p2k9zxRbB5J9C4a2ybIvkn/K4XEyS+Sk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V4mHJWV32DCdN6ZonTRNzNFxG/RXIoVjmasXcjwBRKrOJ6J0Ec3E25qVp0V/gVgGWiXpCsZg2n0Cpa49qrzwgZ2f0QxG3yfUNgmCngtszgTzKEneTuegkPPVXGVUVvp6lw45iB7vvkzVJnxdB08SnnZ3hu/5HxTETFS9cPTeB+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=UPsmt8j8; arc=none smtp.client-ip=79.135.106.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1743020807; x=1743280007;
	bh=HheoLjs/bz6rQL62qYW5HexwyZJOeimWxyvm/Nu745o=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=UPsmt8j8l8kNxtCagXNJPXQcRAfCl0ZWzY/iYbeXnRfB0qWngSiBQMPKDN/J+hClr
	 lGURdZbDZbuUV6v5ZR3HsafVVyYrNYdlqXBLcX6QQRXA8r6mRRSseMAMjpNRupEg+v
	 dbpSuKz908mJVgw4MH33PMejSYKu1exXf7aNqpiFz5AAZ0Qrfq10KPmTR7k6x1dWXt
	 TfMJ9BzaRhTZyOrGeqAd6aV9ulbHH+Qu9xl5uxcTtUzuGN7K/uzFlLLR9wUBKY32xp
	 fVETBq7UIh0RgiBVjY3ZIK1AUtSiW6AYJzQ3+uP8lKxgs14fqaFis7SsNfgehv+9ml
	 n0sz/H/+GfY5Q==
Date: Wed, 26 Mar 2025 20:26:41 +0000
To: Christian Schrefl <chrisi.schrefl@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Lee Jones <lee@kernel.org>, Daniel Almeida <daniel.almeida@collabora.com>, Danilo Krummrich <dakr@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] rust: add UnsafePinned type
Message-ID: <D8QHB0Y7AZ31.PVET84S32Q6X@proton.me>
In-Reply-To: <20250131-b4-rust_miscdevice_registrationdata-v2-1-588f1e6cfabe@gmail.com>
References: <20250131-b4-rust_miscdevice_registrationdata-v2-0-588f1e6cfabe@gmail.com> <20250131-b4-rust_miscdevice_registrationdata-v2-1-588f1e6cfabe@gmail.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: bba8644bdc0a5e3e586244e0ff284c61a6c31151
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri Jan 31, 2025 at 4:08 PM CET, Christian Schrefl wrote:
> @@ -573,3 +576,57 @@ pub enum Either<L, R> {
>  /// [`NotThreadSafe`]: type@NotThreadSafe
>  #[allow(non_upper_case_globals)]
>  pub const NotThreadSafe: NotThreadSafe =3D PhantomData;
> +
> +/// Stores a value that may be used from multiple mutable pointers.
> +///
> +/// `UnsafePinned` gets rid of some of the usual assumptions that Rust h=
as for a value:
> +/// - The value is allowed to be mutated, when a `&UnsafePinned<T>` exis=
ts on the Rust side.
> +/// - No uniqueness for mutable references: it is fine to have multiple =
`&mut UnsafePinned<T>`
> +///   point to the same value.

We have another patch series [1] in transit that changes the wording on
the `Opaque<T>` type. I think we should mirror the same wording here.

[1]: https://lore.kernel.org/rust-for-linux/20250305053438.1532397-2-dirk.b=
ehme@de.bosch.com/

> +///
> +/// To avoid the ability to use [`core::mem::swap`] this still needs to =
be used through a

IIRC typing out the whole path makes it also appear in the docs. I think
we should just use `mem::swap` and omit `core` of course you need to
add this to make it work:
   =20
    /// [`mem::swap`]: core::mem::swap

> +/// [`core::pin::Pin`] reference.

Here, I would link to `Pin`, but say "[pinned](core::pin::Pin) pointer."
instead, since eg `Pin<Box<T>>` also is okay to use.

> +///
> +/// This is useful for cases where a value might be shared with C code
> +/// but not interpreted by it or in cases where it can not always be gua=
ranteed that the
> +/// references are unique.
> +///
> +/// This is similar to [`Opaque<T>`] but is guaranteed to always contain=
 valid data and will
> +/// call the [`Drop`] implementation of `T` when dropped.
> +#[repr(transparent)]
> +pub struct UnsafePinned<T> {
> +    value: UnsafeCell<T>,
> +    _pin: PhantomPinned,
> +}
> +
> +impl<T> UnsafePinned<T> {
> +    /// Creates a new [`UnsafePinned`] value.
> +    pub const fn new(value: T) -> Self {
> +        Self {
> +            value: UnsafeCell::new(value),
> +            _pin: PhantomPinned,
> +        }
> +    }
> +
> +    /// Create an [`UnsafePinned`] pin-initializer from the given pin-in=
itializer.
> +    pub fn try_pin_init<E>(value: impl PinInit<T, E>) -> impl PinInit<Se=
lf, E> {
> +        // SAFETY:
> +        //   - In case of an error in `value` the error is returned, oth=
erwise `slot` is fully
> +        //     initialized, since `self.value` is initialized and `_pin`=
 is a zero sized type.
> +        //   - The `Pin` invariants of `self.value` are upheld, since no=
 moving occurs.
> +        unsafe { init::pin_init_from_closure(move |slot| value.__pinned_=
init(Self::raw_get(slot))) }

Ah this is a bit suboptimal, but I guess there currently isn't a better
way to do this. I'll add it to my list of things to improve with
pin-init.

> +    }
> +
> +    /// Returns a raw pointer to the contained data.
> +    pub const fn get(&self) -> *mut T {
> +        UnsafeCell::get(&self.value).cast::<T>()
> +    }
> +
> +    /// Gets the value behind `this`.
> +    ///
> +    /// This function is useful to get access to the value without creat=
ing intermediate
> +    /// references.
> +    pub const fn raw_get(this: *const Self) -> *mut T {
> +        UnsafeCell::raw_get(this.cast::<UnsafeCell<MaybeUninit<T>>>()).c=
ast::<T>()

Why the cast to `MaybeUninit<T>`? I think this can just be:

    UnsafeCell::raw_get(&raw const this.value)

---
Cheers,
Benno

> +    }
> +}



