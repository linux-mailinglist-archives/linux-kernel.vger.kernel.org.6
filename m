Return-Path: <linux-kernel+bounces-529019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A63C1A41EE6
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 13:28:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 717D83A4E8D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 12:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6562221F18;
	Mon, 24 Feb 2025 12:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kezcIo3C"
Received: from mail-lf1-f66.google.com (mail-lf1-f66.google.com [209.85.167.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10A621931F;
	Mon, 24 Feb 2025 12:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740399699; cv=none; b=T8d/iBiVbcqgFL0awkoJ05BceWMN2hHn51CCpzc7oVc69+ZT6f/qUDz1jO6k9RE93EVxXX534o/ai04IzgiH9aRLcOGl1rLd1ZQHp6af027CC5M2HfuXN49E+UhEdMbuBBoRX685812JZGZTcqDT2C3hQ1SPWC8/ZACOy0oLfgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740399699; c=relaxed/simple;
	bh=c/0MoOdjamanUJmTHJ0B14Pe8e4uSePSvvWTapuIgp8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XW0gXo+U5fsAp91/vkgNMKHmQsilR1C3q2EjMpuGVXx7H8Acg6UGTeLEEH4dO0I/hR82J7sEQ9ljj3L5lJt+8OhxgJMFfxkvr0tGT3XC7ogk8RUSvodANuALWUixw+JLD5aE9cOzG9tWxJo3X7TEvk0u6sb3T3u/mRx7/7HTP9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kezcIo3C; arc=none smtp.client-ip=209.85.167.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f66.google.com with SMTP id 2adb3069b0e04-5461dab4bfdso5307464e87.3;
        Mon, 24 Feb 2025 04:21:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740399696; x=1741004496; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IWmOfEdSXzaBBdG333oww2KYZMfQXKcB4kFwGEnLasM=;
        b=kezcIo3CC/x38Gs4FFUc0ZbWna0oGz/lsZiPqZQvGNvr4muIOoNGIny1h714ybtIAJ
         kdUisxBuoitVOiq6E65hdf0E0bCw8pCduDQ9e7+8EJiq70fg+0HyFb/4cAUIqPuYww6T
         F5MuLVq0KPzS4lzMTYxX3+1z2c+vQ3kfXF/1nDNsWp5550BlXcBwtGqkjJT6iEokh6rR
         EpNOf32H/CNVSfmNLKesIRxsreSGM8v17YgtVZAUhY0kIv3O/QTmZVxk6eKrvf/FX2h9
         voWw/DyeJUK5YJG6VBu4Z0bhSPErpllubn3bJSBR7wplMTRXwEbUXZDhzDH3gk34Tpmj
         P6sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740399696; x=1741004496;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IWmOfEdSXzaBBdG333oww2KYZMfQXKcB4kFwGEnLasM=;
        b=T7DBM6R6M1wMtzNiICFoewsmSl60hSzUa0K/1QIpbNjit0bBl1XjPTkEPSWpmoA6fa
         +9uszXkUxVsUwwklE402cmqprSC0HWRg9bBYQYobirzlsoZmkcPVG3scbBglV618dmvo
         uHi+M6vasJkrc70q9d+6H9GMPNN8tInVarqd6ihcprdxKf457qx+Ze89l94AVFtzRsl9
         g0fFZW9fQngkhLUhWUkhrsnLC4IyF+q46ESaUolzBp8KI7o0r5ojexR4Oq91frna4NkU
         pe01GbSc2pTNcsuV019uGdGvawMRXeF6LQAAzsPaUiPcM5Yj5/w3OkEa6ro5mzyZLHxV
         R0kg==
X-Forwarded-Encrypted: i=1; AJvYcCUJNjYZVm+6oJpIzFe8FKka0gNsVqihu7C2PFE3A8WGAvgCh5xTfY1moY5dtf2tzDHCqe9i/wLAGuws8No=@vger.kernel.org, AJvYcCUnipPExmnKMPETkuoJNzbH0UNKb1RHHQRQtCc2WyzRVtmrZ8lDscYYejo3eDoCjPAbzGllW/4uwzXhbWlf9tM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyuh4jiNEOrS1Yl/Te1t5+ib5mHtwX9N7BCRxyYmqKb7x4f9a1x
	XAp0RN00h2IjyQi4xPKmqBDBxkEEPNTArW/I3KsLvNb9lkId9GvbKA6dlGL9SQO1FY4qBUffvdz
	Tlf2oaNd8WteNVWTbXYdugjpaYWs=
X-Gm-Gg: ASbGncsNBiKF5qC6jrwH0013T7DnDvuNloYCEe0St33Wc0pJH+7aCQWUJ47O4cCDTw9
	V8miE7GTEEHhc543wJP1wcEzFGnrQ+Es2TtbYdz4f8n6M3G1JrwekIfVZOqqvpymS1Cfs6/LehV
	MlFHXtlwtG
X-Google-Smtp-Source: AGHT+IH2c4YXSrUFIM8m/cIdnso6oiTzGNNXNjULwiaY1NOd65Qxm1jJJr3q91sh9mzEWfc8vGw0MuG3NJk+3gUjqoY=
X-Received: by 2002:a05:6512:b9d:b0:545:e2e:842b with SMTP id
 2adb3069b0e04-54838eddd50mr4261726e87.9.1740399695761; Mon, 24 Feb 2025
 04:21:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFJgqgRygssuSya_HCdswguuj3nDf_sP9y2zq4GGrN1-d7RMRw@mail.gmail.com>
 <20250222141521.1fe24871@eugeo> <CAFJgqgSG4iZE12Yg6deX3_VYSOLxkm5yr5yu25HxN+y4wPD5bg@mail.gmail.com>
 <6pwjvkejyw2wjxobu6ffeyolkk2fppuuvyrzqpigchqzhclnhm@v5zhfpmirk2c>
 <CAHk-=wgq1DvgNVoodk7JKc6BuU1m9UnoN+k=TLtxCAL7xTP=Dg@mail.gmail.com>
 <CAFJgqgSqMO724SQxinNqVGCGc7=ibUvVq-f7Qk1=S3A47Mr-ZQ@mail.gmail.com>
 <20250224002745.7d7460a7.gary@garyguo.net> <CAFJgqgSNjF=LfrCNTH3GdYssXz9YG-AeCtpibejJ7Ywtx0m3HQ@mail.gmail.com>
 <4cb1d98b-f94b-410a-be90-4394c48bdbf2@proton.me>
In-Reply-To: <4cb1d98b-f94b-410a-be90-4394c48bdbf2@proton.me>
From: Ventura Jack <venturajack85@gmail.com>
Date: Mon, 24 Feb 2025 05:21:20 -0700
X-Gm-Features: AWEUYZmWJgurU6G-WWMuuBdcrkMGAbk8dsKVeoYyziZ88-TkzAQTxVNTTtG_9_I
Message-ID: <CAFJgqgQ3P81-iskGu9R+T=c=wyB2K0JqUhx+Gj+6mkYeY8-ORg@mail.gmail.com>
Subject: Re: C aggregate passing (Rust kernel policy)
To: Benno Lossin <benno.lossin@proton.me>
Cc: Gary Guo <gary@garyguo.net>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Kent Overstreet <kent.overstreet@linux.dev>, airlied@gmail.com, boqun.feng@gmail.com, 
	david.laight.linux@gmail.com, ej@inai.de, gregkh@linuxfoundation.org, 
	hch@infradead.org, hpa@zytor.com, ksummit@lists.linux.dev, 
	linux-kernel@vger.kernel.org, miguel.ojeda.sandonis@gmail.com, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2025 at 3:31=E2=80=AFAM Benno Lossin <benno.lossin@proton.m=
e> wrote:
>
> On 24.02.25 10:57, Ventura Jack wrote:
> >
> > In regards to `UnsafeCell`, I believe that you are correct in regards
> > to mutability. However, if I understand you correctly, and if I
> > am not mistaken, I believe that you are wrong about `UnsafeCell`
> > making it possible to opt-out of the aliasing rules. And thus that
> > `UnsafeCell` does not behave like `T*` in C.
>
> `UnsafeCell<T>` does not behave like `T*` in C, because it isn't a
> pointer. Like Gary said, `&UnsafeCell<T>` behaves like `T*` in C, while
> `&mut UnsafeCell<T>` does not. That is what you quote from the docs
> below. (Those ampersands mark references in Rust, pointers that have
> additional guarantees [1])

From what I can see in the documentation, `&UnsafeCell<T>` also does not
behave like `T*` in C. In C, especially if "strict aliasing" is turned
off in the
compiler, `T*` does not have aliasing requirements. You can have multiple
C `T*` pointers pointing to the same object, and mutate the same object.
The documentation for `UnsafeCell` conversely spends a lot of space
discussing invariants and aliasing requirements.

I do not understand why you claim:

    "`&UnsafeCell<T>` behaves like `T*` in C,"

That statement is false as far as I can figure out, though I have taken it
out of context here. Is the argument in regards to mutability? But `T*` in =
C
allows mutability. If you looked at C++ instead of C, maybe a `const`
pointer would be closer in semantics and behavior.

> below. (Those ampersands mark references in Rust, pointers that have
> additional guarantees [1])
>
>[omitted]
>
> [1]: https://doc.rust-lang.org/std/primitive.reference.html

There is also https://doc.rust-lang.org/reference/types/pointer.html .
But, references must follow certain aliasing rules, and in unsafe Rust,
it is the programmer that has the burden of upholding those aliasing rules,
right?

> For disabling the uniqueness guarantee for `&mut`, we use an official
> "hack" that the Rust language developers are working on replacing with
> a better mechanism (this was also mentioned by Gary above).

Are you referring to `Opaque`?

> > Documentation and related links for `Opaque`:
> >     https://rust.docs.kernel.org/kernel/types/struct.Opaque.html
> >     https://rust.docs.kernel.org/src/kernel/types.rs.html#307-310
> >     https://github.com/Rust-for-Linux/pinned-init
> >
> > It uses `UnsafeCell`, Rust "pinning", and the Rust for Linux library
> > "pinned-init".
>
> pinned-init is not specific to `Opaque` and not really relevant with
> respect to discussing aliasing guarantees.

Is `Opaque` really able to avoid aliasing requirements for users,
without internally using "pinned-init"/derivative or the pinning
feature used in its implementation?

> > "pinned-init" uses a number of experimental, unstable and nightly
> > features of Rust.
>
> This is wrong. It uses no unstable features when you look at the version
> in-tree (at `rust/kernel/init.rs`). The user-space version uses a single
> unstable feature: `allocator_api` for accessing the `AllocError` type
> from the standard library. You can disable the `alloc` feature and use
> it on a stable compiler as written in the readme.

Interesting, I did not realize that the Rust for Linux project uses
a fork or derivative of "pinned-init" in-tree, not "pinned-init" itself.

What I can read in the README.md:
    https://github.com/Rust-for-Linux/pinned-init/tree/main

    "Nightly Needed for alloc feature

    This library requires the allocator_api unstable feature
    when the alloc feature is enabled and thus this feature
    can only be used with a nightly compiler. When enabling
    the alloc feature, the user will be required to activate
    allocator_api as well.

    The feature is enabled by default, thus by default
    pinned-init will require a nightly compiler. However, using
    the crate on stable compilers is possible by disabling alloc.
    In practice this will require the std feature, because stable
    compilers have neither Box nor Arc in no-std mode."

Rust in Linux uses no_std, right? So Rust in Linux would not be
able to use the original "pinned_init" library as it currently is without
using currently nightly/unstable features, until the relevant feature(s)
is stabilized.

> > Working with the library implementation requires having a good
> > understanding of unsafe Rust and many advanced features of Rust.
>
> pinned-init was explicitly designed such that you *don't* have to write
> unsafe code for initializing structures that require pinning from the
> get-go (such as the kernel's mutex).

Sorry, I sought to convey that I was referring to the internal library
implementation, not the usage of the library.

For the library implementation, do you agree that a good
understanding of unsafe Rust and many advanced features
are required to work with the library implementation? Such as
pinning?

> > `Opaque` looks interesting. Do you know if it will become a more
> > widely used abstraction outside the Linux kernel?
>
> Only in projects that do FFI with C/C++ (or other such languages).
> Outside of that the `Opaque` type is rather useless, since it disables
> normal guarantees and makes working with the inner type annoying.

Interesting.

Best, VJ.

