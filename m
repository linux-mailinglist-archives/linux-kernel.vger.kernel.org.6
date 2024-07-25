Return-Path: <linux-kernel+bounces-262614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF79393C993
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 22:32:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F0F11C21F01
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 20:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 526947172F;
	Thu, 25 Jul 2024 20:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="V8brqegr"
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4332623741;
	Thu, 25 Jul 2024 20:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721939548; cv=none; b=Zvql3kTyMZz2GkrQsdM2qSM+IFLtAdnIGaae+UT5z6lfp4JNgWJIwAMCkyGum4HwK2frHl1w0UDIzfBGu6biUz8F1vxG+V9kDEW/dBKUCNb2DEnQtKQxIPaY3ajF6k+vYd5FPCGSHxK12CG5gaK2QGve1fXkqjthYxDxfLmJzl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721939548; c=relaxed/simple;
	bh=sIObVfwo78nXmq5CgmvLuWxkp1dZMcbvcPF1Fc5edAI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Lykd6jqyq9YntHTx40znGzoY5ZO+RVMC7G6xygQd4YSHb/LBzT3lKR+bgZcUSq4KcjhUf0R/ElvzMJZSGOi8xFyoYCie6p9SnlT1f26iK60/ZxatFzV+r8EJK+ut+qk73RvTa87l0OjsPIlSWtQEKNfMTmdlt1ZP3FLnOlZfuRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=V8brqegr; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1721939538; x=1722198738;
	bh=m8zYI59YSqvAJZYI6Q+xN9mUEDVfcCsuZdcvq0LILCk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=V8brqegr1YJtrnJG4e0s7oXNS2iitU8A4HqgEaC1Po/z3e9fmv0EctnTw7MyLmCcY
	 VdyzK9M6S0E704wUV/hWZFfEuOV+80hUZCO5c9yc6UwnGqYY1B4JU52g5OQv4jHwJi
	 Vb9O5CCtrUMi2DOCwi5zceNHdMZJM1BjqR3cHgfg/8p6XH46hFyETETYCad6+FDB5Z
	 Fi1reB59T0jQ/OrMP1O6KHYRSilaEKdwH+wBDamXjDebRETVApya7/B67DGcz0zu2v
	 1uGnYYDyWfMkBXaE4RBL0m0ZlnNo6oP2EcRvxGfntoflU2LBcIFybLk878mV3OwHkB
	 ddYsNgnMvnfXA==
Date: Thu, 25 Jul 2024 20:32:10 +0000
To: Boqun Feng <boqun.feng@gmail.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, Jonathan Corbet <corbet@lwn.net>, Viresh Kumar <viresh.kumar@linaro.org>, Danilo Krummrich <dakr@redhat.com>, Trevor Gross <tmgross@umich.edu>, gregkh@linuxfoundation.org
Subject: Re: [RFC PATCH] rust: types: Add explanation for ARef pattern
Message-ID: <ba35b142-a5ad-454f-8ed8-216bc6cf4d9c@proton.me>
In-Reply-To: <ZqKwQ4krNB1WjSu5@boqun-archlinux>
References: <20240710032447.2161189-1-boqun.feng@gmail.com> <ef9c98ea-b8ce-4017-9db8-177731996513@proton.me> <ZqKwQ4krNB1WjSu5@boqun-archlinux>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 3e09d934b99928e7759e1b4259e570b07c6f8c42
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 25.07.24 22:06, Boqun Feng wrote:
> Hi Benno,
>=20
> Thanks for taking a look.
>=20
> On Thu, Jul 25, 2024 at 06:51:56PM +0000, Benno Lossin wrote:
>> On 10.07.24 05:24, Boqun Feng wrote:
>>> As the usage of `ARef` and `AlwaysRefCounted` is growing, it makes sens=
e
>>> to add explanation of the "ARef pattern" to cover the most "DO" and "DO
>>> NOT" cases when wrapping a self-refcounted C type.
>>>
>>> Hence an "ARef pattern" section is added in the documentation of `ARef`=
.
>>>
>>> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
>>> ---
>>> This is motivated by:
>>>
>>> =09https://lore.kernel.org/rust-for-linux/20240705110228.qqhhynbwwuwpcd=
eo@vireshk-i7/
>>>
>>>  rust/kernel/types.rs | 156 +++++++++++++++++++++++++++++++++++++++++++
>>>  1 file changed, 156 insertions(+)
>>>
>>> diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
>>> index bd189d646adb..70fdc780882e 100644
>>> --- a/rust/kernel/types.rs
>>> +++ b/rust/kernel/types.rs
>>> @@ -329,6 +329,162 @@ pub unsafe trait AlwaysRefCounted {
>>>  ///
>>>  /// The pointer stored in `ptr` is non-null and valid for the lifetime=
 of the [`ARef`] instance. In
>>>  /// particular, the [`ARef`] instance owns an increment on the underly=
ing object's reference count.
>>> +///
>>> +/// # [`ARef`] pattern
>>> +///
>>> +/// "[`ARef`] pattern" is preferred when wrapping a C struct which has=
 its own refcounting
>>
>> I would have written "[...] struct which is reference-counted, because
>> [...]", is there a specific reason you wrote "its own"?
>>
>=20
> "its own" indicates the reference counters are inside the object (i.e.
> self refcounted), it's different than `Arc<T>` where the reference
> counters are "attached" to `T`. Your version looks good to me as well.

I thought about that as well, but the paragraph above talks about a C
struct, so what is meant with "its own" there?

>>> +/// mechanism, because it decouples the operations on the object itsel=
f (usually via a `&Foo`) vs the
>>> +/// operations on a pointer to the object (usually via an `ARef<Foo>`)=
. For example, given a `struct
>>
>> Not exactly sure I understand your point here, what exactly is the
>> advantage of decoupling the operations?
>> In my mind the following points are the advantages of using `ARef`:
>> (1) prevents having to implement multiple abstractions for a single C
>>     object: say there is a `struct foo` that is both used via reference
>>     counting and by-value on the stack. Without `ARef`, we would have to
>>     write two abstractions, one for each use-case. With `ARef`, we can
>>     have one `Foo` that can be wrapped with `ARef` to represent a
>>     reference-counted object.
>> (2) `ARef<T>` always represents a reference counted object, so it helps
>>     with understanding the code. If you read `Foo`, you cannot be sure
>>     if it is heap or stack allocated.
>> (3) generalizes common code of reference-counted objects (ie avoiding
>>     code duplication) and concentration of `unsafe` code.
>>
>> In my opinion (1) is the most important, then (2). And (3) is a nice
>> bonus. If you agree with the list above (maybe you also have additional
>> advantages of `ARef`?) then it would be great if you could also add them
>> somewhere here.
>>
>=20
> Basically to me, the advantages are mostly (1) and (2) in your list,
> thank you for the list. And I did try to use an example (below) to
> explain these, because I felt an example of the bad cases is
> straightforward.
>=20
> I will add your list here, because although an example may be
> straightforward of reading, a list of advantages are better for
> references. Again, thanks a lot!
>=20
>>> +/// foo` defined in C, which has its own refcounting operations `get_f=
oo()` and `put_foo()`. Without
>>> +/// "[`ARef`] pattern", i.e. **bad case**:
>>
>> Instead of "bad case" I would have written "i.e. you want to avoid this:=
".
>>
>=20
> I'm OK with your version, but for my personal interest, why? ;-)

I felt like "bad case" did not "flow" right when reading and I also
think that "you want to avoid this" sounds more polite :)

>>> +///
>>> +/// ```ignore
>>> +/// pub struct Foo(NonNull<foo>);
>>> +///
>>> +/// impl Foo {
>>> +///     // An operation on the pointer.
>>> +///     pub unsafe fn from_ptr(ptr: *mut foo) -> Self {
>>> +///         // Note that whether `get_foo()` is needed here depends on=
 the exact semantics of
>>> +///         // `from_ptr()`: is it creating a new reference, or it con=
tinues using the caller's
>>> +///         // reference?
>>> +///         unsafe { get_foo(ptr); }
>>> +///
>>> +///         unsafe { Foo(NonNull::new_unchecked(foo)) }
>>> +///     }
>>> +///
>>> +///     // An operation on the object.
>>> +///     pub fn get_bar(&self) -> Bar {
>>> +///         unsafe { (*foo.0.as_ptr()).bar }
>>> +///     }
>>> +/// }
>>> +///
>>> +/// // Plus `impl Clone` and `impl Drop` are also needed to implement =
manually.
>>> +/// impl Clone for Foo {
>>> +///     fn clone(&self) -> Self {
>>> +///         unsafe { get_foo(self.0.as_ptr()); }
>>> +///
>>> +///         Foo(self.0)
>>> +///     }
>>> +/// }
>>> +///
>>> +/// impl Drop for Foo {
>>> +///     fn drop(&mut self) {
>>> +///         unsafe { put_foo(self.0.as_ptr()); }
>>> +///     }
>>> +/// }
>>> +/// ```
>>> +///
>>> +/// In this case, it's hard to tell whether `Foo` represent an object =
of `foo` or a pointer to
>>> +/// `foo`.
>>> +///
>>> +/// However, if using [`ARef`] pattern, `foo` can be wrapped as follow=
:
>>> +///
>>> +/// ```ignore
>>> +/// /// Note: `Opaque` is needed in most cases since there usually exi=
st C operations on
>>
>> I would disagree for the reason that `Opaque` is needed. You need it if
>> the `foo` eg contains a bool, since C might just write a nonsense
>> integer which would then result in immediate UB in Rust.
>> Other reasons might be that certain bytes of `foo` are written to by
>> other threads, even though on the Rust side we have `&mut Foo` (eg a
>> `mutex`).
>>
>=20
> hmm.. "since there usually exist C operations on ..." include these two
> cases you mentioned, no? Plus, the reference counters themselves are not
> marked as atomic at the moment, so without `Opaque`, we also have UB
> because of the reference counters. I was trying to summarize all these
> as "C operations on ...", maybe I should say "concurrent C operations on
> ..."? I am trying to be concise here since it's a comment inside a
> comment ;-)

Ah that is your definition of "C operations", I interpreted it as "there
are functions that take `struct foo *`". So maybe it would be good to
spell out exactly why `Opaque` might be needed.
I think its fine to be verbose here.

---
Cheers,
Benno

>>> +/// /// `struct foo *`, and `#[repr(transparent)]` is needed for the s=
afety of converting a `*mut
>>> +/// /// foo` to a `*mut Foo`
>>> +/// #[repr(transparent)]
>>> +/// pub struct Foo(Opaque<foo>);
>>> +///
>>> +/// impl Foo {
>>> +///     pub fn get_bar(&self) -> Bar {
>>> +///         // SAFETY: `self.0.get()` is a valid pointer.
>>> +///         //
>>> +///         // Note: Usually extra safety comments are needed here to =
explain why accessing `.bar`
>>> +///         // doesn't race with C side. Most cases are either calling=
 a C function, which has its
>>> +///         // own concurrent access protection, or holding a lock.
>>> +///         unsafe { (*self.0.get()).bar }
>>> +///     }
>>> +/// }
>>> +/// ```
>>> +///
>>> +/// ## Avoid `impl AlwaysRefCounted` if unnecesarry


