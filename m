Return-Path: <linux-kernel+bounces-539530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7773BA4A591
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 23:03:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 451FF3A5E2D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 22:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 857051DE2CD;
	Fri, 28 Feb 2025 22:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i5N8aWN9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1AD01C700A;
	Fri, 28 Feb 2025 22:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740780211; cv=none; b=Oxoh0sVYa1ZS7DPIrmGZ5rNEk0b3paySnCstOsaeEJDUOh0hpmH0mV0AVyjtaqKaHEoE9E6YqlMGZIBgNJQ6JhVSytmTHViR5c4OvRXS02dUFn42xwqQnGxXePwmMZvdathuypFEfY9xJqTfO7kYQjH9w3vD5AHPLd8JqhTJsgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740780211; c=relaxed/simple;
	bh=Zt0lUEdiXddoi07OHZAKDs4YA/iQzIVjey7pxY0i+U8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Eng6dlE7eBrLLDFzN/Hen0aGt+3zBh99ov/CSKNmdKYRFOxjqaYvOz38fhIU7O56uS9g40gaM/+7LmrVv5FvO1IYKecx5tMci9yML43iXXiOR/t4FzPhE59KYBt4VTEDpBFEa2I52b1bmwiGX1A190LKdfqu7zMs3V7WKAbJ+5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i5N8aWN9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10100C4CED6;
	Fri, 28 Feb 2025 22:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740780211;
	bh=Zt0lUEdiXddoi07OHZAKDs4YA/iQzIVjey7pxY0i+U8=;
	h=From:To:Cc:Subject:Date:From;
	b=i5N8aWN96hU0WTEh499DBC0G3jNX+Wb1bz6WokrK2VmJ1gL365vyPI45SAElFE7Mb
	 fCCQ1UnPEDv44B0xImWIoheYh0ZHiUiHGFFZrba64W5uuf25qjyoHSsXlaSmVv5XVd
	 uILs+X5x2bmtYMlvpTbnRUGeF2GwigPEMV+AM/DpiJD6v73BfEVeu2OqIHETOlnCqV
	 8jvN/RlaOzBsYDe5XTaSpWhYwMSxy0/vLJMHdd8htYEf4wB5pfHa8yps2PQgoV6KTy
	 1iRcz2ODEJbqcE7zZxVCepZUTEfKq6FeeB+4FbC1gvsj2hER6JH8OGiDJMvObDwwYC
	 IXxYXSGO3uMqA==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2 0/8] mm/damon: auto-tune aggregation interval
Date: Fri, 28 Feb 2025 14:03:20 -0800
Message-Id: <20250228220328.49438-1-sj@kernel.org>
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

We confirmed the tuning works as expected with a few simple workloads
including kernel builds and an in-memory caching representative
benchmark[1].  We will conduct more evaluations with more workloads and
share the results with more details by the time that we drop the RFC
tag.

Changelog
=========

Changes from RFC v1
(https://lore.kernel.org/20250213014438.145611-1-sj@kernel.org)
- Replace the target metric from positive samples ratio to
  DAMON-observed access samples ratio
- Fix wrong max events accounting bug
- Fix double-increase of next_aggregation_sis

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


base-commit: 9e7d9145ab8ce407acc540fc29133c471bc29046
-- 
2.39.5

