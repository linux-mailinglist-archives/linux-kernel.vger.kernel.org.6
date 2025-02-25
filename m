Return-Path: <linux-kernel+bounces-530841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FC7FA43924
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 10:18:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85A331725ED
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 09:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 976E62676F8;
	Tue, 25 Feb 2025 09:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DDefn0rw"
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 396DA26770E
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 09:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740474681; cv=none; b=FXiccEGZgLnFYh8h72XtvWOMs6QQE7EY1O55XLoKRb8/g6bBw5nHI+euac5hHaeTG1zDKZ9NnKP5ooBYBj6GJGJpgDjFSgLubq/H5rK5cp0xSCquSrz4mxZaC4yBG3lhzukVsppn3nrg3WVnXIfjvwpQMgo2nGqeIf+ONE+ecdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740474681; c=relaxed/simple;
	bh=ULVdGn7V1+B9/1+UvwyE2gO5D3tyEjU/3bIQJWQvo9w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aszoi/GjJpT3Xu/EegU6dLT4xCFN8IMFg07Uz5rZ2e1x0pEYN6A5DyvbvxRZMhpQNpgg40x8DyicITBSdES8D7REv5cQE7ewtFJrCJfEKgpp6kqSZMZQ+rXM1bEMR3gOIa5LnLSEg/jH0TkkMd4tEV4pLXC/+FZMxBWWPxOW88c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DDefn0rw; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <425215fb-8fb5-4412-87e7-1d29c4ac0b7f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740474667;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z+uneR/mJS3GnAKzOPOj3taPV7XZaDcHgKVZzaJi0fo=;
	b=DDefn0rw48FmnpU4dE1uzQN58xOKblryXKII2hPkQlzaPz9m/h8jhLz7SHxlkpRBfpxqtO
	zqlhWACWT2n6KotMuGTBKZH/4KDxrB1BeTioPMtSI5wvaY4aXn8wOp8uFvSG3FE52bafWy
	gbI0sciBbXJFt9Pdp4DL92u1CiJP6VA=
Date: Tue, 25 Feb 2025 17:10:58 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v3 3/4] stmmac: Remove pcim_* functions for
 driver detach
To: Philipp Stanner <phasta@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Huacai Chen <chenhuacai@kernel.org>, Yinggang Gu <guyinggang@loongson.cn>,
 Feiyang Chen <chenfeiyang@loongson.cn>, Philipp Stanner
 <pstanner@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Qing Zhang <zhangqing@loongson.cn>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250224135321.36603-2-phasta@kernel.org>
 <20250224135321.36603-5-phasta@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yanteng Si <si.yanteng@linux.dev>
In-Reply-To: <20250224135321.36603-5-phasta@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


在 2/24/25 9:53 PM, Philipp Stanner 写道:
> Functions prefixed with "pcim_" are managed devres functions which
> perform automatic cleanup once the driver unloads. It is, thus, not
> necessary to call any cleanup functions in remove() callbacks.
>
> Remove the pcim_ cleanup function calls in the remove() callbacks.
>
> Signed-off-by: Philipp Stanner <phasta@kernel.org>
> ---
>   drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c |  7 -------
>   drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c     | 10 ----------
>   2 files changed, 17 deletions(-)
>
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> index e3cacd085b3f..f3ea6016be68 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> @@ -614,13 +614,6 @@ static void loongson_dwmac_remove(struct pci_dev *pdev)
>   	if (ld->loongson_id == DWMAC_CORE_LS_MULTICHAN)
>   		loongson_dwmac_msi_clear(pdev);
>   
> -	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
> -		if (pci_resource_len(pdev, i) == 0)
> -			continue;
> -		pcim_iounmap_regions(pdev, BIT(i));
> -		break;
> -	}
> -
>   	pci_disable_device(pdev);
>   }
>   
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c
> index 352b01678c22..91ff6c15f977 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c
> @@ -227,20 +227,10 @@ static int stmmac_pci_probe(struct pci_dev *pdev,
>    *
>    * @pdev: platform device pointer

>    * Description: this function calls the main to free the net resources

There is a missing full stop. You commented on the next email,

and it seems that you are already preparing for v4.  With this


Reviewed-by: Yanteng Si <si.yanteng@linux.dev>

Thanks,
Yanteng

> - * and releases the PCI resources.
>    */
>   static void stmmac_pci_remove(struct pci_dev *pdev)
>   {
> -	int i;
> -
>   	stmmac_dvr_remove(&pdev->dev);
> -
> -	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
> -		if (pci_resource_len(pdev, i) == 0)
> -			continue;
> -		pcim_iounmap_regions(pdev, BIT(i));
> -		break;
> -	}
>   }
>   
>   static int __maybe_unused stmmac_pci_suspend(struct device *dev)

