Return-Path: <linux-kernel+bounces-176543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDF858C3164
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 14:57:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 687DA281AA3
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 12:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC76D5028C;
	Sat, 11 May 2024 12:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f4dZTZ4N"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 043A817C8;
	Sat, 11 May 2024 12:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715432250; cv=none; b=L7N8xxnpPdMGpUnQp5LbCd+EIy3AFJbQzNsadXXhsDnCJnuVOSHA+ZUjp3sRcIKOsWmqA58+Pw4K3mgL7QPHPgWdEmpKklCdW1v34UMk8UhA2JITh/UL0ZspIT4QyBgnZYbVEPah05k3GWXzCdOeCHRJhqZuxtAiWHvZcHxb1Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715432250; c=relaxed/simple;
	bh=RWNbN/njK6wiOv9OAhu8J3IBvFOEIPFY4gNdL026NKk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Edun6qCY67ysiwi2Sk0bM9dUuZT0ejwvdxjHSKoJj9bRlJ4+nC4GRb62SProXbdB/y6PkVb8ph1dG6EiBIikQHWInQjpNIarGjFYa+yiPu6jx/h9ew2FOYq1JyDRFKpifEZl80hXxeS+BB66QRp9zvXXnpUHYshJR3RGUsdvyBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f4dZTZ4N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 301DEC2BBFC;
	Sat, 11 May 2024 12:57:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715432249;
	bh=RWNbN/njK6wiOv9OAhu8J3IBvFOEIPFY4gNdL026NKk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f4dZTZ4NkC2yeKdkHWoLB3uKpvLzNYJZM7/Dmn7TtZlctDYUb9g4POSi770fEpVQl
	 umghgzNJRejcHjMog/GvLP3uz++uB0MPmllpzy+g2ioCNhOmHrO54Iqx1S9YL2YjxU
	 5BUnTjWh9xhpTGnLRklf5zxcEMNK5x7gThOQqc1fJiV9rM7yjXZUQ2lsz/34JLpoXX
	 YHUCrztvC+nUwscpBuI9ZrfPPaP45xFfEZJHoOTldvBtNtBXlRWi27zJ9QzdofFYa4
	 1N1AlYJLbXHhdNCQ/thTahSxqV68OHVxzbE/ZzDWjM6dMlphc+e9H2Qc2AS+KTOL2R
	 1l7VvQZpUIPlA==
Date: Sat, 11 May 2024 13:57:23 +0100
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
Subject: Re: [PATCH 3/3] dt-bindings: display: panel: constrain 'reg' in DSI
 panels
Message-ID: <20240511-unturned-bubbling-fc90b310c5f1@spud>
References: <20240509-dt-bindings-dsi-panel-reg-v1-0-8b2443705be0@linaro.org>
 <20240509-dt-bindings-dsi-panel-reg-v1-3-8b2443705be0@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="HTAa7j2IxMwfD4P2"
Content-Disposition: inline
In-Reply-To: <20240509-dt-bindings-dsi-panel-reg-v1-3-8b2443705be0@linaro.org>


--HTAa7j2IxMwfD4P2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 09, 2024 at 11:42:53AM +0200, Krzysztof Kozlowski wrote:
> DSI-attached devices could respond to more than one virtual channel
> number, thus their bindings are supposed to constrain the 'reg' property
> to match hardware.  Add missing 'reg' constrain for DSI-attached display
> panels, based on DTS sources in Linux kernel (assume all devices take
> only one channel number).
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--HTAa7j2IxMwfD4P2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZj9rMgAKCRB4tDGHoIJi
0rD/AP9+Gs0oiRtbfQUrh44iaHJuc/JQaNQ+Wy4jwt0yI2XP5QD/cRuuA4zX971s
PPQqGvSsOiXgR7eOBgd8Xob8Gg8ZFwY=
=TLGw
-----END PGP SIGNATURE-----

--HTAa7j2IxMwfD4P2--

