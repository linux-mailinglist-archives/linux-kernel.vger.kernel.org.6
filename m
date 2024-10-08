Return-Path: <linux-kernel+bounces-355878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DB6B995853
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 22:23:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F4811C21355
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 20:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7018B215000;
	Tue,  8 Oct 2024 20:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="B0ZKTc3P"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA12A212D27
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 20:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728419010; cv=none; b=H5eGaricmWWiV276+H9E39QVpquKdWdpRYwQvlpexwGozBrKReouhBNZHxrBcMTdr2iqjRyNZf5vdboF6/rlVNWryPNUWz0VqBZoVQ1ow7LYI3/lRgAIOS/URfEXoziOamX8ZxwXQzM5i+W9td/Bz0KHHqENMKGtjj8zstvVevo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728419010; c=relaxed/simple;
	bh=uyX/UDus13cx/UHVe4fbBMZuoGjhi+yGgbmr83XOFfw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H/Jrw/RS8L3V3Ghn24g0Q+rWXO7W0eclWFU4FLu8AltTDcurx5k1mWAfrNavB8mlUtISv7p5XDNf6ZEAKiqL4xj8DQ7RaZqfE884CWXka8gCAZUgn5rd157ZKKei4wk9U0ZsIOFYlnIlVgyLAQovVXHL/YJeTg7IVaKSRHlA31Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=B0ZKTc3P; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5398df2c871so6588843e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2024 13:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1728419007; x=1729023807; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EDnb4fLf/tcrWG5SBzt36Cz475xIYljj6zFplZ4H15A=;
        b=B0ZKTc3PJ6WQWfacSuSF7A9GDeWmMpRIGBXKyjX1+769Dkifqnt7gaosQYpBtSfua/
         yCE8Qz1sN9QZU72pL4kZpvqOY1LTUT54yIwWpLrthRsAq3JwH5j0+mIxHuUpc5KYKN7s
         5dibnepftqkmW7gdqVp9DgpZi6acPImhV0p7w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728419007; x=1729023807;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EDnb4fLf/tcrWG5SBzt36Cz475xIYljj6zFplZ4H15A=;
        b=KEe7sR895ngY/Aj7yrKyue7E+mitTzFLjdUA6GNotcWnc8qE7M0q4ccVQRwvigpdzy
         mCtEwbkN4S12fkvdbSlmfqT21SkkpDm3uzu89k5M8IDTPMlMQHpR1c69Ny91EbzHUUuS
         ZUE1X2lvUoc0Rs3VPAEF4n9LOFKbTe92nlxq2J46xuxc0NYuHO6R2pEDkyxmBwegqF+f
         mIzxg9r+4G/zbzXzqmTtG9vE2JlpqCKtkHei+SmkYNpeQoIhRoAdMGwKHNXFiNP1WRTl
         QRwqei2MXT9MBchSsxTzRcJWQOOKfbilXx6gSfzhFQwdDiiUTsMTbOSIunYC9V6n19Gc
         /M6A==
X-Forwarded-Encrypted: i=1; AJvYcCWfEnssqDqiAITn5VFDSJLPFJqqt3v9qPMAp4wrp2n398poOyalsbqzr8phFAjZjf6ryHlyMtdsZOXYu2c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMp3hcFQIJlqCH4sNpXJRH2E5g/9AJL6cQZ9uL2IAdm1kCWwnN
	tSc7xC0jucPvZha/l8kK4VkIvSUXCLkjOeeQoHpoEYe6jFFFY47SVSzmu4Zac7ug+vs7d+ecP9e
	VUj2U
X-Google-Smtp-Source: AGHT+IHjDrdoMi7OLI1kV1ETG/40SGTgoDdxlqSrQrTqhEO+cpH9i89NaBdWcC6xzneezl06gaYQ5Q==
X-Received: by 2002:a05:6512:b94:b0:539:8c02:64d5 with SMTP id 2adb3069b0e04-539c48d7851mr8865e87.27.1728419006533;
        Tue, 08 Oct 2024 13:23:26 -0700 (PDT)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-539afec80adsm1309188e87.87.2024.10.08.13.23.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Oct 2024 13:23:25 -0700 (PDT)
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2fac49b17ebso48273261fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2024 13:23:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU5Cp0WBUgoTP11rkuSDCA5bfHOMUTSRoBD5TeARb0fBK1N4XsjdeoNStxOmlELoPTKBwCly/H/jzd0sW8=@vger.kernel.org
X-Received: by 2002:a2e:702:0:b0:2f6:6576:ae6e with SMTP id
 38308e7fff4ca-2fb1878c5b5mr1138191fa.21.1728419004946; Tue, 08 Oct 2024
 13:23:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241008073014.16411-1-alex.vinarskis@gmail.com>
In-Reply-To: <20241008073014.16411-1-alex.vinarskis@gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 8 Oct 2024 13:23:09 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WdTW3R1n_1CA11vcPhkwHihcM-wDr0AQapnxUyKGHc5Q@mail.gmail.com>
Message-ID: <CAD=FV=WdTW3R1n_1CA11vcPhkwHihcM-wDr0AQapnxUyKGHc5Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] drm/edp-panel: Add panels used by Dell XPS 13 9345
To: Aleksandrs Vinarskis <alex.vinarskis@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Neil Armstrong <neil.armstrong@linaro.org>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Bryan.Kemp@dell.com, tudor.laurentiu.oss@gmail.com, peterdekraker@umito.nl
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Oct 8, 2024 at 12:30=E2=80=AFAM Aleksandrs Vinarskis
<alex.vinarskis@gmail.com> wrote:
>
> Introduce low-res IPS and OLED panels for mentioned device.
>
> SHP panel's timings were picked experimentally, without this patch or wit=
h
> `delay_200_500_e50` panel sometimes fails to boot/stays black on startup.
>
> LGD panel's timings were copied from other LGD panels and tested to be
> working.
>
> Particular laptop also comes in high-res IPS variant, which unfortunately
> I do not have access to verify.
>
> The raw edid for SHP panel is:
>
> 00 ff ff ff ff ff ff 00 4d 10 93 15 00 00 00 00
> 2c 21 01 04 a5 1d 12 78 07 ee 95 a3 54 4c 99 26
> 0f 50 54 00 00 00 01 01 01 01 01 01 01 01 01 01
> 01 01 01 01 01 01 f0 7b 80 90 70 b0 52 45 30 20
> 36 00 20 b4 10 00 00 18 00 00 00 fd 00 1e 78 9a
> 9a 20 01 0a 20 20 20 20 20 20 00 00 00 fe 00 4b
> 4a 46 47 52 80 4c 51 31 33 34 4e 31 00 00 00 00
> 00 02 41 0c 32 00 01 00 00 0b 41 0a 20 20 01 ef
>
> 70 20 79 02 00 20 00 13 8c 52 19 93 15 00 00 00
> 00 2c 17 07 4c 51 31 33 34 4e 31 21 00 1d 40 0b
> 08 07 80 07 b0 04 88 3d 8a 54 cd a4 99 66 62 0f
> 02 45 54 d0 5f d0 5f 00 34 12 78 26 00 09 02 00
> 00 00 00 00 01 00 00 22 00 14 5e d7 04 05 7f 07
> 8f 00 2f 00 1f 00 af 04 50 00 02 00 05 00 25 01
> 09 5e d7 04 5e d7 04 1e 78 80 81 00 0b e3 05 80
> 00 e6 06 01 01 6a 6a 39 00 00 00 00 00 00 ce 90
>
> The raw edid for LGD panel is:
>
> 00 ff ff ff ff ff ff 00 30 e4 78 07 00 00 00 00
> 00 22 01 04 b5 1d 12 78 06 96 65 b0 4f 3c b9 23
> 0b 50 54 00 00 00 01 01 01 01 01 01 01 01 01 01
> 01 01 01 01 01 01 ef 83 40 a0 b0 08 34 70 30 20
> 36 00 20 b4 10 00 00 1a 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 fe 00 44
> 48 39 50 57 80 31 33 34 57 54 31 0a 00 00 00 00
> 00 04 04 03 28 00 01 00 00 2b 01 0a 20 20 01 d4
>
> 70 20 79 02 00 20 00 13 3c e6 24 78 07 00 00 00
> 00 00 18 07 31 33 34 57 54 31 0a 21 00 1d 41 0b
> 08 07 40 0b 08 07 88 06 6b 4f c3 a3 b9 35 82 0b
> 02 45 54 40 5e 1a 60 18 10 23 78 26 00 09 04 00
> 00 00 00 00 41 00 00 22 00 14 55 27 05 85 3f 0b
> 9f 00 2f 80 1f 00 07 07 33 00 02 00 05 00 25 01
> 09 55 27 05 55 27 05 3c 3c 00 81 00 0b e3 05 80
> 00 e6 06 05 01 6d 60 02 00 00 00 00 00 00 31 90
>
> Signed-off-by: Aleksandrs Vinarskis <alex.vinarskis@gmail.com>
> ---
>  drivers/gpu/drm/panel/panel-edp.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/pa=
nel-edp.c
> index 767e47a2b0c1..8566e9cf2f82 100644
> --- a/drivers/gpu/drm/panel/panel-edp.c
> +++ b/drivers/gpu/drm/panel/panel-edp.c
> @@ -1977,11 +1977,13 @@ static const struct edp_panel_entry edp_panels[] =
=3D {
>         EDP_PANEL_ENTRY('L', 'G', 'D', 0x0567, &delay_200_500_e200_d200, =
"Unknown"),
>         EDP_PANEL_ENTRY('L', 'G', 'D', 0x05af, &delay_200_500_e200_d200, =
"Unknown"),
>         EDP_PANEL_ENTRY('L', 'G', 'D', 0x05f1, &delay_200_500_e200_d200, =
"Unknown"),
> +       EDP_PANEL_ENTRY('L', 'G', 'D', 0x0778, &delay_200_500_e200_d200, =
"134WT1"),
>
>         EDP_PANEL_ENTRY('S', 'H', 'P', 0x1511, &delay_200_500_e50, "LQ140=
M1JW48"),
>         EDP_PANEL_ENTRY('S', 'H', 'P', 0x1523, &delay_80_500_e50, "LQ140M=
1JW46"),
>         EDP_PANEL_ENTRY('S', 'H', 'P', 0x153a, &delay_200_500_e50, "LQ140=
T1JH01"),
>         EDP_PANEL_ENTRY('S', 'H', 'P', 0x154c, &delay_200_500_p2e100, "LQ=
116M1JW10"),
> +       EDP_PANEL_ENTRY('S', 'H', 'P', 0x1593, &delay_200_500_p2e100, "LQ=
134N1"),

Reviewed-by: Douglas Anderson <dianders@chromium.org>

I'll plan to give it a day or so and then land it. Thanks!

-Doug

