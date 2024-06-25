Return-Path: <linux-kernel+bounces-228430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AB8F915FD1
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 09:16:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D22042819CE
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 07:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A729F146D6B;
	Tue, 25 Jun 2024 07:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IpQKExN3"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A64245BE3
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 07:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719299785; cv=none; b=DNLV4gw07PEV5MyzOFpzRUzcRk9YboEafddbYLUCH+Jl5XFNZRUtPnJ25PSMd9z8yKouwJxoTkFm98POGEPVdvG7oBmeW9QLzknNmRl0XVHH5eJw0Rm5b9ybVeqAHdnnNzwxCgLmBQ5hJxRcGSCn4kUNIUfoLvdPyxq/76xCKOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719299785; c=relaxed/simple;
	bh=xetssutV+uB/aGUYr84dRxPIMyGB/yv1uiSrE55emWY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qDdo1b1008hj1oNn8V0bbrQzbc+NnpHcbTVCQCFqUNRKKmhgi7WUzI/4XKggpmb37eLHDTwkICgM82kFN1niDJ3vNAZ2sDhtClj75CwH+xxWepXNqMfMCtSeSYsbaItNnqFSwhQyqBsLCKS4jKLUFINQiluiH7iKTY9BCWzhGS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IpQKExN3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719299782;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=83RIYUqfgOwmfcWFt4IC4y0oJD58iblfvt+zaDSBWwE=;
	b=IpQKExN3JLX4eM8q98xCRQwOW9cp3qT3z5HfN1oT5iid24I+v080s+/lZHeBL/3qLP6a9+
	DoyAXCNumTkuIt/W/ZDwsBsGeSQULh8Q1C73P3DctTcs9K9Jd0A4P1tt60Cv0e7hzn8o1b
	gHi8ZTqTC/j2H5yLfNd+x8sJ5yAR0cM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-532-uW2KydnCNjCpyTZ0X6gt1A-1; Tue, 25 Jun 2024 03:16:21 -0400
X-MC-Unique: uW2KydnCNjCpyTZ0X6gt1A-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-42196394b72so32260955e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 00:16:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719299780; x=1719904580;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=83RIYUqfgOwmfcWFt4IC4y0oJD58iblfvt+zaDSBWwE=;
        b=O2DwbajrkcKYag2H7CM2gL8xkbwk+Fxyhx6Mn9opj6Bi2TDv7M+BNDG4XaL4xej+iI
         e62IJA2HzfN/ywmwA/KGlF2b/8dLzyliHd8xxt30jCfl+01+/SalOKH3AwyIX+Gg6X+n
         GNWZXVROqteZYGH3OdKOZPMRL/yuSE2RYISB7mbW3DzyeoG2Cp8lXALGerqISsevVZ3Y
         KpDvpe7SynAqA262LwFCMmDe5FyGIiLxJF3pyHRARdg3usqGgjjfWHPBSIhTdPYh9c0J
         MzMYpZf4nqUps8naqcXRdENrGyqf2/mCVrGKWqu+8AQ+TIVFb8LMxPMI9DAglLOBrvRV
         vKxQ==
X-Forwarded-Encrypted: i=1; AJvYcCWY3wg0Pty+KmX2dBX5GWGieKRGQf++aG+r/M4NSWGGRBtJ0uJKZzGe4YSuUrcEG4YT4pbrz/gVfN6rW9KT5UhpPQ4ZdssJEu9xIuww
X-Gm-Message-State: AOJu0YwFOS74PvPA/wiWZ7ePWjJykhvbhcYAIfmmPMOnc93YbDjISQH9
	a8RGl1poKF3GJO8LB+C2ed9i7L3u5iyXv5WfVAJd0kH/mVXZ1bfgIBOQBwgoMvG5LXDTEtIZlA+
	EEMEZnk+iCkya0LuH2iOiKEYIUB0dsr01B5tfSlWASaMJxeU5cEItGgXD1qd1sQ==
X-Received: by 2002:a7b:ce16:0:b0:424:6c83:a78e with SMTP id 5b1f17b1804b1-4248cc67447mr42997885e9.40.1719299779701;
        Tue, 25 Jun 2024 00:16:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFH5r4+wWVEhT87Okk1mm91YxyY156l2jYoof2FlZWbV2LdiRQsg9jyTs260a1DZlEoGAbu9A==
X-Received: by 2002:a7b:ce16:0:b0:424:6c83:a78e with SMTP id 5b1f17b1804b1-4248cc67447mr42997595e9.40.1719299778914;
        Tue, 25 Jun 2024 00:16:18 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f6:f72:b8c7:9fc2:4c8b:feb3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4247d0c547asm202886645e9.22.2024.06.25.00.16.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 00:16:18 -0700 (PDT)
Date: Tue, 25 Jun 2024 03:16:12 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, venkat.x.venkatsubra@oracle.com,
	gia-khanh.nguyen@oracle.com
Subject: Re: [PATCH V2 3/3] virtio-net: synchronize operstate with admin
 state on up/down
Message-ID: <20240625031455-mutt-send-email-mst@kernel.org>
References: <20240624024523.34272-1-jasowang@redhat.com>
 <20240624024523.34272-4-jasowang@redhat.com>
 <20240624060057-mutt-send-email-mst@kernel.org>
 <CACGkMEsysbded3xvU=qq6L_SmR0jmfvXdbthpZ0ERJoQhveZ3w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEsysbded3xvU=qq6L_SmR0jmfvXdbthpZ0ERJoQhveZ3w@mail.gmail.com>

On Tue, Jun 25, 2024 at 09:27:38AM +0800, Jason Wang wrote:
> On Mon, Jun 24, 2024 at 6:07 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Mon, Jun 24, 2024 at 10:45:23AM +0800, Jason Wang wrote:
> > > This patch synchronize operstate with admin state per RFC2863.
> > >
> > > This is done by trying to toggle the carrier upon open/close and
> > > synchronize with the config change work. This allows propagate status
> > > correctly to stacked devices like:
> > >
> > > ip link add link enp0s3 macvlan0 type macvlan
> > > ip link set link enp0s3 down
> > > ip link show
> > >
> > > Before this patch:
> > >
> > > 3: enp0s3: <BROADCAST,MULTICAST> mtu 1500 qdisc pfifo_fast state DOWN mode DEFAULT group default qlen 1000
> > >     link/ether 00:00:05:00:00:09 brd ff:ff:ff:ff:ff:ff
> > > ......
> > > 5: macvlan0@enp0s3: <BROADCAST,MULTICAST,UP,LOWER_UP,M-DOWN> mtu 1500 qdisc noqueue state UP mode DEFAULT group default qlen 1000
> > >     link/ether b2:a9:c5:04:da:53 brd ff:ff:ff:ff:ff:ff
> > >
> > > After this patch:
> > >
> > > 3: enp0s3: <BROADCAST,MULTICAST> mtu 1500 qdisc pfifo_fast state DOWN mode DEFAULT group default qlen 1000
> > >     link/ether 00:00:05:00:00:09 brd ff:ff:ff:ff:ff:ff
> > > ...
> > > 5: macvlan0@enp0s3: <NO-CARRIER,BROADCAST,MULTICAST,UP,M-DOWN> mtu 1500 qdisc noqueue state LOWERLAYERDOWN mode DEFAULT group default qlen 1000
> > >     link/ether b2:a9:c5:04:da:53 brd ff:ff:ff:ff:ff:ff
> > >
> > > Cc: Venkat Venkatsubra <venkat.x.venkatsubra@oracle.com>
> > > Cc: Gia-Khanh Nguyen <gia-khanh.nguyen@oracle.com>
> > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > ---
> > >  drivers/net/virtio_net.c | 72 +++++++++++++++++++++++-----------------
> > >  1 file changed, 42 insertions(+), 30 deletions(-)
> > >
> > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > index b1f8b720733e..eff3ad3d6bcc 100644
> > > --- a/drivers/net/virtio_net.c
> > > +++ b/drivers/net/virtio_net.c
> > > @@ -2468,6 +2468,25 @@ static int virtnet_enable_queue_pair(struct virtnet_info *vi, int qp_index)
> > >       return err;
> > >  }
> > >
> > > +static void virtnet_update_settings(struct virtnet_info *vi)
> > > +{
> > > +     u32 speed;
> > > +     u8 duplex;
> > > +
> > > +     if (!virtio_has_feature(vi->vdev, VIRTIO_NET_F_SPEED_DUPLEX))
> > > +             return;
> > > +
> > > +     virtio_cread_le(vi->vdev, struct virtio_net_config, speed, &speed);
> > > +
> > > +     if (ethtool_validate_speed(speed))
> > > +             vi->speed = speed;
> > > +
> > > +     virtio_cread_le(vi->vdev, struct virtio_net_config, duplex, &duplex);
> > > +
> > > +     if (ethtool_validate_duplex(duplex))
> > > +             vi->duplex = duplex;
> > > +}
> > > +
> > >  static int virtnet_open(struct net_device *dev)
> > >  {
> > >       struct virtnet_info *vi = netdev_priv(dev);
> > > @@ -2486,6 +2505,22 @@ static int virtnet_open(struct net_device *dev)
> > >                       goto err_enable_qp;
> > >       }
> > >
> > > +     /* Assume link up if device can't report link status,
> > > +        otherwise get link status from config. */
> > > +     netif_carrier_off(dev);
> > > +     if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_STATUS)) {
> > > +             virtio_config_enable(vi->vdev);
> > > +             /* We are not sure if config interrupt is disabled by
> > > +              * core or not, so we can't schedule config_work by
> > > +              * ourselves.
> > > +              */
> >
> > This comment confuses more than it explains.
> > You seem to be arguing about some alternative design
> > you had in mind, but readers don't have it in mind.
> >
> >
> > Please just explain what this does and why.
> > For what: something like "Trigger re-read of config - same
> > as we'd do if config changed".
> >
> > Now, please do what you don't do here: explain the why:
> >
> >
> > why do we want all these VM
> > exits on each open/close as opposed to once on probe and later on
> > config changed interrupt.
> 
> Fine, the main reason is that a config interrupt might be pending
> during ifdown and core may disable configure interrupt due to several
> reasons.
> 
> Thanks

If the config changes exactly as command is executing?
Then we'll get an interrupt later and update.
You can't always win this race, even if you read it can
change right after.


> 
> >
> >
> > > +             virtio_config_changed(vi->vdev);
> > > +     } else {
> > > +             vi->status = VIRTIO_NET_S_LINK_UP;
> > > +             virtnet_update_settings(vi);
> > > +             netif_carrier_on(dev);
> > > +     }
> > > +
> > >       return 0;
> > >
> > >  err_enable_qp:
> > > @@ -2928,12 +2963,19 @@ static int virtnet_close(struct net_device *dev)
> > >       disable_delayed_refill(vi);
> > >       /* Make sure refill_work doesn't re-enable napi! */
> > >       cancel_delayed_work_sync(&vi->refill);
> > > +     /* Make sure config notification doesn't schedule config work */
> > > +     virtio_config_disable(vi->vdev);
> > > +     /* Make sure status updating is cancelled */
> > > +     cancel_work_sync(&vi->config_work);
> > >
> > >       for (i = 0; i < vi->max_queue_pairs; i++) {
> > >               virtnet_disable_queue_pair(vi, i);
> > >               cancel_work_sync(&vi->rq[i].dim.work);
> > >       }
> > >
> > > +     vi->status &= ~VIRTIO_NET_S_LINK_UP;
> > > +     netif_carrier_off(dev);
> > > +
> > >       return 0;
> > >  }
> > >
> > > @@ -4632,25 +4674,6 @@ static void virtnet_init_settings(struct net_device *dev)
> > >       vi->duplex = DUPLEX_UNKNOWN;
> > >  }
> > >
> > > -static void virtnet_update_settings(struct virtnet_info *vi)
> > > -{
> > > -     u32 speed;
> > > -     u8 duplex;
> > > -
> > > -     if (!virtio_has_feature(vi->vdev, VIRTIO_NET_F_SPEED_DUPLEX))
> > > -             return;
> > > -
> > > -     virtio_cread_le(vi->vdev, struct virtio_net_config, speed, &speed);
> > > -
> > > -     if (ethtool_validate_speed(speed))
> > > -             vi->speed = speed;
> > > -
> > > -     virtio_cread_le(vi->vdev, struct virtio_net_config, duplex, &duplex);
> > > -
> > > -     if (ethtool_validate_duplex(duplex))
> > > -             vi->duplex = duplex;
> > > -}
> > > -
> > >  static u32 virtnet_get_rxfh_key_size(struct net_device *dev)
> > >  {
> > >       return ((struct virtnet_info *)netdev_priv(dev))->rss_key_size;
> > > @@ -5958,17 +5981,6 @@ static int virtnet_probe(struct virtio_device *vdev)
> > >               goto free_unregister_netdev;
> > >       }
> > >
> > > -     /* Assume link up if device can't report link status,
> > > -        otherwise get link status from config. */
> > > -     netif_carrier_off(dev);
> > > -     if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_STATUS)) {
> > > -             schedule_work(&vi->config_work);
> > > -     } else {
> > > -             vi->status = VIRTIO_NET_S_LINK_UP;
> > > -             virtnet_update_settings(vi);
> > > -             netif_carrier_on(dev);
> > > -     }
> > > -
> > >       for (i = 0; i < ARRAY_SIZE(guest_offloads); i++)
> > >               if (virtio_has_feature(vi->vdev, guest_offloads[i]))
> > >                       set_bit(guest_offloads[i], &vi->guest_offloads);
> > > --
> > > 2.31.1
> >


