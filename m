Return-Path: <linux-kernel+bounces-200750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F19298FB48E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 15:56:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8952B22E0E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 13:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FAADDF5C;
	Tue,  4 Jun 2024 13:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MbvgTgZJ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 631FBB669
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 13:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717509158; cv=none; b=utVETHP2onICb51+Ee2cGuQh+E/dg00uQLc0100hQ7tlwWLmwGF31OESUdbodgu7C48eX5mYvRqSbf6YPf8ouXH6QvMM2oVxmEdmLtwuMsOW+uYUfHFDKBcSJw0Cz5Q3oEygaX3+a/Webdzsr4KcKe0z0F5FqxPZJknjWsKbr7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717509158; c=relaxed/simple;
	bh=AU+eGvnqHFAm1RBD3hnb/xZtqJPO5HTmEwoNf646to4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I2w9AWb5Z9p4Ki9s9KiApDZ0UEBCw24BmmizI4/k4WCSzK80kfIZp2D/YqCOPgqkKEcoV2KuDohBuqsObSBZIo7ptdUSgyuT4hfT91IsHSI2YsR8fVWOnTWKJTKco7AehzSRVx5QR8uYwxjz+YJcrcBeOId1ZUVE3gCBPCWjrk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MbvgTgZJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717509156;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yAFQzZY8JpxmgqUlWM1NDpMdAv0BIR7b/lj5ql78PZE=;
	b=MbvgTgZJcvD79F9Jp/UUkPX6kCLFy7UA+QN0GDWgTxo21eEr40bz+LdTi9UanDCPEAGYRx
	ZQOjdDjttO0EYpKIxVXhaHQXLV2sg3hhrsOaECDGGsPJKIGMZNZsyJ0JdztGagNuKGnnId
	MZ0ymSdW5QybQ0KOK3zdmxPDIaAs6Os=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-8TZ4FrU1Pa6TxmIxOvE52A-1; Tue, 04 Jun 2024 09:52:34 -0400
X-MC-Unique: 8TZ4FrU1Pa6TxmIxOvE52A-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2eaa90653adso18127851fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 06:52:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717509153; x=1718113953;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yAFQzZY8JpxmgqUlWM1NDpMdAv0BIR7b/lj5ql78PZE=;
        b=bsxghTsgDGsAaOelplkvAY2AlhDay5vCKbcKPuO4b1AVsSFPzGBTFVsz8DLuFqZiVZ
         joe1gMqFWOJs3QVcwdvNtsc9uqW15zq1CR+lROm/7IMfTrwQxzPfe0NhQR1gd6ZbjGje
         CRFIjfUFlXDJNXCrDezYspfTZQsWP/VCX+zrl63Yqohi2OxlZXHwOG6L3Mp0tTR0ga/2
         JCbO4X7KCICFbQAmtSqMOIXGbY6l6kQcK+6Rg/fCHqsSnDOsx10l4CmD7n6eV7iLBQfY
         wpNw2K0+bnvf6OSZrzZyflA0d9i7G5AJb4qhe0HLnBjyF1RO1IXN/7h/8rvH2MN0hYdB
         ELQg==
X-Forwarded-Encrypted: i=1; AJvYcCXYuUlO7ZGmzVwMpYYfCRlHqyCg7c+79o61XpDMNCTdp8F1CvYF9kMQPafXlZy9KWcN8nznh530X5FjI4TxXVgQUFwPVXv1Y9XFzRjG
X-Gm-Message-State: AOJu0YxeZJZFK/UCUzXur20Bhpy9bt5Kgd+blIsLYmKsDPoWC3+EVa/W
	MJDBLT8ayx/cLJiDNU9qszjqKX3aPVTtrwwFkm18HOt509UGIG9iJgZQYm8UxPUkSPwpJJVQYzu
	iGZ/rlmIhZ6XiMMrZFYGh+rr8HrLQLTyoEi7kO9aF6DzNC1NZxMVyHmh3aqv1e+bBZV7120Kd+N
	/u5Dyzmyfta1UIWuUegQ08hsh83xwTFHUeMIvB
X-Received: by 2002:a2e:9b06:0:b0:2ea:8e94:a2f4 with SMTP id 38308e7fff4ca-2ea950fa369mr80608131fa.21.1717509152874;
        Tue, 04 Jun 2024 06:52:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEVcTnWxMbCCJGk8cFzSvdq37qQbJ2J1M96WyUbWFPtZFyvR59Ym03swakCQ6zW818B7BZAniACmpmHL6wioLs=
X-Received: by 2002:a2e:9b06:0:b0:2ea:8e94:a2f4 with SMTP id
 38308e7fff4ca-2ea950fa369mr80607931fa.21.1717509152500; Tue, 04 Jun 2024
 06:52:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240531080739.2608969-1-jiangyunshui@kylinos.cn>
 <41e4b0e3-ecc0-43ca-a6cd-4a6beb0ceb8f@datenfreihafen.org> <20240603165543.46c7d3b4@kernel.org>
In-Reply-To: <20240603165543.46c7d3b4@kernel.org>
From: Alexander Aring <aahringo@redhat.com>
Date: Tue, 4 Jun 2024 09:52:20 -0400
Message-ID: <CAK-6q+j7vBbeB5ZPdT6szgUzYhDiPyVuadLooOywOU7M0fpfzQ@mail.gmail.com>
Subject: Re: [PATCH] net: mac802154: Fix racy device stats updates by
 DEV_STATS_INC() and DEV_STATS_ADD()
To: Jakub Kicinski <kuba@kernel.org>
Cc: Stefan Schmidt <stefan@datenfreihafen.org>, Yunshui Jiang <jiangyunshui@kylinos.cn>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-wpan@vger.kernel.org, alex.aring@gmail.com, miquel.raynal@bootlin.com, 
	davem@davemloft.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jun 3, 2024 at 7:56=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Mon, 3 Jun 2024 11:33:28 +0200 Stefan Schmidt wrote:
> > Hello.
> >
> > On 31.05.24 10:07, Yunshui Jiang wrote:
> > > mac802154 devices update their dev->stats fields locklessly. Therefor=
e
> > > these counters should be updated atomically. Adopt SMP safe DEV_STATS=
_INC()
> > > and DEV_STATS_ADD() to achieve this.
> > >
> > > Signed-off-by: Yunshui Jiang <jiangyunshui@kylinos.cn>
> > > ---
> > >   net/mac802154/tx.c | 8 ++++----
> > >   1 file changed, 4 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/net/mac802154/tx.c b/net/mac802154/tx.c
> > > index 2a6f1ed763c9..6fbed5bb5c3e 100644
> > > --- a/net/mac802154/tx.c
> > > +++ b/net/mac802154/tx.c
> > > @@ -34,8 +34,8 @@ void ieee802154_xmit_sync_worker(struct work_struct=
 *work)
> > >     if (res)
> > >             goto err_tx;
> > >
> > > -   dev->stats.tx_packets++;
> > > -   dev->stats.tx_bytes +=3D skb->len;
> > > +   DEV_STATS_INC(dev, tx_packets);
> > > +   DEV_STATS_ADD(dev, tx_bytes, skb->len);
> > >
> > >     ieee802154_xmit_complete(&local->hw, skb, false);
> > >
> > > @@ -90,8 +90,8 @@ ieee802154_tx(struct ieee802154_local *local, struc=
t sk_buff *skb)
> > >             if (ret)
> > >                     goto err_wake_netif_queue;
> > >
> > > -           dev->stats.tx_packets++;
> > > -           dev->stats.tx_bytes +=3D len;
> > > +           DEV_STATS_INC(dev, tx_packets);
> > > +           DEV_STATS_ADD(dev, tx_bytes, len);
> > >     } else {
> > >             local->tx_skb =3D skb;
> > >             queue_work(local->workqueue, &local->sync_tx_work);
> >
> > This patch has been applied to the wpan tree and will be
> > part of the next pull request to net. Thanks!
>
> Hi! I haven't looked in detail, but FWIW
>
> $ git grep LLTX net/mac802154/
> $
>
> and similar patch from this author has been rejected:
>
> https://lore.kernel.org/all/CANn89iLPYoOjMxNjBVHY7GwPFBGuxwRoM9gZZ-fWUUYF=
YjM1Uw@mail.gmail.com/

In the case of ieee802154_tx() yes the tx lock is held so it's like
what the mentioned link says. The workqueue is an ordered workqueue
and you either have the driver async xmit option (the preferred
option) or the driver sync xmit callback on a per driver (implies per
interface) basis.

I also don't see why there is currently a problem with the current
non-atomic way.

- Alex


