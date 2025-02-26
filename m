Return-Path: <linux-kernel+bounces-532706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97EA4A45139
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 01:09:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 192DB189D748
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 00:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F052C4689;
	Wed, 26 Feb 2025 00:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="bBfd3smd"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27125EBE
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 00:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740528504; cv=none; b=q4k9RtmLXnzaYPiJfNFs0ymPj/tl7q3Mw1eRXFaecG+r77HHFjfjhnx+21bvNBTkPo0jP9/mz55zoTkAppSiwJaTVHia9agVxfQZy0TaQDqtifoLBIJwnzyEOlOsdByjqvMWnqq0mDcXkTE5FBicCs99AI4VGiTmoulE5Sjh2dA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740528504; c=relaxed/simple;
	bh=DNFBwu0nuGfjvMILeMqyhehmgLcdWlJgJZDSKJWPX/4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Jf38V2PPSScS7uCGrrmVv8pglCkdDJRZOb6hhpkWk477Q53avPcGUNpSpiXFVrbWd5mTdDlGyKZ2fbuBZuWRpysT3TN86/awiwvh8K7E2ntLa/IxiAWzBE2a69r6PXGAhHOx2uZsDUczcml0P/Q4l3zpFSaOKala7lxZ1o0htQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=bBfd3smd; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43994ef3872so38316535e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 16:08:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1740528500; x=1741133300; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MgyA7Y9GsN2YNrD/5vS7AosxwFLqJ8euRszMZaVdtyw=;
        b=bBfd3smdcsCZe2U0hoKwufP8LyodwLnnxME9Ac6qrS4DdV2stwBdnbAE1WCJ5G4uJz
         J1yvnnzWiAc5PSM6O/XMPLrzgmTSPEl3/vtpPaamKV5HiezFz7xkC1h51hWYIee8cxWv
         4Zy2f1Cd87dK/bSBHinmHKdT8VQtPWT/JMO6FAUICaxb3zSwaVk8AIOqdhaiiCd6AM61
         A5mIFAYBPpxHGVsq1r6qrZODNr/GlAWnVPZ3SwUYRxLGr6ArXfsKZPTV1JzQplUubJuX
         +bwXL9JDWrJZ5HeAVl5P/eHGQagz1EZy6MJTwu+/vCCt0c/73pGqeYtCsoqFgeYR8S9P
         tEvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740528500; x=1741133300;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MgyA7Y9GsN2YNrD/5vS7AosxwFLqJ8euRszMZaVdtyw=;
        b=VHSQTMn6WM+Ymt51gXrprgzWju+ZYncidEBRgG6AgHGqEXlU4nZDy8CuhClVHuLRtH
         tu4+Cy7kG2xcr2XKtdJuKdPMi1pd3c5XKSzu9PnNn1lJM9zNidmDEKmOp6jiwxtIpuBt
         mYrIpJbarWLHBnueXjB04Z9poYOLrPyfdq4l/LDpVALwDHgF0PwppqxmqenPKniJ0nL1
         RzJmiARBxJosoBH2EvY1tpB+L3qut7kx5YCFvHqeoO7vF/QDaOFQMsPqE7yEZccsRZy3
         sDWmpDWPZzLZzQVmBY80hJ0O782HkCo2j7wbxlpNsJYawutYo7V9vOMzDyXvAdb/dsxg
         tn6A==
X-Forwarded-Encrypted: i=1; AJvYcCWus6S8zm2JhtmQH326bMCMR1HpHpqdmGsPDwI4RICRqGKmlHfcpQ5aUr7dhEh68RTw18rYm6x5/IA6YLE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSOgR/YxT8ofHORHXA/qaGPMJlPYJJ/EmPsAGOAm64ahuhl+kq
	YtpI5f+TKqqfGzXjLjmWdfX++MEtbw6AgXzNx5UC3/QXgvJ+r4cL9cIpfFVTTcI=
X-Gm-Gg: ASbGnctORTrnH3MJmQFwnr0UKS6dCbIdw+rIvbA2LhsU3DusS7YC58rwKqEVoFp1nbN
	k+kuOeo036lG/F0ugCk9FYHDj6rLfZrMezk/NfRM/0Anz9mKiNXLTn7K/YbtWvhkKptsKNgdotF
	HRF10d0ZGPyob5tqatwuoEhLGlTLU2zNr4T6ruNOqeqUwuRE3ipdd/s9ViMw2cGg4eh4cFPayki
	4hzb6CeRoWW5JP/OuuFGC1/ROhR+NiV+wYK7dltsB9dAi5aJl/G+ACL330IE33PgpvAF4UyIpBU
	Nf3kbjYzfno7WwydCugJ4pE=
X-Google-Smtp-Source: AGHT+IG7VyC90jHXnQLMiafIqShQlvmlnSDN3OI5elpfmEcENDSxld9lcG1qRuMLw9WiU8ZTIDpjPw==
X-Received: by 2002:a05:600c:5123:b0:439:88bb:d035 with SMTP id 5b1f17b1804b1-43ab0f2887dmr50282775e9.5.1740528500074;
        Tue, 25 Feb 2025 16:08:20 -0800 (PST)
Received: from airbuntu.. ([46.186.201.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390cd8e725dsm3912540f8f.63.2025.02.25.16.08.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 16:08:19 -0800 (PST)
From: Qais Yousef <qyousef@layalina.io>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>
Cc: Juri Lelli <juri.lelli@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Stultz <jstultz@google.com>,
	Saravana Kannan <saravanak@google.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	David Laight <david.laight.linux@gmail.com>,
	Andrea Righi <arighi@nvidia.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	Qais Yousef <qyousef@layalina.io>
Subject: [PATCH v2] Kconfig.hz: Change default HZ to 1000
Date: Wed, 26 Feb 2025 00:08:09 +0000
Message-Id: <20250226000810.459547-1-qyousef@layalina.io>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The frequency at which TICK happens is very important from scheduler
perspective. There's a responsiveness trade-of that for interactive
systems the current default is set too low.

Historically it was set to 250 to address throughput and power concerns.
But these issues should no longer be true. Throughput is more sensitive
to base_slice which can be controlled with task sched_attr::runtime. And
current state of NOHZ and RCU_LAZY should make frequent TICKS not
a problem from keeping CPUs at deep idle state to save power when the
system doesn't any activities.

Joel indicated that ChromeOS has seen power gains on x86 with HZ=1000.
Andrea has done analysis at Ubuntu [1] which confirms that power is the
same or better on x86  with no significant impact on performance.
Phoronix has also conducted an experiment that shows performance is
better in a number of use cases and slightly lower in others with no
significant power impact [2]. Testing on Android environment shows that
UI pipeline can have 54% and 13% less missed frames at 6.67% power cost
due to increased responsiveness of util signal as explained below.

Generally having a slow TICK frequency can lead to the following
shortcomings in scheduler decisions:

1. Imprecise time slice
-----------------------

Preemption checks occur when a new task wakes up, on return from
interrupt or at TICK. If we have N tasks running on the same CPU then as
a worst case scenario these tasks will time slice every TICK regardless
of their actual slice size.

By default base_slice ends up being 3ms on many systems. But due to TICK
being 4ms by default, tasks will end up slicing every 4ms instead in
busy scenarios.  It also makes the effectiveness of reducing the
base_slice to a lower value like 2ms or 1ms pointless. It will allow new
waking tasks to preempt sooner.  But it will prevent timely cycling of
tasks in busy scenarios. Which is an important and frequent scenario.

2. Delayed load_balance()
-------------------------

Scheduler task placement decision at wake up can easily become stale as
more tasks wake up. load_balance() is the correction point to ensure the
system is loaded optimally. And in the case of HMP systems tasks are
migrated to a bigger CPU to meet their compute demand.

Newidle balance can help alleviate the problem. But the worst case
scenario is for the TICK to trigger the load_balance().

3. Delayed stats update
-----------------------

And subsequently delayed cpufreq updates and misfit detection (the need
to move a task from little CPU to a big CPU in HMP systems).

When a task is busy then as a worst case scenario the util signal will
update every TICK. Since util signal is the main driver for our
preferred governor - schedutil - and what drives EAS to decide if
a task fits a CPU or needs to migrate to a bigger CPU, these delays can
be detrimental to system responsiveness.

------------------------------------------------------------------------

Note that the worst case scenario is an important and defining
characteristic for interactive systems. It's all about the P90 and P95.
Responsiveness IMHO is no longer a characteristic of a desktop system.
Modern hardware and workloads are interactive generally and need better
latencies. To my knowledge even servers run mixed workloads and serve
a lot of users interactively.

On Android and Desktop systems etc 120Hz is a common screen
configuration. This gives tasks 8ms deadline to do their work. 4ms is
half this time which makes the burden on making very correct decision at
wake up stressed more than necessary. And it makes utilizing the system
effectively to maintain best perf/watt harder. As an example [3] tries
to fix our definition of DVFS headroom to be a function of TICK as it
defines our worst case scenario of updating stats. The larger TICK means
we have to be overly aggressive in going into higher frequencies if we
want to ensure perf is not impacted. But if the task didn't consume all
of its slice, we lost an opportunity to use a lower frequency and save
power. Lower TICK value allows us to be smarter about our resource
allocation to balance perf and power.

Generally workloads working with ever smaller deadlines is not unique to
UI pipeline. Everything is expected to finish work sooner and be more
responsive.

As pointed out to me by Saravana though, the longer TICK did indirectly
help with timers delayed trigger which means it could hide issues with
drivers/tasks asking for frequent timers preventing entry to deeper idle
states (4ms is a high value to allow entry to deeper idle state for many
systems). But one can argue this is a problem with these drivers/tasks.
And if the delayed trigger behavior is desired we can make it
intentional rather than accidental.

The faster TICK might still result in higher power, but not due to TICK
activities. The impact is more prominent with schedutil governor. The system
is more responsive (as intended) and it is expected the residencies in higher
freqs would be higher as they were accidentally being stuck at lower freqs. The
series in [3] attempts to improve scheduler handling of responsiveness and give
users/apps a way to better provide/get their needs.

Since the default behavior might end up on many unwary users, ensure it
matches what modern systems and workloads expect given that our NOHZ has
moved a long way to keep TICKS tamed in idle scenarios.

Noteworthy that some folks reported that PREEMPT_LAZY helps undo the
slight throughput loss in some benchmarks.

[1] https://discourse.ubuntu.com/t/enable-low-latency-features-in-the-generic-ubuntu-kernel-for-24-04/42255
[2] https://www.phoronix.com/news/Linux-250Hz-1000Hz-Kernel-2025
[3] https://lore.kernel.org/lkml/20240820163512.1096301-6-qyousef@layalina.io/

Acked-by: Joel Fernandes <joelagnelf@nvidia.com>
Acked-by : Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Qais Yousef <qyousef@layalina.io>
---

Changes in v2:
	* Update commit message to include some data
	* Add Acked-bys

 kernel/Kconfig.hz | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/Kconfig.hz b/kernel/Kconfig.hz
index 38ef6d06888e..c742c9298af3 100644
--- a/kernel/Kconfig.hz
+++ b/kernel/Kconfig.hz
@@ -5,7 +5,7 @@
 
 choice
 	prompt "Timer frequency"
-	default HZ_250
+	default HZ_1000
 	help
 	 Allows the configuration of the timer frequency. It is customary
 	 to have the timer interrupt run at 1000 Hz but 100 Hz may be more
-- 
2.34.1


