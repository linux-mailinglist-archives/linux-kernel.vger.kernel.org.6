Return-Path: <linux-kernel+bounces-536915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 660DCA485D5
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 17:56:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE08E1887868
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 16:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6534A1AE003;
	Thu, 27 Feb 2025 16:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o0X+vPNM"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB6A1BCA0A
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 16:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740675045; cv=none; b=lSmuaxI8Bd1xwMMtCCxL/UAWWT/rmtXMt83iA1RQJn14YFVJxQkpYeLD6fUtI0hBBMaLyfnOh+zzbLgN/UXExpcHYAoKvp0LNBqePl9E5wvxyEymKIr4IyfQvQ6+JlHvOyE1VHxAsPuzsG8FS7hcPAIpv1m18xxVCmbLpsC1yYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740675045; c=relaxed/simple;
	bh=12rVFyRRUPsF65d5vORiEKQQhPic/Db68beF7rEDFhU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jYDoD4GIyYoUaqdulAzcX1dJGfVUVg5dlIt9ebEqCbw95gQF3t9yJZMOgVl5HOUp2hXfwaSb65jDgbfyuTo5lZqwURgdkoCfwZwzir3I77KJkluMfY284/reQQmmZj3FHezxUxyW+V/RiVDDqGA+47cwEeweejc66OS+CRrIHRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=o0X+vPNM; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-aaf0f1adef8so216192566b.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 08:50:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740675042; x=1741279842; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=U9B6UFKW6QmOND+nqqfJHYUB8wm1gr52tPG9pQzTZMI=;
        b=o0X+vPNM2eXFsR37rv83TIJFeqE8A9IflWWefDNfxZL8jK7+vRaZi/rOvHsbym7JMD
         F6y7q82ui4bCT2FuDNj9DXp7HIrvwXH+u3Rxu5vgbR5jzdjcdDbwET1PZPIZP/TMjDQ6
         vcaqkBMVc/Q4I10ryvXaU+eZ1YdpMrcBAdOd4lTsr/ZigHb14tbPzNTyzPba2IFjlAqS
         n4ReHnGFAIG7UkKaYLxTVPqQwq09shARfO3rgt0oZ4P2+C95KtmTJpMCECmu3liElAdV
         urbMhc9oAReLr5qz+uLYyF1ShfQ7+q4YDdgjuOJdpIV4/uy+KX5BHpdCq4FzLi2ywdWS
         uRyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740675042; x=1741279842;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U9B6UFKW6QmOND+nqqfJHYUB8wm1gr52tPG9pQzTZMI=;
        b=bibpgs0k2HBzwLe2gCO5yiSBkHxNKL3LnL4qiqunevjPV3k3YWVBUFexXI8+jWAWtt
         EFYn3A+hwed8DWt/V+Hu1dd0OxJJwP88iLhHmABoqpku4w3JaryJW291Q7pZiM8AlwUT
         eevFHxXAm3R3r9blSdTczQcOKFm1oIF4YN0foyb4KPiJNrG8OTgYQGlKPHk3i0UGK4Hl
         AjaZjCcz7A2EvavaOWscn+xoAokNavtMyi3uebcJpDr+H7kTJqxnIx6aUtfTZZJhbcF2
         fdx9x23HTr+5ke5YeCLQ00o1uiBump/t6g5z1ErTHbAGah4B1GyDlyuwJyNFzR3jE55W
         9ogg==
X-Forwarded-Encrypted: i=1; AJvYcCXKveUfMJAEggXP6H6RIyriN6zqbbARJI2lZ3mXEdz6I8llza7FVYvMXb+52unBIsRkHVmzMHCFg0/G1Fk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBlczT5ajNtI6PLEHqq9ZiNSbwwXeem1wV60fYNLZWQFmoFBw+
	6cgzVuu63+eubYKw5pI/AnHGYylNl/W+gdAsucf+gxNtPr9tmCx7Cq4mMBKBlvc=
X-Gm-Gg: ASbGncuu3/3R09tYwxgD3oUEDjHVqaV7QprVlIcYATuxcBmXtNG0KpvqcC3fBRZnWx4
	2KYvBxRmQfHMugQzOjJfCn92TSeyivGkfNH6tfMy0cw/f7JFdj419mSWOk6ae06+NK2Dz3WbHcP
	rFXDDNu0GQJTr06O4RKAQi8hH5UqUPHcvxUU+LtQu1tyGplis2+MOTmfpnc3UL+sjdW0ag+1at1
	5+x9w1EhtAIeTvNBZj4m/suGdiIg+rsmpU3M4ip0VA6P0T0hmgYtoTQINFi23FazbjyULg6yWdw
	ytRtcBGJ+JWTQj/5+ANQKQ4=
X-Google-Smtp-Source: AGHT+IGfoZwgSLt/LlIZbdRYkcSEc5pTARTCn2VKVHoHQpdHvHilVJZaKDcCop6xnuShR5HL0iFVCQ==
X-Received: by 2002:a17:907:7f0a:b0:abb:aef3:6052 with SMTP id a640c23a62f3a-abf26838238mr11726366b.55.1740675041559;
        Thu, 27 Feb 2025 08:50:41 -0800 (PST)
Received: from linaro.org ([62.231.96.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf0c0ba408sm149482266b.37.2025.02.27.08.50.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 08:50:39 -0800 (PST)
Date: Thu, 27 Feb 2025 18:50:38 +0200
From: Abel Vesa <abel.vesa@linaro.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>
Cc: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Johan Hovold <johan@kernel.org>, Sebastian Reichel <sre@kernel.org>,
	linux-pwm@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-arm-msm@vger.kernel.org, linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] backlight: pwm_bl: Read back PWM period from provider
Message-ID: <Z8CX3vr1xuaKT38m@linaro.org>
References: <20250226-pwm-bl-read-back-period-from-hw-v1-1-ccd1df656b23@linaro.org>
 <xltamao27utfrsax2pc6mh5tthanmrqszz4k7gyw3knqkm24xp@4tydmhfh6g4j>
 <Z8BjiRjLin8jTE8j@linaro.org>
 <rplq65h5k7kfu7anwhuh3w6lmwtm47lzeruofon4ilsxkhogjl@6k7nmeotjidd>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <rplq65h5k7kfu7anwhuh3w6lmwtm47lzeruofon4ilsxkhogjl@6k7nmeotjidd>

On 25-02-27 16:51:15, Uwe Kleine-König wrote:
> Hello Abel,
> 
> On Thu, Feb 27, 2025 at 03:07:21PM +0200, Abel Vesa wrote:
> > On 25-02-26 17:34:50, Uwe Kleine-König wrote:
> > > On Wed, Feb 26, 2025 at 05:31:08PM +0200, Abel Vesa wrote:
> > > > The current implementation assumes that the PWM provider will be able to
> > > > meet the requested period, but that is not always the case. Some PWM
> > > > providers have limited HW configuration capabilities and can only
> > > > provide a period that is somewhat close to the requested one. This
> > > > simply means that the duty cycle requested might either be above the
> > > > PWM's maximum value or the 100% duty cycle is never reached.
> > > 
> > > If you request a state with 100% relative duty cycle you should get 100%
> > > unless the hardware cannot do that. Which PWM hardware are you using?
> > > Which requests are you actually doing that don't match your expectation?
> > 
> > The PWM hardware is Qualcomm PMK8550 PMIC. The way the duty cycle is
> > controlled is described in the following comment found in lpg_calc_freq
> > of the leds-qcom-lpg driver:
> > 
> > /*
> >  * The PWM period is determined by:
> >  *
> >  *          resolution * pre_div * 2^M
> >  * period = --------------------------
> >  *                   refclk
> >  *
> >  * Resolution = 2^9 bits for PWM or
> >  *              2^{8, 9, 10, 11, 12, 13, 14, 15} bits for high resolution PWM
> >  * pre_div = {1, 3, 5, 6} and
> >  * M = [0..7].
> >  *
> >  * This allows for periods between 27uS and 384s for PWM channels and periods between
> >  * 3uS and 24576s for high resolution PWMs.
> >  * The PWM framework wants a period of equal or lower length than requested,
> >  * reject anything below minimum period.
> >  */
> > 
> > So if we request a period of 5MHz, that will not ever be reached no matter what config
> > is used. Instead, the 4.26 MHz is selected as closest possible.
> 
> The trace in the other mail thread suggest that you asked for a period
> of 5 ms, not 5 MHz. And that results in a period of 4.26 ms.

OK. So unit is ms. Got it.

> 
> > Now, the pwm_bl is not aware of this limitation and will request duty cycle values that
> > go above 4.26MHz.
> 
> It requests .period = 5 ms + .duty_cycle = 5 ms. This is fine, and
> according to the trace this results in both values becoming 4.26 ms in
> real life. Seems fine to me.

Right, but as I keep trying to explain is that, the consumer keeps
asking for duty cycles that go over the 4.26ms, which is the period that
the provider decided it can do instead of 5ms.

> 
> > > > This could be easily fixed if the pwm_apply*() API family would allow
> > > > overriding the period within the PWM state that's used for providing the
> > > > duty cycle. But that is currently not the case.
> > > 
> > > I don't understand what you mean here.
> > 
> > What I was trying to say is that the PWM generic framework currently doesn't
> > allow overriding the PWM state's period with one provided by the consumer,
> > when calling pwm_apply_might_sleep().
> 
> Either I still don't understand what you want, or that is impossible or
> useless. If you target .period = 5 ms and the hardware can only do 4.26
> ms, why would you want to override period to 5 ms?

Meaning the consumer should become aware of the period the provider can
do before asking for a duty cycle. 

If you look at the other mail thread, the trace there shows the
following sequence for every new backlight update request:

1. pwm_apply with consumer's period (5ms)
2. pwm_get reads the provider's period (4.25ms) 
   - which is what the provider is able to do instead of 5ms
3. pwm_apply (due to debug) which uses the state from 2.
4. pwm_get reads back exactly as 2.

So we can ignore 3 and 4 for now as they are there due to debug,
but the step 1 still requests a value over the 4.26ms (5ms),
which in the provider will translate to a pwm value higher than allowed
by the selected configuration.

> 
> > Also, the pwm_get_state_hw() doesn't cache the state either.
> 
> *shrug*.
> 
> > This results in always having to call pwm_get_state_hw() before calling
> > pwm_apply_might_sleep().
> 
> I cannot follow this conclusion. At least one of us two didn't
> understand some detail yet.
> 
> > On top of that, pwm_get_state_hw() doesn't default to the cached value if the
> > provider doesn't implement the ->get_state() op.
> 
> If it did that, the consumer wouldn't know if the request was
> implemented exactly or if there is no way to read back the actual
> configuration.
> 
> > Please correct me if I'm wrong about these.
> > 
> > > 
> > > > So easiest fix here is to read back the period from the PWM provider via
> > > > the provider's ->get_state() op, if implemented, which should provide the
> > > > best matched period. Do this on probe after the first ->pwm_apply() op has
> > > > been done, which will allow the provider to determine the best match
> > > > period based on available configuration knobs. From there on, the
> > > > backlight will use the best matched period, since the driver's internal
> > > > PWM state is now synced up with the one from provider.
> > > > [...]
> > > > diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
> > > > index 237d3d3f3bb1a6d713c5f6ec3198af772bf1268c..71a3e9cd8844095e85c01b194d7466978f1ca78e 100644
> > > > --- a/drivers/video/backlight/pwm_bl.c
> > > > +++ b/drivers/video/backlight/pwm_bl.c
> > > > @@ -525,6 +525,17 @@ static int pwm_backlight_probe(struct platform_device *pdev)
> > > >  		goto err_alloc;
> > > >  	}
> > > >  
> > > > +	/*
> > > > +	 * The actual period might differ from the requested one due to HW
> > > > +	 * limitations, so sync up the period with one determined by the
> > > > +	 * provider driver.
> > > > +	 */
> > > > +	ret = pwm_get_state_hw(pb->pwm, &pb->pwm->state);
> > > 
> > > As a consumer you're not supposed to write to &pb->pwm->state. That's a
> > > layer violation. Please call pwm_get_state_hw() with a struct pwm_state
> > > that you own and save the relevant parts in your driver data.
> > 
> > Yep, that is indeed wrong. Maybe making the pwm opaque might be a good idea as well.
> > 
> > [1] Calling pwm_get_state_hw() would be wrong if the provider doesn't implement the ->get_state(),
> > as I mentioned above.
> > 
> > But are you suggesting we replace all calls to pwm_get_state() with
> > pwm_get_state_hw() in pwm_bl?
> 
> No, I still didn't understand the problem you want to fix here. So I'm
> not suggesting anything yet.
>  
> Best regards
> Uwe



