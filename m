Return-Path: <linux-kernel+bounces-193803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 546198D3258
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 10:55:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 064FF1F21936
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 08:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ABEB167DB3;
	Wed, 29 May 2024 08:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Sd5pEFp8"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F5B9167264
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 08:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716972899; cv=none; b=p8x6V8s3Z1d4HqtCHP8+Tvk2co6jm1845vRYsMHtUrwp0fYR/tj3jx3tUiMtoHIYJ2PUX8Ga14Bnj7iibWe0to6zONPSruC+QpaWrEZzCmquKA0XRs5PiEAWompGxVwCAonk7m2Sfp4OVphrh+mAz8rLMnpj9vxs6lUJpFxnoOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716972899; c=relaxed/simple;
	bh=stmi+KjKYwhxeArkzsaF8RjOW0BjWcjWKiALUZ9OGuI=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k7prFDQGNMNyrQidPkm6vguXrtI6Xrmd7F8bBjE39Zj6b19hbaHsOjkQD9tinAQeriZenZWjHY82/gwmYdnJ+l0RhDTJsvc3mtKkbKIhE6AF4aHiOReNjvvBcTbJiF7qOaHQT0vXuIQfw/eASV+e+bIxX9RQ1ir7dirown2jnHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Sd5pEFp8; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1716972897; x=1748508897;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=stmi+KjKYwhxeArkzsaF8RjOW0BjWcjWKiALUZ9OGuI=;
  b=Sd5pEFp8Jm3jUcLmHKtrGbE8U0i9ItAJ7XCYT3utqbV3Uyl4xTZdREi3
   AF7/jtL2i1Kdm3hG+UWWa+kwBczNHuL/RvjDlX9DFeeiux2iPCM5zRH9O
   5Eo84x6bC4TVs2xPA2ijroH2MzD+J4xpgNzd4kj9GB9oLYqZQMA1ZDrVz
   EaXVvJkL1T/nIGz0ha1zqzvDWWvf/aRJl8NnBLKPtP4841zOE4vaSeH8a
   v1mkjwcld691Hd/QPsM9FA5xX7q5/209YNBXpVvNE/Ak0yPu1FzvFwi62
   WVvu1dIkjVc4Kf1+zkmN2cn4Bxlm9+uIbOdzYKnqf6/CFV4pGJi2XADfO
   w==;
X-CSE-ConnectionGUID: 7aj2rH0ESMaOikeNKY2vOw==
X-CSE-MsgGUID: xF5tUv5VR9WfS0JhHj6+6g==
X-IronPort-AV: E=Sophos;i="6.08,197,1712646000"; 
   d="asc'?scan'208";a="194084660"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 May 2024 01:54:56 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 29 May 2024 01:54:48 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex02.mchp-main.com (10.10.85.144)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Wed, 29 May 2024 01:54:46 -0700
Date: Wed, 29 May 2024 09:54:30 +0100
From: Conor Dooley <conor.dooley@microchip.com>
To: Alexandre Ghiti <alex@ghiti.fr>
CC: Conor Dooley <conor@kernel.org>, <linux-riscv@lists.infradead.org>,
	<xiao.w.wang@intel.com>, Andrew Jones <ajones@ventanamicro.com>,
	<pulehui@huawei.com>, Charlie Jenkins <charlie@rivosinc.com>, Paul Walmsley
	<paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
	<linux-kernel@vger.kernel.org>, Samuel Holland <samuel.holland@sifive.com>,
	Pu Lehui <pulehui@huaweicloud.com>, =?iso-8859-1?Q?Bj=F6rn_T=F6pel?=
	<bjorn@kernel.org>
Subject: Re: [PATCH v3 1/2] RISC-V: clarify what some RISCV_ISA* config
 options do
Message-ID: <20240529-riveter-spectacle-e5ab2f45065f@wendy>
References: <20240528-applaud-violin-facef8d9d846@spud>
 <20240528-varnish-status-9c22973093a0@spud>
 <f2a3bddd-0cc1-43ca-8421-1d67dd2800f8@ghiti.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ufpfARkzjihwFYJ8"
Content-Disposition: inline
In-Reply-To: <f2a3bddd-0cc1-43ca-8421-1d67dd2800f8@ghiti.fr>

--ufpfARkzjihwFYJ8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 29, 2024 at 10:47:40AM +0200, Alexandre Ghiti wrote:
> Hi Conor,
>=20
> On 28/05/2024 13:11, Conor Dooley wrote:
> > From: Conor Dooley <conor.dooley@microchip.com>
> >=20
> > During some discussion on IRC yesterday and on Pu's bpf patch [1]
> > I noticed that these RISCV_ISA* Kconfig options are not really clear
> > about their implications. Many of these options have no impact on what
> > userspace is allowed to do, for example an application can use Zbb
> > regardless of whether or not the kernel does. Change the help text to
> > try and clarify whether or not an option affects just the kernel, or
> > also userspace. None of these options actually control whether or not an
> > extension is detected dynamically as that's done regardless of Kconfig
> > options, so drop any text that implies the option is required for
> > dynamic detection, rewording them as "do x when y is detected".
> >=20
> > Link: https://lore.kernel.org/linux-riscv/20240328-ferocity-repose-c554=
f75a676c@spud/ [1]
> > Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> > Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> > ---
> >   arch/riscv/Kconfig | 36 +++++++++++++++++++-----------------
> >   1 file changed, 19 insertions(+), 17 deletions(-)
> >=20
> > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > index b94176e25be1..3b702e6cc051 100644
> > --- a/arch/riscv/Kconfig
> > +++ b/arch/riscv/Kconfig
> > @@ -501,7 +501,8 @@ config RISCV_ISA_C
> >   	help
> >   	  Adds "C" to the ISA subsets that the toolchain is allowed to emit
> >   	  when building Linux, which results in compressed instructions in t=
he
> > -	  Linux binary.
> > +	  Linux binary. This option produces a kernel that will not run on
> > +	  systems that do not support compressed instructions.
> >   	  If you don't know what to do here, say Y.
> > @@ -511,8 +512,8 @@ config RISCV_ISA_SVNAPOT
> >   	depends on RISCV_ALTERNATIVE
> >   	default y
> >   	help
> > -	  Allow kernel to detect the Svnapot ISA-extension dynamically at boot
> > -	  time and enable its usage.
> > +	  Add support for the Svnapot ISA-extension in the kernel when it
> > +	  is detected at boot.
>=20
>=20
> To me, the new version makes things even more confusing: svnapot mappings
> will indeed be handled by the kernel (since only the kernel sets up the p=
age
> tables) but it will only be used (for now) for HugeTLB mappings in
> userspace.

How would you suggest that I word it? "Enable the use of the Svnapot
ISA-extension when it is detected at boot"? The current text implies that
these options control detection of extensions (which they do not) and
that is what I am looking to remove as it has caused confusion.

--ufpfARkzjihwFYJ8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZlbtRgAKCRB4tDGHoIJi
0qRDAQCWy/SRBWv+pbbkpLOchCFKbDcNZQYKkbilBF83QCBRgQEAsLJNQ3h2WnQO
MVK+RXQe2Hmh41W45EEunlXhnJeWqQI=
=3yN1
-----END PGP SIGNATURE-----

--ufpfARkzjihwFYJ8--

