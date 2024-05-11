Return-Path: <linux-kernel+bounces-176544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F30548C316C
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 14:58:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A04E282228
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 12:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77B545028D;
	Sat, 11 May 2024 12:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aUh0Yrr1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6BA34F5E6;
	Sat, 11 May 2024 12:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715432322; cv=none; b=SknOpbPk9A+PYShRMjCl9V1Fi+spBMD4E9+gGBDU6tgclossG3O4wiZVN65Au7RYlcPQzf69xkv+MFmCfm0hrZaioTQtZokjuMI5pN9+8S/mTMGM9PVt3NOnxH4EwYDlhwdfD8Hz+JDOrQrH8JCZigUimyrwnulg1R5N8W3e9q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715432322; c=relaxed/simple;
	bh=g9G7oMu4B/QiQlAbIRQ7UTs0dpw6tTeALLYU0kIXKmY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OEXFtzihRfaF2C1lHj2LkWwMrEAcSiB9KdJiLy7M6TAT3nIFoonByrWze0uWQ1E0viAWO1B1gxuOlYOrHv1bGQd/qvHYWdmy3+WQ3TBeFK6I42LFg8BA9n/dZf800HKrI/f3jTVswRAefQ4XP/xpV7EeaOAqqxCSQyjBbGbQdDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aUh0Yrr1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE3D8C2BBFC;
	Sat, 11 May 2024 12:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715432322;
	bh=g9G7oMu4B/QiQlAbIRQ7UTs0dpw6tTeALLYU0kIXKmY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aUh0Yrr1FaisCxGYtYe3P5bZwLzDNEIDmL3o9aYgptvIc6jiYsCDwWxUIWMCwtjYZ
	 yewsfrTUxjBBLEMyawlhzxx2fEvzl4K2hcv6IM8yBwz7LjelTXSeob38649B+FAw2a
	 VEVx0VmYIzMnVvcfae0lBZoZ5CASYNQeZ9Zvnh+QI6t2vOWT8XHhFRbHUfQQjI05N9
	 DTkPVpsyWIxp2HdWSWxwvXNIZhEDvC0yDf+uK+PpYeAr12F8JAlFAhakz6qI5nammE
	 IlUnuao7duEz8CSf+X6JV186V7zx5xQdgTO4SVNOByY/u7GYNqR7ee9++oDz+NVK/S
	 zDnNSlv+CxFrg==
Date: Sat, 11 May 2024 13:58:35 +0100
From: Conor Dooley <conor@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
	Sam Ravnborg <sam@ravnborg.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chris Morgan <macromorgan@hotmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Konrad Dybcio <konradybcio@gmail.com>,
	Del Regno <angelogioacchino.delregno@somainline.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Luca Weiss <luca.weiss@fairphone.com>,
	Dmitry Baryskov <dmitry.baryshkov@linaro.org>,
	Shawn Guo <shawn.guo@linaro.org>, dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: display: panel: constrain 'reg' in SPI
 panels
Message-ID: <20240511-gizmo-attic-fc4dff917af1@spud>
References: <20240509-dt-bindings-dsi-panel-reg-v1-0-8b2443705be0@linaro.org>
 <20240509-dt-bindings-dsi-panel-reg-v1-2-8b2443705be0@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="PPvr9IV2m0OUjKgH"
Content-Disposition: inline
In-Reply-To: <20240509-dt-bindings-dsi-panel-reg-v1-2-8b2443705be0@linaro.org>


--PPvr9IV2m0OUjKgH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 09, 2024 at 11:42:52AM +0200, Krzysztof Kozlowski wrote:
> SPI-attached devices could have more than one chip-select, thus their
> bindings are supposed to constrain the 'reg' property to match hardware.
> Add missing 'reg' constrain for SPI-attached display panels.
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--PPvr9IV2m0OUjKgH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZj9rewAKCRB4tDGHoIJi
0k+wAQC9NFi60nEG0IT9rsXvel4SH48N8CPnUkfZNDN9n+JiEwEAtE7FMl36skZw
dkladI4t3xdvRRNRSsfh253nM0JnnQI=
=fNjt
-----END PGP SIGNATURE-----

--PPvr9IV2m0OUjKgH--

