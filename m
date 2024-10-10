Return-Path: <linux-kernel+bounces-359548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46DCA998DDA
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 18:53:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7A0DB2AD5F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 16:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45F001CDA30;
	Thu, 10 Oct 2024 16:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i/afJ6UM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A173E2A1D3;
	Thu, 10 Oct 2024 16:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728577095; cv=none; b=llHLCzyTMV0gj8e8X8uuy0yEm25AuzHxUe8TWd1aTAYoE3FZJesXrATsZAkNMcis8HSKpLgIWbqKlWp0ljhdXh2PZPrtIruUZAtj5G5BKOd4URr9k/LTY8JSCa1QrluCoSAzzsDoaLlBlmYzFX5d4aU5IBTeJIhXi/LQTZa49tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728577095; c=relaxed/simple;
	bh=7AvwzW/MffijGtC0LhT/DeNlVgIXdZaZHv+b0DuiaQI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gn0ePSiO/hKHeiDT0JzpIMNInH901xdqIZ3wULkXZ3Wfk+r3c0nTwfAHqfKfR82XKXYyiKo1B07QtdeZMud3Es4gCs9L91LWQtTWoxqm1F0ZFGt/v5NmlN5Bz4MuPtSWWBTIOoOdN+WXXnscUaL/mHk+77wSo6gylNFL9fVs2J4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i/afJ6UM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3666DC4CEC5;
	Thu, 10 Oct 2024 16:18:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728577094;
	bh=7AvwzW/MffijGtC0LhT/DeNlVgIXdZaZHv+b0DuiaQI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i/afJ6UMziGG0n5c651fLNqExmF+2hxMw0UnlPgjv6l8wPNqVpWT1g+2jRynU23CB
	 CYCGxvbJKfjZyCpXEMK3ACa7DvfxGPX230erEWue/QS+8QThKSMF8HJ3p93i3yBPn9
	 XNslMxIxYUYDO/AqOa2ueuSZ8bQocUjLNf7gZEHwZGIf24lGDdEBn+6MGcirSlY0z2
	 UXDoFapD757My+tl4vSwx0ZWcYRajHy2d5xcRJs3oplXZIKbqR6Qx0TPMtYgZUZw1+
	 PmGF+PtB68vd6oyipHBJ+qCJ62ajvph8fSZguXcqv7iJ8IpPOVSnzjmqJlQrN5I8vh
	 aKWDuJBn9CdNg==
Date: Thu, 10 Oct 2024 17:18:08 +0100
From: Conor Dooley <conor@kernel.org>
To: Inochi Amaoto <inochiama@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Peter Zijlstra <peterz@infradead.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@outlook.com>, Guo Ren <guoren@kernel.org>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Yangyu Chen <cyy@cyyself.name>, Jinyu Tang <tangjinyu@tinylab.org>,
	Hal Feng <hal.feng@starfivetech.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Yixun Lan <dlan@gentoo.org>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 1/3] dt-bindings: interrupt-controller: Add Sophgo
 SG2044 ACLINT SSWI
Message-ID: <20241010-eradicate-overtake-a7b09ad79a0f@spud>
References: <20241009224410.53188-1-inochiama@gmail.com>
 <20241009224410.53188-2-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="OEx6wLTBXftTPeHH"
Content-Disposition: inline
In-Reply-To: <20241009224410.53188-2-inochiama@gmail.com>


--OEx6wLTBXftTPeHH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 10, 2024 at 06:44:07AM +0800, Inochi Amaoto wrote:
> Sophgo SG2044 has a new version of T-HEAD C920, which implement
> a fully featured ACLINT device. This ACLINT has an extra SSWI
> field to support fast S-mode IPI.
>=20
> Add necessary compatible string for the T-HEAD ACLINT sswi device.
>=20
> Signed-off-by: Inochi Amaoto <inochiama@gmail.com>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

--OEx6wLTBXftTPeHH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZwf+QAAKCRB4tDGHoIJi
0lBEAQC/9BgCiFl0swGHZLcJnu+WIiWZzMnC3V4UnuR/ZVGFlAD6AvphKvcYmc/k
q+jXM+CNWCUIsWRxsrAGhdxQX5O+UQM=
=z4lx
-----END PGP SIGNATURE-----

--OEx6wLTBXftTPeHH--

