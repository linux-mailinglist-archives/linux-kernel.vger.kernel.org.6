Return-Path: <linux-kernel+bounces-564672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 623FAA658FF
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 17:52:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82F697A45C5
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 16:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E16F91DE4E7;
	Mon, 17 Mar 2025 16:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PjnrT51g"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1571DD0C7
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 16:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742230057; cv=none; b=PkiBKbl3/3EsI8rW+qUfghmEut13gVbZ/jkeqEMPX6jm0+yfVaUUf1z/um4y52LICIc+7/gkZwJYMSiOkO+rKFwWEqI6xkWew5EEtxqyK60sSTopDQj5wuMMyTw0ml/IysLs3Yfwqj4WQQzsVfuSLYXvHaSa39k/8KMJSVG/vNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742230057; c=relaxed/simple;
	bh=fqAWorI/IijoDnsIyNR5wVArlprAf6Lh35mcV9x3xtQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cBwVG0YHWeW97642PfVCOxRhufgb1X/LnJXYdSvfgw4n3FI4NViK9oZlsz7UgDRKXfFXnf159lUe9JQBzkIdIacOvPnEPYy2UTA1VXUAOYLtBGVS3rigLH3/tu+4uWfzaxT823JajOazB4oL7xhVeO3SvgLqP6HqUPn7kdk7Rxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=PjnrT51g; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=oyC7+eWfCsY2ldWxknayBsCHD5+HuepYtp8UG/Q2UVA=; b=PjnrT51gHGSXw/2l7Ehb+pocoO
	MmfOl/48ouEk/T07tbDgSb3r9sjuUmkiLmwAbNtWIZnv8ATKvNtpGfzwleT9SHRAW46+OLwhJhx+m
	GICefSWOkWMnQMUclo3w6limTEhxlJrtxE6teJVqd+x63NlqssHKknfu6w0c3mutY+3d4fpvtmhWq
	yRM5JruRxeC26Por+JrXwN4oHRx6a/h54FuEoGV0mZN+QP2adxZvjtkaiMKbBhNEVZwp5okWeVggJ
	9iqPWC5F1W9PNdTi2Z3jDQ0jZrmSdS/lzYB0TQQ3V7o9Q7kOrIXwo+xEwGP10XbhI41f7+0vEoG1d
	VbY+ezfg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tuDcc-00000003Uk3-0Go7;
	Mon, 17 Mar 2025 16:47:26 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 843D7300783; Mon, 17 Mar 2025 17:47:25 +0100 (CET)
Date: Mon, 17 Mar 2025 17:47:25 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: John Stultz <jstultz@google.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Qais Yousef <qyousef@layalina.io>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Zimuzo Ezeozue <zezeozue@google.com>, Mel Gorman <mgorman@suse.de>,
	Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Metin Kaya <Metin.Kaya@arm.com>,
	Xuewen Yan <xuewen.yan94@gmail.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Suleiman Souhlal <suleiman@google.com>, kernel-team@android.com,
	Valentin Schneider <valentin.schneider@arm.com>,
	Connor O'Brien <connoro@google.com>
Subject: Re: [RFC PATCH v15 7/7] sched: Start blocked_on chain processing in
 find_proxy_task()
Message-ID: <20250317164725.GC6888@noisy.programming.kicks-ass.net>
References: <20250312221147.1865364-1-jstultz@google.com>
 <20250312221147.1865364-8-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250312221147.1865364-8-jstultz@google.com>

On Wed, Mar 12, 2025 at 03:11:37PM -0700, John Stultz wrote:
> @@ -6791,6 +6890,7 @@ static void __sched notrace __schedule(int sched_mode)
>  	struct rq_flags rf;
>  	struct rq *rq;
>  	int cpu;
> +	bool preserve_need_resched = false;
>  
>  	cpu = smp_processor_id();
>  	rq = cpu_rq(cpu);
> @@ -6858,9 +6958,12 @@ static void __sched notrace __schedule(int sched_mode)
>  		next = find_proxy_task(rq, next, &rf);
>  		if (!next)
>  			goto pick_again;
> +		if (next == rq->idle)
> +			preserve_need_resched = true;
>  	}
>  picked:
> -	clear_tsk_need_resched(prev);
> +	if (!preserve_need_resched)
> +		clear_tsk_need_resched(prev);
>  	clear_preempt_need_resched();
>  #ifdef CONFIG_SCHED_DEBUG
>  	rq->last_seen_need_resched_ns = 0;

I would really rather this was done like so:


--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6957,12 +6944,12 @@ static void __sched notrace __schedule(i
 		if (!next)
 			goto pick_again;
 		if (next == rq->idle)
-			preserve_need_resched = true;
+			goto keep_resched;
 	}
 picked:
-	if (!preserve_need_resched)
-		clear_tsk_need_resched(prev);
+	clear_tsk_need_resched(prev);
 	clear_preempt_need_resched();
+keep_resched:
 #ifdef CONFIG_SCHED_DEBUG
 	rq->last_seen_need_resched_ns = 0;
 #endif

