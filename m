Return-Path: <linux-kernel+bounces-439764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6EB39EB3B5
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 15:43:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 172D018887C8
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 14:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58FFA1B6CEC;
	Tue, 10 Dec 2024 14:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rsfaYKT3"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E551B21A0
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 14:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733841799; cv=none; b=kkxwkjK4bnMsXUE88CFH98meO1hbpgjW9/WYI+6MyYXusTwXBC+7pga3qvsFHMehig7OpVUJxaFWiTNECH+XmFQWY0VbDHFIvjiZOicwl62/8X5aYyHK59IV2YZOzoPIkf36haoT6AdPiU7SQSvDzmLvUzdgNrFTUDSkkhoTqZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733841799; c=relaxed/simple;
	bh=BfXL+MwJVLKr1vTqTiVwGvJYCO8qFV54tvNpmEZ8iB0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nkWXWHXef2zBhSu8n2UN8RCVr7YKRuXoqsd4bxFpctkl12m4popSA02vxaqD0g5Se9Kh5zpMi2hpJhRlwDNyAs+ynCtknE0mHBvw7WSPLxVLfL0NaAvGp+O+xueqmAK/bnKlRGxAaDLuT/skt7XhbAvA/+qm/Vs7yhFYlAJ6LEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=rsfaYKT3; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=EDyjX6TSs12zCxD6fnFMwFwO2IgeyV3TxNqHAWDkPvI=; b=rsfaYKT37kQCfKQEH3Pzhjlyy9
	gRt59Pf9CnqHQZFIF8cxarl74+9CJ3v0HCgnAlTT9n6M8VU/1dVQ0S4NbbZPBQt+KwfSMmc888ri0
	TyV5Q9x7f4OStgrLqlmPqXw5A3tW9DfDUKr3C/Sb5t2Xr1u8Hj92/vZ+PkUJLHjtJeKr2KPSFT5Rd
	Sr7WEcw7WLlhtTEaBjVJkRWzSW5ZAueIfucxEumTw0q/TDV0WYcuvlkjrfNevqa1mqoVoC2gkk7GV
	/jWCKlu82nWDKb/kRqt8Tc1KlVRNjsbr+o8I1HhW/+aM3eMGlZMLVEdCkrPR/pSo39/Obit57H8vY
	jV4sFTCA==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tL1S8-00000009t6L-0iM5;
	Tue, 10 Dec 2024 14:43:08 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 877BF300402; Tue, 10 Dec 2024 15:43:07 +0100 (CET)
Date: Tue, 10 Dec 2024 15:43:07 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Vishal Chourasia <vishalc@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, sshegde@linux.ibm.com, srikar@linux.ibm.com,
	vineethr@linux.ibm.com, zhangqiao22@huawei.com
Subject: Re: [PATCH v3] sched/fair: Fix CPU bandwidth limit bypass during CPU
 hotplug
Message-ID: <20241210144307.GV35539@noisy.programming.kicks-ass.net>
References: <20241210102346.228663-2-vishalc@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241210102346.228663-2-vishalc@linux.ibm.com>

On Tue, Dec 10, 2024 at 03:53:47PM +0530, Vishal Chourasia wrote:
> CPU controller limits are not properly enforced during CPU hotplug
> operations, particularly during CPU offline. When a CPU goes offline,
> throttled processes are unintentionally being unthrottled across all CPUs
> in the system, allowing them to exceed their assigned quota limits.
> 
> Consider below for an example,
> 
> Assigning 6.25% bandwidth limit to a cgroup
> in a 8 CPU system, where, workload is running 8 threads for 20 seconds at
> 100% CPU utilization, expected (user+sys) time = 10 seconds.
> 
> $ cat /sys/fs/cgroup/test/cpu.max
> 50000 100000
> 
> $ ./ebizzy -t 8 -S 20        // non-hotplug case
> real 20.00 s
> user 10.81 s                 // intended behaviour
> sys   0.00 s
> 
> $ ./ebizzy -t 8 -S 20        // hotplug case
> real 20.00 s
> user 14.43 s                 // Workload is able to run for 14 secs
> sys   0.00 s                 // when it should have only run for 10 secs
> 
> During CPU hotplug, scheduler domains are rebuilt and cpu_attach_domain
> is called for every active CPU to update the root domain. That ends up
> calling rq_offline_fair which un-throttles any throttled hierarchies.
> 
> Unthrottling should only occur for the CPU being hotplugged to allow its
> throttled processes to become runnable and get migrated to other CPUs.
> 
> With current patch applied,
> $ ./ebizzy -t 8 -S 20        // hotplug case
> real 21.00 s
> user 10.16 s                 // intended behaviour
> sys   0.00 s
> 
> Note: hotplug operation (online, offline) was performed in while(1) loop
> 
> Signed-off-by: Vishal Chourasia <vishalc@linux.ibm.com>
> Tested-by: Madadi Vineeth Reddy <vineethr@linux.ibm.com>

Did you mean this?

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 2c4ebfc82917..b6afb8337e73 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6696,6 +6696,9 @@ static void __maybe_unused unthrottle_offline_cfs_rqs(struct rq *rq)
 
 	lockdep_assert_rq_held(rq);
 
+	if (cpumask_test_cpu(cpu_of(rq), cpu_active_mask))
+		return;
+
 	/*
 	 * The rq clock has already been updated in the
 	 * set_rq_offline(), so we should skip updating

