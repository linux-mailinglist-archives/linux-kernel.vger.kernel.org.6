Return-Path: <linux-kernel+bounces-524962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F33FA3E937
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 01:40:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C5AC421F0B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 00:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 958781A270;
	Fri, 21 Feb 2025 00:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="OLWLCW56"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4324C79FD
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 00:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740098421; cv=none; b=oVoXGYiuVEiM2w5k0AXZADq2fynXpQuUFAlpQqrM6cx8zSORjZIvAT6S4GB01SrYKSOpMdOVOeVf+e8wCYeil5CDUENwVVl9M62bbe+tGl9ZOSoY3gBywJpNlELH4Bjc0wlNo3bCGM2/uLBEyvKx9qsZkcbqZ8Rm+HkpA8B1YBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740098421; c=relaxed/simple;
	bh=4TZmT0OVj6lmyqRooEpFA8ZqX8x6sU7ElubS1e40FT8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wy7szalf3iIMUnh4tHWeBVakWI3vPHAETn0ovfmDkO0sB3zNZMxwd5YbzYRqhAcw2DLAfyWNkahdaqG1od3S1IiXSSGxLkVuSblBhXUJ7HOgptS7ldRdXtEBXKQNyko77+Aqp6aT4gKdhR2XL1+cagMYIwGqabSOvwJxBJVeJrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=OLWLCW56; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5dedae49c63so2852113a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 16:40:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1740098417; x=1740703217; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IIRyFU8js5MTrYu3kLLDCqOpLqxeTQMOioCoscja6X0=;
        b=OLWLCW56OcgSQuwQyYvNAeN+ju6tl0cJQDIRFq774y/I8245K/ddPULdhvLDAp8EY1
         0CjP11k5Hyz843TpgpRCNqyYo+dpfCog2droIYQgcQDBmHf5jIyP6GBTyipJJHhNuKiY
         W6grixhHkcpw29culiybkw1FvoGBB7CJhRwW8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740098417; x=1740703217;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IIRyFU8js5MTrYu3kLLDCqOpLqxeTQMOioCoscja6X0=;
        b=vvrgNPQbmNmp/12yfPLYCTkrGaeU6KQnVsOdHgfvukP7BfUYdt8U1W4H1Wt2dLRn2I
         DefOQStTPl0dCYR0aSd46HiFYuL2zNCUOfcRdlx6FNOf0tadL3d8Ej+pSqt+w0s335Id
         K74m+qgLA3tzhobYi99lI3Wo1yH1Ui1mYX9zw+CvBBrzRo4oCMpajJ0Xl1t4E2530HJf
         EpzdhqHC/4tU2mxxYuMCpwzw1OyZTSy5CHEJG+4zzDLsUQAP1PXuEdAGVh5P78yiCPQZ
         eOJSwjMI03oUVmvBJreP/kVuxxxboIMI6RYkjLOYdJx1GuLo+iaTGdpO9kdH5OimC/Ip
         ef6Q==
X-Forwarded-Encrypted: i=1; AJvYcCXNDAELWCavJo416jvKwcUWGD/j41+wTueDni4PFlUSxirMpOEnoNGrMoqV1bAxduNALaEM6vRS3UTsygk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxglwfykG19TnJqWuyDVmGPPEdUzaeA9U8CXncjXp6xtCzYdF90
	sibk+E+B7zBrAYlz/yTntnMxGTWHHPMpQ5UQYjVEeStQ6eomTGSe98M3SrSfGY3HKU7Ihudk3xe
	dxQo=
X-Gm-Gg: ASbGncuOn2eW9+Zqz7y56+OWo427SS9C+xSzQnEX+oNqg83rns3Qh7HZoRgqTkx5j6m
	mNeQmWeJR4rQpAteMXfhQLYrZ36PCBylvqUw63ZSRoJZv7/Zk5ZZMIUzN9rT5WWNKygujBiJsSn
	FgSCoAPQfhobqEDBLaZI0iPtzbGPiJHSZRdOQ6ofcRmervDTAUb4/uhsQh54Alg1LHtHfKYYYhf
	ISGG41OSMESNqEFjtabBaG/zVMPCfFim1Zr2vCRYIZrhfNd9C4iy+2VC9khZVByj7cusfaDxquE
	aHhioFe4vziMghTVWnSkjTVnvJKBTWQMdkfX14Iz7eBRuLvHtM0uduiNV0h6eA8g+Q==
X-Google-Smtp-Source: AGHT+IHat3xpapNpPTeq7oILL5oOSkY29vavgnrNcKWHMRNhyDLeU0vsKMql0X4THSorxV04r7frkw==
X-Received: by 2002:a17:907:d8f:b0:ab3:85f2:ff67 with SMTP id a640c23a62f3a-abc0d9e5349mr72239166b.16.1740098417245;
        Thu, 20 Feb 2025 16:40:17 -0800 (PST)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com. [209.85.218.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abbbe74100asm595402066b.95.2025.02.20.16.40.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2025 16:40:16 -0800 (PST)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-aaecf50578eso308835766b.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 16:40:15 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXKNLqP5lGhiS6/9Z5NVLsVYV5kjE598hUQzJS0S9TvQ0xJCoWLDBRKYtSX/1hob2/7JX6s0solQH84zQU=@vger.kernel.org
X-Received: by 2002:a17:906:f5a9:b0:abb:a88d:ddaf with SMTP id
 a640c23a62f3a-abc0df5d5a1mr76770566b.55.1740098415082; Thu, 20 Feb 2025
 16:40:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANiq72m-R0tOakf=j7BZ78jDHdy=9-fvZbAT8j91Je2Bxy0sFg@mail.gmail.com>
 <Z7SwcnUzjZYfuJ4-@infradead.org> <CANiq72myjaA3Yyw_yyJ+uvUrZQcSLY_jNp65iKH8Y5xGY5tXPQ@mail.gmail.com>
 <Z7bO1jT2onZFZwgH@infradead.org>
In-Reply-To: <Z7bO1jT2onZFZwgH@infradead.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 20 Feb 2025 16:39:58 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgLbz1Bm8QhmJ4dJGSmTuV5w_R0Gwvg5kHrYr4Ko9dUHQ@mail.gmail.com>
X-Gm-Features: AWEUYZl110dqtgnPbf_5O23eqr6Efb1z5WIykrA3dNVGStovQIgnPSeO4hmGu6I
Message-ID: <CAHk-=wgLbz1Bm8QhmJ4dJGSmTuV5w_R0Gwvg5kHrYr4Ko9dUHQ@mail.gmail.com>
Subject: Re: Rust kernel policy
To: Christoph Hellwig <hch@infradead.org>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, 
	rust-for-linux <rust-for-linux@vger.kernel.org>, Greg KH <gregkh@linuxfoundation.org>, 
	David Airlie <airlied@gmail.com>, linux-kernel@vger.kernel.org, ksummit@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Wed, 19 Feb 2025 at 22:42, Christoph Hellwig <hch@infradead.org> wrote:
>
> The document claims no subsystem is forced to take Rust.  That's proven
> to be wrong by Linus.  And while you might not have known that when
> writing the document, you absolutely did when posting it to the list.

I was hopeful, and I've tried to just see if this long thread results
in anything constructive, but this seems to be going backwards (or at
least not forwards).

The fact is, the pull request you objected to DID NOT TOUCH THE DMA
LAYER AT ALL.

It was literally just another user of it, in a completely separate
subdirectory, that didn't change the code you maintain in _any_ way,
shape, or form.

I find it distressing that you are complaining about new users of your
code, and then you keep bringing up these kinds of complete garbage
arguments.

Honestly, what you have been doing is basically saying "as a DMA
maintainer I control what the DMA code is used for".

And that is not how *any* of this works.

What's next? Saying that particular drivers can't do DMA, because you
don't like that device, and as a DMA maintainer you control who can
use the DMA code?

That's _literally_ exactly what you are trying to do with the Rust code.

You are saying that you disagree with Rust - which is fine, nobody has
ever required you to write or read Rust code.

But then you take that stance to mean that the Rust code cannot even
use or interface to code you maintain.

So let me be very clear: if you as a maintainer feel that you control
who or what can use your code, YOU ARE WRONG.

I respect you technically, and I like working with you.

And no, I am not looking for yes-men, and I like it when you call me
out on my bullshit. I say some stupid things at times, there needs to
be people who just stand up to me and tell me I'm full of shit.

But now I'm calling you out on *YOURS*.

So this email is not about some "Rust policy". This email is about a
much bigger issue: as a maintainer you are in charge of your code,
sure - but you are not in charge of who uses the end result and how.

You don't have to like Rust. You don't have to care about it. That's
been made clear pretty much from the very beginning, that nobody is
forced to suddenly have to learn a new language, and that people who
want to work purely on the C side can very much continue to do so.

So to get back to the very core of your statement:

   "The document claims no subsystem is forced to take Rust"

that is very much true.

You are not forced to take any Rust code, or care about any Rust code
in the DMA code. You can ignore it.

But "ignore the Rust side" automatically also means that you don't
have any *say* on the Rust side.

You can't have it both ways. You can't say "I want to have nothing to
do with Rust", and then in the very next sentence say "And that means
that the Rust code that I will ignore cannot use the C interfaces I
maintain".

Maintainers who *want* to be involved in the Rust side can be involved
in it, and by being involved with it, they will have some say in what
the Rust bindings look like. They basically become the maintainers of
the Rust interfaces too.

But maintainers who are taking the "I don't want to deal with Rust"
option also then basically will obviously not have to bother with the
Rust bindings - but as a result they also won't have any say on what
goes on on the Rust side.

So when you change the C interfaces, the Rust people will have to deal
with the fallout, and will have to fix the Rust bindings. That's kind
of the promise here: there's that "wall of protection" around C
developers that don't want to deal with Rust issues in the promise
that they don't *have* to deal with Rust.

But that "wall of protection" basically goes both ways. If you don't
want to deal with the Rust code, you get no *say* on the Rust code.

Put another way: the "nobody is forced to deal with Rust" does not
imply "everybody is allowed to veto any Rust code".

See?

And no, I don't actually think it needs to be all that
black-and-white. I've stated the above in very black-and-white terms
("becoming a maintainer of the Rust bindings too" vs "don't want to
deal with Rust at all"), but in many cases I suspect it will be a much
less harsh of a line, where a subsystem maintainer may be *aware* of
the Rust bindings, and willing to work with the Rust side, but perhaps
not hugely actively involved.

So it really doesn't have to be an "all or nothing" situation.

                  Linus

