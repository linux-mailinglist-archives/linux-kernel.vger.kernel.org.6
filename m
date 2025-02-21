Return-Path: <linux-kernel+bounces-524993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BDE8A3E993
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 02:01:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 252D270215A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 00:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6562A155C96;
	Fri, 21 Feb 2025 00:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hE8WTpkl"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4533136E37
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 00:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740099362; cv=none; b=rw8EBCHr8yA9KAbOKDm4u6HZFCfuV1XuYYPq6JMaM5C4iXnuzPYcNO5IZl9fvgTLIIR5ebxeIBLBgtE07RdMmbXq68buKrbzzsBJT18mNDyloTYT59NJy0XWVl4lGiiQWWenwcreOJ+AnB9e8E4b0m800wMjQqFKhYI0nInKpEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740099362; c=relaxed/simple;
	bh=fV1mBsSJF2DsjbNy6DP++8YFbTYKXele61nzgQiiQfo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aSVsTlXJiXmXcuO+TDAMfK8DzYpwv9OO5eQJXqY/TirM2jHZEH2KUBaoewiGbAu0QPs16v0mcERS6LY1J6wTPCLzhQfq8WL9j1rVQMulSpoioYblnmA1svSb6vPtDQxREST11h9+UsaYrEaAK34TsS1FkjfA6qu5DQmdIgNS0+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hE8WTpkl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740099359;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GNy7L+vuP5BvqDAnGLHquOls1vdb8Cwyy2NuM7jwo8I=;
	b=hE8WTpklaKYYydSiMgb+SPOnduz4EKCm12Us3wEygYzZPFJGZqA5699ZBG+Y9AlJfxxEzX
	uQIpQWh0Z89CJ5Wilk+/cOi9FVVIvHn6XmpeCxx3bkbFFmfA7IgoBQ2ZfANWfL7ABzzmH7
	TtQ0n4F4OYJ+8Lm8cr/TPdVQ65Z27Ds=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-R7L8FPSRPY-eob-mCkhyKQ-1; Thu, 20 Feb 2025 19:55:56 -0500
X-MC-Unique: R7L8FPSRPY-eob-mCkhyKQ-1
X-Mimecast-MFC-AGG-ID: R7L8FPSRPY-eob-mCkhyKQ_1740099355
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-22101351b1dso31541675ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 16:55:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740099355; x=1740704155;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GNy7L+vuP5BvqDAnGLHquOls1vdb8Cwyy2NuM7jwo8I=;
        b=affYPKnQYqHYHJNF0i5U03vTRRCJZ4A77hWueW97yey9upy6en75lL+wDSURfiQPvr
         fbEQFQlQsncVqeW54XMgEOTTXmwithLjRlPJqGRlfUHCI97ZU4fG5PrRl29y2keqCvsN
         ul7Vi/RPepneSwHkLMw9ERhVMctfTERWBedvqWz5D5df/2jeaShZXUrNavm9bnGjHSMA
         flrwoxNdBqwFhVXwwW/umMePhJyjJF/z/ejLXq0053RPlQb3M9UZevL6N81s/mygMhkp
         eLZPWgilylPAYGiiHfR9VvF80wASqi5usX0rElRYDLeMQfXksAOMDkBFpZNaAXclBUUt
         2k9Q==
X-Forwarded-Encrypted: i=1; AJvYcCVC+CH1Jtt10PEFpRuiFiMBvuZXL5K3gj8xta0VM3DVhZQ11Xi9qTFpAuyxX39wR780SrMu5y0XTbNMDeM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRdZ8nVFnLEmM1xpKb+veREoPqD4JQD+MKy1Q/5FLj8n89uihO
	FHS1bj4gBuFHTrgEV/F2E6SSJH1fYIQ+LrYEVnG04sYGMWz6WYqp4jTD/0HbT6K62puQfhpTb/n
	K6+iI3JE5DfWhpCWKh2capFN/xr1snUaGIgj4YT47ax1cfS2j3jy2mlk3NQzbVCP/F/8Wa+WxhG
	sCKqkMmZbgc6VLo68NXaDo+jZWkhNCKr95JN5W
X-Gm-Gg: ASbGnctxrHz/WfrJUkZLfQu/AFxWBG/t0GAUTLXIyO9tYV6rODjv333LrJru441FWSj
	H6FD/YpMkKnJZY2rp1cxgeI17UCjYN+xmkL2l/VMlU1Umi/WMpxtHsBbhbYju7YY=
X-Received: by 2002:a17:902:f689:b0:20d:cb6:11e with SMTP id d9443c01a7336-2219ff61211mr16249605ad.26.1740099355259;
        Thu, 20 Feb 2025 16:55:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH8S4q180J8wfgz6tGusfQ0NQthsbHXXSQU0QZSoirAYrGPHl9rkncJDp+BBTc7oqXXlufQB9c7G3k1LOo8rO8=
X-Received: by 2002:a17:902:f689:b0:20d:cb6:11e with SMTP id
 d9443c01a7336-2219ff61211mr16249265ad.26.1740099354751; Thu, 20 Feb 2025
 16:55:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250218023908.1755-1-jasowang@redhat.com> <20250220162359-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250220162359-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 21 Feb 2025 08:55:30 +0800
X-Gm-Features: AWEUYZm8_TusPuJH3xQ4ETsht6VJ5b0urYN8Wvwj2tbdPnWKqkMznfIIszOdZiA
Message-ID: <CACGkMEueUcag6ETNqjPeCaKAird8E9P8JutSmtyOPrGeyaMtpg@mail.gmail.com>
Subject: Re: [PATCH net-next] virtio-net: tweak for better TX performance in
 NAPI mode
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 21, 2025 at 5:25=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Tue, Feb 18, 2025 at 10:39:08AM +0800, Jason Wang wrote:
> > There are several issues existed in start_xmit():
> >
> > - Transmitted packets need to be freed before sending a packet, this
> >   introduces delay and increases the average packets transmit
> >   time. This also increase the time that spent in holding the TX lock.
> > - Notification is enabled after free_old_xmit_skbs() which will
> >   introduce unnecessary interrupts if TX notification happens on the
> >   same CPU that is doing the transmission now (actually, virtio-net
> >   driver are optimized for this case).
> >
> > So this patch tries to avoid those issues by not cleaning transmitted
> > packets in start_xmit() when TX NAPI is enabled and disable
> > notifications even more aggressively. Notification will be since the
> > beginning of the start_xmit(). But we can't enable delayed
> > notification after TX is stopped as we will lose the
> > notifications. Instead, the delayed notification needs is enabled
> > after the virtqueue is kicked for best performance.
> >
> > Performance numbers:
> >
> > 1) single queue 2 vcpus guest with pktgen_sample03_burst_single_flow.sh
> >    (burst 256) + testpmd (rxonly) on the host:
> >
> > - When pinning TX IRQ to pktgen VCPU: split virtqueue PPS were
> >   increased 55% from 6.89 Mpps to 10.7 Mpps and 32% TX interrupts were
> >   eliminated. Packed virtqueue PPS were increased 50% from 7.09 Mpps to
> >   10.7 Mpps, 99% TX interrupts were eliminated.
> >
> > - When pinning TX IRQ to VCPU other than pktgen: split virtqueue PPS
> >   were increased 96% from 5.29 Mpps to 10.4 Mpps and 45% TX interrupts
> >   were eliminated; Packed virtqueue PPS were increased 78% from 6.12
> >   Mpps to 10.9 Mpps and 99% TX interrupts were eliminated.
> >
> > 2) single queue 1 vcpu guest + vhost-net/TAP on the host: single
> >    session netperf from guest to host shows 82% improvement from
> >    31Gb/s to 58Gb/s, %stddev were reduced from 34.5% to 1.9% and 88%
> >    of TX interrupts were eliminated.
> >
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
>
>
> okay
>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
>
> but tell me something, would it be even better to schedule
> napi once, and have that deal with enabling notifications?

I'm not sure I will get here, if we know a NAPI is scheduled, any
reason for enabling notifications?

Thanks

>
> > ---
> >  drivers/net/virtio_net.c | 45 ++++++++++++++++++++++++++++------------
> >  1 file changed, 32 insertions(+), 13 deletions(-)
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index 7646ddd9bef7..ac26a6201c44 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -1088,11 +1088,10 @@ static bool is_xdp_raw_buffer_queue(struct virt=
net_info *vi, int q)
> >               return false;
> >  }
> >
> > -static void check_sq_full_and_disable(struct virtnet_info *vi,
> > -                                   struct net_device *dev,
> > -                                   struct send_queue *sq)
> > +static bool tx_may_stop(struct virtnet_info *vi,
> > +                     struct net_device *dev,
> > +                     struct send_queue *sq)
> >  {
> > -     bool use_napi =3D sq->napi.weight;
> >       int qnum;
> >
> >       qnum =3D sq - vi->sq;
> > @@ -1114,6 +1113,25 @@ static void check_sq_full_and_disable(struct vir=
tnet_info *vi,
> >               u64_stats_update_begin(&sq->stats.syncp);
> >               u64_stats_inc(&sq->stats.stop);
> >               u64_stats_update_end(&sq->stats.syncp);
> > +
> > +             return true;
> > +     }
> > +
> > +     return false;
> > +}
> > +
> > +static void check_sq_full_and_disable(struct virtnet_info *vi,
> > +                                   struct net_device *dev,
> > +                                   struct send_queue *sq)
> > +{
> > +     bool use_napi =3D sq->napi.weight;
> > +     int qnum;
> > +
> > +     qnum =3D sq - vi->sq;
> > +
> > +     if (tx_may_stop(vi, dev, sq)) {
> > +             struct netdev_queue *txq =3D netdev_get_tx_queue(dev, qnu=
m);
> > +
> >               if (use_napi) {
> >                       if (unlikely(!virtqueue_enable_cb_delayed(sq->vq)=
))
> >                               virtqueue_napi_schedule(&sq->napi, sq->vq=
);
> > @@ -3253,15 +3271,10 @@ static netdev_tx_t start_xmit(struct sk_buff *s=
kb, struct net_device *dev)
> >       bool use_napi =3D sq->napi.weight;
> >       bool kick;
> >
> > -     /* Free up any pending old buffers before queueing new ones. */
> > -     do {
> > -             if (use_napi)
> > -                     virtqueue_disable_cb(sq->vq);
> > -
> > +     if (!use_napi)
> >               free_old_xmit(sq, txq, false);
> > -
> > -     } while (use_napi && !xmit_more &&
> > -            unlikely(!virtqueue_enable_cb_delayed(sq->vq)));
> > +     else
> > +             virtqueue_disable_cb(sq->vq);
> >
> >       /* timestamp packet in software */
> >       skb_tx_timestamp(skb);
> > @@ -3287,7 +3300,10 @@ static netdev_tx_t start_xmit(struct sk_buff *sk=
b, struct net_device *dev)
> >               nf_reset_ct(skb);
> >       }
> >
> > -     check_sq_full_and_disable(vi, dev, sq);
> > +     if (use_napi)
> > +             tx_may_stop(vi, dev, sq);
> > +     else
> > +             check_sq_full_and_disable(vi, dev,sq);
> >
> >       kick =3D use_napi ? __netdev_tx_sent_queue(txq, skb->len, xmit_mo=
re) :
> >                         !xmit_more || netif_xmit_stopped(txq);
> > @@ -3299,6 +3315,9 @@ static netdev_tx_t start_xmit(struct sk_buff *skb=
, struct net_device *dev)
> >               }
> >       }
> >
> > +     if (use_napi && kick && unlikely(!virtqueue_enable_cb_delayed(sq-=
>vq)))
> > +             virtqueue_napi_schedule(&sq->napi, sq->vq);
> > +
> >       return NETDEV_TX_OK;
> >  }
> >
> > --
> > 2.34.1
>


