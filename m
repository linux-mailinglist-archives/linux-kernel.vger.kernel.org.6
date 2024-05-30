Return-Path: <linux-kernel+bounces-195405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3008C8D4C4C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 15:09:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F6571F2242B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 13:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F482183077;
	Thu, 30 May 2024 13:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OCXn6azv"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB5276F2F3
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 13:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717074577; cv=none; b=awsXF49sPIpUCN9X+ClF75zs7HuTt1JbkrWBWR/d8KtRZrL+2XV2VckKoffE9+enqXqa6KxstaMz/GnQ0t0lOqzszHAtrGjWt8vAdHUAiQVIums7VaNEYpLG/RY8IzqSU/AWS1Jgholf0T/jHeU0iUQqyJYWNFfjSH9wos5l360=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717074577; c=relaxed/simple;
	bh=lYNJdQ0V3/Gcp7v8u0m6JSo1A8R6lWx78f/B4BWszTM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f8xD/UA/f2zEJaKfvaWyV9FUqqj13vIVbQLvaaZlz3AnfZnO6PSao3J6UHMGqfP5X/hjgWNcClzT5bEnQVTP8RrIv8wArfROvfbfWhBvs3RJq6Tz7LGI2E3wbKRo+wr7Xv5OQbgJbIfwTcEtK7syk1j9RPjojVW8oEg+e6ndXCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OCXn6azv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717074574;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I9nGi8qNIfkniqpWSI+fxCxi2UDSD2WgUFS9bKLvDdI=;
	b=OCXn6azv0Jqgli6Peh/2+uxhH0tAsorgJfI321vy5xpKOfd0qqB/El2TB9Fe9Wh7Lxbkem
	0OBfscN7ntpk1DxPCLfo9QWpbVXeGZLLnGcBgG3MlQRzqLnPcTP02Chc7qjupPoc8GpfTT
	VNo73bfqgjLKtmfG9ulI23j89nW4y24=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-435-NV7HzmMpNcazjdY2SMD7RA-1; Thu, 30 May 2024 09:09:32 -0400
X-MC-Unique: NV7HzmMpNcazjdY2SMD7RA-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-35dca4922a4so331165f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 06:09:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717074571; x=1717679371;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I9nGi8qNIfkniqpWSI+fxCxi2UDSD2WgUFS9bKLvDdI=;
        b=s6tTugsvbPEPXJGXoA046oCb7EOJrAP9E2cKKig0bllLmCugSWNlppetqKjkUSnnAC
         a9gMUWSLVzW0gV5Wad0z5TJE/lCNtKBFI3E/opfXBNz2+YzJYmSUbSMi7zukz7HRlMnp
         LD/MyesdZQldIml3rKxUwBNt4aSUyUickSzvi+s1evdMIe9cPitboW0TeCIchUxdcZjz
         FymBzk3Yr1rgVUORIri2CQ/sJisbEAWwtSGYLAd6xaYkRLd6zDYN2kUlyoPXcl0TJCsB
         dmtR9F8itxR48IntQ80BkCrWVjwXvX3dUQsbZ1YEm16Sa5Ur4n1d60MwGTXkV/PqbW6X
         EN3A==
X-Forwarded-Encrypted: i=1; AJvYcCVbcPYJ5acjbT0gCTmrJpU4R3Dtivr0RIsJqBQzfY7MI1GsSFxd4YdSMmHaTwcXDwtErmGyJo0pMuqweprnxXjDESEXTvst4Z6OkS9l
X-Gm-Message-State: AOJu0YzIzX6Kzy7KXbh3xg6WkMRyw7HUs0dHpqyiNv8zIhh7cLu9i6gF
	dC9IAk6GdGumpveABUNgxnOsntrGnQeSrmlhU/Nimgb5MBHklS5t2DLnoysbBQUyNj4OGZskk5V
	gEo0RnPLsw01Mli2nwjHOszKjF9JULJWx/sex+PuJ9nehN6DRYbxXkCL5kva8yw==
X-Received: by 2002:a5d:550e:0:b0:354:df32:69da with SMTP id ffacd0b85a97d-35dc7e3e081mr1620581f8f.14.1717074570885;
        Thu, 30 May 2024 06:09:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGBO25tbyDOl41OKFzuynZI6kqQwz9TH+1XUOCoEVIPxL3Ze93yMi/uikbyOHQnO8vRDvDBBw==
X-Received: by 2002:a5d:550e:0:b0:354:df32:69da with SMTP id ffacd0b85a97d-35dc7e3e081mr1620530f8f.14.1717074570198;
        Thu, 30 May 2024 06:09:30 -0700 (PDT)
Received: from redhat.com ([2.52.145.167])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42127065907sm25070785e9.16.2024.05.30.06.09.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 06:09:29 -0700 (PDT)
Date: Thu, 30 May 2024 09:09:25 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Venkat Venkatsubra <venkat.x.venkatsubra@oracle.com>,
	Gia-Khanh Nguyen <gia-khanh.nguyen@oracle.com>
Subject: Re: [PATCH net-next V2] virtio-net: synchronize operstate with admin
 state on up/down
Message-ID: <20240530090742-mutt-send-email-mst@kernel.org>
References: <20240530032055.8036-1-jasowang@redhat.com>
 <20240530020531-mutt-send-email-mst@kernel.org>
 <CACGkMEun-77fXbQ93H_GEC4=0_7CLq7iPtXSKe9Qriw-Qh1Tbw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEun-77fXbQ93H_GEC4=0_7CLq7iPtXSKe9Qriw-Qh1Tbw@mail.gmail.com>

On Thu, May 30, 2024 at 06:29:51PM +0800, Jason Wang wrote:
> On Thu, May 30, 2024 at 2:10 PM Michael S. Tsirkin <mst@redhat.com> wrote:
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
> > > 3: enp0s3: <BROADCAST,MULTICAST> mtu 1500 qdisc pfifo_fast state DOWN mode DEFAULT group default qlen 1000
> > >     link/ether 00:00:05:00:00:09 brd ff:ff:ff:ff:ff:ff
> > > ......
> > > 5: macvlan0@enp0s3: <BROADCAST,MULTICAST,UP,LOWER_UP,M-DOWN> mtu 1500 qdisc noqueue state UP mode DEFAULT group default qlen 1000
> > >     link/ether b2:a9:c5:04:da:53 brd ff:ff:ff:ff:ff:ff
> > >
> > > After this patch:
> > >
> > > 3: enp0s3: <BROADCAST,MULTICAST> mtu 1500 qdisc pfifo_fast state DOWN mode DEFAULT group default qlen 1000
> > >     link/ether 00:00:05:00:00:09 brd ff:ff:ff:ff:ff:ff
> > > ...
> > > 5: macvlan0@enp0s3: <NO-CARRIER,BROADCAST,MULTICAST,UP,M-DOWN> mtu 1500 qdisc noqueue state LOWERLAYERDOWN mode DEFAULT group default qlen 1000
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
> > >  drivers/net/virtio_net.c | 94 +++++++++++++++++++++++++++-------------
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
> > > +     /* The lock to synchronize the access to config_change_enabled */
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

Well for core it happens on bring up path before driver works
and later on tear down after it is gone.
So I do not think they ever do it at the same time.


> And device enabling on the core is different from bringing the device
> up in the networking subsystem. Here we just delay to deal with the
> config change interrupt on ndo_open(). (E.g try to ack announce is
> meaningless when the device is down).
> 
> Thanks

another thing is that it is better not to re-read all config
on link up if there was no config interrupt - less vm exits.

-- 
MST


