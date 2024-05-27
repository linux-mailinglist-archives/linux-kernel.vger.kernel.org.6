Return-Path: <linux-kernel+bounces-191513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A63E18D1092
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 01:43:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A1921F22250
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 23:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 968B313D2A2;
	Mon, 27 May 2024 23:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CZszdni2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D255F17E8F8;
	Mon, 27 May 2024 23:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716853371; cv=none; b=fdmPb9mvJ9IBeLkjyqlQVmrcCY9reUzNDLmD442fl2aYPWyDm2Zly1x4UdjV+frRbjKawgeDkh4Q2CUKmP+u7qBdUcZz8HeL1EaPGxc2WV2s3nYEKUwWkwYM1WSmBVyqIPgkhNzAvuOlR/He0deVdw1M0eoYPuPGRlkxFS9+ixU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716853371; c=relaxed/simple;
	bh=XUGNe4Vne0m7pN3CMpt65nY5zW6n4Cua0wTpgEl0dxI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nQ+TtfVWVwypkQiZNTdIskpaJFn/Z6Iq0VC2H/dtflIx5ek3oDGNaXgCnjNtksrCsjO+cQUs5B2oVNQi3jC1Oqf4hQOZf5aywi6WeErp8U6qHjdajjqdcIP9nYhfOmH7BufXQu63kwSDMauEOEmrj1oQYi/whvs3/whCPCMJoAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CZszdni2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B19FAC2BBFC;
	Mon, 27 May 2024 23:42:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716853371;
	bh=XUGNe4Vne0m7pN3CMpt65nY5zW6n4Cua0wTpgEl0dxI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CZszdni2CFdUNNsdaZQSdg5xyv2aQogk6pGHNwOc4uqLYLDCvOQmcSZ0kn8u+298X
	 KpbX3qLNsRuXhWknHdCEkOhfPUtWjkSFsPv/EU9WtIAbyPTgRe8GoGqQGAY1AbHeOY
	 hoXeHswPUOoGseVhJFFKmOC+BI2hk7/79aLxRobZfrbKEi4twNZOdHpv1gAu11jS90
	 zMPOTHWY7nd4og9A93W8OF0excwX1wAEgcksaNMyiyOH4tkk7veTAP6UflJz42ir9a
	 jzw7zUJf2XnF1tK81SpynefzpwVwhNpFffDHLDKLMEIz9rLTl+jpUEMu8qwWUqE2nj
	 eKslG/W+wlbcQ==
Date: Mon, 27 May 2024 16:42:49 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Chen Ni <nichen@iscas.ac.cn>
Cc: nbd@nbd.name, sean.wang@mediatek.com, Mark-MC.Lee@mediatek.com,
 lorenzo@kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net-next v2] net: ethernet: mtk_eth_soc: add missing
 check for rhashtable_init
Message-ID: <20240527164249.4aafd105@kernel.org>
In-Reply-To: <20240517023922.362327-1-nichen@iscas.ac.cn>
References: <20240517023922.362327-1-nichen@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 17 May 2024 10:39:22 +0800 Chen Ni wrote:
> diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> index cae46290a7ae..f9b8956a8726 100644
> --- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> +++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> @@ -4957,7 +4957,7 @@ static int mtk_probe(struct platform_device *pdev)
>  
>  			eth->ppe[i] = mtk_ppe_init(eth, eth->base + ppe_addr, i);
>  
> -			if (!eth->ppe[i]) {
> +			if (IS_ERR_OR_NULL(eth->ppe[i])) {
>  				err = -ENOMEM;

You still discard the real error here.

>  				goto err_deinit_ppe;
>  			}
> diff --git a/drivers/net/ethernet/mediatek/mtk_ppe.c b/drivers/net/ethernet/mediatek/mtk_ppe.c
> index 0acee405a749..4895c6febaf8 100644
> --- a/drivers/net/ethernet/mediatek/mtk_ppe.c
> +++ b/drivers/net/ethernet/mediatek/mtk_ppe.c
> @@ -884,12 +884,15 @@ struct mtk_ppe *mtk_ppe_init(struct mtk_eth *eth, void __iomem *base, int index)
>  	struct mtk_ppe *ppe;
>  	u32 foe_flow_size;
>  	void *foe;
> +	int ret;
>  
>  	ppe = devm_kzalloc(dev, sizeof(*ppe), GFP_KERNEL);
>  	if (!ppe)
>  		return NULL;

Please convert the return NULL in this function to 
return ERR_PTR(-ENOMEM) and use the error code in mtk_probe()

> -	rhashtable_init(&ppe->l2_flows, &mtk_flow_l2_ht_params);
> +	ret = rhashtable_init(&ppe->l2_flows, &mtk_flow_l2_ht_params);
> +	if (ret)
> +		return ERR_PTR(ret);

Also there are two direct return NULLs without calling rhashtable_destroy()
later in this function. Please fix that in a separate patch.

>  	/* need to allocate a separate device, since it PPE DMA access is
>  	 * not coherent.

