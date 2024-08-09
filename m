Return-Path: <linux-kernel+bounces-281018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32DE294D1F3
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 16:15:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D99D0281A45
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 14:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 129FE196DA2;
	Fri,  9 Aug 2024 14:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MNHznpcD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4266118E749;
	Fri,  9 Aug 2024 14:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723212918; cv=none; b=gw4VGtWpXkcgXjB9+s3991GsqZViq0GVNKHQlbQKDBUdk/FDjZel766z7K40tDFRDuFdi0yoz0PLEYK5sAEtW3HwRQJNFVfLVF8ucsz+/6KEvZnqTwdG+5i4R/V+BsW4WuwzvEXgb8uGSrCuFjPJAiX1+34IfmF3n5wcbE92XIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723212918; c=relaxed/simple;
	bh=w5Uu8kE++ZYIbMhB71Ar9euCDfVNBzU6Ua9+eX4Vqrc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WePpkFJEkIABg5I9UCs1i5t62yvcWplxV7S3ehmVAFZ/vbPMhLB/4mKK8ZmIGas7Rl6pm6h2lzXJVdvfGrkVGv5CzSLhAK7IGP3ZLtFTRyru6e6g4QOU/PCz7IpWe8yLajL8rTsIN/outs0KPWLnb86l9zNimBwlyyWbN56MeAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MNHznpcD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B78EAC32782;
	Fri,  9 Aug 2024 14:15:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723212917;
	bh=w5Uu8kE++ZYIbMhB71Ar9euCDfVNBzU6Ua9+eX4Vqrc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MNHznpcD4kDI2a5pn8+YKkQ5KDyMUHxuduzP8D8BxyoGl5MZQvROUYH4feFzEQ1Lq
	 rl/RX45ljxAoe+GJKbVaE5oKRzxFnRCZys/7A8xGdbfo4k9BTM2JFvmCutUQdg+6k8
	 eu2BeVwcwMYBgxyIYYhDnYADQLZ4gFI0KbUKja3pkjCyQ+UX+nzK1IC02J8zyF9Dw6
	 EBlzhGOvqbECOQrwXp75MIV5e3IaWLObG6/tFT5zMn5fdvFHlHZ20YUWrzEZb4pODI
	 bT+O7zS0G6iFizXnrDPbVzRBIDThNOpGv9Nc81E0sy4KpueELltbSRAe+XP1f0aGfz
	 3CAQgfVNbzMfg==
Date: Fri, 9 Aug 2024 15:15:12 +0100
From: Conor Dooley <conor@kernel.org>
To: Detlev Casanova <detlev.casanova@collabora.com>
Cc: linux-kernel@vger.kernel.org,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Elaine Zhang <zhangqing@rock-chips.com>, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, kernel@collabora.com,
	Sugar Zhang <sugar.zhang@rock-chips.com>
Subject: Re: [PATCH v4 1/3] dt-bindings: reset: Add rk3576 reset definitions
Message-ID: <20240809-linoleum-ogle-ace67939d9a0@spud>
References: <20240809125553.3889-1-detlev.casanova@collabora.com>
 <20240809125553.3889-2-detlev.casanova@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="t78d8km8087h0PQv"
Content-Disposition: inline
In-Reply-To: <20240809125553.3889-2-detlev.casanova@collabora.com>


--t78d8km8087h0PQv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 09, 2024 at 08:54:52AM -0400, Detlev Casanova wrote:
> Add reset ID defines for rk3576.
>=20
> Compared to the downstream bindings this uses continous gapless
> reset IDs starting at 1 instead of register offsets as IDs, as
> introduced in the RK3588 bindings.
> Thus all numbers are different between upstream and downstream,
> but names are kept exactly the same.
>=20
> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
> Signed-off-by: Sugar Zhang <sugar.zhang@rock-chips.com>
> Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>

IMO squash this with the other binding patch.

--t78d8km8087h0PQv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZrYkcAAKCRB4tDGHoIJi
0lbGAP9gRbbIcKDIuGKKqo4LvACMVh0fW9tL7WjBO/s+laybYQD/W5GuzkgcpFiW
fR9M8fRJqwKwuTsybhrS3U05O2DcJAk=
=MRvi
-----END PGP SIGNATURE-----

--t78d8km8087h0PQv--

