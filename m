Return-Path: <linux-kernel+bounces-260528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5814293AA90
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 03:26:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E516CB2200D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 01:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1104E7483;
	Wed, 24 Jul 2024 01:26:23 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B894C6D
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 01:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721784382; cv=none; b=cqqA/N+4aEanrnK9iHXPH63gS0BlYClfsqdjVJmaT24reH5375hCuDRnLusEY+RC/65dKEfiNd6WyAxhJnOWPRZyYVhHalrMcNnd5QwlS5qGM6DNkUaGp9xVigwwrB3DF4sa9JZIdoGyj68EFb70q9lf9L5FO12QXSbgqi4hS+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721784382; c=relaxed/simple;
	bh=yhDifUe87sO4zdMvMc60OLhOO1uiIOMrN3dpZY2NmIM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=VDVOdwlbAg4SZ6AGardBNZHoWZB3AtpE09o4xKTQMw54CQqi1Mo63F4L6Ff9lrXk1iu9XEZXvJeAcPqECChM/i09lbey9SVrUXBMucVBL69Hn8Cz+lHxV3Fph6YGBzVVPqzxMQHLYjQyUmSEGL6lYZHHzFoUAJ+nQ16wcu0+t7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4WTGT8180YzQmrs;
	Wed, 24 Jul 2024 09:22:04 +0800 (CST)
Received: from kwepemd200012.china.huawei.com (unknown [7.221.188.145])
	by mail.maildlp.com (Postfix) with ESMTPS id E7B021402CD;
	Wed, 24 Jul 2024 09:26:14 +0800 (CST)
Received: from [10.67.121.115] (10.67.121.115) by
 kwepemd200012.china.huawei.com (7.221.188.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Wed, 24 Jul 2024 09:26:14 +0800
Message-ID: <d1a90045-887c-d339-46fc-003fb72742e8@hisilicon.com>
Date: Wed, 24 Jul 2024 09:26:13 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] irqchip/gic-v4: Fix ordering between vmapp and vpe locks
Content-Language: en-US
To: Marc Zyngier <maz@kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
CC: Thomas Gleixner <tglx@linutronix.de>
References: <20240723175203.3193882-1-maz@kernel.org>
From: Zhou Wang <wangzhou1@hisilicon.com>
In-Reply-To: <20240723175203.3193882-1-maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemd200012.china.huawei.com (7.221.188.145)

On 2024/7/24 1:52, Marc Zyngier wrote:
> The (recently established) lock ordering mandates that the per-VM
> vmapp_lock is acquired before we take the per-VPE lock.
> 
> As it turns out, its_vpe_set_affinity() takes the VPE lock, and
> then calls into its_send_vmovp(), which itself takes the vmapp
> lock. Obviously, this isn't what we want.
> 
> As its_send_vmovp() is only called from its_vpe_set_affinity(),
> hoist the vmapp locking from the former into the latter, restoring
> the expected order.
> 
> Fixes: f0eb154c39471 ("irqchip/gic-v4: Substitute vmovp_lock for a per-VM lock")
> Reported-by: Zhou Wang <wangzhou1@hisilicon.com>

Hi Marc,

Tested-by: Zhou Wang <wangzhou1@hisilicon.com>

Thanks,
Zhou

> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>  drivers/irqchip/irq-gic-v3-its.c | 18 +++++++++++-------
>  1 file changed, 11 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
> index 951ec140bcea2..b88c6011c8771 100644
> --- a/drivers/irqchip/irq-gic-v3-its.c
> +++ b/drivers/irqchip/irq-gic-v3-its.c
> @@ -1328,12 +1328,6 @@ static void its_send_vmovp(struct its_vpe *vpe)
>  		return;
>  	}
>  
> -	/*
> -	 * Protect against concurrent updates of the mapping state on
> -	 * individual VMs.
> -	 */
> -	guard(raw_spinlock_irqsave)(&vpe->its_vm->vmapp_lock);
> -
>  	/*
>  	 * Yet another marvel of the architecture. If using the
>  	 * its_list "feature", we need to make sure that all ITSs
> @@ -3808,7 +3802,7 @@ static int its_vpe_set_affinity(struct irq_data *d,
>  	struct its_vpe *vpe = irq_data_get_irq_chip_data(d);
>  	unsigned int from, cpu = nr_cpu_ids;
>  	struct cpumask *table_mask;
> -	unsigned long flags;
> +	unsigned long flags, vmapp_flags;
>  
>  	/*
>  	 * Changing affinity is mega expensive, so let's be as lazy as
> @@ -3822,7 +3816,14 @@ static int its_vpe_set_affinity(struct irq_data *d,
>  	 * protect us, and that we must ensure nobody samples vpe->col_idx
>  	 * during the update, hence the lock below which must also be
>  	 * taken on any vLPI handling path that evaluates vpe->col_idx.
> +	 *
> +	 * Finally, we must protect ourselves against concurrent
> +	 * updates of the mapping state on this VM should the ITS list
> +	 * be in use.
>  	 */
> +	if (its_list_map)
> +		raw_spin_lock_irqsave(&vpe->its_vm->vmapp_lock, vmapp_flags);
> +
>  	from = vpe_to_cpuid_lock(vpe, &flags);
>  	table_mask = gic_data_rdist_cpu(from)->vpe_table_mask;
>  
> @@ -3852,6 +3853,9 @@ static int its_vpe_set_affinity(struct irq_data *d,
>  	irq_data_update_effective_affinity(d, cpumask_of(cpu));
>  	vpe_to_cpuid_unlock(vpe, flags);
>  
> +	if (its_list_map)
> +		raw_spin_unlock_irqrestore(&vpe->its_vm->vmapp_lock, vmapp_flags);
> +
>  	return IRQ_SET_MASK_OK_DONE;
>  }
>  

