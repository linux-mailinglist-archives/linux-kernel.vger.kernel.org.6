Return-Path: <linux-kernel+bounces-303597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F3552960FE4
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 17:03:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 737421F239D3
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 15:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF7AB1C7B92;
	Tue, 27 Aug 2024 15:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="I0DL/ISZ"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A0BC1C68B1
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 15:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724770963; cv=none; b=KaYfN20fX+p5oeQm8XrIvVU6xQsUuD7zWbX3cwLAk97oJGiNig05DNtBflWiOhIxQXJ/SPwn1i3pcjKHn30vC8WDSTgtYUF5A1KNlF/1re95nzgiQ9IUlYspUSVsnRz6Gf2oKbB7cReplQe40W0TqNflHF5EIS2oDZPCfIUV7I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724770963; c=relaxed/simple;
	bh=mQZ97ZNvzRncqKcm9pTIsuBADoggR2DR7S+QK/RHBys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I9RQ+pymuneQW/Hpkq59P5OWKP4q0n8/42GVX8NyUaAOSQXN8GOO/xlBqIdI8Wt4zpK0GbqZgy5iI287SMldRKeBnVNi52tk1uPvPyx61ou4sxRjwnjqwSAz/3PTuEXTf7BQhCQ7SXsu1e389fIaScx+VRHsZbLh0hNeupCqVMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=I0DL/ISZ; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5bed83488b3so6515965a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 08:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1724770959; x=1725375759; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yFL51re5mKGiWTbXsiX4IVZzXWb4fz8WW1qyOQEt1vE=;
        b=I0DL/ISZgrU44DK86eL3Y9oolyOMZe4sPuUxANK57Zt6GLn1l1mAfw1uD/aaUMVAD3
         52svBYTZC4N9O0PMeeEZ4gqIuUqsCuLFx9zZ558W5uH5hHb3ywEs0wmpoR0dbi2w0fbH
         2pgRKSWnOkM5EtFGJr9+C69XCEpvC3pNRdx0sEDfkk5jeFZlLR1xIopC8+kvkVlX3d7b
         Qyy5IWxj+90qdzlvZkYN9KIZat/khICFZTSHNtFHXQ9VfKGSEVfWtyRp/x/aqUBTonBO
         pMEsFDCYUNPr9iLmOLhQv2ZwZsVplis+TDn6MfK75RpbF7XD2mJD75SrAPP0Xixh9wx+
         SUlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724770959; x=1725375759;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yFL51re5mKGiWTbXsiX4IVZzXWb4fz8WW1qyOQEt1vE=;
        b=NjhE2oZX3MKoA8Vna0fzItVvoouJzv6oiFe8GXZBFq8v6iw9krLEfYiMejWV/qPOhA
         +nSJuHlKUYvvYQJiugy+P2wJEZKGjAs2uSvPv1XzBVAqdDUjx8JPvyWh/9Z+0PO4vp1e
         tSsmZhmnCavj5Z2RmcViYJeTK+NiiVcoJWqLpkmNpWsz09KMO+Wz5KLHlTk0IERiaY0v
         VJBvH5oFbT6hFMuEZCGvifBVVp4UAqnDPGWERKSHg0cFzPb+ncZjtaHnrd67mX61t+Zu
         L5G2AIZTPrWQn/lVHRpazVQJ5A8wUa/YC7gpZU5560En2Ekd978zghV0q1A8fTjiOP8T
         T7yQ==
X-Forwarded-Encrypted: i=1; AJvYcCUa9wYZLG9I433IRDpimZ32MYtIDegm+ZYUW6mUe68jn/ykRUCll+KeyvziHZReOhu0cmvluBeNwaM1MM0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDtc7R6AOoSU8D1+Hqs6f3Y2hLOUcKgzIjk37mxrlAqAZz7cQ8
	RBpPeAO+F1E1y5SO8ZNj0diViOMaFRvs2Npe5grnbpCEGHaB0bsWc3xS8op8fLY=
X-Google-Smtp-Source: AGHT+IGo2EhMX5Npq1n9OFLM4+D9y+dMp43956Cyj2PTcbfZH9XfB8jNzxAc58L1TFmqOcaYqJP0Tg==
X-Received: by 2002:a17:907:c7e6:b0:a86:82da:2c3c with SMTP id a640c23a62f3a-a86a52c1b34mr916975166b.40.1724770958596;
        Tue, 27 Aug 2024 08:02:38 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a86e588ad1asm121362666b.171.2024.08.27.08.02.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 08:02:37 -0700 (PDT)
Date: Tue, 27 Aug 2024 17:02:36 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: cve@kernel.org, linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Tao Liu <thomas.liu@ucloud.cn>, Willem de Bruijn <willemb@google.com>
Subject: Re: CVE-2022-48936: gso: do not skip outer ip header in case of ipip
 and net_failover
Message-ID: <z3hh3yrf5wym3obgol6obh3dkmqoc3rwbkj23qcmadf63b47h2@nn2232wngans>
References: <2024082224-CVE-2022-48936-9302@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zlldsbb7ibsfnogu"
Content-Disposition: inline
In-Reply-To: <2024082224-CVE-2022-48936-9302@gregkh>


--zlldsbb7ibsfnogu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 22, 2024 at 11:31:37AM GMT, Greg Kroah-Hartman <gregkh@linuxfou=
ndation.org> wrote:
> We encounter a tcp drop issue in our cloud environment. Packet GROed in
> host forwards to a VM virtio_net nic with net_failover enabled. VM acts
> as a IPVS LB with ipip encapsulation. The full path like:
> host gro -> vm virtio_net rx -> net_failover rx -> ipvs fullnat
>  -> ipip encap -> net_failover tx -> virtio_net tx
>=20
> When net_failover transmits a ipip pkt (gso_type =3D 0x0103, which means
> SKB_GSO_TCPV4, SKB_GSO_DODGY and SKB_GSO_IPXIP4), there is no gso
> did because it supports TSO and GSO_IPXIP4. But network_header points to
> inner ip header.
>=20
> Call Trace:
>  tcp4_gso_segment        ------> return NULL
>  inet_gso_segment        ------> inner iph, network_header points to
>  ipip_gso_segment
>  inet_gso_segment        ------> outer iph
>  skb_mac_gso_segment

> Afterwards virtio_net transmits the pkt, only inner ip header is modified.
> And the outer one just keeps unchanged. The pkt will be dropped in remote
> host.

That may appear like a transient connection issue or permanently
impossible connection?

> Call Trace:
>  inet_gso_segment        ------> inner iph, outer iph is skipped
>  skb_mac_gso_segment
>  __skb_gso_segment
>  validate_xmit_skb
>  validate_xmit_skb_list
>  sch_direct_xmit
>  __qdisc_run
>  __dev_queue_xmit        ------> virtio_net
>  dev_hard_start_xmit
>  __dev_queue_xmit        ------> net_failover
>  ip_finish_output2
>  ip_output
>  iptunnel_xmit
>  ip_tunnel_xmit
>  ipip_tunnel_xmit        ------> ipip
>  dev_hard_start_xmit
>  __dev_queue_xmit
>  ip_finish_output2
>  ip_output
>  ip_forward
>  ip_rcv
>  __netif_receive_skb_one_core
>  netif_receive_skb_internal
>  napi_gro_receive
>  receive_buf
>  virtnet_poll
>  net_rx_action
>=20
> The root cause of this issue is specific with the rare combination of
> SKB_GSO_DODGY and a tunnel device that adds an SKB_GSO_ tunnel option.
> SKB_GSO_DODGY is set from external virtio_net. We need to reset network
> header when callbacks.gso_segment() returns NULL.

Who's in control of these configuration (who can cause this incorrect
packet being sent)?

> This patch also includes ipv6_gso_segment(), considering SIT, etc.
>=20
> The Linux kernel CVE team has assigned CVE-2022-48936 to this issue.

What is the security issue here?

Thanks,
Michal

--zlldsbb7ibsfnogu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZs3qhwAKCRAt3Wney77B
SX95AP92dOHL0efG8bDJy1ktpIsxQDIVU8jEI2t2j274FogjIwD+PciDpkAbOYnT
gLdlbfFPFGsnUaUbMxO4m/8I/pOu8ws=
=lVo1
-----END PGP SIGNATURE-----

--zlldsbb7ibsfnogu--

