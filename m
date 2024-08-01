Return-Path: <linux-kernel+bounces-270664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4558944304
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 08:06:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 064B1B2140F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 06:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9478115746D;
	Thu,  1 Aug 2024 06:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NTJY9YdF"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 822E11B7E4
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 06:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722492374; cv=none; b=ANntRUetoh6OrQMR/ocTBZZr9wL8PgjR2MBcO98XlNfkXezPs/gzj7vniVoIcxO6Y05Sg0Ntmzzv0CxOGzNCo7ANffJxWFKTl2zRt3XTNi/7/uIvi+C/HV9LydtcLyusx+A8kSG0Zd5NVRrU1INp3dwaPVvVUR8aMtbjxC0lTCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722492374; c=relaxed/simple;
	bh=MoJr4mGPo2emWOdduc6Ewmz4RQQEWee+Ztqd4CfE9Nc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ApdYVE+DTUvUH+SH8vSc2mt5TpBTSRnZewMuWHdGNmQZcIjQRvvfWKq0s0uXK5vbQVt9IJ7hem7FTyuE5rABa/+FJG7+cdr+DbfeDRihfJj5eKap8vAnCd2soa7bg+HIl/W7NGf7ijzz6EDCmpB69BoPihxToNxMuELLlLZXqGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NTJY9YdF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722492370;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oXvVrXEs7imKq8lxNZGkuvPb2Qi8cRn244ngd84DYZs=;
	b=NTJY9YdFaOiyQZGBlw1E0jIkJq0R0PjYgLcR3cMG0AG9VWnzLmYkEFPXOGR0i/pDjRDwM7
	/u7gBIFu82q61a6OF6VidOtxpYjaUBXklc3cJvKZWot7pWZdSvjknofplZdcjMO7QvrLFx
	hr7vDOkFymUC5xIEQdobAzEnJuxyv+0=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-ptmEyYCuNfGVPxPKZ7bDcw-1; Thu, 01 Aug 2024 02:06:09 -0400
X-MC-Unique: ptmEyYCuNfGVPxPKZ7bDcw-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2ef3157ae4cso68672751fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 23:06:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722492367; x=1723097167;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oXvVrXEs7imKq8lxNZGkuvPb2Qi8cRn244ngd84DYZs=;
        b=Sy7TvmmMyVO7Wxva0NHSg5zfMsyM7SYPN5K/Inu36EdrL709pWtETyMcOGfD1ZR9+8
         uFGGnz1SYIvLRghnpPLmPOtRjL5qGo3Qkx7f3JpjAdZkRa2xN2pNd+gtVD6BFO6FoXwi
         eK/23kFPUVC6O2aGrU+L4fI+Qg+ty8eczEuDNgBpo8p9eQtdlfRYYrUs3NARzQTC5CSo
         56ivrW4atVzySlgFWMK6g9+9TWNlKMlbx+6T0faf7hzHXFSgUl9EMahG3n2x5YmiawqL
         4zc0dHeBx3Zvn8CwxIoeNgUpgc1qIJSoUrsA4wu6951b137/24TkfVZ0HcBzZuV7xRki
         TDuQ==
X-Forwarded-Encrypted: i=1; AJvYcCWlcZRvSROavi9uQsaHJfl4daH+PAt4VLtwuGtLxFj+xlchyNS4KaboxP/UTKe2c/A1NWGrJLE1VQjI2sH+XNkn4/eHt9wgv9eaDRor
X-Gm-Message-State: AOJu0YyRkICrVdXw78hx+gWI0BaEpUq7mCOR6Afct1R/GzIx1jCtRCkT
	DM9QiihY9TGyFJttb0HX1Jyq3cnlM6IbFWsKnK6T+frtiSDx3GPsvY6HP7PenZQ0Lnp9rzqEHoK
	sUMFZiNBazey6lxjf8vSaP7Qqzg3H+M+GvPf1Df/girbjs3DhdOihOsF8KrctRw==
X-Received: by 2002:a2e:9e44:0:b0:2ef:32bb:5368 with SMTP id 38308e7fff4ca-2f1530ea1e2mr11451341fa.11.1722492367212;
        Wed, 31 Jul 2024 23:06:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHM9ZyKL75V6GO6PtO5RhoimbEdBrF+GHnf8Kpa6aPVDLn3MkQr2Rf9oSzR7icep3N5IacJHQ==
X-Received: by 2002:a2e:9e44:0:b0:2ef:32bb:5368 with SMTP id 38308e7fff4ca-2f1530ea1e2mr11450881fa.11.1722492366305;
        Wed, 31 Jul 2024 23:06:06 -0700 (PDT)
Received: from redhat.com ([2.55.14.19])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acad41027sm845472466b.122.2024.07.31.23.06.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 23:06:04 -0700 (PDT)
Date: Thu, 1 Aug 2024 02:05:54 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Venkat Venkatsubra <venkat.x.venkatsubra@oracle.com>,
	Gia-Khanh Nguyen <gia-khanh.nguyen@oracle.com>
Subject: Re: [PATCH V4 net-next 3/3] virtio-net: synchronize operstate with
 admin state on up/down
Message-ID: <20240801015914-mutt-send-email-mst@kernel.org>
References: <20240731025947.23157-1-jasowang@redhat.com>
 <20240731025947.23157-4-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240731025947.23157-4-jasowang@redhat.com>

On Wed, Jul 31, 2024 at 10:59:47AM +0800, Jason Wang wrote:
> This patch synchronize operstate with admin state per RFC2863.
> 
> This is done by trying to toggle the carrier upon open/close and
> synchronize with the config change work. This allows propagate status
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
> 
> Cc: Venkat Venkatsubra <venkat.x.venkatsubra@oracle.com>
> Cc: Gia-Khanh Nguyen <gia-khanh.nguyen@oracle.com>
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/net/virtio_net.c | 84 ++++++++++++++++++++++++++--------------
>  1 file changed, 54 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 0383a3e136d6..0cb93261eba1 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -2878,6 +2878,7 @@ static int virtnet_enable_queue_pair(struct virtnet_info *vi, int qp_index)
>  	return err;
>  }
>  
> +
>  static void virtnet_cancel_dim(struct virtnet_info *vi, struct dim *dim)
>  {
>  	if (!virtio_has_feature(vi->vdev, VIRTIO_NET_F_VQ_NOTF_COAL))
> @@ -2885,6 +2886,25 @@ static void virtnet_cancel_dim(struct virtnet_info *vi, struct dim *dim)
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
> @@ -2903,6 +2923,16 @@ static int virtnet_open(struct net_device *dev)
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
> +		virtnet_update_settings(vi);
> +	}
> +
>  	return 0;
>  
>  err_enable_qp:
> @@ -3381,12 +3411,18 @@ static int virtnet_close(struct net_device *dev)
>  	disable_delayed_refill(vi);
>  	/* Make sure refill_work doesn't re-enable napi! */
>  	cancel_delayed_work_sync(&vi->refill);
> +	/* Make sure config notification doesn't schedule config work */
> +	virtio_config_driver_disable(vi->vdev);
> +	/* Make sure status updating is cancelled */
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
> @@ -5085,25 +5121,6 @@ static void virtnet_init_settings(struct net_device *dev)
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
> @@ -6514,6 +6531,11 @@ static int virtnet_probe(struct virtio_device *vdev)
>  		goto free_failover;
>  	}
>  
> +	/* Forbid config change notification until ndo_open. */
> +	virtio_config_driver_disable(vi->vdev);
> +	/* Make sure status updating work is done */

Wait a second, how can anything run here, this is probe,
config change callbacks are never invoked at all.

> +	cancel_work_sync(&vi->config_work);
> +


this is pointless, too.

>  	virtio_device_ready(vdev);
>  
>  	virtnet_set_queues(vi, vi->curr_queue_pairs);
> @@ -6563,6 +6585,19 @@ static int virtnet_probe(struct virtio_device *vdev)
>  		vi->device_stats_cap = le64_to_cpu(v);
>  	}
>  
> +	/* Assume link up if device can't report link status,
> +           otherwise get link status from config. */
> +        netif_carrier_off(dev);
> +        if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_STATUS)) {
> +		/* This is safe as config notification change has been
> +		   disabled. */

What "this"? pls explain what this does: get config data from
device.

Actually not because it was disabled. probe can poke at
config with impunity no change callbacks trigger during probe.

> +                virtnet_config_changed_work(&vi->config_work);




> +        } else {
> +                vi->status = VIRTIO_NET_S_LINK_UP;
> +                virtnet_update_settings(vi);
> +                netif_carrier_on(dev);
> +        }
> +
>  	rtnl_unlock();
>  
>  	err = virtnet_cpu_notif_add(vi);
> @@ -6571,17 +6606,6 @@ static int virtnet_probe(struct virtio_device *vdev)
>  		goto free_unregister_netdev;
>  	}
>  
> -	/* Assume link up if device can't report link status,
> -	   otherwise get link status from config. */
> -	netif_carrier_off(dev);
> -	if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_STATUS)) {
> -		schedule_work(&vi->config_work);
> -	} else {
> -		vi->status = VIRTIO_NET_S_LINK_UP;
> -		virtnet_update_settings(vi);
> -		netif_carrier_on(dev);
> -	}
> -
>  	for (i = 0; i < ARRAY_SIZE(guest_offloads); i++)
>  		if (virtio_has_feature(vi->vdev, guest_offloads[i]))
>  			set_bit(guest_offloads[i], &vi->guest_offloads);
> -- 
> 2.31.1


