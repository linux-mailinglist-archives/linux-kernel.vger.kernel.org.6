Return-Path: <linux-kernel+bounces-307211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9306F964A1B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 17:32:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E7FA1F23083
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 15:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B8491B3F0B;
	Thu, 29 Aug 2024 15:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CKv9zzdq"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF8261A0732
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 15:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724945506; cv=none; b=M6WdyvrryKe6HLnf5dhri16xANPpHyfVyzjPSnwt49gtD6p0mNV5JjS5VUV/H95Pptsl8uF8xOR9Vcsm1YSnlY9249WDQXipP7sSaQrQmS4ucXU2qytJzwnxJCZA84E+AoA/9DHLnz1iE6wnvq6p7JaAYC3bTsw5KbNrvIXfWus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724945506; c=relaxed/simple;
	bh=HJmwn/0JFnzsnQnzKr8gkbD+ep4LL2U46xq8HCPKOfc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=JjM5L9Tv4jl0F7FBjJxDFPdWsW5Q/8qs/Hw6PVt9BVqVD7U9sypVoBy8pFcEaa/6TYlIEki4cMiiFCsuKCGBp+1emxfKOQAwyneWQPoQjT5QlMB0XhopbkYAY+weRbLrmt2ZBhUXoRef3wntmljWp5YYSirJL4sGJQwdDZLMoT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CKv9zzdq; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2f3f163e379so13068951fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 08:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724945503; x=1725550303; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1U1YaxDrIZa5AMVlFHNmIflB8sd0no/S8DXcr9Xwqxg=;
        b=CKv9zzdqGnxK30sccuDFjpeOLYQW4LC4eoH+2xS28l8563eqXHPWPw4cIOTRftjUey
         CNpzUdi1yYultXRG25CTjP771zm6mCvoArfUdGGxwGAz80ki5e0TuZvTA//K9g9bxLjj
         g5S4n2ZlHoGfsN2fVwH3dLiz6dx9iHkflRnmXZo5wUPnLNHo51W1qCmrfgh0CA5wTrCo
         xnTWW7mCsvtEKFqAb6NPEOfjtsl+skJRkOv2xmoOXbU7JNrXaki2aeO5x0G/1FHLIQkH
         6MvTvuAvixWsML7FMGC1y+8183dQN7Dx4WwS8sBypEYS81aBxnhRUZiBSRGAcVZi/tx+
         WKLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724945503; x=1725550303;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1U1YaxDrIZa5AMVlFHNmIflB8sd0no/S8DXcr9Xwqxg=;
        b=Sg/yvDNiqFhz2V6xKhRhsTdFjzCjK4NLSShWlD0pTt3vH0IZwVYNneCOvDdN1fRlpN
         ngnuDmzqL/4VfIE+dtoZWy74UdvrxFHu12oTw1mbYTht33ZuS5MTNgpeGYk/EvsXA5xy
         It2+MvoFnTYXk7NQn/b3m2NG+n6l7rdyEU+IKX94PaDv8LcEYpv+QjVJXfRxPh9m70h6
         SJ/NRhUz4zKaossk/qhxr97sJiJVUHw/l/1Qyb/vg3MZ4CaC3jk2azJnpq8NWXg8/F3Q
         IBi585478u9kq2jqQ2kRS76PyIVoElDv4NhmlFg+qzYWojdb7lP2x1iOu3Lve4THdFdV
         jPwg==
X-Forwarded-Encrypted: i=1; AJvYcCXi7oW+4KNiIyMjp819Mb3umzJgIUjao4uhm/nGfSNiLgun4ccWxLDPmYm/Z+iA+EpyNMzBbzHeDHagSUA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhUz4cdNjcrt7aRxBqzOwD7VVPGJNLjk1kRnG/3m8BcfmgIipj
	ZcRWWe+/CmR9IE+cb5dX2S4KDU4prbppRG9CGemh1vcfyJ7V5UblahcSmRs8Y1dn2SScGqH4AQv
	rDHR5YrzvUBPFAl3RRjIDyQKsUAjRb//zJ9eC
X-Google-Smtp-Source: AGHT+IEU6GOaXKR9I2jPDVOQ4lVSi6XXLtyFi4pPPM5bH2cZUJwcifL4f/1ZEBLGQ9soQOhjCYDh5zF2yVTZbC+r6GE=
X-Received: by 2002:a05:6512:3d05:b0:535:3da7:5b59 with SMTP id
 2adb3069b0e04-5353e5431d9mr3651290e87.12.1724945501915; Thu, 29 Aug 2024
 08:31:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240829131214.169977-1-jdamato@fastly.com> <20240829131214.169977-4-jdamato@fastly.com>
 <CANn89iKUqF5bO_Ca+qrfO_gsfWmutpzFL-ph5mQd86_2asW9dg@mail.gmail.com> <ZtCTgEEgcL3XqQcO@LQ3V64L9R2>
In-Reply-To: <ZtCTgEEgcL3XqQcO@LQ3V64L9R2>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 29 Aug 2024 17:31:30 +0200
Message-ID: <CANn89iJgXsn7yjWaiuuq=LFsKpQi8RQFo89MDRxeNddxeZUC2A@mail.gmail.com>
Subject: Re: [PATCH net-next 3/5] net: napi: Make gro_flush_timeout per-NAPI
To: Joe Damato <jdamato@fastly.com>, Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org, 
	amritha.nambiar@intel.com, sridhar.samudrala@intel.com, sdf@fomichev.me, 
	bjorn@rivosinc.com, hch@infradead.org, willy@infradead.org, 
	willemdebruijn.kernel@gmail.com, skhawaja@google.com, kuba@kernel.org, 
	Martin Karsten <mkarsten@uwaterloo.ca>, "David S. Miller" <davem@davemloft.net>, 
	Paolo Abeni <pabeni@redhat.com>, Jiri Pirko <jiri@resnulli.us>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Lorenzo Bianconi <lorenzo@kernel.org>, 
	Breno Leitao <leitao@debian.org>, Johannes Berg <johannes.berg@intel.com>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, Heiner Kallweit <hkallweit1@gmail.com>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 29, 2024 at 5:28=E2=80=AFPM Joe Damato <jdamato@fastly.com> wro=
te:
>
> On Thu, Aug 29, 2024 at 03:48:05PM +0200, Eric Dumazet wrote:
> > On Thu, Aug 29, 2024 at 3:13=E2=80=AFPM Joe Damato <jdamato@fastly.com>=
 wrote:
> > >
> > > Allow per-NAPI gro_flush_timeout setting.
> > >
> > > The existing sysfs parameter is respected; writes to sysfs will write=
 to
> > > all NAPI structs for the device and the net_device gro_flush_timeout
> > > field.  Reads from sysfs will read from the net_device field.
> > >
> > > The ability to set gro_flush_timeout on specific NAPI instances will =
be
> > > added in a later commit, via netdev-genl.
> > >
> > > Signed-off-by: Joe Damato <jdamato@fastly.com>
> > > Reviewed-by: Martin Karsten <mkarsten@uwaterloo.ca>
> > > Tested-by: Martin Karsten <mkarsten@uwaterloo.ca>
> > > ---
> > >  include/linux/netdevice.h | 26 ++++++++++++++++++++++++++
> > >  net/core/dev.c            | 32 ++++++++++++++++++++++++++++----
> > >  net/core/net-sysfs.c      |  2 +-
> > >  3 files changed, 55 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> > > index 7d53380da4c0..d00024d9f857 100644
> > > --- a/include/linux/netdevice.h
> > > +++ b/include/linux/netdevice.h
> > > @@ -372,6 +372,7 @@ struct napi_struct {
> > >         int                     rx_count; /* length of rx_list */
> > >         unsigned int            napi_id;
> > >         int                     defer_hard_irqs;
> > > +       unsigned long           gro_flush_timeout;
> > >         struct hrtimer          timer;
> > >         struct task_struct      *thread;
> > >         /* control-path-only fields follow */
> > > @@ -557,6 +558,31 @@ void napi_set_defer_hard_irqs(struct napi_struct=
 *n, int defer);
> > >   */
> > >  void netdev_set_defer_hard_irqs(struct net_device *netdev, int defer=
);
> > >
> >
> > Same remark :  dev->gro_flush_timeout is no longer read in the fast pat=
h.
> >
> > Please move gro_flush_timeout out of net_device_read_txrx and update
> > Documentation/networking/net_cachelines/net_device.rst
>
> Is there some tooling I should use to generate this file?
>
> I am asking because it seems like the file is missing two fields in
> net_device at the end of the struct:
>
> struct hlist_head          page_pools;
> struct dim_irq_moder *     irq_moder;
>

At first glance this is control path only, no big deal.

> Both of which seem to have been added just before and long after
> (respectively) commit 14006f1d8fa2 ("Documentations: Analyze heavily
> used Networking related structs").
>
> If this is a bug, I can submit one patch (with two fixes tags) which
> adds both fields to the file?

No need for a Fixes: tag for this, just submit to net-next.

This file is really 'needed' for current development, for people
caring about data locality.

