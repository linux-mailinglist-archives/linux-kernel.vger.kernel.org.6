Return-Path: <linux-kernel+bounces-318024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36F9C96E744
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 03:24:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3F0D285E14
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 01:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E3231B969;
	Fri,  6 Sep 2024 01:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V7Z7Hnjk"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 444401CA94
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 01:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725585845; cv=none; b=dUICFt73XR7ZTHeBih4ZWntBmqaMISF4bN3gN0QqrTiBev5ftmKzlDf9I4vzaGb7Q/chf9+0+u3c7inD3+XpZ8sQ656ttuwam82k8zLBzgj7e4OY/2glG6EM9kwUKrMFU2iOib9QXl7jKPIA0MfVpAml5M8RZ+mtQoAE9Iwxphw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725585845; c=relaxed/simple;
	bh=fuEix3DlvVeTuOrM1KkbRGOiFc9Wy3crOaLkMDjAa+g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UzYmdgxrNJ3uua14zwIBJcnDY0x/tv8AuOmf3cZBUTDS1DGKj6qsGnul/cUr914csIam03PSw9QgkHVqo15jEpH+/QSmgZO+QHgiIzMIi4tD7sX51wi56FJeKi4eTg/zBaieme6DjVY/AfKmE1HcHF3gcLZNZsiKGGfUc8emHfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V7Z7Hnjk; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2d87f34a650so1022932a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 18:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725585842; x=1726190642; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dNUn9mXf5C6UNEuTt3eUfW8jIvalDCTepQKAUNKiQ+Q=;
        b=V7Z7Hnjk5jXafU5uZedO5/Wf5ddL4xVl6bQjHAWyA0jTQ9IeotmPhIhCMp3Y8yld48
         KueTSx/5xTXcn/AtKr6f9hBbIyuhMzHcP+sSaTBbI6yhTuI7PpXfm3tJLFHg1w/8xzAx
         i7C3Kn0U57iNIn/q7332TbBlrI2qiXJ8fCBYRSjLO72YUZiKwm8XDKJgiPMQA4JnsUGH
         S4AsDI2Cb9b98heOhSpXO/TsNnQ86sg4UNlyCSybrls2z5Oa4HGJmB4mAvAqg/ZJvMjc
         ZCrFoF8LJx+PEOgMNozqgCi/RvEcqdSTjiCfK4GgFfqiiK2r1ofUIOnHGt6aMOvRIgUR
         l26w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725585842; x=1726190642;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dNUn9mXf5C6UNEuTt3eUfW8jIvalDCTepQKAUNKiQ+Q=;
        b=VjVFD4Q28NqAoHgbMdIhRJ9W+LNLskn7j9kfKiWF/X2xH8vUcVfgEEoMZkkladhtda
         rYZMt5GK6ZNA4zmAql7uvPy8ftf7NEjYyYuj7XEHTDGgR3DbA/edakJJR3nD3ZT4GNGX
         cTwblyqHmAmymVaWgE3XS1SEBM1vox6WhtKhIuBIxUNqlnz3x4cBavIA6S/6eggR4OC7
         eotJd9OU3SvQ4rVKtZMHrr62U+D4EJnc02qfSH0y0WqEH9Ph80ll36LhOq5UE/+ISwOv
         iZ1kuhnW6CydNR0cQGSbIJSO2qxghraJ7I+YoKek724cowdr7WEGMVLgXQD9nvjdnZ+h
         OEFQ==
X-Forwarded-Encrypted: i=1; AJvYcCWioeFAovaowZY9UwKASkIOaRcb7yt7M3VMqZh9Yy5jZr6T9G2m82gjVtSlCoJTJjj1ZE7myEcfSxxo5UI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1dP8TAGxhT9MCPjHXwmP46w3zQoIGwQ02J/WMpvytW8i77gbw
	YSwl6lvERNH5/BTDaIbNp01BR2Y1HHtQp1vdl9kI/10gpXI5GIJZbKUo54F00IfjtLsF5EiZjgl
	CH+OYJLPJfaL3+jaamovpJZ727GA=
X-Google-Smtp-Source: AGHT+IEzidPjWUAxLPR+PLVPSNwJ7lIMn8k2LTrBVIUEZVpFdJ+OKRUvczF0LpmZQ/Y8yM7A1+ju97f0lISmBkyxGkU=
X-Received: by 2002:a17:90a:a018:b0:2d8:719d:98a2 with SMTP id
 98e67ed59e1d1-2dad50294d4mr1690680a91.7.1725585842408; Thu, 05 Sep 2024
 18:24:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240904083103.1257480-1-dominique.martinet@atmark-techno.com>
In-Reply-To: <20240904083103.1257480-1-dominique.martinet@atmark-techno.com>
From: Adam Ford <aford173@gmail.com>
Date: Thu, 5 Sep 2024 20:23:51 -0500
Message-ID: <CAHCN7xLmZYZcHyPh3gy20vFKP7aTDKvWu+a_mbG6LN2gdEifTA@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge: imx8mp-hdmi-tx: allow 0.5% margin with
 selected clock
To: Dominique Martinet <dominique.martinet@atmark-techno.com>
Cc: Liu Ying <victor.liu@nxp.com>, Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	Lucas Stach <l.stach@pengutronix.de>, Frieder Schrempf <frieder.schrempf@kontron.de>, 
	dri-devel@lists.freedesktop.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 4, 2024 at 3:31=E2=80=AFAM Dominique Martinet
<dominique.martinet@atmark-techno.com> wrote:
>
> This allows the hdmi driver to pick e.g. 64.8MHz instead of 65Mhz when we
> cannot output the exact frequency, enabling the imx8mp HDMI output to
> support more modes
>
I went from 19 options on Modetest with my AOC 4K monitor to 31.  Of
those 31, three did not appear to sync, but not all the frequencies in
the LUT sync for me either, so I have no objection to moving forward
with this, but I wonder if we should have a note in there about why we
have a 5% tolerance.

> Signed-off-by: Dominique Martinet <dominique.martinet@atmark-techno.com>

Tested-by:  Adam Ford <aford173@gmail.com> #imx8mp-beacon

> ---
> This completes the patch series sent by Adam Ford here:
> https://lkml.kernel.org/r/20240904023310.163371-1-aford173@gmail.com
>
> and makes the cheap screens we recommend work with our imx8mp board
> without further kludging.
>
>
>  drivers/gpu/drm/bridge/imx/imx8mp-hdmi-tx.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/imx/imx8mp-hdmi-tx.c b/drivers/gpu/dr=
m/bridge/imx/imx8mp-hdmi-tx.c
> index 13bc570c5473..9431cd5e06c3 100644
> --- a/drivers/gpu/drm/bridge/imx/imx8mp-hdmi-tx.c
> +++ b/drivers/gpu/drm/bridge/imx/imx8mp-hdmi-tx.c
> @@ -23,6 +23,7 @@ imx8mp_hdmi_mode_valid(struct dw_hdmi *dw_hdmi, void *d=
ata,
>                        const struct drm_display_mode *mode)
>  {
>         struct imx8mp_hdmi *hdmi =3D (struct imx8mp_hdmi *)data;
> +       long round_rate;
>
>         if (mode->clock < 13500)
>                 return MODE_CLOCK_LOW;
> @@ -30,8 +31,9 @@ imx8mp_hdmi_mode_valid(struct dw_hdmi *dw_hdmi, void *d=
ata,
>         if (mode->clock > 297000)
>                 return MODE_CLOCK_HIGH;
>
> -       if (clk_round_rate(hdmi->pixclk, mode->clock * 1000) !=3D
> -           mode->clock * 1000)
> +       round_rate =3D clk_round_rate(hdmi->pixclk, mode->clock * 1000);
> +       /* accept 0.5% =3D 1/200 =3D 5/1000 tolerance */
> +       if (abs(round_rate - mode->clock * 1000) > mode->clock * 5)
>                 return MODE_CLOCK_RANGE;
>
>         /* We don't support double-clocked and Interlaced modes */
> --
> 2.39.2
>
>

