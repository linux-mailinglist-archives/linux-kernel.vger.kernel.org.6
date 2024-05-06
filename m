Return-Path: <linux-kernel+bounces-169277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 621B48BC632
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 05:24:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93B951C20FA5
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 03:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E519543156;
	Mon,  6 May 2024 03:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WXJq8JDl"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7591541C62
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 03:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714965883; cv=none; b=R6P9xJkuDtMcMYncI2mHjmnOJibOE91O1pe1GhvElLjMOSkNqPdQPOklbolS9lR8Dmo4wHj/E6vfWAL338KJQfgQ87WHY15oocI0q53CQXHzZpWuza3FJ8/x+HRsNgvPc05byXhREK//0+ibKKd0E5L2POFvZCixegK7JKdLP4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714965883; c=relaxed/simple;
	bh=bBHRYR+zXOeAjZ6EPCrBlhNWwq4VARwBFLo2xTUGLZU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NlanfcaY7ycE/DTdPLDgRKKn/1ZQXEwtJjE8hKcZcUUyHJwBWKFLsmoD9uyI4BWRorjMLilYbktu2QaGSsdW43HAF1ftRJdQBArzE+6LBodRkVwyIS3yR0Cfp+lSVC8NW4ix+8efW9JH1FjsectT9b66stmFMJYO26SbSfA7v+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WXJq8JDl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714965880;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BXECy0j7At+OptqnyBfrJG9H7LKgIkADB2rySsLldvo=;
	b=WXJq8JDlWzX2RreasT/YGBM98hdl/Ps6Nslp+qsHicoB3wDUpJVbd28NgUA3uM2svU9kWM
	1bF5ZbqLs7sMebBejVEygyQYgHl/StRkfX0QWPz0Vz4ndVVRF/XohxGAqpAuFGakyU3aHD
	wlbKwPhLpS6D+aU4vQdMHqkdfAz/pUs=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-99-aYAIwLLaPAGfzRGgbYdt0g-1; Sun, 05 May 2024 23:24:38 -0400
X-MC-Unique: aYAIwLLaPAGfzRGgbYdt0g-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2acf6bce4cfso1151811a91.0
        for <linux-kernel@vger.kernel.org>; Sun, 05 May 2024 20:24:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714965878; x=1715570678;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BXECy0j7At+OptqnyBfrJG9H7LKgIkADB2rySsLldvo=;
        b=QiwXGJ9uuYQ85AyqJZF9VlzLNP+mrOyciR2g/gaMw3Snj4n3FsBJ/6saaX51/JvjPF
         HXMRL2/PIoZWHYfijZ8+APeOMGGOf2KP2voUiFpZLtqG10cQYK7N/Nrlqoe1JmBj//Mo
         K4a286fUZ6NXGRflJ6/sSPFZqN22AnC+FguOdYVT54PebTE62xIIj10eFpBxWEDgL5sf
         154TCavjCmD+tN8O2tf59uTtXaB3vFTEsaV2t+EFylHBAxKUSd8MBWImVzpsROfKuMJ1
         ZjgG9HobSlabFMBgg8TKUdLESdChE+04/rZy93KvF2OmemxvE6ECVp7EO6nukE3zfc+x
         ylBw==
X-Forwarded-Encrypted: i=1; AJvYcCXQzipAX6T+/cKuUZ9xTjoHqctydTnxoAAKrH7dIOXPLu2+HZNRdV0T4qoRYMbgmX5nW84kxUj3SwcNvX1OaORW7iC097ME04l79+sp
X-Gm-Message-State: AOJu0YxPeMjy5EW1jZZJG6IpXrt5Jvl1YuX6esAYXlFagg9rLsxuqEoJ
	HpzxNfU7wRxRmiw6JUyLjE2k5JadD/iZSYVrBhq8+SMfVik0BPZZm6qfHuxUwbg/Hjgrmae/8rw
	Plk50QP+xEwAVx83Vc1pr2w6QXL4GUgPoOH4sOrx1sg2Nyh2yWf/Ah9FOGdUF42lbqJ6WnUyFfO
	WhhFCyzDBwE8VBwWZtFE1ACNSdkSv26IxcsNa4
X-Received: by 2002:a17:90b:19cc:b0:2b2:da7:2c83 with SMTP id nm12-20020a17090b19cc00b002b20da72c83mr12511965pjb.4.1714965877777;
        Sun, 05 May 2024 20:24:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHsgR09huJq7794Kr7Va7gw9HzoZRK/fRVHd00z788cM7NjAkL3DywsEKb+A/xOZDmoDbwkRNX9xodgt7fyblY=
X-Received: by 2002:a17:90b:19cc:b0:2b2:da7:2c83 with SMTP id
 nm12-20020a17090b19cc00b002b20da72c83mr12511949pjb.4.1714965877400; Sun, 05
 May 2024 20:24:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZjFH7Xb5gyTtOpWd@localhost.localdomain> <20240430121730-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240430121730-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 6 May 2024 11:24:25 +0800
Message-ID: <CACGkMEsFMXdswxgguH1P_TkY9wnKgE8RbhUdw_Pd+niSp2UjSg@mail.gmail.com>
Subject: Re: [PATCH] virtio_net: Warn if insufficient queue length for transmitting
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Darius Rad <darius@bluespec.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 1, 2024 at 4:07=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com> =
wrote:
>
> On Tue, Apr 30, 2024 at 03:35:09PM -0400, Darius Rad wrote:
> > The transmit queue is stopped when the number of free queue entries is =
less
> > than 2+MAX_SKB_FRAGS, in start_xmit().  If the queue length (QUEUE_NUM_=
MAX)
> > is less than then this, transmission will immediately trigger a netdev
> > watchdog timeout.  Report this condition earlier and more directly.
> >
> > Signed-off-by: Darius Rad <darius@bluespec.com>
> > ---
> >  drivers/net/virtio_net.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index 115c3c5414f2..72ee8473b61c 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -4917,6 +4917,9 @@ static int virtnet_probe(struct virtio_device *vd=
ev)
> >                       set_bit(guest_offloads[i], &vi->guest_offloads);
> >       vi->guest_offloads_capable =3D vi->guest_offloads;
> >
> > +     if (virtqueue_get_vring_size(vi->sq->vq) < 2 + MAX_SKB_FRAGS)
> > +             netdev_warn_once(dev, "not enough queue entries, expect x=
mit timeout\n");
> > +
>
> How about actually fixing it though? E.g. by linearizing...

Actually, the linearing is only needed for the case when the indirect
descriptor is not supported.

>
> It also bothers me that there's practically
> /proc/sys/net/core/max_skb_frags
> and if that's low then things could actually work.

Probably not as it won't exceed MAX_SKB_FRAGS.

>
> Finally, while originally it was just 17 typically, now it's
> configurable. So it's possible that you change the config to make big
> tcp

Note that virtio-net doesn't fully support big TCP.

> work better and device stops working while it worked fine
> previously.

For this patch, I guess not as we had:

        if (sq->vq->num_free < 2+MAX_SKB_FRAGS)

in the tx path. So it won't even work before this patch.

Thanks

>
>
> >       pr_debug("virtnet: registered device %s with %d RX and TX vq's\n"=
,
> >                dev->name, max_queue_pairs);
> >
> > --
> > 2.39.2
>


