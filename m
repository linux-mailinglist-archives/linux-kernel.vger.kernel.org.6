Return-Path: <linux-kernel+bounces-188765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D1D78CE69F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 16:04:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FE611C20CCC
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 14:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA63712C485;
	Fri, 24 May 2024 14:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="Zcm30jR3"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB3E12C466
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 14:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716559477; cv=none; b=juqlbbr1Y/sN9XGlvhZ6nm9oVKvzZbfwrdaGqDOhsDqz0/UzmlgOfNHfwWD421As2BkjVMiMs4K8bN7qX/XHbiqdoGDJ4MaRNgrgOhE7xDwIo6Z94biMwNdbfsJ31fhxrvRetZgUr1FlrVhEf4CtnbE40JADjS0Q+Xk0cEU4YNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716559477; c=relaxed/simple;
	bh=OQRUGmqH7p8q0TZ8UDyzXz9YCJ1OKHSOJS5ShBfUsiY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rGIhQskaEnh+yxaPPXPxYGu1N66x9929U4keu9efsRU+p51xyqki0RF7F3KlDCTXEEmF9eCx8nwOXiETSEbvYDHTxit4tHT1/Q3/HeEcEML6vYOA2sz5euAaqNj7bdIpwV0laQl9xxwRl2rqU2EOttlRnofR+91BH2oejBkIK0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=Zcm30jR3; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com [209.85.218.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id A74A63F847
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 14:04:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1716559470;
	bh=E/RPD6hDIUky/ZMLcvb6p1QR9dziudjaKxoHx5ZJMx4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=Zcm30jR3+I2B37W7jlmsXTS3fMVr1SHDTIGAGsqAA7rSrjQawuT2ZZOblDataMZJz
	 U7GjS84VBU+sE9wv1RLkMf3MRQb8vtLC0apM+LqBkuZ8mfP0AJQfjdMVF3g017qFjj
	 sBnI4hP82C1BWehVn5sd3C463O15q2UQwx+2/TAf+a3iOUrfC7j6hBXbnsIIhrYPTy
	 3cGFtZgmlgo1CJ+2PwWYHhDpJgr5hEhRISYJSbEA/b43sb9zKXciog4ZYT7YkT59U+
	 ppZyHLv18Gj48AbY7PXRjZaOSRGm/9EhB8xCUrUDp8O7/mjvWpb6uz5M56Gii/tVYP
	 DN26UJu18vekg==
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a6269738909so81107966b.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 07:04:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716559470; x=1717164270;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E/RPD6hDIUky/ZMLcvb6p1QR9dziudjaKxoHx5ZJMx4=;
        b=vbm8dhXE8ft49EnxH9T8s19DHswoM7rZAkSmM+BcOXnZctWfEFCZi7SJ/vQjm4WutR
         vaI61+Imp4Wx5rhCUoPDpAqe678hXy8OH2VkG7s7/glViPm8hOwFOMtTTgcvgWLM09Au
         L5/tlD3wTmhKGGas0PiCncH1K8VHpOpNBI29H5ubN/JavK26pT0Tt5Wl61lDcX0iV2Hi
         /E8Kke9L2hBUyizo2fmIeOdD+Fd0/4kPzfeVUJIOHb7wXTUVB0do99/4OKEqllJ619Um
         SyHOwL2ibMsNMZBtjzRODRqogfKUeL2sviQURcrTvEZbQ4jS/0o+qe+B2CYs5Z2RJtIZ
         3C4Q==
X-Forwarded-Encrypted: i=1; AJvYcCX8g+WlqvC2/FwbUb1Jl5IJX6lnJER8+9lAM7oCrovqQNirVnZePTaee5Dmu4hVjQ8Yfib0HVmcJxyX4GjYf0NbGa94mrf5cC5IniXV
X-Gm-Message-State: AOJu0YxLZMiGPNr0SiEIR7YMgy3KEsq3Z57mBWURPduIvueBDn80uZgS
	iTqWFxbfkCbIAuyaucJMjTINtMhdtZecceijdtyCbuCKh+rFgrXOZRyb4TuQjmwDwzAZ25lHORI
	X+CPpkIM64hX8u4nxeJjYX+1F+fe2nyZ+Cmtref1Gl5mMe2cIOO5zrbN3Zbl1VXSTQSlJLr6QXg
	bnwcsVQ5xF+UcDJSZunzKbSjjPOzoKS3rZ9C7dGpCVHhT8AbH5CeMg
X-Received: by 2002:a17:907:764c:b0:a59:bbea:14e8 with SMTP id a640c23a62f3a-a623e8f6f41mr432494666b.17.1716559470324;
        Fri, 24 May 2024 07:04:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEql+GAkjUup3w0xI5yrgomfUNWLGb5V5DxEcnO2p9Dl7TWFLzTL/sXrafxV4fOQVrDWDhJg/PcRsDvbxVe2i4=
X-Received: by 2002:a17:907:764c:b0:a59:bbea:14e8 with SMTP id
 a640c23a62f3a-a623e8f6f41mr432492866b.17.1716559469945; Fri, 24 May 2024
 07:04:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240520070348.26725-1-chengen.du@canonical.com> <664f5938d2bef_1b5d2429467@willemb.c.googlers.com.notmuch>
In-Reply-To: <664f5938d2bef_1b5d2429467@willemb.c.googlers.com.notmuch>
From: Chengen Du <chengen.du@canonical.com>
Date: Fri, 24 May 2024 22:04:18 +0800
Message-ID: <CAPza5qc+m6aK0hOn8m1OxnmNVibJQn-VFXBAnjrca+UrcmEW4g@mail.gmail.com>
Subject: Re: [PATCH] af_packet: Handle outgoing VLAN packets without hardware offloading
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Willem,

Thank you for your reply.

Please allow me to briefly summarize to ensure we are in agreement on
the solution.

Firstly, I will submit a patch to add a new bit in the status to
indicate the presence of VLAN information in the payload and modify
the header's entry accordingly.
A new member will be added to the sockaddr_ll struct to represent the
VLAN-encapsulated protocol, thus avoiding direct modification of the
sll_protocol.

Following this patch, I will work on enabling the link layer header
via a socket option.

If there are no ambiguities, I will submit the patch next week.
Your assistance and suggestions are highly appreciated.

Best regards,
Chengen Du

On Thu, May 23, 2024 at 10:57=E2=80=AFPM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Chengen Du wrote:
> > In the outbound packet path, if hardware VLAN offloading is unavailable=
,
> > the VLAN tag is inserted into the payload but then cleared from the
> > metadata. Consequently, this could lead to a false negative result when
> > checking for the presence of a VLAN tag using skb_vlan_tag_present(),
> > causing the packet sniffing outcome to lack VLAN tag information. As a
> > result, the packet capturing tool may be unable to parse packets as
> > expected.
> >
> > Signed-off-by: Chengen Du <chengen.du@canonical.com>
>
> Fixes tag and Cc: stable.
>
> As discussed please add more detail to the commit message that
> explains the bug. And/or add a Link: for instance to the github
> issue.
>
> > ---
> >  net/packet/af_packet.c | 25 +++++++++++++++++++------
> >  1 file changed, 19 insertions(+), 6 deletions(-)
> >
> > diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
> > index ea3ebc160e25..73e9acb1875b 100644
> > --- a/net/packet/af_packet.c
> > +++ b/net/packet/af_packet.c
> > @@ -1010,12 +1010,15 @@ static void prb_fill_vlan_info(struct tpacket_k=
bdq_core *pkc,
> >       if (skb_vlan_tag_present(pkc->skb)) {
> >               ppd->hv1.tp_vlan_tci =3D skb_vlan_tag_get(pkc->skb);
> >               ppd->hv1.tp_vlan_tpid =3D ntohs(pkc->skb->vlan_proto);
> > -             ppd->tp_status =3D TP_STATUS_VLAN_VALID | TP_STATUS_VLAN_=
TPID_VALID;
> > +     } else if (eth_type_vlan(pkc->skb->protocol)) {
> > +             ppd->hv1.tp_vlan_tci =3D ntohs(vlan_eth_hdr(pkc->skb)->h_=
vlan_TCI);
> > +             ppd->hv1.tp_vlan_tpid =3D ntohs(pkc->skb->protocol);
> >       } else {
> >               ppd->hv1.tp_vlan_tci =3D 0;
> >               ppd->hv1.tp_vlan_tpid =3D 0;
> > -             ppd->tp_status =3D TP_STATUS_AVAILABLE;
> >       }
> > +     ppd->tp_status =3D (ppd->hv1.tp_vlan_tci || ppd->hv1.tp_vlan_tpid=
) ?
> > +             TP_STATUS_VLAN_VALID | TP_STATUS_VLAN_TPID_VALID : TP_STA=
TUS_AVAILABLE;
>
> Don't move this out of the original branch and don't make the valid
> conditional on the value of tp_vlan_tci. Just duplicating the line
> to both branches is fine. Here and below.
>
> >  }
> >
> >  static void prb_run_all_ft_ops(struct tpacket_kbdq_core *pkc,
> > @@ -2427,11 +2430,15 @@ static int tpacket_rcv(struct sk_buff *skb, str=
uct net_device *dev,
> >               if (skb_vlan_tag_present(skb)) {
> >                       h.h2->tp_vlan_tci =3D skb_vlan_tag_get(skb);
> >                       h.h2->tp_vlan_tpid =3D ntohs(skb->vlan_proto);
> > -                     status |=3D TP_STATUS_VLAN_VALID | TP_STATUS_VLAN=
_TPID_VALID;
> > +             } else if (eth_type_vlan(skb->protocol)) {
> > +                     h.h2->tp_vlan_tci =3D ntohs(vlan_eth_hdr(skb)->h_=
vlan_TCI);
> > +                     h.h2->tp_vlan_tpid =3D ntohs(skb->protocol);
> >               } else {
> >                       h.h2->tp_vlan_tci =3D 0;
> >                       h.h2->tp_vlan_tpid =3D 0;
> >               }
> > +             if (h.h2->tp_vlan_tci || h.h2->tp_vlan_tpid)
> > +                     status |=3D TP_STATUS_VLAN_VALID | TP_STATUS_VLAN=
_TPID_VALID;
> >               memset(h.h2->tp_padding, 0, sizeof(h.h2->tp_padding));
> >               hdrlen =3D sizeof(*h.h2);
> >               break;
> > @@ -2457,7 +2464,8 @@ static int tpacket_rcv(struct sk_buff *skb, struc=
t net_device *dev,
> >       sll->sll_halen =3D dev_parse_header(skb, sll->sll_addr);
> >       sll->sll_family =3D AF_PACKET;
> >       sll->sll_hatype =3D dev->type;
> > -     sll->sll_protocol =3D skb->protocol;
> > +     sll->sll_protocol =3D eth_type_vlan(skb->protocol) ?
> > +             vlan_eth_hdr(skb)->h_vlan_encapsulated_proto : skb->proto=
col;
>
> For QinQ you probably want the true network protocol, not the inner
> VLAN tag.
> >       sll->sll_pkttype =3D skb->pkt_type;
> >       if (unlikely(packet_sock_flag(po, PACKET_SOCK_ORIGDEV)))
> >               sll->sll_ifindex =3D orig_dev->ifindex;
> > @@ -3482,7 +3490,8 @@ static int packet_recvmsg(struct socket *sock, st=
ruct msghdr *msg, size_t len,
> >               /* Original length was stored in sockaddr_ll fields */
> >               origlen =3D PACKET_SKB_CB(skb)->sa.origlen;
> >               sll->sll_family =3D AF_PACKET;
> > -             sll->sll_protocol =3D skb->protocol;
> > +             sll->sll_protocol =3D eth_type_vlan(skb->protocol) ?
> > +                     vlan_eth_hdr(skb)->h_vlan_encapsulated_proto : sk=
b->protocol;
> >       }
> >
> >       sock_recv_cmsgs(msg, sk, skb);
> > @@ -3538,11 +3547,15 @@ static int packet_recvmsg(struct socket *sock, =
struct msghdr *msg, size_t len,
> >               if (skb_vlan_tag_present(skb)) {
> >                       aux.tp_vlan_tci =3D skb_vlan_tag_get(skb);
> >                       aux.tp_vlan_tpid =3D ntohs(skb->vlan_proto);
> > -                     aux.tp_status |=3D TP_STATUS_VLAN_VALID | TP_STAT=
US_VLAN_TPID_VALID;
> > +             } else if (eth_type_vlan(skb->protocol)) {
> > +                     aux.tp_vlan_tci =3D ntohs(vlan_eth_hdr(skb)->h_vl=
an_TCI);
> > +                     aux.tp_vlan_tpid =3D ntohs(skb->protocol);
> >               } else {
> >                       aux.tp_vlan_tci =3D 0;
> >                       aux.tp_vlan_tpid =3D 0;
> >               }
> > +             if (aux.tp_vlan_tci || aux.tp_vlan_tpid)
> > +                     aux.tp_status |=3D TP_STATUS_VLAN_VALID | TP_STAT=
US_VLAN_TPID_VALID;
> >               put_cmsg(msg, SOL_PACKET, PACKET_AUXDATA, sizeof(aux), &a=
ux);
> >       }
> >
> > --
> > 2.40.1
> >
>
>

