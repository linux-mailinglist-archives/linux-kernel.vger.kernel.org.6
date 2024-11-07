Return-Path: <linux-kernel+bounces-400455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A8659C0DD3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 19:31:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D3C7283C13
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 18:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF4D9194A59;
	Thu,  7 Nov 2024 18:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o1vzfRD0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2830EF9D6
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 18:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731004265; cv=none; b=VeHmUqb1MySK4KGmsxvm9HsOVC07rVgzM9z2VauX3hoTlKmWYZRetB6MNz56lnkqoWMviKRklDxJQKi4THXB1AfHY9g5lWgwkkAiR7bPLMAOob99ZxM/846dq/7MuwcGm1iKz0EB2zgCXPmAgETwc7j3LPI5BBjEPebe1tb6CBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731004265; c=relaxed/simple;
	bh=ZYRVY8sNunfS28Hfdf4uEMKjhHqSaZEaY12DFnb70wU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WXHhio4F5Rr3y5uVBMoB2Mv8UHqB46Fu5STkkgFS47ca7VUHcMJevRAfn5huddzl8HOdGHX3ZBh2VlDRRWIP3s200CZs9g8dsSJ43kzqbLLUM3BhAGYgGbUYLl23tgfSRjFIFwP0Lba9uHjPxbrktgC8xvxds1tBwFit4m7Zv9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o1vzfRD0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B5E0C4CECC;
	Thu,  7 Nov 2024 18:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731004264;
	bh=ZYRVY8sNunfS28Hfdf4uEMKjhHqSaZEaY12DFnb70wU=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=o1vzfRD0XXs4iz5vG5R9iWZ/cEnogz6sOsXkw8/ECOKv7hykf+iFQqbEOs8UcnBAb
	 Lcz/UMSMPLAP3qWuWjtYQJZ9hgUZaJEZzciasbJoWGA5EEgnhBGuIcL/mPtMKHzIoy
	 hl02RJQ/MalHZVuReXg3BgJMDmlq6xZVBeTJRUGi5qQcdaOccxsOmsERJcaGiLYExf
	 52c5P+lyEd+xGxelXnkG1k5brlnqtCLDcuhxRYAiSrC7CvllIVolJrsK5bmt5lbHaY
	 ouIo8PaUSlybQm+tQEOtiUjwPekhQjUmT0kLS6ua9OYTUj6oSe88OKxJjIPY9nbSo6
	 7r5aNLOdV5Z2A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 46D3ECE0886; Thu,  7 Nov 2024 10:31:04 -0800 (PST)
Date: Thu, 7 Nov 2024 10:31:04 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, Boqun Feng <boqun.feng@gmail.com>,
	Marco Elver <elver@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Tomas Gleixner <tglx@linutronix.de>,
	Vlastimil Babka <vbabka@suse.cz>, akpm@linux-foundation.org,
	cl@linux.com, iamjoonsoo.kim@lge.com, longman@redhat.com,
	penberg@kernel.org, rientjes@google.com, sfr@canb.auug.org.au
Subject: Re: [PATCH v2 3/3] scftorture: Use a lock-less list to free memory.
Message-ID: <abeb5162-2751-4eb1-ad0d-00a6a7ca5e70@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20241107111821.3417762-1-bigeasy@linutronix.de>
 <20241107111821.3417762-4-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241107111821.3417762-4-bigeasy@linutronix.de>

On Thu, Nov 07, 2024 at 12:13:08PM +0100, Sebastian Andrzej Siewior wrote:
> scf_handler() is used as a SMP function call. This function is always
> invoked in IRQ-context even with forced-threading enabled. This function
> frees memory which not allowed on PREEMPT_RT because the locking
> underneath is using sleeping locks.
> 
> Add a per-CPU scf_free_pool where each SMP functions adds its memory to
> be freed. This memory is then freed by scftorture_invoker() on each
> iteration. On the majority of invocations the number of items is less
> than five. If the thread sleeps/ gets delayed the number exceed 350 but
> did not reach 400 in testing. These were the spikes during testing.
> The bulk free of 64 pointers at once should improve the give-back if the
> list grows. The list size is ~1.3 items per invocations.
> 
> Having one global scf_free_pool with one cleaning thread let the list
> grow to over 10.000 items with 32 CPUs (again, spikes not the average)
> especially if the CPU went to sleep. The per-CPU part looks like a good
> compromise.
> 
> Reported-by: "Paul E. McKenney" <paulmck@kernel.org>
> Closes: https://lore.kernel.org/lkml/41619255-cdc2-4573-a360-7794fc3614f7@paulmck-laptop/
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Nice!!!

One nit at the end below.

> ---
>  kernel/scftorture.c | 39 +++++++++++++++++++++++++++++++++++----
>  1 file changed, 35 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/scftorture.c b/kernel/scftorture.c
> index 555b3b10621fe..1268a91af5d88 100644
> --- a/kernel/scftorture.c
> +++ b/kernel/scftorture.c
> @@ -97,6 +97,7 @@ struct scf_statistics {
>  static struct scf_statistics *scf_stats_p;
>  static struct task_struct *scf_torture_stats_task;
>  static DEFINE_PER_CPU(long long, scf_invoked_count);
> +static DEFINE_PER_CPU(struct llist_head, scf_free_pool);
>  
>  // Data for random primitive selection
>  #define SCF_PRIM_RESCHED	0
> @@ -133,6 +134,7 @@ struct scf_check {
>  	bool scfc_wait;
>  	bool scfc_rpc;
>  	struct completion scfc_completion;
> +	struct llist_node scf_node;
>  };
>  
>  // Use to wait for all threads to start.
> @@ -148,6 +150,31 @@ static DEFINE_TORTURE_RANDOM_PERCPU(scf_torture_rand);
>  
>  extern void resched_cpu(int cpu); // An alternative IPI vector.
>  
> +static void scf_add_to_free_list(struct scf_check *scfcp)
> +{
> +	struct llist_head *pool;
> +	unsigned int cpu;
> +
> +	cpu = raw_smp_processor_id() % nthreads;
> +	pool = &per_cpu(scf_free_pool, cpu);
> +	llist_add(&scfcp->scf_node, pool);
> +}
> +
> +static void scf_cleanup_free_list(unsigned int cpu)
> +{
> +	struct llist_head *pool;
> +	struct llist_node *node;
> +	struct scf_check *scfcp;
> +
> +	pool = &per_cpu(scf_free_pool, cpu);
> +	node = llist_del_all(pool);
> +	while (node) {
> +		scfcp = llist_entry(node, struct scf_check, scf_node);
> +		node = node->next;
> +		kfree(scfcp);
> +	}
> +}
> +
>  // Print torture statistics.  Caller must ensure serialization.
>  static void scf_torture_stats_print(void)
>  {
> @@ -296,7 +323,7 @@ static void scf_handler(void *scfc_in)
>  		if (scfcp->scfc_rpc)
>  			complete(&scfcp->scfc_completion);
>  	} else {
> -		kfree(scfcp);
> +		scf_add_to_free_list(scfcp);
>  	}
>  }
>  
> @@ -363,7 +390,7 @@ static void scftorture_invoke_one(struct scf_statistics *scfp, struct torture_ra
>  				scfp->n_single_wait_ofl++;
>  			else
>  				scfp->n_single_ofl++;
> -			kfree(scfcp);
> +			scf_add_to_free_list(scfcp);
>  			scfcp = NULL;
>  		}
>  		break;
> @@ -391,7 +418,7 @@ static void scftorture_invoke_one(struct scf_statistics *scfp, struct torture_ra
>  				preempt_disable();
>  		} else {
>  			scfp->n_single_rpc_ofl++;
> -			kfree(scfcp);
> +			scf_add_to_free_list(scfcp);
>  			scfcp = NULL;
>  		}
>  		break;
> @@ -428,7 +455,7 @@ static void scftorture_invoke_one(struct scf_statistics *scfp, struct torture_ra
>  			pr_warn("%s: Memory-ordering failure, scfs_prim: %d.\n", __func__, scfsp->scfs_prim);
>  			atomic_inc(&n_mb_out_errs); // Leak rather than trash!
>  		} else {
> -			kfree(scfcp);
> +			scf_add_to_free_list(scfcp);
>  		}
>  		barrier(); // Prevent race-reduction compiler optimizations.
>  	}
> @@ -479,6 +506,8 @@ static int scftorture_invoker(void *arg)
>  	VERBOSE_SCFTORTOUT("scftorture_invoker %d started", scfp->cpu);
>  
>  	do {
> +		scf_cleanup_free_list(cpu);
> +
>  		scftorture_invoke_one(scfp, &rand);
>  		while (cpu_is_offline(cpu) && !torture_must_stop()) {
>  			schedule_timeout_interruptible(HZ / 5);
> @@ -538,6 +567,8 @@ static void scf_torture_cleanup(void)
>  
>  end:
>  	torture_cleanup_end();
> +	for (i = 0; i < nthreads; i++)
> +		scf_cleanup_free_list(i);

It would be better for this to precede the call to torture_cleanup_end().
As soon as torture_cleanup_end() is invoked, in theory, another torture
test might start.  Yes, in practice, this would only matter if the next
module was again scftorture and you aren't supposed to modprobe a given
module until after the prior rmmod has completed, which would prevent
this scf_cleanup_free_list() from interacting with the incoming instance
of scftorture.

But why even allow the possibility?

							Thanx, Paul

>  }
>  
>  static int __init scf_torture_init(void)
> -- 
> 2.45.2
> 

