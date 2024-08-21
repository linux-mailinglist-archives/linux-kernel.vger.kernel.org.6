Return-Path: <linux-kernel+bounces-295784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E15E395A17E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 17:37:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D9FD28349F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 15:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B398C14B948;
	Wed, 21 Aug 2024 15:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Bv+rvVWa"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC3914D44F
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 15:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724254618; cv=none; b=Gfce9xcvI3rbbU7NB/utiYBcmn2wZ+U/b8/bQ6FwioD35EBOW29vyNlS2TufDo93r5fdxgX98D0SaWJFFani0J3iWuvubFXhxZUsHhQ+KXuILq6qOplcFWk+0+/PKAweI8eexzr4qROe6TihnR29ymmxmaByRV6V6G6xKiQNSjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724254618; c=relaxed/simple;
	bh=TcnVT6P/MC9Mv2BlVzq0MLYaqgtjeuonuNX1FNmnEZU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X4H4qOsJzpph8RwU2O9nJVd3hdMYwqxVJVEfzC3KgEcb9LuIIeHnWukPM3EkhdYXrVHsFc/C9HfoJxD+bKxUj/BViYJB7wmV+9EvauM8Bx6BegzpsnaZt3ammbbN74Oa+c6DBY6qz0WnMjfUg/1Jwedpp9LIBKt3a7FAnrA+tZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Bv+rvVWa; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2f3ce5bc7d2so48250441fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 08:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1724254615; x=1724859415; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=85MRSyYE3jZaKv49DdRtYAZEfrlaaHfH6W95IHNDbAI=;
        b=Bv+rvVWaehR2nn1edCV7YIhlUxv7osTXstcz5RDqXP93tGfrt2XR2lRspYbWAFKxqf
         6r4WGycWr46wrPsqFda2A4U1GuuY/2q0bLv0FS/PZR1CE6zPJ3z+FcD/KDZLxKSd+WBS
         dT2B6+uwLrt4M+sk7OhEKEG6T52YIuc3dzeno=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724254615; x=1724859415;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=85MRSyYE3jZaKv49DdRtYAZEfrlaaHfH6W95IHNDbAI=;
        b=sv1R6bSzYWjYL8slKM0R0LWa/Hq+XSUN9QErmvT6Rk8zQ9lP0nCpRrRbg9xTVcXHTB
         7xzP4E68O+7YFwIC6Yz9UJCvcipB+4FPMQ0YnKOHMR5D1t4lJ6+sx2JpMQ8Wz0QmInJh
         l/KUei/yDf8pWWQEn3MtiBdU2G5Q6EqmNyrReKNsnXwNzuIlx7aPscKxT06UQZpmpGP4
         Hd9kjM5EfOw0cZJe4+lXUnoWVIXB63LQWch893aphYT25fLdaEBUg5H4ZG09zegFjxch
         PE4Y80IAF/VOHFjBKp19rlClFAkUNMiSZ631BA39o/ZGikCOOAq8++b4lfG75lsKq4ek
         TF6Q==
X-Forwarded-Encrypted: i=1; AJvYcCViCVs+K8ipvVbdhXXQdf+wMRsx8ietuZC9XfifZmY88KQKre/iRnZWJxhbqUzBLxCHifgNAcF62dxcmC0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxju8e2VtjXmpWa94aRmcFddham+ViCTAXwKbN1/sDIZa2t61dX
	pBER/1EoCsZP8IKmD/0470W4Ck0QUttxTCTMZJ89Lfat0rIIQpQTxrXx9j4zPmzEpvfoCv3nmlX
	NEQ==
X-Google-Smtp-Source: AGHT+IFHf+IOTOCRXHIyBjIE8IlJjN/5iU1G6zKhrXInm10lqxoBW3EZm4lJaZKIgXFMTnaQkEwmDA==
X-Received: by 2002:a2e:9949:0:b0:2f3:f501:f4e7 with SMTP id 38308e7fff4ca-2f3f881e227mr18258591fa.16.1724254614372;
        Wed, 21 Aug 2024 08:36:54 -0700 (PDT)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bf0c7f5b04sm2386343a12.39.2024.08.21.08.36.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Aug 2024 08:36:54 -0700 (PDT)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a8657900fc1so212522466b.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 08:36:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUpmOZJzIn4jrH2NN0P4v5E7IQcHUzHODDJC9cD5HNmJ/J/EiMC8zdLmObNzbR3C/I367Ws5OBz/E1qnx8=@vger.kernel.org
X-Received: by 2002:a17:907:e61c:b0:a7a:c083:8579 with SMTP id
 a640c23a62f3a-a866f9b0ae1mr201603766b.62.1724254231664; Wed, 21 Aug 2024
 08:30:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6101a3bb-30eb-97fc-3a8e-6d15afc4efb5@amd.com> <3de1ff24-3970-6e22-a73c-70446b8de4bd@infradead.org>
 <CAHQZ30BLb13Mz5+3MCgV30eG-LiU-6-4F7AEinGQmsgiyzD-yA@mail.gmail.com>
 <ZLF5_dJyQgzNnrnO@alley> <CAHQZ30DjZE6Mg-KUrLQOLHh+OxNHZXRDkuZopxJb3F7G29TsXA@mail.gmail.com>
 <ZLGVYg1FAZN7VFxB@alley> <CAHQZ30Abpvm+__VK9oaU9eWwLKpiND+rmfjrPvF_R_09d2JqGQ@mail.gmail.com>
 <ZLZgZvE35fYCkgOq@alley> <CAHQZ30DQw9n=uiuz3-nqnOKVbZdp-=DfeSn2feoPL08RjYzT=A@mail.gmail.com>
 <CAHQZ30AEuwUzJs0bjsZ4eisJhmG8zkrXx4eKnfGsJ1jBt=jTUA@mail.gmail.com> <ZsX79M3RcertYHQZ@pathway.suse.cz>
In-Reply-To: <ZsX79M3RcertYHQZ@pathway.suse.cz>
From: Raul Rangel <rrangel@chromium.org>
Date: Wed, 21 Aug 2024 09:30:17 -0600
X-Gmail-Original-Message-ID: <CAHQZ30BwXeZNS1BZCQa5Nyb6S7akXvAqnhXR8w2Cj6LnMG6kGg@mail.gmail.com>
Message-ID: <CAHQZ30BwXeZNS1BZCQa5Nyb6S7akXvAqnhXR8w2Cj6LnMG6kGg@mail.gmail.com>
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

On Wed, Aug 21, 2024 at 8:38=E2=80=AFAM Petr Mladek <pmladek@suse.com> wrot=
e:
>
> On Thu 2024-08-08 11:30:53, Raul Rangel wrote:
> > On Fri, Jul 28, 2023 at 11:57=E2=80=AFAM Raul Rangel <rrangel@chromium.=
org> wrote:
> > > > Your patch is good then. Well, would you mind to add a comment into
> > > > the code and make the commit message more clear even for dummies li=
ke
> > > > me?
> > > >
> > > > Something like the patch below. It would be better to split it into
> > > > two:
> > > >
> > > >    + 1st shuffling the check and adding the first part of the comme=
nt
> > > >    + 2nd fixing the case with empty console=3D options.
> > > >
> > > > I could prepare the patchset. I would keep your SOB for the 2nd pat=
ch
> > > > if you agreed.
> > >
> > > Yes, feel free. Thanks!
> > >
> >
> > Hey Petr,
> > I was just following up on this. Were you going to prepare the two patc=
hes?
>
> I have been quite overloaded last two years. It would help me a lot if
> you could prepare the two patches and send them for review.
>
> Thanks for re-opening this. It has already fallen through cracks on my
> side /o\.
>
> Best Regards,
> Petr

No worries, we were just going through our tech debt backlog and this
patch came up.

Thinking about this a little bit more, I'm wondering if we can clean
up the hack. Would something like the following patch work? My thought
is we declare an early handler for `console=3D`, so we can handle the
`console=3DuartXXXX` case, and leave the non-early handler in place to
handle the `console=3DttyXX` cases.

diff --git a/drivers/tty/serial/earlycon.c b/drivers/tty/serial/earlycon.c
index a5f380584cdae7..7a48fe6fc0dffc 100644
--- a/drivers/tty/serial/earlycon.c
+++ b/drivers/tty/serial/earlycon.c
@@ -241,6 +241,21 @@ static int __init param_setup_earlycon(char *buf)
 }
 early_param("earlycon", param_setup_earlycon);

+static int __init param_setup_earlycon_console_alias(char *buf)
+{
+       /* We only want to handle `console=3DXXXX` in this handler. We leav=
e
+          `console` and `console=3D` to be handled later by the non-early =
printk
+          handler.
+       */
+       if (!buf || !buf[0]) {
+               return 0;
+       }
+
+       /* `console=3DuartXXXX` is actually an alias for `earlycon=3DuartXX=
XX`. */
+       return param_setup_earlycon(buf);
+}
+early_param("console=3D", param_setup_earlycon_console_alias);
+
 #ifdef CONFIG_OF_EARLY_FLATTREE

 int __init of_setup_earlycon(const struct earlycon_id *match,
diff --git a/init/main.c b/init/main.c
index 8e1f6127e172c3..b6f0cb424176da 100644
--- a/init/main.c
+++ b/init/main.c
@@ -740,9 +740,7 @@ static int __init do_early_param(char *param, char *val=
,
        const struct obs_kernel_param *p;

        for (p =3D __setup_start; p < __setup_end; p++) {
-               if ((p->early && parameq(param, p->str)) ||
-                   (strcmp(param, "console") =3D=3D 0 &&
-                    strcmp(p->str, "earlycon") =3D=3D 0 && val && val[0]))=
 {
+               if ((p->early && parameq(param, p->str))) {
                        if (p->setup_func(val) !=3D 0)
                                pr_warn("Malformed early option '%s'\n", pa=
ram);
                }


>
>
> > > > Here is the proposal:
> > > >
> > > > From d2fb7c54bed4c67df229c56fcc1b0af83ada5227 Mon Sep 17 00:00:00 2=
001
> > > > From: Raul E Rangel <rrangel@chromium.org>
> > > > Date: Fri, 7 Jul 2023 19:17:25 -0600
> > > > Subject: [PATCH] init: Don't proxy the empty console=3D options to =
earlycon
> > > >
> > > > Right now we are proxying the `console=3DXXX` command line args to =
the
> > > > param_setup_earlycon. This is done because the early consoles used =
to
> > > > be enabled via the `console` parameter.
> > > >
> > > > The `earlycon` parameter was added later by the commit 18a8bd949d6a=
db311
> > > > ("serial: convert early_uart to earlycon for 8250"). It allowed to
> > > > setup the early consoles using another callback. And it was indeed
> > > > more self-explanatory and cleaner approach.
> > > >
> > > > As a result, for example, the following parameters have the same ef=
fect:
> > > >
> > > >     console=3Duart[8250],mmio,<addr>[,options]
> > > >     earlycon=3Duart[8250],mmio,<addr>[,options]
> > > >
> > > > Nevertheless, `console` and `earlycon` parameters behave different =
when
> > > > the options do not match an early console. setup_earlycon() accepts=
 only
> > > > console names in __earlycon_table. Also the empty options are handl=
ed
> > > > differently:
> > > >
> > > >   + When `earlycon=3D` or just `earlycon` is specified on the comma=
nd line,
> > > >     param_setup_earlycon() tries to enable an early console via the=
 SPCR
> > > >     table or the device tree.
> > > >
> > > >   + When `console=3D` is specified on the command line, it's intent=
ion is to
> > > >     disable the console.
> > > >
> > > > Here comes the problem. The current code calls param_setup_earlycon=
()
> > > > even when `console=3D` is used with no options. As a result, it mig=
ht
> > > > enable the early console when it is defined in the SPCR table or
> > > > a device tree. This is obviously not what users want.
> > > >
> > > > The early console should be enabled via SPCR or DT only when `early=
con`
> > > > is used explicitly with no options.
> > > >
> > > > Signed-off-by: Raul E Rangel <rrangel@chromium.org>
> > > > [pmladek@suse.com: Add comments and more details into the commit me=
ssage]
> > > > ---
> > > >  init/main.c | 20 ++++++++++++++++----
> > > >  1 file changed, 16 insertions(+), 4 deletions(-)
> > > >
> > > > diff --git a/init/main.c b/init/main.c
> > > > index ad920fac325c..3b059e316e62 100644
> > > > --- a/init/main.c
> > > > +++ b/init/main.c
> > > > @@ -733,13 +733,25 @@ static int __init do_early_param(char *param,=
 char *val,
> > > >         const struct obs_kernel_param *p;
> > > >
> > > >         for (p =3D __setup_start; p < __setup_end; p++) {
> > > > -               if ((p->early && parameq(param, p->str)) ||
> > > > -                   (strcmp(param, "console") =3D=3D 0 &&
> > > > -                    strcmp(p->str, "earlycon") =3D=3D 0)
> > > > -               ) {
> > > > +               if (p->early && parameq(param, p->str)) {
> > > >                         if (p->setup_func(val) !=3D 0)
> > > >                                 pr_warn("Malformed early option '%s=
'\n", param);
> > > >                 }
> > > > +
> > > > +               /*
> > > > +                * Early consoles can be historically enabled also =
when earlycon
> > > > +                * specific options are passed via console=3D[early=
con options]
> > > > +                * parameter.
> > > > +                *
> > > > +                * Do not try it with an empty value. "console=3D" =
is used to
> > > > +                * disable real normal consoles. While "earlycon" i=
s used to
> > > > +                * enable an early console via SPCR or DT.
> > > > +                */
> > > > +               if (strcmp(param, "console") =3D=3D 0 && val && val=
[0] &&
> > > > +                   strcmp(p->str, "earlycon") =3D=3D 0) {
> > > > +                       if (p->setup_func(val) !=3D 0)
> > > > +                               pr_warn("Failed to setup earlycon v=
ia console=3D%s\n", val);
> > > > +               }
> > > >         }
> > > >         /* We accept everything at this stage. */
> > > >         return 0;
> > > > --
> > > > 2.35.3
> > > >
> > >
> > > Signed-off-by: Raul E Rangel <rrangel@chromium.org>
> >
> > Thanks,
> > Raul

