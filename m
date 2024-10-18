Return-Path: <linux-kernel+bounces-372396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5808B9A480D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 22:33:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC5FA28592E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 20:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64F5D20A5D8;
	Fri, 18 Oct 2024 20:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KFB0lzL5"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E10212657
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 20:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729283498; cv=none; b=CHTwleQVkV2GDyf/cY9bMokX9kxXUkTRWZBPCLsD1PxLw7bhdtwVJk/vXAnOBMweYYg2fsvyjNOhFOJO3MzVlRaPsTPPjGy+OdwivMkbpqtUUENjrAKI/f+zTxjZBifVkxXhFOx0axrIg0paPaWb79NFsBFPko+9P5s6W5+w/+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729283498; c=relaxed/simple;
	bh=/hkrKxbX4L11Q8kvBCoA1rTCd+a/GyUcSxHLmASsrPg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QUA195JGMGDgyOgkQjJs+1Asa9xj00ILSWjDME36At/CAC15O+6U/MbXYG69+yq/AOfXtvovPkoKoP5i10XvUWYNOF55xuW6yp91g+8XISdAZZBX8VY7YpnO8QnLXO7bH2HOs2oX53L0BHBPh+/u88bl/7JE1tZHdiKAvJWp1m8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KFB0lzL5; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2e2a999b287so1984015a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 13:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729283496; x=1729888296; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GCZHBsLr9Yv/sVgX6G+ehlGmplsS8D5LjwzJdkkRRMU=;
        b=KFB0lzL5Z4ndEFOrYHxhjhsYVRn+OxPy342Sbt19Glg8TtJfe38amx8nBcKlMMlgen
         38WKZ5IjyGO5IMqvvZuU446McX1plqIDvsUch7PhkNwEJdasuPYm1yXfjPBcgLJr+/Pt
         /r0JTHICp0yNGMNJNN9/VOjA2nv3vqJM6q2Lp8+sfcdS3n/Am/OL4zYbRp6gawq4h0vR
         Mo9nhr84p1kX8H8MHBYVZ3kpm4wXAQpyZOn35SlUBJIVo71D304YGCxLCui82kcvbRey
         IAaNzqbDknmzT6lnJqey+bkJQAM4iHkz7jJw5K3FMk9+OUJX7U0NJuOkuYJ8plOQ+JKK
         DG4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729283496; x=1729888296;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GCZHBsLr9Yv/sVgX6G+ehlGmplsS8D5LjwzJdkkRRMU=;
        b=AlzstgVNW7HjZDUcqd2Kru81jt+rTB8c+hYDQJ82xijiDLmP3HBJPk6DN7OSOpzt+b
         DF5GTdeHLy3+beIO7fQszxa5yL+EqwZfd5cOCujqo+zmIlw6edBdtXQoEYt0ZppcaI8c
         pAGH+Yhz8Y7Jzj6RQLDEJN9gOZKIfVjSaKvoBn8OJZnXoeM/ks/IwlqUotKtl/9qWOpb
         DsO6mkI/IAN9uiV949RV5NqQTw2JfG+0kYmoAK0yyYm6ud36gtaPHOdSVM36iAq3HDWx
         OFOWtYv+oO0GPfASB2LHBCMOhXp4iSxSOCJ3/cVfS/nbvK28scQfoPvhXOlbRal4E1XI
         +OHw==
X-Forwarded-Encrypted: i=1; AJvYcCUX/hT9+wATXfJmG8jYaAasCxqCeupMCpP1gPiVfUsGQhsQ32OR9fUlrAjIGkgu+JqY1hPoVvOtzftoLcc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMeEAkbLaH+8i+MX9A6IweVp2LwmtRv5gH6eBol2B//Z47FVPx
	7usAO8yif23A75qIl2CB4U8ay9nb4+jLnezaPYLPuA9Ufu61wjrnRKG0RVEnSdT3S0w+TPsaLd5
	4TArccAGL1qGe2SPjUXnAnUxMrlWBbscf4n6G
X-Google-Smtp-Source: AGHT+IHSVD4x+mqs1tyMEE9UIJZAplC7Zu6gX9MpXIl9VwGRNb8uGusk3IDg4vv0CqIfjCaxeP4oRFI8S87Vv9ywv3Y=
X-Received: by 2002:a17:90b:4d0f:b0:2e2:cf5c:8ee8 with SMTP id
 98e67ed59e1d1-2e561612dcemr3965121a91.12.1729283495614; Fri, 18 Oct 2024
 13:31:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014161100.18034-1-will@kernel.org> <172898869113.658437.16326042568646594201.b4-ty@kernel.org>
 <ZxIeVabQQS2aISe5@elver.google.com> <CA+fCnZc4iNa_bxo8mj52Dm8RCKAW=DQ_KUSKK2+OzjmF3T+tRw@mail.gmail.com>
In-Reply-To: <CA+fCnZc4iNa_bxo8mj52Dm8RCKAW=DQ_KUSKK2+OzjmF3T+tRw@mail.gmail.com>
From: Marco Elver <elver@google.com>
Date: Fri, 18 Oct 2024 22:30:57 +0200
Message-ID: <CANpmjNP5Sny0Xj0JeHU8SFFsNvgnQQ7-c3PGDmiH9RVnUF5YTA@mail.gmail.com>
Subject: Re: [PATCH] kasan: Disable Software Tag-Based KASAN with GCC
To: Andrey Konovalov <andreyknvl@gmail.com>
Cc: Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	catalin.marinas@arm.com, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, ryabinin.a.a@gmail.com, glider@google.com, 
	kasan-dev@googlegroups.com, Mark Rutland <mark.rutland@arm.com>, 
	syzbot+908886656a02769af987@syzkaller.appspotmail.com, 
	Andrew Pinski <pinskia@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 18 Oct 2024 at 22:25, Andrey Konovalov <andreyknvl@gmail.com> wrote=
:
>
> On Fri, Oct 18, 2024 at 10:37=E2=80=AFAM Marco Elver <elver@google.com> w=
rote:
> >
> > > Applied to arm64 (for-next/fixes), thanks!
> > >
> > > [1/1] kasan: Disable Software Tag-Based KASAN with GCC
> > >       https://git.kernel.org/arm64/c/7aed6a2c51ff
> >
> > I do not think this is the right fix. Please see alternative below.
> > Please do double-check that the observed splat above is fixed with that=
.
> >
> > Thanks,
> > -- Marco
> >
> > ------ >8 ------
> >
> > From 23bd83dbff5a9778f34831ed292d5e52b4b0ee18 Mon Sep 17 00:00:00 2001
> > From: Marco Elver <elver@google.com>
> > Date: Fri, 18 Oct 2024 10:18:24 +0200
> > Subject: [PATCH] kasan: Fix Software Tag-Based KASAN with GCC
> >
> > Per [1], -fsanitize=3Dkernel-hwaddress with GCC currently does not disa=
ble
> > instrumentation in functions with __attribute__((no_sanitize_address)).
> >
> > However, __attribute__((no_sanitize("hwaddress"))) does correctly
> > disable instrumentation. Use it instead.
> >
> > Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D117196 [1]
> > Link: https://lore.kernel.org/r/000000000000f362e80620e27859@google.com
> > Link: https://lore.kernel.org/r/ZvFGwKfoC4yVjN_X@J2N7QTR9R3
> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D218854
> > Reported-by: syzbot+908886656a02769af987@syzkaller.appspotmail.com
> > Cc: Andrew Pinski <pinskia@gmail.com>
> > Cc: Andrey Konovalov <andreyknvl@gmail.com>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: Will Deacon <will@kernel.org>
> > Signed-off-by: Marco Elver <elver@google.com>
> > ---
> >  include/linux/compiler-gcc.h | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.=
h
> > index f805adaa316e..cd6f9aae311f 100644
> > --- a/include/linux/compiler-gcc.h
> > +++ b/include/linux/compiler-gcc.h
> > @@ -80,7 +80,11 @@
> >  #define __noscs __attribute__((__no_sanitize__("shadow-call-stack")))
> >  #endif
> >
> > +#ifdef __SANITIZE_HWADDRESS__
> > +#define __no_sanitize_address __attribute__((__no_sanitize__("hwaddres=
s")))
> > +#else
> >  #define __no_sanitize_address __attribute__((__no_sanitize_address__))
> > +#endif
> >
> >  #if defined(__SANITIZE_THREAD__)
> >  #define __no_sanitize_thread __attribute__((__no_sanitize_thread__))
> > --
> > 2.47.0.rc1.288.g06298d1525-goog
>
> Tested the change, it does fix the boot-time issue #1 from [1], but #2
> and #3 still exist.

Thanks for testing.
AFAIK #2 and #3 look like false negatives, which are tolerable (not
great, but it does not cause serious issues).

> However, perhaps, just fixing #1 is already good enough to do a revert
> of the Will's patch - at least the kernel will boot without
> false-positive reports.
>
> But I would keep a note that SW_TAGS doesn't work well with GCC until
> [1] is fully resolved.
>
> Thanks!
>
> [1] https://bugzilla.kernel.org/show_bug.cgi?id=3D218854

