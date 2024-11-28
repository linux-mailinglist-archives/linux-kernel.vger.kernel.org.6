Return-Path: <linux-kernel+bounces-424806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D15DD9DB9AF
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 15:33:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53ADDB20D63
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 14:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73D531AF0D3;
	Thu, 28 Nov 2024 14:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tbXGonHA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C499D5D8F0
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 14:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732804395; cv=none; b=S3ys1lC/r6iUjk9sXwiLoKd4Ekj6i74GusqEjDykNic/TeD5y/+/2FsqWLyT0WisdCKAeRsNSc9oBc951JoEtLoPOSCOzvwKVI6fqz8UnfO1zbVEkAAmRxN7179HHYKMZDVCs77PaoRz9xUQU7Ve3JVJTWRUYhu24yp1YaL2B1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732804395; c=relaxed/simple;
	bh=JGsUUZERS31wEQOCoCXfAj5BYJ6gnxKdGuErmHOU+0w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qgap0qqBe881C/ij0kJTjSAqQJZstU0gSQS3zcweSqDZ042lAkNDGc4FNSFDV4MyBImh2VpP+Or9wthJkjmJ+NIY3vV25JZF9Ae0TtF4nvmwL3sJaEu0GHZUYPDDiMJXH1R2Jn3EvQpB/5iSyeSBIPo0cGPxdBNCPfbdlyETMdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tbXGonHA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D31A6C4CECE;
	Thu, 28 Nov 2024 14:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732804395;
	bh=JGsUUZERS31wEQOCoCXfAj5BYJ6gnxKdGuErmHOU+0w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tbXGonHAW3sF55BPSxk/YcVJ1dlx1Csrzp85ufkz85QejY/X5d1yasxYzsYuBxUcw
	 dWmXk0oOZIua5lLA1bXdQ/kNXQkjlvMwCDReuvWc1Iz5TvxctXQ/OhqwXlMmotW38t
	 1aaqPwTephlfsEOr69TAocFXJNWWUR491Wn8Nq7MqJOBKGUJOIIB8WkyR/YhYtpeBm
	 Z4BBRQefx2kxy8uto6tMN+4FSYwF7QxwRcAjBkCNUHfWitB0sfyJmekzDEv9C5j9YT
	 l7w+mfFRocUCYtOG/4Inea1UPBVNwL7yxKqVc3Nnv80E+ud2X6WWCPETjP7zibB4Ti
	 nlMAsR/NusW8w==
Date: Thu, 28 Nov 2024 15:33:12 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Ankur Arora <ankur.a.arora@oracle.com>
Cc: linux-kernel@vger.kernel.org, peterz@infradead.org, tglx@linutronix.de,
	paulmck@kernel.org, mingo@kernel.org, bigeasy@linutronix.de,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, efault@gmx.de,
	sshegde@linux.ibm.com, boris.ostrovsky@oracle.com,
	Daniel Bristot de Oliveira <bristot@kernel.org>
Subject: Re: [PATCH v2 5/6] osnoise: handle quiescent states for
 PREEMPT_RCU=n, PREEMPTION=y
Message-ID: <Z0h_KMzCCx2umo6h@localhost.localdomain>
References: <20241106201758.428310-1-ankur.a.arora@oracle.com>
 <20241106201758.428310-6-ankur.a.arora@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241106201758.428310-6-ankur.a.arora@oracle.com>

Le Wed, Nov 06, 2024 at 12:17:57PM -0800, Ankur Arora a écrit :
> To reduce RCU noise for nohz_full configurations, osnoise depends
> on cond_resched() providing quiescent states for PREEMPT_RCU=n
> configurations. And, for PREEMPT_RCU=y configurations does this
> by directly calling rcu_momentary_eqs().
> 
> With PREEMPT_LAZY=y, however, we can have configurations with
> (PREEMPTION=y, PREEMPT_RCU=n), which means neither of the above
> can help.
> 
> Handle that by fallback to the explicit quiescent states via
> rcu_momentary_eqs().
> 
> Cc: Paul E. McKenney <paulmck@kernel.org>
> Cc: Daniel Bristot de Oliveira <bristot@kernel.org>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Suggested-by: Paul E. McKenney <paulmck@kernel.org>
> Acked-by: Daniel Bristot de Oliveira <bristot@kernel.org>
> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
> ---
>  kernel/trace/trace_osnoise.c | 22 ++++++++++++----------
>  1 file changed, 12 insertions(+), 10 deletions(-)
> 
> diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
> index a50ed23bee77..15e9600d231d 100644
> --- a/kernel/trace/trace_osnoise.c
> +++ b/kernel/trace/trace_osnoise.c
> @@ -1538,18 +1538,20 @@ static int run_osnoise(void)
>  		/*
>  		 * In some cases, notably when running on a nohz_full CPU with
>  		 * a stopped tick PREEMPT_RCU has no way to account for QSs.
> -		 * This will eventually cause unwarranted noise as PREEMPT_RCU
> -		 * will force preemption as the means of ending the current
> -		 * grace period. We avoid this problem by calling
> -		 * rcu_momentary_eqs(), which performs a zero duration
> -		 * EQS allowing PREEMPT_RCU to end the current grace period.
> -		 * This call shouldn't be wrapped inside an RCU critical
> -		 * section.
> +		 * This will eventually cause unwarranted noise as RCU forces
> +		 * preemption as the means of ending the current grace period.
> +		 * We avoid this by calling rcu_momentary_eqs(), which performs
> +		 * a zero duration EQS allowing RCU to end the current grace
> +		 * period. This call shouldn't be wrapped inside an RCU
> +		 * critical section.
>  		 *
> -		 * Note that in non PREEMPT_RCU kernels QSs are handled through
> -		 * cond_resched()
> +		 * For non-PREEMPT_RCU kernels with cond_resched() (non-
> +		 * PREEMPT_LAZY configurations), QSs are handled through
> +		 * cond_resched(). For PREEMPT_LAZY kernels, we fallback to
> +		 * the zero duration QS via rcu_momentary_eqs().
>  		 */
> -		if (IS_ENABLED(CONFIG_PREEMPT_RCU)) {
> +		if (IS_ENABLED(CONFIG_PREEMPT_RCU) ||
> +		    (!IS_ENABLED(CONFIG_PREEMPT_RCU) && IS_ENABLED(CONFIG_PREEMPTION))) {
>  			if (!disable_irq)
>  				local_irq_disable();

How about making this unconditional so it works everywhere and doesn't
rely on cond_resched() Kconfig/preempt-dynamic mood?

Thanks.


>  
> -- 
> 2.43.5
> 

