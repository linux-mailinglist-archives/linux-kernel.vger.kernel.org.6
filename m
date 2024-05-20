Return-Path: <linux-kernel+bounces-183763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43D828C9DA7
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 14:46:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED80D283EBC
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 12:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ABAB12E1F0;
	Mon, 20 May 2024 12:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JQHJXqTq"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D519812CD84
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 12:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716209180; cv=none; b=At+ytSUQuaTqBnTlXOSf+wCOOXpwd0NBLZQ+jQytWfPp1Vn/rldb/eMoqXdwuBvFrcGR/ri+pXGTiYB005bBo82almCrylfKpjjQQ8H7toR2rnY1mzYkhoWZeyVjnB+cczI5XsjzCgCrDn8zfzZSOppIY5+d5ajpOy/2RBoRISQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716209180; c=relaxed/simple;
	bh=IwRc/jNHtdr7Yb1rF350pde5SvdWBSKBoJw/Rt6ZUnY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q08b2N9dgFsrwzd6mCl6z63jYtHn3Ws62C1+x4pwQm/ScUNUczC8ZAUGPzsSYpibSHhsKGOyuKv9GiooGJmcc1eqwlAj5aAW8GPgXDpKDzBVfA8RMs/9pljKNwLdCaWalMOwialDkzP/T2KqJBb/Sc3WaPSzeR9XM17/z2uNE5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JQHJXqTq; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1e651a9f3ffso69122285ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 05:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716209178; x=1716813978; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BwMxQZoH/pdYWGNQ/YeZLuMCW+PYBbYOJhWPSoR82r8=;
        b=JQHJXqTqBMt8U1Tk8Dd4BMSB+KzHA1Jar0KRg2OhCkasy7vpAiAxE7fX7yEk9Fjqx+
         PiAf724sdJ1wisf/YWHsWTYQ/1tE8UuPo14N9dEyTSAAjqh8KxFrk5TZT7mD3aG6W88U
         aveNnE+fiilIClP0OftymvrK4DKP2Go/JevKXi9a2pCeKowA+kNfYt2q8GklbkONnroj
         YmNiwtRrVTwoI5FgvK34IQQ5JEnx/X9MXcuCly9azhNWNth/aOe3bn4FGlQc9KUmcvSW
         pxezHDb5pqASg7IocL5HfcrJrBGZ0YPSLUwja6udhFSFGYnoqVTUHiRk8IpnBiPgEQE3
         nMGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716209178; x=1716813978;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BwMxQZoH/pdYWGNQ/YeZLuMCW+PYBbYOJhWPSoR82r8=;
        b=odHLMGSr8WxASPRT7w9kGfYmpUw3cNGBO2A2ZTGDKXoImRbJzeU8fnLKxuKQye9l11
         CmPf0fTGUpy3P6ic8LRRoWUWiJlBWXQQRP61XDyhqTh7BhNYZxxZGf99oUu5BgNrraE3
         a7Iy8ehzxWb2YLL8jiUBTWeMb4+smUYMjHMW7yTCoUCCBPjVx+zH8RHdBfwwMSBMRjeh
         g3Vz5ScnveU8WioAyGGv4kPgKsf4rVUHc1kw4Ys3VqL1C5c8NMSZYg8nzNt/3gI5oPGb
         aniJ1UfeCot1G19il5+hruccbuduInqngukrut7of9Zr04jtONw+0egqEVRT+k96yQXK
         pSig==
X-Forwarded-Encrypted: i=1; AJvYcCU8IWiax6YRjPl4bXYynwPRZ8fJDOxQmD5uuh0q4aMqfJo2ZJbnI6ivY9YQnxVlBtpTewD9ypHcErm816lYI27UPrXrAyDNtWYmHEHH
X-Gm-Message-State: AOJu0Yw3+kNOBnv4LxQuGrQcssAHvWtxpexQmNGtSe5Jk0t9mLvHhYgk
	QBBUCnYNOPR62bT6oU2RljwFKe1kjzo1f1+X4anObbhG251DjvRjMEPtxtDGKBNGI/qFQlkI//x
	e5iHk6TBdyaURru9Wkh4MrNLLmPJIOgEa
X-Google-Smtp-Source: AGHT+IFUnnZlAeieYu0zFoMsxuuu/4UuL7b2X7zXorwXsTylOgzNhcytGNxmAggfeSnd7meG6r8sXMoCV6AF4xcfMoE=
X-Received: by 2002:a05:6a20:d70b:b0:1af:d6dc:86b9 with SMTP id
 adf61e73a8af0-1afde1faeb8mr29071654637.53.1716209177746; Mon, 20 May 2024
 05:46:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240516101006.2388767-1-victor.liu@nxp.com> <evnxopqt5be56vxuxqdj4l3mcd5nrrvucio7jhwgg4emraai3t@gherubdynyip>
 <e2d4e8b4-bab4-448f-8b67-21f2902fdcd2@linux.dev> <CAA8EJppH1rYQ5pzkGP+V-=cOPBYMWm=ZK2Ei1ttjOiN6GRDP+w@mail.gmail.com>
 <acc508e2-b067-47ef-b3e2-fcac51403fe0@linux.dev> <CAA8EJpowLnrnV8ezXYj=oWBFFTa6LqkPFFHc9F49un6AYgZvzw@mail.gmail.com>
In-Reply-To: <CAA8EJpowLnrnV8ezXYj=oWBFFTa6LqkPFFHc9F49un6AYgZvzw@mail.gmail.com>
From: Adam Ford <aford173@gmail.com>
Date: Mon, 20 May 2024 07:46:05 -0500
Message-ID: <CAHCN7x+5L+fjkDgR_mJ2BQ1M52oBZyU0nUca1Uvhyh1pFSJChw@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge: adv7511: Exit interrupt handling when necessary
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Sui Jingfeng <sui.jingfeng@linux.dev>, Liu Ying <victor.liu@nxp.com>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org, 
	Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se, jernej.skrabec@gmail.com, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
	airlied@gmail.com, daniel@ffwll.ch, biju.das.jz@bp.renesas.com, 
	u.kleine-koenig@pengutronix.de, jani.nikula@intel.com, bli@bang-olufsen.dk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 20, 2024 at 7:00=E2=80=AFAM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On Mon, 20 May 2024 at 14:48, Sui Jingfeng <sui.jingfeng@linux.dev> wrote=
:
> >
> > Hi,
> >
> >
> > On 5/20/24 19:13, Dmitry Baryshkov wrote:
> > > On Mon, 20 May 2024 at 14:11, Sui Jingfeng <sui.jingfeng@linux.dev> w=
rote:
> > >>
> > >> Hi,
> > >>
> > >> On 5/20/24 06:11, Dmitry Baryshkov wrote:
> > >>> On Thu, May 16, 2024 at 06:10:06PM +0800, Liu Ying wrote:
> > >>>> Commit f3d9683346d6 ("drm/bridge: adv7511: Allow IRQ to share GPIO=
 pins")
> > >>>> fails to consider the case where adv7511->i2c_main->irq is zero, i=
e.,
> > >>>> no interrupt requested at all.
> > >>>>
> > >>>> Without interrupt, adv7511_wait_for_edid() could return -EIO somet=
imes,
> > >>>> because it polls adv7511->edid_read flag by calling adv7511_irq_pr=
ocess()
> > >>>> a few times, but adv7511_irq_process() happens to refuse to handle
> > >>>> interrupt by returning -ENODATA.  Hence, EDID retrieval fails rand=
omly.

Sorry about that.  I did some testing and didn't see any regressions,
but if it was random, it's likely I just was lucky to not see it.

> > >>>>
> > >>>> Fix the issue by checking adv7511->i2c_main->irq before exiting in=
terrupt
> > >>>> handling from adv7511_irq_process().
> > >>>>
> > >>>> Fixes: f3d9683346d6 ("drm/bridge: adv7511: Allow IRQ to share GPIO=
 pins")
> > >>>> Signed-off-by: Liu Ying <victor.liu@nxp.com>
> > >>>> ---
> > >>>>    drivers/gpu/drm/bridge/adv7511/adv7511_drv.c | 3 ++-
> > >>>>    1 file changed, 2 insertions(+), 1 deletion(-)
> > >>>>
> > >>>> diff --git a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c b/driver=
s/gpu/drm/bridge/adv7511/adv7511_drv.c
> > >>>> index 6089b0bb9321..2074fa3c1b7b 100644
> > >>>> --- a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
> > >>>> +++ b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
> > >>>> @@ -479,7 +479,8 @@ static int adv7511_irq_process(struct adv7511 =
*adv7511, bool process_hpd)
> > >>>>               return ret;
> > >>>>
> > >>>>       /* If there is no IRQ to handle, exit indicating no IRQ data=
 */
> > >>>> -    if (!(irq0 & (ADV7511_INT0_HPD | ADV7511_INT0_EDID_READY)) &&
> > >>>> +    if (adv7511->i2c_main->irq &&
> > >>>> +        !(irq0 & (ADV7511_INT0_HPD | ADV7511_INT0_EDID_READY)) &&
> > >>>>           !(irq1 & ADV7511_INT1_DDC_ERROR))
> > >>>>               return -ENODATA;
> > >>>
> > >>> I think it might be better to handle -ENODATA in adv7511_wait_for_e=
did()
> > >>> instead. WDYT?
> > >>>
> > >>
> > >> I think this is may deserve another patch.
> > >
> > > My point is that the IRQ handler is fine to remove -ENODATA here,
> >
> > [...]
> >
> > > there is no pending IRQ that can be handled.
> >
> > But there may has other things need to do in the adv7511_irq_process()
> > function.
>
> But the function returns anyway. So, we know that the condition is broken=
.

When I originally submitted the patch, I only added the shared IRQ
flag without any IRQ condition checks, IRQ because I didn't want to
break anything. The feedback I got was to check to see if the IRQ was
intended by the device.  My focus was the adv7511_drv.c file because
that appears to be what the registered IRQ hander was, but after
looking through adv7511_cec, I see that adv7511_cec_irq_process checks
adv_cec_tx_raw_status and returns if there is nothing to do.

Would it make sense to move the if statement  did the following things:

-  Make adv7511_cec_irq_process return an int and modify it to return
0 in normal operation or return -ENODATA where there is nothing to do.
It already has the checks in place to determine if there is work to
do, so the impact here should be minimal.

- Move the check I added on whether or not there is an interrupt  to
the very end of adv7511_irq_process just before the return 0.

- Instead of blindly returning 0, modify the if statement to read the
state of the return code of adv7511_cec_irq_process and the IRQ flags
it already checks.  If ADV7511_INT0_HPD, ADV7511_INT0_EDID_READY and
ADV7511_INT1_DDC_ERROR are all not true and adv7511_cec_irq_process
returned early, return ENODATA, but if any of the interrupts was
present and adv7511_cec_irq_process did work, it would return 0.

I think that would cover the situation where adv7511_cec_irq_process
would get called, and also prevent a false return of the IRQ being
handled when this part didn't handle anything.

It would look something like:

cec_irq =3D adv7511_cec_irq_process(adv7511, irq1);

/* If there is no IRQ to handle, exit indicating no IRQ data */)
if (!(irq0 & (ADV7511_INT0_HPD | ADV7511_INT0_EDID_READY)) &&
   !(irq1 & ADV7511_INT1_DDC_ERROR) &&
  cec_irq =3D=3D  -ENODATA)
        return -ENODATA;
else
        return 0


OR...


Another alternative to all this is to modify the check that I added to
verify all the following flags which are currently checked in
adv7511_cec_irq_process :

ADV7511_INT1_CEC_TX_READY
ADV7511_INT1_CEC_TX_ARBIT_LOST
ADV7511_INT1_CEC_TX_RETRY_TIMEOUT
ADV7511_INT1_CEC_RX_READY1
ADV7511_INT1_CEC_RX_READY2
ADV7511_INT1_CEC_RX_READY3

It would look something like:

/* If there is no IRQ to handle, exit indicating no IRQ data */
if (!(irq0 & (ADV7511_INT0_HPD | ADV7511_INT0_EDID_READY)) &&
   !(irq1 & ADV7511_INT1_DDC_ERROR) &&
   !(irq1 & ADV7511_INT1_CEC_TX_READY) &&
  !(irq1 & ADV7511_INT1_CEC_TX_ARBIT_LOST) &&
  !(irq1 & ADV7511_INT1_CEC_TX_RETRY_TIMEOUT) &&
  !(irq1 & ADV7511_INT1_CEC_RX_READY1) &&
  !(irq1 & ADV7511_INT1_CEC_RX_READY2) &&
  !(irq1 & ADV7511_INT1_CEC_RX_READY3))
return -ENODATA;


Please let me know what is preferred or if there is a third possible soluti=
on.

I can write up a patch with a fixes tag later today when I get back to
my build machine.

adam
>
> >
> > > So instead of continuing
> > > the execution when we know that IRQ bits are not set,
> >
> > Even when IRQ bits are not set, it just means that there is no HPD
> > and no EDID ready-to-read signal. HDMI CEC interrupts still need
> > to process.
>
> Yes. Let's get the CEC fixed. Then maybe we won't need this commit at all=
.
>
> >
> >
> > > it's better to
> > > ignore -ENODATA in the calling code and go on with msleep().
> > >
> >
> > So, It's confusing to ignore the -ENODATA here.
>
> [BTW: you had quotation levels wrong in two places, I've fixed them]
>
> --
> With best wishes
> Dmitry

