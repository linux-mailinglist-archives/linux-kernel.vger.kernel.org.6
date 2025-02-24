Return-Path: <linux-kernel+bounces-529110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42F0BA41FD7
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 14:03:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00EAB3A5FE6
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 13:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B674523BCFF;
	Mon, 24 Feb 2025 13:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3kwfdOUB"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C026233734
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 13:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740402064; cv=none; b=FDxfsOKgCwxmbd8phg+tCKelNq/0E9j/TwOfeTXmMWEgj6kzvkyIOZmQdL+AvnXceYw8M7L6cI3fZm0nBw0LbozWiVfT9ZtdejAyWQo+Up69GxDUDzilcWjnKONt1/ysX/d3OT+ypzcAzdEBkan7C3uKJuvEigQHnDuKHMPCB4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740402064; c=relaxed/simple;
	bh=VLAsrmSAb3kGU++2nwWF9OOXrMTkn8/dEIc9dcvkfZE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hqNme2Bz93c+2r2WKS+f+3CkuvIMbGSUzvKw1Jv/qbbyrV4J2uRgedWVIJtOYnaEJDEkvJU1vLvRJ8qXODfRw6Vw8IxoXOVLvjHbOCR1VdIBiq5/zLAz6SusqZLkP2adNcWEME6whhcQFhGy4iFm47ikC7GPMkO+C8fQ2gKDwkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3kwfdOUB; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ab771575040so936590966b.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 05:01:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740402061; x=1741006861; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MhW5lfJWyyYPvccFPixIiNXBgnolkSq4aXYrSR9SgFo=;
        b=3kwfdOUBkNylkJ2/oiCtXMwByK9d/R4kA7FFgCb+Nz4BaT00krfHIdRa8FlvesjIs8
         qZ3k9LmblB7pwgtUTInk52p2Kax56Ax8QpsgkDgMxnAKJy2bpooiJALQfGtTMDNeS+/6
         dtTIwDad7bxYSbB96Oe942MmQcdUQY5RDVWXOCBTiSZ/4+neQHYJ2i78OjDCjU/EdHa4
         LHE4TQ3L91VdVwmqRrruVk3FkQ0MhC1RYwBugGi3/mYens4qLebK6zsn80l64xoBAot0
         XtnbLokTRDZDwGsKDI6rTo6mm516mTspm7uFW/0j2UoR3Fo5UwND1nGYWPVqpV3b6EgS
         3iag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740402061; x=1741006861;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MhW5lfJWyyYPvccFPixIiNXBgnolkSq4aXYrSR9SgFo=;
        b=Mh2MVnpHsS1pg+ltmTJeO/Ta5aV+rw0smHSmhEc3TxRlZIlrGAtL+7B2DdcNErtVNU
         E2RNtnrPuTBy6OC6wxaZMB36t6kAxpVQ5lw+OwVCx8qLcOgnWw0J7f73puBaiYlyr5PS
         FSP/bkYJCziTZeM1Oe1NOMUIePY9Y8UxLzbBt7G+oGfU5xHRKFvlrI0MUZt7ynWh/SrH
         qBMxnMlMfa6tIn7zt4f9Y4w8zwPotTN8ykJGNpk17ZcRWpFBNSWjJfWMT6pirn9Xnr/m
         fdtRUaM243yZPScoPdR+6ECLtDjzQfZcR40qrUgiW37pTBR3XxVhVXhzrcbGDpcUbKhW
         zoyA==
X-Forwarded-Encrypted: i=1; AJvYcCVjjFueLROVffppomhs+jhHNRgQBQoQdCdtEdoOL9gRWzRaXwit6J1TFaNxVGNO5j+POJelcHeSiGUUpZQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMTbN5zHGWrczwmqr3DznSvoQuZtE0nlNGEUtUdnTTz2z0N5UW
	ktQnWQWwLlejlapRFKI5fXoEvPp5Z1CwTOrl3K+RmYFC38c/goec4eXtBUz2GT1ZS9Bqn0TONft
	YNIiKIlHtYy4gVAt2fZgPFSM7eItAZgCG4rZM
X-Gm-Gg: ASbGncvTePtMA3cpRLbrv4VyKT7FJLLqheSSR4rMfx0cBWAxMSsaN67ZGVAl5Yj46PQ
	3DHt19Y5YgjJKmud2uqTvduFeORgENi6fHLsH6/LaPJJwEvsZzBmNuclbu/d2Gwb1zU+FKjRpLR
	bH7vgH0Q==
X-Google-Smtp-Source: AGHT+IFxP6DKH9JVVKKeu9MfUZc742Xg3JoJpQSL6FzFgLaRmR+KL/fy1Rt8P0ne+rwSe6Uj+SiEwuDzYufljb0FcKg=
X-Received: by 2002:a17:907:c49b:b0:abb:8926:5b9f with SMTP id
 a640c23a62f3a-abbeda29d05mr1318984066b.6.1740402059256; Mon, 24 Feb 2025
 05:00:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224112046.52304-1-nbd@nbd.name>
In-Reply-To: <20250224112046.52304-1-nbd@nbd.name>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 24 Feb 2025 14:00:46 +0100
X-Gm-Features: AWEUYZnf60BoIkKhs_5P3lIQAgrUMsntAC8uHFiAbLzqhf9ShLWOsjDaDtw-1wY
Message-ID: <CANn89iLi-NC=4jbNfFW7DELtHS2_JNAHiwRs7GbfZP2E9rGqXA@mail.gmail.com>
Subject: Re: [PATCH net] net: ipv6: fix TCP GSO segmentation with NAT
To: Felix Fietkau <nbd@nbd.name>
Cc: netdev@vger.kernel.org, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Willem de Bruijn <willemb@google.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2025 at 12:21=E2=80=AFPM Felix Fietkau <nbd@nbd.name> wrote=
:
>
> When updating the source/destination address, the TCP/UDP checksum needs =
to
> be updated as well.
>
> Fixes: bee88cd5bd83 ("net: add support for segmenting TCP fraglist GSO pa=
ckets")
> Signed-off-by: Felix Fietkau <nbd@nbd.name>
> ---
>  net/ipv6/tcpv6_offload.c | 20 ++++++++++++++++----
>  1 file changed, 16 insertions(+), 4 deletions(-)
>
> diff --git a/net/ipv6/tcpv6_offload.c b/net/ipv6/tcpv6_offload.c
> index a45bf17cb2a1..5d0fcdbf57a1 100644
> --- a/net/ipv6/tcpv6_offload.c
> +++ b/net/ipv6/tcpv6_offload.c
> @@ -113,24 +113,36 @@ static struct sk_buff *__tcpv6_gso_segment_list_csu=
m(struct sk_buff *segs)
>         struct sk_buff *seg;
>         struct tcphdr *th2;
>         struct ipv6hdr *iph2;
> +       bool addr_equal;
>
>         seg =3D segs;
>         th =3D tcp_hdr(seg);
>         iph =3D ipv6_hdr(seg);
>         th2 =3D tcp_hdr(seg->next);
>         iph2 =3D ipv6_hdr(seg->next);
> +       addr_equal =3D ipv6_addr_equal(&iph->saddr, &iph2->saddr) &&
> +                    ipv6_addr_equal(&iph->daddr, &iph2->daddr);
>
>         if (!(*(const u32 *)&th->source ^ *(const u32 *)&th2->source) &&
> -           ipv6_addr_equal(&iph->saddr, &iph2->saddr) &&
> -           ipv6_addr_equal(&iph->daddr, &iph2->daddr))
> +           addr_equal)
>                 return segs;
>
>         while ((seg =3D seg->next)) {
>                 th2 =3D tcp_hdr(seg);
>                 iph2 =3D ipv6_hdr(seg);
>
> -               iph2->saddr =3D iph->saddr;
> -               iph2->daddr =3D iph->daddr;
> +               if (!addr_equal) {
> +                       inet_proto_csum_replace16(&th2->check, seg,
> +                                                 iph2->saddr.s6_addr32,
> +                                                 iph->saddr.s6_addr32,
> +                                                 true);
> +                       inet_proto_csum_replace16(&th2->check, seg,
> +                                                 iph2->daddr.s6_addr32,
> +                                                 iph->daddr.s6_addr32,
> +                                                 true);
> +                       iph2->saddr =3D iph->saddr;
> +                       iph2->daddr =3D iph->daddr;
> +               }
>                 __tcpv6_gso_segment_csum(seg, &th2->source, th->source);
>                 __tcpv6_gso_segment_csum(seg, &th2->dest, th->dest);

Good catch !

I note that __tcpv4_gso_segment_csum() does the needed csum changes
for both ports and address components.

Have you considered using the same logic for IPv6, to keep
__tcpv6_gso_segment_list_csum()
and __tcpv4_gso_segment_list_csum() similar ?

