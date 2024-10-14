Return-Path: <linux-kernel+bounces-364136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AE4D99CB88
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 15:24:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C9731F21DF4
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 13:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFC6F1AA78D;
	Mon, 14 Oct 2024 13:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ncng1wVS"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ECEA4A3E
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 13:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728912274; cv=none; b=gHC7YOc/OeIDnTs3mVVYc4vFMFauFQ4+fBmdX/wv6lfjJIl+9yM/88JxipJRRTkCBRWxDZOCs/p5R6eM9WM0r6TEQTZmIDF2I1DvR3czTkhwtMSJzuJoICYqjcSjlAVjB6ofzKnbyKlvM1jTQDV+Php0bUbz3h0V5WWLqkP0Wv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728912274; c=relaxed/simple;
	bh=xrXhQABRV81Vzx7GWZwk0fYd1nj6Scg5+6f67OlamiM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nSmvcthltUjnPy58vQg8eI81lb1GJAO3h4xDWOMmzRtW0DM4nAAwKRWSgi89qUkw5p8VrAc9UH6t4xKl0gpVjCw4NsaRXZQkiku9MGzbeQgu5e9npzl3w7aZxjYl9TxS8k7WYmhc6Pc95qdfRCb0GrscG7NQ/PiebKNFGA7dGN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ncng1wVS; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2fb58980711so3533211fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 06:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728912271; x=1729517071; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n5KhJAw2py2gNyB51ij4Ahm4Pf+WITFslqbmQTWMfBg=;
        b=Ncng1wVSaOWNe/9wdzgZdT0OYyRsNgexuKEVCT3R159fAHzsH+vSaM1MzoiRv1lQ4i
         WQdvCWsfxPd5hAeh96FWhmpnmyBulNmjMypl7GE1Viwt96yPZaNYXpv1mTfD8O7ZAqIS
         iB3D/wtBZhko4UcQlNvA6uDIBrNP7Tl3rs2BDn4w5rAG6BwcdfhnEatvuL5yqdc3Ks7f
         m3bcJXeBh+L6pHaBg1IRVni8OAcWYggm34niuov8AFjGz7MIter8p0t/ZA1qDG0SAiR9
         QoGkfmwwKwvcj6Yd0DkwAngY4eVz1UTn70FW79+0P6VhJfptm+PiAKEmP/Tavj+cdGyc
         q+VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728912271; x=1729517071;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n5KhJAw2py2gNyB51ij4Ahm4Pf+WITFslqbmQTWMfBg=;
        b=vsYthgpQ9nfBvkuthFw61bn3b3WzQA97N+kcHHwa5dx4HTFRL82G8shl6JdJlNAPnn
         JjJZaPAxlFo1e+zCkj8k2SsewaCEA6Xo++v2ebQ+PAYBzCw0jU6p0RR2b+sWMcg8XuMJ
         V0N9Uj9po2yg2Eukeu+xr9aqdbFHiSVBQi8mMydbz2m+0NPL6+S/GIrV711osfNVYcYU
         uTTvYb8e77Xwuqv30ks9R9jXAIbeBBvvU+7n1m7VSNwJg/00XRpdXJNWSsS6zNWug3Pf
         SqRATBbOHa34jFxGFMpRkbOgTt82LLXWqu5natnNLmDaIvphg1Av5JSzlbiGDZE5+b2Q
         2pow==
X-Forwarded-Encrypted: i=1; AJvYcCWMOYbiUj4xBliCKlR7np17JUnSxPC+OPxNCiTYeol2FC5gJYfPfyNsdm/SfnTfDvMhsGuNnN1Il4W/VOE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7hJEynZzrvJtzZY6wngFoKiEEPmn5/aLye8DlA9Rcp0XH3uRQ
	BMKo/UcpF1AKJgLFn4/5m5EQTlL07KSg6aRLp6pk/nfgLrAh7gbYXuymxgKXLF6btkgcdJNo4Pr
	+bUdzcJpEsfedRYOu65hsrrIeNZY4+Qw2pcZW
X-Google-Smtp-Source: AGHT+IENmU+8gZcd0n4/BWk5Du8tBT6NpXgwJWpHkzCIHdhxUpyy+q2TmAGvGdxix2OqIXBk9jSMIBaz2UmZY+T6C2A=
X-Received: by 2002:a2e:b8c1:0:b0:2f7:90b8:644e with SMTP id
 38308e7fff4ca-2fb326ff6b6mr53795831fa.1.1728912270535; Mon, 14 Oct 2024
 06:24:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241012225524.117871-1-andrey.konovalov@linux.dev>
 <CACT4Y+YS4UTMwk_j+Fjah3bCQd0zFcr2XqsUJ5K8HC991Soyhg@mail.gmail.com> <CA+fCnZfkurMxTyf0ivF8uffeO+S0piqFuZ975SSxmjr_V2OrHg@mail.gmail.com>
In-Reply-To: <CA+fCnZfkurMxTyf0ivF8uffeO+S0piqFuZ975SSxmjr_V2OrHg@mail.gmail.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Mon, 14 Oct 2024 15:24:15 +0200
Message-ID: <CACT4Y+aPjTmFRA58ewiHOaxUFxh1w_OwHj00GRjuPSBgA9ZyCw@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: kasan, kcov: add bugzilla links
To: Andrey Konovalov <andreyknvl@gmail.com>
Cc: andrey.konovalov@linux.dev, Andrew Morton <akpm@linux-foundation.org>, 
	Marco Elver <elver@google.com>, Alexander Potapenko <glider@google.com>, 
	Andrey Ryabinin <ryabinin.a.a@gmail.com>, kasan-dev@googlegroups.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 14 Oct 2024 at 14:51, Andrey Konovalov <andreyknvl@gmail.com> wrote=
:
>
> On Mon, Oct 14, 2024 at 10:08=E2=80=AFAM Dmitry Vyukov <dvyukov@google.co=
m> wrote:
> >
> > On Sun, 13 Oct 2024 at 00:55, <andrey.konovalov@linux.dev> wrote:
> > >
> > > From: Andrey Konovalov <andreyknvl@gmail.com>
> > >
> > > Add links to the Bugzilla component that's used to track KASAN and KC=
OV
> > > issues.
> > >
> > > Signed-off-by: Andrey Konovalov <andreyknvl@gmail.com>
> > > ---
> > >  MAINTAINERS | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index 7ad507f49324a..c9b6fc55f84a6 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -12242,6 +12242,7 @@ R:      Dmitry Vyukov <dvyukov@google.com>
> > >  R:     Vincenzo Frascino <vincenzo.frascino@arm.com>
> > >  L:     kasan-dev@googlegroups.com
> > >  S:     Maintained
> > > +B:     https://bugzilla.kernel.org/buglist.cgi?component=3DSanitizer=
s&product=3DMemory%20Management
> >
> > Do we want a link to buglist.cgi, or to enter_bug.cgi, or both? =F0=9F=
=A4=94
>
> I think buglist.cgi makes more sense - people can check the list of
> existing bugs before filing a new one. Finding a link to the right
> enter_bug.cgi page once you know the component name should not be hard
> (but IMO Bugzilla should just provide that link when viewing bugs for
> a component).

then
Acked-by: Dmitry Vyukov <dvyukov@google.com>

