Return-Path: <linux-kernel+bounces-308079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 347BA9656F8
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 07:35:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9BBEFB230AA
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 05:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71CEA14EC48;
	Fri, 30 Aug 2024 05:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1g3NjHf7"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACFC313BAFA
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 05:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724996113; cv=none; b=RGpDbHSpCei5umPoY0AxwMzz3yQe+1Sts31aBTBuyj2Q0VwQg3ZLUuhzOkd+VSAeHtOW+8/euHAO26PWIy9495/V6IjGCAiSVkLBegRyqTcVYPHX5Ypl+F151EhuFScDEKU88Wp71xFoXcoURyleisA+GBhtJcESBgsUXpvuJtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724996113; c=relaxed/simple;
	bh=EHSFeRUDGOMddUDsT2zweoP+iP9Pt8pKxAdAe3CAY7w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=evhvkUcG63YIJQh8KKSDjyKHBgYz4zgrzHe3eLxoUuGTUkDPB2dONX1xG8LSPZwW7sVccaZBdk9UXOY1SroZTjXmradVpcxUoJGzTWI6LEQsM8eHmg7mlTSHRRj2KSROlVZ5YNzPlCrytQI16lnQZPDy6bEYuTDViI5rr9wplUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1g3NjHf7; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-427fc97a88cso11960545e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 22:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724996110; x=1725600910; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1vrYriDVjGVQmzllPvxrqLODdFohEr/iUmNCkkDjUp0=;
        b=1g3NjHf7dazNj8GxbHB/OiaEgpGQJ8piTvC4wV+SUo1DtosYPjywtlvXSLF1NYForq
         TaHAmCEUyXknC7rDKQnviiYsMfH7mxZM7ehF6eczKy9IHCCTfWbuG7NkJceIT0AtJhLr
         e3+/xcoA7i2Ed2Fnc/F+uSsazi6atfHgDrhmpA7uaf8d33Ilmjfe4LkoTUYKmV147dWz
         /WgYKRVXOy0OkhK5ZgRpR1jE38xvyBHDqb7N6gmuzXXTnNQc/J5/GiUwkIP0PJYG+BeV
         0Hz8TMbLS45Yyw8R5+tyNTad7+s1SlgK/dCNFguSBwdX3WlYHrHAazjkwOvCx0PMrUhS
         yi/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724996110; x=1725600910;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1vrYriDVjGVQmzllPvxrqLODdFohEr/iUmNCkkDjUp0=;
        b=BfTrn2iUWL4AFzmBStX9mPlHcJFgy5G/a4KjSKJk5izSTUNyHZDp4cylNcYNx644+n
         ehO85VUoRqCk5jjPcqC7sIfLR2wJJaxskTLM3owe4/q9qbkacUX51ud21l+2wMAM14ca
         jxZ8fM7MXiCcCtPSfg3x6MOe5NR4AwFL/7jNMZLFXUrK+H3DBWX1HAvxU6ENBAn05ztl
         VM2DMiF5VEisB//AtaTqi/7N2j81medETQqp4pDEidyTLYfBjhDqy49XL+saYYdc/1Ma
         ylo9q/hZToQ5ZhrP2ktIJwB1tn9xiE0UDysaI3f5BSLF3N3q6L3lj0LvmD/zw1AGfMrb
         Mx4Q==
X-Forwarded-Encrypted: i=1; AJvYcCWjqsflkKy7xoeCsk78KHkx94hl6eOumUdQcUiUmnYcrkt2PDbD+uymt1VDie9JerE2UjDzOCtoWZi7WJE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzje57Z6CFLblQuvwCdBYcu1b0aGeGPqBIDKJj11epU1Y9/60LQ
	bOacccnBmO50MKmgvun6f2ep9khyPTGwphKOa+oI+T2aBkgVW6r8g63OdKd9GXr09vCt8BtQbq3
	Z7GcLnqXmpfZ96BvhAxeRa1SXaNIjYyiWB9WQ
X-Google-Smtp-Source: AGHT+IGz3TbfRy6iGbQcL+Uol9xaehk3qIrmI0IICBkJLmsOo8+Xo/UAlhh7u3P8cp49jwhPJ0+53ZDd7o0nErrurlw=
X-Received: by 2002:a05:600c:3145:b0:426:6667:bbbe with SMTP id
 5b1f17b1804b1-42bb0257a2fmr42120135e9.9.1724996109288; Thu, 29 Aug 2024
 22:35:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240827-static-mutex-v2-1-17fc32b20332@google.com> <10453342-d269-4b78-8962-821ef53d3cb5@proton.me>
In-Reply-To: <10453342-d269-4b78-8962-821ef53d3cb5@proton.me>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 30 Aug 2024 07:34:00 +0200
Message-ID: <CAH5fLgh-DYvXobXQVaQ9txYS4Rx8QhjyVvfTphk6vvnUOGzPnw@mail.gmail.com>
Subject: Re: [PATCH v2] rust: add global lock support
To: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@samsung.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 29, 2024 at 8:17=E2=80=AFPM Benno Lossin <benno.lossin@proton.m=
e> wrote:
>
> On 27.08.24 10:41, Alice Ryhl wrote:
> > We don't currently have any support for global locks in Rust, however
> > they are very useful and I have needed to work around this limitation
> > several times. My workarounds generally involve initializing the mutex
> > in the module's init function, and this workaround is reflected here.
>
> I would not exactly call this a "workaround". If your use-case is
> covered by putting a `Mutex`, then I would prefer it. Or did you need
> additional ugly code to access it?

Not sure what you mean by "putting a Mutex" but the workaround is
really gross and involves defining a whole struct to make types Sync
and so on. Unlike binder, this patch has access to private fields of
Lock, so it can do it in a more nice way. You can find it in the
Binder RFC if you search for "context_global".
https://lore.kernel.org/rust-for-linux/20231101-rust-binder-v1-2-08ba9197f6=
37@google.com/#Z31drivers:android:context.rs

> > Due to the initialization requirement, constructing a global mutex is
> > unsafe with the current approach. In the future, it would be really nic=
e
> > to support global mutexes that don't need to be initialized, which woul=
d
> > make them safe. Unfortunately, this is not possible today because
> > bindgen refuses to expose __ARCH_SPIN_LOCK_UNLOCKED to Rust as a
> > compile-time constant. It just generates an `extern "C"` global
> > reference instead.
>
> Ideally, we would have support for static initialization in pinned-init.

I don't think traits work with const today, so pin-init would need an
entirely different mechanism? If you're talking about using
CONSTRUCTORS, then I think it's an undesirable solution. C code can
define static mutexes without load-time initialization hooks. We
should be able to do the same.

> > On most architectures, we could initialize the lock to just contain all
> > zeros. A possible improvement would be to create a Kconfig constant
> > that is set whenever the current architecture uses all zeros for the
> > initializer and have `unsafe_const_init` be a no-op on those
> > architectures. We could also provide a safe const initializer that is
> > only available when that Kconfig option is set.
>
> I am not sure if the two branches (depending on the config) will be a
> good idea. We don't save on `unsafe` and only increase code complexity.
> The no-op sounds like a better idea to me.

You mean put the logic here instead in the downstream user? I agree.

> > For architectures that don't use all-zeros for the unlocked case, we
> > will most likely have to hard-code the correct representation on the
> > Rust side.
>
> You mean in `unsafe_const_init`?

No, I mean we would have `unsafe_const_new` directly set `state` to
the right value and let `unsafe_const_init` be a no-op.

> > Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> > ---
> > Changes in v2:
> > - Require `self: Pin<&Self>` and recommend `Pin::static_ref`.
> > - Other doc improvements including new example.
> > - Link to v1: https://lore.kernel.org/r/20240826-static-mutex-v1-1-a14e=
e71561f3@google.com
> > ---
> >  rust/kernel/sync/lock.rs | 64 ++++++++++++++++++++++++++++++++++++++++=
+++++++-
> >  1 file changed, 63 insertions(+), 1 deletion(-)
> >
> > diff --git a/rust/kernel/sync/lock.rs b/rust/kernel/sync/lock.rs
> > index f6c34ca4d819..cfc5e160d78c 100644
> > --- a/rust/kernel/sync/lock.rs
> > +++ b/rust/kernel/sync/lock.rs
> > @@ -7,7 +7,7 @@
> >
> >  use super::LockClassKey;
> >  use crate::{init::PinInit, pin_init, str::CStr, types::Opaque, types::=
ScopeGuard};
> > -use core::{cell::UnsafeCell, marker::PhantomData, marker::PhantomPinne=
d};
> > +use core::{cell::UnsafeCell, marker::PhantomData, marker::PhantomPinne=
d, pin::Pin};
> >  use macros::pin_data;
> >
> >  pub mod mutex;
> > @@ -117,6 +117,68 @@ pub fn new(t: T, name: &'static CStr, key: &'stati=
c LockClassKey) -> impl PinIni
> >              }),
> >          })
> >      }
> > +
> > +    /// Create a global lock that has not yet been initialized.
> > +    ///
>
> Could you add a paragraph that explains that

Explains that what?

> > +    /// Since global locks is not yet fully supported, this method imp=
lements global locks by
> > +    /// requiring you to initialize them before you start using it. Us=
ually this is best done in
> > +    /// the module's init function.
> > +    ///
> > +    /// # Examples
> > +    ///
>
> I would preface this example with "Instead of [`Mutex<T>`], you can use
> any other lock.".

I don't love that wording. How about something along these lines?
"This example uses a Mutex, but this works with any other lock
including spin locks."

> > +    /// ```
> > +    /// use kernel::sync::Mutex;
> > +    ///
> > +    /// // SAFETY: We initialize the mutex before first use.
> > +    /// static MY_MUTEX: Mutex<()> =3D unsafe { Mutex::unsafe_const_ne=
w(()) };
> > +    ///
> > +    /// // For the sake of this example, assume that this is the modul=
e initializer.
>
> Why not actually provide a module initializer?

Can I put a `module!` macro inside a kunit test? I assumed that I couldn't.

> > +    /// fn module_init() {
> > +    ///     // SAFETY:
> > +    ///     // * `MY_MUTEX` was created using `unsafe_const_new`.
> > +    ///     // * This call is in the module initializer, which doesn't=
 runs more than once.
> > +    ///     unsafe {
> > +    ///         core::pin::Pin::static_ref(&MY_MUTEX)
>
> I would put this into a let binding, that way the formatting will also
> be nicer.

Ok.

> > +    ///             .unsafe_const_init(kernel::c_str!("MY_MUTEX"), ker=
nel::static_lock_class!())
> > +    ///     };
> > +    /// }
> > +    /// ```
> > +    ///
> > +    /// # Safety
> > +    ///
> > +    /// You must call [`unsafe_const_init`] before calling any other m=
ethod on this lock.
> > +    ///
> > +    /// [`unsafe_const_init`]: Self::unsafe_const_init
> > +    pub const unsafe fn unsafe_const_new(t: T) -> Self {
>
> I am not sure on this name, I don't think we have any functions with
> `unsafe` in it (and `std` also doesn't). How about `new_uninitialized`?
>
> Although that might be confusing, since it does actually take a value...

Hmm. Any other ideas? const_new_need_manual_init?

> > +        Self {
> > +            data: UnsafeCell::new(t),
> > +            state: Opaque::uninit(),
> > +            _pin: PhantomPinned,
> > +        }
> > +    }
> > +
> > +    /// Initialize a global lock.
> > +    ///
> > +    /// When using this to initialize a `static` lock, you can use [`P=
in::static_ref`] to construct
> > +    /// the pinned reference.
> > +    ///
> > +    /// See the docs for [`unsafe_const_new`] for examples.
> > +    ///
> > +    /// # Safety
> > +    ///
> > +    /// * This lock must have been created with [`unsafe_const_new`].
> > +    /// * This method must not be called more than once on a given loc=
k.
> > +    ///
> > +    /// [`unsafe_const_new`]: Self::unsafe_const_new
> > +    pub unsafe fn unsafe_const_init(
>
> I know you are using `const` here to have symmetry with the function
> above, but I think it's a bit misleading, you can't call this from const
> context. Going with the theme of the suggestion from above, what about
> `manual_init`?

That could work.

Alice

