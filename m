Return-Path: <linux-kernel+bounces-200403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A50248FAF96
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 12:11:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 118041F2266F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 10:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8CCF1448DD;
	Tue,  4 Jun 2024 10:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XIAwUZ2K"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A6D143C72
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 10:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717495891; cv=none; b=W6E9cDhfhfnZ1sYMFrVcqhmLTI3b8Pvvd6e26D/0GJcK+MMvWoUtMC0aszbMAu40eaoc39lvmq194f/KWi7tJNu390uVFqr45E668K8eyp3er08LA+TbeL/E2r17PYPcgBpiIujwXdnp15m/MzvGGIMmJG2b4LAGR24puKHsV9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717495891; c=relaxed/simple;
	bh=Q5FhSAKmhTtyMKkX3TGPlAag5uc3ZeJc0glHX5zdRBE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JrXsjHPb+AQ225w0RsePWsb1QnAIA5S4av7Mg2IRzUhDrpdQ/TM1v2AFudwc1ptSCJ2o9yW1rxmQd5vkSrIuZ0p/WCH/wZN5XKDVYi0KykMzkHGqGQTWHU8a7l03i9KDCtT9VIAsVIBQRuYdNEcmSi8/wvBR7Fs8ojxpdYkM1xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=XIAwUZ2K; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ATGlkKEngE3eomrKUxqxHcflBPoRWqyoqgF1HGqQ1pQ=; b=XIAwUZ2Kh6rGtNHJMU4EVNN+t2
	0sHDUb30n7mCdT61O1ARapfiPxD/b+bK9SmH9OOX94PlnuIcZUdgmrlfYde4A2kUnG8SSt5S9Ei8k
	s37edxtQFQ+ejjVD55iQm5D8ukUYt3oj7uTDN/Gaklgj9jCIXPm93fY+oBh0d9iBY9EQtHEYX4+3k
	06G4FdQ19YNfG6tNrfzjE9k5bzyZ4s8zYPPTNkwfz0/u8+reGy1yB2IKXSKcWOPri/TrticA2TiXJ
	k7R/BIZNk6RRImWH9KVuhOkzl12BQHkGpbXlBWaruSGojAaA3LzBOOcjfsmtWGq/UQpF3kE9LCEsT
	gFYcncCQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sER8I-0000000Ekl8-2O6v;
	Tue, 04 Jun 2024 10:11:10 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 93C9F30068B; Tue,  4 Jun 2024 12:11:07 +0200 (CEST)
Date: Tue, 4 Jun 2024 12:11:07 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Luis Machado <luis.machado@arm.com>
Cc: mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
	linux-kernel@vger.kernel.org, kprateek.nayak@amd.com,
	wuyun.abel@bytedance.com, tglx@linutronix.de, efault@gmx.de,
	nd <nd@arm.com>, John Stultz <jstultz@google.com>,
	Hongyan.Xia2@arm.com
Subject: Re: [RFC][PATCH 08/10] sched/fair: Implement delayed dequeue
Message-ID: <20240604101107.GO26599@noisy.programming.kicks-ass.net>
References: <20240405110010.631664251@infradead.org>
 <3888d7c8-660e-479c-8c10-8295204e5f36@arm.com>
 <1461277e-af68-41e7-947c-9178b55810b1@arm.com>
 <20240425104220.GE21980@noisy.programming.kicks-ass.net>
 <20240425114949.GH12673@noisy.programming.kicks-ass.net>
 <20240426093241.GI12673@noisy.programming.kicks-ass.net>
 <c6152855-ef92-4c24-a3f5-64d4256b6789@arm.com>
 <2fba04b0-e55e-41f4-8b7a-723734fe1ad2@arm.com>
 <20240529225036.GN40213@noisy.programming.kicks-ass.net>
 <7eac0774-0f9d-487c-97b6-ab0e85f0ae3a@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7eac0774-0f9d-487c-97b6-ab0e85f0ae3a@arm.com>

On Mon, Jun 03, 2024 at 08:30:43PM +0100, Luis Machado wrote:

> Exchanging some information with Hongyan today, he was a bit suspicious of the uclamp
> behavior with the eevdf complete series applied.
> 
> Checking the uclamp code, I see we have some refcounting tied to enqueuing/dequeuing
> of tasks, and the uclamp values are organized in buckets.
> 
> Just for fun I added a few trace_printk's in uclamp_eff_value, uclamp_rq_inc_id and
> uclamp_rq_dec_id.
> 
> Booting up the system with delayed_dequeue disabled and running the benchmark, I 
> see the uclamp bucket management pretty stable. Tasks get added to the uclamp
> buckets but then get removed. At the end of the benchmark, the uclamp buckets
> are (almost always) clean of tasks.
> 
> Enabling delayed dequeue, I can see the uclamp buckets slowly filling up with
> tasks. At the end of the benchmark, I see uclamp buckets with 30, 40 or 50
> tasks still. If I do another run, I can see 80, 100 tasks still.
> 
> I suspect refcounting might be going wrong somewhere due to delayed dequeue
> tasks, but that's more of a guess right now. Hopefully that is useful
> information. I'll resume investigation tomorrow.

Thank you both!!

Does the below help?

Note how dequeue_task() does uclamp_rq_dec() unconditionally, which is
then not balanced in the case below.

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3664,6 +3664,7 @@ static int ttwu_runnable(struct task_str
 			/* mustn't run a delayed task */
 			SCHED_WARN_ON(task_on_cpu(rq, p));
 			enqueue_task(rq, p, ENQUEUE_DELAYED);
+			uclamp_rq_inc(rq, p);
 		}
 		if (!task_on_cpu(rq, p)) {
 			/*

