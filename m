Return-Path: <linux-kernel+bounces-541249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E76A8A4BA88
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 10:14:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68B9E3B1BE4
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 09:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4935C1DE3A4;
	Mon,  3 Mar 2025 09:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="QA+InjHe"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B1B21EFFA1;
	Mon,  3 Mar 2025 09:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740993199; cv=none; b=o0N/7qweb8enTNGyOENxLnFHk2fDFVwthj+KLtuQ9PEWWyr0b4Kc7H8x4mob9RZ19pAn3+IFqRIU7dUdZk+UWI2ZbPBZdULCr1UOTPmOyaRvHaV0+gbEdWWG4WYO01lr9qi5dR+a9RT7p37nVNDPI72tL86e/Ha7/AV8uFKiRzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740993199; c=relaxed/simple;
	bh=BtoQelzDR2YH4eJcJiAnN1ShwH9UMlztv91FI3QOKQM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XNnEbG0PAvQtyNLsNVSw1mCTOsgym7AWShu36czjM+IKg9iIipO0uzUXYFIbKXOuasVaCk6miIs3okpQn1vx/bQFcNpcI3vOH+M8V9/B/DelkXG+0cPvETsGW1HKg4ERvaUR1sr33FD5EOTV6bDDjnFEGw0JvoQgTMznSk6g5eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=QA+InjHe; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1740993198; x=1772529198;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BtoQelzDR2YH4eJcJiAnN1ShwH9UMlztv91FI3QOKQM=;
  b=QA+InjHeqMw2h8BtxSN9YF3NcSoHnXswe7vo071hbRu2B3hu0GyErJF8
   WHzBdnNfIQWbP4ZtFa8Kre4bCzigVVV/0pPCiM9LO791qS6tytGw/gZJb
   cOUkipGp0BXxHSpVSHsCoeIz5zwaqL0RZG6PIVGCeJ1nhhokXv+FuZFek
   PdlDOm7drxezI2P9hA74gV466pI4JNPL6Y2lr7AyfZ5U4DmiUzKCzQSZA
   rS680nSZrHQ+gu98rkzjkWGGLpPVQyWV9U5tb5nVRHTN7cVK9qUdR+mxG
   FOqKIVzfE2GEDb3eVLEqF2jgSU9uunGlvOM3CsYPvNguo8G8rTB/5brKc
   A==;
X-CSE-ConnectionGUID: zipm0jdkRfKil1sH3LekQQ==
X-CSE-MsgGUID: HgnAMhUcRYiKVH8wTkC38Q==
X-IronPort-AV: E=Sophos;i="6.13,329,1732604400"; 
   d="asc'?scan'208";a="205866723"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 Mar 2025 02:13:16 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 3 Mar 2025 02:13:01 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex02.mchp-main.com (10.10.85.144)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Mon, 3 Mar 2025 02:12:58 -0700
Date: Mon, 3 Mar 2025 09:12:12 +0000
From: Conor Dooley <conor.dooley@microchip.com>
To: damon <sycamoremoon376@gmail.com>
CC: Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Paul
 Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@outlook.com>, Alexandre Ghiti <alex@ghiti.fr>,
	<devicetree@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <sophgo@lists.linux.dev>,
	<chao.wei@sophgo.com>, <xiaoguang.xing@sophgo.com>
Subject: Re: [PATCH v2] riscv: sophgo: dts: Add spi controller for SG2042
Message-ID: <20250303-demeanor-snowstorm-d3ca34450099@wendy>
References: <20250228-sfg-spi-v2-1-8bbf23b85d0e@gmail.com>
 <20250228-factual-rage-0e1e1e48b009@spud>
 <CAKyUbwXUPBceR1ArZeLLjs1VNyRW=DngZyLTUCDGPFvT9wKikw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="yvO2V4zUqjO1jyjY"
Content-Disposition: inline
In-Reply-To: <CAKyUbwXUPBceR1ArZeLLjs1VNyRW=DngZyLTUCDGPFvT9wKikw@mail.gmail.com>

--yvO2V4zUqjO1jyjY
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 01, 2025 at 09:41:14PM +0800, damon wrote:
> On 25/02/28 06:22PM, Conor Dooley wrote:
> > On Fri, Feb 28, 2025 at 08:40:23PM +0800, Zixian Zeng wrote:

> > > diff --git a/arch/riscv/boot/dts/sophgo/sg2042.dtsi b/arch/riscv/boot=
/dts/sophgo/sg2042.dtsi
> > > index e62ac51ac55abd922b5ef796ba8c2196383850c4..500645147b1f8ed0a08ad=
3cafb38ea79cf57d737 100644
> > > --- a/arch/riscv/boot/dts/sophgo/sg2042.dtsi
> > > +++ b/arch/riscv/boot/dts/sophgo/sg2042.dtsi
> > > @@ -545,5 +545,33 @@ sd: mmc@704002b000 {
> > >                                   "timer";
> > >                     status =3D "disabled";
> > >             };
> > > +
> > > +           spi0: spi@7040004000 {
> > > +                   compatible =3D "snps,dw-apb-ssi";
> >
> > I thought were were dropping the use of "snps,dw-abp-ssi" in isolation,
> > and starting to require soc-specific compatibles now.
> >
> That=E2=80=99s better, I will do it in next revision.
> BTW, <https://lore.kernel.org/linux-riscv/20240703-garbage-explicit-bd95f=
8deb716@wendy>
> has similar situation,
> those patches only create binding but not implement the compatible
> property of "thead,th1520-spi=E2=80=9D in driver.
> When kernel matching, it will find out there=E2=80=99s no compatible of
> "thead,th1520-spi=E2=80=9D so fallback to "snps,dw-apb-ssi=E2=80=9D

> May I take you a few minutes for reason behind it? My understanding is
> that using soc-specific compatible is better
> for future maintaining, If the device actually comes with some unknown
> quirks not present in the generic IP.

Yup, that's pretty much it. Those quirks could be some sort of bug etc,
or they could be an extra feature. Sometimes the specific compatible is
only used to enforce constraints on what properties are allowed, but
that's more of a thing for the more configurable IPs like the dwmac.

> And all we need to do for fixing is implementing the soc-specific
> compatible property.

Correct. You just need to add a specific compatible to the binding and
to the dts, the driver will work just fine with the "fallback" dw one.

--yvO2V4zUqjO1jyjY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ8VyawAKCRB4tDGHoIJi
0j1iAQCyO+C9MUu181Bphcy8Tffe1bTfr7IWlfWuccIoHjOBhAD9HxKK0VwJzs9G
QdA5iHSPF66wWVcdBRk99lm7Oi90sAM=
=RlN7
-----END PGP SIGNATURE-----

--yvO2V4zUqjO1jyjY--

