Return-Path: <linux-kernel+bounces-250516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3351D92F8BF
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 12:14:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 576EC1C21CCC
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 10:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 176ED154BE8;
	Fri, 12 Jul 2024 10:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b="mjcwNzoU"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF4712B71
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 10:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720779290; cv=none; b=pI8rWW/YNjdatqunSqWl/0Vrf4PI7Pd0vitXrUkLyMA1mP9KI6t7QtfcVnaOWTeDZ/3WNoeAQkYklPiXOa1IYwxFlk4C3XMyv/WtqLcyCtN+zhgQ1bKt1PutpUsFGGwDHUULT6K3kJZgKvQepxPXTh84LBTlRuBfuY6IEQpjwgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720779290; c=relaxed/simple;
	bh=LoukGmD9kSfQPo32ZB2OgSine/llPim7sqDkzlj+D2U=;
	h=Date:Subject:In-Reply-To:CC:From:To:Message-ID:Mime-Version:
	 Content-Type; b=L8Oi1nEnqV4m7dDdcAcSq9gM+sIFIDYVrFqc/28hTbrKVC8NzSfRXeJHiKvR2WbeawDq7NXv2rb40qrfzzbBtk+uF55MsEjpyzSMTQOasiZ2ZP7/ShlkDHqWriKxOwQebPMGridGx1ba6l5DkFRGcyp0eH64IqSJ5+2zJtsvtB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com; spf=pass smtp.mailfrom=dabbelt.com; dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b=mjcwNzoU; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dabbelt.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1fb457b53c8so13810295ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 03:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1720779287; x=1721384087; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SYGKh1rSGwZMMdb+jKC0h+rI0XGmJjkbO0qhMEGPnio=;
        b=mjcwNzoUGghkRl0TN5jeIBQwnWflu06ZvZTnkZQrzZLNTZ/BiRY2ksgT4PAlvTXIvM
         4H1u7eMyuF0mho8be063xJSXEUr1KuM8ljMa0T6teBWBilXbIG9IkeEVFR9k8M+HdfmH
         5ivKFTLYME3uVZjpJM8GOmvd3gDk/6rkBqH7PtXAN0P6tLSpOGK15rzomFWIQjBbcUvL
         5o7Q19wChMm8VrSfKscpKMdYjePAZBcqg35bOnJ1WzgDGNk/ykfjmYbrX/cSWXPfL+/E
         /pMHEHpc2oyG6vh1go8llciqIEy5FH1AqSBOboKgwVHQdotIKNtR71JYxob8IJu+4i0Z
         rT1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720779287; x=1721384087;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SYGKh1rSGwZMMdb+jKC0h+rI0XGmJjkbO0qhMEGPnio=;
        b=vU1P5y37dhVsmbfPIQiVoG8tn8jkwREr/W3dj7+tGtBx8yEqYdHEZFD6P3qbIb51xL
         omIq6lx1fqyixuH0GHbAz7cAGHVbg7uuAeo41EHL7VAzdK1xusywiKp+iKXYRxcDBBze
         tNcUqmaIjkpAvucZcShvqhhonbWCoua6k+rLz04aECjIqaIPt/s4q65s2/v5XQNd/rZH
         /6eg6Bykh6FHgyUwQ+3SdpU9pPFQvhYfnPk3Oe5UcPYRI27gReZQw7dcB4XkXnyCo8H3
         +low9fJ4ynvk2CkLDfBfsrDx0Yj3svPEROnffq2CbUkUYqdSNjQLr32U00u0+HY00R1/
         EPtQ==
X-Forwarded-Encrypted: i=1; AJvYcCVNyHfg4gaufYudnDgKozk3vQvcsELW+SFPNLRbL7gBKjvG2T/NN9H5nHqujg4VZaEiWs210c4M5xOoxhdXfMthx20Bel2p2DKmyVrr
X-Gm-Message-State: AOJu0YwkkuKRNvLO7CXeaiQgsYjRgDhA1BL0K1SZHTQD5qfiqp3IJaLB
	qbbp06OoMVoy49EDpsvbldEh3GZDz8r7yzsuaiPqdAm3HNIdxzRSk0z3RldsYyQ=
X-Google-Smtp-Source: AGHT+IFMifVwNt8IScPJ6260qWA57jb2o+gvsjPQqNzo05GV8To6C74ereNxSC9kehEGRwxHHbYwvA==
X-Received: by 2002:a17:902:d481:b0:1fb:7b96:8479 with SMTP id d9443c01a7336-1fbb6f098bdmr91958555ad.58.1720779287137;
        Fri, 12 Jul 2024 03:14:47 -0700 (PDT)
Received: from localhost ([192.184.165.199])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fbb6ad0387sm63859975ad.274.2024.07.12.03.14.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 03:14:46 -0700 (PDT)
Date: Fri, 12 Jul 2024 03:14:46 -0700 (PDT)
X-Google-Original-Date: Fri, 12 Jul 2024 03:13:37 PDT (-0700)
Subject:     Re: [PATCH] RISC-V: Enable IPI CPU Backtrace
In-Reply-To: <20240417050711.41930-1-takakura@valinux.co.jp>
CC: Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
  apatel@ventanamicro.com, Bin Meng <bmeng.cn@gmail.com>, Atish Patra <atishp@rivosinc.com>,
  daniel.thompson@linaro.org, Arnd Bergmann <arnd@arndb.de>, Stephen Rothwell <sfr@canb.auug.org.au>,
  akpm@linux-foundation.org, Conor Dooley <conor.dooley@microchip.com>, samuel.holland@sifive.com,
  taka@valinux.co.jp, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
  takakura@valinux.co.jp
From: Palmer Dabbelt <palmer@dabbelt.com>
To: takakura@valinux.co.jp
Message-ID: <mhng-d03b5c09-5fc6-41dd-9257-dfec64492705@palmer-ri-x1c9>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On Tue, 16 Apr 2024 22:07:11 PDT (-0700), takakura@valinux.co.jp wrote:
> From: Ryo Takakura <takakura@valinux.co.jp>
>
> Add CPU backtrace feature using IPI on riscv.
> Currently, riscv doesn't yet support the feature while other
> architectures do. As IPI multiplexing allows to handle
> multiple IPIs, I think this feature can also be enabled
> on riscv by adding IPI.
>
> This patch defines arch_trigger_all_cpu_backtrace() which triggers
> the IPI for CPU backtrace.
> It will be triggered in the events of oops/panic when options
> (oops_all_cpu_backtrace/panic_print) are set accordingly.
>
> Below is the case of oops with the oops_all_cpu_backtrace
> enabled.
>
> $ sysctl kernel.oops_all_cpu_backtrace=1
>
> triggering oops shows:
> [  435.716754] NMI backtrace for cpu 3
> [  435.716893] CPU: 3 PID: 621 Comm: in:imklog Tainted: G           OE      6.9.0-rc4 #1
> [  435.717086] Hardware name: riscv-virtio,qemu (DT)
> [  435.717182] epc : fallback_scalar_usercopy+0x8/0xdc
> [  435.717300]  ra : _copy_to_user+0x32/0x58
> [  435.717391] epc : ffffffff80c33d88 ra : ffffffff80598e3c sp : ff20000000e83b50
> [  435.717544]  gp : ffffffff82066bf0 tp : ff60000091fd7000 t0 : 3363303866660000
> [  435.717711]  t1 : 000000000000005b t2 : 3363303866666666 s0 : ff20000000e83b60
> [  435.717874]  s1 : 00000000000001af a0 : 00007ff74d3df74f a1 : ff60000082cdc800
> [  435.718040]  a2 : 000000000000003c a3 : 0000000000000000 a4 : 0000000000000000
> [  435.718196]  a5 : 00ffffffffffffc4 a6 : 0000000000000000 a7 : 0000000000000010
> [  435.718333]  s2 : ff60000082cdc800 s3 : ffffffff82066910 s4 : 0000000000001df1
> [  435.718475]  s5 : ffffffff8206a5b8 s6 : 00007ff74d3df74f s7 : ffffffff8206a5b0
> [  435.718616]  s8 : ff60000082cdc800 s9 : ffffffff81e26208 s10: 000000000000003c
> [  435.718760]  s11: ffffffff8206a5ad t3 : ff60000082cdc812 t4 : ff60000082cdc812
> [  435.718909]  t5 : ff60000082cdc818 t6 : 0000000000040000
> [  435.719019] status: 0000000000040120 badaddr: 0000000000000000 cause: 8000000000000001
> [  435.719191] [<ffffffff80c33d88>] fallback_scalar_usercopy+0x8/0xdc
> [  435.719330] [<ffffffff80094eee>] syslog_print+0x1f4/0x2b2
> [  435.719446] [<ffffffff80095e10>] do_syslog.part.0+0xb0/0x326
> [  435.719594] [<ffffffff8009692e>] do_syslog+0x66/0x88
> [  435.719816] [<ffffffff803a1a80>] kmsg_read+0x44/0x5c
> [  435.720017] [<ffffffff8038ea92>] proc_reg_read+0x7a/0xa8
> [  435.720251] [<ffffffff802fae20>] vfs_read+0x94/0x264
> [  435.720478] [<ffffffff802fb906>] ksys_read+0x64/0xe4
> [  435.720709] [<ffffffff802fb9a6>] __riscv_sys_read+0x20/0x2c
> [  435.720880] [<ffffffff80c43ea2>] do_trap_ecall_u+0x60/0x1d4
> [  435.721236] [<ffffffff80c4f74c>] ret_from_exception+0x0/0x64
>
> Signed-off-by: Ryo Takakura <takakura@valinux.co.jp>
> ---
>  arch/riscv/include/asm/irq.h |  3 +++
>  arch/riscv/kernel/smp.c      | 16 ++++++++++++++++
>  2 files changed, 19 insertions(+)
>
> diff --git a/arch/riscv/include/asm/irq.h b/arch/riscv/include/asm/irq.h
> index 8e10a94430a2..ed8f76879270 100644
> --- a/arch/riscv/include/asm/irq.h
> +++ b/arch/riscv/include/asm/irq.h
> @@ -12,6 +12,9 @@
>
>  #include <asm-generic/irq.h>
>
> +void arch_trigger_cpumask_backtrace(const cpumask_t *mask, int exclude_cpu);
> +#define arch_trigger_cpumask_backtrace arch_trigger_cpumask_backtrace

I'm getting a build failure with SMP=n (allnoconfig), the implementation 
is in smp.c which isn't built without SMP.

> +
>  void riscv_set_intc_hwnode_fn(struct fwnode_handle *(*fn)(void));
>
>  struct fwnode_handle *riscv_get_intc_hwnode(void);
> diff --git a/arch/riscv/kernel/smp.c b/arch/riscv/kernel/smp.c
> index 45dd4035416e..6e297b9eb641 100644
> --- a/arch/riscv/kernel/smp.c
> +++ b/arch/riscv/kernel/smp.c
> @@ -21,6 +21,7 @@
>  #include <linux/delay.h>
>  #include <linux/irq.h>
>  #include <linux/irq_work.h>
> +#include <linux/nmi.h>
>
>  #include <asm/tlbflush.h>
>  #include <asm/cacheflush.h>
> @@ -33,6 +34,7 @@ enum ipi_message_type {
>  	IPI_CPU_CRASH_STOP,
>  	IPI_IRQ_WORK,
>  	IPI_TIMER,
> +	IPI_CPU_BACKTRACE,
>  	IPI_MAX
>  };
>
> @@ -136,6 +138,9 @@ static irqreturn_t handle_IPI(int irq, void *data)
>  		tick_receive_broadcast();
>  		break;
>  #endif
> +	case IPI_CPU_BACKTRACE:
> +		nmi_cpu_backtrace(get_irq_regs());
> +		break;
>  	default:
>  		pr_warn("CPU%d: unhandled IPI%d\n", smp_processor_id(), ipi);
>  		break;
> @@ -212,6 +217,7 @@ static const char * const ipi_names[] = {
>  	[IPI_CPU_CRASH_STOP]	= "CPU stop (for crash dump) interrupts",
>  	[IPI_IRQ_WORK]		= "IRQ work interrupts",
>  	[IPI_TIMER]		= "Timer broadcast interrupts",
> +	[IPI_CPU_BACKTRACE]     = "CPU backtrace interrupts",
>  };
>
>  void show_ipi_stats(struct seq_file *p, int prec)
> @@ -332,3 +338,13 @@ void arch_smp_send_reschedule(int cpu)
>  	send_ipi_single(cpu, IPI_RESCHEDULE);
>  }
>  EXPORT_SYMBOL_GPL(arch_smp_send_reschedule);
> +
> +static void riscv_backtrace_ipi(cpumask_t *mask)
> +{
> +	send_ipi_mask(mask, IPI_CPU_BACKTRACE);
> +}
> +
> +void arch_trigger_cpumask_backtrace(const cpumask_t *mask, int exclude_cpu)
> +{
> +	nmi_trigger_cpumask_backtrace(mask, exclude_cpu, riscv_backtrace_ipi);
> +}

