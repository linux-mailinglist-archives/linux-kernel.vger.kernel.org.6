Return-Path: <linux-kernel+bounces-241757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63498927F35
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 01:57:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 863331C22694
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 23:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A2551448FA;
	Thu,  4 Jul 2024 23:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="Nec+0hVc"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E69614388D
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 23:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720137418; cv=none; b=koLsIGYCutC3DhYgECurvLzJihtFEzYY+TMF2ye8yFRXQ9dRsBP000vI0tdq8QOYsnZnjnsHy1+1f8gDGqCRNsklLK072TEQsWIgWTbJIyUCLemwXqNHKreIXLdVD4INDBiIju2h817qhweQAo+HTx7Hh+8Tx1hXwXKk/hwxPIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720137418; c=relaxed/simple;
	bh=9jE/BMzZml7g8GG5sf31ueS5tR+gpHmSQURpUULv2po=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VaH20aFQB6IL4qtY27APlNwWA6eezL6ybHdLvxr0E6FVEPSTVpZRHhFIxdStcyQjJxung1AwulEPc7dGAz5MilwuRpAaXyUqK5eyw2VEHB0c6+uBgjaRbdKBXsPCXKQdAeK5sUw3fMmSmQQcZ5JSa2FcFzjCLhNMjJAqQjly0t4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=Nec+0hVc; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-36799fb93baso777655f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2024 16:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1720137414; x=1720742214; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ift/djFAd5vR5fDXwQVGEOi05OM6XhZgE+X7k3Z5d5Y=;
        b=Nec+0hVc1b6FxhBZVfE8A1JYgFVTwXmeK3tElqcJH5nctg7Fhz3CiJxZY1sNRDNoRc
         Bk5p6DbrhPt1qNziqHdtxM3nrhYzDPrnpIzdkrG39knOMkPRO9+gmOgUf4e/SFHvd3ko
         x/7QdoF9uwBgDJfPNFwVBwtqYfH7wmpOGXd2Khf1kiQ/Waw3Fe7LvBidpg/hnCxoTB3e
         E7bO2P3RhcsHFYsX2LpkqYN8OOp2J7TFp5kMA54VKYXxoVfmxWyjFGFjpZWaHu9j8rHv
         qnKeWtHf5luJRmDRsPRDzXe5U/s/5Vn3qLs9Rg1zWnLWOq5aW39ozoJPpXJVrN8Llc+B
         KrxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720137414; x=1720742214;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ift/djFAd5vR5fDXwQVGEOi05OM6XhZgE+X7k3Z5d5Y=;
        b=Ef8K98itWXbiT6UytJPD2Xy52a1R76nXdSeGZ8mS8qFag/HJKS1Ac50w/79Vw3Xjly
         hn9USdLiP6f1CjQJP9/PW0SmElwIuFX6jsg+YkzYTV6gNQRZvo9RHM6duq/2zKjMgue4
         Z/SoFpdp7UyTD1T2jiJgPXLjh5Rr7XxQAdYCNIcCFxnmNbdaASS1YAtQagBz6Y36tSGU
         Nduaz7vHwtSHausWP1CxrdMcA/knPUlgAO0Fig7NKvNB2gi8qarpyRvpOfKQqptLDdG+
         CvqA7oB37XNcB+R3e4xW4Czj34NPHHtJrVZZe7F6iIvG4WXrZq2X/JfI6U4dd36XYYUu
         sPPg==
X-Forwarded-Encrypted: i=1; AJvYcCVleJrTBktjOaDwWYJ3zdeN5uIo5eEKiAHoXp64Q/VFWpsd4cYGNfBQsn6f9Zcj5WLLwb99ZaLqUBbr9zhTCxnRebUAcpmEpj1/s0fd
X-Gm-Message-State: AOJu0YyiaVNnehPHn+9rgw9LuFzBQxyK4JMHCbFOA3mXvC0Gr+p8txLM
	APl3i85pH1++V63r5e143unKD4NTFA+2PIE6qRlHHKZRtyuS1o2+Y3eTMdgSECg=
X-Google-Smtp-Source: AGHT+IFc4VCm6W4IwJNHOTpzBy7YXLjHKtDjGG4rlCFU3YDxRXyjDcdjChuUiuTGN/rU7fXWxvUVfw==
X-Received: by 2002:a05:6000:1845:b0:366:e801:3177 with SMTP id ffacd0b85a97d-3679dd3102emr2475582f8f.13.1720137414482;
        Thu, 04 Jul 2024 16:56:54 -0700 (PDT)
Received: from airbuntu (host81-157-90-255.range81-157.btcentralplus.com. [81.157.90.255])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4264a251ef5sm40003985e9.36.2024.07.04.16.56.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 16:56:54 -0700 (PDT)
Date: Fri, 5 Jul 2024 00:56:52 +0100
From: Qais Yousef <qyousef@layalina.io>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Xuewen Yan <xuewen.yan@unisoc.com>, dietmar.eggemann@arm.com,
	mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	bristot@redhat.com, vschneid@redhat.com, christian.loehle@arm.com,
	vincent.donnefort@arm.com, ke.wang@unisoc.com, di.shen@unisoc.com,
	xuewen.yan94@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 2/2] sched/fair: Use actual_cpu_capacity everywhere in
 util_fits_cpu()
Message-ID: <20240704235652.n2wtpwck43umh4dq@airbuntu>
References: <20240624082011.4990-1-xuewen.yan@unisoc.com>
 <20240624082011.4990-3-xuewen.yan@unisoc.com>
 <20240628012832.37swdtxr4ds2kkp7@airbuntu>
 <CAKfTPtALDtnbPmq4401oLKzcEDurLKuCyqyNKOb1oYLAVJ2P4A@mail.gmail.com>
 <20240703115407.y6tjelkpq5njkzjy@airbuntu>
 <CAKfTPtCNEa+pAbo1br_1SDSn8=x67YMCi_jytpjUMHv7a9xMKA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKfTPtCNEa+pAbo1br_1SDSn8=x67YMCi_jytpjUMHv7a9xMKA@mail.gmail.com>

On 07/03/24 16:54, Vincent Guittot wrote:
> On Wed, 3 Jul 2024 at 13:54, Qais Yousef <qyousef@layalina.io> wrote:
> >
> > On 07/02/24 15:25, Vincent Guittot wrote:
> >
> > > > >        *
> > > > >        * Only exception is for HW or cpufreq pressure since it has a direct impact
> > > > >        * on available OPP of the system.
> > > > > @@ -5011,7 +5011,7 @@ static inline int util_fits_cpu(unsigned long util,
> > > > >        * For uclamp_max, we can tolerate a drop in performance level as the
> > > > >        * goal is to cap the task. So it's okay if it's getting less.
> > > > >        */
> > > > > -     capacity_orig = arch_scale_cpu_capacity(cpu);
> > > > > +     capacity_actual = get_actual_cpu_capacity(cpu);
> > > > >
> > > > >       /*
> > > > >        * We want to force a task to fit a cpu as implied by uclamp_max.
> > > > > @@ -5039,7 +5039,7 @@ static inline int util_fits_cpu(unsigned long util,
> > > > >        *     uclamp_max request.
> > > > >        *
> > > > >        *   which is what we're enforcing here. A task always fits if
> > > > > -      *   uclamp_max <= capacity_orig. But when uclamp_max > capacity_orig,
> > > > > +      *   uclamp_max <= capacity_actual. But when uclamp_max > capacity_actual,
> > > > >        *   the normal upmigration rules should withhold still.
> > > > >        *
> > > > >        *   Only exception is when we are on max capacity, then we need to be
> > > > > @@ -5050,8 +5050,8 @@ static inline int util_fits_cpu(unsigned long util,
> > > > >        *     2. The system is being saturated when we're operating near
> > > > >        *        max capacity, it doesn't make sense to block overutilized.
> > > > >        */
> > > > > -     uclamp_max_fits = (capacity_orig == SCHED_CAPACITY_SCALE) && (uclamp_max == SCHED_CAPACITY_SCALE);
> > > > > -     uclamp_max_fits = !uclamp_max_fits && (uclamp_max <= capacity_orig);
> > > > > +     uclamp_max_fits = (capacity_actual == SCHED_CAPACITY_SCALE) && (uclamp_max == SCHED_CAPACITY_SCALE);
> > > >
> > > > We should use capacity_orig here. We are checking if the CPU is the max
> > > > capacity CPU.
> > >
> > > I was also wondering what would be the best choice there. If we
> > > consider that we have only one performance domain with all max
> > > capacity cpus then I agree that we should keep capacity_orig as we
> > > can't find a better cpu that would fit. But is it always true that all
> > > max cpu are tied to the same perf domain ?
> >
> > Hmm I could be not thinking straight today. But the purpose of this check is to
> > ensure overutilized can trigger for the common case where a task will always
> > fit the max capacity cpu (whether it's on a single pd or multiple ones). For
> > that corner case fits_capacity() should be the only fitness check otherwise
> > overutilized will never trigger by default.
> 
> Ok, so I messed up several use cases but in fact both are similar ...
> 
> if capacity_actual != SCHED_CAPACITY_SCALE and uclamp_max ==
> SCHED_CAPACITY_SCALE
> then uclamp_max_fits = (capacity_actual == SCHED_CAPACITY_SCALE) &&
> (uclamp_max == SCHED_CAPACITY_SCALE) is false
> and uclamp_max_fits = !uclamp_max_fits && (uclamp_max <=
> capacity_actual); is also false because (uclamp_max <=
> capacity_actual) is always false
> 
> if capacity_actual == SCHED_CAPACITY_SCALE and uclamp_max ==
> SCHED_CAPACITY_SCALE
> then we are the same as with capacity_orig

Right. The condition is becoming less readable, but you're right it doesn't
change functionality.

Xuewen, could you put something in the commit message please to remind us in
the future that we thought about this and it is fine?

Thanks!

--
Qais Yousef

