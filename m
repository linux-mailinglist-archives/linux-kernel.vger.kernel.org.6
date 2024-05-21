Return-Path: <linux-kernel+bounces-185492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDDEC8CB581
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 23:49:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FA13282B35
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 21:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FE58149C46;
	Tue, 21 May 2024 21:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V/jFOLmo"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 717CF487B0
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 21:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716328167; cv=none; b=mtwV8UuUIz+jOMi0y1tpgy6ALJ0df6t3oUQB0ZkLubQmi69slU0YKsRh9zFAnMhHbKRKQ0vduZZECoffIkzxdzDmm1h7e7vLRWCIHSKFPhbBBxrY/SVxPF3Wp94YItTaQxgsgggxitSVUq9I9D+OdYGnx+DepyIpaKSLtD11pAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716328167; c=relaxed/simple;
	bh=QkS/qn8DxEq7/cSkd29Toj5P91ZjzFb7thiexZ+Q+Vk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LvPNUfSutJAZUSGo5qs7AflQCoeTmndlUNpxsD4vxzIVo0lG0798LSFRYEd3feLnY9GWjgtpY1jVHCqddow9v6nTyBezTIcrzjV91pbXvWZZYc0SGHSi+7GHI1bGroDhp/VfDREq4FJGKILprITY+qZ5I10p2frT22XSpiP86Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V/jFOLmo; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1ecd9a81966so2096235ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 14:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716328165; x=1716932965; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8GGCRq2Ndy1hxp/g1PB5jr/b9oZhFBCgGqizCUbAq1E=;
        b=V/jFOLmonieSUqVI/wvInnqEZnn/vGbWSKktw9sDjRrUI1VJMLNrNOXt3M84eXCEgu
         AS3CW55iz8bgmuq0qNyA56DOOhPtSsB4+9jRvKLRZMjdOt6maez3XmzMN/9aC5l8x0LI
         RIFlAGVzqLWon2UJHCc8pj+YUlCjMNla3647I2+52VMdFg5MPlPYxF6XkLTv+okN45VP
         6vvq4kwspSIcGkvuZtSI05iyHNVvUqq5vtBP7DmbFWo9mg760o5dil1bU2FLibzDlapB
         ojex9TuNSgE2jA+EpDbETR/fw7o0+lBGk2Yzd8xYhJ6UrIPN90JknVgsg+C0uYhrwtY/
         ClUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716328165; x=1716932965;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8GGCRq2Ndy1hxp/g1PB5jr/b9oZhFBCgGqizCUbAq1E=;
        b=GQ5NyzhviYMxy9/B9Q9sFw/oyXqIEiuV6b/pG2Jen9MHOD73z7oZRZaCqVnxyFYPbl
         aexQvqfT6KMsGSYBRwMkkpfdsUxH4vO2PSqTDtL8L05tt62l4mAz/6JQd2M5bh8N65AM
         E8YjSSZo8vnHfnEu9H1WMMyVpySJMIo1csqpsB9qCm/o23/WFMOLye86Hex3/dwROyfa
         YYx8NYubvrA8WkHgRzVv+POMbCL8pkugEOCHpECL2vBZcAmGs8yh3l5iwwCYTFUaXwfT
         v0b52HdOUKnRO6xKyg49bHWXPJM+xWCbfvCVehvyGMV0fNg3B5lpCw5o9W8uZXmiZTzb
         N0Kg==
X-Forwarded-Encrypted: i=1; AJvYcCWwfVjQjHPQhrGCOfMYDL23XNtdkaFv2lh4JSVW3bIkLykPa/mRWudPCSaatz6InDrIF6SqB9mtS5vSdssIbhLE3G8VWwJJ4cRv5wuQ
X-Gm-Message-State: AOJu0Yx6tLpst1rXg+qJ0XK8JTxCh/WKOw5Efc5c2tafLq/0C70u9Twh
	+medJ9OD4YW4fHo46t1qN8egTpINTTWDVbHiPqRwKQPmnbU2/VMX8I7vLDjNAn0VOzuV+7bmrSL
	EH2EDnjSAgeewxP9CqTXa+Vg5RHU=
X-Google-Smtp-Source: AGHT+IHk/Bh8czYalA/qer60Z/oouST3IPJB3/UsdD32RIJw9mWN4Evo2jZ3J4LCsyDWQo52hJgmYhGRYo9YtVObCwY=
X-Received: by 2002:a17:903:41c7:b0:1f3:3b0:61a7 with SMTP id
 d9443c01a7336-1f303b06359mr84827515ad.12.1716328164614; Tue, 21 May 2024
 14:49:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240516101006.2388767-1-victor.liu@nxp.com> <evnxopqt5be56vxuxqdj4l3mcd5nrrvucio7jhwgg4emraai3t@gherubdynyip>
 <e2d4e8b4-bab4-448f-8b67-21f2902fdcd2@linux.dev> <CAA8EJppH1rYQ5pzkGP+V-=cOPBYMWm=ZK2Ei1ttjOiN6GRDP+w@mail.gmail.com>
 <acc508e2-b067-47ef-b3e2-fcac51403fe0@linux.dev> <CAA8EJpowLnrnV8ezXYj=oWBFFTa6LqkPFFHc9F49un6AYgZvzw@mail.gmail.com>
 <CAHCN7x+5L+fjkDgR_mJ2BQ1M52oBZyU0nUca1Uvhyh1pFSJChw@mail.gmail.com> <lpgtwv74vlazlzpurey3qdhs6qygauw2xr3g4gcfp6kvbio4zj@2puyycoaqqay>
In-Reply-To: <lpgtwv74vlazlzpurey3qdhs6qygauw2xr3g4gcfp6kvbio4zj@2puyycoaqqay>
From: Adam Ford <aford173@gmail.com>
Date: Tue, 21 May 2024 16:49:12 -0500
Message-ID: <CAHCN7xKAByP3CHM-VGopS1e5mO9N6yv54GkigyXHb3jmfy-jrg@mail.gmail.com>
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

On Mon, May 20, 2024 at 4:16=E2=80=AFPM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On Mon, May 20, 2024 at 07:46:05AM -0500, Adam Ford wrote:
> > On Mon, May 20, 2024 at 7:00=E2=80=AFAM Dmitry Baryshkov
> > <dmitry.baryshkov@linaro.org> wrote:
> > >
> > > On Mon, 20 May 2024 at 14:48, Sui Jingfeng <sui.jingfeng@linux.dev> w=
rote:
> > > >
> > > > Hi,
> > > >
> > > >
> > > > On 5/20/24 19:13, Dmitry Baryshkov wrote:
> > > > > On Mon, 20 May 2024 at 14:11, Sui Jingfeng <sui.jingfeng@linux.de=
v> wrote:
> > > > >>
> > > > >> Hi,
> > > > >>
> > > > >> On 5/20/24 06:11, Dmitry Baryshkov wrote:
> > > > >>> On Thu, May 16, 2024 at 06:10:06PM +0800, Liu Ying wrote:
> > > > >>>> Commit f3d9683346d6 ("drm/bridge: adv7511: Allow IRQ to share =
GPIO pins")
> > > > >>>> fails to consider the case where adv7511->i2c_main->irq is zer=
o, i.e.,
> > > > >>>> no interrupt requested at all.
> > > > >>>>
> > > > >>>> Without interrupt, adv7511_wait_for_edid() could return -EIO s=
ometimes,
> > > > >>>> because it polls adv7511->edid_read flag by calling adv7511_ir=
q_process()
> > > > >>>> a few times, but adv7511_irq_process() happens to refuse to ha=
ndle
> > > > >>>> interrupt by returning -ENODATA.  Hence, EDID retrieval fails =
randomly.
> >
> > Sorry about that.  I did some testing and didn't see any regressions,
> > but if it was random, it's likely I just was lucky to not see it.
> >
> > > > >>>>
> > > > >>>> Fix the issue by checking adv7511->i2c_main->irq before exitin=
g interrupt
> > > > >>>> handling from adv7511_irq_process().
> > > > >>>>
> > > > >>>> Fixes: f3d9683346d6 ("drm/bridge: adv7511: Allow IRQ to share =
GPIO pins")
> > > > >>>> Signed-off-by: Liu Ying <victor.liu@nxp.com>
> > > > >>>> ---
> > > > >>>>    drivers/gpu/drm/bridge/adv7511/adv7511_drv.c | 3 ++-
> > > > >>>>    1 file changed, 2 insertions(+), 1 deletion(-)
> > > > >>>>
> > > > >>>> diff --git a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c b/dr=
ivers/gpu/drm/bridge/adv7511/adv7511_drv.c
> > > > >>>> index 6089b0bb9321..2074fa3c1b7b 100644
> > > > >>>> --- a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
> > > > >>>> +++ b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
> > > > >>>> @@ -479,7 +479,8 @@ static int adv7511_irq_process(struct adv7=
511 *adv7511, bool process_hpd)
> > > > >>>>               return ret;
> > > > >>>>
> > > > >>>>       /* If there is no IRQ to handle, exit indicating no IRQ =
data */
> > > > >>>> -    if (!(irq0 & (ADV7511_INT0_HPD | ADV7511_INT0_EDID_READY)=
) &&
> > > > >>>> +    if (adv7511->i2c_main->irq &&
> > > > >>>> +        !(irq0 & (ADV7511_INT0_HPD | ADV7511_INT0_EDID_READY)=
) &&
> > > > >>>>           !(irq1 & ADV7511_INT1_DDC_ERROR))
> > > > >>>>               return -ENODATA;
> > > > >>>
> > > > >>> I think it might be better to handle -ENODATA in adv7511_wait_f=
or_edid()
> > > > >>> instead. WDYT?
> > > > >>>
> > > > >>
> > > > >> I think this is may deserve another patch.
> > > > >
> > > > > My point is that the IRQ handler is fine to remove -ENODATA here,
> > > >
> > > > [...]
> > > >
> > > > > there is no pending IRQ that can be handled.
> > > >
> > > > But there may has other things need to do in the adv7511_irq_proces=
s()
> > > > function.
> > >
> > > But the function returns anyway. So, we know that the condition is br=
oken.
> >
> > When I originally submitted the patch, I only added the shared IRQ
> > flag without any IRQ condition checks, IRQ because I didn't want to
> > break anything. The feedback I got was to check to see if the IRQ was
> > intended by the device.  My focus was the adv7511_drv.c file because
> > that appears to be what the registered IRQ hander was, but after
> > looking through adv7511_cec, I see that adv7511_cec_irq_process checks
> > adv_cec_tx_raw_status and returns if there is nothing to do.
> >
> > Would it make sense to move the if statement  did the following things:
> >
> > -  Make adv7511_cec_irq_process return an int and modify it to return
> > 0 in normal operation or return -ENODATA where there is nothing to do.
> > It already has the checks in place to determine if there is work to
> > do, so the impact here should be minimal.
> >
> > - Move the check I added on whether or not there is an interrupt  to
> > the very end of adv7511_irq_process just before the return 0.
> >
> > - Instead of blindly returning 0, modify the if statement to read the
> > state of the return code of adv7511_cec_irq_process and the IRQ flags
> > it already checks.  If ADV7511_INT0_HPD, ADV7511_INT0_EDID_READY and
> > ADV7511_INT1_DDC_ERROR are all not true and adv7511_cec_irq_process
> > returned early, return ENODATA, but if any of the interrupts was
> > present and adv7511_cec_irq_process did work, it would return 0.
> >
> > I think that would cover the situation where adv7511_cec_irq_process
> > would get called, and also prevent a false return of the IRQ being
> > handled when this part didn't handle anything.
> >
> > It would look something like:
> >
> > cec_irq =3D adv7511_cec_irq_process(adv7511, irq1);
> >
> > /* If there is no IRQ to handle, exit indicating no IRQ data */)
> > if (!(irq0 & (ADV7511_INT0_HPD | ADV7511_INT0_EDID_READY)) &&
> >    !(irq1 & ADV7511_INT1_DDC_ERROR) &&
> >   cec_irq =3D=3D  -ENODATA)
> >         return -ENODATA;
> > else
> >         return 0
> >
> >
> > OR...
> >
> >
> > Another alternative to all this is to modify the check that I added to
> > verify all the following flags which are currently checked in
> > adv7511_cec_irq_process :
> >
> > ADV7511_INT1_CEC_TX_READY
> > ADV7511_INT1_CEC_TX_ARBIT_LOST
> > ADV7511_INT1_CEC_TX_RETRY_TIMEOUT
> > ADV7511_INT1_CEC_RX_READY1
> > ADV7511_INT1_CEC_RX_READY2
> > ADV7511_INT1_CEC_RX_READY3
> >
> > It would look something like:
> >
> > /* If there is no IRQ to handle, exit indicating no IRQ data */
> > if (!(irq0 & (ADV7511_INT0_HPD | ADV7511_INT0_EDID_READY)) &&
> >    !(irq1 & ADV7511_INT1_DDC_ERROR) &&
> >    !(irq1 & ADV7511_INT1_CEC_TX_READY) &&
> >   !(irq1 & ADV7511_INT1_CEC_TX_ARBIT_LOST) &&
> >   !(irq1 & ADV7511_INT1_CEC_TX_RETRY_TIMEOUT) &&
> >   !(irq1 & ADV7511_INT1_CEC_RX_READY1) &&
> >   !(irq1 & ADV7511_INT1_CEC_RX_READY2) &&
> >   !(irq1 & ADV7511_INT1_CEC_RX_READY3))
> > return -ENODATA;
>
> This definitely looks ugly. At least it should be a mask.
>
> I have a slightly different solution:
>
> Make adv7511_irq_process return <0 for error, IRQ_NONE or IRQ_HANDLED.
> This would also require tracking whether HPD, EDID or CEC processing
> actually took place (add temp var for the current 'handled' status, make
> adv7511_cec_irq_process() return IRQ_HANDLED too).

Dmitry,

I think I have addressed your concerns.  I got feedback from a build
bot with one warning, so I'll address that, but i wasn't sure if I
should wait for feedback from you.  I am traveling Friday-Tuesday, so
I was hoping to send a V2 on Thursday if there are no other concerns.


Liu,

I realized that I didn't properly copy-paste your e-mail address, so
you didn't get copied on the submission I just did.  I'll reply to the
thread where I posted a bug fix with your proper e-mail address.  If
you can try it to see if it addresses your issue, that would be really
helpful.

thanks,

adam

>
> >
> >
> > Please let me know what is preferred or if there is a third possible so=
lution.
> >
> > I can write up a patch with a fixes tag later today when I get back to
> > my build machine.
> >
> > adam
> > >
> > > >
> > > > > So instead of continuing
> > > > > the execution when we know that IRQ bits are not set,
> > > >
> > > > Even when IRQ bits are not set, it just means that there is no HPD
> > > > and no EDID ready-to-read signal. HDMI CEC interrupts still need
> > > > to process.
> > >
> > > Yes. Let's get the CEC fixed. Then maybe we won't need this commit at=
 all.
> > >
> > > >
> > > >
> > > > > it's better to
> > > > > ignore -ENODATA in the calling code and go on with msleep().
> > > > >
> > > >
> > > > So, It's confusing to ignore the -ENODATA here.
> > >
> > > [BTW: you had quotation levels wrong in two places, I've fixed them]
> > >
> > > --
> > > With best wishes
> > > Dmitry
>
> --
> With best wishes
> Dmitry

