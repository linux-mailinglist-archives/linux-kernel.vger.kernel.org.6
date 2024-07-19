Return-Path: <linux-kernel+bounces-257509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90614937AF4
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 18:28:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C1722811F3
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 16:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 756DB145FFB;
	Fri, 19 Jul 2024 16:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zm+Hod46"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C3FA2AF12;
	Fri, 19 Jul 2024 16:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721406500; cv=none; b=IjTq5o6n66ORRDP9pBOki1nT/v9ki1wXX+h1eJIeYMSX6Iahvwq5BArOg6w/TxMpr92LqHXd1GSpk/V4Lyc6wJzeYiRnMe8ngI1GnZkL4TS6Cp546pCLBHmOBIk75esN4Z9C4fNFItPRbFXTAORQw+jY+Kz7z11d8xeiJ7h8gdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721406500; c=relaxed/simple;
	bh=ex1rU7vF9CwFi1ojZJgaEL8x2pgCvZSEMkfjUO4d1ec=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=aKR3h6jANrgmo3YvuuDZlnfO7HwSgwObcNd2nO2cDsppF+LTr4mTgAWZwMZ8ZuPQp4BEvCLd39mNf1volSnm8Ie2WSawO4cmjQpH2Zl2wTtOzofpROLXE22ZGjp7VJ61Zhaq5PFGngtbtSIA6tgyNct1CHWPXOKMupqxeu3zWKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zm+Hod46; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-70af3d9169bso824432b3a.1;
        Fri, 19 Jul 2024 09:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721406498; x=1722011298; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mBxdc8htTVNTdgwXFOVSXYK26L43hc2ApkbvbhVjMfA=;
        b=Zm+Hod46+9ZIidrssItGSDC5rykorQhB4LDWZf6OaDg5gi1rfbJMi5dczR5gfJv3JO
         hxG3P/oDiQJoc7LZXyKYO2l6gvl7+2aN4aydLWVJ+rs2yR/DnkzgeWGutCwSz2EGGik/
         uLOdtQjvbF7ph3xe8rpOR+NnbUBgskxQJ/wK6+hXjgLn9E1CjTe9zuMjeHpa8hyvFWWW
         3ySQlIKllBbTpkM5K1WOdgAVVNLXkZd39z5F45aJCODegkcOL2vJ1S5D4x94suAuFvVs
         GMGpcVviXp3SXmdGp4RLy4QNc0NjVYK/XYoRHoRFv1+UFogFdlBit83cSd40GEdiPrGq
         LVbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721406498; x=1722011298;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mBxdc8htTVNTdgwXFOVSXYK26L43hc2ApkbvbhVjMfA=;
        b=cKB5Zf6yWjgA+TTRl5Mcj39cTjxKLU+bZuyZBWkaeyfuAyZLd3nBEpxICcnNUgJdAK
         pIMuf5aWsuXlJy4A11UiaaGW0fHgMw1cPY2Zuh6hATZG25WlTlpLPgf1htZnZO/RrSq4
         EXwvn49ZZn2XehhTs5AzYd+HVf636uLTW2uDp7y3gmnhwbDrHtKhnCSuXw1LzPwU6iyo
         mq/tK8jazO/Yd3dPl3C5H+zIyfcvy9SiTgBRvtcYK4ItKv9SkP/vBjluOfMxDIQwv0YD
         ZSmM0GAioT5S/miQ8sf8BCL/s5OnW7KSQa0IzIiLDogO3y4A11OI5zGgrwhdci6GEC9I
         QfyQ==
X-Forwarded-Encrypted: i=1; AJvYcCWIvcqX/NnGdqP/0Dw/2x+4eOAVWDHnoPqu5U/eyczpdUNZPekrjv28AKpKoIpgfTL+NMNJLoxGTn97ZKDx/KNHOHsVO+7OAR2pKrgAjdwFZX+vuHohklnOM9WBJqVG0pItad3rNuJNKigAZ21SGR4Xi8CbrpBDYxtaEhHXlqKaHW1F/e4Q9EU=
X-Gm-Message-State: AOJu0YzXEWEB8E/XVw5/lHFygxH+K/d0YIsNJaRTFj89aXj1QrMHJONj
	a+wWzjT0thKXmfH4qheBul0Fo01v3Fx29I88kK1gfC3nrLxzr+9F
X-Google-Smtp-Source: AGHT+IFPbEeCxCkDDDmHRTe46oZyTKacN+m1a4EVDNJ8zRsbZmcUO5ydpSycRE43Wxng9n1rdrSPSg==
X-Received: by 2002:a05:6a20:1595:b0:1c3:b102:bdfb with SMTP id adf61e73a8af0-1c42299ec6cmr583123637.43.1721406497939;
        Fri, 19 Jul 2024 09:28:17 -0700 (PDT)
Received: from smtpclient.apple ([2804:431:c7e4:b76c:70bb:7589:2029:7c05])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cb772c2160sm3069852a91.8.2024.07.19.09.28.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Jul 2024 09:28:17 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.600.62\))
Subject: Re: [RFC PATCH 2/5] doc: rust: safety standard: add examples
From: Daniel Almeida <dwlsalmeida@gmail.com>
In-Reply-To: <20240717221133.459589-3-benno.lossin@proton.me>
Date: Fri, 19 Jul 2024 13:28:02 -0300
Cc: Jonathan Corbet <corbet@lwn.net>,
 Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>,
 Wedson Almeida Filho <wedsonaf@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Andreas Hindborg <a.hindborg@samsung.com>,
 Alice Ryhl <aliceryhl@google.com>,
 linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <FD292228-0AA1-465C-B373-E982F612FA27@gmail.com>
References: <20240717221133.459589-1-benno.lossin@proton.me>
 <20240717221133.459589-3-benno.lossin@proton.me>
To: Benno Lossin <benno.lossin@proton.me>
X-Mailer: Apple Mail (2.3774.600.62)

Hi Benno,

> On 17 Jul 2024, at 19:12, Benno Lossin <benno.lossin@proton.me> wrote:
>=20
> Add examples of good and bad safety documentation.
>=20
> There aren't many examples at the moment, as I hope to add more during
> discussions, since coming up with examples on my own is very =
difficult.
>=20
> Signed-off-by: Benno Lossin <benno.lossin@proton.me>
> ---
> .../rust/safety-standard/examples.rst         | 70 +++++++++++++++++++
> Documentation/rust/safety-standard/index.rst  | 23 ++++--
> 2 files changed, 86 insertions(+), 7 deletions(-)
> create mode 100644 Documentation/rust/safety-standard/examples.rst
>=20
> diff --git a/Documentation/rust/safety-standard/examples.rst =
b/Documentation/rust/safety-standard/examples.rst
> new file mode 100644
> index 000000000000..d66ef3f8954a
> --- /dev/null
> +++ b/Documentation/rust/safety-standard/examples.rst
> @@ -0,0 +1,70 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +.. highlight:: rust
> +
> +Examples
> +=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Unsound APIs
> +------------
> +
> +Simple Unsound Function
> +***********************
> +::
> +
> +    struct Data {
> +        a: usize,
> +    }
> +
> +    fn access_a(data: *mut Data) -> usize {
> +        unsafe { (*data).a }
> +    }
> +
> +One would normally call this function as follows, which does not =
trigger UB::
> +
> +    fn main() {
> +        let mut d =3D Data { a: 42 };
> +        println!("{}", access_a(&mut d));
> +    }
> +
> +However, a caller could also call it like this, which triggers UB =
using only safe code::
> +
> +    fn main() {
> +        println!("{}", access_a(core::ptr::null_mut()));
> +    }
> +
> +And this would result in a dereference of a null pointer.
> +
> +
> +Sound ``unsafe`` Code
> +---------------------
> +
> +The Importance of the API Boundary
> +**********************************
> +
> +Is the following API sound?::
> +
> +    fn foo(r: &mut u32) {
> +        let ptr: *mut u32 =3D r;
> +        let val;
> +        unsafe {
> +            val =3D *ptr;
> +            *ptr =3D 0;
> +        }
> +    }
> +
> +It better be sound, but one could argue that it is unsound, since one =
could replace the ptr
> +initialization by ``ptr =3D core::ptr::null_mut()``::
> +
> +    fn foo(r: &mut u32) {
> +        let ptr: *mut u32 =3D core::ptr::null_mut();
> +        let val;
> +        unsafe {
> +            val =3D *ptr;
> +            *ptr =3D 0;
> +        }
> +    }
> +
> +But this modification is not allowed, since it goes beyond the API =
boundary of ``foo``. This way
> +any ``unsafe`` code that relies on surrounding safe code could be =
shown to be unsound. Instead one
> +should only consider safe code using the API, in this case, there is =
no way to make the code
> +incorrect, since a reference is always valid to dereference during =
its lifetime.

I find this paragraph a bit confusing. Maybe this can be clarified a bit =
further?

> diff --git a/Documentation/rust/safety-standard/index.rst =
b/Documentation/rust/safety-standard/index.rst
> index 1cbc8d3dea04..bebebda06831 100644
> --- a/Documentation/rust/safety-standard/index.rst
> +++ b/Documentation/rust/safety-standard/index.rst
> @@ -92,21 +92,28 @@ And this would result in a dereference of a null =
pointer.
> In its essence, a sound API means that if someone only writes safe =
code, they can never encounter UB
> even if they call safe code that calls ``unsafe`` code behind the =
scenes.
>=20
> +For more examples of unsound code see examples.rst.
> +
> Because unsoundness issues have the potential for allowing safe code =
to experience UB, they are
> -treated similarly to actual bugs with UB. Their fixes should also be =
included in the  stable tree.
> +treated similarly to real UB. Their fixes should also be included in =
the stable tree.
>=20
> Safety Documentation
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> -After trying to minimize and remove as much ``unsafe`` code as =
possible, there still is some left.
> -This is because some things are just not possible in only safe code. =
This last part of ``unsafe``
> -code must still be correct. Helping with that is the safety =
documentation: it meticulously documents
> -the various requirements and justifications for every line of =
``unsafe`` code. That way it can be
> -ensured that all ``unsafe`` code is sound without anyone needing to =
know the whole kernel at once.
> +No matter how hard one tries to remove ``unsafe`` code, it is =
impossible to completely get rid of it
> +in the Kernel. There are things that are impossible for safe code. =
For example interacting with the
> +C side. So one can never be completely sure that there are no memory =
issues lurking somewhere.
> +
> +This is where safety documentation helps: it meticulously documents =
the various requirements and
> +justifications for every line of ``unsafe`` code. That way the risk =
of writing unsound ``unsafe``
> +code is reduced drastically.
> +
> The gist of the idea is this: every ``unsafe`` operation documents its =
requirements and every
> location that uses an ``unsafe`` operation documents for every =
requirement a justification why they
> are fulfilled. If now all requirements and justifications are correct, =
then there can only be sound
> -``unsafe`` code.
> +``unsafe`` code. Reducing the global problem of correctness of the =
whole kernel to the correctness
> +of each and every ``unsafe`` code block makes it a local problem. =
Local problems are a lot easier to
> +handle, since each instance can be fixed/reviewed independently.
>=20
> The ``unsafe`` keywords has two different meanings depending on the =
context it is used in:
>=20
> @@ -238,6 +245,8 @@ Further Pages
> .. toctree::
>    :maxdepth: 1
>=20
> +   examples
> +
> .. only::  subproject and html
>=20
>    Indices
> --=20
> 2.45.1
>=20
>=20

=E2=80=94 Daniel


