Return-Path: <linux-kernel+bounces-230089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECEAB917837
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 07:37:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 291621C22891
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 05:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E1031474A6;
	Wed, 26 Jun 2024 05:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="Ir9TCriQ"
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB9114534D
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 05:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719380233; cv=none; b=LFyEG95y5q5uXZV0APR6HATwM+u5xMBZUXyG9adjNF1nGP+EBM7KfuRiEO1/8QvHIBd6QqEyrl+mdEINr9zxfPCZ9aWhBWlel9wR0uwUeK01G1dHCYjuumcZr0UCtvyYXO2ll5KXGyGvZwwna8WJrmYYup2eYsDm41cV+9D7UAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719380233; c=relaxed/simple;
	bh=FTe89paSGdwU1GopKzT/O3Bwg1DVJVLQZbRDJZaMbR4=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=AYdjawtS/pZlGPnfoZGYNpBX87NCQBiPNwXQlMuW9Ykd3Cw8lNl9dA7Vtxt0LBSbjQA1RwiLf2V6MNjckN9wXHzO8IeFRUN6Py59tPy3HuhiJRSaXkeI+HsFBQWjoVSJQwuxYI6xQ519ZT4omvsCMYMYobHsLeCvCytbukWyvH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=Ir9TCriQ; arc=none smtp.client-ip=192.134.164.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:subject:message-id:mime-version;
  bh=Rib6lHY5IepeGT7xRRMN/CyWn4k9xgNuQBWMMEkBdjA=;
  b=Ir9TCriQXleBiPtyOmsqclmY4Q/xF/X729fmdy2jxkxwgx+eE+H0U/zy
   jFJP0TFMcM1gRfAvogbwVYejg4KzZkfJRtdNjTjVSZqMzuda2sTyXmn5p
   mQDWDja06r2P2YBSIbp1J0NNqzbWO1ucZw6rRVDeecY8F30OP4cHJ2+70
   g=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.08,266,1712613600"; 
   d="scan'208";a="90635034"
Received: from 203-174-183-243.bri.static-ipl.aapt.com.au (HELO hadrien) ([203.174.183.243])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2024 07:37:05 +0200
Date: Wed, 26 Jun 2024 15:37:01 +1000 (AEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Vincent Guittot <vincent.guittot@linaro.org>, 
    Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
    Dietmar Eggemann <dietmar.eggemann@arm.com>, Mel Gorman <mgorman@suse.de>, 
    K Prateek Nayak <kprateek.nayak@amd.com>, 
    linux-kernel <linux-kernel@vger.kernel.org>
Subject: softirq
Message-ID: <ef964f57-7c9d-aa77-c958-793c899dc4d9@inria.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

Hello,

I'm not sure to understand how soft irqs work.  I see the code:

open_softirq(SCHED_SOFTIRQ, sched_balance_softirq);

Intuitively, I would expect that sched_balance_softirq would be run by
ksoftirqd.  That is, I would expect ksoftirqd to be scheduled
(sched_switch event), then the various actions of sched_balance_softirq to
be executed, and the ksoftirqd to be unscheduled (another ksoftirqd)
event.

But in practice, I see the code of sched_balance_softirq being executed
by the idle task, before the ksoftirqd is scheduled (see core 40):

          <idle>-0     [040]  3611.432554: softirq_entry:        vec=7 [action=SCHED]
          <idle>-0     [040]  3611.432554: bputs:                sched_balance_softirq: starting nohz
          <idle>-0     [040]  3611.432554: bputs:                sched_balance_softirq: starting _nohz_idle_balance
          bt.B.x-12022 [047]  3611.432554: softirq_entry:        vec=1 [action=TIMER]
          <idle>-0     [040]  3611.432554: bputs:                _nohz_idle_balance.isra.0: searching for a cpu
          bt.B.x-12033 [003]  3611.432554: softirq_entry:        vec=7 [action=SCHED]
          <idle>-0     [040]  3611.432554: bputs:                sched_balance_softirq: ending _nohz_idle_balance
          bt.B.x-12052 [011]  3611.432554: softirq_entry:        vec=7 [action=SCHED]
          <idle>-0     [040]  3611.432554: bputs:                sched_balance_softirq: nohz returns true ending soft irq
          <idle>-0     [040]  3611.432554: softirq_exit:         vec=7 [action=SCHED]

For example, idle seems to be running the code in _nohz_idle_balance.

I updated the code of _nohz_idle_balance as follows:

trace_printk("searching for a cpu\n");
        for_each_cpu_wrap(balance_cpu,  nohz.idle_cpus_mask, this_cpu+1) {
                if (!idle_cpu(balance_cpu))
                        continue;
trace_printk("found an idle cpu\n");

It prints searching for a cpu, but not found an idle cpu, because the
ksoftirqd on the core's runqueue makes the core not idle.  This makes the
whole softirq seem fairly useless when the only idle core is the one
raising the soft irq.

This is all for the same scenario that I have discussed previously, where
there are two sockets and an overload of on thread on one and an underload
of on thread on the other, and all the thread have been marked by numa
balancing as preferring to be where they are.  Now I am trying Prateek's
patch series.

thanks,
julia

