Return-Path: <linux-kernel+bounces-270767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77ED29444F8
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 08:57:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B6351C22837
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 06:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A7C7170A14;
	Thu,  1 Aug 2024 06:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bfpeF69V"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69392170A01
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 06:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722495328; cv=none; b=nhNI4iPiSH++djDRnIGdvfAUC2pcxzxVPDCtOeE8DyUkPD2DUHnjEP2BNOMmLH+O+ulvs7gbNohnW6wNoMvGCbl2dVMlLEDedW76/QNREtFZr3p59QysxAyMUJlxXyedf171MQX/ZjIWPasSFjUfU89eBYWcl9c6bisBAtEkjsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722495328; c=relaxed/simple;
	bh=uXmdlxLtuhdSFkzTQtvzg1fFuky0y8tBPgCNsG7pnT4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sbb3Dt8S9wVug0mDCJyfU32OLSgPeTQfwwNyyjic234mXJ1C6De2t3UdL/zbiF8T0beTEHs+cETiGlwO3EiD57iWmYR8/bGdXJPtA+FgoBW4ehKbr4gZnCK0XcT2bwQB4ttxp5dYKugBJfLFk9FAZR2kAbX6nDDC81O/unlh1SE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bfpeF69V; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722495324;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cu/9czGWQvKSUqESVT20yPNW+1bt6243UgdHjViN9PY=;
	b=bfpeF69VbXutWRM/2id5YVkJnRgjimi/ohcTY8OSBBzGQR5KMtBS9TuCLkZUe/gFFImm17
	s5jOqoN6hI60mHYbapWwKQNVgzCP3aiAatlBuYDaBXkch/UAFbEPGMJnTdRwnLdIP/DjBS
	nxyD7nRlXaOv6FhPV0qYOunpFmdbikQ=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-522-zkeNp2wUNwiEVZ1zVZvmNg-1; Thu, 01 Aug 2024 02:55:23 -0400
X-MC-Unique: zkeNp2wUNwiEVZ1zVZvmNg-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2cb7364bac9so1993395a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 23:55:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722495322; x=1723100122;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cu/9czGWQvKSUqESVT20yPNW+1bt6243UgdHjViN9PY=;
        b=auhrBXW3zwTUkycGcqHaDtezygxgpvbpgwIqHuK/QqmmJWFhAF4V2b8XENRUaxo9CE
         wRDf4TrH13epj03UMyEY9nclAUcXGd7l0OEIH/0Z+pFR6oPyslJdfAvBiU0yDcbmyfO0
         eCpoeE+rfPWXLRZ+xMVYaNZ7HYMTb/GbCBoohU8v8hs7vP0ReG+mGKgygAIfCMDogvsU
         f5laltQPb/f6xLP4rG12b08W+QnyJ2G4Es3EIXpZJeYaXgu78KWqFt/UCZbrcPrtiyLv
         2mYzSMuTPRzKmBlwUaOMkU2ZydxdhQCB7qE04YQIAcBtwFatNHEGihnhUrk0dUnEfubL
         pbBg==
X-Forwarded-Encrypted: i=1; AJvYcCU0WrAglto/X3MGX/ReupDp4UqsCTvZHNTdlIMGnMRe/cJ/Not4gMBFrO41JJXgMU/dabkc9JYG1GeFXIYNjRaeWT2qGu+rN0zVdlth
X-Gm-Message-State: AOJu0Yw3iFtY61UzPuPWn4ZheiskI4koU+Q8b2YHb3t4UgD9ioGZpM7E
	5Q6ALTbgo5H4DMPGLQAIzoFR5WVFWBFOEo32QHxXGV8Rq17TiIj9fqTeG2AVVGUA7WGQODUYhqG
	lXMypEx5s1P8NktSUmR/zA2DkiBhN/IRK8y6XkUK27WJfh0nH7N/VMHXpKq98RpcmPf6Q0SuckP
	p+Ms412yBArnRZZkX6T8oImq4KeGUvt6lLEHhc
X-Received: by 2002:a17:90b:3b81:b0:2cb:5829:a491 with SMTP id 98e67ed59e1d1-2cff09d8c3fmr550946a91.20.1722495321934;
        Wed, 31 Jul 2024 23:55:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEqTjPUWLV8th20Enf1oPyc2eYbUP8SCXasEvxLlNjEGi2/9QJ+/HTwWMiBJGZL1DJpOqISHINxPFYbhaZWO6M=
X-Received: by 2002:a17:90b:3b81:b0:2cb:5829:a491 with SMTP id
 98e67ed59e1d1-2cff09d8c3fmr550909a91.20.1722495321377; Wed, 31 Jul 2024
 23:55:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240731025947.23157-1-jasowang@redhat.com> <20240731025947.23157-4-jasowang@redhat.com>
 <20240731172020-mutt-send-email-mst@kernel.org> <CACGkMEvXfZJbCs0Fyi3EdYja37+D-o+79csXJYsBo0s+j2e5iA@mail.gmail.com>
 <20240801015344-mutt-send-email-mst@kernel.org> <CACGkMEstXNPWqhxBXiU3_VnXgQrwHgJKPONRTisbG9mRMkosuA@mail.gmail.com>
 <20240801024012-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240801024012-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 1 Aug 2024 14:55:10 +0800
Message-ID: <CACGkMEu1MO_UWObYY99SVMigjbRv0oaaKZKqXeVjdiFmUzUM2A@mail.gmail.com>
Subject: Re: [PATCH V4 net-next 3/3] virtio-net: synchronize operstate with
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

On Thu, Aug 1, 2024 at 2:42=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com> =
wrote:
>
> On Thu, Aug 01, 2024 at 02:13:18PM +0800, Jason Wang wrote:
> > On Thu, Aug 1, 2024 at 1:58=E2=80=AFPM Michael S. Tsirkin <mst@redhat.c=
om> wrote:
> > >
> > > On Thu, Aug 01, 2024 at 10:16:00AM +0800, Jason Wang wrote:
> > > > > > @@ -2885,6 +2886,25 @@ static void virtnet_cancel_dim(struct vi=
rtnet_info *vi, struct dim *dim)
> > > > > >       net_dim_work_cancel(dim);
> > > > > >  }
> > > > > >
> > > > > > +static void virtnet_update_settings(struct virtnet_info *vi)
> > > > > > +{
> > > > > > +     u32 speed;
> > > > > > +     u8 duplex;
> > > > > > +
> > > > > > +     if (!virtio_has_feature(vi->vdev, VIRTIO_NET_F_SPEED_DUPL=
EX))
> > > > > > +             return;
> > > > > > +
> > > > > > +     virtio_cread_le(vi->vdev, struct virtio_net_config, speed=
, &speed);
> > > > > > +
> > > > > > +     if (ethtool_validate_speed(speed))
> > > > > > +             vi->speed =3D speed;
> > > > > > +
> > > > > > +     virtio_cread_le(vi->vdev, struct virtio_net_config, duple=
x, &duplex);
> > > > > > +
> > > > > > +     if (ethtool_validate_duplex(duplex))
> > > > > > +             vi->duplex =3D duplex;
> > > > > > +}
> > > > > > +
> > > > >
> > > > > I already commented on this approach.  This is now invoked on eac=
h open,
> > > > > lots of extra VM exits. No bueno, people are working hard to keep=
 setup
> > > > > overhead under control. Handle this in the config change interrup=
t -
> > > > > your new infrastructure is perfect for this.
> > > >
> > > > No, in this version it doesn't. Config space read only happens if
> > > > there's a pending config interrupt during ndo_open:
> > > >
> > > > +       if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_STATUS)) {
> > > > +               if (vi->status & VIRTIO_NET_S_LINK_UP)
> > > > +                       netif_carrier_on(vi->dev);
> > > > +               virtio_config_driver_enable(vi->vdev);
> > > > +       } else {
> > > > +               vi->status =3D VIRTIO_NET_S_LINK_UP;
> > > > +               netif_carrier_on(dev);
> > > > +               virtnet_update_settings(vi);
> > > > +       }
> > >
> > > Sorry for being unclear, I was referring to !VIRTIO_NET_F_STATUS.
> > > I do not see why do we need to bother re-reading settings in this cas=
e at all,
> > > status is not there, nothing much changes.
> >
> > Ok, let me remove it from the next version.
> >
> > >
> > >
> > > > >
> > > > >
> > > > > >  static int virtnet_open(struct net_device *dev)
> > > > > >  {
> > > > > >       struct virtnet_info *vi =3D netdev_priv(dev);
> > > > > > @@ -2903,6 +2923,16 @@ static int virtnet_open(struct net_devic=
e *dev)
> > > > > >                       goto err_enable_qp;
> > > > > >       }
> > > > > >
> > > > > > +     if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_STATUS)) {
> > > > > > +             if (vi->status & VIRTIO_NET_S_LINK_UP)
> > > > > > +                     netif_carrier_on(vi->dev);
> > > > > > +             virtio_config_driver_enable(vi->vdev);
> > > > > > +     } else {
> > > > > > +             vi->status =3D VIRTIO_NET_S_LINK_UP;
> > > > > > +             netif_carrier_on(dev);
> > > > > > +             virtnet_update_settings(vi);
> > > > > > +     }
> > > > > > +
> > > > > >       return 0;
> > > > > >
> > > > > >  err_enable_qp:
> > > > > > @@ -3381,12 +3411,18 @@ static int virtnet_close(struct net_dev=
ice *dev)
> > > > > >       disable_delayed_refill(vi);
> > > > > >       /* Make sure refill_work doesn't re-enable napi! */
> > > > > >       cancel_delayed_work_sync(&vi->refill);
> > > > > > +     /* Make sure config notification doesn't schedule config =
work */
> > > > >
> > > > > it's clear what this does even without a comment.
> > > > > what you should comment on, and do not, is *why*.
> > > >
> > > > Well, it just follows the existing style, for example the above sai=
d
> > > >
> > > > "/* Make sure refill_work doesn't re-enable napi! */"
> > >
> > > only at the grammar level.
> > > you don't see the difference?
> > >
> > >         /* Make sure refill_work doesn't re-enable napi! */
> > >         cancel_delayed_work_sync(&vi->refill);
> > >
> > > it explains why we cancel: to avoid re-enabling napi.
> > >
> > > why do you cancel config callback and work?
> > > comment should say that.
> >
> > Something like "Prevent the config change callback from changing
> > carrier after close"?
>
>
> sounds good.
>
> > >
> > >
> > >
> > > > >
> > > > > > +     virtio_config_driver_disable(vi->vdev);
> > > > > > +     /* Make sure status updating is cancelled */
> > > > >
> > > > > same
> > > > >
> > > > > also what "status updating"? confuses more than this clarifies.
> > > >
> > > > Does "Make sure the config changed work is cancelled" sounds better=
?
> > >
> > > no, this just repeats what code does.
> > > explain why you cancel it.
> >
> > Does something like "Make sure carrier changes have been done by the
> > config change callback" works?
> >
> > Thanks
>
> I don't understand what this means.

Maybe "Ensure the configuration change callback successfully modifies
the carrier status"?

Thanks

>
> > >
> > >
> > >
> > > --
> > > MST
> > >
>


