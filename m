Return-Path: <linux-kernel+bounces-512154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 394A4A334E6
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 02:44:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1318167538
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 01:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EA14142E77;
	Thu, 13 Feb 2025 01:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hAEZ/IWO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CBA214037F;
	Thu, 13 Feb 2025 01:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739411091; cv=none; b=qEZMIo7MbFnmSe66xYDBRcclt2sir/TY/oxuF/nEZd4QWV36vIBrVLEOS79voTkpb+O0pzToLdsTth1emrcfymNR9UEwUyRmfXB7VoxXa0kE1w0w4CVBYHG0jH0+hMWyVqdHWLgHxKKVRmbgOn3oy782Z+GgyrZlu1cFG+lKiCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739411091; c=relaxed/simple;
	bh=olXBav6CKqcfpxooRDtGfAnr1eu6Xdsee3Taqi4Maco=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=I/Jkbsz3Yo2e76Sm2iKwHVD4NFVhCTDkAZgzPywBTHK6OVyIY6qlH8/lAc6HRz3f6NehsytzCCWdlfLF1+EpYIT8tZG3PBL9gz/85UAnBmFP2Jyb+JYyCAuVp5olk+PsaTL2NqTBJUSZYaKYksvVmuWDkTeReLjnuF0htGzAGvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hAEZ/IWO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABAD6C4CEDF;
	Thu, 13 Feb 2025 01:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739411090;
	bh=olXBav6CKqcfpxooRDtGfAnr1eu6Xdsee3Taqi4Maco=;
	h=From:To:Cc:Subject:Date:From;
	b=hAEZ/IWOPGugUt6Zhsm3o8ZFAJp25JzElRJuJSVCvjg/0eoIiC9ErDI890Xs2DnCL
	 CW7CpDfTqV+S9o3gmRibBFpd63WKYqS+Sag3eMjfH3qRQzAiG/y4CHoCvVqLHRiMm2
	 dnhZjHzCUVd0wLoAGwJ/ea/g60qfHFJJUpN2suLvWggsR0o2nFKTcYpD2IlE6hI/FP
	 l15Gk0fILVMPv6biQSYSdZeYvxN2pT42eHo+Zh1MYSTzgyk1dInkDGg8cVJwxi7VIy
	 AZ02vOkW0+mx3BA0/yVa2Il95eXzxbYO+2C/V2lWtORT6xCGLydlk7Vr83V4Oy+FtE
	 K0mzGVPDvTT5Q==
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
Subject: [RFC PATCH 0/8] mm/damon: auto-tune aggregation interval
Date: Wed, 12 Feb 2025 17:44:30 -0800
Message-Id: <20250213014438.145611-1-sj@kernel.org>
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
of captured access events to total capturing attempts of single snapshot,
or more technically speaking, the ratio of positive access check samples
to total samples within the aggregation interval.  It allows the users
to set the target value of the ratio.  Once the target is set, the
automation periodically measures the current value of the ratio and
increase or decrease the aggregation interval if the ratio value is
lower or higher than the target.  The amount of the change is proportion
to the distance between current value and the target value.

To avoid auto-tuning goes too long way, let users set minimum and
maximum aggregation interval time.  Changing only aggregation interval
while sampling interval is kept make the maximum level of access
frequency in each snapshot, or discernment of regions inconsistent.
Also, unnecessarily short sampling interval causes meaningless
monitoring overhed.  The automation therefore adjusts the sampling
interval together with aggregation interval, while keeping the ratio
between the two intervals.  Users can set the ratio, or the discernment.

Discussion
==========

The modified question (aimed amount of heats in each snapshot) is easy
to answer by both the users and the kernel.  If users are interested in
finding more cold regions, the value should be lower, and vice versa.
If users have no idea, kernel can suggest about 20% positive access
samples ratio as a fair default value based on the Pareto principle.

Sampling to aggregation intervals ratio and min/max aggregation
intervals are also arguably easy to answer.  What users want is
discernment of regions for efficient system operation, for examples, X
amount of colder regions or Y amount of warmer regions, not exactly how
many times each cache line is accessed in nanoseconds degree.  The
appropriate min/max aggregation interval can relatively naively set, and
may better to set for aimed monitoring overhead.  Since sampling
interval is directly related with the overhead, setting it based on the
sampling interval can be easy.  With my experiences, I'd argue the
intervals ratio 0.05, and 5 milliseconds to 20 seconds sampling interval
range (100 milliseconds to 400 seconds aggregation interval) can be a
good default suggestions.

Evaluation
==========

We confirmed the tuning works as expected with only a few simple
workloads including kernel builds, and that's why this is an RFC.  We
will conduct more evaluations with more massive and realistic workloads
and share the results by the time that we drop the RFC tag.

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
 Documentation/mm/damon/design.rst             |  38 +++
 include/linux/damon.h                         |  43 ++++
 mm/damon/core.c                               |  90 ++++++++
 mm/damon/sysfs.c                              | 216 ++++++++++++++++++
 6 files changed, 442 insertions(+)


base-commit: d5c35650f4945e1406871f9d9d51ab8c54ec0d03
-- 
2.39.5

