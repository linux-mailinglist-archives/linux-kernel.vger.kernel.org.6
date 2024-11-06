Return-Path: <linux-kernel+bounces-398103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 140B99BE569
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 12:18:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C82E3285860
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 11:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33BF71DE3AC;
	Wed,  6 Nov 2024 11:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k5uc5pXH"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F9F18C00E
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 11:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730891885; cv=none; b=kQK2KqWcwbbxc47PYZ0KWhai/z1JgIhOMX9WRoEKxrDJze9awxx/OiVNbLbdKlHYZmr9lWOsXWpGwoW6p1ki+Nb08p4jZEViowp/Xo31Z5hHWsPG+ojj+jVSoChgab2EkwQV7H7zaqpFVa0pER2Y1pGY0xEN+fTYzi7ANOF6K3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730891885; c=relaxed/simple;
	bh=VkXepOu1IROrz0E0RHhVsvpjcH2flzLDXbxEmNisBKw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xm03GPloiqnQVtqix/u026bCQhcmMN0qzm3sCGMOoKt/09raVZJ5OPJRcKGvtI4YAtagprNORknddzLq7fmFish19V/Bd7cHXnGbf6PQoLgupMptKzdhCEPxbkgHOlBUV+2q2av/oiDQnD1l2qtWekIQd5vjcBpFLEBy2dRUP3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=k5uc5pXH; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4314c4cb752so58416405e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2024 03:18:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730891882; x=1731496682; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qspgAAcJdGrh11t/PtpnDNz6ZQTSd8KOFfIKFNMREJc=;
        b=k5uc5pXHnaz+NLpiVZww29JsMhjB7yqvWM+CWoCrorwYx2vPNJ8VOhQhmA7uE6+u4T
         ngMWU0uBxuEjo0odauGup54iISmFrhwpwghytWTPhWfO9s2AtXaMoJYggIvpBY9ou4Qd
         mCnq4IAI7cL8XxbTBHflchCsZoxlIbHclmxENZ+ZuYR9HM7xJ5PrVDqViy4vvd5J2wmq
         zIoFkCA5o4GcNnWo8aNOSRZ9iaH3kbSHggm8QpjgQ+7T2yM2Skmyl4mYX6H4EJ740Oak
         wxYVJ8gKxkUCChUEDa4Ne0uBRnT4YQNBwBhJOhcTjRqN7dvIuLq/zgix+/b/V0MLbSWE
         ItXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730891882; x=1731496682;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qspgAAcJdGrh11t/PtpnDNz6ZQTSd8KOFfIKFNMREJc=;
        b=de+yb+ShwNy3FuVTzeYu2Ia7nTiMKKwhc62mS2oSAS2yccUymG//qfWJm7Ay0VCp0m
         qqiIX09Am+tdvLmkW5BUyRoMHMvOCInV+KwnAcubbj+oNxizMfeShCVzHKYdu32nKZmD
         R2NB/0li/NhDCJz7hfa7eGV2KlGZdPrId20ULofROdUBhcslOnRRQD/mQmV599UQafeY
         hkf2CeC41yZADKQidvC4Dj03PpbqtPIT8/kqbE6JwoKkNTqAsakjb7mg8p5a2n2dyElo
         93UiXHUwZwI3RVMbWRIXv3sn2hNUdWkZiI0fVTYoVHc5UXFBtGatYAKg4EN58ybjVMgK
         0QLA==
X-Forwarded-Encrypted: i=1; AJvYcCW3BoicFkWHXRNuKGngSU1YsoEQkTnkkGhmZleE/76rPYJDzM4HSCJgk4gUP9FxbAr0su1y6ysA0wpW+hg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyY97IsJtkobKnKSY+w5LAB9PsuWvTZ1d/aT9CUtjmhthR8GKH
	TPFDFb1dprzXjiJNqFPZBlmSSY9/xbAW8QvlhD0v2JHmbdgWC1xeO3qCF203AkwsDZ0KIXE2Ji8
	cZCtstJ3U0V0bRs/jG2vW2LHUHqN+Oh4lG8JA
X-Google-Smtp-Source: AGHT+IFq9a/ady6t1PDaPfXayblxvOFGIFWnmuuTWWDK839BwErDGLobzL/dR8fW1qCbx6nMQ/8csVf6edGxmaylw4Q=
X-Received: by 2002:a05:6000:2188:b0:37d:5231:f539 with SMTP id
 ffacd0b85a97d-381bea270b7mr15397680f8f.54.1730891881446; Wed, 06 Nov 2024
 03:18:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241024-topic-panthor-rs-request_irq-v1-1-7cbc51c182ca@collabora.com>
 <CAH5fLgjRJtdpcOZySpRN-keLSMJjJdfXZGOhy_cEbiM3uNU7Tw@mail.gmail.com> <45D09BD8-208C-4195-BACB-95B0922C5324@collabora.com>
In-Reply-To: <45D09BD8-208C-4195-BACB-95B0922C5324@collabora.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 6 Nov 2024 12:17:49 +0100
Message-ID: <CAH5fLgiWO6u3_frPDrXP2vD0_5NRDVVV=z6VEz3sTjQ_7h1arA@mail.gmail.com>
Subject: Re: [PATCH] rust: irq: add support for request_irq()
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 4, 2024 at 9:10=E2=80=AFPM Daniel Almeida
<daniel.almeida@collabora.com> wrote:
>
> Hi Alice, thanks for the review!
>
>
> > On 28 Oct 2024, at 12:29, Alice Ryhl <aliceryhl@google.com> wrote:
> >
> > On Thu, Oct 24, 2024 at 4:20=E2=80=AFPM Daniel Almeida
> > <daniel.almeida@collabora.com> wrote:
> >>
> >> Both regular and threaded versions are supported.
> >>
> >> Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
> >
>
> Yeah, as I was saying, my latest patches were sent with some provisional
> commit messages. Sometimes these things slip through.
>
> In fact, as this was my first time switching to b4, it took me a while to
> realize I had sent the patches to myself only, so you can see I started o=
ff
> with the =E2=80=9Cwrong foot=E2=80=9D here.
>
> > I left some comments below:
> >
> >> diff --git a/rust/kernel/irq/request.rs b/rust/kernel/irq/request.rs
> >> new file mode 100644
> >> index 0000000000000000000000000000000000000000..4b5c5b80c3f43d48213242=
3c2c52cfa5696b7661
> >> --- /dev/null
> >> +++ b/rust/kernel/irq/request.rs
> >> @@ -0,0 +1,450 @@
> >> +// SPDX-License-Identifier: GPL-2.0
> >> +// SPDX-FileCopyrightText: Copyright 2019 Collabora ltd.
> >
> > should this be 2024?
> >
> >> +/// The value that can be returned from an IrqHandler;
> >> +pub enum IrqReturn {
> >> +    /// The interrupt was not from this device or was not handled.
> >> +    None =3D bindings::irqreturn_IRQ_NONE as _,
> >> +
> >> +    /// The interrupt was handled by this device.
> >> +    Handled =3D bindings::irqreturn_IRQ_HANDLED as _,
> >> +}
> >> +
> >> +/// Callbacks for an IRQ handler.
> >> +pub trait Handler: Sync {
> >> +    /// The actual handler function. As usual, sleeps are not allowed=
 in IRQ
> >> +    /// context.
> >> +    fn handle_irq(&self) -> IrqReturn;
> >> +}
> >> +
> >> +/// A registration of an IRQ handler for a given IRQ line.
> >> +///
> >> +/// # Invariants
> >> +///
> >> +/// * We own an irq handler using `&self` as its private data.
> >
> > The invariants section is usually last.
> >
> >> +/// # Examples
> >> +///
> >> +/// The following is an example of using `Registration`:
> >> +///
> >> +/// ```
> >> +/// use kernel::prelude::*;
> >> +/// use kernel::irq;
> >> +/// use kernel::irq::Registration;
> >> +/// use kernel::sync::Arc;
> >> +/// use kernel::sync::lock::SpinLock;
> >> +///
> >> +/// // Declare a struct that will be passed in when the interrupt fir=
es. The u32
> >> +/// // merely serves as an example of some internal data.
> >> +/// struct Data(u32);
> >> +///
> >> +/// // [`handle_irq`] returns &self. This example illustrates interio=
r
> >> +/// // mutability can be used when share the data between process con=
text and IRQ
> >> +/// // context.
> >> +/// //
> >> +/// // Ideally, this example would be using a version of SpinLock tha=
t is aware
> >> +/// // of `spin_lock_irqsave` and `spin_lock_irqrestore`, but that is=
 not yet
> >> +/// // implemented.
> >> +///
> >> +/// type Handler =3D SpinLock<Data>;
> >
> > I doubt this will compile outside of the kernel crate. It fails the
> > orphan rule because your driver neither owns the SpinLock type or the
> > Handler trait. You should move `SpinLock` inside `Data` instead.
> >
> >> +/// impl kernel::irq::Handler for Handler {
> >> +///     // This is executing in IRQ context in some CPU. Other CPUs c=
an still
> >> +///     // try to access to data.
> >> +///     fn handle_irq(&self) -> irq::IrqReturn {
> >> +///         // We now have exclusive access to the data by locking th=
e SpinLock.
> >> +///         let mut handler =3D self.lock();
> >> +///         handler.0 +=3D 1;
> >> +///
> >> +///         IrqReturn::Handled
> >> +///     }
> >> +/// }
> >> +///
> >> +/// // This is running in process context.
> >> +/// fn register_irq(irq: u32, handler: Handler) -> Result<irq::Regist=
ration<Handler>> {
> >
> > Please try compiling the example. The return type should be
> > Result<Arc<irq::Registration<Handler>>>.
>
> Sorry, I was under the impression that `rustdoc` would compile the exampl=
es too.
>
> >
> >> +///     let registration =3D Registration::register(irq, irq::flags::=
SHARED, "my-device", handler)?;
> >> +///
> >> +///     // You can have as many references to the registration as you=
 want, so
> >> +///     // multiple parts of the driver can access it.
> >> +///     let registration =3D Arc::pin_init(registration)?;
> >> +///
> >> +///     // The handler may be called immediately after the function a=
bove
> >> +///     // returns, possibly in a different CPU.
> >> +///
> >> +///     // The data can be accessed from the process context too.
> >> +///     registration.handler().lock().0 =3D 42;
> >> +///
> >> +///     Ok(registration)
> >> +/// }
> >> +///
> >> +/// # Ok::<(), Error>(())
> >> +///```
> >> +#[pin_data(PinnedDrop)]
> >> +pub struct Registration<T: Handler> {
> >> +    irq: u32,
> >> +    #[pin]
> >> +    handler: Opaque<T>,
> >> +}
> >> +
> >> +impl<T: Handler> Registration<T> {
> >> +    /// Registers the IRQ handler with the system for the given IRQ n=
umber. The
> >> +    /// handler must be able to be called as soon as this function re=
turns.
> >> +    pub fn register(
> >> +        irq: u32,
> >> +        flags: Flags,
> >> +        name: &'static CStr,
> >
> > Does the name need to be 'static?
>
> Actually, the lifetime relationship that we want to express here is that =
`name` should
> live for at least as long as &self.
>
> Most of the time in C, this is solved by having `name` point to a statica=
lly allocated string,
> usually a string literal, so this version of the patch implemented that.
>
> What about:
>
> ```
> Registration<=E2=80=98a> {
>         name: PhantomData<&=E2=80=98a CStr>
> }
> ```
>
> Where calling register() with some c_str!(=E2=80=9Cfoo=E2=80=9D) would cr=
eate a Registration<=E2=80=99static>
> anyways?

Ah ... what you propose would be correct but it doesn't sound useful.
Let's just keep 'static.

> >> +        handler: T,
> >> +    ) -> impl PinInit<Self, Error> {
> >> +        try_pin_init!(Self {
> >> +            irq,
> >> +            handler: Opaque::new(handler)
> >> +        })
> >> +        .pin_chain(move |slot| {
> >> +            // SAFETY:
> >> +            // - `handler` points to a valid function defined below.
> >> +            // - only valid flags can be constructed using the `flags=
` module.
> >> +            // - `devname` is a nul-terminated string with a 'static =
lifetime.
> >> +            // - `ptr` is a cookie used to identify the handler. The =
same cookie is
> >> +            // passed back when the system calls the handler.
> >> +            to_result(unsafe {
> >> +                bindings::request_irq(
> >> +                    irq,
> >> +                    Some(handle_irq_callback::<T>),
> >> +                    flags.0,
> >> +                    name.as_char_ptr(),
> >> +                    &*slot as *const _ as *mut core::ffi::c_void,
> >
> > Can simplify to `slot as *mut c_void` or `slot.cast()`.
> >
> >> +                )
> >> +            })?;
> >> +
> >> +            Ok(())
> >> +        })
> >> +    }
> >> +
> >> +    /// Returns a reference to the handler that was registered with t=
he system.
> >> +    pub fn handler(&self) -> &T {
> >> +        // SAFETY: `handler` is initialized in `register`.
> >> +        unsafe { &*self.handler.get() }
> >
> > This relies on T being Sync as it could also get accessed by the irq
> > handler in parallel. You probably want the SAFETY comment to mention
> > that.
> >
> >> +    }
> >> +}
> >> +
> >> +#[pinned_drop]
> >> +impl<T: Handler> PinnedDrop for Registration<T> {
> >> +    fn drop(self: Pin<&mut Self>) {
> >> +        // SAFETY:
> >> +        // - `self.irq` is the same as the one passed to `reques_irq`=
.
> >> +        // -  `&self` was passed to `request_irq` as the cookie. It i=
s
> >> +        // guaranteed to be unique by the type system, since each cal=
l to
> >> +        // `register` will return a different instance of `Registrati=
on`.
> >> +        //
> >> +        // Notice that this will block until all handlers finish exec=
uting, so,
> >> +        // at no point will &self be invalid while the handler is run=
ning.
> >> +        unsafe { bindings::free_irq(self.irq, &*self as *const _ as *=
mut core::ffi::c_void) };
> >
> > I can't tell if this creates a pointer to the Registration or a
> > pointer to a pointer to the Registration. Please spell out the type:
> > ```
> > &*self as *const Self as *mut core::ffi::c_void
> > ```
>
> My thought process here is that Pin<Ptr<T>> dereferences to Ptr::Target, =
i.e. Self,
> which is then borrowed, i.e. &Self.
>
> I do not see how this can create a pointer to a pointer, but you=E2=80=99=
re right, it=E2=80=99s
> always good to be more explicit by spelling out the full type. I will fix=
 that.

Ah, yes, I suppose the Pin wrapper does make it more clear. Still, I
think spelling out the type would improve the clarity in this case.

> >> +    }
> >> +}
> >> +
> >> +/// The value that can be returned from `ThreadedHandler::handle_irq`=
.
> >> +pub enum ThreadedIrqReturn {
> >> +    /// The interrupt was not from this device or was not handled.
> >> +    None =3D bindings::irqreturn_IRQ_NONE as _,
> >> +
> >> +    /// The interrupt was handled by this device.
> >> +    Handled =3D bindings::irqreturn_IRQ_HANDLED as _,
> >> +
> >> +    /// The handler wants the handler thread to wake up.
> >> +    WakeThread =3D bindings::irqreturn_IRQ_WAKE_THREAD as _,
> >> +}
> >> +
> >> +/// The value that can be returned from `ThreadedFnHandler::thread_fn=
`.
> >> +pub enum ThreadedFnReturn {
> >> +    /// The thread function did not make any progress.
> >> +    None =3D bindings::irqreturn_IRQ_NONE as _,
> >> +
> >> +    /// The thread function ran successfully.
> >> +    Handled =3D bindings::irqreturn_IRQ_HANDLED as _,
> >> +}
> >
> > This is the same as IrqReturn?
>
> Thanks for noticing this. It indeed ended up as the same type after all.
>
> >
> >> +/// Callbacks for a threaded IRQ handler.
> >> +pub trait ThreadedHandler: Sync {
> >> +    /// The actual handler function. As usual, sleeps are not allowed=
 in IRQ
> >> +    /// context.
> >> +    fn handle_irq(&self) -> ThreadedIrqReturn;
> >> +
> >> +    /// The threaded handler function. This function is called from t=
he irq
> >> +    /// handler thread, which is automatically created by the system.
> >> +    fn thread_fn(&self) -> ThreadedFnReturn;
> >> +}
> >
> > Most of my comments above also reply to ThreadedHandler.
> >
> > Alice
>
> =E2=80=94 Daniel
>

