Return-Path: <linux-kernel+bounces-183518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B79CE8C9A1D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 11:08:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71468281CFA
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 09:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55B211C6A3;
	Mon, 20 May 2024 09:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YGzLuJOW"
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E022117582
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 09:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716196128; cv=none; b=VUdgI0e6HtL2sn0Gz0blBFTfXpb2Ivg5+RTMqeuWDDaK40ediozZrN5cJHgM9BrGyqdi2NUxhfJOh58HImyEgStnsPX84BN60a+tZIwYz6dut/TLtUPpw7oHGQ35AoUiZdmPcFLW3VAO56e2nZPpaTPdHC3HwXr4EOyYMCQjN0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716196128; c=relaxed/simple;
	bh=rCsD98lOj+gPz0pt3osk3WseVqXh3KbKOiVTjSqIW2w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J2gtTeqSytTSQfs4H1kAp+37qQbi8nv4VLeDw0xVZOG9C8wVwOi/tp7Lpj3FDe8xTCfTYlIeQdSGpB92ijl0AyqKxI8vSPDM7N2rHIxrrN8qZFCvBOZsTgSqOkDHEjmm290DqTx3H8O/fNGMWoXX+hYEyCAf9/4HGP/Ct6DNBSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YGzLuJOW; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-deb654482bcso2282242276.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 02:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716196126; x=1716800926; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rsXIdnEGMK6jEQXuJEcWV+3QDrgp423KVVA+wYoTsTk=;
        b=YGzLuJOW+arCWwh9PXPKY6tFpZ/4uwrSVkkJxR8p2GCyqteSXbOfWKSpHYV9SQJ7vs
         UgcDK6CHc47xAT/w3XacbTzsxDNaPKWuzU9pHadF+99u1PQbdQxDeeVN/riXVnV/ptXd
         B/QPquY63wq/3Pf5booKUR+op3uMR21cxmQBFNKvqHaWCK1FV/MsAPN9q5asAqgOfB47
         I+Ji+MLuz2AMPEwot0oieHI5I6+Lveumn9SbndOTr3VSwYUuZZXgxgBA5zyH6aTk/LA1
         933uLCj2z5JndY7C2zJ/Q+hi9HZUR8lsWGJjYC/5VXwp3mtnxTGg4bnNbiEcFlDksg5g
         ydhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716196126; x=1716800926;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rsXIdnEGMK6jEQXuJEcWV+3QDrgp423KVVA+wYoTsTk=;
        b=RoQAy3DJRj2a3S+mfnpTjMM0JMhQOoFPoGfDp2t56sjevYtZiTaSZiv+6hdbxKdEWx
         tcLLKoM6aA8G2OXfhSKQX5G6CXby3pov2fju8VuhYKpmuhXw6Vacd6u3mLPZdW5ktRjw
         ROjuzxL0SM4JQROUQKz39VsPqPq4Ln292itBwQpf7Utb7+yaFViyoFr/s8RLDhArEDLE
         y5IEiyf6qzq8x0aVotXbRtcVkYfOgYa/TmtfkWN6eayYYW9LhfH2pKpf03IhSKrQINWq
         AUU+vVrBvkBGJ9rpR827jlx6KNG6guhWoRnZvsLLneM2lYssoK0mVnymid3qm6uggAQi
         RKbg==
X-Forwarded-Encrypted: i=1; AJvYcCUSUuvOoEdFPMXJmBrZfLJt/HCpyj7bsby1ifbqfolkMo6rYHYFFFh6wUZQbRKmlfN1v3iHfS0dduuIYHDwRVFh86hb1wHEPR0w/KNE
X-Gm-Message-State: AOJu0Yz6qpKt483gX1ju+KXszM8K/YA/DwPzc0SCEBstkCbMJH4ibc21
	DzpoXN+MCA6nEaHC6WR8M8r2bvG5Lz80jypwg+jPCfFPHXuf/Or+nstoh+r4hHHFyxGmOQ5QBeO
	ZZh74plrPo3y2LoFMU1kjGlF0k0kWWl8y4f/mJQ==
X-Google-Smtp-Source: AGHT+IHNVEhnihEzvQfFRep3JcNSMShmxc2WAoOrCzTZfseWMCDTcy0PJ24ZzIcLimohwaU6t1G4RC2Jwd5WaS/Am1A=
X-Received: by 2002:a25:f403:0:b0:de5:4b1f:7e00 with SMTP id
 3f1490d57ef6-dee4f2ce7bcmr24641867276.15.1716196125854; Mon, 20 May 2024
 02:08:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240516101006.2388767-1-victor.liu@nxp.com> <evnxopqt5be56vxuxqdj4l3mcd5nrrvucio7jhwgg4emraai3t@gherubdynyip>
 <5efe29a7-441f-4d70-b17c-5327c0a9f600@nxp.com>
In-Reply-To: <5efe29a7-441f-4d70-b17c-5327c0a9f600@nxp.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 20 May 2024 12:08:34 +0300
Message-ID: <CAA8EJpqZPQUcqm2U+T7AK74qxo9J0kggS4g484OfoNPAEZPNBw@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge: adv7511: Exit interrupt handling when necessary
To: Liu Ying <victor.liu@nxp.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org, 
	Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se, jernej.skrabec@gmail.com, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
	airlied@gmail.com, daniel@ffwll.ch, biju.das.jz@bp.renesas.com, 
	u.kleine-koenig@pengutronix.de, aford173@gmail.com, jani.nikula@intel.com, 
	bli@bang-olufsen.dk, sui.jingfeng@linux.dev
Content-Type: text/plain; charset="UTF-8"

On Mon, 20 May 2024 at 06:29, Liu Ying <victor.liu@nxp.com> wrote:
>
> On 5/20/24 06:11, Dmitry Baryshkov wrote:
> > On Thu, May 16, 2024 at 06:10:06PM +0800, Liu Ying wrote:
> >> Commit f3d9683346d6 ("drm/bridge: adv7511: Allow IRQ to share GPIO pins")
> >> fails to consider the case where adv7511->i2c_main->irq is zero, i.e.,
> >> no interrupt requested at all.
> >>
> >> Without interrupt, adv7511_wait_for_edid() could return -EIO sometimes,
> >> because it polls adv7511->edid_read flag by calling adv7511_irq_process()
> >> a few times, but adv7511_irq_process() happens to refuse to handle
> >> interrupt by returning -ENODATA.  Hence, EDID retrieval fails randomly.
> >>
> >> Fix the issue by checking adv7511->i2c_main->irq before exiting interrupt
> >> handling from adv7511_irq_process().
> >>
> >> Fixes: f3d9683346d6 ("drm/bridge: adv7511: Allow IRQ to share GPIO pins")
> >> Signed-off-by: Liu Ying <victor.liu@nxp.com>
> >> ---
> >>  drivers/gpu/drm/bridge/adv7511/adv7511_drv.c | 3 ++-
> >>  1 file changed, 2 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
> >> index 6089b0bb9321..2074fa3c1b7b 100644
> >> --- a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
> >> +++ b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
> >> @@ -479,7 +479,8 @@ static int adv7511_irq_process(struct adv7511 *adv7511, bool process_hpd)
> >>              return ret;
> >>
> >>      /* If there is no IRQ to handle, exit indicating no IRQ data */
> >> -    if (!(irq0 & (ADV7511_INT0_HPD | ADV7511_INT0_EDID_READY)) &&
> >> +    if (adv7511->i2c_main->irq &&
> >> +        !(irq0 & (ADV7511_INT0_HPD | ADV7511_INT0_EDID_READY)) &&
> >>          !(irq1 & ADV7511_INT1_DDC_ERROR))
> >>              return -ENODATA;
> >
> > I think it might be better to handle -ENODATA in adv7511_wait_for_edid()
> > instead. WDYT?
>
> Then, adv7511_cec_irq_process() will have less chance to be called from
> adv7511_irq_process() (assuming CONFIG_DRM_I2C_ADV7511_CEC is defined)
> if adv7511->i2c_main->irq is zero.
>
> But, anyway, it seems that commit f3d9683346d6 ("drm/bridge: adv7511:
> Allow IRQ to share GPIO pins") is even more broken to handle the CEC case,
> as adv7511_cec_adap_enable() may enable some interrupts for CEC.
>
> This is a bit complicated.  Thoughts?

Send a revert and do it properly?

>
> Regards,
> Liu Ying
>
>
>
>
>


-- 
With best wishes
Dmitry

