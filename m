Return-Path: <linux-kernel+bounces-305022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C066C962840
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 15:08:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E528F1C23674
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 13:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BE671850A4;
	Wed, 28 Aug 2024 13:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="WiTZXmOs"
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B333167D98
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 13:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724850507; cv=none; b=LilPBOF2GXW2xYxIV0wG2UvoV6tvst77r1FA2I+OVQcouSEkVSc6qlSoOFQabDwHu4vpljC7f/67nuFtW6aeW3XawMHbMWKheqDZeQ3d4diz8P6KD7fe3xlMMFgI6gHWi2ayB+DVhu31+bmzmZ8D4KgD3a+vK3fOpG2aKtluPT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724850507; c=relaxed/simple;
	bh=/dlSVks3Y6CeDlB3oBafOlR/ZvFA1HhYvMps5IMyC/k=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=rtHlAj+vxpcU3e95dTKUFyKdqkk1Pxc3xXAQnbS4+cXxCttGOQZT7OTXVlUmQLV0jZtmdS1DD4LemK/rXpYkUyW5m7d8LhqwCSaN10fma3rYC1EexhWwQMMjTLcL43QDux+pzibJOY6DDZRrHRrmqcb8In3FIETEd8gx0wHGkUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=WiTZXmOs; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-39d380d4ffcso24966845ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 06:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1724850504; x=1725455304; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:cc:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oRugccQxWcrb++fcdfIGc7HnEfuP1yE5tRkb4v6wa+E=;
        b=WiTZXmOsHLXopzMLhTrlQkUt6PHmU/l+k/JZKKmp0VQQu6S9kEFaXrepYu3e9s38U4
         Spr3GHPUSvG+X6G0Ob3hpnTSvaP5O+p2z69t22X4KUxICL7Ff38C6KwX5h7bYuoIt4Iv
         XZJDLBjwJMRhGHl8smTwYBxmwU/H2rQzUKYHYkExVBWUhLAEgFdzCtsENm4zsrJtQj4N
         To/klONVNYrC+4NhH9IyfOKxkkir1HWReRjfn0MWhwmtI+jfJMQv933hhXfr3rPUUwvK
         MExwniNCLXAVm0A1HBF/EVLPSC+stBk1wI4yQo+0gAWC5mX36Vriwx/8xLBCfcqeHPgh
         uBrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724850504; x=1725455304;
        h=content-transfer-encoding:in-reply-to:cc:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oRugccQxWcrb++fcdfIGc7HnEfuP1yE5tRkb4v6wa+E=;
        b=rGS7rjKHp6a8KwflXIApgKuM0muos5BjN0BjhPmcMLvxs+A4kn65eGGFO+t07Nai8/
         /EKdR9WFm5/QAGMY/dYVPuduNXEKj3PpEyr53j/auyC2kwmCRP9dK8Rsxy/sRy0bKEFB
         53JSVMlhyuAFcpFPdtAnU9rgeSElJ+k+B26VWoKvVP3JLOvf41119gbZ/VhK4fXih1Gy
         QRFKatYr0L1gFaOuWNj4wkDINxzRbqth9t0ZcMFbkv3TvKCLhRsKw83l1beLNzN5mfLm
         X1cqc+WdPwRUvseptpAnjlfrt1MEQiq5JifHC8B7GWDLgsyqpGpPOdcazE9sZO03/bjD
         bfOQ==
X-Forwarded-Encrypted: i=1; AJvYcCWQfUq9GgYNQfaoi3VA4Cciwrtz4zSMeZ92wN5ayy/yftyiGdR07R45FYdWVpN20GuysOM2Hr1fd1PqJmI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwF/hz+PWf+UsKxuGNJGKJebG9hU3GTxCGHhXgoSXwE5nhucpMb
	oQWGa7xuJN2x4ZTF38NMzZUPSXxq0tHhg1oNZqLkfU7ECnZKB7KISyXgBzmHP+s=
X-Google-Smtp-Source: AGHT+IFGARinHfv9SVtpM/GUQkr3obp0SvgN0jGDYhUoMl6fvwznsqI3PoQ4/ZyJzR3MAdQHsoFqfQ==
X-Received: by 2002:a05:6e02:178c:b0:39d:46f6:b936 with SMTP id e9e14a558f8ab-39e3c9c0812mr213073725ab.17.1724850504177;
        Wed, 28 Aug 2024 06:08:24 -0700 (PDT)
Received: from [100.64.0.1] ([147.124.94.167])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ce70f81180sm2969647173.73.2024.08.28.06.08.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Aug 2024 06:08:23 -0700 (PDT)
Message-ID: <869b5faa-82c3-456a-a7b0-6dcc41114280@sifive.com>
Date: Wed, 28 Aug 2024 08:08:22 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -fixes] riscv: Fix RISCV_ALTERNATIVE_EARLY
To: Alexandre Ghiti <alexghiti@rivosinc.com>
References: <20240826105737.106879-1-alexghiti@rivosinc.com>
From: Samuel Holland <samuel.holland@sifive.com>
Content-Language: en-US
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Guo Ren <guoren@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240826105737.106879-1-alexghiti@rivosinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Alex,

On 2024-08-26 5:57 AM, Alexandre Ghiti wrote:
> RISCV_ALTERNATIVE_EARLY will issue sbi_ecall() very early in the boot
> process, before the first memory mapping is setup so we can't have any
> instrumentation happening here.
> 
> In addition, when the kernel is relocatable, we must also not issue any
> relocation this early since they would have been patched virtually only.
> 
> So, instead of disabling instrumentation for the whole kernel/sbi.c file
> and compiling it with -fno-pie, simply move __sbi_ecall() and
> __sbi_base_ecall() into their own file where this is fixed.

Looking at the baseline disassembly from both LLVM 19 and GCC 13.2.0 with
RISCV_ALTERNATIVE_EARLY + KASAN + TRACEPOINTS, all of the instrumentation in
__sbi_ecall() itself is out of line and only executed when the tracepoint static
branches are enabled. However, there is instrumentation in sbi_get_m*id() from
the switch table inlined from sbi_err_map_linux_errno(), and some of those
memory accesses are done unconditionally.

This change will force sbi_err_map_linux_errno() to be out of line (unless LTO
is enabled), so it also forces that particular bit of instrumentation to be
executed only in the error path. But we could still crash in the error path. So
I think sbi_err_map_linux_errno() needs to be moved to sbi_ecall.c as well.

Alternatively, sbi_get_m*id() do not have any errors defined (and we don't
really handle that possibility), so we could drop to the call to
sbi_err_map_linux_errno() from __sbi_base_ecall().

Regards,
Samuel

> Fixes: 1745cfafebdf ("riscv: don't use global static vars to store alternative data")
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> ---
>  arch/riscv/include/asm/sbi.h  |  2 ++
>  arch/riscv/kernel/Makefile    |  6 ++++-
>  arch/riscv/kernel/sbi.c       | 44 --------------------------------
>  arch/riscv/kernel/sbi_ecall.c | 48 +++++++++++++++++++++++++++++++++++
>  4 files changed, 55 insertions(+), 45 deletions(-)
>  create mode 100644 arch/riscv/kernel/sbi_ecall.c
> 
> diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
> index 7cffd4ffecd0..5843a10b380e 100644
> --- a/arch/riscv/include/asm/sbi.h
> +++ b/arch/riscv/include/asm/sbi.h
> @@ -9,6 +9,7 @@
>  
>  #include <linux/types.h>
>  #include <linux/cpumask.h>
> +#include <linux/jump_label.h>
>  
>  #ifdef CONFIG_RISCV_SBI
>  enum sbi_ext_id {
> @@ -304,6 +305,7 @@ struct sbiret {
>  };
>  
>  void sbi_init(void);
> +long __sbi_base_ecall(int fid);
>  struct sbiret __sbi_ecall(unsigned long arg0, unsigned long arg1,
>  			  unsigned long arg2, unsigned long arg3,
>  			  unsigned long arg4, unsigned long arg5,
> diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
> index 06d407f1b30b..7f88cc4931f5 100644
> --- a/arch/riscv/kernel/Makefile
> +++ b/arch/riscv/kernel/Makefile
> @@ -20,17 +20,21 @@ endif
>  ifdef CONFIG_RISCV_ALTERNATIVE_EARLY
>  CFLAGS_alternative.o := -mcmodel=medany
>  CFLAGS_cpufeature.o := -mcmodel=medany
> +CFLAGS_sbi_ecall.o := -mcmodel=medany
>  ifdef CONFIG_FTRACE
>  CFLAGS_REMOVE_alternative.o = $(CC_FLAGS_FTRACE)
>  CFLAGS_REMOVE_cpufeature.o = $(CC_FLAGS_FTRACE)
> +CFLAGS_REMOVE_sbi_ecall.o = $(CC_FLAGS_FTRACE)
>  endif
>  ifdef CONFIG_RELOCATABLE
>  CFLAGS_alternative.o += -fno-pie
>  CFLAGS_cpufeature.o += -fno-pie
> +CFLAGS_sbi_ecall.o += -fno-pie
>  endif
>  ifdef CONFIG_KASAN
>  KASAN_SANITIZE_alternative.o := n
>  KASAN_SANITIZE_cpufeature.o := n
> +KASAN_SANITIZE_sbi_ecall.o := n
>  endif
>  endif
>  
> @@ -88,7 +92,7 @@ obj-$(CONFIG_DYNAMIC_FTRACE)	+= mcount-dyn.o
>  
>  obj-$(CONFIG_PERF_EVENTS)	+= perf_callchain.o
>  obj-$(CONFIG_HAVE_PERF_REGS)	+= perf_regs.o
> -obj-$(CONFIG_RISCV_SBI)		+= sbi.o
> +obj-$(CONFIG_RISCV_SBI)		+= sbi.o sbi_ecall.o
>  ifeq ($(CONFIG_RISCV_SBI), y)
>  obj-$(CONFIG_SMP)		+= sbi-ipi.o
>  obj-$(CONFIG_SMP) += cpu_ops_sbi.o
> diff --git a/arch/riscv/kernel/sbi.c b/arch/riscv/kernel/sbi.c
> index 837bdab2601b..ace9e2f59c41 100644
> --- a/arch/riscv/kernel/sbi.c
> +++ b/arch/riscv/kernel/sbi.c
> @@ -14,9 +14,6 @@
>  #include <asm/smp.h>
>  #include <asm/tlbflush.h>
>  
> -#define CREATE_TRACE_POINTS
> -#include <asm/trace.h>
> -
>  /* default SBI version is 0.1 */
>  unsigned long sbi_spec_version __ro_after_init = SBI_SPEC_VERSION_DEFAULT;
>  EXPORT_SYMBOL(sbi_spec_version);
> @@ -27,36 +24,6 @@ static int (*__sbi_rfence)(int fid, const struct cpumask *cpu_mask,
>  			   unsigned long start, unsigned long size,
>  			   unsigned long arg4, unsigned long arg5) __ro_after_init;
>  
> -struct sbiret __sbi_ecall(unsigned long arg0, unsigned long arg1,
> -			  unsigned long arg2, unsigned long arg3,
> -			  unsigned long arg4, unsigned long arg5,
> -			  int fid, int ext)
> -{
> -	struct sbiret ret;
> -
> -	trace_sbi_call(ext, fid);
> -
> -	register uintptr_t a0 asm ("a0") = (uintptr_t)(arg0);
> -	register uintptr_t a1 asm ("a1") = (uintptr_t)(arg1);
> -	register uintptr_t a2 asm ("a2") = (uintptr_t)(arg2);
> -	register uintptr_t a3 asm ("a3") = (uintptr_t)(arg3);
> -	register uintptr_t a4 asm ("a4") = (uintptr_t)(arg4);
> -	register uintptr_t a5 asm ("a5") = (uintptr_t)(arg5);
> -	register uintptr_t a6 asm ("a6") = (uintptr_t)(fid);
> -	register uintptr_t a7 asm ("a7") = (uintptr_t)(ext);
> -	asm volatile ("ecall"
> -		      : "+r" (a0), "+r" (a1)
> -		      : "r" (a2), "r" (a3), "r" (a4), "r" (a5), "r" (a6), "r" (a7)
> -		      : "memory");
> -	ret.error = a0;
> -	ret.value = a1;
> -
> -	trace_sbi_return(ext, ret.error, ret.value);
> -
> -	return ret;
> -}
> -EXPORT_SYMBOL(__sbi_ecall);
> -
>  int sbi_err_map_linux_errno(int err)
>  {
>  	switch (err) {
> @@ -535,17 +502,6 @@ long sbi_probe_extension(int extid)
>  }
>  EXPORT_SYMBOL(sbi_probe_extension);
>  
> -static long __sbi_base_ecall(int fid)
> -{
> -	struct sbiret ret;
> -
> -	ret = sbi_ecall(SBI_EXT_BASE, fid, 0, 0, 0, 0, 0, 0);
> -	if (!ret.error)
> -		return ret.value;
> -	else
> -		return sbi_err_map_linux_errno(ret.error);
> -}
> -
>  static inline long sbi_get_spec_version(void)
>  {
>  	return __sbi_base_ecall(SBI_EXT_BASE_GET_SPEC_VERSION);
> diff --git a/arch/riscv/kernel/sbi_ecall.c b/arch/riscv/kernel/sbi_ecall.c
> new file mode 100644
> index 000000000000..24aabb4fbde3
> --- /dev/null
> +++ b/arch/riscv/kernel/sbi_ecall.c
> @@ -0,0 +1,48 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2024 Rivos Inc. */
> +
> +#include <asm/sbi.h>
> +#define CREATE_TRACE_POINTS
> +#include <asm/trace.h>
> +
> +long __sbi_base_ecall(int fid)
> +{
> +	struct sbiret ret;
> +
> +	ret = sbi_ecall(SBI_EXT_BASE, fid, 0, 0, 0, 0, 0, 0);
> +	if (!ret.error)
> +		return ret.value;
> +	else
> +		return sbi_err_map_linux_errno(ret.error);
> +}
> +EXPORT_SYMBOL(__sbi_base_ecall);
> +
> +struct sbiret __sbi_ecall(unsigned long arg0, unsigned long arg1,
> +			  unsigned long arg2, unsigned long arg3,
> +			  unsigned long arg4, unsigned long arg5,
> +			  int fid, int ext)
> +{
> +	struct sbiret ret;
> +
> +	trace_sbi_call(ext, fid);
> +
> +	register uintptr_t a0 asm ("a0") = (uintptr_t)(arg0);
> +	register uintptr_t a1 asm ("a1") = (uintptr_t)(arg1);
> +	register uintptr_t a2 asm ("a2") = (uintptr_t)(arg2);
> +	register uintptr_t a3 asm ("a3") = (uintptr_t)(arg3);
> +	register uintptr_t a4 asm ("a4") = (uintptr_t)(arg4);
> +	register uintptr_t a5 asm ("a5") = (uintptr_t)(arg5);
> +	register uintptr_t a6 asm ("a6") = (uintptr_t)(fid);
> +	register uintptr_t a7 asm ("a7") = (uintptr_t)(ext);
> +	asm volatile ("ecall"
> +		       : "+r" (a0), "+r" (a1)
> +		       : "r" (a2), "r" (a3), "r" (a4), "r" (a5), "r" (a6), "r" (a7)
> +		       : "memory");
> +	ret.error = a0;
> +	ret.value = a1;
> +
> +	trace_sbi_return(ext, ret.error, ret.value);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL(__sbi_ecall);


