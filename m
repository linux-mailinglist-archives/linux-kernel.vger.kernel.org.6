Return-Path: <linux-kernel+bounces-389436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 324E79B6D1E
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 20:50:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5E08282C06
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 19:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CB251D1741;
	Wed, 30 Oct 2024 19:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="keJGYyUx"
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E21C1D0F66
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 19:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730317822; cv=none; b=X++qI74ptr2suu1umEHFMVKkQGW8hNXiAapPtHLvtamYdrwiPrXMxHg2yh555EtxmWgqkW6UqiTDdt8VuxahT7bRn4oKK5m69o1CnZ8eE6wqwxX94JoMcTBHMx2DIN65qqc4wQfKuxMUoh97BjuBpFc/DhwIBPHW0hHwgv8/qCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730317822; c=relaxed/simple;
	bh=ySnpbX4VP29q4J6OxGAwZZWV0JQNNJpiT2GpfS/xK+E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nXZwwccuA0HtmbVYtvsyvOUKkHoAv+yHbRCH7u1b3bcQDC4mM4ACrF+vMwvGJGr5ETooaQUZlRQDYWvSqsbcVIxQMBzs1+vH/qhJls2886tPNuvxRtjY1ZV/8nhvBlEjEakBI0elFw1FhM+8jMNodwcxXxJ18LNBbHeHVYExTxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=keJGYyUx; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3a4e5e57678so4414815ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 12:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1730317819; x=1730922619; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ggsqcu8z7xAQnpCnTimF3os+TBYkuBRWj+Dwvf/jCsg=;
        b=keJGYyUxl/eHpbMY19OIuK0p2Gc0iUsjP3HLMu63v5Y3RbcrwBGFOlGYCTUyMi6G4p
         miT4RdiQDK0mk4TR2+lWoIUxjujmPgjRMjaKK5+Ose9supRDdMjeGKBQ6rA85krTwUjq
         b7LBbp6L2bowmomWk/W+yJwaBxxIPUN6naT8Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730317819; x=1730922619;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ggsqcu8z7xAQnpCnTimF3os+TBYkuBRWj+Dwvf/jCsg=;
        b=eNUBnOS6bzk1Wct+3hkFSB4a/8zM6TG6nyC/SraJU4QjTT1m8iwBxjZzlYW8VHkV4x
         6fRGUQCOasodl5F8j7Yrmw6QYZLN39FvE696E7SHDQNYa9SClPnCehV9ZjEAQqwiqaej
         F/ZGvpDx+GxuMqy/rvyfP7KemquihpPDtvXXvag1hP/Bt24AseYwHDVlHvlQ2mBU8bOe
         /HmoW3GN3a02q2GD546rYJ7gsoW9XYs+4RFCPSBFnDJp6Ev7Eq3vE4FDiOrq4mVB9gm7
         alux4BFH3Olk14JBvXZGx4Ww6tQjKNN/cDmYML3MZ2yHNzIu70eyB99d1Bu232MPo6RD
         KKOQ==
X-Gm-Message-State: AOJu0YylPYpUHdzttf83rJ8i4nUEYpM/vTs7x9GFv3w761rtDl8TGTD5
	gNr9VE2HKFT2QvYOUzgJ5hEtoOnvTyGHfZWz+nUArOAnWMBQXtQEjqOcqOZ5l58=
X-Google-Smtp-Source: AGHT+IHYt0ZOSpiI7jrVNYso6Mo3G2wuCM5em87FTJDa+Bpc0QVRk9VV2WFNEahmGB/VwZ2NzyWUJQ==
X-Received: by 2002:a05:6e02:12ef:b0:3a2:6d54:33df with SMTP id e9e14a558f8ab-3a5e3b5916bmr27226945ab.4.1730317818992;
        Wed, 30 Oct 2024 12:50:18 -0700 (PDT)
Received: from localhost (68.192.68.34.bc.googleusercontent.com. [34.68.192.68])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4dc72781359sm3001146173.138.2024.10.30.12.50.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 12:50:18 -0700 (PDT)
Date: Wed, 30 Oct 2024 19:50:17 +0000
From: Joel Fernandes <joel@joelfernandes.org>
To: Juri Lelli <juri.lelli@redhat.com>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Suleiman Souhlal <suleiman@google.com>,
	Aashish Sharma <shraash@google.com>,
	Shin Kawamura <kawasin@google.com>,
	Vineeth Remanan Pillai <vineeth@bitbyteword.org>
Subject: Re: [PATCH] dl_server: Reset DL server params when rd changes
Message-ID: <20241030195017.GA4171541@google.com>
References: <20241029225116.3998487-1-joel@joelfernandes.org>
 <ZyJC9MkbPeF9_rdP@jlelli-thinkpadt14gen4.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZyJC9MkbPeF9_rdP@jlelli-thinkpadt14gen4.remote.csb>

On Wed, Oct 30, 2024 at 03:30:12PM +0100, Juri Lelli wrote:
> Hi Joel,

Hi Juri!

> On 29/10/24 22:51, Joel Fernandes (Google) wrote:
> > During boot initialization, DL server parameters are initialized using the
> > default root domain before the proper scheduler domains and root domains
> > are built. This results in DL server parameters being tied to the default
> > root domain's bandwidth accounting instead of the actual root domain
> > assigned to the CPU after scheduler topology initialization.
> > 
> > When secondary CPUs are brought up, the dl_bw_cpus() accounting doesn't
> > properly track CPUs being added since the DL server was started too early
> > with the default root domain. Specifically, dl_bw_cpus() is called before
> > set_cpu_active() during secondary CPU bringup, causing it to not account
> > for the CPU being brought up in its capacity calculations. This causes
> > subsequent sysfs parameter updates to fail with -EBUSY due to bandwidth
> > accounting using the wrong root domain with zeroed total_bw.
> > 
> > This issue also causes under-utilization of system capacity. With the fix,
> > we see proper capacity initialization and scaling as CPUs come online - the
> > total system capacity increases from CPU 0 to CPU 1 and continues scaling
> > up as more CPUs are added (from cap=1024 initially to cap=8192 with 8
> > CPUs). Without the fix, the capacity initialization was incomplete since
> > dl_bw_cpus() runs before the CPU is marked active in set_cpu_active(),
> > leading to CPUs not being properly accounted for in the capacity
> > calculations.
> > 
> > Fix this by tracking the last root domain used for the DL server and
> > resetting the server parameters when the root domain changes. This ensures
> > bandwidth accounting uses the correct, fully initialized root domain after
> > the scheduler topology is built.
> 
> So, I'm trying to reproduce this issue, but currenlty not really seeing
> it, sorry.
> 
> I'm on a 40 CPUs box and, even if I fiddle with hotplug, the numbers I
> see from debug (bw, total_bw) seem sane and consistent with the fair
> server settings.
> 
> Could you please provide additional info about how you reproduce the
> issue? Maybe you have a test script around you could share?

With some prints [1] in the kernel, we can see on boot:

$ dmesg|grep appl
[    0.930337] dl_server_apply_params: cpu=0, runtime=50000000, period=1000000000, cpus=1, cap=1024, init=1
[    0.949025] dl_server_apply_params: cpu=1, runtime=50000000, period=1000000000, cpus=1, cap=1024, init=1
[    0.953026] dl_server_apply_params: cpu=2, runtime=50000000, period=1000000000, cpus=2, cap=2048, init=1
[    0.957024] dl_server_apply_params: cpu=3, runtime=50000000, period=1000000000, cpus=3, cap=3072, init=1
[    0.961023] dl_server_apply_params: cpu=4, runtime=50000000, period=1000000000, cpus=4, cap=4096, init=1
[    0.965030] dl_server_apply_params: cpu=5, runtime=50000000, period=1000000000, cpus=5, cap=5120, init=1
[    0.969024] dl_server_apply_params: cpu=6, runtime=50000000, period=1000000000, cpus=6, cap=6144, init=1
[    0.973024] dl_server_apply_params: cpu=7, runtime=50000000, period=1000000000, cpus=7, cap=7168, init=1

For the 8th apply_params, the 8th CPU is not considered. This is because
set_cpu_active() for the 8th CPU has not yet happened as mentioned in commit
message.

With the patch:

$ dmesg|grep appl
[    0.961169] dl_server_apply_params: cpu=0, runtime=50000000, period=1000000000, cpus=1, cap=1024, init=1
[    0.981936] dl_server_apply_params: cpu=1, runtime=50000000, period=1000000000, cpus=1, cap=1024, init=1
[    0.985836] dl_server_apply_params: cpu=2, runtime=50000000, period=1000000000, cpus=2, cap=2048, init=1
[    0.989835] dl_server_apply_params: cpu=3, runtime=50000000, period=1000000000, cpus=3, cap=3072, init=1
[    0.993840] dl_server_apply_params: cpu=4, runtime=50000000, period=1000000000, cpus=4, cap=4096, init=1
[    0.997835] dl_server_apply_params: cpu=5, runtime=50000000, period=1000000000, cpus=5, cap=5120, init=1
[    1.001838] dl_server_apply_params: cpu=6, runtime=50000000, period=1000000000, cpus=6, cap=6144, init=1
[    1.005834] dl_server_apply_params: cpu=7, runtime=50000000, period=1000000000, cpus=7, cap=7168, init=1

   [ ... here somewhere rd changes as topology init finishes, then all the
   params are replied, this time with the correct rd. ]

[    1.009903] dl_server_apply_params: cpu=0, runtime=50000000, period=1000000000, cpus=8, cap=8192, init=1
[    1.012409] dl_server_apply_params: cpu=1, runtime=50000000, period=1000000000, cpus=8, cap=8192, init=1
[    1.014269] dl_server_apply_params: cpu=2, runtime=50000000, period=1000000000, cpus=8, cap=8192, init=1
[    1.019865] dl_server_apply_params: cpu=3, runtime=50000000, period=1000000000, cpus=8, cap=8192, init=1
[    1.054908] dl_server_apply_params: cpu=4, runtime=50000000, period=1000000000, cpus=8, cap=8192, init=1
[    1.081865] dl_server_apply_params: cpu=5, runtime=50000000, period=1000000000, cpus=8, cap=8192, init=1
[    1.108861] dl_server_apply_params: cpu=6, runtime=50000000, period=1000000000, cpus=8, cap=8192, init=1
[    1.136944] dl_server_apply_params: cpu=7, runtime=50000000, period=1000000000, cpus=8, cap=8192, init=1

The -EBUSY happens for our 5.15 backport. I see dl_b->total_bw to be 0
without my patch. Even if the -EBUSY doesn't happen for you (perhaps due to
compiler or other differences), shouldn't we use the correct rd for
apply_params? The dl_bw is tied to the rd via  cpu_rq(cpu)->rd->dl_bw;

So if rd changes during boot initialization, the correct dl_bw has to be
updated AFAICS. Also if cpusets are used, the rd for a CPU may change.

Let me know if I missed something?

[1]
----------8<-----------
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index d9d5a702f1a6..249f99e88b98 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -238,6 +238,12 @@ void __dl_add(struct dl_bw *dl_b, u64 tsk_bw, int cpus)
 static inline bool
 __dl_overflow(struct dl_bw *dl_b, unsigned long cap, u64 old_bw, u64 new_bw)
 {
+	printk("dl_b->bw: %llu\n", dl_b->bw);
+	printk("cap: %lu, cap_scale(dl_b->bw, cap): %llu\n", cap, cap_scale(dl_b->bw, cap));
+	printk("dl_b->total_bw: %llu\n", dl_b->total_bw);
+	printk("old_bw: %llu\n", old_bw);
+	printk("new_bw: %llu\n", new_bw);
+
 	return dl_b->bw != -1 &&
 	       cap_scale(dl_b->bw, cap) < dl_b->total_bw - old_bw + new_bw;
 }
@@ -1704,6 +1710,10 @@ int dl_server_apply_params(struct sched_dl_entity *dl_se, u64 runtime, u64 perio
 	cpus = dl_bw_cpus(cpu);
 	cap = dl_bw_capacity(cpu);
 
+	printk("dl_server_apply_params: cpu=%d, runtime=%llu, period=%llu, cpus=%d, cap=%lu, init=%d\n",
+		cpu, runtime, period, cpus, cap, init);
+	printk("initial dl_b->total_bw=%llu, dl_b->bw=%llu\n", dl_b->total_bw, dl_b->bw);
+
 	if (__dl_overflow(dl_b, cap, old_bw, new_bw))
 		return -EBUSY;
 
-- 
2.47.0.163.g1226f6d8fa-goog


