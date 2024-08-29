Return-Path: <linux-kernel+bounces-307432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B9D8964D90
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 20:17:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8865B22A9E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 18:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53C4D1B81D9;
	Thu, 29 Aug 2024 18:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="RbPi/x+3"
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3381215B13D;
	Thu, 29 Aug 2024 18:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724955434; cv=none; b=N0V4AsTLkJktWEeCmq36vRtWfEjLeQr8+BxQ4T85eCSw6meeMbMuyXiv+vWomWhFX1bzt+u2l6ZGKJ6v1UMiUpfPZnWuNep5ftvQpES6JUMKCEVSye4DVjifgXIH2zWr2br9ijALCC2bv5yLyW/SGfiuU4wXUcAoH0CMqO7nruU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724955434; c=relaxed/simple;
	bh=GjXbiQHpsXXCXZcRNghGt9xlCnjp3UKcYVNUWKhB4X4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jRuQ4wk9Azx12gTApnhYTGdm3xGXsJ+OsoBfX/I25qaCsDCCnuHG0dEyrXPK04WaqJTSRCyUlpapl+Oe5nRT2fgqsYF4m4V12ayoDUd0BXOG5VM7ap/OcAwCE7WdAtzMIZjwsqDJwleQeUQl5mYSv0NEt0j0th/6UdDLMLwEkPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=RbPi/x+3; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1724955423; x=1725214623;
	bh=4mb+KNe5ME5gClA6st6pA2TT04np6idiAvItMe/bWE4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=RbPi/x+38Sz2omicO/Fl5Dwvep6F1RZ6Z32+y++TWSp98Xt0pFjNj/AlKnm+ArZBV
	 Tg/WIbu/eomgy6OKgri+GmJVDKK3liX+NNZZ0k4O72pfDsaUa/c100unoXxwgspIBS
	 zA3Ewlq9+OKxBeEXh3wtjRgmBqDfCqPaiDl0KZLJnZuk6+i/9svGqpLNqI6sa0h6tn
	 KHQeSF0kaEsYqaaZfnJC1VOfJ7XSvprwuu7xf6gRNd5jr+fReeA4cGyWypzJaPEYjI
	 a2NoYKAz+ecuD/v6CSV/byex0137Ewr++sFibp35iWv7ODWqHbF2pFE/ieHNgh42c7
	 9587jtQpDHt8w==
Date: Thu, 29 Aug 2024 18:16:55 +0000
To: Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] rust: add global lock support
Message-ID: <10453342-d269-4b78-8962-821ef53d3cb5@proton.me>
In-Reply-To: <20240827-static-mutex-v2-1-17fc32b20332@google.com>
References: <20240827-static-mutex-v2-1-17fc32b20332@google.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: f1ac1e732176b557f206a6c04fdecf133a7a863b
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 27.08.24 10:41, Alice Ryhl wrote:
> We don't currently have any support for global locks in Rust, however
> they are very useful and I have needed to work around this limitation
> several times. My workarounds generally involve initializing the mutex
> in the module's init function, and this workaround is reflected here.

I would not exactly call this a "workaround". If your use-case is
covered by putting a `Mutex`, then I would prefer it. Or did you need
additional ugly code to access it?

> Due to the initialization requirement, constructing a global mutex is
> unsafe with the current approach. In the future, it would be really nice
> to support global mutexes that don't need to be initialized, which would
> make them safe. Unfortunately, this is not possible today because
> bindgen refuses to expose __ARCH_SPIN_LOCK_UNLOCKED to Rust as a
> compile-time constant. It just generates an `extern "C"` global
> reference instead.

Ideally, we would have support for static initialization in pinned-init.

> On most architectures, we could initialize the lock to just contain all
> zeros. A possible improvement would be to create a Kconfig constant
> that is set whenever the current architecture uses all zeros for the
> initializer and have `unsafe_const_init` be a no-op on those
> architectures. We could also provide a safe const initializer that is
> only available when that Kconfig option is set.

I am not sure if the two branches (depending on the config) will be a
good idea. We don't save on `unsafe` and only increase code complexity.
The no-op sounds like a better idea to me.

> For architectures that don't use all-zeros for the unlocked case, we
> will most likely have to hard-code the correct representation on the
> Rust side.

You mean in `unsafe_const_init`?

> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
> Changes in v2:
> - Require `self: Pin<&Self>` and recommend `Pin::static_ref`.
> - Other doc improvements including new example.
> - Link to v1: https://lore.kernel.org/r/20240826-static-mutex-v1-1-a14ee7=
1561f3@google.com
> ---
>  rust/kernel/sync/lock.rs | 64 ++++++++++++++++++++++++++++++++++++++++++=
+++++-
>  1 file changed, 63 insertions(+), 1 deletion(-)
>=20
> diff --git a/rust/kernel/sync/lock.rs b/rust/kernel/sync/lock.rs
> index f6c34ca4d819..cfc5e160d78c 100644
> --- a/rust/kernel/sync/lock.rs
> +++ b/rust/kernel/sync/lock.rs
> @@ -7,7 +7,7 @@
>=20
>  use super::LockClassKey;
>  use crate::{init::PinInit, pin_init, str::CStr, types::Opaque, types::Sc=
opeGuard};
> -use core::{cell::UnsafeCell, marker::PhantomData, marker::PhantomPinned}=
;
> +use core::{cell::UnsafeCell, marker::PhantomData, marker::PhantomPinned,=
 pin::Pin};
>  use macros::pin_data;
>=20
>  pub mod mutex;
> @@ -117,6 +117,68 @@ pub fn new(t: T, name: &'static CStr, key: &'static =
LockClassKey) -> impl PinIni
>              }),
>          })
>      }
> +
> +    /// Create a global lock that has not yet been initialized.
> +    ///

Could you add a paragraph that explains that=20

> +    /// Since global locks is not yet fully supported, this method imple=
ments global locks by
> +    /// requiring you to initialize them before you start using it. Usua=
lly this is best done in
> +    /// the module's init function.
> +    ///
> +    /// # Examples
> +    ///

I would preface this example with "Instead of [`Mutex<T>`], you can use
any other lock.".

> +    /// ```
> +    /// use kernel::sync::Mutex;
> +    ///
> +    /// // SAFETY: We initialize the mutex before first use.
> +    /// static MY_MUTEX: Mutex<()> =3D unsafe { Mutex::unsafe_const_new(=
()) };
> +    ///
> +    /// // For the sake of this example, assume that this is the module =
initializer.

Why not actually provide a module initializer?

> +    /// fn module_init() {
> +    ///     // SAFETY:
> +    ///     // * `MY_MUTEX` was created using `unsafe_const_new`.
> +    ///     // * This call is in the module initializer, which doesn't r=
uns more than once.
> +    ///     unsafe {
> +    ///         core::pin::Pin::static_ref(&MY_MUTEX)

I would put this into a let binding, that way the formatting will also
be nicer.

> +    ///             .unsafe_const_init(kernel::c_str!("MY_MUTEX"), kerne=
l::static_lock_class!())
> +    ///     };
> +    /// }
> +    /// ```
> +    ///
> +    /// # Safety
> +    ///
> +    /// You must call [`unsafe_const_init`] before calling any other met=
hod on this lock.
> +    ///
> +    /// [`unsafe_const_init`]: Self::unsafe_const_init
> +    pub const unsafe fn unsafe_const_new(t: T) -> Self {

I am not sure on this name, I don't think we have any functions with
`unsafe` in it (and `std` also doesn't). How about `new_uninitialized`?

Although that might be confusing, since it does actually take a value...

> +        Self {
> +            data: UnsafeCell::new(t),
> +            state: Opaque::uninit(),
> +            _pin: PhantomPinned,
> +        }
> +    }
> +
> +    /// Initialize a global lock.
> +    ///
> +    /// When using this to initialize a `static` lock, you can use [`Pin=
::static_ref`] to construct
> +    /// the pinned reference.
> +    ///
> +    /// See the docs for [`unsafe_const_new`] for examples.
> +    ///
> +    /// # Safety
> +    ///
> +    /// * This lock must have been created with [`unsafe_const_new`].
> +    /// * This method must not be called more than once on a given lock.
> +    ///
> +    /// [`unsafe_const_new`]: Self::unsafe_const_new
> +    pub unsafe fn unsafe_const_init(

I know you are using `const` here to have symmetry with the function
above, but I think it's a bit misleading, you can't call this from const
context. Going with the theme of the suggestion from above, what about
`manual_init`?

---
Cheers,
Benno

> +        self: Pin<&Self>,
> +        name: &'static CStr,
> +        key: &'static LockClassKey,
> +    ) {
> +        // SAFETY: The pointer to `state` is valid for the duration of t=
his call, and both `name`
> +        // and `key` are valid indefinitely.
> +        unsafe { B::init(self.state.get(), name.as_char_ptr(), key.as_pt=
r()) }
> +    }
>  }
>=20
>  impl<T: ?Sized, B: Backend> Lock<T, B> {
>=20
> ---
> base-commit: b204bbc53f958fc3119d63bf2cda5a526e7267a4
> change-id: 20240826-static-mutex-a4b228e0e6aa
>=20
> Best regards,
> --
> Alice Ryhl <aliceryhl@google.com>
>=20


