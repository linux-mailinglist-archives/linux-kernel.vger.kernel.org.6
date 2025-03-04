Return-Path: <linux-kernel+bounces-543745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 86CAAA4D947
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 10:52:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6AC11634D0
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 09:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00B2F1FCFCC;
	Tue,  4 Mar 2025 09:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="I9A+BCBa"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F0671F37CE
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 09:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741081944; cv=none; b=cWLyZvqgJkEpiRmx5ho6m2pBvdyc4CENYSNWWfW2wnFleYYcXc0Cp/FK3D15Hg+LdmSyOoE1RcKoPoo1KtXSrhy24m4SIC/BLfd1zFCrx93S8xURk5VaUKir6q3U8MDdjoRpuuHIO63J5K0dl6MsISA7aOjDCOj24SAvnp2+/zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741081944; c=relaxed/simple;
	bh=KwJAL+8nlg6NaZr6TQKkWAfNsCpzYo3HevwgkwWaprs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W6pEIJyQwRcPfioxkH/AQLtWE3sLaXYoX+lwiBuurSvtDbpNXiPCXfjwj3n1sKXrJH8AqqRajq1JLjNLe7i1WyhGVhWf/m2l4YTYz3Tns6dCZ9G20j4mIO6lceIObUakKhRGqOpD+xzBl7NsPOpFCvEdC1awymomAQNDmhAEZJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=I9A+BCBa; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5e4c0c12bccso9589300a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 01:52:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741081939; x=1741686739; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DZwiKL4v283+SUaq0hgu1/dyqNCJkSPuPE7RC6lrBDY=;
        b=I9A+BCBaOLy49cLTiD32KZxB6RBOkbF9wAWhpcjWpbBjZ0T+iroMwuQxOQ7fsEITQj
         i3jA4fKu+NHKxx3H8vbzd1HtfOBciq2H9Y78dFIGr9pug7jd7VTe1f0bv3Bwi0dCmGAP
         ddmzebE7bejKhwO51lNvDUMsTioiX6ICqGZ1WUv6FidCF8iHTj2980j2fAk8r4LngR2q
         2LRFuqD3BLEMb3GPv4fsSndYXoBu+7sC1Nrt7QZTo9vxLecCD5gbBKD6hRVd4rMGadcC
         92FNZ3E7vqij+Iwrz77iM5Xijtr8ZonlX4q2tPTA3d37t+1gbI1N3lh6B+d3qImZJtup
         7m4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741081939; x=1741686739;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DZwiKL4v283+SUaq0hgu1/dyqNCJkSPuPE7RC6lrBDY=;
        b=aTftiwlgR1yK3b/VJEQhAH/4VQM6LG6gClIKXj760PbUrGdes5NuoNCMpwsWiasouF
         ok8NSh40UFCDZTsdEpx4CcbSH3UYYnEH1bAUnvVtL2J06L2+5F7ZAhylTS8DC6/J5sol
         sOnfN6jz4j9dD41zwTda+aYaG/7XsBVaLZbp6JzV77e7L3sE7YyQ51B0XRaWj99iCwni
         m2cDXlcRmzbx+ACrhN1/yh2ExGd+BL36Kf6XpAD80YiHcAZsW+B6M1V4bkfz1i2u/aYY
         Z7MkJZzAAAEOXizMaEqDqBy8XNnPrnSR1XPcnihRhjS7a2OQhVoaVvxn7WHAtm9UN7Jt
         u1Vw==
X-Forwarded-Encrypted: i=1; AJvYcCXVHJr91W29wpgPC97ZtOCliomEzKrQefy9RQZh6oqmn0mJ12DAO7eMz3nmqwu2X8D+Xg2GybMwUjwMFNk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaYwjEMT2Vpg5SeEE6br9+EEIXVFGXVFH8Gsj7yCIzkCRNsGsU
	7b20DbyE9haceODmu5oqXSv/9vCi+fO20h2cxktu3n8GhCt2UwGopWL654jE5OY=
X-Gm-Gg: ASbGncvglvJYbtVLT5EAIqVKWqyQlrKW9Yiupu3tR0RcLe8lMDdvt6ulS1fttrIVZ94
	29qHJw4LcdK+x8PPsvkyqlf2HTzO0kAkvxoN6/obc1gVjUuwgyI2MxycRnzKsQ9zlNihrZOTJ+8
	lb+n33WZZPTr/GVTLvOPQNhEQIriJ6JqCwoiZtRso/clVjIT5WhWpXI5gLGGhlNlrFGZvfzhbDF
	Ymwg54Ibw0CvPelq5JWUERSmdBq1GtZndJ4zgAAATnSxSRcVXdQ8jCW5sVYOcGbX6GLSXRhiD1R
	8NHmSZxMCWSZ6tobTNAkjIH8wXYP7JMTaP09wM0H4A==
X-Google-Smtp-Source: AGHT+IGQWlKN4k2lczko659hMXJWFN/NdCnjB0I9ceOXcaqEkhXaUGAzcOp5oqggOVX2KYuNVpHIxg==
X-Received: by 2002:a05:6402:2710:b0:5de:5025:2bd9 with SMTP id 4fb4d7f45d1cf-5e4d6af2430mr17405045a12.11.1741081939377;
        Tue, 04 Mar 2025 01:52:19 -0800 (PST)
Received: from linaro.org ([62.231.96.41])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e4c3fb51f9sm7986504a12.55.2025.03.04.01.52.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 01:52:18 -0800 (PST)
Date: Tue, 4 Mar 2025 11:52:16 +0200
From: Abel Vesa <abel.vesa@linaro.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>
Cc: Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>,
	Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>,
	Kamal Wadhwa <quic_kamalw@quicinc.com>,
	Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Johan Hovold <johan@kernel.org>, Sebastian Reichel <sre@kernel.org>,
	Pavel Machek <pavel@ucw.cz>, linux-leds@vger.kernel.org,
	linux-pwm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] leds: rgb: leds-qcom-lpg: Compute PWM value based on
 period instead
Message-ID: <Z8bNUI9Fj2TaV/2m@linaro.org>
References: <20250303-leds-qcom-lpg-compute-pwm-value-using-period-v1-1-833e729e3da2@linaro.org>
 <ylnkjxnukss7askv7ip5htrb4tyjzhpw7jim2se6rloleq5h6w@ngk7lbk26hxj>
 <Z8bGHV4PIkY4te6V@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z8bGHV4PIkY4te6V@linaro.org>

On 25-03-04 11:21:33, Abel Vesa wrote:
> On 25-03-04 07:24:32, Uwe Kleine-König wrote:
> > Hello Abel,
> > 
> > On Mon, Mar 03, 2025 at 06:14:36PM +0200, Abel Vesa wrote:
> > > Currently, the implementation computes the best matched period based
> > > on the requested one, by looping through all possible register
> > > configurations. The best matched period is below the requested period.
> > 
> > The best matched period *isn't above* the requested one. An exact match
> > is fine.
> > 
> 
> Yep, that's better. Will re-word.
> 
> > > This means the PWM consumer could request duty cycle values between
> > > the best matched period and the requested period, which with the current
> > > implementation for computing the PWM value, it will result in values out
> > > of range with respect to the selected resolution.
> > 
> > I still don't understand what you mean with resolution here.
> 
> Resolution in this context means the number of bits the PWM value
> (register value) is represented in. Currently, the driver supporst two PWM
> HW subtypes: normal and Hi-Res. Normal ones recently got support for changing
> the resolution between 6 bits or 9 bits. The high resolution ones support
> anything between 8 bits and 15 bits.
> 
> > 
> > I guess you spend some time understanding the workings of the driver and
> > you also have an example request that results in a hardware
> > configuration you don't like. Please share the latter to a) support your
> > case and b) make it easier for your reviewers to judge if your change is
> > indeed an improvement.
> 
> Sure, will bring up the 5ms period scenario again.
> 
> When the consumer requests a period of 5ms, the closest the HW can do in
> this case is actually 4.26ms. Since the PWM API will continue to ask for
> duty cycle values based on the 5ms period, for any duty cycle value
> between 4.26ms and 5ms, the resulting PWM value will be above 255, which
> has been selected as best resolution for the 4.26ms best matched period.
> 
> For example, when 5ms duty cycle value is requested, it will result in a
> PWM value of 300, which overflows the 255 selected resolution.
> 
> > 
> > > So change the way the PWM value is determined as a ratio between the
> > > requested period and duty cycle, mapped on the resolution interval.
> > 
> > Is the intention here that (for the picked period) a duty_cycle is
> > selected that approximates the requested relative duty_cycle (i.e.
> > .duty_cycle / .period)?
> 
> Yes, that exactly what the intention is.
> 
> > 
> > If it's that: Nack. This might be the right thing for your use case, but
> > it's wrong for others, it complicates the driver because you have spend
> > more effort in the calculation and (from my POV even worse) the driver's
> > behaviour deviates from the usual one for pwm drivers. I admit there are
> > some other lowlevel pwm drivers that are not aligned to the procedure I
> > described that should be used to determine the register settings for a
> > given request. But I target a common behaviour of all pwm drivers
> > because that is the only way the pwm API functions can make a promise to
> > its consumers about the resulting behaviour. Reaching this is difficult,
> > because some consumers might depend on the "broken" behaviour of a given
> > lowlevel driver (and also because analysing a driver to check and fix
> > its behaviour is an effort). But "fixing" a driver to deviate from the
> > declared right behaviour is wrong and includes all downsides that make
> > me hesitate to align the old drivers to the common policy.
> 
> OK, fair enough. But I still don't get what you expect from the provider
> that can't give the exact requested period. Do you expect the consumer
> to request a period, then provider compute a best matched one, which in
> our case is pretty far, and then still give exact duty cycle values ?
> 
> Like: request 5ms period, get 4.26ms instead, then request 4ms duty
> cycle and get exact 4ms duty cycle when measured, instead of a
> proportional value to the best matched period?
> 
> If so, then what happens when consumer asks for 5ms duty cycle?
> Everything above the 4.26ms will just represent 100% duty cycle.
> 
> > 
> > The policy to pick a hardware setting is a compromise between consumer
> > needs and what is straight forward to implement for (most) hardware
> > drivers. Please stick to that. If you want more flexibility and
> > precision in your consumer, please consider converting the pwm driver to
> > the waveform API.
> 
> That means the pwm_bl driver will have to switch to waveform API, IIUC.
> 
> That might break other providers for the pwm_bl consumer, wouldn't it?
> 
> > 
> > > [...]
> > > @@ -532,13 +534,15 @@ static void lpg_calc_duty(struct lpg_channel *chan, uint64_t duty)
> > >  	if (chan->subtype == LPG_SUBTYPE_HI_RES_PWM) {
> > >  		max = BIT(lpg_pwm_resolution_hi_res[chan->pwm_resolution_sel]) - 1;
> > >  		clk_rate = lpg_clk_rates_hi_res[chan->clk_sel];
> > > +		pwm_resolution_arr = lpg_pwm_resolution_hi_res;
> > >  	} else {
> > >  		max = BIT(lpg_pwm_resolution[chan->pwm_resolution_sel]) - 1;
> > >  		clk_rate = lpg_clk_rates[chan->clk_sel];
> > > +		pwm_resolution_arr = lpg_pwm_resolution;
> > >  	}
> > >  
> > > -	val = div64_u64(duty * clk_rate,
> > > -			(u64)NSEC_PER_SEC * lpg_pre_divs[chan->pre_div_sel] * (1 << chan->pre_div_exp));
> > > +	step = div64_u64(period, max);
> > > +	val = div64_u64(duty, step);
> > 
> > Such a pair of divisions is bound to loose precision. I didn't try to
> > determine values that can happen in practise here, but consider:
> > 
> > 	period =  999996
> > 	max =     500000
> > 	duty =    499998
> > 
> > The exact value for val is 250000. However with integer division you
> > get 499998. What you can do about that is calculating
> > 
> > 	val = duty * max / period
> > 
> > instead which gives you a more exact result. The challenge here however
> > is that the multiplication might overflow. If you know that the result
> > fits into a u64, mul_u64_u64_div_u64() is the function that gets this
> > right for you.
> 
> I like this idea. Will use that instead.
> 
> > 
> > >  	chan->pwm_value = min(val, max);
> > >  }
> > > [...]
> > > ---
> > > base-commit: 0067a4b21c9ab441bbe6bf3635b3ddd21f6ca7c3
> > 
> > My git repo doesn't know that commit. Given that you said your patch
> > bases on that other series, this isn't surprising. Please use a publicly
> > available commit as base parameter, otherwise you (and I) don't benefit
> > from the armada of build bots because they just silently fail to test in
> > this case.
> 
> Well, this is a pretty common practice. When the patch relies on other
> patches that haven't been merged yet, but are still on the list, you
> can't really base it on a publicly available commit.
> 
> And the fixes patchset that this is based on is needed for this to work.
> 
> So I really don't get how this can be done differently.

Ignore this comment.

Just learned about 'b4 --edit-deps' today, so will do that from now on.

> 
> > 
> > Best regards
> > Uwe
> 
> Thanks for reviewing,
> Abel
> 

