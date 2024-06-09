Return-Path: <linux-kernel+bounces-207527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B428901881
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 00:20:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F76F281376
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jun 2024 22:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65FA653E22;
	Sun,  9 Jun 2024 22:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="op2Ookdx"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E57611CFAF
	for <linux-kernel@vger.kernel.org>; Sun,  9 Jun 2024 22:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717971635; cv=none; b=VJA372LSrRvFppfyz09YS6OdTF2OjQl9aUDehS2KuTvssOxah7HmZhbLKqNU0NIpi8nHFSCZ90k5Yp75U/vfzkB+AXlsEQH7oFlvG2zWrOGK/t7fCy0uei2RH3hFZB8wvBFeogrX672tSGjZaobiZe3UJuYkUQBWyAxpXuIhfLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717971635; c=relaxed/simple;
	bh=9+n4z6PHma9WMp2Smv74h7ErUV/1pq2HGsBupGkD7dA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=awHHPc0ES6E8JdApFcRGZBF4dqfLJki3U0Yg3O27xUD9lQH+O+iMVyJSFy4sirV8z6bCXEAChbilY1eFjuJIawTjuDjzy7hAESz8tFfvtXng3Up1aLge0U7B7R6n5+Def4IGfv8pb0VPLxg9QLLHUaFotyk5I5kJEAb9s8rxWDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=op2Ookdx; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-354b722fe81so3245183f8f.3
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jun 2024 15:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1717971631; x=1718576431; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oHc0h4ytn0quxx7T9SUT8FUoAjYS+2WFatBpz0qSLT8=;
        b=op2OokdxRnKRuXEghujswnMB315tnkCrp17dbS4oo/gXjwlzwa9XKecPUAlD2Kq4WE
         WMQO/Du+E+xZCQGR+Dy/V/G1q2X+Yp0DWF2eK16MiInMqbSt+SnIEWPxR3Dee6DrV/Hm
         zqF+FN0eON0+qGFSvPPWj+YeV1nyDDpwLEM9953VUz6OnWwtsFAbEShT4VPa99FSz/xq
         bUbIZOdjbWTlpBTa0WhXp+E7EwFtetmHaq8ekyo6/Hj51uAXWebvSVfD+TWeRyjiAZP/
         W3rnTAYIIPFNKgVSHjq1laBS2Nt8EwBs/ReTi1Zqkq1rUPP0YjO4xW/W8gaJgZcMIQCy
         diiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717971631; x=1718576431;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oHc0h4ytn0quxx7T9SUT8FUoAjYS+2WFatBpz0qSLT8=;
        b=ZHbPPhzSpslOioV2ShEe7n+fNuu6d0cnAFnYsW3XUFQ4Hf1EeWIBZhzrrqkYJgPS0I
         HvXhS/0AW/6hF4IxP01sAwpUHyGgrpDsVz9ty27EfBIDYsVyCvgvUlqjLZSBGRq9ROKq
         FGKriDjoHfyceEt27tQnicEk1iuNVjMH/QAqmVkI5Wxm1gPBoLeLWn1wFnnS2EVS4bpv
         uEc4PwGqyGOE+05fi6Bx8UEO77cX1KHyTzfAoIzy/gLn2K7qwgmlHj/yDMRD2QbDPPlX
         pOk5p2YqbKhQI+c7c0QvjmdrEfZvUL7fQXYpzQE62kr9UxSiqi6VrhDk5OADl46aRV7L
         8Yyg==
X-Forwarded-Encrypted: i=1; AJvYcCXxg++Rnf4rC7WaShKd6ttA+Ej3uRxykGQRN1N4uaH6eF51bDaQ9waNSKCChqlxAC7mSKA3BViLUEK+T85bM5BuLQCT3MOmeI4oMzOv
X-Gm-Message-State: AOJu0YwPDR1ankiNxR+BhGoDZ0sg0aK8QgiKUSRUh1X/c9oWgpfj3d7G
	aNA5fawTI/7at+I7InGjVMDkepB1TCze6vF5coi16xSmsojTG64jEk6LETlKHVk=
X-Google-Smtp-Source: AGHT+IHeyJMWEvfMZi/wZCb6BpC4/fb80QGI+bbYZBWrD7lSEDalPFXwyGcRzY9689gjelOtNXYOyg==
X-Received: by 2002:a5d:634e:0:b0:35f:1384:de4d with SMTP id ffacd0b85a97d-35f1384e1e3mr2786380f8f.37.1717971631047;
        Sun, 09 Jun 2024 15:20:31 -0700 (PDT)
Received: from airbuntu (host81-157-90-255.range81-157.btcentralplus.com. [81.157.90.255])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-421f23d06ddsm3444455e9.8.2024.06.09.15.20.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jun 2024 15:20:30 -0700 (PDT)
Date: Sun, 9 Jun 2024 23:20:29 +0100
From: Qais Yousef <qyousef@layalina.io>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Hongyan Xia <hongyan.xia2@arm.com>,
	John Stultz <jstultz@google.com>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] sched: Consolidate cpufreq updates
Message-ID: <20240609222029.yebhborjptp3gr6a@airbuntu>
References: <20240530104653.1234004-1-qyousef@layalina.io>
 <20240601224017.qku2mhbaz4vsh3a3@airbuntu>
 <CAKfTPtCHfnDAD-p_ScqHh7cZ=7AXDTw3fE0+ynMHNvCjuG8ogw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKfTPtCHfnDAD-p_ScqHh7cZ=7AXDTw3fE0+ynMHNvCjuG8ogw@mail.gmail.com>

On 06/05/24 14:22, Vincent Guittot wrote:
> Hi Qais,
> 
> On Sun, 2 Jun 2024 at 00:40, Qais Yousef <qyousef@layalina.io> wrote:
> >
> > On 05/30/24 11:46, Qais Yousef wrote:
> >
> > > +static __always_inline void
> > > +__update_cpufreq_ctx_switch(struct rq *rq, struct task_struct *prev)
> > > +{
> >
> > I found a problem here. We should check if prev was sugov task. I hit a
> > corner case where we were constantly switching between RT task and sugov.
> >
> >         if (prev && prev->dl.flags & SCHED_FLAG_SUGOV) {
> >                 /* Sugov just did an update, don't be too aggressive */
> >                 return;
> >         }
> >
> 
> I reran my test with this v5 and the fix above but the problem is
> still there, it waits for the next tick to update the frequency
> whereas the cpu was idle.

Hurmph. Sorry I forgot to rerun this test. I broke it again with this
optimization :( Maybe I can replace this with explicit check with util_avg ==
SCHED_CAPACITY_SCALE, though this is not generic enough..

	diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
	index 6d8d569cdb6a..d64d47b4471a 100644
	--- a/kernel/sched/fair.c
	+++ b/kernel/sched/fair.c
	@@ -4702,7 +4702,6 @@ static void detach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
	 static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
	 {
		u64 now = cfs_rq_clock_pelt(cfs_rq);
	-       unsigned long prev_util_avg = cfs_rq->avg.util_avg;

		/*
		 * Track task load average for carrying it to new CPU after migrated, and
	@@ -4736,16 +4735,6 @@ static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
		} else if (cfs_rq->decayed && (flags & UPDATE_TG)) {
			update_tg_load_avg(cfs_rq);
		}
	-
	-       /*
	-        * This field is used to indicate whether a trigger of cpufreq update
	-        * is required. When the CPU is saturated, other load signals could
	-        * still be changing, but util_avg would have settled down, so ensure
	-        * that we don't trigger unnecessary updates as from fair policy point
	-        * of view, nothing has changed to cause a cpufreq update.
	-        */
	-       if (cfs_rq->decayed && prev_util_avg == cfs_rq->avg.util_avg)
	-               cfs_rq->decayed = false;
	 }

	 /*

> 
> Also continuing here the discussion started on v2:
> 
> I agree that in the current implementation we are probably calling way
> too much cpufreq_update, we can optimize some sequences and using the
> context switch is a good way to get a better sampling but this is not
> enough and we still need to call cpufreq_update in some other case
> involving enqueue. The delay of waiting for the next tick is not

Do you have any suggestions? I'm not sure how to classify different type of
enqueue events where some would need an update and others don't.

I think cases that involve wakeup preemption not causing a context switch AND
maybe a large change in util_avg?

> acceptable nor sustainable especially with 250 and lower HZ but I'm

I think it is fine for 250. I have been testing with this and didn't see
issues. But wider testing could yield different results.

> pretty sure it would be the same for some system using 1000HZ. IIUC
> new HW is becoming much more efficient at updating the frequency so it
> would not be a problem for this new system to update performance more
> frequently especially when it ends up being as simple as writing a
> value in a memory region without waiting for it to be applied (like
> cpufreq fast_switch methods). All this to say that always/only waiting
> for context switch or tick might be suitable for your case but it
> doesn't look like the right solution for all devices and systems

I just don't want us to end up with probabilistic approach. I am fine with more
updates, but we need to be more intentional/specific when it's truly needed.

