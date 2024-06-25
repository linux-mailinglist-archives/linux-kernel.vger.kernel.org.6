Return-Path: <linux-kernel+bounces-228162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9437A915BB2
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 03:28:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5351B214FE
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 01:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C0021A270;
	Tue, 25 Jun 2024 01:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hHqfEIvN"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 829D71B960
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 01:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719278875; cv=none; b=Xb9fjUEErQF42y0jvcH5xzw1liIDgv1wHjwiJCzYPUikExibVhYQlGR2TintF2ySQ94O0nj7Hk3sCY5VGmuRlyUnNo1AD9NjZxZvXeFqF0FYI1cPtPRbMd5DDB7kdbkUTsFxXuClO6OImz193or11bL4QiU4nPVH/qGAuPkQvQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719278875; c=relaxed/simple;
	bh=yjjQUUKXhxytqvA2OHxeNfjdJ0+LI/24Ja29DIooPo8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=krywo1zlej0zjbtOV6eTrhxI2b4KG71l+3oZD0yPnQeYsgvSSfD4D/PJm2MTkoNs9YBJO5o6lZilqbFk849UA/kVA3SVYAKHeIiIKvFmdkX2k2U6nMzZbsYWGIY2jvNGsZfqUsA8STZWi9hwM33n26ZhIcr8vztlFVRLOc2vbEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hHqfEIvN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719278872;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pqCzMsWS7cK7fhBVzoWPTT37VEQ1CT6mCtp7QCXX3Sc=;
	b=hHqfEIvNZocZx8WIhLmoofVp1dNt3MCX7wheYKuabNXaRJ8842d6EiIPe9j7dRHYz/HTFJ
	8vd1b+BF5gfg7WkbzdRvRhGjqCTtV7RAOTKIFwnk6WrNQYGkPbI7/BdUkKny88hIlluJZS
	FiRZanEx7tZ+vEJYjMVlJngCUS3SmLM=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-343-b5HmNWJ1MSK_NsAvhQsdWg-1; Mon, 24 Jun 2024 21:27:51 -0400
X-MC-Unique: b5HmNWJ1MSK_NsAvhQsdWg-1
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-70d8b7924e7so5626606a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 18:27:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719278870; x=1719883670;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pqCzMsWS7cK7fhBVzoWPTT37VEQ1CT6mCtp7QCXX3Sc=;
        b=HYfVPsL9YrRBEs0FUp3gvOLY5CW7St0wP//zDV8YU0bxx3tU/89wOQq/fG0IzR6Hvs
         lpnfVd4WZQd0AI6fVb7NL4BAae08UR2i4VIoOijJlGT5XYAHvUbqTI1OCs4mtHtu4BTL
         QY7SVH1vgi5rIq489ZaFo1TehyS3DQyUsPYRGXoz8VLYF9VfwDkykbYG1vZ6enZj4FYI
         jcm8sd6ppd7OcWrID8C7MvRpJ8hwO0OqmKvb60yh3s0+CQaR1bfQmxYIC2VI8uZDpqRB
         d2nLtgQ66eNLc4W51dttT0aWuw4hfQ+4rX5Zt8Da/xmvEWAs4lrVU8mObx0Qm8p8qPCG
         Nc9g==
X-Forwarded-Encrypted: i=1; AJvYcCWDo2pK3v24udXQN3N3TW0c+W/9yLMXV2Dm1Jfsc9Pv77cH6HLb14Vcct/xaDPh25wPGzbsSeXJbgQRUWH/R6AFfp6Q/uen982n6igr
X-Gm-Message-State: AOJu0YzWtpNe3NCMOsgrT2WftyMO7sXGgrpq4S6wA2hgiahJiopqeoON
	nHHNGInW4odYiCybdj8DTLDvm3eZea9HuV/qYNgoW4kb9iqB9sNZZoxJiy58IUBfjNvPciIg/iN
	2oib8/FD+pqyzEt8ioOO/ZvYPUoPRJ+GX/ZJu6gcaCt/5BL9cKC9fqC6FnIoqyaKaNmIIDNcKXa
	sALnyxlHjSTzNWUL4AbkAxjRQHngahTX4BU6Rn
X-Received: by 2002:a05:6a20:3f15:b0:1bd:b69:f0e3 with SMTP id adf61e73a8af0-1bd0b69f2e6mr2859702637.44.1719278869790;
        Mon, 24 Jun 2024 18:27:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGnSD1Ch6q09/yixw0OjRjgosSIFbkYnngHKOWbkFx4RhraQi66A+gxlTJvgHuMxTB4ShwvJ3EbZnK+L4FKMIw=
X-Received: by 2002:a05:6a20:3f15:b0:1bd:b69:f0e3 with SMTP id
 adf61e73a8af0-1bd0b69f2e6mr2859683637.44.1719278869254; Mon, 24 Jun 2024
 18:27:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240624024523.34272-1-jasowang@redhat.com> <20240624024523.34272-4-jasowang@redhat.com>
 <20240624060057-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240624060057-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 25 Jun 2024 09:27:38 +0800
Message-ID: <CACGkMEsysbded3xvU=qq6L_SmR0jmfvXdbthpZ0ERJoQhveZ3w@mail.gmail.com>
Subject: Re: [PATCH V2 3/3] virtio-net: synchronize operstate with admin state
 on up/down
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, venkat.x.venkatsubra@oracle.com, 
	gia-khanh.nguyen@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 24, 2024 at 6:07=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Mon, Jun 24, 2024 at 10:45:23AM +0800, Jason Wang wrote:
> > This patch synchronize operstate with admin state per RFC2863.
> >
> > This is done by trying to toggle the carrier upon open/close and
> > synchronize with the config change work. This allows propagate status
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
> >
> > Cc: Venkat Venkatsubra <venkat.x.venkatsubra@oracle.com>
> > Cc: Gia-Khanh Nguyen <gia-khanh.nguyen@oracle.com>
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > ---
> >  drivers/net/virtio_net.c | 72 +++++++++++++++++++++++-----------------
> >  1 file changed, 42 insertions(+), 30 deletions(-)
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index b1f8b720733e..eff3ad3d6bcc 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -2468,6 +2468,25 @@ static int virtnet_enable_queue_pair(struct virt=
net_info *vi, int qp_index)
> >       return err;
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
> > @@ -2486,6 +2505,22 @@ static int virtnet_open(struct net_device *dev)
> >                       goto err_enable_qp;
> >       }
> >
> > +     /* Assume link up if device can't report link status,
> > +        otherwise get link status from config. */
> > +     netif_carrier_off(dev);
> > +     if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_STATUS)) {
> > +             virtio_config_enable(vi->vdev);
> > +             /* We are not sure if config interrupt is disabled by
> > +              * core or not, so we can't schedule config_work by
> > +              * ourselves.
> > +              */
>
> This comment confuses more than it explains.
> You seem to be arguing about some alternative design
> you had in mind, but readers don't have it in mind.
>
>
> Please just explain what this does and why.
> For what: something like "Trigger re-read of config - same
> as we'd do if config changed".
>
> Now, please do what you don't do here: explain the why:
>
>
> why do we want all these VM
> exits on each open/close as opposed to once on probe and later on
> config changed interrupt.

Fine, the main reason is that a config interrupt might be pending
during ifdown and core may disable configure interrupt due to several
reasons.

Thanks


>
>
> > +             virtio_config_changed(vi->vdev);
> > +     } else {
> > +             vi->status =3D VIRTIO_NET_S_LINK_UP;
> > +             virtnet_update_settings(vi);
> > +             netif_carrier_on(dev);
> > +     }
> > +
> >       return 0;
> >
> >  err_enable_qp:
> > @@ -2928,12 +2963,19 @@ static int virtnet_close(struct net_device *dev=
)
> >       disable_delayed_refill(vi);
> >       /* Make sure refill_work doesn't re-enable napi! */
> >       cancel_delayed_work_sync(&vi->refill);
> > +     /* Make sure config notification doesn't schedule config work */
> > +     virtio_config_disable(vi->vdev);
> > +     /* Make sure status updating is cancelled */
> > +     cancel_work_sync(&vi->config_work);
> >
> >       for (i =3D 0; i < vi->max_queue_pairs; i++) {
> >               virtnet_disable_queue_pair(vi, i);
> >               cancel_work_sync(&vi->rq[i].dim.work);
> >       }
> >
> > +     vi->status &=3D ~VIRTIO_NET_S_LINK_UP;
> > +     netif_carrier_off(dev);
> > +
> >       return 0;
> >  }
> >
> > @@ -4632,25 +4674,6 @@ static void virtnet_init_settings(struct net_dev=
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
> > @@ -5958,17 +5981,6 @@ static int virtnet_probe(struct virtio_device *v=
dev)
> >               goto free_unregister_netdev;
> >       }
> >
> > -     /* Assume link up if device can't report link status,
> > -        otherwise get link status from config. */
> > -     netif_carrier_off(dev);
> > -     if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_STATUS)) {
> > -             schedule_work(&vi->config_work);
> > -     } else {
> > -             vi->status =3D VIRTIO_NET_S_LINK_UP;
> > -             virtnet_update_settings(vi);
> > -             netif_carrier_on(dev);
> > -     }
> > -
> >       for (i =3D 0; i < ARRAY_SIZE(guest_offloads); i++)
> >               if (virtio_has_feature(vi->vdev, guest_offloads[i]))
> >                       set_bit(guest_offloads[i], &vi->guest_offloads);
> > --
> > 2.31.1
>


