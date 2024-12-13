Return-Path: <linux-kernel+bounces-445520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E1039F1734
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 21:11:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 871311886943
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 20:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E7211F4E35;
	Fri, 13 Dec 2024 20:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="COf1KehJ"
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3092D18FDBE;
	Fri, 13 Dec 2024 20:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734120233; cv=none; b=TtU/JdXL4ovyLAYPw1L8Mz+bOuukHHdf1uosbMMz9d/tpDW87317CCBwXRlICjXXiuuXn8qn/FWT7PntaFA7pOa+pvPXwnKENiP6DtnKPasBkzLEAgxWgfd0TozE0SHeTp3Qmgm79tT0HbIiY3cEqXT3oXnAy+HxJfpMjeQCAv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734120233; c=relaxed/simple;
	bh=EEsLHXfnyW13fmLQ5HyaSLe3hkTge+h6SACTUjwD0O0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XXcBVO0xfoevSv9uIeGhLhoM9HrH2WSD2Jxj8rMzBonCP0NPt/y/+12H3f7RBMFsv/4WBiBzFt5YWtGogMd+2F2rqUUd5gMWq2+WvujajJR/vQfsq9Vkl0N2AilGY70FG+6wFS4imPBR290p3C8TDWy8iOIoProYvcKfGKq1k3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=COf1KehJ; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-2a3c15add84so7694fac.2;
        Fri, 13 Dec 2024 12:03:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734120231; x=1734725031; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EEsLHXfnyW13fmLQ5HyaSLe3hkTge+h6SACTUjwD0O0=;
        b=COf1KehJn+4PvUV8alovEaw6peeTMN0k8qqod2j2s+g/EJwgGbeIgFMiwFdMu7XLo9
         Izy91jQqeKPPn0W+ywtxbPZ1Pz5ktez74+kvQ/KXe8JYjB88MYM52srDsKbNQU+DB++f
         mDH+0nWjojuZ8HN1X7JG5zZO3fVLeZ/nzKWyfte1rX2VEmA2vDM8tXCRbsbwkSd/u9Tg
         74e/b5zWxOXO1Zco1yMwSAsPD1AXki+LUB3OdAADdwlmdF3aqbM6X57KEfA9TKOBqP8Z
         URAU3J+zq94ks5+jXGLbZQVDsLAk/ZFSBCdyroYA+7RvotdHle6KD40AYJlsnSlm30lz
         HAgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734120231; x=1734725031;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EEsLHXfnyW13fmLQ5HyaSLe3hkTge+h6SACTUjwD0O0=;
        b=k6ZrjA7WvIFwHI/vaOCk0FglHvWShdftqiEzK0SnPJRR29sUXT8WMD4d67a8bcvc99
         sx7oZsudPoBrEGYh7xzd4Xmp1rum9nPHXxK4o/5u/nnzZ/T2tG3lcoboZjzyZXnE1Idf
         Mow/sr0d6tiNZwGJ9CBcZfQ5brGvHfUJV4+890wNBadCKGXSNr2OdkU6CaTJfyo6qe5L
         agJIYIAdluG/fTfVywVo5Rp7zdVRfQEDhH45rusQJ//NZDtjF5mCM67vJFcRq9e3pvjJ
         MEHytooLIZaKS1vLHBoY9R1/9qtv6mLoST6j+/C6NLrYL0hL5I7KS0KsW6dJFQwsMdrP
         4yuA==
X-Forwarded-Encrypted: i=1; AJvYcCWLg7cYC6U/VURD9jj1tczZrT9NsJgEB/eLG9x3U2f7koYhRnVbKe7/lKscJAFxaqagCUvZZSB8AGysN/h1UEM=@vger.kernel.org, AJvYcCWMaSKolUXptVmipzgeLoDrlDGxhkzaVX+xooaXzx/cp6yYUQl/5MTUQxGJd3tjhNO/alQUsztNU+yO3Xk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkJW7aKaBNs9vnEXxptI6+HKydH1K73g9Xb+XOyknesHNblsil
	FoXYPMs55p8bIPGV3FGvT1CkIGd7g0A/mNQfSYkr1OeqXG8vi6uSOlsPf8LIUixQJYvvvLePflQ
	qmwy0jtQl0kJpGRBEp+MQpFrpYS7+b46e
X-Gm-Gg: ASbGncvdzjU27lEIIma3mYVoE7IHffF73nXCCa1RBZr2AwV0wKDLQQTKL9kMlVNlC0Q
	VZO8Es+8kAU+1KcVav/6P2pRPFclEAdYLU7gipA==
X-Google-Smtp-Source: AGHT+IGYO2czvH9Cgdniw5DNvlFlBt1sflul4wM6XvRZz/U3hU3A9O8tSeSxGN0BUY/FTTWSWpDNjqSbojPy9P90htI=
X-Received: by 2002:a17:90b:3804:b0:2ee:d9f2:2acd with SMTP id
 98e67ed59e1d1-2f2902add3dmr2176730a91.6.1734118689108; Fri, 13 Dec 2024
 11:38:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241212-rust-xarray-bindings-v12-0-59ab9b1f4d2e@gmail.com>
 <20241212-rust-xarray-bindings-v12-2-59ab9b1f4d2e@gmail.com>
 <CAH5fLggwK0LXAsBnP3FtFHCnEzzBNNZfsCy3iJ6w=nT07CHgVg@mail.gmail.com>
 <L-1MAJJDE02BClBz6dbLWTKAz6RM33gupqt5fPEyX9tYoW43aDrrH4oY-OerHc17mpVTgy6j4e6_EauQQY8Viw==@protonmail.internalid>
 <CAJ-ks9mTEcRg6=ZiYFX3ebHSYgMwTv692ufUdTCoA1vX5E1nNg@mail.gmail.com>
 <87pllvczag.fsf@kernel.org> <CANiq72kEk5y=As6rOSe6V7w7AV3qg7u3Dd+PKtwWzzDEi1a1RA@mail.gmail.com>
 <CAJ-ks9=_nO292bvG=ir1o8dLvc=MGdT__m0pU48-qn6YdwSJVQ@mail.gmail.com>
In-Reply-To: <CAJ-ks9=_nO292bvG=ir1o8dLvc=MGdT__m0pU48-qn6YdwSJVQ@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 13 Dec 2024 20:37:56 +0100
Message-ID: <CANiq72=f94m5mG69+wvh-x7xX_-sbRuq1OzMfOtkNJhwWstqcg@mail.gmail.com>
Subject: Re: [PATCH v12 2/2] rust: xarray: Add an abstraction for XArray
To: Tamir Duberstein <tamird@gmail.com>
Cc: Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Trevor Gross <tmgross@umich.edu>, 
	=?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>, 
	Asahi Lina <lina@asahilina.net>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 13, 2024 at 6:55=E2=80=AFPM Tamir Duberstein <tamird@gmail.com>=
 wrote:
>
> Implicit in this statement is the assumption that while new to Rust,
> those reviewers will not be new to C.

Sorry, I am not sure what you mean.

I was talking about maintainers and key reviewers that need to read
your code, and thus the "advantageous for the submitter" bit, who most
likely are able to read C.

But even if you are talking about a reviewer that is new to C (or even
both C and Rust), they will be able to understand your Rust code if
you are writing an `if` instead of `.then()`.

It is not about what style is best, but about making it readable for
the majority of readers.

> Anyway, I'm not emotionally attached to this style. Would you prefer I
> rewrite it using loops and conditionals? Whatever helps this land, I
> will do.

Personally, I would rewrite at least the `if` one, since it is not
really how we write those elsewhere. The other one, since you are
building an iterator anyway, I think it makes sense. For similar
reasons, perhaps one `match` you have could be an early return
instead.

But it is up to the maintainer. By the way, I don't see the XARRAY
maintainer nor the list Cc'd?

Thanks!

Cheers,
Miguel

