Return-Path: <linux-kernel+bounces-301786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55FBA95F58D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 17:50:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A72BB21899
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 15:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB0D1194124;
	Mon, 26 Aug 2024 15:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r0de/vYF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA43A192B79;
	Mon, 26 Aug 2024 15:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724687438; cv=none; b=I6diQCD13qdLneseeYVlsujyUM6MZA6b28kW4GYO8AjFx4xg9NjCG4hnhMWVJy+GFeLrjWNtU1naSLeT+T3pYjdmviNq85pcEgHXHACCJvYeeOL0A7wK1k5jp0tOUDtjnpCXTPiH2e4D9ZOk4RJmGrXdbCuUpiStsvr3MK9LovY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724687438; c=relaxed/simple;
	bh=ktxTLHI62m07O4aByHNtqdVU4NHYWDBoMv9Kczki3Rs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fbvsdVVZrJ9NudF0BPkb9ooCDiItGDhR6WI+YzE6F20Rstt+BFF6oArKrUOShqJHX/12obqRE+vl2+nWHXMiJ5xDd94Zeg2f76CaI4+7utvpT7yEIZ3KpEbnVzIhE6l2JYml6ytaRk7cx8VMcZ54JyJZlPhczmXl6hu250KeTR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r0de/vYF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF966C4FF57;
	Mon, 26 Aug 2024 15:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724687438;
	bh=ktxTLHI62m07O4aByHNtqdVU4NHYWDBoMv9Kczki3Rs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r0de/vYF8OEWJOWzCY7dYubWPfWUHk5m6z1Z/5T2AqlxcRxn39H+cl2W+d9TSlRqT
	 V1Kt+welB3O3YMFUfE4Au9oon6Nlx40aZUi3skZF8XIZr/YiBRcq/Opoz0QM6xRk8h
	 N0HCiuhDBPzTWKadM/uUYZwV3SH3ejXLpKq7wFqqYfTxql28ALtynebpplP323aJkZ
	 znopSFVVGtjJgpO3q2VbkH0IXhY0v7jau3yv87nMGFZITaMC5LfEfheFQLS9y018aY
	 1w+VoxyjJDFtzMoK4qiFLIg81MmjB/ADouNjejhsAl0mY2Lt6oDafHRXr9IrBYQTCz
	 yo0yQ5W0PfH7A==
Date: Mon, 26 Aug 2024 16:50:32 +0100
From: Conor Dooley <conor@kernel.org>
To: Macpaul Lin <macpaul.lin@mediatek.com>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
	Alexandre Mergnat <amergnat@baylibre.com>,
	Flora Fu <flora.fu@mediatek.com>,
	Bear Wang <bear.wang@mediatek.com>,
	Pablo Sun <pablo.sun@mediatek.com>, Macpaul Lin <macpaul@gmail.com>,
	Sen Chu <sen.chu@mediatek.com>,
	Chris-qj chen <chris-qj.chen@mediatek.com>,
	MediaTek Chromebook Upstream <Project_Global_Chrome_Upstream_Group@mediatek.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
	Chen-Yu Tsai <wenst@chromium.org>
Subject: Re: [PATCH] dt-bindings: mfd: mediatek,mt6357: Fixup reference to
 pwrap node
Message-ID: <20240826-slurp-earphone-0d5173923ae8@spud>
References: <20240826065415.19641-1-macpaul.lin@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="50OsiPZgodBAcn76"
Content-Disposition: inline
In-Reply-To: <20240826065415.19641-1-macpaul.lin@mediatek.com>


--50OsiPZgodBAcn76
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 26, 2024 at 02:54:15PM +0800, Macpaul Lin wrote:
> The mt6357 is a subnode of pwrap node. Previously, the documentation
> only included a note in the description of mt6357. This change adds the
> appropriate $ref for pwrap to ensure clarity and correctness.

I think this change is wrong and the existing binding is fine.
Adding the ref overcomplicates the binding completely, and stating that
this is a child node of another device is sufficient.

Instead, if anything, the pwrap binding should have a ref to /this/
binding.

Thanks,
Conor.

>=20
>   $ref: /schemas/soc/mediatek/mediatek,pwrap.yaml
>=20
> Additionally, the indentation for the pmic section has been adjusted
> to match the corresponding structure.
>=20
> Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
> ---
>  .../bindings/mfd/mediatek,mt6357.yaml         | 124 +++++++++---------
>  1 file changed, 65 insertions(+), 59 deletions(-)
>=20
> Changes for v1:
>  - This patch has been made based on linux-next/master branch.
>=20
> diff --git a/Documentation/devicetree/bindings/mfd/mediatek,mt6357.yaml b=
/Documentation/devicetree/bindings/mfd/mediatek,mt6357.yaml
> index b67fbe0..5f4f540 100644
> --- a/Documentation/devicetree/bindings/mfd/mediatek,mt6357.yaml
> +++ b/Documentation/devicetree/bindings/mfd/mediatek,mt6357.yaml
> @@ -22,69 +22,75 @@ description: |
> =20
>    It is interfaced to host controller using SPI interface by a proprieta=
ry hardware
>    called PMIC wrapper or pwrap. This MFD is a child device of pwrap.
> -  See the following for pwrap node definitions:
> -  Documentation/devicetree/bindings/soc/mediatek/mediatek,pwrap.yaml
> =20
>  properties:
> -  compatible:
> -    const: mediatek,mt6357
> -
> -  interrupts:
> -    maxItems: 1
> -
> -  interrupt-controller: true
> -
> -  "#interrupt-cells":
> -    const: 2
> -
> -  mediatek,hp-pull-down:
> -    description:
> -      Earphone driver positive output stage short to
> -      the audio reference ground.
> -    type: boolean
> -
> -  mediatek,micbias0-microvolt:
> -    description: Selects MIC Bias 0 output voltage.
> -    enum: [1700000, 1800000, 1900000, 2000000,
> -           2100000, 2500000, 2600000, 2700000]
> -    default: 1700000
> -
> -  mediatek,micbias1-microvolt:
> -    description: Selects MIC Bias 1 output voltage.
> -    enum: [1700000, 1800000, 1900000, 2000000,
> -           2100000, 2500000, 2600000, 2700000]
> -    default: 1700000
> -
> -  regulators:
> -    type: object
> -    $ref: /schemas/regulator/mediatek,mt6357-regulator.yaml
> -    unevaluatedProperties: false
> -    description:
> -      List of MT6357 BUCKs and LDOs regulators.
> -
> -  rtc:
> +  pwrap:
>      type: object
> -    $ref: /schemas/rtc/rtc.yaml#
> -    unevaluatedProperties: false
> -    description:
> -      MT6357 Real Time Clock.
> +    $ref: /schemas/soc/mediatek/mediatek,pwrap.yaml
>      properties:
> -      compatible:
> -        const: mediatek,mt6357-rtc
> -      start-year: true
> -    required:
> -      - compatible
> -
> -  keys:
> -    type: object
> -    $ref: /schemas/input/mediatek,pmic-keys.yaml
> -    unevaluatedProperties: false
> -    description:
> -      MT6357 power and home keys.
> -
> -required:
> -  - compatible
> -  - regulators
> +      pmic:
> +        type: object
> +        additionalProperties: false
> +        properties:
> +          compatible:
> +            const: mediatek,mt6357
> +
> +          interrupts:
> +            maxItems: 1
> +
> +          interrupt-controller: true
> +
> +          "#interrupt-cells":
> +            const: 2
> +
> +          mediatek,hp-pull-down:
> +            description:
> +              Earphone driver positive output stage short to
> +              the audio reference ground.
> +            type: boolean
> +
> +          mediatek,micbias0-microvolt:
> +            description: Selects MIC Bias 0 output voltage.
> +            enum: [1700000, 1800000, 1900000, 2000000,
> +                   2100000, 2500000, 2600000, 2700000]
> +            default: 1700000
> +
> +          mediatek,micbias1-microvolt:
> +            description: Selects MIC Bias 1 output voltage.
> +            enum: [1700000, 1800000, 1900000, 2000000,
> +                   2100000, 2500000, 2600000, 2700000]
> +            default: 1700000
> +
> +          regulators:
> +            type: object
> +            $ref: /schemas/regulator/mediatek,mt6357-regulator.yaml
> +            unevaluatedProperties: false
> +            description:
> +              List of MT6357 BUCKs and LDOs regulators.
> +
> +          rtc:
> +            type: object
> +            $ref: /schemas/rtc/rtc.yaml#
> +            unevaluatedProperties: false
> +            description:
> +              MT6357 Real Time Clock.
> +            properties:
> +              compatible:
> +                const: mediatek,mt6357-rtc
> +              start-year: true
> +            required:
> +              - compatible
> +
> +          keys:
> +            type: object
> +            $ref: /schemas/input/mediatek,pmic-keys.yaml
> +            unevaluatedProperties: false
> +            description:
> +              MT6357 power and home keys.
> +
> +        required:
> +          - compatible
> +          - regulators
> =20
>  additionalProperties: false
> =20
> --=20
> 2.45.2
>=20
>=20

--50OsiPZgodBAcn76
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZsykSAAKCRB4tDGHoIJi
0gYAAQCGfMBFaDP6ivfMJJBwfUboQER1rC8YTMNL4nNMsiTnyQD/baclX5aCHVJi
8ubJmmeyqBJRPWK/Nw5vmepd5ePRKwg=
=JZUq
-----END PGP SIGNATURE-----

--50OsiPZgodBAcn76--

