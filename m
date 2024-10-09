Return-Path: <linux-kernel+bounces-357674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E86229973F2
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 20:02:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 687B3B253E0
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 18:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BCA91C2DB8;
	Wed,  9 Oct 2024 18:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mTc9//8A"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1501B45C18
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 18:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728496888; cv=none; b=dQkgeB38TLvIJE0/fiOJ2CIWvLV5hC9ctngJCJNlE5v1Btb5xRafzNdUERDV+dfbC0VWsdPfvuLuhhJXre82atxw1kr5LAdsAENq0WuMYKLxpDj+n2Brjuer3t9xpQLuVeEj77d9bho2/SSbK/00a8v1bPvWrHWpw7A47ZUnaZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728496888; c=relaxed/simple;
	bh=vhII4taw8HL7nFNAFuTuyAaMnPiv7sffn2mqx1sU5EY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pQ7UJGbz3bA8MnEWW/mq7uxoNbLi8gP65ArLi/Xhz0GnDhNAOSOfXriAfEghamjgr6hfXSP+ZUwfF9Xn90O6Tn8EIIUEzax+pFCDvVuEk2NCKEtD7Ku6AlX7wpA691Yjjoxunv4Zc7naR+FF+HeopGWwKCOcLPit4PR03qi+xmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=mTc9//8A; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=AHsih5KSns1m9Kx7khq7yBP70wjy2rAzdmSLjHMWTGc=; b=mTc9//8AnbFnT2pBYCWqduaa0n
	ornlpspgOByFC+1t//vgaGpzwb/jvCASaCsKMKcnSEKVYGulKr6OCqjC02l/RVt4dMXORS8D+RE8y
	gvFaYLf5sfWffqBv2O+xQZqxZ0ZZlzc7CFe+kfSq7UI2kLC1Zy6Y7aOsfKWPC7VvE22TshofYnHKs
	AkE8MwtRf4YjHnTCv60gMLoZVtYHBrNGAqHDlE04zdJZlnHPajfcxKu+iO7hpMH6Bo2p2rCOSm77S
	8GKcvLFxD082tHdR+klsWHjyv8scBh8LzVWvpoJCGjXV0yU9rcHq7k7Vib9by/jIvFug/VcvImP8n
	btRnVWsQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1syazu-000000054TW-22ID;
	Wed, 09 Oct 2024 18:01:18 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 0912930057A; Wed,  9 Oct 2024 20:01:18 +0200 (CEST)
Date: Wed, 9 Oct 2024 20:01:17 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Ankur Arora <ankur.a.arora@oracle.com>
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de, paulmck@kernel.org,
	mingo@kernel.org, bigeasy@linutronix.de, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, frederic@kernel.org, efault@gmx.de
Subject: Re: [PATCH 2/7] rcu: limit PREEMPT_RCU configurations
Message-ID: <20241009180117.GS17263@noisy.programming.kicks-ass.net>
References: <20241009165411.3426937-1-ankur.a.arora@oracle.com>
 <20241009165411.3426937-3-ankur.a.arora@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241009165411.3426937-3-ankur.a.arora@oracle.com>

On Wed, Oct 09, 2024 at 09:54:06AM -0700, Ankur Arora wrote:
> PREEMPT_LAZY can be enabled stand-alone or alongside PREEMPT_DYNAMIC
> which allows for dynamic switching of preemption models.
> 
> The choice of preemptible RCU or not, however, is fixed at compile
> time. Given the trade-offs made to have a preemptible RCU, some
> configurations which have limited preemption might prefer the
> stronger forward-progress guarantees of PREEMPT_RCU=n.
> 
> Accordingly, explicitly limit PREEMPT_RCU=y to PREEMPT_DYNAMIC,
> PREEMPT, PREEMPT_RT.
> 
> This means that (PREEMPT_LAZY=y, PREEMPT_DYNAMIC=n), which selects
> PREEMPTION will run with PREEMPT_RCU=n. The combination (PREEMPT_LAZY=y,
> PREEMPT_DYNAMIC=y), will run with PREEMPT_RCU=y.

I am completely confused by this. Why do we want this?

> Cc: Paul E. McKenney <paulmck@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
> ---
>  kernel/rcu/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
> index 3e079de0f5b4..1bfe7016724f 100644
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
> -- 
> 2.43.5
> 

