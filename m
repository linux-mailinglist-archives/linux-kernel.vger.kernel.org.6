Return-Path: <linux-kernel+bounces-284048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2824694FC63
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 05:46:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 818C9283478
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 03:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB0281CD16;
	Tue, 13 Aug 2024 03:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jMcqL7+a"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67EEE1B970
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 03:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723520764; cv=none; b=dEmkXIJo4NpvyIJe8uxbzBO0gEPHQth5W87sKwR1Wds+HbyBHjeRRKXVl5n1oubtFe++chj5XNQ4S/yPvn1pDd/yllszLTmv3Z9RmEUbrj9q3mefcqJ+KOk7AAXxjitOjGtSR8UjtrRRBwAeYfkrb5aeW5yhjlo06rYO+H/qM9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723520764; c=relaxed/simple;
	bh=yceP9DAWKPKlT7Sq5hjZWKK36tp3OUW2w6K7QPwMXj4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sRydNJ5DHsEFXasO4AbBTo5mLxOtzwio+ingc2Nn7L+mK3DotVOJfRBAnaCOr0n2qoZnQk/Oa6uBTOqhSsPv1x3xbhRiZfe6z+i/z/UL3tUY39DYFZLGmoxBl5/NGZCVfuEd/e2K0NZMycKyBZw3rX87NnB+1ofzyxEcsWAARlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jMcqL7+a; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723520761;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VLzbGP2JsMnr9jy5iZ9KVQ1RMqy5vYx7gbKlTyJ7iAc=;
	b=jMcqL7+aLstLo1cM8HndCRoqRNZYiMb1JGf76pC88ofPQ1P4ntvrii//lZyIp9Yi7Xf4EF
	0FRZ94sbQ0JOD5iKKYHhgTxD9Y+NHvkUp1FRpFm4CbBvCL1u/99sOtaoxgA9QyW0aM8FtR
	+kxf721o6v218P9ubinvzJx5fcVwU0U=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-TyzaWeqfPei5jtrCpLhaKg-1; Mon, 12 Aug 2024 23:45:59 -0400
X-MC-Unique: TyzaWeqfPei5jtrCpLhaKg-1
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-70eab26e146so4365355b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 20:45:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723520758; x=1724125558;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VLzbGP2JsMnr9jy5iZ9KVQ1RMqy5vYx7gbKlTyJ7iAc=;
        b=cFnCs5VS4jHJphAniNr3A7KID/hpZLQlIKLX0PAqNyfWnuv/DwZxE6xvErxU1AnRQE
         4Flw3satsESOiwrxjy8VOdpKqAecSJErwozTfFLuIS+gyT6Dhl/jIYueV262pm+j8mUC
         WbUpsf9WyJltkAcThuhBQcmJO9FV6AC8iwevcFPQYD5tkqCTUZwlWOD5Wta9Ev1wFkXN
         veYoqeKGQZ/uWavg/yYNeGzafxohXLeVimW1Cf4PFFqXNSP6ak2sr5Sbclv3YBYUvKKE
         O5mSSEBtB8BcJmPwFCbbIIYB7YvMFqQAZ1K6Z4owLnsuy1jLz/8LXeZnXz9zBYQGGIWS
         Xolg==
X-Forwarded-Encrypted: i=1; AJvYcCVLfY1NufPBJAHot0aDtGFxN0cSQIo9wrVwke0hbBzd+Jti8efznq4I+nhSR8itioXQOtp+ZiURQbTWvX26pAzLJMG0WaSkF7zYjeAr
X-Gm-Message-State: AOJu0YxnWqdyacReiC1CfYc7eflvqPZzIXh4VSHrlGfcjv5ohcPDZlaZ
	30dqOL3k2wJVAo7uqWJ+JzCszoLORjxephcGAZr47DVb6RR2DK8jXyJeEPu24ZdQaA64Hve6px8
	GQpDL7MCs+g5lVRtHt3Y5oYLRyMpLeVYe4E65owMt5ou31XjqvLB6DnTGl9Ip2i8mLuvVber+Hk
	kRKEtEARj5rSgie0A767CV2JzhS1jJhSco45Jg
X-Received: by 2002:a05:6a20:d807:b0:1c2:8efc:88e9 with SMTP id adf61e73a8af0-1c8d758f7b3mr2695451637.40.1723520758529;
        Mon, 12 Aug 2024 20:45:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHzdASWlW/KSJWKCN/sNH/7JSAZUMKWVCaiEG3UXrFA9r5uSYwo8aJRYAd+QG4neTb0YfGVMCyAfG0csmi814c=
X-Received: by 2002:a05:6a20:d807:b0:1c2:8efc:88e9 with SMTP id
 adf61e73a8af0-1c8d758f7b3mr2695435637.40.1723520757960; Mon, 12 Aug 2024
 20:45:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240806022224.71779-1-jasowang@redhat.com> <20240806022224.71779-5-jasowang@redhat.com>
 <20240806082436-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240806082436-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 13 Aug 2024 11:45:46 +0800
Message-ID: <CACGkMEuNqpeNwmFNu-104RxRr0VnBt5Tv_MLg0UdWmjoDxZsMA@mail.gmail.com>
Subject: Re: [PATCH net-next V6 4/4] virtio-net: synchronize probe with ndo_set_features
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 6, 2024 at 8:25=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com> =
wrote:
>
> On Tue, Aug 06, 2024 at 10:22:24AM +0800, Jason Wang wrote:
> > We calculate guest offloads during probe without the protection of
> > rtnl_lock. This lead to race between probe and ndo_set_features. Fix
> > this by moving the calculation under the rtnl_lock.
> >
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
>
> Fixes tag pls?

Fixes: 3f93522ffab2 ("virtio-net: switch off offloads on demand if
possible on XDP set")

Thanks


>
> > ---
> >  drivers/net/virtio_net.c | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index fc5196ca8d51..1d86aa07c871 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -6596,6 +6596,11 @@ static int virtnet_probe(struct virtio_device *v=
dev)
> >               netif_carrier_on(dev);
> >       }
> >
> > +     for (i =3D 0; i < ARRAY_SIZE(guest_offloads); i++)
> > +             if (virtio_has_feature(vi->vdev, guest_offloads[i]))
> > +                     set_bit(guest_offloads[i], &vi->guest_offloads);
> > +     vi->guest_offloads_capable =3D vi->guest_offloads;
> > +
> >       rtnl_unlock();
> >
> >       err =3D virtnet_cpu_notif_add(vi);
> > @@ -6604,11 +6609,6 @@ static int virtnet_probe(struct virtio_device *v=
dev)
> >               goto free_unregister_netdev;
> >       }
> >
> > -     for (i =3D 0; i < ARRAY_SIZE(guest_offloads); i++)
> > -             if (virtio_has_feature(vi->vdev, guest_offloads[i]))
> > -                     set_bit(guest_offloads[i], &vi->guest_offloads);
> > -     vi->guest_offloads_capable =3D vi->guest_offloads;
> > -
> >       pr_debug("virtnet: registered device %s with %d RX and TX vq's\n"=
,
> >                dev->name, max_queue_pairs);
> >
> > --
> > 2.31.1
>


