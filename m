Return-Path: <linux-kernel+bounces-274215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1396B94751E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 08:17:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B03A1F217EC
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 06:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16EB3145A0B;
	Mon,  5 Aug 2024 06:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W5Txebd6"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C820745F2
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 06:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722838631; cv=none; b=HANkztFOPMFGmysdYX/X0fB2KQ19jHHqyYHNRQnjxPrXz/F+UffXx9Sg95RM7KSkMmDrjcKIDX/xZY+TUyXiCNjFXUoY5eU58y1DK/LTjRWLD0ry3rLQK+q3/7/4Bq/xjQsktlwEg++nn/YVeyW5AyeVpiyPSvVvaJWzxYH+23I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722838631; c=relaxed/simple;
	bh=Rit4jcoqnFILYWO8SBQsZCnBg4Ywfq3V1qADQrAkrwk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jyaxn7P0VMAJpZCBs2AogaCtBvedVr3YnlxS2u2sEUEa4cTNfbMOoCfH0UBZdFdaUD7ayhINrvEAEUh8lUwIe/Hr9MV87AqJUQFoCH35UabuebqzOx5NoEGJAG7tf1lzh5r3gurCNWZoqmoyZ32WEVkO0HLrcruSQ39MwOJTN2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W5Txebd6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722838626;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zhPxt2+wzyEUDBe4s1sTOBs3jhz1NJVxgB47WCLuhIk=;
	b=W5Txebd6QSLmWDkAw1NkbP4C7GM1TyJlRjr8vk49ZkR9+VCaOIVKdtsSK16hLSsVEYvuFH
	WRq41zt+JdQNrnYlA+UQqV5cYAi6Tuti1TS3vKieVCWh2fxfEdjJd1oD7LWKNcp+J7lxFo
	Pi4DXveXGQ/H0yAYHafF/2fcV9zj5Q8=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-8xsk3qlmMaSF9wpGFS9lmQ-1; Mon, 05 Aug 2024 02:17:04 -0400
X-MC-Unique: 8xsk3qlmMaSF9wpGFS9lmQ-1
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-7a3c6dd559aso8595571a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 04 Aug 2024 23:17:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722838624; x=1723443424;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zhPxt2+wzyEUDBe4s1sTOBs3jhz1NJVxgB47WCLuhIk=;
        b=WyuBYaD2ekvwwQv5a1VyQP4bU0koGvikbS+wTRhqChkHQQFqgUmstSdNgl+nV0K9cA
         NneRdxqW5Tz596dMaRwgOr+n5nnFOy2mzw+fFgptj+Ex8GwPcEt5kgXpZjkBXpytS242
         2iNiMLa/Lr0LuXxQCnVaVl3LxI44XKBNMjiLie9D2AtB3wQA0xEni9kDehFUFs45UFrI
         QUdpViH9BLgOxDRucc4+j3dfdlKNgP9V0RHV0aWUnTXheIa1eUd3QaASU6cQhU5BdYHl
         Dzh+ILFF2diKERnV5cWqpQK1HY3Scm5vqaRg3504r6agUXb3JNFazvUVehpnzWbhnDxp
         DqhQ==
X-Forwarded-Encrypted: i=1; AJvYcCXCqTRfd8HqxKLFDgsni1zA6ySpJyvjOO94dcxF/pLI6xG5B21KB1vPuD3vxOC58w4QXEg6TlJ8imDGGj3PmQ94FsFjhEr7kK5vbik6
X-Gm-Message-State: AOJu0YzllBR7bZ4irW8a/UOu7GMV6bmwgo6Kxi7/mEF2vWsrfCJDWfpI
	Lk40iLMwJX+Bt/CeT4YcsuU8fpq4qi57jvxUptgoH4lx1gkzwfnfIYwXTLKKNWYfsILhGghZM6y
	PiKJLFoVijQq7j2PQ11uvt4oG3zzJI/CA2VgQKio6o4s4yHxKTI5TdngGd9LpUZ/RqrNvalGfIE
	KZ95v/ROfhHb4P8dtPmflxXfPwC3gqQxBqQKKo
X-Received: by 2002:a05:6a20:1596:b0:1c3:b2da:7e27 with SMTP id adf61e73a8af0-1c69953e15dmr11239115637.14.1722838623621;
        Sun, 04 Aug 2024 23:17:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGR/F9LA6B2u2qRpitMWhN7IesolWXzsgRINkyrLzhTDqlOy7Vw70opvzmfZVX6qh9u8Rz+KekB5aOKrQcfupM=
X-Received: by 2002:a05:6a20:1596:b0:1c3:b2da:7e27 with SMTP id
 adf61e73a8af0-1c69953e15dmr11239090637.14.1722838623012; Sun, 04 Aug 2024
 23:17:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240805030242.62390-1-jasowang@redhat.com> <20240805030242.62390-4-jasowang@redhat.com>
 <20240805014422-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240805014422-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 5 Aug 2024 14:16:51 +0800
Message-ID: <CACGkMEsRaY282qQ98611PxYBdYSWkNeX9-qzY7r3ThsRnZVySw@mail.gmail.com>
Subject: Re: [PATCH V5 net-next 3/3] virtio-net: synchronize operstate with
 admin state on up/down
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Venkat Venkatsubra <venkat.x.venkatsubra@oracle.com>, 
	Gia-Khanh Nguyen <gia-khanh.nguyen@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 5, 2024 at 1:52=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com> =
wrote:
>
> On Mon, Aug 05, 2024 at 11:02:42AM +0800, Jason Wang wrote:
> > This patch synchronize operstate with admin state per RFC2863.
>
>
> synchronizes
>
> >
> > This is done by trying to toggle the carrier upon open/close and
> > synchronize with the config change work. This allows propagate status
>
> to propagate

Will fix.

>
> > correctly to stacked devices like:
> >
> > ip link add link enp0s3 macvlan0 type macvlan
> > ip link set link enp0s3 down
> > ip link show
> >
> > Before this patch:
> >
> > 3: enp0s3: <BROADCAST,MULTICAST> mtu 1500 qdisc pfifo_fast state DOWN m=
ode DEFAULT group default qlen 1000
> >     link/ether 00:00:05:00:00:09 brd ff:ff:ff:ff:ff:ff
> > ......
> > 5: macvlan0@enp0s3: <BROADCAST,MULTICAST,UP,LOWER_UP,M-DOWN> mtu 1500 q=
disc noqueue state UP mode DEFAULT group default qlen 1000
> >     link/ether b2:a9:c5:04:da:53 brd ff:ff:ff:ff:ff:ff
> >
> > After this patch:
> >
> > 3: enp0s3: <BROADCAST,MULTICAST> mtu 1500 qdisc pfifo_fast state DOWN m=
ode DEFAULT group default qlen 1000
> >     link/ether 00:00:05:00:00:09 brd ff:ff:ff:ff:ff:ff
> > ...
> > 5: macvlan0@enp0s3: <NO-CARRIER,BROADCAST,MULTICAST,UP,M-DOWN> mtu 1500=
 qdisc noqueue state LOWERLAYERDOWN mode DEFAULT group default qlen 1000
> >     link/ether b2:a9:c5:04:da:53 brd ff:ff:ff:ff:ff:ff
>
> Add an empty line here pls.
>
> > Cc: Venkat Venkatsubra <venkat.x.venkatsubra@oracle.com>
> > Cc: Gia-Khanh Nguyen <gia-khanh.nguyen@oracle.com>
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > ---
> >  drivers/net/virtio_net.c | 78 +++++++++++++++++++++++++---------------
> >  1 file changed, 50 insertions(+), 28 deletions(-)
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index 0383a3e136d6..fc5196ca8d51 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -2885,6 +2885,25 @@ static void virtnet_cancel_dim(struct virtnet_in=
fo *vi, struct dim *dim)
> >       net_dim_work_cancel(dim);
> >  }
> >
> > +static void virtnet_update_settings(struct virtnet_info *vi)
> > +{
> > +     u32 speed;
> > +     u8 duplex;
> > +
> > +     if (!virtio_has_feature(vi->vdev, VIRTIO_NET_F_SPEED_DUPLEX))
> > +             return;
> > +
> > +     virtio_cread_le(vi->vdev, struct virtio_net_config, speed, &speed=
);
> > +
> > +     if (ethtool_validate_speed(speed))
> > +             vi->speed =3D speed;
> > +
> > +     virtio_cread_le(vi->vdev, struct virtio_net_config, duplex, &dupl=
ex);
> > +
> > +     if (ethtool_validate_duplex(duplex))
> > +             vi->duplex =3D duplex;
> > +}
> > +
> >  static int virtnet_open(struct net_device *dev)
> >  {
> >       struct virtnet_info *vi =3D netdev_priv(dev);
> > @@ -2903,6 +2922,15 @@ static int virtnet_open(struct net_device *dev)
> >                       goto err_enable_qp;
> >       }
> >
> > +     if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_STATUS)) {
> > +             if (vi->status & VIRTIO_NET_S_LINK_UP)
> > +                     netif_carrier_on(vi->dev);
> > +             virtio_config_driver_enable(vi->vdev);
> > +     } else {
> > +             vi->status =3D VIRTIO_NET_S_LINK_UP;
> > +             netif_carrier_on(dev);
> > +     }
> > +
> >       return 0;
> >
> >  err_enable_qp:
> > @@ -3381,12 +3409,22 @@ static int virtnet_close(struct net_device *dev=
)
> >       disable_delayed_refill(vi);
> >       /* Make sure refill_work doesn't re-enable napi! */
> >       cancel_delayed_work_sync(&vi->refill);
> > +     /* Prevent the config change callback from changing carrier
> > +      * after close
> > +      */
> > +     virtio_config_driver_disable(vi->vdev);
> > +     /* Stop getting status/speed updates: we don't care until next
> > +      * open
> > +      */
> > +     cancel_work_sync(&vi->config_work);
> >
> >       for (i =3D 0; i < vi->max_queue_pairs; i++) {
> >               virtnet_disable_queue_pair(vi, i);
> >               virtnet_cancel_dim(vi, &vi->rq[i].dim);
> >       }
> >
> > +     netif_carrier_off(dev);
> > +
> >       return 0;
> >  }
> >
> > @@ -5085,25 +5123,6 @@ static void virtnet_init_settings(struct net_dev=
ice *dev)
> >       vi->duplex =3D DUPLEX_UNKNOWN;
> >  }
> >
> > -static void virtnet_update_settings(struct virtnet_info *vi)
> > -{
> > -     u32 speed;
> > -     u8 duplex;
> > -
> > -     if (!virtio_has_feature(vi->vdev, VIRTIO_NET_F_SPEED_DUPLEX))
> > -             return;
> > -
> > -     virtio_cread_le(vi->vdev, struct virtio_net_config, speed, &speed=
);
> > -
> > -     if (ethtool_validate_speed(speed))
> > -             vi->speed =3D speed;
> > -
> > -     virtio_cread_le(vi->vdev, struct virtio_net_config, duplex, &dupl=
ex);
> > -
> > -     if (ethtool_validate_duplex(duplex))
> > -             vi->duplex =3D duplex;
> > -}
> > -
> >  static u32 virtnet_get_rxfh_key_size(struct net_device *dev)
> >  {
> >       return ((struct virtnet_info *)netdev_priv(dev))->rss_key_size;
> > @@ -6514,6 +6533,9 @@ static int virtnet_probe(struct virtio_device *vd=
ev)
> >               goto free_failover;
> >       }
> >
> > +     /* Disable config change notification until ndo_open. */
> > +     virtio_config_driver_disable(vi->vdev);
> > +
> >       virtio_device_ready(vdev);
> >
> >       virtnet_set_queues(vi, vi->curr_queue_pairs);
> > @@ -6563,25 +6585,25 @@ static int virtnet_probe(struct virtio_device *=
vdev)
> >               vi->device_stats_cap =3D le64_to_cpu(v);
> >       }
> >
> > -     rtnl_unlock();
> > -
> > -     err =3D virtnet_cpu_notif_add(vi);
> > -     if (err) {
> > -             pr_debug("virtio_net: registering cpu notifier failed\n")=
;
> > -             goto free_unregister_netdev;
> > -     }
> > -
> >       /* Assume link up if device can't report link status,
> >          otherwise get link status from config. */
> >       netif_carrier_off(dev);
> >       if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_STATUS)) {
> > -             schedule_work(&vi->config_work);
> > +             virtnet_config_changed_work(&vi->config_work);
> >       } else {
> >               vi->status =3D VIRTIO_NET_S_LINK_UP;
> >               virtnet_update_settings(vi);
> >               netif_carrier_on(dev);
> >       }
> >
> > +     rtnl_unlock();
>
>
> OK I guess you are moving rtnl to make sure this does not
> run in parallel with ndo_open/close.
> I do, however, wonder whether ndo_set_features
> can happen before guest_offloads_capable calculation below.
> WDYT?

I think it can and it needs another patch to fix (probably on top).

Thanks

>
> > +     err =3D virtnet_cpu_notif_add(vi);
> > +     if (err) {
> > +             pr_debug("virtio_net: registering cpu notifier failed\n")=
;
> > +             goto free_unregister_netdev;
> > +     }
> > +
> >       for (i =3D 0; i < ARRAY_SIZE(guest_offloads); i++)
> >               if (virtio_has_feature(vi->vdev, guest_offloads[i]))
> >                       set_bit(guest_offloads[i], &vi->guest_offloads);
> > --
> > 2.31.1
>


