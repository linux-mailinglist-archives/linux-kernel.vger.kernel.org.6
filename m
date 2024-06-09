Return-Path: <linux-kernel+bounces-207451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 10D06901753
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jun 2024 19:41:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 280DD1C20B70
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jun 2024 17:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9689017554;
	Sun,  9 Jun 2024 17:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ABMxO1ut"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437A847A40
	for <linux-kernel@vger.kernel.org>; Sun,  9 Jun 2024 17:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717954886; cv=none; b=TANHMY6ox2e4qSS3s2TlBvxHYUTyhmXOJIwKMOpNi9Z4QRUcM0uRrWQ3pu57EmvP0g83+NbnVyuhrEsrz87Wbmru3T0LKHVCiWuWSZ02ACqufylLnIdEHGIPC+Yhf0lRMfiVk7xTTrU6q/60Tx/XLV68sN/1vmSMOuMDU9BWBtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717954886; c=relaxed/simple;
	bh=w3a7fvB29GfWdZ5y0r1ZUW3aa87+9cKwUWO2cYlJ3SM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B0mBrbHjxzZEtyewClxQ+AgPM/CVD7V8zCF1tyoyBh5qVWNeSCPA45uCHOxcl144evg/tYwadToktTMXP55teQ2zLLUTmXQzdzp8jy2vlrSuziNAah1fTx7fIsGMv7osLgxEqeRE4EuiWUcrsjO3JNsPw5IPzlWPokrm3ep7uvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ABMxO1ut; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2c2e31d319eso667561a91.1
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jun 2024 10:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717954884; x=1718559684; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TU6uzy6Znj21ZkzrxgGT3l5nBGIbu+NflqZO4C9QeU8=;
        b=ABMxO1utuf0fjsqYZBR0INC2dNm73T7UdWl6pIq0E3jEI4JjTDItjVg4C+1fbEAJ0W
         CM9TcHU5bd8dAYxfn4NrvRu0Btp3dgwSIKx8B0sOQULk3O+pATmqKWmIeGU/XhcCzok8
         WAFRqiqCSbtgnkwOUYNR1Kv0dR0RX7UmIeeUqFjZ7U2pD6GE6SNAlp0YchheIAh+adfb
         UKx027i/c1pFuEXs17D1/DLnO6rzMQ3DmFQ0CaLGzudhZ77BtvUV3JQNsEzbVp7Jc4IC
         uwYIeq8EhPLcKLArcF6iCRYvOS8Ii6383Pggx0EEVCqUKU+PDiYJTcuwSs5YgT3W3R6A
         kBPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717954884; x=1718559684;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TU6uzy6Znj21ZkzrxgGT3l5nBGIbu+NflqZO4C9QeU8=;
        b=KM6696nq9e7rx2/7PzFALhBoXJ0FjmemycvroL+KL9oQfhNzgEo9CWE/N19vxDKZ3s
         CS8y+wPFsf4VjYLWQWFEwhAaYbsWiKi9reU5qM4OBlqm0dwxh9VcRGiQewWcgh4P5pX8
         bcBiyJRjZB9wMscwJ6WdxvqGiooXfRpwZc7ZDK4pfSydKIp3SyJCx4QeUJwvSL8Lg2qI
         0ecNnXKYo+Ta9Zla7IbryL68W8OMEJdmtB6VaXVJKWyMhnDmQhyMG+K4tkTnv6WPkar9
         vNZSKn83wfnPKaK2S4L6O3M7ai5qI98qutSWDR0o3yMDb/jdzP0pTCekGOG8qBKdP2Po
         8UQQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/aSOHuEERsdOtbILp1IBiEGWdVKnc98cUao4vYzTsy+cHe4C6azrfxZoF8ybV/iz2OYjojvOAK17bLemyo7/tgMyddlwGl5uSyGiy
X-Gm-Message-State: AOJu0YyB9C3IPj225AxJurDOYimqYWdyEBq/EXXEfR00AioEn2Juj24t
	5UcPCL4nUrurfkVvTSBK9QDl2K2Wq7j/oBJMfLvrsGNL2gc2jGprtW/Dp8i+v5ZKVD7JwWNAEW0
	Z1keSzYaBNNhhz8VyoD9Wd74OdZU=
X-Google-Smtp-Source: AGHT+IGBA2o2mU7yH6Ev7JEO8G+3z4qUuZ8QKX9g9LD1fV6N+OLe1etE1oCNgxpSMpEY1SEYkQe/lE7ygEyABBAozbY=
X-Received: by 2002:a17:90a:bf0a:b0:2c2:d732:3bc8 with SMTP id
 98e67ed59e1d1-2c2d7323ef4mr3816893a91.21.1717954884398; Sun, 09 Jun 2024
 10:41:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240601132459.81123-1-aford173@gmail.com>
In-Reply-To: <20240601132459.81123-1-aford173@gmail.com>
From: Adam Ford <aford173@gmail.com>
Date: Sun, 9 Jun 2024 12:41:13 -0500
Message-ID: <CAHCN7x+WaHvWk7-nHURy+PA0+9voYNd+RJewm5ie_niBFTAFyA@mail.gmail.com>
Subject: Re: [PATCH V2] drm/bridge: adv7511: Fix Intermittent EDID failures
To: dri-devel@lists.freedesktop.org
Cc: dmitry.baryshkov@linaro.org, victor.liu@nxp.com, sui.jingfeng@linux.dev, 
	aford@beaconembedded.com, Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 1, 2024 at 8:25=E2=80=AFAM Adam Ford <aford173@gmail.com> wrote=
:
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
> Reported-by: Liu Ying <victor.liu@nxp.com>
> Fixes: f3d9683346d6 ("drm/bridge: adv7511: Allow IRQ to share GPIO pins")
> Signed-off-by: Adam Ford <aford173@gmail.com>
> Tested-by: Liu Ying <victor.liu@nxp.com> # i.MX8MP EVK ADV7535 EDID retri=
eval w/o IRQ

Gentile nudge on this.  It would be nice to get this fix applied since
it caused a regression.

adam

> ---
> V2:  Fix uninitialized cec_status
>      Cut back a little on error handling to return either IRQ_NONE or
>      IRQ_HANDLED.
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
> index 44451a9658a3..651fb1dde780 100644
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
> +               return irq_status;
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
> index 66ccb61e2a66..c8d2c4a157b2 100644
> --- a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
> +++ b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
> @@ -469,6 +469,8 @@ static int adv7511_irq_process(struct adv7511 *adv751=
1, bool process_hpd)
>  {
>         unsigned int irq0, irq1;
>         int ret;
> +       int cec_status =3D IRQ_NONE;
> +       int irq_status =3D IRQ_NONE;
>
>         ret =3D regmap_read(adv7511->regmap, ADV7511_REG_INT(0), &irq0);
>         if (ret < 0)
> @@ -478,29 +480,31 @@ static int adv7511_irq_process(struct adv7511 *adv7=
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
> @@ -509,7 +513,7 @@ static irqreturn_t adv7511_irq_handler(int irq, void =
*devid)
>         int ret;
>
>         ret =3D adv7511_irq_process(adv7511, true);
> -       return ret < 0 ? IRQ_NONE : IRQ_HANDLED;
> +       return ret < 0 ? IRQ_NONE : ret;
>  }
>
>  /* ---------------------------------------------------------------------=
--------
> --
> 2.43.0
>

