Return-Path: <linux-kernel+bounces-321333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C98789718E5
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 14:03:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72C461F23D61
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 12:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8674B1B3B11;
	Mon,  9 Sep 2024 12:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="E9GNjMEU"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3FC1531E0
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 12:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725883429; cv=none; b=RhyOQaPkSbaTasFs1LkR3H50qRBYu8AJfF9JUGJCdOorzlpCQ4Td5aNlPVHeFJyy0eGltjOvUVn/yq4uEO0AgViLKj5o+yCqAtzIK0FYhROBdskXdS0AceDAXFpkTWjlqV8G1Gm4iL9UG5K7hzqt0Zb2tssJGmF7rIecHKTtT9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725883429; c=relaxed/simple;
	bh=WKLVagKCvlej+Nkegj3NsrqkHP2IAw9hMia5vdAaZ7w=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QuWwrE6E4d7GnECyTyoi/BwoK/vuSIyeKBkup3DCb7lkwW33zYzJ8BkuiHiQQVx6l9RdE5uG27HHU3Oj4Hszoj5uV92Q1+R7KI+agj7Mv4TUSmnE2yHTNZjG9e7e5lx6oEWMG7A09wkPE2uMtZcdoYeLTSMhY0z3UtFixvYbySg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=E9GNjMEU; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1725883426; x=1757419426;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WKLVagKCvlej+Nkegj3NsrqkHP2IAw9hMia5vdAaZ7w=;
  b=E9GNjMEUoawgnyZzuaCzS5rc8YaFxL4X7V/by7uKMburqrshMRuW87r8
   dLuws0dkTW1MiBAGkGF+XPrl8Tz6KydwVp0rNp88NFNS9E79ZfYt8kKqw
   zsHgx9GOjt7j5ng1uF/omvtJwXgaSllGSns0yXEW6pSPcYNtlbkYltMo1
   7cqhbtNqvEnWYmFcKwOhu64XUyot2LOYB5S4lLU8CKWMo6ibKZ3hwFY8b
   7s5vaqKCehtqRqwCtco14VnjDqG/Uu5CTmNsiRE3xHJNB6ZOk1+37N3JI
   wRVrYEMwUkN3tK5fDDzI6rw3s/QO0/ZdNjCq53NJUyRzbA08hRSAMShue
   g==;
X-CSE-ConnectionGUID: G/qWnvzMSiGL2qspbnG2OA==
X-CSE-MsgGUID: X1ZbZu1KSaKuryA37AoB+g==
X-IronPort-AV: E=Sophos;i="6.10,214,1719903600"; 
   d="asc'?scan'208";a="198946972"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Sep 2024 05:03:45 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 9 Sep 2024 05:03:32 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex04.mchp-main.com (10.10.85.152)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Mon, 9 Sep 2024 05:03:30 -0700
Date: Mon, 9 Sep 2024 13:02:57 +0100
From: Conor Dooley <conor.dooley@microchip.com>
To: Inochi Amaoto <inochiama@outlook.com>
CC: Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
	<palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Guo Ren
	<guoren@kernel.org>, Emil Renner Berthing
	<emil.renner.berthing@canonical.com>, Lad Prabhakar
	<prabhakar.mahadev-lad.rj@bp.renesas.com>, Sunil V L
	<sunilvl@ventanamicro.com>, Anup Patel <apatel@ventanamicro.com>, Hal Feng
	<hal.feng@starfivetech.com>, <linux-riscv@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] riscv: defconfig: Enable pinctrl support for CV18XX
 Series SoC
Message-ID: <20240909-outsell-duh-8b7c3111be9a@wendy>
References: <IA1PR20MB4953FF3C0CA0B51962DBE892BB972@IA1PR20MB4953.namprd20.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="r5oDv1O1gOAd5s8U"
Content-Disposition: inline
In-Reply-To: <IA1PR20MB4953FF3C0CA0B51962DBE892BB972@IA1PR20MB4953.namprd20.prod.outlook.com>

--r5oDv1O1gOAd5s8U
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 30, 2024 at 04:57:38PM +0800, Inochi Amaoto wrote:
> Enable pinctrl driver for the whole CV18XX series.
>=20
> Signed-off-by: Inochi Amaoto <inochiama@outlook.com>

I've applied this one, I'll send it out to Arnd once it's been in
linux-next.

Cheers,
Conor.

--r5oDv1O1gOAd5s8U
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZt7j8QAKCRB4tDGHoIJi
0ue3AP0QNhBOpyi72GYzMwq1kpiYhmwZcXEMdnOls7RX5lU8mAEAv9P0PhlCvZIW
7GmjYyy8jZ+FYhDxjD2h6Kfa4/qYtAo=
=1B8s
-----END PGP SIGNATURE-----

--r5oDv1O1gOAd5s8U--

