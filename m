Return-Path: <linux-kernel+bounces-410482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A586E9CDC22
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 11:06:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 592A11F22DC2
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 10:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C3611B3933;
	Fri, 15 Nov 2024 10:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="F9t9nGM6"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DAA718FC91
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 10:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731665109; cv=none; b=COChMuZuHS/+FnitNqCfanIzJZdbN64awswGaLEYtVLovstGM6POMFtg/0DL0BTTumWg/KblaCw8N/C7nn5EbA6s1/LrouCWZ2Xi1yp7oZnbZi+GDda+V6EGPyDjiNf1J7sawsRa76RN50ZZlIBtT/FepsM12K183I5aIy3CY6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731665109; c=relaxed/simple;
	bh=2Yrm9NsZNG2O5YXYCwAS6tiK/F4N4sWGIvFu1tZ5aZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B3qa8jUwpMnOe0JcDyKAj7IBCQjHKrKZVzjE8WTXGo55/3uYPRJ4azZP2qxmxPH+5yRjKn7oNt7Ss8+NyvUEXJwIQO7C6uBZiEsuHea0w4LCPwbXbs9jxive5tlcM+WsFJ9/5qvPw2X06+ZWS5TlPiddLMGqr1IbNlr03tZ1D8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=F9t9nGM6; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=vEKXm1Mo9tl1SFeLiTvA2Pt2EWYiAiGiFYXNoJkWNas=; b=F9t9nGM6EXbQS4NBMotsJjQHPK
	0uCbAS9fZhvKuNVIFi/mLyW/mdvLszc+9uWDoXbndhWW1bhzP4Dk96gSN+131tDC7SKa/mGRnAfTD
	29bfGQe9bww1rdaI0g69NEPRAyt856E/4E83wY8XnulZIrK2LrCKB5cDq32ZDoZdo0m424/Cc5Dhp
	wutKko+ViKF1jZ14NjMfba3izwhn+0+7XcOhmZvOizuI6HHVsRR99tKuR+BKWdpfaG+tSyyF4VNZc
	Jeuf1EZKkp74on+GiK9jEeCI2jRzLw9PSQ1CXToHQGo5SYAru2OXLtEx2tbJEgdLDXKiYKPllsnr+
	597Mmijw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tBtCC-00000000DPh-23JS;
	Fri, 15 Nov 2024 10:04:56 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 1E51330066A; Fri, 15 Nov 2024 11:04:56 +0100 (CET)
Date: Fri, 15 Nov 2024 11:04:56 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Jon Kohler <jon@nutanix.com>
Cc: Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/rt: use for_each_cpu_wrap to iterate over rto_mask
Message-ID: <20241115100456.GX22801@noisy.programming.kicks-ass.net>
References: <20241114220558.1842569-1-jon@nutanix.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241114220558.1842569-1-jon@nutanix.com>

On Thu, Nov 14, 2024 at 03:05:58PM -0700, Jon Kohler wrote:
> When using NO_RT_PUSH_IPI, using for_each_cpu() over rto_mask may cause
> many CPUs to attempt to pull load from the same CPU, causing RQ
> lock contention.
> 
> Use for_each_cpu_wrap instead to spread out which RQ gets evaluated
> first, similar to how _nohz_idle_balance iterates over idle_cpus_mask.
> This strategy is beneficial when there are many CPUs in rto_mask and
> many other CPUs going in and out of schedule() at the same time.
> 
> Signed-off-by: Jon Kohler <jon@nutanix.com>
> ---
>  kernel/sched/rt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> index 172c588de542..c883ff122f5d 100644
> --- a/kernel/sched/rt.c
> +++ b/kernel/sched/rt.c
> @@ -2308,7 +2308,7 @@ static void pull_rt_task(struct rq *this_rq)
>  	}
>  #endif
>  
> -	for_each_cpu(cpu, this_rq->rd->rto_mask) {
> +	for_each_cpu_wrap(cpu, this_rq->rd->rto_mask, this_cpu+1) {
>  		if (this_cpu == cpu)
>  			continue;

Works for me I suppose, but as with that other rt patch, please do the
matching change for dl too.

