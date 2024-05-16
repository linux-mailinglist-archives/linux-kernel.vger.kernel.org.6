Return-Path: <linux-kernel+bounces-180679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22A1D8C71AC
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 08:38:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC93F28229D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 06:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 363F92C697;
	Thu, 16 May 2024 06:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="L5EdT7ge"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 066CA2C1A3
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 06:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715841483; cv=none; b=NE4T2YAZHbZKkvBVtbCG35ulfa4FAhQ/aMnyb+daCah08+DqGAkgFWoAR1oLQLjM2VS5RtOlXQAiK8IWR1OzY7o7G55d5Vsyf6L9WiSgwcoXV3rm4BW3RqrcGeDj2cWw5AxdZ+3D6Uo+KgGJDYMmclu8w91MW8ejSRxX7y1Wyvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715841483; c=relaxed/simple;
	bh=9IbxgxangNBjD9bGDiYx5CbaIdSHkDnezGEsV/4dPXk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sUy8RARFeUbCWKOZisfL4P1HSiET/+tf66fDt9+8v6U1ZoLNrNbrmQfQciDdgEoLsNDI7S94HpMcgmnxuuhYRETnoDJbC5OTQ4EMWnxRdTJ/2KcnxcQKW5vJcUQvFzCpTMNV1reFuec+57aDDXlPlNerdac6K2ckQAfCYHR/A2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=L5EdT7ge; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1715841480; x=1747377480;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9IbxgxangNBjD9bGDiYx5CbaIdSHkDnezGEsV/4dPXk=;
  b=L5EdT7gebjnISrmUwaHQZjqBRoP1HZ1m5hZGh3610qiBciVDNiN6EhiS
   EtHWa+9Z7PoMp5pWzzUUoOQUpHGLIKlTifjjJmHpafcgJsTTQ/J08IOGF
   KuYSxVK1Ntj/Sw1BlRFIGWdE3ih2ngqBO3l/EH/eq/bSVA23XGEZV+b55
   Si7P5RtZQ/dLtwS+snVKbU6uKOstjr1sr77fefz148l3F5yHENJHNIILq
   wx+t0Cvl+z5jyBeuQxeboSaZ6pIYo1+9IQx+dmUxXGb2dvo7s5QXPlijH
   OEQTAqFhYg78my+PbpgXwCKBURGJuX0omgJ1LM/SrsrjpIDGXY7/snMv3
   g==;
X-CSE-ConnectionGUID: qGyYzRZvQFOwTFEAoDhGCQ==
X-CSE-MsgGUID: fF4CylFhTS+np7Tk6xNJgg==
X-IronPort-AV: E=Sophos;i="6.08,163,1712646000"; 
   d="asc'?scan'208";a="192311659"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 May 2024 23:37:59 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 15 May 2024 23:37:54 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex02.mchp-main.com (10.10.85.144)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Wed, 15 May 2024 23:37:52 -0700
Date: Thu, 16 May 2024 07:37:38 +0100
From: Conor Dooley <conor.dooley@microchip.com>
To: Charlie Jenkins <charlie@rivosinc.com>
CC: Conor Dooley <conor@kernel.org>, <linux-riscv@lists.infradead.org>,
	<xiao.w.wang@intel.com>, Andrew Jones <ajones@ventanamicro.com>,
	<pulehui@huawei.com>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer
 Dabbelt <palmer@dabbelt.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] RISC-V: separate Zbb optimisations requiring and not
 requiring toolchain support
Message-ID: <20240516-daybreak-keenness-95f165d98ca1@wendy>
References: <20240515-hedging-passage-44fd394ab1be@spud>
 <ZkWSioeSHh8p3pxM@ghost>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="I6CAVCoCeGlCV3zX"
Content-Disposition: inline
In-Reply-To: <ZkWSioeSHh8p3pxM@ghost>

--I6CAVCoCeGlCV3zX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 15, 2024 at 09:58:50PM -0700, Charlie Jenkins wrote:
> On Wed, May 15, 2024 at 04:27:40PM +0100, Conor Dooley wrote:

> > diff --git a/arch/riscv/lib/strlen.S b/arch/riscv/lib/strlen.S
> > index 8ae3064e45ff..3ab1310a7b83 100644
> > --- a/arch/riscv/lib/strlen.S
> > +++ b/arch/riscv/lib/strlen.S
> > @@ -8,7 +8,7 @@
> >  /* int strlen(const char *s) */
> >  SYM_FUNC_START(strlen)
> > =20
> > -	ALTERNATIVE("nop", "j strlen_zbb", 0, RISCV_ISA_EXT_ZBB, CONFIG_RISCV=
_ISA_ZBB)
> > +	ALTERNATIVE("nop", "j strlen_zbb", 0, RISCV_ISA_EXT_ZBB, CONFIG_RISCV=
_ISA_ZBB_ALT)

> I am missing why these str functions are changed to use
> CONFIG_RISCV_ISA_ZBB_ALT when the __arch_hweight* functions were left as
> using CONFIG_RISCV_ISA_ZBB in their alternatives.

I don't think I missed anything in the __arch_hweight*() functions,
their final argument is 1 and they are not conditional on a config
option as the whole block of code they're in is wrapped in ifdeffery:

# ifdef CONFIG_RISCV_ISA_ZBB_ALT
	asm goto(ALTERNATIVE("j %l[legacy]", "nop", 0,
				      RISCV_ISA_EXT_ZBB, 1)
			  : : : : legacy);

Cheers,
Conor.

--I6CAVCoCeGlCV3zX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZkWprwAKCRB4tDGHoIJi
0j+VAP9FBdovBIV1EfkfOq2ItigNKUkCb9ju651I7qWvhIV3yAD/Wxx+umEj3IGD
YZjVYKJFMMJsW+EeEb/sKCTEv5p0MQk=
=8Ddb
-----END PGP SIGNATURE-----

--I6CAVCoCeGlCV3zX--

