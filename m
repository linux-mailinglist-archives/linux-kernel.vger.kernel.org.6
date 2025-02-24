Return-Path: <linux-kernel+bounces-529582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4976AA4282B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 17:43:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A1017A578C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 16:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DD04263C72;
	Mon, 24 Feb 2025 16:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="KaZJpRi9"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 188242561DD;
	Mon, 24 Feb 2025 16:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740415371; cv=none; b=spFTHHQ8PovUwnTk4SXnzLcLaPlF2wehOLm4LEuvRn89qHvcSHJ6KxkvJiAxOSrOKy4+sOTxpHe0xfq/XBOFgqzYpw/xyYVyrrIFokmcEtW8eOtfYhlV5/K1zqRXg7oe5NB95ExPKXAnmmoFtWqf1sr++9VPDhTMBnhkv0IQ5/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740415371; c=relaxed/simple;
	bh=pPtB5iBTpjPdvvBag0ikJrB3ubm7dMsqxX600w4wRLs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=seQ1XKOGS8YlX6T6hbz8OWBC3xO9qSpPNfsTe4G6gNHoQ399TPSrQ9uXeeedCeCQFE3kYAL3YStFwGDdc3DfEu8TbGJpw2osDp17c8hr4sRN0VwmER6zhC7ffLD8S5tz9Ds5xhEap4LGY4KvAC+jdqdaplhU11qJU1u6t6jf+ZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=KaZJpRi9; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4399d14334aso40704225e9.0;
        Mon, 24 Feb 2025 08:42:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1740415368; x=1741020168; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Lf+NqEZsMFJBEN4P7MtP2hG4hE4jH1JzYMV0SWzaCc=;
        b=KaZJpRi9vdfWG6VWXS12ei1F0PIwEQ645WR9EejhysMy2VDqlJtF3E2jVmL7DVVrJD
         AXy/iuY0l073l5Y5Zc+Wv1oIrT7KR5n20e92A4OBLyf06RQvPWS/MMFn57W0MTidmtut
         Y5WYmro57eOotfPbRupfTv5mkD1uhMusmJzgFQYHXtZwmO3IyFdzg6hGHgcCm2krCOcw
         8ddjjMVaUGUDc41GJ89qo7aYY9t936haqPTgTkkibzsytUnsci3zH125kYVS/26kQtL5
         IwFkGwVvhs7oonL9EFCR6mmTJFZEOarHDdlO4XHkRK5Xx7mw2OK88J4uhpPFy4MvzBR9
         pCtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740415368; x=1741020168;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0Lf+NqEZsMFJBEN4P7MtP2hG4hE4jH1JzYMV0SWzaCc=;
        b=DqOfj4JlVo2soH6Bsu1wpMw1C8r/1M0LdDojCQrpR87h23PnZVi5HtgZbfedJ4+dxS
         lekR6LmWQJxEmQDGTZ3Bl8vP3XzcH3uUV6b+SJNwry9yKVYz1HKCEULepPZMg3U2xD+f
         FWL9oDcd8mCNgk3j4virLIecpyyGwYw4C+LFlYPC43wCoAxuILrjmlr/LcbgdYpzxtlT
         lU4cxCzHrzpJIajuJK8d13dKXTsGVfrmzGTKW7G93hwug8hDSUxrpsI2iduFlzEX1KQa
         Hx7BX72AMrDy4e6wl2eJv90tw9sFofhMPMi54MDkFA/oMP9z2HXFPepeR0LiT7wI2LZD
         zmkw==
X-Forwarded-Encrypted: i=1; AJvYcCUy8QOq1z2HvndTIo2CuZx2IJHXjTJhmkQiTqucV1E1O9p+fleEIV63fgJ8zeA6yGg3fg2j1SjZhUOoZEo=@vger.kernel.org, AJvYcCXyIlJhD4Tbe22HAToK1NZ9nZkVVeqShFZXOoBSCccSjIiK+1LzLZorlEn1/FDzExivrkzr9a6U57DVzouthE8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxoo3nVveUUKHCb33yB0zX37vks36x8VhKoGAl92JEjW5yFWwEl
	s5bfxC5ruWRw8QbetnmU0ElgmUe7F9bjy3JgVAGfCnBgJ9325AbG06TnWztaWuTPsUDl0zm6nF0
	8MxOjGiC/22W8JJTiuSiLQ/USR3o=
X-Gm-Gg: ASbGncsGP+StUEWgMLVkOFQdEvf+As8L/U3t9JhODmEbd9wJx+ypnJlb7xSrE+MLEGS
	CGFy7hwUxCBwR0JJf56XMMOcWr3kaHEiSi5eexmO0WWMlXUt8bugM/pkQY+kT7JInOJqXcd5zwu
	BiZSB4cWU=
X-Google-Smtp-Source: AGHT+IH3gB4+t4ey8K9foQhFPpwmzLnBNia3/nkgoWIlj9aPcrWrDOKgmoNT1IpZOeCmBWbMuz+dZb9s8u6tQkQtXEU=
X-Received: by 2002:a5d:64e8:0:b0:38d:deb4:4ee8 with SMTP id
 ffacd0b85a97d-38f6f0587b2mr11976583f8f.28.1740415368087; Mon, 24 Feb 2025
 08:42:48 -0800 (PST)
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
 <20250224125805.GA5729@mit.edu> <CANiq72k-K3-Cbnm=0556sXAWs0kXBCB4oR67M4UtD=fq=kyp7A@mail.gmail.com>
 <CANiq72mfQk_ViHJ9Y_rU0etS8XpORvZUNMc5m2iHL=pQDiVFSg@mail.gmail.com>
In-Reply-To: <CANiq72mfQk_ViHJ9Y_rU0etS8XpORvZUNMc5m2iHL=pQDiVFSg@mail.gmail.com>
From: Philip Herron <herron.philip@googlemail.com>
Date: Mon, 24 Feb 2025 16:42:36 +0000
X-Gm-Features: AWEUYZkmtXLg4bnwYTgYkY70WPSl5ESlM86vRJLwZsePt1goNhhMQ9aQBGEtYX8
Message-ID: <CAEvRbeo3QujuvRxjonhzqjQbO5e1_ut0LOSQsukH1T5vx=jzuw@mail.gmail.com>
Subject: Re: C aggregate passing (Rust kernel policy)
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, Ventura Jack <venturajack85@gmail.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Kent Overstreet <kent.overstreet@linux.dev>, 
	Gary Guo <gary@garyguo.net>, airlied@gmail.com, boqun.feng@gmail.com, 
	david.laight.linux@gmail.com, ej@inai.de, gregkh@linuxfoundation.org, 
	hch@infradead.org, hpa@zytor.com, ksummit@lists.linux.dev, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	Ralf Jung <post@ralfj.de>, Antoni Boucher <bouanto@zoho.com>, 
	Arthur Cohen <arthur.cohen@embecosm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 24 Feb 2025 at 14:54, Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Mon, Feb 24, 2025 at 3:47=E2=80=AFPM Miguel Ojeda
> <miguel.ojeda.sandonis@gmail.com> wrote:
> >
> > On Mon, Feb 24, 2025 at 1:58=E2=80=AFPM Theodore Ts'o <tytso@mit.edu> w=
rote:
> > >
> > > Hmm, I wonder if this is the reason of the persistent hostility that =
I
> > > keep hearing about in the Rust community against alternate
> > > implementations of the Rust compiler, such as the one being developed
> > > using the GCC backend.  *Since* the aliasing model hasn't been
> >
> > I guess you are referring to gccrs, i.e. the new GCC frontend
> > developed within GCC (the other one, which is a backend,
> > rustc_codegen_gcc, is part of the Rust project, so no hostility there
> > I assume).
> >
> > In any case, yes, there are some people out there that may not agree
> > with the benefits/costs of implementing a new frontend in, say, GCC.
> > But that does not imply everyone is hostile. In fact, as far as I
> > understand, both Rust and gccrs are working together, e.g. see this
> > recent blog post:
> >
> >     https://blog.rust-lang.org/2024/11/07/gccrs-an-alternative-compiler=
-for-rust.html
>
> Cc'ing Antoni, Arthur and Philip, in case they want to add, clarify
> and/or correct me.
>
> Cheers,
> Miguel

Resending in plain text mode for the ML.

My 50 cents here is that gccrs is trying to follow rustc as a guide, and
there are a lot of assumptions in libcore about the compiler, such as lang
items, that we need to follow in order to compile Rust code. I don't have
objections to opt-out flags of some kind, so long as it's opt-out and peopl=
e
know it will break things. But it's really not something I care about right
now. We wouldn't accept patches to do that at the moment because it would
just make it harder for us to get this right. It wouldn=E2=80=99t help us o=
r Rust for
Linux=E2=80=94it would just add confusion.

As for hostility, yeah, it's been a pet peeve of mine because this is a
passion project for me. Ultimately, it doesn't matter=E2=80=94I want to get=
 gccrs
out, and we are very lucky to be supported to work on this (Open Source
Security and Embecosm). Between code-gen-gcc, Rust for Linux, and gccrs, we
are all friends. We've all had a great time together=E2=80=94long may it co=
ntinue!

Thanks

--Phil

