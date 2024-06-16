Return-Path: <linux-kernel+bounces-216491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F410B90A004
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 23:51:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F2F9281D18
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 21:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C82C86BFAA;
	Sun, 16 Jun 2024 21:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="aKtZZhvR"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830372B2CF
	for <linux-kernel@vger.kernel.org>; Sun, 16 Jun 2024 21:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718574662; cv=none; b=ehv2nkLlBKll+rR6hdC2vuon3xsW/WOYZq3iS9zFf39RAYN3DPA1o4n29LcoRxoJSixYfy/oeN0Mgxez6gNiT/I6QdYJm3y6NymbRBQmPiJUTrkBoO5nW48zrUEdZ9hzkVHUoSnLilLkzNb08Z6rWxc+aRjWd3wwbdtr0wsGtn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718574662; c=relaxed/simple;
	bh=Ff5Nf3si23fZlMuJjIdH3xse7cb4ambxMNDGSNWT4YE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sD0iS3mXGTC3+Hq1wAvWl/23pKbcT3vF3uWwPEQ46XDrRYIEOxiyjpVcJwRtCprFV5gkoGr30vyyxS0rjxqX6HSQCq7DF7q+g0Nqk4genZs5ln6heM/jIBmwZ56Y/8CpbupOKmRYxdsFYDjPlw8Ed49fxB5I4gG2skuieNdYmXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=aKtZZhvR; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4218314a6c7so32169125e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jun 2024 14:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1718574658; x=1719179458; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IljrA2nKChPYotd2lYx0rCpYizmmH1C3znB7hDHQdmQ=;
        b=aKtZZhvRSlHp4RNmoH9gfhSvU+j7hDiby8qIKgIMMT5eFwvMY5PiV3EA1jXuArtsYN
         LuztYH9h30fDYHCJRxG7VcTT+uBzMDi3C5XtYYls19BUZa16W5xuqCtwSLwB4wplNl2m
         dRRLcjqlEHLFNiUG8WZBlkj2jzE3pUIpjYAozgWM7ZiPG2Ryp8NIihTXfwg9KHDLtYIw
         OwsDnih5RiQ8aCGcElOe9xdI9m8QlfceGldrIVYPq2EE8NTvtI1wynusiOeCJx8ysZQ/
         Q6bTnwaT8ETUgjUFyUVPkcUNVCYvrPDmQyFa2Gr1X8D1l2daiBdHZBU5ikcGzZH2zUtp
         Kutw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718574658; x=1719179458;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IljrA2nKChPYotd2lYx0rCpYizmmH1C3znB7hDHQdmQ=;
        b=WHWMxknB1kGNYfBAptFVQh0uVBE/JuOI4bDnL23IsE0KxynRjJzDj6KP+g1JibY9DQ
         JYfNzqOKkh84FS6fnPHUw+9B/m/S59mGHOGZmyAdoDIsDvnNAwaS/+BjFPmfyWz+CIjt
         UZDmGiFOAoSyku6w07x+rZSq3kM9EmzAMrDl1Mj2V2nyx39duqyLHi/dwk18neDtz3vS
         IKMthCzKZ57FcOAwGjtT5lCuKEU+rFjONoq+IveBB3Uk/uRvrqm87Zu/AQGvF2xz3tHF
         aDyyWejrz6W3N2z+0RBSBINjkUSuMWZYSr7rH8DywjG/xe15bF77Dmh5klxg91XTCw0m
         oYug==
X-Forwarded-Encrypted: i=1; AJvYcCX+fWfi2THqp3mS5ayK/jsFxAhYvluHLSxaoeyOy3TxIQLfHTVYnnHXoLyWTRQ/dmEjcjfEj2fYMeSmPpl6cUem6QbR64rLMRZQqPOw
X-Gm-Message-State: AOJu0Yz9tMjyh3NiR+2YqaZhtoJ/5c9hb20c2yBcVcQPOtYNOYQ3SaN7
	/S/doePx1uoffRsAGYUVbQRzALTVPZdQ0BzYDqkCvP1A4nWWnI6pQ/BqEaNtvew=
X-Google-Smtp-Source: AGHT+IEhOVfm1xqBB6bEfl8xv+khfXbF4JIF3FAXWImSV616kpBP4isHNIoQ737Gth+07OYlZzoCjw==
X-Received: by 2002:a05:600c:1c23:b0:421:8429:79ba with SMTP id 5b1f17b1804b1-423047dfc95mr73550565e9.0.1718574657768;
        Sun, 16 Jun 2024 14:50:57 -0700 (PDT)
Received: from airbuntu (host81-157-90-255.range81-157.btcentralplus.com. [81.157.90.255])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422f6419e38sm142979805e9.39.2024.06.16.14.50.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Jun 2024 14:50:57 -0700 (PDT)
Date: Sun, 16 Jun 2024 22:50:56 +0100
From: Qais Yousef <qyousef@layalina.io>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Christian Loehle <christian.loehle@arm.com>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, rafael@kernel.org,
	vincent.guittot@linaro.org, peterz@infradead.org,
	daniel.lezcano@linaro.org, anna-maria@linutronix.de,
	kajetan.puchalski@arm.com, lukasz.luba@arm.com,
	dietmar.eggemann@arm.com
Subject: Re: [PATCH 1/6] cpuidle: teo: Increase util-threshold
Message-ID: <20240616215056.g4rnb4o5o7gwpcez@airbuntu>
References: <20240606090050.327614-1-christian.loehle@arm.com>
 <20240606090050.327614-2-christian.loehle@arm.com>
 <20240609224701.pc6om2o5ep6btywe@airbuntu>
 <CAPDyKFoHc6Zcg8i-y3HxUp0=S_N2GhmKcT0w2e-NkzR498mp2Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPDyKFoHc6Zcg8i-y3HxUp0=S_N2GhmKcT0w2e-NkzR498mp2Q@mail.gmail.com>

On 06/10/24 11:57, Ulf Hansson wrote:
> On Mon, 10 Jun 2024 at 00:47, Qais Yousef <qyousef@layalina.io> wrote:
> >
> > On 06/06/24 10:00, Christian Loehle wrote:
> > > Increase the util-threshold by a lot as it was low enough for some
> > > minor load to always be active, especially on smaller CPUs.
> > >
> > > For small cap CPUs (Pixel6) the util threshold is as low as 1.
> > > For CPUs of capacity <64 it is 0. So ensure it is at a minimum, too.
> > >
> > > Fixes: 9ce0f7c4bc64 ("cpuidle: teo: Introduce util-awareness")
> > > Reported-by: Qais Yousef <qyousef@layalina.io>
> > > Reported-by: Vincent Guittot <vincent.guittot@linaro.org>
> > > Suggested-by: Kajetan Puchalski <kajetan.puchalski@arm.com>
> > > Signed-off-by: Christian Loehle <christian.loehle@arm.com>
> > > ---
> > >  drivers/cpuidle/governors/teo.c | 11 +++++------
> > >  1 file changed, 5 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/drivers/cpuidle/governors/teo.c b/drivers/cpuidle/governors/teo.c
> > > index 7244f71c59c5..45f43e2ee02d 100644
> > > --- a/drivers/cpuidle/governors/teo.c
> > > +++ b/drivers/cpuidle/governors/teo.c
> > > @@ -146,13 +146,11 @@
> > >   * The number of bits to shift the CPU's capacity by in order to determine
> > >   * the utilized threshold.
> > >   *
> > > - * 6 was chosen based on testing as the number that achieved the best balance
> > > - * of power and performance on average.
> > > - *
> > >   * The resulting threshold is high enough to not be triggered by background
> > > - * noise and low enough to react quickly when activity starts to ramp up.
> > > + * noise.
> > >   */
> > > -#define UTIL_THRESHOLD_SHIFT 6
> > > +#define UTIL_THRESHOLD_SHIFT 2
> > > +#define UTIL_THRESHOLD_MIN 50
> > >
> > >  /*
> > >   * The PULSE value is added to metrics when they grow and the DECAY_SHIFT value
> > > @@ -671,7 +669,8 @@ static int teo_enable_device(struct cpuidle_driver *drv,
> > >       int i;
> > >
> > >       memset(cpu_data, 0, sizeof(*cpu_data));
> > > -     cpu_data->util_threshold = max_capacity >> UTIL_THRESHOLD_SHIFT;
> > > +     cpu_data->util_threshold = max(UTIL_THRESHOLD_MIN,
> > > +                             max_capacity >> UTIL_THRESHOLD_SHIFT);
> >
> > Thanks for trying to fix this. But I am afraid this is not a solution. There's
> > no magic number that can truly work here - we tried. As I tried to explain
> > before, a higher util value doesn't mean long idle time is unlikely. And
> > blocked load can cause problems where a decay can take too long.
> >
> > We are following up with the suggestions I have thrown back then and we'll
> > share results if anything actually works.
> >
> > For now, I think a revert is more appropriate. There was some perf benefit, but
> > the power regressions were bad and there's no threshold value that actually
> > works. The thresholding concept itself is incorrect and flawed - it seemed the
> > correct thing back then, yes. But in a hindsight now it doesn't work.
> >
> 
> For the record, I fully agree with the above. A revert seems to be the
> best option in my opinion too.
> 
> Besides for the above reasons; when using cpuidle-psci with PSCI OSI
> mode, the approach leads to disabling *all* of cluster's idle-states
> too, as those aren't even visible for the teo governor. I am sure,
> that was not the intent with commit 9ce0f7c4bc64.

+2

