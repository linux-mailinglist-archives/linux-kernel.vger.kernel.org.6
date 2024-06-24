Return-Path: <linux-kernel+bounces-227022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97C2791475C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 12:24:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA5A41C232AB
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 10:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C23F4136E28;
	Mon, 24 Jun 2024 10:24:06 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 172A11369A3
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 10:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719224646; cv=none; b=IrzXi53xzkVLUZ5ja5QiRCbvdijGIMEABOgUQxdu8s/PH09iCUjxgrU/j0XMKrilkuQBxYslgUExWqd34Xw3j1XnygJZZDQNrMbd3rZBnX1cIJ04t+mRk3A9tT9A4b5qJllUT5AtYPZgJzPEgfbJFHUGFTUcKQWmzhEgDJ0SkmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719224646; c=relaxed/simple;
	bh=qGFtnFZuIXpcbUSYjipGjWaGwOOCWov7ktu2iKdZAmc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=h3FB+ls9hn87Cr/gbUItnzu1L5vmEYrr29zkj7pKMIqRlVBkXm5YZi7cwWySZy6CCAFvXzymULV1V7/zOiOlaG3LliV1gEMknEkby8wdXXW+ZCrlIf2Aoc/tXC4rE7HT1YR6C9UCBV9OROE+1oIDBE5ucMKg/hKVYoQVShN54zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 26A8FDA7;
	Mon, 24 Jun 2024 03:24:27 -0700 (PDT)
Received: from e130256.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DA1763F766;
	Mon, 24 Jun 2024 03:24:00 -0700 (PDT)
From: Hongyan Xia <hongyan.xia2@arm.com>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Qais Yousef <qyousef@layalina.io>,
	Morten Rasmussen <morten.rasmussen@arm.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Pierre Gondois <pierre.gondois@arm.com>,
	Youssef Esmat <youssefesmat@google.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/7] uclamp sum aggregation
Date: Mon, 24 Jun 2024 11:23:49 +0100
Message-Id: <cover.1719223916.git.hongyan.xia2@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Current uclamp implementation, max aggregation, has several drawbacks.
This series gives an alternative implementation that addresses the
problems and shows other advantages, mostly:

1. Simplicity. Sum aggregation implements uclamp with less than half of
   code than max aggregation.
2. Effectiveness. Sum aggregation shows better uclamp effectiveness,
   either in benchmark scores or more importantly, in energy efficiency.
3. Works on its own. No changes in cpufreq or other sub-systems are
   needed.
4. Low-overhead. No bucket operations and no need to tweak the number of
   buckets to balance between overhead and uclamp granularity.

The key idea of sum aggregation is fairly simple. Each task has a
util_avg_bias, which is obtained by:

    util_avg_bias = clamp(util_avg, uclamp_min, uclamp_max) - util_avg;

If a CPU has N tasks, p1, p2, p3... pN, then we sum the biases up and
obtain a rq total bias:

    rq_bias = util_avg_bias1 + util_avg_bias2... + util_avg_biasN;

Then we use the biased rq utilization rq_util + rq_bias to select OPP
and to schedule tasks.

PATCH BREAKDOWN:

Patch 1/7 reverts a patch that accommodate uclamp_max tasks under max
aggregation. This patch is not needed and creates other problems for sum
aggregation. It is discussed elsewhere that this patch will be improved
and there may not be the need to revert it in the future.

Patch 2, 3 and 4 implement sum aggregation.

Patch 5 and 6 remove max aggregation.

Patch 7 applies PELT decay on negative util_avg_bias. This improves
energy efficiency and task placement, but is not strictly necessary.

TESTING:

Two notebooks are shared at

https://nbviewer.org/github/honxia02/notebooks/blob/bb97afd74f49d4b8add8b28ad4378ea337c695a8/whitebox/max.ipynb
https://nbviewer.org/github/honxia02/notebooks/blob/bb97afd74f49d4b8add8b28ad4378ea337c695a8/whitebox/sum-offset.ipynb

The experiments done in notebooks are on Arm Juno r2 board. CPU0-3 are
little cores with capacity of 383. CPU4-5 are big cores. The rt-app
profiles used for these experiments are included in the notebooks.

Scenario 1: Scheduling 4 tasks with UCLAMP_MAX at 110.

The scheduling decisions are plotted in Out[11]. Both max and sum
aggregation understand the UCLAMP_MAX hint and schedule all 4 tasks on
the little cluster. Max aggregation sometimes schedule 2 tasks on 1 CPU,
and this is the reason why sum aggregation reverts the 1st commit.
However, the reverted patch may be improved and this revert may not be
needed in the future.

Scenario 2: Scheduling 2 tasks with UCLAMP_MIN and UCLAMP_MAX at a value
slightly above the capacity of the little CPU.

Results are in Out[17]. The purpose is to use UCLAMP_MIN to place tasks
on the big core. Both max and sum aggregation handle this correctly.

Scenario 3: Task A is a task with a small utilization pinned to CPU4.
Task B is an always-running task pinned to CPU5, but UCLAMP_MAX capped
at 300. After a while, task A is then pinned to CPU5, joining B.

Results are in Out[23]. Max aggregation sees a frequency spike at
239.75s. When zoomed in, one can see square-wave-like utilization values
because of A periodically going to sleep. When A wakes up, its default
UCLAMP_MAX of 1024 will uncap B and reach the highest CPU frequency.
When A sleeps, B's UCLAMP_MAX will be in effect and will reduce rq
utilization. This happens repeatedly, hence the square wave. In
contrast, sum aggregation sees a normal increase in utilization when A
joins B, without any square-wave behavior.

Scenario 4: 4 always-running tasks with UCLAMP_MAX of 110 pinned to the
little PD (CPU0-3). 4 same tasks pinned to the big PD (CPU4-5).
After a while, remove the CPU pinning of the 4 tasks on the big PD.

Results are in Out[29]. After unpinning, max aggregation moves all 8
tasks to the little cluster, but schedules 5 tasks on CPU0 and 1 each on
CPU1-3. In contrast, sum aggregation schedules 2 on each little CPU
after unpinning, which is the desired balanced task placement.

Same as Scenario 1, the situation may not be as bad once the improvement
of the reverted patch comes out in the future.

Scenario 5: Scheduling 8 tasks with UCLAMP_MAX of 110.

Results are in Out[35] and Out[36]. There's no doubt that sum
aggregation yields substantially better scheduling decisions. This tests
roughly the same thing as Scenario 4.

EVALUATION:

We backport patches to kernel v6.1 on Pixel 6 and run Android
benchmarks.

Speedometer:

We run Speedometer 2.0 to test ADPF/uclamp effectiveness. Because sum
aggregation does not circumvent the 20% OPP margin, we reduce uclamp
values to 80% to be fair.

------------------------------------------------------
|   score   | score |   %   | CPU power (mW) |   %   |
|    max    | 161.4 |       |    2358.9      |       |
|  sum_0.8  | 166.0 | +2.85 |    2485.0      | +5.35 |
| sum_tuned | 162.6 | +0.74 |    2332.0      | -1.14 |
------------------------------------------------------

We see a consistant higher score and higher average power consumption.
Note that a higher score also means a reduction in run-time, so total
energy increase for sum_0.8 is only 1.88%.

We then reduce uclamp values so that the Speedometer score is roughly
the same. If we do so, then sum aggregation actually gives a reduced
average power and total energy consumption than max aggregation.

UIBench:

-----------------------------------------------------------------
|   score   | jank percentage |   %    | CPU power (mW) |   %   |
|    max    |     0.375%      |        |     122.75     |       |
|  sum_0.8  |     0.440%      | +17.33 |     116.35     | -5.21 |
| sum_tuned |     0.220%      | -41.33 |     119.35     | -2.77 |
-----------------------------------------------------------------

UIBench on Pixel 6 by default already has a low enough jank percentage.
Moving to sum aggregation gives higher jank percentage and lower power
consumption. We then tune the hardcoded uclamp values in the Android
image to take advantage of the power budget, and can achieve more than
41% jank reduction while still operating with less power consumption
than max aggregation.

This result is not suggesting that sum aggregation greatly outperforms
max aggregation, because the jank percentage is already very low, but
instead suggests that hardcoded uclamp values in the system (like in
init scripts) need to be changed to perform well under sum aggregation.
If tuned well, sum aggregation generally shows better effectiveness, or
the same effectiveness but with less power consumption.

---
Changed in v1 since RFCv3:
- Rebase and add comments as suggested.
- Move util_est changes into a separate patch.
- Fix build failures on !CONFIG_SMP detected by Intel kernel bot.
- Avoid duplicate calls to util() and util_uclamp() functions by using
  the static key.

Changed in RFCv3:
- Addresses the biggest concern from multiple people, that PELT and
  uclamp need to be separate. The new design is significantly simpler
  than the previous revision and separates util_avg_uclamp into the
  original util_avg (which this series doesn't touch at all) and the
  util_avg_bias component.
- Keep the tri-state return value of util_fits_cpu().
- Keep both the unclamped and clamped util_est, so that we use the right
  one depending on the caller in frequency or energy calculations.


Hongyan Xia (7):
  Revert "sched/uclamp: Set max_spare_cap_cpu even if max_spare_cap is
    0"
  sched/uclamp: Track a new util_avg_bias signal
  sched/uclamp: Add util_est_uclamp
  sched/fair: Use util biases for utilization and frequency
  sched/uclamp: Remove all uclamp bucket logic
  sched/uclamp: Simplify uclamp_eff_value()
  Propagate negative bias

 include/linux/sched.h            |   8 +-
 init/Kconfig                     |  32 ---
 kernel/sched/core.c              | 294 ++--------------------
 kernel/sched/cpufreq_schedutil.c |  12 +-
 kernel/sched/debug.c             |   2 +-
 kernel/sched/fair.c              | 419 ++++++++++++++++---------------
 kernel/sched/pelt.c              |  37 +++
 kernel/sched/rt.c                |   4 -
 kernel/sched/sched.h             | 131 +++-------
 kernel/sched/syscalls.c          |  16 +-
 10 files changed, 312 insertions(+), 643 deletions(-)

-- 
2.34.1


