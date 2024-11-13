Return-Path: <linux-kernel+bounces-407912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1042A9C7989
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 18:04:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA5ADB4438E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 15:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6415D202651;
	Wed, 13 Nov 2024 15:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Stjyxz47"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C615786AE3
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 15:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731511878; cv=none; b=hO3ZLsfTwdjg+2YAy5G4mzFqPOw08NjuJ3rpmkhOBrFn8TsWjJ0RCT9uri6YX4c6jzZ63/UHQYy1Q0z4XzASow5Pnsp9wR1QyzY/LJ0i75u/YT2BjTHiT7VVopFOp0sG0j2HgfUQQ45k2qpqgV4eUrumXCipnTaqsE0umqSBByU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731511878; c=relaxed/simple;
	bh=RvXTp4UNuJGHLkucYvm5XdasIt0xr3Qw7sFTtmIlVZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aLzeRqB+c4TvocZGyL+ziX42piBJ9eVBHRoD8g3j5DiXr9EUSj62ts+VM0YQenejjqmZsNGFqMQFdthc0Ur6KLtQtnG2rcA7b7eR8H9q5K8ZDdg51DX51aceHkfboKpRAs7L7YSZpjIdS6EerJOtB19bJFcdihN7M24v3Jpq27M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Stjyxz47; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3A57C4CEC3;
	Wed, 13 Nov 2024 15:31:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731511878;
	bh=RvXTp4UNuJGHLkucYvm5XdasIt0xr3Qw7sFTtmIlVZ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Stjyxz47DR4cx1M5q+cHF7bQecXvM6yO+vEtRMop7x+qP2rcBXjznD/avjOzqJQET
	 ob7H43DaXP0LSAZ69hUqXMKXprkNLuHbq2erEdxtoOMnFJAKJhWXKBXs4DISoYQnvv
	 +fNfPynTAf327aJFLVzwJ515KEsJl9SOgXBZgePLGLwAnoPgFfbPf0Qu6cjZoV8ctX
	 h4anEwyriH8hAgMHJuiLaNZsWirIG4YSJBynb6NFIHERY4wfMBwVIq8+o2OhN7neD6
	 LuuaZVtl8lfXr1V/aYS+CYp/LW+LZKZVqhg5o8Hk1wfLCr5WGVXzdqoDi+P0aq5h3f
	 5hk8usfBuUK7A==
Date: Wed, 13 Nov 2024 16:31:15 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Ankur Arora <ankur.a.arora@oracle.com>
Cc: linux-kernel@vger.kernel.org, peterz@infradead.org, tglx@linutronix.de,
	paulmck@kernel.org, mingo@kernel.org, bigeasy@linutronix.de,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, efault@gmx.de,
	sshegde@linux.ibm.com, boris.ostrovsky@oracle.com
Subject: Re: [PATCH v2 3/6] rcu: limit PREEMPT_RCU configurations
Message-ID: <ZzTGQ_zTS8NrxjW9@localhost.localdomain>
References: <20241106201758.428310-1-ankur.a.arora@oracle.com>
 <20241106201758.428310-4-ankur.a.arora@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241106201758.428310-4-ankur.a.arora@oracle.com>

Le Wed, Nov 06, 2024 at 12:17:55PM -0800, Ankur Arora a écrit :
> PREEMPT_LAZY can be enabled stand-alone or alongside PREEMPT_DYNAMIC
> which allows for dynamic switching of preemption models.
> 
> The choice of PREEMPT_RCU or not, however, is fixed at compile time.
> 
> Given that PREEMPT_RCU makes some trade-offs to optimize for latency
> as opposed to throughput, configurations with limited preemption
> might prefer the stronger forward-progress guarantees of PREEMPT_RCU=n.
> 
> Accordingly, explicitly limit PREEMPT_RCU=y to the latency oriented
> preemption models: PREEMPT, PREEMPT_RT, and the runtime configurable
> model PREEMPT_DYNAMIC.
> 
> This means the throughput oriented models, PREEMPT_NONE,
> PREEMPT_VOLUNTARY and PREEMPT_LAZY will run with PREEMPT_RCU=n.
> 
> Cc: Paul E. McKenney <paulmck@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
> ---
>  kernel/rcu/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
> index 5a7ff5e1cdcb..9d52f87fac27 100644
> --- a/kernel/rcu/Kconfig
> +++ b/kernel/rcu/Kconfig
> @@ -18,7 +18,7 @@ config TREE_RCU
>  
>  config PREEMPT_RCU
>  	bool
> -	default y if PREEMPTION
> +	default y if (PREEMPT || PREEMPT_RT || PREEMPT_DYNAMIC)
>  	select TREE_RCU
>  	help
>  	  This option selects the RCU implementation that is

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

But looking at !CONFIG_PREEMPT_RCU code on tree_plugin.h, I see
some issues now that the code can be preemptible. Well I think
it has always been preemptible but PREEMPTION && !PREEMPT_RCU
has seldom been exerciced (or was it even possible?).

For example rcu_read_unlock_strict() can be called with preemption
enabled so we need the following otherwise the rdp is unstable, the
norm value becomes racy (though automagically fixed in rcu_report_qs_rdp())
and rcu_report_qs_rdp() might warn.

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 58d84c59f3dd..368f00267d4e 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -95,9 +95,9 @@ static inline void __rcu_read_lock(void)
 
 static inline void __rcu_read_unlock(void)
 {
-	preempt_enable();
 	if (IS_ENABLED(CONFIG_RCU_STRICT_GRACE_PERIOD))
 		rcu_read_unlock_strict();
+	preempt_enable();
 }
 
 static inline int rcu_preempt_depth(void)


Let me audit further if we missed something else...

Thanks.

> -- 
> 2.43.5
> 

