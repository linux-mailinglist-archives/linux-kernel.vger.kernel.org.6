Return-Path: <linux-kernel+bounces-217571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7098190B1A7
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 16:22:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D7D8283830
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 14:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 839EF1A0B1C;
	Mon, 17 Jun 2024 13:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="e53mt5Pg"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4264199E9E;
	Mon, 17 Jun 2024 13:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718631016; cv=none; b=qkR48AdCcFJfsoAFH7Vw9JpepKvqAGuG6woF7mAkkxlIqwwUThI2LaQG+/cRjG0QU7YLuFztedWPgzEakHk8Ta4eNMbpuk3wjMmhCqCFDGozcJJBAejIIbIHsgkl5L3ddGXvDe+UHOI+zcUHLRh6ymen614cPWxbOe6ijeset6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718631016; c=relaxed/simple;
	bh=KSb3mRso17rcUhqb1Oro4xaRLDBSd9Y8je7X+EGQxKI=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JAalEoGnUyNnNps7/L8KRBxyy9TwV8mSoi5NTPkz3bVvkQBvGLD08Q2sSMv9OpD95NTgaGpcspiUlyYsOeYVeenyd0wsxNn8/9/tjTgBDRUPdAHyOaTZ+I/b3iAkcZNH3XA//IOY2R8Aggiw4KYnD40O6VkJM/X7X/fsyzNE0TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=e53mt5Pg; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1718631014; x=1750167014;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KSb3mRso17rcUhqb1Oro4xaRLDBSd9Y8je7X+EGQxKI=;
  b=e53mt5PgulIomW5ZRO2a1Kr5zgEdNHWwCLemuc+aHDPDmFLp3qQ8ppo6
   hmcCNarB031kIGHXq3GELT4jZjfWKNphrqHBKUkpzq3nQmKMANGQJCoHV
   xn3fO4WBG7L6iwIFkEuVI36hlwnYbEOL/2n5rFKQhsvI7shSyo577r2Im
   URXoISN6ji9wSs856g93ptj3KaGAlPaJTUroJZipSCDFkWxXeIhnpIoHU
   ZOvQgNs0RQlW7tLcLFF922GtDBTZfBO43ebvcjdAxpyJSASwcVxjssTQb
   3sJNHHfrYwfLUukRhh/5kPfYe6O7k5RuEbuhdTt4VOkZS/bvtg54mF+h9
   w==;
X-CSE-ConnectionGUID: vs/KqhXwTIKMnwb8mVJ4mg==
X-CSE-MsgGUID: jnR8qmdfSTeSCRZB+zW6Sg==
X-IronPort-AV: E=Sophos;i="6.08,244,1712646000"; 
   d="asc'?scan'208";a="28519325"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Jun 2024 06:30:13 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 17 Jun 2024 06:30:06 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex02.mchp-main.com (10.10.85.144)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Mon, 17 Jun 2024 06:30:04 -0700
Date: Mon, 17 Jun 2024 14:29:46 +0100
From: Conor Dooley <conor.dooley@microchip.com>
To: Jisheng Zhang <jszhang@kernel.org>
CC: Yangyu Chen <cyy@cyyself.name>, <linux-riscv@lists.infradead.org>, Conor
 Dooley <conor+dt@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Paul
 Walmsley <paul.walmsley@sifive.com>, Samuel Holland
	<samuel.holland@sifive.com>, Anup Patel <anup.patel@wdc.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 7/9] riscv: dts: add initial SpacemiT K1 SoC device
 tree
Message-ID: <20240617-carat-poise-ee63ed6a224e@wendy>
References: <tencent_BC64B7B1876F5D10479BD19112F73F262505@qq.com>
 <tencent_701082E2DAE48E2FB857316321778D737C08@qq.com>
 <ZnAw9QrSD-svYqQ5@xhacker>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="oT9/HnCyP3m+8Cht"
Content-Disposition: inline
In-Reply-To: <ZnAw9QrSD-svYqQ5@xhacker>

--oT9/HnCyP3m+8Cht
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 17, 2024 at 08:49:57PM +0800, Jisheng Zhang wrote:
> On Mon, Jun 17, 2024 at 01:20:52AM +0800, Yangyu Chen wrote:
> > Banana Pi BPI-F3 motherboard is powered by SpacemiT K1[1].
> >=20
> > Key features:
> > - 4 cores per cluster, 2 clusters on chip
> > - UART IP is Intel XScale UART
> >=20
> > Some key considerations:
> > - ISA string is inferred from vendor documentation[2]
> > - Cluster topology is inferred from datasheet[1] and L2 in vendor dts[3]
> > - No coherent DMA on this board
> >     Inferred by taking vendor ethernet and MMC drivers to the mainline
> >     kernel. Without dma-noncoherent in soc node, the driver fails.
> > - No cache nodes now
> >     The parameters from vendor dts are likely to be wrong. It has 512
> >     sets for a 32KiB L1 Cache. In this case, each set is 64B in size.
> >     When the size of the cache line is 64B, it is a directly mapped
> >     cache rather than a set-associative cache, the latter is commonly
> >     used. Thus, I didn't use the parameters from vendor dts.
> >=20
> > Currently only support booting into console with only uart, other
> > features will be added soon later.
>=20
> Hi Yangyu,
>=20
> Per recent practice of cv1800b and th1520 upstream, I think a complete
> initial support would include pinctrl, clk and reset, I have received
> the complains from the community. So can you please bring the pinctrl
> clk  and reset at the same time?

What sort of complaints have you got? That the support is too minimal to
be useful?

--oT9/HnCyP3m+8Cht
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZnA6SgAKCRB4tDGHoIJi
0na7AP9um0KeWsttwnNSGE2JtwpFCri+BagSptLaplA4idDWBgD/a2Bs8pedwuex
lnoPGQJ1Ty98RoIrkROV8cur2alHbQU=
=LKni
-----END PGP SIGNATURE-----

--oT9/HnCyP3m+8Cht--

