Return-Path: <linux-kernel+bounces-529091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FBD1A41F81
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 13:49:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23FB81895667
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 12:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E407D248865;
	Mon, 24 Feb 2025 12:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="exZNX6Mr"
Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E28718B46C
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 12:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740401263; cv=none; b=P1WM8GsF6k59GPuY+2KChnh+AFJq6thf1NZ1OlPZfGoBP7tdhguYUlzZrgis9C0P9baQIsohr3VhHPMrfLReN5VpE3AbwgWO8S3FmtZlRG70QAtmn2NhFevWG3aD/RxQch2qjVCQ3h//P3aqprxa9N8OGa4FaSA/QvKC0d4Rx5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740401263; c=relaxed/simple;
	bh=oZ2dWmyU4A//0DoserIi+hU6J9FipYEUap9axJniyx4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qx4DcZpW+Q2K+Hk0PjkXgWmlkGBkaume89A8zcX35jaupn/yazQOX+IlvVfmpNRX2zVCCsKyBX7cSWiiy5Z+XAx5/61Yo3OajpxWVmfq9Sj+ohcFsK+CUvqPCwx1QHHL6xBpOAexZtrpUEuRgcZ8Bk5jjJb5qfQ2IZX+1Y5T8+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=exZNX6Mr; arc=none smtp.client-ip=185.70.40.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=vldkxvxq5bgy3elbypmorpcpye.protonmail; t=1740401258; x=1740660458;
	bh=izzT/+0Q8SQxJzAfO8adqcn2Lgu3MSr0pO4y4sFm3ys=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=exZNX6MrZub/mnUGj6o/6Nq69vx7GgeC3TMGUDibQyxTc6nuKWYxmtWTgWtIqdz4P
	 p9TNIP8ChSbMuwMPCJQRcSmqPfSA0gks98iBMQp1h+xxVwQ2WnBb7C37lU+yKtlCW2
	 3cwVRumVstGDepJO95gozF3Z8OmF6OiIPtC+KmuuY75kX/iEACUxq8YJOQYC+quvgA
	 /Dk8YKV7zUfCWxscoTHsGsaS/D13XHqSDz/xCKh09ey2nIp3a2ztkAtZJm4VRFm5Yn
	 GrRLe5Di82lZOkNmPc4IBHjCbY7PYQa43jQ3b+p1v5XblsmgtJvDtcG647c+cqJifi
	 udNoy5YMQhmfA==
Date: Mon, 24 Feb 2025 12:47:32 +0000
To: Ventura Jack <venturajack85@gmail.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Gary Guo <gary@garyguo.net>, Linus Torvalds <torvalds@linux-foundation.org>, Kent Overstreet <kent.overstreet@linux.dev>, airlied@gmail.com, boqun.feng@gmail.com, david.laight.linux@gmail.com, ej@inai.de, gregkh@linuxfoundation.org, hch@infradead.org, hpa@zytor.com, ksummit@lists.linux.dev, linux-kernel@vger.kernel.org, miguel.ojeda.sandonis@gmail.com, rust-for-linux@vger.kernel.org
Subject: Re: C aggregate passing (Rust kernel policy)
Message-ID: <a4b79751-f1c8-4476-98a5-c59fb2e545ad@proton.me>
In-Reply-To: <CAFJgqgQ3P81-iskGu9R+T=c=wyB2K0JqUhx+Gj+6mkYeY8-ORg@mail.gmail.com>
References: <CAFJgqgRygssuSya_HCdswguuj3nDf_sP9y2zq4GGrN1-d7RMRw@mail.gmail.com> <20250222141521.1fe24871@eugeo> <CAFJgqgSG4iZE12Yg6deX3_VYSOLxkm5yr5yu25HxN+y4wPD5bg@mail.gmail.com> <6pwjvkejyw2wjxobu6ffeyolkk2fppuuvyrzqpigchqzhclnhm@v5zhfpmirk2c> <CAHk-=wgq1DvgNVoodk7JKc6BuU1m9UnoN+k=TLtxCAL7xTP=Dg@mail.gmail.com> <CAFJgqgSqMO724SQxinNqVGCGc7=ibUvVq-f7Qk1=S3A47Mr-ZQ@mail.gmail.com> <20250224002745.7d7460a7.gary@garyguo.net> <CAFJgqgSNjF=LfrCNTH3GdYssXz9YG-AeCtpibejJ7Ywtx0m3HQ@mail.gmail.com> <4cb1d98b-f94b-410a-be90-4394c48bdbf2@proton.me> <CAFJgqgQ3P81-iskGu9R+T=c=wyB2K0JqUhx+Gj+6mkYeY8-ORg@mail.gmail.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 5e36dc550687cf705f54d72a0b677ac4439eb912
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 24.02.25 13:21, Ventura Jack wrote:
> On Mon, Feb 24, 2025 at 3:31=E2=80=AFAM Benno Lossin <benno.lossin@proton=
.me> wrote:
>>
>> On 24.02.25 10:57, Ventura Jack wrote:
>>>
>>> In regards to `UnsafeCell`, I believe that you are correct in regards
>>> to mutability. However, if I understand you correctly, and if I
>>> am not mistaken, I believe that you are wrong about `UnsafeCell`
>>> making it possible to opt-out of the aliasing rules. And thus that
>>> `UnsafeCell` does not behave like `T*` in C.
>>
>> `UnsafeCell<T>` does not behave like `T*` in C, because it isn't a
>> pointer. Like Gary said, `&UnsafeCell<T>` behaves like `T*` in C, while
>> `&mut UnsafeCell<T>` does not. That is what you quote from the docs
>> below. (Those ampersands mark references in Rust, pointers that have
>> additional guarantees [1])
>=20
> From what I can see in the documentation, `&UnsafeCell<T>` also does not
> behave like `T*` in C. In C, especially if "strict aliasing" is turned
> off in the
> compiler, `T*` does not have aliasing requirements. You can have multiple
> C `T*` pointers pointing to the same object, and mutate the same object.

This is true for `&UnsafeCell<T>`. You can have multiple of those and
mutate the same value via only shared references. Note that
`UnsafeCell<T>` is `!Sync`, so it cannot be shared across threads, so
all of those shared references have to be on the same thread. (there is
the `SyncUnsafeCell<T>` type that is `Sync`, so it does allow for
across-thread mutations, but that is much more of a footgun, since you
still have to synchronize the writes/reads)

> The documentation for `UnsafeCell` conversely spends a lot of space
> discussing invariants and aliasing requirements.

Yes, since normally in Rust, you can either have exactly one mutable
reference, or several shared references (which cannot be used to mutate
a value). `UnsafeCell<T>` is essentially a low-level primitive that can
only be used with `unsafe` to build for example a mutex.

> I do not understand why you claim:
>=20
>     "`&UnsafeCell<T>` behaves like `T*` in C,"
>=20
> That statement is false as far as I can figure out, though I have taken i=
t
> out of context here.

Not sure how you arrived at that conclusion, the following code is legal
and sound Rust:

    let val =3D UnsafeCell::new(42);
    let x =3D &val;
    let y =3D &val;
    unsafe {
        *x.get() =3D 0;
        *y.get() =3D 42;
        *x.get() =3D 24;
    }

You can't do this with `&mut i32`.

> Is the argument in regards to mutability? But `T*` in C
> allows mutability. If you looked at C++ instead of C, maybe a `const`
> pointer would be closer in semantics and behavior.
>=20
>> below. (Those ampersands mark references in Rust, pointers that have
>> additional guarantees [1])
>>
>> [omitted]
>>
>> [1]: https://doc.rust-lang.org/std/primitive.reference.html
>=20
> There is also https://doc.rust-lang.org/reference/types/pointer.html .

Yes that is the description of all primitive pointer types. Both
references and raw pointers.

> But, references must follow certain aliasing rules, and in unsafe Rust,
> it is the programmer that has the burden of upholding those aliasing rule=
s,
> right?

Indeed.

>> For disabling the uniqueness guarantee for `&mut`, we use an official
>> "hack" that the Rust language developers are working on replacing with
>> a better mechanism (this was also mentioned by Gary above).
>=20
> Are you referring to `Opaque`?

I am referring to the hack used by `Opaque`, it is `!Unpin` which
results in `&mut Opaque<T>` not having the `noalias` attribute.

>>> Documentation and related links for `Opaque`:
>>>     https://rust.docs.kernel.org/kernel/types/struct.Opaque.html
>>>     https://rust.docs.kernel.org/src/kernel/types.rs.html#307-310
>>>     https://github.com/Rust-for-Linux/pinned-init
>>>
>>> It uses `UnsafeCell`, Rust "pinning", and the Rust for Linux library
>>> "pinned-init".
>>
>> pinned-init is not specific to `Opaque` and not really relevant with
>> respect to discussing aliasing guarantees.
>=20
> Is `Opaque` really able to avoid aliasing requirements for users,
> without internally using "pinned-init"/derivative or the pinning
> feature used in its implementation?

Yes, you can write `Opaque<T>` without using pinned-init. The hack
described above uses `PhantomPinned` to make `Opaque<T>: !Unpin`.

>>> "pinned-init" uses a number of experimental, unstable and nightly
>>> features of Rust.
>>
>> This is wrong. It uses no unstable features when you look at the version
>> in-tree (at `rust/kernel/init.rs`). The user-space version uses a single
>> unstable feature: `allocator_api` for accessing the `AllocError` type
>> from the standard library. You can disable the `alloc` feature and use
>> it on a stable compiler as written in the readme.
>=20
> Interesting, I did not realize that the Rust for Linux project uses
> a fork or derivative of "pinned-init" in-tree, not "pinned-init" itself.

Yes, that is something that I am working on at the moment.

> What I can read in the README.md:
>     https://github.com/Rust-for-Linux/pinned-init/tree/main
>=20
>     "Nightly Needed for alloc feature
>=20
>     This library requires the allocator_api unstable feature
>     when the alloc feature is enabled and thus this feature
>     can only be used with a nightly compiler. When enabling
>     the alloc feature, the user will be required to activate
>     allocator_api as well.
>=20
>     The feature is enabled by default, thus by default
>     pinned-init will require a nightly compiler. However, using
>     the crate on stable compilers is possible by disabling alloc.
>     In practice this will require the std feature, because stable
>     compilers have neither Box nor Arc in no-std mode."
>=20
> Rust in Linux uses no_std, right? So Rust in Linux would not be
> able to use the original "pinned_init" library as it currently is without
> using currently nightly/unstable features, until the relevant feature(s)
> is stabilized.

Yes, Rust for Linux uses `#![no_std]` (and also has its own alloc), so
it an use the stable version of pinned-init. However, there are several
differences between the current in-tree version and the user-space
version. I am working on some patches that fix that.

>>> Working with the library implementation requires having a good
>>> understanding of unsafe Rust and many advanced features of Rust.
>>
>> pinned-init was explicitly designed such that you *don't* have to write
>> unsafe code for initializing structures that require pinning from the
>> get-go (such as the kernel's mutex).
>=20
> Sorry, I sought to convey that I was referring to the internal library
> implementation, not the usage of the library.

Ah I see.

> For the library implementation, do you agree that a good
> understanding of unsafe Rust and many advanced features
> are required to work with the library implementation? Such as
> pinning?

Yes I agree.

---
Cheers,
Benno

>>> `Opaque` looks interesting. Do you know if it will become a more
>>> widely used abstraction outside the Linux kernel?
>>
>> Only in projects that do FFI with C/C++ (or other such languages).
>> Outside of that the `Opaque` type is rather useless, since it disables
>> normal guarantees and makes working with the inner type annoying.
>=20
> Interesting.
>=20
> Best, VJ.


