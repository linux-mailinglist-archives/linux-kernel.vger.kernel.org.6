Return-Path: <linux-kernel+bounces-316248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD19496CD0C
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 05:10:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96B0B28141C
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 03:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF8B9145B25;
	Thu,  5 Sep 2024 03:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G/SlAUUi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE9F42AA2
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 03:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725505829; cv=none; b=kM0Igw9FAztgZxlNDW0wi0G8rUySxEe+KDC1vlWIklwpAvqi5mjUkntliN6eCjJ1q5fRcrUd/TuqcOjeGAP8+INxqzwOYPfORvdaUJwlm6JrTVuwjRLwLM449tpbuRmWEfD9ZCJaEHli+FoQXZZBEqGMuKB4RdIuQhZDCpKX3zA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725505829; c=relaxed/simple;
	bh=4D5oDBmYspBeextM49eoAfWIHIUc/gszGzj9mXt4t/8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CYAo/sRZAHSHHjnpeovaZj+zWMO2zXwPawBpyaW3whomSGp6XPi3vX457LX9n2elQErvP65iJDPOImpwtTRr/56+yBrL4GvkB7EkXEaMNE/Iqztf72gWppGQtzagbpUAjzErGdckjAzBqzS2rZ5AnGHzkTtc23ik/DJQyw33DBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G/SlAUUi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AECFC4CEC6;
	Thu,  5 Sep 2024 03:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725505828;
	bh=4D5oDBmYspBeextM49eoAfWIHIUc/gszGzj9mXt4t/8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G/SlAUUi/TTuMrhX91lGUdFlk+KsTT11rC9G38RpLLchDPLbAh9LlSxDHtmiOX9lt
	 1kYGNXi+TtfGIewtwUvnSM/Reew2JO1ql9ArUK+KB33zfRdm3nJHhhYvqzbQsLOans
	 KxI2O2Megk4SRsupvHGtWK6qYYv7Z5l62wTrBYHNFCDa3/X3Bg1nOk+BWUihJ2QXii
	 XMyBSmauJ1XOls8E4Kl6p8xKWwvY5jamBvdk/VruXu8TXWfy4X1WH41GO5Li1Bgroe
	 RToNY0w5BM6MYgNjnxt+6iIu5+O9ghOBgfIA5yQGZTGtWr/qfd9bQA9d+YP9E31Rgx
	 LNzaAzI0t4N6g==
From: Namhyung Kim <namhyung@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Stephane Eranian <eranian@google.com>,
	Ravi Bangoria <ravi.bangoria@amd.com>
Subject: [PATCH 1/5] perf/core: Add PERF_FORMAT_DROPPED
Date: Wed,  4 Sep 2024 20:10:23 -0700
Message-ID: <20240905031027.2567913-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
In-Reply-To: <20240905031027.2567913-1-namhyung@kernel.org>
References: <20240905031027.2567913-1-namhyung@kernel.org>
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
index 701549967c1854e3..955d39543398afb0 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -809,6 +809,7 @@ struct perf_event {
 	u64				id;
 
 	atomic64_t			lost_samples;
+	atomic64_t			dropped_samples;
 
 	u64				(*clock)(void);
 	perf_overflow_handler_t		overflow_handler;
diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index 58daf6156fd0ee66..6f19d4f7482389b7 100644
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
index c6a720f412258079..4d72538628ee62f4 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -5679,6 +5679,8 @@ static int __perf_read_group_add(struct perf_event *leader,
 		values[n++] = primary_event_id(leader);
 	if (read_format & PERF_FORMAT_LOST)
 		values[n++] = atomic64_read(&leader->lost_samples);
+	if (read_format & PERF_FORMAT_DROPPED)
+		values[n++] = atomic64_read(&leader->dropped_samples);
 
 	for_each_sibling_event(sub, leader) {
 		values[n++] += perf_event_count(sub, false);
@@ -5686,6 +5688,8 @@ static int __perf_read_group_add(struct perf_event *leader,
 			values[n++] = primary_event_id(sub);
 		if (read_format & PERF_FORMAT_LOST)
 			values[n++] = atomic64_read(&sub->lost_samples);
+		if (read_format & PERF_FORMAT_DROPPED)
+			values[n++] = atomic64_read(&sub->dropped_samples);
 	}
 
 unlock:
@@ -5751,6 +5755,8 @@ static int perf_read_one(struct perf_event *event,
 		values[n++] = primary_event_id(event);
 	if (read_format & PERF_FORMAT_LOST)
 		values[n++] = atomic64_read(&event->lost_samples);
+	if (read_format & PERF_FORMAT_DROPPED)
+		values[n++] = atomic64_read(&event->dropped_samples);
 
 	if (copy_to_user(buf, values, n * sizeof(u64)))
 		return -EFAULT;
@@ -7348,6 +7354,8 @@ static void perf_output_read_one(struct perf_output_handle *handle,
 		values[n++] = primary_event_id(event);
 	if (read_format & PERF_FORMAT_LOST)
 		values[n++] = atomic64_read(&event->lost_samples);
+	if (read_format & PERF_FORMAT_DROPPED)
+		values[n++] = atomic64_read(&event->dropped_samples);
 
 	__output_copy(handle, values, n * sizeof(u64));
 }
@@ -7386,6 +7394,8 @@ static void perf_output_read_group(struct perf_output_handle *handle,
 		values[n++] = primary_event_id(leader);
 	if (read_format & PERF_FORMAT_LOST)
 		values[n++] = atomic64_read(&leader->lost_samples);
+	if (read_format & PERF_FORMAT_DROPPED)
+		values[n++] = atomic64_read(&leader->dropped_samples);
 
 	__output_copy(handle, values, n * sizeof(u64));
 
@@ -7401,6 +7411,8 @@ static void perf_output_read_group(struct perf_output_handle *handle,
 			values[n++] = primary_event_id(sub);
 		if (read_format & PERF_FORMAT_LOST)
 			values[n++] = atomic64_read(&sub->lost_samples);
+		if (read_format & PERF_FORMAT_DROPPED)
+			values[n++] = atomic64_read(&sub->dropped_samples);
 
 		__output_copy(handle, values, n * sizeof(u64));
 	}
-- 
2.46.0.469.g59c65b2a67-goog


