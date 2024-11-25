Return-Path: <linux-kernel+bounces-420836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 088C89D8385
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 11:37:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC2CD288B99
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 10:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B570193064;
	Mon, 25 Nov 2024 10:36:18 +0000 (UTC)
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D75101426C
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 10:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732530978; cv=none; b=Xkvb1T9dZJKRS0J+RbHcUJWKTcdZboHU0fF8fGDrIHUTovUu2dPh1lAeA3bt/IxCYYulIpr8XyXAS4D/Gp2ZkfxFKiQoABt6izGSDSuc+poYv7ROMiipHkCz3YwSSia3bw2rk5TsoL10+0oBwa05S/rnlOBOYlSn59Tt75/Xkoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732530978; c=relaxed/simple;
	bh=9sk9rHLSZRYB00T96sP5E3eEDYtDZECLqYJCfExrK/g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dJMejYb0Qxs47Ri8LmJD4DteU0OX7YL97o7t6OJ//aMFhe5Wqc9IMCfzHQdDHkP309WD6AtB1LTxyku+JwpBU/wmM0PGwR1yp4XlKtHQqUyI4gUZmV8hV8UKvOFV1WKWK3m4OQk749ofWywCvXAdWpMREJYkApvZ+tB9z8HI+FU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6eeffdff41dso9192517b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 02:36:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732530973; x=1733135773;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8d+g8WKkfE6s6pK+JrY3tSWdNLGevwdYmgstGGTm524=;
        b=j3cE7F0w0ncSq4KX4v6zbd2dK3yzPZIGotqKuLS/3UCWNeFj7doC04MlxtIwl6CAtT
         uiJzYX2e1CdjJd/JCBEBAZsZCsgHHqirlenOfJ/1aJkh1qC5C1kjxkHRjYNYXBhYrHQM
         x6WSRu5ddUmIa1YJGfgYdsmrfG689VVdrBkXbHtHsNE+y5dqUTeI7ZOCr3lG1UV+DT6M
         yAwzHeNq3AFrz3a393UfzEQDwaW/EleLbWNiEziLwSlUP6yjv95pM1A6+dbelIq4U/EL
         5j6/V99A6B6IyvokdxE+dmtz/wfd9cxpTHnP1l1FQP1csdO7s/6mAD0pnVwwP6sDRsLD
         JMLQ==
X-Forwarded-Encrypted: i=1; AJvYcCUkFJMr3eML6ZbmRkS+8LwU5JYOBwrLbzT7Zwlu/X0O/UoZ10RO9ilHNlGz9LKQ0U8V8GmbikNRB/1yBL4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhQBJolVke1TsudKPw4fsgsWxqko8xoP8/KARCKD2K0ip5cGnJ
	oSdkAfNhSsw2n+Q/+DIMcBoIbUWBYkOGG/HcDqCMwstYTSWfTsdKv5MuADs+
X-Gm-Gg: ASbGncsKz8sQ2sBzS4tpyMQH/XIXz6XXtBJQf3nH2T1SR3U1zITXCU5R9ehpBwrP6TF
	4eNHbdDX6fXed1roKT2hbNYnI93JTywcpuhdia4UEALAMAN9X6fCsfXEEWgQ6KrYlYzWlq8MlI6
	1G788MEZgXk803tTbLjIrO5BcsMo3PeWTjEKgwLCe7PB6Zjy40ydcApGZgtU/dW2UD5TSZT8GJ6
	ex80q6vPlaGIdlO33A92WMLTriZ/SSkdD1Dhm/olNih33eCoG9JAWW2vnyOb1P8p2RoVQ+wWUDU
	hKWrrT0iggRRUwmE
X-Google-Smtp-Source: AGHT+IFv7cclo/EVIuFcpG4PPvXy7rA5+5d9c61EF3qVh3+EL73f/ByTtnhcQY3Jeg1oJorAQx9PqQ==
X-Received: by 2002:a05:690c:7085:b0:6ee:a70c:8721 with SMTP id 00721157ae682-6eee0a22678mr121821737b3.26.1732530972822;
        Mon, 25 Nov 2024 02:36:12 -0800 (PST)
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com. [209.85.128.171])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6eee00824f6sm17523487b3.76.2024.11.25.02.36.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Nov 2024 02:36:11 -0800 (PST)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-6eeba477fcaso43269827b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 02:36:11 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVDmYqVgzwrzRzkTtzskuboXpJzDvOj15mhSa6pYoCNMdwMQRx/uv8O8l3TN91eV+QyYveyE2Z2O+9PUy0=@vger.kernel.org
X-Received: by 2002:a05:690c:4a13:b0:6ee:cf8b:c6c1 with SMTP id
 00721157ae682-6eee0a24b1cmr108161527b3.29.1732530970890; Mon, 25 Nov 2024
 02:36:10 -0800 (PST)
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
Date: Mon, 25 Nov 2024 11:35:58 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUC6cq+ybVzOC9n3XaT-x3oy+7tpA+Z=e8a4yd3B6Ykng@mail.gmail.com>
Message-ID: <CAMuHMdUC6cq+ybVzOC9n3XaT-x3oy+7tpA+Z=e8a4yd3B6Ykng@mail.gmail.com>
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
>
> It was applied already, I made sure it's part of the next PR we send to
> Linus. And it should be in linux-next tomorrow.

Thank you, I can confirm it is now commit 818956c76517e127
("drm/rockchip: avoid 64-bit division") in drm-misc/for-linux-next
and next-20241125.

Interestingly, the commit description contains:

    (cherry picked from commit 4b64b4a81fcd51f570c046cf904aef19ec756d45)

which is not in any tree on git.kernel.org, but the github collective
does know about it:
https://github.com/torvalds/linux/commit/4b64b4a81fcd51f570c046cf904aef19ec=
756d45

Probably you want to drop that line.

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

