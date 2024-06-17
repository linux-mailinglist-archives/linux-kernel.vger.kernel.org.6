Return-Path: <linux-kernel+bounces-217964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8982490B6F6
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 18:48:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CB001F2458E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 16:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49258166305;
	Mon, 17 Jun 2024 16:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R194lI59"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84EC61D953D;
	Mon, 17 Jun 2024 16:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718642859; cv=none; b=Z8xvX4esY2060Ovrj3s3xFoTRlLipPFaxSN+eED6WiDlt+qji/qPRp4G2hJEMjoscJ1GeC4+8jqXJd+P98Q5zqsj+cM4BLLg4c86MK6cGZr80U5kEmM/DC1i4vaiPXGGgUYshvVmL3Kfcfg8Y6QjZG6iXdfD639DLR0bfNocYdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718642859; c=relaxed/simple;
	bh=ExhDcZ4//zTNSSYj74RmnlQmZzjz1qUm2+2ZmpYR86Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=up7hpHKsaJtvhAr1p5Dyf4tkNLRBngvXO8MS8z6PmHga8SRWqbPeW8+S9fMAcaK3zqAUH6WsgQMXkwluWr54ueWqcuLHgxrJqhQAFlm2f9YzJLP5CnfEOSlh11OBDp1CgzIFtRBNbpN/y+z2aRnP9XKIZW3gRO5XwF4Y3YGiNuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R194lI59; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E0CCC3277B;
	Mon, 17 Jun 2024 16:47:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718642859;
	bh=ExhDcZ4//zTNSSYj74RmnlQmZzjz1qUm2+2ZmpYR86Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R194lI59CkumFpQX1GcvmvdU4pUe9jICkjfIBKTOFJzSsR8bfBU2zgrqwc8vHwstG
	 nNBLREq+rOsEToxk8ocZa4rjMzl497x11FZFfvdNnnQNLSCy2VuHh8j+vPsazeQ7np
	 jS/YXVIPyfurmqwDaf14Moc6j8PN90pPyLul6FBnC9DBTTyiSeyhFOAlqA2xoYhyTV
	 g5HPZh7GPGso7hCR86KaRz3SwvFwhaZn7kdQ+qR+lwCO0UFGRsE+LCODu0LA9hs0wI
	 2riu/8B1FuWuK3t3T4D0J6z5wLg9OSQmPjudurW/qiePm/uzWtII0wT/FJFkQKeJ9Q
	 vkxaYB+dEs22A==
Date: Mon, 17 Jun 2024 17:47:32 +0100
From: Conor Dooley <conor@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>,
	Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>,
	Jacky Huang <ychuang3@nuvoton.com>,
	Shan-Chun Hung <schung@nuvoton.com>,
	Khuong Dinh <khuong@os.amperecomputing.com>,
	Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lars Povlsen <lars.povlsen@microchip.com>,
	Steen Hegelund <Steen.Hegelund@microchip.com>,
	Daniel Machon <daniel.machon@microchip.com>,
	UNGLinuxDriver@microchip.com, Nishanth Menon <nm@ti.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2 3/7] dt-bindings: soc: intel: lgm-syscon: Move to
 dedicated schema
Message-ID: <20240617-overnight-chevron-cd481dbc59ba@spud>
References: <20240616-dt-bindings-mfd-syscon-split-v2-0-571b5850174a@linaro.org>
 <20240616-dt-bindings-mfd-syscon-split-v2-3-571b5850174a@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="8k1Yhdbf/8He0O/S"
Content-Disposition: inline
In-Reply-To: <20240616-dt-bindings-mfd-syscon-split-v2-3-571b5850174a@linaro.org>


--8k1Yhdbf/8He0O/S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 16, 2024 at 03:19:23PM +0200, Krzysztof Kozlowski wrote:
> intel,lgm-syscon is not a simple syscon device - it has children - thus
> it should be fully documented in its own binding.
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>=20
> ---
>=20
> Context might depend on patch in Lee's MFD tree:
> https://lore.kernel.org/all/171828959006.2643902.8308227314531523435.b4-t=
y@kernel.org/
> and also further patches here depend on this one.
> ---
>  Documentation/devicetree/bindings/mfd/syscon.yaml  |  1 -
>  .../bindings/soc/intel/intel,lgm-syscon.yaml       | 56 ++++++++++++++++=
++++++
>  2 files changed, 56 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/mfd/syscon.yaml b/Document=
ation/devicetree/bindings/mfd/syscon.yaml
> index af442767aa96..b9bf5bc05e92 100644
> --- a/Documentation/devicetree/bindings/mfd/syscon.yaml
> +++ b/Documentation/devicetree/bindings/mfd/syscon.yaml
> @@ -77,7 +77,6 @@ properties:
>                - hisilicon,pcie-sas-subctrl
>                - hisilicon,peri-subctrl
>                - hpe,gxp-sysreg
> -              - intel,lgm-syscon
>                - loongson,ls1b-syscon
>                - loongson,ls1c-syscon
>                - lsi,axxia-syscon
> diff --git a/Documentation/devicetree/bindings/soc/intel/intel,lgm-syscon=
=2Eyaml b/Documentation/devicetree/bindings/soc/intel/intel,lgm-syscon.yaml
> new file mode 100644
> index 000000000000..0a73b7616a60
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/intel/intel,lgm-syscon.yaml
> @@ -0,0 +1,56 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/soc/intel/intel,lgm-syscon.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Intel Lightning Mountain(LGM) Syscon
> +
> +maintainers:
> +  - Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.=
com>

This email is bouncing FYI.

--8k1Yhdbf/8He0O/S
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZnBopAAKCRB4tDGHoIJi
0mU6AQCMelblVQzCR1QbJoBZ8rkW9ROijWRXui1XEUzgGVthiwD/aGWKRDu2jypE
UOhojA9+yW0IbmsZ7KSU00OLDZkwLwk=
=EkUU
-----END PGP SIGNATURE-----

--8k1Yhdbf/8He0O/S--

