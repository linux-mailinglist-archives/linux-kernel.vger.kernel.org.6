Return-Path: <linux-kernel+bounces-375828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A4099A9B65
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 09:45:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2BFCB21B97
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 07:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 387F4148316;
	Tue, 22 Oct 2024 07:45:24 +0000 (UTC)
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E9079CF
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 07:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729583123; cv=none; b=KReQGTL4ln9tz7dWXIQSPn1moSxm80ayc2dwv/89B9/RIotf1skkzD6ICs34qqch2142IjbgkZdOZjeTVMxgYdumeO/G2tygYmQb/Y1U6ZQOCnp+63zWnzZG/7lXitsASXTGS5uDF3a8+LrOzqX39/VYfUanZSOBeHEZj06us5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729583123; c=relaxed/simple;
	bh=LAAo4ZftQ3FWeIe9LTkcFVNX4YbZA1Iy70loF29/mdc=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=fFVESXZ2IBgjfdOfvwFf74q1LHHJaaU/DlozT71VfrOSwN4iQZ+1FL1nxRT4TmMl+3XzRPnMZOOxKPlWub8pZi4jzfmY7TX6jJuPrb9olWYlRa/IbhMiOFJre/4IXetjmjBp4aN0tOvb3vNyGlm0tzqIxBqcMvqb3s8zUSbTBeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4XXkjy1tnqz1ynMr;
	Tue, 22 Oct 2024 15:45:26 +0800 (CST)
Received: from kwepemm600007.china.huawei.com (unknown [7.193.23.208])
	by mail.maildlp.com (Postfix) with ESMTPS id 3775C1A016C;
	Tue, 22 Oct 2024 15:45:19 +0800 (CST)
Received: from [10.174.178.219] (10.174.178.219) by
 kwepemm600007.china.huawei.com (7.193.23.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 22 Oct 2024 15:45:18 +0800
Subject: Re: [PATCH] irqchip/gic-v4: Don't allow a VMOVP on a dying VPE
To: Marc Zyngier <maz@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>, Kunkun Jiang <jiangkunkun@huawei.com>
References: <20241002204959.2051709-1-maz@kernel.org>
From: Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <aab45cd3-e5ca-58cf-e081-e32a17f5b4e7@huawei.com>
Date: Tue, 22 Oct 2024 15:45:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20241002204959.2051709-1-maz@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600007.china.huawei.com (7.193.23.208)

Hi Marc,

On 2024/10/3 4:49, Marc Zyngier wrote:
> Kunkun Jiang reports that there is a small window of opportunity for
> userspace to force a change of affinity for a VPE while the VPE has
> already been unmapped, but the corresponding doorbell interrupt still
> visible in /proc/irq/.
> 
> Plug the race by checking the value of vmapp_count, which tracks whether
> the VPE is mapped ot not, and returning an error in this case.
> 
> This involves making vmapp_count common to both GICv4.1 and its v4.0
> ancestor.
> 
> Reported-by: Kunkun Jiang <jiangkunkun@huawei.com>
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> Link: https://lore.kernel.org/r/c182ece6-2ba0-ce4f-3404-dba7a3ab6c52@huawei.com
> ---
>  drivers/irqchip/irq-gic-v3-its.c   | 18 ++++++++++++------
>  include/linux/irqchip/arm-gic-v4.h |  4 +++-
>  2 files changed, 15 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
> index fdec478ba5e7..ab597e74ba08 100644
> --- a/drivers/irqchip/irq-gic-v3-its.c
> +++ b/drivers/irqchip/irq-gic-v3-its.c
> @@ -797,8 +797,8 @@ static struct its_vpe *its_build_vmapp_cmd(struct its_node *its,
>  	its_encode_valid(cmd, desc->its_vmapp_cmd.valid);
>  
>  	if (!desc->its_vmapp_cmd.valid) {
> +		alloc = !atomic_dec_return(&desc->its_vmapp_cmd.vpe->vmapp_count);
>  		if (is_v4_1(its)) {
> -			alloc = !atomic_dec_return(&desc->its_vmapp_cmd.vpe->vmapp_count);
>  			its_encode_alloc(cmd, alloc);
>  			/*
>  			 * Unmapping a VPE is self-synchronizing on GICv4.1,
> @@ -817,13 +817,13 @@ static struct its_vpe *its_build_vmapp_cmd(struct its_node *its,
>  	its_encode_vpt_addr(cmd, vpt_addr);
>  	its_encode_vpt_size(cmd, LPI_NRBITS - 1);
>  
> +	alloc = !atomic_fetch_inc(&desc->its_vmapp_cmd.vpe->vmapp_count);
> +
>  	if (!is_v4_1(its))
>  		goto out;
>  
>  	vconf_addr = virt_to_phys(page_address(desc->its_vmapp_cmd.vpe->its_vm->vprop_page));
>  
> -	alloc = !atomic_fetch_inc(&desc->its_vmapp_cmd.vpe->vmapp_count);
> -
>  	its_encode_alloc(cmd, alloc);
>  
>  	/*
> @@ -3806,6 +3806,13 @@ static int its_vpe_set_affinity(struct irq_data *d,
>  	struct cpumask *table_mask;
>  	unsigned long flags;
>  
> +	/*
> +	 * Check if we're racing against a VPE being destroyed, for
> +	 * which we don't want to allow a VMOVP.
> +	 */
> +	if (!atomic_read(&vpe->vmapp_count))
> +		return -EINVAL;

We lazily map the vPE so that vmapp_count is likely to be 0 on GICv4.0
implementations with the ITSList feature. Seems that that implementation
is not affected by the reported race and we don't need to check
vmapp_count for that.

Testing rc4 on my 920 server triggers the WARN_ON() in vgic_v3_load().

void vgic_v3_load(struct kvm_vcpu *vcpu)
{
	WARN_ON(vgic_v4_load(vcpu));

Thanks,
Zenghui

