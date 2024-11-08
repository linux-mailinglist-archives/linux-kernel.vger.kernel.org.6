Return-Path: <linux-kernel+bounces-401848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AAE59C201D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 16:12:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDED42846C4
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 15:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 245EE1F6679;
	Fri,  8 Nov 2024 15:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="K+p8lLLQ"
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D421F666F
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 15:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731078715; cv=none; b=gUqZBectIqf8g7DNeeG+uUReQ5/wbx50k1s63Rh5CNr5sGVZk5ykKqDP7C8vXQxC2UZcG/0VTrhDnYwCVDhFrmE6umy++um+R1mCGHNAdHMZN0exJ89i9gFGJ5mX1QCyWFRfk1glSr9mCr/kUJ7NorvCeYRMuEPrfIxtUJGrgqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731078715; c=relaxed/simple;
	bh=GNVFDNqJ8WeDYhHLwQfA/gWF2r05SDu9NQakYeuZUxk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CfjOq0DWCOp6xrQe+GaJsk0Pu6QA8ZQQrLWTrwffQ7bBLukS59bjuRVDdWYoJTek2/RN4uGqdzTxic7+GPRjOMTT+tyFJJxyrF4LvHTTD30WBkBXdSWUin5zUG1XRfifOh79YilO5ArBrmiOj03/Ww13ovGG6Wrv9aMuFaPVlvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=K+p8lLLQ; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <c3682951-e172-421f-945e-ffe08d67ab66@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1731078710;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IStD4SWIrv5W1vpLpxVKURat2SUcclzzait9dqwsJJk=;
	b=K+p8lLLQwLgLjXZ5migX6X6/Hw+nO3Hk7CchIkUPLkWi4/MBXRvxszOBlJMHoZrY/EoWge
	awXz+Lzjac1rrJYwmdYRmStScGUtdzKDfPO8fOg9x+HdKHemWZ3AA9rTFoCDuic7FF48js
	5kh/+qAms629g4BDwxbrl2+g8ndwsz8=
Date: Fri, 8 Nov 2024 15:11:42 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net v2 1/7] octeon_ep: Add checks to fix double free
 crashes.
To: Shinas Rasheed <srasheed@marvell.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: hgani@marvell.com, sedara@marvell.com, vimleshk@marvell.com,
 thaller@redhat.com, wizhao@redhat.com, kheib@redhat.com, egallen@redhat.com,
 konguyen@redhat.com, horms@kernel.org, frank.feng@synaxg.com,
 Veerasenareddy Burru <vburru@marvell.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
References: <20241107132846.1118835-1-srasheed@marvell.com>
 <20241107132846.1118835-2-srasheed@marvell.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20241107132846.1118835-2-srasheed@marvell.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 07/11/2024 13:28, Shinas Rasheed wrote:
> From: Vimlesh Kumar <vimleshk@marvell.com>
> 
> Add required checks to avoid double free. Crashes were
> observed due to the same on reset scenarios
> 
> Signed-off-by: Vimlesh Kumar <vimleshk@marvell.com>
> Signed-off-by: Shinas Rasheed <srasheed@marvell.com>
> ---
> V2:
>    - No changes
> 
> V1: https://lore.kernel.org/all/20241101103416.1064930-2-srasheed@marvell.com/
> 
>   .../ethernet/marvell/octeon_ep/octep_main.c   | 39 +++++++++++--------
>   .../net/ethernet/marvell/octeon_ep/octep_tx.c |  2 +
>   2 files changed, 25 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_main.c b/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
> index 549436efc204..ff72b796bd25 100644
> --- a/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
> +++ b/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
> @@ -154,9 +154,11 @@ static int octep_enable_msix_range(struct octep_device *oct)
>    */
>   static void octep_disable_msix(struct octep_device *oct)
>   {
> -	pci_disable_msix(oct->pdev);
> -	kfree(oct->msix_entries);
> -	oct->msix_entries = NULL;
> +	if (oct->msix_entries) {
> +		pci_disable_msix(oct->pdev);
> +		kfree(oct->msix_entries);
> +		oct->msix_entries = NULL;
> +	}
>   	dev_info(&oct->pdev->dev, "Disabled MSI-X\n");

How can this function crash? pci_disable_msix() will have checks for
already disabled msix, kfree can properly deal with NULL pointer.
Do you have stack trace of the crash here?

>   }
>   
> @@ -496,16 +498,18 @@ static void octep_free_irqs(struct octep_device *oct)
>   {
>   	int i;
>   
> -	/* First few MSI-X interrupts are non queue interrupts; free them */
> -	for (i = 0; i < CFG_GET_NON_IOQ_MSIX(oct->conf); i++)
> -		free_irq(oct->msix_entries[i].vector, oct);
> -	kfree(oct->non_ioq_irq_names);
> -
> -	/* Free IRQs for Input/Output (Tx/Rx) queues */
> -	for (i = CFG_GET_NON_IOQ_MSIX(oct->conf); i < oct->num_irqs; i++) {
> -		irq_set_affinity_hint(oct->msix_entries[i].vector, NULL);
> -		free_irq(oct->msix_entries[i].vector,
> -			 oct->ioq_vector[i - CFG_GET_NON_IOQ_MSIX(oct->conf)]);
> +	if (oct->msix_entries) {
> +		/* First few MSI-X interrupts are non queue interrupts; free them */
> +		for (i = 0; i < CFG_GET_NON_IOQ_MSIX(oct->conf); i++)
> +			free_irq(oct->msix_entries[i].vector, oct);
> +		kfree(oct->non_ioq_irq_names);
> +
> +		/* Free IRQs for Input/Output (Tx/Rx) queues */
> +		for (i = CFG_GET_NON_IOQ_MSIX(oct->conf); i < oct->num_irqs; i++) {
> +			irq_set_affinity_hint(oct->msix_entries[i].vector, NULL);
> +			free_irq(oct->msix_entries[i].vector,
> +				 oct->ioq_vector[i - CFG_GET_NON_IOQ_MSIX(oct->conf)]);
> +		}
>   	}
>   	netdev_info(oct->netdev, "IRQs freed\n");
>   }

Have you considered fast return option? like

if (!octep_disable_msix)
	return;

It will make less intendation and less changes in LoC but will presume
the same behavior.

> @@ -635,8 +639,10 @@ static void octep_napi_delete(struct octep_device *oct)
>   
>   	for (i = 0; i < oct->num_oqs; i++) {
>   		netdev_dbg(oct->netdev, "Deleting NAPI on Q-%d\n", i);
> -		netif_napi_del(&oct->ioq_vector[i]->napi);
> -		oct->oq[i]->napi = NULL;
> +		if (oct->oq[i]->napi) {
> +			netif_napi_del(&oct->ioq_vector[i]->napi);
> +			oct->oq[i]->napi = NULL;
> +		}
>   	}
>   }
>   

[ .. snip ..]

