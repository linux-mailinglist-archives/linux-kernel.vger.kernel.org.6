Return-Path: <linux-kernel+bounces-529623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EC718A428E2
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 18:07:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DE1B1889A88
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 17:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C776265CC9;
	Mon, 24 Feb 2025 16:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VNRQApxj"
Received: from mail-lf1-f67.google.com (mail-lf1-f67.google.com [209.85.167.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4FD265CBC;
	Mon, 24 Feb 2025 16:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740416278; cv=none; b=A+UU+n3kl/bhduBrKpX2FzIb69shy2++9go5vd/MXAuy6LKmkoylAVHsZZEOxQpZwxfRQSAW3rFAUz46OZ/+R1HSbvf4Y5kOM2MziHX1qgyToOqZ3ZvELQX9e66M8T8rYlMIe3zuWzeOoEOWT87zc1suBWyx0LWlshYbSyU9/zM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740416278; c=relaxed/simple;
	bh=9AkYuCDxcIMGop0F0nXFLogpfd+Onp8GeWGOnM+by0o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e0qXmuX4rT0p9HPJIaYrc0yDHJqubGLpafFN3nwRN4oA3No7Y9YqqYaL3VdeJBipYR9J1YLgF8YdhS2q5U4YVV8PL4XTQeSqy1Su9oqVW+O0+XjzadfVbB07dnbCL33bDMZ/4Bpz+Z1KRYzTgwunBaLMEXWITqN/MO+eealN/IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VNRQApxj; arc=none smtp.client-ip=209.85.167.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f67.google.com with SMTP id 2adb3069b0e04-5452e6f2999so4978413e87.3;
        Mon, 24 Feb 2025 08:57:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740416275; x=1741021075; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+yFjW1zH+gD+0Z6S7sAaI1nnRNP2Mxs8668OLM/EkQk=;
        b=VNRQApxjAdpPytk34zPMsnsvRNTCtKR4XmRZgIM62ObFkYZ13DybB44Xy+pErEAzFf
         20Z5LMzgYKlByi4R6ZLPAUBOLYjmql/2MN8vrRakFWUCdMzO7jibT4zZqklviNHu4MAS
         qu6Mv8GdXAd7BcSVSVqbpBiQY1rzEvFLw8zcei0tnoc36mVu/d5+t0dpaL/A54BhfnsX
         l5/CNNOUE0mIwk1ujHZX3FaF4oMXT0k+w2dRsYJh5AXml0MVAiXRb1fXd9CtPuB+Hbl+
         ocjdHmqUJhkIBVXk7E5LTHw8TaGZHOdbEWEYGQEA6zz9aQcL05gumEvJAug2y259YcnK
         yGxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740416275; x=1741021075;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+yFjW1zH+gD+0Z6S7sAaI1nnRNP2Mxs8668OLM/EkQk=;
        b=KTKrCvzKVfFprbKUkHBZLzsCzqGnKla7EktroQnyVh2hHoykkVFo5vKVKwGy9u0bcZ
         SsgPQAbTcL2/H45xAiZu5boLuS8pbkmCF8nrTwfFBZApJenHAT0fZ+p6JMnx38gnU1Nn
         89t617D5ydBZl4KaPokYErXnbne/zFWuqxtwARr/aRYb1p/yyMAb7CnSm/MzfmFzjaAL
         k8jQYqQkHrzQpfOXvLqrRX2sV3QuRgvkXblOBWxZeN5BEAYHKz2ArUjyeNAf7xUTZTTv
         VN92MuiSVy1L3nhwOc3uBc9QSWyHFxvOCtmGzMu6QctLL3+hLFlH34j8jI03DfJy81Ho
         KteA==
X-Forwarded-Encrypted: i=1; AJvYcCWh3HiBTsG6YOJrupwCTvctUynzgph/hof1lKsZZ6w+g4P58rxoE/1kyYktktsJbNfD6W3f5ATbSbrcpUC6x1w=@vger.kernel.org, AJvYcCXF0qVjxLxEHvJPEVWPP22LfEFL4gMMV/TgLggjnYUSR3ouITgsFBH/tclyVziq1YSDEJIqD4Ks8eTppTU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfkD7F9aHEbaCNNtjuGbNEQc7wCxpyT1Gyd2kGAire6iggHD5a
	TnXCacLrEaWqEENGPUrQUIbZQV2flvWfydcoOO+8567tOEE0BIQh40cLJZXTOFvPiHWgrfdGeSS
	ZEXuxgvPFtiJg32LyL/IsIB7FJUk=
X-Gm-Gg: ASbGncsesGNBNZkiGnKZtdieY2UxdXDaU23VV/9AHRLelrGnpMMKyszr2dvJZkAnko8
	5NySDSIcUsnRDAp/V2ZAe4tEolMxRWK2H927qPF26ryfpYd0qUohFWp8lZXHKZTc4Be7FNNd4np
	UYIV14s0nH
X-Google-Smtp-Source: AGHT+IHP2RFtRRFgPClAmeR5ehEd+2cm9UqNvHlbg+2L/TpXnPY8RInvpcCNChJWYqXNBEYE3uOLKncWh/I2IMVw2Mw=
X-Received: by 2002:a05:6512:3da2:b0:545:fad:a757 with SMTP id
 2adb3069b0e04-54838ef8a13mr4353079e87.29.1740416274400; Mon, 24 Feb 2025
 08:57:54 -0800 (PST)
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
 <4cb1d98b-f94b-410a-be90-4394c48bdbf2@proton.me> <CAFJgqgQ3P81-iskGu9R+T=c=wyB2K0JqUhx+Gj+6mkYeY8-ORg@mail.gmail.com>
 <a4b79751-f1c8-4476-98a5-c59fb2e545ad@proton.me>
In-Reply-To: <a4b79751-f1c8-4476-98a5-c59fb2e545ad@proton.me>
From: Ventura Jack <venturajack85@gmail.com>
Date: Mon, 24 Feb 2025 09:57:41 -0700
X-Gm-Features: AWEUYZlW-Dr9Wj_nVWLIHYCRytgyFrZfCz9iJ9M6YRwrculG79d-CGIFN3fd43o
Message-ID: <CAFJgqgRdiQ29bWvwsu11yokZb4OFF7pYYUU=ES6CYv9847KgVg@mail.gmail.com>
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

On Mon, Feb 24, 2025 at 5:47=E2=80=AFAM Benno Lossin <benno.lossin@proton.m=
e> wrote:
>
> On 24.02.25 13:21, Ventura Jack wrote:
> >
> > From what I can see in the documentation, `&UnsafeCell<T>` also does no=
t
> > behave like `T*` in C. In C, especially if "strict aliasing" is turned
> > off in the
> > compiler, `T*` does not have aliasing requirements. You can have multip=
le
> > C `T*` pointers pointing to the same object, and mutate the same object=
.
>
> This is true for `&UnsafeCell<T>`. You can have multiple of those and
> mutate the same value via only shared references. Note that
> `UnsafeCell<T>` is `!Sync`, so it cannot be shared across threads, so
> all of those shared references have to be on the same thread. (there is
> the `SyncUnsafeCell<T>` type that is `Sync`, so it does allow for
> across-thread mutations, but that is much more of a footgun, since you
> still have to synchronize the writes/reads)
>
> > The documentation for `UnsafeCell` conversely spends a lot of space
> > discussing invariants and aliasing requirements.
>
> Yes, since normally in Rust, you can either have exactly one mutable
> reference, or several shared references (which cannot be used to mutate
> a value). `UnsafeCell<T>` is essentially a low-level primitive that can
> only be used with `unsafe` to build for example a mutex.
>
> > I do not understand why you claim:
> >
> >     "`&UnsafeCell<T>` behaves like `T*` in C,"
> >
> > That statement is false as far as I can figure out, though I have taken=
 it
> > out of context here.
>
> Not sure how you arrived at that conclusion, the following code is legal
> and sound Rust:
>
>     let val =3D UnsafeCell::new(42);
>     let x =3D &val;
>     let y =3D &val;
>     unsafe {
>         *x.get() =3D 0;
>         *y.get() =3D 42;
>         *x.get() =3D 24;
>     }
>
> You can't do this with `&mut i32`.

I think I see what you mean. The specific Rust "const reference"
`&UnsafeCell<T>` sort of behaves like C `T*`. But you have to get a
Rust "mutable raw pointer" `*mut T` when working with it using
`UnsafeCell::get()`. And you have to be careful with lifetimes if you
do any casts or share it or certain other things. And to dereference a
Rust "mutable raw pointer", you must use unsafe Rust. And you have to
understand aliasing.

One example I tested against MIRI:

    use std::cell::UnsafeCell;

    fn main() {

        let val: UnsafeCell<i32> =3D UnsafeCell::new(42);
        let x: & UnsafeCell<i32> =3D &val;
        let y: & UnsafeCell<i32> =3D &val;

        unsafe {

            // UB.
            //let pz: & i32 =3D & *val.get();

            // UB.
            //let pz: &mut i32 =3D &mut *val.get();

            // Okay.
            //let pz: *const i32 =3D &raw const *val.get();

            // Okay.
            let pz: *mut i32 =3D &raw mut *val.get();

            let px: *mut i32 =3D x.get();
            let py: *mut i32 =3D y.get();

            *px =3D 0;
            *py +=3D 42;
            *px +=3D 24;

            println!("x, y, z: {}, {}, {}", *px, *py, *pz);
        }
    }

It makes sense that the Rust "raw pointers" `*const i32` and `*mut
i32` are fine here, and that taking Rust "references" `& i32` and
`&mut i32` causes UB, since Rust "references" have aliasing rules that
must be followed.

Best, VJ.

