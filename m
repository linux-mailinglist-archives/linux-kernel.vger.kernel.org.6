Return-Path: <linux-kernel+bounces-264986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54ED193EAE2
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 04:00:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50A53B20EF2
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 02:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1A1078C8E;
	Mon, 29 Jul 2024 01:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WTnBfsn6"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF9176056
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 01:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722218395; cv=none; b=i4S+bCsbZ/yfBiLAoqiHGQkP+y/dP2HDRWKZWzzujvzxQeVoUw6Swr4TilLqbo08tY4ZZgY6G6RbReL4hU2nIN5lJW939tQPbu9UsNhsI39FJll/vbL1lZojA+noXJE4++mXLgcz1UMkkBUGTJUjTDy2tBxpiie31FjPF+6iLrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722218395; c=relaxed/simple;
	bh=+X0mGMHud1UsXfJvmimh2dFioubpBL1uQnZDyNJg5uI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s8DbCZXt35u9tgzdCw6t2mM/eTcKo2ebHlwRW/NuASIpMqCcjHza0zXMmGSbt8+OlEboBNheA8JXckRh8ycmhyo/2iQL8WUhzdJZQVwqEmOCHPZJ01K7K26ksTbu0rCzj/wYylucJfZZ3cKJ96+MxbNEMy3HRyGMkdloeOLGe5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WTnBfsn6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722218391;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=23KXdt0rS76z6H8F/tfIBaq1hxhA7lnY5D2w9B1+Znw=;
	b=WTnBfsn6fXMTxAMQn8f8vuUJl7E6grKGIWq7YuUJAnzmarMd+AQ4DWUTYAgBB3H1p2YpHk
	Aw6roS7tKZtU08zaod0G4Ita375Q7SrylMKI3Nxv6i2lfVBnMaXj6PvUWyzsPvWW6yLyJR
	vRhcdGeEyn1Ir20nXyojLzXjdbcxR8o=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-64-YBylRtv3Ph67CElHy1GuZA-1; Sun, 28 Jul 2024 21:59:48 -0400
X-MC-Unique: YBylRtv3Ph67CElHy1GuZA-1
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-70d24aead3eso2423445b3a.0
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2024 18:59:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722218385; x=1722823185;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=23KXdt0rS76z6H8F/tfIBaq1hxhA7lnY5D2w9B1+Znw=;
        b=RVF+GpI7fVjimTws7aygmF0jkMg+BoMh09HjC5bg0M3bv0oCQ3q/VbchcwB/uX+b/g
         W1Os137ImxSXvI8vkIBEyHNywdE+opLptDW0yyZd1Qnky4P+PwsO8WPb58HSyOphifX4
         5vzLLA9aODwKA+rfVR6gbz6f/bfLxIOA9CIr/QC93vFIv9XqCuLYLmg2UMtDfrwiom3P
         0Q3HXfcT/Fha1di8vM1ou4PsPkwGp8STlFFQ2EUjaT6OCOpmqpPEvDLwnTo5Yp9WtwNQ
         bpRT3aDdaNbZFsEjvtcK+hxhxc3LQoa15zcd04HMdN6EE2TZnACS79HgAkZ5WjVrjQKd
         1jqw==
X-Forwarded-Encrypted: i=1; AJvYcCVHJp8gs+b8sSzFxJdpyq883yuGjonIfMAdwGj6ZOkLG7jJ3ycT2nWCz+wfFX1vVxDzf25PxO5X7zZ/bsbtc9uBmQYw6/tGy/Fnsm2e
X-Gm-Message-State: AOJu0Yz1+hpOETXD+5XEz2Q00N3MiSjbzrmIHgy4R44QzWzNPgIJ8sTK
	PW+JPW/F1vHE6Ipi5eGc2r4NUbYlc8D02A+iPc4b2e1errbo8RYVXwh9bajVFnuQQ3XFN9kowQ9
	+6MOY9pcd8k4s+LFJ/aC9+H8aioQLergPHLBrYkiMKkZCy8rzLTZscbmtlPKA6hbSFqBywlAeep
	WHvEAxVN+wEkBdT7AtjFndWvjTEDuxoRk3q2O6
X-Received: by 2002:a05:6a20:6a1c:b0:1c2:922f:379c with SMTP id adf61e73a8af0-1c4a12c60ffmr5112887637.23.1722218384900;
        Sun, 28 Jul 2024 18:59:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGa8vHqCqrF5pQ5VITjMSs3FlYrs/NcFnJvQicEG5nZ/QcT9HdpObjSa/Q8lgZxz9AMTfEuv+RGY3taM3pipQI=
X-Received: by 2002:a05:6a20:6a1c:b0:1c2:922f:379c with SMTP id
 adf61e73a8af0-1c4a12c60ffmr5112859637.23.1722218384345; Sun, 28 Jul 2024
 18:59:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240709080214.9790-1-jasowang@redhat.com> <20240709080214.9790-4-jasowang@redhat.com>
 <20240709090743-mutt-send-email-mst@kernel.org> <CACGkMEv4CVK4YdOvHEbMY3dLc3cxF_tPN8H4YO=0rvFLaK-Upw@mail.gmail.com>
 <20240726031947-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240726031947-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 29 Jul 2024 09:59:33 +0800
Message-ID: <CACGkMEtX3o_yzuac2py=rurRKkCahW4LF=1zttDF=eKJ-3UT6Q@mail.gmail.com>
Subject: Re: [PATCH net-next v3 3/3] virtio-net: synchronize operstate with
 admin state on up/down
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, Venkat Venkatsubra <venkat.x.venkatsubra@oracle.com>, 
	Gia-Khanh Nguyen <gia-khanh.nguyen@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 26, 2024 at 3:24=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Wed, Jul 10, 2024 at 11:03:42AM +0800, Jason Wang wrote:
> > On Tue, Jul 9, 2024 at 9:28=E2=80=AFPM Michael S. Tsirkin <mst@redhat.c=
om> wrote:
> > >
> > > On Tue, Jul 09, 2024 at 04:02:14PM +0800, Jason Wang wrote:
> > > > This patch synchronize operstate with admin state per RFC2863.
> > > >
> > > > This is done by trying to toggle the carrier upon open/close and
> > > > synchronize with the config change work. This allows propagate stat=
us
> > > > correctly to stacked devices like:
> > > >
> > > > ip link add link enp0s3 macvlan0 type macvlan
> > > > ip link set link enp0s3 down
> > > > ip link show
> > > >
> > > > Before this patch:
> > > >
> > > > 3: enp0s3: <BROADCAST,MULTICAST> mtu 1500 qdisc pfifo_fast state DO=
WN mode DEFAULT group default qlen 1000
> > > >     link/ether 00:00:05:00:00:09 brd ff:ff:ff:ff:ff:ff
> > > > ......
> > > > 5: macvlan0@enp0s3: <BROADCAST,MULTICAST,UP,LOWER_UP,M-DOWN> mtu 15=
00 qdisc noqueue state UP mode DEFAULT group default qlen 1000
> > > >     link/ether b2:a9:c5:04:da:53 brd ff:ff:ff:ff:ff:ff
> > > >
> > > > After this patch:
> > > >
> > > > 3: enp0s3: <BROADCAST,MULTICAST> mtu 1500 qdisc pfifo_fast state DO=
WN mode DEFAULT group default qlen 1000
> > > >     link/ether 00:00:05:00:00:09 brd ff:ff:ff:ff:ff:ff
> > > > ...
> > > > 5: macvlan0@enp0s3: <NO-CARRIER,BROADCAST,MULTICAST,UP,M-DOWN> mtu =
1500 qdisc noqueue state LOWERLAYERDOWN mode DEFAULT group default qlen 100=
0
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
>
> It's a bunch of extra vmexits on each VM boot, yes.

A new version is ready, will be posted to net-next soon.

>
> > > Config interrupt is handled in core, you can read once
> > > on probe and then handle config changes.
> >
> > Per RFC2863, the code tries to avoid dealing with any operstate change
> > via config space read when the admin state is down.
>
> what exactly in RFC2863 are you referring to? This?
>    (2)   if ifAdminStatus is down, then ifOperStatus will normally also
>          be down (or notPresent) i.e., there is not (necessarily) a
>          fault condition on the interface.

Yes.

> So basically, just call virtio_config_driver_disable on close,
> and then config interrupt will not trigger.
> Why is that not enough?

So when close (admin down), we need to call netif_carrier_off() to
make (oper status down).

Thanks

>
>
> > >
> > >
> > >
> > >
> > >
> > > > ---
> > > >  drivers/net/virtio_net.c | 64 ++++++++++++++++++++++++------------=
----
> > > >  1 file changed, 38 insertions(+), 26 deletions(-)
> > > >
> > > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > > index 0b4747e81464..e6626ba25b29 100644
> > > > --- a/drivers/net/virtio_net.c
> > > > +++ b/drivers/net/virtio_net.c
> > > > @@ -2476,6 +2476,25 @@ static void virtnet_cancel_dim(struct virtne=
t_info *vi, struct dim *dim)
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
> > > > +     virtio_cread_le(vi->vdev, struct virtio_net_config, speed, &s=
peed);
> > > > +
> > > > +     if (ethtool_validate_speed(speed))
> > > > +             vi->speed =3D speed;
> > > > +
> > > > +     virtio_cread_le(vi->vdev, struct virtio_net_config, duplex, &=
duplex);
> > > > +
> > > > +     if (ethtool_validate_duplex(duplex))
> > > > +             vi->duplex =3D duplex;
> > > > +}
> > > > +
> > > >  static int virtnet_open(struct net_device *dev)
> > > >  {
> > > >       struct virtnet_info *vi =3D netdev_priv(dev);
> > > > @@ -2494,6 +2513,18 @@ static int virtnet_open(struct net_device *d=
ev)
> > > >                       goto err_enable_qp;
> > > >       }
> > > >
> > > > +     if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_STATUS)) {
> > > > +             virtio_config_driver_enable(vi->vdev);
> > > > +             /* Do not schedule the config change work as the
> > > > +              * config change notification might have been disable=
d
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
> > 1) if the device is not being freezed, it will read the config space so=
on
> > 2) if the device is being freezed, the read of the config space will
> > be delayed to resume
> >
> > >
> > >
> > > > +             virtio_config_changed(vi->vdev);
> > > > +     } else {
> > > > +             vi->status =3D VIRTIO_NET_S_LINK_UP;
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
> > > > @@ -2936,12 +2967,19 @@ static int virtnet_close(struct net_device =
*dev)
> > > >       disable_delayed_refill(vi);
> > > >       /* Make sure refill_work doesn't re-enable napi! */
> > > >       cancel_delayed_work_sync(&vi->refill);
> > > > +     /* Make sure config notification doesn't schedule config work=
 */
> > > > +     virtio_config_driver_disable(vi->vdev);
> > > > +     /* Make sure status updating is cancelled */
> > > > +     cancel_work_sync(&vi->config_work);
> > > >
> > > >       for (i =3D 0; i < vi->max_queue_pairs; i++) {
> > > >               virtnet_disable_queue_pair(vi, i);
> > > >               virtnet_cancel_dim(vi, &vi->rq[i].dim);
> > > >       }
> > > >
> > > > +     vi->status &=3D ~VIRTIO_NET_S_LINK_UP;
> > > > +     netif_carrier_off(dev);
> > > > +
> > > >       return 0;
> > > >  }
> > > >
> > > > @@ -4640,25 +4678,6 @@ static void virtnet_init_settings(struct net=
_device *dev)
> > > >       vi->duplex =3D DUPLEX_UNKNOWN;
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
> > > > -     virtio_cread_le(vi->vdev, struct virtio_net_config, speed, &s=
peed);
> > > > -
> > > > -     if (ethtool_validate_speed(speed))
> > > > -             vi->speed =3D speed;
> > > > -
> > > > -     virtio_cread_le(vi->vdev, struct virtio_net_config, duplex, &=
duplex);
> > > > -
> > > > -     if (ethtool_validate_duplex(duplex))
> > > > -             vi->duplex =3D duplex;
> > > > -}
> > > > -
> > > >  static u32 virtnet_get_rxfh_key_size(struct net_device *dev)
> > > >  {
> > > >       return ((struct virtnet_info *)netdev_priv(dev))->rss_key_siz=
e;
> > > > @@ -6000,13 +6019,6 @@ static int virtnet_probe(struct virtio_devic=
e *vdev)
> > > >       /* Assume link up if device can't report link status,
> > > >          otherwise get link status from config. */
> > > >       netif_carrier_off(dev);
> > > > -     if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_STATUS)) {
> > > > -             schedule_work(&vi->config_work);
> > > > -     } else {
> > > > -             vi->status =3D VIRTIO_NET_S_LINK_UP;
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
> > > >       for (i =3D 0; i < ARRAY_SIZE(guest_offloads); i++)
> > > >               if (virtio_has_feature(vi->vdev, guest_offloads[i]))
> > > > --
> > > > 2.31.1
> > >
> > >
>


