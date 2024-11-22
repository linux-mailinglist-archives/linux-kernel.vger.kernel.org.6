Return-Path: <linux-kernel+bounces-418028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 226A09D5C00
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 10:33:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7D491F21B42
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 09:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48B101D363F;
	Fri, 22 Nov 2024 09:33:22 +0000 (UTC)
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C2EE16DEB3
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 09:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732268001; cv=none; b=cx6Q/pTKfgnVKrMpysMLNabcmSL2jA2tyx7wIpaB9cCM2ghBzR5cf/yfwfunT+jAUvd1TpqP6kh5Zd6rOR1bF7nqTreTCrs4ajAb6dhkgPFRi8DEiLmQsajhyd9prn8gBx3F5U72ElXyrqJxTw/gf8qcFsvXzZQyeYft0PKw1Ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732268001; c=relaxed/simple;
	bh=4GSFBlGuBuzLqD1fS5Kh8SaUQ9k2TmrEylgq8YaaWOs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cmsqGoW8s8rezZvUa+4Fu5lGwYvMgXxBmnAEjJoF+JSzBjW7U4tOzbI/FQX2CLsLuKl3dMAe/uaSFWwORd5bu7kf979E84FI6MgRUKx9Z2fw2udOy3fsaE6CE3ENqO8PRYcfKhJdVUhR7z379XbFzB4yvrbLhYrCHsyJsqKZ9+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6eebc318242so18627687b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 01:33:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732267997; x=1732872797;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xM8g64sET8hw7b+gyg+vsiEnmYLC8RSZn0rXhR5lgBE=;
        b=JDsrinjY78PYX6sAQg883XpqfkVLmoZ0yMcur2v0dbPbmDNwvdDcTN5bvBq62ULBd4
         f5jN3QEiUMedGi7V1ALv64LJjxjcgaocDY5bARgZ0geO8QYIdqADC1BTmZC5rEyMShC/
         pUG9ufOd1uniaenCSEQyU9QlTOfZObYr7TLhztqE2WLc9sYWqn2GyDET0Ap/JYk8ed7I
         XlTgNkZgrOIeY4GKHI5z0iVVh9sbKkn5aNuk+kmARHrlZ53RIe+wXTWx18iuJy0JJnFd
         ahPcpWLhnn9OCzwal813Gpgw9KAcjaYdwkaZjBb72sopYmEDPJu8JvumtyMtNjgr2XB/
         V4Fw==
X-Forwarded-Encrypted: i=1; AJvYcCWoP7oqDKQvKiYBAUT3+j7NyXgLfVJx3N03nwiZJ2OliRe3GfG68DoL2dsEx7uBXcSzR8N3sDtsvHeoqOc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhF2fIcCDafYbKJHYfqPubPKGcmMFVc4onmzv1AWj5n0L8MyB8
	lG6f78CkRjHk7opH3X8heWewf+TMsnhucUKCE9FaRMC7l97f3psc+eIaFqMK
X-Gm-Gg: ASbGncvwuK+YIWLnp4WvfeRHraL2i6X66EJPiLdumCWKlvSq4llhrj+nsTaaMKg2cU2
	4E3paAmmSuBipjL2tO4Y3LKEDWL+ZZkSaQ6nY0sJr4MWOckC2fowDsovfp0+qOtlKXJVuLU0Bb+
	5ltww8hCR2uZwNb32l594BViXrJnlYr0BzIzneMjhwxYBHD5i0a8j2yBoF7dfRAeVYFv5YYQVcE
	GpR9QqLpbH2EFaKCw4GzT5NvW+rOVi4sUaJqanPYT9zuJaWFhKwvMfaad0XByJoh6pMwE0EErIX
	PSoOD/KmaEXP7Bcu
X-Google-Smtp-Source: AGHT+IFQYhsogYq5nXVXdWSyyB8EVP1OJTxQukQorQkdKJSrIALYKp6JWq5RjXZqKJ9H/w/wncGMfA==
X-Received: by 2002:a05:690c:3688:b0:6ea:3283:58c3 with SMTP id 00721157ae682-6eee08d1bf8mr24278837b3.11.1732267997261;
        Fri, 22 Nov 2024 01:33:17 -0800 (PST)
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com. [209.85.128.170])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6eee0081c3esm3687697b3.90.2024.11.22.01.33.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Nov 2024 01:33:16 -0800 (PST)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6eee6874ef8so3134337b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 01:33:16 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWeklyhYuCx8IlQictjSlV69muJeC1V64KZFj4KRnWVgYXTSAXSU/4faZJqnEf0HLFoIDZ3oKWKtcQK91Y=@vger.kernel.org
X-Received: by 2002:a05:690c:6e09:b0:6ee:9cb7:dc31 with SMTP id
 00721157ae682-6eee08b5abemr26651957b3.3.1732267996019; Fri, 22 Nov 2024
 01:33:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241018151016.3496613-1-arnd@kernel.org> <20241104172950.GA741087@thelio-3990X>
 <CAMuHMdXrrCiLm2sQmpegtVHV8X5AUp-8E5BejDxRpMbeAfHhvQ@mail.gmail.com> <20241122-rebel-donkey-of-atheism-a0b8b6@houat>
In-Reply-To: <20241122-rebel-donkey-of-atheism-a0b8b6@houat>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 22 Nov 2024 10:33:03 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUGfCWyFHnAKeg4YViErzX5BReb2A-8gtqECstUMn2Oeg@mail.gmail.com>
Message-ID: <CAMuHMdUGfCWyFHnAKeg4YViErzX5BReb2A-8gtqECstUMn2Oeg@mail.gmail.com>
Subject: Re: [PATCH] drm/rockchip: avoid 64-bit division
To: Maxime Ripard <mripard@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>, Arnd Bergmann <arnd@kernel.org>, Sandy Huang <hjc@rock-chips.com>, 
	=?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
	Andy Yan <andy.yan@rock-chips.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Algea Cao <algea.cao@rock-chips.com>, 
	Cristian Ciocaltea <cristian.ciocaltea@collabora.com>, Arnd Bergmann <arnd@arndb.de>, 
	dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Maxime,

On Fri, Nov 22, 2024 at 10:15=E2=80=AFAM Maxime Ripard <mripard@kernel.org>=
 wrote:
> On Fri, Nov 22, 2024 at 09:36:16AM +0100, Geert Uytterhoeven wrote:
> > On Mon, Nov 4, 2024 at 6:30=E2=80=AFPM Nathan Chancellor <nathan@kernel=
.org> wrote:
> > > On Fri, Oct 18, 2024 at 03:10:10PM +0000, Arnd Bergmann wrote:
> > > > From: Arnd Bergmann <arnd@arndb.de>
> > > >
> > > > Dividing a 64-bit integer prevents building this for 32-bit targets=
:
> > > >
> > > > ERROR: modpost: "__aeabi_uldivmod" [drivers/gpu/drm/rockchip/rockch=
ipdrm.ko] undefined!
> > > >
> > > > As this function is not performance criticial, just Use the div_u64=
() helper.
> > > >
> > > > Fixes: 128a9bf8ace2 ("drm/rockchip: Add basic RK3588 HDMI output su=
pport")
> > > > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > >
> > > Reviewed-by: Nathan Chancellor <nathan@kernel.org>
> > >
> > > Can someone please pick this up? It is still broken in next-20241104.=
..
> > >
> > > https://storage.tuxsuite.com/public/clangbuiltlinux/continuous-integr=
ation2/builds/2oNvJFRj8tkDieb6VfrMf4rh1Kn/build.log
> > >
> > > > ---
> > > >  drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c b/drive=
rs/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
> > > > index 9c796ee4c303..c8b362cc2b95 100644
> > > > --- a/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
> > > > +++ b/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
> > > > @@ -82,7 +82,7 @@ static void dw_hdmi_qp_rockchip_encoder_enable(st=
ruct drm_encoder *encoder)
> > > >                * comment in rk_hdptx_phy_power_on() from
> > > >                * drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
> > > >                */
> > > > -             phy_set_bus_width(hdmi->phy, rate / 100);
> > > > +             phy_set_bus_width(hdmi->phy, div_u64(rate, 100));
> > > >       }
> > > >  }
> >
> > noreply@ellerman.id.au has just told me this build issue is now upstrea=
m:
> >
> >     FAILED linus/m68k-allmodconfig/m68k-gcc8.1 Fri Nov 22, 05:34
> >     http://kisskb.ellerman.id.au/kisskb/buildresult/15277242/
> >
> >     Commit:   Merge tag 'drm-next-2024-11-21' of
> > https://gitlab.freedesktop.org/drm/kernel
> >               28eb75e178d389d325f1666e422bc13bbbb9804c
> >     Compiler: m68k-linux-gcc (GCC) 8.1.0 / GNU ld (GNU Binutils) 2.30
> >
> >     ERROR: modpost: "__udivdi3"
> > [drivers/gpu/drm/rockchip/rockchipdrm.ko] undefined!
> >
> > Applying this patch fixes it, so
> > Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
> >
> > Do we really need +5 weeks to apply a fix for a reported build issue?
>
> Do we really need that kind of comments?

Perhaps not...

> It was applied already,

Where was it applied?
How would I know that, when the fix is not in linux-next?

> I made sure it's part of the next PR we send to
> Linus. And it should be in linux-next tomorrow.

Thank you!

The issue is that the reported build issue was not fixed in linux-next,
despite the fix having been available for 5 weeks, thus reducing
(build) test coverage for all affected architectures, possibly hiding
other issues.
In addition, a PR including the build issue was sent to Linus, so now
the above applies to Linus' tree, too.

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

