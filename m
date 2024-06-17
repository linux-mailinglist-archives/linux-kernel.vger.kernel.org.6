Return-Path: <linux-kernel+bounces-217493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF70E90B2FC
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 16:56:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3444CB2926C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 13:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50FD316EB55;
	Mon, 17 Jun 2024 13:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S8cEi+yM"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E8816DC0C
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 13:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718630720; cv=none; b=PDWnpLO+T5EPalSaImzM0kR0dTXGsMHXnNX3nYBVyCfzvSwxH/TVlaJj/dUfIYrJ7LV29PmWDp0JWlZ1pIis0e1/W91mqvyOg3s2N5maIb2dFOgCxNGcOabgyFl3yjiR3GU2eZ0e6Slt5AKRRPxEngmWliYM5L1Nfi3Ej9RLb68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718630720; c=relaxed/simple;
	bh=e0Ai7S6YQSXLPsDKMzDQYJxDo/I6cDjDA6YZygp1mvE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eIfVrXy3d1juuTSgiGLgIqvDk3vZ5yMfHMc+glq7dOQwF02V6E0ood9gAoZuf3S2hxXodhoUbewvsGQv39a4CGy1oGHVlAXlKwFCHkOuk8t7g29FPN7FuzIIl6nXhK/9sAILZuqBVLfc9fvw3NyMtwM3Lo9kqh66xulZIuU/uCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S8cEi+yM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718630718;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/S3QsnopAU1g3EZ48Lr3+KF/tnwo0ee82bp6T2xhvDs=;
	b=S8cEi+yM5tXwym7NqL5eTO/Jv+nHAgZlp2YvsMeg9hzOp8MIleVnq8ktsbPVPJA18ZeDGF
	Ufad7CE2IqJi63khIvGjbuiMGuMtVUK6jr8qb/8BPRSuBOwGjp+OlAw07wgml5djVLxO/n
	cIUzd1DYZAmUlCjjiKG0BZDiCyJ8zMw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-363-BlJk37XOOUOIThFzWWXb7g-1; Mon, 17 Jun 2024 09:25:16 -0400
X-MC-Unique: BlJk37XOOUOIThFzWWXb7g-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3608fb58acaso1135762f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 06:25:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718630715; x=1719235515;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/S3QsnopAU1g3EZ48Lr3+KF/tnwo0ee82bp6T2xhvDs=;
        b=b5M7XvR/6BCn/l4OoxqtWQsPZg24HYxQVfcF634Jb8g/f15Hoa49+/xB07J72qNUpq
         /vYWxmSwGnfOaouuItS+S8suN3Ag9anZ2ltmjQ/yT08fUvtaogUxkKS5/1K5jelnqvBq
         mV2yLFiOoyhm39bAbt+un0w9OeRbMRBoBFra87J9WzjhiDNypyyTFLr0bxvzXFFUfd+4
         i8KO84i1mjyLndCIvfc9k80YzNcuBk+RIZQComt+tAvpOQo/0Rj5nSdiUvSQVJyCoe8i
         nMIUDfy+sqIguXgWlws/hLEEn0K2ImbJvfbFwaKx90JR0BeWWBpf9AMKU56jF38GMOr5
         xGHw==
X-Forwarded-Encrypted: i=1; AJvYcCWryMoNILbURfIjw5tZ/x1qyQeVvDOBLHyFfQDkOWC/RV+r4H5XE/0HM3LFHtV7tqxW+HRoDsheLrJdZ0YllgjoCH9aq4SkIK2fAs+G
X-Gm-Message-State: AOJu0YzctaM7lNpYZh3DbahfG1S+fHpr08BYP0bkwoGke2h3OjTV0dIk
	JDnRdLsRdAMuT2pRNLoNXLUSXNTSbcPveNDaqoFSayQkHXLtL7FvW5hHe07sM4Xepby2sU4iMB2
	wuqNge93cq2cP+vC+ebwii8qO0GYIexawr2VuQSYbYAg3RGYLgh68uUI2dEIIpg==
X-Received: by 2002:adf:e850:0:b0:35f:204c:889f with SMTP id ffacd0b85a97d-3607a7833b0mr8786835f8f.56.1718630715268;
        Mon, 17 Jun 2024 06:25:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE5RKQQn0KRZhLjfi6KZQa3K/TTM2W1cxHcRKnOc2A/u+LNZscYxGxayZdx96GzT+RJtL3BLQ==
X-Received: by 2002:adf:e850:0:b0:35f:204c:889f with SMTP id ffacd0b85a97d-3607a7833b0mr8786801f8f.56.1718630714671;
        Mon, 17 Jun 2024 06:25:14 -0700 (PDT)
Received: from redhat.com ([2a06:c701:7439:b500:58cc:2220:93ce:7c4a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3607509353csm11912155f8f.22.2024.06.17.06.25.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 06:25:13 -0700 (PDT)
Date: Mon, 17 Jun 2024 09:25:10 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Abhinav Jain <jain.abhinav177@gmail.com>
Cc: jasowang@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org, javier.carrasco.cruz@gmail.com
Subject: Re: [PATCH] virtio_net: Eliminate OOO packets during switching
Message-ID: <20240617091919-mutt-send-email-mst@kernel.org>
References: <20240614220422.42733-1-jain.abhinav177@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240614220422.42733-1-jain.abhinav177@gmail.com>

On Fri, Jun 14, 2024 at 10:04:22PM +0000, Abhinav Jain wrote:
> Disable the network device & turn off carrier before modifying the
> number of queue pairs.
> Process all the in-flight packets and then turn on carrier, followed
> by waking up all the queues on the network device.

Did you test that there's a workload with OOO and
this patch actually prevents that?

> 
> Signed-off-by: Abhinav Jain <jain.abhinav177@gmail.com>


> ---
>  drivers/net/virtio_net.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 61a57d134544..d0a655a3b4c6 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -3447,7 +3447,6 @@ static void virtnet_get_drvinfo(struct net_device *dev,
>  
>  }
>  
> -/* TODO: Eliminate OOO packets during switching */
>  static int virtnet_set_channels(struct net_device *dev,
>  				struct ethtool_channels *channels)
>  {
> @@ -3471,6 +3470,15 @@ static int virtnet_set_channels(struct net_device *dev,
>  	if (vi->rq[0].xdp_prog)
>  		return -EINVAL;
>  
> +	/* Disable network device to prevent packet processing during
> +	 * the switch.
> +	 */
> +	netif_tx_disable(dev);
> +	netif_carrier_off(dev);

Won't turning off carrier cause a lot of damage such as
changing IP and so on?

> +
> +	/* Make certain that all in-flight packets are processed. */
> +	synchronize_net();
> +

The comment seems to say what the code does not do.


Also, doing this under rtnl is a heavy weight operation.



>  	cpus_read_lock();
>  	err = virtnet_set_queues(vi, queue_pairs);
>  	if (err) {
> @@ -3482,7 +3490,12 @@ static int virtnet_set_channels(struct net_device *dev,
>  
>  	netif_set_real_num_tx_queues(dev, queue_pairs);
>  	netif_set_real_num_rx_queues(dev, queue_pairs);
> - err:
> +
> +	/* Restart the network device */
> +	netif_carrier_on(dev);
> +	netif_tx_wake_all_queues(dev);
> +
> +err:
>  	return err;
>  }
>  



Given the result is, presumably, improved performance with less
packet loss due to OOO, I'd like to see some actual testing results,
hopefully also measuring the effect on CPU load.




> -- 
> 2.34.1


