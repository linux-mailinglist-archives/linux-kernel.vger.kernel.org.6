Return-Path: <linux-kernel+bounces-180806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01A7A8C7358
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 11:00:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2034E1C22945
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 09:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5C0A37142;
	Thu, 16 May 2024 09:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="v8IaGF1P"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71AD62D054
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 09:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715850016; cv=none; b=DLve8Wqv0Az5OTMzuTb2eNM6g3meAj9uUmqzC9afeKKWkj7JilVhs9XbLrpSSV28Biw543fdzvVLpdujxanDoy7IYhWyzxH25LcXF9gC5wHsLJ88V9RGMLgj+Z8nvv2kDDdH6QjQquxz5nVcTntv3yX6dgTUNVGzOthfLVZuIts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715850016; c=relaxed/simple;
	bh=DoekEA5xBBqpthARG5DKlf+VJobDj/Eoe+rOBWUFrbg=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X0Kh//Bf7Yi01vKykWA0hezajKDlhNty1VjqhHhLobY8piTHOaW/IDPujmdyp/SeKSgNlSAjczM8jU49Qg+6gMTsIPQWTpWt1hrfoQbMMXyGxtatT8kMJ1EfWW6kHoA++49PKFTVAoeby9cxn0ZFX4DvZUxNm38dJQbdXgDnBus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=v8IaGF1P; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1715850014; x=1747386014;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DoekEA5xBBqpthARG5DKlf+VJobDj/Eoe+rOBWUFrbg=;
  b=v8IaGF1P4lUTW2y+3Dt/6o1RK5EttzAzToypEkAm9BZJLPkD28zlpBR0
   F93IYAb5FflhcE4mITFe8aXnXqmnohJ1qq2GGklh6xxN6m7GwSXHEBEkC
   7hiPlEXYUrILQ2HWjtr546i7GQvmO4TdLTDdC+ltpL7AlXcjFnCZZNrdb
   aFe77fcLNjPcqRTaimEgyVgprnvkpvCsyi/hIwyvNjXg3gZwbNX97pz0+
   5WyMb/oYrzAOCHL2D/0V1I4EFVZQnq9x8mVmyQvs9Lg7AnqH70fyH3so4
   p8QG+X4lc8qzS5rXjyCzEbq76EtW5r7Uhhs30/ybYR219eo91VMkDI5Mu
   A==;
X-CSE-ConnectionGUID: 44sAXBHNQGSSIAoZ8s+36g==
X-CSE-MsgGUID: X+ZakUmORtWSOstulPdrVg==
X-IronPort-AV: E=Sophos;i="6.08,164,1712646000"; 
   d="asc'?scan'208";a="255817437"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 May 2024 02:00:07 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 16 May 2024 02:00:00 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex03.mchp-main.com (10.10.85.151)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Thu, 16 May 2024 01:59:58 -0700
Date: Thu, 16 May 2024 09:59:44 +0100
From: Conor Dooley <conor.dooley@microchip.com>
To: Andrew Jones <ajones@ventanamicro.com>
CC: Conor Dooley <conor@kernel.org>, <linux-riscv@lists.infradead.org>,
	<xiao.w.wang@intel.com>, <pulehui@huawei.com>, Charlie Jenkins
	<charlie@rivosinc.com>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer
 Dabbelt <palmer@dabbelt.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] RISC-V: separate Zbb optimisations requiring and not
 requiring toolchain support
Message-ID: <20240516-speller-target-d453ad060486@wendy>
References: <20240515-hedging-passage-44fd394ab1be@spud>
 <20240516-7ff4001c9f2edd2a61775244@orel>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="imfjeleD6eCBdD1o"
Content-Disposition: inline
In-Reply-To: <20240516-7ff4001c9f2edd2a61775244@orel>

--imfjeleD6eCBdD1o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 16, 2024 at 09:59:44AM +0200, Andrew Jones wrote:
> On Wed, May 15, 2024 at 04:27:40PM GMT, Conor Dooley wrote:
>=20
> So the new hidden config is a shorthand for
>=20
> #if defined(CONFIG_RISCV_ISA_ZBB) && \
>     defined(CONFIG_TOOLCHAIN_HAS_ZBB) && \
>     defined(CONFIG_RISCV_ALTERNATIVE)
>=20
> which is reasonable to add, since that's a mouthful, but I'm not sure the
> name, RISCV_ISA_ZBB_ALT, does a good job conveying all that.
>=20
> If we instead just dropped the 'depends on TOOLCHAIN_HAS_ZBB' from
> config RISCV_ISA_ZBB (keeping the 'depends on RISCV_ALTERNATIVE',
> since nobody is really complaining about that), then we could change
> this to
>=20
> #if defined(CONFIG_RISCV_ISA_ZBB) && defined(CONFIG_TOOLCHAIN_HAS_ZBB)

Yeah, I think this is a cleaner solution.

> >  	asm goto(ALTERNATIVE("j %l[legacy]", "nop", 0,
> >  				      RISCV_ISA_EXT_ZBB, 1)
> >  			  : : : : legacy);
> > diff --git a/arch/riscv/include/asm/bitops.h b/arch/riscv/include/asm/b=
itops.h
> > index 880606b0469a..3ed810a6123d 100644
> > --- a/arch/riscv/include/asm/bitops.h
> > +++ b/arch/riscv/include/asm/bitops.h
> > @@ -15,7 +15,7 @@
> >  #include <asm/barrier.h>
> >  #include <asm/bitsperlong.h>
> > =20
> > -#if !defined(CONFIG_RISCV_ISA_ZBB) || defined(NO_ALTERNATIVE)
> > +#if !defined(CONFIG_RISCV_ISA_ZBB_ALT) || defined(NO_ALTERNATIVE)
>=20
> nit: It's sufficient to check !defined(CONFIG_RISCV_ISA_ZBB), so no need
> for this change or its #endif comment change below.

Are you sure? I did test leaving this as-was and it broke the build for
llvm-14.

Cheers,
Conor.

--imfjeleD6eCBdD1o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZkXLAAAKCRB4tDGHoIJi
0mdCAP4k64AOQkHw9Y2P4/kfHnxYOv6lwItSSqAKWjUhGXo68wD+OKcRKjtDJPM7
SRUdK3yi9L9Fr7Anrbe3LVNbURswiQU=
=o+IN
-----END PGP SIGNATURE-----

--imfjeleD6eCBdD1o--

