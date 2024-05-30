Return-Path: <linux-kernel+bounces-195346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CCA58D4B56
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 14:12:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94E811F2689A
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 12:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4D2A1822DD;
	Thu, 30 May 2024 12:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EYR75etd"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 692881822D4
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 12:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717071152; cv=none; b=nGfeOvPSvCfbHyJfKCDI42MAGn0kdm2AtgHSYYI0wcBd8QnHxmT3OTj+SNugVLTOGcqY2txweus+X69CUSAQNbFJvlJJArEFdVXO5bLqPBv4B1mbWBKHypttW/5sgIbszr6Y5Lbb6QB4yt6u9p1Gfp+DJ9P+skwI319WAE/zXUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717071152; c=relaxed/simple;
	bh=xmIVpAopZsJ2ZtPSpEgRALCQGLbG0A1e9zqWQ/sIFc0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gpGGTDjAFzKNryeAtPtqNbG/8W5b7urycWH1Q9+q5sbDblql/lmxykWM8k2OGK1rz/ELvAon+03f4i/dI4XRIbLoPvjRiIs3N7/rBiewHyXuRC7qsiFbSeoHs8puR91UoCfqefRGEP+riQZBWwmmMVdlDcq9wwdCeHy/oSxgWVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EYR75etd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717071149;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U4ZPonxQfUaxHPhmUO2CXQCo0FNADvYEXeFvyWukAwU=;
	b=EYR75etd3CPunOSDC3Y/YCGrVbKelpEQkBA09oWIWnpwmLHaP8h7E+QF7GhY7/jljfnGe8
	dt40F7vllw59yNu0pQWThCtl0NDUmYNB8/JnvrQNWOHG+JVWSZXPqiFxlgu8vvlKmIrTSv
	Jv60fWflcmdVEBowsyZt2A5qqRnmZ9g=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-29-54Gj-fuqPAC98txoUbw1pw-1; Thu, 30 May 2024 08:12:28 -0400
X-MC-Unique: 54Gj-fuqPAC98txoUbw1pw-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2c1b17995e5so393908a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 05:12:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717071147; x=1717675947;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U4ZPonxQfUaxHPhmUO2CXQCo0FNADvYEXeFvyWukAwU=;
        b=PfSt01LJFuDGNMBxrgBhuPi4Ew2cTv5xLawcMjh2Eih4KstgJsPUAlwnFU60qgfkMc
         oW4U4AUCwxmt4rLlrgr5E6jFKcsCTvi12JyvYEMdUtplIz2rmAUinH9Kzekpg9o7eGtz
         CCzGbwhczTgr8xK9Y5gRlQ6Z4L8oKz1MUOz3OZNRevvrALj9C6v6RuxvGf348QDb1so6
         HhdRsznG2xMiwQHXk06xt0vOOkMKjeEYUZ6cxjqbkcghxAi5tp1m+GnZp6ikm4ZDLXIA
         eGBdreBSjiMCuHy4ZEvey70gZ/dBgQ5M4AnoZDl4r32RuJl34Gg6B2T54wljerkRSLXS
         4a+A==
X-Forwarded-Encrypted: i=1; AJvYcCU7/X6tE5K4YCSWslHaZfwsYhOyI6lssJOad86s4ytbqNNONNUSGjbV7YotC3KTvGHvGcpnxkQuMVKGmG2dcMhl2z8OZBu3tMW3R3FL
X-Gm-Message-State: AOJu0Yy/K4+lzol8tibVNVbup0O4e0/OfvWKUnH0bERI/Egi+aFOv7m3
	Llt1JfmO7Fllx7isI8cfnzXY8XZ4ersuBuNYe34NnkPrJwBPJH80iitU5zJYsJXlvZ9P7YlXYZQ
	CuHdyWYDU9SiWyBnrypr6SA78N0qqOjCluIhIpOr4RnA+zG1ppup/UlBEcwQ8e6jxzNwS2Q8iVv
	82ntJ7yM3Xjx/far6vBfgDOLr/EgaL49N6BQR3
X-Received: by 2002:a17:90b:1a85:b0:2a2:7a00:f101 with SMTP id 98e67ed59e1d1-2c1abc4a2d9mr1568046a91.47.1717071147183;
        Thu, 30 May 2024 05:12:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHxiVaGL5dfbdmmXh78ZPfATcru6UOjzaDGxFpxTSHh+NfsQAtdCSWJBv1oUf0a1JwZWKCpqfTxjfOGrN4uByQ=
X-Received: by 2002:a17:90b:1a85:b0:2a2:7a00:f101 with SMTP id
 98e67ed59e1d1-2c1abc4a2d9mr1568027a91.47.1717071146795; Thu, 30 May 2024
 05:12:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240530032055.8036-1-jasowang@redhat.com> <20240530020531-mutt-send-email-mst@kernel.org>
 <CACGkMEun-77fXbQ93H_GEC4=0_7CLq7iPtXSKe9Qriw-Qh1Tbw@mail.gmail.com>
In-Reply-To: <CACGkMEun-77fXbQ93H_GEC4=0_7CLq7iPtXSKe9Qriw-Qh1Tbw@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 30 May 2024 20:12:15 +0800
Message-ID: <CACGkMEt__DPnyTOU8Z-u=pFROVaAeHFKm0t5XtHpZq3o7j+dEg@mail.gmail.com>
Subject: Re: [PATCH net-next V2] virtio-net: synchronize operstate with admin
 state on up/down
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Venkat Venkatsubra <venkat.x.venkatsubra@oracle.com>, 
	Gia-Khanh Nguyen <gia-khanh.nguyen@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 30, 2024 at 6:29=E2=80=AFPM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Thu, May 30, 2024 at 2:10=E2=80=AFPM Michael S. Tsirkin <mst@redhat.co=
m> wrote:
> >
> > On Thu, May 30, 2024 at 11:20:55AM +0800, Jason Wang wrote:
> > > This patch synchronize operstate with admin state per RFC2863.
> > >
> > > This is done by trying to toggle the carrier upon open/close and
> > > synchronize with the config change work. This allows propagate status
> > > correctly to stacked devices like:
> > >
> > > ip link add link enp0s3 macvlan0 type macvlan
> > > ip link set link enp0s3 down
> > > ip link show
> > >
> > > Before this patch:
> > >
> > > 3: enp0s3: <BROADCAST,MULTICAST> mtu 1500 qdisc pfifo_fast state DOWN=
 mode DEFAULT group default qlen 1000
> > >     link/ether 00:00:05:00:00:09 brd ff:ff:ff:ff:ff:ff
> > > ......
> > > 5: macvlan0@enp0s3: <BROADCAST,MULTICAST,UP,LOWER_UP,M-DOWN> mtu 1500=
 qdisc noqueue state UP mode DEFAULT group default qlen 1000
> > >     link/ether b2:a9:c5:04:da:53 brd ff:ff:ff:ff:ff:ff
> > >
> > > After this patch:
> > >
> > > 3: enp0s3: <BROADCAST,MULTICAST> mtu 1500 qdisc pfifo_fast state DOWN=
 mode DEFAULT group default qlen 1000
> > >     link/ether 00:00:05:00:00:09 brd ff:ff:ff:ff:ff:ff
> > > ...
> > > 5: macvlan0@enp0s3: <NO-CARRIER,BROADCAST,MULTICAST,UP,M-DOWN> mtu 15=
00 qdisc noqueue state LOWERLAYERDOWN mode DEFAULT group default qlen 1000
> > >     link/ether b2:a9:c5:04:da:53 brd ff:ff:ff:ff:ff:ff
> > >
> > > Cc: Venkat Venkatsubra <venkat.x.venkatsubra@oracle.com>
> > > Cc: Gia-Khanh Nguyen <gia-khanh.nguyen@oracle.com>
> > > Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > Acked-by: Michael S. Tsirkin <mst@redhat.com>
> > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > ---
> > > Changes since V1:
> > > - rebase
> > > - add ack/review tags
> >
> >
> >
> >
> >
> > > ---
> > >  drivers/net/virtio_net.c | 94 +++++++++++++++++++++++++++-----------=
--
> > >  1 file changed, 63 insertions(+), 31 deletions(-)
> > >
> > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > index 4a802c0ea2cb..69e4ae353c51 100644
> > > --- a/drivers/net/virtio_net.c
> > > +++ b/drivers/net/virtio_net.c
> > > @@ -433,6 +433,12 @@ struct virtnet_info {
> > >       /* The lock to synchronize the access to refill_enabled */
> > >       spinlock_t refill_lock;
> > >
> > > +     /* Is config change enabled? */
> > > +     bool config_change_enabled;
> > > +
> > > +     /* The lock to synchronize the access to config_change_enabled =
*/
> > > +     spinlock_t config_change_lock;
> > > +
> > >       /* Work struct for config space updates */
> > >       struct work_struct config_work;
> > >
> >
> >
> > But we already have dev->config_lock and dev->config_enabled.
> >
> > And it actually works better - instead of discarding config
> > change events it defers them until enabled.
> >
>
> Yes but then both virtio-net driver and virtio core can ask to enable
> and disable and then we need some kind of synchronization which is
> non-trivial.
>
> And device enabling on the core is different from bringing the device
> up in the networking subsystem. Here we just delay to deal with the
> config change interrupt on ndo_open(). (E.g try to ack announce is
> meaningless when the device is down).

Or maybe you meant to make config_enabled a nest counter?

Thanks

>
> Thanks


