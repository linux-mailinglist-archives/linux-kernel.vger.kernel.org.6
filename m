Return-Path: <linux-kernel+bounces-257910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B1599380BC
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 12:32:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A040AB214CB
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 10:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60F227829C;
	Sat, 20 Jul 2024 10:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xy9vauJs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974859449
	for <linux-kernel@vger.kernel.org>; Sat, 20 Jul 2024 10:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721471566; cv=none; b=bWeeAltL2kO5wmrsDBtHed3fqUHBewoZk32IzRXet+6wjRKYAEzaoepOJgQWrtiARioWV4FG9RFNyHu3kY1+nQtq9qUw3gvBeJH7yyyViby8870mIZZom11YrF5uefShaAowA6U/Qf2rnKA7hWMWidaGF4kdXUc9RpIK5m3TpB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721471566; c=relaxed/simple;
	bh=no/gchey9dA5kKh7DZHwzN7x/LS5bd0amWk45TC0q7M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gp8+KaFfZGKVi5fjZ3vTDcaRjri9XwmDAuWdw4XSryYFYb6KPUIb/3owNiIbg/HvF1MdiBw8DzSkALFuRiJzYwbqSsIC/KyCEBOG3N2zByV3+zROezVqNssGmVn89Drz8s+7FeZwX0wDGBvFslcdMmH6sKS1t3mZ3a9XzLTtRuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xy9vauJs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42204C2BD10;
	Sat, 20 Jul 2024 10:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721471566;
	bh=no/gchey9dA5kKh7DZHwzN7x/LS5bd0amWk45TC0q7M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Xy9vauJshyR5q9vr91qVrTnhjzabpUPzwwaph9Roklj6vKyFQKl50URKVpwk/nDmh
	 IoPjT+3lB5B7JUNIjUogPU4RFi/WGab2Av/AjW2eBo6W+fkqKr5xmrwSHC00pczwAn
	 WK0Fxn1sFwSVKJoPpmaIZ2ZnzdmJzjPRnCzc56BX3ouJR4T0moB6TZog2kqiDSOHN0
	 RVKWRcuxxqchQmp5zULFdfzlRN6Be32qM/UeBMvAXSQVX6IcbyJ99ocP/VgdIbSY91
	 9cb1+ksIYETXHh5iF4ififYMEzkSpoOuGtq/1DjgPz0wR50sqsKDkKzuSBsDRzT2cs
	 VYdK/gj5lYagw==
Date: Sat, 20 Jul 2024 18:18:20 +0800
From: Jisheng Zhang <jszhang@kernel.org>
To: Zhu Hengbo <zhuhengbo@iscas.ac.cn>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Andrew Morton <akpm@linux-foundation.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] riscv: add tracepoints for page fault
Message-ID: <ZpuO7Du1L-m_I-GB@xhacker>
References: <20240715101400.39103-1-zhuhengbo@iscas.ac.cn>
 <20240717082728.84401-1-zhuhengbo@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240717082728.84401-1-zhuhengbo@iscas.ac.cn>

On Wed, Jul 17, 2024 at 08:27:19AM +0000, Zhu Hengbo wrote:
> Introduce page_fault_user and page_fault_kernel for riscv page fault.
> Help to get more detail information when page fault happen.

Just curious what's the expected usage? The mm subsystem has supported
page faults perf software event, is it enough?

> 
> Signed-off-by: Zhu Hengbo <zhuhengbo@iscas.ac.cn>
> ---
> Changes in v2:
> - Add print instruction point info
> 
> Simple test go below:
> 
> root@riscv-ubuntu2204 ~ # bin/perf list | grep exceptions
>   exceptions:page_fault_kernel                       [Tracepoint event]
>   exceptions:page_fault_user                         [Tracepoint event]
> 
> root@riscv-ubuntu2204 ~ # bin/perf record -e exceptions:page_fault_kernel -e exceptions:page_fault_user
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 0.091 MB perf.data (19 samples) ]
> 
> perf report tracepoint:
> perf     563 [007]   115.824363:   exceptions:page_fault_user: user page fault, address=0x7fff94cf6400 epc=0x55558632808e cause=0xd
> perf     563 [007]   115.824441:   exceptions:page_fault_user: user page fault, address=0x7fff94c75400 epc=0x55558632808e cause=0xd
> perf     563 [007]   115.824518:   exceptions:page_fault_user: user page fault, address=0x7fff94bf4400 epc=0x55558632808e cause=0xd
> perf     563 [007]   115.824907: exceptions:page_fault_kernel: kernel page fault, address=0x7fff94bf5000 epc=fault_in_readable cause=0xd
> perf     563 [007]   115.825238:   exceptions:page_fault_user: user page fault, address=0x7fff94bf4408 epc=0x5555863281bc cause=0xf
> perf     564 [000]   116.247999:   exceptions:page_fault_user: user page fault, address=0x7fff94b73400 epc=0x55558632808e cause=0xd
> perf     564 [000]   116.248558:   exceptions:page_fault_user: user page fault, address=0x7fff94af2400 epc=0x55558632808e cause=0xd
> ---
>  arch/riscv/include/asm/trace/exceptions.h | 66 +++++++++++++++++++++++
>  arch/riscv/mm/fault.c                     | 15 ++++++
>  2 files changed, 81 insertions(+)
>  create mode 100644 arch/riscv/include/asm/trace/exceptions.h
> 
> diff --git a/arch/riscv/include/asm/trace/exceptions.h b/arch/riscv/include/asm/trace/exceptions.h
> new file mode 100644
> index 000000000000..ff258da2f45f
> --- /dev/null
> +++ b/arch/riscv/include/asm/trace/exceptions.h
> @@ -0,0 +1,66 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Tracepoints for RISC-V exceptions
> + *
> + * Copyright (C) 2024 ISCAS. All rights reserved
> + *
> + */
> +
> +#if !defined(_TRACE_PAGE_FAULT_H) || defined(TRACE_HEADER_MULTI_READ)
> +#define _TRACE_PAGE_FAULT_H
> +
> +#include <linux/tracepoint.h>
> +
> +#undef TRACE_SYSTEM
> +#define TRACE_SYSTEM exceptions
> +
> +TRACE_EVENT(page_fault_user,
> +	TP_PROTO(struct pt_regs *regs),
> +	TP_ARGS(regs),
> +
> +	TP_STRUCT__entry(
> +		__field(unsigned long, address)
> +		__field(unsigned long, epc)
> +		__field(unsigned long, cause)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->address	= regs->badaddr;
> +		__entry->epc		= regs->epc;
> +		__entry->cause		= regs->cause;
> +	),
> +
> +	TP_printk("user page fault, address=%ps epc=%ps cause=0x%lx",
> +			(void *)__entry->address, (void *)__entry->epc,
> +			__entry->cause)
> +);
> +
> +TRACE_EVENT(page_fault_kernel,
> +	TP_PROTO(struct pt_regs *regs),
> +	TP_ARGS(regs),
> +
> +	TP_STRUCT__entry(
> +		__field(unsigned long, address)
> +		__field(unsigned long, epc)
> +		__field(unsigned long, cause)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->address	= regs->badaddr;
> +		__entry->epc		= regs->epc;
> +		__entry->cause		= regs->cause;
> +	),
> +
> +	TP_printk("kernel page fault, address=%ps epc=%ps cause=0x%lx",
> +			(void *)__entry->address, (void *)__entry->epc,
> +			__entry->cause)
> +);
> +
> +#undef TRACE_INCLUDE_PATH
> +#undef TRACE_INCLUDE_FILE
> +#define TRACE_INCLUDE_PATH asm/trace/
> +#define TRACE_INCLUDE_FILE exceptions
> +#endif /*  _TRACE_PAGE_FAULT_H */
> +
> +/* This part must be outside protection */
> +#include <trace/define_trace.h>
> diff --git a/arch/riscv/mm/fault.c b/arch/riscv/mm/fault.c
> index 5224f3733802..22874074c5bc 100644
> --- a/arch/riscv/mm/fault.c
> +++ b/arch/riscv/mm/fault.c
> @@ -22,6 +22,10 @@
>  
>  #include "../kernel/head.h"
>  
> +
> +#define CREATE_TRACE_POINTS
> +#include <asm/trace/exceptions.h>
> +
>  static void die_kernel_fault(const char *msg, unsigned long addr,
>  		struct pt_regs *regs)
>  {
> @@ -215,6 +219,15 @@ static inline bool access_error(unsigned long cause, struct vm_area_struct *vma)
>  	return false;
>  }
>  
> +
> +static inline void trace_page_fault(struct pt_regs *regs)
> +{
> +	if (user_mode(regs))
> +		trace_page_fault_user(regs);
> +	else
> +		trace_page_fault_kernel(regs);
> +}
> +
>  /*
>   * This routine handles page faults.  It determines the address and the
>   * problem, and then passes it off to one of the appropriate routines.
> @@ -235,6 +248,8 @@ void handle_page_fault(struct pt_regs *regs)
>  	tsk = current;
>  	mm = tsk->mm;
>  
> +	trace_page_fault(regs);
> +
>  	if (kprobe_page_fault(regs, cause))
>  		return;
>  
> -- 
> 2.34.1
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

