Return-Path: <linux-kernel+bounces-217589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99AFE90B1D5
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 16:27:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C2841C22CD2
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 14:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B829119AD60;
	Mon, 17 Jun 2024 13:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B9w9EJl8"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E3F192B88
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 13:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718631676; cv=none; b=kEw31cQk+jnz3hLjPVn5bvLNRHR5QS25Uvnqi8HhBsIlSSUfC7Iq4PozrNmnJca5kVEnOBWn54cqJfKV7nvJPSn/rgEDevIeUS/wf89rdhSyA/0Rrwbbo4kfOC/nGqlacF8uzs0CJ6TySZXSUmCafqqBFs2+caVHsSKGYFEBChw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718631676; c=relaxed/simple;
	bh=ajRZ2EjcsauA7rjIlvZ2dPQTW7oo2QpMTQarfEMCOTg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gfz4gx2jeaqjM1f/OCLvS46MEIBMnRgQYS4PQFuMSjOXdChATRkndeXvYPChz8679jYHccoPV9r4YnZKegkKg1WzIfVEAe1d2fR+aH/mmV931qykhTu3734qByezQw/FFw6rqWY2kAbfDIoyXDaqG39pnFhlI0vefkiytpcPvmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B9w9EJl8; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7046e87e9afso3403923b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 06:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718631674; x=1719236474; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q0pp4nLuLDtvrTRt1gP/9BmZwggZYJPGQwgqI4bcf7s=;
        b=B9w9EJl8npuLmDW6a3oPDlAiqqbDG18p3NaY0ABqZ/X+LzUDP8H1edJxDyoFA03ufN
         nxg2OxTFRiKfYApyd/VVf0VfOGaKS+Q6juzIT4SlYxepv/3EMujJGedc4bDJW79oGZ+P
         QwFLlCtrjCmsGHIX0OAN54B26kOFFax2KDYpa3TES6e8UifPfEJTTAXhOdmkl4UtxdH2
         0PU0WKwb3GqxJBa/0uqTrpz+Wb7u/y6VnrMcBA+wF9ZFA9fzmSCqJGjEeEzSEXikoXQt
         fdqAaOhpoA5LIQRAIdLJ5iQnpWxGzV+84kYdRYBUV2upCYExB1pHqbPvSGcbEJwnUGtg
         FWWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718631674; x=1719236474;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q0pp4nLuLDtvrTRt1gP/9BmZwggZYJPGQwgqI4bcf7s=;
        b=OeLqYCYNQfeRV4AsgUPe0/1kLgm0xDoOy6vrtYgs8oGWPHEhz19Y1EelWXlzMMGmdT
         PBC6NBy3RUuCwKhkPDxU/7qWF9E40kcry60bpvBkJQNAMzaeTbktY5QrsOerrfFvVta6
         Z2lPoYglMdl5H9WxpDisjvyy6E8M5J/mwyiGET2gQ0T7o9dT2xaYLJiccoGdDq7mZEp1
         aOnTCR29GdbzlK5DlNBtcGJoW0LjevzM4E5T6X7AN3FHbdsWfaxC4WJGf5N5FEZWxMwZ
         LkNF0UUD4W2fFvq0hyDYjuTpMERFylktKqtI7uBT7rtkF5PtAucXxT5HjYdSS/46M6TQ
         RnPg==
X-Forwarded-Encrypted: i=1; AJvYcCXHX30HG84/3+h0Pz16dz++bugpioFJNQGflBbFbVcCS0H9mrfiXggH7vh7FbnBb8yFAdGD6aOWRBnpSEJXpem/5Axm0mKJ7pfZIa2T
X-Gm-Message-State: AOJu0Yxokh4e04f5rRBPaYmgPpO/oqF4q7FZSXCADQcDM93Y8bF9/GES
	PGkbNHxw2P6tcnA2NXZsIqzEnzO3e1bSZWZbC5z7hkTNWcLZH/e/DxtvlTgRIPStjw32/rXKsv3
	UwjyYLSygYYTok6kgF73yRWwjN4E=
X-Google-Smtp-Source: AGHT+IGL1B2BYMw+YBoulVZaQLRFpQouRVZZxGbMCWRau4ceu76A7i6GVVB7OO7b8w3Wvy9CS3LAD+elObIiA6nzxos=
X-Received: by 2002:a05:6a20:2448:b0:1b8:d79:55f3 with SMTP id
 adf61e73a8af0-1bae82a599bmr9569600637.54.1718631674103; Mon, 17 Jun 2024
 06:41:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240601132459.81123-1-aford173@gmail.com> <7015c544-14c3-40af-aa10-e3088eea5633@leemhuis.info>
 <CAHCN7xJfqcN=yqWAURuy-oF8EiwoB5i840Gct65xgqgxNSL_Ug@mail.gmail.com> <701edf2c-2c70-4031-9d6f-cd31cd082df7@leemhuis.info>
In-Reply-To: <701edf2c-2c70-4031-9d6f-cd31cd082df7@leemhuis.info>
From: Adam Ford <aford173@gmail.com>
Date: Mon, 17 Jun 2024 08:41:02 -0500
Message-ID: <CAHCN7x+LasjE8NgkKzXZbxUZXLnhJhnuzfXPgbBKgtWeD0rEXA@mail.gmail.com>
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

On Mon, Jun 17, 2024 at 8:29=E2=80=AFAM Linux regression tracking (Thorsten
Leemhuis) <regressions@leemhuis.info> wrote:
>
> On 17.06.24 15:14, Adam Ford wrote:
> > On Mon, Jun 17, 2024 at 8:00=E2=80=AFAM Linux regression tracking (Thor=
sten
> > Leemhuis) <regressions@leemhuis.info> wrote:
> >>
> >> [CCing the regression list, as it should be in the loop for regression=
s:
> >> https://docs.kernel.org/admin-guide/reporting-regressions.html]
> >>
> >> Hi! Top-posting for once, to make this easily accessible to everyone.
> >>
> >> Hmm, seem nobody took a look at below fix for a regression that seems =
to
> >> be caused by f3d9683346d6b1 ("drm/bridge: adv7511: Allow IRQ to share
> >> GPIO pins") [which went into v6.10-rc1].
> >>
> >> Adam and Dimitry, what are your stances on this patch from Adam? I'm
> >> asking, as you authored respectively committed the culprit?
> >
> > I learned of the regression from Liu Ying [...]
>
> Ohh, I'm very sorry, stupid me somehow missed that the Adam that was
> posting the fix was the same Adam that authored the culprit. :-( Seems I
> definitely need more coffee (or green tea in my case) or reduce the
> number or regressions on the stack. Please accept my apologies.
>
> Thx for the update anyway.

No problem.  Sent out a few e-mails and/or patches while tired and I
when I read them again when I was awake, I had to ask myself 'what
what was I thinking'

>
> > Dimitry had given me some suggestions, and from that,  I posted a V1.
> > Dmitry had some more followup suggestions [2] which resulted in the
> > V2.
> >> As far as I know, Liu was satisfied that this addressed the regression
> > he reported.
>
> So in that case the main question afaics is why this fix did not make
> any progress for more than two weeks now (at least afaics -- or did I
> miss something in that area, too?).

I have not seen anything either which is why I sent out the gentle
nudge last week.

adam
>
> Ciao, Thorsten
>
> >> On 01.06.24 15:24, Adam Ford wrote:
> >>> In the process of adding support for shared IRQ pins, a scenario
> >>> was accidentally created where adv7511_irq_process returned
> >>> prematurely causing the EDID to fail randomly.
> >>>
> >>> Since the interrupt handler is broken up into two main helper functio=
ns,
> >>> update both of them to treat the helper functions as IRQ handlers. Th=
ese
> >>> IRQ routines process their respective tasks as before, but if they
> >>> determine that actual work was done, mark the respective IRQ status
> >>> accordingly, and delay the check until everything has been processed.
> >>>
> >>> This should guarantee the helper functions don't return prematurely
> >>> while still returning proper values of either IRQ_HANDLED or IRQ_NONE=
.
> >>>
> >>> Reported-by: Liu Ying <victor.liu@nxp.com>
> >>> Fixes: f3d9683346d6 ("drm/bridge: adv7511: Allow IRQ to share GPIO pi=
ns")
> >>> Signed-off-by: Adam Ford <aford173@gmail.com>
> >>> Tested-by: Liu Ying <victor.liu@nxp.com> # i.MX8MP EVK ADV7535 EDID r=
etrieval w/o IRQ
> >>> ---
> >>> V2:  Fix uninitialized cec_status
> >>>      Cut back a little on error handling to return either IRQ_NONE or
> >>>      IRQ_HANDLED.
> >>>
> >>> diff --git a/drivers/gpu/drm/bridge/adv7511/adv7511.h b/drivers/gpu/d=
rm/bridge/adv7511/adv7511.h
> >>> index ea271f62b214..ec0b7f3d889c 100644
> >>> --- a/drivers/gpu/drm/bridge/adv7511/adv7511.h
> >>> +++ b/drivers/gpu/drm/bridge/adv7511/adv7511.h
> >>> @@ -401,7 +401,7 @@ struct adv7511 {
> >>>
> >>>  #ifdef CONFIG_DRM_I2C_ADV7511_CEC
> >>>  int adv7511_cec_init(struct device *dev, struct adv7511 *adv7511);
> >>> -void adv7511_cec_irq_process(struct adv7511 *adv7511, unsigned int i=
rq1);
> >>> +int adv7511_cec_irq_process(struct adv7511 *adv7511, unsigned int ir=
q1);
> >>>  #else
> >>>  static inline int adv7511_cec_init(struct device *dev, struct adv751=
1 *adv7511)
> >>>  {
> >>> diff --git a/drivers/gpu/drm/bridge/adv7511/adv7511_cec.c b/drivers/g=
pu/drm/bridge/adv7511/adv7511_cec.c
> >>> index 44451a9658a3..651fb1dde780 100644
> >>> --- a/drivers/gpu/drm/bridge/adv7511/adv7511_cec.c
> >>> +++ b/drivers/gpu/drm/bridge/adv7511/adv7511_cec.c
> >>> @@ -119,7 +119,7 @@ static void adv7511_cec_rx(struct adv7511 *adv751=
1, int rx_buf)
> >>>       cec_received_msg(adv7511->cec_adap, &msg);
> >>>  }
> >>>
> >>> -void adv7511_cec_irq_process(struct adv7511 *adv7511, unsigned int i=
rq1)
> >>> +int adv7511_cec_irq_process(struct adv7511 *adv7511, unsigned int ir=
q1)
> >>>  {
> >>>       unsigned int offset =3D adv7511->info->reg_cec_offset;
> >>>       const u32 irq_tx_mask =3D ADV7511_INT1_CEC_TX_READY |
> >>> @@ -130,17 +130,21 @@ void adv7511_cec_irq_process(struct adv7511 *ad=
v7511, unsigned int irq1)
> >>>                               ADV7511_INT1_CEC_RX_READY3;
> >>>       unsigned int rx_status;
> >>>       int rx_order[3] =3D { -1, -1, -1 };
> >>> -     int i;
> >>> +     int i, ret =3D 0;
> >>> +     int irq_status =3D IRQ_NONE;
> >>>
> >>> -     if (irq1 & irq_tx_mask)
> >>> +     if (irq1 & irq_tx_mask) {
> >>>               adv_cec_tx_raw_status(adv7511, irq1);
> >>> +             irq_status =3D IRQ_HANDLED;
> >>> +     }
> >>>
> >>>       if (!(irq1 & irq_rx_mask))
> >>> -             return;
> >>> +             return irq_status;
> >>>
> >>> -     if (regmap_read(adv7511->regmap_cec,
> >>> -                     ADV7511_REG_CEC_RX_STATUS + offset, &rx_status)=
)
> >>> -             return;
> >>> +     ret =3D regmap_read(adv7511->regmap_cec,
> >>> +                     ADV7511_REG_CEC_RX_STATUS + offset, &rx_status)=
;
> >>> +     if (ret < 0)
> >>> +             return irq_status;
> >>>
> >>>       /*
> >>>        * ADV7511_REG_CEC_RX_STATUS[5:0] contains the reception order =
of RX
> >>> @@ -172,6 +176,8 @@ void adv7511_cec_irq_process(struct adv7511 *adv7=
511, unsigned int irq1)
> >>>
> >>>               adv7511_cec_rx(adv7511, rx_buf);
> >>>       }
> >>> +
> >>> +     return IRQ_HANDLED;
> >>>  }
> >>>
> >>>  static int adv7511_cec_adap_enable(struct cec_adapter *adap, bool en=
able)
> >>> diff --git a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c b/drivers/g=
pu/drm/bridge/adv7511/adv7511_drv.c
> >>> index 66ccb61e2a66..c8d2c4a157b2 100644
> >>> --- a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
> >>> +++ b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
> >>> @@ -469,6 +469,8 @@ static int adv7511_irq_process(struct adv7511 *ad=
v7511, bool process_hpd)
> >>>  {
> >>>       unsigned int irq0, irq1;
> >>>       int ret;
> >>> +     int cec_status =3D IRQ_NONE;
> >>> +     int irq_status =3D IRQ_NONE;
> >>>
> >>>       ret =3D regmap_read(adv7511->regmap, ADV7511_REG_INT(0), &irq0)=
;
> >>>       if (ret < 0)
> >>> @@ -478,29 +480,31 @@ static int adv7511_irq_process(struct adv7511 *=
adv7511, bool process_hpd)
> >>>       if (ret < 0)
> >>>               return ret;
> >>>
> >>> -     /* If there is no IRQ to handle, exit indicating no IRQ data */
> >>> -     if (!(irq0 & (ADV7511_INT0_HPD | ADV7511_INT0_EDID_READY)) &&
> >>> -         !(irq1 & ADV7511_INT1_DDC_ERROR))
> >>> -             return -ENODATA;
> >>> -
> >>>       regmap_write(adv7511->regmap, ADV7511_REG_INT(0), irq0);
> >>>       regmap_write(adv7511->regmap, ADV7511_REG_INT(1), irq1);
> >>>
> >>> -     if (process_hpd && irq0 & ADV7511_INT0_HPD && adv7511->bridge.e=
ncoder)
> >>> +     if (process_hpd && irq0 & ADV7511_INT0_HPD && adv7511->bridge.e=
ncoder) {
> >>>               schedule_work(&adv7511->hpd_work);
> >>> +             irq_status =3D IRQ_HANDLED;
> >>> +     }
> >>>
> >>>       if (irq0 & ADV7511_INT0_EDID_READY || irq1 & ADV7511_INT1_DDC_E=
RROR) {
> >>>               adv7511->edid_read =3D true;
> >>>
> >>>               if (adv7511->i2c_main->irq)
> >>>                       wake_up_all(&adv7511->wq);
> >>> +             irq_status =3D IRQ_HANDLED;
> >>>       }
> >>>
> >>>  #ifdef CONFIG_DRM_I2C_ADV7511_CEC
> >>> -     adv7511_cec_irq_process(adv7511, irq1);
> >>> +     cec_status =3D adv7511_cec_irq_process(adv7511, irq1);
> >>>  #endif
> >>>
> >>> -     return 0;
> >>> +     /* If there is no IRQ to handle, exit indicating no IRQ data */
> >>> +     if (irq_status =3D=3D IRQ_HANDLED || cec_status =3D=3D IRQ_HAND=
LED)
> >>> +             return IRQ_HANDLED;
> >>> +
> >>> +     return IRQ_NONE;
> >>>  }
> >>>
> >>>  static irqreturn_t adv7511_irq_handler(int irq, void *devid)
> >>> @@ -509,7 +513,7 @@ static irqreturn_t adv7511_irq_handler(int irq, v=
oid *devid)
> >>>       int ret;
> >>>
> >>>       ret =3D adv7511_irq_process(adv7511, true);
> >>> -     return ret < 0 ? IRQ_NONE : IRQ_HANDLED;
> >>> +     return ret < 0 ? IRQ_NONE : ret;
> >>>  }
> >>>
> >>>  /* -----------------------------------------------------------------=
------------
> >
> >

