Return-Path: <linux-kernel+bounces-542813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E66E3A4CE13
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 23:17:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EDF717304C
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 22:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9764A22F3AB;
	Mon,  3 Mar 2025 22:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rO2RXlYJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE441DFE1;
	Mon,  3 Mar 2025 22:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741040252; cv=none; b=YETfzal8ndAKONBHpYF5BSorKD+OFXxVZNrpydKBMr+r19xDnwHuH/SqVo5rve8uH0KuH+pS+SnnxeBn9vG2kiDpKo+30WsN2lGkUUNNdW9np6B1U++jhn0c/0z2hqR7n5YuPuoi/JlIRyJGwEf7eQqlOw24a1rli0JUtFtT+sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741040252; c=relaxed/simple;
	bh=7kMhJrsuHoyhhxHw8CA0cgQFlcSyx8x1axGfPstjeGk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=L05buD6KurnQb7wbEJR1+0GLonO9QAZQokkqoKFEgdeMR0Pb+/nD1Ld0DefWyTVrkBuqKnNunMhfNuU4oPpMSbGMJo9rtJUH3kSncWYPDt23DYwDV4u+IM3n5sWMkFAYVwefhnRT+d/Dsmr4onC4ICLzb3EzS323fGHzz9waHFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rO2RXlYJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89F4EC4CED6;
	Mon,  3 Mar 2025 22:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741040251;
	bh=7kMhJrsuHoyhhxHw8CA0cgQFlcSyx8x1axGfPstjeGk=;
	h=From:To:Cc:Subject:Date:From;
	b=rO2RXlYJTwKA2B/TggHkNlV3kBx0JUffUWZw+ZA4LVL/CtiAmFfDjYovTXlS895r2
	 yCQ2zPJwB5XQm8Et1/eHOcysg6B1O1bc2XZ4tadOPFdc5AH9bPcXu4qWG4MUaYE5BJ
	 UEuvgJayZO29n5K5M9Nr+OjdLRLfkdP+9dNn0C17kFEz4ARD3dFegmLnOKVcC9d97b
	 su+dwkAXhfNshWZ5MMYGEcA6uRAV/IcRNJsQ1IVOWh2Zsn/s5sSOqGuUaagdrxJ8mg
	 vOxdStg2NDnpoUwJwAhPC8uscxFYsynLvfxZMvPzVkghA4Ypzge1mXlRaX5GU3nkec
	 EsXhuV9RWo1RA==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 0/8] mm/damon: auto-tune aggregation interval
Date: Mon,  3 Mar 2025 14:17:18 -0800
Message-Id: <20250303221726.484227-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON requires time-consuming and repetitive aggregation interval
tuning.  Introduce a feature for automating it using a feedback loop
that aims an amount of observed access events, like auto-exposing
cameras.

Background: Access Frequency Monitoring and Aggregation Interval
================================================================

DAMON checks if each memory element (damon_region) is accessed or not
for every user-specified time interval called 'sampling interval'.  It
aggregates the check intervals on per-element counter called
'nr_accesses'.  DAMON users can read the counters to get the access
temperature of a given element.  The counters are reset for every
another user-specified time interval called 'aggregation interval'.

This can be illustrated as DAMON continuously capturing a snapshot of
access events that happen and captured within the last aggregation
interval.  This implies the aggregation interval plays a key role for
the quality of the snapshots, like the camera exposure time.  If it is
too short, the amount of access events that happened and captured for
each snapshot is small, so each snapshot will show no many interesting
things but just a cold and dark world with hopefuly one pale blue dot or
two.  If it is too long, too many events are aggregated in a single
shot, so each snapshot will look like world of flames, or Muspellheim.
It will be difficult to find practical insights in both cases.

Problem: Time Consuming and Repetitive Tuning
=============================================

The appropriate length of the aggregation interval depends on how
frequently the system and workloads are making access events that DAMON
can observe.  Hence, users have to tune the interval with excessive
amount of tests with the target system and workloads.  If the system and
workloads are changed, the tuning should be done again.  If the
characteristic of the workloads is dynamic, it becomes more challenging.
It is therefore time-consuming and repetitive.

The tuning challenge mainly stems from the wrong question.  It is not
asking users what quality of monitoring results they want, but how DAMON
should operate for their hidden goal.  To make the right answer, users
need to fully understand DAMON's mechanisms and the characteristics of
their workloads.  Users shouldn't be asked to understand the underlying
mechanism.  Understanding the characteristics of the workloads shouldn't
be the role of users but DAMON.

Aim-oriented Feedback-driven Auto-Tuning
=========================================

Fortunately, the appropriate length of the aggregation interval can be
inferred using a feedback loop.  If the current snapshots are showing no
much intresting information, in other words, if it shows only rare
access events, increasing the aggregation interval helps, and vice
versa.  We tested this theory on a few real-world workloads, and
documented one of the experience with an official DAMON monitoring
intervals tuning guideline.  Since it is a simple theory that requires
repeatable tries, it can be a good job for machines.

Based on the guideline's theory, we design an automation of aggregation
interval tuning, in a way similar to that of camera auto-exposure
feature.  It defines the amount of interesting information as the ratio
of DAMON-observed access events that DAMON actually observed to
theoretical maximum amount of it within each snapshot.  Events are
accounted in byte and sampling attempts granularity.  For example, let's
say there is a region of 'X' bytes size.  DAMON tried access check
smapling for the region 'Y' times in total for a given aggregation.
Among the 'Y' attempts, 'Z' times it shown positive results.  Then, the
theoritical maximum number of access events for the region is 'X * Y'.
And the number of access events that DAMON has observed for the region
is 'X * Z'.  The abount of the interesting information is
'(X * Z / X * Y)'.  Note that each snapshot would have multiple regions.

Users can set an arbitrary value of the ratio as their target.  Once the
target is set, the automation periodically measures the current value of
the ratio and increase or decrease the aggregation interval if the ratio
value is lower or higher than the target.  The amount of the change is
proportion to the distance between the current adn the target values.

To avoid auto-tuning goes too long way, let users set the minimum and
the maximum aggregation interval times.  Changing only aggregation
interval while sampling interval is kept makes the maximum level of
access frequency in each snapshot, or discernment of regions
inconsistent.  Also, unnecessarily short sampling interval causes
meaningless monitoring overhed.  The automation therefore adjusts the
sampling interval together with aggregation interval, while keeping the
ratio between the two intervals.  Users can set the ratio, or the
discernment.

Discussion
==========

The modified question (aimed amount of access events, or lights, in each
snapshot) is easy to answer by both the users and the kernel.  If users
are interested in finding more cold regions, the value should be lower,
and vice versa.  If users have no idea, kernel can suggest a fair
default value based on some theories and experiments.  For example,
based on the Pareto principle (80/20 rule), we could expect 20% target
ratio will capture 80% of real access events.  Since 80% might be too
high, applying the rule once again, 4% (20% * 20%) may capture about 56%
(80% * 80%) of real access events.

Sampling to aggregation intervals ratio and min/max aggregation
intervals are also arguably easy to answer.  What users want is
discernment of regions for efficient system operation, for examples, X
amount of colder regions or Y amount of warmer regions, not exactly how
many times each cache line is accessed in nanoseconds degree.  The
appropriate min/max aggregation interval can relatively naively set, and
may better to set for aimed monitoring overhead.  Since sampling
interval is directly deciding the overhead, setting it based on the
sampling interval can be easy.  With my experiences, I'd argue the
intervals ratio 0.05, and 5 milliseconds to 20 seconds sampling interval
range (100 milliseconds to 400 seconds aggregation interval) can be a
good default suggestion.

Evaluation
==========

On a machine running a real world server workload, I ran DAMON to
monitor its physical address space for about 23 hours, with this feature
turned on.  We set it to tune sampling interval in a range from 5
milliseconds to 10 seconds, aiming 4 % DAMON-observed access ratio per
three aggregation intervals.  The exact command I used is as below.

    damo start --monitoring_intervals_goal 4% 3 5ms 10s --damos_action stat

During the test run, DAMON continuously updated sampling and aggregation
intervals as designed, within the given range.  For all the time, DAMON
was able to find the intervals that meets the target access events ratio
in the given intervals range (sampling interval between 5 milliseconds
and 10 seconds).

For most of the time, tuned sampling interval was converged in 300-400
milliseconds.  It made only small amount of changes within the range.
The average of the tuned sampling interval during the test was about 380
milliseconds.

The workload periodically gets less load and decreases its CPU usage.
Presumably this also caused it making less memory access events.
Reactively to such event,s DAMON also increased the intervals as
expected.  It was still able to find the optimum interval that
satisfying the target access ratio within the given intervals range.
Usually it was converged to about 5 seconds.  Once the workload gets
normal amount of load again, DAMON reactively reduced the intervals to
the normal range.

I collected and visualized DAMON's monitoring results on the server a
few times.  Every time the visualized access pattern looked not biased
to only cold or hot pages but diverse and balanced.  Let me show some of
the snapshots that I collected at the nearly end of the test (after
about 23 hours have passed since starting DAMON on the server).

The recency histogram looks as below.  Please note that this
visualization shows only a very coarse grained information.  For more
details about the visualization format, please refer to DAMON user-space
tool documentation[1].

    # ./damo report access --style recency-sz-hist --tried_regions_of 0 0 0 --access_rate 0 0
    <last accessed time (us)> <total size>
    [-19 h 7 m 45.514 s, -17 h 12 m 58.963 s)  6.198 GiB  |****                |
    [-17 h 12 m 58.963 s, -15 h 18 m 12.412 s) 0 B        |                    |
    [-15 h 18 m 12.412 s, -13 h 23 m 25.860 s) 0 B        |                    |
    [-13 h 23 m 25.860 s, -11 h 28 m 39.309 s) 0 B        |                    |
    [-11 h 28 m 39.309 s, -9 h 33 m 52.757 s)  0 B        |                    |
    [-9 h 33 m 52.757 s, -7 h 39 m 6.206 s)    0 B        |                    |
    [-7 h 39 m 6.206 s, -5 h 44 m 19.654 s)    0 B        |                    |
    [-5 h 44 m 19.654 s, -3 h 49 m 33.103 s)   0 B        |                    |
    [-3 h 49 m 33.103 s, -1 h 54 m 46.551 s)   0 B        |                    |
    [-1 h 54 m 46.551 s, -0 ns)                16.967 GiB |*********           |
    [-0 ns, --6886551440000 ns)                38.835 GiB |********************|
    memory bw estimate: 9.425 GiB per second
    total size: 62.000 GiB

It shows about 38 GiB of memory was accessed at least once within last
aggregation interval (given ~300 milliseconds tuned sampling interval,
this is about six seconds).  This is about 61 % of the total memory.  In
other words, DAMON found warmest 61 % memory of the system.  The number
is particularly interesting given our Pareto principle based theory for
the tuning goal value.  We set it as 20 % of 20 % (4 %), thinking it
would capture 80 % of 80 % (64 %) real access events.  And it foudn 61 %
hot memory, or working set.  Nevertheless, to make the theory clearer,
much more discussion and tests would be needed.  At the moment,
nonetheless, we can say making the target value higher helps finding
more hot memory regions.

The histogram also shows an amount of cold memory.  About 17 GiB memory
of the system has not accessed at least for last aggregation interval
(about six seconds), and at most for about last two hours.  The real
longest unaccessed time of the 17 GiB memory was about 19 minutes,
though.  This is a limitation of this visualization format.

It further found very cold 6 GiB memory.  It has not accessed at least for last
17 hours and at most 19 hours.

What about hot memory distribution?  To see this, I capture and
visualize the snapshot in access temperature histogram.  Again, please
refer to the DAMON user-space tool documentation[1] for the format and
what access temperature mean.   Both the visualization and metric shows
only very coarse grained and limited information.  The resulting
histogram look like below.

    # ./damo report access --style temperature-sz-hist --tried_regions_of 0 0 0
    <temperature> <total size>
    [-6,840,763,776,000, -5,501,580,939,800) 6.198 GiB  |***                 |
    [-5,501,580,939,800, -4,162,398,103,600) 0 B        |                    |
    [-4,162,398,103,600, -2,823,215,267,400) 0 B        |                    |
    [-2,823,215,267,400, -1,484,032,431,200) 0 B        |                    |
    [-1,484,032,431,200, -144,849,595,000)   0 B        |                    |
    [-144,849,595,000, 1,194,333,241,200)    55.802 GiB |********************|
    [1,194,333,241,200, 2,533,516,077,400)   4.000 KiB  |*                   |
    [2,533,516,077,400, 3,872,698,913,600)   4.000 KiB  |*                   |
    [3,872,698,913,600, 5,211,881,749,800)   8.000 KiB  |*                   |
    [5,211,881,749,800, 6,551,064,586,000)   12.000 KiB |*                   |
    [6,551,064,586,000, 7,890,247,422,200)   4.000 KiB  |*                   |
    memory bw estimate: 5.178 GiB per second
    total size: 62.000 GiB

We can see most of the memory is in similar access temperature range,
and definitely some pages are extremely hot.

To see the picture in more detail, let's capture and visualize the
snapshot per DAMON-region, sorted by their access temperature.  The
total number of the regions was about 300.  Due to the limited space,
I'm showing only a few parts of the output here.

    # ./damo report access --style hot --tried_regions_of 0 0 0
    heatmap: 00000000888888889999999888888888888888888888888888888888888888888888888888888888
    # min/max temperatures: -6,827,258,184,000, 17,589,052,500, column size: 793.600 MiB
     |999999999999999999999999999999999999999| 4.000 KiB   access 100 % 18 h 9 m 43.918 s
     |999999999999999999999999999999999999999| 8.000 KiB   access 100 % 17 h 56 m 5.351 s
     |999999999999999999999999999999999999999| 4.000 KiB   access 100 % 15 h 24 m 19.634 s
     |999999999999999999999999999999999999999| 4.000 KiB   access 100 % 14 h 10 m 55.606 s
     |999999999999999999999999999999999999999| 4.000 KiB   access 100 % 11 h 34 m 18.993 s
    [...]
               |99999999999999999999999999999| 8.000 KiB   access 100 % 1 m 27.945 s
               |11111111111111111111111111111| 80.000 KiB  access 15 %  1 m 21.180 s
               |00000000000000000000000000000| 24.000 KiB  access 5 %   1 m 21.180 s
               |00000000000000000000000000000| 5.919 GiB   access 10 %  1 m 14.415 s
               |99999999999999999999999999999| 12.000 KiB  access 100 % 1 m 7.650 s
    [...]
                                           |0| 4.000 KiB   access 5 %   0 ns
                                           |0| 12.000 KiB  access 5 %   0 ns
                                           |0| 188.000 KiB access 0 %   0 ns
                                           |0| 24.000 KiB  access 0 %   0 ns
                                           |0| 48.000 KiB  access 0 %   0 ns
    [...]
             |0000000000000000000000000000000| 8.000 KiB   access 0 %   6 m 45.901 s
            |00000000000000000000000000000000| 36.000 KiB  access 0 %   7 m 26.491 s
            |00000000000000000000000000000000| 4.000 KiB   access 0 %   12 m 37.682 s
           |000000000000000000000000000000000| 8.000 KiB   access 0 %   18 m 9.168 s
           |000000000000000000000000000000000| 16.000 KiB  access 0 %   19 m 3.288 s
    |0000000000000000000000000000000000000000| 6.198 GiB   access 0 %   18 h 57 m 52.582 s
    memory bw estimate: 8.798 GiB per second
    total size: 62.000 GiB

We can see DAMON found small and extremely hot regions that accessed for
all access check sampling (once per about 300 milliseconds) for more
than  10 hours.  The access temperature rapidly decreases.  DAMON was
also able to find small and big regions that not accessed for up to
about 19 minutes.  It even found an outlier cold region of 6 GiB that
not accessed for about 19 hours.  It is unclear what the outlier region
is, as of this writing.

For the testing, DAMON was consuming about 0.1% of single CPU time.
This is again expected results, since DAMON was using about 370
milliseconds sampling interval in most case.

    # ps -p $kdamond_pid -o %cpu
    %CPU
     0.1

I also ran similar tests against kernel build workload and an in-memory
cache workload benchmark[2].  Detialed results including tuned intervals
and captured access pattern were of course different sicne those depend
on the workloads.  But the auto-tuning feature was always working as
expected like the above results for the real world workload.

To wrap up, with intervals auto-tuning feature, DAMON was able to
capture access pattern snapshots of a quality on a real world server
workload.  The auto-tuning feature was able to adaptively react to the
dynamic access patterns of the workload and reliably provide consistent
monitoring results without manual human interventions.  Also, the
auto-tuning made DAMON consumes only necessary amount of resource for
the required quality.

Changelog
=========

Changes from RFC v2
(https://lore.kernel.org/20250228220328.49438-1-sj@kernel.org)
- Add detailed evaluation results on cover letter

Changes from RFC v1
(https://lore.kernel.org/20250213014438.145611-1-sj@kernel.org)
- Replace the target metric from positive samples ratio to
  DAMON-observed access samples ratio
- Fix wrong max events accounting bug
- Fix double-increase of next_aggregation_sis

References
==========

[1] https://github.com/damonitor/damo/blob/next/USAGE.md#access-report-styles
[2] https://github.com/facebookresearch/DCPerf/blob/main/packages/tao_bench/README.md

SeongJae Park (8):
  mm/damon: add data structure for monitoring intervals auto-tuning
  mm/damon/core: implement intervals auto-tuning
  mm/damon/sysfs: implement intervals tuning goal directory
  mm/damon/sysfs: commit intervals tuning goal
  mm/damon/sysfs: implement a command to update auto-tuned monitoring
    intervals
  Docs/mm/damon/design: document for intervals auto-tuning
  Docs/ABI/damon: document intervals auto-tuning ABI
  Docs/admin-guide/mm/damon/usage: add intervals_goal directory on the
    hierarchy

 .../ABI/testing/sysfs-kernel-mm-damon         |  30 +++
 Documentation/admin-guide/mm/damon/usage.rst  |  25 ++
 Documentation/mm/damon/design.rst             |  50 ++++
 include/linux/damon.h                         |  43 ++++
 mm/damon/core.c                               |  98 ++++++++
 mm/damon/sysfs.c                              | 216 ++++++++++++++++++
 6 files changed, 462 insertions(+)


base-commit: 2ade695ab17eb4005f006001aa9c51ad22d2f206
-- 
2.39.5

