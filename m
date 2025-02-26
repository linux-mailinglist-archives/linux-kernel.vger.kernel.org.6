Return-Path: <linux-kernel+bounces-535053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA1BEA46E3B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 23:11:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F05B93A4134
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 22:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C5A026E63E;
	Wed, 26 Feb 2025 22:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LEugKU2W"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE4A2561D6
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 22:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740607886; cv=none; b=u+Kq36vG+8LYLCX1s2cnPeyK4qcu9Z8wKlghB4y1AN3PiPxDAvql8KFxchIcvbfTt2Yx/ayqxF3ZsN/87Swc7SD5hXJcYDgWn0r0aiZ9IoPmN2X+DWptzMEgPw7yarQ/EAMv8fYTWj0xmqSnOe9UbiwD/Z3mcAgV/pSkgh3vxrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740607886; c=relaxed/simple;
	bh=V++Xmlo2Nswu93mayQmVsWDhp4ss6pyFSfa1fzm2HeM=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BiTbB6W4vCez/uectLfH9I+Uxnao74fmZrpzK+3TDuipjv8Oxzf83usyiimenPk7itZfoidvXZCy46yEdxeLspGKE2/jmMXpZe7CNLN6v8mW6Xeuj+6TaC+ZFPvw2sMoxiPLBkIvEUJvsCLXu4SKoOMztIk7g/SOJ6iaYZPsOoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LEugKU2W; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740607883;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SDLn/itlfNCF0HlLfDkYsSVrwBFlxuyO81r68eizKZU=;
	b=LEugKU2WMJMt+Hxfxagjb0yMraDJiyMbQU2eSDGaPbx8BxHOwTJzGbD+eHZw+BIXaWxw4+
	lgYuSJRoqsQ2Dt3v1WaPMscnrnK7BVUupiKO71caje+ncYlIqo/rvjMat+wYtte2Iljith
	E6dthLxtl80b/hNp9luKY+oR+jXrkdg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-28-STlzqmG7PHakyTaNHf0GUg-1; Wed, 26 Feb 2025 17:11:21 -0500
X-MC-Unique: STlzqmG7PHakyTaNHf0GUg-1
X-Mimecast-MFC-AGG-ID: STlzqmG7PHakyTaNHf0GUg_1740607881
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43947a0919aso3510755e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 14:11:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740607880; x=1741212680;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SDLn/itlfNCF0HlLfDkYsSVrwBFlxuyO81r68eizKZU=;
        b=Pj9H4Aa4ezBuTiph3ocNPowdRCkuketTflp513XGtYgU480HCX+NaxgakaKi4kJbdD
         lhTpFXE6zNtO3e0mfyV1KdacWDuulTiSdgmop+lJD2Ng8HJjRCn+z7LP34TWNx9RtT/M
         Jktb+WPq3ZSCF/7cT2cMnnC6FwlEvs9Zmeusb8XZWbZVZwSDNYH8/vLzggKobrd4GOEz
         kKh+xMJhIBBCJiZL3WfYakiXUuKpfxNGCg4BUZoAfbwDiM+9PyIOc0cIFQbusXcU53mf
         uU8BVbs00GDJulNOMOFz+mgKyGR51ovKHydjtRdGD8Sda5OMV+EKtjcOXOzdGMBTNABT
         0KqA==
X-Forwarded-Encrypted: i=1; AJvYcCWLkSnZZSpcQOZPa4BrgdMWVatJh1CRlQitZ3V1RjqyF23qjEacyGFYS7Y9BbuDccgm+1L/Rr2EoHeArdg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCIDbfM/GtpIxWcj5wIwBRPKMqVl4jJD3qgeqHLeaF+d1/rNKo
	lAegNMoApwohyfPtxxIjqXwZa1adsbNPiJmgHdBcMuzqCnEGF0tLlYDjPp4FcKBu2yWOSLFoExJ
	0LTjBw74k3iNS2mpRhcKetAxJbf6NXLFoSJ4alS56L7YHPihyMw952Eb2T1a8xA==
X-Gm-Gg: ASbGncuVrk1Kg4k6YDVtN3G0lJU8gkNahoR6hjuuTYAa5KHgeKSr9gK4jn/tt2L+NfI
	Z0TY235REQwVpA7jLUka6sv+jBp9mLH2WkB13T8MY4sLJILuwo5QxmXBhySfjmUnyyZNRlauisF
	En9hIrih7dbv/FA8DRgdyFO8eB3Fu3wsIT2NDTNpyiOQx/raSaPLeax/A+rdZai0n+bJTLHl+8M
	91SJD14EM25Wa+oLMBTG/9p71iV/GZfGPZ4S9iA6F3Ve+X7jCqb0cMFk4tR5qAvomgkPnG62eLJ
	zXhcg+drvw==
X-Received: by 2002:a05:600c:3b12:b0:439:86c4:a8ec with SMTP id 5b1f17b1804b1-43ad6834cedmr18689525e9.15.1740607880656;
        Wed, 26 Feb 2025 14:11:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEaelfXZLDUuHI3CpMumlbbQdNQDUp+SKRLlXHIvXK8BQFYRaYdUr1OnrM+q+ZUTw6/bJjjHA==
X-Received: by 2002:a05:600c:3b12:b0:439:86c4:a8ec with SMTP id 5b1f17b1804b1-43ad6834cedmr18689355e9.15.1740607880188;
        Wed, 26 Feb 2025 14:11:20 -0800 (PST)
Received: from redhat.com ([2a02:14f:1eb:e270:8595:184c:7546:3597])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43b7a28bcfdsm2512865e9.40.2025.02.26.14.11.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 14:11:19 -0800 (PST)
Date: Wed, 26 Feb 2025 17:11:15 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Joe Damato <jdamato@fastly.com>, Jason Wang <jasowang@redhat.com>,
	netdev@vger.kernel.org, mkarsten@uwaterloo.ca,
	gerhard@engleder-embedded.com, xuanzhuo@linux.alibaba.com,
	kuba@kernel.org,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	"open list:VIRTIO CORE AND NET DRIVERS" <virtualization@lists.linux.dev>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v4 3/4] virtio-net: Map NAPIs to queues
Message-ID: <20250226171034-mutt-send-email-mst@kernel.org>
References: <20250225020455.212895-1-jdamato@fastly.com>
 <20250225020455.212895-4-jdamato@fastly.com>
 <CACGkMEv6y+TkZnWWLPG4UE59iyREhkiaby8kj==cnp=6chmu+w@mail.gmail.com>
 <Z79XXQjp9Dz7OYYQ@LQ3V64L9R2>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z79XXQjp9Dz7OYYQ@LQ3V64L9R2>

On Wed, Feb 26, 2025 at 01:03:09PM -0500, Joe Damato wrote:
> On Wed, Feb 26, 2025 at 01:48:50PM +0800, Jason Wang wrote:
> > On Tue, Feb 25, 2025 at 10:05 AM Joe Damato <jdamato@fastly.com> wrote:
> > >
> > > Use netif_queue_set_napi to map NAPIs to queue IDs so that the mapping
> > > can be accessed by user apps, taking care to hold RTNL as needed.
> > 
> > I may miss something but I wonder whether letting the caller hold the
> > lock is better.
> 
> Hmm...
> 
> Double checking all the paths over again, here's what I see:
>   - refill_work, delayed work that needs RTNL so this change seems
>     right?
> 
>   - virtnet_disable_queue_pair, called from virtnet_open and
>     virtnet_close. When called via NDO these are safe and hold RTNL,
>     but they can be called from power management and need RTNL.
> 
>   - virtnet_enable_queue_pair called from virtnet_open, safe when
>     used via NDO but needs RTNL when used via power management.
> 
>   - virtnet_rx_pause called in both paths as you mentioned, one
>     which needs RTNL and one which doesn't.
> 
> I think there are a couple ways to fix this:
> 
>   1. Edit this patch to remove the virtnet_queue_set_napi helper,
>      and call netif_queue_set_napi from the napi_enable and
>      napi_disable helpers directly. Modify code calling into these
>      paths to hold rtnl (or not) as described above.
> 
>   2. Modify virtnet_enable_queue_pair, virtnet_disable_queue_pair,
>      and virtnet_rx_pause to take a "bool need_rtnl" as an a
>      function argument and pass that through.
> 
> I'm not sure which is cleaner and I do not have a preference.
> 
> Can you let me know which you prefer? I am happy to implement either
> one for the next revision.


1  seems cleaner.
taking locks depending on paths is confusing

> [...]
> 
> > > ---
> > >  drivers/net/virtio_net.c | 73 ++++++++++++++++++++++++++++------------
> > >  1 file changed, 52 insertions(+), 21 deletions(-)
> > >
> > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > index e578885c1093..13bb4a563073 100644
> > > --- a/drivers/net/virtio_net.c
> > > +++ b/drivers/net/virtio_net.c
> > > @@ -2807,6 +2807,20 @@ static void skb_recv_done(struct virtqueue *rvq)
> > >         virtqueue_napi_schedule(&rq->napi, rvq);
> > >  }
> > >
> > > +static void virtnet_queue_set_napi(struct net_device *dev,
> > > +                                  struct napi_struct *napi,
> > > +                                  enum netdev_queue_type q_type, int qidx,
> > > +                                  bool need_rtnl)
> > > +{
> > > +       if (need_rtnl)
> > > +               rtnl_lock();
> > > +
> > > +       netif_queue_set_napi(dev, qidx, q_type, napi);
> > > +
> > > +       if (need_rtnl)
> > > +               rtnl_unlock();
> > > +}
> > > +
> > >  static void virtnet_napi_do_enable(struct virtqueue *vq,
> > >                                    struct napi_struct *napi)
> > >  {
> > > @@ -2821,15 +2835,21 @@ static void virtnet_napi_do_enable(struct virtqueue *vq,
> > >         local_bh_enable();
> > >  }
> > >
> > > -static void virtnet_napi_enable(struct receive_queue *rq)
> > > +static void virtnet_napi_enable(struct receive_queue *rq, bool need_rtnl)
> > >  {
> > > +       struct virtnet_info *vi = rq->vq->vdev->priv;
> > > +       int qidx = vq2rxq(rq->vq);
> > > +
> > >         virtnet_napi_do_enable(rq->vq, &rq->napi);
> > > +       virtnet_queue_set_napi(vi->dev, &rq->napi,
> > > +                              NETDEV_QUEUE_TYPE_RX, qidx, need_rtnl);
> > >  }
> > >
> > > -static void virtnet_napi_tx_enable(struct send_queue *sq)
> > > +static void virtnet_napi_tx_enable(struct send_queue *sq, bool need_rtnl)
> > >  {
> > >         struct virtnet_info *vi = sq->vq->vdev->priv;
> > >         struct napi_struct *napi = &sq->napi;
> > > +       int qidx = vq2txq(sq->vq);
> > >
> > >         if (!napi->weight)
> > >                 return;
> > > @@ -2843,20 +2863,31 @@ static void virtnet_napi_tx_enable(struct send_queue *sq)
> > >         }
> > >
> > >         virtnet_napi_do_enable(sq->vq, napi);
> > > +       virtnet_queue_set_napi(vi->dev, napi, NETDEV_QUEUE_TYPE_TX, qidx,
> > > +                              need_rtnl);
> > >  }
> > >
> > > -static void virtnet_napi_tx_disable(struct send_queue *sq)
> > > +static void virtnet_napi_tx_disable(struct send_queue *sq, bool need_rtnl)
> > >  {
> > > +       struct virtnet_info *vi = sq->vq->vdev->priv;
> > >         struct napi_struct *napi = &sq->napi;
> > > +       int qidx = vq2txq(sq->vq);
> > >
> > > -       if (napi->weight)
> > > +       if (napi->weight) {
> > > +               virtnet_queue_set_napi(vi->dev, NULL, NETDEV_QUEUE_TYPE_TX,
> > > +                                      qidx, need_rtnl);
> > >                 napi_disable(napi);
> > > +       }
> > >  }
> > >
> > > -static void virtnet_napi_disable(struct receive_queue *rq)
> > > +static void virtnet_napi_disable(struct receive_queue *rq, bool need_rtnl)
> > >  {
> > > +       struct virtnet_info *vi = rq->vq->vdev->priv;
> > >         struct napi_struct *napi = &rq->napi;
> > > +       int qidx = vq2rxq(rq->vq);
> > >
> > > +       virtnet_queue_set_napi(vi->dev, NULL, NETDEV_QUEUE_TYPE_TX, qidx,
> > > +                              need_rtnl);
> > >         napi_disable(napi);
> > >  }
> > >
> > > @@ -2870,9 +2901,9 @@ static void refill_work(struct work_struct *work)
> > >         for (i = 0; i < vi->curr_queue_pairs; i++) {
> > >                 struct receive_queue *rq = &vi->rq[i];
> > >
> > > -               virtnet_napi_disable(rq);
> > > +               virtnet_napi_disable(rq, true);
> > >                 still_empty = !try_fill_recv(vi, rq, GFP_KERNEL);
> > > -               virtnet_napi_enable(rq);
> > > +               virtnet_napi_enable(rq, true);
> > >
> > >                 /* In theory, this can happen: if we don't get any buffers in
> > >                  * we will *never* try to fill again.
> > > @@ -3069,8 +3100,8 @@ static int virtnet_poll(struct napi_struct *napi, int budget)
> > >
> > >  static void virtnet_disable_queue_pair(struct virtnet_info *vi, int qp_index)
> > >  {
> > > -       virtnet_napi_tx_disable(&vi->sq[qp_index]);
> > > -       virtnet_napi_disable(&vi->rq[qp_index]);
> > > +       virtnet_napi_tx_disable(&vi->sq[qp_index], false);
> > > +       virtnet_napi_disable(&vi->rq[qp_index], false);
> > >         xdp_rxq_info_unreg(&vi->rq[qp_index].xdp_rxq);
> > >  }
> > >
> > > @@ -3089,8 +3120,8 @@ static int virtnet_enable_queue_pair(struct virtnet_info *vi, int qp_index)
> > >         if (err < 0)
> > >                 goto err_xdp_reg_mem_model;
> > >
> > > -       virtnet_napi_enable(&vi->rq[qp_index]);
> > > -       virtnet_napi_tx_enable(&vi->sq[qp_index]);
> > > +       virtnet_napi_enable(&vi->rq[qp_index], false);
> > > +       virtnet_napi_tx_enable(&vi->sq[qp_index], false);
> > >
> > >         return 0;
> > >
> > > @@ -3342,7 +3373,7 @@ static void virtnet_rx_pause(struct virtnet_info *vi, struct receive_queue *rq)
> > >         bool running = netif_running(vi->dev);
> > >
> > >         if (running) {
> > > -               virtnet_napi_disable(rq);
> > > +               virtnet_napi_disable(rq, true);
> > 
> > During the resize, the rtnl lock has been held on the ethtool path
> > 
> >         rtnl_lock();
> >         rc = __dev_ethtool(net, ifr, useraddr, ethcmd, state);
> >         rtnl_unlock();
> > 
> > virtnet_rx_resize()
> >     virtnet_rx_pause()
> > 
> > and in the case of XSK binding, I see ASSERT_RTNL in xp_assign_dev() at least.
> 
> Thanks for catching this. I re-read all the paths and I think I've
> outlined a few other issues above.
> 
> Please let me know which of the proposed methods above you'd like me
> to implement to get this merged.
> 
> Thanks.
> 
> ---
> pw-bot: cr


