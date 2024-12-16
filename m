Return-Path: <linux-kernel+bounces-447150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D44079F2DFD
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 11:14:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04B367A133A
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 10:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01597202F9C;
	Mon, 16 Dec 2024 10:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="B2YAizzT"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B48202F8C
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 10:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734344069; cv=none; b=oHUz9pdTt5xQuJsU4Usb4DDcziXHk9RXU8RUuV6E2tSfHCkNsBt01Q+2CuhTNZmDARc9T4A314LhgFWQrDPWFB7HmvLwjx9yTDsG5dWz1eThCxzUh9pu1hx4Aw7vx/mRRtRoOq/OadKJwIS6zoXfNq0kiA08cqThtMfLdzuD5TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734344069; c=relaxed/simple;
	bh=oevHNvEMytCO/w2BsyOZ5rIUF1D5BkzLPG8TAKcZOmA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rS4a6JE34JhQ2nKLMPLc4enZuTS6TxFcpvdT2RarO7bShuzOPUfUfDPn+Iay3XPQzWWWEL5M0dhUI0vm7d+pQLLe+rXfaOvH6o47/BCYceEpqPdM0LVV3AHqbA6Fyt01qo3T1YM+WvP9P1YQSil6VBIPMdD5BWW0lDrSxU/icSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=B2YAizzT; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1734344067; x=1765880067;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oevHNvEMytCO/w2BsyOZ5rIUF1D5BkzLPG8TAKcZOmA=;
  b=B2YAizzTeaMvNvE/KT1fKW7jBJNU/6Gy/e8n30ETk5zPhRj8/9Rd3tXc
   3PjrVS/9ouJqqHm67KmRoUip61ZBtC+QQ4hAWcvhtkosNSzGkTwCw6h6j
   vn1gp+LttxYPJ4EkwCjNQp1bkUOwTkCPvhdZCAqoQ+nZV4VItrY96kesK
   5iRljJiqc29G7ZN0OUY/WfniHgNLV61QGdP9OQUR+5Wr9lJw7belKovAa
   CAUmfoBtSgpkysS/zXbumJrt+fCuC+a4WZ5RUDbIMRzENXCzsS/YvWHiF
   ckvQXnQM8aOBjNXX2f5Ne2ld8NUK7v+/IQr9obCsnvWhV9LbEi1MDimV6
   Q==;
X-CSE-ConnectionGUID: 9L0TMu2tSHCHWfhN2S/CJA==
X-CSE-MsgGUID: S8x2wtMjTUSVspMwc6qKYA==
X-IronPort-AV: E=Sophos;i="6.12,238,1728975600"; 
   d="asc'?scan'208";a="203042226"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Dec 2024 03:14:18 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 16 Dec 2024 03:13:38 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex04.mchp-main.com (10.10.85.152)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Mon, 16 Dec 2024 03:13:36 -0700
Date: Mon, 16 Dec 2024 10:13:04 +0000
From: Conor Dooley <conor.dooley@microchip.com>
To: Drew Fustini <drew@pdp7.com>
CC: Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
	<palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Inochi Amaoto
	<inochiama@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Yangyu Chen
	<cyy@cyyself.name>, Anup Patel <apatel@ventanamicro.com>, Hal Feng
	<hal.feng@starfivetech.com>, Chen Wang <unicorn_wang@outlook.com>, Geert
 Uytterhoeven <geert+renesas@glider.be>, <linux-riscv@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Emil Renner Berthing
	<emil.renner.berthing@canonical.com>
Subject: Re: [RESEND][PATCH] riscv: defconfig: enable pinctrl and dwmac
 support for TH1520
Message-ID: <20241216-video-bush-7239b0cf29a3@wendy>
References: <20241216003114.326129-1-drew@pdp7.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="LtjecBICw5GPZ6x2"
Content-Disposition: inline
In-Reply-To: <20241216003114.326129-1-drew@pdp7.com>

--LtjecBICw5GPZ6x2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 15, 2024 at 04:31:15PM -0800, Drew Fustini wrote:
> Enable pinctrl and ethernet dwmac driver for the TH1520 SoC boards like
> the BeagleV Ahead and the Sipeed LicheePi 4A.
>=20
> Reviewed-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
> Signed-off-by: Drew Fustini <drew@pdp7.com>
> ---
> I am resending this patch since it has been about a month. It is still
> listed in patchwork in the "new" state:
> https://patchwork.kernel.org/project/linux-riscv/patch/20241113184333.829=
716-1-drew@pdp7.com/

I'll grab it.

--LtjecBICw5GPZ6x2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ1/9MAAKCRB4tDGHoIJi
0l6dAPoD8yjJYupWC+472YD6A0TQiaMgAe4s2XxkxxkbysfjDwEAw/hOnW9hjfxm
Rs263BzlAUFvp4rwZbRVqNf9SsJtAQQ=
=h0DQ
-----END PGP SIGNATURE-----

--LtjecBICw5GPZ6x2--

