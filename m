Return-Path: <linux-kernel+bounces-421477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C84D59D8BDB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 19:03:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74CF1B306B2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 18:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81F9E41C92;
	Mon, 25 Nov 2024 17:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="G4cJmfYM"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 508741B81DC
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 17:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732557580; cv=none; b=nakRez/ujnZeK2mqRVUFWIf2BMl38T5stAjgYN/gJgrmZxY6Yl5mvof2kp+EaNHKg0lv8nBfgHHuwiBR2u6Rgemls9kgF/efxB/8asYgjW/pjN1DO+Mynlv2D9WUzbr5vysn9aPxYcPUCRYWc2ui8IQowNVxiiEMZ+6IDoxMpI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732557580; c=relaxed/simple;
	bh=+aKBNdyqoPPoH7YFlDbUCvXZ6sn8H8tO0XYdJpv9c8M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Chf1COqHp4w4AoXSBETHQF+XgoYHfK0LF+/o76AkzpRzp9oRHhRxiW3syjAIzYyV1GRNTPieEz4aEFG7a4mQ8NBbravi/lGCwnzOAlRJoxiN6+sEGEn67Znb/9MLha++8IP0XL3LZZMUFzbLI5Xc4Tj70CPBUrkWd3UT/YVsKs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=G4cJmfYM; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2fc968b3545so50521171fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 09:59:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732557576; x=1733162376; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bAoWd6DpzeBICi4AhBURcNm7laPx9KjIN0TBKhbYcUY=;
        b=G4cJmfYMOvwIdgfHjMUpVLkMx1RQbpJ1izafy+x/13kaUfFkOsqgKnwS+p/r6m1NK2
         kZqruNk4uUmGUJJ+G8loaTi8PFyCGUj+Q24sEvCixhv/whnGWZuz50CVwi/l2rcC5spy
         81ptrJmURUYLdzZf+JgeIwzuJnOv6n1UfHen0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732557576; x=1733162376;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bAoWd6DpzeBICi4AhBURcNm7laPx9KjIN0TBKhbYcUY=;
        b=vllBisZnqz2g+MiXjzwjyrC/m5GAbjxt7UNaLbl3PYYKRZldsCEfoZozfV1PbAtLqy
         NCu2heoOoY9TLs7S6y10nADl8fnTGESE9rhBw6DBxuoHNiVRHmjkvpoHFI9AWRGQKq8y
         y86Sm5CfPeiwAmou/HqXpYM2i0x9ZCSbI6QO0OPsv1DaM/1G+6bwPkObifzueNCtXFkS
         +IWaagpX+xYovJRWqxsV6HHwM7ETEVKdly19ZO/ZNUD96YZj/xaSXcsycIzcPObPYB0C
         CpdgqCkSzpcSkgFFoqCo++Lfv78wPJZxjqS0E/hOw9yGIFtRz6LeoUa94ItzeRedWFwT
         unrg==
X-Forwarded-Encrypted: i=1; AJvYcCUYAc3YnHt4K6jkEcqUzI2SzTawzVvmB4DmNbS+aB+wje9jSxQyySoeSJL8k2iT27fdjf0TI+lN02L8l2Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwkkdSkwDiZR5LC+U8uATH7pfrUA5SCHnjsuCKXJGbcIUSw+Vi
	WHaD6u6G7Gk7P2ysU6esrYofRVc33nZNyMWkNLA7sw82O8i2ydWwwvgf+ENto1ik/GFTdU4Z7z5
	bpQ==
X-Gm-Gg: ASbGnctxgoF+8qTzg2jHAogjdpEpN6L/1QlFlh4qdS9jj0edqbUJ5yXR6oFNMJT0aJX
	AcJGu0d2sss7bJ1ujr0oi33Hw3QXS2NJ/fXLT6HpVxfOyn6i1J1TDXWwrDwgI3mt4JkRkWSL6Ly
	NU112mYCUOago85/mO0chhWTDKvQ4vC/q8+3mu7gkWMt8URW4Wkth6VJIrMgn3JiK7qsp6SPrlh
	JiAmciJR9ANAI2JOSmZAKcbCIECm9gn6EQRbWLeDeegBlT/cAh0TP+7eNUPkhU3IDNkEdz2vVFA
	Js6IbDEs36zjjQ==
X-Google-Smtp-Source: AGHT+IE9aRsX+sz6w+3fNaHAMI7Tzpgo9Cs1bE9ileirhaI61K7n1cBvxor2yQnndSKoLLU6et2J/A==
X-Received: by 2002:a2e:be23:0:b0:2fb:5035:11da with SMTP id 38308e7fff4ca-2ffa719af26mr76772431fa.33.1732557576099;
        Mon, 25 Nov 2024 09:59:36 -0800 (PST)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ffaba9bb5esm13626111fa.72.2024.11.25.09.59.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Nov 2024 09:59:35 -0800 (PST)
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-53da6801c6dso4364493e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 09:59:35 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXWiwcJHDBOs2DWSlFy0z+D3PowtHiVfqDJ2oJxB1YEQyYFpln9WsJaSTTEP6lKzcAU9Q8eV3Om9h97JE4=@vger.kernel.org
X-Received: by 2002:a05:6512:1247:b0:536:56d8:24b4 with SMTP id
 2adb3069b0e04-53dd35a4f22mr6019059e87.5.1732557234037; Mon, 25 Nov 2024
 09:53:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241124-hp-omnibook-x14-v1-0-e4262f0254fa@oldschoolsolutions.biz>
 <20241124-hp-omnibook-x14-v1-3-e4262f0254fa@oldschoolsolutions.biz>
In-Reply-To: <20241124-hp-omnibook-x14-v1-3-e4262f0254fa@oldschoolsolutions.biz>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 25 Nov 2024 09:53:42 -0800
X-Gmail-Original-Message-ID: <CAD=FV=V2JhWsK4-gHL72ttXdNA0U2p6YojN+DXtWxNSOjD-ZSw@mail.gmail.com>
Message-ID: <CAD=FV=V2JhWsK4-gHL72ttXdNA0U2p6YojN+DXtWxNSOjD-ZSw@mail.gmail.com>
Subject: Re: [PATCH 3/4] drm/panel-edp: Add unknown BOE panel for HP Omnibook X14
To: jens.glathe@oldschoolsolutions.biz
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Kalle Valo <kvalo@kernel.org>, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Nov 24, 2024 at 5:20=E2=80=AFAM Jens Glathe via B4 Relay
<devnull+jens.glathe.oldschoolsolutions.biz@kernel.org> wrote:
>
> From: Jens Glathe <jens.glathe@oldschoolsolutions.biz>
>
> Seems to be like NV140DRM-N61 but with touch. Haven't disassembled
> the lid to look.
>
> Due to lack of information, use the delay_200_500_e200 timings like
> many other BOE panels do for now.
>
> The raw EDID of the panel is:
>
> 00 ff ff ff ff ff ff 00 09 e5 93 0c 00 00 00 00
> 25 21 01 04 a5 1e 13 78 03 ee 95 a3 54 4c 99 26
> 0f 50 54 00 00 00 01 01 01 01 01 01 01 01 01 01
> 01 01 01 01 01 01 a4 57 c0 dc 80 78 78 50 30 20
> f6 0c 2e bc 10 00 00 1a 6d 3a c0 dc 80 78 78 50
> 30 20 f6 0c 2e bc 10 00 00 1a 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
> 00 0d 36 ff 0a 3c 96 0f 09 15 96 00 00 00 01 8b
>
> There are no timings in it, sadly.

Yeah, and like other BOE panels also no model info in the EDID. Sigh.
I guess "Unknown" it is until someone can officially add it.


> Signed-off-by: Jens Glathe <jens.glathe@oldschoolsolutions.biz>
> ---
>  drivers/gpu/drm/panel/panel-edp.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/pa=
nel-edp.c
> index 8566e9cf2f82a..403679e506fa4 100644
> --- a/drivers/gpu/drm/panel/panel-edp.c
> +++ b/drivers/gpu/drm/panel/panel-edp.c
> @@ -1915,6 +1915,7 @@ static const struct edp_panel_entry edp_panels[] =
=3D {
>         EDP_PANEL_ENTRY('B', 'O', 'E', 0x0c20, &delay_200_500_e80, "NT140=
FHM-N47"),
>         EDP_PANEL_ENTRY('B', 'O', 'E', 0x0cb6, &delay_200_500_e200, "NT11=
6WHM-N44"),
>         EDP_PANEL_ENTRY('B', 'O', 'E', 0x0cfa, &delay_200_500_e50, "NV116=
WHM-A4D"),
> +       EDP_PANEL_ENTRY('B', 'O', 'E', 0x0c93, &delay_200_500_e200, "Unkn=
own"),

This is sorted incorrectly. I'll fix it for you this time while
applying, but in the future make sure you sort numerically. 0x0c93
should be before 0x0cb6.

Reviewed-by: Douglas Anderson <dianders@chromium.org>

Pushed to drm-misc-next:

[3/4] drm/panel-edp: Add unknown BOE panel for HP Omnibook X14
      commit: c1bae6802ee9c8ad8e3c1df7ca3174d6b4b260e5

