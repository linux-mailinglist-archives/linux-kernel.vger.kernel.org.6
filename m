Return-Path: <linux-kernel+bounces-441672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EEDF69ED237
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 17:38:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A899218897C9
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 16:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 251901DE2A9;
	Wed, 11 Dec 2024 16:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="KO5n/qlT"
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 307A31A0726
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 16:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.143.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733935073; cv=none; b=QjUpBilIuZuBt5oWmwpG02wOklB+EdG5fBIHl9DDx9MCeuoJqBR16q6PzQSY7+F7tA2ZR5RgE/dWG6/FiFtLCcjSIP0wuP9roKCXR1GIXWvde6iWul9rJc23saw3YEyc7AWP/yD2Szrvt20Lya4rqxeGRoe9pvkEyYvImfK8c+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733935073; c=relaxed/simple;
	bh=ofCQ8en6qXcDPINoXn4J21vvU3bUneO3DyTCibjoWMM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ezq+mZFd9rV0Io1CWlkYX3Oqv3Ppp0yj9TTpLR7KI5aVQburIayxhoSaW8tfYlchmCCr+VVK2edyMFKcJddjy5KR3CgBuDyLJorJlyDJINjjXiNdoQ5GpaXWjdRS/iT1DFAaVubxKkH6KRDGaDdZCg9gHdiy92qOgIeQZx8czPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=KO5n/qlT; arc=none smtp.client-ip=148.163.143.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0150245.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BBG8dGt011031;
	Wed, 11 Dec 2024 16:37:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pps0720; bh=bLhMdArQ0qTFTTRq3vq7tHK6Yh
	ijaJ9boT1hqsK1zoY=; b=KO5n/qlThSWdblFSrwt9luasbnIP3ZekE9lAQadM1b
	ZQxl4BIj8It3b3RPItmp2s4+ZDj3m1agJFMbK6Pr8+rjXhIcR5wile8enZqLOsqL
	Q3vETdlNAGX+Q70X3PpwXF3C8TCwakmJGvcbAN9+to0G7s9xXQToQkZHpze8sE3K
	YQel6GsCO3P4pQ6EJ4Hb+BWgyKR003KJKN6klHdVpShEh6KDvYPiY3K9C7gW9Fdp
	ygcAsa/tto3WE3zqbwKOlTeaeqoNgHS2ptvJ/ng2qlgU2lJS19NClX1llHZyegCl
	2k9Mc1bVIxUYE64XoxRvzubjindCt+0hCpOvSbmBhmBA==
Received: from p1lg14878.it.hpe.com ([16.230.97.204])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 43fe04ra65-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Dec 2024 16:37:04 +0000 (GMT)
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by p1lg14878.it.hpe.com (Postfix) with ESMTPS id D20E42BAFC;
	Wed, 11 Dec 2024 16:37:03 +0000 (UTC)
Received: from swahl-home.5wahls.com (unknown [16.231.227.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTPS id DB8258146D3;
	Wed, 11 Dec 2024 16:36:59 +0000 (UTC)
Date: Wed, 11 Dec 2024 10:36:56 -0600
From: Steve Wahl <steve.wahl@hpe.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Anup Patel <apatel@ventanamicro.com>, Wei Liu <wei.liu@kernel.org>,
        Steve Wahl <steve.wahl@hpe.com>, Joerg Roedel <joro@8bytes.org>,
        Lu Baolu <baolu.lu@linux.intel.com>, Juergen Gross <jgross@suse.com>,
        Vineet Gupta <vgupta@kernel.org>, Brian Cain <bcain@quicinc.com>
Subject: Re: [patch 4/5] x86/apic: Convert to IRQCHIP_MOVE_DEFERRED
Message-ID: <Z1m_qH8cFK2vBbnV@swahl-home.5wahls.com>
References: <20241210102148.760383417@linutronix.de>
 <20241210103335.563277044@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241210103335.563277044@linutronix.de>
X-Proofpoint-ORIG-GUID: 3gtyYs8sIGmsVPXkaU7uZrxzPKtdvYt6
X-Proofpoint-GUID: 3gtyYs8sIGmsVPXkaU7uZrxzPKtdvYt6
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_02,2024-10-04_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=999
 lowpriorityscore=0 impostorscore=0 spamscore=0 phishscore=0 mlxscore=0
 suspectscore=0 adultscore=0 clxscore=1011 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412110120

Reviewed-by: Steve Wahl <steve.wahl@hpe.com>

Thanks,

--> Steve

On Tue, Dec 10, 2024 at 11:34:15AM +0100, Thomas Gleixner wrote:
> Instead of marking individual interrupts as safe to be migrated in
> arbitrary contexts, mark the interrupt chips, which require the interrupt
> to be moved in actual interrupt context, with the new IRQCHIP_MOVE_DEFERRED
> flag. This makes more sense because this is a per interrupt chip property
> and not restricted to individual interrupts.
> 
> That flips the logic from the historical opt-out to a opt-in model. This is
> simpler to handle for other architectures, which default to unrestricted
> affinity setting. It also allows to cleanup the redundant core logic
> significantly.
> 
> All interrupt chips, which belong to a top-level domain sitting directly on
> top of the x86 vector domain are marked accordingly, unless the related
> setup code marks the interrupts with IRQ_MOVE_PCNTXT, i.e. XEN.
> 
> No functional change intended.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Wei Liu <wei.liu@kernel.org>
> Cc: Steve Wahl <steve.wahl@hpe.com>
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Lu Baolu <baolu.lu@linux.intel.com>
> Cc: Juergen Gross <jgross@suse.com>
> ---
>  arch/x86/Kconfig                    |    1 +
>  arch/x86/hyperv/irqdomain.c         |    2 +-
>  arch/x86/kernel/apic/io_apic.c      |    2 +-
>  arch/x86/kernel/apic/msi.c          |    3 ++-
>  arch/x86/kernel/hpet.c              |    8 --------
>  arch/x86/platform/uv/uv_irq.c       |    2 --
>  drivers/iommu/amd/init.c            |    2 +-
>  drivers/iommu/amd/iommu.c           |    1 -
>  drivers/iommu/intel/irq_remapping.c |    1 -
>  drivers/pci/controller/pci-hyperv.c |    1 +
>  drivers/xen/events/events_base.c    |    6 ------
>  11 files changed, 7 insertions(+), 22 deletions(-)
> 
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -173,6 +173,7 @@ config X86
>  	select GENERIC_IRQ_RESERVATION_MODE
>  	select GENERIC_IRQ_SHOW
>  	select GENERIC_PENDING_IRQ		if SMP
> +	select GENERIC_PENDING_IRQ_CHIPFLAGS	if SMP
>  	select GENERIC_PTDUMP
>  	select GENERIC_SMP_IDLE_THREAD
>  	select GENERIC_TIME_VSYSCALL
> --- a/arch/x86/hyperv/irqdomain.c
> +++ b/arch/x86/hyperv/irqdomain.c
> @@ -304,7 +304,7 @@ static struct irq_chip hv_pci_msi_contro
>  	.irq_retrigger		= irq_chip_retrigger_hierarchy,
>  	.irq_compose_msi_msg	= hv_irq_compose_msi_msg,
>  	.irq_set_affinity	= msi_domain_set_affinity,
> -	.flags			= IRQCHIP_SKIP_SET_WAKE,
> +	.flags			= IRQCHIP_SKIP_SET_WAKE | IRQCHIP_MOVE_DEFERRED,
>  };
>  
>  static struct msi_domain_ops pci_msi_domain_ops = {
> --- a/arch/x86/kernel/apic/io_apic.c
> +++ b/arch/x86/kernel/apic/io_apic.c
> @@ -1861,7 +1861,7 @@ static struct irq_chip ioapic_chip __rea
>  	.irq_set_affinity	= ioapic_set_affinity,
>  	.irq_retrigger		= irq_chip_retrigger_hierarchy,
>  	.irq_get_irqchip_state	= ioapic_irq_get_chip_state,
> -	.flags			= IRQCHIP_SKIP_SET_WAKE |
> +	.flags			= IRQCHIP_SKIP_SET_WAKE | IRQCHIP_MOVE_DEFERRED |
>  				  IRQCHIP_AFFINITY_PRE_STARTUP,
>  };
>  
> --- a/arch/x86/kernel/apic/msi.c
> +++ b/arch/x86/kernel/apic/msi.c
> @@ -214,6 +214,7 @@ static bool x86_init_dev_msi_info(struct
>  		if (WARN_ON_ONCE(domain != real_parent))
>  			return false;
>  		info->chip->irq_set_affinity = msi_set_affinity;
> +		info->chip->flags |= IRQCHIP_MOVE_DEFERRED;
>  		break;
>  	case DOMAIN_BUS_DMAR:
>  	case DOMAIN_BUS_AMDVI:
> @@ -315,7 +316,7 @@ static struct irq_chip dmar_msi_controll
>  	.irq_retrigger		= irq_chip_retrigger_hierarchy,
>  	.irq_compose_msi_msg	= dmar_msi_compose_msg,
>  	.irq_write_msi_msg	= dmar_msi_write_msg,
> -	.flags			= IRQCHIP_SKIP_SET_WAKE |
> +	.flags			= IRQCHIP_SKIP_SET_WAKE | IRQCHIP_MOVE_DEFERRED |
>  				  IRQCHIP_AFFINITY_PRE_STARTUP,
>  };
>  
> --- a/arch/x86/kernel/hpet.c
> +++ b/arch/x86/kernel/hpet.c
> @@ -516,22 +516,14 @@ static int hpet_msi_init(struct irq_doma
>  			 struct msi_domain_info *info, unsigned int virq,
>  			 irq_hw_number_t hwirq, msi_alloc_info_t *arg)
>  {
> -	irq_set_status_flags(virq, IRQ_MOVE_PCNTXT);
>  	irq_domain_set_info(domain, virq, arg->hwirq, info->chip, NULL,
>  			    handle_edge_irq, arg->data, "edge");
>  
>  	return 0;
>  }
>  
> -static void hpet_msi_free(struct irq_domain *domain,
> -			  struct msi_domain_info *info, unsigned int virq)
> -{
> -	irq_clear_status_flags(virq, IRQ_MOVE_PCNTXT);
> -}
> -
>  static struct msi_domain_ops hpet_msi_domain_ops = {
>  	.msi_init	= hpet_msi_init,
> -	.msi_free	= hpet_msi_free,
>  };
>  
>  static struct msi_domain_info hpet_msi_domain_info = {
> --- a/arch/x86/platform/uv/uv_irq.c
> +++ b/arch/x86/platform/uv/uv_irq.c
> @@ -92,8 +92,6 @@ static int uv_domain_alloc(struct irq_do
>  	if (ret >= 0) {
>  		if (info->uv.limit == UV_AFFINITY_CPU)
>  			irq_set_status_flags(virq, IRQ_NO_BALANCING);
> -		else
> -			irq_set_status_flags(virq, IRQ_MOVE_PCNTXT);
>  
>  		chip_data->pnode = uv_blade_to_pnode(info->uv.blade);
>  		chip_data->offset = info->uv.offset;
> --- a/drivers/iommu/amd/init.c
> +++ b/drivers/iommu/amd/init.c
> @@ -2332,7 +2332,7 @@ static struct irq_chip intcapxt_controll
>  	.irq_retrigger		= irq_chip_retrigger_hierarchy,
>  	.irq_set_affinity       = intcapxt_set_affinity,
>  	.irq_set_wake		= intcapxt_set_wake,
> -	.flags			= IRQCHIP_MASK_ON_SUSPEND,
> +	.flags			= IRQCHIP_MASK_ON_SUSPEND | IRQCHIP_MOVE_DEFERRED,
>  };
>  
>  static const struct irq_domain_ops intcapxt_domain_ops = {
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -3532,7 +3532,6 @@ static int irq_remapping_alloc(struct ir
>  		irq_data->chip_data = data;
>  		irq_data->chip = &amd_ir_chip;
>  		irq_remapping_prepare_irte(data, cfg, info, devid, index, i);
> -		irq_set_status_flags(virq + i, IRQ_MOVE_PCNTXT);
>  	}
>  
>  	return 0;
> --- a/drivers/iommu/intel/irq_remapping.c
> +++ b/drivers/iommu/intel/irq_remapping.c
> @@ -1463,7 +1463,6 @@ static int intel_irq_remapping_alloc(str
>  		else
>  			irq_data->chip = &intel_ir_chip;
>  		intel_irq_remapping_prepare_irte(ird, irq_cfg, info, index, i);
> -		irq_set_status_flags(virq + i, IRQ_MOVE_PCNTXT);
>  	}
>  	return 0;
>  
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -2053,6 +2053,7 @@ static struct irq_chip hv_msi_irq_chip =
>  	.irq_set_affinity	= irq_chip_set_affinity_parent,
>  #ifdef CONFIG_X86
>  	.irq_ack		= irq_chip_ack_parent,
> +	.flags			= IRQCHIP_MOVE_DEFERRED,
>  #elif defined(CONFIG_ARM64)
>  	.irq_eoi		= irq_chip_eoi_parent,
>  #endif
> --- a/drivers/xen/events/events_base.c
> +++ b/drivers/xen/events/events_base.c
> @@ -722,12 +722,6 @@ static struct irq_info *xen_irq_init(uns
>  		INIT_RCU_WORK(&info->rwork, delayed_free_irq);
>  
>  		set_info_for_irq(irq, info);
> -		/*
> -		 * Interrupt affinity setting can be immediate. No point
> -		 * in delaying it until an interrupt is handled.
> -		 */
> -		irq_set_status_flags(irq, IRQ_MOVE_PCNTXT);
> -
>  		INIT_LIST_HEAD(&info->eoi_list);
>  		list_add_tail(&info->list, &xen_irq_list_head);
>  	}
> 

-- 
Steve Wahl, Hewlett Packard Enterprise

