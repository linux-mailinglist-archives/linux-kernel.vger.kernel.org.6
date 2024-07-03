Return-Path: <linux-kernel+bounces-239396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 74CFD925FD3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 14:12:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9AC79B23848
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 11:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CD3716F827;
	Wed,  3 Jul 2024 11:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="HX+U0qEG"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F83213B5B2
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 11:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720007189; cv=none; b=bDxPsGVcZ4KJTZjaTVQ4hH7fMItFE8JXSapexYry6jJla5XtjopLTnLiKDi+6Mv4Ot/Oz7+IewE7kR0T63U5UcoxuMjRSsEdkm2oJunjigD/IGyR8wy6Rd8SOHDcAFiS5KD7ewNqii2HjXkpt0e1cnaNplttE5bFi2HdRXfwfiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720007189; c=relaxed/simple;
	bh=NVka7LdFhNak7mWiqRSHdImmzu3VSO08Qioh0A1K68M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dqh8cs24pwd9x9NY4J4oTpq/4zcW1lxxULKszjSWn0uRX7bNZUAIS+fWZnibmeDS5cBpabpjtlPciDbdI+ZzvgLUVT/UiXlF8NLsjCI7l2+q6jlNwobpooGbb1Rxiug83oIA5SmiyT/Ki4dXEsTA0dMXxKrWLpco2BZjcw1s6vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=HX+U0qEG; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-52e9944764fso509167e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 04:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1720007185; x=1720611985; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RD61GeZNS1NUH4+36WhC2nBOz/+c8ob3A4yfUrlEwiA=;
        b=HX+U0qEG48JoIFXazX9CrAPHb8b2CfUinMR6kIZlwTAw+VreX4tkJDACIRu+6mkb2/
         vT+R3fjz0Z5RoMA2Ein3o8IRrYpIpTi9bUtLpjFDyCWLUVd/WwOgH/LEcXEgODxOnBvl
         /iRdlRYJqSsa+V0EjRbsflugf6qNwbZYXKZtHRtqMouVP56ohMVWzdj1C6RAqTgX5k2C
         Unhbz2bcmn+4h/CgxE84ikLW4eJd9PT+ZkVjN2Vs0P3qJt1QAnVppRSKWyfGQXlxVZL9
         1h8W9AlkZnAn8GyNygjyBwny6e7alC8SGP81lTiBnQKUt0CSXei7ox38S6GiRiTHqNZO
         IHbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720007185; x=1720611985;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RD61GeZNS1NUH4+36WhC2nBOz/+c8ob3A4yfUrlEwiA=;
        b=oM4o2ICJ1kNMIjgw6KFZ5buyIzO6iJL8eVNcm8LmK+OGVgy5niZKOl9/srq/gnbFvm
         q9G5iiFKTiqAIYZl59eldnjCDTMhLYiPOhvtenMnMnXe/foOuAkGE72JhZDg8OpAbuJO
         jZ8qk4OiGoLjet/twlzpkNT/1f+/EwHLj0Kl2c8G7q2hSxNgraU1RToiM70TL72SdAKa
         E//5JSh2h0vq68cm8aDS4WFHQlkqRmkw6tVV0iW+TPmqmuw05yAE7n91qh6bnUNvjjaP
         fJ69P1OxLrd5MQDu0li1UL4txBlCM/L7kY1KMfhey5r26qan53qrEMNBztV47Sbvh1QV
         Hh/g==
X-Forwarded-Encrypted: i=1; AJvYcCXeUiZQJ6aO8uDiP31eOhsIgGI+vuqBZ/xIeihDwZrqmqVMNpzYUY4c1GGcikXdvlk0nGo9Kraj8hI4RT4+nAPuWRORB5JgNws8gHQ3
X-Gm-Message-State: AOJu0YyMmWEq6kMVEAaw2QpLUs+YR83lLL2t9Hc6UXgJhVl5KX0GLuND
	AmEZJzDH8OKSCzgUdzeH06X9ITD1Rlg57UXsIZ3bN65+98eQTrJzZytKBUTzq3U=
X-Google-Smtp-Source: AGHT+IEgElY0USQhWi09GiNFlgNu9bIuDIBzJHExs+cE+oIBcdpUxWBHzzbv9tDKsriVdm3zAvQwag==
X-Received: by 2002:a05:6512:10d4:b0:52c:890e:e8e7 with SMTP id 2adb3069b0e04-52e8270e724mr7211144e87.50.1720007184879;
        Wed, 03 Jul 2024 04:46:24 -0700 (PDT)
Received: from airbuntu (host81-157-90-255.range81-157.btcentralplus.com. [81.157.90.255])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36790a40391sm2100391f8f.54.2024.07.03.04.46.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 04:46:24 -0700 (PDT)
Date: Wed, 3 Jul 2024 12:46:23 +0100
From: Qais Yousef <qyousef@layalina.io>
To: Xuewen Yan <xuewen.yan94@gmail.com>
Cc: Xuewen Yan <xuewen.yan@unisoc.com>, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, mingo@redhat.com, peterz@infradead.org,
	juri.lelli@redhat.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
	christian.loehle@arm.com, vincent.donnefort@arm.com,
	ke.wang@unisoc.com, di.shen@unisoc.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 2/2] sched/fair: Use actual_cpu_capacity everywhere in
 util_fits_cpu()
Message-ID: <20240703114623.g7damgahld47kiah@airbuntu>
References: <20240624082011.4990-1-xuewen.yan@unisoc.com>
 <20240624082011.4990-3-xuewen.yan@unisoc.com>
 <20240628012832.37swdtxr4ds2kkp7@airbuntu>
 <CAB8ipk-p_vT3mq4+BD0AxzgsLiRxpAnHJ1QaTWr1t619JeaL+w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAB8ipk-p_vT3mq4+BD0AxzgsLiRxpAnHJ1QaTWr1t619JeaL+w@mail.gmail.com>

On 07/01/24 20:13, Xuewen Yan wrote:

> > >        *
> > >        * Only exception is for HW or cpufreq pressure since it has a direct impact
> > >        * on available OPP of the system.
> > > @@ -5011,7 +5011,7 @@ static inline int util_fits_cpu(unsigned long util,
> > >        * For uclamp_max, we can tolerate a drop in performance level as the
> > >        * goal is to cap the task. So it's okay if it's getting less.
> > >        */
> > > -     capacity_orig = arch_scale_cpu_capacity(cpu);
> > > +     capacity_actual = get_actual_cpu_capacity(cpu);
> > >
> > >       /*
> > >        * We want to force a task to fit a cpu as implied by uclamp_max.
> > > @@ -5039,7 +5039,7 @@ static inline int util_fits_cpu(unsigned long util,
> > >        *     uclamp_max request.
> > >        *
> > >        *   which is what we're enforcing here. A task always fits if
> > > -      *   uclamp_max <= capacity_orig. But when uclamp_max > capacity_orig,
> > > +      *   uclamp_max <= capacity_actual. But when uclamp_max > capacity_actual,
> > >        *   the normal upmigration rules should withhold still.
> > >        *
> > >        *   Only exception is when we are on max capacity, then we need to be
> > > @@ -5050,8 +5050,8 @@ static inline int util_fits_cpu(unsigned long util,
> > >        *     2. The system is being saturated when we're operating near
> > >        *        max capacity, it doesn't make sense to block overutilized.
> > >        */
> > > -     uclamp_max_fits = (capacity_orig == SCHED_CAPACITY_SCALE) && (uclamp_max == SCHED_CAPACITY_SCALE);
> > > -     uclamp_max_fits = !uclamp_max_fits && (uclamp_max <= capacity_orig);
> > > +     uclamp_max_fits = (capacity_actual == SCHED_CAPACITY_SCALE) && (uclamp_max == SCHED_CAPACITY_SCALE);
> >
> > We should use capacity_orig here. We are checking if the CPU is the max
> > capacity CPU.
> 
> Maybe we could remove the uclamp_max_fits = (capacity_orig ==
> SCHED_CAPACITY_SCALE) && (uclamp_max == SCHED_CAPACITY_SCALE);
> and just judge the uclamp_max <= capacity_actual?
> 
> -     uclamp_max_fits = (capacity_orig == SCHED_CAPACITY_SCALE) &&
> (uclamp_max == SCHED_CAPACITY_SCALE);
> -     uclamp_max_fits = !uclamp_max_fits && (uclamp_max <= capacity_orig);
> +     uclamp_max_fits =  (uclamp_max <= capacity_actual);

If capacity_orig = 1024, capacity_actual = 1024, uclamp_max = 1024 (which is
the common case), then overutilized will never trigger for big CPU, no?

We can't 'force' fit a task on the biggest core, and fits_capacity() should be
our sole judge here if we fit or not.

