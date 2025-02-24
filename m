Return-Path: <linux-kernel+bounces-528487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04628A41834
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 10:09:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BCEA16F9EE
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 09:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D2761946AA;
	Mon, 24 Feb 2025 09:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hisG+jAm"
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD727243951;
	Mon, 24 Feb 2025 09:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740388140; cv=none; b=kZmskZi+elgX6e9kUZsJQ3QipZPYuck9rdxmX9hx2Iyytf1Ml+WFfNQoeYDrPfOpLaQk87JcfJ0nCnsYjwvhihwsVO5nK9M2UWmqGY0Y28Rq46tpzRJLF1DZUYC1tmh5QoU71RAD1Ti5ngZj9K0vCeNY7JpNaqv3fLIpHfWivU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740388140; c=relaxed/simple;
	bh=daM8eCpYsb21gX9QsirhUsHYuQ1YdkY3jqPS9x3ir38=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cLgpXfyRpRANC3j4lk6XZb7ilVMCLMcYgQtjmqyI8cBYvCxQ6iPhazTNzcVWYwDkMcTI42f9zcY32n7PhJypH6OJPnrKcYyELZw91qING5fw2/LEvjazggqNZOu8f3MgOzQSVjOIn/nVkoGoNQh4KKpMP9H1P5LjkyxXfW9HFt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hisG+jAm; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7c089b2e239so447293885a.0;
        Mon, 24 Feb 2025 01:08:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740388137; x=1740992937; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s8Z8QEwUCxkupWd1+3HNImprL2CAvRRP+kS3TrK5QZE=;
        b=hisG+jAm6PXct5rOjPJ5jyYe/mo2VdwwoNh05uC3w5P3vmM8feBCOFNkTnkLrnPyD8
         rOeBS+G/JVnRfQHZ3Dx/DrgOu7XTICR9JhCudVDgulkd6BQH9p+F+fJQKRpeR/QRWksh
         6u2MgZYSm1/E6ar8TSDQozfTjhJMmrsBNZvXVG0ZPkQO8ZLZbC/hsqbocAfFflAwDcZT
         KMo7GRTCfLoIfxN0WI+aEJfUvRjsf4SOjexN4cze7ihHk/999AgaCm5gjNghtmeNhgn3
         VJhlhGk2EYkIRZ/a0eIm6mo+Sol7SSb0/yI7tLNoX6Y54NpzRfUbyMCFO1iu3Te8loOW
         hzpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740388137; x=1740992937;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s8Z8QEwUCxkupWd1+3HNImprL2CAvRRP+kS3TrK5QZE=;
        b=oury54QmCepou0UHSdtKhhAEgQyHy5RI+VGM1mk/vvAzA7b0cVmWJQDi7/A+Z5000B
         SXkRmUKcsriI9jIemrRi9aYVFA+bY8NBvop1GUnXeZH5GAB/0GiR4ws7NvEjbGrALkTM
         RGe49DUtV1d9v/C5r/Snsl3jtCYU5PbDutx6sHDNHBRswlfMcCHyD7UI896gr5ggsNPc
         Y3BjGulyrvUjPkqBgauSC972GXMyvv3eot8ryvf2RCpYLxXKnfLt5fWr9sKy0MsfY1eL
         RjFaLRKQF11/LqxVjici0fE7Jh1+iO9fKg7trck7UbKz/QRAOH8PTejIVSYwqoIYJ8Hk
         UlyQ==
X-Forwarded-Encrypted: i=1; AJvYcCUuVoevrTbnCJml4ORrYKvl1DyrF9jxCfHYGLZaqoKXvdIBzZQXz4TWGqi/CvmanbbxOay84ba9TUq48UlK314=@vger.kernel.org, AJvYcCWm1wmOoLwLehTqM1VopU0GBaW1MgqTFhliJnbSF60zqBkeVFXTtrB2SwbbaEuMdTkr70+OGGUb6DXzfis=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2o1z6Yv31zrGmYquTQhbv1Ze0WCR6+fCtAIfDSV8OqmoZHVEB
	DE9/OPDHDWdfg1g6T46r0bLZrxB8chjICvUe04iLAJ6cD1iybNGPwjR3a8exOhCfn1n3tcqiDsb
	O/CdCDDkWrO/qIQMbvxhn8lghpIM=
X-Gm-Gg: ASbGncsp65fOSPgQV4dOvCqnAF/HDMilH1bPPPDFN1QpmjFA/eowx77/KEOq0koBobt
	SZgKXcWc+9M9jnaobDnTCTTamUjRU7sEMlBnF6Vu5Hn+RMP6l3656ZyPwbJL2nzjiwmRkhuJHoo
	OJVgNDsJdN
X-Google-Smtp-Source: AGHT+IGjG8I5drO+X1eEUiibGtzlCaFmdmDDWxEcy/DATfn0GZv0YcS1x2zAkBvkENKOLf26xD8UR2442xGniu3XVH8=
X-Received: by 2002:a05:620a:4405:b0:7a8:554:c368 with SMTP id
 af79cd13be357-7c0c2164e93mr2368642885a.6.1740388137584; Mon, 24 Feb 2025
 01:08:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANiq72m-R0tOakf=j7BZ78jDHdy=9-fvZbAT8j91Je2Bxy0sFg@mail.gmail.com>
 <Z7SwcnUzjZYfuJ4-@infradead.org> <CANiq72myjaA3Yyw_yyJ+uvUrZQcSLY_jNp65iKH8Y5xGY5tXPQ@mail.gmail.com>
 <326CC09B-8565-4443-ACC5-045092260677@zytor.com> <CANiq72m+r1BZVdVHn2k8XeU37ZeY6VT2S9KswMuFA=ZO3e4uvQ@mail.gmail.com>
 <a7c5973a-497c-4f31-a7be-b3123bddb6dd@zytor.com> <Z7VKW3eul-kGaIT2@Mac.home>
 <2025021954-flaccid-pucker-f7d9@gregkh> <4e316b01634642cf4fbb087ec8809d93c4b7822c.camel@tugraz.at>
 <2025022024-blooper-rippling-2667@gregkh> <1d43700546b82cf035e24d192e1f301c930432a3.camel@tugraz.at>
 <D7ZDF8NZGPS3.3QBMAVC1NTUDM@maslowski.xyz> <E0BD1BDB-0EBC-4E27-9324-7CA70ACE194B@gmail.com>
In-Reply-To: <E0BD1BDB-0EBC-4E27-9324-7CA70ACE194B@gmail.com>
From: Ventura Jack <venturajack85@gmail.com>
Date: Mon, 24 Feb 2025 02:08:45 -0700
X-Gm-Features: AWEUYZnfy9opWscz-4jFfz1MccFJtXuWWbjaTV1FP0XPTI4GXNbYujZ-2jgW9oU
Message-ID: <CAFJgqgSCW9XbVYr7yTa47Miax+LGM9jNNE5Yuw1xQE2BZ9gkTQ@mail.gmail.com>
Subject: Re: Rust kernel policy
To: comex <comexk@gmail.com>
Cc: =?UTF-8?Q?Piotr_Mas=C5=82owski?= <piotr@maslowski.xyz>, 
	Martin Uecker <uecker@tugraz.at>, Greg KH <gregkh@linuxfoundation.org>, 
	Boqun Feng <boqun.feng@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Christoph Hellwig <hch@infradead.org>, 
	rust-for-linux <rust-for-linux@vger.kernel.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, David Airlie <airlied@gmail.com>, 
	linux-kernel@vger.kernel.org, ksummit@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 23, 2025 at 4:32=E2=80=AFPM comex <comexk@gmail.com> wrote:
>
> > On Feb 22, 2025, at 3:42=E2=80=AFPM, Piotr Mas=C5=82owski <piotr@maslow=
ski.xyz> wrote:
> >
> > I'm sure you already know this, but the idea of safety in Rust isn't
> > just about making elementary language constructs safe. Rather, it is
> > primarily about designing types and code in such a way one can't "use
> > them wrong=E2=80=9D.
>
> And importantly, it=E2=80=99s very hard to replicate this approach in C, =
even in a hypothetical =E2=80=98C + borrow checker=E2=80=99, because C has =
no generic types.  Not all abstractions need generics, but many do.

True, a more expressive and complex language like Rust, C++, Swift,
Haskell, etc. will typically have better facilities for creating good
abstractions. That expressiveness has its trade-offs. I do think the
costs of expressive and complex languages can very much be worth it
for many different kinds of projects. A rule of thumb may be that a
language that is expressive and complex, may allow writing programs
that are simpler relative to if those programs were written in a
simpler and less expressive language. But one should research and be
aware that there are trade-offs for a language being expressive and
complex. In a simplistic view, a language designer will try to
maximize the benefits from expressiveness of a complex language, and
try to minimize the costs of that expressiveness and complexity.

Rust stands out due to its lifetimes and borrow checker, in addition
to it being newer and having momentum.

What are the trade-offs of a more complex language? One trade-off is
that implementing a compiler for the language can be a larger and more
difficult undertaking than if the language was simpler. As an example,
to date, there is only one major Rust compiler, rustc, while gccrs is
not yet ready. Another example is that it can be more difficult to
ensure high quality of a compiler for a complex language than for a
simpler language.

Best, VJ.

