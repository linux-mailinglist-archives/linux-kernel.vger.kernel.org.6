Return-Path: <linux-kernel+bounces-378122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B5E89ACBA8
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 15:52:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 497FF1C20AD6
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 13:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 462121B4F31;
	Wed, 23 Oct 2024 13:51:47 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1250E159583
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 13:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729691506; cv=none; b=drwzrkadXLqDTafaTMh7APk4EgBjh5Gvj4AUKSofeTeCR1OsJZnWUlHQJs23eMf0U2BJBpEOLfv74LTDYryGSljdCOD9JoCih8EQQGgfsowVt50PG4pvlfC+iWrrpUOLIA4uF2sRBpGubx6fWpkS2LUcq+kY4WlCeS0ZQxzbvf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729691506; c=relaxed/simple;
	bh=YOtwnsW70pES7KMVuJKypeky+wnAe3/kq7f0tWecmnE=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=GM5q2SwfHUUmVKDp/3e4g/a+Aim2hE7hVxq5zrov5z/OKA7d0ihOqm3cRj+8eDYHxgW8tl7mwbLOii/Vy/lBeklwZkt6iqO4xnMlbmnnZUiXdC6JlmeVCG0p9R/0eHeT1yxjtfkUXErHyeVTzD1ylkjy8VebniACkpJ+31MkSbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4XYVls0Vp0zpX8B;
	Wed, 23 Oct 2024 21:49:45 +0800 (CST)
Received: from kwepemm600007.china.huawei.com (unknown [7.193.23.208])
	by mail.maildlp.com (Postfix) with ESMTPS id 07D92180087;
	Wed, 23 Oct 2024 21:51:42 +0800 (CST)
Received: from [10.174.178.219] (10.174.178.219) by
 kwepemm600007.china.huawei.com (7.193.23.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 23 Oct 2024 21:51:41 +0800
Subject: Re: [PATCH] irqchip/gic-v4: Don't allow a VMOVP on a dying VPE
To: Marc Zyngier <maz@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>, Kunkun Jiang <jiangkunkun@huawei.com>
References: <20241002204959.2051709-1-maz@kernel.org>
 <aab45cd3-e5ca-58cf-e081-e32a17f5b4e7@huawei.com>
 <87wmhztd9z.wl-maz@kernel.org>
From: Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <bb3a38d9-4eb8-83ff-8b94-dd1bc80d005f@huawei.com>
Date: Wed, 23 Oct 2024 21:51:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <87wmhztd9z.wl-maz@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600007.china.huawei.com (7.193.23.208)

On 2024/10/23 16:49, Marc Zyngier wrote:
> Hi Zenghui,
> 
> On Tue, 22 Oct 2024 08:45:17 +0100,
> Zenghui Yu <yuzenghui@huawei.com> wrote:
> >
> > Hi Marc,
> >
> > On 2024/10/3 4:49, Marc Zyngier wrote:
> > > Kunkun Jiang reports that there is a small window of opportunity for
> > > userspace to force a change of affinity for a VPE while the VPE has
> > > already been unmapped, but the corresponding doorbell interrupt still
> > > visible in /proc/irq/.
> > >
> > > Plug the race by checking the value of vmapp_count, which tracks whether
> > > the VPE is mapped ot not, and returning an error in this case.
> > >
> > > This involves making vmapp_count common to both GICv4.1 and its v4.0
> > > ancestor.
> > >
> > > Reported-by: Kunkun Jiang <jiangkunkun@huawei.com>
> > > Signed-off-by: Marc Zyngier <maz@kernel.org>
> > > Link: https://lore.kernel.org/r/c182ece6-2ba0-ce4f-3404-dba7a3ab6c52@huawei.com
> > > ---
> > >  drivers/irqchip/irq-gic-v3-its.c   | 18 ++++++++++++------
> > >  include/linux/irqchip/arm-gic-v4.h |  4 +++-
> > >  2 files changed, 15 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
> > > index fdec478ba5e7..ab597e74ba08 100644
> > > --- a/drivers/irqchip/irq-gic-v3-its.c
> > > +++ b/drivers/irqchip/irq-gic-v3-its.c
> > > @@ -797,8 +797,8 @@ static struct its_vpe *its_build_vmapp_cmd(struct its_node *its,
> > >  	its_encode_valid(cmd, desc->its_vmapp_cmd.valid);
> > >  
> > >  	if (!desc->its_vmapp_cmd.valid) {
> > > +		alloc = !atomic_dec_return(&desc->its_vmapp_cmd.vpe->vmapp_count);
> > >  		if (is_v4_1(its)) {
> > > -			alloc = !atomic_dec_return(&desc->its_vmapp_cmd.vpe->vmapp_count);
> > >  			its_encode_alloc(cmd, alloc);
> > >  			/*
> > >  			 * Unmapping a VPE is self-synchronizing on GICv4.1,
> > > @@ -817,13 +817,13 @@ static struct its_vpe *its_build_vmapp_cmd(struct its_node *its,
> > >  	its_encode_vpt_addr(cmd, vpt_addr);
> > >  	its_encode_vpt_size(cmd, LPI_NRBITS - 1);
> > >  
> > > +	alloc = !atomic_fetch_inc(&desc->its_vmapp_cmd.vpe->vmapp_count);
> > > +
> > >  	if (!is_v4_1(its))
> > >  		goto out;
> > >  
> > >  	vconf_addr = virt_to_phys(page_address(desc->its_vmapp_cmd.vpe->its_vm->vprop_page));
> > >  
> > > -	alloc = !atomic_fetch_inc(&desc->its_vmapp_cmd.vpe->vmapp_count);
> > > -
> > >  	its_encode_alloc(cmd, alloc);
> > >  
> > >  	/*
> > > @@ -3806,6 +3806,13 @@ static int its_vpe_set_affinity(struct irq_data *d,
> > >  	struct cpumask *table_mask;
> > >  	unsigned long flags;
> > >  
> > > +	/*
> > > +	 * Check if we're racing against a VPE being destroyed, for
> > > +	 * which we don't want to allow a VMOVP.
> > > +	 */
> > > +	if (!atomic_read(&vpe->vmapp_count))
> > > +		return -EINVAL;
> >
> > We lazily map the vPE so that vmapp_count is likely to be 0 on GICv4.0
> > implementations with the ITSList feature. Seems that that implementation
> > is not affected by the reported race and we don't need to check
> > vmapp_count for that.
> 
> Indeed, the ITSList guards the sending of VMOVP in that case, and we
> avoid the original issue in that case. However, this still translates
> in the doorbell being moved for no reason (see its_vpe_db_proxy_move).

Yup.

> How about something like this?

I'm pretty sure that the splat will disappear with that.

> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
> index ab597e74ba08..ac8ed56f1e48 100644
> --- a/drivers/irqchip/irq-gic-v3-its.c
> +++ b/drivers/irqchip/irq-gic-v3-its.c
> @@ -3810,8 +3810,17 @@ static int its_vpe_set_affinity(struct irq_data *d,
>  	 * Check if we're racing against a VPE being destroyed, for
>  	 * which we don't want to allow a VMOVP.
>  	 */
> -	if (!atomic_read(&vpe->vmapp_count))
> -		return -EINVAL;
> +	if (!atomic_read(&vpe->vmapp_count)) {
> +		if (gic_requires_eager_mapping())
> +			return -EINVAL;

Nitpick: why do we treat this as an error?

> +
> +		/*
> +		 * If we lazily map the VPEs, this isn't an error, and
> +		 * we exit cleanly.
> +		 */
> +		irq_data_update_effective_affinity(d, cpumask_of(cpu));

@cpu is uninitialized to a sensible value at this point?

> +		return IRQ_SET_MASK_OK_DONE;
> +	}
>  
>  	/*
>  	 * Changing affinity is mega expensive, so let's be as lazy as

Thanks,
Zenghui

