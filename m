Return-Path: <linux-kernel+bounces-533534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CEADA45BC3
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 11:30:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FF34170DC8
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 10:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEF3F24DFE9;
	Wed, 26 Feb 2025 10:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YuVuEk7a"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58BAC258CE8
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 10:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740565805; cv=none; b=TIIAuj0Zgpy7gN1yfkaMZjYSXVf+B4FlXon+R0aycwnuxcKZ/rqEfPoKFU2FDWYvx12OY/GeiksHV8716UFYbFjP67j6gkOVLARKjg12XxcxAaAb2u1HhiwueY3i7tUzYtYe5q3Zk/5bE9TBwiK4VMLhuGwDzh9PttJAWm4yE9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740565805; c=relaxed/simple;
	bh=bsAyNNQkQVKThSw24g/EY+CHTrvuROCaxPN0DzHE+2o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TwU/kLpG5MiYiEmqheGdd99jbEeldnTDp+gxb9DVyjl7OuNz3bO7XU2kNMEtWnvmHF8Q2VYAlzTo8ICE2xgHv2LsMgO5W6SuI3MQ1CM6d1UBo0yNr5IC80ti4Hhq718pxA3wMB/rpNvQwKntHa+3/rjgpnoEKsnYh6j66AcSzlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YuVuEk7a; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-abbdf897503so137149666b.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 02:30:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740565801; x=1741170601; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=K9DD0fnDN/AtUagifRVVvBok4ZTdBpDaDU4p8Mda5rU=;
        b=YuVuEk7acAl28bF0ZnqOYk41BeKnuq85btntS/p2RHUFT2PgspWyiswMP6mOJw06mk
         lLFQejCfvZGuraUvFagVew39hgjjhybdjxrM7QzOXpVZIAjRNHDQshmW6OycT267dMTh
         s7teU6Y2EdoKmyXyjt2PJjGFbNxalPgJFGaGSB9Gqr6kp+PKYyXsDY0bKdCNMxHoWdcC
         Sh/HUNrvVDAIYYV4DRfabzYb+6QSkO01Bj9sqidQuL6FnbLDRlzOy8YMIg1iEzwkJpdU
         Xt6XRk8xhqT723QxN3Xz8VPPhK2eLjHJfH0XoyQqiT0Rp47sLGgW7MCUT6+4QIvnQosk
         FpTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740565801; x=1741170601;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K9DD0fnDN/AtUagifRVVvBok4ZTdBpDaDU4p8Mda5rU=;
        b=quJFohQmqb6GsiU6i/H40Pbp7+QfCE+m1Dy78N2lb0lcFMuqJjmT7PoH6qhxMf9KDy
         OGq58yBpugEqzgmWuT8kZeEzpkxE3d2qCoFORL1iEniS1WeW2gFKpmHeQDZUuDVp3Q5y
         qANV+yozV8BV8P59gch2Gwgaw6Ss2Wlti/3/6RAaHdN533wQRVsZLAD/HMP90ZPGPeQp
         9RmYXpTXK7P1Rrcint9Avn+FQiikfzpyLg7jT3KU/DStbexCLpIyvp+LhEP0nGBgyNIO
         LEti+DEUfkUqVebp9z+H2KxN7srZM5UuxrS5CaXuzQzWR3viMnjqpZhUpmHaPSag+wiG
         oOtg==
X-Forwarded-Encrypted: i=1; AJvYcCXH16XQ2ucVQWRTIjfWSIUnLJ5t1eypj2QDWjNUwqU3IoAkvYAsLU+mRjVOXB24D5khdk4geIBCvRINB7c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGkPMGgOQVYNn55MWffN5D5T56jHF+Zm1SQskQzrC41OV3QJqb
	+3Q5nWgw+MTc1JAUPfBlrJ7kDCGrT4Mc99Ul/CXd9GaIhByVfPjDcuaQjxAdQ7w=
X-Gm-Gg: ASbGncuyGXtjPthMt4udfSg2At5RZgvQixCjcgvCd8Hrpp1Q9q03cScA7jIEklGJdZi
	l16RsBtZAqinYdH5ZB0obLp0BKb+v4YS2Vyohn6dzEsBChyXxsD5Lw9d9T6Cd1wWa7WrZWqeN7O
	S5bg7igKpSNpIAyfyGk7l/8NFgoZVremJxlAo/80Ukw20OipPxgyTaFoTYqGTHJi8f4PEBJAJyJ
	iuFg8eOVSw+ISSTUbKihSwOJ2U5axMgoF3OeTozgcCuBDvJLJOXhOM3tjOfrdShES/jb2i+81y4
	kBf4USZPoBwlFelo2vQL9nuRwajGQCg=
X-Google-Smtp-Source: AGHT+IHr4uQ5R5/KWmLNlHHoe7q5Yn5WHDFYUfnRdWeKc0hVpBSxYaUpHUfPTVtbh9gcGuAG6MEifA==
X-Received: by 2002:a17:907:784f:b0:abb:b24d:c63e with SMTP id a640c23a62f3a-abc0ae910famr1773453866b.16.1740565801539;
        Wed, 26 Feb 2025 02:30:01 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-abed1d54a0dsm305559066b.50.2025.02.26.02.30.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 02:30:00 -0800 (PST)
Date: Wed, 26 Feb 2025 13:29:57 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Meghana Malladi <m-malladi@ti.com>
Cc: rogerq@kernel.org, danishanwar@ti.com, pabeni@redhat.com,
	kuba@kernel.org, edumazet@google.com, davem@davemloft.net,
	andrew+netdev@lunn.ch, bpf@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, u.kleine-koenig@baylibre.com,
	matthias.schiffer@ew.tq-group.com, schnelle@linux.ibm.com,
	diogo.ivo@siemens.com, glaroque@baylibre.com, macro@orcam.me.uk,
	john.fastabend@gmail.com, hawk@kernel.org, daniel@iogearbox.net,
	ast@kernel.org, srk@ti.com, Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH net-next v3 2/3] net: ti: icssg-prueth: introduce and use
 prueth_swdata struct for SWDATA
Message-ID: <41fbeb70-bf49-4751-b4ba-6b122a45233d@stanley.mountain>
References: <20250224110102.1528552-1-m-malladi@ti.com>
 <20250224110102.1528552-3-m-malladi@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224110102.1528552-3-m-malladi@ti.com>

On Mon, Feb 24, 2025 at 04:31:01PM +0530, Meghana Malladi wrote:
> From: Roger Quadros <rogerq@kernel.org>
> 
> We have different cases for SWDATA (skb, page, cmd, etc)
> so it is better to have a dedicated data structure for that.
> We can embed the type field inside the struct and use it
> to interpret the data in completion handlers.
> 
> Increase SWDATA size to 48 so we have some room to add
> more data if required.

What is the "SWDATA size"?  Where is that specified?  Is
that a variable or a define or the size of a struct or
what?

> 
> Signed-off-by: Roger Quadros <rogerq@kernel.org>
> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
> Signed-off-by: Meghana Malladi <m-malladi@ti.com>
> ---
> Changes since v2 (v3-v2):
> - Fix leaking tx descriptor in emac_tx_complete_packets()
> - Free rx descriptor if swdata type is not page in emac_rx_packet()
> - Revert back the size of PRUETH_NAV_SW_DATA_SIZE
> - Use build time check for prueth_swdata size
> - re-write prueth_swdata to have enum type as first member in the struct
> and prueth_data union embedded in the struct
> 
> All the above changes have been suggested by Roger Quadros <rogerq@kernel.org>
> 
>  drivers/net/ethernet/ti/icssg/icssg_common.c  | 52 +++++++++++++------
>  drivers/net/ethernet/ti/icssg/icssg_prueth.c  |  3 ++
>  drivers/net/ethernet/ti/icssg/icssg_prueth.h  | 16 ++++++
>  .../net/ethernet/ti/icssg/icssg_prueth_sr1.c  |  4 +-
>  4 files changed, 57 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/net/ethernet/ti/icssg/icssg_common.c b/drivers/net/ethernet/ti/icssg/icssg_common.c
> index acbb79ad8b0c..01eeabe83eff 100644
> --- a/drivers/net/ethernet/ti/icssg/icssg_common.c
> +++ b/drivers/net/ethernet/ti/icssg/icssg_common.c
> @@ -136,12 +136,12 @@ int emac_tx_complete_packets(struct prueth_emac *emac, int chn,
>  	struct net_device *ndev = emac->ndev;
>  	struct cppi5_host_desc_t *desc_tx;
>  	struct netdev_queue *netif_txq;
> +	struct prueth_swdata *swdata;
>  	struct prueth_tx_chn *tx_chn;
>  	unsigned int total_bytes = 0;
>  	struct sk_buff *skb;
>  	dma_addr_t desc_dma;
>  	int res, num_tx = 0;
> -	void **swdata;
>  
>  	tx_chn = &emac->tx_chns[chn];
>  
> @@ -163,12 +163,19 @@ int emac_tx_complete_packets(struct prueth_emac *emac, int chn,
>  		swdata = cppi5_hdesc_get_swdata(desc_tx);
>  
>  		/* was this command's TX complete? */
> -		if (emac->is_sr1 && *(swdata) == emac->cmd_data) {
> +		if (emac->is_sr1 && (void *)(swdata) == emac->cmd_data) {

I don't think this conversion is correct.  You still need to say:

		if (emac->is_sr1 && swdata->data.something == emac->cmd_data) {

Where something is probably "page".

regards,
dan carpenter

>  			prueth_xmit_free(tx_chn, desc_tx);
>  			continue;
>  		}
>  
> -		skb = *(swdata);
> +		if (swdata->type != PRUETH_SWDATA_SKB) {
> +			netdev_err(ndev, "tx_complete: invalid swdata type %d\n", swdata->type);
> +			prueth_xmit_free(tx_chn, desc_tx);
> +			budget++;
> +			continue;
> +		}


