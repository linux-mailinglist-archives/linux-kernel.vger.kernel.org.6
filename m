Return-Path: <linux-kernel+bounces-178988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DECA88C5A12
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 19:07:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D2F61F219D4
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 17:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F09EA17F39F;
	Tue, 14 May 2024 17:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="W0ZSfUzf"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F11F17F37C
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 17:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715706444; cv=none; b=J0CiMwR+swXdjmRGXKww8PGv3XGM6jN0DN/eJ/XrZHDq5NoAH3170ltheEBM7hnBpx30sUY7lEw6qEkbv83XysCjiVRY7ykhUzr8mzE8V8LZ2G18AdKmEiLneEg11zXoU4+JV9UoJ8t2UXEpLnmiruoOHyt6X5/vSn3dMtrFHjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715706444; c=relaxed/simple;
	bh=EVeLEj7Jswi8cg76AHCqyTRfsBAkt5bp4by2FNUmIwg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cy/q13un1DZ8DStzwUVrei3T+FYXA9T3r4Nx5TBu4ob3H647lkCTigR/zE17seQqSduX+e0bciQ+pRQW9pvbhakjT+LqCeOmnlI9BhylKQxy4q1deeBjar1x0Ow6JCrVGHUprt1X4hDDCReuFk97ro4dJnbVJVzhQu5wRx1pY2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=W0ZSfUzf; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-56e48d0a632so623662a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 10:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1715706440; x=1716311240; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3yZqNPwvXDORKPUW8oFHYhpNWnQ0WTMGBEW6etUKrK4=;
        b=W0ZSfUzfXXcRjz9699/BmTypgqAimzUMIXkvCdHDk5wH+2TX+kdf1NrJ6Z92Wp9ITx
         Z5EtC0PcoL97GKe++s4brT4oNXh1pl+I+JkTjvQgd1bf0sacquN6rBoG5TMCu9UiOf1O
         KL8vuWiiIOguVYk2DImIbKhHSz812eOsifouk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715706440; x=1716311240;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3yZqNPwvXDORKPUW8oFHYhpNWnQ0WTMGBEW6etUKrK4=;
        b=FhbI/vbZ2OZPuADmEGS/B7dDvEiKvOqP5SO7kLQQzDb5Nxe3WnLKwSBusTD4zqCizt
         MjI+JJ63q2IRm0n0A5lbz5uiNggOv1190ReQbkTFaSiDfSvekGjvWF7dL2a/Z58fpv9K
         0w3lW/IQ7o6h5Bcfr0saluayLei3Tq2kboN/sa94qfV+EXbVyLc1Kfn7eJObDe8p5B1m
         kGajPxdVUSPw8aZn9m4iIEnMj4VQILm5qDesDzrKa/Z0iQCjd/vJ/W/BvNKERCDTITYu
         Fje/1qekRWgyOBmWBbCgp8iTchQcEIu8bFydy7wrgNgSKh/q7jxvVPCI5K+elsVaqGpQ
         t0pg==
X-Forwarded-Encrypted: i=1; AJvYcCX1d7co4kX+u/Dgsj3z1jVHOh/v03luwjaYqeJaxMZGDragrLS5IgiPAQacHRUR3Ykjh4PCgomTqJXfkXpOJ5FkPjRff9obB9fwPcR6
X-Gm-Message-State: AOJu0Yx3Zg59p8ZKTW+Ku7UXne2nCdFehctOcDP+yCehPP7bTkaO4Sk7
	qjyK9xoFoNfJZUJhydX8AQ4JW3LRUhYcekmX9//ckCTEv2x6+6LlNzQBmZq1dnX8HH38Lx04Yqf
	N9o7mYg==
X-Google-Smtp-Source: AGHT+IHeaR6qBVe4BMYihlijYuWp4XyeQdpxxdCyrGLJvqNioy+9mDicos07AUM6NQ22x95Ho1dntA==
X-Received: by 2002:a17:906:c78c:b0:a5a:1b60:7c9a with SMTP id a640c23a62f3a-a5a2d676415mr1214843366b.71.1715706440421;
        Tue, 14 May 2024 10:07:20 -0700 (PDT)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a90d0e919sm18459366b.85.2024.05.14.10.07.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 May 2024 10:07:19 -0700 (PDT)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-56e48d0a632so623621a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 10:07:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUWW4qNxuD5p/64nZ0Mj6Htz7xs454eaidy8gEE5B3gSRh2QiNe84H6Q6XfglReeHR1vOm1R7QTI2je+Shv+n2p0BCHY9ltMbaUSH3L
X-Received: by 2002:a17:907:35d4:b0:a5a:7d28:54aa with SMTP id
 a640c23a62f3a-a5a7d285594mr320156966b.23.1715706439246; Tue, 14 May 2024
 10:07:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=wi1T6wq1USBfU=NjdpSaTiKzV4H2gnUQfKa_mcXqOSk_w@mail.gmail.com>
 <CAHk-=wjmwmWv3sDCNq8c4VHWZUtZH72tDqR=TcgfpxTegL=aZw@mail.gmail.com> <ZkMKvAnyOR3_cJnS@wunner.de>
In-Reply-To: <ZkMKvAnyOR3_cJnS@wunner.de>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 14 May 2024 10:07:02 -0700
X-Gmail-Original-Message-ID: <CAHk-=whRK3wdMoUd7UOL-R8GcfwYYLsy26ft-kHv5WaofyYe=Q@mail.gmail.com>
Message-ID: <CAHk-=whRK3wdMoUd7UOL-R8GcfwYYLsy26ft-kHv5WaofyYe=Q@mail.gmail.com>
Subject: Re: [GIT PULL] Crypto Update for 6.10
To: Lukas Wunner <lukas@wunner.de>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Crypto Mailing List <linux-crypto@vger.kernel.org>, Julia Lawall <julia.lawall@inria.fr>, 
	Nicolas Palix <nicolas.palix@imag.fr>, cocci@inria.fr
Content-Type: text/plain; charset="UTF-8"

On Mon, 13 May 2024 at 23:54, Lukas Wunner <lukas@wunner.de> wrote:
>
> On Mon, May 13, 2024 at 03:12:53PM -0700, Linus Torvalds wrote:
> >
> > > https://lore.kernel.org/all/202404252210.KJE6Uw1h-lkp@intel.com/
> >
> > looks *very* much like the cases we've seen with clang in particular
> > where clang goes "this code isn't reachable, so I'll just drop
> > everything on the floor", and then it just becomes a fallthrough to
> > whatever else code happens to come next. Most of the time that's just
> > more (unrelated) code in the same function, but sometimes it causes
> > that "falls through to next function" instead, entirely randomly
> > depending on how the code was laid out.
>
> Curiously, this particular 0-day report is for gcc 13.2.0 though,
> not clang.

Hmm. I think all the previous reports of "falls through to next
function" that I have seen have been with clang, but that is probably
be selection bias: the gcc cases of this tend to be found so much more
quickly (because gcc is still more common at least on x86) that by the
time I see the reports, it's because of some clang issue.

And in fact, when I go test this theory by going to search on lore, I
do see several gcc reports.

So no, it was never just clang-only, it was just that the ones I had
looked at were about clang.

> The assume() macro had no effect with clang when I tested it.

I suspect that the issue is that with *normal* kernel configurations,
the code generation is simple and straightforward enough that gcc did
the right thing.

And then some more complicated setup with more debugging support
enabled (particularly things like UBSAN or KASAN) the code gets
complicated enough that gcc doesn't do the optimization any more, and
then the conditional in assume() doesn't get optimized away at an
early stage any more, and remains as a conditional branch to
la-la-land.

And you actually don't even see this as a warning unless the
la-la-land happens to be at the end of a function. IOW, the "branch to
nowhere" _could_ just branch to some label inside the function, and
the objtool sanity check would never even have triggered.

That's why "unreachable()" can be so dangerous. It tells the compiler
that code generation in one place no longer matters, and then the
compiler can decide to leave things just dangling in odd ways.

The code presumably still *works* - because the actual conditional
never triggers, so in that sense it's safe and fine. But it's still
just horrendous to try to figure out, which is why I was so down on
it.

              Linus

