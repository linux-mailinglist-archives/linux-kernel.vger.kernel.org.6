Return-Path: <linux-kernel+bounces-529396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2281A42461
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 15:55:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B80807A6A8D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 14:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0164924EF8D;
	Mon, 24 Feb 2025 14:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NxiXwruL"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0066224EF70;
	Mon, 24 Feb 2025 14:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740408868; cv=none; b=ZNg5UwS3bcJDLllKnq6ElSVfKscAOmq5EwHSug/zkWceHV6ljjfF/P+OYDBNTesx1lPcKVG1nb/XZ1EGT7TAwKTllkCcXnmyVPVY7GJ/zx1XRKeKLXdfGBWkdSIGufF+YPfRfDkuHAWbHi1WYXaFWSITJqmGLvgIiBpVOLT+mAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740408868; c=relaxed/simple;
	bh=KLul3ZTAtHJe/n3xu+7cwVDZJuShWGTqS305WKdQyAo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QXRE1Kpp5Ql5kJdDnnuAXGdJLquVGb0iKe4dI8whBiiXMe4e3bB5o2C8Ti6LWMfNPcgDk6tchwYquJ0idA1S1AblL60RlNGs15eUO7gCmIhLGOCDA3p2TnbivU99nxxLocxp86dtqWt/5kyKoC9sEEOv9SDkgDTwe1D4epsijSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NxiXwruL; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2fe5d75ff8cso106050a91.3;
        Mon, 24 Feb 2025 06:54:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740408866; x=1741013666; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vcJQ2PByz6Lu9IM3XdLufcM/7wqjI4LpjnZF5XQFLRQ=;
        b=NxiXwruL6QDjNIxvG+r7exkLpfAhSUMj3DnZ0rgGHotuTXaSSpvklOWa1IsJgZtJaT
         +jd7MftBdRvUCAY1pAZNC+gMLt1w9JxOJosa3KFd9vuNBJQ9+F8NYtldFrzljyPRNX0T
         BkuxQIizFocQlGNe8rYJRrYEfJmqTkRSp1DrMnG85GcBt9AzDx81ceMoc1Pn9gO4Fjsr
         isu1TuNC8h+VjXomxzvFZKk+7t9SyW1ar0C9y4LVqjZHGwxWpHM1EkZE4mJO4j6F1wIj
         eInr1ysTIzfRx/MFJciTZsZu/NTJRphBfRsS3dEYPdqsyEwOWnHjR/YogO+H93mXSZNa
         opag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740408866; x=1741013666;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vcJQ2PByz6Lu9IM3XdLufcM/7wqjI4LpjnZF5XQFLRQ=;
        b=XfyYTuPgflG74E1Ojed8XpAmbaEIB5jib9k5ivHEs8/fQmtR/Y3lrxxcGRECo+u+hG
         3pX4DNPu7PHt3nrILM6NbEEC749pdF702cTYJMPwWp78yOTzsqi7t+qMf/izjVnPCrZD
         lsV6gMVLa5G1q++yWj+FgdbX7F23f7HSx/E6rpiLafnS6NGbylTW9j3vkhfZUPgBRNGi
         4VCeif5RTrJJ20MS4yNwT9sbLLmZf5wpDe1MbbtA7ShiCWBcW+Oyfbp+8C28eoviq/Jf
         xWns3N5Yn1MVBsgVRGYV9XitybHWLzXn/KaXO71uT1aawsztC8ENG5zLD6HO3wez410U
         7LYg==
X-Forwarded-Encrypted: i=1; AJvYcCVV2F1CxnaahnTEuIn9GMbFuJtVSj03qbPzG0/XgH01Q/RXsqSJe918latXuqyhMotyhHS63UCbYxvF2uc=@vger.kernel.org, AJvYcCXeHrVmB6DE3eUGBUDI0tPScbAt3lEz/6Q2Bh9+5W9cSMuqYQ7xBeGJFnEB7Ww0JUDmKQtubMQKv5fMO8lkkTg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCwfst7NVAY8tNTxC/lpKQXTjf19zYpkKqwMfd1vWQP1dr9eza
	/wwuW29AtrYwIFevlrkqoQbOYij53NKAvdmXR3J5keujm9/kuRaGxG7t7A0DzRoFHvB4DT7uXlf
	Bem7SA8oi+bZhzm/RxX9Z4u7/K8M=
X-Gm-Gg: ASbGncvj3GH9PKYl5hb5poPwB0kJWXor4LbW5sU12p6I6v6htTX4VelIhEEW3N8uxsy
	CvkyiwfH9iMHmjsuaAiPWB820bDbD/KExDFg3ZTcBRXNfX4pgCu+JapzYLR+ZDbvbTdEJauI3WQ
	ULnvnT6IQ=
X-Google-Smtp-Source: AGHT+IGDjahBUVO6BXevnVMHWjQyKi4BqDRHKTF8y7apvI5jM3Rv1j7RNOMukgd4iq3HaXOneLmH+308oWENkLJBz9E=
X-Received: by 2002:a17:90b:4f85:b0:2f2:f6e5:d28e with SMTP id
 98e67ed59e1d1-2fce7aef8damr8610160a91.3.1740408866030; Mon, 24 Feb 2025
 06:54:26 -0800 (PST)
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
In-Reply-To: <CANiq72k-K3-Cbnm=0556sXAWs0kXBCB4oR67M4UtD=fq=kyp7A@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 24 Feb 2025 15:54:12 +0100
X-Gm-Features: AWEUYZmiNFSazSTTuGNZbCDwsIIxYoIgz2rLtYlFv5_7wXS0fxYpgaGNrAtv5_E
Message-ID: <CANiq72mfQk_ViHJ9Y_rU0etS8XpORvZUNMc5m2iHL=pQDiVFSg@mail.gmail.com>
Subject: Re: C aggregate passing (Rust kernel policy)
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: Ventura Jack <venturajack85@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Kent Overstreet <kent.overstreet@linux.dev>, Gary Guo <gary@garyguo.net>, airlied@gmail.com, 
	boqun.feng@gmail.com, david.laight.linux@gmail.com, ej@inai.de, 
	gregkh@linuxfoundation.org, hch@infradead.org, hpa@zytor.com, 
	ksummit@lists.linux.dev, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, Ralf Jung <post@ralfj.de>, 
	Antoni Boucher <bouanto@zoho.com>, Arthur Cohen <arthur.cohen@embecosm.com>, 
	Philip Herron <herron.philip@googlemail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2025 at 3:47=E2=80=AFPM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Mon, Feb 24, 2025 at 1:58=E2=80=AFPM Theodore Ts'o <tytso@mit.edu> wro=
te:
> >
> > Hmm, I wonder if this is the reason of the persistent hostility that I
> > keep hearing about in the Rust community against alternate
> > implementations of the Rust compiler, such as the one being developed
> > using the GCC backend.  *Since* the aliasing model hasn't been
>
> I guess you are referring to gccrs, i.e. the new GCC frontend
> developed within GCC (the other one, which is a backend,
> rustc_codegen_gcc, is part of the Rust project, so no hostility there
> I assume).
>
> In any case, yes, there are some people out there that may not agree
> with the benefits/costs of implementing a new frontend in, say, GCC.
> But that does not imply everyone is hostile. In fact, as far as I
> understand, both Rust and gccrs are working together, e.g. see this
> recent blog post:
>
>     https://blog.rust-lang.org/2024/11/07/gccrs-an-alternative-compiler-f=
or-rust.html

Cc'ing Antoni, Arthur and Philip, in case they want to add, clarify
and/or correct me.

Cheers,
Miguel

