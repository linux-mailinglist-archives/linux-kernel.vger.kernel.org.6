Return-Path: <linux-kernel+bounces-399776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 817009C040A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 12:31:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABE421C212B2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 11:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3E492071E8;
	Thu,  7 Nov 2024 11:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iiv3jC/I"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6167E206E86
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 11:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730979107; cv=none; b=enyu4dyCT0UtA7INSdrHchogofqxAUwSwuzsWfiurl565+zfPxHJXbWnoXaxz4gQ/zALzsr0T8Br/I753ccRQEnRh8048No9/62Uyl7mtBsYrWRKoR0wQ1jpLaGew1UoiQvreGTPEhSLM/B6/2p9pWYbwRV/P/poOYTDGyV8OsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730979107; c=relaxed/simple;
	bh=vlhXP63gbnV/K/hBWN1l2+GmMFmUfhLS4EbRLQRpP08=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tc2bByC9C5OJxaH1zcH/PSage2XLGnB0HJPw/su4eTXV1+qa+Y2n/V9aYFFeRHI3tq1mJ9I5rYHYNWSCZw8RSe1wvOMwkedCiKknezdX/VUSbtTc1J+7ehoN0aL2AWjJP0unVH+bahvYYyOuyii3RxsBohNmL9deay4JKp5/Zyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iiv3jC/I; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2fb388e64b0so8035441fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2024 03:31:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730979103; x=1731583903; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QndIZJRv3FtA+5X9SUDAUUy4yK+Ln5u7KvBfyyMUAGE=;
        b=iiv3jC/IlL5Ig0B5gGVz7dj+/C8PDrMxG+9/1w5HRpuK4cZ2r8ByH8zG/c+ykX1560
         Yh56DA4g15P3xkXpFJyh3Q3CqZmkR5d9Gy0uusqJaMb1Dq/pmtdZxU4r52JxHX0nhk80
         BhKV1ka3xcj9dPi/qAVpNpPFgzrB9xEChOHnMlx83d5gtiChVr3mqgnw5Dlu8rbwmbph
         71aXUW6lY1+f/GBdbcGBsVYhn+l16BKrP8E+fIJjG6DZ9e3FU+mtKzOOv38mXO+11jkz
         hPCCidcM3Us5I82Xy3LhLxmsr4Xv0GSH6Xz4oHB8odsW03BhSH5Q7pAcQjZqj2iOgF6E
         NMzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730979103; x=1731583903;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QndIZJRv3FtA+5X9SUDAUUy4yK+Ln5u7KvBfyyMUAGE=;
        b=FZIOZbZUGW1fnWkBaLrCquoBDrRVHwXRiWAn/CiG8uNCC56qLdtoVg6i3c6BrNjR2v
         uxTA7gWTOHZzVoe0Q5/fYRA7qI04N+2O2pYwAJvHlz0/LOMFxzYImd8Qs86tCT+pZ5oi
         4kWEzZiIBb/jEEegHJZon07MMBLqyvuYPdow+TZqfFaOW02csCO26KPRlFgGhbbjloQM
         u7mxXx6Afl6AOoYoJa641t/oixg+gt4nq24Fu3Vwwiw+R+CkriZC8CqZyW9uJHFh/HZ6
         7rKsh2u8ZMhzvTINGM26JmTJ0GYSa4oZvEIz5C+a/rR79S9rFA//jhH6KskE/m+7UVw6
         QRxg==
X-Gm-Message-State: AOJu0YxHx2S0mEdagrekcxlzPhBxwJcVl91wqmPScd/Lgaf0wLMs0l97
	P8XiV/mIG0GRSrV6yuEIUoS1TNVfenAjs27mi5P/uBmtHZG2CDaL/fRkhLLLE67w/gILbRtscGO
	0LXspfm65z05IUFOBhMLByBt5MsgL5Itkgc0=
X-Google-Smtp-Source: AGHT+IGkaRFch6NSXDd+qejuzlUgO5KS7DZQn5ujAfSsGzuResH8S0Hv0LZ8hfJrw3t4Vgb7okj1j2IHmBHxhfb9YOA=
X-Received: by 2002:a05:651c:b2a:b0:2fb:382e:410b with SMTP id
 38308e7fff4ca-2ff1a9e18c5mr6462641fa.32.1730979103187; Thu, 07 Nov 2024
 03:31:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241105155801.1779119-1-brgerst@gmail.com> <20241105155801.1779119-7-brgerst@gmail.com>
 <CAFULd4b9RqWD5uaZEzejQfzJ4cH85sCgbTaHJdg-qJ-OaLJiWA@mail.gmail.com> <CAMzpN2i6MM27Pb+82rPN8FuBn4B7HZOZdaPdP2eNRS9FJZ-GGw@mail.gmail.com>
In-Reply-To: <CAMzpN2i6MM27Pb+82rPN8FuBn4B7HZOZdaPdP2eNRS9FJZ-GGw@mail.gmail.com>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Thu, 7 Nov 2024 12:31:31 +0100
Message-ID: <CAFULd4Y=7WgtkzYds-FJ1fkjNC72ArCkRpvyXkEWEtxoY=MAhw@mail.gmail.com>
Subject: Re: [PATCH v5 06/16] x86/relocs: Handle R_X86_64_REX_GOTPCRELX relocations
To: Brian Gerst <brgerst@gmail.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, 
	Ingo Molnar <mingo@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Borislav Petkov <bp@alien8.de>, Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 7, 2024 at 12:27=E2=80=AFPM Brian Gerst <brgerst@gmail.com> wro=
te:
>
> On Thu, Nov 7, 2024 at 6:20=E2=80=AFAM Uros Bizjak <ubizjak@gmail.com> wr=
ote:
> >
> > On Tue, Nov 5, 2024 at 4:58=E2=80=AFPM Brian Gerst <brgerst@gmail.com> =
wrote:
> > >
> > > Clang may produce R_X86_64_REX_GOTPCRELX relocations when redefining =
the
> > > stack protector location.  Treat them as another type of PC-relative
> > > relocation.
> > >
> > > Signed-off-by: Brian Gerst <brgerst@gmail.com>
> > > ---
> > >  arch/x86/tools/relocs.c | 7 +++++++
> > >  1 file changed, 7 insertions(+)
> > >
> > > diff --git a/arch/x86/tools/relocs.c b/arch/x86/tools/relocs.c
> > > index 6afe2e5e9102..7d7fc7f0a250 100644
> > > --- a/arch/x86/tools/relocs.c
> > > +++ b/arch/x86/tools/relocs.c
> > > @@ -32,6 +32,11 @@ static struct relocs         relocs32;
> > >  static struct relocs           relocs32neg;
> > >  static struct relocs           relocs64;
> > >  # define FMT PRIu64
> > > +
> > > +#ifndef R_X86_64_REX_GOTPCRELX
> > > +#define R_X86_64_REX_GOTPCRELX 42
> > > +#endif
> >
> > The next patch (7/16) introduces the above definition to
> > arch/x86/include/asm/elf.h. If you swap patches 6 and 7 in the series,
> > you won't have to introduce the above conditional definition.
>
> This is a userspace tool, so it's using the build host libc headers.

Ah, indeed.

Thanks,
Uros.

