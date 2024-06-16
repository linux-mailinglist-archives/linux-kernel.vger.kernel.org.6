Return-Path: <linux-kernel+bounces-216520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 17E9490A07F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 00:20:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 313921C20978
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 22:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B8A46F06F;
	Sun, 16 Jun 2024 22:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="UOgpGTVk"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE5CE1C2AF
	for <linux-kernel@vger.kernel.org>; Sun, 16 Jun 2024 22:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718576408; cv=none; b=uAgkRsYySaA2J7lLVCU3tp3NU0mIXFW1Y2Wlh4PA8C7/GhVmdPpIJuwYwlk5la2F+Ej5PRI6xekgOMZ6fifYR75p15e0YN8UJbsg3BZNyT/OcdO9Lx0ShHtdj1QB44C2cUCjO+D77wy0w0u8Nq+cWHiXSdRNVHcj92Yl+xYyslo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718576408; c=relaxed/simple;
	bh=YUamIrym1mCsYNUdvrncN7Xw/7gDWYv3jn3J7JIMLC0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=faGsVJQlrtg0rqetaJdOLkyuPIL289sNMquVCrWCLDxlokBB2aoRhbPrT/ITnaSZmnzbjPkZ/nILFDudj944mFKP9YKQpjHCpKws0LdmX91I5mKjPZUazZNu+BbGFUEcmHoV52R+xGRlJ5DkBnlJxl0MLEq+Xp50blnKcgiSm1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=UOgpGTVk; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-35f236a563cso3109499f8f.2
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jun 2024 15:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1718576405; x=1719181205; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zdKvlJR9sN12F6cVt64hUhXMOC68cH4ScNBqHXrp1s0=;
        b=UOgpGTVkB5TiOdBcI8b2QYrjSfxnozktnlBGFhxLOBzo3IBnyxOlktvst3x/KQ9rjB
         WP/prK5FE0w8ZTaNbgLp9oKtH0lD+lPBWzwNCm2moJIt5p2GJUDNT6L9o1zNV62mpm9b
         /ba36X3KnaQ+xY9+ZbXPVoF7Dx7/Iez2jqgeCNpDdctFSxiVhdZsrE7ajdZLay+BB3zg
         0B1DBxavPQczLPU6YU6vQf9gx541le1YpZ3lI6K8UYNM4RbKvJ6tcAATOyDHAp5XZv/n
         AFQYjU3P7+bUuIGovHn5XaHl9o0AAFqbavakVPqhKQOYEq0cFT/4SaVYUPBoOKrSDTb2
         DjSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718576405; x=1719181205;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zdKvlJR9sN12F6cVt64hUhXMOC68cH4ScNBqHXrp1s0=;
        b=Bjhr2TFP4uuoXmDe7Z+bHZGvzWn2+dhpmQ1hhDCkcRobPk8Wlabe4YenTn7jabBX0u
         wfXYukxQxPfFAj22P0tRiQvJXyJbvoRisEOmRBAPqid12zR/vdP2fesVUR/DgJttg4Zf
         tPMusZ0HQtEY+tJHFkmBzjuWjLuzE+VVSYhn/fcr8YUmhjA3Pf/SCNqhp1cWD/xYvojd
         tfvLtG6+AIHYsoR7ailc3l5GcPaeVchgQ4CCJyR0IzG8vBajMGK6qZOprlYfxN7U+AQX
         bC3IeC5dAACb+rDPqfAFAMqpyBLdaiQdVqwQzfab957W8eYTDUtscuxJ4GxymzHxuFXG
         DmyA==
X-Forwarded-Encrypted: i=1; AJvYcCVmqLBMUoOsrtAqGAZBbN8GOWoBnV0Q6Z6WYWxhLDg9Ue0YyONPC1r6mr+50widdNdT29A0BZcbweEZvg7CNgwHo1MhZqv2W8E/YQzY
X-Gm-Message-State: AOJu0YwppNbAc6nA+mul0+FtHa+WBogorVx6HOthu8ifqCDEBCpRWdzG
	mDQjX2y87ofS/QauDFKwrEwhtvDyVclU23skHhnRC7XAr0qY/AWcEi6Y7Fv406Q=
X-Google-Smtp-Source: AGHT+IFtwWGzKXOQH5pH16LaKT2KEGeHx/OIGWNKtj8yUGdx4lHVcEJgc2c5blPRQd2aPCw3a/VifA==
X-Received: by 2002:adf:fa8a:0:b0:360:728d:842b with SMTP id ffacd0b85a97d-3607a77fa69mr5754180f8f.52.1718576404986;
        Sun, 16 Jun 2024 15:20:04 -0700 (PDT)
Received: from airbuntu (host81-157-90-255.range81-157.btcentralplus.com. [81.157.90.255])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36075093d41sm10550967f8f.16.2024.06.16.15.20.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Jun 2024 15:20:04 -0700 (PDT)
Date: Sun, 16 Jun 2024 23:20:03 +0100
From: Qais Yousef <qyousef@layalina.io>
To: Xuewen Yan <xuewen.yan94@gmail.com>
Cc: Xuewen Yan <xuewen.yan@unisoc.com>, vincent.guittot@linaro.org,
	mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
	vincent.donnefort@arm.com, ke.wang@unisoc.com,
	linux-kernel@vger.kernel.org, christian.loehle@arm.com
Subject: Re: [PATCH] sched/fair: Prevent cpu_busy_time from exceeding
 actual_cpu_capacity
Message-ID: <20240616222003.agcz5osb2nkli75h@airbuntu>
References: <20240606070645.3295-1-xuewen.yan@unisoc.com>
 <20240609225520.6gnmx2wjhxghcxfo@airbuntu>
 <CAB8ipk-9EVgyii3SGH9GOA3Mb5oMQdn1_vLVrCsSn1FmSQieOw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAB8ipk-9EVgyii3SGH9GOA3Mb5oMQdn1_vLVrCsSn1FmSQieOw@mail.gmail.com>

On 06/12/24 16:11, Xuewen Yan wrote:
> Hi Qais
> 
> On Mon, Jun 10, 2024 at 6:55 AM Qais Yousef <qyousef@layalina.io> wrote:
> >
> > On 06/06/24 15:06, Xuewen Yan wrote:
> > > Because the effective_cpu_util() would return a util which
> > > maybe bigger than the actual_cpu_capacity, this could cause
> > > the pd_busy_time calculation errors.
> > > So clamp the cpu_busy_time with the eenv->cpu_cap, which is
> > > the actual_cpu_capacity.
> >
> > I actually think capping by pd_cap is something we should remove. Saturated
> > systems aren't calculated properly especially when uclamp_max is used.
> >
> > But this might a bigger change and out of scope of what you're proposing..
> 
> I agree, there are other things to consider before doing this.
> 
> >
> > Did this 'wrong' calculation cause an actual problem for task placement?
> > I assume the pd looked 'busier' because some CPUs were too busy.
> 
> This will not only affect calculations in scenarios with high temperatures.
> Sometimes, users will set scalimg_max_freq to actively limit the CPU frequency,
> so that even if the CPU load is large, the CPU frequency will not be very high.
> At this time, even if tasks are placed on other CPUs in the same PD,
> the energy increment may not be too large, thus affecting core selection.
> 
> >
> > Was the system in overutilzied state? Usually if one CPU is that busy
> > overutilized should be set and we'd skip EAS - unless uclamp_max was used.
> 
> As Christian said, This case occurs not only in the overutil scenario,
> this scenario holds true as long as the actual-cpu-capacity caused by
> the reduction in max cpu frequency is smaller than the cpu util.

Hmm. Sorry I might be thick here, but shouldn't fits_capacity() use
capacity_of() which should return capacity based on get_actual_cpu_capacity()
to compare if we are overutilized? If we are higher than this value that you
need to cap, then the CPU must be overutilized and we shouldn't be in feec() in
the first place, no? Unless the rq is capped with uclamp_max that is.

I generally think our current definition of overutilized is wrong and the use
case you're talking about should hold true if it's just a single CPU that is
overutilized. But I can't see how you end up in feec() if the util is higher
than the CPU in our current code base.

What did I miss?

And should effective_cpu_util() return a value higher than
get_actual_cpu_capacity()?

diff --git a/kernel/sched/syscalls.c b/kernel/sched/syscalls.c
index 8b1194c39161..91acc0f92ae4 100644
--- a/kernel/sched/syscalls.c
+++ b/kernel/sched/syscalls.c
@@ -286,7 +286,7 @@ unsigned long effective_cpu_util(int cpu, unsigned long util_cfs,
        unsigned long util, irq, scale;
        struct rq *rq = cpu_rq(cpu);

-       scale = arch_scale_cpu_capacity(cpu);
+       scale = get_actual_cpu_capacity(cpu);

        /*
         * Early check to see if IRQ/steal time saturates the CPU, can be

