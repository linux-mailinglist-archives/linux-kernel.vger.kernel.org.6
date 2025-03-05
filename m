Return-Path: <linux-kernel+bounces-546125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA8EEA4F6A9
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 06:47:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E644216ED69
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 05:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F7671D7E42;
	Wed,  5 Mar 2025 05:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MP4e13DS"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5A4191F75
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 05:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741153632; cv=none; b=SmWHYYzyaZGpCYZ2OZNAbXe93OIB3rmC8DJQ2r1lJJxaNJg/XDf22SYI7U8LUzj/NCLidK/kmgZGSTgo1GYBTRPzvn1Bsy/QYXqcwTaHneXm21wrOqgO86Mu5XBKgnVUtub1oGSHuxVKRvAvpTTppesexKJxezrVzfzopTjhSxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741153632; c=relaxed/simple;
	bh=Yr2zEleQP5OB9VQnCOvN96Nz1sM+C0j+qfjDSd3R7qM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QaCLKRAkmCpCd9Gqki+FGOXo7XIJJ9WU27R8Mzs7j8H+AmX6CpOQB6nFO3iDl+tawurcwu3tqefu1LyAFcylUivIxC1iN3wdxGYr+MZL8Oo/J9RwMS8QDC8ADGOgyLC85R1CJoBqxADEOmx/VKBtbvPzTKOLZfzzfmbr4diWx50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MP4e13DS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741153629;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TckiHzoidmvghQ6zu3pJdp/CUVWbSHOgWhuCociTv5w=;
	b=MP4e13DSP8GrWaJJOc1aGnMtzaCTvmRk3WFx1PSgx0UGjAn7Ro07JHfr0YhNBk/KMLTIiK
	x84/JOLp0f/SqOmwW+Wq+r+r1IkRGPwG/XzjA+jWjYxerSwMcm2L6/mf2u2SqBJ+JNkdSA
	+NETmOhvMQTN+k9/J2wzm/yGUiRTx04=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-6_pUkw6HNliSWmDcRR8YVQ-1; Wed, 05 Mar 2025 00:47:07 -0500
X-MC-Unique: 6_pUkw6HNliSWmDcRR8YVQ-1
X-Mimecast-MFC-AGG-ID: 6_pUkw6HNliSWmDcRR8YVQ_1741153627
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2ff53a4754aso55408a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 21:47:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741153627; x=1741758427;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TckiHzoidmvghQ6zu3pJdp/CUVWbSHOgWhuCociTv5w=;
        b=QDJl0FSopZfNXVRI0Dgj+ZoVqeYhAhcHjne58rqM0DbqdIGZh9RVOjVNy1ZIAxLYQc
         7OaCaaBHonnZlDtL64UVy4e6HTJMEybnGut4id5xnS8P2+K1W9Gw5IpvYA5DfqDXCCzp
         6GPAV+3h0a9Pw+EP/0xeAMNqSXvZcLkXGF2PeuLBhFvOInYnjYV0J3OlVxv+kd2VJyD8
         H1j/gOgoqsHhoj2Ae18zl3qgfFy9p1dNlVdYeSoWuuckXEzAx5jwVGMQxw631RKZN9zC
         pP1cuCi6AwWQtpqNlyOkPYdkkkQXA7ZDFfazSs+hk4MEZWfVxuVz9+Aq9Iy2CHupE5uN
         1qpg==
X-Forwarded-Encrypted: i=1; AJvYcCXd1TliNyGaTA1MMSH6lWa/fdbkQ682eWyYY+j7PXT4hQXgmx7FfNEj4iFwd5waLWNCo7CazOSrCuq95Uc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJo/U0hTp16Uwv8pIBmwS/c5ldVXjQdRc9UkHpN7aRadaJIy8z
	NEUp1j4hsqZpphabSYq1gUD3rP4V344PVIx4ruRJnFe9YMKoEUwfZO6fb+09tP5UP2CVAJr95Re
	azoIGEZyzdnaKgL9FqdvzMKs7cIia067JPUXIO/g5I/qujEvMqod3wJeDybcbmmxReT9uO5tFI0
	tDu5VYCILFgBIMIlTxQmCxGUy+mHfdZ8d90aHa
X-Gm-Gg: ASbGncvuz36s7pBfLputb164PIW4BumftdG8Z8aLRUhrSFoq5vC0vtBRgNEBIJQIxP3
	o5p/ESAAUrcvNkro/pgXFLKEai/9csC1s2Imw6BTU5y9/AQG8XNcsJ1aGyUHwy5AQsWOkcta1DA
	==
X-Received: by 2002:a17:90b:1d52:b0:2ee:dcf6:1c8f with SMTP id 98e67ed59e1d1-2ff497cb040mr4004275a91.16.1741153626847;
        Tue, 04 Mar 2025 21:47:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE7tLwkzpVQv2Fhj6KJP/g5jr88+NKViP8f9P/MLEqloHXqeIoNFWMkg7gOLyvweXjBE7QjXpxFd7/tryglpqM=
X-Received: by 2002:a17:90b:1d52:b0:2ee:dcf6:1c8f with SMTP id
 98e67ed59e1d1-2ff497cb040mr4004247a91.16.1741153626527; Tue, 04 Mar 2025
 21:47:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20200116172428.311437-1-sgarzare@redhat.com> <20200427142518.uwssa6dtasrp3bfc@steredhat>
 <224cdc10-1532-7ddc-f113-676d43d8f322@redhat.com> <20200428160052.o3ihui4262xogyg4@steredhat>
 <Z8edJjqAqAaV3Vkt@devvm6277.cco0.facebook.com>
In-Reply-To: <Z8edJjqAqAaV3Vkt@devvm6277.cco0.facebook.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 5 Mar 2025 13:46:54 +0800
X-Gm-Features: AQ5f1JrNByKY7PtEfXG0ORfP7FScyD2MAlIYCt0mdU5F_0VbeZRH2Dv5bfH1am0
Message-ID: <CACGkMEtTgmFVDU+ftDKEvy31JkV9zLLUv25LrEPKQyzgKiQGSQ@mail.gmail.com>
Subject: Re: [PATCH net-next 0/3] vsock: support network namespace
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>, davem@davemloft.net, 
	Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, 
	Jorgen Hansen <jhansen@vmware.com>, kvm@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, linux-hyperv@vger.kernel.org, 
	Dexuan Cui <decui@microsoft.com>, netdev@vger.kernel.org, 
	Jakub Kicinski <kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 5, 2025 at 8:39=E2=80=AFAM Bobby Eshleman <bobbyeshleman@gmail.=
com> wrote:
>
> On Tue, Apr 28, 2020 at 06:00:52PM +0200, Stefano Garzarella wrote:
> > On Tue, Apr 28, 2020 at 04:13:22PM +0800, Jason Wang wrote:
> > >
> > >
> > > As we've discussed, it should be a netdev probably in either guest or=
 host
> > > side. And it would be much simpler if we want do implement namespace =
then.
> > > No new API is needed.
> > >
> >
> > Thanks Jason!
> >
> > It would be cool, but I don't have much experience on netdev.
> > Do you see any particular obstacles?
> >
> > I'll take a look to understand how to do it, surely in the guest would
> > be very useful to have the vsock device as a netdev and maybe also in t=
he host.
> >
>
> WRT netdev, do we foresee big gains beyond just leveraging the netdev's
> namespace?

It's a leverage of the network subsystem (netdevice, steering, uAPI,
tracing, probably a lot of others), not only its namespace. It can
avoid duplicating existing mechanisms in a vsock specific way. If we
manage to do that, namespace support will be a "byproduct".

>
> IIUC, the idea is that we could follow the tcp/ip model and introduce
> vsock-supported netdevs. This would allow us to have a netdev associated
> with the virtio-vsock device and create virtual netdev pairs (i.e.,
> veth) that can bridge namespaces. Then, allocate CIDs or configure port
> mappings for those namespaces?

Probably.

>
> I think it might be a lot of complexity to bring into the picture from
> netdev, and I'm not sure there is a big win since the vsock device could
> also have a vsock->net itself?

Yes, it can. I think we need to evaluate both approaches (that's why I
raise the approach of reusing netdevice). We can hear from others.

> I think the complexity will come from the
> address translation, which I don't think netdev buys us because there
> would still be all of the work work to support vsock in netfilter?

Netfilter should not work as vsock will behave as a separate protocol
other than TCP/IP (e.g ETH_P_VSOCK)  if we try to implement netdevice.

>
> Some other thoughts I had: netdev's flow control features would all have
> to be ignored or disabled somehow (I think dev_direct_xmit()?), because
> queueing introduces packet loss and the vsock protocol is unable to
> survive packet loss.

Or just allow it and then configuring a qdisc that may drop packets
could be treated as a misconfiguration.

> Netfilter's ability to drop packets would have to
> be disabled too.
>
> Best,
> Bobby
>

Thanks


