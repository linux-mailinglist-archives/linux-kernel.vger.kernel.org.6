Return-Path: <linux-kernel+bounces-559166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C471EA5F04A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 11:09:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37EA93B2078
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 10:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A6E3264630;
	Thu, 13 Mar 2025 10:09:17 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4343A1BC5C
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 10:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741860557; cv=none; b=oYSURtQUkNw4bizyWI+iMPm5ht43NhHqhYLedxkVSWBFx6KwuHKbxO9JYYetV2eaNM/tLTSNXZsPff0IlWz05r2f0DevB5v3CdiVk1eWkK0ZS/XTa3TwPlLrHK9G9+ztahxiK7GKwj7CrbrYiOm60Lp7bepKCNad27fCqNvV+JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741860557; c=relaxed/simple;
	bh=Qnjyg7KV1dZTy6BQ3iPR4RaScEjQsemlcInyNPgYWxk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L3TxGG+7Fr3/jX2rxgnyjyUMZLKyFrCzN2Go1xHSQGx5pljXbyMJGhK2kQ9mM7a15vqmDtfPrpKQMoI2xbo+mWkSQwyDW0Y9IXBmI47d0XsYBA230esFIO7wUl5/zib7+BcJx5vYR764JPpKzRRbP7xeerzIaH/2nllHNAhxZpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 469A3C4CEDD;
	Thu, 13 Mar 2025 10:09:10 +0000 (UTC)
Date: Thu, 13 Mar 2025 06:09:07 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: John Stultz <jstultz@google.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Joel Fernandes
 <joelagnelf@nvidia.com>, Qais Yousef <qyousef@layalina.io>, Ingo Molnar
 <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Juri Lelli
 <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Valentin Schneider
 <vschneid@redhat.com>, Ben Segall <bsegall@google.com>, Zimuzo Ezeozue
 <zezeozue@google.com>, Mel Gorman <mgorman@suse.de>, Will Deacon
 <will@kernel.org>, Waiman Long <longman@redhat.com>, Boqun Feng
 <boqun.feng@gmail.com>, "Paul E. McKenney" <paulmck@kernel.org>, Metin Kaya
 <Metin.Kaya@arm.com>, Xuewen Yan <xuewen.yan94@gmail.com>, K Prateek Nayak
 <kprateek.nayak@amd.com>, Thomas Gleixner <tglx@linutronix.de>, Daniel
 Lezcano <daniel.lezcano@linaro.org>, Suleiman Souhlal
 <suleiman@google.com>, kernel-team@android.com
Subject: Re: [RFC PATCH v15 1/7] sched: Add CONFIG_SCHED_PROXY_EXEC & boot
 argument to enable/disable
Message-ID: <20250313060907.6828c62c@batman.local.home>
In-Reply-To: <20250312221147.1865364-2-jstultz@google.com>
References: <20250312221147.1865364-1-jstultz@google.com>
	<20250312221147.1865364-2-jstultz@google.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 12 Mar 2025 15:11:31 -0700
John Stultz <jstultz@google.com> wrote:
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index fb8752b42ec85..dcc2443078d00 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -6262,6 +6262,11 @@
>  	sa1100ir	[NET]
>  			See drivers/net/irda/sa1100_ir.c.
>  
> +	sched_proxy_exec= [KNL]
> +			Enables or disables "proxy execution" style
> +			solution to mutex-based priority inversion.
> +			Format: <bool>

To enable, does this require: sched_proxy_exec=true

Could we just allow it to be:

		sched_proxy_exec

Also mean true? That is, both of the above would be true, but to
disable it, you would need: sched_proxy_exec=false.

> +
>  	sched_verbose	[KNL,EARLY] Enables verbose scheduler debug messages.
>  
>  	schedstats=	[KNL,X86] Enable or disable scheduled statistics.
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 9c15365a30c08..1462f2c70aefc 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -1636,6 +1636,19 @@ struct task_struct {
>  	 */
>  };
>  
> +#ifdef CONFIG_SCHED_PROXY_EXEC
> +DECLARE_STATIC_KEY_TRUE(__sched_proxy_exec);
> +static inline bool sched_proxy_exec(void)
> +{
> +	return static_branch_likely(&__sched_proxy_exec);
> +}
> +#else
> +static inline bool sched_proxy_exec(void)
> +{
> +	return false;
> +}
> +#endif
> +
>  #define TASK_REPORT_IDLE	(TASK_REPORT + 1)
>  #define TASK_REPORT_MAX		(TASK_REPORT_IDLE << 1)
>  
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

Nit, you don't need "default n" because "default n" is the default ;-)

> +	# Avoid some build failures w/ PREEMPT_RT until it can be fixed
> +	depends on !PREEMPT_RT
> +	depends on EXPERT
> +	help
> +	  This option enables proxy execution, a mechanism for mutex-owning
> +	  tasks to inherit the scheduling context of higher priority waiters.
> +
>  endmenu
>  
>  #
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 67189907214d3..3968c3967ec38 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -119,6 +119,35 @@ EXPORT_TRACEPOINT_SYMBOL_GPL(sched_compute_energy_tp);
>  
>  DEFINE_PER_CPU_SHARED_ALIGNED(struct rq, runqueues);
>  
> +#ifdef CONFIG_SCHED_PROXY_EXEC
> +DEFINE_STATIC_KEY_TRUE(__sched_proxy_exec);
> +static int __init setup_proxy_exec(char *str)
> +{
> +	bool proxy_enable;
> +
> +	if (kstrtobool(str, &proxy_enable)) {

To make it work without adding =true, the above could be:

	bool proxy_enable = true;

	if (*str && kstrtobool(str, &proxy_enable)) {

> +		pr_warn("Unable to parse sched_proxy_exec=\n");
> +		return 0;
> +	}
> +
> +	if (proxy_enable) {
> +		pr_info("sched_proxy_exec enabled via boot arg\n");
> +		static_branch_enable(&__sched_proxy_exec);
> +	} else {
> +		pr_info("sched_proxy_exec disabled via boot arg\n");
> +		static_branch_disable(&__sched_proxy_exec);
> +	}
> +	return 1;
> +}

-- Steve

