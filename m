Return-Path: <linux-kernel+bounces-254700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED21D933682
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 08:00:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 241AE1C22872
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 06:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6485C12E48;
	Wed, 17 Jul 2024 06:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CiVgopbN"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A230E574
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 06:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721196040; cv=none; b=ONmfdiGJUKb75FemUzDV28t3aC10aX94NP2lwUm2AJik8+NFLtiC5V4dCDbqHITpF29Exp5lKidWMPdfuSuXiOsCw/Xos/pUQqYXFvpaCW8sl6rkTEYhy/rFU5N2xLoNa2X1A67ZmuoCGYVJlZAmruHNzt4MfLE6Aeo8ef1VznY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721196040; c=relaxed/simple;
	bh=KW09d8Wc1ZGpgPYZhIZDAhgbHjFTyW7HLNLNM0Z4R5k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QX7C+xsNukSBPZkiLO+lnosyY8XF6krS0MaW0Gh6FR/3TLs1LPnE68VJZS3JaL/4ubrB/Spx0XgaHr/0E18AOi0tMbGTtrwKI/RvLMLM11MQlEcv7GBFqU5ufhNxR3wMXYLRtzR3uw7KnWW/IQnnTJSE9Q4DXtQiPNj7Oe7doyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CiVgopbN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721196037;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DLSwQGWDiUaXmNejs9TGNFb6eo7q0Jz5uryzJxXFuEw=;
	b=CiVgopbNCd1EOdfKQV394WOHRhqX9a2W2C+02QLY4ZS7eVqRW+S48C/o7enunXpcZcE7E5
	9KFSGS3eOPx3z+XmTIBzaKACj5yFnAM8uCm8tvOEaR5f953sK7mlDDyKVSYTljCdS9buBJ
	0g8xwibCHMrR9APBV+iIdLBQOFUY+qM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-47-w31ao9soNIigCUVA9768HA-1; Wed, 17 Jul 2024 02:00:33 -0400
X-MC-Unique: w31ao9soNIigCUVA9768HA-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-426703ac88dso42098725e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 23:00:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721196032; x=1721800832;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DLSwQGWDiUaXmNejs9TGNFb6eo7q0Jz5uryzJxXFuEw=;
        b=WRTgE6Hw9ghSshPW25R62rCdKZ7PD0c/XRyrbRdDER199Hcy+I+GvmjocjU0PXbUZ0
         pOYbnVEEJSQAdYCBsjqXjL/vlICOkIWpUTfW38uYO4xnfbJz5o8JfwYfgpQSxSUokQeJ
         N+Q1XySSexj2qkOPHymOc/VRxbt3hJ5H6cAvbX1VbNhOx+hZtMJU6tWzzICahkVeuDk5
         wOX72LBbKVrSAiLBBSie/YBFF691Of751TYZajGdn/l3Ia4x8I1Le4ed+u3uLfGqSSAE
         NuwOYINAmWsKj1ppYuVIdcKL/j3cClrxl8WLQ32LrCVv/pyvxGvz03718rO/9yvdfEoi
         uR3g==
X-Forwarded-Encrypted: i=1; AJvYcCWEfgJWK8SzjvNktJ6HKFAs66clzASuNtOBQJNPemc05DovamiN8IU3OdZKrcwUE8YvmlFZDsBhKNa/C00wFcfIlFDnBg8F3QCo+X0j
X-Gm-Message-State: AOJu0YzPUyJbJ2Z6G2XMRsvqiaLhBVrczs+7UYZmoWNSuowgVlSy0GmJ
	C4FE930PZEmv+3hXUp4ZbqD2PD0BmCaTeyunkvDRlzsKbm84sRYWyfeNmghTeftkHsMw5DudZIc
	hRGDHa4Mu+3O3wnqgb47rG7tBF+WN4p7fhFMHtCxoiZ+0qiVn0jvp/CzanSqLDw==
X-Received: by 2002:a05:600c:5026:b0:426:6114:7328 with SMTP id 5b1f17b1804b1-427c3285f65mr3884055e9.38.1721196031717;
        Tue, 16 Jul 2024 23:00:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHgsxme7Ix3OPYUWIk/ZQeBCSMa0m0FQ9Fn23uTw768M4puzQBnKYjB36kEMD4l4mZZDFUIGg==
X-Received: by 2002:a05:600c:5026:b0:426:6114:7328 with SMTP id 5b1f17b1804b1-427c3285f65mr3883675e9.38.1721196031020;
        Tue, 16 Jul 2024 23:00:31 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f6:360d:da73:bbf7:ba86:37fb])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427a5edb478sm157439305e9.33.2024.07.16.23.00.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 23:00:30 -0700 (PDT)
Date: Wed, 17 Jul 2024 02:00:23 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	Venkat Venkatsubra <venkat.x.venkatsubra@oracle.com>,
	Gia-Khanh Nguyen <gia-khanh.nguyen@oracle.com>
Subject: Re: [PATCH net-next v3 3/3] virtio-net: synchronize operstate with
 admin state on up/down
Message-ID: <20240717015904-mutt-send-email-mst@kernel.org>
References: <20240709080214.9790-1-jasowang@redhat.com>
 <20240709080214.9790-4-jasowang@redhat.com>
 <20240709090743-mutt-send-email-mst@kernel.org>
 <CACGkMEv4CVK4YdOvHEbMY3dLc3cxF_tPN8H4YO=0rvFLaK-Upw@mail.gmail.com>
 <CACGkMEvDiQHfLaBRoaFtpYJHKTqicqbrpeZWzat43YveTa9Wyg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEvDiQHfLaBRoaFtpYJHKTqicqbrpeZWzat43YveTa9Wyg@mail.gmail.com>

On Wed, Jul 17, 2024 at 09:19:02AM +0800, Jason Wang wrote:
> On Wed, Jul 10, 2024 at 11:03 AM Jason Wang <jasowang@redhat.com> wrote:
> >
> > On Tue, Jul 9, 2024 at 9:28 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > >
> > > On Tue, Jul 09, 2024 at 04:02:14PM +0800, Jason Wang wrote:
> > > > This patch synchronize operstate with admin state per RFC2863.
> > > >
> > > > This is done by trying to toggle the carrier upon open/close and
> > > > synchronize with the config change work. This allows propagate status
> > > > correctly to stacked devices like:
> > > >
> > > > ip link add link enp0s3 macvlan0 type macvlan
> > > > ip link set link enp0s3 down
> > > > ip link show
> > > >
> > > > Before this patch:
> > > >
> > > > 3: enp0s3: <BROADCAST,MULTICAST> mtu 1500 qdisc pfifo_fast state DOWN mode DEFAULT group default qlen 1000
> > > >     link/ether 00:00:05:00:00:09 brd ff:ff:ff:ff:ff:ff
> > > > ......
> > > > 5: macvlan0@enp0s3: <BROADCAST,MULTICAST,UP,LOWER_UP,M-DOWN> mtu 1500 qdisc noqueue state UP mode DEFAULT group default qlen 1000
> > > >     link/ether b2:a9:c5:04:da:53 brd ff:ff:ff:ff:ff:ff
> > > >
> > > > After this patch:
> > > >
> > > > 3: enp0s3: <BROADCAST,MULTICAST> mtu 1500 qdisc pfifo_fast state DOWN mode DEFAULT group default qlen 1000
> > > >     link/ether 00:00:05:00:00:09 brd ff:ff:ff:ff:ff:ff
> > > > ...
> > > > 5: macvlan0@enp0s3: <NO-CARRIER,BROADCAST,MULTICAST,UP,M-DOWN> mtu 1500 qdisc noqueue state LOWERLAYERDOWN mode DEFAULT group default qlen 1000
> > > >     link/ether b2:a9:c5:04:da:53 brd ff:ff:ff:ff:ff:ff
> > >
> > > I think that the commit log is confusing. It seems to say that
> > > the issue fixed is synchronizing state with hardware
> > > config change.
> > > But your example does not show any
> > > hardware change. Isn't this example really just
> > > a side effect of setting carrier off on close?
> >
> > The main goal for this patch is to make virtio-net follow RFC2863. The
> > main thing that is missed is to synchronize the operstate with admin
> > state, if we do this, we get several good results, one of the obvious
> > one is to allow virtio-net to propagate status to the upper layer, for
> > example if the admin state of the lower virtio-net is down it should
> > be propagated to the macvlan on top, so I give the example of using a
> > stacked device. I'm not we had others but the commit log is probably
> > too small to say all of it.
> 
> Michael, any more comments on this?
> 
> Thans


Still don't get it, sorry.
> > > > This is done by trying to toggle the carrier upon open/close and
> > > > synchronize with the config change work.
What does this sentence mean? What is not synchronized with config
change that needs to be?

> >
> > >
> > >
> > > > Cc: Venkat Venkatsubra <venkat.x.venkatsubra@oracle.com>
> > > > Cc: Gia-Khanh Nguyen <gia-khanh.nguyen@oracle.com>
> > > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > >
> > > Yes but this just forces lots of re-reads of config on each
> > > open/close for no good reason.
> >
> > Does it really harm? Technically the link status could be changed
> > several times when the admin state is down as well.
> >
> > > Config interrupt is handled in core, you can read once
> > > on probe and then handle config changes.
> >
> > Per RFC2863, the code tries to avoid dealing with any operstate change
> > via config space read when the admin state is down.
> >
> > >
> > >
> > >
> > >
> > >
> > > > ---
> > > >  drivers/net/virtio_net.c | 64 ++++++++++++++++++++++++----------------
> > > >  1 file changed, 38 insertions(+), 26 deletions(-)
> > > >
> > > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > > index 0b4747e81464..e6626ba25b29 100644
> > > > --- a/drivers/net/virtio_net.c
> > > > +++ b/drivers/net/virtio_net.c
> > > > @@ -2476,6 +2476,25 @@ static void virtnet_cancel_dim(struct virtnet_info *vi, struct dim *dim)
> > > >       net_dim_work_cancel(dim);
> > > >  }
> > > >
> > > > +static void virtnet_update_settings(struct virtnet_info *vi)
> > > > +{
> > > > +     u32 speed;
> > > > +     u8 duplex;
> > > > +
> > > > +     if (!virtio_has_feature(vi->vdev, VIRTIO_NET_F_SPEED_DUPLEX))
> > > > +             return;
> > > > +
> > > > +     virtio_cread_le(vi->vdev, struct virtio_net_config, speed, &speed);
> > > > +
> > > > +     if (ethtool_validate_speed(speed))
> > > > +             vi->speed = speed;
> > > > +
> > > > +     virtio_cread_le(vi->vdev, struct virtio_net_config, duplex, &duplex);
> > > > +
> > > > +     if (ethtool_validate_duplex(duplex))
> > > > +             vi->duplex = duplex;
> > > > +}
> > > > +
> > > >  static int virtnet_open(struct net_device *dev)
> > > >  {
> > > >       struct virtnet_info *vi = netdev_priv(dev);
> > > > @@ -2494,6 +2513,18 @@ static int virtnet_open(struct net_device *dev)
> > > >                       goto err_enable_qp;
> > > >       }
> > > >
> > > > +     if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_STATUS)) {
> > > > +             virtio_config_driver_enable(vi->vdev);
> > > > +             /* Do not schedule the config change work as the
> > > > +              * config change notification might have been disabled
> > > > +              * by the virtio core. */
> > >
> > > I don't get why you need this.
> > > If the notification was disabled it will just trigger later.
> > > This is exactly why using core is a good idea.
> >
> > So we need a read here (this seems to be not rare for most modern
> > hardware NICs) because we don't know if the link status is changed or
> > not and it is not guaranteed by virtio_config_driver_enable() since it
> > only works when there's a pending config change. Another thing is that
> > the device is being freezed, so the virtio core may prevent the device
> > from accessing the device.
> >
> > So using virtio_config_changed() will guaranteed that:
> >
> > 1) if the device is not being freezed, it will read the config space soon
> > 2) if the device is being freezed, the read of the config space will
> > be delayed to resume
> >
> > >
> > >
> > > > +             virtio_config_changed(vi->vdev);
> > > > +     } else {
> > > > +             vi->status = VIRTIO_NET_S_LINK_UP;
> > > > +             virtnet_update_settings(vi);
> > >
> > >
> > > And why do we need this here I don't get at all.
> >
> > See above, because doing this on a probe is racy and buggy: The
> > opersate is up even if the adminstate is not, this is conflict with
> > RFC2863:
> >
> > "
> > If ifAdminStatus is down(2) then ifOperStatus
> >             should be down(2)
> > "
> >
> > >
> > > > +             netif_carrier_on(dev);
> > > > +     }
> > >
> > >
> > >
> > > > +
> > > >       return 0;
> > > >
> > > >  err_enable_qp:
> > > > @@ -2936,12 +2967,19 @@ static int virtnet_close(struct net_device *dev)
> > > >       disable_delayed_refill(vi);
> > > >       /* Make sure refill_work doesn't re-enable napi! */
> > > >       cancel_delayed_work_sync(&vi->refill);
> > > > +     /* Make sure config notification doesn't schedule config work */
> > > > +     virtio_config_driver_disable(vi->vdev);
> > > > +     /* Make sure status updating is cancelled */
> > > > +     cancel_work_sync(&vi->config_work);
> > > >
> > > >       for (i = 0; i < vi->max_queue_pairs; i++) {
> > > >               virtnet_disable_queue_pair(vi, i);
> > > >               virtnet_cancel_dim(vi, &vi->rq[i].dim);
> > > >       }
> > > >
> > > > +     vi->status &= ~VIRTIO_NET_S_LINK_UP;
> > > > +     netif_carrier_off(dev);
> > > > +
> > > >       return 0;
> > > >  }
> > > >
> > > > @@ -4640,25 +4678,6 @@ static void virtnet_init_settings(struct net_device *dev)
> > > >       vi->duplex = DUPLEX_UNKNOWN;
> > > >  }
> > > >
> > > > -static void virtnet_update_settings(struct virtnet_info *vi)
> > > > -{
> > > > -     u32 speed;
> > > > -     u8 duplex;
> > > > -
> > > > -     if (!virtio_has_feature(vi->vdev, VIRTIO_NET_F_SPEED_DUPLEX))
> > > > -             return;
> > > > -
> > > > -     virtio_cread_le(vi->vdev, struct virtio_net_config, speed, &speed);
> > > > -
> > > > -     if (ethtool_validate_speed(speed))
> > > > -             vi->speed = speed;
> > > > -
> > > > -     virtio_cread_le(vi->vdev, struct virtio_net_config, duplex, &duplex);
> > > > -
> > > > -     if (ethtool_validate_duplex(duplex))
> > > > -             vi->duplex = duplex;
> > > > -}
> > > > -
> > > >  static u32 virtnet_get_rxfh_key_size(struct net_device *dev)
> > > >  {
> > > >       return ((struct virtnet_info *)netdev_priv(dev))->rss_key_size;
> > > > @@ -6000,13 +6019,6 @@ static int virtnet_probe(struct virtio_device *vdev)
> > > >       /* Assume link up if device can't report link status,
> > > >          otherwise get link status from config. */
> > > >       netif_carrier_off(dev);
> > > > -     if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_STATUS)) {
> > > > -             schedule_work(&vi->config_work);
> > > > -     } else {
> > > > -             vi->status = VIRTIO_NET_S_LINK_UP;
> > > > -             virtnet_update_settings(vi);
> > > > -             netif_carrier_on(dev);
> > > > -     }
> > >
> > >
> > > Here it all made sense - we were reading config for the 1st time.
> >
> > See above.
> >
> > Thanks
> >
> > >
> > >
> > > >       for (i = 0; i < ARRAY_SIZE(guest_offloads); i++)
> > > >               if (virtio_has_feature(vi->vdev, guest_offloads[i]))
> > > > --
> > > > 2.31.1
> > >
> > >


