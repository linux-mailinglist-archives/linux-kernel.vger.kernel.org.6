Return-Path: <linux-kernel+bounces-169780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF6918BCD8E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 14:13:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEE821C227B3
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 12:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00F06143C72;
	Mon,  6 May 2024 12:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XG/A/0RP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40DCC143C52
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 12:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714997588; cv=none; b=Pz4mbmMqqy27jnP0UsWKOtiNkT06GNHujjpVER3VLUPGZq+8cuWiLZ1VSGfrLijdUmyJiSrOYqpjBlZj4iA0Wej26OI7EZO6IkvLY+Eni9bJ9MqMXgxq7ZyAIR/EbyFDqvXGrfnjJ/LauOHrjdTxbla6YKBb/wDQtp1zb8KRRtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714997588; c=relaxed/simple;
	bh=SJorlvBhI60itC7iiQx26RslvUGaX59HbR2ZqMGANGk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FHcfme9mPMGmY+0wnlSMgSkdSgLwvc1gpFdSfN/gCZcQ/0tW1EWLg3Oo0sb2eszKVU5r/54VrHNqxKmSR6UmYRmTgK4yO21vtJtbW6jZkrN5xwzKgI4X+KYwjfKTtLdOlHLh/YmLhvUbpnBFXwa8rE4UKwXSDqfPakLHqZj1btU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XG/A/0RP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFD30C4DDE6
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 12:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714997587;
	bh=SJorlvBhI60itC7iiQx26RslvUGaX59HbR2ZqMGANGk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=XG/A/0RPtmpxF8KzxNDsBqtVTipjfffh68vuGTv4CF1NkIzQcAl66ev7nIH4aEVEb
	 g1v+inLWVqSwUyx7srz68yAnEiqj5LmAuMewDtjCYc2D6a5wK6R132ZZOOnYt75d9L
	 VglcF7MA6E7+inXJ17Fv/GC9aNZFi54ENR1FixCPQVmJ6iCYksGkmPUeKyhJrnm8Mj
	 AZWCJCQxfW3epDHCFWqVjOj4Jsu0Y6JxpHjSFHSysdU1gP0pcDv3bNcCWtTEYPDEn4
	 918uJoFaEWrnGkCQrFejpsj1IMRE50xLkTo74zErAl6kfVr7S2Q85YP0Ud7F9GLi0u
	 RnfF1iFh/v9QQ==
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-dc6dcd9124bso1519198276.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2024 05:13:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWGlXLFxXNwOlIJpGCs1QFF32s/5eJODmH49SAjZJYJEziQYus0kwVQKfcLo9Iay59NAwKiyZ52pK/7KHgQxVctPBhkLATy12DYzvAN
X-Gm-Message-State: AOJu0YzLWCb/r29NA5bS7tEv7uHRYspKeNblyjkgNDsCulNvFXtA+89z
	wa6rV2GXOjZ3XcTj9Sak9ksFMnYLaj5nNBqnqPyUQIwv1Jnif9UDcNAgr5W05gFhV0VK9L2enGz
	YsKCD+MqJ2lOpNvdgYvfQfp+DwJTRcK4NxxWakQ==
X-Google-Smtp-Source: AGHT+IEdvvzDKPPs35mauLYBPaP2BlZLW/tD4jzIuzbyL2tiOrWFfQ0DbgvnC6EA7OV6cZIuLrHmcp8oSAKySJVe49A=
X-Received: by 2002:a05:6902:1b01:b0:ddd:7456:d203 with SMTP id
 eh1-20020a0569021b0100b00ddd7456d203mr11606197ybb.41.1714997586640; Mon, 06
 May 2024 05:13:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240502-anx-tdm-v1-0-894a9f634f44@chromium.org> <20240502-anx-tdm-v1-2-894a9f634f44@chromium.org>
In-Reply-To: <20240502-anx-tdm-v1-2-894a9f634f44@chromium.org>
From: Robert Foss <rfoss@kernel.org>
Date: Mon, 6 May 2024 14:12:55 +0200
X-Gmail-Original-Message-ID: <CAN6tsi79jNhCybjyX3aQjXAP_J6MpjuCBL5q2aFrgjENPt60kA@mail.gmail.com>
Message-ID: <CAN6tsi79jNhCybjyX3aQjXAP_J6MpjuCBL5q2aFrgjENPt60kA@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/bridge: anx7625: Change TDM setting accroding to
 dt property
To: Hsin-Te Yuan <yuanhsinte@chromium.org>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Xin Ji <xji@analogixsemi.com>, dri-devel@lists.freedesktop.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 2, 2024 at 11:03=E2=80=AFAM Hsin-Te Yuan <yuanhsinte@chromium.o=
rg> wrote:
>
> For some SoCs, the TDM setting is not to shift the first audio data bit,
> which is not the default setting of anx7625. In such cases, the TDM
> setting should be changed according to the device tree property.
>
> Signed-off-by: Hsin-Te Yuan <yuanhsinte@chromium.org>
> ---
>  drivers/gpu/drm/bridge/analogix/anx7625.c | 8 ++++++++
>  drivers/gpu/drm/bridge/analogix/anx7625.h | 1 +
>  2 files changed, 9 insertions(+)
>
> diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/drm/=
bridge/analogix/anx7625.c
> index 29d91493b101a..538edddf313c9 100644
> --- a/drivers/gpu/drm/bridge/analogix/anx7625.c
> +++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
> @@ -1709,6 +1709,9 @@ static int anx7625_parse_dt(struct device *dev,
>         if (of_property_read_bool(np, "analogix,audio-enable"))
>                 pdata->audio_en =3D 1;
>
> +       if(!of_property_read_bool(np, "no-shift-audio-data"))
> +               pdata->shift_audio_data =3D 1;

checkpatch --strict reports this:

ERROR: space required before the open parenthesis '('
#27: FILE: drivers/gpu/drm/bridge/analogix/anx7625.c:1712:
+    if(!of_property_read_bool(np, "no-shift-audio-data"))


> +
>         return 0;
>  }
>
> @@ -1866,6 +1869,11 @@ static int anx7625_audio_hw_params(struct device *=
dev, void *data,
>                                            ~TDM_SLAVE_MODE,
>                                            I2S_SLAVE_MODE);
>
> +       if (!ctx->pdata.shift_audio_data)
> +               ret |=3D anx7625_write_or(ctx, ctx->i2c.tx_p2_client,
> +                                      AUDIO_CONTROL_REGISTER,
> +                                      TDM_TIMING_MODE);
> +
>         /* Word length */
>         switch (params->sample_width) {
>         case 16:
> diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.h b/drivers/gpu/drm/=
bridge/analogix/anx7625.h
> index 39ed35d338363..41b395725913a 100644
> --- a/drivers/gpu/drm/bridge/analogix/anx7625.h
> +++ b/drivers/gpu/drm/bridge/analogix/anx7625.h
> @@ -441,6 +441,7 @@ struct anx7625_platform_data {
>         u8 lane1_reg_data[DP_TX_SWING_REG_CNT];
>         u32 low_power_mode;
>         struct device_node *mipi_host_node;
> +       int shift_audio_data;
>  };
>
>  struct anx7625_i2c_client {
>
> --
> 2.45.0.rc1.225.g2a3ae87e7f-goog
>
>

