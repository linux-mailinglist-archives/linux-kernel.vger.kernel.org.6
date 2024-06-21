Return-Path: <linux-kernel+bounces-225008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A175A912A7E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 17:41:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5612F280E93
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 15:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13335142620;
	Fri, 21 Jun 2024 15:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="dlXuFeO1"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE0815444C
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 15:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718984459; cv=none; b=gqzKLPdZXmKPHCSeDM6gsrlBD51V/v3yD5ghjQ6JIxO29Y8WamzDjj2pdvVG5ZNATZrdKgCS3SofTu73oVAYcv1FgTCvbgDr8wbscB8fEH4/FbjA1A/MMSKyLBaWltU3usVuVKiJtbVr08jpfvR2i0F0Y1XVNEraoCVAW+WpNSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718984459; c=relaxed/simple;
	bh=M5hQFADkyAXAzxKb0j5OaON7Ocd4rbvfXil7V15NScY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SKdTJlcQ7JQt+UZ7LzdrFrMA4vLSvLdz0ubIoa9AXRx00yrCCsrm1emq6e8vzS8HcIXB54erJjcZPaMIXJ6m9hE/u10qisblNqt1GHnPwE655Gsa/5Or6Ipj2KHhwHJuN35G5iDSwfQaclspDN45UMfKwrSgSOVrKh6wMn8uQgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=dlXuFeO1; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2ec52fbb50aso2771631fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 08:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1718984455; x=1719589255; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ITQplhMiV0b/XVFET6r9dSYiL51VVA3294UIGshKU6M=;
        b=dlXuFeO1EusRyFDKRGOZWRUlyeLu2Z6omlZYQBKk7/Bf8QJy9V1VIqiuJqs23DNHJa
         4ZvsMdPMEdfY/5fm6IRRFhauAttjL6awCBJYpfH05cF7vCnSTdFEYHZYi4JN3HgMx+Bz
         /douloCTAr6tdPHlfhxzHy0q+xbWFpwGRNdbIzVcv9W8zoMBVDCTpPFIiBABuHBrt5oC
         uThbjKiH+bStNO1AbcQu+pMdtu3ZNZFXJqhwkgHFRLaAVVckECj6Y6AAwuqifbm9/CkI
         HTVUszkoIKw0XZtoY4AOydxy4+B/GCRjw6INPaWW7eWy6SEBUzU3BKHZ4vXT2CWqN1oE
         1d+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718984455; x=1719589255;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ITQplhMiV0b/XVFET6r9dSYiL51VVA3294UIGshKU6M=;
        b=cL7nVc0DK9v5juELQD91SCzV+p3/tQNsVXafRZ1Px88FwwkmHSu22nmdoQ2nuC+KmV
         g5UH1QzcAxgQIKq8v5zp260iWGyn5R7ymGE+u7XIxh6bc/QWj6Q+eJvAJehidSuZtieJ
         bJG+Z17egQpVo831/piIWBAONgpPwifmUvOZQGACPLEfhfb3I8yDS5vcMsxo2gY6CcvK
         ZKVBX2b8wcu+er3PUiK5LX0oDDEaGiF0neTh0f51cwCLLvn698JSgBWiLkFoZlZeZb42
         7JMe8cy9MH1YB634nxQeul3jt2yO2XcG99IGT9biy2bcdX1hur1AiTQ8yhKEQU/4d9JL
         5oIg==
X-Forwarded-Encrypted: i=1; AJvYcCXWqZ0MJD+dcAd1Ox0ayvup0G7AjgTaMJHlCFH51RxB/F/kE9vl/MQiFa29nhtCKpC9Pmgx5fzfWI94DaNIwvc83l7PCoqdekMlp7sG
X-Gm-Message-State: AOJu0Yxk6ZelIfuKwNxNhUPZnc9A3/PDxPI05VUnrEy4/QXCxhx0QDNG
	/dtUaH4v9ZT0jNYwtzFe4IdQCEpt9OM8xUE6cgebBdVxEAo4Yd9201Alf1dXW4CfJlG5vyGCT5L
	I4ttFwaSC9TuIAOTeWCfxpMR4qjxqeaj4PXJChA==
X-Google-Smtp-Source: AGHT+IH2IostdubtS6pKCWbrAkESd03OxM2FOyVGOL1lqEbwnPW82ccU4bdIloRvLJ0wnlGCr1La92Iy2sC6XmDoY50=
X-Received: by 2002:a05:651c:20f:b0:2eb:f6bd:e4ec with SMTP id
 38308e7fff4ca-2ec3cea1b44mr65343691fa.24.1718984455332; Fri, 21 Jun 2024
 08:40:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1718919473.git.yan@cloudflare.com> <b8c183a24285c2ab30c51622f4f9eff8f7a4752f.1718919473.git.yan@cloudflare.com>
 <17c0b83b-b3f4-43c0-be3f-d72a56e4087e@intel.com>
In-Reply-To: <17c0b83b-b3f4-43c0-be3f-d72a56e4087e@intel.com>
From: Yan Zhai <yan@cloudflare.com>
Date: Fri, 21 Jun 2024 10:40:44 -0500
Message-ID: <CAO3-PbpB-Wqji-9vFifCTExah-ctRkPSpz60EQvsA=oYdPpQZQ@mail.gmail.com>
Subject: Re: [RFC net-next 1/9] skb: introduce gro_disabled bit
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Willem de Bruijn <willemb@google.com>, Simon Horman <horms@kernel.org>, Florian Westphal <fw@strlen.de>, 
	Mina Almasry <almasrymina@google.com>, Abhishek Chauhan <quic_abchauha@quicinc.com>, 
	David Howells <dhowells@redhat.com>, David Ahern <dsahern@kernel.org>, 
	Richard Gobert <richardbgobert@gmail.com>, Antoine Tenart <atenart@kernel.org>, 
	Felix Fietkau <nbd@nbd.name>, Soheil Hassas Yeganeh <soheil@google.com>, 
	Pavel Begunkov <asml.silence@gmail.com>, Lorenzo Bianconi <lorenzo@kernel.org>, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 21, 2024 at 4:13=E2=80=AFAM Alexander Lobakin
<aleksander.lobakin@intel.com> wrote:
>
> From: Yan Zhai <yan@cloudflare.com>
> Date: Thu, 20 Jun 2024 15:19:10 -0700
>
> > Software GRO is currently controlled by a single switch, i.e.
> >
> >   ethtool -K dev gro on|off
> >
> > However, this is not always desired. When GRO is enabled, even if the
> > kernel cannot GRO certain traffic, it has to run through the GRO receiv=
e
> > handlers with no benefit.
> >
> > There are also scenarios that turning off GRO is a requirement. For
> > example, our production environment has a scenario that a TC egress hoo=
k
> > may add multiple encapsulation headers to forwarded skbs for load
> > balancing and isolation purpose. The encapsulation is implemented via
> > BPF. But the problem arises then: there is no way to properly offload a
> > double-encapsulated packet, since skb only has network_header and
> > inner_network_header to track one layer of encapsulation, but not two.
>
> Implement it in the kernel then? :D
>
It would be a big commitment that I dare not make :) Out of curiosity,
is it something that devices can handle today?

> > On the other hand, not all the traffic through this device needs double
> > encapsulation. But we have to turn off GRO completely for any ingress
> > device as a result.
> >
> > Introduce a bit on skb so that GRO engine can be notified to skip GRO o=
n
> > this skb, rather than having to be 0-or-1 for all traffic.
> >
> > Signed-off-by: Yan Zhai <yan@cloudflare.com>
> > ---
> >  include/linux/netdevice.h |  9 +++++++--
> >  include/linux/skbuff.h    | 10 ++++++++++
> >  net/Kconfig               | 10 ++++++++++
> >  net/core/gro.c            |  2 +-
> >  net/core/gro_cells.c      |  2 +-
> >  net/core/skbuff.c         |  4 ++++
> >  6 files changed, 33 insertions(+), 4 deletions(-)
> >
> > diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> > index c83b390191d4..2ca0870b1221 100644
> > --- a/include/linux/netdevice.h
> > +++ b/include/linux/netdevice.h
> > @@ -2415,11 +2415,16 @@ struct net_device {
> >       ((dev)->devlink_port =3D (port));                         \
> >  })
> >
> > -static inline bool netif_elide_gro(const struct net_device *dev)
> > +static inline bool netif_elide_gro(const struct sk_buff *skb)
> >  {
> > -     if (!(dev->features & NETIF_F_GRO) || dev->xdp_prog)
> > +     if (!(skb->dev->features & NETIF_F_GRO) || skb->dev->xdp_prog)
> >               return true;
> > +
> > +#ifdef CONFIG_SKB_GRO_CONTROL
> > +     return skb->gro_disabled;
> > +#else
> >       return false;
> > +#endif
> >  }
> >
> >  #define      NETDEV_ALIGN            32
> > diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> > index f4cda3fbdb75..48b10ece95b5 100644
> > --- a/include/linux/skbuff.h
> > +++ b/include/linux/skbuff.h
> > @@ -1008,6 +1008,9 @@ struct sk_buff {
> >  #if IS_ENABLED(CONFIG_IP_SCTP)
> >       __u8                    csum_not_inet:1;
> >  #endif
> > +#ifdef CONFIG_SKB_GRO_CONTROL
> > +     __u8                    gro_disabled:1;
> > +#endif
> >
> >  #if defined(CONFIG_NET_SCHED) || defined(CONFIG_NET_XGRESS)
> >       __u16                   tc_index;       /* traffic control index =
*/
> > @@ -1215,6 +1218,13 @@ static inline bool skb_wifi_acked_valid(const st=
ruct sk_buff *skb)
> >  #endif
> >  }
> >
> > +static inline void skb_disable_gro(struct sk_buff *skb)
> > +{
> > +#ifdef CONFIG_SKB_GRO_CONTROL
> > +     skb->gro_disabled =3D 1;
> > +#endif
> > +}
> > +
> >  /**
> >   * skb_unref - decrement the skb's reference count
> >   * @skb: buffer
> > diff --git a/net/Kconfig b/net/Kconfig
> > index 9fe65fa26e48..47d1ee92df15 100644
> > --- a/net/Kconfig
> > +++ b/net/Kconfig
> > @@ -289,6 +289,16 @@ config MAX_SKB_FRAGS
> >         and in drivers using build_skb().
> >         If unsure, say 17.
> >
> > +config SKB_GRO_CONTROL
> > +     bool "allow disable GRO on per-packet basis"
> > +     default y
> > +     help
> > +       By default GRO can only be enabled or disabled per network devi=
ce.
> > +       This can be cumbersome for certain scenarios.
> > +       Toggling this option will allow disabling GRO for selected pack=
ets,
> > +       e.g. by XDP programs, so that it is more flexibile.
> > +       Extra overhead should be minimal.
>
> I don't think we need a Kconfig option for that. Can't it be
> unconditional? Is there any real eye-visible overhead?

Normally if it is a single branch I would not worry about it. But I
know I am touching a hot potato here so I just want to be cautious :)

best
Yan

>
> Thanks,
> Olek

