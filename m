Return-Path: <linux-kernel+bounces-374801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D52C99A702E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 18:56:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 620881F2147F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 16:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE2AA1E9097;
	Mon, 21 Oct 2024 16:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bgZU75Ze"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF12B1C3F1F;
	Mon, 21 Oct 2024 16:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729529788; cv=none; b=AiusVdjJ6lm3cfF/lNqbLXbWcCgjVQr4VBX2tnjnS5o3vBoQRIkDI6Bo4pMWfMvu3MU5a0w3WQAGTzrUVXApcW+HOYOoZR8paBfXIHiAF+4CDMPh/E8kxkPGS8bwgnT7RgxgQxsB+Uu++yj3Mw+TrkKOeN/NCb7whybZD6WcZww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729529788; c=relaxed/simple;
	bh=liPd4zwwNy3T+1XLeHuqkI/iYD/8y4/wV+I9AolNpIg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PnRUBFGRGPJ5YVScSEbvzjaEaGgeKG+pTvA1HVV1XwTcS38mqjM7wCk1G+g9IIPlNGkAiiVtYmqjKcjvZaHS1aylgxFeo8905K7qn+pUyY9o6bxriqFoS0IwVNJHlvfWy3R2XcJ6LxX+Ejs6+SjIAX4ep7WYn6My8TGzsd19QaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bgZU75Ze; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01E20C4CEC3;
	Mon, 21 Oct 2024 16:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729529787;
	bh=liPd4zwwNy3T+1XLeHuqkI/iYD/8y4/wV+I9AolNpIg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bgZU75ZeBiRT88L0fTlc+hKkfIm+521NfeTaa5pqW8Kn8ZGsrX9To9RwJi50mEkGX
	 hKd0p4gAX5OSTuwS8FwdvhpICy9EzKFOV09zSxHkTLEZBOlScdAw+XDXDoNS5Tegw4
	 lWgwuP32nTjxDW7h/oi59zWHTwAZqyD0lAfr2nhMwnTrMsmSUxSBS3SABSJMPXUekd
	 /np3SM4/nPr/jBAaeJb/o1rGHd3yNw1Fm9+ylvKDgPKyJcbsCGE3PjgCJmRc2RK05R
	 9RKijhngwzRRqkz3q7FIg2DF7iwOWOkpaCETr7HOSYwAWPx9vqyleYii0NAT61qdkE
	 23biU/DDR+VXA==
Date: Mon, 21 Oct 2024 17:56:21 +0100
From: Conor Dooley <conor@kernel.org>
To: Yassine Oudjana <yassine.oudjana@gmail.com>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Sam Shih <sam.shih@mediatek.com>,
	Yassine Oudjana <y.oudjana@protonmail.com>,
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] dt-bindings: clock: mediatek: Add bindings for
 MT6735 syscon clock and reset controllers
Message-ID: <20241021-goatskin-wafer-7582dbcfe1d1@spud>
References: <20241021121618.151079-1-y.oudjana@protonmail.com>
 <20241021121618.151079-2-y.oudjana@protonmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ZXuBxhWPZaWXTuxG"
Content-Disposition: inline
In-Reply-To: <20241021121618.151079-2-y.oudjana@protonmail.com>


--ZXuBxhWPZaWXTuxG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2024 at 03:16:15PM +0300, Yassine Oudjana wrote:
> From: Yassine Oudjana <y.oudjana@protonmail.com>
>=20
> Add device tree bindings for syscon clock and reset controllers (IMGSYS,
> MFGCFG, VDECSYS and VENCSYS).
>=20
> Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
> ---
>  .../bindings/clock/mediatek,syscon.yaml           |  4 ++++
>  MAINTAINERS                                       |  6 ++++++
>  .../dt-bindings/clock/mediatek,mt6735-imgsys.h    | 15 +++++++++++++++
>  .../dt-bindings/clock/mediatek,mt6735-mfgcfg.h    |  8 ++++++++
>  .../dt-bindings/clock/mediatek,mt6735-vdecsys.h   |  9 +++++++++
>  .../dt-bindings/clock/mediatek,mt6735-vencsys.h   | 11 +++++++++++
>  .../dt-bindings/reset/mediatek,mt6735-mfgcfg.h    |  9 +++++++++
>  .../dt-bindings/reset/mediatek,mt6735-vdecsys.h   | 10 ++++++++++

Is it really necessary to have individual files foe each of these? Seems
a bit extra, no?

Cheers,
Conor.

>  8 files changed, 72 insertions(+)
>  create mode 100644 include/dt-bindings/clock/mediatek,mt6735-imgsys.h
>  create mode 100644 include/dt-bindings/clock/mediatek,mt6735-mfgcfg.h
>  create mode 100644 include/dt-bindings/clock/mediatek,mt6735-vdecsys.h
>  create mode 100644 include/dt-bindings/clock/mediatek,mt6735-vencsys.h
>  create mode 100644 include/dt-bindings/reset/mediatek,mt6735-mfgcfg.h
>  create mode 100644 include/dt-bindings/reset/mediatek,mt6735-vdecsys.h
>=20
> diff --git a/Documentation/devicetree/bindings/clock/mediatek,syscon.yaml=
 b/Documentation/devicetree/bindings/clock/mediatek,syscon.yaml
> index 10483e26878fb..a86a64893c675 100644
> --- a/Documentation/devicetree/bindings/clock/mediatek,syscon.yaml
> +++ b/Documentation/devicetree/bindings/clock/mediatek,syscon.yaml
> @@ -28,6 +28,10 @@ properties:
>                - mediatek,mt2712-mfgcfg
>                - mediatek,mt2712-vdecsys
>                - mediatek,mt2712-vencsys
> +              - mediatek,mt6735-imgsys
> +              - mediatek,mt6735-mfgcfg
> +              - mediatek,mt6735-vdecsys
> +              - mediatek,mt6735-vencsys
>                - mediatek,mt6765-camsys
>                - mediatek,mt6765-imgsys
>                - mediatek,mt6765-mipi0a
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2ce38c6c0e6ff..25484783f6a0b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14537,11 +14537,17 @@ F:	drivers/clk/mediatek/clk-mt6735-infracfg.c
>  F:	drivers/clk/mediatek/clk-mt6735-pericfg.c
>  F:	drivers/clk/mediatek/clk-mt6735-topckgen.c
>  F:	include/dt-bindings/clock/mediatek,mt6735-apmixedsys.h
> +F:	include/dt-bindings/clock/mediatek,mt6735-imgsys.h
>  F:	include/dt-bindings/clock/mediatek,mt6735-infracfg.h
> +F:	include/dt-bindings/clock/mediatek,mt6735-mfgcfg.h
>  F:	include/dt-bindings/clock/mediatek,mt6735-pericfg.h
>  F:	include/dt-bindings/clock/mediatek,mt6735-topckgen.h
> +F:	include/dt-bindings/clock/mediatek,mt6735-vdecsys.h
> +F:	include/dt-bindings/clock/mediatek,mt6735-vencsys.h
>  F:	include/dt-bindings/reset/mediatek,mt6735-infracfg.h
> +F:	include/dt-bindings/reset/mediatek,mt6735-mfgcfg.h
>  F:	include/dt-bindings/reset/mediatek,mt6735-pericfg.h
> +F:	include/dt-bindings/reset/mediatek,mt6735-vdecsys.h
> =20
>  MEDIATEK MT76 WIRELESS LAN DRIVER
>  M:	Felix Fietkau <nbd@nbd.name>
> diff --git a/include/dt-bindings/clock/mediatek,mt6735-imgsys.h b/include=
/dt-bindings/clock/mediatek,mt6735-imgsys.h
> new file mode 100644
> index 0000000000000..f250c26c5eb4d
> --- /dev/null
> +++ b/include/dt-bindings/clock/mediatek,mt6735-imgsys.h
> @@ -0,0 +1,15 @@
> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
> +
> +#ifndef _DT_BINDINGS_CLK_MT6735_IMGSYS_H
> +#define _DT_BINDINGS_CLK_MT6735_IMGSYS_H
> +
> +#define CLK_IMG_SMI_LARB2		0
> +#define CLK_IMG_CAM_SMI			1
> +#define CLK_IMG_CAM_CAM			2
> +#define CLK_IMG_SEN_TG			3
> +#define CLK_IMG_SEN_CAM			4
> +#define CLK_IMG_CAM_SV			5
> +#define CLK_IMG_SUFOD			6
> +#define CLK_IMG_FD			7
> +
> +#endif /* _DT_BINDINGS_CLK_MT6735_IMGSYS_H */
> diff --git a/include/dt-bindings/clock/mediatek,mt6735-mfgcfg.h b/include=
/dt-bindings/clock/mediatek,mt6735-mfgcfg.h
> new file mode 100644
> index 0000000000000..d2d99a48348a0
> --- /dev/null
> +++ b/include/dt-bindings/clock/mediatek,mt6735-mfgcfg.h
> @@ -0,0 +1,8 @@
> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
> +
> +#ifndef _DT_BINDINGS_CLK_MT6735_MFGCFG_H
> +#define _DT_BINDINGS_CLK_MT6735_MFGCFG_H
> +
> +#define CLK_MFG_BG3D			0
> +
> +#endif /* _DT_BINDINGS_CLK_MT6735_MFGCFG_H */
> diff --git a/include/dt-bindings/clock/mediatek,mt6735-vdecsys.h b/includ=
e/dt-bindings/clock/mediatek,mt6735-vdecsys.h
> new file mode 100644
> index 0000000000000..f94cec10c89ff
> --- /dev/null
> +++ b/include/dt-bindings/clock/mediatek,mt6735-vdecsys.h
> @@ -0,0 +1,9 @@
> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
> +
> +#ifndef _DT_BINDINGS_CLK_MT6735_VDECSYS_H
> +#define _DT_BINDINGS_CLK_MT6735_VDECSYS_H
> +
> +#define CLK_VDEC_VDEC			0
> +#define CLK_VDEC_SMI_LARB1		1
> +
> +#endif /* _DT_BINDINGS_CLK_MT6735_VDECSYS_H */
> diff --git a/include/dt-bindings/clock/mediatek,mt6735-vencsys.h b/includ=
e/dt-bindings/clock/mediatek,mt6735-vencsys.h
> new file mode 100644
> index 0000000000000..e5a9cb4f269ff
> --- /dev/null
> +++ b/include/dt-bindings/clock/mediatek,mt6735-vencsys.h
> @@ -0,0 +1,11 @@
> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
> +
> +#ifndef _DT_BINDINGS_CLK_MT6735_VENCSYS_H
> +#define _DT_BINDINGS_CLK_MT6735_VENCSYS_H
> +
> +#define CLK_VENC_SMI_LARB3			0
> +#define CLK_VENC_VENC			1
> +#define CLK_VENC_JPGENC			2
> +#define CLK_VENC_JPGDEC			3
> +
> +#endif /* _DT_BINDINGS_CLK_MT6735_VENCSYS_H */
> diff --git a/include/dt-bindings/reset/mediatek,mt6735-mfgcfg.h b/include=
/dt-bindings/reset/mediatek,mt6735-mfgcfg.h
> new file mode 100644
> index 0000000000000..c489242b226e2
> --- /dev/null
> +++ b/include/dt-bindings/reset/mediatek,mt6735-mfgcfg.h
> @@ -0,0 +1,9 @@
> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
> +
> +#ifndef _DT_BINDINGS_RESET_MT6735_MFGCFG_H
> +#define _DT_BINDINGS_RESET_MT6735_MFGCFG_H
> +
> +#define MT6735_MFG_RST0_AXI		0
> +#define MT6735_MFG_RST0_G3D		1
> +
> +#endif /* _DT_BINDINGS_RESET_MT6735_MFGCFG_H */
> diff --git a/include/dt-bindings/reset/mediatek,mt6735-vdecsys.h b/includ=
e/dt-bindings/reset/mediatek,mt6735-vdecsys.h
> new file mode 100644
> index 0000000000000..90ad73af50a3f
> --- /dev/null
> +++ b/include/dt-bindings/reset/mediatek,mt6735-vdecsys.h
> @@ -0,0 +1,10 @@
> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
> +
> +#ifndef _DT_BINDINGS_RESET_MT6735_VDECSYS_H
> +#define _DT_BINDINGS_RESET_MT6735_VDECSYS_H
> +
> +#define MT6735_VDEC_RST0_VDEC			0
> +
> +#define MT6735_VDEC_RST1_SMI_LARB1		1
> +
> +#endif /* _DT_BINDINGS_RESET_MT6735_VDECSYS_H */
> --=20
> 2.47.0
>=20

--ZXuBxhWPZaWXTuxG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZxaHtQAKCRB4tDGHoIJi
0vumAPwIGS1OkatMBdA7JBQ/k/ArAJ9clhu5Cv3etWlrGqWZwgD/X6ZWlsd5k88w
qd9HgL4SAxnpMRUPeiUkOmaN5qWsTAE=
=+NYr
-----END PGP SIGNATURE-----

--ZXuBxhWPZaWXTuxG--

