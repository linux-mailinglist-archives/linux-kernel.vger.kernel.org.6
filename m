Return-Path: <linux-kernel+bounces-216610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C089890A213
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 03:52:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DD121F24B50
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 01:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28F58170859;
	Mon, 17 Jun 2024 01:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JW03Qjkb"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A1716131C
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 01:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718589033; cv=none; b=hZ8X11GOBZZiJFKQJT2o3RszGMa8KXKW+X/NzU4nlNSmEJCBkFxbw1skxlhYhUPSNjN8Pfxgz9ZTkSCgdRjOkpK8SdMTTFpg0nJ4QCRDjhIyaDoyeiWPXzTrfZLQEjL8o6nFRfWS6L3gTETaINgsEDqK8wjrBqnHGdQ+7Qk+0yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718589033; c=relaxed/simple;
	bh=S/eCGNow7bSLOSxc4Fn8MLZDHmPnq7z++CG3pe6YBm8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dHmbY8HGL9aoL1X2ONxqJGscxLVjGoxmZ/Wrp+aAFPXj6zkGn2MtQxNeTCwzczgdL0zvxEE0TshjloKCU3PSdBTQVtL+0TDYs/oTmDYQIExKtE7musy5pZjSobi1MhzDRQLJi7Z1BAWMYpdKscztv9LYUwOpTvMinXu67N9YQ0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JW03Qjkb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718589030;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=enLk9HBzEHTcsjLuiFUFXs3G9hkw9wMVk66unL1i+tU=;
	b=JW03QjkbJ+OQPzQvJyNZofnbRekOB5XNIPBDfXW/eBZydsLbHIHZSy/OMAoXGYg2Ow8Zg/
	hCpW72voIaAUpBz8bnICz3O7WiHS85uLH4DaMbs9CVlRNbRjnwpGhuURrn9jh+ADayzIOb
	ncDxX+4O0ofA7MMABI8/zxFP4W0FXDs=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-347-FdnJuau_MbC8zIgwzDhgMQ-1; Sun, 16 Jun 2024 21:50:29 -0400
X-MC-Unique: FdnJuau_MbC8zIgwzDhgMQ-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2c534edb860so193953a91.1
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jun 2024 18:50:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718589028; x=1719193828;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=enLk9HBzEHTcsjLuiFUFXs3G9hkw9wMVk66unL1i+tU=;
        b=CZnv7PmOs9E9LQx5chdpQ2SlvJkLm1LX467R/ha1ZtcTMG+lQVPlRbJg3MgA34fUNn
         58bf2/ZY4VBwZsLimZaNE7a632sA5r3Dd8Aol9z1u5PuKK2lu0Seu0JDqCTpWPqhTudT
         7hGAGX2+rdxBjuMclKfhnDKTFYBBj9LCPqSQiUQ8syyOuFTSJaYw60S2tetENM0ihbtG
         bn7bA5oYuKtaQWCbp776zUghWmiRtpOV6MtS0XoNPF1bf9synXVYXHQ9RTtVSuDsT4oz
         D6dj1aA/Oq002IpAW6J97ErAEH/xuomCKBjqQcbXnBuY7sRufyYPRyazYx21r7VCOE8B
         3QVQ==
X-Forwarded-Encrypted: i=1; AJvYcCWHjKCKcrSRTXigdWKq2xxuYsT/upcwT1Nm+r/oe89vH6MFeps9RAYOamb9gwBDeisYy6W+pgWMH7dNf0pu0y2fLZACUuoDB/oXfsE7
X-Gm-Message-State: AOJu0YxZkLEfhUG4oz0iv+rUnCpqmHyaTPJczMFAaK/G/7kGRnXj9ka7
	IOpo3AXZOYpQeB+S/ywfMTxqwcwZgGNk2hki7EVCMfw229GL7nPzrdj7LWDlKXU1U6oGijb5A1r
	q/cXxcgM3/0CtsEp0mW+Qm0ap665O+P9kWEPkucyHfBR1l7JtSOVXJu46fNPXmLy0StLjkHIGGo
	2SGBqe5hWXmozBSnCe7yUBsWY/KkuqufJg0POC
X-Received: by 2002:a17:90a:4418:b0:2c2:d6f3:6353 with SMTP id 98e67ed59e1d1-2c4db24e983mr7955932a91.14.1718589028207;
        Sun, 16 Jun 2024 18:50:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE1MU/JZFpNvhOdjY7TMg2h2pvSTX+Sf4tEigJOVf3BB6dXfR/PJ+oD724nUKpn40pvzjX96XmfBeq9XVIb+1Y=
X-Received: by 2002:a17:90a:4418:b0:2c2:d6f3:6353 with SMTP id
 98e67ed59e1d1-2c4db24e983mr7955910a91.14.1718589027418; Sun, 16 Jun 2024
 18:50:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240530032055.8036-1-jasowang@redhat.com> <20240530020531-mutt-send-email-mst@kernel.org>
 <CACGkMEun-77fXbQ93H_GEC4=0_7CLq7iPtXSKe9Qriw-Qh1Tbw@mail.gmail.com>
 <20240530090742-mutt-send-email-mst@kernel.org> <CACGkMEsYRCJ96=sja9pBo_mnPsp75Go6E-wmm=-QX0kaOu4RFQ@mail.gmail.com>
 <CACGkMEu2vb8njbNHExWnDAG_pFjsLkYChgNerH4LAQ7pbYyEcg@mail.gmail.com>
In-Reply-To: <CACGkMEu2vb8njbNHExWnDAG_pFjsLkYChgNerH4LAQ7pbYyEcg@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 17 Jun 2024 09:50:16 +0800
Message-ID: <CACGkMEu2smqH2WxYxpp1bbpp9CZmaQ0PH60V7LOjaN2MqCO6qA@mail.gmail.com>
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

On Thu, Jun 6, 2024 at 8:22=E2=80=AFAM Jason Wang <jasowang@redhat.com> wro=
te:
>
> On Fri, May 31, 2024 at 8:18=E2=80=AFAM Jason Wang <jasowang@redhat.com> =
wrote:
> >
> > On Thu, May 30, 2024 at 9:09=E2=80=AFPM Michael S. Tsirkin <mst@redhat.=
com> wrote:
> > >
> > > On Thu, May 30, 2024 at 06:29:51PM +0800, Jason Wang wrote:
> > > > On Thu, May 30, 2024 at 2:10=E2=80=AFPM Michael S. Tsirkin <mst@red=
hat.com> wrote:
> > > > >
> > > > > On Thu, May 30, 2024 at 11:20:55AM +0800, Jason Wang wrote:
> > > > > > This patch synchronize operstate with admin state per RFC2863.
> > > > > >
> > > > > > This is done by trying to toggle the carrier upon open/close an=
d
> > > > > > synchronize with the config change work. This allows propagate =
status
> > > > > > correctly to stacked devices like:
> > > > > >
> > > > > > ip link add link enp0s3 macvlan0 type macvlan
> > > > > > ip link set link enp0s3 down
> > > > > > ip link show
> > > > > >
> > > > > > Before this patch:
> > > > > >
> > > > > > 3: enp0s3: <BROADCAST,MULTICAST> mtu 1500 qdisc pfifo_fast stat=
e DOWN mode DEFAULT group default qlen 1000
> > > > > >     link/ether 00:00:05:00:00:09 brd ff:ff:ff:ff:ff:ff
> > > > > > ......
> > > > > > 5: macvlan0@enp0s3: <BROADCAST,MULTICAST,UP,LOWER_UP,M-DOWN> mt=
u 1500 qdisc noqueue state UP mode DEFAULT group default qlen 1000
> > > > > >     link/ether b2:a9:c5:04:da:53 brd ff:ff:ff:ff:ff:ff
> > > > > >
> > > > > > After this patch:
> > > > > >
> > > > > > 3: enp0s3: <BROADCAST,MULTICAST> mtu 1500 qdisc pfifo_fast stat=
e DOWN mode DEFAULT group default qlen 1000
> > > > > >     link/ether 00:00:05:00:00:09 brd ff:ff:ff:ff:ff:ff
> > > > > > ...
> > > > > > 5: macvlan0@enp0s3: <NO-CARRIER,BROADCAST,MULTICAST,UP,M-DOWN> =
mtu 1500 qdisc noqueue state LOWERLAYERDOWN mode DEFAULT group default qlen=
 1000
> > > > > >     link/ether b2:a9:c5:04:da:53 brd ff:ff:ff:ff:ff:ff
> > > > > >
> > > > > > Cc: Venkat Venkatsubra <venkat.x.venkatsubra@oracle.com>
> > > > > > Cc: Gia-Khanh Nguyen <gia-khanh.nguyen@oracle.com>
> > > > > > Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > > > Acked-by: Michael S. Tsirkin <mst@redhat.com>
> > > > > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > > > > ---
> > > > > > Changes since V1:
> > > > > > - rebase
> > > > > > - add ack/review tags
> > > > >
> > > > >
> > > > >
> > > > >
> > > > >
> > > > > > ---
> > > > > >  drivers/net/virtio_net.c | 94 +++++++++++++++++++++++++++-----=
--------
> > > > > >  1 file changed, 63 insertions(+), 31 deletions(-)
> > > > > >
> > > > > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.=
c
> > > > > > index 4a802c0ea2cb..69e4ae353c51 100644
> > > > > > --- a/drivers/net/virtio_net.c
> > > > > > +++ b/drivers/net/virtio_net.c
> > > > > > @@ -433,6 +433,12 @@ struct virtnet_info {
> > > > > >       /* The lock to synchronize the access to refill_enabled *=
/
> > > > > >       spinlock_t refill_lock;
> > > > > >
> > > > > > +     /* Is config change enabled? */
> > > > > > +     bool config_change_enabled;
> > > > > > +
> > > > > > +     /* The lock to synchronize the access to config_change_en=
abled */
> > > > > > +     spinlock_t config_change_lock;
> > > > > > +
> > > > > >       /* Work struct for config space updates */
> > > > > >       struct work_struct config_work;
> > > > > >
> > > > >
> > > > >
> > > > > But we already have dev->config_lock and dev->config_enabled.
> > > > >
> > > > > And it actually works better - instead of discarding config
> > > > > change events it defers them until enabled.
> > > > >
> > > >
> > > > Yes but then both virtio-net driver and virtio core can ask to enab=
le
> > > > and disable and then we need some kind of synchronization which is
> > > > non-trivial.
> > >
> > > Well for core it happens on bring up path before driver works
> > > and later on tear down after it is gone.
> > > So I do not think they ever do it at the same time.
> >
> > For example, there could be a suspend/resume when the admin state is do=
wn.
> >
> > >
> > >
> > > > And device enabling on the core is different from bringing the devi=
ce
> > > > up in the networking subsystem. Here we just delay to deal with the
> > > > config change interrupt on ndo_open(). (E.g try to ack announce is
> > > > meaningless when the device is down).
> > > >
> > > > Thanks
> > >
> > > another thing is that it is better not to re-read all config
> > > on link up if there was no config interrupt - less vm exits.
> >
> > Yes, but it should not matter much as it's done in the ndo_open().
>
> Michael, any more comments on this?

Gentle ping.

Thanks

>
> Please confirm if this patch is ok or not. If you prefer to reuse the
> config_disable() I can change it from a boolean to a counter that
> allows to be nested.
>
> Thanks
>
> >
> > Thanks
> >
> > >
> > > --
> > > MST
> > >


