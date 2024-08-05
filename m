Return-Path: <linux-kernel+bounces-274199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AE9F29474E2
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 07:53:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B723B20A83
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 05:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2B29143C50;
	Mon,  5 Aug 2024 05:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pl6/TGPV"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FFB91448EF
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 05:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722837154; cv=none; b=smxqodZu42UvfclzZZeDpsVCrBJ8ky3ASzVSJffwyZcwf76c8YMPQ9i3TKZDw0OkLLFKfugxjVgDzJsJfLUKdtSk2g1QmjRuen/wRYux1KDhD3JIVxyOyRXlpYyDXKlYQKg/Unv11KX0Ryzhs4NRrS73bQmH+tGD4cy/frHTZ5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722837154; c=relaxed/simple;
	bh=D4mZImU22arsEREEh+abHrXNb7bqP3pmKWJaqmOKv8A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dxSFV4hb4oDL5PRsxhLOUxjfu+6py8+51cUYB1WYaRNLKeh3fz+5epm3rIE2CpvUxcjc13yiNOczbSbcF6uBONNO1MjZtNI16AQE2mfEQ9rwOTI/flKFSQpmG5/S8hd4/ugv4CpMchpO4kTi3sGU73R9IfsZ1CLSr5MlarqIGaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Pl6/TGPV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722837151;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yY3ZlmNQoxZJfnobrEKSrd91AZgKABUVpX64d54Ifn0=;
	b=Pl6/TGPV4KmCkD2MAMyNKrsXvoMjILXnbTs1QFxyNlCF8+Vu5zwY0TwgNtAW6xmaIKPsUG
	pNv40E2OWeup76CL92OW1HGdpuuV8EGOZdY66Qj6PteuFypUul4uSJplhigKVIYtONzvYH
	C46bfH6/Fx49gIawL7ijVtv3fhu6NtI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-282-W6AOjnxKOqOQzSs99iRLuQ-1; Mon, 05 Aug 2024 01:52:30 -0400
X-MC-Unique: W6AOjnxKOqOQzSs99iRLuQ-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-368665a3fdfso5226703f8f.1
        for <linux-kernel@vger.kernel.org>; Sun, 04 Aug 2024 22:52:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722837149; x=1723441949;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yY3ZlmNQoxZJfnobrEKSrd91AZgKABUVpX64d54Ifn0=;
        b=ixW8Zb/z2XieY0jsOU9KEYqsjls0vPJiy0Igdujh2ScJ9SEpHJl7REk/jNxiGUFPmL
         pWAdLLO2ME/Fi7h+bjKFqZ0cOuOmRYmomFYV79D3rMZ5DvzwwF/2NFNzuKDh1+aACYUB
         vN4e7ffhaohi62HJB4po+n0gzWEHF8xp35tmHlOnHFvD/RN5BxN4eTFAw6qmZG9l4XBB
         lgCWPQ45BcHwjeCovJ+Bc1SbNT3/YpE+DGEMsZpEcd4kSHGJKTkZYADwaSyf50JbW+jW
         /mGiajWThqxIljY2sqr77UUGqhI/whLn9pYjc1QvjBEoTHIBovOO+dCNjez3RpemuIvb
         MRIA==
X-Forwarded-Encrypted: i=1; AJvYcCXgMSHXyjefMQ4f/KgOlC4XbR6fYsdGtBD6jbtYpWS65b4FIsAfU7dhjFIrUFAo77z39TmbKYWCeyyh6qMPJCb5Xlo1YpPEIHTzi8mV
X-Gm-Message-State: AOJu0YxDO1tXSvpq9IETK4pJ6+YS6a4uADFMvWsxOIOWWfvcsYMpPwm9
	gucIJpIqYLEY6cP0UJ8Nl7kPdfVdTO3RumFnHnooJ+SyMc9DnTLaV29oCO+cwT2dZCfHDUy+MX7
	1D6NkbGqvBU6g72SpPWIybHEetXD3kfLDhzpcyPRxXV6XXptx4nvCURFVM/g2VQ==
X-Received: by 2002:adf:f18a:0:b0:362:4ce:2171 with SMTP id ffacd0b85a97d-36bbc1657f1mr6624197f8f.52.1722837148680;
        Sun, 04 Aug 2024 22:52:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFEkym7lde2/Fw8MPIUxZ0ooZX0XQmN1ihWR9EClWvK4Q2zQn1BAchxK9PqJ2C/S7CY9LK4Pw==
X-Received: by 2002:adf:f18a:0:b0:362:4ce:2171 with SMTP id ffacd0b85a97d-36bbc1657f1mr6624175f8f.52.1722837147834;
        Sun, 04 Aug 2024 22:52:27 -0700 (PDT)
Received: from redhat.com ([2a02:14f:17d:dd95:f049:da1a:7ecb:6d9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-428e6e03d74sm121895045e9.14.2024.08.04.22.52.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Aug 2024 22:52:27 -0700 (PDT)
Date: Mon, 5 Aug 2024 01:52:22 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Venkat Venkatsubra <venkat.x.venkatsubra@oracle.com>,
	Gia-Khanh Nguyen <gia-khanh.nguyen@oracle.com>
Subject: Re: [PATCH V5 net-next 3/3] virtio-net: synchronize operstate with
 admin state on up/down
Message-ID: <20240805014422-mutt-send-email-mst@kernel.org>
References: <20240805030242.62390-1-jasowang@redhat.com>
 <20240805030242.62390-4-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240805030242.62390-4-jasowang@redhat.com>

On Mon, Aug 05, 2024 at 11:02:42AM +0800, Jason Wang wrote:
> This patch synchronize operstate with admin state per RFC2863.


synchronizes

> 
> This is done by trying to toggle the carrier upon open/close and
> synchronize with the config change work. This allows propagate status

to propagate

> correctly to stacked devices like:
> 
> ip link add link enp0s3 macvlan0 type macvlan
> ip link set link enp0s3 down
> ip link show
> 
> Before this patch:
> 
> 3: enp0s3: <BROADCAST,MULTICAST> mtu 1500 qdisc pfifo_fast state DOWN mode DEFAULT group default qlen 1000
>     link/ether 00:00:05:00:00:09 brd ff:ff:ff:ff:ff:ff
> ......
> 5: macvlan0@enp0s3: <BROADCAST,MULTICAST,UP,LOWER_UP,M-DOWN> mtu 1500 qdisc noqueue state UP mode DEFAULT group default qlen 1000
>     link/ether b2:a9:c5:04:da:53 brd ff:ff:ff:ff:ff:ff
> 
> After this patch:
> 
> 3: enp0s3: <BROADCAST,MULTICAST> mtu 1500 qdisc pfifo_fast state DOWN mode DEFAULT group default qlen 1000
>     link/ether 00:00:05:00:00:09 brd ff:ff:ff:ff:ff:ff
> ...
> 5: macvlan0@enp0s3: <NO-CARRIER,BROADCAST,MULTICAST,UP,M-DOWN> mtu 1500 qdisc noqueue state LOWERLAYERDOWN mode DEFAULT group default qlen 1000
>     link/ether b2:a9:c5:04:da:53 brd ff:ff:ff:ff:ff:ff

Add an empty line here pls.

> Cc: Venkat Venkatsubra <venkat.x.venkatsubra@oracle.com>
> Cc: Gia-Khanh Nguyen <gia-khanh.nguyen@oracle.com>
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/net/virtio_net.c | 78 +++++++++++++++++++++++++---------------
>  1 file changed, 50 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 0383a3e136d6..fc5196ca8d51 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -2885,6 +2885,25 @@ static void virtnet_cancel_dim(struct virtnet_info *vi, struct dim *dim)
>  	net_dim_work_cancel(dim);
>  }
>  
> +static void virtnet_update_settings(struct virtnet_info *vi)
> +{
> +	u32 speed;
> +	u8 duplex;
> +
> +	if (!virtio_has_feature(vi->vdev, VIRTIO_NET_F_SPEED_DUPLEX))
> +		return;
> +
> +	virtio_cread_le(vi->vdev, struct virtio_net_config, speed, &speed);
> +
> +	if (ethtool_validate_speed(speed))
> +		vi->speed = speed;
> +
> +	virtio_cread_le(vi->vdev, struct virtio_net_config, duplex, &duplex);
> +
> +	if (ethtool_validate_duplex(duplex))
> +		vi->duplex = duplex;
> +}
> +
>  static int virtnet_open(struct net_device *dev)
>  {
>  	struct virtnet_info *vi = netdev_priv(dev);
> @@ -2903,6 +2922,15 @@ static int virtnet_open(struct net_device *dev)
>  			goto err_enable_qp;
>  	}
>  
> +	if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_STATUS)) {
> +		if (vi->status & VIRTIO_NET_S_LINK_UP)
> +			netif_carrier_on(vi->dev);
> +		virtio_config_driver_enable(vi->vdev);
> +	} else {
> +		vi->status = VIRTIO_NET_S_LINK_UP;
> +		netif_carrier_on(dev);
> +	}
> +
>  	return 0;
>  
>  err_enable_qp:
> @@ -3381,12 +3409,22 @@ static int virtnet_close(struct net_device *dev)
>  	disable_delayed_refill(vi);
>  	/* Make sure refill_work doesn't re-enable napi! */
>  	cancel_delayed_work_sync(&vi->refill);
> +	/* Prevent the config change callback from changing carrier
> +	 * after close
> +	 */
> +	virtio_config_driver_disable(vi->vdev);
> +	/* Stop getting status/speed updates: we don't care until next
> +	 * open
> +	 */
> +	cancel_work_sync(&vi->config_work);
>  
>  	for (i = 0; i < vi->max_queue_pairs; i++) {
>  		virtnet_disable_queue_pair(vi, i);
>  		virtnet_cancel_dim(vi, &vi->rq[i].dim);
>  	}
>  
> +	netif_carrier_off(dev);
> +
>  	return 0;
>  }
>  
> @@ -5085,25 +5123,6 @@ static void virtnet_init_settings(struct net_device *dev)
>  	vi->duplex = DUPLEX_UNKNOWN;
>  }
>  
> -static void virtnet_update_settings(struct virtnet_info *vi)
> -{
> -	u32 speed;
> -	u8 duplex;
> -
> -	if (!virtio_has_feature(vi->vdev, VIRTIO_NET_F_SPEED_DUPLEX))
> -		return;
> -
> -	virtio_cread_le(vi->vdev, struct virtio_net_config, speed, &speed);
> -
> -	if (ethtool_validate_speed(speed))
> -		vi->speed = speed;
> -
> -	virtio_cread_le(vi->vdev, struct virtio_net_config, duplex, &duplex);
> -
> -	if (ethtool_validate_duplex(duplex))
> -		vi->duplex = duplex;
> -}
> -
>  static u32 virtnet_get_rxfh_key_size(struct net_device *dev)
>  {
>  	return ((struct virtnet_info *)netdev_priv(dev))->rss_key_size;
> @@ -6514,6 +6533,9 @@ static int virtnet_probe(struct virtio_device *vdev)
>  		goto free_failover;
>  	}
>  
> +	/* Disable config change notification until ndo_open. */
> +	virtio_config_driver_disable(vi->vdev);
> +
>  	virtio_device_ready(vdev);
>  
>  	virtnet_set_queues(vi, vi->curr_queue_pairs);
> @@ -6563,25 +6585,25 @@ static int virtnet_probe(struct virtio_device *vdev)
>  		vi->device_stats_cap = le64_to_cpu(v);
>  	}
>  
> -	rtnl_unlock();
> -
> -	err = virtnet_cpu_notif_add(vi);
> -	if (err) {
> -		pr_debug("virtio_net: registering cpu notifier failed\n");
> -		goto free_unregister_netdev;
> -	}
> -
>  	/* Assume link up if device can't report link status,
>  	   otherwise get link status from config. */
>  	netif_carrier_off(dev);
>  	if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_STATUS)) {
> -		schedule_work(&vi->config_work);
> +		virtnet_config_changed_work(&vi->config_work);
>  	} else {
>  		vi->status = VIRTIO_NET_S_LINK_UP;
>  		virtnet_update_settings(vi);
>  		netif_carrier_on(dev);
>  	}
>  
> +	rtnl_unlock();


OK I guess you are moving rtnl to make sure this does not
run in parallel with ndo_open/close.
I do, however, wonder whether ndo_set_features
can happen before guest_offloads_capable calculation below.
WDYT?

> +	err = virtnet_cpu_notif_add(vi);
> +	if (err) {
> +		pr_debug("virtio_net: registering cpu notifier failed\n");
> +		goto free_unregister_netdev;
> +	}
> +
>  	for (i = 0; i < ARRAY_SIZE(guest_offloads); i++)
>  		if (virtio_has_feature(vi->vdev, guest_offloads[i]))
>  			set_bit(guest_offloads[i], &vi->guest_offloads);
> -- 
> 2.31.1


