Return-Path: <linux-kernel+bounces-232135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C803491A3F3
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 12:35:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83A7E2810AD
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 10:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE4CD13B58B;
	Thu, 27 Jun 2024 10:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="lnG9bbxy"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2C013DBBB
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 10:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719484549; cv=none; b=LeSTRcE6DojVj6e3MA2QiyD3NWxGwRPvBZDMHEtDPNB9TTwsPybMByFTXdH3pIiDpA2PiYlsi3SdsoBZW62RDvvvLuMtfFSTy69cWLlHQZCVM7itIiYqfkknN1pQhBXcHi+n5QxWl6oUQ6Dhxc0lQToCCKWiuGhQxm6+N+Abzw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719484549; c=relaxed/simple;
	bh=PT0DemCx5L/ZcJvMGNX3zxbnwOgua37LhSOsc+eGUas=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PYPEjmmeEt1wkblCsOsagIdLPKXSaQ9sIDOdnXEKO7Ak8r36XOkh7LVWICi7wDCAx1ycYpdLXaYQijTTWbqY7SX84QMV/HD+zV0lHRkzwST1boOf1+vUMy3LYjPu98VFjLnLgte6PLgxJ887M9DqyQYJ099T2aJt0RY0OzsMLqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=lnG9bbxy; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1719484548; x=1751020548;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PT0DemCx5L/ZcJvMGNX3zxbnwOgua37LhSOsc+eGUas=;
  b=lnG9bbxyK4GmoCKutVXKTlGJcfrLVe2YVeAuKzDp0yB6gizZNshRCp7X
   t5dnaKV9/cnBAdLu8UBWY1CyQvKEZ49CFcuIQL2vihwsZUlFevOY+SC0e
   RGmo/PusRKCNqIodZaq9yTr9qMwmlwSwR0naR/L9YZog521nOsIQy80fi
   NmlojwySb9H30OHU5CCm1TWb+RYHh6FoRVJkV9hQTtU3BaZcr8MoDuFSX
   nvQqLpi1JIkTXFB0WByMTUdMUBgbn00ENUcBA3i+al1icHGbX1pxTiL3m
   wANzYmGBMtX3AVfBGlst0bX30GsiBcIMnQ6rfwu//hL23rOy1zvPl9+36
   Q==;
X-CSE-ConnectionGUID: +0US9/oBS+uQ72sgXKrlTQ==
X-CSE-MsgGUID: 3UJBguS/R3mlbAbhaHQ3dw==
X-IronPort-AV: E=Sophos;i="6.08,269,1712646000"; 
   d="asc'?scan'208";a="259448239"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Jun 2024 03:35:46 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 27 Jun 2024 03:35:13 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex02.mchp-main.com (10.10.85.144)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Thu, 27 Jun 2024 03:35:09 -0700
Date: Thu, 27 Jun 2024 11:34:53 +0100
From: Conor Dooley <conor.dooley@microchip.com>
To: Jesse Taube <jesse@rivosinc.com>
CC: <linux-riscv@lists.infradead.org>, Ard Biesheuvel <ardb@kernel.org>, Paul
 Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, Alexandre Ghiti
	<alexghiti@rivosinc.com>, Masahiro Yamada <masahiroy@kernel.org>, Wende Tan
	<twd2.me@gmail.com>, Christophe JAILLET <christophe.jaillet@wanadoo.fr>, Sami
 Tolvanen <samitolvanen@google.com>, Andrew Morton
	<akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>, Chen Jiahao
	<chenjiahao16@huawei.com>, "Mike Rapoport (IBM)" <rppt@kernel.org>, "Vishal
 Moola (Oracle)" <vishal.moola@gmail.com>, <linux-kernel@vger.kernel.org>,
	<llvm@lists.linux.dev>
Subject: Re: [PATCH v2 1/3] RISC-V: pi: Force hidden visibility for all
 symbol references
Message-ID: <20240627-boring-handgun-40ae5bf2651e@wendy>
References: <20240626171652.366415-1-jesse@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="vKFCYLL3R2eTISok"
Content-Disposition: inline
In-Reply-To: <20240626171652.366415-1-jesse@rivosinc.com>

--vKFCYLL3R2eTISok
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 26, 2024 at 01:16:50PM -0400, Jesse Taube wrote:
> Eliminate all GOT entries in the .pi section, by forcing hidden
> visibility for all symbol references, which informs the compiler that
> such references will be resolved at link time without the need for
> allocating GOT entries.
>=20
> Include linux/hidden.h in Makefile, like arm64, for the
> hidden visibility attribute.
>=20
> Signed-off-by: Jesse Taube <jesse@rivosinc.com>

Did you forget to add --cover-letter to your format-patch incantation?

--vKFCYLL3R2eTISok
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZn1ATQAKCRB4tDGHoIJi
0ro5AQDUTIQAFPaxq8FMvwx+tMjLHvhpLVDKFrBTkl0J4RVnQAD+JyHcenavbWL3
JE+a1l9TQCnI/BGKBArtQn7zTJ0dMQ0=
=n7mi
-----END PGP SIGNATURE-----

--vKFCYLL3R2eTISok--

