Return-Path: <linux-kernel+bounces-225032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C506A912AD6
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 18:05:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE404B256DB
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 16:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C563C15FA8C;
	Fri, 21 Jun 2024 16:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="V/RM0Zau"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F895028C
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 16:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718985932; cv=none; b=Oa58GzHS2hj6drNSGhY/yV1H8JImGwXMST4FSIZ5tJ1g6mzwDuX30Zgf2JLmoJEUAnc78XjwST9AAWVviCfN5F9DK8tS3S1IuXcGqvP5eAc6nwhaGCRjh1V3LFuzD1B6MkG7u9wyxbG8bHrX2qtAkOUHbOS5zndxuPh3fLxXvDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718985932; c=relaxed/simple;
	bh=fkwPZLyQNQ4ZNXfxazc5Zwbqv5MiORFU7s6HGX0pBXo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nVvMT/CKLyldwLQjpg6kFSbKMZYDn199pLHl2ztTBAYReN/dI431sQmamm6RJs5NPTZSCCatf32saYqybOzI1Uw7r08GkYqBYPMmE/f1dK4q8LfAfTBZO4BfsSSbl+7f8N+OEqv3w8WjcQMgkIid3HT4LTZ5u5hfENhcL321EQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=V/RM0Zau; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-57d1d45ba34so2467929a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 09:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1718985927; x=1719590727; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D2aLeA46ZAcGtDVAAuPO+bTYmu9QSz8VmaNmucxcUMo=;
        b=V/RM0ZauFfBwHiyGmK69tMrTEtIlck9+4z5c+chqweQK7pscIT5gmLbxwJsMw0kXij
         aZtfvoPX47z8UnwHZ6TYdv3IYaM9uMeJp/obQMgR0S67uAgul4jVrAFDExWYY7e3Cdxn
         zv01dX7S76E3o8nPKHsdv4aByMscP3clQ6gV+jAyfTvlYG+69yRb9I+44x5ISly0fyES
         LivPrYzfMn276anaK5ua7FSqgR1/B0u2H3Qr7gxFiaGysxQkFFXdEDqzt+AEYiCKIMDl
         k/MGflMmsKJWDhxHVRyB2pld3NK7LMN644LDvAM0Bi67zLeLwai22JfuYLnxAXnsX2x8
         LRkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718985927; x=1719590727;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D2aLeA46ZAcGtDVAAuPO+bTYmu9QSz8VmaNmucxcUMo=;
        b=mFKjCKY6rXxHNjhZaV4XHLherahO9RG43srMyEXQWx3nT4rGGbVaRabhVX59rxi0s+
         nGOfRSa/mXsqGZXZvH2ExRdAQXGG4/4EkA+70SJ9tAxsGKwgvwsuaHIDPpuW3Eo/5NpG
         7/hym8Ga4Au/vZxaU92CJAOq1map3tM2XTKSbcrvBpFW0OxOUTb9nfzeE435B9J3vp+5
         dUDjVHYNCNSY2XYHaXrM3zwxQkloKtBzJ7n0esLHFtNLIqwW2Zl89Hmak8YqzWesQh5M
         UfgWEKl0amhqsSs79M0yj2hO5xjNhqM265uQYgkGZUJFi9hveG2XT7B1jhVzsgONG4Ht
         4+9g==
X-Forwarded-Encrypted: i=1; AJvYcCWq8udgyA9JMnzg65MJveu/gWNrsjkXiE3HMPwOZ3dtsbXjWki15Pvdy+epKArjzCf5xYR3HP6ZsyBizEPAeR4LyoWx/XhfUC/Sj6fr
X-Gm-Message-State: AOJu0YzV5ZxTfDB5Sy+3UKZIpOVspXaA3DWzJZPg/RiXr4qLtsRAsmGg
	NpAjUwwkOlYEyNADwkeA8K/adw09a0iSTdE4rd2y8xVMm/gMKj58pLlrRVqL/cLB+/0YFlxt/59
	3DLmEO0u+YRKGbaNVKR/CJRdeoMWR4QEVPVZ09A==
X-Google-Smtp-Source: AGHT+IGD3zOZ+DlFfttlvVbViNyesT1FVgv0TCou1a6PzL45XRc693Rl+UIwHlsumxzTa5uTopBV2v3bgejeyto8xfA=
X-Received: by 2002:a50:9e67:0:b0:57d:57c:ce99 with SMTP id
 4fb4d7f45d1cf-57d07e68e29mr4776325a12.2.1718985927129; Fri, 21 Jun 2024
 09:05:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1718919473.git.yan@cloudflare.com> <a9eba425bfd3bfac7e7be38fe86ad5dbff3ae01f.1718919473.git.yan@cloudflare.com>
 <6414deb0-165c-4a98-8467-ba6949166f96@intel.com>
In-Reply-To: <6414deb0-165c-4a98-8467-ba6949166f96@intel.com>
From: Yan Zhai <yan@cloudflare.com>
Date: Fri, 21 Jun 2024 11:05:16 -0500
Message-ID: <CAO3-PbrVbOo9ydrtc7kfWitXrnftgT3QGpub3y2K209L0jis1Q@mail.gmail.com>
Subject: Re: [RFC net-next 5/9] ice: apply XDP offloading fixup when building skb
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: netdev@vger.kernel.org, Jesse Brandeburg <jesse.brandeburg@intel.com>, 
	Tony Nguyen <anthony.l.nguyen@intel.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	=?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	Magnus Karlsson <magnus.karlsson@intel.com>, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Jonathan Lemon <jonathan.lemon@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 21, 2024 at 4:22=E2=80=AFAM Alexander Lobakin
<aleksander.lobakin@intel.com> wrote:
>
> From: Yan Zhai <yan@cloudflare.com>
> Date: Thu, 20 Jun 2024 15:19:22 -0700
>
> > Add a common point to transfer offloading info from XDP context to skb.
> >
> > Signed-off-by: Yan Zhai <yan@cloudflare.com>
> > Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>
> > ---
> >  drivers/net/ethernet/intel/ice/ice_txrx.c | 2 ++
> >  drivers/net/ethernet/intel/ice/ice_xsk.c  | 6 +++++-
> >  include/net/xdp_sock_drv.h                | 2 +-
> >  3 files changed, 8 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/et=
hernet/intel/ice/ice_txrx.c
> > index 8bb743f78fcb..a247306837ed 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_txrx.c
> > +++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
> > @@ -1222,6 +1222,7 @@ int ice_clean_rx_irq(struct ice_rx_ring *rx_ring,=
 int budget)
> >
> >                       hard_start =3D page_address(rx_buf->page) + rx_bu=
f->page_offset -
> >                                    offset;
> > +                     xdp_init_buff_minimal(xdp);
>
> Two lines below, you have this:
>
>         xdp_buff_clear_frags_flag(xdp);
>
> Which clears frags bit in xdp->flags. I.e. since you always clear flags
> here, this call becomes redundant.
> But I'd say that `xdp->flags =3D 0` really wants to be moved from
> xdp_init_buff() to xdp_prepare_buff().
>
You are right, there is some redundancy here. I will fix it if people
feel good about the use case in general :)


> >                       xdp_prepare_buff(xdp, hard_start, offset, size, !=
!offset);
> >  #if (PAGE_SIZE > 4096)
> >                       /* At larger PAGE_SIZE, frame_sz depend on len si=
ze */
> > @@ -1287,6 +1288,7 @@ int ice_clean_rx_irq(struct ice_rx_ring *rx_ring,=
 int budget)
> >
> >               /* populate checksum, VLAN, and protocol */
> >               ice_process_skb_fields(rx_ring, rx_desc, skb);
> > +             xdp_buff_fixup_skb_offloading(xdp, skb);
> >
> >               ice_trace(clean_rx_irq_indicate, rx_ring, rx_desc, skb);
> >               /* send completed skb up the stack */
> > diff --git a/drivers/net/ethernet/intel/ice/ice_xsk.c b/drivers/net/eth=
ernet/intel/ice/ice_xsk.c
> > index a65955eb23c0..367658acaab8 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_xsk.c
> > +++ b/drivers/net/ethernet/intel/ice/ice_xsk.c
> > @@ -845,8 +845,10 @@ int ice_clean_rx_irq_zc(struct ice_rx_ring *rx_rin=
g, int budget)
> >       xdp_prog =3D READ_ONCE(rx_ring->xdp_prog);
> >       xdp_ring =3D rx_ring->xdp_ring;
> >
> > -     if (ntc !=3D rx_ring->first_desc)
> > +     if (ntc !=3D rx_ring->first_desc) {
> >               first =3D *ice_xdp_buf(rx_ring, rx_ring->first_desc);
> > +             xdp_init_buff_minimal(first);
>
> xdp_buff_set_size() always clears flags, this is redundant.
>
> > +     }
> >
> >       while (likely(total_rx_packets < (unsigned int)budget)) {
> >               union ice_32b_rx_flex_desc *rx_desc;
> > @@ -920,6 +922,7 @@ int ice_clean_rx_irq_zc(struct ice_rx_ring *rx_ring=
, int budget)
> >                       break;
> >               }
> >
> > +             xdp =3D first;
> >               first =3D NULL;
> >               rx_ring->first_desc =3D ntc;
> >
> > @@ -934,6 +937,7 @@ int ice_clean_rx_irq_zc(struct ice_rx_ring *rx_ring=
, int budget)
> >               vlan_tci =3D ice_get_vlan_tci(rx_desc);
> >
> >               ice_process_skb_fields(rx_ring, rx_desc, skb);
> > +             xdp_buff_fixup_skb_offloading(xdp, skb);
> >               ice_receive_skb(rx_ring, skb, vlan_tci);
> >       }
> >
> > diff --git a/include/net/xdp_sock_drv.h b/include/net/xdp_sock_drv.h
> > index 0a5dca2b2b3f..02243dc064c2 100644
> > --- a/include/net/xdp_sock_drv.h
> > +++ b/include/net/xdp_sock_drv.h
> > @@ -181,7 +181,7 @@ static inline void xsk_buff_set_size(struct xdp_buf=
f *xdp, u32 size)
> >       xdp->data =3D xdp->data_hard_start + XDP_PACKET_HEADROOM;
> >       xdp->data_meta =3D xdp->data;
> >       xdp->data_end =3D xdp->data + size;
> > -     xdp->flags =3D 0;
> > +     xdp_init_buff_minimal(xdp);
>
> Why is this done in the patch prefixed with "ice:"?
>
Good catch, this should be moved to the previous patch.

thanks
Yan

> >  }
> >
> >  static inline dma_addr_t xsk_buff_raw_get_dma(struct xsk_buff_pool *po=
ol,
>
> Thanks,
> Olek

