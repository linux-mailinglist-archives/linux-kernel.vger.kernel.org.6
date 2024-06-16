Return-Path: <linux-kernel+bounces-216493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6515C90A00C
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 23:54:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6287281D64
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 21:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C67C76E60E;
	Sun, 16 Jun 2024 21:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="02QoeJRH"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B9B62B2CF
	for <linux-kernel@vger.kernel.org>; Sun, 16 Jun 2024 21:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718574871; cv=none; b=Rf2Kjy/ZEHfyKmNCCCMMhKwoY05RmTWed+3uZAFngrSSJOChQJQhxfMiGay7/SEed4RL/ssw6kRiV8i7CEvU5oawgK/cXvdGruFAw4qauveaYxjtPUN/r/TObTIP1L++2rHH8G9aUAb+n0azw1KaAd8ngihqFRRB5oVkAwzdRo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718574871; c=relaxed/simple;
	bh=0BtYdNmj4tgibhr+X25IskYgP4z0Rb9KC7CYpn/A8aI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MCBi1A3685JI33KkBI/aAVhR6GBaVPeSsW7EaYtdUQ40t8AB6RJqMuO/Jg7dr3lvBBdI6xzCcZH1uKS+kIMu8yAH4QOcnaiQZjs/VGgDPWaEBH+BANRKbxgnpuCF2sOxCJruxDrUd9yp3ob9QHTAO1CIrxAaMUlbk5tC3MCBxP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=02QoeJRH; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-35f27eed98aso3058679f8f.2
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jun 2024 14:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1718574867; x=1719179667; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Va7jxWnDAAKQwyBwWcGtGRPq0HJsT58aAXHG+7OBweM=;
        b=02QoeJRHA/6Hw9C8iNK2Tq/3n/ZIJ94GzYmJW2JkiNB7XZHKSmlyptpkuIMpgAEZLs
         yVJUAeurcIqMUGfJQRiBOa6YNWHUcURSvUCBABJzrkEbLflNABxZ+Noy4G1kwNpqo9UH
         pT9PQSphpx2K36hnYaK72hbBG6mjGqdphAKar4JgxXUH+S9QIF781x51rhoxoElocrNp
         xuynuFrBoU73k80x03sTOMO7CEjWEcFk9VMb0r3SlZ3+63XmECBsFfcFic4W5BKkw71R
         sW0bsACVHcXVKVcpRh36hcEXxt60wZX4LuGnyC/Le531mevkQF4ahfL9BtNV0Jeu8Xo0
         Vd1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718574867; x=1719179667;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Va7jxWnDAAKQwyBwWcGtGRPq0HJsT58aAXHG+7OBweM=;
        b=xKqnzvZiA8SLZhEiXx3YvYUk1BRaRzy2RjKrL0d18/RPt4tZmz67JvZ8ETeIEah4oh
         fbJSCIlnDaHpdeig1nT3KElG9+0ntmzSGUQdhSkpJxT85yrh2XP7XExvgbXal8OBGfpj
         t86Tt8USF5PgcWN9jDR+GZj+NHPu8g7axw4gqrLRp011QzFb+WSwKLWC+LBzdUEXz1IW
         BbzyqD91vTyn5pk7orKODbp5kf+w8/fkSff1yEiUtlEDZ21z9Cx8fVjfWpNH3PEEuCru
         SuAlLVciKZsjHqIxwk5pzkCwoiqS+HUvMeVzF/9LXCSbhNlKrxxkJvLnFixTm5YZw80z
         o9nA==
X-Forwarded-Encrypted: i=1; AJvYcCVVGWDCdVbj6eZ6UsT3kViBEzLe08ZKY15UP3PqbbaeYudZQbGmDbgaQe5nO2Q8dRgpf0LgJguzXxooWXNXLxDFmrxNkFedLaF7y3M+
X-Gm-Message-State: AOJu0YzfhQfkUdjam+gMtq1tnYDiz1S11UOZomBgY+ldYCoFi1ycPWfp
	ulA/GMuzIbfSy8N7TFGTDM44Fz1i6glWP8U0Wlm7+rISFLsk5+QXCBHt2L4RLyKDv3RWsXf9QZL
	ua2s=
X-Google-Smtp-Source: AGHT+IEU7um6AxXVHOmLV8ehOKCW5eJRSPwONaIvfB1JzmEuC6EgmofL3tqLOy8ox+3sxwQEThHjpA==
X-Received: by 2002:a05:6000:d51:b0:35f:2261:4625 with SMTP id ffacd0b85a97d-3607a781819mr5996581f8f.61.1718574867557;
        Sun, 16 Jun 2024 14:54:27 -0700 (PDT)
Received: from airbuntu (host81-157-90-255.range81-157.btcentralplus.com. [81.157.90.255])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-360750ad216sm10437041f8f.57.2024.06.16.14.54.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Jun 2024 14:54:27 -0700 (PDT)
Date: Sun, 16 Jun 2024 22:54:26 +0100
From: Qais Yousef <qyousef@layalina.io>
To: Christian Loehle <christian.loehle@arm.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	rafael@kernel.org, vincent.guittot@linaro.org, peterz@infradead.org,
	daniel.lezcano@linaro.org, anna-maria@linutronix.de,
	kajetan.puchalski@arm.com, lukasz.luba@arm.com,
	dietmar.eggemann@arm.com
Subject: Re: [PATCH 1/6] cpuidle: teo: Increase util-threshold
Message-ID: <20240616215426.wwv5o2gxneiugq46@airbuntu>
References: <20240606090050.327614-1-christian.loehle@arm.com>
 <20240606090050.327614-2-christian.loehle@arm.com>
 <20240609224701.pc6om2o5ep6btywe@airbuntu>
 <569b7923-d7ba-49a9-a88d-906f44903d20@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <569b7923-d7ba-49a9-a88d-906f44903d20@arm.com>

On 06/10/24 10:11, Christian Loehle wrote:
> On 6/9/24 23:47, Qais Yousef wrote:
> > On 06/06/24 10:00, Christian Loehle wrote:
> >> Increase the util-threshold by a lot as it was low enough for some
> >> minor load to always be active, especially on smaller CPUs.
> >>
> >> For small cap CPUs (Pixel6) the util threshold is as low as 1.
> >> For CPUs of capacity <64 it is 0. So ensure it is at a minimum, too.
> >>
> >> Fixes: 9ce0f7c4bc64 ("cpuidle: teo: Introduce util-awareness")
> >> Reported-by: Qais Yousef <qyousef@layalina.io>
> >> Reported-by: Vincent Guittot <vincent.guittot@linaro.org>
> >> Suggested-by: Kajetan Puchalski <kajetan.puchalski@arm.com>
> >> Signed-off-by: Christian Loehle <christian.loehle@arm.com>
> >> ---
> >>  drivers/cpuidle/governors/teo.c | 11 +++++------
> >>  1 file changed, 5 insertions(+), 6 deletions(-)
> >>
> >> diff --git a/drivers/cpuidle/governors/teo.c b/drivers/cpuidle/governors/teo.c
> >> index 7244f71c59c5..45f43e2ee02d 100644
> >> --- a/drivers/cpuidle/governors/teo.c
> >> +++ b/drivers/cpuidle/governors/teo.c
> >> @@ -146,13 +146,11 @@
> >>   * The number of bits to shift the CPU's capacity by in order to determine
> >>   * the utilized threshold.
> >>   *
> >> - * 6 was chosen based on testing as the number that achieved the best balance
> >> - * of power and performance on average.
> >> - *
> >>   * The resulting threshold is high enough to not be triggered by background
> >> - * noise and low enough to react quickly when activity starts to ramp up.
> >> + * noise.
> >>   */
> >> -#define UTIL_THRESHOLD_SHIFT 6
> >> +#define UTIL_THRESHOLD_SHIFT 2
> >> +#define UTIL_THRESHOLD_MIN 50
> >>  
> >>  /*
> >>   * The PULSE value is added to metrics when they grow and the DECAY_SHIFT value
> >> @@ -671,7 +669,8 @@ static int teo_enable_device(struct cpuidle_driver *drv,
> >>  	int i;
> >>  
> >>  	memset(cpu_data, 0, sizeof(*cpu_data));
> >> -	cpu_data->util_threshold = max_capacity >> UTIL_THRESHOLD_SHIFT;
> >> +	cpu_data->util_threshold = max(UTIL_THRESHOLD_MIN,
> >> +				max_capacity >> UTIL_THRESHOLD_SHIFT);
> > 
> > Thanks for trying to fix this. But I am afraid this is not a solution. There's
> > no magic number that can truly work here - we tried. As I tried to explain
> > before, a higher util value doesn't mean long idle time is unlikely. And
> > blocked load can cause problems where a decay can take too long.
> > 
> > We are following up with the suggestions I have thrown back then and we'll
> > share results if anything actually works.
> 
> Namely watching increase / decrease of utilization?

We still have to explore and see. I think we need multiple cues if we are to
try to predict the likelihood of a task waking up sooner than min_residency.
And be scalable across workloads/systems.

> I think you would have to watch at least a couple of values before entering such
> a logic and at that point the intercepts logic will handle it anyway.
> Furthermore IMO we should be wary about introducing any state in teo that persists
> across calls if not absolutely necessary (like intercept-detection) as it really
> makes teo much less predictable.
> 
> > 
> > For now, I think a revert is more appropriate. There was some perf benefit, but
> > the power regressions were bad and there's no threshold value that actually
> > works. The thresholding concept itself is incorrect and flawed - it seemed the
> > correct thing back then, yes. But in a hindsight now it doesn't work.
> 
> Unfortunate :/
> OK. I'll do some more testing with that, too. From what I can see a revert wouldn't
> have terrible fallout with the series altogether, so I might just change this for
> v2 and drop 2/6.
> 
> Kind Regards,
> Christian
> 

