Return-Path: <linux-kernel+bounces-267108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7597D940CA5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 10:59:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 223632855DC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 08:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D712F194087;
	Tue, 30 Jul 2024 08:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="pqzuGqUA"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA11193066
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 08:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722329947; cv=none; b=rqVskx+UFv5Q/7nbf1EeFDr7UMlciCpfytifPZzPoOVw71mHRkn/fYTZdQsiyInnRv5P6fx/yCVZD1YTRzg/Mt6aPVSmo06aizshR0PlFKnDuB1PzAQ/6b3ZzYazxLAxs0W4QD5nJWhF+AMNQY8P9sDpD6j1hNtireFYXB+gS58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722329947; c=relaxed/simple;
	bh=e4hGq0rPqSlVktLFo9Y499joBy960BuARH+yeJfcm5A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YyMWMOR57wrUAnWP4vPs3gqihuNn0MOoYExQ+RkuK9iCDNBAlow8+mrpKo+xAEAVarzMwBwr9lC9Xyhew5dH/qbGQZcwpA0a4E+BozSe7u+2+P7tckfx8U+2bj7sLnbT+uQetj26LZmQcCBd5L/Btno5xlpNOcL+JOuKw+DUYzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=pqzuGqUA; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-42812945633so25151235e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 01:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1722329943; x=1722934743; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+PyYxHAAjKY94HrEwTuVrgQc3+br0mLRkqh/sY77Zbs=;
        b=pqzuGqUAy0WGU1pBUB2MDsQjxnm6E5PjI9gp7x+yZpKga1CNaGyF5A1BV3sm/Cdt1c
         JDhCgwC4gSbjSva2mQc3qZAfmV0mx5mIy+buiYkP+QThcfOz6M5UNC7inhsN4eUnkj5d
         EkMr7DhIircQ1CqCqri6xp2s2mkYqTPay6GFk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722329943; x=1722934743;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+PyYxHAAjKY94HrEwTuVrgQc3+br0mLRkqh/sY77Zbs=;
        b=UD/x4tLtgSATUrijO8ltwjt/y5fyDSnQHtha1ZTIR9ZI81bYiwDP+t9vLQLFUedzPz
         rMSuoy2gMGQJXP5Qrdg+bWGiwEFdC3IdD1hTNp/YPOn3elntxgp0djTBFV6bFjUNgw9f
         xbdC9I7BVUwg21qJt5Aq8VkAajGO63/Ox+UbNFavNyDOMtvp11MKZDMs/TENABdW8G2x
         bOSxN6EoIpavlTBtVYHzAXkeoJ/CB9kQ9UwJtC4fkfplGFf8Udnn+icDxL1f8+ieeXrz
         +hS7fn4JM9cw0uKX1rcccFXm1ToeCsGdqIm0waIKYujFJr0cws4BkxcyqpSsGnJCl0C/
         Vi5A==
X-Forwarded-Encrypted: i=1; AJvYcCU0EFkJN9dhBwZVm/0TNcrcMKewQSFpygYuM+kx2wp2vFZaG/Pmrc8Np86dv0r1WH5wASPceAn8VvBlip5dJi02ccN4TdDUCU+urBmt
X-Gm-Message-State: AOJu0YxpMPsFSDC+FzwDTJBCEvQlJaV4BvZqIv6RoB30KjYFY54bYAtc
	tQ7ZMz8zJvopmKQsltw8CJMWcfohVnPAVwZD+sO3Grp4Vq9NcheQqGnpKx0VNug=
X-Google-Smtp-Source: AGHT+IF/ePhGnUz5oRY8da3ygbH+O32+pdLnV9wMLAT92Wkbz17fdqBPIg9jUaaUhazOspOKL0yp8Q==
X-Received: by 2002:a05:600c:1d9b:b0:426:5f7d:addc with SMTP id 5b1f17b1804b1-42811df6daamr52383965e9.37.1722329943453;
        Tue, 30 Jul 2024 01:59:03 -0700 (PDT)
Received: from LQ3V64L9R2 ([80.208.222.2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-428218a3934sm28986935e9.45.2024.07.30.01.59.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 01:59:03 -0700 (PDT)
Date: Tue, 30 Jul 2024 09:59:01 +0100
From: Joe Damato <jdamato@fastly.com>
To: Elad Yifee <eladwf@gmail.com>
Cc: Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>,
	Mark Lee <Mark-MC.Lee@mediatek.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Daniel Golle <daniel@makrotopia.org>
Subject: Re: [PATCH net-next v2 1/2] net: ethernet: mtk_eth_soc: use prefetch
 methods
Message-ID: <ZqirVSHTM42983Qr@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Elad Yifee <eladwf@gmail.com>, Felix Fietkau <nbd@nbd.name>,
	Sean Wang <sean.wang@mediatek.com>,
	Mark Lee <Mark-MC.Lee@mediatek.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Daniel Golle <daniel@makrotopia.org>
References: <20240729183038.1959-1-eladwf@gmail.com>
 <20240729183038.1959-2-eladwf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240729183038.1959-2-eladwf@gmail.com>

On Mon, Jul 29, 2024 at 09:29:54PM +0300, Elad Yifee wrote:
> Utilize kernel prefetch methods for faster cache line access.
> This change boosts driver performance,
> allowing the CPU to handle about 5% more packets/sec.
> 
> Signed-off-by: Elad Yifee <eladwf@gmail.com>
> ---
> Changes in v2:
> 	- use net_prefetchw as suggested by Joe Damato
> 	- add (NET_SKB_PAD + eth->ip_align) offset to prefetched data
> 	- use eth->ip_align instead of NET_IP_ALIGN as it could be 0,
> 	depending on the platform 
> ---
>  drivers/net/ethernet/mediatek/mtk_eth_soc.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> index 16ca427cf4c3..4d0052dbe3f4 100644
> --- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> +++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c

[...]

> @@ -2143,6 +2147,7 @@ static int mtk_poll_rx(struct napi_struct *napi, int budget,
>  			dma_unmap_single(eth->dma_dev, ((u64)trxd.rxd1 | addr64),
>  					 ring->buf_size, DMA_FROM_DEVICE);
>  
> +			net_prefetch(data + NET_SKB_PAD + eth->ip_align);
>  			skb = build_skb(data, ring->frag_size);
>  			if (unlikely(!skb)) {
>  				netdev->stats.rx_dropped++;
> @@ -2150,7 +2155,8 @@ static int mtk_poll_rx(struct napi_struct *napi, int budget,
>  				goto skip_rx;
>  			}
>  
> -			skb_reserve(skb, NET_SKB_PAD + NET_IP_ALIGN);
> +			net_prefetchw(skb->data);
> +			skb_reserve(skb, NET_SKB_PAD + eth->ip_align);

Based on the code in mtk_probe, I am guessing that only
MTK_SOC_MT7628 can DMA to unaligned addresses, because for
everything else eth->ip_align would be 0.

Is that right?

I am asking because the documentation in
Documentation/core-api/unaligned-memory-access.rst refers to the
case you mention, NET_IP_ALIGN = 0, suggesting that this is
intentional for performance reasons on powerpc:

  One notable exception here is powerpc which defines NET_IP_ALIGN to
  0 because DMA to unaligned addresses can be very expensive and dwarf
  the cost of unaligned loads.

It goes on to explain that some devices cannot DMA to unaligned
addresses and I assume that for your driver that is everything which
is not MTK_SOC_MT7628 ?

