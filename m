Return-Path: <linux-kernel+bounces-409622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E4D219C8FE2
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 17:35:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B91F2B2CF2B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 16:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53FCE15C144;
	Thu, 14 Nov 2024 16:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VK4ha6vw"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D483FB0E
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 16:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731600849; cv=none; b=muMnoU5rbbZqea3q9DeP8IKyoKEJeZZTPaI31GkPJggR9tbPjMOOv/vyw0+RIhIyyCY4ZDxVRWWeUdGNWdjGJ5szQF0RO6zhfb+GTCmLlK6idL5zr6CghVqt7u3EkUxa2I5Xi/PD4FYGuOhI3BWxlZvP2o7EwhNd2dDKwsk7Htw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731600849; c=relaxed/simple;
	bh=1RN7tyr/xpi1Iyz9+0tasAurFfALZXmSFk2Z51jBvn0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EqZ/Qrs7Xy9KrSbhWzdwavnDIqNAyo/NDmo2kbkVqtJU4CyTxk2b7vqBXR3la4c0DACsUmMu+54j+6u++/2YPXTwYJJjGNdSPhMjP6Up3Mf8638AaEbg+GZHh1je7Pb+hBEz7cGoDsTdCa+X+baspglJ81mqSywU4xGoyHGO0Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VK4ha6vw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731600846;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZaWMQRDcdpd2bCtg+kKRN9VG9vMpZyor3XYx/XAZPJQ=;
	b=VK4ha6vwntVYJo/5rj/jX2QcrCRA+mgfS+8W6PI7F5HdfjFYpf8q9WsgoMZxhffYsPRrSn
	dO0PBUpt/wpyTuaXl5NcLBw/qkBiSkjxAPkAJiKpt9tFONxx3cuDzD3UOvRzAZn2fNvU1A
	Yxhc6f65M2ULSbj2inw5qsaaY4g7d5M=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-77-2zGKkO_gM7mTjC0UlMq08g-1; Thu, 14 Nov 2024 11:14:04 -0500
X-MC-Unique: 2zGKkO_gM7mTjC0UlMq08g-1
X-Mimecast-MFC-AGG-ID: 2zGKkO_gM7mTjC0UlMq08g
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4317391101aso5880905e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 08:14:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731600843; x=1732205643;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZaWMQRDcdpd2bCtg+kKRN9VG9vMpZyor3XYx/XAZPJQ=;
        b=Hkf9z7Ik7YceyBTBGSw01U/N0DPGCsC90wnjUwY3CJSaFg7mCVAUNJm8RcqMBWteNv
         n7Ks/QSwH5LBEa4UTs8TXIYml3+/FYgv10SUWxCt2RRU82iqHujeR91DwWLe/JKpN9K4
         JPaTAJ+/jCXLJf5OZuUYenyacP9c29ifXz+JIeJJM6pLQTN1tbWCvYXBycZzr6vdV/n8
         mXsgUDDV3mvLvcatdCNXWbV72KIiiJxkRpvQaIJMl1tulHzhHkD6JQEkJrrRmH++I5XL
         5gxTZjCzn0TWDVflNxA6eqpthpddShmt8LAlaqkUhBR4ttGDnXy3aigc+2fM6BWyIMWe
         kL8g==
X-Forwarded-Encrypted: i=1; AJvYcCVFVBqpmN4o/Zc7Fm4wlHP6EmHUJ0+76yQ4i2cGztgNMgQFaQCc4gpcm6iHtXwMNJTfENojIz5+t/pz0yY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGqipGTCTJZID2zi/l7wh8Q1uG8fz88+FD+TGjCxYSN73nbkA8
	w4z8QsvVlBq+gfudA/6KOrWSfPfFO79pEWjcvRWhBxatpvznr5kLuzj0du6+nzVyRw2ee8M0zMD
	SctoxMYiTq4doT2iwIMw2Sv4afjPoIl0MG/gEm6PEw01jLAp+Kzps2kYscouGxg==
X-Received: by 2002:a05:6000:4711:b0:378:7f15:d51e with SMTP id ffacd0b85a97d-38218538e3amr1984789f8f.43.1731600843192;
        Thu, 14 Nov 2024 08:14:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFUIYjCdU1AwFvWay9cBvZfF3w9KboS3jI296juNq/s23tFCuYm+rB8xd5g8if1KJ/qTUtszw==
X-Received: by 2002:a05:6000:4711:b0:378:7f15:d51e with SMTP id ffacd0b85a97d-38218538e3amr1984757f8f.43.1731600842791;
        Thu, 14 Nov 2024 08:14:02 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb (host-80-47-4-194.as13285.net. [80.47.4.194])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3821adbbc44sm1879839f8f.45.2024.11.14.08.14.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 08:14:02 -0800 (PST)
Date: Thu, 14 Nov 2024 16:14:00 +0000
From: Juri Lelli <juri.lelli@redhat.com>
To: Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Koutny <mkoutny@suse.com>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Phil Auld <pauld@redhat.com>
Cc: Qais Yousef <qyousef@layalina.io>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	"Joel Fernandes (Google)" <joel@joelfernandes.org>,
	Suleiman Souhlal <suleiman@google.com>,
	Aashish Sharma <shraash@google.com>,
	Shin Kawamura <kawasin@google.com>,
	Vineeth Remanan Pillai <vineeth@bitbyteword.org>,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [PATCH v2 0/2] Fix DEADLINE bandwidth accounting in root domain
 changes and hotplug
Message-ID: <ZzYhyOQh3OAsrPo9@jlelli-thinkpadt14gen4.remote.csb>
References: <20241114142810.794657-1-juri.lelli@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241114142810.794657-1-juri.lelli@redhat.com>

Thanks Waiman and Phil for the super quick review/test of this v2!

On 14/11/24 14:28, Juri Lelli wrote:

...

> In all honesty, I still see intermittent issues that seems to however be
> related to the dance we do in sched_cpu_deactivate(), where we first
> turn everything related to a cpu/rq off and revert that if
> cpuset_cpu_inactive() reveals failing DEADLINE checks. But, since these
> seem to be orthogonal to the original discussion we started from, I
> wanted to send this out as an hopefully meaningful update/improvement
> since yesterday. Will continue looking into this.

About this that I mentioned, it looks like the below cures it (and
hopefully doesn't regress wrt the other 2 patches).

What do everybody think?

---
Subject: [PATCH] sched/deadline: Check bandwidth overflow earlier for hotplug

Currently we check for bandwidth overflow potentially due to hotplug
operations at the end of sched_cpu_deactivate(), after the cpu going
offline has already been removed from scheduling, active_mask, etc.
This can create issues for DEADLINE tasks, as there is a substantial
race window between the start of sched_cpu_deactivate() and the moment
we possibly decide to roll-back the operation if dl_bw_deactivate()
returns failure in cpuset_cpu_inactive(). An example is a throttled
task that sees its replenishment timer firing while the cpu it was
previously running on is considered offline, but before
dl_bw_deactivate() had a chance to say no and roll-back happened.

Fix this by directly calling dl_bw_deactivate() first thing in
sched_cpu_deactivate() and do the required calculation in the former
function considering the cpu passed as an argument as offline already.

Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
---
 kernel/sched/core.c     |  9 +++++----
 kernel/sched/deadline.c | 12 ++++++++++--
 2 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index d1049e784510..43dfb3968eb8 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8057,10 +8057,6 @@ static void cpuset_cpu_active(void)
 static int cpuset_cpu_inactive(unsigned int cpu)
 {
 	if (!cpuhp_tasks_frozen) {
-		int ret = dl_bw_deactivate(cpu);
-
-		if (ret)
-			return ret;
 		cpuset_update_active_cpus();
 	} else {
 		num_cpus_frozen++;
@@ -8128,6 +8124,11 @@ int sched_cpu_deactivate(unsigned int cpu)
 	struct rq *rq = cpu_rq(cpu);
 	int ret;
 
+	ret = dl_bw_deactivate(cpu);
+
+	if (ret)
+		return ret;
+
 	/*
 	 * Remove CPU from nohz.idle_cpus_mask to prevent participating in
 	 * load balancing when not active
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 267ea8bacaf6..6e988d4cd787 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -3505,6 +3505,13 @@ static int dl_bw_manage(enum dl_bw_request req, int cpu, u64 dl_bw)
 		}
 		break;
 	case dl_bw_req_deactivate:
+		/*
+		 * cpu is not off yet, but we need to do the math by
+		 * considering it off already (i.e., what would happen if we
+		 * turn cpu off?).
+		 */
+		cap -= arch_scale_cpu_capacity(cpu);
+
 		/*
 		 * cpu is going offline and NORMAL tasks will be moved away
 		 * from it. We can thus discount dl_server bandwidth
@@ -3522,9 +3529,10 @@ static int dl_bw_manage(enum dl_bw_request req, int cpu, u64 dl_bw)
 		if (dl_b->total_bw - fair_server_bw > 0) {
 			/*
 			 * Leaving at least one CPU for DEADLINE tasks seems a
-			 * wise thing to do.
+			 * wise thing to do. As said above, cpu is not offline
+			 * yet, so account for that.
 			 */
-			if (dl_bw_cpus(cpu))
+			if (dl_bw_cpus(cpu) - 1)
 				overflow = __dl_overflow(dl_b, cap, fair_server_bw, 0);
 			else
 				overflow = 1;


