Return-Path: <linux-kernel+bounces-214793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A3C69089FC
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 12:33:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD2F41C26A4A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 10:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CB311940AA;
	Fri, 14 Jun 2024 10:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="a1D3eZ6X"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F141D13B5AC
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 10:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718361140; cv=none; b=IFM7lF5GaBbEfJPJlu+WeOVHesvEYG2kPdyhNgF7H0Iz44Z3Zqziu0W0NdRiaW0hdMScoEY71xTtcKX+2bD6vmiMmXSYKYOdsBMDi5stwr5qs/UpmtmQwn977Y7rJePfvLONYyu4GWUBfw/W80EA6MNAyOxw35jXoTtQucvbCcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718361140; c=relaxed/simple;
	bh=CfpSNYRxPzF3eP5B/0FeJ6z/uAilyYbezSPoYSHcqWI=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qGdtnmTu8MgjHz3FcgTQhTA684pUAISgSn6GEngoGySNVx4Y0r+aNQT9WpldbxW2ICPu2v5oZofKoZlAtppDou74Bj/XzEJP2KiCkOLKiK+cssy5vIP97GPQjVqPHkoSXkQkaaNloeIDf3uMc1o/Ckrn0Q3HrQA0mCTes4bdG2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=a1D3eZ6X; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1718361139; x=1749897139;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CfpSNYRxPzF3eP5B/0FeJ6z/uAilyYbezSPoYSHcqWI=;
  b=a1D3eZ6XRytd7y+a1Gf/k49h3xNY71SpOicXuV2EqKiiWPHpHlO9RiOJ
   fEqZjU1LPhaFISqOEifCrp88q7ZGGGJnbQpwacosrOfY8+ogA6x6S51Bj
   VHFqkKByzR1r2ZFsGOMjDqj/EunLo1ucU9bvSdK/zGkaYu+YfdOfdEJFv
   B3Z2tJKHCCI1FWUOGhtKlNz1CBXleeObdTxETUsk2YXXmZXHoiCB/JSEz
   5TbRkQG1rvYj7eSJSCIV2EZFrQkTt0aqq1Y4gSlu5KZH2xs+94D0EhsD8
   QRgRyPt2RdViqYtvszdD00cklw/hM45u2A2kzsKHBdK705/B46WGKlPkT
   g==;
X-CSE-ConnectionGUID: nFBF+wvcSOK6O7fDHKZSVQ==
X-CSE-MsgGUID: F2wRbsnVRvqFmTnNJb1XtA==
X-IronPort-AV: E=Sophos;i="6.08,237,1712646000"; 
   d="asc'?scan'208";a="27543976"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Jun 2024 03:32:17 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 14 Jun 2024 03:31:46 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex04.mchp-main.com (10.10.85.152)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Fri, 14 Jun 2024 03:31:44 -0700
Date: Fri, 14 Jun 2024 11:31:27 +0100
From: Conor Dooley <conor.dooley@microchip.com>
To: Samuel Holland <samuel.holland@sifive.com>
CC: <linux-riscv@lists.infradead.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Andrew Jones <ajones@ventanamicro.com>, Conor Dooley <conor@kernel.org>,
	<linux-kernel@vger.kernel.org>, Deepak Gupta <debug@rivosinc.com>
Subject: Re: [PATCH v2 1/3] riscv: Enable cbo.zero only when all harts
 support Zicboz
Message-ID: <20240614-parasail-lived-b771878e869b@wendy>
References: <20240613171447.3176616-1-samuel.holland@sifive.com>
 <20240613171447.3176616-2-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="z5ZL1EgnfI55oztK"
Content-Disposition: inline
In-Reply-To: <20240613171447.3176616-2-samuel.holland@sifive.com>

--z5ZL1EgnfI55oztK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 13, 2024 at 10:14:39AM -0700, Samuel Holland wrote:
> Currently, we enable cbo.zero for usermode on each hart that supports
> the Zicboz extension. This means that the [ms]envcfg CSR value may
> differ between harts. Other features, such as pointer masking and CFI,
> require setting [ms]envcfg bits on a per-thread basis. The combination
> of these two adds quite some complexity and overhead to context
> switching, as we would need to maintain two separate masks for the
> per-hart and per-thread bits. Andrew Jones, who originally added Zicboz
> support, writes[1][2]:
>=20
>   I've approached Zicboz the same way I would approach all
>   extensions, which is to be per-hart. I'm not currently aware of
>   a platform that is / will be composed of harts where some have
>   Zicboz and others don't, but there's nothing stopping a platform
>   like that from being built.
>=20
>   So, how about we add code that confirms Zicboz is on all harts.
>   If any hart does not have it, then we complain loudly and disable
>   it on all the other harts. If it was just a hardware description
>   bug, then it'll get fixed. If there's actually a platform which
>   doesn't have Zicboz on all harts, then, when the issue is reported,
>   we can decide to not support it, support it with defconfig, or
>   support it under a Kconfig guard which must be enabled by the user.
>=20
> Let's follow his suggested solution and require the extension to be
> available on all harts, so the envcfg CSR value does not need to change
> when a thread migrates between harts. Since we are doing this for all
> extensions with fields in envcfg, the CSR itself only needs to be saved/
> restored when it is present on all harts.
>=20
> This should not be a regression as no known hardware has asymmetric
> Zicboz support, but if anyone reports seeing the warning, we will
> re-evaluate our solution.
>=20
> Link: https://lore.kernel.org/linux-riscv/20240322-168f191eeb8479b2ea169a=
5e@orel/ [1]
> Link: https://lore.kernel.org/linux-riscv/20240323-28943722feb57a41fb0ff4=
88@orel/ [2]
> Reviewed-by: Deepak Gupta <debug@rivosinc.com>
> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

--z5ZL1EgnfI55oztK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZmwb/wAKCRB4tDGHoIJi
0ldKAQDTQ/APmkNX8IRH/02s56jNsFUXa0qY9IeWFnaEdYB/GgD/Z0+wxcrVz8Xs
/vyJ79gnZtJJN6bFUsf3dif12uOlPgk=
=oFvk
-----END PGP SIGNATURE-----

--z5ZL1EgnfI55oztK--

