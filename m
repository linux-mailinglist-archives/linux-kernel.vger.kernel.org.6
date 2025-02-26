Return-Path: <linux-kernel+bounces-533906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F9A4A46027
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 14:04:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43B103AFEB3
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 13:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EBD22206B2;
	Wed, 26 Feb 2025 13:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E8/7CjMn"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FFC11891A9;
	Wed, 26 Feb 2025 13:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740575018; cv=none; b=XamUFe2Nlmzftthls4NrY5ny35wVchiwpRy25Wyg9ehpNC0HND+54tZIbcN0yhenw4zWn64UA+zNKhxHTYHflZkhiaAlQYBHmcC396ao8jWFmo4ay00dkQydR9iX11pdd6E35JYWt4wsysaJqVNcAybVMGUthtUnqgsOUA2YW8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740575018; c=relaxed/simple;
	bh=eHXH2xcwHvpeP2rTbNNDIAknPYHbqmdnpV8ggdyjZ7M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Svoh9Q7oiPGw3De4tPzQ02Z7xsBUrNa1hzfpCPu91mWRMMx5KQRee3r9+EpFlqhA/no48NzNWW5OUputxjTEu7kOo1BynouCW/2azXm2PgAZv/a8xO5K1dCRa/TJ1dQKjMLI68GBnhau6SEY4IPzP8aN8GJ6COy+sIGFUtEdCG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E8/7CjMn; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5461dab4bfdso8013600e87.3;
        Wed, 26 Feb 2025 05:03:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740575015; x=1741179815; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OOaAyIgCFX8Depn/PozouTZSxlQDaDtgCKWZ+jCIr88=;
        b=E8/7CjMn1kbAPnjhKJeOSvnDX2ffIHZEor8AXIe9+2OFoPwTvqeyLAHCy9eB719KAZ
         mC0Hokq/E5lZOUb73xpW/lr+MMPuKoFlpo0Vv2LTldb7dsK1uEFOOylrFOL22przRUsx
         SCy+01cRq6Zzbv/YBChx9L1oWH7nGO0azfcct55QgPvCEsNTZtKQldrAJsSjixow5dp4
         DG3i8yrWEIB/DC+Wnbu2XSZUX+gROSFMXFgbWiHXVC7j35MJOklx+LKkto1Yibef0Jue
         zhaT5Zjr0hmC/3GmeJgWZLStNWwUTR7VmtsrzjsX8BDIDwElW+T66HBp9Y8D+Te53pIG
         +oJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740575015; x=1741179815;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OOaAyIgCFX8Depn/PozouTZSxlQDaDtgCKWZ+jCIr88=;
        b=uYMbfZkvLKuCV6LoI/nNhMUjngp9StNET5D9HS9MG07cR78K/ZipnLQMMewu9mUvUG
         x+UDGwwlQk6rm/yh3U0gZyC8zwPEsf43jhTNy0R5zIPHNufvpBv25/eNNGaLhQfkAPPs
         OpSPSYbquUD8kbbe+XLuQ3jAa1bROLLgxNPyxF5NoczwhiwgFqNvyAL8a/CcxIYvUjIX
         lCmcONYpzCD2Z9ri1mRYjfg0YzdnusAKxhsq1DNyQnnH3O/fSaaAO0rdM7Aly0YVRns2
         mapeV172WeOqfXP6VkhE08YQuWDtpQNE4BKW/t0o3LaTpwgNLYVkkdAjWyS5MSrE32Qo
         IdmA==
X-Forwarded-Encrypted: i=1; AJvYcCWdd28eGA7olQXiOscqVm2SODPlUG1mMKtWGkPawFIsQ3r0jbp9d7dX7ROt0aikfFHt6uvn3Ni/Ad/bxmI=@vger.kernel.org, AJvYcCXGv35DwHEQmvtUrvdmUNYQf2lNEijIZ/6d8sxkDrKOCbEyeOToZISV648yi/pbkjsxyiqu5kMchFiD/+KY1us=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDWCnDF6OnwshAiIYP3edbyNOtvRBAhRM2F9+1GGymm/zRpOfY
	s6qFGklOf53dxWE133vtd5f9hCOK/AEjB8Z1YePy7nL/N/+4Y04f92JoVSg3XGQvFygUv6fCdNM
	j/LZsyu4+O/EFqJa/vq1KfMaRbWg=
X-Gm-Gg: ASbGncvekjZBzJJp2ydtCTPhasNF0fVqEp1pRpjJuF26XfBibVZt01RpRm2TWdqBgPr
	kmejou3GfOriJd4jA4pcFNDeN+0ZNeiFCTiA1b1nORLwFqvhgcLE32gAjI9Gv5NzpQbnYQYY2R3
	k3kNZ/hl2y
X-Google-Smtp-Source: AGHT+IF4/7i4cn3DiJ773zF8xOQe9L3YSlR5TCr/4/VVZsgTQa7dvgs28vk0rkrTCUmUnVPKqxiqJEINXiihbPUT3OY=
X-Received: by 2002:a05:6512:e99:b0:545:6fa:bf5f with SMTP id
 2adb3069b0e04-54838edd8b6mr9406658e87.2.1740575014818; Wed, 26 Feb 2025
 05:03:34 -0800 (PST)
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
 <CAH5fLgh7Be0Eg=7UipL7PXqeV1Jq-1rpMJRa_sBkeiOgA7W9Cg@mail.gmail.com>
 <CAFJgqgREAj-eP-d244WpqO-9H48ajZh83AxE31GqoONZ=DJe-g@mail.gmail.com>
 <CAH5fLghEMtT663SNogAGad-qk7umefGeBKbm+QjKKzoskjOubw@mail.gmail.com>
 <5E3FEDC4-DBE3-45C7-A331-DAADD3E7EB42@zytor.com> <2rrp3fmznibxyg3ocvsfasfnpwfp2skhf4x7ihrnvm72lemykf@lwp2jkdbwqgm>
In-Reply-To: <2rrp3fmznibxyg3ocvsfasfnpwfp2skhf4x7ihrnvm72lemykf@lwp2jkdbwqgm>
From: Ventura Jack <venturajack85@gmail.com>
Date: Wed, 26 Feb 2025 06:03:20 -0700
X-Gm-Features: AQ5f1JoDaaLCqIcdIZhNNBP4aubytjJzFmRPFjw-ljPopqVIQo-B9DJXO1CskAM
Message-ID: <CAFJgqgS-SMMEE2FktuCUimdGkPWMV3HB2Eg38SiUDQK1U8=rNg@mail.gmail.com>
Subject: Re: C aggregate passing (Rust kernel policy)
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Alice Ryhl <aliceryhl@google.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Gary Guo <gary@garyguo.net>, airlied@gmail.com, 
	boqun.feng@gmail.com, david.laight.linux@gmail.com, ej@inai.de, 
	gregkh@linuxfoundation.org, hch@infradead.org, ksummit@lists.linux.dev, 
	linux-kernel@vger.kernel.org, miguel.ojeda.sandonis@gmail.com, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 25, 2025 at 1:21=E2=80=AFPM Kent Overstreet
<kent.overstreet@linux.dev> wrote:
>
> On Tue, Feb 25, 2025 at 10:16:17AM -0800, H. Peter Anvin wrote:
> >
> > I do have to say one thing about the standards process: it forces a
> > real specification to be written, as in a proper interface contract,
> > including the corner cases (which of course may be "undefined", but
> > the idea is that even what is out of scope is clear.)
>
> Did it, though?
>
> The C standard didn't really define undefined behaviour in a
> particularly useful way, and the compiler folks have always used it as a
> shield to hide behind - "look! the standard says we can!", even though
> that standard hasn't meaninfully changed it decades. It ossified things.
>
> Whereas the Rust process seems to me to be more defined by actual
> conversations with users and a focus on practicality and steady
> improvement towards meaningful goals - i.e. concrete specifications.
> There's been a lot of work towards those.
>
> You don't need a standards body to have specifications.

Some have claimed that a full specification for aliasing missing
makes unsafe Rust harder than it otherwise would be. Though
there is work on specifications as far as I understand it.

One worry I do have, is that the aliasing rules being officially
tied to LLVM instead of having its own separate specification,
may make it harder for other compilers like gccrs to implement
the same behavior for programs as rustc.

    https://doc.rust-lang.org/stable/reference/behavior-considered-undefine=
d.html
    http://llvm.org/docs/LangRef.html#pointer-aliasing-rules

Interestingly, some other features of Rust are defined through C++
or implemented similar to C++.

    https://doc.rust-lang.org/nomicon/atomics.html
        "Rust pretty blatantly just inherits the memory model for
        atomics from C++20. This is not due to this model being
        particularly excellent or easy to understand."

    https://rust-lang.github.io/rfcs/1236-stabilize-catch-panic.html
        "Panics in Rust are currently implemented essentially as
        a C++ exception under the hood. As a result, exception
        safety is something that needs to be handled in Rust code
        today."

Exception/unwind safety may be another subject that increases
the difficulty of writing unsafe Rust. At least the major or
aspiring Rust compilers, rustc and gccrs, are all sharing
code or infrastructure with C++ compilers, so C++ reuse in
the Rust language should not hinder making new major
compilers for Rust.

Best,  VJ.

