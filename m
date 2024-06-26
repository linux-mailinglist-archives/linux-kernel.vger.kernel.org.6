Return-Path: <linux-kernel+bounces-229927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 366E991761C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 04:23:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7D59284803
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 02:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE4481C6A0;
	Wed, 26 Jun 2024 02:22:59 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620F81C68C
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 02:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719368579; cv=none; b=Jd4WyixqEbJL5P6fW6PJfL5T5ZT2R0UvgHxCba/dcgCMvqb9eef3O//Lvmsm4Z+3+63q/v0DbTNP7v0TjZo7CQUL48tCn6zllLhbAWWpmUWXMkmkmliIqzaQjloCZpuO1ImqXQ8QEZlWJ9k/HHHPZFVc6h5DuVfZLvp6IalH8e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719368579; c=relaxed/simple;
	bh=tf8cAd4CGDxMkSIb4/CzIqW7Z1l7xYr6/PgLpBFWqmQ=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=tVhjoJmEuTwWCbGWYFZFXTknj/Zx9+b8pH/leJ7UsnHaXp2aZapY9WT0kPO02xGpn7b5tDzMYIqYQs3F80PNm/5HecFfCxSZTAPtGj+PKp3nHwf7cD7C3C/iFS1pTOtmTr979R4o6B0Wz7MJ/xJkTI802t+2OBQ0Klpz8gvamSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4W853B0G6NzZcG9;
	Wed, 26 Jun 2024 10:18:30 +0800 (CST)
Received: from kwepemd500014.china.huawei.com (unknown [7.221.188.63])
	by mail.maildlp.com (Postfix) with ESMTPS id CEEFB180086;
	Wed, 26 Jun 2024 10:22:53 +0800 (CST)
Received: from [10.67.146.137] (10.67.146.137) by
 kwepemd500014.china.huawei.com (7.221.188.63) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Wed, 26 Jun 2024 10:22:53 +0800
Subject: Re: [RESEND PATCH] irqchip/gic-v4.1: Use the ITS of the NUMA node
 where current cpu is located
To: Marc Zyngier <maz@kernel.org>
CC: <tglx@linutronix.de>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <guoyang2@huawei.com>,
	<wangwudi@hisilicon.com>
References: <20240625014019.3914240-1-tangnianyao@huawei.com>
 <86wmmdihkf.wl-maz@kernel.org>
From: Tangnianyao <tangnianyao@huawei.com>
Message-ID: <60de5bd6-51db-e327-5808-280407a6285d@huawei.com>
Date: Wed, 26 Jun 2024 10:22:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <86wmmdihkf.wl-maz@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemd500014.china.huawei.com (7.221.188.63)



On 6/25/2024 15:53, Marc Zyngier wrote:
> On Tue, 25 Jun 2024 02:40:19 +0100,
> Nianyao Tang <tangnianyao@huawei.com> wrote:
>> When GICv4.1 enabled, guest sending IPI use the last ITS reported.
>> On multi-NUMA environment with more than one ITS, it makes IPI performance
>> various from VM to VM, depending on which NUMA the VM is deployed on.
>> We can use closer ITS instead of the last ITS reported.
> Closer to *what*? the SGI sender? or the receiver? Something else?

VSGI sender.
VSGI sender use original find_4_1_its to inject vsgi, it always find the last reported
4_1 ITS, regardless of which NUMA the VSGI sender cpu is located on.

>
>> Modify find_4_1_its to find the ITS of the NUMA node where current
>> cpu is located and save it with per cpu variable.
> But find_4_1_its() isn't only used for SGIs. Is it valid to do this
> trick for all use cases?

To consider this case, I've implemented original find_4_1_its function, finding a
4_1 ITS in system and return, even NUMA is not match. Would it  be enough to be
compatitable with other code ?
A new find_4_1_its can firstly select 4_1 ITS on the same NUMA as the current
cpu(VSGI sender), and if fail to find, then return 4_1 ITS on other NUMA.

>
>> (There's format issues with the previous patch, resend it)
> In the future, please move this sort of comment to a note after the
> --- delimiter.

ok, get it.

>
>> Signed-off-by: Nianyao Tang <tangnianyao@huawei.com>
>> ---
>>  drivers/irqchip/irq-gic-v3-its.c | 27 ++++++++++++++++++---------
>>  1 file changed, 18 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
>> index 3c755d5dad6e..d35b42f3b2af 100644
>> --- a/drivers/irqchip/irq-gic-v3-its.c
>> +++ b/drivers/irqchip/irq-gic-v3-its.c
>> @@ -193,6 +193,8 @@ static DEFINE_RAW_SPINLOCK(vmovp_lock);
>>  
>>  static DEFINE_IDA(its_vpeid_ida);
>>  
>> +static DEFINE_PER_CPU(struct its_node *, its_on_cpu);
> I don't really get the "its_on_cpu" name. "local_its" would at least
> indicate a notion being "close".

I want to mean ITS on the current cpu NUMA node.
Yes, "local_its" is better.

>
>> +
>>  #define gic_data_rdist()		(raw_cpu_ptr(gic_rdists->rdist))
>>  #define gic_data_rdist_cpu(cpu)		(per_cpu_ptr(gic_rdists->rdist, cpu))
>>  #define gic_data_rdist_rd_base()	(gic_data_rdist()->rd_base)
>> @@ -4058,19 +4060,25 @@ static struct irq_chip its_vpe_irq_chip = {
>>  
>>  static struct its_node *find_4_1_its(void)
>>  {
>> -	static struct its_node *its = NULL;
>> +	struct its_node *its = NULL;
>> +	struct its_node *its_non_cpu_node = NULL;
>> +	int cpu = smp_processor_id();
>>  
>> -	if (!its) {
>> -		list_for_each_entry(its, &its_nodes, entry) {
>> -			if (is_v4_1(its))
>> -				return its;
>> -		}
>> +	if (per_cpu(its_on_cpu, cpu))
>> +		return per_cpu(its_on_cpu, cpu);
>>  
>> -		/* Oops? */
>> -		its = NULL;
>> -	}
>> +	list_for_each_entry(its, &its_nodes, entry) {
>> +		if (is_v4_1(its) && its->numa_node == cpu_to_node(cpu)) {
>> +			per_cpu(its_on_cpu, cpu) = its;
>> +			return its;
>> +		} else if (is_v4_1(its))
>> +			its_non_cpu_node = its;
>> +	}
> Why do you consider the NUMA node instead of the ITS' own affinity?
> SVPET gives you some notion of distance with the RDs, and that'd
> probably be useful.

I assumed BIOS should report NUMA node following real topology, use NUMA node
for simplicity.

>
>>  
>> -	return its;
>> +	if (!per_cpu(its_on_cpu, cpu) && its_non_cpu_node)
>> +		per_cpu(its_on_cpu, cpu) = its_non_cpu_node;
>> +
>> +	return its_non_cpu_node;
>>  }
> Urgh. Mixing init and runtime is awful. Why isn't this initialised
> when a CPU comes up? We already have all the infrastructure.

The original find_4_1_its use "static struct its_node *its" to save 4_1 ITS, and
it's init inside this function. So, to follow this, I tried to not modify this usage.

>
> But the biggest question is "what sort of performance improvement does
> this bring"? You give no numbers, no way to evaluate anything.
>
> I've asked for that times and times again: if your changes are
> claiming a performance improvement, please back it up. It's not that
> hard. 

On a 2-socket environment, reported as 2-NUMA, each socket with one ITS
and 32 cpu, GICv4.1 enabled.
For performance, I deploy a 4U8G guest, 4 vcpu on same socket.
When I deploy guest on socket0, kvm-unit-tests ipi_hw result is 850ns. It
test the delay from one vcpu sending ipi to another vcpu receiving ipi in guest.
When I deploy guest on socket1, the result is 750ns.
The reason is VSGI sender always use lasted reported ITS to inject VSGI.
The access from cpu to other-socket ITS will cost 100ns more compared to cpu
to local ITS.





>
> Thanks,
>
> 	M.
>


