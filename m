Return-Path: <linux-kernel+bounces-270737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 712AE94449D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 08:42:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C9E6281DB6
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 06:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA6BB158531;
	Thu,  1 Aug 2024 06:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F0RkExqC"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F82D156F54
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 06:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722494521; cv=none; b=Bva0NLW2eZIRapFh+minbKJGLyq5M4c86/CExgfyecPhjp9/QYFq+6ZDdb1+xedG17c6nljIi+NRlJgmCy/VP1GAqScHO3gqywE7t4PckhtGCAKOiOhzf7FCOLi8vcQhqb4PFXup9VSeX9aC+SOP59ZQtU/fvW8RHfKDA7WhDTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722494521; c=relaxed/simple;
	bh=ONPlwqgsSwpfRRn9JHD2Mbq2Sn2i4FFtY8EerdBkBIg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Joo0Wnqqb5SBLtBhi+YrqAvmXaLjr939EH6N4xn1qqhuBkMGWQI/R/MU2oQEQjPs4HG6AfWBknwz3fw0LBDG1+8/gTPB6UCFJKIW2rf1pFrowJpJK5tb3FgVHLDMAKp6mpi0LsEKLfgDKfpUio9jf/S3giiYNjCOnFdvRff+twc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F0RkExqC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722494518;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TawFxjl8nzx90uXykegTmmxOqKJ1FqGRkr4dkAN2BZc=;
	b=F0RkExqCZqLHUl68406JzEtfKia5+I67pXKNCAK89Q5gah88IGU5SJoidpgeTFO7G461rP
	If0qsvLOwjGCl5KyBdGIKhcC4uQ/lrFy/qiU0nXPvv6HGvvS36sKRCxf7qj61zScEsJzOx
	CwGrLU3b1fz9iq9XuQovu3bLb44KgOM=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-130-2jx4dlL-OPqnMabrIyzrJw-1; Thu, 01 Aug 2024 02:41:57 -0400
X-MC-Unique: 2jx4dlL-OPqnMabrIyzrJw-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-5a45054aa03so2457047a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 23:41:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722494516; x=1723099316;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TawFxjl8nzx90uXykegTmmxOqKJ1FqGRkr4dkAN2BZc=;
        b=bp4rPXWpf75OSVBMTB8C0FbYwP0kQtYOg9bJMKza717IKpvwMjhBxOdrQIk4X4qmPM
         1AJa2nZXQ18/yg2lqMuP52Ov/LGEYTDUguOKei79K2YqIB1XWI5fzoNWgokWLSCrTscy
         yE5GC2nOMwv/QpIBX0UR++p4BsixZFuBcePKjngkWqFZ59hgl6gzF+4W/t/Hf1Z000fs
         bzwuQ2h1/9xLttIMSyam+c5vWELrpNZk3aS2/4Yjk7YMnvKZQ6sX2mO6bn6zRonTaZXe
         uyKpT4ck4gOd4sBqAflRoFbWQKbQDBKhBJKEgEuL3mtpLuj4HZUuqKJvDrBx/nJLCtl7
         HUCQ==
X-Forwarded-Encrypted: i=1; AJvYcCX5K7RvUtIxLo57gZ7+ip2zQiwIN6qm2YW5cExbWtdWzlz8HUHzraSFRZ2OcvOVT4lqHNJSbmf78TeYqJqneqQ6Guwh1dWCmEYBpMb6
X-Gm-Message-State: AOJu0Yy+UyfswW6LFNrFpaMfHGxCC71kZbNN+sWbHYIQnNmpFczqIdsn
	P6yJzK3X+r1r53SLwMSYOd/LMePww/UdFL80fe22smg9bLHd7LyegQX2L3ppWUWY+Hsk9QgIm6P
	6b8ycOOq8f01RNjMw3lcG0GKcAEYRKWLdFrU5Qb6ssqMeCMcX+Sn5ZNI11B9zYw==
X-Received: by 2002:aa7:d0cb:0:b0:58b:1a5e:c0e7 with SMTP id 4fb4d7f45d1cf-5b700f81311mr921575a12.35.1722494515739;
        Wed, 31 Jul 2024 23:41:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGuymEMetUjHr1Ev0KFWrRFuLScNLkGQ/meZSzIJWkY0dxNy2lm8YTQLTJyXEWNfuT7QsXObg==
X-Received: by 2002:aa7:d0cb:0:b0:58b:1a5e:c0e7 with SMTP id 4fb4d7f45d1cf-5b700f81311mr921555a12.35.1722494514978;
        Wed, 31 Jul 2024 23:41:54 -0700 (PDT)
Received: from redhat.com ([2.55.44.248])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5af2f233be4sm8435006a12.41.2024.07.31.23.41.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 23:41:53 -0700 (PDT)
Date: Thu, 1 Aug 2024 02:41:47 -0400
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
Message-ID: <20240801024012-mutt-send-email-mst@kernel.org>
References: <20240731025947.23157-1-jasowang@redhat.com>
 <20240731025947.23157-4-jasowang@redhat.com>
 <20240731172020-mutt-send-email-mst@kernel.org>
 <CACGkMEvXfZJbCs0Fyi3EdYja37+D-o+79csXJYsBo0s+j2e5iA@mail.gmail.com>
 <20240801015344-mutt-send-email-mst@kernel.org>
 <CACGkMEstXNPWqhxBXiU3_VnXgQrwHgJKPONRTisbG9mRMkosuA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEstXNPWqhxBXiU3_VnXgQrwHgJKPONRTisbG9mRMkosuA@mail.gmail.com>

On Thu, Aug 01, 2024 at 02:13:18PM +0800, Jason Wang wrote:
> On Thu, Aug 1, 2024 at 1:58 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Thu, Aug 01, 2024 at 10:16:00AM +0800, Jason Wang wrote:
> > > > > @@ -2885,6 +2886,25 @@ static void virtnet_cancel_dim(struct virtnet_info *vi, struct dim *dim)
> > > > >       net_dim_work_cancel(dim);
> > > > >  }
> > > > >
> > > > > +static void virtnet_update_settings(struct virtnet_info *vi)
> > > > > +{
> > > > > +     u32 speed;
> > > > > +     u8 duplex;
> > > > > +
> > > > > +     if (!virtio_has_feature(vi->vdev, VIRTIO_NET_F_SPEED_DUPLEX))
> > > > > +             return;
> > > > > +
> > > > > +     virtio_cread_le(vi->vdev, struct virtio_net_config, speed, &speed);
> > > > > +
> > > > > +     if (ethtool_validate_speed(speed))
> > > > > +             vi->speed = speed;
> > > > > +
> > > > > +     virtio_cread_le(vi->vdev, struct virtio_net_config, duplex, &duplex);
> > > > > +
> > > > > +     if (ethtool_validate_duplex(duplex))
> > > > > +             vi->duplex = duplex;
> > > > > +}
> > > > > +
> > > >
> > > > I already commented on this approach.  This is now invoked on each open,
> > > > lots of extra VM exits. No bueno, people are working hard to keep setup
> > > > overhead under control. Handle this in the config change interrupt -
> > > > your new infrastructure is perfect for this.
> > >
> > > No, in this version it doesn't. Config space read only happens if
> > > there's a pending config interrupt during ndo_open:
> > >
> > > +       if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_STATUS)) {
> > > +               if (vi->status & VIRTIO_NET_S_LINK_UP)
> > > +                       netif_carrier_on(vi->dev);
> > > +               virtio_config_driver_enable(vi->vdev);
> > > +       } else {
> > > +               vi->status = VIRTIO_NET_S_LINK_UP;
> > > +               netif_carrier_on(dev);
> > > +               virtnet_update_settings(vi);
> > > +       }
> >
> > Sorry for being unclear, I was referring to !VIRTIO_NET_F_STATUS.
> > I do not see why do we need to bother re-reading settings in this case at all,
> > status is not there, nothing much changes.
> 
> Ok, let me remove it from the next version.
> 
> >
> >
> > > >
> > > >
> > > > >  static int virtnet_open(struct net_device *dev)
> > > > >  {
> > > > >       struct virtnet_info *vi = netdev_priv(dev);
> > > > > @@ -2903,6 +2923,16 @@ static int virtnet_open(struct net_device *dev)
> > > > >                       goto err_enable_qp;
> > > > >       }
> > > > >
> > > > > +     if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_STATUS)) {
> > > > > +             if (vi->status & VIRTIO_NET_S_LINK_UP)
> > > > > +                     netif_carrier_on(vi->dev);
> > > > > +             virtio_config_driver_enable(vi->vdev);
> > > > > +     } else {
> > > > > +             vi->status = VIRTIO_NET_S_LINK_UP;
> > > > > +             netif_carrier_on(dev);
> > > > > +             virtnet_update_settings(vi);
> > > > > +     }
> > > > > +
> > > > >       return 0;
> > > > >
> > > > >  err_enable_qp:
> > > > > @@ -3381,12 +3411,18 @@ static int virtnet_close(struct net_device *dev)
> > > > >       disable_delayed_refill(vi);
> > > > >       /* Make sure refill_work doesn't re-enable napi! */
> > > > >       cancel_delayed_work_sync(&vi->refill);
> > > > > +     /* Make sure config notification doesn't schedule config work */
> > > >
> > > > it's clear what this does even without a comment.
> > > > what you should comment on, and do not, is *why*.
> > >
> > > Well, it just follows the existing style, for example the above said
> > >
> > > "/* Make sure refill_work doesn't re-enable napi! */"
> >
> > only at the grammar level.
> > you don't see the difference?
> >
> >         /* Make sure refill_work doesn't re-enable napi! */
> >         cancel_delayed_work_sync(&vi->refill);
> >
> > it explains why we cancel: to avoid re-enabling napi.
> >
> > why do you cancel config callback and work?
> > comment should say that.
> 
> Something like "Prevent the config change callback from changing
> carrier after close"?


sounds good.

> >
> >
> >
> > > >
> > > > > +     virtio_config_driver_disable(vi->vdev);
> > > > > +     /* Make sure status updating is cancelled */
> > > >
> > > > same
> > > >
> > > > also what "status updating"? confuses more than this clarifies.
> > >
> > > Does "Make sure the config changed work is cancelled" sounds better?
> >
> > no, this just repeats what code does.
> > explain why you cancel it.
> 
> Does something like "Make sure carrier changes have been done by the
> config change callback" works?
> 
> Thanks

I don't understand what this means.

> >
> >
> >
> > --
> > MST
> >


