Return-Path: <linux-kernel+bounces-321228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C463F971628
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 13:05:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AE691F21CF4
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 11:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC02E1B81B4;
	Mon,  9 Sep 2024 11:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="08/yQEbr"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB48E1B582F
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 11:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725879813; cv=none; b=tCcsmz1hPM3Iv0YeVGtggfO0a70EQs9yFU59PVhBk6Dx5mhzbKN0QKo/EQIOzq5W13JKXe5uLr3ZW0u0M6O8wP8OWXjJgG8D1icddPdF4n9UyciCyOKg2JCVcbk0uHNDejjQE0epa0xos1Qa79aVSFqhr9b7xMYggUfgDLoGvfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725879813; c=relaxed/simple;
	bh=zxqrtgg8N3MLqE09QLa/5QUpra3H4/9rmhKJTagM0+E=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tNGTg0pLaBCZOP37TTQIzVaIss0ZQ+wUk67XTSJ6pdP0DxAwu0YlTpp1o1MiyOHHaML2PdFZpcSq8PUlIYriCZB+IMnQgsphbQkMDgHoMjnEY9hJNcQor1rmMuoPohFH7CNpbLwf92Ie6RAjqWYvG3YOXwrK7Ir4nQRLG3UkllI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=08/yQEbr; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1725879812; x=1757415812;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zxqrtgg8N3MLqE09QLa/5QUpra3H4/9rmhKJTagM0+E=;
  b=08/yQEbrTbyBUKk3qzYBrrR/j4RAhBmLSCuZmtLuGPAZqIRVJwIU3gcc
   psz2d5veHaMz8ycOXZ6CkQbjtNt+eNmJTz9Fy02mgdr22qsJPp7BXFnPr
   KWN4rbkJnFHSSAdLQoAt7rayH6RlBWWWzvciyuGSFriRctJzOh6QYibDO
   O//nhzIB7WClXW1KltPMdVk6hdEB1XOSc4BcAg+tErb0SuxJ0yHPm3Aqp
   tBpTtfRNKJJdiTrC/t/fcO75NvdSxjKfJCQhxjMGitA4J0fw2PccgF4cY
   J+VBUPgvZaY8fxhj5jg51aE66YUE16UtoYBrQNt4KlW9gvoQIphzvAVjS
   w==;
X-CSE-ConnectionGUID: 4dJ/0+VGSpWfEj1lld7pJA==
X-CSE-MsgGUID: 3psar7/NQRmZko+2y/Yudw==
X-IronPort-AV: E=Sophos;i="6.10,214,1719903600"; 
   d="asc'?scan'208";a="32143414"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Sep 2024 04:03:29 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 9 Sep 2024 04:03:24 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex01.mchp-main.com (10.10.85.143)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Mon, 9 Sep 2024 04:03:22 -0700
Date: Mon, 9 Sep 2024 12:02:49 +0100
From: Conor Dooley <conor.dooley@microchip.com>
To: Minda Chen <minda.chen@starfivetech.com>
CC: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
	Jan Kiszka <jan.kiszka@siemens.com>, <linux-phy@lists.infradead.org>, Emil
 Renner Berthing <emil.renner.berthing@canonical.com>, Rob Herring
	<robh+dt@kernel.org>, Conor Dooley <conor@kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/1] phy: starfive: jh7110-usb: Fix link configuration
 to controller
Message-ID: <20240909-drizzle-hydroxide-dd405c4c3a6d@wendy>
References: <20240902111127.15155-1-minda.chen@starfivetech.com>
 <20240902111127.15155-2-minda.chen@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qjEwf94R/mUYYeCE"
Content-Disposition: inline
In-Reply-To: <20240902111127.15155-2-minda.chen@starfivetech.com>

--qjEwf94R/mUYYeCE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 02, 2024 at 07:11:27PM +0800, Minda Chen wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
>=20
> In order to connect the USB 2.0 PHY to its controller, we also need to
> set "u0_pdrstn_split_sw_usbpipe_plugen" [1]. Some downstream U-Boot
> versions did that, but upstream firmware does not, and the kernel must
> not rely on such behavior anyway. Failing to set this left the USB
> gadget port invisible to connected hosts behind.
>=20
> Link: https://doc-en.rvspace.org/JH7110/TRM/JH7110_TRM/sys_syscon.html#sy=
s_syscon__section_b3l_fqs_wsb [1]
> Fixes: 16d3a71c20cf ("phy: starfive: Add JH7110 USB 2.0 PHY driver")
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> Signed-off-by: Minda Chen <minda.chen@starfivetech.com>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

--qjEwf94R/mUYYeCE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZt7V2AAKCRB4tDGHoIJi
0juLAP0Sv4xZPU/+NpNoVLsi4fsM0XhHNLn4YcKwtjCD6dPgzgD+KH7/Z3GzArn4
IjuEL7terWYP/AVVmz7hHyJkh7+vKwA=
=X8B3
-----END PGP SIGNATURE-----

--qjEwf94R/mUYYeCE--

