Return-Path: <linux-kernel+bounces-543711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A568A4D8E5
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 10:42:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51F20173ADA
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 09:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38ACE1FCFE3;
	Tue,  4 Mar 2025 09:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mv2yid4H"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB9E1FCCF9;
	Tue,  4 Mar 2025 09:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741081085; cv=none; b=ffU7H35Xxh4hLQ8miQ/qmKK7DOTj0eOund5ZoidXIzdjD2Xy7AJxtsntSsdJsNOeqVdH8d5NZIZFOpfYDHAop7HMMZzDNnvZwp3eSQLQ8UUpe4/JaEFdyO8zjsqojvbe0qdNuJKNkNxRilbNKuDkrU/SPlE1Y+nMoTru+LbpPH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741081085; c=relaxed/simple;
	bh=LZDM2xAdf8eJxQzX+hEwCpxB5UmW0nbXtrqKHsDEjI4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PLimxkvVMCGbQZMn2k3o2D563EjAUZ6cXoWfiw05pLDa8nrxlh2ktFgFWOfU2DfiUa1h2V3t0Hg2p1O/VC5pS2z3ok6WG2Pms2YGfMi90/+mQ5MMj7EQJIK+anPqMH0qGOkKRWkAEgGjsqKhGXO753hHQ2w7jyhFd719gTq8HhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mv2yid4H; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2f74e6c6cbcso1570583a91.2;
        Tue, 04 Mar 2025 01:38:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741081083; x=1741685883; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fw0u9DHNsaXRy0ckcD1EnqQyVRFqJOyZfyZRJh2W6bE=;
        b=Mv2yid4HwoxYK2vC+6fcq4KMWlBai00eRgIqYrjOzmQZvdAVvDGC0A1viz/SpqTCIx
         Zq78rNXS0nrzwkBYu61rJ9yaO8KC7BnVd83igWmR6tYxJgYGFr/cNLC66SHIGeWIEmUJ
         Nc5IfRGZVUesEFH90L9/uOJ0gauIkJAG4XjJwrcw2LRYaKWngXr+Ul0oEL134vr+eqxP
         /EN94OBHrZRLmgGZCFAALmSFBqoe6bXsgDgS++E5OfxOP2UWosTpF2O30nx+BdfZDApg
         rDzXfWukPGk2gDxkVBzBJ5ldINeFyNTCKUOiC0Zt57meDA/Y79nSPSEhSsiEA4/sCc8J
         Zh5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741081083; x=1741685883;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fw0u9DHNsaXRy0ckcD1EnqQyVRFqJOyZfyZRJh2W6bE=;
        b=vnQUBUB5B3oYJLCqVfSY+AzbxrVwPcciPTNm+7YYJ4rUSo2inIUk1zXo5BNlJQOAM7
         fJiAY8w/155m/FB5NkyxDbWJVCZTbn+WnGp/hcrbY6cL+jQafmK/65U2gBbBu7oRE/GP
         kTYfJgNlCe4206UnBOCUGxwCazmtkGtLlCc6D52uWDBAlFVplQogp6s0xZDWMTYjN4Ee
         uxKmmx4l25t/RPCDTsgq2M4AikCHS6UfjOhKMS6j+z7aWK64JFhxFfGvnmSdNRrSMAZw
         c2zxwOksUZ99gXLVUDetuTYR1CB9W606iFLOBM1H2gY59bYClsQ67gv3kP5yq3C33Pm0
         MKFQ==
X-Forwarded-Encrypted: i=1; AJvYcCUuhItoBnlKbSa8nu2HqE7bAEa3t2bucx2Jev9hyEBAhoUaEAnLBNCrWduwXFJ6TaYyEwV7mzQ0F/cBnT7KCg8=@vger.kernel.org, AJvYcCWohkwoH7ONe9LnlAOWqmdVrXcY+kEaACfoo1wQVgAZy0Zr5rstmqf7RrjCV44fyX/mqfcb5hUcN4E=@vger.kernel.org, AJvYcCXKikmF2KOQRsHT90uicHhf7JEiUfjGRegmqWvgUPowzQmRq1WmQknrsl9kKWABdC5mmWlHbgm8UfBJ0ghj@vger.kernel.org
X-Gm-Message-State: AOJu0YxDkDwifJYcojxUVPY5J3+CKbpTFJmrpknPyRodOC3eW8KJSJpt
	7DdlN5wiCNjYOk6UCRTGfwqfVsvJEdflJLPIRnmwFSpLZx0QLwmqFO51Fkmexy9AQ90xlVDOIZk
	C8WUWI4ozgKPdEb2BZbbA3ItEhOE=
X-Gm-Gg: ASbGncuoXmiwUyp3R0L+YmODvgyjlzbU0F9dXdRWi71hqrY8+1NS+UlQBX3OMW1k4ul
	9h2cuE2Zx6cPG+zr/ftjMJc2TkjTY3F7cZmdmeDaFCF8Pd8xWFA2Pr/rst4HW3gBye1MBq1GWxl
	BF1EPMnw8MB/4YcSjSLCFkV3jsHQ==
X-Google-Smtp-Source: AGHT+IH7Bt4TfFrukBmJaN9iZdzw8qUaCn0ZZrPGUaEOJ6zpYbPCR7KXCMN07QqTGVg/55EKEonT4z00pMvEFKFCBvI=
X-Received: by 2002:a17:90b:2251:b0:2fb:f9de:9497 with SMTP id
 98e67ed59e1d1-2febabf4096mr10283180a91.5.1741081083151; Tue, 04 Mar 2025
 01:38:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1740995194.git.viresh.kumar@linaro.org> <023e3061cc164087b9079a9f6cb7e9fbf286794e.1740995194.git.viresh.kumar@linaro.org>
 <CANiq72kdWzFOZ39EoFNxEAbk4KYgzLi1OAEc1zn8BM07VpXy3g@mail.gmail.com> <20250304085351.inrvjgixvxla4yn3@vireshk-i7>
In-Reply-To: <20250304085351.inrvjgixvxla4yn3@vireshk-i7>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 4 Mar 2025 10:37:50 +0100
X-Gm-Features: AQ5f1JophVTgEU33y5Gpj9LnEQeCoGu_PJHR12L4h3Bfq4OIOIBgLsVVTzFMGiA
Message-ID: <CANiq72=sU1sHvamC5REFPEC1aOVdZw9EKdxOgkUYESTR2yh3iQ@mail.gmail.com>
Subject: Re: [PATCH V3 2/2] rust: Add initial clk abstractions
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Russell King <linux@armlinux.org.uk>, linux-clk@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	Vincent Guittot <vincent.guittot@linaro.org>, Daniel Almeida <daniel.almeida@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 4, 2025 at 9:53=E2=80=AFAM Viresh Kumar <viresh.kumar@linaro.or=
g> wrote:
>
> I have tried some improvements based on your (and Alice's comments), plea=
se see
> if it looks any better now.

That looks much, much better, thanks!

> +/// Frequency unit.
> +#[derive(Copy, Clone, PartialEq, Eq, Debug)]
> +pub struct Hertz(c_ulong);

Please add a quick example for this one, e.g. constructing it and
comparing the value with an `assert_eq!` and another line comparing
two different `Hertz` objects for instance. After all, this one we can
even run it easily!

> +/// This structure represents the Rust abstraction for a C [`struct clk`=
].

Nit: the usual style is e.g.:

    /// An instance of a PHY device.
    ///
    /// Wraps the kernel's [`struct phy_device`].

i.e. the first line does not need to say "This structure" ... "Rust
abstraction" etc.

> +/// Instances of this type are reference-counted. Calling `get` ensures =
that the allocation remains

Please use intra-doc links (also for `OptionalClk` etc.).

> +/// ## Example

Nit: plural (even if there is a single example).

> +///     clk.disable_unprepare();

Looking at the example, a question that one may have is: should we
have something like a scope guard or a closure-passing API for this,
or does it not make sense in general?

> +    /// Enable the clock.
> +    #[inline]
> +    pub fn enable(&self) -> Result {

Should the users of these methods consult the C API side for the
comments/docs? e.g. should they read
https://docs.kernel.org/driver-api/clk.html#locking?

If so, please at least provide a link to the C API or the relevant
docs. e.g. https://docs.kernel.org/core-api/kernel-api.html#c.clk_enable.
Otherwise, if there is something there that should be mentioned here
directly, please do so.

In other words, in general, the goal is that you can find everything
you need in the Rust docs, even if those docs may sometimes rely on a
link there to the C side or a Doc/ document to avoid duplication. But
the information or the way to find that information should be there,
if that makes sense.

> +        // SAFETY: It is safe to call clk APIs of the C code for a clock=
 pointer earlier returned
> +        // by `clk_get()`.

We should probably say why we know that, i.e. due to the invariant,
unless I am missing something.

By the way, in the constructor, you should add/use an `// INVARIANT:`
comment (please grep to see how others do it).

> +///     let expected_rate =3D Hertz::new(1_000_000_000);

Would it be useful for users to have constructors for a few SI
prefixes, e.g. `Hertz::from_giga`? I see some big constants used for
e.g. `set_rate` in the C side, so I guess it could.

On top of that, would any other kind of operation make sense? For
instance, `.inverse()` to/from time or things like that -- we don't
need to do any of this now, of course, but it may be worth taking a
minute to investigate how we could improve the type now that we have
it.

Thanks!

Cheers,
Miguel

