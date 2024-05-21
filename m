Return-Path: <linux-kernel+bounces-184464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90CED8CA711
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 05:32:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5075D28252E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 03:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E01D182DB;
	Tue, 21 May 2024 03:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="dVZY/b1w"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA297210FB
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 03:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716262318; cv=none; b=SvxL4qYpFoxo2wEfrqTkIsJAaFIOldhluSw/a1pqxRuQAfo5EBHSdArf8e3doNef98EjdGAa56hzIR51WWB9i8jTyDRZ/oCB0m5LEtjXuFGj8vffSd0mg0r7vbfmj9u/dCLrKhBYyYS/DQOOWTrBRgLCL8UbgpzuNTIE+uyFVi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716262318; c=relaxed/simple;
	bh=MFCU+pjB3KCKhjmKoPu7wpzHpc58NnIFXFSypYZ2ds4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nFiKkwRDarmAPxCxPCY8g1f9e655IqKI4xS0fFslsPLoTXoNg4r/IhkUYLVtF9eYCuDqp8+10UXrE8OktGLPhSKyi/t/6Iz/bCKJOwBscx26IafLpC6BMQY476jv8QrhrjJ0ah3svmkJDLkVc/FFUQTVF1ytzeI60DaQlm7qGK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=dVZY/b1w; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com [209.85.218.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id A20763F331
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 03:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1716262313;
	bh=oRT4EC1vFVwwe/RwAMWjDpt+UAEk61rLUizH+FeKckE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=dVZY/b1wgbSp1oD1d6pAxFCX6N/oFTO9SFqa74hRmKu0YIaPS/0DgHKQ83RDXpCnn
	 LxlmB00qb7Qzmr1nvPoaMCgKUPNLHP9zYV8dhWHgTISsH2bXkWJmlP2jryKldkJF+k
	 Wppy1wf2c4TpUBpCi3tlwftGzosyplpaJTGMHCbxoRpKVAo6h/+Hv0t63/F0Y+JsT6
	 G9XnhFMc5xU+Rve7C525juoO56tDZ95TvgUk6Fjlz0lvpPyKgpfb/nAZo0pdcurEWX
	 cmwcK9UKcfUPpdjrNyecsWZr/IRd3222VtesOVtfPWsGx3PTsyQVkyQ5glvqJCXVEE
	 PFHo8l0ExVAAQ==
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a59a63a1f78so707596766b.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 20:31:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716262313; x=1716867113;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oRT4EC1vFVwwe/RwAMWjDpt+UAEk61rLUizH+FeKckE=;
        b=a3LnLFd2pUtlkSpv1jWTxzgymn1X/BIO0smsQiwfo8FZHBgRgb4cydzWxREu50/t3x
         dGN/yDjjJDiCZ0Ex2ZiEFiy1v7C1TQLX+YKqL/rMn+go3Lw1pi4Sb9WHjaCYOfAD8ivb
         LkKUPAFZO49iTiBUiLNOaykJP+3A7OmOME+TWfWAy1tY7nU22jtD2uIthSV4QKda+kA0
         WE0hcKs/+HhI+RtzXOck0RKJK4z1rzBI4EKTo8qmogrwIXi8zBrAM2JYy7gX2HFks2Mw
         Gidw7hWb5ylG9JitGab7cxkbmxqijGQoQvjBjqypmmftFblxmYNjdr2DkAiwGf9ioDrM
         q3NA==
X-Forwarded-Encrypted: i=1; AJvYcCUv/4HMrf939qsopeEC74kbMPO8BKIu0hzLrewMnKhKPKvrS83tnzMhHDy8obH29QHUakzm/KqcylirqPcT2e5xZkFpmVkxR4Dx8e5y
X-Gm-Message-State: AOJu0YyfXjCt6tUsQHg87tqpj2hltRKRlUsOkxOJbz8L5ERiqDUS0GGH
	hNs1gtsw/SUPc1OQTrtk1BVCszH+hwx/MCgD4AQzG+3ERHFz2buIcha42bTASyFt3P7jzwYAavM
	WhKYSoBogd2iHQbWzpSKDYudcMpJvGQc1+lorurVuYDMxF1SuDkvOC85IOIYZNcej4PiPrEPGFv
	mvfB+cxjp3oitwFV9kDwMzcm+3ycyDyCGQvW97iXhoO0dYWlIQ/BVL
X-Received: by 2002:a17:906:c452:b0:a59:ee81:fd68 with SMTP id a640c23a62f3a-a5a2d68089bmr1950750366b.71.1716262313284;
        Mon, 20 May 2024 20:31:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGOJPK5+qn5c923mZ3slXAnGra7/NlJptA4G/g7FgwPIMj5jx6DIRqcDO0o17J+ODRWW86LPcncRhI9GyxkwF0=
X-Received: by 2002:a17:906:c452:b0:a59:ee81:fd68 with SMTP id
 a640c23a62f3a-a5a2d68089bmr1950749466b.71.1716262312944; Mon, 20 May 2024
 20:31:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240520070348.26725-1-chengen.du@canonical.com> <664b97e8abe7a_12b4762946f@willemb.c.googlers.com.notmuch>
In-Reply-To: <664b97e8abe7a_12b4762946f@willemb.c.googlers.com.notmuch>
From: Chengen Du <chengen.du@canonical.com>
Date: Tue, 21 May 2024 11:31:42 +0800
Message-ID: <CAPza5qcGyfcUYOoznci4e=1eaScVTgkzAhXfKSG3bTzC=aOwew@mail.gmail.com>
Subject: Re: [PATCH] af_packet: Handle outgoing VLAN packets without hardware offloading
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Willem,

Thank you for your response.

I would appreciate any suggestions you could offer, as I am not as
familiar with this area as you are.

I encountered an issue while capturing packets using tcpdump, which
leverages the libpcap library for sniffing functionalities.
Specifically, when I use "tcpdump -i any" to capture packets and
hardware VLAN offloading is unavailable, some bogus packets appear.
In this scenario, Linux uses cooked-mode capture (SLL) for the "any"
device, reading from a PF_PACKET/SOCK_DGRAM socket instead of the
usual PF_PACKET/SOCK_RAW socket.

Using SOCK_DGRAM instead of SOCK_RAW means that the Linux socket code
does not supply the packet's link-layer header.
Based on the code in af_packet.c, SOCK_DGRAM strips L2 headers from
the original packets and provides SLL for some L2 information.
From the receiver's perspective, the VLAN information can only be
parsed from SLL, which causes issues if the kernel stores VLAN
information in the payload.

As you mentioned, this modification affects existing PF_PACKET receivers.
For example, libpcap needs to change how it parses VLAN packets with
the PF_PACKET/SOCK_RAW socket.
The lack of VLAN information in SLL may prevent the receiver from
properly decoding the L3 frame in cooked mode.

I am new to this area and would appreciate it if you could kindly
correct any misunderstandings I might have about the mechanism.
I would also be grateful for any insights you could share on this issue.
Additionally, I am passionate about contributing to resolving this
issue and am willing to work on patches based on your suggestions.

Thank you for your time and assistance.

Best regards,
Chengen Du

On Tue, May 21, 2024 at 2:35=E2=80=AFAM Willem de Bruijn
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
> This is changing established behavior, which itself may confuse
> existing PF_PACKET receivers.
>
> The contract is that the VLAN tag can be observed in the payload or
> as tp_vlan_* fields if it is offloaded.
>
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
> This is a particularly subtle change of behavior.
>
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
>
> vlan_tci 0 is valid identifier. That's the reason explicit field
> TP_STATUS_VLAN_VALID was added.
>

