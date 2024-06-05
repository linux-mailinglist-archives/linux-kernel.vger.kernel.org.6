Return-Path: <linux-kernel+bounces-201795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 231D88FC348
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 08:03:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF616287223
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 06:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F2EE21C18A;
	Wed,  5 Jun 2024 06:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="dfaBCAmI"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4226121C164
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 06:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717567425; cv=none; b=lRbfEcqudCQ+S04y28VYFlvJc597EqSLmwzXiipVnqocaK+WL/ypr+C1zNaMDYrrfgGIv6wdwLnLMSR74SianV65GG3Fe55cvluCo6YhYse6QkC3lwmpDVEe6QzWNGV4E2dsyWxscH8jTzATI2uKoiUWUh3efEJxH4AE14LmGDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717567425; c=relaxed/simple;
	bh=iE1Z1/0JW0Gu8FK3x9LUv4036koVlDvgmK2d7y8u49g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DPGX2IIsqdNp2oH2TLjt6dYoUT+PUpjmmOX5+82fLtcqnixDbWjqbYNK/YTzDDLDopiscmjWaaMZTzrSXKqrPghGBygNqAnBffpj60fQAvL62pk+lLCVV2d0jH0+/TfVOBPpuO8VMSvliH04BeySJ3m6voVMMKQq2ssWw7QJyNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=dfaBCAmI; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id A9AE13F2A5
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 06:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1717567413;
	bh=AUBsaZ898jwR2zSzlpj/dNHKgBz8g8tA1Eq6ni8r8nI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=dfaBCAmIFt2nb3rxgXvNMOU88tyouCUJkgvuK9FMa8q0gAXXqwrHVPPN7AvJiXBfL
	 augDsWp+8sG520Q3AMSctEUg5UEx05ufiCDei9QkXD3W0bxb9+PBXEZo8tH5YftvMS
	 foJIAx7XOCpVxgK8PlQ9rKlpJIkfH2lLv1t5hPYnYDwwz5q/XRW6pnXkOyshJYuPlq
	 YdPguHDBowVTyb+PxIYia4JpP6xIDEB55fwk7teSwhYpzIbCSk2QxvfUWHh6CxLLC5
	 XAC3APp6aVz8AsflpOlu1DB/3XSX+eUTZOaZ8wBAJoGCjy2dMG+9ABnWanZOG2/UG8
	 wZCvB1sU95XKA==
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a6912c4ddb1so60244366b.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 23:03:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717567410; x=1718172210;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AUBsaZ898jwR2zSzlpj/dNHKgBz8g8tA1Eq6ni8r8nI=;
        b=qXGM7pI4pYicwrheXqFbjC1JJ6A0RyvqnXuR+SZ8Te+TX49J2YeQ6rMRuCFzL1qUX8
         HsLAquqH4ikxrfqijFPAkuY0RGNj6O1sTIy63O0p0zecDuQ5oCunUzRDb23EpJVD9Sh/
         RDf2C9MZH6aC/l4gFEzE67LCfbkyVnghibhNnXxOnNLDVPVrThB+HjQ21UpS144Q7MgM
         wHsuhex1gqa+cW4xjGV9bGXQc7nbWGmU0JlrUU/uE3/NlCM7dA0zLxYnznrOW7jzb8Iu
         QLSUvaHqJcKsFsSoB5G4uosgx6ytIpM+thNcRRk0QnJby/OQCpuhkD6aeXrzKsGtsaIt
         He6Q==
X-Forwarded-Encrypted: i=1; AJvYcCV1vizygl4qOwsozWaUMTVJxACpapFx+vw390RBEbmUm+CHtL++o5OoGGO/vsyoIic8kdz1Z2sJIQVAoqqMKC52R1LxZRVtsPE8+Pq9
X-Gm-Message-State: AOJu0YzxgO1L0aErBJCqxFN0utdulTQshpx39qPL6Cs27xX1Lt84t3+a
	jea0DttkqIs/DViVZHJOeDjEEF/9/G6WK+KYEVVmLOiP6YKMDadPf6N1uGrjUqi5GFwM8zQfFqu
	2mDy4FBEXR+wIxUAcJ6f5VeX9YD4FYOxXGvy1/MoUSi7GvuqdhUM+SmhrxaD47GuiTQuKFZ3ba5
	ipRlD5Rg/q8q4xJNzDkpSODVf4N5/cgw4I+fZvmN4cJFm6o0abQthF
X-Received: by 2002:a17:906:2491:b0:a5a:8bc4:f503 with SMTP id a640c23a62f3a-a699f663fe6mr89695766b.25.1717567407813;
        Tue, 04 Jun 2024 23:03:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHKl+dVABeKJdYmOGVe5AfX2ECKEeWnXGlkeg4QLHovKCLrexrQILpM2noR3Z4xJDJmNyfOAxIIqElFgcoehY4=
X-Received: by 2002:a17:906:2491:b0:a5a:8bc4:f503 with SMTP id
 a640c23a62f3a-a699f663fe6mr89691566b.25.1717567406645; Tue, 04 Jun 2024
 23:03:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240604054823.20649-1-chengen.du@canonical.com> <665f9bccaa91c_2bf7de294f4@willemb.c.googlers.com.notmuch>
In-Reply-To: <665f9bccaa91c_2bf7de294f4@willemb.c.googlers.com.notmuch>
From: Chengen Du <chengen.du@canonical.com>
Date: Wed, 5 Jun 2024 14:03:15 +0800
Message-ID: <CAPza5qctPn_yrFQrO_2NHXpz-kf1qTwxk_APn2t5VU30sY=-MQ@mail.gmail.com>
Subject: Re: [PATCH v5] af_packet: Handle outgoing VLAN packets without
 hardware offloading
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, kaber@trash.net, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Willem,

My apologies, but I still have some questions I would like to discuss with =
you.

On Wed, Jun 5, 2024 at 6:57=E2=80=AFAM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Chengen Du wrote:
> > The issue initially stems from libpcap. The ethertype will be overwritt=
en
> > as the VLAN TPID if the network interface lacks hardware VLAN offloadin=
g.
> > In the outbound packet path, if hardware VLAN offloading is unavailable=
,
> > the VLAN tag is inserted into the payload but then cleared from the sk_=
buff
> > struct. Consequently, this can lead to a false negative when checking f=
or
> > the presence of a VLAN tag, causing the packet sniffing outcome to lack
> > VLAN tag information (i.e., TCI-TPID). As a result, the packet capturin=
g
> > tool may be unable to parse packets as expected.
> >
> > The TCI-TPID is missing because the prb_fill_vlan_info() function does =
not
> > modify the tp_vlan_tci/tp_vlan_tpid values, as the information is in th=
e
> > payload and not in the sk_buff struct. The skb_vlan_tag_present() funct=
ion
> > only checks vlan_all in the sk_buff struct. In cooked mode, the L2 head=
er
> > is stripped, preventing the packet capturing tool from determining the
> > correct TCI-TPID value. Additionally, the protocol in SLL is incorrect,
> > which means the packet capturing tool cannot parse the L3 header correc=
tly.
> >
> > Link: https://github.com/the-tcpdump-group/libpcap/issues/1105
> > Link: https://lore.kernel.org/netdev/20240520070348.26725-1-chengen.du@=
canonical.com/T/#u
> > Fixes: 393e52e33c6c ("packet: deliver VLAN TCI to userspace")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Chengen Du <chengen.du@canonical.com>
> > ---
> >  net/packet/af_packet.c | 64 ++++++++++++++++++++++++++++++++++++++++--
> >  1 file changed, 62 insertions(+), 2 deletions(-)
> >
> > diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
> > index ea3ebc160e25..53d51ac87ac6 100644
> > --- a/net/packet/af_packet.c
> > +++ b/net/packet/af_packet.c
> > @@ -538,6 +538,52 @@ static void *packet_current_frame(struct packet_so=
ck *po,
> >       return packet_lookup_frame(po, rb, rb->head, status);
> >  }
> >
> > +static u16 vlan_get_tci(struct sk_buff *skb)
> > +{
> > +     unsigned int vlan_depth =3D skb->mac_len;
> > +     struct vlan_hdr vhdr, *vh;
> > +     u8 *skb_head =3D skb->data;
> > +     int skb_len =3D skb->len;
> > +
> > +     if (vlan_depth) {
> > +             if (WARN_ON(vlan_depth < VLAN_HLEN))
> > +                     return 0;
> > +             vlan_depth -=3D VLAN_HLEN;
> > +     } else {
> > +             vlan_depth =3D ETH_HLEN;
> > +     }
> > +
> > +     skb_push(skb, skb->data - skb_mac_header(skb));
> > +     vh =3D skb_header_pointer(skb, vlan_depth, sizeof(vhdr), &vhdr);
> > +     if (skb_head !=3D skb->data) {
> > +             skb->data =3D skb_head;
> > +             skb->len =3D skb_len;
> > +     }
> > +     if (unlikely(!vh))
> > +             return 0;
> > +
> > +     return ntohs(vh->h_vlan_TCI);
>
> As stated in the conversation: no need for the vlan_depth code.
>
> skb->data is either at the link layer header or immediately beyond it
> (i.e., at the outer vlan tag).

I'm confused about this part and feel there may be some
misunderstanding on my end. From what I understand, skb->data will be
at different positions depending on the scenario. For example, in
tpacket_rcv(), in SOCK_RAW, it will be at the link layer header, but
for SOCK_DGRAM with PACKET_OUTGOING, it will be at the network layer
header.

Given this situation, it seems necessary to adjust skb->data to point
to the link layer header and then seek the VLAN tag based on the MAC
length, rather than parsing directly from the skb->data head. Could
you please clarify this in more detail?

I apologize for any confusion and appreciate your guidance on this
matter, as I may not be as familiar with this area as you are.

>
> > +}
> > +
> > +static __be16 vlan_get_protocol_dgram(struct sk_buff *skb)
> > +{
> > +     __be16 proto =3D skb->protocol;
> > +
> > +     if (unlikely(eth_type_vlan(proto))) {
> > +             u8 *skb_head =3D skb->data;
>
> Since skb->head is a different thing from skb->data, please call this
> orig_data or so.
> > +             int skb_len =3D skb->len;
> > +
> > +             skb_push(skb, skb->data - skb_mac_header(skb));
> > +             proto =3D __vlan_get_protocol(skb, proto, NULL);
> > +             if (skb_head !=3D skb->data) {
> > +                     skb->data =3D skb_head;
> > +                     skb->len =3D skb_len;
> > +             }
> > +     }
>
> I don't see a way around this temporary skb->data mangling, so +1
> unless someone else suggests a cleaner way.
>
> On second thought, one option:
>
> This adds some parsing overhead in the datapath. SOCK_RAW does not
> need it, as it can see the whole VLAN tag. Perhaps limit the new
> branches to SOCK_DGRAM cases? Then the above can also be simplified.

I considered this approach before, but it would result in different
metadata for SOCK_DGRAM and SOCK_RAW scenarios. This difference makes
me hesitate because it might be better to provide consistent metadata
to describe the same packet, regardless of the receiver's approach.
These are just my thoughts and I'm open to further discussion.

>
> > +
> > +     return proto;
> > +}
> > +
> >  static void prb_del_retire_blk_timer(struct tpacket_kbdq_core *pkc)
> >  {
> >       del_timer_sync(&pkc->retire_blk_timer);
> > @@ -1011,6 +1057,10 @@ static void prb_fill_vlan_info(struct tpacket_kb=
dq_core *pkc,
> >               ppd->hv1.tp_vlan_tci =3D skb_vlan_tag_get(pkc->skb);
> >               ppd->hv1.tp_vlan_tpid =3D ntohs(pkc->skb->vlan_proto);
> >               ppd->tp_status =3D TP_STATUS_VLAN_VALID | TP_STATUS_VLAN_=
TPID_VALID;
> > +     } else if (unlikely(eth_type_vlan(pkc->skb->protocol))) {
> > +             ppd->hv1.tp_vlan_tci =3D vlan_get_tci(pkc->skb);
> > +             ppd->hv1.tp_vlan_tpid =3D ntohs(pkc->skb->protocol);
> > +             ppd->tp_status =3D TP_STATUS_VLAN_VALID | TP_STATUS_VLAN_=
TPID_VALID;
> >       } else {
> >               ppd->hv1.tp_vlan_tci =3D 0;
> >               ppd->hv1.tp_vlan_tpid =3D 0;
> > @@ -2428,6 +2478,10 @@ static int tpacket_rcv(struct sk_buff *skb, stru=
ct net_device *dev,
> >                       h.h2->tp_vlan_tci =3D skb_vlan_tag_get(skb);
> >                       h.h2->tp_vlan_tpid =3D ntohs(skb->vlan_proto);
> >                       status |=3D TP_STATUS_VLAN_VALID | TP_STATUS_VLAN=
_TPID_VALID;
> > +             } else if (unlikely(eth_type_vlan(skb->protocol))) {
> > +                     h.h2->tp_vlan_tci =3D vlan_get_tci(skb);
> > +                     h.h2->tp_vlan_tpid =3D ntohs(skb->protocol);
> > +                     status |=3D TP_STATUS_VLAN_VALID | TP_STATUS_VLAN=
_TPID_VALID;
> >               } else {
> >                       h.h2->tp_vlan_tci =3D 0;
> >                       h.h2->tp_vlan_tpid =3D 0;
> > @@ -2457,7 +2511,8 @@ static int tpacket_rcv(struct sk_buff *skb, struc=
t net_device *dev,
> >       sll->sll_halen =3D dev_parse_header(skb, sll->sll_addr);
> >       sll->sll_family =3D AF_PACKET;
> >       sll->sll_hatype =3D dev->type;
> > -     sll->sll_protocol =3D skb->protocol;
> > +     sll->sll_protocol =3D (sk->sk_type =3D=3D SOCK_DGRAM) ?
> > +             vlan_get_protocol_dgram(skb) : skb->protocol;
> >       sll->sll_pkttype =3D skb->pkt_type;
> >       if (unlikely(packet_sock_flag(po, PACKET_SOCK_ORIGDEV)))
> >               sll->sll_ifindex =3D orig_dev->ifindex;
> > @@ -3482,7 +3537,8 @@ static int packet_recvmsg(struct socket *sock, st=
ruct msghdr *msg, size_t len,
> >               /* Original length was stored in sockaddr_ll fields */
> >               origlen =3D PACKET_SKB_CB(skb)->sa.origlen;
> >               sll->sll_family =3D AF_PACKET;
> > -             sll->sll_protocol =3D skb->protocol;
> > +             sll->sll_protocol =3D (sock->type =3D=3D SOCK_DGRAM) ?
> > +                     vlan_get_protocol_dgram(skb) : skb->protocol;
> >       }
> >
> >       sock_recv_cmsgs(msg, sk, skb);
> > @@ -3539,6 +3595,10 @@ static int packet_recvmsg(struct socket *sock, s=
truct msghdr *msg, size_t len,
> >                       aux.tp_vlan_tci =3D skb_vlan_tag_get(skb);
> >                       aux.tp_vlan_tpid =3D ntohs(skb->vlan_proto);
> >                       aux.tp_status |=3D TP_STATUS_VLAN_VALID | TP_STAT=
US_VLAN_TPID_VALID;
> > +             } else if (unlikely(eth_type_vlan(skb->protocol))) {
> > +                     aux.tp_vlan_tci =3D vlan_get_tci(skb);
> > +                     aux.tp_vlan_tpid =3D ntohs(skb->protocol);
> > +                     aux.tp_status |=3D TP_STATUS_VLAN_VALID | TP_STAT=
US_VLAN_TPID_VALID;
> >               } else {
> >                       aux.tp_vlan_tci =3D 0;
> >                       aux.tp_vlan_tpid =3D 0;
> > --
> > 2.43.0
> >
>
>

