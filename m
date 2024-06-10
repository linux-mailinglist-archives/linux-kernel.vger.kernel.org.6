Return-Path: <linux-kernel+bounces-208421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24EEE9024F2
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 17:06:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9474F1F25FE6
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 15:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 181EA139D15;
	Mon, 10 Jun 2024 15:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="JP8slxNB"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814C5823DD
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 15:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718031984; cv=none; b=bL21iph6m9fQlABh7487nlO3Css351ayECVDL+ocZmUBEr/CEckcVQKcgXNp1qEmizq/Z84CxCtamnUjH3lwWNjoplZPrKZ4iSzSS0UMFLc6jxPL5NRI/Pt/LZGnuxFrKWId6wd/lMeFfuBFujsdHwnjJk3PZOwcPuc2tC6KJX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718031984; c=relaxed/simple;
	bh=aDAccP97Vrv882n4aLdL6X9An1ESDEwpDibDVG0Cpgk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l57HZniIatj7iIIavAVKJFUfUDVKbDY5bF3dRdlrlByEfAqli6ZFE7eHD7khSf5+nKHPYpeTN29DB6znq2hFip6ykB6LCaYhfIDte7TF9DQS9CWZeEHOKUZ6Jq2R7F6siv+FWd6p4+V8D0W9YOp0aQ/UfUcZyF9enl6m1FIYiWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=JP8slxNB; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com [209.85.218.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id B52AE3F371
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 15:06:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1718031973;
	bh=mMes71e0JY86wpVNx6ZKgnFS0gZH4kPa59mAztM3PFg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=JP8slxNBF6TWtuVyf7RakRFPq/e8lAo0U6IDC8u4Fg4pAod/5WZca9WTi/sLPO6bu
	 ElPMQdEImn+tK75N5Mf6TCMgA0LA42JmyDVqlfAKtTwmcrT50RThxRX7b1T2sfP9bY
	 bH4qjSRD1Na0hjM06Z/KBPFQNgJBLDv2ydqiuhdSpV7QniXLaJPjuKrF6cmnrbwb2Q
	 qo111PPPboD9+HAoW4u0Du1mGLT3Dqu+sIanUpE68eRCagZ3CEgC+eAB71Y0JLu0Op
	 S0yNsTaFD5FXLt8djbMdOR/LD/m9yI3L0C30tASipRHJ8j+FQLlcdK5MKP1XygqI4N
	 x019WMbt2ZuMA==
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a6f0f7d6eaaso192023466b.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 08:06:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718031973; x=1718636773;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mMes71e0JY86wpVNx6ZKgnFS0gZH4kPa59mAztM3PFg=;
        b=GRjDsPin1DnvHII1oN/KHJypbY5UrIWbw9zG4gRfJD4PfBJ2LDZICaubW36QGUkRQO
         L7KzOYfrOlF+l+RLahepYNNhtTNSFbz1N3fcnkC7M9t+14LepvHvLkVGDducpdukRtE7
         FbbPUFkFzwsqcqpDXKA5rnOfJBM84qOI3H7z54uFKJaRA0GIRo0oi94gB/6O10gLlAij
         LWFx2TpOLikCEFj8AW11XIAZev0Sh4PGThlMVarOiNhY3qVQmua7xBJglX8fnTqyGoSD
         f88m8i//rUuyOnaKw9Yy6nWLPfptHkvoRPXQRwTaPyFZeNhLFyjo4zCQX4CMrC1U9oQk
         3aDA==
X-Forwarded-Encrypted: i=1; AJvYcCUDDcwr0xdQOpJ1h8RAY5wSB11wMAGRXQ5PbkYSpxSdYK7Fp+G8OsVv8LTA8JN+s+DeQyi809XsAJ+BnV5m9J//uL6BFOhHZ10JbkXz
X-Gm-Message-State: AOJu0YwkqefnRg0GHD7xaUvtRpgxDgBwAiefqYTvDTfF8DiWEQ61Mqhm
	cXA9LIuc9IHK0j3pJ8CiCtLSsRSNO9H1q/hIK83hAZTvPHYj8Y1ZgOE0iYUcxAsLN0+hPyriURp
	vbbWl6TRwIrMvWCFTz0BZzGKwGdOIPBowC/71I98g8BtWXe9XJ4VATgDHcU4XaU/3yEhsHa5brG
	dIYdYvQKAkVLUrsG7VghVy1I9fQmAV4b4zVeU43/izzXPGt7BXZV51
X-Received: by 2002:a17:906:394c:b0:a6e:f53c:8da0 with SMTP id a640c23a62f3a-a6ef53c9238mr604627866b.8.1718031973182;
        Mon, 10 Jun 2024 08:06:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHrmJ35SEN1PL/TpF5aHavYb6tYg73JpLbRO8e6rXdtU1yng691KZtQfvzY9ns5aX5osUkfarAW018EnSL3A58=
X-Received: by 2002:a17:906:394c:b0:a6e:f53c:8da0 with SMTP id
 a640c23a62f3a-a6ef53c9238mr604624866b.8.1718031972662; Mon, 10 Jun 2024
 08:06:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240608025347.90680-1-chengen.du@canonical.com> <66660e3cd5636_8dbbb294c@willemb.c.googlers.com.notmuch>
In-Reply-To: <66660e3cd5636_8dbbb294c@willemb.c.googlers.com.notmuch>
From: Chengen Du <chengen.du@canonical.com>
Date: Mon, 10 Jun 2024 23:06:01 +0800
Message-ID: <CAPza5qfVzV7NFiVY1jcZR-+0ey-uKgUjV6OcjmDFvKG3T-2SXA@mail.gmail.com>
Subject: Re: [PATCH v6] af_packet: Handle outgoing VLAN packets without
 hardware offloading
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, kaber@trash.net, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Willem,

I'm sorry, but I would like to confirm the issue further.

On Mon, Jun 10, 2024 at 4:19=E2=80=AFAM Willem de Bruijn
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
>
> Overall, solid.
>
> > ---
> >  net/packet/af_packet.c | 57 ++++++++++++++++++++++++++++++++++++++++--
> >  1 file changed, 55 insertions(+), 2 deletions(-)
> >
> > diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
> > index ea3ebc160e25..8cffbe1f912d 100644
> > --- a/net/packet/af_packet.c
> > +++ b/net/packet/af_packet.c
> > @@ -538,6 +538,43 @@ static void *packet_current_frame(struct packet_so=
ck *po,
> >       return packet_lookup_frame(po, rb, rb->head, status);
> >  }
> >
> > +static u16 vlan_get_tci(struct sk_buff *skb)
> > +{
> > +     struct vlan_hdr vhdr, *vh;
> > +     u8 *skb_orig_data =3D skb->data;
> > +     int skb_orig_len =3D skb->len;
> > +
> > +     skb_push(skb, skb->data - skb_mac_header(skb));
> > +     vh =3D skb_header_pointer(skb, ETH_HLEN, sizeof(vhdr), &vhdr);
>
> Don't harcode Ethernet.
>
> According to documentation VLANs are used with other link layers.
>
> More importantly, in practice PF_PACKET allows inserting this
> skb->protocol on any device.
>
> We don't use link layer specific constants anywhere in the packet
> socket code for this reason. But instead dev->hard_header_len.
>
> One caveat there is variable length link layer headers, where
> dev->min_header_len !=3D dev->hard_header_len. Will just have to fail
> on those.

Thank you for pointing out this error. I would like to confirm if I
need to use dev->hard_header_len to get the correct header length and
return zero if dev->min_header_len !=3D dev->hard_header_len to handle
variable-length link layer headers. Is there something I
misunderstand, or are there other aspects I need to consider further?

>
> > +     if (skb_orig_data !=3D skb->data) {
> > +             skb->data =3D skb_orig_data;
> > +             skb->len =3D skb_orig_len;
> > +     }
> > +     if (unlikely(!vh))
> > +             return 0;
> > +
> > +     return ntohs(vh->h_vlan_TCI);
> > +}
> > +
>
> Only since I had to respond above: this is non-obvious enough to
> deserve a function comment. Something like the following?
>
> /* For SOCK_DGRAM, data starts at the network protocol, after any VLAN
>  * headers. sll_protocol must point to the network protocol. The
>  * (outer) VLAN TCI is still accessible as auxdata.
>  */
>
> > +static __be16 vlan_get_protocol_dgram(struct sk_buff *skb)
> > +{
> > +     __be16 proto =3D skb->protocol;
> > +
> > +     if (unlikely(eth_type_vlan(proto))) {
> > +             u8 *skb_orig_data =3D skb->data;
> > +             int skb_orig_len =3D skb->len;
> > +
> > +             skb_push(skb, skb->data - skb_mac_header(skb));
> > +             proto =3D __vlan_get_protocol(skb, proto, NULL);
> > +             if (skb_orig_data !=3D skb->data) {
> > +                     skb->data =3D skb_orig_data;
> > +                     skb->len =3D skb_orig_len;
> > +             }
> > +     }
> > +
> > +     return proto;
> > +}
> > +
> >  static void prb_del_retire_blk_timer(struct tpacket_kbdq_core *pkc)
> >  {
> >       del_timer_sync(&pkc->retire_blk_timer);
> > @@ -1007,10 +1044,16 @@ static void prb_clear_rxhash(struct tpacket_kbd=
q_core *pkc,
> >  static void prb_fill_vlan_info(struct tpacket_kbdq_core *pkc,
> >                       struct tpacket3_hdr *ppd)
> >  {
> > +     struct packet_sock *po =3D container_of(pkc, struct packet_sock, =
rx_ring.prb_bdqc);
> > +
> >       if (skb_vlan_tag_present(pkc->skb)) {
> >               ppd->hv1.tp_vlan_tci =3D skb_vlan_tag_get(pkc->skb);
> >               ppd->hv1.tp_vlan_tpid =3D ntohs(pkc->skb->vlan_proto);
> >               ppd->tp_status =3D TP_STATUS_VLAN_VALID | TP_STATUS_VLAN_=
TPID_VALID;
> > +     } else if (unlikely(po->sk.sk_type =3D=3D SOCK_DGRAM && eth_type_=
vlan(pkc->skb->protocol))) {
> > +             ppd->hv1.tp_vlan_tci =3D vlan_get_tci(pkc->skb);
> > +             ppd->hv1.tp_vlan_tpid =3D ntohs(pkc->skb->protocol);
> > +             ppd->tp_status =3D TP_STATUS_VLAN_VALID | TP_STATUS_VLAN_=
TPID_VALID;
> >       } else {
> >               ppd->hv1.tp_vlan_tci =3D 0;
> >               ppd->hv1.tp_vlan_tpid =3D 0;
> > @@ -2428,6 +2471,10 @@ static int tpacket_rcv(struct sk_buff *skb, stru=
ct net_device *dev,
> >                       h.h2->tp_vlan_tci =3D skb_vlan_tag_get(skb);
> >                       h.h2->tp_vlan_tpid =3D ntohs(skb->vlan_proto);
> >                       status |=3D TP_STATUS_VLAN_VALID | TP_STATUS_VLAN=
_TPID_VALID;
> > +             } else if (unlikely(sk->sk_type =3D=3D SOCK_DGRAM && eth_=
type_vlan(skb->protocol))) {
> > +                     h.h2->tp_vlan_tci =3D vlan_get_tci(skb);
> > +                     h.h2->tp_vlan_tpid =3D ntohs(skb->protocol);
> > +                     status |=3D TP_STATUS_VLAN_VALID | TP_STATUS_VLAN=
_TPID_VALID;
> >               } else {
> >                       h.h2->tp_vlan_tci =3D 0;
> >                       h.h2->tp_vlan_tpid =3D 0;
> > @@ -2457,7 +2504,8 @@ static int tpacket_rcv(struct sk_buff *skb, struc=
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
> > @@ -3482,7 +3530,8 @@ static int packet_recvmsg(struct socket *sock, st=
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
> > @@ -3539,6 +3588,10 @@ static int packet_recvmsg(struct socket *sock, s=
truct msghdr *msg, size_t len,
> >                       aux.tp_vlan_tci =3D skb_vlan_tag_get(skb);
> >                       aux.tp_vlan_tpid =3D ntohs(skb->vlan_proto);
> >                       aux.tp_status |=3D TP_STATUS_VLAN_VALID | TP_STAT=
US_VLAN_TPID_VALID;
> > +             } else if (unlikely(sock->type =3D=3D SOCK_DGRAM && eth_t=
ype_vlan(skb->protocol))) {
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

