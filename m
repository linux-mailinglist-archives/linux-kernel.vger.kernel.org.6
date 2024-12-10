Return-Path: <linux-kernel+bounces-440059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D01F9EB826
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 18:22:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13E67282C4C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 17:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0ED186325;
	Tue, 10 Dec 2024 17:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e+lek6YZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BCCD86320
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 17:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733851332; cv=none; b=N4xLeCQY96n05ElJcaswHKl7MN6oiZyLwyUJK27IVhaVii9yjwgbct6bn+qodHgsgSQDliuuh96daOsagmwBgXa6sjfQKMd4CyGBjcacrHdavuJSnh/FZXAJ81CKmf5eQZspIhhZ0SciFRfJmoooTO4CR0A+ptFtAa9N82XNS/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733851332; c=relaxed/simple;
	bh=JqwIwKHXQ3YYhSseR2XdZhg3K/koJuneICegfB3H4T4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HqSG61UshQfeXew81ppYy37x8rOg5YhZ/mucUVwBlzqgHu1HRp0LND1UARQXjZBGxXLZy4YiKiyjldA+lHa891ZtMNFufGTg2pJYID61DR8vUgX7SkyzXm0WFBGFPON+hRrkh456bHPH0p6YydCyaEx9om3bRgvqQZ84M/s9wL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e+lek6YZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2644CC4CED6;
	Tue, 10 Dec 2024 17:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733851331;
	bh=JqwIwKHXQ3YYhSseR2XdZhg3K/koJuneICegfB3H4T4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=e+lek6YZUxkVUzRMIXFqR1hnd/W83yhh5F6eGTgI+221+ilRenSkiPi06ZZt/0c1S
	 R9W97UQX2a7d0raHssllgOPwaG51AAaJl6+v37OaZZOi7FJ/FqMjEMVHCmj4TRgluu
	 OrsfUhG3mzsEr5X9zvd1i9zW5BFd/XaMA1qdNRcwwo5g/lYRmhUFotMg+jFDZI68+9
	 pzUPnr1twoMP0KN/ZBQq8skmeeseMWRGHjZjQjG3AoDcQM95cUBZPPnww54BWapgRv
	 Hg/CuFAB6GZnOTzO7GylRvGkMvu6+YLx5htrf/pQZbTzi7XEnRDun8nqW008Gq8ivH
	 SXlYXBPg9DNig==
Message-ID: <00beef4c-fef7-4628-854a-f3da3ba90541@kernel.org>
Date: Tue, 10 Dec 2024 09:22:08 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [patch 1/5] ARC: Remove GENERIC_PENDING_IRQ
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Cc: x86@kernel.org, Anup Patel <apatel@ventanamicro.com>,
 Vineet Gupta <vgupta@kernel.org>, Brian Cain <bcain@quicinc.com>,
 Wei Liu <wei.liu@kernel.org>, Steve Wahl <steve.wahl@hpe.com>,
 Joerg Roedel <joro@8bytes.org>, Lu Baolu <baolu.lu@linux.intel.com>,
 Juergen Gross <jgross@suse.com>
References: <20241210102148.760383417@linutronix.de>
 <20241210103335.373392568@linutronix.de>
From: Vineet Gupta <vgupta@kernel.org>
Content-Language: en-US
In-Reply-To: <20241210103335.373392568@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 12/10/24 02:34, Thomas Gleixner wrote:
> Nothing uses the actual functionality and the MCIP controller sets the
> flags which disables the deferred affinity change. The other interrupt
> controller does not support affinity setting at all.
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Vineet Gupta <vgupta@kernel.org>

Acked-by: Vineet Gupta <vgupta@kernel.org>   # arch/arc/

> ---
>  arch/arc/Kconfig       |    1 -
>  arch/arc/kernel/mcip.c |    2 --
>  kernel/irq/debugfs.c   |    1 +
>  3 files changed, 1 insertion(+), 3 deletions(-)
>
> --- a/arch/arc/Kconfig
> +++ b/arch/arc/Kconfig
> @@ -24,7 +24,6 @@ config ARC
>  	# for now, we don't need GENERIC_IRQ_PROBE, CONFIG_GENERIC_IRQ_CHIP
>  	select GENERIC_IRQ_SHOW
>  	select GENERIC_PCI_IOMAP
> -	select GENERIC_PENDING_IRQ if SMP
>  	select GENERIC_SCHED_CLOCK
>  	select GENERIC_SMP_IDLE_THREAD
>  	select GENERIC_IOREMAP
> --- a/arch/arc/kernel/mcip.c
> +++ b/arch/arc/kernel/mcip.c
> @@ -357,8 +357,6 @@ static void idu_cascade_isr(struct irq_d
>  static int idu_irq_map(struct irq_domain *d, unsigned int virq, irq_hw_number_t hwirq)
>  {
>  	irq_set_chip_and_handler(virq, &idu_irq_chip, handle_level_irq);
> -	irq_set_status_flags(virq, IRQ_MOVE_PCNTXT);
> -
>  	return 0;
>  }
>  
> --- a/kernel/irq/debugfs.c
> +++ b/kernel/irq/debugfs.c
> @@ -53,6 +53,7 @@ static const struct irq_bit_descr irqchi
>  	BIT_MASK_DESCR(IRQCHIP_SUPPORTS_NMI),
>  	BIT_MASK_DESCR(IRQCHIP_ENABLE_WAKEUP_ON_SUSPEND),
>  	BIT_MASK_DESCR(IRQCHIP_IMMUTABLE),
> +	BIT_MASK_DESCR(IRQCHIP_MOVE_DEFERRED),

I think this leaked in here, needs to be in patch 3/5

Cheers,
-Vineet

>  };
>  
>  static void
>


