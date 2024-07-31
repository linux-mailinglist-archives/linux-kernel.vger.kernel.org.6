Return-Path: <linux-kernel+bounces-269268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E1A1942FFE
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 15:24:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 617B61C212F9
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 13:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 747781B14E0;
	Wed, 31 Jul 2024 13:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="M6rvquAf"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D968B1DA32
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 13:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722432238; cv=none; b=Yut55nkFPiGPF2OkU3VNQVEvM6ohNlh3uniQrZCwquVxDRLywGrmpJRMtfGaJpeePDwNWa/xgQexsWJ+atXXpKMdtvO2pJvOQLUakwGqPbNh3uR3P608XgAXp4azZA40gsdMqaWDGyLTa5RBbxhu1zjUUuhtVsicuLCBiSyVOvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722432238; c=relaxed/simple;
	bh=dZ3cPRkQJDhvVUvQbEDDy+pIzhXBVeFQfxuxPcEGpVQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S/SH+RobnoGBT0VGd6f9PPq61Eas187qiZWm5Dg1RMgu5XowHwIedJKmBimZFtt8lP6pyPpBkNL1zulkHTztqXN6AAzaXEvrtHkBK7bOLpctzTl2xqnAqOyRusCS6qPmMmWezkV/ZZzFQIAaXto/LM2SrbLM+WQ4svn+bY7MShg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=M6rvquAf; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42816ca797fso32635075e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 06:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1722432235; x=1723037035; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DU4o0euvC+HWsoAf11FMxnSBNfbFYWAJlqOVN7iHABM=;
        b=M6rvquAf0CqVsrpLDEY9nYsU0Uxd8W+NxGKj/I5fPuPehtu7WvaO6jpE4cxnU+W5op
         GAEezCTrlAGyDAcnLwDxRQETfz/5c28yIa3uvgmRmoDDBuGGv7GPf3wYFnlw27lfU7Kt
         ejdDyypn9Rutb/uggu30ElVxF0gPJ5JHP6pRA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722432235; x=1723037035;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DU4o0euvC+HWsoAf11FMxnSBNfbFYWAJlqOVN7iHABM=;
        b=pTQGbj4YpJX2c2Wd4k+zH59yWel0LJh8ET/dTwdqYDQ+4AZBkC0XwamKxQfXm1UqNy
         op2g7VsceOfUHI7Tj9yNAHhAJxnk7KGrrNvoYxX9g8/zDmAP9NnagtialzYs2tjbJZ8G
         pmhb46oPERtLhiFduylUoOYvQ7TaNSITPzl9wJxWUr58qKl2LxMewQX0hwIzh5WyHsew
         Zb+p3j0vAwUPyhhm9d3QHFAvwPpfmKb2avJkPO6QP9GhnEC8UnCS0VP6rXLa1/4hDoze
         IA5scbMGcShaBZ0Mc/F8onj0wPH9qHHwY2C/cU6YI1blg9HyWcu5whM1oh4uBnvc0WMM
         891A==
X-Forwarded-Encrypted: i=1; AJvYcCVOKgms+jfXmwh6wZ2IBk791lLqgP24EFbGflGyBKWXkp5Y5Bwo3GpADuvRdG422fQtkGLWrE0ny1QK0/cjIxALeahHKF/Q+zOrjx1v
X-Gm-Message-State: AOJu0Yw3xvZVrJYg3upPWeL9xDTb6ey4+jKyV9Fx+kapPOY2rhPiM90q
	WuaTM/ybQDBQAdmsbnO0tcT/dHj55VjZNWCz1u3pqits3sJxJPr7egpbgCIjjws=
X-Google-Smtp-Source: AGHT+IHVdCdyn2EEFW3yGK/wy+d9N14iTs2K4LyqriYoeS4eQvQdRNDZKpRe3nxdaLsbcMG17hgDLg==
X-Received: by 2002:a05:600c:5124:b0:426:62c5:473e with SMTP id 5b1f17b1804b1-42811dd486dmr97165355e9.26.1722432235131;
        Wed, 31 Jul 2024 06:23:55 -0700 (PDT)
Received: from LQ3V64L9R2 ([80.208.222.2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4282bafc596sm21018755e9.39.2024.07.31.06.23.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 06:23:54 -0700 (PDT)
Date: Wed, 31 Jul 2024 14:23:53 +0100
From: Joe Damato <jdamato@fastly.com>
To: Jijie Shao <shaojijie@huawei.com>
Cc: yisen.zhuang@huawei.com, salil.mehta@huawei.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, shenjian15@huawei.com, wangpeiyang1@huawei.com,
	liuyonglong@huawei.com, sudongming1@huawei.com,
	xujunsheng@huawei.com, shiyongbang@huawei.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH net-next 07/10] net: hibmcge: Implement rx_poll
 function to receive packets
Message-ID: <Zqo66ZPaD2GtLZwg@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jijie Shao <shaojijie@huawei.com>, yisen.zhuang@huawei.com,
	salil.mehta@huawei.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	shenjian15@huawei.com, wangpeiyang1@huawei.com,
	liuyonglong@huawei.com, sudongming1@huawei.com,
	xujunsheng@huawei.com, shiyongbang@huawei.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240731094245.1967834-1-shaojijie@huawei.com>
 <20240731094245.1967834-8-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240731094245.1967834-8-shaojijie@huawei.com>

On Wed, Jul 31, 2024 at 05:42:42PM +0800, Jijie Shao wrote:
> Implement rx_poll function to read the rx descriptor after
> receiving the rx interrupt. Adjust the skb based on the
> descriptor to complete the reception of the packet.
> 
> Signed-off-by: Jijie Shao <shaojijie@huawei.com>
> ---
>  .../ethernet/hisilicon/hibmcge/hbg_common.h   |   5 +
>  .../net/ethernet/hisilicon/hibmcge/hbg_hw.c   |  10 ++
>  .../net/ethernet/hisilicon/hibmcge/hbg_hw.h   |   1 +
>  .../net/ethernet/hisilicon/hibmcge/hbg_irq.c  |   9 +-
>  .../net/ethernet/hisilicon/hibmcge/hbg_main.c |   2 +
>  .../net/ethernet/hisilicon/hibmcge/hbg_reg.h  |   2 +
>  .../hisilicon/hibmcge/hbg_reg_union.h         |  65 ++++++++
>  .../net/ethernet/hisilicon/hibmcge/hbg_txrx.c | 157 +++++++++++++++++-
>  8 files changed, 248 insertions(+), 3 deletions(-)
 
> diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c
> index 8efeea9b0c26..bb5f8321da8a 100644
> --- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c
> +++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c
> @@ -36,6 +36,7 @@ static int hbg_net_open(struct net_device *dev)
>  		return 0;
>  
>  	netif_carrier_off(dev);
> +	napi_enable(&priv->rx_ring.napi);
>  	napi_enable(&priv->tx_ring.napi);
>  	hbg_enable_intr(priv, true);
>  	hbg_hw_mac_enable(priv, HBG_STATUS_ENABLE);

In the future, it might be good to consider using:
   - netif_napi_set_irq
   - netif_queue_set_napi
 
to link NAPIs with IRQs and queues.

For an example, see 64b62146ba9e ("net/mlx4: link NAPI instances to
queues and IRQs).

[...]

> +static int hbg_rx_fill_buffers(struct hbg_priv *priv)
> +{
> +	struct hbg_ring *ring = &priv->rx_ring;
> +	int ret;
> +
> +	while (!(hbg_fifo_is_full(priv, ring->dir) ||
> +		 hbg_queue_is_full(ring->ntc, ring->ntu, ring))) {
> +		ret = hbg_rx_fill_one_buffer(priv);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static bool hbg_sync_data_from_hw(struct hbg_priv *priv,
> +				  struct hbg_buffer *buffer)
> +{
> +	struct hbg_rx_desc *rx_desc;
> +
> +	/* make sure HW write desc complete */
> +	dma_rmb();
> +
> +	dma_sync_single_for_cpu(&priv->pdev->dev, buffer->skb_dma,
> +				buffer->skb_len, DMA_FROM_DEVICE);
> +
> +	rx_desc = (struct hbg_rx_desc *)buffer->skb->data;
> +	return rx_desc->len != 0;
> +}

Have you looked into using the page pool to simplify some of the
logic above?

> +static int hbg_napi_rx_poll(struct napi_struct *napi, int budget)
> +{
> +	struct hbg_ring *ring = container_of(napi, struct hbg_ring, napi);
> +	struct hbg_priv *priv = ring->priv;
> +	struct hbg_rx_desc *rx_desc;
> +	struct hbg_buffer *buffer;
> +	u32 packet_done = 0;
> +
> +	if (unlikely(!hbg_nic_is_open(priv))) {
> +		napi_complete(napi);
> +		return 0;
> +	}
> +
> +	while (packet_done < budget) {
> +		if (unlikely(hbg_queue_is_empty(ring->ntc, ring->ntu)))
> +			break;
> +
> +		buffer = &ring->queue[ring->ntc];
> +		if (unlikely(!buffer->skb))
> +			goto next_buffer;
> +
> +		if (unlikely(!hbg_sync_data_from_hw(priv, buffer)))
> +			break;
> +
> +		hbg_dma_unmap(buffer);
> +
> +		rx_desc = (struct hbg_rx_desc *)buffer->skb->data;
> +		skb_reserve(buffer->skb, HBG_PACKET_HEAD_SIZE + NET_IP_ALIGN);
> +		skb_put(buffer->skb, rx_desc->len);
> +		buffer->skb->protocol = eth_type_trans(buffer->skb, priv->netdev);
> +
> +		priv->netdev->stats.rx_bytes += rx_desc->len;
> +		priv->netdev->stats.rx_packets++;
> +		netif_receive_skb(buffer->skb);

Any reason why not napi_gro_receive ?

> +		buffer->skb = NULL;
> +		hbg_rx_fill_one_buffer(priv);
> +
> +next_buffer:
> +		hbg_queue_move_next(ntc, ring);
> +		packet_done++;
> +	}
> +
> +	hbg_rx_fill_buffers(priv);
> +	if (packet_done >= budget)
> +		return packet_done;
> +
> +	napi_complete(napi);

Maybe:

   if (napi_complete_done(napi))
     hbg_irq_enable(priv, HBG_IRQ_RX, true);

> +	hbg_irq_enable(priv, HBG_IRQ_RX, true);
> +
> +	return packet_done;
> +}

[...]

