Return-Path: <linux-kernel+bounces-177723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51CC08C43B4
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 17:06:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 831071C2166C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 15:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1004F539C;
	Mon, 13 May 2024 15:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A88V33pD"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0C84C74;
	Mon, 13 May 2024 15:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715612778; cv=none; b=LB1QVfKECiX/QKkfhXsM16/VgplOfgHVfry5S3aF9bdJiLisL9mOCwwYwFD6M2PmNv2XwcdRXiidelqvswqYcNgMGgEOKAVJkaSCdLuMpLX0wJBp+ee/7noqAN60EDTXaDuoAtd/mEhE371SGYZAXy5J3ew5X+Wkp/VlBJnDi5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715612778; c=relaxed/simple;
	bh=7g8daoEXZt8k98DEDlWw6v5vJ/eC5CX6uFPQnLRqmnY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GDqmIPZTX9la83nEyRw3RWw4YczCbOR/L+fyhvI5ifKQegoCobkavzXFxz+cEgNZls0Ca+0pBWZ/p/9YwVtYCjArtVV7OrZjeUuRa+5Uj8bl8C5qoaCQyPlIZJ7jNxUF/yaz3fwp+FsAihyuYn/cEZeUFKkVAxTTEUkbaYtWdvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A88V33pD; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2b273cbbdfdso3533051a91.1;
        Mon, 13 May 2024 08:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715612776; x=1716217576; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yDMMOA9r4bNDAc4sPBmQOSV1c0DXlj0XJCl8jYHs2j0=;
        b=A88V33pDZPpAhNJZDvCZlx5rc5g5rp+XBgMprV6JcPvRsTau9dI5yd48eykqSAu9hq
         iCw9lVDURR4W2Gb+KpeTQFMBtGcyX7GGHZO55XkRkNOvlm+YE8ip2IueBR7lD/2yxonl
         +9pb2zIrXDyqCFT6uHdPs3xhlbchEzf0sMqK1F+rklQ0MdDQV++45XvZqEsCKqXGXai9
         uo96Gsws8em7A1mx1RP4EjPL2l3RlgXGqRZZ2nOrU61yusmH9PXUirjf6UIWzl6qme4c
         HdV92s8upm4FP4PQuv0dBmkiBOlhTktUANIDpG3R8Xqg/8F+YuT3hRZojMSQuBmiB4Dg
         u0aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715612776; x=1716217576;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yDMMOA9r4bNDAc4sPBmQOSV1c0DXlj0XJCl8jYHs2j0=;
        b=Gj9fRcfqa9nna5j/mdcCo/7TmbteZcQnr8Jb5Eahr4btgSypxDc3Ggrj/8kxeMtR+J
         Xqr4G2vYb1vhJv1GtQURxezSY33xae76PssVBwvV18xNkGnTJRnOwS/gdXGQkSxSGp1A
         S7msNUq0YrJFiTqGu4giBYXoru4E2iGV6e8t+V7J8DhADOJZyP/WhSpgYm/vhchk9vmS
         M1uX2aZhW8HgxVvvU54XRPIBwcXnFO1zyqsdtg0350hd2Fj2WEgVVK90CMCRa89I6Fkh
         QPZrcFPCJCSRTp9ZkRFoXlFenH0aQllLGRsrSRVoX73d6WLjvgODw/DNcxCwviGu1T57
         D+Ww==
X-Forwarded-Encrypted: i=1; AJvYcCX5LKaVSnfwMU5Q6m8Sfawqxq2U8K+2v4zS6dQnoajfln5uJIWPQDfITvvTNUfJB7mdt8GEGwUxhs0C1ealNEwqRog+s7oYaFwtXNc4sZwpNHAhZkUP2QcpeoXVTvi9oy1EMYXLJs5774Moq2k=
X-Gm-Message-State: AOJu0YwXTjWZc+07tVdbc736DzCT8CinZF2FoZ+txnSyDfOJdXhwJU5L
	IdfyQ7ohav2t/+sZoVw4ihXStACejo06GiRwZgwxs+q5lLA6ToAD80kb1IIti0NeA0nqFE0hShO
	uqbp8eiwC98id8eDgbb/HXCbWJbM=
X-Google-Smtp-Source: AGHT+IHzCdww7ddjWBV+QCpI/YhQysJ5Rsmtsa1JlVcvlh3EXdR/MMP4mVEjJOc/jyz0IpmKLMqEKruJtuS/tyxoC9g=
X-Received: by 2002:a17:90b:3808:b0:2a2:399f:60e7 with SMTP id
 98e67ed59e1d1-2b853c55c38mr6554334a91.23.1715612776431; Mon, 13 May 2024
 08:06:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Zigj-lY5lnBSKuib@boqun-archlinux> <87cypvnpwn.ffs@tglx>
In-Reply-To: <87cypvnpwn.ffs@tglx>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 13 May 2024 17:04:43 +0200
Message-ID: <CANiq72nGHhgRjfMOhz=ss51q2egHYexPMVvWTr0RES9WAmMF=A@mail.gmail.com>
Subject: Re: [PATCH 2/2] rust: time: Use wrapping_sub() for Ktime::sub()
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
	John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Gary Guo <gary@garyguo.net>, 
	bjorn3_gh@protonmail.com, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Kees Cook <keescook@chromium.org>, Mara Bos <m-ou.se@m-ou.se>, 
	"Amanieu d'Antras" <amanieu@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 9, 2024 at 2:14=E2=80=AFPM Thomas Gleixner <tglx@linutronix.de>=
 wrote:
>
> In principle ktime_sub() should not overflow for regular use cases.
>
> If the binder example overflows the substraction, then something is
> seriously wrong. Though in that case as it's only for debug purposes
> panicing would be totally counter productive. A warning might be
> appropriate though.

Thanks for the clarification Thomas.

Alice and I pinged about this in the RustNL Unconf, i.e. about having
a way to customize what happens on integer overflow (and, in general,
other panics too), which I had in:

    https://github.com/Rust-for-Linux/linux/issues/354

e.g. like UBSan that allows a "report and continue" option.

We chatted with Mara and Amanieu, who were receptive. In particular,
Mara posted right away:

    https://github.com/rust-lang/rfcs/pull/3632

as a possible first step to eventually have that ability, mentioning
Rust for Linux as a user.

If we get the ability to customize those, then this could simply be a
normal arithmetic operation, i.e. like any other. That is, considered
to be a bug if it overflows.

Meanwhile, one alternative is going with Boqun's approach, but I would
just use the standard operator (i.e. what we do elsewhere) and try to
get the customization happen as soon as possible since we will need it
for everything else (plus we avoid to make the code uglier with
changes that we will need to revert anyway; and it also allows us to
easily test any new customization feature from the compiler/library).

Cheers,
Miguel

