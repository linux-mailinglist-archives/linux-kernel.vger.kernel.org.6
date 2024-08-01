Return-Path: <linux-kernel+bounces-270662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB8759442F7
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 07:59:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF1DF1C21AAE
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 05:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D80715748B;
	Thu,  1 Aug 2024 05:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FL9EP7O2"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D309E156F5F
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 05:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722491932; cv=none; b=uzIg5h3F22UG2zZqoLikDUXvNyIfesLgATx8P7VewT4awN/9KjXh9/12UXzrDSFFvl5dR3SOu71mKlj413XOKwOgpq8OnVjdJnXCQusu9h9a3JGPC8CM2GX5yOVoSLaO0fnUjRN5lQLyYN4L8y27YNAB0kD0Gs45izsvkRrBi7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722491932; c=relaxed/simple;
	bh=BQeirBRuPNmOYvkj19aFRvVKY+QYqsgfJredh3tRZs0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BnyJ9jdE42rzLy2rJwAET+vEyoDbokG+NNVMtu1ApJOm08KP3fohwWTmWLE3yPLGFKf9Z75LPefLjA9R+aPWa/IOZRj6hSPmeuwNbyju/76RHb6POiuEvAD9Wogb7LAgC5osNiQw2UtMvtNydyAAfkBCx0cfeBXQAiJTTOVSBBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FL9EP7O2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722491929;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TYby3S55PJtaqBnCLpODSNFCjBcgHmHQ8Om5VMgkKMM=;
	b=FL9EP7O2f856VbuA1dM8ujVWh3N6xhcuCJa79TpsH6frRtWyr7eerpGbdU31rd6HjMAvSJ
	w+R1FFhT8n12yQojTKc3oXNuKna4IvcVwTAinK4PCQKPopgiHnOIhlEjnUoqICOIHRSuDo
	hIThxxVCV3z9jzVqZS3s47eKV7xXN2Y=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-tc4EN13mN4u3Oek6iSAreA-1; Thu, 01 Aug 2024 01:58:46 -0400
X-MC-Unique: tc4EN13mN4u3Oek6iSAreA-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-52efe4c2261so8749160e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 22:58:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722491925; x=1723096725;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TYby3S55PJtaqBnCLpODSNFCjBcgHmHQ8Om5VMgkKMM=;
        b=j3E//TwVgaChTvBu+gYSWMx0O+XTPI6zKwTo1MS75C3pO9SGMJ4YUn1bNhCGoQJbuU
         uM1bZ+KHHP3gyAMOk6Hw9OjLKqF0ib1juRAtlAlgPH4+G3mLaHbqFca9REgVoZTbLjbw
         QqPKn9F3KwIkC9iaKHKyiFd8oCiF70+HBWgVO47uACMnNitmeSWa8qjTjBrX3YiX9wgA
         Z8rnQdVZJgUc0saDrwY8BRpYt+KEePeZ/kWX2YXW92tbI43JFKTgCpGWWwwaXB3wlpY5
         FPOfaTwpqs929HQTXq3/0SAeOLJ8RdXoz/xJInyPAhjn/QUfdyvnjVms/Q0AdBERhHzh
         oyYA==
X-Forwarded-Encrypted: i=1; AJvYcCWvWTQrByuE1NSWpy1wymuh6+yxezcrflZihFiDjYuofqibfoNsBzMyn/fdpMd3vRc3KJxgW7mwOWuaUrgErNlVkDTIosihL0/1dFl1
X-Gm-Message-State: AOJu0Yy75fZxNM+ZZ/lL0ewL2+w+L79cOcdze5olLD8OwXk+t4vo+PDR
	qKeXEPlMXAbRDPBw8T6v5Vppjh8KNExaWeWlVpyRfG31lv7LzPEDPNkF3DWuW/lP9k8QvdEd4ec
	2pcUO2GLNy4c04STtLDmqPjsGvSbhXvYshZg1eFboUuVIPy+Us81Q831wYAOndg==
X-Received: by 2002:a05:6512:4008:b0:52c:83c7:936a with SMTP id 2adb3069b0e04-530b61fec2cmr1028197e87.42.1722491924839;
        Wed, 31 Jul 2024 22:58:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFdBq5LsXMOtvElE6EOfY6fVtQyD07R6xmuzAO4uy70HRKTviw+Ngzs8GylVhzOCWgj7uUzpg==
X-Received: by 2002:a05:6512:4008:b0:52c:83c7:936a with SMTP id 2adb3069b0e04-530b61fec2cmr1028165e87.42.1722491923947;
        Wed, 31 Jul 2024 22:58:43 -0700 (PDT)
Received: from redhat.com ([2.55.44.248])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acad41479sm849692166b.123.2024.07.31.22.58.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 22:58:43 -0700 (PDT)
Date: Thu, 1 Aug 2024 01:58:36 -0400
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
Message-ID: <20240801015344-mutt-send-email-mst@kernel.org>
References: <20240731025947.23157-1-jasowang@redhat.com>
 <20240731025947.23157-4-jasowang@redhat.com>
 <20240731172020-mutt-send-email-mst@kernel.org>
 <CACGkMEvXfZJbCs0Fyi3EdYja37+D-o+79csXJYsBo0s+j2e5iA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACGkMEvXfZJbCs0Fyi3EdYja37+D-o+79csXJYsBo0s+j2e5iA@mail.gmail.com>

On Thu, Aug 01, 2024 at 10:16:00AM +0800, Jason Wang wrote:
> > > @@ -2885,6 +2886,25 @@ static void virtnet_cancel_dim(struct virtnet_info *vi, struct dim *dim)
> > >       net_dim_work_cancel(dim);
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
> >
> > I already commented on this approach.  This is now invoked on each open,
> > lots of extra VM exits. No bueno, people are working hard to keep setup
> > overhead under control. Handle this in the config change interrupt -
> > your new infrastructure is perfect for this.
> 
> No, in this version it doesn't. Config space read only happens if
> there's a pending config interrupt during ndo_open:
> 
> +       if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_STATUS)) {
> +               if (vi->status & VIRTIO_NET_S_LINK_UP)
> +                       netif_carrier_on(vi->dev);
> +               virtio_config_driver_enable(vi->vdev);
> +       } else {
> +               vi->status = VIRTIO_NET_S_LINK_UP;
> +               netif_carrier_on(dev);
> +               virtnet_update_settings(vi);
> +       }

Sorry for being unclear, I was referring to !VIRTIO_NET_F_STATUS.
I do not see why do we need to bother re-reading settings in this case at all,
status is not there, nothing much changes.


> >
> >
> > >  static int virtnet_open(struct net_device *dev)
> > >  {
> > >       struct virtnet_info *vi = netdev_priv(dev);
> > > @@ -2903,6 +2923,16 @@ static int virtnet_open(struct net_device *dev)
> > >                       goto err_enable_qp;
> > >       }
> > >
> > > +     if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_STATUS)) {
> > > +             if (vi->status & VIRTIO_NET_S_LINK_UP)
> > > +                     netif_carrier_on(vi->dev);
> > > +             virtio_config_driver_enable(vi->vdev);
> > > +     } else {
> > > +             vi->status = VIRTIO_NET_S_LINK_UP;
> > > +             netif_carrier_on(dev);
> > > +             virtnet_update_settings(vi);
> > > +     }
> > > +
> > >       return 0;
> > >
> > >  err_enable_qp:
> > > @@ -3381,12 +3411,18 @@ static int virtnet_close(struct net_device *dev)
> > >       disable_delayed_refill(vi);
> > >       /* Make sure refill_work doesn't re-enable napi! */
> > >       cancel_delayed_work_sync(&vi->refill);
> > > +     /* Make sure config notification doesn't schedule config work */
> >
> > it's clear what this does even without a comment.
> > what you should comment on, and do not, is *why*.
> 
> Well, it just follows the existing style, for example the above said
> 
> "/* Make sure refill_work doesn't re-enable napi! */"

only at the grammar level.
you don't see the difference?

        /* Make sure refill_work doesn't re-enable napi! */
        cancel_delayed_work_sync(&vi->refill);

it explains why we cancel: to avoid re-enabling napi.

why do you cancel config callback and work?
comment should say that.



> >
> > > +     virtio_config_driver_disable(vi->vdev);
> > > +     /* Make sure status updating is cancelled */
> >
> > same
> >
> > also what "status updating"? confuses more than this clarifies.
> 
> Does "Make sure the config changed work is cancelled" sounds better?

no, this just repeats what code does.
explain why you cancel it.



-- 
MST


