Return-Path: <linux-kernel+bounces-311228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0707B968657
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 13:38:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 273BE1C217FF
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 11:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59FCF195;
	Mon,  2 Sep 2024 11:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2tkXezNN"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996EB18454E
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 11:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725277084; cv=none; b=sLi1p3qH0vQyqiprZ0A1o0Tl2etYtUXG56AAbQ21ofB3TFljANX6s5QtrcA83iuFDSncU7jNk8nGJVn+yhdMf1vuzfr78kS8LXlBQf+e4HvhLdS2d4uJjcMO3clrO3T19bx9RM4YZE7BIfGBeHZ15Ipa/vrpm+THsR8oPCaWn2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725277084; c=relaxed/simple;
	bh=wfYLkE7LiT2/yG0ACwTF9nSTVgljXntTYZQ8PpUr5V4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I5ZwaauHNI7q5zcctwDx6fG2VDg47Dj/yrWXEbPpxpXepAbHC+diDZTqO8pJe3ehnEonF9eSgZOQdb17G4Zc12ElI3pshW04vYZqMJNxY9MDJlRMOGMvYgw+iEks251TUKNz5qlQ6HjBL0SX5Tkqy9ymAHLuZQNYH0VZkEMVF+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2tkXezNN; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42bac9469e8so34501725e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 04:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725277081; x=1725881881; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qZa//9wOk7FNHzhYJJB1CStsOJGcgeuFsi3tmo4wxzg=;
        b=2tkXezNNRDWCsnJOJBt268cZXMNvMqxAr6d3aD4j3IWCNzQ9bXANFaChw1QZ53eF5R
         ZaP29KkF8ujJkczT7x+9A7xpY/m7aCDJx/prTBJhBcrZFRH9cQ1DOcICKu4dQ+IR5ky7
         aR+T01nbSN7TU0aRr3K/vEWEttnYdUleTigvWrdto8X7c2QxJWF0Y95Izb4V0tzigbeY
         Uwutr5dojdhFzzUu4+9KJV5lWL5L6trvPj2Hie7bxOWgbLvy2Q4HEGfta3NUdh8a2107
         W5nFSUY7y/XZDh+ZZTxmvcqQ9M+7q0gibF2Os39LSCmR2U65A5nXCoIp8yuTAQayOvhN
         9t3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725277081; x=1725881881;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qZa//9wOk7FNHzhYJJB1CStsOJGcgeuFsi3tmo4wxzg=;
        b=Sss7tjc26o3GIrnh5LyhBOhBtonAWxliGL3YTVhy2nAWtNnEHiNl1FwI/ZiMZIzLJ8
         axZcDAAPzIk671FV2oN4LeB8gAXYWhUZqCKQTaxOxm4TbQY4sCm8r97kVigkaImuG1vO
         gzmmOgU792h9gJrWqRYaUFP9mBRTcsM32tfuYf5nGonu67ak9qLNqYCZ0ggzW1arkbIJ
         aHD6DcBrj40X1goiveVhuNEuQYB7Rpiz8EXqjzMJ85W03tts0SwUKCQSFsyIf6p5aaqs
         rG6JNYz98oswGg8n5QYi+vQnLBor6weCWx537O7QlM/IFUyUcmJ4cCUHalsjPnINjiyK
         mwLA==
X-Forwarded-Encrypted: i=1; AJvYcCWpCLrbvKXUt5LhmE9Melc2egNYHs6U1pKadkni9EkPgE3pNV4p25tlMegtFUQKsXs8kfmcz4BY7Y+9Ozk=@vger.kernel.org
X-Gm-Message-State: AOJu0YygI0yOFHRZAh6zIRSP1FWWelXVRK/PlSFSnDak9za7vg4fT39l
	my6aPL5bn2op+qJJujIHDeGEaVXdcf3ksvz348HL7lq2/g18Usn0Nr0mokq+zIC6hJ0vMCIGupv
	tnU90dMX93EhtISwVyTa46OfXMVugnHTVkf/Z
X-Google-Smtp-Source: AGHT+IH+c7G02pXmLKTzR0kKMvFbDOPx96p4Ph3YDBnUHvKXyRrD2ca/MkZ04xl3PU+KbAesdHq3bK9M3Phb0OivgCU=
X-Received: by 2002:a05:600c:4f53:b0:426:55a3:71af with SMTP id
 5b1f17b1804b1-42c82f6cf51mr21024445e9.33.1725277080540; Mon, 02 Sep 2024
 04:38:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240827-static-mutex-v2-1-17fc32b20332@google.com>
 <10453342-d269-4b78-8962-821ef53d3cb5@proton.me> <CAH5fLgh-DYvXobXQVaQ9txYS4Rx8QhjyVvfTphk6vvnUOGzPnw@mail.gmail.com>
 <3b557f61-cead-4568-b2b4-4a56c4cbff52@proton.me>
In-Reply-To: <3b557f61-cead-4568-b2b4-4a56c4cbff52@proton.me>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 2 Sep 2024 13:37:48 +0200
Message-ID: <CAH5fLggE-fWDuZXH_F3ixDSo7sQEFwnUV3cd+9_rpFH+XmnA2Q@mail.gmail.com>
Subject: Re: [PATCH v2] rust: add global lock support
To: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@samsung.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 30, 2024 at 3:22=E2=80=AFPM Benno Lossin <benno.lossin@proton.m=
e> wrote:
>
> On 30.08.24 07:34, Alice Ryhl wrote:
> > On Thu, Aug 29, 2024 at 8:17=E2=80=AFPM Benno Lossin <benno.lossin@prot=
on.me> wrote:
> >>
> >> On 27.08.24 10:41, Alice Ryhl wrote:
> >>> We don't currently have any support for global locks in Rust, however
> >>> they are very useful and I have needed to work around this limitation
> >>> several times. My workarounds generally involve initializing the mute=
x
> >>> in the module's init function, and this workaround is reflected here.
> >>
> >> I would not exactly call this a "workaround". If your use-case is
> >> covered by putting a `Mutex`, then I would prefer it. Or did you need
> >> additional ugly code to access it?
> >
> > Not sure what you mean by "putting a Mutex" but the workaround is
>
> Oh sorry, seems like I forgot to write the rest of that... Let me try
> again: If your use-case is covered by putting a `Mutex` inside of the
> type that implements `Module`, then I think you should do that instead
> of using a global. (you need the inplace module patch for that)

I don't think it's possible to access the `Module` struct after `init`
returns? Even with in-place init.

> > really gross and involves defining a whole struct to make types Sync
> > and so on. Unlike binder, this patch has access to private fields of
> > Lock, so it can do it in a more nice way. You can find it in the
> > Binder RFC if you search for "context_global".
> > https://lore.kernel.org/rust-for-linux/20231101-rust-binder-v1-2-08ba91=
97f637@google.com/#Z31drivers:android:context.rs
>
> Oh I remember this... Yeah I agree that is ugly, but it is not the
> workaround that I imagined when you wrote "initializing the mutex in the
> module's init function". There I was thinking of what I wrote above.
>
> This might just be me misunderstanding that, but if you want to improve
> it, then you could mention that the mutex is still a static.
>
> >>> Due to the initialization requirement, constructing a global mutex is
> >>> unsafe with the current approach. In the future, it would be really n=
ice
> >>> to support global mutexes that don't need to be initialized, which wo=
uld
> >>> make them safe. Unfortunately, this is not possible today because
> >>> bindgen refuses to expose __ARCH_SPIN_LOCK_UNLOCKED to Rust as a
> >>> compile-time constant. It just generates an `extern "C"` global
> >>> reference instead.
> >>
> >> Ideally, we would have support for static initialization in pinned-ini=
t.
> >
> > I don't think traits work with const today, so pin-init would need an
> > entirely different mechanism? If you're talking about using
>
> Oh yeah I forgot that that got scratched some time ago.
>
> > CONSTRUCTORS, then I think it's an undesirable solution. C code can
>
> No, I was thinking that the initializer is run at const eval and then
> the result is put into the binary.
>
> > define static mutexes without load-time initialization hooks. We
> > should be able to do the same.
>
> Agreed.
>
> >>> On most architectures, we could initialize the lock to just contain a=
ll
> >>> zeros. A possible improvement would be to create a Kconfig constant
> >>> that is set whenever the current architecture uses all zeros for the
> >>> initializer and have `unsafe_const_init` be a no-op on those
> >>> architectures. We could also provide a safe const initializer that is
> >>> only available when that Kconfig option is set.
> >>
> >> I am not sure if the two branches (depending on the config) will be a
> >> good idea. We don't save on `unsafe` and only increase code complexity=
.
> >> The no-op sounds like a better idea to me.
> >
> > You mean put the logic here instead in the downstream user? I agree.
>
> I meant that
>
>     #[cfg(ZERO_LOCK_INIT)]
>     static MY_MUTEX: Mutex<()> =3D Mutex::new_zeroed();
>
>     #[cfg(not(ZERO_LOCK_INIT))]
>     // SAFETY: ...
>     static MY_MUTEX: Mutex<()> =3D unsafe { Mutex::unsafe_const_new() };
>
>
>     module_init() {
>         #[cfg(not(ZERO_LOCK_INIT))]
>         {
>             // SAFETY: ...
>             unsafe { MY_MUTEX.unsafe_const_init() };
>         }
>     }
>
> is significantly worse compared to just
>
>     // SAFETY: ...
>     static MY_MUTEX: Mutex<()> =3D unsafe { Mutex::unsafe_const_new() };
>
>
>     module_init() {
>         // SAFETY: ...
>         unsafe { MY_MUTEX.unsafe_const_init() };
>         //                ^^^^^^^^^^^^^^^^^
>         //                if ZERO_LOCK_INIT, then this is a no-op.
>     }

Agree.

> >>> For architectures that don't use all-zeros for the unlocked case, we
> >>> will most likely have to hard-code the correct representation on the
> >>> Rust side.
> >>
> >> You mean in `unsafe_const_init`?
> >
> > No, I mean we would have `unsafe_const_new` directly set `state` to
> > the right value and let `unsafe_const_init` be a no-op.
>
> But how do you set the right value of a list_head? The value will be
> moved.

Right ... we probably can't get around needing a macro. Can statics
even reference themselves?

> >>> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> >>> ---
> >>> Changes in v2:
> >>> - Require `self: Pin<&Self>` and recommend `Pin::static_ref`.
> >>> - Other doc improvements including new example.
> >>> - Link to v1: https://lore.kernel.org/r/20240826-static-mutex-v1-1-a1=
4ee71561f3@google.com
> >>> ---
> >>>  rust/kernel/sync/lock.rs | 64 ++++++++++++++++++++++++++++++++++++++=
+++++++++-
> >>>  1 file changed, 63 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/rust/kernel/sync/lock.rs b/rust/kernel/sync/lock.rs
> >>> index f6c34ca4d819..cfc5e160d78c 100644
> >>> --- a/rust/kernel/sync/lock.rs
> >>> +++ b/rust/kernel/sync/lock.rs
> >>> @@ -7,7 +7,7 @@
> >>>
> >>>  use super::LockClassKey;
> >>>  use crate::{init::PinInit, pin_init, str::CStr, types::Opaque, types=
::ScopeGuard};
> >>> -use core::{cell::UnsafeCell, marker::PhantomData, marker::PhantomPin=
ned};
> >>> +use core::{cell::UnsafeCell, marker::PhantomData, marker::PhantomPin=
ned, pin::Pin};
> >>>  use macros::pin_data;
> >>>
> >>>  pub mod mutex;
> >>> @@ -117,6 +117,68 @@ pub fn new(t: T, name: &'static CStr, key: &'sta=
tic LockClassKey) -> impl PinIni
> >>>              }),
> >>>          })
> >>>      }
> >>> +
> >>> +    /// Create a global lock that has not yet been initialized.
> >>> +    ///
> >>
> >> Could you add a paragraph that explains that
> >
> > Explains that what?
>
> ... this is not the usual way to create a `Lock`, use this only when
> creating a global, `static` lock. For all other purposes, use
> `new_<lock-type>`.

Ok.

> >>> +    /// Since global locks is not yet fully supported, this method i=
mplements global locks by
> >>> +    /// requiring you to initialize them before you start using it. =
Usually this is best done in
> >>> +    /// the module's init function.
> >>> +    ///
> >>> +    /// # Examples
> >>> +    ///
> >>
> >> I would preface this example with "Instead of [`Mutex<T>`], you can us=
e
> >> any other lock.".
> >
> > I don't love that wording. How about something along these lines?
> > "This example uses a Mutex, but this works with any other lock
> > including spin locks."
>
> Sure.
>
> >>> +    /// ```
> >>> +    /// use kernel::sync::Mutex;
> >>> +    ///
> >>> +    /// // SAFETY: We initialize the mutex before first use.
> >>> +    /// static MY_MUTEX: Mutex<()> =3D unsafe { Mutex::unsafe_const_=
new(()) };
> >>> +    ///
> >>> +    /// // For the sake of this example, assume that this is the mod=
ule initializer.
> >>
> >> Why not actually provide a module initializer?
> >
> > Can I put a `module!` macro inside a kunit test? I assumed that I could=
n't.
>
> I think if you wrap it in another `mod`, then it should work, but I
> might be wrong.

I guess I can implement the Module trait without using the module! macro.

> >>> +    ///             .unsafe_const_init(kernel::c_str!("MY_MUTEX"), k=
ernel::static_lock_class!())
> >>> +    ///     };
> >>> +    /// }
> >>> +    /// ```
> >>> +    ///
> >>> +    /// # Safety
> >>> +    ///
> >>> +    /// You must call [`unsafe_const_init`] before calling any other=
 method on this lock.
> >>> +    ///
> >>> +    /// [`unsafe_const_init`]: Self::unsafe_const_init
> >>> +    pub const unsafe fn unsafe_const_new(t: T) -> Self {
> >>
> >> I am not sure on this name, I don't think we have any functions with
> >> `unsafe` in it (and `std` also doesn't). How about `new_uninitialized`=
?
> >>
> >> Although that might be confusing, since it does actually take a value.=
..
> >
> > Hmm. Any other ideas? const_new_need_manual_init?
>
> Hmm that seems too long... `new_static_uninit`? I don't think that
> `const` belongs in the name either, since you wouldn't use it in a
> `const` (but sure it is used in const contexts, but I find putting it in
> the name confusing).

Works for me.

Alice

