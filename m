Return-Path: <linux-kernel+bounces-219038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CD88C90C939
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 13:26:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD84EB266F1
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 11:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3D9213A87A;
	Tue, 18 Jun 2024 10:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="0H5wjngi"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D9677104;
	Tue, 18 Jun 2024 10:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718705823; cv=none; b=LSqbacQohPGLsQ4/xD1oqcWq0q34OshDdZwivaZr8baPhGbcgKbNHzXzATwmqGfoW3tPiKkB8KWrLwUDl4rc4G0WNmdOR3Ac8yLRr5q7xcFho8bnMipw4WEVSnJII++EFZ+/b8BjGSEL7A06u23nv1G/LalkeivZeKlnYnHB5MY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718705823; c=relaxed/simple;
	bh=gx5XNpX9FgJu98i8CWmHAYRyuGCEFHvQShWetZfMZMk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HHulMumhYi41xDIurI/VJMMzUF7OSBsPVWQbkpcVykMuiwXM9UczvriHziG3vho5gRrrqjhfd9VI0JrCFKef3RzWyF+r9U4Si+TFdmkJeSGM2Us/Z3QUqG2rVi0A3FXs8EBzLgMxfESA+uZnp40slY2Us0KAEUjLLKxqmNLU/kE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=0H5wjngi; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1718705821; x=1750241821;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gx5XNpX9FgJu98i8CWmHAYRyuGCEFHvQShWetZfMZMk=;
  b=0H5wjngiS/dWh90CUW5R0m01syYMj0uhnSix3qOfk+4AfEHtNG2yI9vJ
   agaAd4gp5avwcDn+bTYBv7Dv11hDozStt8+BfGUdANcd+ka7yHUTPe1Lf
   vFTkuKysQp+TGzElUI6OPaoldxU/dZ5MbXS5sA1/PkjPR2kFsfetNpfkh
   kpokRS81DHi8oCfSlg92b9Qwf6gBu3Cquoq5S13HEz75MYk6txuZ3DQsn
   wY26vqAeFRqSkWD1u5XEYH/s54dQ+UZz4U/ke7hGQpDzhs02nftYDrwEt
   EmS3pqHeSh0JDov3ipE7gqD0YnWUK7YOikekDoO1VOsdKxZw9oUhaGywX
   w==;
X-CSE-ConnectionGUID: o2SKGVjbQSiEKU8bW2iCXQ==
X-CSE-MsgGUID: 7ZBDQuLCQhWCJdZiKrs8Rg==
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="asc'?scan'208";a="195429902"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Jun 2024 03:16:53 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 18 Jun 2024 03:16:49 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex04.mchp-main.com (10.10.85.152)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Tue, 18 Jun 2024 03:16:46 -0700
Date: Tue, 18 Jun 2024 11:16:28 +0100
From: Conor Dooley <conor.dooley@microchip.com>
To: Jisheng Zhang <jszhang@kernel.org>
CC: Conor Dooley <conor@kernel.org>, Yixun Lan <dlan@gentoo.org>, Yangyu Chen
	<cyy@cyyself.name>, <linux-riscv@lists.infradead.org>, Conor Dooley
	<conor+dt@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley
	<paul.walmsley@sifive.com>, Samuel Holland <samuel.holland@sifive.com>, Anup
 Patel <anup.patel@wdc.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Jesse Taube <jesse@rivosinc.com>
Subject: Re: [PATCH v1 0/9] riscv: add initial support for SpacemiT K1
Message-ID: <20240618-hardwood-footrest-ab5ec5bce3cf@wendy>
References: <tencent_BC64B7B1876F5D10479BD19112F73F262505@qq.com>
 <20240616-exorcism-computing-e11e26084a62@spud>
 <20240616224811.GC3983622@ofsar>
 <ZnBEBQjTQtFs-fXt@xhacker>
 <20240617-synapse-carmaker-0a59c7c6edb7@spud>
 <ZnEOU7D00J8Jzy-1@xhacker>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ls0dFZComN3YRvgQ"
Content-Disposition: inline
In-Reply-To: <ZnEOU7D00J8Jzy-1@xhacker>

--ls0dFZComN3YRvgQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 18, 2024 at 12:34:27PM +0800, Jisheng Zhang wrote:
> On Mon, Jun 17, 2024 at 04:32:59PM +0100, Conor Dooley wrote:
> > On Mon, Jun 17, 2024 at 10:11:17PM +0800, Jisheng Zhang wrote:
> > > On Sun, Jun 16, 2024 at 10:48:11PM +0000, Yixun Lan wrote:
> > > > Hi Conor
> > > >  Thanks for bringing this up
> > > >=20
> > > > On 19:35 Sun 16 Jun     , Conor Dooley wrote:
> > > > > On Mon, Jun 17, 2024 at 01:18:52AM +0800, Yangyu Chen wrote:
> > > > >=20
> > > > > No MAINTAINERS update, so I figure that means you don't want to m=
aintain
> > > > > it going forwards? If there's someone out that that does care abo=
ut the
> > > > > spacemit k1 (Jesse maybe?), then I'd be more than happy to have t=
hem
> > > > > look after it.
> > > > Yangyu kind of has limited time, too many stuff for him..
> > > >=20
> > > > I'd volunteered to help on this if it can fill the gap
> > > > Also I'd be more than happy if anyone willing step forward to co-ma=
intain..
> > >=20
> > > Does maintainership work like this? Is willing to do enough?
> > > FWICT, maintainership involves active patch contributing, reviewing a=
nd
> > > maintaining the whole SoC. It is better to take over the maintainersh=
ip
> > > after showing enough patch contributions and understanding of the SoC.
> >=20
> > I was going to reply to your other patch about providing more complete
> > "basic" support for the SoC, but I guess I'll reply here and address
> > both points. After the k230 and th1520, which were both merged with very
>=20
> When I saw k230 a few minutes ago, I assumed you mean k210 since I
> didn't found k230 support in linus tree now. After searching the
> maillist, I found oh there is a k230 series which is similar to this
> series, no pinctrl, no clk, no reset. Since the incomplete K230 initial
> series hasn't been merged into Linus tree now, is it possible to drop
> it so that we can avoid the same mistake for k230.

Yeah, I think you're right there and I should drop the k230 stuff from
for-next. I forgot that it was not already in, because I had sent it for
6.10 and Arnd didn't like some of the inter-branch dependencies that my
PR had and told me to drop it. If nobody really cares for getting the
platform to a reasonably usable state, then I guess we will just not
support it. And it seems like there's little interest in it, despite
being the first system you could buy with ratified vector. It's not a
great platform to work with documentation wise, at least as a non-Chinese
speaker like myself nor is the U-Boot M-Mode -> OpenSBI -> Linux vendor
boot flow good for iterating on kernels.

> > basic support and have made very little progress towards being a useful
> > platform, I'm pretty reluctant to merge another platform in a super
> > basic state. I was going to make this point before you brought it up,
> > but it's good to know I am not the only one with that view. To be clear,
> > I'm not pointing blame for those platforms, I'd just like to avoid a
>=20
> Yep previously I thought it was fine to use a fixed clock or dummy clock
> during the initial patches, but I changed my mind now, especially after
> Samuel complained the cv1800b reset dt changes.
>=20
> > repeat. If Yangyu doesn't have time to do any development work on the
> > platform, I'd like to see someone else (and as I mentioned Jesse is
> > interested) take on getting some of the basic driver patches written and
> > merge only when those are accepted. Having no in-tree clock and pinctrl
> > drivers is definitely a hindrance to other people doing parallel
> > development of drivers and I'd like to avoid that.
> >=20
> > Getting back to your point in this mail, whoever gets the platform to
> > that state is well suited to looking after it going forwards. Some other
>=20
> The person who can bring the platfrom support to a well-moduled state,
> IE, proper clk, pinctrl, reset drivers shows the passion, the code
> contribution and solid understanding of the SoC, sure he/she is
> definitely suited to maintain the SoC. I just don't think it's=20
> a good practice a person can became maintainer even w/o one LoC
> contrubition to the SoC, because IMHO code contribution matters
> for maintainership.

Right, and the th1520 is suffering a bit from that at the moment, the
maintainers other than yourself haven't sent a single LoC for it, and
have not gotten involved after you have become unable to spend time on
it. I do know that things are likely to change there soon, which is
good.

Thanks,
Conor.

--ls0dFZComN3YRvgQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZnFefAAKCRB4tDGHoIJi
0njCAQDRmhJBRDXSxo9jmNwWNsNOWf+p+Of21MpteeW5PvqBYQD+PRRpSWRtgdSR
MTHkDx0FRVW1eds3JwR/x3zZL4n7/Ak=
=BGK6
-----END PGP SIGNATURE-----

--ls0dFZComN3YRvgQ--

