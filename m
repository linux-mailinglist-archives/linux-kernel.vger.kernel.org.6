Return-Path: <linux-kernel+bounces-218719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 38E5090C49D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 09:53:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8664AB21C5E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 07:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ED0213E025;
	Tue, 18 Jun 2024 06:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="K96M58I3"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DABB013C9B3;
	Tue, 18 Jun 2024 06:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718693969; cv=none; b=gRCXde3csUJyJ2XuRGMGctb9DCLq9h37820xwzedJ/3SoubihXChHedLpaBNraAWnObbgxUBHPcE17H3gAZSuNUg3LF0jpg7AtOHQbdqCfeAsuLZolhAAW+P6MLMxqIuf8vUptUTXxO+9m/WUQO+FyKTs4dksx1hXuT3xs5XqjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718693969; c=relaxed/simple;
	bh=3mK4TsHTIPeZapcY9c5aW4prx8bcHLdsxmGHIyRcCK0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KOm1ktj7CPAdN5bzxAluOJ1KK3oxX5tZUUG1GB/fggpezJTN/h6sIHMMiycXgG4/P0FrzUfzqSRw9BakqUEQecnchWUxS7v0ty1FhwKWiu9d1KT7lYkjFPkF7UuyBugGIXwMy24f7c7mMKP39QyUzxsxI/fr/3rdBxec8b1rMS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=K96M58I3; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1718693967; x=1750229967;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3mK4TsHTIPeZapcY9c5aW4prx8bcHLdsxmGHIyRcCK0=;
  b=K96M58I3v8riDvnkD3mT3oqLPIFVbrDfcWwFwN/u8KPp4K01qd3UgaJn
   1J5eD56irh7RTfGiCWKSMUaK8C+IJmIUv5jaWAnxxoI/gHQAD7G/0LMxm
   1bU89C4mJhxt6irG9MLJDBSSPPH4zsG2RY3rmXsUHMhaRsSM1S/C62MkW
   vJQQFTeOTZfzC0txsprMZd34Aogn6GyfqlGAxVuhWQZuzQYKWCZ0CFlxg
   mQ8R0IHD/HN2uYZcErVHIt0qSgMCzZaj9vjzA3Unvw6xRzNJsFWnpv7q6
   wI/m/v/fmiF5euhf4m63CxjJX2TVwYb1biWSEE8C8NQIdpANdiad/swa9
   A==;
X-CSE-ConnectionGUID: z9K4V9M6RvG3elklgVnlnw==
X-CSE-MsgGUID: /nE/O9yjS8y1iiBhZ+9ZHA==
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="asc'?scan'208";a="258886760"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Jun 2024 23:59:26 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 17 Jun 2024 23:59:10 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex02.mchp-main.com (10.10.85.144)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Mon, 17 Jun 2024 23:59:07 -0700
Date: Tue, 18 Jun 2024 07:58:49 +0100
From: Conor Dooley <conor.dooley@microchip.com>
To: Yangyu Chen <cyy@cyyself.name>
CC: Conor Dooley <conor@kernel.org>, Jisheng Zhang <jszhang@kernel.org>, Yixun
 Lan <dlan@gentoo.org>, <linux-riscv@lists.infradead.org>, Conor Dooley
	<conor+dt@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley
	<paul.walmsley@sifive.com>, Samuel Holland <samuel.holland@sifive.com>, Anup
 Patel <anup.patel@wdc.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, <devicetree@vger.kernel.org>, Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>, Jesse Taube <jesse@rivosinc.com>
Subject: Re: [PATCH v1 0/9] riscv: add initial support for SpacemiT K1
Message-ID: <20240618-pacifism-defendant-2a042a7fe1b9@wendy>
References: <tencent_BC64B7B1876F5D10479BD19112F73F262505@qq.com>
 <20240616-exorcism-computing-e11e26084a62@spud>
 <20240616224811.GC3983622@ofsar>
 <ZnBEBQjTQtFs-fXt@xhacker>
 <20240617-synapse-carmaker-0a59c7c6edb7@spud>
 <tencent_26E7381EE1F6C5188428359AF3F908CA680A@qq.com>
 <20240617-connected-avoid-82f0bdc05cdf@spud>
 <tencent_53226D39C76ADCAA1883109DC6213E5EC107@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="YwBUjE9FTTi9maDS"
Content-Disposition: inline
In-Reply-To: <tencent_53226D39C76ADCAA1883109DC6213E5EC107@qq.com>

--YwBUjE9FTTi9maDS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 18, 2024 at 01:42:34AM +0800, Yangyu Chen wrote:
>=20
>=20
> > On Jun 18, 2024, at 01:14, Conor Dooley <conor@kernel.org> wrote:
> >=20
> > On Tue, Jun 18, 2024 at 12:39:30AM +0800, Yangyu Chen wrote:
> >>=20
> >> The vendor uses a special intel pxa uart driver, marked deprecated
> >> in the kernel and incompatible with ns16550. If we use ns16550 in
> >> the dt, the behavior of uart is like the uart has no interrupt and
> >> stops working permanently when fifo overruns, making many developers
> >> not know how to start unless they use the SBI HVC console, which
> >> needs to turn on CONFIG_NONPORTABLE.
> >=20
> > This I just do not understand. Why did they use this IP? Is it free?
> > Did they use it before for something else? It's a rather strange design
> > choice to me.
>=20
> I don't know either. However, PXA is a subfamily of XScale. The
> kernel also probed the UART as an XScale. So, using XScale compatible
> string is OK.

Using a fallback to an Xscale compatible is okay, FTFY ;)

--YwBUjE9FTTi9maDS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZnEwHAAKCRB4tDGHoIJi
0to+AP9w3gnQ362y8MnFZcbfQCKFvkpQBLoqodJyHtdQJpq/GAEA0V0/yvJzPuS8
8hGxhLKG89Dg+3IulVD5SK6iFT5/EAU=
=QSkx
-----END PGP SIGNATURE-----

--YwBUjE9FTTi9maDS--

