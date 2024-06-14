Return-Path: <linux-kernel+bounces-214865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D377908B43
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 14:10:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 153F31F21C3D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 12:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 481CE195FDE;
	Fri, 14 Jun 2024 12:10:21 +0000 (UTC)
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C2EA811FE
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 12:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718367020; cv=none; b=rwnon7fFoLLAU9g/5wGUJ5aK5rPGnbRZJ6mctu23cLyKdZKjRKjSaWpTEHpXjKrwU7VBUMWfgpGj8GxkJAfdYsejvKcLOfM/8Ufpfgzh5dYoqkFRQINUzOFmV6v09Zk8Nxeb1aIr8ip1hzFDauPFWybdptD+aCPFd0n1xPIuZvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718367020; c=relaxed/simple;
	bh=NFyPsrA6jdLOEig7pGgzBt++SapvFKggz+7IsJWuL/U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MvLRvZDgTc/B4GWRV5TPCJo54WI1yttMmUFFJ4qJXEObozugyXARlfyN6MAnGvk+YCZzbC69eA45+b7OG6A6BnepLuiFxUWKn4QnAACuOSDHno2horrUdw/rMmVzziqaTxToXfHB9KglPWXJhLGjY0D+7mnOQaV6IJrT9NuOgKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6319bf71f28so15000897b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 05:10:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718367017; x=1718971817;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uCUg8QYCKMVfa4NHNqKto50dVwiO8FLSnVupggLvSyg=;
        b=LzZIyqQaGm7DWUb1uZvgdYiz+olnBLgqmpjf8AhKxsAdp2AnYjs6GPG8ZjYzehWu4t
         zQdZJq83AXYYV+b5+6S4MnJ5D0vGyQ8M9kfFjCEnfUVekemo2uE4g7Vv49nAXsU2Hcm5
         mNAk4rHj0h+lV4XztzPLpcfVuioBKadM/JF/Fat712lToEDtYk0UkeSiRal3/JQpr3Oi
         0u9EGpGOYQr6AsXZbV/geYAMo3WIWj4fT/gk8uRrhalFBUby2Co0URXnISQSD5cpGOOb
         iej3zHEMpPPvy0uz7QZWcOkBGx6I0gAVlfsOxECe3401E1EBwJmp3+bhRrb/jXSm9IzO
         UzDA==
X-Forwarded-Encrypted: i=1; AJvYcCUQBy4vHUB+vwj7DyW1NmrrmUus6vwUICUd5Wv1qdFR4w6r/ERyHZ87zfKxUOAmHZHIJyELPvutqTxdke0yFWOOBxqguDiEgaTayoFP
X-Gm-Message-State: AOJu0Yyi3Mj1QVRnyvKQVTGsRQZzkQl/xvYQ8SikZubWOILMuT2dwJC+
	fV5BRJS+XumllObGfOtlLXcM+H+zH1jNL6FYgosXrAH/at9PMNhTyGipvixx
X-Google-Smtp-Source: AGHT+IES0gvRcuf4TlLfK+QlUXE7llzGRWqKIT5QuQLv1mPBjJUDZAyecHsC9YVytnmKGJUD9Zienw==
X-Received: by 2002:a05:690c:3:b0:62d:1eb6:87bf with SMTP id 00721157ae682-63222455d4emr25091077b3.5.1718367016015;
        Fri, 14 Jun 2024 05:10:16 -0700 (PDT)
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com. [209.85.219.169])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6327f50f18dsm1295967b3.131.2024.06.14.05.10.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jun 2024 05:10:15 -0700 (PDT)
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-dfe43dca3bfso2546416276.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 05:10:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWpwgIlsU2sRYKPmLSu77uzvD6GuekVbSvLCaMo9yPjRFkUGhDb130QwKJuS+paJCkzlGDKTKv5WD6rmbUT/0Ul+pTcgK5G5+qJUM15
X-Received: by 2002:a25:ad5c:0:b0:dfb:2cf2:cc23 with SMTP id
 3f1490d57ef6-dff154917f1mr2306806276.42.1718367015107; Fri, 14 Jun 2024
 05:10:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1718311756.git.u.kleine-koenig@baylibre.com>
 <85a3d444f2943ebe9d64e722b1717a5f7d06ed48.1718311756.git.u.kleine-koenig@baylibre.com>
 <CAMuHMdUHi0Yu2Giccp7pHqpjLWG2CjkGFWehLV0iWBHB_V4oGw@mail.gmail.com> <7xnzx6dlim2r5oujon3csocrljcvtvwz46yvmik62hpn4a2rlj@tiqrzlol7l5u>
In-Reply-To: <7xnzx6dlim2r5oujon3csocrljcvtvwz46yvmik62hpn4a2rlj@tiqrzlol7l5u>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 14 Jun 2024 14:10:03 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUzj2Wa=HNk44L3G0S40XxZmwAYNd0nv9J_UsH478CHNg@mail.gmail.com>
Message-ID: <CAMuHMdUzj2Wa=HNk44L3G0S40XxZmwAYNd0nv9J_UsH478CHNg@mail.gmail.com>
Subject: Re: [PATCH RFC v2 2/2] driver core: Don't allow passing a -ENOMEM to dev_err_probe()
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Petr Mladek <pmladek@suse.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Xiubo Li <xiubli@redhat.com>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Uwe,

On Fri, Jun 14, 2024 at 11:15=E2=80=AFAM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@baylibre.com> wrote:
> On Fri, Jun 14, 2024 at 09:26:52AM +0200, Geert Uytterhoeven wrote:
> > Looks like dev_err_probe() does not have a dummy for the !CONFIG_PRINTK
> > case yet, while it could definitely use one.
>
> Would you want to drop
>
>         device_set_deferred_probe_reason(dev, &vaf);
>
> from dev_err_probe() for !CONFIG_PRINTK, too? If not, you can throw away
> the string only if __builtin_constant_p(__err !=3D -EPROBE_DEFER) && __er=
r
> !=3D -EPROBE_DEFER. I agree such an improvement would be nice, but that's
> orthogonal to this series.

I would drop it. CONFIG_PRINTK=3Dn is only intended for production
systems where no console is available, and the full behavior of the system
is understood well.

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

