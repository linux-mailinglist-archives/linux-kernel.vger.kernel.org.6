Return-Path: <linux-kernel+bounces-417941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 100529D5B12
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 09:36:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4543283200
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 08:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBE90184101;
	Fri, 22 Nov 2024 08:36:33 +0000 (UTC)
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3582B156F3F
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 08:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732264593; cv=none; b=V0iaLw+5pp/jrK3tLy+gCRbxWBhtamD6fI9cmRdoHKuYpCCbmI13jI4ASj4O1A/WI1UVoynCEAn/A2Ab6goG/fzn2MVL+RRNY/UbOmm5dblb+8zS9pSmBl6kgbouHA1HuDd5A9eRkOMX3LjGGWBvFdTNhojcDSJGCgniJYdqLdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732264593; c=relaxed/simple;
	bh=RGyoPgiaUJAt9Sz3/OhQ9oMPv3E4lh4dZtjRRMeVrPk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pzFPQ6wxDFYztHzZEgbX+1VJNije8BfmXZ1oGZgKCcqxIAqsftDFMktOmMZ9886SdLdlawSVJWreQ50A3oWTcGoLUk45qB0WiX7CeuTDt/Ej+xE7SJi7C8UXVy8rNYEAMQ63blLcgE9054G9FD1BqrJGTpCjrCuY1+RQrSEmzV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6eeca49d8baso14322717b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 00:36:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732264590; x=1732869390;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gAZGdYy0kLNz/HWKiT5Wenkd6deM0b7lB87bgXf3/+U=;
        b=jEgfMBzWODQrWMAJ1xVVKF8PZ1iL0FLUOOsVBQ5j3F0sug/diab0wyagoOyuCy69eI
         B5vLHLNjZlF9t3KxuHAuhv3n3oJ2hwvResGt07EmExn6x36OFXSBxq2yuX8tsw+c9l5/
         9v+ytrutJV5Jehg5FLWdoFjuduyhUMlbfpDksQJ+HCvmELL/k2Fb+DmDJYAn5P/PSI32
         1LFJ9WXUOsWWnj/uxaoMiZVD/RJ0CU0CSGqJKr9hB/gvRCww0N0/tj0HzTM76WHQ/kCQ
         nB+LXYSbKNii2yqZTRU/rcZldptsKf2v/BImcR2h0gVqTJ5zh0pIeatEUcdzYBBsPZkX
         wLyA==
X-Forwarded-Encrypted: i=1; AJvYcCVWvI5I73BZ6MRm4Ky8J+BkX/8UYjJLAY7rYIenK4jvRLSnBoyBBJtc25oHHB3GI4qdeRSxsyhwsJ+Ocrk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPh4y1JX35Vd5rnqAv7m7dWrwXCR4xH+XHelkCoOSniXYmjYPD
	6QGTn49v8ZjoGpiHSSlfSq1u+uODRzesAiMjd/5iKm6K2UGgeO+vjwjRBctw
X-Gm-Gg: ASbGncu33ZdVhOMN8zM8CVngJvz6oTkFxfENXo4Gdq85C7Btl0OSgy9+d38zcWTV47j
	EsOmgGy/0J5Zk0yYnFi21rfWERgKP7VMkomp6/LvGLiLti5yTpty8htZZ3tYh5v51N77r1zpomM
	X6KV09++ASXM7o8LIKqJVfhMrohOczR9jOZPjF1LiTeBkr+93wDdOKJoy2DkMPqBOkd4uB0Wam0
	qFsdSfWC28sm9mLBvOHjLfv8k0V3UxXRRqJ9DrkxpvL9F9f5YdacHYYZUt+mv2JcNfpeoo+FWsE
	nu/EKsyHycw2tjub
X-Google-Smtp-Source: AGHT+IGymPyGbZj6Tn9e/FmsGcGBWib6HERmy+mF4mKyhn2aIT3E2TZ47KFqIJRrZ/fs+vp5TO7NFg==
X-Received: by 2002:a05:690c:d0e:b0:6ea:1230:2467 with SMTP id 00721157ae682-6eee08a9687mr20163957b3.2.1732264589770;
        Fri, 22 Nov 2024 00:36:29 -0800 (PST)
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com. [209.85.128.180])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6eedfe2a46esm3549847b3.38.2024.11.22.00.36.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Nov 2024 00:36:28 -0800 (PST)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6eeca49d8baso14322527b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 00:36:28 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXWms7ahSitb2tXXFcJasa70lN2JpRChoeBdelQoIZPZ8zrixKf/xVteA/WqQtkoraHSpa8hhe4QPJsk5c=@vger.kernel.org
X-Received: by 2002:a05:690c:7084:b0:6e2:2684:7f62 with SMTP id
 00721157ae682-6eecd25bc15mr55712747b3.8.1732264588474; Fri, 22 Nov 2024
 00:36:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241018151016.3496613-1-arnd@kernel.org> <20241104172950.GA741087@thelio-3990X>
In-Reply-To: <20241104172950.GA741087@thelio-3990X>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 22 Nov 2024 09:36:16 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXrrCiLm2sQmpegtVHV8X5AUp-8E5BejDxRpMbeAfHhvQ@mail.gmail.com>
Message-ID: <CAMuHMdXrrCiLm2sQmpegtVHV8X5AUp-8E5BejDxRpMbeAfHhvQ@mail.gmail.com>
Subject: Re: [PATCH] drm/rockchip: avoid 64-bit division
To: Nathan Chancellor <nathan@kernel.org>
Cc: Arnd Bergmann <arnd@kernel.org>, Sandy Huang <hjc@rock-chips.com>, 
	=?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
	Andy Yan <andy.yan@rock-chips.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Algea Cao <algea.cao@rock-chips.com>, 
	Cristian Ciocaltea <cristian.ciocaltea@collabora.com>, Arnd Bergmann <arnd@arndb.de>, 
	dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 4, 2024 at 6:30=E2=80=AFPM Nathan Chancellor <nathan@kernel.org=
> wrote:
> On Fri, Oct 18, 2024 at 03:10:10PM +0000, Arnd Bergmann wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> >
> > Dividing a 64-bit integer prevents building this for 32-bit targets:
> >
> > ERROR: modpost: "__aeabi_uldivmod" [drivers/gpu/drm/rockchip/rockchipdr=
m.ko] undefined!
> >
> > As this function is not performance criticial, just Use the div_u64() h=
elper.
> >
> > Fixes: 128a9bf8ace2 ("drm/rockchip: Add basic RK3588 HDMI output suppor=
t")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> Reviewed-by: Nathan Chancellor <nathan@kernel.org>
>
> Can someone please pick this up? It is still broken in next-20241104...
>
> https://storage.tuxsuite.com/public/clangbuiltlinux/continuous-integratio=
n2/builds/2oNvJFRj8tkDieb6VfrMf4rh1Kn/build.log
>
> > ---
> >  drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c b/drivers/g=
pu/drm/rockchip/dw_hdmi_qp-rockchip.c
> > index 9c796ee4c303..c8b362cc2b95 100644
> > --- a/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
> > +++ b/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
> > @@ -82,7 +82,7 @@ static void dw_hdmi_qp_rockchip_encoder_enable(struct=
 drm_encoder *encoder)
> >                * comment in rk_hdptx_phy_power_on() from
> >                * drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
> >                */
> > -             phy_set_bus_width(hdmi->phy, rate / 100);
> > +             phy_set_bus_width(hdmi->phy, div_u64(rate, 100));
> >       }
> >  }

noreply@ellerman.id.au has just told me this build issue is now upstream:

    FAILED linus/m68k-allmodconfig/m68k-gcc8.1 Fri Nov 22, 05:34
    http://kisskb.ellerman.id.au/kisskb/buildresult/15277242/

    Commit:   Merge tag 'drm-next-2024-11-21' of
https://gitlab.freedesktop.org/drm/kernel
              28eb75e178d389d325f1666e422bc13bbbb9804c
    Compiler: m68k-linux-gcc (GCC) 8.1.0 / GNU ld (GNU Binutils) 2.30

    ERROR: modpost: "__udivdi3"
[drivers/gpu/drm/rockchip/rockchipdrm.ko] undefined!

Applying this patch fixes it, so
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Do we really need +5 weeks to apply a fix for a reported build issue?
Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

