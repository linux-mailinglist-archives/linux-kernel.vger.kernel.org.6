Return-Path: <linux-kernel+bounces-174271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 005518C0C5E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 10:17:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EFD21F213DF
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 08:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A562149DF9;
	Thu,  9 May 2024 08:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c4+yUBAL"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA8D149C70
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 08:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715242635; cv=none; b=KkZTlWZrKzm38R53rWLF+pQ3cz04+N2DPgDk1oxxmLmBRnmvDFqvk1QdqaanmXNKyCMooy9yS2moqrP8RmfE7eTaSv7njJCNf4Ks/yxup0a+qwQlElYeTwJ9bsxjIJc65wnaxSxUQSiPQjENVFIn3Qd+73h7h9WGucja+H2Qf6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715242635; c=relaxed/simple;
	bh=z+Jz0XJNCIYfLXyzhPT9j7ItAc6fH11c9EUoLCJDGsw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Disposition; b=XIfUk8dYPk8wI3QCDeKhf3c6390ctR2xq9k3pvDaGIxukJzJ0+zgeAgU5c11iDMofUbYiDtmEDzO6yj7k225k26RLteTsYeRbX0yLGWHK1EvVhh/8gZVWf+u/noB28/BejG5AiIqMPZl06EgQuttn2ZyMo1zgr6LnZmFf0VH73g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c4+yUBAL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715242631;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mOTfAiwr8LPoxMSWtWdohs6mTjoqQRYS+50SI4ZMF78=;
	b=c4+yUBALWaC0hdVENjUSX7b2A1mE41GNrRQ5L9fyQyBaxbN/nzfJU50IwKAvvDdZ88K1a/
	JOr9lVUjAso3W44f8L/y3vl4G1OEd9FsrsggrZFOsDOCteDG63PR8qPmDaccMZbcIfAlAm
	BbCz5IPnct1CIh2lENmmfX58PGDcdoA=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-94-ab5KTIyiNYeyuT704piqVg-1; Thu, 09 May 2024 04:17:09 -0400
X-MC-Unique: ab5KTIyiNYeyuT704piqVg-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2b29f4af4e4so586455a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2024 01:17:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715242628; x=1715847428;
        h=content-transfer-encoding:content-disposition:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mOTfAiwr8LPoxMSWtWdohs6mTjoqQRYS+50SI4ZMF78=;
        b=KrWUKV8jvJb4FQmCaxXn8oM8HuDzl49Ioh9/zlioe6NG2Jy19pHjKzvnrLM6ZasRKe
         jlXdH6ju7f3V4QlPl87xe0acVyS9MCCX253jA0DP8Qh1lIxN7WZ9m2MemU3zYItkMZ3C
         tFtZ+Rgs1RiW4ciZgXpjYhTqwFprpf57ZGCHaLCm4iQlSZrP2SRcoajFym6QSSuJeJDN
         kdwdcIMKHIPYDXTzQe5aEso2trMz8x2/c/nNLiYhpJJxk8RBQB9MV0ZYOmhkSVHWMYub
         +XVWnheamyIDrJiQ5LVHSvVEO3Yh6kp7NxqbAAtyf/VoSzx4ZShBcmksdfk9GS4CdEY7
         TN7Q==
X-Forwarded-Encrypted: i=1; AJvYcCW7RcQxLval04h5VdeITCc3cPMCCLF20iP5Pq6K8qA4DRDzto9LzKIST5+E1jrw5jnjUX6Ze7m12h+3ZyvUxujcNK97v4KJsk+LpobY
X-Gm-Message-State: AOJu0YzfQ6Xjuefo9BCVL2VX7p2SmP6LWNhGOwugMMTjaYomapBZf554
	o33SsSuTaot+ydznhXHDVf67E0KzhGTVC8b4Q2hlUgbDN27sab7E3GKmM3M9ihNIFVru6B/AEGe
	P9atTTMWnjUKmeU1ZBXoxvLzwDW0vtKt//gv20tH1czJEQXRuGcItwaaeS0DFAA==
X-Received: by 2002:a17:90b:1207:b0:2b1:1c1e:f489 with SMTP id 98e67ed59e1d1-2b6163a22b4mr4576634a91.4.1715242628356;
        Thu, 09 May 2024 01:17:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF1A96obndE18f37GMHCs8NrHkLBSwaU944om0lk68JAKckCEop7wqS+RM99maUMjHe2qfTqg==
X-Received: by 2002:a17:90b:1207:b0:2b1:1c1e:f489 with SMTP id 98e67ed59e1d1-2b6163a22b4mr4576608a91.4.1715242627852;
        Thu, 09 May 2024 01:17:07 -0700 (PDT)
Received: from LeoBras.redhat.com ([2804:1b3:a800:8d87:eac1:dae4:8dd4:fe50])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2b628ea6ae7sm2721939a91.51.2024.05.09.01.17.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 01:17:07 -0700 (PDT)
From: Leonardo Bras <leobras@redhat.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Leonardo Bras <leobras@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <quic_neeraju@quicinc.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org
Subject: Re: [RFC PATCH v1 0/2] Avoid rcu_core() if CPU just left guest vcpu
Date: Thu,  9 May 2024 05:16:57 -0300
Message-ID: <ZjyGefTZ8ThZukNG@LeoBras>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <5fd66909-1250-4a91-aa71-93cb36ed4ad5@paulmck-laptop>
References: <663a659d-3a6f-4bec-a84b-4dd5fd16c3c1@paulmck-laptop> <ZjqWXPFuoYWWcxP3@google.com> <0e239143-65ed-445a-9782-e905527ea572@paulmck-laptop> <Zjq9okodmvkywz82@google.com> <ZjrClk4Lqw_cLO5A@google.com> <Zjroo8OsYcVJLsYO@LeoBras> <b44962dd-7b8a-4201-90b7-4c39ba20e28d@paulmck-laptop> <ZjsZVUdmDXZOn10l@LeoBras> <ZjuFuZHKUy7n6-sG@google.com> <5fd66909-1250-4a91-aa71-93cb36ed4ad5@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Wed, May 08, 2024 at 08:32:40PM -0700, Paul E. McKenney wrote:
> On Wed, May 08, 2024 at 07:01:29AM -0700, Sean Christopherson wrote:
> > On Wed, May 08, 2024, Leonardo Bras wrote:
> > > Something just hit me, and maybe I need to propose something more generic.
> > 
> > Yes.  This is what I was trying to get across with my complaints about keying off
> > of the last VM-Exit time.  It's effectively a broad stroke "this task will likely
> > be quiescent soon" and so the core concept/functionality belongs in common code,
> > not KVM.
> 
> OK, we could do something like the following wholly within RCU, namely
> to make rcu_pending() refrain from invoking rcu_core() until the grace
> period is at least the specified age, defaulting to zero (and to the
> current behavior).
> 
> Perhaps something like the patch shown below.

That's exactly what I was thinking :)

> 
> Thoughts?

Some suggestions below:

> 
> 							Thanx, Paul
> 
> ------------------------------------------------------------------------
> 
> commit abc7cd2facdebf85aa075c567321589862f88542
> Author: Paul E. McKenney <paulmck@kernel.org>
> Date:   Wed May 8 20:11:58 2024 -0700
> 
>     rcu: Add rcutree.nocb_patience_delay to reduce nohz_full OS jitter
>     
>     If a CPU is running either a userspace application or a guest OS in
>     nohz_full mode, it is possible for a system call to occur just as an
>     RCU grace period is starting.  If that CPU also has the scheduling-clock
>     tick enabled for any reason (such as a second runnable task), and if the
>     system was booted with rcutree.use_softirq=0, then RCU can add insult to
>     injury by awakening that CPU's rcuc kthread, resulting in yet another
>     task and yet more OS jitter due to switching to that task, running it,
>     and switching back.
>     
>     In addition, in the common case where that system call is not of
>     excessively long duration, awakening the rcuc task is pointless.
>     This pointlessness is due to the fact that the CPU will enter an extended
>     quiescent state upon returning to the userspace application or guest OS.
>     In this case, the rcuc kthread cannot do anything that the main RCU
>     grace-period kthread cannot do on its behalf, at least if it is given
>     a few additional milliseconds (for example, given the time duration
>     specified by rcutree.jiffies_till_first_fqs, give or take scheduling
>     delays).
>     
>     This commit therefore adds a rcutree.nocb_patience_delay kernel boot
>     parameter that specifies the grace period age (in milliseconds)
>     before which RCU will refrain from awakening the rcuc kthread.
>     Preliminary experiementation suggests a value of 1000, that is,
>     one second.  Increasing rcutree.nocb_patience_delay will increase
>     grace-period latency and in turn increase memory footprint, so systems
>     with constrained memory might choose a smaller value.  Systems with
>     less-aggressive OS-jitter requirements might choose the default value
>     of zero, which keeps the traditional immediate-wakeup behavior, thus
>     avoiding increases in grace-period latency.
>     
>     Link: https://lore.kernel.org/all/20240328171949.743211-1-leobras@redhat.com/
>     
>     Reported-by: Leonardo Bras <leobras@redhat.com>
>     Suggested-by: Leonardo Bras <leobras@redhat.com>
>     Suggested-by: Sean Christopherson <seanjc@google.com>
>     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 0a3b0fd1910e6..42383986e692b 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -4981,6 +4981,13 @@
>  			the ->nocb_bypass queue.  The definition of "too
>  			many" is supplied by this kernel boot parameter.
>  
> +	rcutree.nocb_patience_delay= [KNL]
> +			On callback-offloaded (rcu_nocbs) CPUs, avoid
> +			disturbing RCU unless the grace period has
> +			reached the specified age in milliseconds.
> +			Defaults to zero.  Large values will be capped
> +			at five seconds.
> +
>  	rcutree.qhimark= [KNL]
>  			Set threshold of queued RCU callbacks beyond which
>  			batch limiting is disabled.
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 7560e204198bb..6e4b8b43855a0 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -176,6 +176,8 @@ static int gp_init_delay;
>  module_param(gp_init_delay, int, 0444);
>  static int gp_cleanup_delay;
>  module_param(gp_cleanup_delay, int, 0444);
> +static int nocb_patience_delay;
> +module_param(nocb_patience_delay, int, 0444);
>  
>  // Add delay to rcu_read_unlock() for strict grace periods.
>  static int rcu_unlock_delay;
> @@ -4334,6 +4336,8 @@ EXPORT_SYMBOL_GPL(cond_synchronize_rcu_full);
>  static int rcu_pending(int user)
>  {
>  	bool gp_in_progress;
> +	unsigned long j = jiffies;

I think this is probably taken care by the compiler, but just in case I would move the 
j = jiffies;
closer to it's use, in order to avoid reading 'jiffies' if rcu_pending 
exits before the nohz_full testing.


> +	unsigned int patience = msecs_to_jiffies(nocb_patience_delay);

What do you think on processsing the new parameter in boot, and saving it 
in terms of jiffies already? 

It would make it unnecessary to convert ms -> jiffies every time we run 
rcu_pending.

(OOO will probably remove the extra division, but may cause less impact in 
some arch)

>  	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
>  	struct rcu_node *rnp = rdp->mynode;
>  
> @@ -4347,11 +4351,13 @@ static int rcu_pending(int user)
>  		return 1;
>  
>  	/* Is this a nohz_full CPU in userspace or idle?  (Ignore RCU if so.) */
> -	if ((user || rcu_is_cpu_rrupt_from_idle()) && rcu_nohz_full_cpu())
> +	gp_in_progress = rcu_gp_in_progress();
> +	if ((user || rcu_is_cpu_rrupt_from_idle() ||
> +	     (gp_in_progress && time_before(j + patience, rcu_state.gp_start))) &&

I think you meant:
	time_before(j, rcu_state.gp_start + patience)

or else this always fails, as we can never have now to happen before a 
previously started gp, right?

Also, as per rcu_nohz_full_cpu() we probably need it to be read with 
READ_ONCE():

	time_before(j, READ_ONCE(rcu_state.gp_start) + patience)

> +	    rcu_nohz_full_cpu())
>  		return 0;
>  
>  	/* Is the RCU core waiting for a quiescent state from this CPU? */
> -	gp_in_progress = rcu_gp_in_progress();
>  	if (rdp->core_needs_qs && !rdp->cpu_no_qs.b.norm && gp_in_progress)
>  		return 1;
>  
> diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> index 340bbefe5f652..174333d0e9507 100644
> --- a/kernel/rcu/tree_plugin.h
> +++ b/kernel/rcu/tree_plugin.h
> @@ -93,6 +93,15 @@ static void __init rcu_bootup_announce_oddness(void)
>  		pr_info("\tRCU debug GP init slowdown %d jiffies.\n", gp_init_delay);
>  	if (gp_cleanup_delay)
>  		pr_info("\tRCU debug GP cleanup slowdown %d jiffies.\n", gp_cleanup_delay);
> +	if (nocb_patience_delay < 0) {
> +		pr_info("\tRCU NOCB CPU patience negative (%d), resetting to zero.\n", nocb_patience_delay);
> +		nocb_patience_delay = 0;
> +	} else if (nocb_patience_delay > 5 * MSEC_PER_SEC) {
> +		pr_info("\tRCU NOCB CPU patience too large (%d), resetting to %ld.\n", nocb_patience_delay, 5 * MSEC_PER_SEC);
> +		nocb_patience_delay = 5 * MSEC_PER_SEC;
> +	} else if (nocb_patience_delay) {

Here you suggest that we don't print if 'nocb_patience_delay == 0', 
as it's the default behavior, right?

I think printing on 0 could be useful to check if the feature exists, even 
though we are zeroing it, but this will probably add unnecessary verbosity.

> +		pr_info("\tRCU NOCB CPU patience set to %d milliseconds.\n", nocb_patience_delay);
> +	}

Here I suppose something like this can take care of not needing to convert 
ms -> jiffies every rcu_pending():

+	nocb_patience_delay = msecs_to_jiffies(nocb_patience_delay);

>  	if (!use_softirq)
>  		pr_info("\tRCU_SOFTIRQ processing moved to rcuc kthreads.\n");
>  	if (IS_ENABLED(CONFIG_RCU_EQS_DEBUG))
> 


Thanks!
Leo


