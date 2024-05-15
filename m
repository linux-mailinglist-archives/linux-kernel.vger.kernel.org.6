Return-Path: <linux-kernel+bounces-179578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4BE18C619E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 09:24:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60AF01F21510
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 07:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7CE54A9B0;
	Wed, 15 May 2024 07:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="znL/rNIC"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01DE157333;
	Wed, 15 May 2024 07:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715757726; cv=none; b=E+TA5sGeNH5xmqadQozLVypxGf8ncmVTsyV0TYxAWJ1QQlJzuhVSUGjZrOiinrDhNBkC6wlHqyt/0c9VJe5AVgXC12d6NJmmsykhWGbmpXLpx43NAcOeb/szN/MAoavvd7Jyf/vFeEHhg6D7VN/WAkRZPY1FBVfSmQ4W1jIgLT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715757726; c=relaxed/simple;
	bh=8rUH+otL33JPl6/eelDW+giyktscV7EVUM1KV0wegvg=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g7KYT2xbwauQyhlwiZqYD7UNQf1+BBLr7k8mdBD61PKGLxXNI1xEiwqhNoibF0x40uJ/trvEmvzrCA5uvojNhEanWUU9Q24IcIKcNnf6zneguA8UP6HpILplNqEjBQf5eOUnfMvXD4B0U+C/2mlIVFXb9vpg5fnonU9X4SMZNQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=znL/rNIC; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1715757724; x=1747293724;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8rUH+otL33JPl6/eelDW+giyktscV7EVUM1KV0wegvg=;
  b=znL/rNICLhUDzQYwEdv7R8UUShWnMxvgPb/o+5JtqLvfufK9lbrwOm6O
   U3CFZKljz64+B5ib//+3R7axkuJgcWTNsWDs+9ueOycMUlN87WKjHo6ZC
   6H++ZWXZf07smn6bsrpoQrgZnlSi82x80XU0UaeHz4F8pLvBIxxKDGgjx
   3A/55kolpGiw4/zzH/YS/MiBtyU5qOF4x5RkTxJxlh4PS88P4PJLWKlp2
   E3tJEhewU7nUPY2kELqgMtw3p6XmV3Faa0YMmhEAMgQjVqzFPCnG/8OmM
   ha/wIobXbY7ehfyH3s6BX0ROroDNW8rEGBg0123j2uJ2O1lAVdWdU0nWX
   w==;
X-CSE-ConnectionGUID: xh7729e8TEGmLa/d6tPEtQ==
X-CSE-MsgGUID: 4h9UeB2TTpyZiPvvgQObqg==
X-IronPort-AV: E=Sophos;i="6.08,161,1712646000"; 
   d="asc'?scan'208";a="255637101"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 May 2024 00:22:03 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 15 May 2024 00:21:30 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex02.mchp-main.com (10.10.85.144)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Wed, 15 May 2024 00:21:28 -0700
Date: Wed, 15 May 2024 08:21:14 +0100
From: Conor Dooley <conor.dooley@microchip.com>
To: Joshua Yeong <joshua.yeong@starfivetech.com>
CC: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<conor@kernel.org>, <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
	<aou@eecs.berkeley.edu>, <leyfoon.tan@starfivetech.com>,
	<jeeheng.sia@starfivetech.com>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH v4 0/2 RESEND] Add StarFive's StarLink Cache Controller
Message-ID: <20240515-denture-matriarch-c775324379e5@wendy>
References: <20240515050253.38061-1-joshua.yeong@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Fy8jGRKT4POCemEl"
Content-Disposition: inline
In-Reply-To: <20240515050253.38061-1-joshua.yeong@starfivetech.com>

--Fy8jGRKT4POCemEl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 15, 2024 at 01:02:51PM +0800, Joshua Yeong wrote:
> StarFive's StarLink Cache Controller flush/invalidates cache using non-
> conventional RISC-V Zicbom extension instructions. This driver provides t=
he
> cache handling on StarFive RISC-V SoC.
>=20
> Changes in v4:
> - Move cache controller initialization to arch_initcall()
> - Link to v3: https://lore.kernel.org/all/20240424075856.145850-1-joshua.=
yeong@starfivetech.com/

Why are you resending this? A resend with no context doesn't help me
understand what you want done.
There's been no action taken yet with the v4 that you had sent because
there was not enough time between its arrival and when I had to send a
PR with 6.10 material. Right now it is the merge window, so there's
nothing that can be done here til that ends.

Cheers,
Conor.

--Fy8jGRKT4POCemEl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZkRiagAKCRB4tDGHoIJi
0omXAP9pIXYi4n5B7Ijb7oNal5DySb2TUY6bM7EGDeulPWO70gEA3Yt4/qVY17Q/
pqEiBG0Ji10JgU4wA+T6k4C4ckqfEwc=
=ZhD4
-----END PGP SIGNATURE-----

--Fy8jGRKT4POCemEl--

