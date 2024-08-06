Return-Path: <linux-kernel+bounces-275706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 325FB9488DB
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 07:14:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 962A6B21461
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 05:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B296F1BBBD6;
	Tue,  6 Aug 2024 05:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="Fc4qoSfQ"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52024B663
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 05:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722921271; cv=none; b=K8QotW4P//2mcC0vI3cS3EQrmMqYSjLb4j9f6xqp/ovc/IWK4XscaAkKJ/ggEizhV/ne+ZfjnH7xaiTXeau+u+rwCYuezLlFT2KjKyyvpwzpQX5dUBIYzsqc7Rm0zXnT1f/pQtvHbUJk1WxGBmBHnDp04b3SKluALrtuooySHtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722921271; c=relaxed/simple;
	bh=rojSfGTwj3e33z7FMNcMye/jafJef6NH+rm3J5cPWlk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MHxY6PBA/K++p+vOtaVkLcfSEEB0qAk/jke5ZCgxFEh7HYHtPoAnq+8y7TdgjDiYdCCQl1KdgthKPoxR4b7uRUZOf9C5dwRiADqQqtPRlZKHWB+4KAkHsZbaJyxf6aAOnKJ0kfoCGsULkb3kJG2l9+QAhQ1HoYzjTIKX4B3L31A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=Fc4qoSfQ; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1722921266;
	bh=T6UJVWrjoJeU8RGTDOBLq9vBy/sFp4d69GgI9WtuFkA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Fc4qoSfQWyq4BM51Y4pDrfnr3s5l0ddnYG8FaahUyoFFU/7i2JjwvDx5AV/wTnVZk
	 HXWDMF1Hg5CWSj096LaeY4HCEwG4J3qKHRrrNBU/EzNkZEq8xYUUJEKizUELUeO2Ah
	 IqDgl7mlqPOA4DzA7UkY5YyWprtN4Xity3wuHpFxj6nOjkrFydwFl1F3qxJMRZ7FXu
	 VtiiPwh4eyNHFYxoOjecr38zogQZABJNbmp+pOB5RvmVG/EWVTKOwvgnpteO0XT7eo
	 33s9x9vERxtxGjtg+wxCqxgjz1eUylT9jiopI1Vge4dY+vPv0HjWzoeiovsbUNBCdP
	 K059UL/xlrYcg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4WdM1D4g3kz4wbp;
	Tue,  6 Aug 2024 15:14:22 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Jinjie Ruan <ruanjinjie@huawei.com>, dennis@kernel.org, tj@kernel.org,
 cl@linux.com, benh@kernel.crashing.org, paulus@samba.org,
 christophe.leroy@csgroup.eu, mahesh@linux.ibm.com,
 gregkh@linuxfoundation.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Cc: ruanjinjie@huawei.com
Subject: Re: [PATCH v5.10] powerpc: Avoid nmi_enter/nmi_exit in real mode
 interrupt.
In-Reply-To: <20240805114544.1552341-1-ruanjinjie@huawei.com>
References: <20240805114544.1552341-1-ruanjinjie@huawei.com>
Date: Tue, 06 Aug 2024 15:14:21 +1000
Message-ID: <87frrii66q.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Jinjie Ruan,

If you want to submit this as a stable backport you need to send it
To: stable@vger.kernel.org.

Jinjie Ruan <ruanjinjie@huawei.com> writes:
> From: Mahesh Salgaonkar <mahesh@linux.ibm.com>

Although it's somewhat modified, this is still a backport of an upstream
commit, so it should include the following line:

  [ Upstream commit 0db880fc865ffb522141ced4bfa66c12ab1fbb70 ]

> nmi_enter()/nmi_exit() touches per cpu variables which can lead to kernel
> crash when invoked during real mode interrupt handling (e.g. early HMI/MCE
> interrupt handler) if percpu allocation comes from vmalloc area.
>
> Early HMI/MCE handlers are called through DEFINE_INTERRUPT_HANDLER_NMI()
> wrapper which invokes nmi_enter/nmi_exit calls. We don't see any issue when
> percpu allocation is from the embedded first chunk. However with
> CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK enabled there are chances where percpu
> allocation can come from the vmalloc area.
>
> With kernel command line "percpu_alloc=page" we can force percpu allocation
> to come from vmalloc area and can see kernel crash in machine_check_early:
>
> [    1.215714] NIP [c000000000e49eb4] rcu_nmi_enter+0x24/0x110
> [    1.215717] LR [c0000000000461a0] machine_check_early+0xf0/0x2c0
> [    1.215719] --- interrupt: 200
> [    1.215720] [c000000fffd73180] [0000000000000000] 0x0 (unreliable)
> [    1.215722] [c000000fffd731b0] [0000000000000000] 0x0
> [    1.215724] [c000000fffd73210] [c000000000008364] machine_check_early_common+0x134/0x1f8
>
> Fix this by avoiding use of nmi_enter()/nmi_exit() in real mode if percpu
> first chunk is not embedded.
>
> CVE-2024-42126
> Cc: stable@vger.kernel.org
> Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> Tested-by: Shirisha Ganta <shirisha@linux.ibm.com>
> Signed-off-by: Mahesh Salgaonkar <mahesh@linux.ibm.com>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> Link: https://msgid.link/20240410043006.81577-1-mahesh@linux.ibm.com
> [ Conflicts in arch/powerpc/include/asm/interrupt.h
>   because machine_check_early() has been refactored. ]
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
>  arch/powerpc/include/asm/percpu.h | 10 ++++++++++
>  arch/powerpc/kernel/mce.c         | 14 +++++++++++---
>  arch/powerpc/kernel/setup_64.c    |  2 ++
>  3 files changed, 23 insertions(+), 3 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/percpu.h b/arch/powerpc/include/asm/percpu.h
> index 8e5b7d0b851c..634970ce13c6 100644
> --- a/arch/powerpc/include/asm/percpu.h
> +++ b/arch/powerpc/include/asm/percpu.h
> @@ -15,6 +15,16 @@
>  #endif /* CONFIG_SMP */
>  #endif /* __powerpc64__ */
>  
> +#if defined(CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK) && defined(CONFIG_SMP)
> +#include <linux/jump_label.h>
> +DECLARE_STATIC_KEY_FALSE(__percpu_first_chunk_is_paged);
> +
> +#define percpu_first_chunk_is_paged	\
> +		(static_key_enabled(&__percpu_first_chunk_is_paged.key))
> +#else
> +#define percpu_first_chunk_is_paged	false
> +#endif /* CONFIG_PPC64 && CONFIG_SMP */
> +
>  #include <asm-generic/percpu.h>
>  
>  #include <asm/paca.h>
> diff --git a/arch/powerpc/kernel/mce.c b/arch/powerpc/kernel/mce.c
> index 63702c0badb9..259343040e1b 100644
> --- a/arch/powerpc/kernel/mce.c
> +++ b/arch/powerpc/kernel/mce.c
> @@ -594,8 +594,15 @@ long notrace machine_check_early(struct pt_regs *regs)
>  	u8 ftrace_enabled = this_cpu_get_ftrace_enabled();
>  
>  	this_cpu_set_ftrace_enabled(0);
> -	/* Do not use nmi_enter/exit for pseries hpte guest */
> -	if (radix_enabled() || !firmware_has_feature(FW_FEATURE_LPAR))
> +	/*
> +	 * Do not use nmi_enter/exit for pseries hpte guest
> +	 *
> +	 * Likewise, do not use it in real mode if percpu first chunk is not
> +	 * embedded. With CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK enabled there
> +	 * are chances where percpu allocation can come from vmalloc area.
> +	 */
> +	if ((radix_enabled() || !firmware_has_feature(FW_FEATURE_LPAR)) &&
> +	    !percpu_first_chunk_is_paged)
>  		nmi_enter();
>  
>  	hv_nmi_check_nonrecoverable(regs);
> @@ -606,7 +613,8 @@ long notrace machine_check_early(struct pt_regs *regs)
>  	if (ppc_md.machine_check_early)
>  		handled = ppc_md.machine_check_early(regs);
>  
> -	if (radix_enabled() || !firmware_has_feature(FW_FEATURE_LPAR))
> +	if ((radix_enabled() || !firmware_has_feature(FW_FEATURE_LPAR)) &&
> +	    !percpu_first_chunk_is_paged)
>  		nmi_exit();
>  
>  	this_cpu_set_ftrace_enabled(ftrace_enabled);
> diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
> index 3f8426bccd16..899d87de0165 100644
> --- a/arch/powerpc/kernel/setup_64.c
> +++ b/arch/powerpc/kernel/setup_64.c
> @@ -824,6 +824,7 @@ static int pcpu_cpu_distance(unsigned int from, unsigned int to)
>  
>  unsigned long __per_cpu_offset[NR_CPUS] __read_mostly;
>  EXPORT_SYMBOL(__per_cpu_offset);
> +DEFINE_STATIC_KEY_FALSE(__percpu_first_chunk_is_paged);
>  
>  static void __init pcpu_populate_pte(unsigned long addr)
>  {
> @@ -903,6 +904,7 @@ void __init setup_per_cpu_areas(void)
>  	if (rc < 0)
>  		panic("cannot initialize percpu area (err=%d)", rc);
>  
> +	static_key_enable(&__percpu_first_chunk_is_paged.key);
>  	delta = (unsigned long)pcpu_base_addr - (unsigned long)__per_cpu_start;
>  	for_each_possible_cpu(cpu) {
>                  __per_cpu_offset[cpu] = delta + pcpu_unit_offsets[cpu];

This looks reasonable to me, though I haven't tested it, I assume you
have done so.

Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

cheers

