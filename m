Return-Path: <linux-kernel+bounces-183708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 051208C9CD2
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 14:00:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF96C282276
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 12:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CFB8537FB;
	Mon, 20 May 2024 12:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LFBhvF8a"
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A03F723AD
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 12:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716206445; cv=none; b=pI1xZ2XUzERO7IrjlzTcGKOJjJFbW12e2JlBAPsvqzh9yn3nUIzwpX6JKRTBjufACJaRb1coxyXJyge0WN4AOGqLdeBK2gvxzevdi4IkJpZNb14+kNjXsvHBAqnv0VRi1g/K8GsMOUVEWs+O52QbNDH21WHed0PgHGtko9nYo+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716206445; c=relaxed/simple;
	bh=qSyJg1K2HZQFIhiik8XiCt7hClMpffIhiGP+ct5XPUk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HkEONpjlum2gsE25wRfxC5vm/Or3loalwyUO7mPtj3JuwmjCEblYfUNwLqyOokQ6FYaY3aQUE8Uf1lE5Hx4JLbGdtyXCXDiZpRlDyoe+sJ05FdBujP8Q4AUdfEZgtWN/jMluQUesDwbvN176mmyR1dGV9TlBWjyfkD/yYC9IpdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LFBhvF8a; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-61e0c2b5cd2so14083357b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 05:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716206442; x=1716811242; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qVN4sbNkbDEnW1RK7cK93DMtRTTOozrAuE7GvJdhEvI=;
        b=LFBhvF8a7mYZlk0qAT3X733hSEyTmqwZfbmu54Wke6BnZiqroATVBc9TidMgPvpRSN
         Mv0jIf9j70q/kkhG5GQXZWS6tNfmO3ri4ryNVi+bDUtxxOas2pdSFdi+Uyc3du2/tUR/
         CTaNj0FOr87fKhkAH0TY3CLUpSomxwpO2SvWUKLSD2AqaE7MC4Y7NV0J2zB4NMsvcp9X
         kUOmgQRKMPZusx0v2716g0bTk2jUFC0ENSxZ+LWq8p7bkLAVDtuV51Y5Y9HOcPxYHCh5
         fNQN6RG0YTlwPI//5hjd7SEBMqP9uyJ6Bs8foe1isYM51iqzeDYO+/dtzhlXv7mEhPw5
         +i3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716206442; x=1716811242;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qVN4sbNkbDEnW1RK7cK93DMtRTTOozrAuE7GvJdhEvI=;
        b=DMksXpzG8HceGq+4nRmcI2+1OP3Ee42pomniuzvtShIZjOMlcPUEUgs/zhT8EgfTqa
         7FG5itfjQc8behfYMKHUlHiQtdQ8l0zf6xpp1diSJMNB8U1xviNM9SOZh9njzH0Wv/LD
         0c0uxWh0v3kZeUc5OAlSaKiXGoxHndBL33aBa4+EMxlrqscpAGrMlZ/mKaogAQDWXdKG
         L96t8Q91xPH43KQX9rXRnuIa06oSm5t0qN7+nMPbZmvqkBAaY6D26ocp9moS6aXl0NKB
         OVsWqosHJ/F+Is6wmaCnNzVRiheW+8ubGaf6N/cyrkPARJv64RUKqpoo2O6np3WcNOwA
         CWkQ==
X-Forwarded-Encrypted: i=1; AJvYcCX/Z45duUfYlwAs++unqYLRVmIdbYFsKHUw8Nxnw0kmvXH/DT+9khb7sn+pH5yMYPYk3zZPUVOwol2ugzmsqkzuuv8FwDNjds5L+X+G
X-Gm-Message-State: AOJu0YyxxBvgFB30m2ef5ldoitVJPdeAoPVEN12Jy8TSheyRNbtkUhoA
	BFRqj+/etmJvGsy1jxJSQXkw3vD+MDX0AjX2eYhp+iUfCX0alQ3ZT41rQa2GY1vcZWldNTea8fI
	I493acnE9RSuZ7AmchK1UWvKLDIwPGJvksQXrVBeE6dPPO8Pn
X-Google-Smtp-Source: AGHT+IHSVI5Muun1d4Yraywna+3qKbgYbyrSHITOEnEVTFE6fqyv1bnRVC6Bix6ZgiBn65MdtlTnre4LV5hO4NgFAM4=
X-Received: by 2002:a05:690c:7442:b0:622:f7df:aa0a with SMTP id
 00721157ae682-627972d3d56mr36406697b3.22.1716206442502; Mon, 20 May 2024
 05:00:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240516101006.2388767-1-victor.liu@nxp.com> <evnxopqt5be56vxuxqdj4l3mcd5nrrvucio7jhwgg4emraai3t@gherubdynyip>
 <e2d4e8b4-bab4-448f-8b67-21f2902fdcd2@linux.dev> <CAA8EJppH1rYQ5pzkGP+V-=cOPBYMWm=ZK2Ei1ttjOiN6GRDP+w@mail.gmail.com>
 <acc508e2-b067-47ef-b3e2-fcac51403fe0@linux.dev>
In-Reply-To: <acc508e2-b067-47ef-b3e2-fcac51403fe0@linux.dev>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 20 May 2024 15:00:30 +0300
Message-ID: <CAA8EJpowLnrnV8ezXYj=oWBFFTa6LqkPFFHc9F49un6AYgZvzw@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge: adv7511: Exit interrupt handling when necessary
To: Sui Jingfeng <sui.jingfeng@linux.dev>
Cc: Liu Ying <victor.liu@nxp.com>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, andrzej.hajda@intel.com, 
	neil.armstrong@linaro.org, rfoss@kernel.org, 
	Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se, jernej.skrabec@gmail.com, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
	airlied@gmail.com, daniel@ffwll.ch, biju.das.jz@bp.renesas.com, 
	u.kleine-koenig@pengutronix.de, aford173@gmail.com, jani.nikula@intel.com, 
	bli@bang-olufsen.dk
Content-Type: text/plain; charset="UTF-8"

On Mon, 20 May 2024 at 14:48, Sui Jingfeng <sui.jingfeng@linux.dev> wrote:
>
> Hi,
>
>
> On 5/20/24 19:13, Dmitry Baryshkov wrote:
> > On Mon, 20 May 2024 at 14:11, Sui Jingfeng <sui.jingfeng@linux.dev> wrote:
> >>
> >> Hi,
> >>
> >> On 5/20/24 06:11, Dmitry Baryshkov wrote:
> >>> On Thu, May 16, 2024 at 06:10:06PM +0800, Liu Ying wrote:
> >>>> Commit f3d9683346d6 ("drm/bridge: adv7511: Allow IRQ to share GPIO pins")
> >>>> fails to consider the case where adv7511->i2c_main->irq is zero, i.e.,
> >>>> no interrupt requested at all.
> >>>>
> >>>> Without interrupt, adv7511_wait_for_edid() could return -EIO sometimes,
> >>>> because it polls adv7511->edid_read flag by calling adv7511_irq_process()
> >>>> a few times, but adv7511_irq_process() happens to refuse to handle
> >>>> interrupt by returning -ENODATA.  Hence, EDID retrieval fails randomly.
> >>>>
> >>>> Fix the issue by checking adv7511->i2c_main->irq before exiting interrupt
> >>>> handling from adv7511_irq_process().
> >>>>
> >>>> Fixes: f3d9683346d6 ("drm/bridge: adv7511: Allow IRQ to share GPIO pins")
> >>>> Signed-off-by: Liu Ying <victor.liu@nxp.com>
> >>>> ---
> >>>>    drivers/gpu/drm/bridge/adv7511/adv7511_drv.c | 3 ++-
> >>>>    1 file changed, 2 insertions(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
> >>>> index 6089b0bb9321..2074fa3c1b7b 100644
> >>>> --- a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
> >>>> +++ b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
> >>>> @@ -479,7 +479,8 @@ static int adv7511_irq_process(struct adv7511 *adv7511, bool process_hpd)
> >>>>               return ret;
> >>>>
> >>>>       /* If there is no IRQ to handle, exit indicating no IRQ data */
> >>>> -    if (!(irq0 & (ADV7511_INT0_HPD | ADV7511_INT0_EDID_READY)) &&
> >>>> +    if (adv7511->i2c_main->irq &&
> >>>> +        !(irq0 & (ADV7511_INT0_HPD | ADV7511_INT0_EDID_READY)) &&
> >>>>           !(irq1 & ADV7511_INT1_DDC_ERROR))
> >>>>               return -ENODATA;
> >>>
> >>> I think it might be better to handle -ENODATA in adv7511_wait_for_edid()
> >>> instead. WDYT?
> >>>
> >>
> >> I think this is may deserve another patch.
> >
> > My point is that the IRQ handler is fine to remove -ENODATA here,
>
> [...]
>
> > there is no pending IRQ that can be handled.
>
> But there may has other things need to do in the adv7511_irq_process()
> function.

But the function returns anyway. So, we know that the condition is broken.

>
> > So instead of continuing
> > the execution when we know that IRQ bits are not set,
>
> Even when IRQ bits are not set, it just means that there is no HPD
> and no EDID ready-to-read signal. HDMI CEC interrupts still need
> to process.

Yes. Let's get the CEC fixed. Then maybe we won't need this commit at all.

>
>
> > it's better to
> > ignore -ENODATA in the calling code and go on with msleep().
> >
>
> So, It's confusing to ignore the -ENODATA here.

[BTW: you had quotation levels wrong in two places, I've fixed them]

-- 
With best wishes
Dmitry

