Return-Path: <linux-kernel+bounces-185494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 838238CB586
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 23:51:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A73271C20BDB
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 21:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58D16149C46;
	Tue, 21 May 2024 21:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i4mTF8ay"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC98487B0
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 21:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716328291; cv=none; b=Kmwsj/lflsmTvzwsIlb7dY4oXV6yy61ohcFuj70zhzSQ1mUKc5mwk/GpcHj8zVRC124ePQ4zKTjNyJwW4kQQ0IH+bLNZ65vcTlXakl0+YpQiPfqX+p83slq7qi8V2cIRjd6NYXEqGXxjU9rRFU68nh9E/09Nrh2S37n6S78ILWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716328291; c=relaxed/simple;
	bh=a2rFyee2fBpbZouMxQuPT31n33FPbjaQZfbBj7wzou8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YApyv9LR9DetmgOPdLHG1ZHhLcnac0s2ovVHyKXjgQo2jT2DZDA88l6/zGaby4gVHdKiYaZjCYmK+iiVjKqjxzUist9PdpdJZiT0JSjf0NWOaL5jJuXikms4cce0iEpnabjPldopnosu9mh0Wn+/G7Y6e/+BBFDqZOHz0yZCk38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i4mTF8ay; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2b9dcc745a4so1579581a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 14:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716328289; x=1716933089; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YzGwiMWKicO+U9PU45V7Oy7/ik9CdkBfeQ1fSiNtONg=;
        b=i4mTF8ayRQdqcLCOZAPKetFkrEHw4Qd77Jy8Y1ADw+lpuDYnFI6BjeurRQTt/apurX
         v1dU0KOso/m1PFHkmW9ct9F7bG9aHLx4q5SAFBmbSDylAAjU4Dx9Ww8hGdjSzeFOnEv8
         MBmmCQRcvlqszx2AMeM9dc2eOpqWzDSUB8almpKLkM5ZTtsRX+24WevwIiZYjq+duOuQ
         f+pr7EwMxHItcxcuh5nMttt3dkLGIUPFrIV96jbSaLdo/lLw3iYbCwlT4GLXj2f6kO1A
         vN+8JV5K10tPDo/tUVYJTXan2yZ/F9q+K4pmYnbSBKSKFqSeGXdbihRZglQWopdYA18e
         F9Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716328289; x=1716933089;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YzGwiMWKicO+U9PU45V7Oy7/ik9CdkBfeQ1fSiNtONg=;
        b=bKPQfqWhXMlm/pui7QP7TOYNL7DsYMjh2O72yrDKfqU5HapQNf/IL4/epCcwlCuyjU
         8mbbIRSLbaTxGeFzwY21nMyjeSAolptJ6/xz5bJqkpRy+0G4pjQD531M4nI0swHZ45bH
         nY+TtwZhMrKlxcni2oScqsFqKk+O5RzEbYbcp8E4wXJxdpF9rF0LDjC2HPU4ETeU4fm5
         30ScF/spVkbvWGN44wmlKPpt3Gzk2MYWsYHLbd03f6Iu0xHb4xrEPCqo7bfb1UX0rIX1
         xUloLr9H77g3apwkT+vuu9WZPePO6N1Ya1Ym2kw7vjwoCDK4S8qxq4HVVw3DUToi75MB
         y/fQ==
X-Forwarded-Encrypted: i=1; AJvYcCUgObGXZq2ZywE++TQs1iaCE2QbkYjIRaGa2mTEXYWU8xIZbB0bqBuntTfJON2x0jxL+Jgs5pNHPja952bMcYoummJTRROmgug0A7Al
X-Gm-Message-State: AOJu0YwamHOvIzJlgk9kc/UQ+sS6bVGM6oHpM5dMi3cDUPYa1lT1rFMb
	Pnn77ihT/JaOEzl5mm7bZi1VQoFI5DbTqUxOc661qLZ0dvfbdkziY1uyE5Yecd0+Rz5nqjLiKMN
	FUBiByzz1fVJcweh/ezfQak8XYR8=
X-Google-Smtp-Source: AGHT+IHZqaPQkPdZWSl9z29CGJIis2+ErhBN3A/J2WUph6DXN2PIWxcF7hyrEajPTWJIclj8xB/FhZfjtqr8l6YsjyE=
X-Received: by 2002:a17:90a:bf05:b0:2af:2be3:89c5 with SMTP id
 98e67ed59e1d1-2bd9f48fe3dmr361892a91.29.1716328288992; Tue, 21 May 2024
 14:51:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240521011614.496421-1-aford173@gmail.com>
In-Reply-To: <20240521011614.496421-1-aford173@gmail.com>
From: Adam Ford <aford173@gmail.com>
Date: Tue, 21 May 2024 16:51:17 -0500
Message-ID: <CAHCN7xLekU9u0auzB+bt7cRgv48qxH8bRY2e-_nK0nUhaLJagA@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge: adv7511: Fix Intermittent EDID failures
To: dri-devel@lists.freedesktop.org
Cc: dmitry.baryshkov@linaro.org, sui.jingfeng@linux.dev, 
	aford@beaconembedded.com, Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	linux-kernel@vger.kernel.org, Liu Ying <victor.liu@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 20, 2024 at 8:16=E2=80=AFPM Adam Ford <aford173@gmail.com> wrot=
e:
>
> In the process of adding support for shared IRQ pins, a scenario
> was accidentally created where adv7511_irq_process returned
> prematurely causing the EDID to fail randomly.
>
> Since the interrupt handler is broken up into two main helper functions,
> update both of them to treat the helper functions as IRQ handlers. These
> IRQ routines process their respective tasks as before, but if they
> determine that actual work was done, mark the respective IRQ status
> accordingly, and delay the check until everything has been processed.
>
> This should guarantee the helper functions don't return prematurely
> while still returning proper values of either IRQ_HANDLED or IRQ_NONE.
>
> Reported by: Liu Ying <victor.liu@nxp.com>
> Fixes: f3d9683346d6 ("drm/bridge: adv7511: Allow IRQ to share GPIO pins")
> Signed-off-by: Adam Ford <aford173@gmail.com>

+ Liu

Sorry about the e-mail address copy-paste error.
>
> diff --git a/drivers/gpu/drm/bridge/adv7511/adv7511.h b/drivers/gpu/drm/b=
ridge/adv7511/adv7511.h
> index ea271f62b214..ec0b7f3d889c 100644
> --- a/drivers/gpu/drm/bridge/adv7511/adv7511.h
> +++ b/drivers/gpu/drm/bridge/adv7511/adv7511.h
> @@ -401,7 +401,7 @@ struct adv7511 {
>
>  #ifdef CONFIG_DRM_I2C_ADV7511_CEC
>  int adv7511_cec_init(struct device *dev, struct adv7511 *adv7511);
> -void adv7511_cec_irq_process(struct adv7511 *adv7511, unsigned int irq1)=
;
> +int adv7511_cec_irq_process(struct adv7511 *adv7511, unsigned int irq1);
>  #else
>  static inline int adv7511_cec_init(struct device *dev, struct adv7511 *a=
dv7511)
>  {
> diff --git a/drivers/gpu/drm/bridge/adv7511/adv7511_cec.c b/drivers/gpu/d=
rm/bridge/adv7511/adv7511_cec.c
> index 44451a9658a3..4efb2cabf1b5 100644
> --- a/drivers/gpu/drm/bridge/adv7511/adv7511_cec.c
> +++ b/drivers/gpu/drm/bridge/adv7511/adv7511_cec.c
> @@ -119,7 +119,7 @@ static void adv7511_cec_rx(struct adv7511 *adv7511, i=
nt rx_buf)
>         cec_received_msg(adv7511->cec_adap, &msg);
>  }
>
> -void adv7511_cec_irq_process(struct adv7511 *adv7511, unsigned int irq1)
> +int adv7511_cec_irq_process(struct adv7511 *adv7511, unsigned int irq1)
>  {
>         unsigned int offset =3D adv7511->info->reg_cec_offset;
>         const u32 irq_tx_mask =3D ADV7511_INT1_CEC_TX_READY |
> @@ -130,17 +130,21 @@ void adv7511_cec_irq_process(struct adv7511 *adv751=
1, unsigned int irq1)
>                                 ADV7511_INT1_CEC_RX_READY3;
>         unsigned int rx_status;
>         int rx_order[3] =3D { -1, -1, -1 };
> -       int i;
> +       int i, ret =3D 0;
> +       int irq_status =3D IRQ_NONE;
>
> -       if (irq1 & irq_tx_mask)
> +       if (irq1 & irq_tx_mask) {
>                 adv_cec_tx_raw_status(adv7511, irq1);
> +               irq_status =3D IRQ_HANDLED;
> +       }
>
>         if (!(irq1 & irq_rx_mask))
> -               return;
> +               return irq_status;
>
> -       if (regmap_read(adv7511->regmap_cec,
> -                       ADV7511_REG_CEC_RX_STATUS + offset, &rx_status))
> -               return;
> +       ret =3D regmap_read(adv7511->regmap_cec,
> +                       ADV7511_REG_CEC_RX_STATUS + offset, &rx_status);
> +       if (ret < 0)
> +               return ret;
>
>         /*
>          * ADV7511_REG_CEC_RX_STATUS[5:0] contains the reception order of=
 RX
> @@ -172,6 +176,8 @@ void adv7511_cec_irq_process(struct adv7511 *adv7511,=
 unsigned int irq1)
>
>                 adv7511_cec_rx(adv7511, rx_buf);
>         }
> +
> +       return IRQ_HANDLED;
>  }
>
>  static int adv7511_cec_adap_enable(struct cec_adapter *adap, bool enable=
)
> diff --git a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c b/drivers/gpu/d=
rm/bridge/adv7511/adv7511_drv.c
> index 66ccb61e2a66..56dd2d5a0376 100644
> --- a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
> +++ b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
> @@ -469,6 +469,8 @@ static int adv7511_irq_process(struct adv7511 *adv751=
1, bool process_hpd)
>  {
>         unsigned int irq0, irq1;
>         int ret;
> +       int cec_status;
> +       int irq_status =3D IRQ_NONE;
>
>         ret =3D regmap_read(adv7511->regmap, ADV7511_REG_INT(0), &irq0);
>         if (ret < 0)
> @@ -478,38 +480,41 @@ static int adv7511_irq_process(struct adv7511 *adv7=
511, bool process_hpd)
>         if (ret < 0)
>                 return ret;
>
> -       /* If there is no IRQ to handle, exit indicating no IRQ data */
> -       if (!(irq0 & (ADV7511_INT0_HPD | ADV7511_INT0_EDID_READY)) &&
> -           !(irq1 & ADV7511_INT1_DDC_ERROR))
> -               return -ENODATA;
> -
>         regmap_write(adv7511->regmap, ADV7511_REG_INT(0), irq0);
>         regmap_write(adv7511->regmap, ADV7511_REG_INT(1), irq1);
>
> -       if (process_hpd && irq0 & ADV7511_INT0_HPD && adv7511->bridge.enc=
oder)
> +       if (process_hpd && irq0 & ADV7511_INT0_HPD && adv7511->bridge.enc=
oder) {
>                 schedule_work(&adv7511->hpd_work);
> +               irq_status =3D IRQ_HANDLED;
> +       }
>
>         if (irq0 & ADV7511_INT0_EDID_READY || irq1 & ADV7511_INT1_DDC_ERR=
OR) {
>                 adv7511->edid_read =3D true;
>
>                 if (adv7511->i2c_main->irq)
>                         wake_up_all(&adv7511->wq);
> +               irq_status =3D IRQ_HANDLED;
>         }
>
>  #ifdef CONFIG_DRM_I2C_ADV7511_CEC
> -       adv7511_cec_irq_process(adv7511, irq1);
> +       cec_status =3D adv7511_cec_irq_process(adv7511, irq1);
> +
> +       if (cec_status < 0)
> +               return cec_status;
>  #endif
>
> -       return 0;
> +       /* If there is no IRQ to handle, exit indicating no IRQ data */
> +       if (irq_status =3D=3D IRQ_HANDLED || cec_status =3D=3D IRQ_HANDLE=
D)
> +               return IRQ_HANDLED;
> +
> +       return IRQ_NONE;
>  }
>
>  static irqreturn_t adv7511_irq_handler(int irq, void *devid)
>  {
>         struct adv7511 *adv7511 =3D devid;
> -       int ret;
>
> -       ret =3D adv7511_irq_process(adv7511, true);
> -       return ret < 0 ? IRQ_NONE : IRQ_HANDLED;
> +       return adv7511_irq_process(adv7511, true);
>  }
>
>  /* ---------------------------------------------------------------------=
--------
> --
> 2.43.0
>

