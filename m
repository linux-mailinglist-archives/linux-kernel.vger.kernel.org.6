Return-Path: <linux-kernel+bounces-531498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A646EA44136
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 14:46:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 601063ADB4C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 13:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB769269837;
	Tue, 25 Feb 2025 13:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="udv7f/Sh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C922690F8
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 13:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740491088; cv=none; b=NG0E9CuRau0gHxYn8p1g196AileQ2OBe6rwS6niWhRh4wtOp8r+tWPGdQFL47zR9c0VrUIhJGKgmFQ9MYw2xqkPcKq8M187VCF/vuv4TtNtkD84xfOHoRa11APeewKwBPWIKealAxj81Rc8zPP1Pt4F3a2csai9cUR7QjyT7zrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740491088; c=relaxed/simple;
	bh=AeNx+svysRUHGMgSZodNsrfjH3Ho7wLx5pmi8IYiYD0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XGAkBqXo4/DCEQMS5zRBqiQgH9C4LEi7yfqzfHg0fyk5xreYTMw/PuOCcmzmRUXwoTNE/eryD28UNTP/QSm375vhEoFnCO32FOki/499TbTWLAyndYMAHctVic3EB0E+wt0sZ0ODpQenvafXN977NOrZB6DP0VwWUYRue/C6Rro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=udv7f/Sh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47BFAC4CEDD;
	Tue, 25 Feb 2025 13:44:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740491087;
	bh=AeNx+svysRUHGMgSZodNsrfjH3Ho7wLx5pmi8IYiYD0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=udv7f/ShVRAhylgR0VEqATxV4gAizHly1/zum7StL8Pf+P1Nismk3sJLD/KIbIPxJ
	 v+rzGvk0f5dALayUtbYk5PUysgyM6iajZXTouL2A5knE8XXojM8/3cQpawFTag0m0S
	 HnVilpwNxlmgcrf9dTEn+MyOqu6oHbdzYR9LCN7dZH3IGe2Jnzq21gUfdgruJ8FZrg
	 fvap6WDqPOjmQDjlHgwNgMz/bkLr2Aj1Lgf3uK/zM9naw4QujS+u0+57He9BlPyOTh
	 prPrLtNalprL0BgjVgKXJQoIaiQRSBWhryX7NJKAZq4F0GyPWTxUUXpWhmAkGb1NF3
	 4IuLMCaBajECg==
Date: Tue, 25 Feb 2025 14:44:38 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Maksim Davydov <davydov-max@yandex-team.ru>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
	den-plotnikov@yandex-team.ru, gpiccoli@igalia.com,
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, hpa@zytor.com
Subject: Re: [PATCH RESEND v4] x86/split_lock: fix delayed detection enabling
Message-ID: <Z73JRsuderQIW1HT@gmail.com>
References: <20250115131704.132609-1-davydov-max@yandex-team.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250115131704.132609-1-davydov-max@yandex-team.ru>


* Maksim Davydov <davydov-max@yandex-team.ru> wrote:

> If the warn mode with disabled mitigation mode is used, then on each
> CPU where the split lock occurred detection will be disabled in order to
> make progress and delayed work will be scheduled, which then will enable
> detection back. Now it turns out that all CPUs use one global delayed
> work structure. This leads to the fact that if a split lock occurs on
> several CPUs at the same time (within 2 jiffies), only one CPU will
> schedule delayed work, but the rest will not. The return value of
> schedule_delayed_work_on() would have shown this, but it is not checked
> in the code.
> 
> A diagram that can help to understand the bug reproduction:
> https://lore.kernel.org/all/2cd54041-253b-4e78-b8ea-dbe9b884ff9b@yandex-team.ru/
> 
> In order to fix the warn mode with disabled mitigation mode, delayed work
> has to be a per-CPU.
> 
> v4 -> v3:
> * rebased the patch onto the latest master
> 
> v3 -> v2:
> * place and time of the per-CPU structure initialization were changed.
>   initcall doesn't seem to be a good place for it, so deferred
>   initialization is used.
> 
> Fixes: 727209376f49 ("x86/split_lock: Add sysctl to control the misery mode")
> Signed-off-by: Maksim Davydov <davydov-max@yandex-team.ru>
> Tested-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
> ---
>  arch/x86/kernel/cpu/bus_lock.c | 20 ++++++++++++++++----
>  1 file changed, 16 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/bus_lock.c b/arch/x86/kernel/cpu/bus_lock.c
> index 704e9241b964..b72235c8db3e 100644
> --- a/arch/x86/kernel/cpu/bus_lock.c
> +++ b/arch/x86/kernel/cpu/bus_lock.c
> @@ -192,7 +192,13 @@ static void __split_lock_reenable(struct work_struct *work)
>  {
>  	sld_update_msr(true);
>  }
> -static DECLARE_DELAYED_WORK(sl_reenable, __split_lock_reenable);
> +/*
> + * In order for each CPU to schedule itself delayed work independently of the
> + * others, delayed work struct should be per-CPU. This is not required when
> + * sysctl_sld_mitigate is enabled because of the semaphore, that limits
> + * the number of simultaneously scheduled delayed works to 1.
> + */
> +static DEFINE_PER_CPU(struct delayed_work, sl_reenable);
>  
>  /*
>   * If a CPU goes offline with pending delayed work to re-enable split lock
> @@ -213,7 +219,7 @@ static int splitlock_cpu_offline(unsigned int cpu)
>  
>  static void split_lock_warn(unsigned long ip)
>  {
> -	struct delayed_work *work;
> +	struct delayed_work *work = NULL;
>  	int cpu;
>  
>  	if (!current->reported_split_lock)
> @@ -235,11 +241,17 @@ static void split_lock_warn(unsigned long ip)
>  		if (down_interruptible(&buslock_sem) == -EINTR)
>  			return;
>  		work = &sl_reenable_unlock;
> -	} else {
> -		work = &sl_reenable;
>  	}
>  
>  	cpu = get_cpu();
> +
> +	if (!work) {
> +		work = this_cpu_ptr(&sl_reenable);
> +		/* Deferred initialization of per-CPU struct */
> +		if (!work->work.func)
> +			INIT_DELAYED_WORK(work, __split_lock_reenable);

The INIT_DELAYED_WORK() call shouldn't be done here, but in some sort 
of init function. The control flow is complicated enough already.

Also, this_cpu_ptr() isn't necessary, we already have 'cpu' as the 
current CPU. per_cpu() ought to be enough.

Thanks,

	Ingo

