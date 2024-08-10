Return-Path: <linux-kernel+bounces-281784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A34C94DB48
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 10:01:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADFAB1F21EF8
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 08:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC0B014B08A;
	Sat, 10 Aug 2024 08:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gI/vLAHu"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E9FA34CE5
	for <linux-kernel@vger.kernel.org>; Sat, 10 Aug 2024 08:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723276847; cv=none; b=Kdhm3Tj1OQQjUDHHnOE3SOIRNBA7essmFBOk1mc1rkpebelJwDbNkc0UzizHtFn7l4pdOisAB6xg0X4l+eTWL0panoQEgynB2O8tOmFdnQCGvbY3/zVmBpP46hxh/NKXVzuuIUiv4j1AQ/wiBJ4Q/RLTjD0H57MmaFRvjCHbKJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723276847; c=relaxed/simple;
	bh=FxumrIDW6qoxo9gfQ9R1lcQJdhBiVgoBIKMyeVQ2eZc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RSriNION/en0OKhgxP3NVzXfsAMFDExFsNhTtPp3slwTizoaHP/9BMoeWtynLWmilK2vBY75yBeqQ637CXeN3cX29pwjgH9fOgFJa272izaOqMQt27fX4e02LN/Ws7qxdsRyBBV0VzMr1B5F9FrOSZmBQJemYRZS+OUssTSQyrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gI/vLAHu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723276844;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cxaBsOWYXbQjl952d0wR8HU0oXx4pPetERcANE2n4pw=;
	b=gI/vLAHucsJzDuwknrYb5jqDUUI6+jvHh4qMHWt+xDTtTg5WSujV6B5vscSHSjF7imSY1a
	TSAqGOAUQmZFs0B3eMZstLdE90cn6df/tKeJ6TAFqaETYcyFFhkkBr3C2qfmsMehZ6DcOv
	5lkDXJarpFbkhzD6ecTnvJBuIbMpBHM=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-322-laqStXZbPHKtbTzL5Cb82Q-1; Sat, 10 Aug 2024 04:00:42 -0400
X-MC-Unique: laqStXZbPHKtbTzL5Cb82Q-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2ef244cdd30so26288201fa.0
        for <linux-kernel@vger.kernel.org>; Sat, 10 Aug 2024 01:00:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723276841; x=1723881641;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cxaBsOWYXbQjl952d0wR8HU0oXx4pPetERcANE2n4pw=;
        b=Qg+FJjP0x3corOtWi9ROBuNPl5f0zaCCQDTV/tn19Qh6EU3tRfG4oi40lnCkwHK5UD
         RZUYNdaBeTvjt2bKx6JE7PG8Go10qdYojpk0Jq40c4gdvcLsh1hIbphXBr3YgLbqyCeR
         S1m/RY33x/DYcqrIQVo/9K+py7/z78GCteYwvFXCJAkl55oeDwZwNL7ZT6EzMwa9Xk1m
         abfB43BAVs+45za+9g+Qt5IMwcu9ZZ1qh01vTujNft148CJ6g7NeR2kbtZjBaB4JJ+Oj
         4DHGEoXjne1Fo8XlBSYDna/BfPmQx3AOVR7Ay6GvHci1YtR5yDN1srnBiJazU531TW5Q
         hMnw==
X-Forwarded-Encrypted: i=1; AJvYcCWFZUKNhZP4rxRZpcqfXO2a8qZrujMTTRnMZMl/VlE4kscakZkwmFxOs6D5AENpU8j1ZbmTvQbwEhTzcXyAkJZ1l0yDdx9+uYuc3mbd
X-Gm-Message-State: AOJu0Yzv7eUZ/n1aXexfBK8JvRGQywy86A2SoaMYS2O8GPLsbMlm2+ll
	IEoJ1QWxWQinF4E3T8kQ+2vwgxOnD1X2j4fDuStab8DYhjynLgoGRtL0B3js/8pW6YITv5Lxwlm
	x6iDsUxWRoHKPqGSbm49/1flzQfOIq4ufLtnCqDqvP0ozhUz6aClzRhd2mu1eQg==
X-Received: by 2002:a2e:be9d:0:b0:2f0:20cd:35fc with SMTP id 38308e7fff4ca-2f1a6c4cf01mr33426841fa.7.1723276840561;
        Sat, 10 Aug 2024 01:00:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHm7k8IUz5d3cudToCANSXgZtSllkVKwZwQhLwKqQ43m1YO/m1NdkmZJerxkfQZ0JUye0k27A==
X-Received: by 2002:a2e:be9d:0:b0:2f0:20cd:35fc with SMTP id 38308e7fff4ca-2f1a6c4cf01mr33426271fa.7.1723276839630;
        Sat, 10 Aug 2024 01:00:39 -0700 (PDT)
Received: from localhost (53.116.107.80.static.otenet.gr. [80.107.116.53])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429c7736b05sm19723545e9.29.2024.08.10.01.00.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Aug 2024 01:00:39 -0700 (PDT)
Date: Sat, 10 Aug 2024 10:00:36 +0200
From: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Daniel Xu <dxu@dxuuu.xyz>,
	Alexander Lobakin <alexandr.lobakin@intel.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Jonathan Lemon <jonathan.lemon@gmail.com>,
	"toke@redhat.com" <toke@redhat.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	David Miller <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Yajun Deng <yajun.deng@linux.dev>,
	Willem de Bruijn <willemb@google.com>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, xdp-hints@xdp-project.net
Subject: Re: [xdp-hints] Re: [PATCH RFC bpf-next 32/52] bpf, cpumap: switch
 to GRO from netif_receive_skb_list()
Message-ID: <ZrceJNrf2EkCD4Av@lore-rh-laptop>
References: <20220628194812.1453059-1-alexandr.lobakin@intel.com>
 <20220628194812.1453059-33-alexandr.lobakin@intel.com>
 <cadda351-6e93-4568-ba26-21a760bf9a57@app.fastmail.com>
 <ZrRPbtKk7RMXHfhH@lore-rh-laptop>
 <54aab7ec-80e9-44fd-8249-fe0cabda0393@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3tjfGVd/eoZK+rGd"
Content-Disposition: inline
In-Reply-To: <54aab7ec-80e9-44fd-8249-fe0cabda0393@intel.com>


--3tjfGVd/eoZK+rGd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Aug 08, Alexander Lobakin wrote:
> From: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
> Date: Thu, 8 Aug 2024 06:54:06 +0200
>=20
> >> Hi Alexander,
> >>
> >> On Tue, Jun 28, 2022, at 12:47 PM, Alexander Lobakin wrote:
> >>> cpumap has its own BH context based on kthread. It has a sane batch
> >>> size of 8 frames per one cycle.
> >>> GRO can be used on its own, adjust cpumap calls to the
> >>> upper stack to use GRO API instead of netif_receive_skb_list() which
> >>> processes skbs by batches, but doesn't involve GRO layer at all.
> >>> It is most beneficial when a NIC which frame come from is XDP
> >>> generic metadata-enabled, but in plenty of tests GRO performs better
> >>> than listed receiving even given that it has to calculate full frame
> >>> checksums on CPU.
> >>> As GRO passes the skbs to the upper stack in the batches of
> >>> @gro_normal_batch, i.e. 8 by default, and @skb->dev point to the
> >>> device where the frame comes from, it is enough to disable GRO
> >>> netdev feature on it to completely restore the original behaviour:
> >>> untouched frames will be being bulked and passed to the upper stack
> >>> by 8, as it was with netif_receive_skb_list().
> >>>
> >>> Signed-off-by: Alexander Lobakin <alexandr.lobakin@intel.com>
> >>> ---
> >>>  kernel/bpf/cpumap.c | 43 ++++++++++++++++++++++++++++++++++++++-----
> >>>  1 file changed, 38 insertions(+), 5 deletions(-)
> >>>
> >>
> >> AFAICT the cpumap + GRO is a good standalone improvement. I think
> >> cpumap is still missing this.
>=20
> The only concern for having GRO in cpumap without metadata from the NIC
> descriptor was that when the checksum status is missing, GRO calculates
> the checksum on CPU, which is not really fast.
> But I remember sometimes GRO was faster despite that.

For the moment we could test it with UDP traffic with checksum disabled.

Regards,
Lorenzo

>=20
> >>
> >> I have a production use case for this now. We want to do some intellig=
ent
> >> RX steering and I think GRO would help over list-ified receive in some=
 cases.
> >> We would prefer steer in HW (and thus get existing GRO support) but no=
t all
> >> our NICs support it. So we need a software fallback.
> >>
> >> Are you still interested in merging the cpumap + GRO patches?
>=20
> For sure I can revive this part. I was planning to get back to this
> branch and pick patches which were not related to XDP hints and send
> them separately.
>=20
> >=20
> > Hi Daniel and Alex,
> >=20
> > Recently I worked on a PoC to add GRO support to cpumap codebase:
> > - https://github.com/LorenzoBianconi/bpf-next/commit/a4b8264d5000ecf016=
da5a2dd9ac302deaf38b3e
> >   Here I added GRO support to cpumap through gro-cells.
> > - https://github.com/LorenzoBianconi/bpf-next/commit/da6cb32a4674aa7240=
1c7414c9a8a0775ef41a55
> >   Here I added GRO support to cpumap trough napi-threaded APIs (with a =
some
> >   changes to them).
>=20
> Hmm, when I was testing it, adding a whole NAPI to cpumap was sorta
> overkill, that's why I separated GRO structure from &napi_struct.
>=20
> Let me maybe find some free time, I would then test all 3 solutions
> (mine, gro_cells, threaded NAPI) and pick/send the best?
>=20
> >=20
> > Please note I have not run any performance tests so far, just verified =
it does
> > not crash (I was planning to resume this work soon). Please let me know=
 if it
> > works for you.
> >=20
> > Regards,
> > Lorenzo
> >=20
> >>
> >> Thanks,
> >> Daniel
>=20
> Thanks,
> Olek
>=20

--3tjfGVd/eoZK+rGd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZrceIQAKCRA6cBh0uS2t
rAuOAP9lAP+wUtI4DT03vstan8oVHlFYyfbFpQ5S9GXv19t6iQD+Oq31gcfUQN93
0x2SbfWudVdpE9DvTKzXi6mE/f29ZAc=
=6Wya
-----END PGP SIGNATURE-----

--3tjfGVd/eoZK+rGd--


