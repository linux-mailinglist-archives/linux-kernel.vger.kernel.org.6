Return-Path: <linux-kernel+bounces-395739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E28D9BC242
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 02:01:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 962111C224BF
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 01:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2C6C17578;
	Tue,  5 Nov 2024 01:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g0xk4+5d"
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D5F225D7
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 01:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730768507; cv=none; b=kV3aiwHpOO3d5xfXGVword05mnK6RbYFZNiHDovge+48DxCeLhoHcIhjKMiFwbIzbxp/NgzMoVZzP58zLle+AEWZq+AhAs2A58kxfKECkgZk3igHYvQiOGl8Hc4RoqwAsJI8s2vpAPvtuNXlV+yC35HeNceJCVk2PdhHeoujBds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730768507; c=relaxed/simple;
	bh=z5YGSDgvGB6bpjwsvQKMjvGcOCAtkEUyrxCrVB3VJZs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fq69mh1SyCNy/mfvlgcsol1xKlXgZkbJd4nBNUOHXlLM3vRwImoEq+PB0V9eax7XH186VwK3OrveMOSQMPZG0rG5g+sfu1mTwNtJbozhlO4qRE9UjDWsk+yd1QmET2uUN8xP2zKLHb0S5He+RotAZI4FZUv8nsl0+H33WMKwFc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g0xk4+5d; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7b15467f383so351288785a.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 17:01:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730768503; x=1731373303; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Or9PsYziaZUPWqGCBJkZi+Ijw9yEk7z687OLKIoWH48=;
        b=g0xk4+5dF/9rBDVVkrRK4E3XNnf9wiI8Aw+TOKdfHKnAhkE2Xe25Vh0oI7VcggMzBn
         0c471/dyQ8Asd/CIMWNM3d1YeFhCUGi9gDILQVVzzxFzXBWMuwEZG7YognrIX9J7IiBQ
         0CkSF27P4RmYglaftGz/Cwv9k8k3pmOsMQ2qs6pbDJ8LPv41NZBpnhSFPospCUUTxam7
         iXKgdW8T/Lb3cnnhIWYmwpmNs1xko0eSjpLZCGwGiR2o21hUDQGfA5u9hef81XTZGJm6
         eSmSQDvymU7oauEzaERrFBH4uNV3l3Evh/7DciZpF4/00c8PwcVr6jX1vY8J2X8Ozk+t
         mssQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730768503; x=1731373303;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Or9PsYziaZUPWqGCBJkZi+Ijw9yEk7z687OLKIoWH48=;
        b=YbkzPkxNUA/yjxx6vmPC5GVZ3jRJGCFdWAkrPJuKCQIvMn9vuNzbiCad+fbgqfF8cz
         7Rc1cb5ZZGAQAatlQ89EEBJMnAKp052/fw/LyR+sVD1TtpwRFmKBA03p2SQHw6hpq+UK
         qPDOzfBcWJ8/iCcOsnPORIz5XFxWtXdztIIV/C+dLUilvrG3q5YmreLNS5QCxSLRx2XE
         eFhB55FG/L0xzPV0tlwHoI4xXlGcGzGEPYqyt/Q4rpJ+uYTTl9psbBWhOByHcnNs6hKB
         oCK6mbKx/qE/WO38DHpa/TkBN90SUVRmyp6Z9a2lqe02aVBfoT7N9znFfzvK3IXkejur
         n6zA==
X-Forwarded-Encrypted: i=1; AJvYcCU2GbaVIrMp43iULcrHLVG2Jo0S+4UXmwRr2M8iH900FQlOCKqvlXqbfvvI0KcDaza0ZNtWb+gYNMktiq4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7UcjPr0l7Cj09aX0L6hJpf5C9LjBjgwxeGXdv4+IDZuCoaphO
	zAk61Ru9j3owJ8+0hMP5/bSoFuvnA160L6TRFMJUwqSyM1J+DKql
X-Google-Smtp-Source: AGHT+IHUQLFQhGnW6z5+2fS8VC3gI8vNmXoG9HSaPHonVhDHsgyMTXfrKv8FpWKgWCNNgdeDonnt6g==
X-Received: by 2002:a05:620a:28c4:b0:7b1:5346:e72d with SMTP id af79cd13be357-7b2f24dd7c6mr2557316485a.23.1730768503394;
        Mon, 04 Nov 2024 17:01:43 -0800 (PST)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b2f3a868dasm472211985a.121.2024.11.04.17.01.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 17:01:42 -0800 (PST)
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfauth.phl.internal (Postfix) with ESMTP id 2229B1200043;
	Mon,  4 Nov 2024 20:01:42 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 04 Nov 2024 20:01:42 -0500
X-ME-Sender: <xms:dm4pZ-XEOH2HKjiFpRQQLfcREpxc9fysqdObu-4bc7J7dcvWZWzNrA>
    <xme:dm4pZ6mvI7Pj8-wZMvczPvCl8PAGOoQ8RBpxQPnT8Um-UqBKOQRcHG4tCZye530-b
    4kNc90prQjKXhbSKg>
X-ME-Received: <xmr:dm4pZyb5L8srqyBwwIfvOxjI_JH2Z0OCZskiCKM_X-rqfL-JdA015t6CRlys_Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeljedgfedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrd
    gtohhmqeenucggtffrrghtthgvrhhnpefhtedvgfdtueekvdekieetieetjeeihedvteeh
    uddujedvkedtkeefgedvvdehtdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdo
    mhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqddujeejke
    ehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgr
    mhgvpdhnsggprhgtphhtthhopedujedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
    epsghighgvrghshieslhhinhhuthhrohhnihigrdguvgdprhgtphhtthhopehprghulhhm
    tghksehkvghrnhgvlhdrohhrghdprhgtphhtthhopehvsggrsghkrgesshhushgvrdgtii
    dprhgtphhtthhopegvlhhvvghrsehgohhoghhlvgdrtghomhdprhgtphhtthhopehlihhn
    uhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrg
    hsrghnqdguvghvsehgohhoghhlvghgrhhouhhpshdrtghomhdprhgtphhtthhopehlihhn
    uhigqdhmmheskhhvrggtkhdrohhrghdprhgtphhtthhopehsfhhrsegtrghnsgdrrghuuh
    hgrdhorhhgrdgruhdprhgtphhtthhopehlohhnghhmrghnsehrvgguhhgrthdrtghomh
X-ME-Proxy: <xmx:dm4pZ1WlMIWEVGiCuOYM-VF9oO2USd01U_CU4bS_U_nsi_ALnUfuhw>
    <xmx:dm4pZ4mH4MZS8TscmbX-MB4OJn-3Dv9z9iqVxwg69aWNskoeDvv56Q>
    <xmx:dm4pZ6dnkahyC-Ypo8e9-3Os6595Oij9nZJMoi8vVySIaJu6xMORUA>
    <xmx:dm4pZ6G9mjup8-HInUX6L3FVJeBoQUfVQtgBS_KlGYFh9Ci8yOSd3A>
    <xmx:dm4pZ2kwXt4AIdKLZretNzMT_-5Ry-GWhSp3eVK4c---SOLCIKrG5lH6>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 4 Nov 2024 20:01:41 -0500 (EST)
Date: Mon, 4 Nov 2024 17:00:19 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
	Vlastimil Babka <vbabka@suse.cz>, Marco Elver <elver@google.com>,
	linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
	linux-mm@kvack.org, sfr@canb.auug.org.au, longman@redhat.com,
	cl@linux.com, penberg@kernel.org, rientjes@google.com,
	iamjoonsoo.kim@lge.com, akpm@linux-foundation.org,
	Tomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 2/2] scftorture: Use a lock-less list to free memory.
Message-ID: <ZyluI0A-LSvvbBb9@boqun-archlinux>
References: <88694240-1eea-4f4c-bb7b-80de25f252e7@paulmck-laptop>
 <20241104105053.2182833-1-bigeasy@linutronix.de>
 <20241104105053.2182833-2-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241104105053.2182833-2-bigeasy@linutronix.de>

Hi Sebastian,

I love this approach, I think it's better than my workqueue work around,
a few comments below:

On Mon, Nov 04, 2024 at 11:50:53AM +0100, Sebastian Andrzej Siewior wrote:
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
> ---
>  kernel/scftorture.c | 47 +++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 43 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/scftorture.c b/kernel/scftorture.c
> index e5546fe256329..ba9f1125821b8 100644
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
> @@ -148,6 +150,40 @@ static DEFINE_TORTURE_RANDOM_PERCPU(scf_torture_rand);
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
> +	unsigned int slot = 0;
> +	void *free_pool[64];
> +
> +	pool = &per_cpu(scf_free_pool, cpu);
> +	node = llist_del_all(pool);
> +	while (node) {
> +		scfcp = llist_entry(node, struct scf_check, scf_node);
> +		node = node->next;
> +		free_pool[slot] = scfcp;
> +		slot++;
> +		if (slot == ARRAY_SIZE(free_pool)) {
> +			kfree_bulk(slot, free_pool);
> +			slot = 0;
> +		}
> +	}
> +	if (slot)
> +		kfree_bulk(slot, free_pool);
> +}
> +
>  // Print torture statistics.  Caller must ensure serialization.
>  static void scf_torture_stats_print(void)
>  {
> @@ -296,7 +332,7 @@ static void scf_handler(void *scfc_in)
>  		if (scfcp->scfc_rpc)
>  			complete(&scfcp->scfc_completion);
>  	} else {
> -		kfree(scfcp);
> +		scf_add_to_free_list(scfcp);
>  	}
>  }
>  
> @@ -363,7 +399,7 @@ static void scftorture_invoke_one(struct scf_statistics *scfp, struct torture_ra
>  				scfp->n_single_wait_ofl++;
>  			else
>  				scfp->n_single_ofl++;
> -			kfree(scfcp);
> +			scf_add_to_free_list(scfcp);
>  			scfcp = NULL;
>  		}
>  		break;
> @@ -391,7 +427,7 @@ static void scftorture_invoke_one(struct scf_statistics *scfp, struct torture_ra
>  				preempt_disable();
>  		} else {
>  			scfp->n_single_rpc_ofl++;
> -			kfree(scfcp);
> +			scf_add_to_free_list(scfcp);
>  			scfcp = NULL;
>  		}
>  		break;
> @@ -428,7 +464,7 @@ static void scftorture_invoke_one(struct scf_statistics *scfp, struct torture_ra
>  			pr_warn("%s: Memory-ordering failure, scfs_prim: %d.\n", __func__, scfsp->scfs_prim);
>  			atomic_inc(&n_mb_out_errs); // Leak rather than trash!
>  		} else {
> -			kfree(scfcp);
> +			scf_add_to_free_list(scfcp);
>  		}
>  		barrier(); // Prevent race-reduction compiler optimizations.
>  	}
> @@ -442,6 +478,7 @@ static void scftorture_invoke_one(struct scf_statistics *scfp, struct torture_ra
>  		schedule_timeout_uninterruptible(1);
>  }
>  
> +
>  // SCF test kthread.  Repeatedly does calls to members of the
>  // smp_call_function() family of functions.
>  static int scftorture_invoker(void *arg)
> @@ -479,6 +516,8 @@ static int scftorture_invoker(void *arg)
>  	VERBOSE_SCFTORTOUT("scftorture_invoker %d started", scfp->cpu);
>  
>  	do {
> +		scf_cleanup_free_list(scfp->cpu);
> +

I think this needs to be:

		scf_cleanup_free_list(cpu);

or

		scf_cleanup_free_list(curcpu);

because scfp->cpu is actually the thread number, and I got a NULL
dereference:

[   14.219225] BUG: unable to handle page fault for address: ffffffffb2ff7210

while running Paul's reproduce command:

tools/testing/selftests/rcutorture/bin/kvm.sh --torture scf --allcpus --duration 2 --configs PREEMPT --kconfig CONFIG_NR_CPUS=64 --memory 7G --trust-make --kasan --bootargs "scftorture.nthreads=64 torture.disable_onoff_at_boot csdlock_debug=1"

on my 48 cores VM (I think 48 core may be key to reproduce the NULL
dereference).


Another thing is, how do we guarantee that we don't exit the loop
eariler (i.e. while there are still callbacks on the list)? After the
following scftorture_invoke_one(), there could an IPI pending somewhere,
and we may exit this loop if torture_must_stop() is true. And that IPI
might add its scf_check to the list but no scf_cleanup_free_list() is
going to handle that, right?

Regards,
Boqun

>  		scftorture_invoke_one(scfp, &rand);
>  		while (cpu_is_offline(cpu) && !torture_must_stop()) {
>  			schedule_timeout_interruptible(HZ / 5);
> -- 
> 2.45.2
> 

