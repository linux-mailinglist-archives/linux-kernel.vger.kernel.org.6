Return-Path: <linux-kernel+bounces-286550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 159BB951C61
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 15:59:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF2871F22A11
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 13:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF75E1B1505;
	Wed, 14 Aug 2024 13:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bo7J5Iya"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2ACCC148;
	Wed, 14 Aug 2024 13:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723643959; cv=none; b=VMRf04h8b019LYpryddpOpsImdc3IViumSATHfx8IbfXjoxV+bSc29jNzfvxxZ+IA2ixuhfnNfxrA0ocSdckrocu8o8Bm07H99iqTQG0XcAzENuxl1sFrUhdp4WhAXQNfpPfOBskfLpuglUR+M9j7pay38Y7MLp7aQK//Ea+N5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723643959; c=relaxed/simple;
	bh=i2XInDiKAjKFZ/WCnSnrMBUbrC57+wTSUjcr1ZI14hU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WHvmlvuflI/b6u5Nk/YEHJhgzJfV/CzQWKz2wnie5Ppm6b+BhYjsqDMvtw1VrNr2kAGhdm6TDZO39C/b/O1a+as4wviiTKQzErOSImKrmC/ILUUBOtnYUgIpYUP9fsm1Www9NQR9x4zYZf3a0BM4UfRnfKCObXn7v3UEdfMhDeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bo7J5Iya; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83D39C116B1;
	Wed, 14 Aug 2024 13:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723643958;
	bh=i2XInDiKAjKFZ/WCnSnrMBUbrC57+wTSUjcr1ZI14hU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bo7J5IyaqAZMcWE4jq4EC8jYNr+t8VU8JaJ5Bd8iOtVmU6W3X9tLeALH897enyLil
	 MpSE8dU/ZQUdowOK3CPs+Gc+l93MZlzDQRiSKKrcLVnHkQqBGwQpH3BisUkMKM3k9l
	 A0dkvNt7N4+IXssfHSjVGsmtKIsKal7ApNc7wJm+px5eNjgV6LoI23u+ScWNoVOYML
	 ER9UyXniAiDGDTZpOJ3si8EkLMINPkneifqHka2tEOGbqAHHDo3LnMeu31ipL4ydlX
	 KgeRUzXx1C1lWrTixV1g/wXxYAc0NfSBnMxapyjHORCAIAqoH74u3l2QZdMrJcT3hu
	 jiqbh3rGANdyg==
Date: Wed, 14 Aug 2024 14:59:11 +0100
From: Conor Dooley <conor@kernel.org>
To: Manikandan Muralidharan <manikandan.m@microchip.com>
Cc: andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org,
	Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
	jernej.skrabec@gmail.com, airlied@gmail.com, daniel@ffwll.ch,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, linux@armlinux.org.uk,
	nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev, arnd@arndb.de, geert+renesas@glider.be,
	mpe@ellerman.id.au, rdunlap@infradead.org, dharma.b@microchip.com,
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 1/4] dt-bindings: display: bridge: add
 sam9x75-mipi-dsi binding
Message-ID: <20240814-anaerobic-unpainted-532b8b117b79@spud>
References: <20240814105256.177319-1-manikandan.m@microchip.com>
 <20240814105256.177319-2-manikandan.m@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="+8ausa8IKd49KxfE"
Content-Disposition: inline
In-Reply-To: <20240814105256.177319-2-manikandan.m@microchip.com>


--+8ausa8IKd49KxfE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 14, 2024 at 04:22:53PM +0530, Manikandan Muralidharan wrote:
> Add the 'sam9x75-mipi-dsi' compatible binding, which describes the
> Microchip's specific wrapper for the Synopsys DesignWare MIPI DSI HOST
> Controller for the sam9x75 series System-on-Chip (SoC) devices.
>=20
> Signed-off-by: Manikandan Muralidharan <manikandan.m@microchip.com>
> ---
> changes in v3:
> - Describe the clocks used
>=20
> changes in v2:
> - List the clocks with description
> - remove describing 'remove-endpoint' properties
> - remove unused label, node and fix example DT indentation
> - cosmetic fixes
> ---
>  .../bridge/microchip,sam9x75-mipi-dsi.yaml    | 116 ++++++++++++++++++
>  1 file changed, 116 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/bridge/micr=
ochip,sam9x75-mipi-dsi.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/display/bridge/microchip,s=
am9x75-mipi-dsi.yaml b/Documentation/devicetree/bindings/display/bridge/mic=
rochip,sam9x75-mipi-dsi.yaml
> new file mode 100644
> index 000000000000..3c86f0cd49e9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/bridge/microchip,sam9x75-=
mipi-dsi.yaml
> @@ -0,0 +1,116 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/bridge/microchip,sam9x75-mipi=
-dsi.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Microchip SAM9X75 MIPI DSI Controller
> +
> +maintainers:
> +  - Manikandan Muralidharan <manikandan.m@microchip.com>
> +
> +description:
> +  Microchip specific extensions or wrapper to the Synopsys Designware MI=
PI DSI.
> +  The MIPI Display Serial Interface (DSI) Host Controller implements all
> +  protocol functions defined in the MIPI DSI Specification.The DSI Host
> +  provides an interface between the LCD Controller (LCDC) and the MIPI D=
-PHY,
> +  allowing communication with a DSI-compliant display.
> +
> +allOf:
> +  - $ref: /schemas/display/dsi-controller.yaml#
> +
> +properties:
> +  compatible:
> +    const: microchip,sam9x75-mipi-dsi
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description:
> +          Peripheral Bus Clock between LCDC and MIPI DPHY
> +      - description:
> +          MIPI DPHY Interface reference clock for PLL block
> +
> +  clock-names:
> +    items:
> +      - const: pclk
> +      - const: refclk
> +
> +  microchip,sfr:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description:
> +      phandle to Special Function Register (SFR) node.To enable the DSI/=
CSI
> +      selection bit in SFR's ISS Configuration Register.

I'm curious - why is this phandle required? How many SFR nodes are there
on the platform?

--+8ausa8IKd49KxfE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZry4LwAKCRB4tDGHoIJi
0jgGAQCNlJez7U3bg6KubO9BcmyXeM+Ooq60GqLPvS/jU0f6LgD/ep76NL779/5C
MBFLfGv3IMIHjffXUIBEpJSOsnvPnAI=
=UfmW
-----END PGP SIGNATURE-----

--+8ausa8IKd49KxfE--

