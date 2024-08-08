Return-Path: <linux-kernel+bounces-279954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 589E894C3D3
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 19:38:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FD5D1C2203F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 17:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C9DD191472;
	Thu,  8 Aug 2024 17:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QujyUa84"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F4413D8A3
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 17:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723138702; cv=none; b=VD6tDChiN2o0E/oDTsGIBRO02dfyoSbCA5WYDRtTBs9Ka/9H3UNhIO9ECpC5qigIZNDbgY2nOvx7z64cE5GPywFDeEdxGTGKZb0JN0sE6/DYi9U1ut9d90VzKKzfZ5cCI5YnECGs7JaGYJJ1+DEruc3UrHDD1O5pa2kfTh6nuZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723138702; c=relaxed/simple;
	bh=gnD/HT6O0crLNlUAz+OP0EZijUHm0EAnPKnEJo9bls0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i1qc+W3boUwT6IaIThQewjfeMfUhYWI/Z3BqqveUn1lPP34DtbbP096k2RPaGyBhRN7Pc13WJl9/vgfYj/KVRYlnaMjqqpdMVgmicxPzKQ1FbF5pqC7qZTBE4i3wEYO4Z0FYhgREamCgo1BEfomkZmdI+0r1ruW7lB+GckXkUDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=QujyUa84; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a728f74c23dso140806866b.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 10:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1723138699; x=1723743499; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4/eyEs7VGUKV5+tA+ktUUedwCkeY9RR2fMIgk//OJ+0=;
        b=QujyUa84IJHfP9BeV53xUMkEipAQeyzPyqg50JIhPj1D0IM8C1NrqSafYy04+UHkIF
         nWxbo4N60tEefJJkEkl8G4ictiRJ/0hrLRUjsM66bVyZ+4O0E8b+PQRPPHyBnZFjqSn1
         elTbPMg2l6jWgO372R1svKEAjdF3WP2G7fefI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723138699; x=1723743499;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4/eyEs7VGUKV5+tA+ktUUedwCkeY9RR2fMIgk//OJ+0=;
        b=WJkidomDehdvaZkaI3L/arrAefDL7R/dEXCg4xji3DklkA6VzYrltJM+zZ8YxZ/G2i
         9bffzh98NVcm6OKJoxxPmoXO5J3gzNNSZgp/almw4p0vDwpm9Ytp0o0t3I9olNwKel9A
         bpWp891FxSVlHKqNEZgs/zA4zwdYujZATMSiKA9QOGA2klt+FFxzTakH1nAAgkHBvOKH
         r/Zevje8acmynKfMMyTTEGBW81jtpHEp8q1XcKvp2jzMisUQEdBbTm8MW/sCQtk2Bqrr
         WR1stytqsQOUtZmp4FWIqGy2BcSVCclsmVxk3sIBjtteU6jk4RyZd3ubbIL0qipNh1I9
         xuzQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQrkyjdX5upiQKNt7mFviYiPNfvp8Hw2393sKopUL6m8fjctr9UQq5jxOSoYSKo+XPkLbcSIozB2v9Dbg6DjMM4e5245IZf1pvhnyB
X-Gm-Message-State: AOJu0Yz/42Fd7Jxrk0ShxuKdqIWCdMwUbj7HXD1sqtUbg9t3MRtpk5yu
	e/MG81nEB5+OV546L1a5RCAJeuS4YAeAk0ytuOurfCWwxD+JBMTW9YIYBTIFRpi65lAo3UpcQkw
	Zug==
X-Google-Smtp-Source: AGHT+IFAychwe474cZE2mwBqcG0ChwEXKPjizIpXAJD4vxdItWxwqC/0y3cLO65Na0zTWTsXuMI13g==
X-Received: by 2002:a17:907:f1d4:b0:a77:b784:deba with SMTP id a640c23a62f3a-a8090c0026bmr183926066b.6.1723138698841;
        Thu, 08 Aug 2024 10:38:18 -0700 (PDT)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9bc3ce6sm762441266b.4.2024.08.08.10.38.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Aug 2024 10:38:18 -0700 (PDT)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5bb85e90ad5so1098312a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 10:38:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUBHY/qCR9wof/W/e+Tk4vb30uNeqvsjKmEJv6cIKhLLj2rC0Tr6vCM3w7n7Uk0zBSk1uN17s498oGNaDiyTZ2o/P0Db1T6lPef+0Lm
X-Received: by 2002:a17:907:e64d:b0:a7a:9ca6:531 with SMTP id
 a640c23a62f3a-a8090beb612mr192822566b.4.1723138266201; Thu, 08 Aug 2024
 10:31:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230707191721.1.Id08823b2f848237ae90ce5c5fa7e027e97c33ad3@changeid>
 <b32ae8af-7950-c725-5632-6ec13420bf77@infradead.org> <6101a3bb-30eb-97fc-3a8e-6d15afc4efb5@amd.com>
 <3de1ff24-3970-6e22-a73c-70446b8de4bd@infradead.org> <CAHQZ30BLb13Mz5+3MCgV30eG-LiU-6-4F7AEinGQmsgiyzD-yA@mail.gmail.com>
 <ZLF5_dJyQgzNnrnO@alley> <CAHQZ30DjZE6Mg-KUrLQOLHh+OxNHZXRDkuZopxJb3F7G29TsXA@mail.gmail.com>
 <ZLGVYg1FAZN7VFxB@alley> <CAHQZ30Abpvm+__VK9oaU9eWwLKpiND+rmfjrPvF_R_09d2JqGQ@mail.gmail.com>
 <ZLZgZvE35fYCkgOq@alley> <CAHQZ30DQw9n=uiuz3-nqnOKVbZdp-=DfeSn2feoPL08RjYzT=A@mail.gmail.com>
In-Reply-To: <CAHQZ30DQw9n=uiuz3-nqnOKVbZdp-=DfeSn2feoPL08RjYzT=A@mail.gmail.com>
From: Raul Rangel <rrangel@chromium.org>
Date: Thu, 8 Aug 2024 11:30:53 -0600
X-Gmail-Original-Message-ID: <CAHQZ30AEuwUzJs0bjsZ4eisJhmG8zkrXx4eKnfGsJ1jBt=jTUA@mail.gmail.com>
Message-ID: <CAHQZ30AEuwUzJs0bjsZ4eisJhmG8zkrXx4eKnfGsJ1jBt=jTUA@mail.gmail.com>
Subject: Re: [PATCH] init: Don't proxy console= to earlycon
To: Petr Mladek <pmladek@suse.com>
Cc: Randy Dunlap <rdunlap@infradead.org>, Mario Limonciello <mario.limonciello@amd.com>, 
	linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	kramasub@chromium.org, Alexander Potapenko <glider@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Ard Biesheuvel <ardb@kernel.org>, 
	"Jason A. Donenfeld" <Jason@zx2c4.com>, Li Zhe <lizhe.67@bytedance.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Mark Rutland <mark.rutland@arm.com>, 
	Will Deacon <will@kernel.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Zhou jie <zhoujie@nfschina.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 28, 2023 at 11:57=E2=80=AFAM Raul Rangel <rrangel@chromium.org>=
 wrote:
> > Your patch is good then. Well, would you mind to add a comment into
> > the code and make the commit message more clear even for dummies like
> > me?
> >
> > Something like the patch below. It would be better to split it into
> > two:
> >
> >    + 1st shuffling the check and adding the first part of the comment
> >    + 2nd fixing the case with empty console=3D options.
> >
> > I could prepare the patchset. I would keep your SOB for the 2nd patch
> > if you agreed.
>
> Yes, feel free. Thanks!
>

Hey Petr,
I was just following up on this. Were you going to prepare the two patches?

> >
> > Here is the proposal:
> >
> > From d2fb7c54bed4c67df229c56fcc1b0af83ada5227 Mon Sep 17 00:00:00 2001
> > From: Raul E Rangel <rrangel@chromium.org>
> > Date: Fri, 7 Jul 2023 19:17:25 -0600
> > Subject: [PATCH] init: Don't proxy the empty console=3D options to earl=
ycon
> >
> > Right now we are proxying the `console=3DXXX` command line args to the
> > param_setup_earlycon. This is done because the early consoles used to
> > be enabled via the `console` parameter.
> >
> > The `earlycon` parameter was added later by the commit 18a8bd949d6adb31=
1
> > ("serial: convert early_uart to earlycon for 8250"). It allowed to
> > setup the early consoles using another callback. And it was indeed
> > more self-explanatory and cleaner approach.
> >
> > As a result, for example, the following parameters have the same effect=
:
> >
> >     console=3Duart[8250],mmio,<addr>[,options]
> >     earlycon=3Duart[8250],mmio,<addr>[,options]
> >
> > Nevertheless, `console` and `earlycon` parameters behave different when
> > the options do not match an early console. setup_earlycon() accepts onl=
y
> > console names in __earlycon_table. Also the empty options are handled
> > differently:
> >
> >   + When `earlycon=3D` or just `earlycon` is specified on the command l=
ine,
> >     param_setup_earlycon() tries to enable an early console via the SPC=
R
> >     table or the device tree.
> >
> >   + When `console=3D` is specified on the command line, it's intention =
is to
> >     disable the console.
> >
> > Here comes the problem. The current code calls param_setup_earlycon()
> > even when `console=3D` is used with no options. As a result, it might
> > enable the early console when it is defined in the SPCR table or
> > a device tree. This is obviously not what users want.
> >
> > The early console should be enabled via SPCR or DT only when `earlycon`
> > is used explicitly with no options.
> >
> > Signed-off-by: Raul E Rangel <rrangel@chromium.org>
> > [pmladek@suse.com: Add comments and more details into the commit messag=
e]
> > ---
> >  init/main.c | 20 ++++++++++++++++----
> >  1 file changed, 16 insertions(+), 4 deletions(-)
> >
> > diff --git a/init/main.c b/init/main.c
> > index ad920fac325c..3b059e316e62 100644
> > --- a/init/main.c
> > +++ b/init/main.c
> > @@ -733,13 +733,25 @@ static int __init do_early_param(char *param, cha=
r *val,
> >         const struct obs_kernel_param *p;
> >
> >         for (p =3D __setup_start; p < __setup_end; p++) {
> > -               if ((p->early && parameq(param, p->str)) ||
> > -                   (strcmp(param, "console") =3D=3D 0 &&
> > -                    strcmp(p->str, "earlycon") =3D=3D 0)
> > -               ) {
> > +               if (p->early && parameq(param, p->str)) {
> >                         if (p->setup_func(val) !=3D 0)
> >                                 pr_warn("Malformed early option '%s'\n"=
, param);
> >                 }
> > +
> > +               /*
> > +                * Early consoles can be historically enabled also when=
 earlycon
> > +                * specific options are passed via console=3D[earlycon =
options]
> > +                * parameter.
> > +                *
> > +                * Do not try it with an empty value. "console=3D" is u=
sed to
> > +                * disable real normal consoles. While "earlycon" is us=
ed to
> > +                * enable an early console via SPCR or DT.
> > +                */
> > +               if (strcmp(param, "console") =3D=3D 0 && val && val[0] =
&&
> > +                   strcmp(p->str, "earlycon") =3D=3D 0) {
> > +                       if (p->setup_func(val) !=3D 0)
> > +                               pr_warn("Failed to setup earlycon via c=
onsole=3D%s\n", val);
> > +               }
> >         }
> >         /* We accept everything at this stage. */
> >         return 0;
> > --
> > 2.35.3
> >
>
> Signed-off-by: Raul E Rangel <rrangel@chromium.org>

Thanks,
Raul

