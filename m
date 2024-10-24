Return-Path: <linux-kernel+bounces-379789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DFE29AE3D3
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 13:28:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B87AA1F238A1
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 11:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 122F91CF5C6;
	Thu, 24 Oct 2024 11:28:47 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D38FE1CF295
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 11:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729769326; cv=none; b=TDRQYspyiM1Ic2hbGeku75PIh9BR13LQYXwWMLCnH0pirOnupV0tvwq9LwPn0iJabgKhpy3F+pS9YtyIsdGlAFGOKhcwoswcQTh/5Rxbys3Dd6T2gcs3mXytagX3huX+XpLWAZCKNKrIz6ldEhCYT9Q0SGdJ1KwYqMpMRXMYAmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729769326; c=relaxed/simple;
	bh=gRiAaL9U+lFGWbjTS0fokEV0D/5yUyE7EjflX9Nll0I=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=L0XI0wGQ4YS+X+iuqfDIJsiMRrMw1fWqkWOV0DxFuQzR5u9TBHdr+Idz20ROGYSM2Fp6QKutMA8xX5bpivjqXhk0zueEIbyRUc+FhBhsTkWTFG8MwmORGMAojnByJbFIu9oDew3zRjC4swSlOWOG4Nb7mhiDRgov4wkgATbfsz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4XZ3XF477Wz1T8xQ;
	Thu, 24 Oct 2024 19:26:37 +0800 (CST)
Received: from kwepemm600007.china.huawei.com (unknown [7.193.23.208])
	by mail.maildlp.com (Postfix) with ESMTPS id 8BD5D1800DB;
	Thu, 24 Oct 2024 19:28:40 +0800 (CST)
Received: from [10.174.178.219] (10.174.178.219) by
 kwepemm600007.china.huawei.com (7.193.23.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 24 Oct 2024 19:28:39 +0800
Subject: Re: [PATCH] irqchip/gic-v4: Don't allow a VMOVP on a dying VPE
To: Marc Zyngier <maz@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>, Kunkun Jiang <jiangkunkun@huawei.com>
References: <20241002204959.2051709-1-maz@kernel.org>
 <aab45cd3-e5ca-58cf-e081-e32a17f5b4e7@huawei.com>
 <87wmhztd9z.wl-maz@kernel.org>
 <bb3a38d9-4eb8-83ff-8b94-dd1bc80d005f@huawei.com>
 <8634km5250.wl-maz@kernel.org>
From: Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <5474225b-d4b7-b565-75d6-3d61113caba0@huawei.com>
Date: Thu, 24 Oct 2024 19:28:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <8634km5250.wl-maz@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600007.china.huawei.com (7.193.23.208)

On 2024/10/23 22:23, Marc Zyngier wrote:
> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
> index ab597e74ba08e..52f625e07658c 100644
> --- a/drivers/irqchip/irq-gic-v3-its.c
> +++ b/drivers/irqchip/irq-gic-v3-its.c
> @@ -3810,8 +3810,18 @@ static int its_vpe_set_affinity(struct irq_data *d,
>  	 * Check if we're racing against a VPE being destroyed, for
>  	 * which we don't want to allow a VMOVP.
>  	 */
> -	if (!atomic_read(&vpe->vmapp_count))
> -		return -EINVAL;
> +	if (!atomic_read(&vpe->vmapp_count)) {
> +		if (gic_requires_eager_mapping())
> +			return -EINVAL;
> +
> +		/*
> +		 * If we lazily map the VPEs, this isn't an error and
> +		 * we can exit cleanly.
> +		 */
> +		cpu = cpumask_first(mask_val);
> +		irq_data_update_effective_affinity(d, cpumask_of(cpu));
> +		return IRQ_SET_MASK_OK_DONE;
> +	}
>  
>  	/*
>  	 * Changing affinity is mega expensive, so let's be as lazy as

Looks good, thanks!

Reviewed-by: Zenghui Yu <yuzenghui@huawei.com>

