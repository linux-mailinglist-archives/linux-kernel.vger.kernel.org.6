Return-Path: <linux-kernel+bounces-203447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DFAF98FDB63
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 02:22:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3CFCBB23C12
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 00:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29C9579D0;
	Thu,  6 Jun 2024 00:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HmeEcK6o"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7339139D
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 00:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717633351; cv=none; b=aRdIggckmRuElIyv8NuOs0TPWgoMGkE3Vin6BMXgCED2S/bsLmFpzCLwNRA2Ja7q5kUvMO+dval9buqEckd7BlablC3KRag469UvRO5I4xfAMB2YPdlKN2bQ1RDbfu2F/kAEtG7nmO37R0N7U3PYfyCw3+2FSZ/MTy5utTH4RFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717633351; c=relaxed/simple;
	bh=3vc8T1yJa+tEmXjxhkr/Caecgw0eEIRO+K3Y9cuhyJk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZNa81tCCKWzAXgcTEP/pMKLixcD2wOqfjuwBysdQDTwqZpXgKnlsQ6VKxHxCFbmVQAguc43q7UZmRc+5XixUuTTFDu3DZmYoGaZ3bdpcqHK4q5Z+6ZryWJ6qEOCTYRqb8Bf9/WHcS0rS8lItZmhlvhYZUdAqmB00IuoD1P/52vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HmeEcK6o; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717633348;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A3WnCdr7NGFNEC2Eyj9xh68M3W1rWWXkjJt9FXdJgiw=;
	b=HmeEcK6oB7O8DJ0LEv6svpcgLWWhpAwRv4J5qe8lsA3/jKw30TqxwNlZ09JfdtlrZpHviZ
	7n7EkGsbgClj7T1FgAoZAoEl678e6nsOkZYgt/la3DEN1t6UDqCXldI7/0s0Hr//MsSeFM
	R7km6W8P70DCYHt+hYAFQEJbAz+9XFk=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-422-IGuwtwOwOmCuwr4emLH1gQ-1; Wed, 05 Jun 2024 20:22:26 -0400
X-MC-Unique: IGuwtwOwOmCuwr4emLH1gQ-1
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-70265fd9230so278199b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 17:22:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717633345; x=1718238145;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A3WnCdr7NGFNEC2Eyj9xh68M3W1rWWXkjJt9FXdJgiw=;
        b=i3LVm+NILA7FwPc6+C6n+2fUYes6kABDErG6F75B9UW7HRn8JLv4nnN+2E3Q3+js+w
         8snQufvwgQUFhvYUh2Wh4jO02MZ/WUQDlybzGvyWxssOFuVIigcRJMfCKaVM5nDzxkNB
         +KCJNtnfo1FslDoI0WtuuJxiIE7ZBHxNgzWwuS3FzW2kCIjVJa5czhzKjRdZ9WhC6IRB
         tqnzQnfvz8qv3upRB6MbEh/4kmbUNZ45nU4nu8NTHceojN7K0AV2Hpu98EKeQbrCZUqb
         kpBTFjApkE30XhzUgvGUflL6YAGbmPrdNai8MJbAoKcli9GTes08WzDtH6L1zOJ4hfnB
         XCQw==
X-Forwarded-Encrypted: i=1; AJvYcCWY/Eiy5sB6ECwEJW6RdyRVqjDCHc9Gkt3WWlZ7kiHy8pAs7K/UlJjNzMh8NC0WyFbBraNaBf+YPbWSjb9BVGwGlAAc359Jx1XTpQKI
X-Gm-Message-State: AOJu0YwpwuvQW0/o1X3m3tt5ft35rCqowu2I0WY+XRj24n6rDkpniskD
	rIk01SHcN0bRY0nP9sNWkFOFa63HRYtjzQIbtPWTlFycA/y3pzdCwyyPupjijOigWjIhHJx1a2V
	gpgrGEUEhDjHjhQg4kyhFM1LLtv+TAXs1KXx+H580fEYoqRgIAjsqPf6BTgwuuvBr0bMLObqV2z
	CRhTbYs453Lk8/xdGVjlXpvZ9G/QwzU3P2v36D
X-Received: by 2002:a05:6a20:7350:b0:1b2:b027:a305 with SMTP id adf61e73a8af0-1b2b6ff5aacmr4915754637.33.1717633345260;
        Wed, 05 Jun 2024 17:22:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGnjAv7WzmQLTwGlWHL0Kk3HDaGP9LfjjTwlSo3xDTBix7n4S/u2CLmFnqs1iGFQDMOH2aET0IA34YjFOGpKIU=
X-Received: by 2002:a05:6a20:7350:b0:1b2:b027:a305 with SMTP id
 adf61e73a8af0-1b2b6ff5aacmr4915727637.33.1717633344499; Wed, 05 Jun 2024
 17:22:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240530032055.8036-1-jasowang@redhat.com> <20240530020531-mutt-send-email-mst@kernel.org>
 <CACGkMEun-77fXbQ93H_GEC4=0_7CLq7iPtXSKe9Qriw-Qh1Tbw@mail.gmail.com>
 <20240530090742-mutt-send-email-mst@kernel.org> <CACGkMEsYRCJ96=sja9pBo_mnPsp75Go6E-wmm=-QX0kaOu4RFQ@mail.gmail.com>
In-Reply-To: <CACGkMEsYRCJ96=sja9pBo_mnPsp75Go6E-wmm=-QX0kaOu4RFQ@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 6 Jun 2024 08:22:13 +0800
Message-ID: <CACGkMEu2vb8njbNHExWnDAG_pFjsLkYChgNerH4LAQ7pbYyEcg@mail.gmail.com>
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

On Fri, May 31, 2024 at 8:18=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Thu, May 30, 2024 at 9:09=E2=80=AFPM Michael S. Tsirkin <mst@redhat.co=
m> wrote:
> >
> > On Thu, May 30, 2024 at 06:29:51PM +0800, Jason Wang wrote:
> > > On Thu, May 30, 2024 at 2:10=E2=80=AFPM Michael S. Tsirkin <mst@redha=
t.com> wrote:
> > > >
> > > > On Thu, May 30, 2024 at 11:20:55AM +0800, Jason Wang wrote:
> > > > > This patch synchronize operstate with admin state per RFC2863.
> > > > >
> > > > > This is done by trying to toggle the carrier upon open/close and
> > > > > synchronize with the config change work. This allows propagate st=
atus
> > > > > correctly to stacked devices like:
> > > > >
> > > > > ip link add link enp0s3 macvlan0 type macvlan
> > > > > ip link set link enp0s3 down
> > > > > ip link show
> > > > >
> > > > > Before this patch:
> > > > >
> > > > > 3: enp0s3: <BROADCAST,MULTICAST> mtu 1500 qdisc pfifo_fast state =
DOWN mode DEFAULT group default qlen 1000
> > > > >     link/ether 00:00:05:00:00:09 brd ff:ff:ff:ff:ff:ff
> > > > > ......
> > > > > 5: macvlan0@enp0s3: <BROADCAST,MULTICAST,UP,LOWER_UP,M-DOWN> mtu =
1500 qdisc noqueue state UP mode DEFAULT group default qlen 1000
> > > > >     link/ether b2:a9:c5:04:da:53 brd ff:ff:ff:ff:ff:ff
> > > > >
> > > > > After this patch:
> > > > >
> > > > > 3: enp0s3: <BROADCAST,MULTICAST> mtu 1500 qdisc pfifo_fast state =
DOWN mode DEFAULT group default qlen 1000
> > > > >     link/ether 00:00:05:00:00:09 brd ff:ff:ff:ff:ff:ff
> > > > > ...
> > > > > 5: macvlan0@enp0s3: <NO-CARRIER,BROADCAST,MULTICAST,UP,M-DOWN> mt=
u 1500 qdisc noqueue state LOWERLAYERDOWN mode DEFAULT group default qlen 1=
000
> > > > >     link/ether b2:a9:c5:04:da:53 brd ff:ff:ff:ff:ff:ff
> > > > >
> > > > > Cc: Venkat Venkatsubra <venkat.x.venkatsubra@oracle.com>
> > > > > Cc: Gia-Khanh Nguyen <gia-khanh.nguyen@oracle.com>
> > > > > Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > > Acked-by: Michael S. Tsirkin <mst@redhat.com>
> > > > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > > > ---
> > > > > Changes since V1:
> > > > > - rebase
> > > > > - add ack/review tags
> > > >
> > > >
> > > >
> > > >
> > > >
> > > > > ---
> > > > >  drivers/net/virtio_net.c | 94 +++++++++++++++++++++++++++-------=
------
> > > > >  1 file changed, 63 insertions(+), 31 deletions(-)
> > > > >
> > > > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > > > index 4a802c0ea2cb..69e4ae353c51 100644
> > > > > --- a/drivers/net/virtio_net.c
> > > > > +++ b/drivers/net/virtio_net.c
> > > > > @@ -433,6 +433,12 @@ struct virtnet_info {
> > > > >       /* The lock to synchronize the access to refill_enabled */
> > > > >       spinlock_t refill_lock;
> > > > >
> > > > > +     /* Is config change enabled? */
> > > > > +     bool config_change_enabled;
> > > > > +
> > > > > +     /* The lock to synchronize the access to config_change_enab=
led */
> > > > > +     spinlock_t config_change_lock;
> > > > > +
> > > > >       /* Work struct for config space updates */
> > > > >       struct work_struct config_work;
> > > > >
> > > >
> > > >
> > > > But we already have dev->config_lock and dev->config_enabled.
> > > >
> > > > And it actually works better - instead of discarding config
> > > > change events it defers them until enabled.
> > > >
> > >
> > > Yes but then both virtio-net driver and virtio core can ask to enable
> > > and disable and then we need some kind of synchronization which is
> > > non-trivial.
> >
> > Well for core it happens on bring up path before driver works
> > and later on tear down after it is gone.
> > So I do not think they ever do it at the same time.
>
> For example, there could be a suspend/resume when the admin state is down=
.
>
> >
> >
> > > And device enabling on the core is different from bringing the device
> > > up in the networking subsystem. Here we just delay to deal with the
> > > config change interrupt on ndo_open(). (E.g try to ack announce is
> > > meaningless when the device is down).
> > >
> > > Thanks
> >
> > another thing is that it is better not to re-read all config
> > on link up if there was no config interrupt - less vm exits.
>
> Yes, but it should not matter much as it's done in the ndo_open().

Michael, any more comments on this?

Please confirm if this patch is ok or not. If you prefer to reuse the
config_disable() I can change it from a boolean to a counter that
allows to be nested.

Thanks

>
> Thanks
>
> >
> > --
> > MST
> >


