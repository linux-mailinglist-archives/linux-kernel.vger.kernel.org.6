Return-Path: <linux-kernel+bounces-536725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07DE4A4836F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 16:47:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60EC53BB717
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 15:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E45126B97F;
	Thu, 27 Feb 2025 15:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UtoEvgtt"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866BD231A4D
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 15:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740671081; cv=none; b=mDWqEr07cfVzcHMSePemkwK0Q4FDYIEfLX5tI+6KdGHacD8FXMpUnfk6CJ9UQ/UiPBM46PfIMLbCJsCXusSW/tp8cCYTXE4RKXBJLDkaUizd1QIrpHbeSaMUR2L3wj3B6r6YTty/fD65LM57KrJLYZCL+N58zhZykQIqafJegj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740671081; c=relaxed/simple;
	bh=cmwlWgUGiBrxzsSi0XMsM6LX8XwWPXdEMltCjcZNrhI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PTpudXdxSII2p9+R9XzSsOEy6PX/ikjfFCISBrhHZh//3V7ZnOG6k8RTVn0kz48ABpwZCjWJim+/nAjip1bvsmpozqUnEB0+3eMc0peNd35ONZK31QzAt/QLnR3y8L7+972J7Drlb5ZMcHevpWxcVfFaoWoJYU4rWLbs9z66maI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UtoEvgtt; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5e095d47a25so1672242a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 07:44:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740671078; x=1741275878; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Rdmeu/qUg5UZArZwBy9tn4KHSIQpe0IPJEdQzsJhtnE=;
        b=UtoEvgttIDDtwvp5W7t/F6Xfh0UCahrcyQIXbHwRF6UFL1QJsUYh2FePUiHMucozxF
         fep38u9LeM9cjRgVJIlqrd8z56d4vIrhfYBsoLVdHRdAolnAz4DBuGJsfBXpb2QNjZls
         oI00rGwc+0gUixFODCRQBWMrjz150D67eUWAN7UxNP2Bii5P6pWHNcwPlgTmHqIv8/E2
         FzwlxN9s6SUhK9pX+jnGAT0p5iE6F5UDzb6OLa2c+wkdUjENKVSY5PAwM5JArl5B/3z9
         iDDWiZ1My9H8YZ95prlWJkIM6K2QYpjGCl20imBQQ53XNiKG0bu4W3k/TEFlotlxHxo7
         aKRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740671078; x=1741275878;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rdmeu/qUg5UZArZwBy9tn4KHSIQpe0IPJEdQzsJhtnE=;
        b=jo5g95eguzrC0q2uOvm3SRdcvgpR0hW1GQ4HoRtSWVcLvTm6ljX/AI49ILIlzNUEXa
         88vln2tUJXKoHDZqYLwvUdJ4cDwwBxGtSckD5Q55T5jZ7xk2B+pc8l4TtxWbvhMR2V38
         y8vcZ56Mfh+b434PhfjOsQvTEXq24kSF4xLuM4OIi4WTY/3ZK7hzYlNqCgrXsBumgD5U
         NXdTIHisOZpeFVjpwfr9UnFHK3dBIsdiMbwb4+RthxB6iHWt6SAUe8iJF9luNrjiw74u
         Kna6QoSWqBmPsuMzdVUYfAbkSDTSZL4iX1gc8c1AReGs5TGQ4EbvIB5j3LwzMQaavCCP
         q2sA==
X-Forwarded-Encrypted: i=1; AJvYcCUyQDG6aw90DhYC7JB/iwF3+7R47QLWqxKyR65Piz4QKnsxqOe07U4IKEc6P9AYrkYDuUCNQ6zKtNN45Mg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+e8VfO45Bp/ECbJ3gUYJTOIofALNyThRn48Y7wyL6pBqu9KZM
	b5gYhjKLrIW9e6bXHYu5xY+PfZ9TOiF+sJ6+AgwIQwuFBWL6mJNaQ+1PYe5xT8b2untRWTUgUWX
	w
X-Gm-Gg: ASbGncsgrRHSnzqAkgC7UGxnuEhk0gSpE7NUI1d3flmxpmJzhUPg2+0B3saf9fbYeII
	YCnbAvDQXtEP2IgVTkfI6mgVmyg7yxsd4iAFdZ8Izial5DG4wQX3DyXtKRQVqkvITxEva7A7wvn
	cy9bIMWl4KYa+lhFwIpq8L1ShrZQSYjn8ynP0+/2k8J1kM3puJTogRTQWAzpOPp/dmj4KoLaM7K
	xCATTsFsTp3zZut/i432wyKtWaoNIjMYbZFuyP50xRwUvHDA9bRW2SR4x2/vaUot8n44lpytu8P
	+qsia6PvHWozMoKn7ZCA+bw=
X-Google-Smtp-Source: AGHT+IFPlvCas/g5XVwHNkkiLI/oKN1mfrZ2+ELWC+zipz3ozWe8GTuEuVMg9ijMVFp68LOxNM0W1A==
X-Received: by 2002:a17:906:6a19:b0:abb:6e95:b272 with SMTP id a640c23a62f3a-abc09a8091emr2789728166b.30.1740671077777;
        Thu, 27 Feb 2025 07:44:37 -0800 (PST)
Received: from linaro.org ([62.231.96.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf0c755e0asm138697266b.133.2025.02.27.07.44.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 07:44:37 -0800 (PST)
Date: Thu, 27 Feb 2025 17:44:35 +0200
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
Message-ID: <Z8CIY2OJUMqIOHGU@linaro.org>
References: <20250220-leds-qcom-lpg-fix-max-pwm-on-hi-res-v1-1-a161ec670ea5@linaro.org>
 <dfthocttum7dscotngi6l2hz6bpdwfgrdxpvkcv6bdux3lt66d@iqfvmntvzyut>
 <Z7zVgeM+7P7SLWIu@linaro.org>
 <vc7irlp7nuy5yvkxwb5m7wy7j7jzgpg73zmajbmq2zjcd67pd2@cz2dcracta6w>
 <Z7161SzdxhLITsW3@linaro.org>
 <5euqboshlfwweie7tlaffajzg3siiy6bm3j4evr572ko54gtbv@7lan3vizskt3>
 <Z8B2Bl/9uD3jPvQi@linaro.org>
 <j55de6bbipoavqx25w2s6qr7n6fv6w7bj3lrgyag4dlvvddbqv@shn22aqcqeci>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <j55de6bbipoavqx25w2s6qr7n6fv6w7bj3lrgyag4dlvvddbqv@shn22aqcqeci>

On 25-02-27 16:25:06, Uwe Kleine-König wrote:
> Hello Abel,
> 
> On Thu, Feb 27, 2025 at 04:26:14PM +0200, Abel Vesa wrote:
> > On 25-02-27 10:58:47, Uwe Kleine-König wrote:
> > > Can you please enable CONFIG_PWM_DEBUG, enable pwm tracing (
> > > 
> > > 	echo 1 > /sys/kernel/debug/tracing/events/pwm/enable
> > > 
> > > ) then reproduce the problem and provide the output of
> > > 
> > > 	cat /sys/kernel/debug/tracing/trace
> > > 
> > > .
> > 
> > $ cat trace
> > # tracer: nop
> > #
> > # entries-in-buffer/entries-written: 13/13   #P:12
> > #
> > #                                _-----=> irqs-off/BH-disabled
> > #                               / _----=> need-resched
> > #                              | / _---=> hardirq/softirq
> > #                              || / _--=> preempt-depth
> > #                              ||| / _-=> migrate-disable
> > #                              |||| /     delay
> > #           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
> > #              | |         |   |||||     |         |
> >         modprobe-203     [000] .....     0.938668: pwm_get: pwmchip0.0: period=1066407 duty_cycle=533334 polarity=0 enabled=1 err=0
> >         modprobe-203     [000] .....     0.938775: pwm_apply: pwmchip0.0: period=5000000 duty_cycle=0 polarity=0 enabled=1 err=0
> >         modprobe-203     [000] .....     0.938821: pwm_get: pwmchip0.0: period=4266537 duty_cycle=0 polarity=0 enabled=1 err=0
> >         modprobe-203     [000] .....     0.938936: pwm_apply: pwmchip0.0: period=4266537 duty_cycle=0 polarity=0 enabled=1 err=0
> >         modprobe-203     [000] .....     0.938982: pwm_get: pwmchip0.0: period=4266537 duty_cycle=0 polarity=0 enabled=1 err=0
> >         modprobe-203     [000] .....     0.939274: pwm_apply: pwmchip0.0: period=5000000 duty_cycle=921458 polarity=0 enabled=1 err=0
> >         modprobe-203     [000] .....     0.939320: pwm_get: pwmchip0.0: period=4266537 duty_cycle=921355 polarity=0 enabled=1 err=0
> >         modprobe-203     [000] .....     0.939434: pwm_apply: pwmchip0.0: period=4266537 duty_cycle=921355 polarity=0 enabled=1 err=0
> >         modprobe-203     [000] .....     0.939480: pwm_get: pwmchip0.0: period=4266537 duty_cycle=921355 polarity=0 enabled=1 err=0
> >  systemd-backlig-724     [006] .....     9.079538: pwm_apply: pwmchip0.0: period=5000000 duty_cycle=5000000 polarity=0 enabled=1 err=0
> >  systemd-backlig-724     [006] .....     9.079585: pwm_get: pwmchip0.0: period=4266537 duty_cycle=4266537 polarity=0 enabled=1 err=0
> >  systemd-backlig-724     [006] .....     9.079698: pwm_apply: pwmchip0.0: period=4266537 duty_cycle=4266537 polarity=0 enabled=1 err=0
> >  systemd-backlig-724     [006] .....     9.079750: pwm_get: pwmchip0.0: period=4266537 duty_cycle=4266537 polarity=0 enabled=1 err=0
> > $
> > 
> > > 
> > > I didn't take a deeper dive in this driver combination, but here is a
> > > description about what *should* happen:
> > > 
> > > You're talking about period in MHz, the PWM abstraction uses
> > > nanoseconds. So your summary translated to the PWM wording is (to the
> > > best of my understanding):
> > > 
> > >   1. PWM backlight driver requests PWM with .period = 200 ns and
> > >      .duty_cycle = 200 ns.
> > > 
> > >   2. leds-qcom-lpg cannot pick 200 ns exactly and then chooses .period =
> > >      1000000000 / 4.26666 MHz = 234.375 ns
> > >      
> > >   3. leds-qcom-lpg then determines setting for requested .duty_cycle
> > >      based on .period = 200 ns which then ends up with something bogus.
> 
> The trace looks better than what I expected. 2. is fine here because it
> seems when Sebastian wrote "driver requests PWM with 5 MHz period" that
> meant period = 5000000 ns. That was then rounded down to 4266537 ns. And
> the request for period = 5000000 ns + duty_cycle = 5000000 ns was
> serviced by configuring period = 4266537 ns + duty_cycle = 4266537 ns.
> So that's a 100 % relative duty configuration as intended.
> 
> So just from the traces I don't spot a problem. Do these logs not match
> what actually happens on the signal?

What I do not get is why do we expect 2 pwm_get() and 2 pwm_apply()
calls each time ?

Need to dig a bit further.

But meanwhile, if the first pwm_apply() call goes all the way to the
provider, then the duty cycle value, when translated to the actual PWM
value that gets written to reg, will overflow. So this is what is wrong.
And this is what actually happens.

> 
> Best regards
> Uwe



