Return-Path: <linux-kernel+bounces-241035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49C8492762E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 14:42:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEA69283611
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 12:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E20501AE847;
	Thu,  4 Jul 2024 12:42:37 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1468846F
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 12:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720096957; cv=none; b=V+SHmaPKiQp8LDKguYrsOtWMAFDzuqVuI8fkI069tg1Lgemzx7przVyNOyaMu1ipZwOR4V8TxyFxE3wRHzgKH0OfwwzWRuKPdK3tJDigJmFqgYFpw/pQ7hkWyWpcAX4yH2lsz/RgXUNajEeAHdFfgN4KQFSlpmWO+E7o1+F/4Jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720096957; c=relaxed/simple;
	bh=X6HKYl5niMRmxbjYBBIknyUdtwsu6NJjmssln7/gLkU=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=EcciclZxVyljwwWWK/SzZ5us28rU0ixQJdmtckwEcGFZn1L4z1IjNxUJ3Uhlw78wxhJg5nQgrtD7e81cG65XWdtSVa8CTpM9X+fWFOs4x8bdX1Emd9h8Zz6raxD36GIThK3HyrPVWZkCA+pZIjLSi3yKBld8mrHXf4UZLdviE5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4WFGSj3h4Nz1HDsB;
	Thu,  4 Jul 2024 20:40:05 +0800 (CST)
Received: from kwepemd500014.china.huawei.com (unknown [7.221.188.63])
	by mail.maildlp.com (Postfix) with ESMTPS id C64FC1A0188;
	Thu,  4 Jul 2024 20:42:24 +0800 (CST)
Received: from [10.67.146.137] (10.67.146.137) by
 kwepemd500014.china.huawei.com (7.221.188.63) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Thu, 4 Jul 2024 20:42:24 +0800
Subject: Re: [PATCH] irqchip/gic-v4: Fix vcpus racing for vpe->col_idx in
 vmapp and vmovp
To: Marc Zyngier <maz@kernel.org>
CC: <tglx@linutronix.de>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <guoyang2@huawei.com>,
	<wangwudi@hisilicon.com>, "jiangkunkun@huawei.com >> jiangkunkun"
	<jiangkunkun@huawei.com>
References: <20240701072305.4129823-1-tangnianyao@huawei.com>
 <868qylicj5.wl-maz@kernel.org>
From: Tangnianyao <tangnianyao@huawei.com>
Message-ID: <dacd8f05-63c5-8a4c-4b5f-8a03a9ac09d3@huawei.com>
Date: Thu, 4 Jul 2024 20:42:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <868qylicj5.wl-maz@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemd500014.china.huawei.com (7.221.188.63)



On 7/1/2024 19:20, Marc Zyngier wrote:
> On Mon, 01 Jul 2024 08:23:05 +0100,
> Nianyao Tang <tangnianyao@huawei.com> wrote:
>> its_map_vm may modify vpe->col_idx without holding vpe->vpe_lock.
>> It would result in a vpe resident on one RD after vmovp to a different RD.
>> Or, a vpe maybe vmovp to a RD same as it is current mapped in vpe table.
>>
>> On a 2-ITS, GICv4 enabled system, 32 vcpus deployed on cpu of collection 0
>> and 1. Two pci devices route VLPIs, using each of the ITS.
>> VPE ready to reside on RD1 may have such unexpected case because another
>> vcpu on other cpu is doing vmapp and modify his vpe->col_idx.
>>
>> Unexpected Case 1:
>> RD                0                              1
>>                                            vcpu_load
>>                                            lock vpe_lock
>>                                            vpe->col_idx = 1
>>             its_map_vm
>>             lock vmovp_lock
>>                                            waiting vmovp_lock
>>             vpe->col_idx = 0
>>             (cpu0 is first online cpu)
>>             vmapp vpe on col0
>>             unlock vmovp_lock
>>                                            lock vmovp_lock
>>                                            vmovp vpe to col0
>>                                            unlock vmovp_lock
>>                                            vpe resident here fail to
>>                                              receive VLPI!
>>
>> Unexpected Case 2:
>> RD                0                              1
>>             its_map_vm                     vcpu_load
>>             lock vmovp_lock                lock vpe_lock
>>             vpe->col_idx = 0
>>                                            vpe->col_idx = 1
>>             vmapp vpe on col1              waiting vmovp_lock
>>             unlock vmovp_lock
>>                                            lock vmovp_lock
>>                                            vmovp vpe to col1
>>                                            (target RD == source RD!)
>>                                            unlock vmovp_lock
> Why is this second case a problem? What is the conclusion? This commit
> message doesn't explain how you are solving it.

The second case may not a problem if ITS does not check "target RD == source RD".
I tried to protect vpe->col_idx with vpe->vpe_lock.

>
>>
>>
>> Signed-off-by: Nianyao Tang <tangnianyao@huawei.com>
>> ---
>>  drivers/irqchip/irq-gic-v3-its.c | 18 +++++++++++++-----
>>  1 file changed, 13 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
>> index f99c0a86320b..adda9824e0e7 100644
>> --- a/drivers/irqchip/irq-gic-v3-its.c
>> +++ b/drivers/irqchip/irq-gic-v3-its.c
>> @@ -1794,11 +1794,15 @@ static bool gic_requires_eager_mapping(void)
>>  static void its_map_vm(struct its_node *its, struct its_vm *vm)
>>  {
>>  	unsigned long flags;
>> +	bool vm_mapped_on_any_its = false;
>> +	int i;
>>  
>>  	if (gic_requires_eager_mapping())
>>  		return;
>>  
>> -	raw_spin_lock_irqsave(&vmovp_lock, flags);
>> +	for (i = 0; i < GICv4_ITS_LIST_MAX; i++)
>> +		if (vm->vlpi_count[i] > 0)
>> +			vm_mapped_on_any_its = true;
> What makes you think that dropping the vmovp lock is a good idea? What
> if you have a concurrent unmap?

I try to protect both vpe->col_idx and vmovp/vmapp with vpe->vpe_lock.
Haven't considered unmap process, sorry.

>
>>  
>>  	/*
>>  	 * If the VM wasn't mapped yet, iterate over the vpes and get
>> @@ -1813,15 +1817,19 @@ static void its_map_vm(struct its_node *its, struct its_vm *vm)
>>  			struct its_vpe *vpe = vm->vpes[i];
>>  			struct irq_data *d = irq_get_irq_data(vpe->irq);
>>  
>> -			/* Map the VPE to the first possible CPU */
>> -			vpe->col_idx = cpumask_first(cpu_online_mask);
>> +			raw_spin_lock_irqsave(&vpe->vpe_lock, flags);
>> +
>> +			if (!vm_mapped_on_any_its) {
>> +				/* Map the VPE to the first possible CPU */
>> +				vpe->col_idx = cpumask_first(cpu_online_mask);
>> +			}
> If the issue is that the target RD isn't initialised before we issue a
> VMAPP, then why not initialising it right from the start?

Yes, initialize vpe->col_idx from the start is better.
It's better not modifying vpe->col_idx in lazy vmapp.

>
>>  			its_send_vmapp(its, vpe, true);
>>  			its_send_vinvall(its, vpe);
>>  			irq_data_update_effective_affinity(d, cpumask_of(vpe->col_idx));
>> +
>> +			raw_spin_unlock_irqrestore(&vpe->vpe_lock, flags);
>>  		}
>>  	}
>> -
>> -	raw_spin_unlock_irqrestore(&vmovp_lock, flags);
>>  }
>>  
>>  static void its_unmap_vm(struct its_node *its, struct its_vm *vm)
> I don't think this patch makes much sense. It opens an even bigger
> race between map and unmap, and I really don't think we want that. The
> main issue is that you are trying to avoid fixing the root cause of
> the problem...

My mistake, haven't consider racing between map and unmap. I just try to avoid
racing between map and vmovp.

> The first course of action is to move the vpe->col_idx init and
> affinity update to activation time, which would make all
> implementations (v4 with and without VMOVP list, v4.1) behave the
> same. On its own, this solves the biggest issue.
>
> The other thing would be to ensure that this lazy VMAPP cannot take
> place concurrently with vcpu_load(). We can't take the VPE lock after
> the vmovp_lock, as this violates the lock ordering established in
> its_vpe_set_affinity(), which locks the VPE before doing anything else.
>
> A possibility would be to take *all* vpe locks *before* taking the
> vmovp lock, ensuring that vmapp sees something consistent. But that's
> potentially huge, and likely to cause stalls on a busy VM. Instead, a
> per-VM lock would do the trick and allow each VPE lock to be taken in
> turn.
>
> With that, we can fix the locking correctly, and make sure that
> vcpu_load and vmapp are mutually exclusive.
>
> I've written the small patch series below (compile-tested only).
> Please let me know how it fares for you.

I've test the patch series below. It works and fix my issue.

>
> 	M.
>
> >From a9857d782fc649bc08db953477bed9b8c3421118 Mon Sep 17 00:00:00 2001
> From: Marc Zyngier <maz@kernel.org>
> Date: Mon, 1 Jul 2024 10:39:19 +0100
> Subject: [PATCH 1/3] irqchip/gic-v4: Always configure affinity on VPE
>  activation
>
> We currently have two paths to set the initial affinity of a VPE:
>
> - at activation time on GICv4 without the stupid VMOVP list, and
>   on GICv4.1
>
> - at map time for GICv4 with VMOVP list
>
> The latter location may end-up modifying the affinity of VPE
> that is currently running, making the results unpredictible.
>
> Instead, unify the two paths, making sure we only set the
> initial affinity at activation time.
>
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>  drivers/irqchip/irq-gic-v3-its.c | 13 ++++---------
>  1 file changed, 4 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
> index 3c755d5dad6e6..a00c5e8c4ea65 100644
> --- a/drivers/irqchip/irq-gic-v3-its.c
> +++ b/drivers/irqchip/irq-gic-v3-its.c
> @@ -1809,13 +1809,9 @@ static void its_map_vm(struct its_node *its, struct its_vm *vm)
>  
>  		for (i = 0; i < vm->nr_vpes; i++) {
>  			struct its_vpe *vpe = vm->vpes[i];
> -			struct irq_data *d = irq_get_irq_data(vpe->irq);
>  
> -			/* Map the VPE to the first possible CPU */
> -			vpe->col_idx = cpumask_first(cpu_online_mask);
>  			its_send_vmapp(its, vpe, true);
>  			its_send_vinvall(its, vpe);
> -			irq_data_update_effective_affinity(d, cpumask_of(vpe->col_idx));
>  		}
>  	}
>  
> @@ -4562,6 +4558,10 @@ static int its_vpe_irq_domain_activate(struct irq_domain *domain,
>  	struct its_vpe *vpe = irq_data_get_irq_chip_data(d);
>  	struct its_node *its;
>  
> +	/* Map the VPE to the first possible CPU */
> +	vpe->col_idx = cpumask_first(cpu_online_mask);
> +	irq_data_update_effective_affinity(d, cpumask_of(vpe->col_idx));
> +
>  	/*
>  	 * If we use the list map, we issue VMAPP on demand... Unless
>  	 * we're on a GICv4.1 and we eagerly map the VPE on all ITSs
> @@ -4570,9 +4570,6 @@ static int its_vpe_irq_domain_activate(struct irq_domain *domain,
>  	if (!gic_requires_eager_mapping())
>  		return 0;
>  
> -	/* Map the VPE to the first possible CPU */
> -	vpe->col_idx = cpumask_first(cpu_online_mask);
> -
>  	list_for_each_entry(its, &its_nodes, entry) {
>  		if (!is_v4(its))
>  			continue;
> @@ -4581,8 +4578,6 @@ static int its_vpe_irq_domain_activate(struct irq_domain *domain,
>  		its_send_vinvall(its, vpe);
>  	}
>  
> -	irq_data_update_effective_affinity(d, cpumask_of(vpe->col_idx));
> -
>  	return 0;
>  }
>  
[...]


