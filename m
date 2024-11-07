Return-Path: <linux-kernel+bounces-400613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4982E9C0FF2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 21:45:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFD8D1F23A2C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 20:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D205212EEC;
	Thu,  7 Nov 2024 20:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hllYnFY0"
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 346CC186E58
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 20:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731012330; cv=none; b=WIPGkR/SSZlPFO//yFtYfso9ec1kzFN9VlD7K+Y4mr4zaLxjDDTuSMCfqEOVBy9g19M6gXEgqY2Xh73kV00ZLWqoGvpMtB2oac+GGX3sItyKwTcEA7mYAH66/isR/ot32nwangzYr78lKEIrXWWnn+rYUMV1Y0rTjI4bQgCS2AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731012330; c=relaxed/simple;
	bh=lJZ2ySURvc4EXgZo7cWL4IfpoKskpDzsZTsw60ge9SU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iWI63OYL3zrk1usYWLhY36cW1sZC/5NVYdvf9HcLmpYgzvI3pyHeq+VZAHzVNqh9/tuWUfP28j29EWuxXSTGHRolFVqCO45Qa9dBOWAZFfz56S3vIrkbqXroyGvo8oKxkz7Dt+JeZsguu0A9JGr4JrWt2XpeGBirE8sgMCv+BXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hllYnFY0; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e30d1d97d20so1287083276.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2024 12:45:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731012328; x=1731617128; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ASBXo4Z2Zrw1kV9v2x3uChH0kNYmBXHhzCm3vG2Xcz8=;
        b=hllYnFY0yWTxLcObkI7FnGk5fHMa9B5ADJaq/CoQtWptgQPUNXCy+IADQXpC7OXv6s
         u6Nfuphr25GadyST1FedU0wx2VgsTWuvLhnS56q9kIWCIC76raZPbBMK3Ks3Cdxk0FOn
         lLo+DxakkPYDTMz4EBKPvohsTU0N69YLmbUPBoPsgjVbuySP1SeTWUgHAsWFLpNR/uqV
         gGCEGsS7UUjkyAuhc7WGg0uUgMFkrdhgtKqNL/l5mwYd2S3Hl0x83/doe0YVhJSBXBgM
         rY+c5FC2P1uptK5gqAvskvcp2/54v9ZYUsWDzCPhHwlGgdKGADJwIo6M/fXpGELSan4z
         1yRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731012328; x=1731617128;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ASBXo4Z2Zrw1kV9v2x3uChH0kNYmBXHhzCm3vG2Xcz8=;
        b=taFKYcb94NWvrNH/rtJdkVl1p8zzQlBcssLlHCq4/Rj0YTbb0W7EDlVo2iIxrRxeDB
         gVErF2fcFol3YSVOgRdpz9RUXUiVc7HtQmrQk95YBaT8jNHZmXB+7+QXAaz3doKlst/b
         4lLIGjMF3YBOo2DEKKEgD3uxfoOFrynTXAVvwNFTgjbiZjHHq69+pampOs+KH6TaSBR9
         2EzMd01LaEGOK/g6hCWOLvZIFdjg6i0LhYH7NtXRdBPVYiPeXJZVsloqSVJB1CYyOIL2
         fK3AokZz3rAVbt2YgWW7H1e/iBSynoww639iJgZlh+CFeTWg3258ttW0tMDL1L5+/JmZ
         T4Fg==
X-Forwarded-Encrypted: i=1; AJvYcCUllDH5Ov2mZp15B9cbRt8QmgsNOoLNyBz3aY9+SP4mRIypjpHHz4AUFNrIUnmWwlrSLP5/97owWBnPN0c=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywa16SjYbCq44sflAlViVGMVGdQ51P2d50jMzDwGluC91CHsbI+
	fndI/Hp3ueCKL4zzPF9ksFykTEWgb98Yxf+d33NvuzNBymYNV5dG
X-Google-Smtp-Source: AGHT+IE6noozYvbqtiN1Ng44Z7wlpCMOXuJB4I0BDFpByRSZ3rjYle85/BW+mx0dMKqPe71bag4ulg==
X-Received: by 2002:a05:6902:f84:b0:e30:cd90:b631 with SMTP id 3f1490d57ef6-e337f8f0c61mr412352276.33.1731012327942;
        Thu, 07 Nov 2024 12:45:27 -0800 (PST)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-462ff5e14f9sm11750031cf.86.2024.11.07.12.45.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 12:45:27 -0800 (PST)
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfauth.phl.internal (Postfix) with ESMTP id C929D1200043;
	Thu,  7 Nov 2024 15:45:26 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Thu, 07 Nov 2024 15:45:26 -0500
X-ME-Sender: <xms:5iYtZ4anBIkz8mLikFbtjBpK2wggB7G8dYkoRt3dv3RlgcCpH3Lraw>
    <xme:5iYtZzbU-3AWEINOE7FxrEAb7XmYh4YiNPoTYidsY3Gw0qGUpjiKN8bf_ajgQJIma
    72PH0wuF3h-5T_H0Q>
X-ME-Received: <xmr:5iYtZy83CsmHsGYC5i4fcVOey-J8cKZ3gDNF-gpZMJBdrtOS5etdJBUT0Eo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrtdeggddufeelucetufdoteggodetrfdotf
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
    epsghighgvrghshieslhhinhhuthhrohhnihigrdguvgdprhgtphhtthhopehkrghsrghn
    qdguvghvsehgohhoghhlvghgrhhouhhpshdrtghomhdprhgtphhtthhopehlihhnuhigqd
    hkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhig
    qdhmmheskhhvrggtkhdrohhrghdprhgtphhtthhopehprghulhhmtghksehkvghrnhgvlh
    drohhrghdprhgtphhtthhopegvlhhvvghrsehgohhoghhlvgdrtghomhdprhgtphhtthho
    pehpvghtvghriiesihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehtghhlgieslh
    hinhhuthhrohhnihigrdguvgdprhgtphhtthhopehvsggrsghkrgesshhushgvrdgtii
X-ME-Proxy: <xmx:5iYtZyolJa3NccFGpih2eG96Ilh61CmPZPHUGvGfb1J0rBx18Xos4A>
    <xmx:5iYtZzpTMAPqDfge5NwoWBh-uHvvLhKkr78apl0kN4zqRYVS1chj-g>
    <xmx:5iYtZwQouEz9J7IPFCKgBSDKpzRuhwdXo2nbCGW8o3ZcE_nli5hpAg>
    <xmx:5iYtZzozquyoM1X86TAoVl_h1acc23me483B8R58GyrD_2amDsZo5Q>
    <xmx:5iYtZ464pjyIiholy018iKlly8G9yT4XfRG6PHb3VTPHN6uqtu6rkqSd>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 Nov 2024 15:45:26 -0500 (EST)
Date: Thu, 7 Nov 2024 12:45:25 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, "Paul E. McKenney" <paulmck@kernel.org>,
	Marco Elver <elver@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Tomas Gleixner <tglx@linutronix.de>,
	Vlastimil Babka <vbabka@suse.cz>, akpm@linux-foundation.org,
	cl@linux.com, iamjoonsoo.kim@lge.com, longman@redhat.com,
	penberg@kernel.org, rientjes@google.com, sfr@canb.auug.org.au
Subject: Re: [PATCH v2 3/3] scftorture: Use a lock-less list to free memory.
Message-ID: <Zy0m5TBz3Ne55syG@Boquns-Mac-mini.local>
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

This needs to be:

	for (i = 0; i < nr_cpu_ids; i++)

because nthreads can be larger than nr_cpu_ids, and it'll access a
out-of-bound percpu section.

Regards,
Boqun

> +		scf_cleanup_free_list(i);
>  }
>  
>  static int __init scf_torture_init(void)
> -- 
> 2.45.2
> 

