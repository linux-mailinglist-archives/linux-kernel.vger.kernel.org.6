Return-Path: <linux-kernel+bounces-256883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF19D9371BB
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 03:02:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 515CC1F21E30
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 01:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A4752913;
	Fri, 19 Jul 2024 01:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UdJDWT3o"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B67BE1362
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 01:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721350967; cv=none; b=sjG4++G65VvXvTKCnOYO3IjzyxHmQZsHXvHIMBchtkfU38t/fBDUfTIE5Ya4JNlDhttdf7ejC/pkYNutryZ31MlTsacR2FBwen5xmJ8bQ0xuiZlN495nRtWyBR+NZeliIUnIKw2BICEsIJ2oDBkEsnJFzfAcuNoRba99Z041eu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721350967; c=relaxed/simple;
	bh=ssP1jVPg8sd9HM1MFutiAyB41wofOCNUt/B8SWda9hI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QpEhj0EKPrezf9RCPKJGR7nXGV3qihnFyZXdKVsleVEXlyCJ/d/RwxE2cDQG1ooXn+rc9IfOOMODIvu1BrJuMUhBbYEGEOmIyAMeadwRDtC6+/9wmBZalB8pr9AGfQdAX3zDCBIRvQVwV7LoxXuA5SWZfctsJd3/DIdkgCuq01s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UdJDWT3o; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721350964;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kRSaE06iHm1lpAkfBSdbhgUw/gaP3pFzc6w4e5ilsgk=;
	b=UdJDWT3oidicJhvnxmXIY0OncVvJJHNLezb2WoiHQasA08qpDVaufmjgar3GAn6CaA/EXX
	ycoq4NN0l40WTofJcpWA4PgZXOsRVB1Dlu1mgPCRZIDycHqh/jJwAMnkn4bI3DFZ+EOt1H
	jE7++9sx+OnAU76N46eo0PBMe6RYMos=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-696-bNTYSJUsNymFfohYcPIj2w-1; Thu, 18 Jul 2024 21:02:43 -0400
X-MC-Unique: bNTYSJUsNymFfohYcPIj2w-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2cb685d5987so988623a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 18:02:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721350962; x=1721955762;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kRSaE06iHm1lpAkfBSdbhgUw/gaP3pFzc6w4e5ilsgk=;
        b=eHcuCE0/hDUxGY/oXTod3pWC+XFWkElSwKy9ELl6Is4ZNB1HLnBDUZGoZ7Lz6m/6wH
         D6FmjfBXctA5DTxcEJml0UKuxZSTIpPbw2GxlkI+f0PXL5ZHMFkCcGKspyll6nfHxoK4
         mBIRtgVC1LOe055BhzxA5Az0P40CQqqODpcdR4qX29DAhSL+rwuU9XrpwGRB0T+YT/36
         PsdbGRx9hlkGcwQMkUZq5xlwTxhCD6m+AIg5riFSejCptdnKgEJird4L7Ur97KgYWAOu
         4Q5R+Wcxapa3zhZQQdv9diPCcPcVwW6aZ/ylr3L/Z4Aq7u14uoItjWCpHgB4IgfSgahH
         O0Nw==
X-Forwarded-Encrypted: i=1; AJvYcCUDASboA2HRWWVnSudOnFN/YSndoLctVHbse/rdfgM42hop3QzxE3wG094SMzVv1wvz9uKR+aF3S/EKT7TCitCrva0osuVnPtA2AngO
X-Gm-Message-State: AOJu0Yxj3MT5TNp4wQ2BxZ9XIhb+QOlsct+p+j+WVEIccJ5qcWn63ifj
	68Sp3xLA43Sgo+ZtmuRClzuuGj1ILwGbN3W9DlLYQHF9IsMzxLQ/Hb22WP7TiXG538/4LNvz6Yl
	ZNxrAeGt3hXoFXSZ7d7T7MqBJUDzOzGDaU0vUbxoPnFctv3MNktBsdCo4/Krw89jHEAvfwH1P9z
	q18XTBsXoJ/T0QVwb1BvZzclSGufwMR2ToOzAR
X-Received: by 2002:a17:90b:70b:b0:2c9:5c63:29f4 with SMTP id 98e67ed59e1d1-2cb773360eemr2375421a91.25.1721350961719;
        Thu, 18 Jul 2024 18:02:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGO4PmCb6HCsLcpCTX7+pQS+hbt8McQL9YjmzCLoXlpXD9+R3TxIFIRGIBhygHbZmPLDNFndBQeKcYJI+L2igo=
X-Received: by 2002:a17:90b:70b:b0:2c9:5c63:29f4 with SMTP id
 98e67ed59e1d1-2cb773360eemr2375398a91.25.1721350961206; Thu, 18 Jul 2024
 18:02:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240709080214.9790-1-jasowang@redhat.com> <20240709080214.9790-4-jasowang@redhat.com>
 <20240709090743-mutt-send-email-mst@kernel.org> <CACGkMEv4CVK4YdOvHEbMY3dLc3cxF_tPN8H4YO=0rvFLaK-Upw@mail.gmail.com>
 <CACGkMEvDiQHfLaBRoaFtpYJHKTqicqbrpeZWzat43YveTa9Wyg@mail.gmail.com>
 <20240717015904-mutt-send-email-mst@kernel.org> <CACGkMEtntsAyddgrtxrbQe407dZkitac4ogC7cASF=iYgsum_A@mail.gmail.com>
In-Reply-To: <CACGkMEtntsAyddgrtxrbQe407dZkitac4ogC7cASF=iYgsum_A@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 19 Jul 2024 09:02:29 +0800
Message-ID: <CACGkMEsd63vH3J5m_4srO3ww2MWGOPc31L4171PfQ7uersN7PQ@mail.gmail.com>
Subject: Re: [PATCH net-next v3 3/3] virtio-net: synchronize operstate with
 admin state on up/down
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, Venkat Venkatsubra <venkat.x.venkatsubra@oracle.com>, 
	Gia-Khanh Nguyen <gia-khanh.nguyen@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 17, 2024 at 2:53=E2=80=AFPM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Wed, Jul 17, 2024 at 2:00=E2=80=AFPM Michael S. Tsirkin <mst@redhat.co=
m> wrote:
> >
> > On Wed, Jul 17, 2024 at 09:19:02AM +0800, Jason Wang wrote:
> > > On Wed, Jul 10, 2024 at 11:03=E2=80=AFAM Jason Wang <jasowang@redhat.=
com> wrote:
> > > >
> > > > On Tue, Jul 9, 2024 at 9:28=E2=80=AFPM Michael S. Tsirkin <mst@redh=
at.com> wrote:
> > > > >
> > > > > On Tue, Jul 09, 2024 at 04:02:14PM +0800, Jason Wang wrote:
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
> > > > >
> > > > > I think that the commit log is confusing. It seems to say that
> > > > > the issue fixed is synchronizing state with hardware
> > > > > config change.
> > > > > But your example does not show any
> > > > > hardware change. Isn't this example really just
> > > > > a side effect of setting carrier off on close?
> > > >
> > > > The main goal for this patch is to make virtio-net follow RFC2863. =
The
> > > > main thing that is missed is to synchronize the operstate with admi=
n
> > > > state, if we do this, we get several good results, one of the obvio=
us
> > > > one is to allow virtio-net to propagate status to the upper layer, =
for
> > > > example if the admin state of the lower virtio-net is down it shoul=
d
> > > > be propagated to the macvlan on top, so I give the example of using=
 a
> > > > stacked device. I'm not we had others but the commit log is probabl=
y
> > > > too small to say all of it.
> > >
> > > Michael, any more comments on this?
> > >
> > > Thans
> >
> >
> > Still don't get it, sorry.
> > > > > > This is done by trying to toggle the carrier upon open/close an=
d
> > > > > > synchronize with the config change work.
> > What does this sentence mean? What is not synchronized with config
> > change that needs to be?
>
> I meant,
>
> 1) maclvan depends on the linkwatch to transfer operstate from the
> lower device to itself.
> 2) ndo_open()/close() will not trigger the linkwatch so we need to do
> it by ourselves in virtio-net to make sure macvlan get the correct
> opersate
> 3) consider config change work can change the state so ndo_close()
> needs to synchronize with it
>
> Thanks

Michael, are you fine with the above or I miss something there?

Thanks


