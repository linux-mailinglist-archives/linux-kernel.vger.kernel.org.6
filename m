Return-Path: <linux-kernel+bounces-217371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A3B290AED4
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 15:15:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5D1028A2F7
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 13:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBF55197A60;
	Mon, 17 Jun 2024 13:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kmn17JjF"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A937197A94
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 13:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718630096; cv=none; b=JGGLsKY4X7Rz2qO/iz3O+jJ3CV57yv4sV1Hue+CpAZcGHtRZhNuNh7ZJMQ1Pg2OQ14F6TCB8lkjaDTtg9OyVEv/Qjlzyz/gtCd2Z8oq40sOw5iclFkgBENtgPfCpu6hsGX9g0IcdXYsQGDYdf5Lya/te57wf2rytf23DQMH8sQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718630096; c=relaxed/simple;
	bh=5Jrcj3XAZumucm9m3uCSbRINLaB+oDyONv5QhCmT9Ls=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TA+YLarldJ6/NeFTVSXehwAtsOoloQvkg28gNm/JKv8jOQO7K31FXUOGy+f1B4pnGpehMU1BjAyw1NPaSmeBRS14pUCqeJ1meZFwqwXQwxPoQQWtv3IAyL7ZaEQmlUB1O+jrnj5I+n2nt2mp7JGmUUxoAIasEY+tlNJkaLUF3bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kmn17JjF; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-656d8b346d2so3063060a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 06:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718630094; x=1719234894; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7zPpuo+CDs0eM0LA7bPoQtMex24IJPtVQOpYyzHo8wQ=;
        b=kmn17JjFykeDRcNDc297HzEqcjleAApJ3IsvU4GpKyZdosTVKiZ8ad5S9QoVr+NmA6
         r2Bq9mdki2HzPdPT8PHA/IH7fnp4AGMojNcynf0SIuhz/Evln1ItEu+JBvDDRDcKH9t/
         Ot2lCZyvZyGSTDpIwQpJqoz9kTkDUAh4fKnVgNMUe4x4KyXHFEhY6RAoeVhTxVknk2Q0
         bL1rk3Ru+ZZDVnUMc4GS0e/plgwfw/RJMQVIm0WV9gH1zYezJ5P+xGzkbg10SV5sLRQF
         bQ5UKOmXrfyfMLbrtbcY63V1KjUImzUFFVWrC1rJxTG8ViQRK42/RFZuf96eElTATr++
         3nFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718630094; x=1719234894;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7zPpuo+CDs0eM0LA7bPoQtMex24IJPtVQOpYyzHo8wQ=;
        b=rjBfYMdYWhAmB8SXRlL6UTYuTzlIxwQF4lK/eBtwnGUTaT/51qHDhVDDrKAZgHiHHc
         g16laA9ySvA0AtHF/7FpRgypIeeHYSAgr85UjYunNW48sArqfBLQRZAfxBrBWYt+cVpq
         9H+rkdZPQL2lld/HLre4MDGtAhmEj7mbHfUwLkK/4CrgM3EnXeRUB19NoPwZ6ublupcE
         P9wooKTSxNwrnFiL7yqA0nzRMHzKFSE/mHFQIdeh+xN32+6528gEag7DrSTNejhRrG5W
         xRnNJEMt022hyrqjxcwuaZAm4MFCdZvj+mBvN6MrpAw4PiZR9ZYJb+DwKyWkNhetFyGC
         sYzw==
X-Forwarded-Encrypted: i=1; AJvYcCUI7NJG9BNEwJ+0h8zPEtWRUVOUMzFHpccJtCk2EvK7Czcf89MRZpaZ2nqpyCy4BP/kP8TCqdTHO3KeA0P6FKVAieFen3eejmKYGrx5
X-Gm-Message-State: AOJu0YxVMudFBgUmd5qTjiCnXE3R/5MCdlapkkFL7J4ZXI+eL2sWk9q1
	bIwWV7bwzMuseYORSjhxktG2iJhP7/deMpmxDd8r89+ADvU6YjA5L2kxthKsIyPprmeIfHTCxt/
	ezZIoaRq7TIL0VQNk8BxF/5/R8Zg=
X-Google-Smtp-Source: AGHT+IFI7N0581urBHdxi21Z7/cG3Jr5D1/48li0S0yh2RX7x3pBEvua4YDdatMFekw++9wWC7A7tkRWSf/7dhHyrbU=
X-Received: by 2002:a17:90a:ab8a:b0:2c4:b0f0:8013 with SMTP id
 98e67ed59e1d1-2c4db24b894mr8585594a91.11.1718630093378; Mon, 17 Jun 2024
 06:14:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240601132459.81123-1-aford173@gmail.com> <7015c544-14c3-40af-aa10-e3088eea5633@leemhuis.info>
In-Reply-To: <7015c544-14c3-40af-aa10-e3088eea5633@leemhuis.info>
From: Adam Ford <aford173@gmail.com>
Date: Mon, 17 Jun 2024 08:14:41 -0500
Message-ID: <CAHCN7xJfqcN=yqWAURuy-oF8EiwoB5i840Gct65xgqgxNSL_Ug@mail.gmail.com>
Subject: Re: [PATCH V2] drm/bridge: adv7511: Fix Intermittent EDID failures
To: Linux regressions mailing list <regressions@lists.linux.dev>
Cc: dmitry.baryshkov@linaro.org, victor.liu@nxp.com, sui.jingfeng@linux.dev, 
	aford@beaconembedded.com, Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 17, 2024 at 8:00=E2=80=AFAM Linux regression tracking (Thorsten
Leemhuis) <regressions@leemhuis.info> wrote:
>
> [CCing the regression list, as it should be in the loop for regressions:
> https://docs.kernel.org/admin-guide/reporting-regressions.html]
>
> Hi! Top-posting for once, to make this easily accessible to everyone.
>
> Hmm, seem nobody took a look at below fix for a regression that seems to
> be caused by f3d9683346d6b1 ("drm/bridge: adv7511: Allow IRQ to share
> GPIO pins") [which went into v6.10-rc1].
>
> Adam and Dimitry, what are your stances on this patch from Adam? I'm
> asking, as you authored respectively committed the culprit?
>

I learned of the regression from Liu Ying when he posted a proposed
fix [1] which then resulted in some further discussion on how to
better solve the issue.   I felt like I should be the one to fix the
issue, since I accidentally caused it when trying to allow for shared
GPIO IRQ's.  The shared GPIO IRQ was required on the imx8mp-beacon-kit
because the interrupt GPIO for the hot-plug-detect IRQ is shared with
a GPIO expander which also serves as an interrupt controller.

Dimitry had given me some suggestions, and from that,  I posted a V1.
Dmitry had some more followup suggestions [2] which resulted in the
V2.

As far as I know, Liu was satisfied that this addressed the regression
he reported.

adam


[1] - https://lore.kernel.org/linux-kernel/2f41a890-915b-4859-8ac9-5436da14=
fe22@nxp.com/T/
[2] - https://lore.kernel.org/all/7bb4d582-5d90-465e-a241-1ee8439a5057@nxp.=
com/T/

> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
> --
> Everything you wanna know about Linux kernel regression tracking:
> https://linux-regtracking.leemhuis.info/about/#tldr
> If I did something stupid, please tell me, as explained on that page.
>
> #regzbot poke
>
> On 01.06.24 15:24, Adam Ford wrote:
> > In the process of adding support for shared IRQ pins, a scenario
> > was accidentally created where adv7511_irq_process returned
> > prematurely causing the EDID to fail randomly.
> >
> > Since the interrupt handler is broken up into two main helper functions=
,
> > update both of them to treat the helper functions as IRQ handlers. Thes=
e
> > IRQ routines process their respective tasks as before, but if they
> > determine that actual work was done, mark the respective IRQ status
> > accordingly, and delay the check until everything has been processed.
> >
> > This should guarantee the helper functions don't return prematurely
> > while still returning proper values of either IRQ_HANDLED or IRQ_NONE.
> >
> > Reported-by: Liu Ying <victor.liu@nxp.com>
> > Fixes: f3d9683346d6 ("drm/bridge: adv7511: Allow IRQ to share GPIO pins=
")
> > Signed-off-by: Adam Ford <aford173@gmail.com>
> > Tested-by: Liu Ying <victor.liu@nxp.com> # i.MX8MP EVK ADV7535 EDID ret=
rieval w/o IRQ
> > ---
> > V2:  Fix uninitialized cec_status
> >      Cut back a little on error handling to return either IRQ_NONE or
> >      IRQ_HANDLED.
> >
> > diff --git a/drivers/gpu/drm/bridge/adv7511/adv7511.h b/drivers/gpu/drm=
/bridge/adv7511/adv7511.h
> > index ea271f62b214..ec0b7f3d889c 100644
> > --- a/drivers/gpu/drm/bridge/adv7511/adv7511.h
> > +++ b/drivers/gpu/drm/bridge/adv7511/adv7511.h
> > @@ -401,7 +401,7 @@ struct adv7511 {
> >
> >  #ifdef CONFIG_DRM_I2C_ADV7511_CEC
> >  int adv7511_cec_init(struct device *dev, struct adv7511 *adv7511);
> > -void adv7511_cec_irq_process(struct adv7511 *adv7511, unsigned int irq=
1);
> > +int adv7511_cec_irq_process(struct adv7511 *adv7511, unsigned int irq1=
);
> >  #else
> >  static inline int adv7511_cec_init(struct device *dev, struct adv7511 =
*adv7511)
> >  {
> > diff --git a/drivers/gpu/drm/bridge/adv7511/adv7511_cec.c b/drivers/gpu=
/drm/bridge/adv7511/adv7511_cec.c
> > index 44451a9658a3..651fb1dde780 100644
> > --- a/drivers/gpu/drm/bridge/adv7511/adv7511_cec.c
> > +++ b/drivers/gpu/drm/bridge/adv7511/adv7511_cec.c
> > @@ -119,7 +119,7 @@ static void adv7511_cec_rx(struct adv7511 *adv7511,=
 int rx_buf)
> >       cec_received_msg(adv7511->cec_adap, &msg);
> >  }
> >
> > -void adv7511_cec_irq_process(struct adv7511 *adv7511, unsigned int irq=
1)
> > +int adv7511_cec_irq_process(struct adv7511 *adv7511, unsigned int irq1=
)
> >  {
> >       unsigned int offset =3D adv7511->info->reg_cec_offset;
> >       const u32 irq_tx_mask =3D ADV7511_INT1_CEC_TX_READY |
> > @@ -130,17 +130,21 @@ void adv7511_cec_irq_process(struct adv7511 *adv7=
511, unsigned int irq1)
> >                               ADV7511_INT1_CEC_RX_READY3;
> >       unsigned int rx_status;
> >       int rx_order[3] =3D { -1, -1, -1 };
> > -     int i;
> > +     int i, ret =3D 0;
> > +     int irq_status =3D IRQ_NONE;
> >
> > -     if (irq1 & irq_tx_mask)
> > +     if (irq1 & irq_tx_mask) {
> >               adv_cec_tx_raw_status(adv7511, irq1);
> > +             irq_status =3D IRQ_HANDLED;
> > +     }
> >
> >       if (!(irq1 & irq_rx_mask))
> > -             return;
> > +             return irq_status;
> >
> > -     if (regmap_read(adv7511->regmap_cec,
> > -                     ADV7511_REG_CEC_RX_STATUS + offset, &rx_status))
> > -             return;
> > +     ret =3D regmap_read(adv7511->regmap_cec,
> > +                     ADV7511_REG_CEC_RX_STATUS + offset, &rx_status);
> > +     if (ret < 0)
> > +             return irq_status;
> >
> >       /*
> >        * ADV7511_REG_CEC_RX_STATUS[5:0] contains the reception order of=
 RX
> > @@ -172,6 +176,8 @@ void adv7511_cec_irq_process(struct adv7511 *adv751=
1, unsigned int irq1)
> >
> >               adv7511_cec_rx(adv7511, rx_buf);
> >       }
> > +
> > +     return IRQ_HANDLED;
> >  }
> >
> >  static int adv7511_cec_adap_enable(struct cec_adapter *adap, bool enab=
le)
> > diff --git a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c b/drivers/gpu=
/drm/bridge/adv7511/adv7511_drv.c
> > index 66ccb61e2a66..c8d2c4a157b2 100644
> > --- a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
> > +++ b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
> > @@ -469,6 +469,8 @@ static int adv7511_irq_process(struct adv7511 *adv7=
511, bool process_hpd)
> >  {
> >       unsigned int irq0, irq1;
> >       int ret;
> > +     int cec_status =3D IRQ_NONE;
> > +     int irq_status =3D IRQ_NONE;
> >
> >       ret =3D regmap_read(adv7511->regmap, ADV7511_REG_INT(0), &irq0);
> >       if (ret < 0)
> > @@ -478,29 +480,31 @@ static int adv7511_irq_process(struct adv7511 *ad=
v7511, bool process_hpd)
> >       if (ret < 0)
> >               return ret;
> >
> > -     /* If there is no IRQ to handle, exit indicating no IRQ data */
> > -     if (!(irq0 & (ADV7511_INT0_HPD | ADV7511_INT0_EDID_READY)) &&
> > -         !(irq1 & ADV7511_INT1_DDC_ERROR))
> > -             return -ENODATA;
> > -
> >       regmap_write(adv7511->regmap, ADV7511_REG_INT(0), irq0);
> >       regmap_write(adv7511->regmap, ADV7511_REG_INT(1), irq1);
> >
> > -     if (process_hpd && irq0 & ADV7511_INT0_HPD && adv7511->bridge.enc=
oder)
> > +     if (process_hpd && irq0 & ADV7511_INT0_HPD && adv7511->bridge.enc=
oder) {
> >               schedule_work(&adv7511->hpd_work);
> > +             irq_status =3D IRQ_HANDLED;
> > +     }
> >
> >       if (irq0 & ADV7511_INT0_EDID_READY || irq1 & ADV7511_INT1_DDC_ERR=
OR) {
> >               adv7511->edid_read =3D true;
> >
> >               if (adv7511->i2c_main->irq)
> >                       wake_up_all(&adv7511->wq);
> > +             irq_status =3D IRQ_HANDLED;
> >       }
> >
> >  #ifdef CONFIG_DRM_I2C_ADV7511_CEC
> > -     adv7511_cec_irq_process(adv7511, irq1);
> > +     cec_status =3D adv7511_cec_irq_process(adv7511, irq1);
> >  #endif
> >
> > -     return 0;
> > +     /* If there is no IRQ to handle, exit indicating no IRQ data */
> > +     if (irq_status =3D=3D IRQ_HANDLED || cec_status =3D=3D IRQ_HANDLE=
D)
> > +             return IRQ_HANDLED;
> > +
> > +     return IRQ_NONE;
> >  }
> >
> >  static irqreturn_t adv7511_irq_handler(int irq, void *devid)
> > @@ -509,7 +513,7 @@ static irqreturn_t adv7511_irq_handler(int irq, voi=
d *devid)
> >       int ret;
> >
> >       ret =3D adv7511_irq_process(adv7511, true);
> > -     return ret < 0 ? IRQ_NONE : IRQ_HANDLED;
> > +     return ret < 0 ? IRQ_NONE : ret;
> >  }
> >
> >  /* -------------------------------------------------------------------=
----------

