Return-Path: <linux-kernel+bounces-171874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A56CA8BE9BB
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 18:52:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5924A1F223AD
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 16:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDB8B200A9;
	Tue,  7 May 2024 16:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jVT4gjEb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 164E6B642;
	Tue,  7 May 2024 16:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715100717; cv=none; b=opZQPmcWYNeWJjek3/SbgudLPJgU4z4atkEWyRLHWuSiB7tkI1JRP2ztzx47E+nb/EUyItWt9MidnUNbdt0Dg0KAYWCzwRYpEJCDFYCqkI6daPw0fegSTORCmZyXsgIIwmt0zcvI+ZNoCJRvPIxJZTM+0dZlmHOYF7U1jWW/8iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715100717; c=relaxed/simple;
	bh=/Bkd2IwTGaLgZju05dzWdon64EKKSvHjfKDMLbB1/9o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qtlox+z1oTMXExOH1sFe6rkTsS/55khRyMebjZv3RXK1D5+1d5EOZcpde9M/jV0Tnb8/7stqTGb8KAXjhOXi9FFX7SxiCpOOpdbcS/A85ClQBcAdA3eKCfg6SkCC2qGZoq0fWbTwKTrLVleHu1g4412i+Byd4ZMcNiGp0Y59Nqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jVT4gjEb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7700C4AF63;
	Tue,  7 May 2024 16:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715100716;
	bh=/Bkd2IwTGaLgZju05dzWdon64EKKSvHjfKDMLbB1/9o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jVT4gjEb4Ki4lwgfVfMSSKV0FIB3ScF4nul0QK+99jzj5PVrZ3AtEeNPhY4pFU5Fz
	 uoHE+fuhAU8AyEq0THAcQX62DyEiiih3bCSIgsxvRFyfmIQfPoJwjvCFN7nzin0gjr
	 IIe3enl8vX1GyZb3/34PtMv2iV9FF1VIijBprcDnVIrdUbZAR7dfzOqvjbd+H1vvyP
	 filpHMehhCOwzz65GnbEu7rM7EM7nq73GBrl2dEJ5ova65j3SaeVx/b8PUhDDV2EH9
	 mtPcdnsVdHUnkTo4iGbgL+UokMvKKBFfM5EQTHkdBOKvjc0vaJLSE+xxMEq1yLLlTs
	 Mzi9nuysRBvBQ==
Date: Tue, 7 May 2024 17:51:50 +0100
From: Conor Dooley <conor@kernel.org>
To: Alex Bee <knaerzche@gmail.com>
Cc: Sandy Huang <hjc@rock-chips.com>,
	Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>,
	Andy Yan <andy.yan@rock-chips.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org
Subject: Re: [PATCH 2/7] dt-bindings: clock: rk3128: Add PCLK_MIPIPHY
Message-ID: <20240507-cardiac-obsessed-89f3b0894bec@spud>
References: <20240506194343.282119-1-knaerzche@gmail.com>
 <20240506194343.282119-3-knaerzche@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="MJDZAnqOutdsOh4Y"
Content-Disposition: inline
In-Reply-To: <20240506194343.282119-3-knaerzche@gmail.com>


--MJDZAnqOutdsOh4Y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 06, 2024 at 09:43:37PM +0200, Alex Bee wrote:
> The DPHY's APB clock is required to be exposed in order to be able to
> enable it and access the phy's registers.
>=20
> Signed-off-by: Alex Bee <knaerzche@gmail.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--MJDZAnqOutdsOh4Y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZjpcJgAKCRB4tDGHoIJi
0s4UAQDtrMr/zcll7XLRlmogcgoAfSJQZq1AEQQeJxIADgIQwwEA+aBSIaagtafp
+CaYRxpIvw/qSd+oMTrkzEpnz5opSg8=
=o2x0
-----END PGP SIGNATURE-----

--MJDZAnqOutdsOh4Y--

