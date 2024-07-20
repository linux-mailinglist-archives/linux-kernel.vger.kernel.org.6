Return-Path: <linux-kernel+bounces-257843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47C16937FAE
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 09:27:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6E36281580
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 07:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5481D1A291;
	Sat, 20 Jul 2024 07:27:13 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23453179AF
	for <linux-kernel@vger.kernel.org>; Sat, 20 Jul 2024 07:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721460432; cv=none; b=UPnQ1EQxQpr2ZbyhQwy64r2qoCvBI19m6B9gQmjfr+iKa3TgFBCPm/tODu/Erex7cmvYY62l7jKCUxQvXGOKBJXHqB3x0aVmAzTBvKPqSXyp5WQ0c9NO2Av8hzS4IO967HtNymN9AbwK6BAj4ZGHmGWM11I4lN10Z5VIcMgPV1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721460432; c=relaxed/simple;
	bh=vlAW6jzj+hzXVNMF2IJqVyIhFQdoiwyb5tZUUbGiNZE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Mu1H+dGQdHwo7y2zH7JKZKHS4LBfRTIZFgwWc2SXiLJ4Q0mNfuxdc0cszi/lOlenMGcg6TNRUD+qS6gc5rHgbEs2WCX9n6vG3frC3SVv3dGi2yZjx4Zs8ocLXca72tTjGoutkXNt53moW7QboDO241klNbw+3nhLcOmNwyHOK0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4WQyfT5Cv8z1JCmb;
	Sat, 20 Jul 2024 15:22:09 +0800 (CST)
Received: from kwepemi100008.china.huawei.com (unknown [7.221.188.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 42F49180104;
	Sat, 20 Jul 2024 15:26:50 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemi100008.china.huawei.com (7.221.188.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sat, 20 Jul 2024 15:26:49 +0800
Message-ID: <333494b6-b128-3804-b8f7-03f61dbca9d7@huawei.com>
Date: Sat, 20 Jul 2024 15:26:48 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH] RISC-V: Implement kgdb_roundup_cpus() to enable IPI KGDB
 Roundup
Content-Language: en-US
To: Andrew Jones <ajones@ventanamicro.com>
CC: <paul.walmsley@sifive.com>, <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
	<samuel.holland@sifive.com>, <conor.dooley@microchip.com>,
	<takakura@valinux.co.jp>, <linux-kernel@vger.kernel.org>,
	<linux-riscv@lists.infradead.org>
References: <20240719081210.1457512-1-ruanjinjie@huawei.com>
 <20240719-8841a9a99566e15c9bd1ff3d@orel>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <20240719-8841a9a99566e15c9bd1ff3d@orel>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemi100008.china.huawei.com (7.221.188.57)



On 2024/7/19 23:14, Andrew Jones wrote:
> On Fri, Jul 19, 2024 at 04:12:10PM GMT, Jinjie Ruan wrote:
>> Until now, the generic weak kgdb_roundup_cpus() has been used for kgdb on
>> RISCV. A custom one allows to debug CPUs that are stuck with interrupts
>> disabled.
> 
> This confuses me since we're using an IPI for the roundup. How does that
> work on CPUs stuck with interrupts disabled? I think this text comes
> from the commit message for the arm64 patch, but arm64 does the roundup
> with a pseudo-NMI.

Sorry, you are right, this commit message is indeed from arm64, and it
will be more useful with IPI as NMI support, where it will work on CPUs
stuck with interrupts disabled.

> 
>> And using an IPI is better than the generic one since it avoids
>> the potential situation described in the generic kgdb_call_nmi_hook().
> 
> This is true.
> 
>>
>> After this patch, the kgdb test show that:
>> 	# echo g > /proc/sysrq-trigger
>> 	[2]kdb> btc
>> 	btc: cpu status: Currently on cpu 2
>> 	Available cpus: 0-1(-), 2, 3(-)
>> 	Stack traceback for pid 0
>> 	0xffffffff81c13a40        0        0  1    0   -  0xffffffff81c14510  swapper/0
>> 	CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.10.0-g3120273055b6-dirty #51
>> 	Hardware name: riscv-virtio,qemu (DT)
>> 	Call Trace:
>> 	[<ffffffff80006c48>] dump_backtrace+0x28/0x30
>> 	[<ffffffff80fceb38>] show_stack+0x38/0x44
>> 	[<ffffffff80fe6a04>] dump_stack_lvl+0x58/0x7a
>> 	[<ffffffff80fe6a3e>] dump_stack+0x18/0x20
>> 	[<ffffffff801143fa>] kgdb_cpu_enter+0x682/0x6b2
>> 	[<ffffffff801144ca>] kgdb_nmicallback+0xa0/0xac
>> 	[<ffffffff8000a392>] handle_IPI+0x9c/0x120
>> 	[<ffffffff800a2baa>] handle_percpu_devid_irq+0xa4/0x1e4
>> 	[<ffffffff8009cca8>] generic_handle_domain_irq+0x28/0x36
>> 	[<ffffffff800a9e5c>] ipi_mux_process+0xe8/0x110
>> 	[<ffffffff806e1e30>] imsic_handle_irq+0xf8/0x13a
>> 	[<ffffffff8009cca8>] generic_handle_domain_irq+0x28/0x36
>> 	[<ffffffff806dff12>] riscv_intc_aia_irq+0x2e/0x40
>> 	[<ffffffff80fe6ab0>] handle_riscv_irq+0x54/0x86
>> 	[<ffffffff80ff2e4a>] call_on_irq_stack+0x32/0x40
>>
>> Rebased on Ryo Takakura's "RISC-V: Enable IPI CPU Backtrace" patch.
>>
>> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
>> ---
>>  arch/riscv/kernel/smp.c | 27 +++++++++++++++++++++++++--
>>  1 file changed, 25 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/riscv/kernel/smp.c b/arch/riscv/kernel/smp.c
>> index 9b047899791c..c180a647a30e 100644
>> --- a/arch/riscv/kernel/smp.c
>> +++ b/arch/riscv/kernel/smp.c
>> @@ -13,6 +13,7 @@
>>  #include <linux/interrupt.h>
>>  #include <linux/module.h>
>>  #include <linux/kexec.h>
>> +#include <linux/kgdb.h>
>>  #include <linux/percpu.h>
>>  #include <linux/profile.h>
>>  #include <linux/smp.h>
>> @@ -35,6 +36,7 @@ enum ipi_message_type {
>>  	IPI_IRQ_WORK,
>>  	IPI_TIMER,
>>  	IPI_CPU_BACKTRACE,
>> +	IPI_KGDB_ROUNDUP,
>>  	IPI_MAX
>>  };
>>  
>> @@ -115,6 +117,7 @@ void arch_irq_work_raise(void)
>>  
>>  static irqreturn_t handle_IPI(int irq, void *data)
>>  {
>> +	unsigned int cpu = smp_processor_id();
>>  	int ipi = irq - ipi_virq_base;
>>  
>>  	switch (ipi) {
>> @@ -128,7 +131,7 @@ static irqreturn_t handle_IPI(int irq, void *data)
>>  		ipi_stop();
>>  		break;
>>  	case IPI_CPU_CRASH_STOP:
>> -		ipi_cpu_crash_stop(smp_processor_id(), get_irq_regs());
>> +		ipi_cpu_crash_stop(cpu, get_irq_regs());
>>  		break;
>>  	case IPI_IRQ_WORK:
>>  		irq_work_run();
>> @@ -141,8 +144,11 @@ static irqreturn_t handle_IPI(int irq, void *data)
>>  	case IPI_CPU_BACKTRACE:
>>  		nmi_cpu_backtrace(get_irq_regs());
>>  		break;
>> +	case IPI_KGDB_ROUNDUP:
>> +		kgdb_nmicallback(cpu, get_irq_regs());
>> +		break;
>>  	default:
>> -		pr_warn("CPU%d: unhandled IPI%d\n", smp_processor_id(), ipi);
>> +		pr_warn("CPU%d: unhandled IPI%d\n", cpu, ipi);
>>  		break;
>>  	}
>>  
>> @@ -209,6 +215,7 @@ static const char * const ipi_names[] = {
>>  	[IPI_IRQ_WORK]		= "IRQ work interrupts",
>>  	[IPI_TIMER]		= "Timer broadcast interrupts",
>>  	[IPI_CPU_BACKTRACE]     = "CPU backtrace interrupts",
>> +	[IPI_KGDB_ROUNDUP]	= "KGDB roundup interrupts",
>>  };
>>  
>>  void show_ipi_stats(struct seq_file *p, int prec)
>> @@ -339,3 +346,19 @@ void arch_trigger_cpumask_backtrace(const cpumask_t *mask, int exclude_cpu)
>>  {
>>  	nmi_trigger_cpumask_backtrace(mask, exclude_cpu, riscv_backtrace_ipi);
>>  }
>> +
>> +#ifdef CONFIG_KGDB
>> +void kgdb_roundup_cpus(void)
>> +{
>> +	int this_cpu = raw_smp_processor_id();
>> +	int cpu;
>> +
>> +	for_each_online_cpu(cpu) {
>> +		/* No need to roundup ourselves */
>> +		if (cpu == this_cpu)
>> +			continue;
>> +
>> +		send_ipi_single(cpu, IPI_KGDB_ROUNDUP);
>> +	}
>> +}
>> +#endif
>> -- 
>> 2.34.1
>>
> 
> Other than the commit message, the patch looks good to me, so
> 
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> 
> but I guess we should extend this and the CPU backtrace support to use
> NMIs when we have support for them.

Yes, arm64 has done what you said, now both CPU Backtrace and KGDB
Roundup on arm64 have swiched to NMI smoothly.

> 
> Thanks,
> drew

