Return-Path: <linux-kernel+bounces-294337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FFB9958C5E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 18:37:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A47281C21F9E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 16:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42C1A1C579E;
	Tue, 20 Aug 2024 16:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="3A3uUyoa"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045201C0DED
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 16:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724171814; cv=none; b=c2XEfiJpG9fsZJVIGoU41GpXuWa+Pfubj0ZywOJSbRuy97Qy+H/56LvkygmBP7RfX3h14zCfcMiUQfUJ23aEKM3lbJACY89ffLUIFtBfCFGC/rtJhbTkcaC+aVBR+m5sh0zDYv6KwpmwtzNygRwulSTk9PWUZ8mKOhPTeWgdMwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724171814; c=relaxed/simple;
	bh=peGOTrMpJU6Y/7bYHyR4tSGHI6Lbtst36QPON3uOXj0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PiYHbA3MdF8tZ/+NLuYJeijJXbV+V/mVZJwYjcl3Cx9W5AdhgMTxIojYjcEty8/EKqVvlHi9B86FRO1uri1Ga3v/3IFRzWfEFxu37E1b2LFTItJmaCbA5GzlBfLEXghm1oH3uDhZIZT2R5TQag98yjzPeDHntsiALAaysr43Mck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=3A3uUyoa; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a8647056026so125241466b.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 09:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1724171810; x=1724776610; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nawo0iXyk8rugawGjPThZSFWb4byKstZYwvxJoh01/U=;
        b=3A3uUyoa2XVh8IQpUMWF9oo+EJnAtvGnVkgTOkd3SrhbRtIYlpsyGX8V8H0KcR/V1e
         nC3fH2Ff2pHhFdNpRiGMeGkoOLXJJ3ZVk4/EDrag/Ntp/+MGPqI7avbvbJDjJjbxxTPg
         lzc0t5Agrk7BhTMPRV3uFnEnFfmr9nLTrrUJP5okbQOVen/wZpjKsrHUhEPuIHUCDEJE
         3uapYNNelcMfaAL2Lb+dTBqsLyUESbDBWE47bOvfOOznohFRNZ8BkOduG711d+zvGaf7
         FoDW+9myWedFeQHli9yAucsOfnybJAoZ/G8ZUmlROJcvzHe4zoCdGL7ccOb1BtYf75LJ
         FFJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724171810; x=1724776610;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nawo0iXyk8rugawGjPThZSFWb4byKstZYwvxJoh01/U=;
        b=lcTkEuHMI5xVV4ImYKtWYaFCN6gkj59Wf4lx5/iloMSPUtY1EKtY487CHbhN36aWNm
         vHBvwwaXcBKVvuJSURHobMxYhQfrA++Ue0ahmHRwmJnjnz1ErK7gRuDY7ZC9dlVQ1UAS
         Xo5h//XIz22U3Fycp81dQTUNwMfuPfcJbKuNb0ZZJ/mFHKFaOuraEqUyDA4Ybp0eFLMB
         uC8XIvTVjGht/TdfJSoSXG8xjYOFbw+H2pDJZz2SMujlhZ/+MXnXd1DkT07ImcJrX3sj
         qo7QvHxPMU1PYfpA5EUodmzSpXTEUFzfWzAz4Zkhoug78PeO9OIMTlKnxynVkD5wFjYZ
         RWdw==
X-Forwarded-Encrypted: i=1; AJvYcCUq9aXjoIW5DiisepwPpC8yOAXmTIP+xbexpByR2vYOMXaXc1TUGchOp/5/ks3NI2+Jvg8N+YirIJtQDbI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQyrStln0HrXA9cyHhD2eryYxVBe4Z9Ef1HRfaReVnrAulsBnx
	QNallrtKVmPchmUckYRLFq5lrQPms/3FfTz0AGsa7M/TphR3JsL37xmN5PxWT0gyTSZqm8RXkSe
	U
X-Google-Smtp-Source: AGHT+IGIadSEibAssyW3zb8AhXXDHexQCIIATFiI9hph0UEKoDLXeaAbkr5C1JABp/pKbDbwR99llQ==
X-Received: by 2002:a17:907:d3c9:b0:a7a:b643:654f with SMTP id a640c23a62f3a-a839292f3ccmr1052502366b.15.1724171810258;
        Tue, 20 Aug 2024 09:36:50 -0700 (PDT)
Received: from airbuntu.. (host81-157-90-255.range81-157.btcentralplus.com. [81.157.90.255])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a83838cfb5esm780728766b.59.2024.08.20.09.36.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 09:36:49 -0700 (PDT)
From: Qais Yousef <qyousef@layalina.io>
To: Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: Juri Lelli <juri.lelli@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	John Stultz <jstultz@google.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Qais Yousef <qyousef@layalina.io>
Subject: [RFC PATCH 13/16] sched/schedutil: Take into account waiting_avg in apply_dvfs_headroom
Date: Tue, 20 Aug 2024 17:35:09 +0100
Message-Id: <20240820163512.1096301-14-qyousef@layalina.io>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240820163512.1096301-1-qyousef@layalina.io>
References: <20240820163512.1096301-1-qyousef@layalina.io>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We now have three sources of delays.

	1. How often we send cpufreq_updates
	2. How often we update util_avg
	3. How long tasks wait in RUNNABLE to become RUNNING

The headroom should cater for all this type of delays to ensure the
system is running at adequate performance point.

We want to pick the maximum headroom required by any of these sources of
delays.

TODO: the signal should use task clock not pelt as this should be
real time based and we don't care about invariance.

Signed-off-by: Qais Yousef <qyousef@layalina.io>
---
 kernel/sched/cpufreq_schedutil.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 94e35b7c972d..318b09bc4ab1 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -259,10 +259,15 @@ static unsigned int get_next_freq(struct sugov_policy *sg_policy,
  * dvfs_update_delay of the cpufreq governor or min(curr.se.slice, TICK_US),
  * whichever is higher.
  *
+ * Also take into accounting how long tasks have been waiting in runnable but
+ * !running state. If it is high, it means we need higher DVFS headroom to
+ * reduce it.
+ *
  * XXX: Should we provide headroom when the util is decaying?
  */
 static inline unsigned long sugov_apply_dvfs_headroom(unsigned long util,  int cpu)
 {
+	unsigned long update_headroom, waiting_headroom;
 	struct rq *rq = cpu_rq(cpu);
 	u64 delay;
 
@@ -276,7 +281,10 @@ static inline unsigned long sugov_apply_dvfs_headroom(unsigned long util,  int c
 		delay = TICK_USEC;
 	delay = max(delay, per_cpu(dvfs_update_delay, cpu));
 
-	return approximate_util_avg(util, delay);
+	update_headroom = approximate_util_avg(util, delay);
+	waiting_headroom = util + READ_ONCE(rq->cfs.avg.waiting_avg);
+
+	return max(update_headroom, waiting_headroom);
 }
 
 unsigned long sugov_effective_cpu_perf(int cpu, unsigned long actual,
-- 
2.34.1


