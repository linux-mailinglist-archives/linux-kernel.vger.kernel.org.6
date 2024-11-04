Return-Path: <linux-kernel+bounces-394996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 133269BB6EB
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 14:59:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93A3DB22734
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 13:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 701E01C4A22;
	Mon,  4 Nov 2024 13:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DloN/mFQ"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C531531D8
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 13:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730728617; cv=none; b=jxwSgbYOZBAxLQeRyYF+KNmw8v+npISlAGv0tHw4vKGwb52rQjAnNHAgSigGPV84mrKFmvqbNLWw3JJNsMxmYFMpbIZUPg9ZbHOPCmOLAR1tkbmjEgUYd6jlSzP/MUpjoDPMEnnD2WWKYiPAdOK7G8dIoSb5MgkWVRw0DYFRNj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730728617; c=relaxed/simple;
	bh=FxeF8AnDf47O0S17Db3sOKWjCrmWnBgyQGNDgQvXEtg=;
	h=Message-Id:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=Hq9dOVy4aN+PhvuDlZ7uz/2vRz5VMonMbofWezIeTasUhMBiopB18LsCCYq3JAwuRjQiS5M6YtwPKCezusl8ZUX6osMr6nOzHS6uF0C0lCWCW1o10pdFPdVbya3THSR+JNJLnTgsa3jBBOPsWETIt2Xf4h+dTD0TCoLlr38jF1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=DloN/mFQ; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=LHo/B2svVtNa82f3aNsJzufuQOwpLjpbG5fuvyX6S2c=; b=DloN/mFQ4/nPZqTFyn62jnqRCZ
	w5DuVFZdrOOGmAD61nL3Wf1kpS/sAP6GrVgu5YYyQX0YMOboFcxOkGkCr5U9fqpTmt4UIj2JVk1Ov
	f+2QsvOYLLqgk4RHCn5kA6U9fHOrTt9SN+7DNrL51sAwF7CceoMNDw3EzH+BS0qPH9Xc8Kw5uzlz6
	RzO8JmiG8r4HfIl6t4W4nK2kCDt4WvLHPN9lYt2fXBAcXWXBSX+JPV1lbjJUDOybrexkPRzKG2/Vt
	hP6Mi+ri67iUDX3xUVkkPyJ0VolGNnH+AU6PNFzXtGfMTm1hsBiXeRlyO98jOOgsv6lNZckAtqaVd
	sV9hC+8g==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t7xZY-00000001EE3-04w2;
	Mon, 04 Nov 2024 13:56:48 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 9FBDF308D9F; Mon,  4 Nov 2024 14:56:46 +0100 (CET)
Message-Id: <20241104135519.582252957@infradead.org>
User-Agent: quilt/0.65
Date: Mon, 04 Nov 2024 14:39:27 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: mingo@kernel.org,
 lucas.demarchi@intel.com
Cc: linux-kernel@vger.kernel.org,
 peterz@infradead.org,
 willy@infradead.org,
 acme@kernel.org,
 namhyung@kernel.org,
 mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com,
 jolsa@kernel.org,
 irogers@google.com,
 adrian.hunter@intel.com,
 kan.liang@linux.intel.com
Subject: [PATCH 18/19] perf: Lift event->mmap_mutex in perf_mmap()
References: <20241104133909.669111662@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

This puts 'all' of perf_mmap() under single event->mmap_mutex.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/events/core.c |   20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -6626,7 +6626,7 @@ static int perf_mmap(struct file *file,
 	unsigned long vma_size;
 	unsigned long nr_pages;
 	long user_extra = 0, extra = 0;
-	int ret = 0, flags = 0;
+	int ret, flags = 0;
 
 	/*
 	 * Don't allow mmap() of inherited per-task counters. This would
@@ -6654,6 +6654,9 @@ static int perf_mmap(struct file *file,
 
 	user_extra = nr_pages;
 
+	mutex_lock(&event->mmap_mutex);
+	ret = -EINVAL;
+
 	if (vma->vm_pgoff == 0) {
 		nr_pages -= 1;
 
@@ -6662,16 +6665,13 @@ static int perf_mmap(struct file *file,
 		 * can do bitmasks instead of modulo.
 		 */
 		if (nr_pages != 0 && !is_power_of_2(nr_pages))
-			return -EINVAL;
+			goto unlock;
 
 		WARN_ON_ONCE(event->ctx->parent_ctx);
-		mutex_lock(&event->mmap_mutex);
 
 		if (event->rb) {
-			if (data_page_nr(event->rb) != nr_pages) {
-				ret = -EINVAL;
+			if (data_page_nr(event->rb) != nr_pages)
 				goto unlock;
-			}
 
 			if (atomic_inc_not_zero(&event->rb->mmap_count)) {
 				/*
@@ -6698,12 +6698,6 @@ static int perf_mmap(struct file *file,
 		 */
 		u64 aux_offset, aux_size;
 
-		if (!event->rb)
-			return -EINVAL;
-
-		mutex_lock(&event->mmap_mutex);
-		ret = -EINVAL;
-
 		rb = event->rb;
 		if (!rb)
 			goto aux_unlock;
@@ -6813,6 +6807,8 @@ static int perf_mmap(struct file *file,
 			rb->aux_mmap_locked = extra;
 	}
 
+	ret = 0;
+
 unlock:
 	if (!ret) {
 		atomic_long_add(user_extra, &user->locked_vm);



