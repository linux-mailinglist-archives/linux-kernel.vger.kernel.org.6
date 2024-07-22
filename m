Return-Path: <linux-kernel+bounces-258576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 257A39389FE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 09:25:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A54431F21550
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 07:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E22D7208CA;
	Mon, 22 Jul 2024 07:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jGDGQH3k"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AEE71B977
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 07:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721633092; cv=none; b=f4JiY4i97/ZbSNS47/akYMnQyvFHvKtmsqo3TUGpXX0YRU3v7wA9Ylv0w+DvnYO/jXI5mNCoPdJ1BJIbyNAPp84q3roByDcOohzbFX+G0HTL04wUND8DYINhwWsMjkpfG6FWAgslPVBaxDu+6dQ1uNesaEY8dE0dqKgzvEGVvAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721633092; c=relaxed/simple;
	bh=v7PvEK9SRryhQ0yl2RVyk/L4XGuIY0eQHGxznJK09FM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DcFGb4XU9SfK2Bx8HOBgn2lgx0CiSeUhhyRTiS36xTXwparJz+ISWY6THL18nv1MGFFvD7I4ZAmoNjtYEPaz+wSFhWEJvXluKFOwSSJm/HY2WEdAo2c0G2keoCXR0gfUVCtnaHXFE/YYRp80yaxKuSVXbeTP/KN8CQKYCw8EkZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jGDGQH3k; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721633089;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6b8DbvMTIZs4UYUWpNzuhLY/mHU8qxZgrbal7u48m9Q=;
	b=jGDGQH3kNrji0xs0gBve/HojKcpAWmYr5mi4zPhHhZDVrMZ16Jj3jne9eXBR1G8FwU9flu
	Z8TXdDlk40gxh52zkjoxHLmE+5ELzOEGHWm+qkUg4mxaPtiSYcH1DmAhn1bBgOwBC5Bek+
	vfP9BK36cmlyF5wzXeOQo/TO4Xq3D5g=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-604-J3g4khaeM4SmF3IlKgCs8A-1; Mon, 22 Jul 2024 03:24:46 -0400
X-MC-Unique: J3g4khaeM4SmF3IlKgCs8A-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2cb5594a9f3so3031920a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 00:24:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721633085; x=1722237885;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6b8DbvMTIZs4UYUWpNzuhLY/mHU8qxZgrbal7u48m9Q=;
        b=OLOYbJ24syzsB+0XFNuKGKbMLMveLDYrkVCoUXpKr4lUuW/OKalRNMBrzL6ilnfMfD
         nAeW1XvlYqRoRpjkMtd7fahABZ+FxThGDx4itFPQ/zVQn5DMnwIVgF0kmt9RErl21OTW
         61Fq6LqRczg19c9+P8JLC+57oeiQF6gcwYKI3B67/wfxXMcVVz7NnWgEJV1yEFxpZ9AR
         Xa5EyLs+N8tHPFwszbRofU9Kc36Y3E5LpgSePj7pEmpVb8CyCVrgE8Ncuea4cbxl9uX3
         qQIYvONmT0MNn3NoZ3TfZzpGQxGm5hlKvmXbXhRYRQl84wCxuLAn/MotTJcH6VqqtDJa
         fn9w==
X-Forwarded-Encrypted: i=1; AJvYcCUFLQnxFALBGV0IOkxhsE6J1mhttzxNoN7sp7s8PXI59Hi3bgjYo09ATPTXNkVTUqJhDZ14qp8qxlL6+dL0vbOGx31wthcG3/syTxNz
X-Gm-Message-State: AOJu0YygzMWaDgV4nSuIIyeXLFDeZhMgvSYGyeSen5ovv4x5OgZXkul/
	hSx1KzQ6essPalnUU1KmJl/5+OI2qSPTbmDFB8r6mE/986aQTGx2o+wDRAMGSQq8JORCQ+f3RXj
	zxFPT8wPLI43Uwoxombsg91k1JirUojoV7Kl/cQpxLtzEbWJmwsVzbl9L3PYchfFvkY2N4ancfb
	P5ikQBx7eZvfGdx8gwVBziNVkK99NpC9f+ArPP
X-Received: by 2002:a17:90a:d804:b0:2c9:5c67:dd9e with SMTP id 98e67ed59e1d1-2cd27432530mr2182482a91.19.1721633084874;
        Mon, 22 Jul 2024 00:24:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFxdBJ/mcGD/aWunnzQ1cFnQfiRB3cLn9nWcv3t64CQgVrqxXu9zfgIZNks+aHUVpy63rI4Xsl+ZPoOkSNQaEw=
X-Received: by 2002:a17:90a:d804:b0:2c9:5c67:dd9e with SMTP id
 98e67ed59e1d1-2cd27432530mr2182471a91.19.1721633084452; Mon, 22 Jul 2024
 00:24:44 -0700 (PDT)
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
 <CACGkMEsd63vH3J5m_4srO3ww2MWGOPc31L4171PfQ7uersN7PQ@mail.gmail.com> <20240718211816-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240718211816-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 22 Jul 2024 15:24:32 +0800
Message-ID: <CACGkMEsvCqymNBZdTB03SacL7JW8emAwgRuS+1e+VkzfEarBrw@mail.gmail.com>
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

On Fri, Jul 19, 2024 at 9:19=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Fri, Jul 19, 2024 at 09:02:29AM +0800, Jason Wang wrote:
> > On Wed, Jul 17, 2024 at 2:53=E2=80=AFPM Jason Wang <jasowang@redhat.com=
> wrote:
> > >
> > > On Wed, Jul 17, 2024 at 2:00=E2=80=AFPM Michael S. Tsirkin <mst@redha=
t.com> wrote:
> > > >
> > > > On Wed, Jul 17, 2024 at 09:19:02AM +0800, Jason Wang wrote:
> > > > > On Wed, Jul 10, 2024 at 11:03=E2=80=AFAM Jason Wang <jasowang@red=
hat.com> wrote:
> > > > > >
> > > > > > On Tue, Jul 9, 2024 at 9:28=E2=80=AFPM Michael S. Tsirkin <mst@=
redhat.com> wrote:
> > > > > > >
> > > > > > > On Tue, Jul 09, 2024 at 04:02:14PM +0800, Jason Wang wrote:
> > > > > > > > This patch synchronize operstate with admin state per RFC28=
63.
> > > > > > > >
> > > > > > > > This is done by trying to toggle the carrier upon open/clos=
e and
> > > > > > > > synchronize with the config change work. This allows propag=
ate status
> > > > > > > > correctly to stacked devices like:
> > > > > > > >
> > > > > > > > ip link add link enp0s3 macvlan0 type macvlan
> > > > > > > > ip link set link enp0s3 down
> > > > > > > > ip link show
> > > > > > > >
> > > > > > > > Before this patch:
> > > > > > > >
> > > > > > > > 3: enp0s3: <BROADCAST,MULTICAST> mtu 1500 qdisc pfifo_fast =
state DOWN mode DEFAULT group default qlen 1000
> > > > > > > >     link/ether 00:00:05:00:00:09 brd ff:ff:ff:ff:ff:ff
> > > > > > > > ......
> > > > > > > > 5: macvlan0@enp0s3: <BROADCAST,MULTICAST,UP,LOWER_UP,M-DOWN=
> mtu 1500 qdisc noqueue state UP mode DEFAULT group default qlen 1000
> > > > > > > >     link/ether b2:a9:c5:04:da:53 brd ff:ff:ff:ff:ff:ff
> > > > > > > >
> > > > > > > > After this patch:
> > > > > > > >
> > > > > > > > 3: enp0s3: <BROADCAST,MULTICAST> mtu 1500 qdisc pfifo_fast =
state DOWN mode DEFAULT group default qlen 1000
> > > > > > > >     link/ether 00:00:05:00:00:09 brd ff:ff:ff:ff:ff:ff
> > > > > > > > ...
> > > > > > > > 5: macvlan0@enp0s3: <NO-CARRIER,BROADCAST,MULTICAST,UP,M-DO=
WN> mtu 1500 qdisc noqueue state LOWERLAYERDOWN mode DEFAULT group default =
qlen 1000
> > > > > > > >     link/ether b2:a9:c5:04:da:53 brd ff:ff:ff:ff:ff:ff
> > > > > > >
> > > > > > > I think that the commit log is confusing. It seems to say tha=
t
> > > > > > > the issue fixed is synchronizing state with hardware
> > > > > > > config change.
> > > > > > > But your example does not show any
> > > > > > > hardware change. Isn't this example really just
> > > > > > > a side effect of setting carrier off on close?
> > > > > >
> > > > > > The main goal for this patch is to make virtio-net follow RFC28=
63. The
> > > > > > main thing that is missed is to synchronize the operstate with =
admin
> > > > > > state, if we do this, we get several good results, one of the o=
bvious
> > > > > > one is to allow virtio-net to propagate status to the upper lay=
er, for
> > > > > > example if the admin state of the lower virtio-net is down it s=
hould
> > > > > > be propagated to the macvlan on top, so I give the example of u=
sing a
> > > > > > stacked device. I'm not we had others but the commit log is pro=
bably
> > > > > > too small to say all of it.
> > > > >
> > > > > Michael, any more comments on this?
> > > > >
> > > > > Thans
> > > >
> > > >
> > > > Still don't get it, sorry.
> > > > > > > > This is done by trying to toggle the carrier upon open/clos=
e and
> > > > > > > > synchronize with the config change work.
> > > > What does this sentence mean? What is not synchronized with config
> > > > change that needs to be?
> > >
> > > I meant,
> > >
> > > 1) maclvan depends on the linkwatch to transfer operstate from the
> > > lower device to itself.
> > > 2) ndo_open()/close() will not trigger the linkwatch so we need to do
> > > it by ourselves in virtio-net to make sure macvlan get the correct
> > > opersate
> > > 3) consider config change work can change the state so ndo_close()
> > > needs to synchronize with it
> > >
> > > Thanks
> >
> > Michael, are you fine with the above or I miss something there?
> >
> > Thanks
>
>
> I don't understand 3. config change can always trigger.
> what I do not like is all these reads from config space
> that now trigger on open/close. previously we did
> read
> - on probe
> - after probe, if config changed
>
>
> and that made sense.

Ok, not sure I get you all but I will post a new version to see.

Thanks

>
> --
> MST
>


