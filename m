Return-Path: <linux-kernel+bounces-299935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BAA3495DC70
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 09:25:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4592AB21B1B
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 07:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD8D7154BE9;
	Sat, 24 Aug 2024 07:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="ks+hFJNL"
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D8F149DF0
	for <linux-kernel@vger.kernel.org>; Sat, 24 Aug 2024 07:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724484306; cv=none; b=cfy4iYeOL9EyU12a651KcINGKb3/xGrVj2X4s//fyYfm3CjbQB8JSvdIkeX1dbeAMCIV9Q8RZNij5fjCO4e52BDs4A8ggiouZRsaEdNx/0daH8ALPN3U3M8DYNUqSgOT9NL+jKaRXZ6rFIgO3hdVtkT1KE3G0oXTXyCIpcUiQDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724484306; c=relaxed/simple;
	bh=g6xKvcThqp7cNcb49IH7d8Zjo3rGrlE8E1s03ZsRXRk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RuQJ/QRiw4i5mvlBpgQHX25CzBN/tP3bfbBbAwttMKoMI6TYTS2P/kJhqRIr1mjv40PPHb7Ts1o5l22IMDo9g0O2yO5AJe8CV0u92lKYimazFemdmDaygnVB7JNj0CjLjZ9oG5sSSzdkgYxtvRV2trPgHCnuwFOTxNSdmXZ7Pmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=umich.edu; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=ks+hFJNL; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=umich.edu
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6c49c9018ebso21142787b3.3
        for <linux-kernel@vger.kernel.org>; Sat, 24 Aug 2024 00:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1724484302; x=1725089102; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q6+A2VuRa3vINzgOnqqBfzLTYjWfMi7SqqtjGQfCE/k=;
        b=ks+hFJNLofwzsobn9TTYFw2gv5rAS3vQxO3b+A8iAK7NGdFj7AUwBHLP/E4yCmxADZ
         RY46MpzI/fB6iQ3eu4l6YCmDnfmxq/qqehSwyBMpwQbnjuldxdEoqZW7QzGMVkrkjgSy
         5x11LvGkzpYCowgCyrlGl1aNI0naFgXr7GQ5UtVCFuUu1x3jwPa55RKG222dn733RPIn
         wl4Wozpl0pCn4Za8GngqgF+tZX5Cbjgd3IhP7IcjnpKV2lAzjFaoaGuQMIL+Sv5b2YMZ
         okJupbJfq0aZlDRaRzdCaPDWec+sEYfylPvKxPRFMFlKugnMXj1vG/hvZbYZ8t6QVx3v
         utSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724484302; x=1725089102;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q6+A2VuRa3vINzgOnqqBfzLTYjWfMi7SqqtjGQfCE/k=;
        b=WrlFCD904dmmu4F55iMyjRXoVAHHYhX19Xo8jugA0LkV/EQNXiPeFMrX9fweDjS23h
         6Hz5n4JE/ByLXz7shGDjHs2I12jHMW5CKjRqfnWUWFC9jMDPLVAVxCYANOzKNOf3SCy4
         RiHukKv/xy/Nc6njTzhePLpAe01g4ICF9dSDCFAXd78+zq2jpCOjvpsrg8W36yaSLpcR
         CVJfI4rLkA3nYmMvWVRMnm3LZatbd3MRYVH7YD5PAHghLgKr5U6rUeWhqhC4V6qGSwP6
         ZvHu4UNPaT36373pI8gLWLsjNzDY4NZ/UciMWuryRu1eSza/fjhe3DpyAA1u1oWPW4nD
         Rigg==
X-Forwarded-Encrypted: i=1; AJvYcCVLJtinV7fpSdBXTPlnfeoAI13RcdhX8ZDeQ9UZxcqLWSxyCEOXGSpRqPV5X6b0PJZX8NGhFgdWsnFQLro=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5BL4800n3nY6NAwoF7b4L2axj8t7vU5c1z5q2vbnplWKkT4ZJ
	EUum7EHjoviYT6/tNRIGiHccm9I9FXWB4qeYq/2CrQhNc4RcI2ZLUppOskYP22Wzq+zMEMhnEkx
	Gh5N6oySAH7RDnjBotX3IWrVEPsPkd8tF/Ly4XQ==
X-Google-Smtp-Source: AGHT+IG1BlHDuekV5AcLsj47uYwHvnVdzGRFSDLUmEl/F7Nsu+5/w5qTxjhDCMbQGyjdd5802kibXL0vaoVv13Foy4o=
X-Received: by 2002:a05:690c:6606:b0:61b:1e81:4eb8 with SMTP id
 00721157ae682-6c62538d6f6mr67130637b3.9.1724484302011; Sat, 24 Aug 2024
 00:25:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240819153656.28807-2-vadorovsky@protonmail.com> <36272d4a-eb95-4842-b171-ad6ec39a7631@gmail.com>
In-Reply-To: <36272d4a-eb95-4842-b171-ad6ec39a7631@gmail.com>
From: Trevor Gross <tmgross@umich.edu>
Date: Sat, 24 Aug 2024 02:24:50 -0500
Message-ID: <CALNs47uKWTH9mUhEp1-f=zX8fgPpWExQWct0YYa2Q9H6yuaKJA@mail.gmail.com>
Subject: Re: [PATCH RESEND v5] rust: str: Use `core::CStr`, remove the custom
 `CStr` implementation
To: Michal Rostecki <vadorovsky@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, Brendan Higgins <brendan.higgins@linux.dev>, 
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, 
	FUJITA Tomonori <fujita.tomonori@gmail.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Martin Rodriguez Reboredo <yakoyoku@gmail.com>, 
	Finn Behrens <me@kloenk.dev>, Manmohan Shukla <manmshuk@gmail.com>, 
	Valentin Obst <kernel@valentinobst.de>, Yutaro Ohno <yutaro.ono.418@gmail.com>, 
	Asahi Lina <lina@asahilina.net>, Danilo Krummrich <dakr@redhat.com>, Tiago Lam <tiagolam@gmail.com>, 
	Charalampos Mitrodimas <charmitro@posteo.net>, Tejun Heo <tj@kernel.org>, Roland Xu <mu001999@outlook.com>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	netdev@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 19, 2024 at 10:43=E2=80=AFAM Michal Rostecki <vadorovsky@gmail.=
com> wrote:
>
> On 8/19/24 17:36, Michal Rostecki wrote:
> > From: Michal Rostecki <vadorovsky@gmail.com>
> >
> > `CStr` became a part of `core` library in Rust 1.75. This change replac=
es
> > the custom `CStr` implementation with the one from `core`.

[ very long snip ]

> > @@ -180,7 +180,7 @@ macro_rules! assert {{
> >       #[allow(unused)]
> >       macro_rules! assert_eq {{
> >           ($left:expr, $right:expr $(,)?) =3D> {{{{
> > -            kernel::kunit_assert_eq!("{kunit_name}", "{real_path}", __=
DOCTEST_ANCHOR - {line}, $left, $right);
> > +            kernel::kunit_assert_eq!(c"{kunit_name}", c"{real_path}", =
__DOCTEST_ANCHOR - {line}, $left, $right);
> >           }}}}
> >       }}
> >
>
> I forgot to include the version history before sending the patch, sorry.

For future reference - when replying, you should delete irrelevant
bits of the message you are replying to, otherwise things get kind of
messy.

- Trevor

