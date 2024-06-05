Return-Path: <linux-kernel+bounces-203327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 55B1C8FD969
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 23:55:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8859B23246
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 21:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4242A15FA80;
	Wed,  5 Jun 2024 21:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EtPtG6Nx"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B34C71581E2
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 21:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717624517; cv=none; b=ja4tLGBzC6/ekCkgC+sWZQR6l/X1Kk/2daGG1VWsuf2EyDYBwCZuuWulNNZ5vI2UPCPp0xJ5lioE/+dLzTslbTtQp7/Rpa+T6BZ0Zcm/eaIzHjua1Q3FD4rJNHs8VSSLw1cft1uKvDuOxcme58KlBpSaCFah3s3jRKvJk6ie2IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717624517; c=relaxed/simple;
	bh=UZPbW0IR5w36PFk3ukWzR4v3+jjQ/ha9eGYPOLhBOWo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kNr+sLAQmI7AD2Ga9j9NVSP4mbFx95HXR9L+GI0L9BXj0A/BtsgHUJYjPscn/+12tfmnH+wH+3jvq45rRgNyuLM/icg61ewZ1/ZbjiUmulSk03IZZXBm1RIjhOqWLbyJ6vQxH9P7r19Hc9H0jxrw77NBFcaeUy2KEp5J50NSe20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EtPtG6Nx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717624514;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZV6Lkl8TnoF8BuIaryKVon5GWIOQyEZj6XsfC7CIoHI=;
	b=EtPtG6Nx7YmutKEgnMOg5l5TCw73CjITfEsGhwlE+CWZJkxtpVT2TUhnW5oGZFZjUZHTQ+
	GIMhmkrBDLco44aGYPlLE0TbYJPPgk3netlaNxHt2VJdc/ydadoxnvVst/wYtzaa8/kVbh
	/JFllWzv5BsEcWyF6NKAiuq6rvkfaL4=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-303-D44O-iXYMpqSm3GPLGRqZg-1; Wed, 05 Jun 2024 17:55:12 -0400
X-MC-Unique: D44O-iXYMpqSm3GPLGRqZg-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-52b84359026so216764e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 14:55:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717624511; x=1718229311;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZV6Lkl8TnoF8BuIaryKVon5GWIOQyEZj6XsfC7CIoHI=;
        b=FqvVfiOkVaNHLBMHnSNs9FYDal4Rdk/aYMENPzq7JgolgdqH7udTtL94Ha81bNCJVb
         wAOFXjQjmfoX2AHlKqALzrPskqcx7JPWLdHAfxgkfgp/3t7dihvyj8IWUPCBdaHv7U4U
         4Bztm/ShAklH/yU3mr5GfGnwWnDtftuhXLoigwQ+KYR3GMsqoO791zM3Rwkb0Uhc/HD8
         GwYKaR536c1XAax8ztZ0kDVYjoXEmP/EF3vjW5ffHtzPxzFxdQssRvCK6nJSv98O81af
         TCRyLVrdjerrPXfeQ4kPF7WdPUTeDzWEFblo4yGTLRWZQQZvQZJcPTu50RXJP7NIxvj3
         Sbjw==
X-Forwarded-Encrypted: i=1; AJvYcCWXVSzIVN84pe9w7i/s0NbhOONF2DaTzu9Re6bxFuFK1Wccw4i8MS33W/jisOXXxussECZUccvzwL0xJ9Sa9JvCz5VuPe+a5xMKqDpR
X-Gm-Message-State: AOJu0YypQ1xeG2jL4R+8bgLaWexbjA2D7NCDKMo3Ajnq45L/Xk0elwBW
	Gnlui5h8BjBImZn9jjCJTw7UZBm8h0OZ/3I/fW99gogmZ9ncVPD2DhwZW1TOjNjv9vvHC1ACHiw
	cLsH7sS5N1ny6J1ZOPQfP6WT49IoG+oIJv/IJ7frCGlEH57wuJndbLXQVW02UioAA6Wo5DtALQo
	R6t32mmXNWY+E1T2rM7ASbp++s49fyFYr2VDw+R1opd/LJ
X-Received: by 2002:a2e:b0cd:0:b0:2e0:aaaa:e551 with SMTP id 38308e7fff4ca-2eac7a526fbmr24710251fa.37.1717624510868;
        Wed, 05 Jun 2024 14:55:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFvLt/CiRPb5P9lD0+sOKcBCQ55vqYildzdGoOchGzeuB+TiwlAiSzLIpChot7zB6HH1kJrimAfbRzc2fsqGUk=
X-Received: by 2002:a2e:b0cd:0:b0:2e0:aaaa:e551 with SMTP id
 38308e7fff4ca-2eac7a526fbmr24710171fa.37.1717624510451; Wed, 05 Jun 2024
 14:55:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240531080739.2608969-1-jiangyunshui@kylinos.cn>
 <41e4b0e3-ecc0-43ca-a6cd-4a6beb0ceb8f@datenfreihafen.org> <20240603165543.46c7d3b4@kernel.org>
 <CAK-6q+j7vBbeB5ZPdT6szgUzYhDiPyVuadLooOywOU7M0fpfzQ@mail.gmail.com> <cb91e5d3-7596-4564-9e0b-4819e437a692@datenfreihafen.org>
In-Reply-To: <cb91e5d3-7596-4564-9e0b-4819e437a692@datenfreihafen.org>
From: Alexander Aring <aahringo@redhat.com>
Date: Wed, 5 Jun 2024 17:54:59 -0400
Message-ID: <CAK-6q+hULQbxFGyJ2t29VqjgnHgvUJ7J+Hsf8Pv-_0QaiNCTCg@mail.gmail.com>
Subject: Re: [PATCH] net: mac802154: Fix racy device stats updates by
 DEV_STATS_INC() and DEV_STATS_ADD()
To: Stefan Schmidt <stefan@datenfreihafen.org>
Cc: Jakub Kicinski <kuba@kernel.org>, Yunshui Jiang <jiangyunshui@kylinos.cn>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-wpan@vger.kernel.org, alex.aring@gmail.com, miquel.raynal@bootlin.com, 
	davem@davemloft.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jun 5, 2024 at 4:02=E2=80=AFPM Stefan Schmidt <stefan@datenfreihafe=
n.org> wrote:
>
> Hello Jakub, Alex,
>
> On 04.06.24 15:52, Alexander Aring wrote:
> > Hi,
> >
> > On Mon, Jun 3, 2024 at 7:56=E2=80=AFPM Jakub Kicinski <kuba@kernel.org>=
 wrote:
> >>
> >> On Mon, 3 Jun 2024 11:33:28 +0200 Stefan Schmidt wrote:
> >>> Hello.
> >>>
> >>> On 31.05.24 10:07, Yunshui Jiang wrote:
> >>>> mac802154 devices update their dev->stats fields locklessly. Therefo=
re
> >>>> these counters should be updated atomically. Adopt SMP safe DEV_STAT=
S_INC()
> >>>> and DEV_STATS_ADD() to achieve this.
> >>>>
> >>>> Signed-off-by: Yunshui Jiang <jiangyunshui@kylinos.cn>
> >>>> ---
> >>>>    net/mac802154/tx.c | 8 ++++----
> >>>>    1 file changed, 4 insertions(+), 4 deletions(-)
> >>>>
> >>>> diff --git a/net/mac802154/tx.c b/net/mac802154/tx.c
> >>>> index 2a6f1ed763c9..6fbed5bb5c3e 100644
> >>>> --- a/net/mac802154/tx.c
> >>>> +++ b/net/mac802154/tx.c
> >>>> @@ -34,8 +34,8 @@ void ieee802154_xmit_sync_worker(struct work_struc=
t *work)
> >>>>      if (res)
> >>>>              goto err_tx;
> >>>>
> >>>> -   dev->stats.tx_packets++;
> >>>> -   dev->stats.tx_bytes +=3D skb->len;
> >>>> +   DEV_STATS_INC(dev, tx_packets);
> >>>> +   DEV_STATS_ADD(dev, tx_bytes, skb->len);
> >>>>
> >>>>      ieee802154_xmit_complete(&local->hw, skb, false);
> >>>>
> >>>> @@ -90,8 +90,8 @@ ieee802154_tx(struct ieee802154_local *local, stru=
ct sk_buff *skb)
> >>>>              if (ret)
> >>>>                      goto err_wake_netif_queue;
> >>>>
> >>>> -           dev->stats.tx_packets++;
> >>>> -           dev->stats.tx_bytes +=3D len;
> >>>> +           DEV_STATS_INC(dev, tx_packets);
> >>>> +           DEV_STATS_ADD(dev, tx_bytes, len);
> >>>>      } else {
> >>>>              local->tx_skb =3D skb;
> >>>>              queue_work(local->workqueue, &local->sync_tx_work);
> >>>
> >>> This patch has been applied to the wpan tree and will be
> >>> part of the next pull request to net. Thanks!
> >>
> >> Hi! I haven't looked in detail, but FWIW
> >>
> >> $ git grep LLTX net/mac802154/
> >> $
> >>
> >> and similar patch from this author has been rejected:
> >>
> >> https://lore.kernel.org/all/CANn89iLPYoOjMxNjBVHY7GwPFBGuxwRoM9gZZ-fWU=
UYFYjM1Uw@mail.gmail.com/
> >
> > In the case of ieee802154_tx() yes the tx lock is held so it's like
> > what the mentioned link says. The workqueue is an ordered workqueue
> > and you either have the driver async xmit option (the preferred
> > option) or the driver sync xmit callback on a per driver (implies per
> > interface) basis.
>
> When I reviewed and applied this I did indeed not realize the ordered
> workqueue making this unnecessary.
>
> > I also don't see why there is currently a problem with the current
> > non-atomic way.
>
> For me this looks more like a wrapper that could avoid future problems
> for no cost. I would not mind if the patch stays. But you are right, its
> not strictly needed. Want me to back it out again?

it's fine for me. I think atomic ops, depending on $ARCH will mess up
your pipelines in some kind of way but it is better than using locks
of course (but locks are here required for other things).

- Alex


