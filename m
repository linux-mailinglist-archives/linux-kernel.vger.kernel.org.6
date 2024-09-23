Return-Path: <linux-kernel+bounces-335608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 029AE97E807
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 11:01:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 252B01C213CB
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 09:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E7CD188918;
	Mon, 23 Sep 2024 09:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KF0KuK4t"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C2228684
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 09:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727082080; cv=none; b=ozfm0eGjkRMT0ZCkftReifpBnco3kfhw2EDxiV4QVWww70+u13EXAnM8WH/1WmWUbyNEG21aR16p3LyITgxI/m1XV0TaP7OV+1i4Ooo/gGiVUSfkaO0zZEnW/2h7Jnkeczx+c6GP5dmAj6kSEXkHpClmhtaMPYwXSW+ptCNprrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727082080; c=relaxed/simple;
	bh=aK3Ccy/qEp8lMx5Lda2LMCann47R9uZzRju5t0KsK2I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BwzbF2xUW6sOJ2QS2VZ0W2Hn8c4/0MMrLZs4LChCa/vRsPWAZEHGhATmZKza5nB+OxVraTM1TQmbi2AcFBgncZecvD89MvswKco+URzKYlHSBv6XoxsG7SbAMktQq1Em+Lmu7nCSHdI/l3u/dxIcpKFpY0fCrRDmPV0+v53rAaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KF0KuK4t; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2db928dbd53so3261326a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 02:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727082077; x=1727686877; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=26Hym3zd0zIr6OsuYGjxkOtQ+t36plo/exdQlFtHHE8=;
        b=KF0KuK4tBm4x2jhLlKla3kYM6F984MM6mLCbMdh0NxoFN8bosDkKq6bnNHgXyFNGkm
         QGCx1CHUWrVF3SavgD4gf1qX6GTJdbvD8jdRhpn7UytUoSPeiWLDLwZh71oxtkPkJOdx
         is034xPpG/MEEpmv0x0sLJQIB8E2ofspJwI7Bl3y5soKwtNwWwwfCfZfvqEkFQuhX1y3
         iOjMSIdoq20diINqt0MhhLosB0iXL6h2s55saSMnWLJTcQJ03Oas9n9lYWPCqKyB2XXn
         Zkb8GCBXra5WBC4YFqLaHkqOB3cxPKHq7/5QtccchIeAOddt+BCxl+Xg+fhzpldhRxyM
         uVpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727082077; x=1727686877;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=26Hym3zd0zIr6OsuYGjxkOtQ+t36plo/exdQlFtHHE8=;
        b=IRd8UnLXtP5wnlunM9NehEsqE5I9HpJRceNFno0if1RMT0sZ6/HBi6f4uptI4cmIC0
         KpaQwidqJXaZepROM9bScFWsmVopsXYywdftBJXZNmWnCjUpmjfdjOWcYf2hnXswVxtk
         fEn53gAh9XgKI0ZCayEnm0yI0SoJuGOD8qoJF8m0GohMQ445AL7xq2VOm5t5eCRLLPLV
         jZTkw2+KnimzP303aIaY4WsQxO7Rr2S76vOeEFdCorJPesKrpBmNvwBLM9p3wKQVw+zo
         9ZJoDsqyNO6vcJcNNMRwlsSZySuAnPuqe2CCHa11poGPgoPGDqAq8/24fJzjjYKt0zQ/
         CXrg==
X-Gm-Message-State: AOJu0Yy+1iJ4Rb2J8itIm+Wc0avpzsB8vCsUEldJ650mHhqfN5w4xKM5
	j1U3535SDdOpZfIucz9QZJmkKYDutJaPRMbTWGXi5RiIvAqPoExL
X-Google-Smtp-Source: AGHT+IHBFc/Q2nBf2o7S+Rqdldzgs4tyEE4NwcA+QpVdfluqiERN8RaTWcTwbk5+2iWDZGucRayFIQ==
X-Received: by 2002:a17:90a:d908:b0:2d8:83ce:d4c0 with SMTP id 98e67ed59e1d1-2dd7f40ad24mr14320519a91.13.1727082077277;
        Mon, 23 Sep 2024 02:01:17 -0700 (PDT)
Received: from localhost.localdomain ([39.144.43.152])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dd7f8ca487sm6768872a91.39.2024.09.23.02.01.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Sep 2024 02:01:16 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com
Cc: linux-kernel@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH 1/3] sched: Fix cgroup irq accounting for CONFIG_IRQ_TIME_ACCOUNTING
Date: Mon, 23 Sep 2024 17:00:26 +0800
Message-Id: <20240923090028.16368-2-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20240923090028.16368-1-laoar.shao@gmail.com>
References: <20240923090028.16368-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

After enabling CONFIG_IRQ_TIME_ACCOUNTING to monitor IRQ pressure in our
container environment, we observed several noticeable behavioral changes.

One of our IRQ-heavy services, such as Redis, reported a significant
reduction in CPU usage after upgrading to the new kernel with
CONFIG_IRQ_TIME_ACCOUNTING enabled. However, despite adding more threads
to handle an increased workload, the CPU usage could not be raised. In
other words, even though the container’s CPU usage appeared low, it was
unable to process more workloads to utilize additional CPU resources, which
caused issues.

This behavior can be demonstrated using netperf:

  function start_server() {
      for j in `seq 1 3`; do
          netserver -p $[12345+j] > /dev/null &
      done
  }

  server_ip=$1
  function start_client() {
    # That applies to cgroup2 as well.
    mkdir -p /sys/fs/cgroup/cpuacct/test
    echo $$ > /sys/fs/cgroup/cpuacct/test/cgroup.procs
    for j in `seq 1 3`; do
        port=$[12345+j]
        taskset -c 0 netperf -H ${server_ip} -l ${run_time:-30000}   \
                -t TCP_STREAM -p $port -- -D -m 1k -M 1K -s 8k -S 8k \
                > /dev/null &
    done
  }

  start_server
  start_client

We can verify the CPU usage of the test cgroup using cpuacct.stat. The
output shows:

  system: 53
  user: 2

The CPU usage of the cgroup is relatively low at around 55%, but this usage
doesn't increase, even with more netperf tasks. The reason is that CPU0 is
at 100% utilization, as confirmed by mpstat:

  02:56:22 PM  CPU    %usr   %nice    %sys %iowait    %irq   %soft  %steal  %guest  %gnice   %idle
  02:56:23 PM    0    0.99    0.00   55.45    0.00    0.99   42.57    0.00    0.00    0.00    0.00

  02:56:23 PM  CPU    %usr   %nice    %sys %iowait    %irq   %soft  %steal  %guest  %gnice   %idle
  02:56:24 PM    0    2.00    0.00   55.00    0.00    0.00   43.00    0.00    0.00    0.00    0.00

This behavior is unexpected. We should account for IRQ time to the cgroup
to reflect the pressure the group is under.

After a thorough analysis, I discovered that this change in behavior is due
to commit 305e6835e055 ("sched: Do not account irq time to current task"),
which altered whether IRQ time should be charged to the interrupted task.
While I agree that a task should not be penalized by random interrupts, the
task itself cannot progress while interrupted. Therefore, the interrupted
time should be reported to the user.

The system metric in cpuacct.stat is crucial in indicating whether a
container is under heavy system pressure, including IRQ/softirq activity.
Hence, IRQ/softirq time should be accounted for in the cpuacct system
usage, which also applies to cgroup2’s rstat.

This patch reintroduces IRQ/softirq accounting to cgroups.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 kernel/sched/cputime.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
index 0bed0fa1acd9..4586db5cf3a8 100644
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -34,7 +34,8 @@ void disable_sched_clock_irqtime(void)
 	sched_clock_irqtime = 0;
 }
 
-static void irqtime_account_delta(struct irqtime *irqtime, u64 delta,
+static void irqtime_account_delta(struct task_struct *curr,
+				  struct irqtime *irqtime, u64 delta,
 				  enum cpu_usage_stat idx)
 {
 	u64 *cpustat = kcpustat_this_cpu->cpustat;
@@ -44,6 +45,9 @@ static void irqtime_account_delta(struct irqtime *irqtime, u64 delta,
 	irqtime->total += delta;
 	irqtime->tick_delta += delta;
 	u64_stats_update_end(&irqtime->sync);
+
+	cgroup_account_cputime(curr, delta);
+	cgroup_account_cputime_field(curr, idx, delta);
 }
 
 /*
@@ -72,9 +76,9 @@ void irqtime_account_irq(struct task_struct *curr, unsigned int offset)
 	 * that do not consume any time, but still wants to run.
 	 */
 	if (pc & HARDIRQ_MASK)
-		irqtime_account_delta(irqtime, delta, CPUTIME_IRQ);
+		irqtime_account_delta(curr, irqtime, delta, CPUTIME_IRQ);
 	else if ((pc & SOFTIRQ_OFFSET) && curr != this_cpu_ksoftirqd())
-		irqtime_account_delta(irqtime, delta, CPUTIME_SOFTIRQ);
+		irqtime_account_delta(curr, irqtime, delta, CPUTIME_SOFTIRQ);
 }
 
 static u64 irqtime_tick_accounted(u64 maxtime)
-- 
2.43.5


