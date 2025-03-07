Return-Path: <linux-kernel+bounces-551418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D4527A56C32
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 16:34:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 554591897438
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 15:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10F4721D3CD;
	Fri,  7 Mar 2025 15:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ReTwye1m"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6744F21ABDA;
	Fri,  7 Mar 2025 15:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741361627; cv=none; b=UCtgg2TG4s0HK+6NBcqXhIkMaLEdSVU99QgYQczi9b+VY0jcM6JgXGAXemD41cinKnmcG4NPc7jW6Bihr82As83YPfSdUJ5V7RXr//fmMwY9Su2qoFm6NzfvpNztaYxexTJdCWlAqA8cD9teyECptQz5bLa466TRT3tLYc563hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741361627; c=relaxed/simple;
	bh=/8G731r/9zVK2cgbL3Wu2RrfDupfpYfNtUS7AyBXLFk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cVMVxybF4Pg7ga7Gj4xbAwRgYPRB/Gja4NrFDrZecNW4YGOHyANkTkVz4mmA3EbrWX0yGnTC2URNJnFmYxCdxldM542tJvOZfuM3KABO/AUJ5GoMDZnN7vLkHQWaiCANd+MqT7viSs3gUeLxctWfnpwW1HUR0pKo+C9Dpo8AcE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ReTwye1m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44B70C4CED1;
	Fri,  7 Mar 2025 15:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741361626;
	bh=/8G731r/9zVK2cgbL3Wu2RrfDupfpYfNtUS7AyBXLFk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ReTwye1mXmyF6GpfQCIWUOALaK0prXPUj/2+2PgnHcmYtGY7IkdpTO2AhskQZb3Ki
	 wNbSeFPuyS55PYZ4/eAdERkgeC/mF/rnlkqKYDfBOgT3t6cPgmF3dOGUIVjdQ80Vci
	 vnO+V8Xc3C8gwMQ4QNLk6AiB1s1WGTutwdLvVtmMjvnQ5PkV6vU3pD6ryQ3OPVJNiI
	 FLOSMj2e8mPTIV5VbmtfrYzYvdq8tI/l1hrFx3h/rTVB88EQ/oZ6c5p8PSlmye9Pk1
	 vWcvcqIYRHNTTO45qTfOArVQouYceu3ZBu9XsGTXIylZ7LaEe6cBuFdUw6bgaCObw0
	 hy0R+pwKJih9g==
Date: Fri, 7 Mar 2025 15:33:40 +0000
From: Conor Dooley <conor@kernel.org>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	"Pu, Hui" <Hui.Pu@gehealthcare.com>,
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: display: simple: Add Tianma
 P0700WXF1MBAA panel
Message-ID: <20250307-tile-parasitic-604a675fe8e2@spud>
References: <20250307-tianma-p0700wxf1mbaa-v1-0-1c31039a3790@bootlin.com>
 <20250307-tianma-p0700wxf1mbaa-v1-1-1c31039a3790@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qerg8HnSeY8a+FU/"
Content-Disposition: inline
In-Reply-To: <20250307-tianma-p0700wxf1mbaa-v1-1-1c31039a3790@bootlin.com>


--qerg8HnSeY8a+FU/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 07, 2025 at 03:54:47PM +0100, Luca Ceresoli wrote:
> Add the Tianma Micro-electronics P0700WXF1MBAA 7.0" LVDS LCD TFT panel.
>=20
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

> ---
>  Documentation/devicetree/bindings/display/panel/panel-simple.yaml | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/display/panel/panel-simple=
=2Eyaml b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
> index e3ee3a332bb7e1736a8d44773b0aef4873153be1..56b636560cbeb2277d65fce83=
916650de7ec4cbf 100644
> --- a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
> +++ b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
> @@ -282,6 +282,8 @@ properties:
>        - startek,kd070wvfpa
>          # Team Source Display Technology TST043015CMHX 4.3" WQVGA TFT LC=
D panel
>        - team-source-display,tst043015cmhx
> +        # Tianma Micro-electronics P0700WXF1MBAA 7.0" WXGA (1280x800) LV=
DS TFT LCD panel
> +      - tianma,p0700wxf1mbaa
>          # Tianma Micro-electronics TM070JDHG30 7.0" WXGA TFT LCD panel
>        - tianma,tm070jdhg30
>          # Tianma Micro-electronics TM070JDHG34-00 7.0" WXGA (1280x800) L=
VDS TFT LCD panel
>=20
> --=20
> 2.48.1
>=20

--qerg8HnSeY8a+FU/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ8sR1AAKCRB4tDGHoIJi
0gCLAP90Ydu+twouujWugpnx76CgrBd+/h0KxzXaRt0fjMaqJgEA8a2mFDWymeDP
WkSo/6vd5vc4LiYGVTmeZB2T8Whb8gE=
=NRmH
-----END PGP SIGNATURE-----

--qerg8HnSeY8a+FU/--

