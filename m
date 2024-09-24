Return-Path: <linux-kernel+bounces-337501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69BA2984ADC
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 20:30:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E26B01F23E3D
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 18:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4320719AD9B;
	Tue, 24 Sep 2024 18:30:50 +0000 (UTC)
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84042941B
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 18:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727202649; cv=none; b=Dh4moExvIFLV7jwRZW1e4x3gqEK5S9JRjHrJHZushh4r151eogDvrbIq7mIMl6tUrPp7R3h9jMrG0dXm1LYykYgL9urAErMtvAWrtL+hHI3DrRMpeGc1TDUy5kO2f4y/LKFZVr8ZX7Yaki/kWkNLunAo7kk8flV7YyshyoT+o74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727202649; c=relaxed/simple;
	bh=2041O88pnFyo7/OpNVaEbZU93xHiy5WIVlFq/bvYPp8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FBNhRKTR3qKOPcnpsDkqDqJlfOyx2/Gp8dhnEJTSIrT4onjMFKqGDSZZNPsKYuRAEAx8eGcvSaYjWWT/WEo54RqmdkoAN+neP2y1aVNL0JGh9TkGtGB1GeNudZvKYWAbDJAsagzA1LACb+HoafLYPpJtiaZkFRcKmkeL9xuDrGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6ddd138e0d0so52213897b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 11:30:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727202645; x=1727807445;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ssSZLVcmWQPI2r6W9zv/izkjJpp9VFhZadtznC3xAi0=;
        b=oBYKzxfN845H8LTXXgRkBOls+u1yFE7vJdTZ4TjPm8sLTs7rD8ZSkUGQeqV5KyJt9k
         iCAvvATlTwancBnHHpZNmtTgCIGt/ljgN3JPHYOQMKvc4CHvUeAmGorRKr/L+uzuOQxT
         M+MaOH47MHnHVMCdbUdRCpbhEibRX+nEmEfQZooLY+Glc96tnTxHsf2OeYN1iXwizg7L
         ZAOMpVzkEuIBg8GmknofLTF4zXz0V23jhBVrouzkn2gtcvz2bcuBhX7Hde1SMW1uw/Lt
         Hk/fEJF69+6i56AtM4XAaP8g3ABNF7UkT7OUYF+IYUnqkXL25Gm04Op2ZAdq1+4go+m8
         TgLQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXorGCGyP42FLpQLMgw1ixgg7+om9A3n8i0pyU2ZpsMJEB4RSdTQJ5/imwqYWg1h6ku7WJtLmapAATe0M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEoh7urujyx9XUZPf1KwE9F4ZGNCL04wYv0fcWe0iunPbrqURS
	sq3f8UZDdJBgbw8zvVOu0c5hQTGJT+ulU1oCTDXFBfTxhGcilb2r0KlQe3e1
X-Google-Smtp-Source: AGHT+IEMzxiBjaSiQrzReBORRGF6GWLSJnA5yMHRtnjOybowmGOwMUin0qmyGPgu8qHT8XKvV7T3qg==
X-Received: by 2002:a05:690c:2a46:b0:6dd:76ce:d6ba with SMTP id 00721157ae682-6e21da1b620mr2689307b3.42.1727202645412;
        Tue, 24 Sep 2024 11:30:45 -0700 (PDT)
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com. [209.85.128.174])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e20cffe21dsm3318727b3.15.2024.09.24.11.30.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Sep 2024 11:30:45 -0700 (PDT)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6db836c6bd7so57342837b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 11:30:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVQUXRUENCjkAppAAKVeDYRbi+1yGChbihqme4GBsid+rWZncyImuKuRW/zf1+3HXkBAsMkW3Vf3IebiK0=@vger.kernel.org
X-Received: by 2002:a05:690c:3588:b0:6d3:da56:1387 with SMTP id
 00721157ae682-6e21d9b4f37mr4253177b3.29.1727202644472; Tue, 24 Sep 2024
 11:30:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <71d8f8448d29c3ce5a7fd883e56c0edeb2f4106b.1727185783.git.geert+renesas@glider.be>
 <CANiq72kqVFs5rfS_y0a40ZAygE5S+vkyb2Fv+B5BNzvuAa_hiQ@mail.gmail.com>
In-Reply-To: <CANiq72kqVFs5rfS_y0a40ZAygE5S+vkyb2Fv+B5BNzvuAa_hiQ@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 24 Sep 2024 20:30:30 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUwt9_zU_2ytSMOoB1VJqZYwonHTZd-bSzpXxRwj2+XfA@mail.gmail.com>
Message-ID: <CAMuHMdUwt9_zU_2ytSMOoB1VJqZYwonHTZd-bSzpXxRwj2+XfA@mail.gmail.com>
Subject: Re: [PATCH] compiler-gcc.h: Disable __retain on gcc-11
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Tony Ambardar <tony.ambardar@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	Miguel Ojeda <ojeda@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Miguel,

On Tue, Sep 24, 2024 at 7:21=E2=80=AFPM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
> On Tue, Sep 24, 2024 at 3:55=E2=80=AFPM Geert Uytterhoeven
> <geert+renesas@glider.be> wrote:
> > All my gcc-11 compilers (Ubuntu 11.4.0-1ubuntu1~22.04) claim to support
> > the __retain__ attribute, but only riscv64-linux-gnu-gcc-11 and
> > x86_64-linux-gnu-gcc-11 (not x86_64-linux-gnux32-gcc-11!) actually do.
> > The arm-linux-gnueabi-gcc-11.5.0 compiler from kernel.org crosstool
> > fails in the same way:
> >
> >     error: =E2=80=98retain=E2=80=99 attribute ignored [-Werror=3Dattrib=
utes]
>
> That appears to be the case indeed:
>
>     https://godbolt.org/z/78Gj94vMW
>
> The `.section` does not get emitted, so the warning appears to be
> right, but we cannot trust `__has_attribute` for this :(
>
> > Fixes: 0a5d3258d7c97295 ("compiler_types.h: Define __retain for __attri=
bute__((__retain__))")
>
> Nit: 12 char hash.

I should really update and resend my patch to sync all (different) values a=
nd
ranges spread across the Linux kernel documentation. And didn't we reach
2^24 objects in git a while ago, so conflicts are imminent?

> > +/*
> > + * Most 11.x compilers claim to support it, but only riscv64-linux-gnu=
-gcc and
> > + * x86_64-linux-gnu-gcc actually do.
> > + */
>
> Just to confirm: did you try all? If not, perhaps we should say "at
> least X does not work" instead.

What's your definition of "all"? ;-)

  1. All compilers available on Ubuntu 22.04LTS:

      aarch64-linux-gnu-gcc-11
      alpha-linux-gnu-gcc-11
      arm-linux-gnueabi-gcc-11
      arm-linux-gnueabihf-gcc-11
      hppa64-linux-gnu-gcc-11
      hppa-linux-gnu-gcc-11
      i686-linux-gnu-gcc-11
      m68k-linux-gnu-gcc-11
      powerpc64le-linux-gnu-gcc-11
      powerpc64-linux-gnu-gcc-11
      powerpc-linux-gnu-gcc-11
      riscv64-linux-gnu-gcc-11
      s390x-linux-gnu-gcc-11
      sh4-linux-gnu-gcc-11
      sparc64-linux-gnu-gcc-11
      x86_64-linux-gnu-gcc-11
      x86_64-linux-gnux32-gcc-11

  2. A few from kernel.org crosstool:

      ia64-linux-gcc-11.1.0
      sh2eb-linux-muslfdpic-gcc-11.2.0
      arm-linux-gnueabi-gcc-11.5.0

  3. A compiler from the J-Core folks:

      sh2eb-linux-muslfdpic-gcc-11.2.0

> > +#if GCC_VERSION < 120000
> > +#undef __retain
> > +#define __retain
> > +#endif
>
> Should this go into the conditional in `compiler_types.h` instead? And
> perhaps the `__has__attribute` test removed for GCC?

AFAIK, the gcc-specifics are in compiler-gcc.h...

> Even if we keep it here, I think at least a comment there should be
> added, since it says GCC >=3D 11 supports it, which can be confusing if
> one is not aware of this other thing in this file.

Fair enough....

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

