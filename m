Return-Path: <linux-kernel+bounces-216835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62B4890A72E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 09:32:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00290280DB2
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 07:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8683018F2FC;
	Mon, 17 Jun 2024 07:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="IR1ru7+i"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29616E554;
	Mon, 17 Jun 2024 07:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718609516; cv=none; b=sD7BNH1FkrDikUbwm/7a8b8Hal29lCg3/Uz9aU2HJtUH/XOLU+l6R1Nym7RksK1ezwI1uk91cSKIhabrggtw4XOQ8/6xKPOgzHhdcLD07YWCjbkgPwaifUrVRzK0zHIBl5uaxok3G6U7MXbFutEQFic5jPQy9I9aLmD6kdYciL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718609516; c=relaxed/simple;
	bh=/SFuD9InR9+QblOhm36ftW37ZdNDPCvj1CPIDtGPO3o=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qWyp1PQFgNEOi4ZJmJIjYhqPn0PG3LeNwbZd0M5BijRzR7ZSoKj7jW8xGqZn+g/xXlYXIYViVHSMBU268/LdCT3J9b8ucEbcjDFlX7R0hacvGknthM4YoccMxvSdg0fUj4UfLzat2QhKK5Mo5zoz46CgA2doI96c5nmw/jzSlQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=IR1ru7+i; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1718609515; x=1750145515;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/SFuD9InR9+QblOhm36ftW37ZdNDPCvj1CPIDtGPO3o=;
  b=IR1ru7+i51gz1PFbTQexoc0O0ZQOi5EzShFaP0rOk/ByO3tslW1TYVFE
   UX5GGCZhytqdmrSoF8DlXeLZ24f1oTz2M9H4kXqeYiT7VAjFuxyXgG1Cz
   mg0DvFr/PQwaUovMIIY5HGQ67XI7O5AfOr+gFkigZ/u4RR6QNuU/4KTPk
   M4GUanKeoYXkz4bi9r4Jja0VOkJONtKizp225xZAMSZckMNWjKl6UKJOd
   pNolRUTLDGF+Qd3Q1sJlMt2MbXy8VuczsShxTFZ7Cfdam5NtIOgpLyAHj
   T7MGCmrnCw7OeiBNm3HexXLLIug7GR2Ux/UMCM0kl1OtNAwtdUpFPCI5v
   A==;
X-CSE-ConnectionGUID: 0jzbtD/eTbm4vVE2ltasdQ==
X-CSE-MsgGUID: wp8sBtHDRnWLcnDDAGF3Kw==
X-IronPort-AV: E=Sophos;i="6.08,244,1712646000"; 
   d="asc'?scan'208";a="28483881"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Jun 2024 00:31:54 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 17 Jun 2024 00:31:23 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex02.mchp-main.com (10.10.85.144)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Mon, 17 Jun 2024 00:31:21 -0700
Date: Mon, 17 Jun 2024 08:31:03 +0100
From: Conor Dooley <conor.dooley@microchip.com>
To: Yixun Lan <dlan@gentoo.org>
CC: Yangyu Chen <cyy@cyyself.name>, <linux-riscv@lists.infradead.org>, Conor
 Dooley <conor+dt@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Paul
 Walmsley <paul.walmsley@sifive.com>, Samuel Holland
	<samuel.holland@sifive.com>, Anup Patel <anup.patel@wdc.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 7/9] riscv: dts: add initial SpacemiT K1 SoC device
 tree
Message-ID: <20240617-haiku-coasting-2f1cdca0ed30@wendy>
References: <tencent_BC64B7B1876F5D10479BD19112F73F262505@qq.com>
 <tencent_701082E2DAE48E2FB857316321778D737C08@qq.com>
 <20240616225314.GA3988639@ofsar>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Z64oah3OWAsjo2wQ"
Content-Disposition: inline
In-Reply-To: <20240616225314.GA3988639@ofsar>

--Z64oah3OWAsjo2wQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 16, 2024 at 10:53:14PM +0000, Yixun Lan wrote:
> On 01:20 Mon 17 Jun     , Yangyu Chen wrote:
> > Banana Pi BPI-F3 motherboard is powered by SpacemiT K1[1].
> >=20
> .. snip
> > +		uart0: serial@d4017000 {
> > +			compatible =3D "intel,xscale-uart";
> are you sure the uart IP is fully compatible with xscale?
> otherwise I'd suggest to introduce a vendor specific one..

Definitely add a soc-specific compatible here, even if fully compatible
with the xscale uart. There's a marvell device doing this already.

--Z64oah3OWAsjo2wQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZm/mNwAKCRB4tDGHoIJi
0uqJAQDNF2/7eSUIK6hC7bqxfYOJcPlPqFDqUHQacO8mrupUjgD/bJ+wVPc5a+L+
nLQwbj4t1epe50jzdz9Zbciau9Dmfgs=
=gR1T
-----END PGP SIGNATURE-----

--Z64oah3OWAsjo2wQ--

