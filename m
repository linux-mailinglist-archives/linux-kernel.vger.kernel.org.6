Return-Path: <linux-kernel+bounces-575068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43163A6ED23
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 11:00:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55CAD3A5FF5
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 09:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EDC91EA7F7;
	Tue, 25 Mar 2025 09:59:54 +0000 (UTC)
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 057D5199FAB
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 09:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742896794; cv=none; b=AXOndMyk6NLWu2puRhFcOK5z8rsbMxtgHh/bZtZCReONYPjhsUJaXl87THDQ0lXjeP72xzNdDuLNXf5D18PCaq19TmD5kV4tOY/fQHJgOqCkgS7HRJLlhnpg6ekYUI39Y3T9UNBIoJSCuGBjjLvSpRYA7126L3ikuicVo6G4lj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742896794; c=relaxed/simple;
	bh=SWsfRbLRu6z1OAvlaXUoNay9G0Cd94I/ud7jbpcroHE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=FiISDZEjrjWFSJtqsAuOH54W5BH68pFmB6JMOVJwDlSpCio8mxOyqLzio5K9JVaF7gRa00qXiVn8r+RqjZnYsjAHon5syUoyvbx0Xkj6Vj/P/caToUcQZj3HPAQG8rI56ZrNG7zyEbWW6MgKGNKeJpPzm+qzqVrRuUeKAaC9I58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id A3EB3433EC;
	Tue, 25 Mar 2025 09:59:43 +0000 (UTC)
Message-ID: <1036c9e7-dd0c-4ae0-ad20-cb424a37736d@ghiti.fr>
Date: Tue, 25 Mar 2025 10:59:42 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] riscv: print hartid on bringup
Content-Language: en-US
To: Yunhui Cui <cuiyunhui@bytedance.com>, apatel@ventanamicro.com,
 atishp@rivosinc.com, paul.walmsley@sifive.com, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, samuel.holland@sifive.com, alexghiti@rivosinc.com,
 jassisinghbrar@gmail.com, takakura@valinux.co.jp,
 valentina.fernandezalanis@microchip.com, ruanjinjie@huawei.com,
 charlie@rivosinc.com, conor.dooley@microchip.com, haibo1.xu@intel.com,
 andybnac@gmail.com, ke.zhao@shingroup.cn, tglx@linutronix.de,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250303083424.14309-1-cuiyunhui@bytedance.com>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20250303083424.14309-1-cuiyunhui@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduiedvfeehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfhfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpeetlhgvgigrnhgurhgvucfihhhithhiuceorghlvgigsehghhhithhirdhfrheqnecuggftrfgrthhtvghrnhepueefgeehheegtddvgeelgeejjeefudekgeetffeijefgveejudehfffftdelhffhnecukfhppeefuddrfedvrdekuddrudekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeefuddrfedvrdekuddrudekjedphhgvlhhopegludelvddrudeikedrvddurddvhegnpdhmrghilhhfrhhomheprghlvgigsehghhhithhirdhfrhdpnhgspghrtghpthhtohepvddtpdhrtghpthhtoheptghuihihuhhnhhhuihessgihthgvuggrnhgtvgdrtghomhdprhgtphhtthhopegrphgrthgvlhesvhgvnhhtrghnrghmihgtrhhordgtohhmpdhrtghpthhtoheprghtihhshhhpsehrihhvohhsihhntgdrtghomhdprhgtphhtthhopehprghulhdrfigrlhhmshhlvgihsehsihhfihhvvgdrtghomhdprhgtphhtthhopehprghlmhgvrhesuggrsggsvghlthdrtghomhdprhgtphhtthhopegrohhusegvvggtshdrsggvrhhkv
 ghlvgihrdgvughupdhrtghpthhtohepshgrmhhuvghlrdhhohhllhgrnhgusehsihhfihhvvgdrtghomhdprhgtphhtthhopegrlhgvgihghhhithhisehrihhvohhsihhntgdrtghomh
X-GND-Sasl: alex@ghiti.fr

Hi Yunhui,

On 03/03/2025 09:34, Yunhui Cui wrote:
> Firmware randomly releases cores, so CPU numbers don't linearly map
> to hartids. When the system has an exception, we care more about hartids.
> Adding "dyndbg="file smpboot.c +p" loglevel=8" to the cmdline can output
> the hartid.
>
> Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> ---
>   arch/riscv/kernel/smp.c     | 2 ++
>   arch/riscv/kernel/smpboot.c | 4 ++++
>   2 files changed, 6 insertions(+)
>
> diff --git a/arch/riscv/kernel/smp.c b/arch/riscv/kernel/smp.c
> index d58b5e751286..e650dec44817 100644
> --- a/arch/riscv/kernel/smp.c
> +++ b/arch/riscv/kernel/smp.c
> @@ -48,6 +48,8 @@ EXPORT_SYMBOL_GPL(__cpuid_to_hartid_map);
>   void __init smp_setup_processor_id(void)
>   {
>   	cpuid_to_hartid_map(0) = boot_cpu_hartid;
> +
> +	pr_info("Booting Linux on hartid %lu\n", boot_cpu_hartid);
>   }
>   
>   static DEFINE_PER_CPU_READ_MOSTLY(int, ipi_dummy_dev);
> diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
> index e36d20205bd7..601a321e0f17 100644
> --- a/arch/riscv/kernel/smpboot.c
> +++ b/arch/riscv/kernel/smpboot.c
> @@ -231,6 +231,10 @@ asmlinkage __visible void smp_callin(void)
>   	riscv_ipi_enable();
>   
>   	numa_add_cpu(curr_cpuid);
> +
> +	pr_debug("CPU%u: Booted secondary hartid %lu\n", curr_cpuid,
> +		cpuid_to_hartid_map(curr_cpuid));
> +
>   	set_cpu_online(curr_cpuid, true);
>   
>   	/*


Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Thanks,

Alex


