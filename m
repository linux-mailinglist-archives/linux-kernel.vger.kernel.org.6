Return-Path: <linux-kernel+bounces-536876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6E7EA48584
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 17:46:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCBDF177D53
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 16:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1880B1B2EF2;
	Thu, 27 Feb 2025 16:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rezkK4U7"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EEDA1AF0C5
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 16:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740673968; cv=none; b=lR1W71E5LYy37/FotzcDPv9L4Gw1UlJ34epUSp8c73+sVgPMmlbizuhrd5f/hBGeKrLPX8gjieTvmROx4KAqJAPKUjscpb+V/a+uu7hRj+V+FJS02zIIhvBntLIirRlLqXmM5mXLvcXmcILo7BRwXfNjAKUYaIs6kHen2GGNs00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740673968; c=relaxed/simple;
	bh=wuQ99hXtmb6GTwGl7mePLWn1OF/2FQnmOhHQ/Yjazmk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UBpFfeFXFKvbasiX1GEIaR346f7OzA3fEZMq0WLH9lTwEZfrV6bE31JqziOlQsVzdlCdhwjh9K1W399JgetiqvkQ8p5UzKbXGxW6QiNA4FsykPSB9Bmq2QRPzQzUcCj0TRvklYAoK0Dm0j+DihhHZDqFRRUK2WY5wTNBuqubbYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rezkK4U7; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-abee54ae370so167686566b.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 08:32:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740673964; x=1741278764; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uxBzUeb6aEpw2RFXXNhIl9qOIlWZxMjJ6EPTTtqpNP4=;
        b=rezkK4U7Tw3qR+vcpgzgc1rho+4OVxDcQVa1Q1NmO7qMF2eF3p14dqh0aLxVUhJfTV
         aOl70Xt1MCDzYD9wG0+f1WlfOB/I9BxErRdebcbbHWZz+qU4tM1kBkn+/qdZ6hpehNOf
         ZpVDyiqB7ncPjWGps2+2cwE7e6ROVVlZVcJlJrUQE268r2wVdY5HrnXUBCKAN+LxqHq0
         z2TWVt3rm/Q5jFR1LyInTjgNNLYwF88+gbTFIdivYt1S3yQ8cG8dxKLZQQ5nZcDW+RfS
         wH+HsqOY+zWDCCONM5WYQqCZygIDas/uDSg1CNLlUHd8lTYI3L/fNLxmbPEhCQZW/TZk
         H21w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740673964; x=1741278764;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uxBzUeb6aEpw2RFXXNhIl9qOIlWZxMjJ6EPTTtqpNP4=;
        b=DQ22HnVGkuJrIu7qzspOca5ZydVHbu1J+TfuveNPGGy4uaH8ago9LN8KfHt1JiR8Ul
         v3FnVc5cR44n9SSa5szM95lDbPckEZymlql7ELELYQK8i7iaxBa6ldz3s6fqzeQTDEsT
         LDhLAYU1Qv72dc9SMGBQ0bGbn50rECpmxSXK4OOwqxTSVDJ9c5uepCYmDquktXNwVLmL
         5sVGrfx/s3+Eq2aCNU3pVLpGc+WBn7Cobj2meTxx2YBISEu6KYnDDq6s/0DTzbDYkg+n
         SQho2rfNwvgNLJ89zlChh/zuygCFug5aMsKb2KML3mZvIqKl8YLnk66ybNu/MQduqJuj
         8ckA==
X-Forwarded-Encrypted: i=1; AJvYcCVAEfbxQkf/fcAH4WjMWFMkvxlWdgyvNA23BjMtNsQGLRcXQ2+WubdaKjC7jh0NbHCiVkah6E8xzbQt7oY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOOpKLXDSw9KjkTe7EHkqIs/LLHbEvbDqiy72xL7tMjnLwPZZV
	lHwCGtAAVcheTwc7NBRQiegdWzGdieE+QLw7clWc0zivk9cNQRNbWMG9zlbCpUU=
X-Gm-Gg: ASbGnctXRXw2Q7OmCZ756dGE/iL8UEDNw6rfEp/V4JWf2QnffjPNh9A8U6/nsDk3LZh
	jenjiMPxGkhGUMrqr/Ph1rBce6aEzYK3b7AjPAQreB5Xr0aGlEdfVKdgCjTK1mVOZ2vpgmP9QIo
	Yv75hRyWCQrJ6OdeTZKgZthaBAlp4ipPcJ6gORWu+GJS17yleC54i4LY3Elzk+hkvac6nScELRs
	/FPMZHjfvPsSCvDMbiHRHVx66kHU6vGd3h/dtypXIr3u/zVwiYSGsy37DHb22q05u7fdZwtJaZp
	r9GoOcmf6z3oMwVzST0hK9I=
X-Google-Smtp-Source: AGHT+IENWfYyNPrvqdJkkInr0wph6rUkn8UzeZpWdw7KVY+SQfhvXNCVt/aAXye31RRnjNVIrHnJ5w==
X-Received: by 2002:a17:906:d542:b0:ab7:e3cb:ca81 with SMTP id a640c23a62f3a-abf2657c56dmr9884666b.30.1740673963757;
        Thu, 27 Feb 2025 08:32:43 -0800 (PST)
Received: from linaro.org ([62.231.96.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf1f1d5b4csm56471066b.85.2025.02.27.08.32.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 08:32:43 -0800 (PST)
Date: Thu, 27 Feb 2025 18:32:41 +0200
From: Abel Vesa <abel.vesa@linaro.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Cc: Sebastian Reichel <sre@kernel.org>, Lee Jones <lee@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Anjelique Melendez <quic_amelende@quicinc.com>,
	Kamal Wadhwa <quic_kamalw@quicinc.com>,
	Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Johan Hovold <johan@kernel.org>, Pavel Machek <pavel@ucw.cz>,
	linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] leds: rgb: leds-qcom-lpg: Fix pwm resolution for Hi-Res
 PWMs
Message-ID: <Z8CTqdFafLY17C25@linaro.org>
References: <20250220-leds-qcom-lpg-fix-max-pwm-on-hi-res-v1-1-a161ec670ea5@linaro.org>
 <dfthocttum7dscotngi6l2hz6bpdwfgrdxpvkcv6bdux3lt66d@iqfvmntvzyut>
 <Z7zVgeM+7P7SLWIu@linaro.org>
 <vc7irlp7nuy5yvkxwb5m7wy7j7jzgpg73zmajbmq2zjcd67pd2@cz2dcracta6w>
 <Z7161SzdxhLITsW3@linaro.org>
 <5euqboshlfwweie7tlaffajzg3siiy6bm3j4evr572ko54gtbv@7lan3vizskt3>
 <Z8B2Bl/9uD3jPvQi@linaro.org>
 <j55de6bbipoavqx25w2s6qr7n6fv6w7bj3lrgyag4dlvvddbqv@shn22aqcqeci>
 <Z8CIY2OJUMqIOHGU@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z8CIY2OJUMqIOHGU@linaro.org>

On 25-02-27 17:44:35, Abel Vesa wrote:
> On 25-02-27 16:25:06, Uwe Kleine-König wrote:
> > Hello Abel,
> > 
> > On Thu, Feb 27, 2025 at 04:26:14PM +0200, Abel Vesa wrote:
> > > On 25-02-27 10:58:47, Uwe Kleine-König wrote:
> > > > Can you please enable CONFIG_PWM_DEBUG, enable pwm tracing (
> > > > 
> > > > 	echo 1 > /sys/kernel/debug/tracing/events/pwm/enable
> > > > 
> > > > ) then reproduce the problem and provide the output of
> > > > 
> > > > 	cat /sys/kernel/debug/tracing/trace
> > > > 
> > > > .
> > > 
> > > $ cat trace
> > > # tracer: nop
> > > #
> > > # entries-in-buffer/entries-written: 13/13   #P:12
> > > #
> > > #                                _-----=> irqs-off/BH-disabled
> > > #                               / _----=> need-resched
> > > #                              | / _---=> hardirq/softirq
> > > #                              || / _--=> preempt-depth
> > > #                              ||| / _-=> migrate-disable
> > > #                              |||| /     delay
> > > #           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
> > > #              | |         |   |||||     |         |
> > >         modprobe-203     [000] .....     0.938668: pwm_get: pwmchip0.0: period=1066407 duty_cycle=533334 polarity=0 enabled=1 err=0
> > >         modprobe-203     [000] .....     0.938775: pwm_apply: pwmchip0.0: period=5000000 duty_cycle=0 polarity=0 enabled=1 err=0
> > >         modprobe-203     [000] .....     0.938821: pwm_get: pwmchip0.0: period=4266537 duty_cycle=0 polarity=0 enabled=1 err=0
> > >         modprobe-203     [000] .....     0.938936: pwm_apply: pwmchip0.0: period=4266537 duty_cycle=0 polarity=0 enabled=1 err=0
> > >         modprobe-203     [000] .....     0.938982: pwm_get: pwmchip0.0: period=4266537 duty_cycle=0 polarity=0 enabled=1 err=0
> > >         modprobe-203     [000] .....     0.939274: pwm_apply: pwmchip0.0: period=5000000 duty_cycle=921458 polarity=0 enabled=1 err=0
> > >         modprobe-203     [000] .....     0.939320: pwm_get: pwmchip0.0: period=4266537 duty_cycle=921355 polarity=0 enabled=1 err=0
> > >         modprobe-203     [000] .....     0.939434: pwm_apply: pwmchip0.0: period=4266537 duty_cycle=921355 polarity=0 enabled=1 err=0
> > >         modprobe-203     [000] .....     0.939480: pwm_get: pwmchip0.0: period=4266537 duty_cycle=921355 polarity=0 enabled=1 err=0
> > >  systemd-backlig-724     [006] .....     9.079538: pwm_apply: pwmchip0.0: period=5000000 duty_cycle=5000000 polarity=0 enabled=1 err=0
> > >  systemd-backlig-724     [006] .....     9.079585: pwm_get: pwmchip0.0: period=4266537 duty_cycle=4266537 polarity=0 enabled=1 err=0
> > >  systemd-backlig-724     [006] .....     9.079698: pwm_apply: pwmchip0.0: period=4266537 duty_cycle=4266537 polarity=0 enabled=1 err=0
> > >  systemd-backlig-724     [006] .....     9.079750: pwm_get: pwmchip0.0: period=4266537 duty_cycle=4266537 polarity=0 enabled=1 err=0
> > > $
> > > 
> > > > 
> > > > I didn't take a deeper dive in this driver combination, but here is a
> > > > description about what *should* happen:
> > > > 
> > > > You're talking about period in MHz, the PWM abstraction uses
> > > > nanoseconds. So your summary translated to the PWM wording is (to the
> > > > best of my understanding):
> > > > 
> > > >   1. PWM backlight driver requests PWM with .period = 200 ns and
> > > >      .duty_cycle = 200 ns.
> > > > 
> > > >   2. leds-qcom-lpg cannot pick 200 ns exactly and then chooses .period =
> > > >      1000000000 / 4.26666 MHz = 234.375 ns
> > > >      
> > > >   3. leds-qcom-lpg then determines setting for requested .duty_cycle
> > > >      based on .period = 200 ns which then ends up with something bogus.
> > 
> > The trace looks better than what I expected. 2. is fine here because it
> > seems when Sebastian wrote "driver requests PWM with 5 MHz period" that
> > meant period = 5000000 ns. That was then rounded down to 4266537 ns. And
> > the request for period = 5000000 ns + duty_cycle = 5000000 ns was
> > serviced by configuring period = 4266537 ns + duty_cycle = 4266537 ns.
> > So that's a 100 % relative duty configuration as intended.
> > 
> > So just from the traces I don't spot a problem. Do these logs not match
> > what actually happens on the signal?
> 
> What I do not get is why do we expect 2 pwm_get() and 2 pwm_apply()
> calls each time ?

OK, so the second pwm_apply() is due to CONFIG_PWM_DEBUG.

But still, the first pwm_apply() requests duty cycle of 5MHz:

systemd-backlig-724     [006] .....     9.079538: pwm_apply: pwmchip0.0: period=5000000 duty_cycle=5000000 polarity=0 enabled=1 err=0

So since the period is 4.26MHz, due to the knobs selected by the
provider, this duty cycle will result in a PWM value that is above the
selected resolution, as I already mentioned.

> 
> Need to dig a bit further.
> 
> But meanwhile, if the first pwm_apply() call goes all the way to the
> provider, then the duty cycle value, when translated to the actual PWM
> value that gets written to reg, will overflow. So this is what is wrong.
> And this is what actually happens.
> 
> > 
> > Best regards
> > Uwe
> 
> 
> 

