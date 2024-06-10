Return-Path: <linux-kernel+bounces-208492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B39CB9025BA
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 17:33:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34AED1F27442
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 15:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 848B713D8A7;
	Mon, 10 Jun 2024 15:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="vL/vk1lv"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D56A953
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 15:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718033619; cv=none; b=DxvxV3pwhPhD3imat4XI6eQgBJ/8hdDav48ZuiXgY8r+7nSFtEurgdniyBZYIA3aqme+wXn6OOepPkRelPzz0Hbt7Mu2WvvMbAFjJTcL/N4BlldchQgeFUnDjVP5cT3xTH9QLr2jjAQib0M4io6i+J+Kk/fZLZewuNJlMDdd+Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718033619; c=relaxed/simple;
	bh=+d4qcBQ5TqLmgZeUZlWX/ETnIPEWZGFBORlIObrELcg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Oy4KYt6OU1qTYQrsLoJ3+mR+JgD0A+hCR34a0++O9mzxJ7ER0BqnK4GfhyI+F427GMAVbjmniSo9IU+7GVXtX7V616ViOxbSgTWLKPYXGBDdmE0yVqTZDRlfrVlqDZvF0T3y3U21UqUXmOloW68ens9DX5GpaHIi6gFNI7JMtJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=vL/vk1lv; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 10EC93F370
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 15:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1718033615;
	bh=OLB74RFEpAPPIbjErc3qPF1SfWkaR9gNaZrKnhtRg+Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=vL/vk1lvk9SePW8ZyqRGY36LNmqtJred2O6Vf4QdJh76Ab/IH5kED5GNRDiJgrTET
	 gP5jMnJyWRG28sQQT0TMVvSgQp0aJy7O//8k1jL/xhc/2Br1GUQBexENC9OR4Gidwb
	 ATzyGm0km8fu5BORjauF30KlM1vLPA+2eJxZiC9kqQCH7sYBDkEFHxCCAIfokGBIk4
	 9JtZeC8OFy1bRogXZn8RTFZG+DFIOgMJ5IeT3Zm5rxXm6Re99PcYsSSy9CZ7l5eGNc
	 qeg06KOj53iYH1Nb6IQ/R7lBDC2ezg0JLDU8VjUjy+cl2PbACWNBTuX1yjP7kcRznW
	 is5V7fQ/HkxLQ==
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a6efe58a1aeso137715166b.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 08:33:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718033614; x=1718638414;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OLB74RFEpAPPIbjErc3qPF1SfWkaR9gNaZrKnhtRg+Q=;
        b=iqm2OW1Jza9S9su/l0IYr/Tg+ul5oa1+wFlBWY9q5zhiHCnPRsvPkmuA4D847ytgNc
         h1W2k9nKNe0JQ2+RXm+Qn9kKccAbfYhipySNPaBmpr0kYsL1KJF2hgNpDE2e3tcSrOzl
         OrA/CYmphCqtg37sq5jVNjS23Nfv9Ftwg4Wdcpk658wHB43idSHppoCmusvjg8ciNKlR
         6Hyp5sJjVXZ2P/B+/dujmhlNrMeUd2FpuqpwcKX0djYDshvqx3c2EMew5VVs4NvAVfiV
         8D/LnQ/Zqxfsj63KAG/FsKS0hcMQXkEEBBv+VG7DWBL65fhbppMCjDI1nevbr23V6JcU
         Vc7A==
X-Forwarded-Encrypted: i=1; AJvYcCWepWwkrtUULqLk1VNp4j12E1A2j0yymMAELlXNiQp1T4mqJFdDPjY8y94L/9HdB1/dXVHFrr3vl1umokxB3WcxGE51n9xSsJSR5uza
X-Gm-Message-State: AOJu0YxVZILcPFCLKGVETMzg/4LsUOpyB1uVJDMVeovunNdpSC7hqU4Q
	KhXoGcT0npHOqyEr27EcZEm0WEdMBPjrNgoMxZuReWcMvATVdFHNBI2pcv68M01FOxFg6XfhgL/
	583AWfptPCgsg/RMgMa1de5MT1rOLaW4QUGX9YbBmpbeeXUQ1Z1JeWzubrsJe/rl6Bt4Add7NYy
	IY/HJWnCcBGicBByouLheB+gBPsDN8snA9NqR812rwSGIAlmRTYwsI
X-Received: by 2002:a17:907:b9da:b0:a6f:11a4:a451 with SMTP id a640c23a62f3a-a6f11a4abd0mr287153766b.46.1718033614580;
        Mon, 10 Jun 2024 08:33:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH0KH9vPXFO8cqAQUSJqHoFXu2nuzjTT2yMRIdMJhxAJ2NY4ei/6rxqDg9O7INg3LgoA52CjHlAspUQcSvhW34=
X-Received: by 2002:a17:907:b9da:b0:a6f:11a4:a451 with SMTP id
 a640c23a62f3a-a6f11a4abd0mr287152766b.46.1718033614222; Mon, 10 Jun 2024
 08:33:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240608025347.90680-1-chengen.du@canonical.com>
 <CAPza5qfuNhDbhV9mau9RE=cNKMwGtJcx4pmjkoHNwpfysnw5yw@mail.gmail.com> <66660ec3f3e22_8dbbb294ed@willemb.c.googlers.com.notmuch>
In-Reply-To: <66660ec3f3e22_8dbbb294ed@willemb.c.googlers.com.notmuch>
From: Chengen Du <chengen.du@canonical.com>
Date: Mon, 10 Jun 2024 23:33:23 +0800
Message-ID: <CAPza5qfcXSQNxz2kNVWHqYBGgnFLDa-Ey5b9y5OenZndo2a0Og@mail.gmail.com>
Subject: Re: [PATCH v6] af_packet: Handle outgoing VLAN packets without
 hardware offloading
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, kaber@trash.net, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Willem,

On Mon, Jun 10, 2024 at 4:21=E2=80=AFAM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Chengen Du wrote:
> > Hi,
> >
> > I would like to provide some additional explanations about the patch.
> >
> >
> > On Sat, Jun 8, 2024 at 10:54=E2=80=AFAM Chengen Du <chengen.du@canonica=
l.com> wrote:
> > >
> > > The issue initially stems from libpcap. The ethertype will be overwri=
tten
> > > as the VLAN TPID if the network interface lacks hardware VLAN offload=
ing.
> > > In the outbound packet path, if hardware VLAN offloading is unavailab=
le,
> > > the VLAN tag is inserted into the payload but then cleared from the s=
k_buff
> > > struct. Consequently, this can lead to a false negative when checking=
 for
> > > the presence of a VLAN tag, causing the packet sniffing outcome to la=
ck
> > > VLAN tag information (i.e., TCI-TPID). As a result, the packet captur=
ing
> > > tool may be unable to parse packets as expected.
> > >
> > > The TCI-TPID is missing because the prb_fill_vlan_info() function doe=
s not
> > > modify the tp_vlan_tci/tp_vlan_tpid values, as the information is in =
the
> > > payload and not in the sk_buff struct. The skb_vlan_tag_present() fun=
ction
> > > only checks vlan_all in the sk_buff struct. In cooked mode, the L2 he=
ader
> > > is stripped, preventing the packet capturing tool from determining th=
e
> > > correct TCI-TPID value. Additionally, the protocol in SLL is incorrec=
t,
> > > which means the packet capturing tool cannot parse the L3 header corr=
ectly.
> > >
> > > Link: https://github.com/the-tcpdump-group/libpcap/issues/1105
> > > Link: https://lore.kernel.org/netdev/20240520070348.26725-1-chengen.d=
u@canonical.com/T/#u
> > > Fixes: 393e52e33c6c ("packet: deliver VLAN TCI to userspace")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Chengen Du <chengen.du@canonical.com>
> > > ---
> > >  net/packet/af_packet.c | 57 ++++++++++++++++++++++++++++++++++++++++=
--
> > >  1 file changed, 55 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
> > > index ea3ebc160e25..8cffbe1f912d 100644
> > > --- a/net/packet/af_packet.c
> > > +++ b/net/packet/af_packet.c
> > > @@ -538,6 +538,43 @@ static void *packet_current_frame(struct packet_=
sock *po,
> > >         return packet_lookup_frame(po, rb, rb->head, status);
> > >  }
> > >
> > > +static u16 vlan_get_tci(struct sk_buff *skb)
> > > +{
> > > +       struct vlan_hdr vhdr, *vh;
> > > +       u8 *skb_orig_data =3D skb->data;
> > > +       int skb_orig_len =3D skb->len;
> > > +
> > > +       skb_push(skb, skb->data - skb_mac_header(skb));
> > > +       vh =3D skb_header_pointer(skb, ETH_HLEN, sizeof(vhdr), &vhdr)=
;
> > > +       if (skb_orig_data !=3D skb->data) {
> > > +               skb->data =3D skb_orig_data;
> > > +               skb->len =3D skb_orig_len;
> > > +       }
> >
> >
> > The reason for not directly using skb_header_pointer(skb,
> > skb_mac_header(skb) + ETH_HLEN, ...) to get the VLAN header is due to
> > the check logic in skb_header_pointer. In the SOCK_DGRAM and
> > PACKET_OUTGOING scenarios, the offset can be a negative number, which
> > causes the check logic (i.e., likely(hlen - offset >=3D len)) in
> > __skb_header_pointer() to not work as expected.
>
> The calculation is still correct?
>
> I think that this is not the first situation where negative offsets
> can be given to skb_header_pointer.

The check will pass even if the offset is negative, but I believe this
may not be the right approach. In my humble opinion, the expected
check should be similar to the skb_push check, which ensures that
after moving forward by the offset bytes, skb->data remains larger
than or equal to skb->head to avoid accessing out-of-bound data. It
might be worth considering adding a check in __skb_header_pointer to
handle negative offsets, as this seems logical. However, this change
could impact a wider range of code. Please correct me if I am
mistaken.

>
> > While it is possible to modify __skb_header_pointer() to handle cases
> > where the offset is negative, this change could affect a wider range
> > of code.
>

