Return-Path: <linux-kernel+bounces-564370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42643A653AF
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 15:35:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 359943B1B05
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 14:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 769982459FC;
	Mon, 17 Mar 2025 14:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CdTLDMSy"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A6C52451EE
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 14:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742222037; cv=none; b=oHabLMsuXUC/Y/9j5xbU7qj8nGaKbjFUCs5OjNsVx0PVzR8HvybjSqX59hZOOPMLtoZmpAuRSV/mlmrZJuyJELcGLZdLGFu/klCVrR9G2qgQP6p5u9w70gf9zQ3KmfYidH58vUdTC8eUVUJ09b3jISloKGSJbGEHQSzJzmKagRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742222037; c=relaxed/simple;
	bh=4l36dhgYBqlpaMgL0Er5cMl92C4EVDVVtd9XEj3CocE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e8DN/SHXJ1W/KXlEiwAEpLbGB5SMSd1Xj7ahQ1c7h38qnPGhkC2DMahuOozA9QojYc2Alqjemry1f7UFCGkoE1WWGljYPYniVwAex1b7hC76K7H+tCjW5mOW7HtWA+Xu9NrrSmWoMCtsfC/GDgJiwSAf6FszNvssuwgT8tMdHKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=CdTLDMSy; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=d9tdhsLFx9Y+Ka1QDxT7vBWyBZEyIqUaO+11tLsabUk=; b=CdTLDMSy71yq0pjkXZ577srzPI
	1IKHmSysgBEN9jZWPrRNOeFwVgXbzZcWcdLcWxOX3QBOw6FwiZvabe4dOZA2M+Rr4DEQ46o0ZJFQD
	1PfbMq4ANJ/d1Vz5noVp0T6B6W+HR2+8lqF13Tj0vGHRopdGIO2J5qtbt6oe/cKqoadDBQqILqhHY
	y7fKAix3TWR2zBu6B5v61a640IB6lKB+UqGPi3auqnABCk7JJ7dI+sOJiV8CN+ApJVt+quMqg8VUF
	/t2Xxa/e78lKw47tVcMoXdvfzJC5OHhQY2Lnqbe27hoaTaHpvITxwlDJowi8P5SOfycEWlli4ipsr
	FnNSeVRw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tuBXH-00000008tKR-444w;
	Mon, 17 Mar 2025 14:33:48 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 6B573300783; Mon, 17 Mar 2025 15:33:47 +0100 (CET)
Date: Mon, 17 Mar 2025 15:33:47 +0100
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
	Suleiman Souhlal <suleiman@google.com>, kernel-team@android.com
Subject: Re: [RFC PATCH v15 1/7] sched: Add CONFIG_SCHED_PROXY_EXEC & boot
 argument to enable/disable
Message-ID: <20250317143347.GE36386@noisy.programming.kicks-ass.net>
References: <20250312221147.1865364-1-jstultz@google.com>
 <20250312221147.1865364-2-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250312221147.1865364-2-jstultz@google.com>

On Wed, Mar 12, 2025 at 03:11:31PM -0700, John Stultz wrote:

> diff --git a/init/Kconfig b/init/Kconfig
> index d0d021b3fa3b3..b989ddc27444e 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -875,6 +875,16 @@ config UCLAMP_BUCKETS_COUNT
>  
>  	  If in doubt, use the default value.
>  
> +config SCHED_PROXY_EXEC
> +	bool "Proxy Execution"
> +	default n
> +	# Avoid some build failures w/ PREEMPT_RT until it can be fixed
> +	depends on !PREEMPT_RT
	depends on !SPM && !SCHED_CLASS_EXT

for now, right?

> +	depends on EXPERT
> +	help
> +	  This option enables proxy execution, a mechanism for mutex-owning
> +	  tasks to inherit the scheduling context of higher priority waiters.
> +

