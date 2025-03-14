Return-Path: <linux-kernel+bounces-562152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24965A61D8E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 22:06:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A09018969A8
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 21:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BE391ACEC6;
	Fri, 14 Mar 2025 21:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Mna+H8zA"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E92F190676
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 21:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741986356; cv=none; b=pW3misfsavRvuB76QcAb1/BkClgJ7XrOT6+/e4X7aK9axlc4HBvXBtQ7zAZD35vUv5j3MS1RFt8zd7V+BZ6O+Qk6CcySGmSbj5C0T7uu+/qMRUez93DOf58OROViJEG0Iu2PPeMNM2nb6TF4AWR18xbAD9Hq6a7UdM+/4dKOANU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741986356; c=relaxed/simple;
	bh=BGCvmQQoA6AZnAf+husQQwCH5fuFyt4lXeTQBEhYU2k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CvxUV8B+yZsQWlG6/0JCzvLm1H9HknUohxvy6S+oXLrTMeBRCEzvy3XPfJFuhaG8IbjlCjBpS/gnhiROjceyaflDPkKW2xEVOfW8IUT5wzHulXe3E1fIrHWQdXKd9WjnOxL5/orwLqYw6I8GEXnv+VnlBHT1Hdwl6KnC88nd/Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Mna+H8zA; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=mVsR1yStgTogjmLrRkPuU6O9y/i4nkeXIwo7Bc2ylNg=; b=Mna+H8zA/e07W6b5N2Eug1dbIa
	s4n7+FE9SSk76zlpl0BYEpAzCaQjv+t1+0g+aG5aZOkyaUF8KJEyBN8bMDYt6U0sLRT2+PAlzMRQb
	c+2Cr6OZZzzfMRooi8uVVX24MnlqjObkYEnybfXn+8451RsdbfI6aAR26UX9hkCAxJtWobz9KMXVV
	bQiHuBHL82U3xxPyIgOB8GhD4lcNqdw0ttkCAmygEUsPyuNTomUQWiZYli7xjqnInGStEO7z15Ovf
	rbYT9Z+XfHBR5gMU4s2L9saAfsWXktb1QUQcQ0vLDv4ahPbu6YB1qpSAGxKZJyOlRdQrLvP1dVJwb
	bPXVZjag==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1ttCDz-00000002wrX-00Cp;
	Fri, 14 Mar 2025 21:05:47 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 21597300599; Fri, 14 Mar 2025 22:05:46 +0100 (CET)
Date: Fri, 14 Mar 2025 22:05:45 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: kan.liang@linux.intel.com
Cc: mingo@redhat.com, tglx@linutronix.de, bp@alien8.de, acme@kernel.org,
	namhyung@kernel.org, irogers@google.com,
	linux-kernel@vger.kernel.org, ak@linux.intel.com,
	eranian@google.com
Subject: Re: [PATCH V10 3/7] perf: attach/detach PMU specific data
Message-ID: <20250314210545.GB21786@noisy.programming.kicks-ass.net>
References: <20250314172700.438923-1-kan.liang@linux.intel.com>
 <20250314172700.438923-3-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250314172700.438923-3-kan.liang@linux.intel.com>

On Fri, Mar 14, 2025 at 10:26:56AM -0700, kan.liang@linux.intel.com wrote:

> @@ -5393,6 +5607,9 @@ static void __free_event(struct perf_event *event)
>  	if (is_cgroup_event(event))
>  		perf_detach_cgroup(event);
>  
> +	if (event->attach_state & PERF_ATTACH_TASK_DATA)
> +		detach_perf_ctx_data(event);
> +
>  	if (event->destroy)
>  		event->destroy(event);
>  

> @@ -12481,6 +12746,18 @@ perf_event_alloc(struct perf_event_attr *attr, int cpu,
>  	if (IS_ERR(pmu))
>  		return (void*)pmu;
>  
> +	/*
> +	 * The PERF_ATTACH_TASK_DATA is set in the event_init()->hw_config().
> +	 * The attach should be right after the perf_init_event().
> +	 * Otherwise, the __free_event() would mistakenly detach the non-exist
> +	 * perf_ctx_data because of the other errors between them.
> +	 */
> +	if (event->attach_state & PERF_ATTACH_TASK_DATA) {
> +		err = attach_perf_ctx_data(event);
> +		if (err)
> +			return ERR_PTR(err);
> +	}
> +
>  	/*
>  	 * Disallow uncore-task events. Similarly, disallow uncore-cgroup
>  	 * events (they don't make sense as the cgroup will be different

I've stuck this on top. Let me see if it all compiles and push out to
queue/perf/core.

--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -666,11 +666,12 @@ struct swevent_hlist {
 #define PERF_ATTACH_GROUP	0x0002
 #define PERF_ATTACH_TASK	0x0004
 #define PERF_ATTACH_TASK_DATA	0x0008
-#define PERF_ATTACH_ITRACE	0x0010
+#define PERF_ATTACH_GLOBAL_DATA	0x0010
 #define PERF_ATTACH_SCHED_CB	0x0020
 #define PERF_ATTACH_CHILD	0x0040
 #define PERF_ATTACH_EXCLUSIVE	0x0080
 #define PERF_ATTACH_CALLCHAIN	0x0100
+#define PERF_ATTACH_ITRACE	0x0200
 
 struct bpf_prog;
 struct perf_cgroup;
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -5278,14 +5278,19 @@ attach_perf_ctx_data(struct perf_event *
 {
 	struct task_struct *task = event->hw.target;
 	struct kmem_cache *ctx_cache = event->pmu->task_ctx_cache;
+	int ret;
 
 	if (!ctx_cache)
 		return -ENOMEM;
 
 	if (task)
 		return attach_task_ctx_data(task, ctx_cache, false);
-	else
-		return attach_global_ctx_data(ctx_cache);
+
+	ret = attach_global_ctx_data(ctx_cache);
+	if (ret)
+		return ret;
+
+	event->attach_state |= PERF_ATTACH_GLOBAL_DATA;
 }
 
 static void
@@ -5348,13 +5353,15 @@ static void detach_perf_ctx_data(struct
 {
 	struct task_struct *task = event->hw.target;
 
-	if (!event->pmu->task_ctx_cache)
-		return;
+	event->attach_state &= ~PERF_ATTACH_TASK_DATA;
 
 	if (task)
-		detach_task_ctx_data(task);
-	else
+		return detach_task_ctx_data(task);
+
+	if (event->attach_state & PERF_ATTACH_GLOBAL_DATA) {
 		detach_global_ctx_data();
+		event->attach_state &= ~PERF_ATTACH_GLOBAL_DATA;
+	}
 }
 
 static void unaccount_event(struct perf_event *event)

