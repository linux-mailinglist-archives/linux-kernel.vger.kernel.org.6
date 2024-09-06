Return-Path: <linux-kernel+bounces-319020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A8D896F68F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 16:20:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 290421C23D7D
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 14:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 585AE1CF7AD;
	Fri,  6 Sep 2024 14:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thaumatec-com.20230601.gappssmtp.com header.i=@thaumatec-com.20230601.gappssmtp.com header.b="md48mjbG"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4D71EEF9
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 14:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725632443; cv=none; b=uKHmLOToaGmMzlHnOQvQGgH+7FdNA98x4SLqclgEHLOWem8PkuV4zteDKMCGBl34fypQopW6tuV6RD9GIyaqogsxYDRci6Kw3Oy0EEUtphRPuH74KFQT2/1Mtya/SgebEr0QAfq3PtsgdRWMK+5IF1hiHMaXN6J38D+Bqg8PjfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725632443; c=relaxed/simple;
	bh=J7OSpCYdTZVQpzznJQKI/6qwbogSqSbYRT0s3KZqqek=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EIDcy/VrtF1bzvOyMGvSi0W2rFfGguWAcPY5XdKPWV/fZrc4VqeVVpkkTw70laDN6aQ4x4ZrUeIhMMpjG3krJkgUQZfVqBO7gCgdbDNKAuNfX2EARZzQ99SG6GmEAI0ad/uOO2obIillzUeT93XJ3FyJoIuFXe/26bRC/BsBKrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thaumatec.com; spf=pass smtp.mailfrom=thaumatec.com; dkim=pass (2048-bit key) header.d=thaumatec-com.20230601.gappssmtp.com header.i=@thaumatec-com.20230601.gappssmtp.com header.b=md48mjbG; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thaumatec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thaumatec.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2f406034874so24755711fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2024 07:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thaumatec-com.20230601.gappssmtp.com; s=20230601; t=1725632440; x=1726237240; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EyrXtbzfkJ2qcMutIVumsIJniKM+4zkeN/47MqaDQFQ=;
        b=md48mjbGr2iliua7rwMrv4wryzPSbWUXndLkizSab5N4MVEhkStgdOUxfvF7qKRUgW
         szdAS+tj7+nSSSnoIkwsG8EPrywpSVwq547k7kw2JYgNEGGjSJEYcQGUUcSnzWXmPSl0
         aj7wV5yeOOZPF+LQw+Bu0QbJppm5/AJAVoMPqyy/uAULkx053R/5g2nQ0e2BnmmhFU0f
         hFNZ/0kRyoe51G1HTStLT4r/J4jtPzl8SWtwYvATPVcWt4f3Mug1/R2X/LRZ33Jm/M06
         RDwv6B/0nHREFiLbxx4QPOriW+dzo6IGKQOxD8Y1TAEbENWZSUWbE0WiBOvRnThqVjRc
         lTAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725632440; x=1726237240;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EyrXtbzfkJ2qcMutIVumsIJniKM+4zkeN/47MqaDQFQ=;
        b=bHyfH1VjSjDBPMAfIslAab8OFVQ0oP1FLKqpAzlV8FQmiWZbV1AsnuWQM9SFJsg9hD
         xmYgrjQn5msdr8vJXNK/NP++2+d5U0FHL8oC7AhnX4OYeD3juL6vDDmE7mcMcpAMO6q3
         QfLUox3GUZuoYWI/SEJX/oKHQULRQDZJ8o0g7DW1dXgk87wshsay0Iir4ISgo4JobwQP
         SUxssGHd8Uykyt+zEwNSaLVVJofimtr3TfBAJlXGtef1GlDYxP+wlkHKZ8WyZQIKL51m
         fYD2lAfnByZP/FRTDJ4uKUfhKfEnRHB7uWX0xzAUVI7cOF3GpaphPF1Q436k/vSgJohW
         RKJw==
X-Forwarded-Encrypted: i=1; AJvYcCWeOsftfG7GskBssUAZwNq6VSlPMBEJfIypZbUGv3QToXDWxI5OXBwwgsvxkCLxNmwR+TEaRIT36aLWpLs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzADvxK2BTR4q5I+AUN3GHWNF2Oi1YIqOmpMsL1girTigXBhGne
	IrMBvw/37dfkTR9BGuqhmkVyTslHCRR2digckmLsb3Jng5QFknqQ+GIL/yiU9MfRyc29T7WBqAx
	uHorD+UtZQRhUTgfgublksiIqhLEPBb3khFEIIQ==
X-Google-Smtp-Source: AGHT+IHtrjIX9SiVNRlY+i3UMGuEvIPbzq+NyW1Z8vRRgxniTG/aS0jGvGsF6c1SbfkZ6JVW1koyRlbyba/UViBbpEs=
X-Received: by 2002:a2e:a587:0:b0:2f7:52c5:b67 with SMTP id
 38308e7fff4ca-2f752c50e4amr17556431fa.29.1725632439382; Fri, 06 Sep 2024
 07:20:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240506-tc358775-fix-powerup-v1-0-545dcf00b8dd@kernel.org> <20240506-tc358775-fix-powerup-v1-9-545dcf00b8dd@kernel.org>
In-Reply-To: <20240506-tc358775-fix-powerup-v1-9-545dcf00b8dd@kernel.org>
From: Daniel Semkowicz <dse@thaumatec.com>
Date: Fri, 6 Sep 2024 16:20:28 +0200
Message-ID: <CAHgnY3=KCD4gyJ4nL6nN1tvWcsiRQL+Oz11RNOniDdyMoEPcSg@mail.gmail.com>
Subject: Re: [PATCH 09/20] drm/bridge: tc358775: remove complex vsdelay calculation
To: Michael Walle <mwalle@kernel.org>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Robert Foss <rfoss@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Chun-Kuang Hu <chunkuang.hu@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Sam Ravnborg <sam@ravnborg.org>, 
	Vinay Simha BN <simhavcs@gmail.com>, Tony Lindgren <tony@atomide.com>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Michael,

On Mon, May 6, 2024 at 3:35=E2=80=AFPM Michael Walle <mwalle@kernel.org> wr=
ote:
>
> To cite the datasheet on VSDELAY:
>   During DSI link speed is slower than that of LVDS link=E2=80=99s, data =
needs
>   to be buffer within 775XBG before outputting to prevent data from
>   underflow. Register field VPCTRL[VSDELAY] is used to for this purpose
>
> This driver assumes that the DSI link speed is the pixel clock (as does
> every DSI bridge driver), after all the LVDS clock is derived from the
> DSI clock. Thus we know for a fact, that the DSI link is not slower than
> the LVDS side. Just use the (sane) default value of the bridge and drop
> the complicated calculation here.

I am not convinced this is a good idea to revert to a default
VSdelay value. I tested your patch series with RK3399 platform
and default value (5) was not enough there. There was small data
underflow visible, resulting in display offset. Removing this patch
and using the original calculation formula fixed the problem.
The calculated VSDELAY value seems to be a lot bigger than required,
but keeps us on the safe side.

It looks that hback-porch value for panel is used also on DSI link,
effectively delaying hactive data delivered to TC358775 bridge.
I suspect this causes the requirement for higher VSDELAY.

>
> While at it, replace the TC358775_VPCTRL_MSF() and
> TC358775_VPCTRL_OPXLFMT() inline functions by the usual macros for a bit
> flag.
>
> Signed-off-by: Michael Walle <mwalle@kernel.org>
> ---
>  drivers/gpu/drm/bridge/tc358775.c | 49 +++++++--------------------------=
------
>  1 file changed, 8 insertions(+), 41 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/tc358775.c b/drivers/gpu/drm/bridge/t=
c358775.c
> index 54aea58a3406..a9d731e87970 100644
> --- a/drivers/gpu/drm/bridge/tc358775.c
> +++ b/drivers/gpu/drm/bridge/tc358775.c
> @@ -109,7 +109,9 @@
>  #define RDPKTLN         0x0404  /* Command Read Packet Length */
>
>  #define VPCTRL          0x0450  /* Video Path Control */
> -#define EVTMODE                BIT(5)  /* Video event mode enable, tc358=
76x only */
> +#define VPCTRL_MSF     BIT(0)
> +#define VPCTRL_OPXLFMT BIT(8)
> +#define VPCTRL_EVTMODE BIT(5)  /* Video event mode enable, tc35876x only=
 */
>  #define HTIM1           0x0454  /* Horizontal Timing Control 1 */
>  #define HTIM2           0x0458  /* Horizontal Timing Control 2 */
>  #define VTIM1           0x045C  /* Vertical Timing Control 1 */
> @@ -187,30 +189,6 @@ enum {
>
>  #define L0EN BIT(1)
>
> -#define TC358775_VPCTRL_VSDELAY__MASK  0x3FF00000
> -#define TC358775_VPCTRL_VSDELAY__SHIFT 20
> -static inline u32 TC358775_VPCTRL_VSDELAY(uint32_t val)
> -{
> -       return ((val) << TC358775_VPCTRL_VSDELAY__SHIFT) &
> -                       TC358775_VPCTRL_VSDELAY__MASK;
> -}
> -
> -#define TC358775_VPCTRL_OPXLFMT__MASK  0x00000100
> -#define TC358775_VPCTRL_OPXLFMT__SHIFT 8
> -static inline u32 TC358775_VPCTRL_OPXLFMT(uint32_t val)
> -{
> -       return ((val) << TC358775_VPCTRL_OPXLFMT__SHIFT) &
> -                       TC358775_VPCTRL_OPXLFMT__MASK;
> -}
> -
> -#define TC358775_VPCTRL_MSF__MASK      0x00000001
> -#define TC358775_VPCTRL_MSF__SHIFT     0
> -static inline u32 TC358775_VPCTRL_MSF(uint32_t val)
> -{
> -       return ((val) << TC358775_VPCTRL_MSF__SHIFT) &
> -                       TC358775_VPCTRL_MSF__MASK;
> -}
> -
>  #define TC358775_LVCFG_PCLKDIV__MASK   0x000000f0
>  #define TC358775_LVCFG_PCLKDIV__SHIFT  4
>  static inline u32 TC358775_LVCFG_PCLKDIV(uint32_t val)
> @@ -350,7 +328,6 @@ static void tc_bridge_enable(struct drm_bridge *bridg=
e)
>         u32 hback_porch, hsync_len, hfront_porch, hactive, htime1, htime2=
;
>         u32 vback_porch, vsync_len, vfront_porch, vactive, vtime1, vtime2=
;
>         unsigned int val =3D 0;
> -       u16 dsiclk, clkdiv, byteclk, t1, t2, t3, vsdelay;
>         struct drm_display_mode *mode;
>         struct drm_connector *connector =3D get_connector(bridge->encoder=
);
>
> @@ -398,27 +375,17 @@ static void tc_bridge_enable(struct drm_bridge *bri=
dge)
>
>         /* Video event mode vs pulse mode bit, does not exist for tc35877=
5 */
>         if (tc->type =3D=3D TC358765)
> -               val =3D EVTMODE;
> +               val =3D VPCTRL_EVTMODE;
>         else
>                 val =3D 0;
>
>         if (tc->bpc =3D=3D 8)
> -               val |=3D TC358775_VPCTRL_OPXLFMT(1);
> +               val |=3D VPCTRL_OPXLFMT;
>         else /* bpc =3D 6; */
> -               val |=3D TC358775_VPCTRL_MSF(1);
> -
> -       dsiclk =3D mode->crtc_clock * 3 * tc->bpc / tc->num_dsi_lanes / 1=
000;
> -       clkdiv =3D dsiclk / (tc->lvds_link =3D=3D DUAL_LINK ? DIVIDE_BY_6=
 : DIVIDE_BY_3);
> -       byteclk =3D dsiclk / 4;
> -       t1 =3D hactive * (tc->bpc * 3 / 8) / tc->num_dsi_lanes;
> -       t2 =3D ((100000 / clkdiv)) * (hactive + hback_porch + hsync_len +=
 hfront_porch) / 1000;
> -       t3 =3D ((t2 * byteclk) / 100) - (hactive * (tc->bpc * 3 / 8) /
> -               tc->num_dsi_lanes);
> -
> -       vsdelay =3D (clkdiv * (t1 + t3) / byteclk) - hback_porch - hsync_=
len - hactive;
> +               val |=3D VPCTRL_MSF;
>
> -       val |=3D TC358775_VPCTRL_VSDELAY(vsdelay);
> -       regmap_write(tc->regmap, VPCTRL, val);
> +       regmap_update_bits(tc->regmap, VPCTRL, val,
> +                          VPCTRL_OPXLFMT | VPCTRL_MSF | VPCTRL_EVTMODE);
>
>         regmap_write(tc->regmap, HTIM1, htime1);
>         regmap_write(tc->regmap, VTIM1, vtime1);
>
> --
> 2.39.2
>

Kind regards
Daniel

