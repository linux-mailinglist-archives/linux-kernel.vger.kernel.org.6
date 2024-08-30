Return-Path: <linux-kernel+bounces-308859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA27A9662CD
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 15:22:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4A58B20E29
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 13:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1312B1A4AC6;
	Fri, 30 Aug 2024 13:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="IkNjMnMe"
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B9BE1DA26
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 13:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725024124; cv=none; b=Lo8ivtnRNETgnZzQ5EyWlOVFuCad2pqRyGXju35NNphWp9iN85D49tgJabBmS7Pg1URnwo3TwxPc2BVZhW5Tgm9Ec01hugGEp9IY4E/JpwZoh03yP8xL2yafdhMS5/HWQ6+WaPPd4CPL8jSzimNHPXOHLj1v3Y7K3yo4bZ6R0V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725024124; c=relaxed/simple;
	bh=mNpksmwYlBWl8yUGvwSKr/uBdGm4FLMS/TE4IgDUPKE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=akYfSxNy2APNCxuDU/0ub6/sv/SQoOr8u3fyIe4ZZN1rOuMMLLmHP4bSZwmYNa1AWjRkvHH23YYFuFrnftEsJNq/6Y/Lf3ZjAqqpN86a9Ar6fnNb9yy7iswYr6bDcXbhbtc6Y0mb1Ya4d5e4XVQTpag8RgU1/s/S1wfuzRp7vLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=IkNjMnMe; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1725024119; x=1725283319;
	bh=dNPzc2PTEgDMvGlNoTF8tjdkW2RLDHlcKpclNxo1ikU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=IkNjMnMeKBj0UDlcnivL2FrpUz/9xEXvnHqIAccQcgctsmTokA0qFBCqG3iFFO5+r
	 mZoR2+rjvgaTLlbU9zwzqCPUZctwwpBifF3jz9vRY/RxN+3bpcYJ/1Ww4bnWHO78bB
	 xOfRNHZ+EJFESNQl7Z2AYnMPtGsLUSYOldvDXbl15gmKlD61gLBJIer3pMs3ENtoc0
	 ggl81kYP+rlRRDoUR3uw1sFzey+EM8523cPc6oazVgLJV5iOoM8jgvSbQQOfQHJ52y
	 GSOK0Z+xvJMK1sLzpDWPWpT1QfEe1LzLMWwlI8ZXSIIj+apoP9i8utN3H55JEvJZ+e
	 DXpZ4TBOrrH8g==
Date: Fri, 30 Aug 2024 13:21:55 +0000
To: Alice Ryhl <aliceryhl@google.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] rust: add global lock support
Message-ID: <3b557f61-cead-4568-b2b4-4a56c4cbff52@proton.me>
In-Reply-To: <CAH5fLgh-DYvXobXQVaQ9txYS4Rx8QhjyVvfTphk6vvnUOGzPnw@mail.gmail.com>
References: <20240827-static-mutex-v2-1-17fc32b20332@google.com> <10453342-d269-4b78-8962-821ef53d3cb5@proton.me> <CAH5fLgh-DYvXobXQVaQ9txYS4Rx8QhjyVvfTphk6vvnUOGzPnw@mail.gmail.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: bf4d532ba8af8eec0acbe1dfbd936670d49391dc
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 30.08.24 07:34, Alice Ryhl wrote:
> On Thu, Aug 29, 2024 at 8:17=E2=80=AFPM Benno Lossin <benno.lossin@proton=
.me> wrote:
>>
>> On 27.08.24 10:41, Alice Ryhl wrote:
>>> We don't currently have any support for global locks in Rust, however
>>> they are very useful and I have needed to work around this limitation
>>> several times. My workarounds generally involve initializing the mutex
>>> in the module's init function, and this workaround is reflected here.
>>
>> I would not exactly call this a "workaround". If your use-case is
>> covered by putting a `Mutex`, then I would prefer it. Or did you need
>> additional ugly code to access it?
>=20
> Not sure what you mean by "putting a Mutex" but the workaround is

Oh sorry, seems like I forgot to write the rest of that... Let me try
again: If your use-case is covered by putting a `Mutex` inside of the
type that implements `Module`, then I think you should do that instead
of using a global. (you need the inplace module patch for that)

> really gross and involves defining a whole struct to make types Sync
> and so on. Unlike binder, this patch has access to private fields of
> Lock, so it can do it in a more nice way. You can find it in the
> Binder RFC if you search for "context_global".
> https://lore.kernel.org/rust-for-linux/20231101-rust-binder-v1-2-08ba9197=
f637@google.com/#Z31drivers:android:context.rs

Oh I remember this... Yeah I agree that is ugly, but it is not the
workaround that I imagined when you wrote "initializing the mutex in the
module's init function". There I was thinking of what I wrote above.

This might just be me misunderstanding that, but if you want to improve
it, then you could mention that the mutex is still a static.

>>> Due to the initialization requirement, constructing a global mutex is
>>> unsafe with the current approach. In the future, it would be really nic=
e
>>> to support global mutexes that don't need to be initialized, which woul=
d
>>> make them safe. Unfortunately, this is not possible today because
>>> bindgen refuses to expose __ARCH_SPIN_LOCK_UNLOCKED to Rust as a
>>> compile-time constant. It just generates an `extern "C"` global
>>> reference instead.
>>
>> Ideally, we would have support for static initialization in pinned-init.
>=20
> I don't think traits work with const today, so pin-init would need an
> entirely different mechanism? If you're talking about using

Oh yeah I forgot that that got scratched some time ago.

> CONSTRUCTORS, then I think it's an undesirable solution. C code can

No, I was thinking that the initializer is run at const eval and then
the result is put into the binary.

> define static mutexes without load-time initialization hooks. We
> should be able to do the same.

Agreed.

>>> On most architectures, we could initialize the lock to just contain all
>>> zeros. A possible improvement would be to create a Kconfig constant
>>> that is set whenever the current architecture uses all zeros for the
>>> initializer and have `unsafe_const_init` be a no-op on those
>>> architectures. We could also provide a safe const initializer that is
>>> only available when that Kconfig option is set.
>>
>> I am not sure if the two branches (depending on the config) will be a
>> good idea. We don't save on `unsafe` and only increase code complexity.
>> The no-op sounds like a better idea to me.
>=20
> You mean put the logic here instead in the downstream user? I agree.

I meant that

    #[cfg(ZERO_LOCK_INIT)]
    static MY_MUTEX: Mutex<()> =3D Mutex::new_zeroed();

    #[cfg(not(ZERO_LOCK_INIT))]
    // SAFETY: ...
    static MY_MUTEX: Mutex<()> =3D unsafe { Mutex::unsafe_const_new() };


    module_init() {
        #[cfg(not(ZERO_LOCK_INIT))]
        {
            // SAFETY: ...
            unsafe { MY_MUTEX.unsafe_const_init() };
        }
    }

is significantly worse compared to just

    // SAFETY: ...
    static MY_MUTEX: Mutex<()> =3D unsafe { Mutex::unsafe_const_new() };


    module_init() {
        // SAFETY: ...
        unsafe { MY_MUTEX.unsafe_const_init() };
        //                ^^^^^^^^^^^^^^^^^
        //                if ZERO_LOCK_INIT, then this is a no-op.
    }

>>> For architectures that don't use all-zeros for the unlocked case, we
>>> will most likely have to hard-code the correct representation on the
>>> Rust side.
>>
>> You mean in `unsafe_const_init`?
>=20
> No, I mean we would have `unsafe_const_new` directly set `state` to
> the right value and let `unsafe_const_init` be a no-op.

But how do you set the right value of a list_head? The value will be
moved.

>>> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
>>> ---
>>> Changes in v2:
>>> - Require `self: Pin<&Self>` and recommend `Pin::static_ref`.
>>> - Other doc improvements including new example.
>>> - Link to v1: https://lore.kernel.org/r/20240826-static-mutex-v1-1-a14e=
e71561f3@google.com
>>> ---
>>>  rust/kernel/sync/lock.rs | 64 ++++++++++++++++++++++++++++++++++++++++=
+++++++-
>>>  1 file changed, 63 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/rust/kernel/sync/lock.rs b/rust/kernel/sync/lock.rs
>>> index f6c34ca4d819..cfc5e160d78c 100644
>>> --- a/rust/kernel/sync/lock.rs
>>> +++ b/rust/kernel/sync/lock.rs
>>> @@ -7,7 +7,7 @@
>>>
>>>  use super::LockClassKey;
>>>  use crate::{init::PinInit, pin_init, str::CStr, types::Opaque, types::=
ScopeGuard};
>>> -use core::{cell::UnsafeCell, marker::PhantomData, marker::PhantomPinne=
d};
>>> +use core::{cell::UnsafeCell, marker::PhantomData, marker::PhantomPinne=
d, pin::Pin};
>>>  use macros::pin_data;
>>>
>>>  pub mod mutex;
>>> @@ -117,6 +117,68 @@ pub fn new(t: T, name: &'static CStr, key: &'stati=
c LockClassKey) -> impl PinIni
>>>              }),
>>>          })
>>>      }
>>> +
>>> +    /// Create a global lock that has not yet been initialized.
>>> +    ///
>>
>> Could you add a paragraph that explains that
>=20
> Explains that what?

... this is not the usual way to create a `Lock`, use this only when
creating a global, `static` lock. For all other purposes, use
`new_<lock-type>`.

>>> +    /// Since global locks is not yet fully supported, this method imp=
lements global locks by
>>> +    /// requiring you to initialize them before you start using it. Us=
ually this is best done in
>>> +    /// the module's init function.
>>> +    ///
>>> +    /// # Examples
>>> +    ///
>>
>> I would preface this example with "Instead of [`Mutex<T>`], you can use
>> any other lock.".
>=20
> I don't love that wording. How about something along these lines?
> "This example uses a Mutex, but this works with any other lock
> including spin locks."

Sure.

>>> +    /// ```
>>> +    /// use kernel::sync::Mutex;
>>> +    ///
>>> +    /// // SAFETY: We initialize the mutex before first use.
>>> +    /// static MY_MUTEX: Mutex<()> =3D unsafe { Mutex::unsafe_const_ne=
w(()) };
>>> +    ///
>>> +    /// // For the sake of this example, assume that this is the modul=
e initializer.
>>
>> Why not actually provide a module initializer?
>=20
> Can I put a `module!` macro inside a kunit test? I assumed that I couldn'=
t.

I think if you wrap it in another `mod`, then it should work, but I
might be wrong.

>>> +    /// fn module_init() {
>>> +    ///     // SAFETY:
>>> +    ///     // * `MY_MUTEX` was created using `unsafe_const_new`.
>>> +    ///     // * This call is in the module initializer, which doesn't=
 runs more than once.
>>> +    ///     unsafe {
>>> +    ///         core::pin::Pin::static_ref(&MY_MUTEX)
>>
>> I would put this into a let binding, that way the formatting will also
>> be nicer.
>=20
> Ok.
>=20
>>> +    ///             .unsafe_const_init(kernel::c_str!("MY_MUTEX"), ker=
nel::static_lock_class!())
>>> +    ///     };
>>> +    /// }
>>> +    /// ```
>>> +    ///
>>> +    /// # Safety
>>> +    ///
>>> +    /// You must call [`unsafe_const_init`] before calling any other m=
ethod on this lock.
>>> +    ///
>>> +    /// [`unsafe_const_init`]: Self::unsafe_const_init
>>> +    pub const unsafe fn unsafe_const_new(t: T) -> Self {
>>
>> I am not sure on this name, I don't think we have any functions with
>> `unsafe` in it (and `std` also doesn't). How about `new_uninitialized`?
>>
>> Although that might be confusing, since it does actually take a value...
>=20
> Hmm. Any other ideas? const_new_need_manual_init?

Hmm that seems too long... `new_static_uninit`? I don't think that
`const` belongs in the name either, since you wouldn't use it in a
`const` (but sure it is used in const contexts, but I find putting it in
the name confusing).

---
Cheers,
Benno


