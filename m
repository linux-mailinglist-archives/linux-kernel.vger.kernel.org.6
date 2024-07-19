Return-Path: <linux-kernel+bounces-257424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CCCD9379B4
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 17:14:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22BAB281764
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 15:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25E451448DE;
	Fri, 19 Jul 2024 15:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="W+w3opSa"
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B80F18C06
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 15:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721402064; cv=none; b=DNzJQhZ2ZDrYvUmNg5w3ZZ5qjD2UY8ySc8VH53B3DgXmlmOLHKPujJ0/XmB4UY2GS3mK1Jqm8Q1fsL6XKJVd/40qRJyaU85efYH3B6qXAzJbe9HC81EVUHQsJxK0XvIdqrADi3LKUhX/3Rd7U/irmiS3EKLa54Di1VD6R6h73dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721402064; c=relaxed/simple;
	bh=1lkKX8+BwLoRY5hauTPKhVnv1tKmPehSClPP1N3QXLk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q3/8OAT9k3EiDh8SVLPumsb39Iy3p5vLLmxkCXnaLArSMUdgiz7DIeN30Pm4fi6ooPB2V+Bdwrz1lE/Gs6wbhc8fsQSjhlyhOmNbikMG3XSFUOLSE4d6S7OKWeWwFfpf4j2GLY5HdKc69+UAQ4zA5SdMuWVQ3l8tiB1VmwJMlRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=W+w3opSa; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-66a048806e6so4279297b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 08:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1721402061; x=1722006861; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ep7USquIc8ObqQgurTx1eKeBf6SX6vM17VAQn9SQ8FQ=;
        b=W+w3opSa/b4WG1WUBExfK4zQP6+nPx7eI/b1bfQFpiTwCW0GgSi54RL5PStwXy3CA9
         3fs/qCadxOnbKWOowBPs10THTiE97zzkRjd2qdXoa/himqVGQQdQgcCLtp7c+A7v2V5R
         mxLqSmDyu5y8J/iLr4+JsF1qwtjK8NSPjFMFbDYZ73JkY9N3wEq6KZmp8EEucfIDEvn4
         7UP/4cyLXJYhJANxN1v1gFNQzro7xri/VmbCjKrYeuEHcwnJGy8biqT55ZGAbPghANAx
         gvS1Om3L1VuUOKnJxLO4Wqb0WorS1sbBoEW27WjVCTu4YHLp/OS3zaN14pn4owSaw2wP
         0D5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721402061; x=1722006861;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ep7USquIc8ObqQgurTx1eKeBf6SX6vM17VAQn9SQ8FQ=;
        b=b992YkHapyOHjextnoz3K0M4pP2emtJPshFALU6OxSMTfJHO3fcFXCNbkObtdxry56
         IhvsCBksZy5ZIC5s3YU7KYN/ph6HlX1fXJ7aIXw6E44yx6wOfypjSK/hTuF1VgYY7rJ9
         8ZD8Z8OpoH0pwnThGBMKxJx2n3YQI3TgR6d3HRfFl0rXUgYGvu/VYaTsBreL4Gb/tmyL
         oKJdLf4KZ99Uxy8Z+vac3UBS0SfaFjXVNAaWHZZKMlRXoi50/qhdKvTll3y6y8F/1GHX
         IDn5ejeCGPbezzEAlXs3lvlG+SuGBlvaTg8wvHZPyUcJieDRXX4o/XLNHdolXApoBItA
         LQ0g==
X-Forwarded-Encrypted: i=1; AJvYcCWoAC9/Y1bamoqLW7IkaiGwLcx57Y2BqnffS54oweSOsaGiwOZ1rroCBO0dYfXhvrnSZme4TgjpsBtYo90BT2E3K3j8LpBeJNV98UA+
X-Gm-Message-State: AOJu0Yy4RDCLaMMpSgkpyAgDvwZ4Ny0fslC8E0ct37xwrtEODp6ICfPz
	OmZLyYX0Po/jiP783drRVc0Ja45j94DjnP1Ut9pZccmmUm/Aq/Ajd0IeJ7V2Gqs=
X-Google-Smtp-Source: AGHT+IG+4qcjwODC/mjEvyVMtdvYVHkfFCV6ubPYqh5WoweDatTqVpmhoXnXig8R9l1fsymD/hQgPQ==
X-Received: by 2002:a81:8804:0:b0:64a:791b:60ce with SMTP id 00721157ae682-66500574925mr85667487b3.30.1721402061512;
        Fri, 19 Jul 2024 08:14:21 -0700 (PDT)
Received: from localhost ([140.82.166.162])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44f9cd04062sm8510161cf.40.2024.07.19.08.14.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jul 2024 08:14:21 -0700 (PDT)
Date: Fri, 19 Jul 2024 10:14:19 -0500
From: Andrew Jones <ajones@ventanamicro.com>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	samuel.holland@sifive.com, conor.dooley@microchip.com, takakura@valinux.co.jp, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH] RISC-V: Implement kgdb_roundup_cpus() to enable IPI KGDB
 Roundup
Message-ID: <20240719-8841a9a99566e15c9bd1ff3d@orel>
References: <20240719081210.1457512-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240719081210.1457512-1-ruanjinjie@huawei.com>

On Fri, Jul 19, 2024 at 04:12:10PM GMT, Jinjie Ruan wrote:
> Until now, the generic weak kgdb_roundup_cpus() has been used for kgdb on
> RISCV. A custom one allows to debug CPUs that are stuck with interrupts
> disabled.

This confuses me since we're using an IPI for the roundup. How does that
work on CPUs stuck with interrupts disabled? I think this text comes
from the commit message for the arm64 patch, but arm64 does the roundup
with a pseudo-NMI.

> And using an IPI is better than the generic one since it avoids
> the potential situation described in the generic kgdb_call_nmi_hook().

This is true.

> 
> After this patch, the kgdb test show that:
> 	# echo g > /proc/sysrq-trigger
> 	[2]kdb> btc
> 	btc: cpu status: Currently on cpu 2
> 	Available cpus: 0-1(-), 2, 3(-)
> 	Stack traceback for pid 0
> 	0xffffffff81c13a40        0        0  1    0   -  0xffffffff81c14510  swapper/0
> 	CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.10.0-g3120273055b6-dirty #51
> 	Hardware name: riscv-virtio,qemu (DT)
> 	Call Trace:
> 	[<ffffffff80006c48>] dump_backtrace+0x28/0x30
> 	[<ffffffff80fceb38>] show_stack+0x38/0x44
> 	[<ffffffff80fe6a04>] dump_stack_lvl+0x58/0x7a
> 	[<ffffffff80fe6a3e>] dump_stack+0x18/0x20
> 	[<ffffffff801143fa>] kgdb_cpu_enter+0x682/0x6b2
> 	[<ffffffff801144ca>] kgdb_nmicallback+0xa0/0xac
> 	[<ffffffff8000a392>] handle_IPI+0x9c/0x120
> 	[<ffffffff800a2baa>] handle_percpu_devid_irq+0xa4/0x1e4
> 	[<ffffffff8009cca8>] generic_handle_domain_irq+0x28/0x36
> 	[<ffffffff800a9e5c>] ipi_mux_process+0xe8/0x110
> 	[<ffffffff806e1e30>] imsic_handle_irq+0xf8/0x13a
> 	[<ffffffff8009cca8>] generic_handle_domain_irq+0x28/0x36
> 	[<ffffffff806dff12>] riscv_intc_aia_irq+0x2e/0x40
> 	[<ffffffff80fe6ab0>] handle_riscv_irq+0x54/0x86
> 	[<ffffffff80ff2e4a>] call_on_irq_stack+0x32/0x40
> 
> Rebased on Ryo Takakura's "RISC-V: Enable IPI CPU Backtrace" patch.
> 
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
>  arch/riscv/kernel/smp.c | 27 +++++++++++++++++++++++++--
>  1 file changed, 25 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/riscv/kernel/smp.c b/arch/riscv/kernel/smp.c
> index 9b047899791c..c180a647a30e 100644
> --- a/arch/riscv/kernel/smp.c
> +++ b/arch/riscv/kernel/smp.c
> @@ -13,6 +13,7 @@
>  #include <linux/interrupt.h>
>  #include <linux/module.h>
>  #include <linux/kexec.h>
> +#include <linux/kgdb.h>
>  #include <linux/percpu.h>
>  #include <linux/profile.h>
>  #include <linux/smp.h>
> @@ -35,6 +36,7 @@ enum ipi_message_type {
>  	IPI_IRQ_WORK,
>  	IPI_TIMER,
>  	IPI_CPU_BACKTRACE,
> +	IPI_KGDB_ROUNDUP,
>  	IPI_MAX
>  };
>  
> @@ -115,6 +117,7 @@ void arch_irq_work_raise(void)
>  
>  static irqreturn_t handle_IPI(int irq, void *data)
>  {
> +	unsigned int cpu = smp_processor_id();
>  	int ipi = irq - ipi_virq_base;
>  
>  	switch (ipi) {
> @@ -128,7 +131,7 @@ static irqreturn_t handle_IPI(int irq, void *data)
>  		ipi_stop();
>  		break;
>  	case IPI_CPU_CRASH_STOP:
> -		ipi_cpu_crash_stop(smp_processor_id(), get_irq_regs());
> +		ipi_cpu_crash_stop(cpu, get_irq_regs());
>  		break;
>  	case IPI_IRQ_WORK:
>  		irq_work_run();
> @@ -141,8 +144,11 @@ static irqreturn_t handle_IPI(int irq, void *data)
>  	case IPI_CPU_BACKTRACE:
>  		nmi_cpu_backtrace(get_irq_regs());
>  		break;
> +	case IPI_KGDB_ROUNDUP:
> +		kgdb_nmicallback(cpu, get_irq_regs());
> +		break;
>  	default:
> -		pr_warn("CPU%d: unhandled IPI%d\n", smp_processor_id(), ipi);
> +		pr_warn("CPU%d: unhandled IPI%d\n", cpu, ipi);
>  		break;
>  	}
>  
> @@ -209,6 +215,7 @@ static const char * const ipi_names[] = {
>  	[IPI_IRQ_WORK]		= "IRQ work interrupts",
>  	[IPI_TIMER]		= "Timer broadcast interrupts",
>  	[IPI_CPU_BACKTRACE]     = "CPU backtrace interrupts",
> +	[IPI_KGDB_ROUNDUP]	= "KGDB roundup interrupts",
>  };
>  
>  void show_ipi_stats(struct seq_file *p, int prec)
> @@ -339,3 +346,19 @@ void arch_trigger_cpumask_backtrace(const cpumask_t *mask, int exclude_cpu)
>  {
>  	nmi_trigger_cpumask_backtrace(mask, exclude_cpu, riscv_backtrace_ipi);
>  }
> +
> +#ifdef CONFIG_KGDB
> +void kgdb_roundup_cpus(void)
> +{
> +	int this_cpu = raw_smp_processor_id();
> +	int cpu;
> +
> +	for_each_online_cpu(cpu) {
> +		/* No need to roundup ourselves */
> +		if (cpu == this_cpu)
> +			continue;
> +
> +		send_ipi_single(cpu, IPI_KGDB_ROUNDUP);
> +	}
> +}
> +#endif
> -- 
> 2.34.1
>

Other than the commit message, the patch looks good to me, so

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

but I guess we should extend this and the CPU backtrace support to use
NMIs when we have support for them.

Thanks,
drew

