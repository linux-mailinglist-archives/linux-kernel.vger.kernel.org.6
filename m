Return-Path: <linux-kernel+bounces-278882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E354894B605
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 06:54:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C97C8283CA5
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 04:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1683213B780;
	Thu,  8 Aug 2024 04:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wd8LIhoA"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD73112C81F
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 04:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723092858; cv=none; b=N8RcA73yOOK/KLWbfccgII2Y8TB6mOrz3+TnDAN/Qoj83NJavQ/9FpkIvNu+kY5SN4QsKC4RUv/Rc4nlkW+orqqqEUYZYTZ2m6q55oY4bXeCi+T8gaCAgIZ8QOvOi88Y+fQiqDaLjeLhuk6lecqD1FUFScLihbLmfISfjCQqHIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723092858; c=relaxed/simple;
	bh=7YSzCk1x0lHqAwjDor8GeWE/OSdIDFIRLEbOD4s+Lvc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uoKuxaIa/8FXZAq9zlfTxf8GZHmfntu2l3sZ9/oavR6COBfru5JS+7yiG8UgMnGurtR6sc9X7NmbvNHnRTtoervnbADe0AbnuVdUZSB8ltHqUMRECqyFe06yY075kSLy22zqCfYDVRTGS5FdstT9a3/8ly+GimOkldWB2nq9yzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Wd8LIhoA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723092855;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qGxD/J7yLslw467eIYb7KFvZb5Ntx0WCR07t6fDsHCo=;
	b=Wd8LIhoAA05IUKik7LoO2U2favb25fMXkb+sAtSwphG0O5EkPxdhgqsFdY9tOqaFXBMCZl
	hNGge4Xnt9wstxQqDViPhr+eDzDZTE5XB8K5VfBTVnLTsuW4//iNm5BjI5aeF/0bUy4SAo
	MgUZn3qgh+RFonBrtw7rh/Vlf/NzooU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-133-bII3mdOHMDWmaWlOVq5nzg-1; Thu, 08 Aug 2024 00:54:11 -0400
X-MC-Unique: bII3mdOHMDWmaWlOVq5nzg-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-427ffa0c9c7so7478015e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 21:54:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723092850; x=1723697650;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qGxD/J7yLslw467eIYb7KFvZb5Ntx0WCR07t6fDsHCo=;
        b=P6ZZTef+4p4t0aBqYIp/e152/qiyRXzVqTTfbnWOvxs61+HEcHSrIxhKfhg8YtNGsi
         5bjHT/5CuGr41Rkg9RasAhuhdlP7fdRrbb9/OESp8nAbazIQYt8VPndcQrUxQCf3f8Ja
         67hK1I3NDOb2ZM9Ulc0+oTpqcgqFNhC9Z/JQ0WBSYpgyY1dpHnXhudEy4Afb4N7Sld76
         rgUWRqCpXR8mXGDHx4wcD8y3QWQXcQe1QyLzpqRy7AjAVCDP+spkzEs2L0614Blz+cO9
         Mjg1jymmA9mEjAUXb4C/RvtxzxGwa9yfDVr28u4mUkMcOQ1v8Y6IK6kzwcsvFrHH6XtF
         yFkg==
X-Forwarded-Encrypted: i=1; AJvYcCXSjLc8QrzUjpiNXDPblQkMe/O1Km9KmkxLzH9+3Q2azapKhmuBexCmh29Q+suPmAqNHSzJp3wCePBI4EUykGcC6c4PmLqP1mFWOb9S
X-Gm-Message-State: AOJu0Yy6crHdGJcpnlEmhD4o5w1qQfvdcRUALfh9gqr4f+HJvwCXhpuZ
	aWaocUsopOp81qOn6YUOt/XQ8CLk9Qp0BE0UkBrp7UPI142I17yGNMsPz47RAABdDDgiG0JPzYL
	Sp5wHL3J3x4adJndqL+/S9FT9iiFh3jxBy7/WHPM/uq7BUFB59YTAc0Zwffkv8w==
X-Received: by 2002:a5d:4f05:0:b0:368:3384:e9da with SMTP id ffacd0b85a97d-36d275ce9a7mr428266f8f.62.1723092850052;
        Wed, 07 Aug 2024 21:54:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGxcuyBS6WGfohjX62xojVV6mMc4LlSUlv10jMb/ThanMzMeAKJEdX/KoyeeG9vRzfcx6bY1A==
X-Received: by 2002:a5d:4f05:0:b0:368:3384:e9da with SMTP id ffacd0b85a97d-36d275ce9a7mr428232f8f.62.1723092849508;
        Wed, 07 Aug 2024 21:54:09 -0700 (PDT)
Received: from localhost (53.116.107.80.static.otenet.gr. [80.107.116.53])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36d2716befbsm594845f8f.27.2024.08.07.21.54.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 21:54:08 -0700 (PDT)
Date: Thu, 8 Aug 2024 06:54:06 +0200
From: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To: Daniel Xu <dxu@dxuuu.xyz>
Cc: Alexander Lobakin <alexandr.lobakin@intel.com>,
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
Subject: Re: [PATCH RFC bpf-next 32/52] bpf, cpumap: switch to GRO from
 netif_receive_skb_list()
Message-ID: <ZrRPbtKk7RMXHfhH@lore-rh-laptop>
References: <20220628194812.1453059-1-alexandr.lobakin@intel.com>
 <20220628194812.1453059-33-alexandr.lobakin@intel.com>
 <cadda351-6e93-4568-ba26-21a760bf9a57@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="BrzZC+NstxqLld0s"
Content-Disposition: inline
In-Reply-To: <cadda351-6e93-4568-ba26-21a760bf9a57@app.fastmail.com>


--BrzZC+NstxqLld0s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Hi Alexander,
>=20
> On Tue, Jun 28, 2022, at 12:47 PM, Alexander Lobakin wrote:
> > cpumap has its own BH context based on kthread. It has a sane batch
> > size of 8 frames per one cycle.
> > GRO can be used on its own, adjust cpumap calls to the
> > upper stack to use GRO API instead of netif_receive_skb_list() which
> > processes skbs by batches, but doesn't involve GRO layer at all.
> > It is most beneficial when a NIC which frame come from is XDP
> > generic metadata-enabled, but in plenty of tests GRO performs better
> > than listed receiving even given that it has to calculate full frame
> > checksums on CPU.
> > As GRO passes the skbs to the upper stack in the batches of
> > @gro_normal_batch, i.e. 8 by default, and @skb->dev point to the
> > device where the frame comes from, it is enough to disable GRO
> > netdev feature on it to completely restore the original behaviour:
> > untouched frames will be being bulked and passed to the upper stack
> > by 8, as it was with netif_receive_skb_list().
> >
> > Signed-off-by: Alexander Lobakin <alexandr.lobakin@intel.com>
> > ---
> >  kernel/bpf/cpumap.c | 43 ++++++++++++++++++++++++++++++++++++++-----
> >  1 file changed, 38 insertions(+), 5 deletions(-)
> >
>=20
> AFAICT the cpumap + GRO is a good standalone improvement. I think
> cpumap is still missing this.
>=20
> I have a production use case for this now. We want to do some intelligent
> RX steering and I think GRO would help over list-ified receive in some ca=
ses.
> We would prefer steer in HW (and thus get existing GRO support) but not a=
ll
> our NICs support it. So we need a software fallback.
>=20
> Are you still interested in merging the cpumap + GRO patches?

Hi Daniel and Alex,

Recently I worked on a PoC to add GRO support to cpumap codebase:
- https://github.com/LorenzoBianconi/bpf-next/commit/a4b8264d5000ecf016da5a=
2dd9ac302deaf38b3e
  Here I added GRO support to cpumap through gro-cells.
- https://github.com/LorenzoBianconi/bpf-next/commit/da6cb32a4674aa72401c74=
14c9a8a0775ef41a55
  Here I added GRO support to cpumap trough napi-threaded APIs (with a some
  changes to them).

Please note I have not run any performance tests so far, just verified it d=
oes
not crash (I was planning to resume this work soon). Please let me know if =
it
works for you.

Regards,
Lorenzo

>=20
> Thanks,
> Daniel
>=20

--BrzZC+NstxqLld0s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZrRPagAKCRA6cBh0uS2t
rK0FAQCwzPqU/L+8uGaMYta8IEEG8is+yCbIYKNDjVPfsabMBwD8DTd1Xi5dSpFL
Lj2cZ9irZxRYcLz+GkmnAHDga5i2+Qk=
=Oc7V
-----END PGP SIGNATURE-----

--BrzZC+NstxqLld0s--


