Return-Path: <linux-kernel+bounces-181298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 82D058C7A1C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 18:11:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3ADA1C21523
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 16:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D77914D71A;
	Thu, 16 May 2024 16:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GHn5ukKt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B622314D6FB
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 16:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715875870; cv=none; b=CmJKAfPis35rgkw9pTEXYB1dSaRN+VCFyGXx1n7KyL0WvWsY+wpvbdvDCFbSX0Q8hjSzFh/1MZvwrhXU7Mnqct/InbxfRyboA3PgtQeUMxGLdBocFBnqvpvCk7mG64ndxA/G9RtooA7Fxkffj56PjWvQVUnRWFfisgPdNX4R3Ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715875870; c=relaxed/simple;
	bh=KPHdabfWiaxtIGIkpvORD6tIq15eItbt5MKhO4Blybo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KoFdky3brWCtf1hUJFVRLvE94RyCduwUcz3BnWMCbIgzVV/eeZkRoIiXXbMPsZZIQQU31MPAdai3PHbsRF5OKJ54VlQu8rI8idAsp/m1QNIChBp2KUYbZ9exLXzmIgdY3ZfwE0YeMisDztjFwvZA0i7z/O9FmJwS2BJ9uIyTrkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GHn5ukKt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98F4FC113CC;
	Thu, 16 May 2024 16:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715875870;
	bh=KPHdabfWiaxtIGIkpvORD6tIq15eItbt5MKhO4Blybo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GHn5ukKt7aOHuWlDuzODIb3SvaGBw0d0vyjSaODCUH+inFxUaVMi8pO1ZRlypj5lb
	 XI+NL+lFc8iICdYyk3f3xhsicBboTTgR4zHTsB9uqqJZnsNWELEcgtyU56VrJ2rU7l
	 +m45L3EzsJ9rUp6QUVMzTT9swR7BsyXAGp2a7EXwq2N80Gfwq1fFZQtxUnF8wjJped
	 QwsirWfyOPyoCy87LQNaem2wTTdytYtoqdIhsh3krszGbVg3DKWnT/lKaIbN7Z5A8u
	 fK3NWBmqvlm4wsdUIuXEbQO5j7KI+5ffKPmgE7gUIUBtIKewN4M9OBnhtPjnK4PNBY
	 bQyOzGoGlTl9A==
Date: Thu, 16 May 2024 17:11:06 +0100
From: Conor Dooley <conor@kernel.org>
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Conor Dooley <conor.dooley@microchip.com>,
	Evan Green <evan@rivosinc.com>, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] riscv: Introduce vendor variants of extension helpers
Message-ID: <20240516-woozy-flatten-7fb7cc2eac52@spud>
References: <20240515-support_vendor_extensions-v1-0-b05dd5ea7d8d@rivosinc.com>
 <20240515-support_vendor_extensions-v1-3-b05dd5ea7d8d@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="0+/XzYarysVlGuOn"
Content-Disposition: inline
In-Reply-To: <20240515-support_vendor_extensions-v1-3-b05dd5ea7d8d@rivosinc.com>


--0+/XzYarysVlGuOn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 15, 2024 at 02:26:15PM -0700, Charlie Jenkins wrote:
> Vendor extensions are maintained in per-vendor structs (separate from
> standard extensions which live in riscv_isa). Create vendor variants for
> the existing extension helpers to interface with the riscv_isa_vendor
> bitmaps.

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--0+/XzYarysVlGuOn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZkYwGgAKCRB4tDGHoIJi
0o3uAQDZqSeE2PfossmmMsc96NPgqt6dTMaCDMs8JN+xw5MlIgEAnakVM7VWT4OM
TSMBsrHoorfFbYQp731WFofPusWCZgk=
=qzzp
-----END PGP SIGNATURE-----

--0+/XzYarysVlGuOn--

