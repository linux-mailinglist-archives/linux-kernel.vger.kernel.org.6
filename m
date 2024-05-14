Return-Path: <linux-kernel+bounces-178704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E535E8C56A8
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 15:11:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBDBC284403
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 13:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1257E47A57;
	Tue, 14 May 2024 13:11:24 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224C81411E7
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 13:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715692283; cv=none; b=BFeadTZu7ItgBQNIHJSUa2tLyVvd/7/3AqcUkWw7PF4aflsAOMJB9IYp4w/4Vu42YF+9eu41q6uEk/6mhpoASl6XCBB2Choa93S2seZNRSGFyHB+KTuD9lylzugfC1PoGF7PXa8UK0v9Ju+FOCGzzKopo0FF0yviAGuMHPw4qyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715692283; c=relaxed/simple;
	bh=EFrWLGeK8DYkOeYKEgBZUG6UC+AvHnAbzCcC59Su6VA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=OtgtObc44wKqUgDddmHAm3Tt5bkiprnCUluajN8IsCoiJTgSrVHE/FBFtU+jABOsC7Qa+6z+CGBINvJmGSsEKQm5g9k6q1DTXCSAjTSP4tdxKbuv4kdH8iKSXkMGfvWnp/L2noz5iQddk9t5tMXvKXDK/8D/Gqax6WqbrqnT84w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4VdxVw52TGzPlKS
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 21:08:24 +0800 (CST)
Received: from kwepemi500008.china.huawei.com (unknown [7.221.188.139])
	by mail.maildlp.com (Postfix) with ESMTPS id 2450E18007E
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 21:11:18 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemi500008.china.huawei.com (7.221.188.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 14 May 2024 21:11:17 +0800
Message-ID: <668e65d3-f7a5-2387-bad8-d4b29bb69563@huawei.com>
Date: Tue, 14 May 2024 21:11:16 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH] genirq: Clean code for handle_edge_irq()
Content-Language: en-US
To: <tglx@linutronix.de>, <linux-kernel@vger.kernel.org>
References: <20240514130915.2613753-1-ruanjinjie@huawei.com>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <20240514130915.2613753-1-ruanjinjie@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemi500008.china.huawei.com (7.221.188.139)



On 2024/5/14 21:09, Jinjie Ruan wrote:
> The pending set and mask_ack_irq() repeated twice, a new goto label can
> reduce a few lines of code, with no functional changes.
> 
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
>  kernel/irq/chip.c | 17 +++++++----------
>  1 file changed, 7 insertions(+), 10 deletions(-)
> 
> diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
> index 638cf5eee04b..4613dc9ff6b6 100644
> --- a/kernel/irq/chip.c
> +++ b/kernel/irq/chip.c
> @@ -775,21 +775,15 @@ void handle_edge_irq(struct irq_desc *desc)
>  
>  	desc->istate &= ~(IRQS_REPLAY | IRQS_WAITING);
>  
> -	if (!irq_may_run(desc)) {
> -		desc->istate |= IRQS_PENDING;
> -		mask_ack_irq(desc);
> -		goto out_unlock;
> -	}
> +	if (!irq_may_run(desc))
> +		goto out_mask_ack;
>  
>  	/*
>  	 * If its disabled or no action available then mask it and get
>  	 * out of here.
>  	 */
> -	if (irqd_irq_disabled(&desc->irq_data) || !desc->action) {
> -		desc->istate |= IRQS_PENDING;
> -		mask_ack_irq(desc);
> -		goto out_unlock;
> -	}
> +	if (irqd_irq_disabled(&desc->irq_data) || !desc->action)
> +		goto out_mask_ack;
>  
>  	kstat_incr_irqs_this_cpu(desc);
>  
> @@ -818,6 +812,9 @@ void handle_edge_irq(struct irq_desc *desc)
>  	} while ((desc->istate & IRQS_PENDING) &&
>  		 !irqd_irq_disabled(&desc->irq_data));
>  
> +out_mask_ack:
> +	desc->istate |= IRQS_PENDING;
> +	mask_ack_irq(desc);

Please ignore this patch, this is a generic export and should not be
used as such.

>  out_unlock:
>  	raw_spin_unlock(&desc->lock);
>  }

