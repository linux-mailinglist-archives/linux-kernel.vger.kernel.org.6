Return-Path: <linux-kernel+bounces-377145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E84D9ABA64
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 02:09:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DA051C22FBA
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 00:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A1534C79;
	Wed, 23 Oct 2024 00:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YxgRb8Fc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD09211C
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 00:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729642170; cv=none; b=FTV9w/kscy11BYeaellXL1xUZAyP3pp1GUnoG/fVs/dv1EhJqpp0muJFlKFCtv0Gke8aXyKj0uLqcgq+WU0dZfxT4TtAq/hU1m6PZ8dpX18850sbzoMk3k+RPBqpChUmmCp4FpFfS6dEYUyKvIIlE+lQraTJ61f0bj7AlSgU3l0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729642170; c=relaxed/simple;
	bh=+9ImHzQM83ukdUpgROB2C6IE07UJCS2V4nHqORAMoyM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=llwnzK4t9r4Ts/GCTDVMiEaQvDgoGduvCtudDVJVwBwiNPFfwnvpO5lFsBUm0MY1jKQ2is63bs2NeSCNstXkzM2Oo0ls+UR0dhBa7Th2PudGLA+daEhrJ1FgBlaKbJpmH2x+Cl+3e20CJJs7t5Jm4DRulKgU0J2AEPsAy70Mna4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YxgRb8Fc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9B49C4AF09;
	Wed, 23 Oct 2024 00:09:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729642170;
	bh=+9ImHzQM83ukdUpgROB2C6IE07UJCS2V4nHqORAMoyM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YxgRb8Fc57SM6gbHeQn38FMQnWyRYUGrwsBBypsOG4xdy/cPWzH9p7UmwUNBeFNI5
	 20hWSSpwU5NFRDMCucrnTYycOHxpXfFouULHYg2yHtpDpp1r7lnd4aNiUmP2nbrH0l
	 SED0/FI16jpnStg33H7gPXuMh5ynvHyfBQBw8/Y+KH02yarlNLJKYMsIo2IawSl3kH
	 ZRarKj6K/SH7t53Sy6H+ohu8o1Yvc8Eq1DfxC9klBT3iRlEQXGjgew5bEnZOt+o0Nh
	 jyw5fKzYcF4pHMzthDOzG4eMPNf7HN2B/W1N+h3JJagz2EisAs5brdk8iO2fciw661
	 G5D9Xh+b1CiQA==
From: Namhyung Kim <namhyung@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Stephane Eranian <eranian@google.com>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Sandipan Das <sandipan.das@amd.com>
Subject: [PATCH v4 1/5] perf/core: Add PERF_FORMAT_DROPPED
Date: Tue, 22 Oct 2024 17:09:24 -0700
Message-ID: <20241023000928.957077-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.47.0.105.g07ac214952-goog
In-Reply-To: <20241023000928.957077-1-namhyung@kernel.org>
References: <20241023000928.957077-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a perf_event is dropped due to some kind of (SW-based) filter, it
won't generate sample data.  For example, software events drops samples
when it doesn't match to privilege from exclude_{user,kernel}.

In order to account such dropped samples, add a new counter in the
perf_event, and let users can read(2) the number with the new
PERF_FORMAT_DROPPED like the lost sample count.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 include/linux/perf_event.h      |  1 +
 include/uapi/linux/perf_event.h |  5 ++++-
 kernel/events/core.c            | 12 ++++++++++++
 3 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index fb908843f209288d..c1e6340e561c400e 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -830,6 +830,7 @@ struct perf_event {
 	u64				id;
 
 	atomic64_t			lost_samples;
+	atomic64_t			dropped_samples;
 
 	u64				(*clock)(void);
 	perf_overflow_handler_t		overflow_handler;
diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index 4842c36fdf801996..7813e05218657713 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -347,6 +347,7 @@ enum {
  *	  { u64		time_running; } && PERF_FORMAT_TOTAL_TIME_RUNNING
  *	  { u64		id;           } && PERF_FORMAT_ID
  *	  { u64		lost;         } && PERF_FORMAT_LOST
+ *	  { u64		dropped;      } && PERF_FORMAT_DROPPED
  *	} && !PERF_FORMAT_GROUP
  *
  *	{ u64		nr;
@@ -355,6 +356,7 @@ enum {
  *	  { u64		value;
  *	    { u64	id;           } && PERF_FORMAT_ID
  *	    { u64	lost;         } && PERF_FORMAT_LOST
+ *	    { u64	dropped;      } && PERF_FORMAT_DROPPED
  *	  }		cntr[nr];
  *	} && PERF_FORMAT_GROUP
  * };
@@ -365,8 +367,9 @@ enum perf_event_read_format {
 	PERF_FORMAT_ID				= 1U << 2,
 	PERF_FORMAT_GROUP			= 1U << 3,
 	PERF_FORMAT_LOST			= 1U << 4,
+	PERF_FORMAT_DROPPED			= 1U << 5,
 
-	PERF_FORMAT_MAX = 1U << 5,		/* non-ABI */
+	PERF_FORMAT_MAX = 1U << 6,		/* non-ABI */
 };
 
 #define PERF_ATTR_SIZE_VER0	64	/* sizeof first published struct */
diff --git a/kernel/events/core.c b/kernel/events/core.c
index e3589c4287cb458c..7e15fe0a8dee4ee7 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -5697,6 +5697,8 @@ static int __perf_read_group_add(struct perf_event *leader,
 		values[n++] = primary_event_id(leader);
 	if (read_format & PERF_FORMAT_LOST)
 		values[n++] = atomic64_read(&leader->lost_samples);
+	if (read_format & PERF_FORMAT_DROPPED)
+		values[n++] = atomic64_read(&leader->dropped_samples);
 
 	for_each_sibling_event(sub, leader) {
 		values[n++] += perf_event_count(sub, false);
@@ -5704,6 +5706,8 @@ static int __perf_read_group_add(struct perf_event *leader,
 			values[n++] = primary_event_id(sub);
 		if (read_format & PERF_FORMAT_LOST)
 			values[n++] = atomic64_read(&sub->lost_samples);
+		if (read_format & PERF_FORMAT_DROPPED)
+			values[n++] = atomic64_read(&sub->dropped_samples);
 	}
 
 unlock:
@@ -5769,6 +5773,8 @@ static int perf_read_one(struct perf_event *event,
 		values[n++] = primary_event_id(event);
 	if (read_format & PERF_FORMAT_LOST)
 		values[n++] = atomic64_read(&event->lost_samples);
+	if (read_format & PERF_FORMAT_DROPPED)
+		values[n++] = atomic64_read(&event->dropped_samples);
 
 	if (copy_to_user(buf, values, n * sizeof(u64)))
 		return -EFAULT;
@@ -7370,6 +7376,8 @@ static void perf_output_read_one(struct perf_output_handle *handle,
 		values[n++] = primary_event_id(event);
 	if (read_format & PERF_FORMAT_LOST)
 		values[n++] = atomic64_read(&event->lost_samples);
+	if (read_format & PERF_FORMAT_DROPPED)
+		values[n++] = atomic64_read(&event->dropped_samples);
 
 	__output_copy(handle, values, n * sizeof(u64));
 }
@@ -7408,6 +7416,8 @@ static void perf_output_read_group(struct perf_output_handle *handle,
 		values[n++] = primary_event_id(leader);
 	if (read_format & PERF_FORMAT_LOST)
 		values[n++] = atomic64_read(&leader->lost_samples);
+	if (read_format & PERF_FORMAT_DROPPED)
+		values[n++] = atomic64_read(&leader->dropped_samples);
 
 	__output_copy(handle, values, n * sizeof(u64));
 
@@ -7423,6 +7433,8 @@ static void perf_output_read_group(struct perf_output_handle *handle,
 			values[n++] = primary_event_id(sub);
 		if (read_format & PERF_FORMAT_LOST)
 			values[n++] = atomic64_read(&sub->lost_samples);
+		if (read_format & PERF_FORMAT_DROPPED)
+			values[n++] = atomic64_read(&sub->dropped_samples);
 
 		__output_copy(handle, values, n * sizeof(u64));
 	}
-- 
2.47.0.105.g07ac214952-goog


