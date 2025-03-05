Return-Path: <linux-kernel+bounces-547253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6858A504F0
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 17:33:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F034177D1F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 16:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EE88194A75;
	Wed,  5 Mar 2025 16:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GxrtDGNC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA8E567D;
	Wed,  5 Mar 2025 16:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741192101; cv=none; b=f84QtdsKI9ctux2uPFh+rJTW2TqJRHngClXH9+oPrOtiJmJ7iWRKQX9RxqLGtsf7lRmUdmPYPg5gG9yr1K4wE+0FAq5ArgnyrYdOwi1NnQznAS2i1E4G5Wt8n2JVIbHBfTVYKvFH99Q/C2iRYtS4KDqT8jgwim3W2693Extbzr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741192101; c=relaxed/simple;
	bh=k6csO67vDrMnXIexjx2So/2QNSl6gZamVG0l1qJBY1o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lHPbG/BibU40/PlxCMnNmEMuSWP8yArkTI6gE82KA4Hm89iMoywN5SEEwuTuZtsSsjQdD/6ohWQQqCFwrbRsyAWrPplA22vkOYsD+u/IKHJBx/hc1hyPboJMmuBdgxYOkj0xVuBHAmjKWVQI73WtR2wepxWfTf4plxZkM7j2JOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GxrtDGNC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81834C4CED1;
	Wed,  5 Mar 2025 16:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741192101;
	bh=k6csO67vDrMnXIexjx2So/2QNSl6gZamVG0l1qJBY1o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GxrtDGNC3NypBKUNs8Dbgy7duGDWhk7EV2KWkLlu67Su+A4Zd7xCnBB6t/DAFWyKJ
	 s9p10W6UQbieQuyLUUT3RKnOeLzZ0jVKT0NADLxLzQXyx66A0ytCkG8X2bG/Hfbi1u
	 vVcYpD+x28L+JM0GX6YsHw+40QaB52VuYl0ptky9bMR03CEI1bJLbNLbTcZVL42HFS
	 T2wCppU9rkXCEcQnG5MIrmNHG0Rg8NW318+iH7kx42+dWDHIvJijmQEltgLQRMfCMG
	 9Pmewl+OqduWV67YNEjWASglYwJOtXWFr0Ks8r4wPmr29LusnVmTlPsVoxxIUPZ6sk
	 RBgjGrumuAK6g==
Date: Wed, 5 Mar 2025 16:28:16 +0000
From: Conor Dooley <conor@kernel.org>
To: xianwei.zhao@amlogic.com
Cc: Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org
Subject: Re: [PATCH v3 1/4] dt-bindings: interrupt-controller: Add support
 for Amlogic A4 and A5 SoCsy
Message-ID: <20250305-corral-unfair-a7f25abbfd64@spud>
References: <20250305-irqchip-gpio-a4-a5-v3-0-1eec70352fea@amlogic.com>
 <20250305-irqchip-gpio-a4-a5-v3-1-1eec70352fea@amlogic.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="MMuZ/eZR8DrqmyMW"
Content-Disposition: inline
In-Reply-To: <20250305-irqchip-gpio-a4-a5-v3-1-1eec70352fea@amlogic.com>


--MMuZ/eZR8DrqmyMW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 05, 2025 at 06:02:56PM +0800, Xianwei Zhao via B4 Relay wrote:
> From: Xianwei Zhao <xianwei.zhao@amlogic.com>
>=20
> Update dt-binding document for GPIO interrupt controller
> of Amlogic A4 and A5 SoCs
>=20
> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
> ---
>  .../amlogic,meson-gpio-intc.yaml                    | 21 +++++++++++++++=
++++--
>  1 file changed, 19 insertions(+), 2 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/amlog=
ic,meson-gpio-intc.yaml b/Documentation/devicetree/bindings/interrupt-contr=
oller/amlogic,meson-gpio-intc.yaml
> index a93744763787..3c5853c71efa 100644
> --- a/Documentation/devicetree/bindings/interrupt-controller/amlogic,meso=
n-gpio-intc.yaml
> +++ b/Documentation/devicetree/bindings/interrupt-controller/amlogic,meso=
n-gpio-intc.yaml
> @@ -35,6 +35,9 @@ properties:
>                - amlogic,meson-sm1-gpio-intc
>                - amlogic,meson-a1-gpio-intc
>                - amlogic,meson-s4-gpio-intc
> +              - amlogic,a4-gpio-intc
> +              - amlogic,a4-gpio-ao-intc
> +              - amlogic,a5-gpio-intc
>                - amlogic,c3-gpio-intc
>                - amlogic,t7-gpio-intc
>            - const: amlogic,meson-gpio-intc
> @@ -49,8 +52,6 @@ properties:
> =20
>    amlogic,channel-interrupts:
>      description: Array with the upstream hwirq numbers
> -    minItems: 8
> -    maxItems: 12

Please leave the widest constraints here, and let the more restricted
ones in your if/else below.

>      $ref: /schemas/types.yaml#/definitions/uint32-array
> =20
>  required:
> @@ -60,6 +61,22 @@ required:
>    - "#interrupt-cells"
>    - amlogic,channel-interrupts
> =20
> +if:
> +  properties:
> +    compatible:
> +      contains:
> +        const: amlogic,a4-gpio-ao-intc
> +then:
> +  properties:
> +    amlogic,channel-interrupts:
> +      minItems: 2
> +      maxItems: 12
> +else:
> +  properties:
> +    amlogic,channel-interrupts:
> +      minItems: 8
> +      maxItems: 12
> +
>  additionalProperties: false
> =20
>  examples:
>=20
> --=20
> 2.37.1
>=20
>=20

--MMuZ/eZR8DrqmyMW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ8h7oAAKCRB4tDGHoIJi
0h1GAP9khO8ylB5zlNKs4uW4bc5TRHhnmWk5xx6QOLvsYcAUWgEAiN0yW0agWWR/
qQUvLSvAvFW7/l6X9Sym1jqe28wIRwM=
=RNx5
-----END PGP SIGNATURE-----

--MMuZ/eZR8DrqmyMW--

