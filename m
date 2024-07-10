Return-Path: <linux-kernel+bounces-247368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76F2B92CE86
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 11:47:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A7E11C235DD
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 09:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 214A818FC65;
	Wed, 10 Jul 2024 09:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YatCsrQp"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CBCC3BBF5
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 09:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720604807; cv=none; b=PuFj9HgAfyCheWsNGDvi+Y+3bMWItDD40/Ys/a+xWIfw7lKBNTu3J7pJH+uJQk1Kh2jCiU4iiYWSpQ9T2tr+nhQIbieWjZdYdbWecy+HBdSQXmt0gqcxekpbJF5Uzc3VTs6aTWh3Hz4NLKPwn5gP5DOL/UKdaSgZEIovHMs40yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720604807; c=relaxed/simple;
	bh=LZFnsJhlMMXmLcnLjHwif3Tko8RTPA1FKx72W7VDpJM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nhmf0dyLZtqdh+1mryI9tmyN7/p/Hz+rb4eSmgM/n+AzeIwFrCjMl/BTH+zVgrdV2KBp2LwAcv7qHe3agee87SH/YDMX3/FvWq8RmV7/wPQGPFFOe4Vo7R1+CzSgNNYZdIWNnqbI6sN+lQEmHnbm3KT0uIgeK9m4Huq1DTj4BVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YatCsrQp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720604803;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wr3Fzy04+IjAcueeHCouhzEQFA2vb2X2x/Lajkzkytk=;
	b=YatCsrQpJ/OO0CxDVg2fqzIj8akACHno4x0xxpaagEwisLr/+FQ+51BbnL5/6uNPkVtVI4
	PH1xwL70j94+hs503mPBKFJSKk5Yhg+1piLEA28LlIH5kZ/oE1RKUKGr3rEXJiOklf1CDe
	BJumird57RJt5nbMQl9xklVeOVTuZRQ=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-190-e2UFyAbXMsOHu3LL4QZ6aQ-1; Wed, 10 Jul 2024 05:46:42 -0400
X-MC-Unique: e2UFyAbXMsOHu3LL4QZ6aQ-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2ee9308bc8cso51308071fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 02:46:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720604800; x=1721209600;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wr3Fzy04+IjAcueeHCouhzEQFA2vb2X2x/Lajkzkytk=;
        b=ZrXoVmDyxS/0xfsXSEyhoIpEOmNtT/hqoq05mYX+cEA7EbeRq+AvTGR0XjLsbmFEqa
         0ycCvzH7Sws9EHbsY80wishGFPuruJo8FmaBQ2+IGtUr3H2pIMzA1AySPpmMreKd/VvW
         li1BTM8/vo35xtpwX6HT0+8S7xswWQ9XV+Mj14tG3eEU3Bo5qtxlb7ii35JULDraFA4s
         mar17hhBrCBAXHShKVB85hwch65oJQluaIwryuro8XMfdSJ54GB5yoloxYUzIlB82AuC
         12Fzr4cUPBt7aIRsWNtHD4qb6b1sJL2f/amn0hX5tp7Yo1ANYqcCqB/a6ZzLuVgbJMdo
         bfQA==
X-Forwarded-Encrypted: i=1; AJvYcCV972hQ03R/OFWlvq4viQOrBOQX2Zeo7bcnxLGjEqXGsqulZsQOXQsCJK5VwIuR+Tkm5O57gTUgmJayZhgX6A8+ewOigWJ1UTiSAtKy
X-Gm-Message-State: AOJu0YyOr6ezSU9WTqRde+V6Fk4iZ5pMngDGHwM+YIM0jvbykRuoXSXx
	EKFgUk9neNRw9FlnhowJKtrJ8F69X+zVfyH8YxN02UpVp6ypGulLdkbEUyp3TVMhNaL90OG0wc+
	H8pUf77K1RCDljL1yyoEdR0r5nlAbjockc7Galwuitg+cyXW8dc59BsjacyRj421nhZUsilg+qH
	0o3poDVp6BLsZqigdlueTP9XnlCPNfVx+qP0I7
X-Received: by 2002:a05:651c:97:b0:2ee:8aed:ddcd with SMTP id 38308e7fff4ca-2eeb30ba01bmr30673201fa.2.1720604800506;
        Wed, 10 Jul 2024 02:46:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH0ffFCw3VbNM6Vw/r2MqpTFMKw6bcckSDGxnXr5Oj3vP+HBV03PNXiHpFH5GB2HlKHopl3lyeXuVt4nS1YdPI=
X-Received: by 2002:a05:651c:97:b0:2ee:8aed:ddcd with SMTP id
 38308e7fff4ca-2eeb30ba01bmr30673101fa.2.1720604800176; Wed, 10 Jul 2024
 02:46:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240708064820.88955-1-lulu@redhat.com> <PH0PR12MB5481AE2FD52AEE1C10411F3DDCDB2@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACLfguXk4qiw4efRGK4Gw8OZQ_PKw6j+GVQJCVtbyJ+hxOoE0Q@mail.gmail.com>
 <20240709084109-mutt-send-email-mst@kernel.org> <CACGkMEtdFgbgrjNDoYfW1B+4BwG8=i9CP5ePiULm2n3837n29w@mail.gmail.com>
 <20240710020852-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240710020852-mutt-send-email-mst@kernel.org>
From: Cindy Lu <lulu@redhat.com>
Date: Wed, 10 Jul 2024 17:46:02 +0800
Message-ID: <CACLfguW0HxPy7ZF7gg7hNzMqFcf5x87asQKBUqZMOJC_S8kSbw@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] vdpa: support set mac address from vdpa tool
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, Parav Pandit <parav@nvidia.com>, 
	Dragos Tatulea <dtatulea@nvidia.com>, "sgarzare@redhat.com" <sgarzare@redhat.com>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	Leonardo Milleri <lmilleri@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 10 Jul 2024 at 14:10, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Wed, Jul 10, 2024 at 11:05:48AM +0800, Jason Wang wrote:
> > On Tue, Jul 9, 2024 at 8:42=E2=80=AFPM Michael S. Tsirkin <mst@redhat.c=
om> wrote:
> > >
> > > On Tue, Jul 09, 2024 at 02:19:19PM +0800, Cindy Lu wrote:
> > > > On Tue, 9 Jul 2024 at 11:59, Parav Pandit <parav@nvidia.com> wrote:
> > > > >
> > > > > Hi Cindy,
> > > > >
> > > > > > From: Cindy Lu <lulu@redhat.com>
> > > > > > Sent: Monday, July 8, 2024 12:17 PM
> > > > > >
> > > > > > Add support for setting the MAC address using the VDPA tool.
> > > > > > This feature will allow setting the MAC address using the VDPA =
tool.
> > > > > > For example, in vdpa_sim_net, the implementation sets the MAC a=
ddress to
> > > > > > the config space. However, for other drivers, they can implemen=
t their own
> > > > > > function, not limited to the config space.
> > > > > >
> > > > > > Changelog v2
> > > > > >  - Changed the function name to prevent misunderstanding
> > > > > >  - Added check for blk device
> > > > > >  - Addressed the comments
> > > > > > Changelog v3
> > > > > >  - Split the function of the net device from vdpa_nl_cmd_dev_at=
tr_set_doit
> > > > > >  - Add a lock for the network device's dev_set_attr operation
> > > > > >  - Address the comments
> > > > > >
> > > > > > Cindy Lu (2):
> > > > > >   vdpa: support set mac address from vdpa tool
> > > > > >   vdpa_sim_net: Add the support of set mac address
> > > > > >
> > > > > >  drivers/vdpa/vdpa.c                  | 81 ++++++++++++++++++++=
++++++++
> > > > > >  drivers/vdpa/vdpa_sim/vdpa_sim_net.c | 19 ++++++-
> > > > > >  include/linux/vdpa.h                 |  9 ++++
> > > > > >  include/uapi/linux/vdpa.h            |  1 +
> > > > > >  4 files changed, 109 insertions(+), 1 deletion(-)
> > > > > >
> > > > > > --
> > > > > > 2.45.0
> > > > >
> > > > > Mlx5 device already allows setting the mac and mtu during the vdp=
a device creation time.
> > > > > Once the vdpa device is created, it binds to vdpa bus and other d=
river vhost_vdpa etc bind to it.
> > > > > So there was no good reason in the past to support explicit confi=
g after device add complicate the flow for synchronizing this.
> > > > >
> > > > > The user who wants a device with new attributes, as well destroy =
and recreate the vdpa device with new desired attributes.
> > > > >
> > > > > vdpa_sim_net can also be extended for similar way when adding the=
 vdpa device.
> > > > >
> > > > > Have you considered using the existing tool and kernel in place s=
ince 2021?
> > > > > Such as commit d8ca2fa5be1.
> > > > >
> > > > > An example of it is,
> > > > > $ vdpa dev add name bar mgmtdev vdpasim_net mac 00:11:22:33:44:55=
 mtu 9000
> > > > >
> > > > Hi Parav
> > > > Really thanks for your comments. The reason for adding this functio=
n
> > > > is to support Kubevirt.
> > > > the problem we meet is that kubevirt chooses one random vdpa device
> > > > from the pool and we don't know which one it going to pick. That me=
ans
> > > > we can't get to know the Mac address before it is created. So we pl=
an
> > > > to have this function to change the mac address after it is created
> > > > Thanks
> > > > cindy
> > >
> > > Well you will need to change kubevirt to teach it to set
> > > mac address, right?
> >
> > That's the plan. Adding Leonardo.
> >
> > Thanks
>
> So given you are going to change kubevirt, can we
> change it to create devices as needed with the
> existing API?
>
Hi Micheal and Parav,
I'm really not familiar with kubevirt, hope Leonardo can help answer
these questions
Hi @Leonardo Milleri
would you help answer these questions?

Thanks
Cindy
> > >
> > > --
> > > MST
> > >
>


