Return-Path: <linux-kernel+bounces-224351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 434E391212E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 11:50:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B308DB2114D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 09:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9695516F8F3;
	Fri, 21 Jun 2024 09:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DftZbPXt"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19ED916F859
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 09:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718963375; cv=none; b=R77lPSbCe+GllMZdRmFLZPetSbmQQvVP33j0ofdY1YQmHSvxi592D8DBxZ6yVrd5U3LmBkm8bi7DRAlF+bHoLKFQwScK5d5vCG+T3l7XBr7ZSyT7TFWY/l++48xRAe1m4X3Urazdx229K9kZe9M9ND/2Kh8Ld9FVQG4NfjkWeAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718963375; c=relaxed/simple;
	bh=5XUVWX/2+5ahyhYTtBJduwq6+JE3ihhtWrDhK7/d8zA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=W7byABVsfwpMrZ0AI9u/TH41eW8jiNeKFaqc1nmCkNK7iLx5r4HX4Tgg+nJ5eCV6ptcCeHg0CMMBWtAdZdC25p/uE0sma5vASUPsiX7QSTaRwLVVTUFJSWxmDGiQhwTxIRwoTzlHoFxsEjDe/AUDPgeUwMcFtqzDOmJtxH1fKU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DftZbPXt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718963373;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=T84pkPxoOVF7+EbEjV+8MHWS6p9zQoo8JNnRS5sf/gM=;
	b=DftZbPXtN8U39K0xrWpXG2Yj1nTY46dJuJffo9wyPzBhLNb2wLMBjeel+Z3IU88Zh+BZ31
	G11qk53fkyI/z6r/uRGxL1lBzG2PTKG1yYsTorKW8ttbAiiuwp4DFllv7Vzh0atB2/jvCk
	ZmIFTZbm55cqmAt5xWm+epKRhcWVbD4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-256-C5avpVNDMIWrs46GdAgyGw-1; Fri, 21 Jun 2024 05:49:29 -0400
X-MC-Unique: C5avpVNDMIWrs46GdAgyGw-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-36333c6b9c7so290957f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 02:49:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718963368; x=1719568168;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T84pkPxoOVF7+EbEjV+8MHWS6p9zQoo8JNnRS5sf/gM=;
        b=dsnwBrguqPIAiwmvvO3AU3Lqw9ktQf6t1r31mMYRm/R90RLWZ7UiuA9+5lL/vp9axa
         NGQSTtCFcibdRR1SFxANI24a01ZQxgK2lIT+ep3kShUKYki58dt2gFWeo8GlotNHwGWh
         o9B44PbHumi5gujfOA+/TO0lyuv4vSa+rX86JuzSvcQ6L2cA8Uls8AfyT23zwuvZjYX0
         AqIwot1V3jvh4B1Zdk3FMkq5+1MsWVSwBTSydm0SYrlL+BJlXv4JziSD9Pv/aAVMCgZu
         6+Z0l9UlA7oH6Vaza94LUhCBT+nSDxWEe88iAdMtZvB+4s48qTZ3jY1cGsRi+keBI5u3
         w8tQ==
X-Forwarded-Encrypted: i=1; AJvYcCXmrLfLZQr2xvptIQk7iaYgWYVuNKHCt5/YiEoin+TIShTAMypmYhZ6hdKdpn16uC/9QANdy5S3Czm+jfvNhGtk+OgKfVOpWKeL/R0j
X-Gm-Message-State: AOJu0Yx8yCJ+N4Q8bEl61IfGUsv9A+meHLqxiuTfe7UWZn2l+rqDQIcm
	GzXVeQEKfa21d82CmyrBXsQmr+kLxBkJus92yi2vVdoU0pzmIQgH6NGfnGIGrAwjEz8qXZq8bMt
	J9QSSI7jCDFuVN57H4sqTb4WmTOX4tI9Y+JmfJaDixNSXJCZXxLLNWKnOSJkBgQ==
X-Received: by 2002:a05:6000:18a2:b0:362:1322:affc with SMTP id ffacd0b85a97d-3631998fb44mr6557126f8f.5.1718963367976;
        Fri, 21 Jun 2024 02:49:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG13B6ru48yXs3LfLtUM5S/5oxVo2hDzIyhqBvGMis2Kdbj45jbmJgKjpz4JCOx31aj2AzMag==
X-Received: by 2002:a05:6000:18a2:b0:362:1322:affc with SMTP id ffacd0b85a97d-3631998fb44mr6557100f8f.5.1718963367495;
        Fri, 21 Jun 2024 02:49:27 -0700 (PDT)
Received: from gerbillo.redhat.com ([2a0d:3341:b08b:6910:937c:803f:4309:91d0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3663a2f694asm1227044f8f.77.2024.06.21.02.49.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 02:49:27 -0700 (PDT)
Message-ID: <a1c983cdb95bdd44385dae29ca7451da16a70c98.camel@redhat.com>
Subject: Re: [RFC net-next 1/9] skb: introduce gro_disabled bit
From: Paolo Abeni <pabeni@redhat.com>
To: Yan Zhai <yan@cloudflare.com>, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>, Willem de Bruijn <willemb@google.com>, Simon
 Horman <horms@kernel.org>, Florian Westphal <fw@strlen.de>, Mina Almasry
 <almasrymina@google.com>, Abhishek Chauhan <quic_abchauha@quicinc.com>, 
 David Howells <dhowells@redhat.com>, Alexander Lobakin
 <aleksander.lobakin@intel.com>, David Ahern <dsahern@kernel.org>, Richard
 Gobert <richardbgobert@gmail.com>, Antoine Tenart <atenart@kernel.org>,
 Felix Fietkau <nbd@nbd.name>, Soheil Hassas Yeganeh <soheil@google.com>,
 Pavel Begunkov <asml.silence@gmail.com>, Lorenzo Bianconi
 <lorenzo@kernel.org>, Thomas =?ISO-8859-1?Q?Wei=DFschuh?=
 <linux@weissschuh.net>,  linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Date: Fri, 21 Jun 2024 11:49:24 +0200
In-Reply-To: <b8c183a24285c2ab30c51622f4f9eff8f7a4752f.1718919473.git.yan@cloudflare.com>
References: <cover.1718919473.git.yan@cloudflare.com>
	 <b8c183a24285c2ab30c51622f4f9eff8f7a4752f.1718919473.git.yan@cloudflare.com>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-06-20 at 15:19 -0700, Yan Zhai wrote:
> Software GRO is currently controlled by a single switch, i.e.
>=20
>   ethtool -K dev gro on|off
>=20
> However, this is not always desired. When GRO is enabled, even if the
> kernel cannot GRO certain traffic, it has to run through the GRO receive
> handlers with no benefit.
>=20
> There are also scenarios that turning off GRO is a requirement. For
> example, our production environment has a scenario that a TC egress hook
> may add multiple encapsulation headers to forwarded skbs for load
> balancing and isolation purpose. The encapsulation is implemented via
> BPF. But the problem arises then: there is no way to properly offload a
> double-encapsulated packet, since skb only has network_header and
> inner_network_header to track one layer of encapsulation, but not two.
> On the other hand, not all the traffic through this device needs double
> encapsulation. But we have to turn off GRO completely for any ingress
> device as a result.
>=20
> Introduce a bit on skb so that GRO engine can be notified to skip GRO on
> this skb, rather than having to be 0-or-1 for all traffic.
>=20
> Signed-off-by: Yan Zhai <yan@cloudflare.com>
> ---
>  include/linux/netdevice.h |  9 +++++++--
>  include/linux/skbuff.h    | 10 ++++++++++
>  net/Kconfig               | 10 ++++++++++
>  net/core/gro.c            |  2 +-
>  net/core/gro_cells.c      |  2 +-
>  net/core/skbuff.c         |  4 ++++
>  6 files changed, 33 insertions(+), 4 deletions(-)
>=20
> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index c83b390191d4..2ca0870b1221 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -2415,11 +2415,16 @@ struct net_device {
>  	((dev)->devlink_port =3D (port));				\
>  })
> =20
> -static inline bool netif_elide_gro(const struct net_device *dev)
> +static inline bool netif_elide_gro(const struct sk_buff *skb)
>  {
> -	if (!(dev->features & NETIF_F_GRO) || dev->xdp_prog)
> +	if (!(skb->dev->features & NETIF_F_GRO) || skb->dev->xdp_prog)
>  		return true;
> +
> +#ifdef CONFIG_SKB_GRO_CONTROL
> +	return skb->gro_disabled;
> +#else
>  	return false;
> +#endif

This will generate OoO if the gro_disabled is flipped in the middle of
a stream.

Assuming the above is fine for your use case (I think it's _not_ in
general), you could get the same result without an additional costly
bit in sk_buff.

Let xdp_frame_fixup_skb_offloading() return a bool - e.g. 'true' when
gro should be avoided - and let the NIC driver call netif_receive_skb()
instead of the gro rx hook for such packet.

All in all the approach implemented in this series does not look worthy
to me.

Thanks,

Paolo


