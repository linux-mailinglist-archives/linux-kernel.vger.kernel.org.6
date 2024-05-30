Return-Path: <linux-kernel+bounces-195262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 94AB48D49A8
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 12:30:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC10EB229FC
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 10:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7828B176ADB;
	Thu, 30 May 2024 10:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G/LCCiuA"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B4F2AE6A
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 10:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717065008; cv=none; b=M0+ducvaVJR91aQuA4jFodU6DxA+SDhsqxptUDcpe7sDmhiCluvYE50zFoHv49snWQV2rkIQgpV5fDCBqdgcFAo+Q4xhnzZwyiiSVVliFO+DdfB+VuoX8qwMxsMyEPkqW9UBFUS3yNQsetOjzkEu+h2MLrQ23olimzxCbPYJVmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717065008; c=relaxed/simple;
	bh=mVHva8M32IxDEuPKEKgHcF5zqbOYLYjPtVGp80CqZ68=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gvIDgaH+tuR+5L9z7e6cmMoAJwQqwiwInxTQBoA0iE0c+lUljxATuD0AagbNqhAF64ZO6k0/eenuqVbDpjOhXhwRcW95KVBE+zewHyamKS/vA8fyqNJ/QG3Rc+Hm5++xPQSyb/ZH4kBlGAlmtQbi5NCj5m2usZc7JVSqH3sMfTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G/LCCiuA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717065006;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fXuu0VhYv/Sqtsmj/xee9XrMd/ZRARenPycPxIhwC84=;
	b=G/LCCiuA2T41HAuHVieZymegU6tGYjFLTKArSRVruAaw/uEqDDR51nYCyLfRZ6CXTCxkTD
	ajf3NCUgDHgUTtZMq1iCV8vthFB4+5X7R4q6WDLiTTpE6nfdenpJrfbKPMkYJQi/HMXIXs
	QJDGMndDmxKbvnjHygwAvUV/vi6qyAA=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-TT7Sei3_MPG4CkSp1JIZyw-1; Thu, 30 May 2024 06:30:04 -0400
X-MC-Unique: TT7Sei3_MPG4CkSp1JIZyw-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2c1a23d1382so694528a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 03:30:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717065004; x=1717669804;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fXuu0VhYv/Sqtsmj/xee9XrMd/ZRARenPycPxIhwC84=;
        b=TpwbH/pu92XXCo1pHsYoIeyhI9DU+fB/1ZLigqv72dfYQYItKkekp2FDCeTnF796Wr
         XdmbNtZE7e9ChKxfXVwHwloA5eeT0iwG9k4jNXlCGY3d2diRBy27aaDSUkKYE7DAfAmC
         K89vWDIV9Gg0dP0O3ABbuuoI+B5y8gywZLeH/qcKlMbe0KolqSx27qYdG5IRvEkVLZrN
         gjuYbZu/k9YZvim+lg/2vDdnHWXxO1NInjS83Cn+5UPgUu4uEcNPNATkLoZlO+bj0kKZ
         aX1CsaIdzaCnJKSxV8/mf7LT0I949ASQh1QYZCIR04+V41AOLxwuY7MvswG1VrFE7jky
         CtQQ==
X-Forwarded-Encrypted: i=1; AJvYcCVRtH8I18CYlY9oI6xVbGij6gg2RffS9/i7Bu0VqjgVya4QUwyRBkV5tC7UmYZr34F1SSk+bGuUJgFUNo/8ZENLiBMZxnhMVkgIHHzk
X-Gm-Message-State: AOJu0YygASjj2uUUklFl8S113xz2ssbtNODvOG2HnP7ItACMx6by4hof
	jeMvKj1nFHuowlDgPZ7ZNIDlfuDR2W47ADL409p9ZMv1S3X9L+V2Sc8B8C02Fqbaz6f8AbLvUVh
	ckZSFKqiM8JY8AsN7PO5M/wao5CpcYrOytZJgjt9w1h1o0gRdD5G26B6SkU4un5af4pT2QazzIB
	7ZwHq0bQPoudAiCWIM29QRPO/zujvc4YUaZBx4
X-Received: by 2002:a17:90a:ce90:b0:2c0:3400:df40 with SMTP id 98e67ed59e1d1-2c1aabe9d88mr2621232a91.0.1717065003793;
        Thu, 30 May 2024 03:30:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGA7U478P9i05qqxnNKG+nvSy+yQhk/wrEg2bbs8tGfMLiA4XTvaTHtx1q3ccmrbRhBHVyV89R4f4eHnf4hT+E=
X-Received: by 2002:a17:90a:ce90:b0:2c0:3400:df40 with SMTP id
 98e67ed59e1d1-2c1aabe9d88mr2621210a91.0.1717065003379; Thu, 30 May 2024
 03:30:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240530032055.8036-1-jasowang@redhat.com> <20240530020531-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240530020531-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 30 May 2024 18:29:51 +0800
Message-ID: <CACGkMEun-77fXbQ93H_GEC4=0_7CLq7iPtXSKe9Qriw-Qh1Tbw@mail.gmail.com>
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

On Thu, May 30, 2024 at 2:10=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Thu, May 30, 2024 at 11:20:55AM +0800, Jason Wang wrote:
> > This patch synchronize operstate with admin state per RFC2863.
> >
> > This is done by trying to toggle the carrier upon open/close and
> > synchronize with the config change work. This allows propagate status
> > correctly to stacked devices like:
> >
> > ip link add link enp0s3 macvlan0 type macvlan
> > ip link set link enp0s3 down
> > ip link show
> >
> > Before this patch:
> >
> > 3: enp0s3: <BROADCAST,MULTICAST> mtu 1500 qdisc pfifo_fast state DOWN m=
ode DEFAULT group default qlen 1000
> >     link/ether 00:00:05:00:00:09 brd ff:ff:ff:ff:ff:ff
> > ......
> > 5: macvlan0@enp0s3: <BROADCAST,MULTICAST,UP,LOWER_UP,M-DOWN> mtu 1500 q=
disc noqueue state UP mode DEFAULT group default qlen 1000
> >     link/ether b2:a9:c5:04:da:53 brd ff:ff:ff:ff:ff:ff
> >
> > After this patch:
> >
> > 3: enp0s3: <BROADCAST,MULTICAST> mtu 1500 qdisc pfifo_fast state DOWN m=
ode DEFAULT group default qlen 1000
> >     link/ether 00:00:05:00:00:09 brd ff:ff:ff:ff:ff:ff
> > ...
> > 5: macvlan0@enp0s3: <NO-CARRIER,BROADCAST,MULTICAST,UP,M-DOWN> mtu 1500=
 qdisc noqueue state LOWERLAYERDOWN mode DEFAULT group default qlen 1000
> >     link/ether b2:a9:c5:04:da:53 brd ff:ff:ff:ff:ff:ff
> >
> > Cc: Venkat Venkatsubra <venkat.x.venkatsubra@oracle.com>
> > Cc: Gia-Khanh Nguyen <gia-khanh.nguyen@oracle.com>
> > Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > Acked-by: Michael S. Tsirkin <mst@redhat.com>
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > ---
> > Changes since V1:
> > - rebase
> > - add ack/review tags
>
>
>
>
>
> > ---
> >  drivers/net/virtio_net.c | 94 +++++++++++++++++++++++++++-------------
> >  1 file changed, 63 insertions(+), 31 deletions(-)
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index 4a802c0ea2cb..69e4ae353c51 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -433,6 +433,12 @@ struct virtnet_info {
> >       /* The lock to synchronize the access to refill_enabled */
> >       spinlock_t refill_lock;
> >
> > +     /* Is config change enabled? */
> > +     bool config_change_enabled;
> > +
> > +     /* The lock to synchronize the access to config_change_enabled */
> > +     spinlock_t config_change_lock;
> > +
> >       /* Work struct for config space updates */
> >       struct work_struct config_work;
> >
>
>
> But we already have dev->config_lock and dev->config_enabled.
>
> And it actually works better - instead of discarding config
> change events it defers them until enabled.
>

Yes but then both virtio-net driver and virtio core can ask to enable
and disable and then we need some kind of synchronization which is
non-trivial.

And device enabling on the core is different from bringing the device
up in the networking subsystem. Here we just delay to deal with the
config change interrupt on ndo_open(). (E.g try to ack announce is
meaningless when the device is down).

Thanks


