Return-Path: <linux-kernel+bounces-257159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 547699375FD
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 11:43:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A46E1F225F2
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 09:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 360B3839F3;
	Fri, 19 Jul 2024 09:42:10 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC7082D89
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 09:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721382129; cv=none; b=Rh+yz6UOwyIg8eA/W9EhDTb3VP/Fc3iZiaYe+L/kTQtoqDUEKplTp3sNfXE8Rb6tiGlb/Epv4mLmJstMJNMDkZCLmQnPN0tyip4N+vE9YhZhJVpWlFenh2/x/9tGXXiLNIPIhZLa0LbCW34F9FSp9Z/vpBySqkoTnksBmuK7+xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721382129; c=relaxed/simple;
	bh=qGopGABQSOZ4WINzP7qpGeg325G03koAFu5o3JX1uP8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=e2X5Sb12LlPBxf/6j3AGbOwcll76T1GW3BH7gejOJb36yAhXQPH0Ebb+sQ6LawB1fKMlCgYr6i2WCRAqZNoUT55oYaafmywqxTfe/9A4ZWvNRHAnoTNAudTi9K+MZVYPSXLl5u70/pw1cMaeaoHfPrDQI7vL8g7M5ZIjemRroZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4WQPjf1ZT0zQmGy;
	Fri, 19 Jul 2024 17:37:58 +0800 (CST)
Received: from kwepemd200012.china.huawei.com (unknown [7.221.188.145])
	by mail.maildlp.com (Postfix) with ESMTPS id D4E9418007C;
	Fri, 19 Jul 2024 17:42:03 +0800 (CST)
Received: from [10.67.121.115] (10.67.121.115) by
 kwepemd200012.china.huawei.com (7.221.188.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Fri, 19 Jul 2024 17:42:03 +0800
Message-ID: <2c9489cc-d276-7c52-5d52-7f234fdc726e@hisilicon.com>
Date: Fri, 19 Jul 2024 17:42:02 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 3/3] irqchip/gic-v4: Make sure a VPE is locked when VMAPP
 is issued
Content-Language: en-US
To: Marc Zyngier <maz@kernel.org>, <kvmarm@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>, Nianyao Tang
	<tangnianyao@huawei.com>
References: <20240705093155.871070-1-maz@kernel.org>
 <20240705093155.871070-4-maz@kernel.org>
From: Zhou Wang <wangzhou1@hisilicon.com>
In-Reply-To: <20240705093155.871070-4-maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemd200012.china.huawei.com (7.221.188.145)

On 2024/7/5 17:31, Marc Zyngier wrote:
> In order to make sure that vpe->col_idx is correctly sampled
> when a VMAPP command is issued, we must hold the lock for the
> VPE. This is now possible since the introduction of the per-VM
> vmapp_lock, which can be taken before vpe_lock in the locking
> order.
> 
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>  drivers/irqchip/irq-gic-v3-its.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
> index b52d60097cad5..951ec140bcea2 100644
> --- a/drivers/irqchip/irq-gic-v3-its.c
> +++ b/drivers/irqchip/irq-gic-v3-its.c
> @@ -1810,7 +1810,9 @@ static void its_map_vm(struct its_node *its, struct its_vm *vm)
>  		for (i = 0; i < vm->nr_vpes; i++) {
>  			struct its_vpe *vpe = vm->vpes[i];
>  
> -			its_send_vmapp(its, vpe, true);
> +			scoped_guard(raw_spinlock, &vpe->vpe_lock)
> +				its_send_vmapp(its, vpe, true);
> +
>  			its_send_vinvall(its, vpe);
>  		}
>  	}
> @@ -1827,8 +1829,10 @@ static void its_unmap_vm(struct its_node *its, struct its_vm *vm)
>  	if (!--vm->vlpi_count[its->list_nr]) {
>  		int i;
>  
> -		for (i = 0; i < vm->nr_vpes; i++)
> +		for (i = 0; i < vm->nr_vpes; i++) {
> +			guard(raw_spinlock)(&vm->vpes[i]->vpe_lock);
>  			its_send_vmapp(its, vm->vpes[i], false);
> +		}
>  	}
>  }
>  

Hi Marc,

It looks like there is ABBA deadlock after applying this series:

In its_map_vm: vmapp_lock -> vpe_lock
In its_vpe_set_affinity: vpe_to_cpuid_lock(vpe_lock) -> its_send_vmovp(vmapp_lock)

Any idea about this?

Best,
Zhou

