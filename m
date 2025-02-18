Return-Path: <linux-kernel+bounces-518915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3543A3962B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 09:55:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3ADE16CD4B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 08:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9410C22CBF7;
	Tue, 18 Feb 2025 08:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fxWcVAqC"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 377B8188580
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 08:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739868594; cv=none; b=Uq7q6bhxNzguFfLk1hYy/wC11F9cRawAsXtBmNUNZgWSrwbHZNnkd2eV9I+ESHO7rxXhUboA+AnRLPl9owJ2UdhtB9ccSMrgkoxHRQzvn68/DmgXxmgI0PF4lNxoZjxa22U7HKfeQGY6HbBV/89D0XgYPptfWq0/qzcZm9F28og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739868594; c=relaxed/simple;
	bh=dXoEOkK2zL7ZpgMh1uya9jJKqyfmFRh3MsQ3mafOb6g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PKL6jHJUyE2z+VbgYBxQDL/n4A0xwbwZig6IE7Up5QWUdPGXNk+1CwQkxQ3ePPrAy1pSRTAWxdTaj5zG6z4X2d4PHk8tZE7xsqK5v8dKys5ViO84Uq6DMvD+6dQOcx6V8JUtAUidnDIbcB1jU7bQxfDv7CTjuvzcWGv8LuLu0ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fxWcVAqC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739868592;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r2LzTC5dXVKNPAth+Ux9LT9Nh8e/89qeI4vDz/bFUhw=;
	b=fxWcVAqCOKGaOkXXMLtv5SyfEAxLfDGBCG1BS2MOapDW9gJCrf1KUULWBbb5IEMx+mY1rU
	mjuZEsAYOSq5IHgzhUmJcdrqbgL87G04Ulb3De2f5lGq3knHjIfKq0HkukF5OMVUYl8bz2
	+QjJ1CizI5g2c2kV8UNxG8jtxP03Enk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-327-e4CAK4MmOpeELbXRzJRuYQ-1; Tue, 18 Feb 2025 03:49:50 -0500
X-MC-Unique: e4CAK4MmOpeELbXRzJRuYQ-1
X-Mimecast-MFC-AGG-ID: e4CAK4MmOpeELbXRzJRuYQ_1739868589
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43995bff469so1922075e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 00:49:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739868589; x=1740473389;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r2LzTC5dXVKNPAth+Ux9LT9Nh8e/89qeI4vDz/bFUhw=;
        b=NCNSnYgCmCJmFoShCsu64fBgyfNukV1yn50lNatqQQKU/FKAI8t1rfMHNznKGfy21O
         yhAgAd2zFokNHJtNyQiwh5rCKP+9X01pnABgHlR+b66KXMj2LtlZj5eSpvUAazgPH3yb
         WGwux+J3Hn3Kke4lXKBJC2Zv8eRE8xyu0eIuKGqtm69BZbNi1SOrni6Q4uCm33kNn/bw
         Nq/EfBjZVouYPMnG9HQvvE4FEM8VsKJBDkemoFNf5cWv4XpKHSyrZgS/ikLbGHTZ5ahT
         5sRCvCsVTyY3dyZYlqgWA0yBw4PA2oTDj+GVeL0un8J8pZxpXhdTVu0dyZM7MvJyfLH0
         u4Jg==
X-Forwarded-Encrypted: i=1; AJvYcCUFtEHr3vLsjEbpQdaDXSNzb7rLZcOGqrlkpLFZXuldkYSl7VZJDzwumxpr9TLEtJxjJ+RS1J3A0sd7rww=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4Q0hD8DqG8ZyM7gyfVU2nDiMyAiitOIB9pfQYJ3QAb+i0+2Uk
	gbs2XmQDRDHgZkzYykFJKVpzRHDXRrOpTay3oC5hm1bivO5miw+DMEI41mWj3N9VjLXc3irBa+t
	oZ0Ip6dENUAiP1nkmKiwDOVfuzXFDjC6iCIte3H8OEIcaOT8+o2n8aEuLDYMS5g==
X-Gm-Gg: ASbGnctPIDcJAaYKcye3hHplN0lHS8nriYil4UoFycmAmk5Xy0nA9fkZlJwdxFB83iV
	eecdRbBzZPJqPoOWEzOf9vh+4EUDQ4fWZA/RQ3QcNcbB/quRmQJ2PwCGAL6bW+lMn6+duIPVeWg
	8z4COLcMK2Hh0U48qZfFTgD02LIIAXm/157V+jCxxwmlBgsAU+cX62gh0vnKjUDPVMHy4YyjKia
	cqAZFOVsdCBLHzt05TPDHipkNqYnji17f2OC/Cr4K/NQdqzpAVI+BWDbBFj4oDoowONb2w=
X-Received: by 2002:a05:600c:1d26:b0:439:6a40:4860 with SMTP id 5b1f17b1804b1-4396e75cea1mr107159305e9.28.1739868588915;
        Tue, 18 Feb 2025 00:49:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEwjS+nR/wHh1APBF9u+K9/mt1qqaSj+MqVMyzeTqVCHDHhclsydu5xCXA8WU4A9dOyCXmxgQ==
X-Received: by 2002:a05:600c:1d26:b0:439:6a40:4860 with SMTP id 5b1f17b1804b1-4396e75cea1mr107159005e9.28.1739868588502;
        Tue, 18 Feb 2025 00:49:48 -0800 (PST)
Received: from redhat.com ([2a02:14f:1f5:7ef9:8f0d:a8:10c1:4db])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4395a1b84bcsm181214165e9.40.2025.02.18.00.49.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 00:49:47 -0800 (PST)
Date: Tue, 18 Feb 2025 03:49:43 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] virtio-net: tweak for better TX performance in
 NAPI mode
Message-ID: <20250218034919-mutt-send-email-mst@kernel.org>
References: <20250218023908.1755-1-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250218023908.1755-1-jasowang@redhat.com>

On Tue, Feb 18, 2025 at 10:39:08AM +0800, Jason Wang wrote:
> There are several issues existed in start_xmit():
> 
> - Transmitted packets need to be freed before sending a packet, this
>   introduces delay and increases the average packets transmit
>   time. This also increase the time that spent in holding the TX lock.
> - Notification is enabled after free_old_xmit_skbs() which will
>   introduce unnecessary interrupts if TX notification happens on the
>   same CPU that is doing the transmission now (actually, virtio-net
>   driver are optimized for this case).
> 
> So this patch tries to avoid those issues by not cleaning transmitted
> packets in start_xmit() when TX NAPI is enabled and disable
> notifications even more aggressively. Notification will be since the
> beginning of the start_xmit(). But we can't enable delayed
> notification after TX is stopped as we will lose the
> notifications. Instead, the delayed notification needs is enabled
> after the virtqueue is kicked for best performance.
> 
> Performance numbers:
> 
> 1) single queue 2 vcpus guest with pktgen_sample03_burst_single_flow.sh
>    (burst 256) + testpmd (rxonly) on the host:
> 
> - When pinning TX IRQ to pktgen VCPU: split virtqueue PPS were
>   increased 55% from 6.89 Mpps to 10.7 Mpps and 32% TX interrupts were
>   eliminated. Packed virtqueue PPS were increased 50% from 7.09 Mpps to
>   10.7 Mpps, 99% TX interrupts were eliminated.
> 
> - When pinning TX IRQ to VCPU other than pktgen: split virtqueue PPS
>   were increased 96% from 5.29 Mpps to 10.4 Mpps and 45% TX interrupts
>   were eliminated; Packed virtqueue PPS were increased 78% from 6.12
>   Mpps to 10.9 Mpps and 99% TX interrupts were eliminated.
> 
> 2) single queue 1 vcpu guest + vhost-net/TAP on the host: single
>    session netperf from guest to host shows 82% improvement from
>    31Gb/s to 58Gb/s, %stddev were reduced from 34.5% to 1.9% and 88%
>    of TX interrupts were eliminated.
> 
> Signed-off-by: Jason Wang <jasowang@redhat.com>

can you pls also test perf with tx irq disabled mode, to be sure?

> ---
>  drivers/net/virtio_net.c | 45 ++++++++++++++++++++++++++++------------
>  1 file changed, 32 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 7646ddd9bef7..ac26a6201c44 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -1088,11 +1088,10 @@ static bool is_xdp_raw_buffer_queue(struct virtnet_info *vi, int q)
>  		return false;
>  }
>  
> -static void check_sq_full_and_disable(struct virtnet_info *vi,
> -				      struct net_device *dev,
> -				      struct send_queue *sq)
> +static bool tx_may_stop(struct virtnet_info *vi,
> +			struct net_device *dev,
> +			struct send_queue *sq)
>  {
> -	bool use_napi = sq->napi.weight;
>  	int qnum;
>  
>  	qnum = sq - vi->sq;
> @@ -1114,6 +1113,25 @@ static void check_sq_full_and_disable(struct virtnet_info *vi,
>  		u64_stats_update_begin(&sq->stats.syncp);
>  		u64_stats_inc(&sq->stats.stop);
>  		u64_stats_update_end(&sq->stats.syncp);
> +
> +		return true;
> +	}
> +
> +	return false;
> +}
> +
> +static void check_sq_full_and_disable(struct virtnet_info *vi,
> +				      struct net_device *dev,
> +				      struct send_queue *sq)
> +{
> +	bool use_napi = sq->napi.weight;
> +	int qnum;
> +
> +	qnum = sq - vi->sq;
> +
> +	if (tx_may_stop(vi, dev, sq)) {
> +		struct netdev_queue *txq = netdev_get_tx_queue(dev, qnum);
> +
>  		if (use_napi) {
>  			if (unlikely(!virtqueue_enable_cb_delayed(sq->vq)))
>  				virtqueue_napi_schedule(&sq->napi, sq->vq);
> @@ -3253,15 +3271,10 @@ static netdev_tx_t start_xmit(struct sk_buff *skb, struct net_device *dev)
>  	bool use_napi = sq->napi.weight;
>  	bool kick;
>  
> -	/* Free up any pending old buffers before queueing new ones. */
> -	do {
> -		if (use_napi)
> -			virtqueue_disable_cb(sq->vq);
> -
> +	if (!use_napi)
>  		free_old_xmit(sq, txq, false);
> -
> -	} while (use_napi && !xmit_more &&
> -	       unlikely(!virtqueue_enable_cb_delayed(sq->vq)));
> +	else
> +		virtqueue_disable_cb(sq->vq);
>  
>  	/* timestamp packet in software */
>  	skb_tx_timestamp(skb);
> @@ -3287,7 +3300,10 @@ static netdev_tx_t start_xmit(struct sk_buff *skb, struct net_device *dev)
>  		nf_reset_ct(skb);
>  	}
>  
> -	check_sq_full_and_disable(vi, dev, sq);
> +	if (use_napi)
> +		tx_may_stop(vi, dev, sq);
> +	else
> +		check_sq_full_and_disable(vi, dev,sq);
>  
>  	kick = use_napi ? __netdev_tx_sent_queue(txq, skb->len, xmit_more) :
>  			  !xmit_more || netif_xmit_stopped(txq);
> @@ -3299,6 +3315,9 @@ static netdev_tx_t start_xmit(struct sk_buff *skb, struct net_device *dev)
>  		}
>  	}
>  
> +	if (use_napi && kick && unlikely(!virtqueue_enable_cb_delayed(sq->vq)))
> +		virtqueue_napi_schedule(&sq->napi, sq->vq);
> +
>  	return NETDEV_TX_OK;
>  }
>  
> -- 
> 2.34.1


