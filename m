Return-Path: <linux-kernel+bounces-411259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97C579CF53F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 20:49:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CCAC1F2A6BF
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 19:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5CCE1E2009;
	Fri, 15 Nov 2024 19:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HINu09E3"
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414001E0E1E
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 19:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731700157; cv=none; b=YvkfYtp7LzR7F4O0rusMxLCX0UFkzbcB8gGVIBkNNkvn9WjTOn/qCwi2Gu7cm5IdsVlQgj7fCaitRZ6mOq9LxINTqB1JEHhvw62z/ddtYThxTq4Yrcm0lc8T757wCrI7o6dKlCmaOc/35MiFlrcJUfahsTFBnSjAS/sOM7FENps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731700157; c=relaxed/simple;
	bh=UPYHjAvjhpVrrn2vrGx+b8gmgz/IHKUoLfHMVL7UPC0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ww+uAFcqfjYRqNWLNh9Z7Qp1FzJZlsCJxrGJMPM/CVnPRxU8lTXc3U00WUb6bawOtIB4JtxdWQv0ces+YYQF0NXQ1P9sWRGjP8wHNuV6oGkG2Qn3tQRFDxBo3L7rSOurlbes0kjarpftk0dkpnwiFp4rvTpl5rbL3p/8IOcOa3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HINu09E3; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6ee6a2ae6ecso5871487b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 11:49:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731700154; x=1732304954; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=y94fAUfM+3cNhhFqsHNtgfO9Mz5/U4lZKL82t/xQEL8=;
        b=HINu09E3ZUHSk1TUaYPh+TzdP22xJNo4OyHPWMnZ7unJwbrKF6p2nmuv+C96/AiYid
         6XJSSi5AEPwyqxve7W6pApRuXztzTnHuURu07wjObQXKUQqzyjLolkcmQhcPeFg5SyDZ
         IayCRr1FPzlgiSy7Pv8L1/BZXT31vGIsW6sASxJlwBmjMpewKP9TWtfJnAczeCX6md3r
         aDKY8XdIaz2ry1cUMTBOixw250nONs4/rINjJysNBw/9ovx6iS/SbtXPHNVPJWBXUc/P
         XxAY2awJIg8+mInz1LoInWPOlT7GIqaWr1UI9BINRssbC1fT2LngaaQCqekRQ4pQiYBl
         re7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731700154; x=1732304954;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y94fAUfM+3cNhhFqsHNtgfO9Mz5/U4lZKL82t/xQEL8=;
        b=rzOaI3aLgO1H3TloXpUgx4iDgqrPjh/YODVgQc4KyRaZQDmZmI99YZcvQyVUvaNMNH
         9PgiYmUVUcaMQaSlYn/u8VgFbRa7DggwwhdGg2wJmwVPp5fZBdQD62GNm9BC6M2cDP31
         E9/sH9AgKrVOYN3BmGs3GS4cdbdMbXwUCcglZgb9TQ1MPLfwCpCfJPz4OCRkbYz/DraD
         750Nfu8acI6GDW+IWwDhGNgmPOri8LAoifiC0OdSEtEf8xKxnHGppXaevXkqj7Z9XtBB
         TP++8cc5k1cfxYJCyjV9k9Hcj1IMuE3tadG+aagkahij2hfZh9jzjffj2Xt62v+wjaNc
         4jKQ==
X-Forwarded-Encrypted: i=1; AJvYcCX9Fx+OR/HZcPl566JYczyN9UVT0BHBqUp7wd/XGlCMh3ANcekYxVGuIBbUeQM5XJBJsNz0RIw3baPP37M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwniH5KcfFEu7Dlw2MSSS5YOfT8zgk4qUIQ4L3o7kjg5AsOq36K
	2s9/dXasbLTHB7Qi0bv2oaVxxm+2QScPMW0B5h66+4gFLq3l0JTi5939AvH41TETaF09v9FQrVz
	wVBTVu/ahDqMUMBJvKwxLw/WowQvu4+iZ1DW3LQ==
X-Google-Smtp-Source: AGHT+IEzAvh8fLR6Ax4JJe+zyTZnsvfTpgwuFH5OGzKisu4bE6+zEnCKOEYNIoshN2LGpyOsGJ6ZS1RXQUCkY67ASlM=
X-Received: by 2002:a05:690c:9b10:b0:6e5:d35b:ca80 with SMTP id
 00721157ae682-6ee55a2f663mr39231287b3.5.1731700154212; Fri, 15 Nov 2024
 11:49:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241113-adv7511-audio-info-frame-v1-1-49b368b995a5@axis.com>
 <nramdgi4pziet3ypwdi32zolnhdzualv4rpov372s4mfsakdhs@7qjro2oaef7i> <d7121d00-4353-2901-e87b-7fef7da5a35f@axis.com>
In-Reply-To: <d7121d00-4353-2901-e87b-7fef7da5a35f@axis.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 15 Nov 2024 21:49:03 +0200
Message-ID: <CAA8EJpqbMvevmWZ3AbQOwBbVUOkUPHB_mrv+BtLndAcpLmcVpA@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge: adv7511_audio: Update Audio InfoFrame properly
To: Stefan Ekenberg <stefan.ekenberg@axis.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Robert Foss <rfoss@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	kernel@axis.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 15 Nov 2024 at 14:25, Stefan Ekenberg <stefan.ekenberg@axis.com> wrote:
>
> On 11/15/24 09:16, Dmitry Baryshkov wrote:
> > On Wed, Nov 13, 2024 at 08:38:11AM +0100, Stefan Ekenberg wrote:
> >> AUDIO_UPDATE bit (Bit 5 of MAIN register 0x4A) needs to be set to 1
> >> while updating Audio InfoFrame information and then set to 0 when done.
> >> Otherwise partially updated Audio InfoFrames could be sent out. Two
> >> cases where this rule were not followed are fixed:
> >>   - In adv7511_hdmi_hw_params() make sure AUDIO_UPDATE bit is updated
> >>     before/after setting ADV7511_REG_AUDIO_INFOFRAME.
> >>   - In audio_startup() use the correct register for clearing
> >>     AUDIO_UPDATE bit.
> >>
> >> The problem with corrupted audio infoframes were discovered by letting
> >> a HDMI logic analyser check the output of ADV7535.
> >>
> >> Signed-off-by: Stefan Ekenberg <stefan.ekenberg@axis.com>
> >
> > Missing Fixes tag,
>
> Ok, I will add Fixes tag.
>
> >
> >> ---
> >>   drivers/gpu/drm/bridge/adv7511/adv7511_audio.c | 14 ++++++++++++--
> >>   1 file changed, 12 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/bridge/adv7511/adv7511_audio.c b/drivers/gpu/drm/bridge/adv7511/adv7511_audio.c
> >> index 61f4a38e7d2bf6905683cbc9e762b28ecc999d05..8f786592143b6c81e5a434768b51508d5e5f3c73 100644
> >> --- a/drivers/gpu/drm/bridge/adv7511/adv7511_audio.c
> >> +++ b/drivers/gpu/drm/bridge/adv7511/adv7511_audio.c
> >> @@ -153,7 +153,16 @@ static int adv7511_hdmi_hw_params(struct device *dev, void *data,
> >>                         ADV7511_AUDIO_CFG3_LEN_MASK, len);
> >>      regmap_update_bits(adv7511->regmap, ADV7511_REG_I2C_FREQ_ID_CFG,
> >>                         ADV7511_I2C_FREQ_ID_CFG_RATE_MASK, rate << 4);
> >> -    regmap_write(adv7511->regmap, 0x73, 0x1);
> >> +
> >> +    /* send current Audio infoframe values while updating */
> >> +    regmap_update_bits(adv7511->regmap, ADV7511_REG_INFOFRAME_UPDATE,
> >> +                       BIT(5), BIT(5));
> >> +
> >> +    regmap_write(adv7511->regmap, ADV7511_REG_AUDIO_INFOFRAME(0), 0x1);
> >> +
> >> +    /* use Audio infoframe updated info */
> >> +    regmap_update_bits(adv7511->regmap, ADV7511_REG_INFOFRAME_UPDATE,
> >> +                       BIT(5), 0);
> >>
> >>      return 0;
> >>   }
> >> @@ -184,8 +193,9 @@ static int audio_startup(struct device *dev, void *data)
> >>      regmap_update_bits(adv7511->regmap, ADV7511_REG_GC(0),
> >>                              BIT(7) | BIT(6), BIT(7));
> >>      /* use Audio infoframe updated info */
> >> -    regmap_update_bits(adv7511->regmap, ADV7511_REG_GC(1),
> >> +    regmap_update_bits(adv7511->regmap, ADV7511_REG_INFOFRAME_UPDATE,
> >>                              BIT(5), 0);
> >
> > Should the REG_GC(1) still be written?
>
> The comment before this line states "use Audio infoframe updated info"
> and, before my change, bit 5 of REG_GC(1) was cleared by the line I
> removed. Bit 5 is positioned within field GC_PP[3:0] and that field
> doesn't control audio infoframe and is read-only. My conclusion
> therefore was that the author if this code actually meant to clear bit 5
> of REG_INFOFRAME_UPDATE from the very beginning. In short, clearing bit
> 5 of REG_GC(1) is invalid since it is a read-only field.

Ack, thanks for the explanation. It might be nice if you can include
this into the commit message.

>
> >
> >> +
> >>      /* enable SPDIF receiver */
> >>      if (adv7511->audio_source == ADV7511_AUDIO_SOURCE_SPDIF)
> >>              regmap_update_bits(adv7511->regmap, ADV7511_REG_AUDIO_CONFIG,
> >>
> >> ---
> >> base-commit: 59b723cd2adbac2a34fc8e12c74ae26ae45bf230
> >> change-id: 20241108-adv7511-audio-info-frame-54614dd4bf57
> >>
> >> Best regards,
> >> --
> >> Stefan Ekenberg <stefan.ekenberg@axis.com>
> >>
> >
>


-- 
With best wishes
Dmitry

