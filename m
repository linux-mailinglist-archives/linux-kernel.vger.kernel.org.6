Return-Path: <linux-kernel+bounces-388296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 100399B5D57
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 09:05:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33C441C20EEC
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 08:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BDEA1E0DD2;
	Wed, 30 Oct 2024 08:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="w5rmvAdN"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 552871DE898
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 08:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730275498; cv=none; b=Sfs+X8Iymyzpiuhyhp3xC0+dKacbK/evApPSRch5HrnqfWos0RNb91RzJIz3JXKViDDsNy5Ew0yQguOfMYk77c/K8XA+4bXuQXkxCun+onKpR0Y19YkHZqFQ05FAFCHnvLd0dEPMt5pU8nNMkOE0g3UpTZlN+IGu3eeJ/isQVr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730275498; c=relaxed/simple;
	bh=uIeID8LPkVV7vbsIkbApKkA4nCAHOHCbaN4cEw6ZYcM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ed3aJ6PCOvlJPhoZmKNKKqY4JVyQyfZWsSyNAheTIs4J0MQToT9qD0eLGbLpAoX36OHNuBgNaMyELyAGf0Twbs4Ty06A+42lo4sg9lVqNaGufOVld3Vdex5RHL7pJTeohBJHrVqgn2nluCIF6prQTcqcPS5k7B7Qt9LLuidHtp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=w5rmvAdN; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-37d47eff9acso4513417f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 01:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730275495; x=1730880295; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=95RTSh8J+27qXgrorPD5Q3P6nvO44Dt8mII1tFtUkPY=;
        b=w5rmvAdNdopCxTt1EwoBkRJxap2Rvi5hc8hpBz+TVNPXpms6/xYc8uyniN2fCGIoPU
         5o8Y3hzSj8ZTrHV5nnljyXRcBlERs4vZIm1IRLeGvzFzI3tZDbl/ngvZKzsd+IDDGW2V
         oVtOowIiF1UkxI6cS2EqKYUYXl1UThhccC4W9YBQ6QTyamq3msGabmoTN4uDRfddBola
         ig54L8vc5dxbpQHwvVnTCIkau6lun4GmDYiT+eHEomrbLBsgO/gKwJUS8u1B5DOhiNyl
         yoXPTCngxEgPRgU2nkxA3536HtBicmlKhtNEiSc+0T9r/lEnrDGRurQGgod457FetsBw
         AGJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730275495; x=1730880295;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=95RTSh8J+27qXgrorPD5Q3P6nvO44Dt8mII1tFtUkPY=;
        b=a22ujOLvPqU+//6D2NTGmuJQkhEA3h3nAtUTFOOm9b7Dp9BKrMWpand/Jib0av4McZ
         35YYv3wAeN5EhtPS+UPQvY2mviekyybkHtHqNUNDjkT77Z70VkCHnm7Rr0SW4kacIrSy
         qUoqOzF8A1iszfu5GComCBhCTQO90GNHrR7OkvMcTLofIRbtv1etcQH2FLTyEmLccxN4
         fBjwfFFk2eFfzPLMfZYISVYu9JoONOBD1MgBjyg7e3/aNWk1vuF1Xqg6yd5YjV/4VyLY
         MvBap4Lk1C9Dl5W31+V5aSp5EEa0iNS/KcFvRdllGDrXubpc0x0HiqzrXm1+t5jXySY0
         6a9g==
X-Forwarded-Encrypted: i=1; AJvYcCUuGJzNrseP2cQv4E/AF2OIl6m6UGn03UpV1AB6XsME2gDRaMzUIKCqjW/cShEBOLnoKSZ7SGxPl+7XvYU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZpnWglc1QZrlQRx7FmZluveoHLvACf4K1xakaOp/4vcYHamuW
	3ln5yg1WHVhkCfcd7FEyHNxLUZVs5Vnw+RydeRsjtnJkeaAjGEd+f2v/JydQ1FrhdU3yt9QLzOs
	xbR8/oP1iuvZXeVubiUZxn5XqbRjdZ5PD9VKH
X-Google-Smtp-Source: AGHT+IEO8HFZjd7+VNFhebqwnkZwF6uDUNNFfey/mrUvUsK0aGS/SN5Vy+JcStW4TaK1VVchX5VbiY422M+f2Hi1rVs=
X-Received: by 2002:a5d:658c:0:b0:37d:46fa:d1d3 with SMTP id
 ffacd0b85a97d-3806119ac9emr10555574f8f.34.1730275494522; Wed, 30 Oct 2024
 01:04:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241029092422.2884505-1-davidgow@google.com> <20241029092422.2884505-2-davidgow@google.com>
 <CAH5fLghSJtxKPZczEzc30m=LrG_BX0JkxX+0tFQLhojsOEzogg@mail.gmail.com> <CABVgOS=tp1SiZeQYgDX2ET3twJ8-xCZTu8ofsWabjsQZQbyMCg@mail.gmail.com>
In-Reply-To: <CABVgOS=tp1SiZeQYgDX2ET3twJ8-xCZTu8ofsWabjsQZQbyMCg@mail.gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 30 Oct 2024 09:04:41 +0100
Message-ID: <CAH5fLggKDanVVYschS85mw_00vVnJ7SeJ9pKGYFrmmFh7iC4cg@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] rust: kunit: add KUnit case and suite macros
To: David Gow <davidgow@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, =?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>, 
	Brendan Higgins <brendan.higgins@linux.dev>, Rae Moar <rmoar@google.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Gary Guo <gary@garyguo.net>, Benno Lossin <benno.lossin@proton.me>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Matt Gilbride <mattgilbride@google.com>, kunit-dev@googlegroups.com, 
	linux-kselftest@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 30, 2024 at 5:59=E2=80=AFAM David Gow <davidgow@google.com> wro=
te:
>
> On Tue, 29 Oct 2024 at 20:08, Alice Ryhl <aliceryhl@google.com> wrote:
> >
> > On Tue, Oct 29, 2024 at 10:24=E2=80=AFAM David Gow <davidgow@google.com=
> wrote:
> > >
> > > From: Jos=C3=A9 Exp=C3=B3sito <jose.exposito89@gmail.com>
> > >
> > > Add a couple of Rust const functions and macros to allow to develop
> > > KUnit tests without relying on generated C code:
> > >
> > >  - The `kunit_unsafe_test_suite!` Rust macro is similar to the
> > >    `kunit_test_suite` C macro. It requires a NULL-terminated array of
> > >    test cases (see below).
> > >  - The `kunit_case` Rust function is similar to the `KUNIT_CASE` C ma=
cro.
> > >    It generates as case from the name and function.
> > >  - The `kunit_case_null` Rust function generates a NULL test case, wh=
ich
> > >    is to be used as delimiter in `kunit_test_suite!`.
> > >
> > > While these functions and macros can be used on their own, a future
> > > patch will introduce another macro to create KUnit tests using a
> > > user-space like syntax.
> > >
> > > Signed-off-by: Jos=C3=A9 Exp=C3=B3sito <jose.exposito89@gmail.com>
> > > Co-developed-by: Matt Gilbride <mattgilbride@google.com>
> > > Signed-off-by: Matt Gilbride <mattgilbride@google.com>
> > > Co-developed-by: David Gow <davidgow@google.com>
> > > Signed-off-by: David Gow <davidgow@google.com>
> > > ---
> > >
> > > Changes since v1:
> > > https://lore.kernel.org/lkml/20230720-rustbind-v1-1-c80db349e3b5@goog=
le.com/
> > > - Rebase on top of rust-next
> > > - As a result, KUnit attributes are new set. These are hardcoded to t=
he
> > >   defaults of "normal" speed and no module name.
> > > - Split the kunit_case!() macro into two const functions, kunit_case(=
)
> > >   and kunit_case_null() (for the NULL terminator).
> > >
> > > ---
> > >  rust/kernel/kunit.rs | 108 +++++++++++++++++++++++++++++++++++++++++=
++
> > >  rust/kernel/lib.rs   |   1 +
> > >  2 files changed, 109 insertions(+)
> > >
> > > diff --git a/rust/kernel/kunit.rs b/rust/kernel/kunit.rs
> > > index 824da0e9738a..fc2d259db458 100644
> > > --- a/rust/kernel/kunit.rs
> > > +++ b/rust/kernel/kunit.rs
> > > @@ -161,3 +161,111 @@ macro_rules! kunit_assert_eq {
> > >          $crate::kunit_assert!($name, $file, $diff, $left =3D=3D $rig=
ht);
> > >      }};
> > >  }
> > > +
> > > +/// Represents an individual test case.
> > > +///
> > > +/// The test case should have the signature
> > > +/// `unsafe extern "C" fn test_case(test: *mut crate::bindings::kuni=
t)`.
> > > +///
> > > +/// The `kunit_unsafe_test_suite!` macro expects a NULL-terminated l=
ist of test cases.
> > > +/// Use `kunit_case_null` to generate such a delimeter.
> > > +const fn kunit_case(name: &kernel::str::CStr, run_case: unsafe exter=
n "C" fn(*mut kernel::bindings::kunit)) -> kernel::bindings::kunit_case {
> >
> > This should probably say `name: &'static CStr` to require that the
> > name lives forever.
>
> Fixed in v3, thanks.
>
> > > +/// Registers a KUnit test suite.
> > > +///
> > > +/// # Safety
> > > +///
> > > +/// `test_cases` must be a NULL terminated array of test cases.
> > > +///
> > > +/// # Examples
> > > +///
> > > +/// ```ignore
> > > +/// unsafe extern "C" fn test_fn(_test: *mut crate::bindings::kunit)=
 {
> > > +///     let actual =3D 1 + 1;
> > > +///     let expected =3D 2;
> > > +///     assert_eq!(actual, expected);
> > > +/// }
> > > +///
> > > +/// static mut KUNIT_TEST_CASE: crate::bindings::kunit_case =3D crat=
e::kunit_case(name, test_fn);
> > > +/// static mut KUNIT_NULL_CASE: crate::bindings::kunit_case =3D crat=
e::kunit_case_null();
> > > +/// static mut KUNIT_TEST_CASES: &mut[crate::bindings::kunit_case] =
=3D unsafe {
> > > +///     &mut[KUNIT_TEST_CASE, KUNIT_NULL_CASE]
> > > +/// };
> > > +/// crate::kunit_unsafe_test_suite!(suite_name, KUNIT_TEST_CASES);
> > > +/// ```
> > > +#[macro_export]
> > > +macro_rules! kunit_unsafe_test_suite {
> > > +    ($name:ident, $test_cases:ident) =3D> {
> > > +        const _: () =3D {
> > > +            static KUNIT_TEST_SUITE_NAME: [i8; 256] =3D {
> > > +                let name_u8 =3D core::stringify!($name).as_bytes();
> > > +                let mut ret =3D [0; 256];
> > > +
> > > +                let mut i =3D 0;
> > > +                while i < name_u8.len() {
> > > +                    ret[i] =3D name_u8[i] as i8;
> > > +                    i +=3D 1;
> > > +                }
> >
> > I assume the name must be zero-terminated? If so, you probably need to
> > enforce that somehow, e.g. by failing if `name_u8` is longer than 255
> > bytes.
>
> Nice catch. I'm not sure how to nicely throw a compile time error in
> this function, so I'm truncating it here and doing a compile error in
> the macro in patch #2. This isn't ideal, but seems to work.

You should be able to just panic! if it happens.

Also, I believe it should be i < 255 instead of 256?

Alice

