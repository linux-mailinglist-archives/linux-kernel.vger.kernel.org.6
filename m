Return-Path: <linux-kernel+bounces-244339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF01392A2E4
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 14:37:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95C9F284674
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 12:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 424837E0F1;
	Mon,  8 Jul 2024 12:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CovDcesS"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB347404B
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 12:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720442216; cv=none; b=XZ692wl6fD6rYFQhdWxG4Qra36piEMujXQj+1kgWErLowKGt7zbSn8kxIW9eGWcFmAettuFt6bATVvGRDwvtgt9WM6AhluUBCiVubKcTkRqFsdFXoT6clLyWBGNoiUzkYDYcQda50lYNgBGQQFM1EwvKs845coLATgCtxZL65VE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720442216; c=relaxed/simple;
	bh=VEzmrbhsif6JgITHRFFe75NLNgDIMRuAgvsX2FzcpFU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W+ORCbWzS4mJiHHw/7QfqUZ7Uny5JPljZaDRnxsVENeBQnPlrxJPJxbnh27P7wEC+ZPz2wcYfV29ypxeUKfEuoPZ8TNDoXHeju8qZAD0tCCSc2CBJ3fGffT73E2VF7mmgBMgpD+OXHJ9nvDJsqSX+wWATBum1HWHg+lTNRoFigg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CovDcesS; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-70af0684c2bso2299577b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2024 05:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720442214; x=1721047014; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yXn9040q77oGlxBnBYUKFbDXyOPG8b0Isv78rveFo2M=;
        b=CovDcesS0uAOVMqLRz8UPEUj5NQB9UqAsHrD43OLvAXc4VRcfFvSQd07vsC5hdiQFV
         fp8tkZSECMjqCt2m1Qhb5bX415cRa24MJYLrda3gSbBhHMLyhFyDl7AQLbg//6bO4Vik
         Yf4apXkoVSvagxOhy1vXvK+v9lCSG3tS64HWQ3I/VFyaRIA+mqDaIqpggOWCWMGzAHKI
         fQXmy4yKCyrD0QFRFjZrrUYi3h/N37Hg3EomESkIFL9QFsV7jXqtLNZRlSEW+QQljufg
         87UlcPDML3bp+bY8Y74PKEzehDqn7ndIwHwCvaXjo0fJ8Cco61TJuwCh0s3dCvtmvfWP
         He5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720442214; x=1721047014;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yXn9040q77oGlxBnBYUKFbDXyOPG8b0Isv78rveFo2M=;
        b=rWWG0Sgi0iuRKDmc9fRPIimfI4Nt0I75Vr8dIZZRrf0BxXZFDcLv1JVbmBKqKzDku1
         dakRKG8RUItAIvUbybV+HpLugs5x9CQ/6PIgZNXNvzOx8ooxtcpDhuUQT2tjtaJJhckp
         rWUWa6MVPu0k+NbSPsruJbiy9mjUs5WVYWKIlSl5jqM07wviEbP3J0I+Qppy15niNdz7
         OBN3zGZgZOmyaLBl+1GvzaW1uqBIy+bJaHCLJXsO3tyc/CUpnGTnqNYMpQwB/yLmQ23W
         NNNvy1Oja1FJZ2CvYWJWMx1qsQKr2arFmiyOfY3aa3OVvA0dQcXnsM9oFukyYlu0suBo
         Z4ww==
X-Forwarded-Encrypted: i=1; AJvYcCXUE41VeMG41oTFibb5K9twQF5kypCafwvslnjHFJ1x5R7Zt97aV/cVum3DQ8MkFP2Nm2oi3uD5ILHOQgn9Bdk9hhJr2d3iKALL0EgI
X-Gm-Message-State: AOJu0YzM8Ht7lzm9vKvOcRFK/918zG6IKP91r8OD3bRBBxiov2pkFQ6v
	bePxDFR4Avz3V5qTwyZ0q0VcTWoebXY0pYsnykkfUk/8Nn4piaszQaBGwsyyXpH/AsJINkdgpqg
	KMZbww0vb1OMukRHfatPZ5l1ldFU=
X-Google-Smtp-Source: AGHT+IGDyypax6tFZ+0anhgmRjNpIBTLAzdwlweVYSSS9ZlMea4/i8gmb8U7aD4CSE+xGJaBxWDhp4YVGLzu89vRlPk=
X-Received: by 2002:a05:6a00:1891:b0:70b:1450:1d05 with SMTP id
 d2e1a72fcca58-70b14501ee1mr5909528b3a.20.1720442213791; Mon, 08 Jul 2024
 05:36:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240630221931.1650565-1-aford173@gmail.com>
In-Reply-To: <20240630221931.1650565-1-aford173@gmail.com>
From: Adam Ford <aford173@gmail.com>
Date: Mon, 8 Jul 2024 07:36:41 -0500
Message-ID: <CAHCN7xKE34WBgUjOaHQg4Z_+0LwYHoHy5jgFtdr-754CnW6qqA@mail.gmail.com>
Subject: Re: [PATCH V3] drm/bridge: adv7511: Fix Intermittent EDID failures
To: dri-devel@lists.freedesktop.org
Cc: aford@beaconembedded.com, Liu Ying <victor.liu@nxp.com>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 30, 2024 at 5:19=E2=80=AFPM Adam Ford <aford173@gmail.com> wrot=
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
> Reported-by: Liu Ying <victor.liu@nxp.com>
> Fixes: f3d9683346d6 ("drm/bridge: adv7511: Allow IRQ to share GPIO pins")
> Signed-off-by: Adam Ford <aford173@gmail.com>
> Tested-by: Liu Ying <victor.liu@nxp.com> # i.MX8MP EVK ADV7535 EDID retri=
eval w/o IRQ
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Gentle nudge on this.  I was hoping it could be merged in the 6.10
window since it fixes a known regression, but  I know it's summer in
the northern hemisphere, and everyone is busy.

adam
> ---
> V3:  Remove unnecessary declaration of ret by evaluating the return
>      code of regmap_read directly.
>
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
> index 44451a9658a3..2e9c88a2b5ed 100644
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
> @@ -131,16 +131,19 @@ void adv7511_cec_irq_process(struct adv7511 *adv751=
1, unsigned int irq1)
>         unsigned int rx_status;
>         int rx_order[3] =3D { -1, -1, -1 };
>         int i;
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
>         if (regmap_read(adv7511->regmap_cec,
>                         ADV7511_REG_CEC_RX_STATUS + offset, &rx_status))
> -               return;
> +               return irq_status;
>
>         /*
>          * ADV7511_REG_CEC_RX_STATUS[5:0] contains the reception order of=
 RX
> @@ -172,6 +175,8 @@ void adv7511_cec_irq_process(struct adv7511 *adv7511,=
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

