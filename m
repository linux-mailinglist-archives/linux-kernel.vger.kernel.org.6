Return-Path: <linux-kernel+bounces-195614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BE3D8D4F50
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 17:43:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC335282A54
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 15:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DA05183091;
	Thu, 30 May 2024 15:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EyEIwPzF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2B2143C40;
	Thu, 30 May 2024 15:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717083787; cv=none; b=UdP1Cvx5ICFYqVnmbyspVDA+d2YABzknudaY/jz60cifj3zVnIoH6cYWBJptLTqidMsSV824U6PdR4GQ4JngUm5mRRZuCxKpzvjqXGuCnAISdIzt+zS9ikIos5/hJ/WHYBPLNY4X4+PWTWMrJzr6vkv4cwhhJiaF0H0v5QNh3YI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717083787; c=relaxed/simple;
	bh=sxN5z1qmpio62Pf/Ml/zd6Qag4AfNKvE5xoF1EDGv8k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gxZR7g59sFbMpowUQ7anbxpKZxE+2EsMpoQHzyRLKpmPQfebuZirMJdmRJ59tDZ+HkFEQW3v/vQL0PZK7XKAd0AiRml7sGk19oOfCvrwy8u9sTAMw7IxtrlLb1+GO9afa7mxPUkucl/nSJ0vOQn9XhfbME19c7hsGAm7NftWJEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EyEIwPzF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9046EC2BBFC;
	Thu, 30 May 2024 15:43:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717083787;
	bh=sxN5z1qmpio62Pf/Ml/zd6Qag4AfNKvE5xoF1EDGv8k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EyEIwPzFPgWdzqskayElMj22rlPIlDN2LaVM/azx2RaO/xA4IFv8HTizqT23FMoNg
	 6Dr+cMjQXbetPZdH9FZmRF3E7tUSe/CmcciHka2lO0g3rsyF9PfAuM92s++w5rgy0h
	 TFDnJJHBx1jW9NK2KrYWzA1OZGmpeQpsNnEQUhE056LUu3YRaVTdXtYcxHKIJZ2bMw
	 I6Z9okTggGuAglPbNRLc3Pg/rfAMX+4bn2S5/tvtSCLKR+y9NPufOpJUCSE+9xNDqp
	 onnljimCs8C/5y1HqTHsR2GZZsWkWdCi5adQOPL6mu8sSRASA6yKpP3vXjmP1ICURQ
	 FlGIaudMbe/bw==
Date: Thu, 30 May 2024 16:43:01 +0100
From: Conor Dooley <conor@kernel.org>
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: Frank Binns <frank.binns@imgtec.com>,
	Matt Coster <matt.coster@imgtec.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	dri-devel@lists.freedesktop.org, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] dt-bindings: clock: mediatek: Add mt8173 mfgtop
Message-ID: <20240530-revisit-profanity-889f1bcae21a@spud>
References: <20240530083513.4135052-1-wenst@chromium.org>
 <20240530083513.4135052-2-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="C42pYJ1S35FYsJe7"
Content-Disposition: inline
In-Reply-To: <20240530083513.4135052-2-wenst@chromium.org>


--C42pYJ1S35FYsJe7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 30, 2024 at 04:35:00PM +0800, Chen-Yu Tsai wrote:
> The MFG (GPU) block on the MT8173 has a small glue layer, named MFG_TOP
> in the datasheet, that contains clock gates, some power sequence signal
> delays, and other unknown registers that get toggled when the GPU is
> powered on.
>=20
> The clock gates are exposed as clocks provided by a clock controller,
> while the power sequencing bits are exposed as one singular power domain.
>=20
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> ---
>  .../clock/mediatek,mt8173-mfgtop.yaml         | 71 +++++++++++++++++++
>  include/dt-bindings/clock/mt8173-clk.h        |  7 ++
>  2 files changed, 78 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/mediatek,mt81=
73-mfgtop.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/clock/mediatek,mt8173-mfgt=
op.yaml b/Documentation/devicetree/bindings/clock/mediatek,mt8173-mfgtop.ya=
ml
> new file mode 100644
> index 000000000000..03c3c1f8cf75
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/mediatek,mt8173-mfgtop.yaml
> @@ -0,0 +1,71 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +
> +$id: http://devicetree.org/schemas/clock/mediatek,mt8173-mfgtop.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MediaTek MT8173 MFG TOP controller
> +
> +maintainers:
> +  - AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> +
> +description:
> +  The MFG TOP glue layer controls various signals going to the MFG (GPU)
> +  block on the MT8173.
> +
> +properties:
> +  compatible:
> +    const: mediatek,mt8173-mfgtop
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    minItems: 4

minItems is not needed when minItems =3D=3D maxItems.

> +    maxItems: 4
> +
> +  clock-names:
> +    items:
> +      - const: sys
> +      - const: mem
> +      - const: core
> +      - const: clk26m
> +
> +  power-domains:
> +    maxItems: 1
> +
> +  '#clock-cells':
> +    const: 1
> +
> +  '#power-domain-cells':
> +    const: 0
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - power-domains
> +  - '#clock-cells'
> +  - '#power-domain-cells'
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +        #include <dt-bindings/clock/mt8173-clk.h>
> +        #include <dt-bindings/power/mt8173-power.h>
> +
> +        mfgtop: clock-controller@13fff000 {

The label here is used, so drop it.

Otherwise,
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--C42pYJ1S35FYsJe7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZliehQAKCRB4tDGHoIJi
0rnoAQDaN332uA+sfGCydZsLPg1xRomJNTaEgeLJGYjMhgfcgAEAqIXjskcLzKk2
FwiVXlgrZQV08uIeB/KqLI7h50RF3Qo=
=MB31
-----END PGP SIGNATURE-----

--C42pYJ1S35FYsJe7--

