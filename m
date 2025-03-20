Return-Path: <linux-kernel+bounces-569167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95284A69F6F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 06:40:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C35288085B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 05:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6A211DE3A8;
	Thu, 20 Mar 2025 05:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IQZk6dO7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EDC11AAE01;
	Thu, 20 Mar 2025 05:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742449185; cv=none; b=T0B9xrclSNntf0qu/H41mHU9ReQK1DR1XNRP0OZBbMz7G0RF17wBZrwqp5Hb8X5hDXTBr10sHoBLcNYhq2TSfGdrAXyJGQ9wC1gd+dZ/BofLx1cTnWetKKLtC+Praymz3rKkQYIUlhNES7OuMVlrmJxNCDPSUoF/TAvgcat74mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742449185; c=relaxed/simple;
	bh=IiVFX+FX+dpUA02tUTC4oeyJG5AoO0bkyrK8R/wDzrs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iug9cQup4RkrLUMXXAj6aFDl9RiVvvekczPYlPFPPvF2LiO26MkJpJdaDnDDdNR8rzTovppIgAUJqLoarXOba0VNrTsW2dpiEx6warUfjdIM6pv7xYqzAd39FrrxUaBsihlJD2/hN/DcqR4Vqo6xUWeiWhKVC0yTSPlXgRUUwgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IQZk6dO7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1939C4CEDD;
	Thu, 20 Mar 2025 05:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742449184;
	bh=IiVFX+FX+dpUA02tUTC4oeyJG5AoO0bkyrK8R/wDzrs=;
	h=From:To:Cc:Subject:Date:From;
	b=IQZk6dO7/UxMcnxo/KxhfXM4rxzNpfkWIlCtW2Q2rV84HMh/H/eXaGKVgHfImzjGz
	 nicDDGHWrJF+Hw4cpBYEeJecj4NzKbZWWjQF0kI7chCVClvXpwNGHfwAzETbMH6E93
	 9hdJlUWoy92Rj8OLvZMFrlqpENa2KJPfMVMEJ2s+0mJsgMulrdn0j4heOw4a+TS5DR
	 XLgH7foB3J2sOnTGyCpfReGHO+qG4dTawBaJ6LVFSw34c3bZ6MDWCsNMoiYGx+Kuco
	 WHqNxPuXIiBxz/OG58ilzD4iOSG19M5H5ssARQDfaNJPgYEWKGhGirqrtv8hKWQZjx
	 NvpuU2G04HefA==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 0/4] mm/damon: let DAMON-based memory tiering self-tuned and just works
Date: Wed, 19 Mar 2025 22:39:33 -0700
Message-Id: <20250320053937.57734-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Utilizing DAMON for memory tiering usually requires manual tuning and
tedious controls.  Let it be able to self-tune hotness and coldness
thresholds for promotion and demotion itself aiming high utilization of
high memory tiers, by introducing new DAMOS quota goal metrics
representing the utilization and free space ratios of specific NUMA
nodes.  Further make it just works with minimum user controls such as
adding a single boot time kernel commandline parameter or single command
on runtime, by introducing a DAMON kernel module that runs the
DAMON-based memory tiering.

This is a partial implementation of previously shared RFC idea[1].

Backgrounds
===========

Some systems equip tiered memory systems that exposes the memory tiers
as NUMA nodes.  A straightforward pages placement strategy for such
systems is placing access-hot and cold pages on upper and lower tiers,
reespectively, pursuing higher utilization of upper tiers.  Since access
temperature can be dynamic, periodically finding and migrating hot pages
and cold pages to peroper tiers (promoting and demoting) is also
required.  Linux kernel provides several features for such dynamic and
transparent pages placement.

Page Faults and LRU
-------------------

One widely known way is using NUMA balancing in tiering mode (a.k.a
NUMAB-2) and reclaim-based demotion features.  NUMAB-2 finds hot pages
using access check-purpose page faults (a.k.a prot_none) and do
promotion inside each process' context.  In the combination, promotions
fill up upper tier until memory pressure happens, and demote LRU based
reclaim-candidates to lower tiers in asynchronous (kswapd) and/or
synchronous ways (direct reclaim).

DAMON
-----

Yet another available solution is using DAMOS with migrate_hot and
migrate_cold DAMOS actions for promotions and demotions, respectively.
To make it optimum, users need to specify aggressiveness and access
temperature thresholds for promotions and demotions in a good balance
that result in high utilization of upper tiers.  The number of
parameters is not small, and optimum values of those depend on
characteristics of the underlying hardware and the workload.  Hence it
is often required to do manual and time consuming tuning of the DAMOS
schemes repetitively for given workloads and systems combinations.

Self-tuned DAMON-based Memory Tiering
=====================================

To solve such manual tuning problems, DAMOS provides aim-oriented
feedback-driven quotas self-tuning.  Using the feature, we design
Self-tuned DAMON-based memory tiering for general multi-tiers memory
systems.

For each memory tier node, if it has a lower tier, run a DAMOS scheme
that demotes cold pages of the node, auto-tuning the aggressiveness
aiming a small amount of free space ratio of the node.  The free space
is for keeping the space to avoid memory pressure while promoting hot
pages from the lower tier to the tier.  About 0.5% could be recommended
by default.

For each memory tier node, if it has a upper tier, run a DAMOS scheme
that promotes hot pages of the node, auto-tuning the aggressiveness
aiming a high utilization ratio of the node.  The target ratio is to
ensure higher tiers are utilized as much as possible.  It should match
with the headroom for demotion scheme, but as slightly overlap with it,
to ensure hot and pages exchange is not stopped.  For example, 99.7 %
could be recommended by default.

To make implementation of the tiering solution, DAMOS need new quota
goal metrics for utilization and free space ratio of specific NUMA node.
This patch series introduces the two new quota goal metrics.

Discussions
===========

Expected Behavior
-----------------

The system will let upper tier memory node accommodates as many hot data
as possible.  If total amount of the memory is less than the top tier
memory's promotion/demotion target utilization, entire data will be
just placed on the top tier.  Promotion scheme will do nothing since
there is no data to promote.  Demotion scheme will also do nothing since
the free space ratio of the top tier is higher than the goal.

If the amount of data is larger than the top tier's utilization ratio,
demotion scheme will demote cold pages and ensure the headroom free
space.  Since the promotion and demotion schemes for a single node has
small overlap at their target utilization and free space goals,
promotions and demotions will continue working with a moderate
aggressiveness level.  IT will keep all data is placed on access
hotness, while minimizing migration overhead.

In any case, each node will keep headroom free space and as many upper
tiers are utilized as possible.

Ease of Use
-----------

Users still need to set the target utilization and free space ratio, but
it will be easier to set.  We argue 99.7 % utilization and 0.5 % free
space ratios are good default values.  Users are also still required to
answer the minimum coldness and hotness thresholds.  Together with
monitoring intervals auto-tuning[2], DAMON will always show meaningful
amount of hot and cold memory.  And DAMOS quota's prioritization
mechanism will make good decision as long as the source information is
that colorful.  Hence, users can very naively set the minimum criterias.
We believe any access observation and no access observation within last
one aggregation interval is enough for minimum hot and cold regions
criterias.

The design can be applied to any number of tiers having any performance
characteristics, as long as they can be hierarchical.  Hence, applying
the system to different tiered memory system will be straightforward.
Note that this assumes only single CPU NUMA node case.  Because DAMON of
today has no ability to get source of access information, applying this
on systems having multiple CPU NUMA nodes can be complicated.  In
future, DAMON might gain the access source information, but that's out
of the scope of this patch series.

How To Use
----------

Users can implement the auto-tuned DAMON-based memory tiering using
DAMON sysfs interface.  It can be easily done using DAMON user-space
tool like user-space tool.  For wider and simpler deployment, having a
kernel module that sets up and run the DAMOS schemes, using DAMON kerenl
API can be useful.  The module can enable the memory tiering at boot
time via kernel command line parameter or at run time with single
command.  This patch series implements a sample kernel module that shows
how such module can be implemented.

Comparison To Page Faults and LRU-based Approaches
--------------------------------------------------

The existing page faults based promotion (NUMAB-2) does hot pages
detection and migration in the process context.  When there are many
pages to promote, it can block the progress of the application's real
works.  DAMOS works in asynchronous worker thread, so it doesn't block
the real works.

NUMAB-2 doesn't provide a way to control aggressiveness of promotion
other than the maximum amount of pages to promote per given time widnow.
If hot pages are found, promotions can happen in the upper-bound speed,
regardless of current upper tier memory utilization.  If the maximum
speed is not well set for the given workload, it can result in slow
promotion or unnecessary memory pressure.  Self-tuned DAMON-based memory
tiering alleviates the problem by adjusting the speed based on current
utilization of the upper tier.

LRU-based demotion can triggered in both asynchronous (kswapd) and
synchronous (direct reclaim) ways.  Other than the way of finding cold
pages, asynchronous LRU-based demotion and DAMON-based demotion has no
big difference.  DAMON-based demotion can make a better balancing with
DAMON-based promotion, with the adaptive aggressiveness, though.  The
synchronous LRU-based demotion can do better than DAMON-based demotion
when the tier is having significant memory pressure.  It would be wise
to use DAMON-based demotion as a proactive and primary one, but
utilizing LRU-based demotions together as a fast backup solution.

Evaluation
==========

In short, under a setup that requires fast and frequent promotions,
self-tuning DAMON-based memory tiering's hot pages promotion improves
performance about 4.42 %.  We believe this shows self-tuned DAMON-based
promotion's effectiveness and a practical level of DAMON monitoring
results accuracy.  Meanwhile, NUMAB-2's hot pages promotion degrades the
performance about 7.34 %.  We suspect the degradation is mostly due to
NUMAB-2's synchronous nature that can block the application's progress,
which highlights advantage of DAMON-based solution's asynchronous
nature.  More detailed investigation and evaluation of DAMON-based
demotion solution are assigned as future works.

Setup
-----

Hardware.  Use a machine that equips 250 GiB DRAM memory tier and 50 GiB
CXL memory tier.  The tiers are exposed as NUMA nodes 0 and 1,
respectively.

Kernel.  Use Linux kernel v6.13 that modified as following.  Add all
DAMON patches that available on mm tree of 2025-03-15, and this patch
series.  Also modify it to ignore mempolicy() system calls, to avoid bad
effects from application's traditional NUMA systems assumed
optimizations.

Workload.  Use a modified version of Taobench benchmark that available
on DCPerf benchmark suite.  It represents an in-memory caching workload.
We set its 'memsize', 'warmup_time', and 'test_time' parameter as
340 GiB, 2,500 seconds and 1,440 seconds.  The parameters are chosen to
ensure the workload uses more than DRAM memory tier.  Its RSS under the
parameter grows to 270 GiB within the warmup time.

It turned out the workload has a very static access pattrn.  Only about
13 % of the RSS is frequently accessed from the beginning to end.  Hence
promotion shows no meaningful performance difference regardless of
different design and implementations.  We therefore modify the kernel to
periodically demote up to 10 GiB hot pages and promote up to 10 GiB cold
pages once per minute.  The intention is to simulate periodic access
pattern changes.  This is why we call the workload as "modified".  It is
implemented as two DAMOS schemes.

System configurations.  Use below variant system configurations.

- Baseline.  No memory tiering features are turned on.
- Numab_tiering.  On the baseline, enable NUMAB-2 and relcaim-based
  demotion.  In detail, following command is executed:
  echo 2 > /proc/sys/kernel/numa_balancing;
  echo 1 > /sys/kernel/mm/numa/demotion_enabled;
  echo 7 > /proc/sys/vm/zone_reclaim_mode
- DAMON_tiering.  On the baseline, utilize self-tuned DAMON-based memory
  tiering implementation via DAMON user-space tool.  It utilizes two
  kernel threads, namely promotion thread and demotion thread.  Demotion
  thread monitors access pattern of DRAM node using DAMON with
  auto-tuned monitoring intervals aiming 4% DAMON-observed access ratio,
  and demote coldest pages up to 200 MiB per second aiming 0.5% free
  space of DRAM node.  Promotion thread monitors CXL node using same
  intervals auto-tuning, and promote hot pages in same way but aiming
  for 99.7% utilization of DRAM node.  Because DAMON provides only
  best-effort accuracy, add young page DAMOS filters to allow only and
  reject all young pages at promoting and demoting, respectively.

Measurment Results
------------------

On each system configuration, run the modified version of Taobench and
collect 'score'.  'score' is a metric that calculated and provided by
Taobench to represents the performance of the run on the  system.  To
handle the measurement errors, repeat the measurement five times.  The
results are as below.

    Config         Score   Stdev   (%)     Normalized
    Baseline       1.6165  0.0319  1.9764  1.0000
    Numab_tiering  1.4976  0.0452  3.0209  0.9264
    DAMON_tiering  1.6881  0.0249  1.4767  1.0443

'Config' column shows the system config of the measurement.  'Score'
column shows the 'score' measurement in average of the five runs on the
system config.  'Stdev' column shows the standsard deviation of the five
measurements of the scores.  '(%)' column shows the 'Stdev' to 'Score'
ratio in percentage.  Finally, 'Normalized' column shows the averaged
score values of the configs that normalized to that of 'Baseline'.

The periodic hot pages demotion and cold pages promotion that was
conducted to simulate dynamic access pattern was started from the
beginning of the workload.  It resulted in the DRAM tier utilization
always under the watermark, and hence no real demotion was happened for
all test runs.  This means the above results show no difference between
LRU-based and DAMON-based demotions.  Only difference between NUMAB-2
and DAMON-based promotions are represented on the results.

Numab_tiering config degraded the performance about 7.36 %.  We suspect
this is because NUMAB-2's synchronous promotion was blocking the
Taobench's real work progress.

DAMON_tiering config improved the performance about 4.43 %.  We believe
this shows effectiveness of DAMON-based promotion that didn't block
Taobench's real work progress due to its asynchronous nature.  Also this
means DAMON's monitoring results are accurate enough to provide visible
amount of improvement.

Evaluation Limitations
----------------------

As mentioned above, this evaluation shows only comparison of promotion
mechanisms.  DAMON-based tiering is recommended to used together with
reclaim-based demotion as a faster backup under significant memory
pressure, though.

From some perspective, the modified version of Taobench may seems making
the picture distorted too much.  It would be better to evaluate with
more realistic workload, or more fairly set micro benchmarks.

Request For Comments and Upstream Plan
======================================

This patch series is for getting comments, and hence having [RFC] tag.
We're looking for comments about topics including but not limited to
- misunderstood backgrounds,
- confusing explanations,
- better evaluation setup suggestion,
- request of details such as evaluation reproduction steps, and
- whether this makes sense at all.

Hopefully we will share this patch series as WIP future plan at DAMON
updates and plans session at LSFMMBPF next week and get more comments.

Unless serious concerns are found, we will upstream the new DAMOS quota
goal metrics part of this patch series first.  That's because the
changes are small but can be useful user-space driven memory tiering and
even other NUMA-based DAMOS schemes.

Upstreaming of the memory tiering module part of this RFC patch series
will be done more later.  The part is for showing how the module can be
implemented, and far from its complete form.  Especially, it is assuming
only two tiers and asking users to set the address range of the nodes.
Those should be automated in the final version for upstreaming.

Patch Sequence
==============

The first patch (patch 1) implements the two new quota goal metrics on
core layer and expose it to DAMON core kernel API.  The second and third
ones (patches 2 and 3) further link it to DAMON sysfs interface.  The
final and fourth one (patch 4) implements a specific self-tuned
DAMON-based memory tiering solution in an incomplete but easy to
understand form as a kernel module under samples/damon/ directory.

References
==========

[1] https://lore.kernel.org/20231112195602.61525-1-sj@kernel.org/
[2] https://lore.kernel.org/20250303221726.484227-1-sj@kernel.org

SeongJae Park (4):
  mm/damon/core: introduce two damos quota goal metrics for NUMA memory
    utilization and free space ratios
  mm/damon/sysfs-schemes: implement file for quota goal nid parameter
  mm/damon/sysfs-schemes: connect damos_quota_goal nid with core layer
  samples/damon: implement a DAMON module for memory tiering

 include/linux/damon.h    |   6 ++
 mm/damon/core.c          |  27 +++++++
 mm/damon/sysfs-schemes.c |  40 +++++++++-
 samples/damon/Kconfig    |  13 +++
 samples/damon/Makefile   |   1 +
 samples/damon/mtier.c    | 167 +++++++++++++++++++++++++++++++++++++++
 6 files changed, 253 insertions(+), 1 deletion(-)
 create mode 100644 samples/damon/mtier.c


base-commit: a95a9039462356c73ba28bcd2a1622311dafdab8
-- 
2.39.5

