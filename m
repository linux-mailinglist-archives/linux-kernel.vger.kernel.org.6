Return-Path: <linux-kernel+bounces-225504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8256F91317A
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 03:57:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3D8E1C20F57
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 01:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5584A63D5;
	Sat, 22 Jun 2024 01:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="TKyxwey8"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A637137E
	for <linux-kernel@vger.kernel.org>; Sat, 22 Jun 2024 01:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719021427; cv=none; b=aefjhLlpJbuK2jvmkayKwwbzOc9xcUGV2HxVJIO7hQOSIAyhOugquM5Qeov41kRuhNMYAHbONn2XReo3qn3WX7W/kgIUePubUES7KLZnd0pvSXYn+hzJnPjI3yf/Icw82lkLVbnVvf/FV+GtQww3LmFsmw+0yYLMwLtBq8Nc2w8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719021427; c=relaxed/simple;
	bh=8zqEXze3fEHr+zCqxux/Dy6aUVh/dIgDy21TaXzMbTI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jc2jw2THzNPsvwQc88ZYlZ81zq0CUv7MjLyL6bhswcaIjsxwOP4Fhcfu1CPDulI+SlO41Nl5r6wUs6gRmAvTS1EiNKy1zVo2T11Qzxnw2k0GH39ReRWLAt0LD+K+kY31pHU0I0k9wNidEtQQRqnLivw52N+uFY020V++YFBd9VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=TKyxwey8; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2ec1ac1aed2so30028221fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 18:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1719021423; x=1719626223; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wKHMfbyDfNXzhbJefDVMkuCyrSXAHynzAEUW3BjE6BE=;
        b=TKyxwey8zwvJey3oinz8ysJoZLoPEWiXH+mZ2gIXmHGtPcEb7PQns/q5NKt9Br+Fxn
         1Z6sEonepPK0b3tJIUdOXHREMv6iDtqE8CtalOVyDw2yb5ylIqIYd33JZozH0xda4qan
         xzWJSyN0DxJvZdnrxxAmAyfGH5EytLKKrn2g8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719021423; x=1719626223;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wKHMfbyDfNXzhbJefDVMkuCyrSXAHynzAEUW3BjE6BE=;
        b=eBL77H/pvBnu9vYDWNakZ6/4DfoViM65a4wuU5zabMhAoAP0GZNDUOvRr5MKjHhEdt
         TzRGuLE6LvKUgjNs4Qe507+FZXoUITQZxGhqzPsSJnpTm2FlmjhqmiCXum9WXBgnVkiW
         oBbAhlPYcl+2aOvV+s8NHE3fpieAgToJbNvjkeRCIWFwH4gJ9DINMAHYRrmStIyg/ArO
         /YJw3h7mHH2GyvXHTDbF2XaKb9sTnofKHZch61Zien4eLHw6H0ecaj6ufK6HnjoYR293
         OF2Yya+llgaFmNMpTb3qZUv6ajEQzFQYjjeUwhM57EGSp/rN7jCCSVp56/0sMjsqyniL
         iEmw==
X-Forwarded-Encrypted: i=1; AJvYcCUVHbYUBbzNWmkym80W6UHSFjvyuPCqu5VI5qX+PrDm+bRFXZqLX+OcUpVHJwtxH2k0toVCqwb1xUYf4xtBLo0U1TuXkWjxuvZHok6X
X-Gm-Message-State: AOJu0YxmqzJto9WPjmvCnoQ5NTM/TOyfT62DpEztj/EOhSF18jUQr+wu
	8ID+lyQf0666zn0CUNcDJsf6j8yUtoTR+qz3B54gEexYhiY3NxG0yGksV1+wa6e/w3b5Se+aDbS
	l3+Xc7Q==
X-Google-Smtp-Source: AGHT+IHakm+C/oICJBIuLq2/atoiZPqmZGeiajkcD8AJ4pUqUG17aIVgAHgWmjm3NZzP9L044SaGhw==
X-Received: by 2002:a2e:8346:0:b0:2ec:18e5:e68f with SMTP id 38308e7fff4ca-2ec3cff2e5cmr59783441fa.33.1719021423222;
        Fri, 21 Jun 2024 18:57:03 -0700 (PDT)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ec4d70b1ebsm3389051fa.57.2024.06.21.18.57.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jun 2024 18:57:02 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2ebe6495aedso25955331fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 18:57:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUQzJdhcnXdp76vvP3bGlbTBmsGrHK/ZhAzAIkSRC/ytA7ySO8r3n/kZdbhxfvXvvUM/jzr6kcji4pWmHbJoNBtSaepCVIq55P83G/u
X-Received: by 2002:a2e:a409:0:b0:2ec:4d98:c9d6 with SMTP id
 38308e7fff4ca-2ec4d98caa9mr19638211fa.29.1719021422276; Fri, 21 Jun 2024
 18:57:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <317d2de5fdb5e27f8f493e0e0ad23640a41b6acf.camel@HansenPartnership.com>
 <CAHk-=whEQRH6eS=_JwanytAKERuWO1JQdzRb4YiLK4omzL2J-Q@mail.gmail.com> <yq15xu1oo3e.fsf@ca-mkp.ca.oracle.com>
In-Reply-To: <yq15xu1oo3e.fsf@ca-mkp.ca.oracle.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 21 Jun 2024 18:56:45 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgLGuYSgbS90MMudryOOjuWYeXaXGeGJRg9SVy1GmLKcQ@mail.gmail.com>
Message-ID: <CAHk-=wgLGuYSgbS90MMudryOOjuWYeXaXGeGJRg9SVy1GmLKcQ@mail.gmail.com>
Subject: Re: [GIT PULL] SCSI fixes for 6.10-rc4
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-scsi <linux-scsi@vger.kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, Bart Van Assche <bvanassche@acm.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 21 Jun 2024 at 18:48, Martin K. Petersen
<martin.petersen@oracle.com> wrote:
>
> The specific problem with mode pages is that there is no way to know
> whether a given page is supported without asking for it. Whereas for
> most of the other things we query at discovery time, the device provides
> a list of supported pages we can consult before we attempt to query the
> page itself.

Yes. I know.

But I also know that pretty much *EVERY* time the SCSI layer has
decided to start looking at some new piece of data, it turns out that
"Oh, look, all those devices have only ever been tested with operating
systems that did *NOT* look at that mode page or other thing, and
surprise surprise - not being tested means that it's buggy".

> It is a new feature in SCSI spearheaded by the Android folks. That's why
> there isn't a lot of information available about it elsewhere.

So no wonder random devices are buggy.

And I'm not putting down random devices. Quite the opposite. I'm
stating a well-known fact: untested things are buggy.

And no amount of "but but but it worked for me" is at all an argument.
If it hasn't been tested, it's almost certainly broken somewhere.

We've seen this over and over again.

> I am super picky about having good heuristics for when we should attempt
> to query a device for new protocol capabilities. In this case we lacked
> a reliable indicator that the feature was supported.

My argument is that things should be opt-in.

If it wasn't needed for the previous 30 years go SCSI history, it sure
as heck didn't suddenly become necessary today.

So you literally NEVER DO THIS unless the system admin has explicitly
enabled it.

That's what opt-in means.

And honestly, then the Android people can decide to opt in. Not random
other victims.

What's the advantage of just enabling random new features that have no
real use case today?

Put another way: why wasn't this an explicit opt-in from the get-go?
And why can't we make that be the rule going forward for the *NEXT*
time somebody introduces some random new mode page?

That was my ask.

           Linus

