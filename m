Return-Path: <linux-kernel+bounces-244252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E6B992A1AC
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 13:54:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EDC31B232C2
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 11:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F9617E57F;
	Mon,  8 Jul 2024 11:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D/5+LRWE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 841C83BBE8
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 11:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720439661; cv=none; b=nXr2QH3/95FAcsUV2qjUmKfBghG7Ozlcc5HRRORxEp8su3EViwgDpYkx/m+st1VdoznUe1kb6cd/YaS3oD7ODnezFQT+C4UpCoswIeqLveZ7mz+VEz5fck+Bu7dKOKxSowSYeTc19HZfOOnsMjiyzyf+ZbRj/CJ9u4mUGhvcUPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720439661; c=relaxed/simple;
	bh=y/dfz0dNt2yASIGjyhxA6+iQhXcIOu7J+RpWw9//jKc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DAKJsn/l6Fx1H5VnunB0XamwxvhDVNxAg/lPPCpUrT6tSATf7OJvjVLxzSjC+k/4IS2V641A9kguTbR4h07ckxzzNSIRDLTt/aClsNerw84USgofBgyj763NJqhVPskfuzWk77T1twkTRSStpj3Ljo37dBgp5kf+Sc806taNfoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D/5+LRWE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DEEEC116B1;
	Mon,  8 Jul 2024 11:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720439661;
	bh=y/dfz0dNt2yASIGjyhxA6+iQhXcIOu7J+RpWw9//jKc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D/5+LRWE8gXMp4jDeRrbN9wLgETE+KFFc9VRqA3tjQoK/clNIQC+FkI3STKpAgFe5
	 Mdy7var16xpa/pvXQwddgSQ09mFuZCRJvOXVxsUPKPT95ms8XcX05rzci1bk+6rqt4
	 cqyJmxaBQJNkWYdPUi/n3vx8L5Ucaobu36fRPCWqEHZKSbZwqhru4PABHl11KJmO66
	 MiGSSEPrdCSTpr40lIdJ6exDaVZauyF61wRWAhIyY58kZa+uSmFQjoEVkj0f3vOn2m
	 Mnt3zq1vLv9yvmNQzRVsBGYVfA1jYfs7LItVE02m+eqqvSN2V4PmjrRJQ3+NZ+CVk0
	 iYphYWeqMiXqg==
Date: Mon, 8 Jul 2024 12:54:15 +0100
From: Will Deacon <will@kernel.org>
To: Jinjie Ruan <ruanjinjie@huawei.com>, catalin.marinas@arm.com
Cc: mark.rutland@arm.com, dianders@chromium.org, swboyd@chromium.org,
	sumit.garg@linaro.org, frederic@kernel.org,
	scott@os.amperecomputing.com, misono.tomohiro@fujitsu.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v2] arm64: smp: Fix missing IPI statistics
Message-ID: <20240708115415.GA11771@willie-the-truck>
References: <20240620063600.573559-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240620063600.573559-1-ruanjinjie@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Thu, Jun 20, 2024 at 02:36:00PM +0800, Jinjie Ruan wrote:
> commit 83cfac95c018 ("genirq: Allow interrupts to be excluded from
> /proc/interrupts") is to avoid IPIs appear twice in /proc/interrupts.
> But the commit 331a1b3a836c ("arm64: smp: Add arch support for backtrace
> using pseudo-NMI") and commit 2f5cd0c7ffde("arm64: kgdb: Implement
> kgdb_roundup_cpus() to enable pseudo-NMI roundup") set CPU_BACKTRACE and
> KGDB_ROUNDUP IPIs "IRQ_HIDDEN" flag but not show them in
> arch_show_interrupts(), which cause the interrupt kstat_irqs accounting
> is missing in display.

[...]

> diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> index 31c8b3094dd7..5de85dccc09c 100644
> --- a/arch/arm64/kernel/smp.c
> +++ b/arch/arm64/kernel/smp.c
> @@ -767,13 +767,15 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
>  	}
>  }
>  
> -static const char *ipi_types[NR_IPI] __tracepoint_string = {
> +static const char *ipi_types[MAX_IPI] __tracepoint_string = {
>  	[IPI_RESCHEDULE]	= "Rescheduling interrupts",
>  	[IPI_CALL_FUNC]		= "Function call interrupts",
>  	[IPI_CPU_STOP]		= "CPU stop interrupts",
>  	[IPI_CPU_CRASH_STOP]	= "CPU stop (for crash dump) interrupts",
>  	[IPI_TIMER]		= "Timer broadcast interrupts",
>  	[IPI_IRQ_WORK]		= "IRQ work interrupts",
> +	[IPI_CPU_BACKTRACE]	= "CPU backtrace interrupts",
> +	[IPI_KGDB_ROUNDUP]	= "KGDB roundup interrupts",
>  };
>  
>  static void smp_cross_call(const struct cpumask *target, unsigned int ipinr);
> @@ -784,7 +786,7 @@ int arch_show_interrupts(struct seq_file *p, int prec)
>  {
>  	unsigned int cpu, i;
>  
> -	for (i = 0; i < NR_IPI; i++) {
> +	for (i = 0; i < MAX_IPI; i++) {
>  		seq_printf(p, "%*s%u:%s", prec - 1, "IPI", i,
>  			   prec >= 4 ? " " : "");
>  		for_each_online_cpu(cpu)
> -- 
> 2.34.1

Acked-by: Will Deacon <will@kernel.org>

Will

