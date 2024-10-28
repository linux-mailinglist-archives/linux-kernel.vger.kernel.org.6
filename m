Return-Path: <linux-kernel+bounces-385035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 12A5E9B319A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 14:23:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9BB0FB22261
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 13:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 568CF1DB92A;
	Mon, 28 Oct 2024 13:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="k4NXsdC8"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FAF838396
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 13:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730121801; cv=none; b=Sj1zeBO6bg2hDG37FnFjHyJncHwgsBk3oQ8R950n0X5WXMTAs33TEOeXRvv+sEssvSGeYB1XHMHwhrDp7t2QgEpGXE0JplzZcircWpVTfs/YZB7X3MOKWQZw0FYO5iw6uO9RpDRb+5dsny0pkX8SYLVOMKVHZGAhfoMsWS9rUTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730121801; c=relaxed/simple;
	bh=esSGSXH7jB3IQQWeum4//cC9lsdkx5i7Q9ZZfFTuoME=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=edvK+xXI7jQIqrHL05TnM5Lgdwz+2sKjLSj8HizdixUCEEgh/UV4V+acj7CJuxNJr66TFNYJ+ZO/zjk/bueJgGNdgRMazpXExiRdyUYXx/ldJXVq1JUERlZz4dsKh5qrUdVg3tsg3eWOj9vMpdUc0dQJjttG1nGGdogxNgE71qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=k4NXsdC8; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=77fE5jzGLpolVyjwxDvLLZZxdaxWxpJTh6gpD2XJluM=; b=k4NXsdC8jPsb2B7hyU56O7S9Om
	3UEJMMHsjaHBcWYgECpLhAF0vcrL2AiUdmQVAmwyn8UzJqjS4Xcv03dqXND7fbfp920UHLOLqfNHA
	3SArKaYUt2x/1kimc+xoPBmg1K4KdyY36pv37/Ylbjj106w/BmF1r4CyfEOdL6cebZa3lOUIsvjfj
	kkwNRx7l1BN95HUjxJu8FkSMc2yWcMVjfAKRbXbkmDrxQZF+1N3S9EtUWbcErLcFwAQUr75AxON7e
	RF2o0KTS1QgY1a9MApNsreQbrePtkbDlZ+liOiSRafAmBrShZg2RNrJpD5eCE0k1gRXi6ZopVoYjh
	bwdmaJgw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t5Pi6-00000008XSL-2Jf1;
	Mon, 28 Oct 2024 13:23:07 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id C2DC630083E; Mon, 28 Oct 2024 14:23:06 +0100 (CET)
Date: Mon, 28 Oct 2024 14:23:06 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Cc: mingo@redhat.com, James Morse <james.morse@arm.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Gavin Shan <gshan@redhat.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Thomas Gleixner <tglx@linutronix.de>,
	Simon Deziel <simon.deziel@canonical.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/cpuacct: show only present CPUs to userspace
Message-ID: <20241028132306.GP14555@noisy.programming.kicks-ass.net>
References: <20241017102138.92504-1-aleksandr.mikhalitsyn@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241017102138.92504-1-aleksandr.mikhalitsyn@canonical.com>

On Thu, Oct 17, 2024 at 12:21:38PM +0200, Alexander Mikhalitsyn wrote:
> After commit b0c69e1214bc ("drivers: base: Use present CPUs in GENERIC_CPU_DEVICES")
> changed which CPUs are shown in /sys/devices/system/cpu/ (only "present" ones)
> it also makes sense to change cpuacct cgroupv1 code not to report CPUs
> which are not present in the system as it confuses userspace.
> Let's make it consistent.
> 
> A configuration when #(present CPUs) < #(possible CPUs) is easy to get with:
> qemu-system-x86_64
> 	-smp 3,maxcpus=12 \
> 	...
> 
> Cc: James Morse <james.morse@arm.com>
> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Gavin Shan <gshan@redhat.com>
> Cc: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Reported-by: Simon Deziel <simon.deziel@canonical.com>
> Closes: https://github.com/canonical/lxd/issues/13324
> Co-developed-by: Simon Deziel <simon.deziel@canonical.com>
> Signed-off-by: Simon Deziel <simon.deziel@canonical.com>
> Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
> ---
>  kernel/sched/cpuacct.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/sched/cpuacct.c b/kernel/sched/cpuacct.c
> index 0de9dda09949..0f07fbfdb20e 100644
> --- a/kernel/sched/cpuacct.c
> +++ b/kernel/sched/cpuacct.c
> @@ -213,7 +213,7 @@ static int __cpuacct_percpu_seq_show(struct seq_file *m,
>  	u64 percpu;
>  	int i;
>  
> -	for_each_possible_cpu(i) {
> +	for_each_present_cpu(i) {
>  		percpu = cpuacct_cpuusage_read(ca, i, index);
>  		seq_printf(m, "%llu ", (unsigned long long) percpu);
>  	}
> @@ -247,7 +247,7 @@ static int cpuacct_all_seq_show(struct seq_file *m, void *V)
>  		seq_printf(m, " %s", cpuacct_stat_desc[index]);
>  	seq_puts(m, "\n");
>  
> -	for_each_possible_cpu(cpu) {
> +	for_each_present_cpu(cpu) {
>  		seq_printf(m, "%d", cpu);
>  		for (index = 0; index < CPUACCT_STAT_NSTATS; index++)
>  			seq_printf(m, " %llu",


Doesn't this create problems for machines that support actual physical
hotplug?

Then all of a sudden, when a CPU with non-zero stats goes from present
to !present, the stats also go away, and any userspace looking at the
sum of stats over CPUs sees an unexplained dis-continuity.

