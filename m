Return-Path: <linux-kernel+bounces-544616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E1F6A4E40A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 16:47:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E19C13BE86C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 15:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49AA5283CA6;
	Tue,  4 Mar 2025 15:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="1ORyGz++"
Received: from beeline3.cc.itu.edu.tr (beeline3.cc.itu.edu.tr [160.75.25.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D730A283C89
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 15:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=160.75.25.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741101160; cv=pass; b=u+/EAYDVamI6o2SwcsnTp0vCtaA8IPRbHSRwbXqKBQXy1pzWsl9oeCNU3kqSnqZc3I3LbkNymDYssaQvP2iyfanetxwhBKdIyERP6LsEe1Lbm/bhKcx2yAgu38b6HrVUcZodk5Nl77ee3/NnQzn2v6LWVr6whw6rmXK9grJVBM8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741101160; c=relaxed/simple;
	bh=eLPVTYCLr/v+z3Rpfjq9386InLTsMCaOhJxCahwa3fE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tF+Na/aJhUqPyX6ho78pN7aXqYjZXLbagUb6woUdi3R2JKgHfeBdm8o/VzCOIMmMDpss9vw6iOf5pO0ZXDoYtaJxCRdZPVCqiKzTQstAoY4edzPGaXmiBWD7BlKdu9JWZDq0elmu4J8GspGgirmZlZHgyw3rIBUh+uo0GgqTw2s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=none smtp.mailfrom=cc.itu.edu.tr; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=1ORyGz++; arc=none smtp.client-ip=68.232.154.123; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; arc=pass smtp.client-ip=160.75.25.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (lesvatest1.cc.itu.edu.tr [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline3.cc.itu.edu.tr (Postfix) with ESMTPS id 1856540CF12F
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 18:12:37 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Authentication-Results: lesvatest1.cc.itu.edu.tr;
	dkim=pass (2048-bit key, unprotected) header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=1ORyGz++
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6fHy6WTxzFyZb
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 18:10:22 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id B86914273C; Tue,  4 Mar 2025 18:10:19 +0300 (+03)
Authentication-Results: lesva1.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=1ORyGz++
X-Envelope-From: <linux-kernel+bounces-541240-bozkiru=itu.edu.tr@vger.kernel.org>
Authentication-Results: lesva2.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=1ORyGz++
Received: from fgw1.itu.edu.tr (fgw1.itu.edu.tr [160.75.25.103])
	by le2 (Postfix) with ESMTP id 5818341BD0
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 12:10:06 +0300 (+03)
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by fgw1.itu.edu.tr (Postfix) with SMTP id 30D443063EFC
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 12:10:06 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA5A21891680
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 09:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F21EB1F0E54;
	Mon,  3 Mar 2025 09:09:30 +0000 (UTC)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C25C1F09A8;
	Mon,  3 Mar 2025 09:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740992968; cv=none; b=hSkDWBu/9WMHcUm+Uvc26wsH8ge1hisAD5vuPVCHlRYGUvJb4HlofMoYdEs0ORD2hOEfb5JfNDR2Dy7WxzCLK+rM2EoQrRecC1F2bATsPqGG7y3dN54Z1p2wGvIEjn7yRHkjAnu4hp2WKfcyv5eiJ6Ar92p5E60Vp9d/5YKAzGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740992968; c=relaxed/simple;
	bh=eLPVTYCLr/v+z3Rpfjq9386InLTsMCaOhJxCahwa3fE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vC3Hh2T1EcHM2OTXDwvG+uWpNSgT0Dq39nZaBir1H6qDCgTnA+WiUC/Y9d6FYcE182HgwN7S4RvTEPd+gJKPXjJ5OF5BpTgHLqJj1TrdTItYSpTRzmanZiswiNtsRFtqOYwUwFB+EcnJnlFBxJ1/E/oI+MGUuQKfAz6Ljl7qkjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=1ORyGz++; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1740992966; x=1772528966;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eLPVTYCLr/v+z3Rpfjq9386InLTsMCaOhJxCahwa3fE=;
  b=1ORyGz++BGcPpsBaNrjBX6oYxf1PMx5yWTVExleoTj5SdvKjSPAwkgp7
   afOHMT/ieCCyc+GOJVhcydpyHgVy2v9zsKBOX9uvCNl90T8MqDcNdmhdl
   kBly+DwmTmqbsfgyJRhMHTzCAzzkvvb2kOcE+ilcUNOMtiOEQtWUozTw4
   SQxpuL+6x7wYNo8rToK47nZnknn840oqgY5rBxZSFIZl1xYl23rk1Xs5N
   IeRrXAV77WLgdDHO44yKcl1BX7131mLj1kU99CEsulwYsOMLIVgRk9sQa
   V4OnC1yjMkLMmMdJ2za1G1Sq0otS3NCQB06CnvOx1Ilo9zQZAt3wuBl+N
   A==;
X-CSE-ConnectionGUID: vdV2+gEUTw2O2FxCKkKLiw==
X-CSE-MsgGUID: bSWdOAdmQv+RmLfY7KSCNA==
X-IronPort-AV: E=Sophos;i="6.13,329,1732604400"; 
   d="asc'?scan'208";a="38764365"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 Mar 2025 02:09:20 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 3 Mar 2025 02:09:14 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex02.mchp-main.com (10.10.85.144)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Mon, 3 Mar 2025 02:09:11 -0700
Date: Mon, 3 Mar 2025 09:08:16 +0000
From: Conor Dooley <conor.dooley@microchip.com>
To: Chen Wang <unicorn_wang@outlook.com>
CC: Conor Dooley <conor@kernel.org>, Zixian Zeng <sycamoremoon376@gmail.com>,
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
	Inochi Amaoto <inochiama@outlook.com>, Alexandre Ghiti <alex@ghiti.fr>,
	<devicetree@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <sophgo@lists.linux.dev>,
	<chao.wei@sophgo.com>, <xiaoguang.xing@sophgo.com>
Subject: Re: [PATCH v2] riscv: sophgo: dts: Add spi controller for SG2042
Message-ID: <20250303-recital-crunchy-6f7806987da0@wendy>
References: <20250228-sfg-spi-v2-1-8bbf23b85d0e@gmail.com>
 <20250228-factual-rage-0e1e1e48b009@spud>
 <PN0PR01MB103937D1C23820E0FC43BEA33FECF2@PN0PR01MB10393.INDPRD01.PROD.OUTLOOK.COM>
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Ow63fKL/6QkVXSRs"
Content-Disposition: inline
In-Reply-To: <PN0PR01MB103937D1C23820E0FC43BEA33FECF2@PN0PR01MB10393.INDPRD01.PROD.OUTLOOK.COM>
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6fHy6WTxzFyZb
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741705831.53943@CuDXe3KY5w/G5QwMN76r1w
X-ITU-MailScanner-SpamCheck: not spam

--Ow63fKL/6QkVXSRs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 01, 2025 at 09:58:24AM +0800, Chen Wang wrote:
>=20
> On 2025/3/1 2:22, Conor Dooley wrote:
> [......]
> > > +
> > > +		spi0: spi@7040004000 {
> > > +			compatible =3D "snps,dw-apb-ssi";
> > I thought were were dropping the use of "snps,dw-abp-ssi" in isolation,
> > and starting to require soc-specific compatibles now.
> >=20
> > Rob, Krzysztof?
> I'm also very interested to know why we can't just use "snps,dw-abp-ssi",
> maybe I missed some discussion ...

Ordinarily you're not allowed to use generic compatibles at all, the
dw stuff has kinda been an ?unofficial? exception for a while and not
just for spi. I think that "exception" has been withdrawn though, and
dw stuff is being brought in line with everything else, but cannot
remember where that started.

> I googled examples of soc-specific defined in the code, and it doesn't se=
em
> to be much, only arch/mips/boot/dts/mscc/ocelot.dtsi and
> arch/riscv/boot/dts/thead/th1520.dtsi.

> Specially, I looked at the commits for th1520 and saw this https://lore.k=
ernel.org/linux-riscv/20240703-garbage-explicit-bd95f8deb716@wendy/.
> It tells if the fallback works identically, then the specific compatible =
is
> not needed.

This link is talking about the driver, not the dts/binding. Adding the
device-specific compatible to the driver is only needed if the specific
one has some extra features above and beyond the compatible used as the
fallback.

Cheers,
Conor.

--Ow63fKL/6QkVXSRs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ8VxcwAKCRB4tDGHoIJi
0lX/AQDJBY3641IPRBtubqSLaUcbCrjzlLFp3F9Lw+Wi6rDPSAEA8dXwvoY2dJWS
Vy+cEBykB0x0CsyGnioS7rl+yMdBqwk=
=upyW
-----END PGP SIGNATURE-----

--Ow63fKL/6QkVXSRs--


