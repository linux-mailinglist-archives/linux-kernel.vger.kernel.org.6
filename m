Return-Path: <linux-kernel+bounces-551423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14548A56C42
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 16:38:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81CBF188F0C0
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 15:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 749EA21D3E0;
	Fri,  7 Mar 2025 15:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hb7UWL5h"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD83A21D01B;
	Fri,  7 Mar 2025 15:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741361880; cv=none; b=pXm99rNOpedM1OeM+pmLjb5VxgnVy9CMTPLquxsfDCm6DMetdXiMmdajr3l+jwOqL6MTC2fc0yx9jtpNuEFyn87HIC+OSPbrp5Ic2Kc3JxVzoHvIvJ5trBS0vE5y6GkkTusHBqtw/SglDR2ULk7IuRmAd9RjqOnAOM+SVNRqy7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741361880; c=relaxed/simple;
	bh=yN1dKWUGjtltzBE/WNByPB2L5yvAiNaSW2puRpSmGZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EsENm8ELF2XWyFfF9oiGFkARJfZ0CwWksjTOPW1fpY6hactu4VAGZ4jo71hZfJ4IwPMLvpMSvvnrBFBRcJNbZZubkv8DCVYvOBXQo/JVNm8EbRYkp/nmKPcqms2OCd8KlkjN0pJPGrvLQly1xwMj4IY5HyavIkmbPEcBu+1v+EE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hb7UWL5h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A64BC4CED1;
	Fri,  7 Mar 2025 15:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741361880;
	bh=yN1dKWUGjtltzBE/WNByPB2L5yvAiNaSW2puRpSmGZI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hb7UWL5h7uttVEAWxXxcGBZPDwSXkjXXYUYlIGcsycLnWgiNZTrVPf6ahCuMsRcjv
	 YL7tG606+7RziFoN1r5Y9xCm1dqvvYCHAvlsuqr9HZshGJxZfx7YK5UNO6foU2tPUj
	 o6uCDcmyhljV4Uvu2r3WlG66Kt9+Ja4VXchtHgkSvxmB3UEW/hdrdVam1zezjd59In
	 8MmduJpPRfE8P0Td8dbrBkh7vG/A9p9xPZonV8gRJOMKzs+0yum5aPXtvFoQe7rItU
	 39c45ZZMOT7r01FePYgpQ0UBuq82LoXOBUyaIeo2oXStAQGUtXGt9mN7kVmf2bGYcE
	 t6A7lH+GaDgNg==
Date: Fri, 7 Mar 2025 15:37:54 +0000
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
Subject: Re: [PATCH v4 1/4] dt-bindings: interrupt-controller: Add support
 for Amlogic A4 and A5 SoCs
Message-ID: <20250307-villain-blustery-8668e70cc005@spud>
References: <20250307-irqchip-gpio-a4-a5-v4-0-d03a9424151b@amlogic.com>
 <20250307-irqchip-gpio-a4-a5-v4-1-d03a9424151b@amlogic.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="uCezGwJWEIthy7K/"
Content-Disposition: inline
In-Reply-To: <20250307-irqchip-gpio-a4-a5-v4-1-d03a9424151b@amlogic.com>


--uCezGwJWEIthy7K/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 07, 2025 at 04:49:22PM +0800, Xianwei Zhao via B4 Relay wrote:
> From: Xianwei Zhao <xianwei.zhao@amlogic.com>
>=20
> Update dt-binding document for GPIO interrupt controller
> of Amlogic A4 and A5 SoCs
>=20
> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

> ---
>  .../interrupt-controller/amlogic,meson-gpio-intc.yaml | 19 +++++++++++++=
+++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/amlog=
ic,meson-gpio-intc.yaml b/Documentation/devicetree/bindings/interrupt-contr=
oller/amlogic,meson-gpio-intc.yaml
> index a93744763787..3d60d9e9e208 100644
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
> @@ -49,7 +52,7 @@ properties:
> =20
>    amlogic,channel-interrupts:
>      description: Array with the upstream hwirq numbers
> -    minItems: 8
> +    minItems: 2
>      maxItems: 12
>      $ref: /schemas/types.yaml#/definitions/uint32-array
> =20
> @@ -60,6 +63,20 @@ required:
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
> +      maxItems: 2
> +else:
> +  properties:
> +    amlogic,channel-interrupts:
> +      minItems: 8
> +
>  additionalProperties: false
> =20
>  examples:
>=20
> --=20
> 2.37.1
>=20
>=20

--uCezGwJWEIthy7K/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ8sS0gAKCRB4tDGHoIJi
0tLcAP0ab+eCyxWATmSaxQwJSP8SxJFf5vnViJI7+FDedfojRgEAqJJlUHhpTFfu
RHSHT6nbo2scx2atcuuOt9dgB0VPpwA=
=n9nr
-----END PGP SIGNATURE-----

--uCezGwJWEIthy7K/--

