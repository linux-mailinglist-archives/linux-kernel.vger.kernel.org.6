Return-Path: <linux-kernel+bounces-217940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A736890B696
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 18:37:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D7A7283B26
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 16:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B550515FA61;
	Mon, 17 Jun 2024 16:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NHLPPlKI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCA9914AD30;
	Mon, 17 Jun 2024 16:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718642239; cv=none; b=r2FMf1I/RUwLfSWL0Jxal4/PROEavhfDHgQdK3lSpzXwt52stnWEvTdiR3YShfnZGSmN2d8wLzWfLyMS5QuLr+6W7Va8K4ylwZ6CIAoXYu3DK5s4rWcN/sHf1evY4axSo0naKLnzkgnx19Wex5+mFQn9RF/1EDA6DGvvB6M07tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718642239; c=relaxed/simple;
	bh=bsNHKljQ8dUGrH+H3y8GxXgXhqd8CbqoOjh9i6Fjd88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ndMU0wBPZ/ROvxFPcZoMWgtc35gXcyl3BFZJE/4NEv6AEJaZjj+IturdLsB1vL5pvLpKxDv7nzZRYHa3FUo8Kfe7IxLtBocyxY4yrn9ZiA+PjjlbkRAiwUfkZ0WxvZJSFIaQzMdPk++DfY0wrSjNWhUzpogIwLvD1NC0idI8TiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NHLPPlKI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D5D4C2BD10;
	Mon, 17 Jun 2024 16:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718642239;
	bh=bsNHKljQ8dUGrH+H3y8GxXgXhqd8CbqoOjh9i6Fjd88=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NHLPPlKILApQ3qXvYxiUtwf9WK3LMRlGFpZqtRT+w1tUpyYsz/GNcSVWtDZxFyxRx
	 DgTkZEXBY6mvEMyx+Vg+7j23Tq7x2rVbfQvzAS+szzJUKCZVjNIHFfj2pIgZd33Vil
	 WwVpGoGMruW5ETMntI+Hbbi79yJx+fwtzCiBBPHFRzBVNmbIrkeumxU+khcHFg38u0
	 Qvoc26DZUCRCP5CaIo/BLwBrd/9rQat0T/54JmoKyrywkQVjjF1TA9R2EhJbZXzPn3
	 xoh+CSMwfYFTkCK5VwDtQ8dkZJ7L9dGTlnUXfxL9xx+Y8yIiMdoE5xawYK2DxtX2aV
	 cSVgNQL9LPWkQ==
Date: Mon, 17 Jun 2024 17:37:14 +0100
From: Conor Dooley <conor@kernel.org>
To: Pankaj Gupta <pankaj.gupta@nxp.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 2/5] dt-bindings: arm: fsl: add imx-se-fw binding doc
Message-ID: <20240617-control-calamari-317f59c4eb09@spud>
References: <20240617-imx-se-if-v3-0-a7d28dea5c4a@nxp.com>
 <20240617-imx-se-if-v3-2-a7d28dea5c4a@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="XREzqQ352E1T40zH"
Content-Disposition: inline
In-Reply-To: <20240617-imx-se-if-v3-2-a7d28dea5c4a@nxp.com>


--XREzqQ352E1T40zH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 17, 2024 at 12:59:40PM +0530, Pankaj Gupta wrote:
> The NXP security hardware IP(s) like: i.MX EdgeLock Enclave, V2X etc.,
> creates an embedded secure enclave within the SoC boundary to enable
> features like:
> - HSM
> - SHE
> - V2X
>=20
> Secure-Enclave(s) communication interface are typically via message
> unit, i.e., based on mailbox linux kernel driver. This driver enables
> communication ensuring well defined message sequence protocol between
> Application Core and enclave's firmware.
>=20
> Driver configures multiple misc-device on the MU, for multiple
> user-space applications, to be able to communicate over single MU.
>=20
> It exists on some i.MX processors. e.g. i.MX8ULP, i.MX93 etc.
>=20
> Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
> ---
>  .../devicetree/bindings/firmware/fsl,imx-se.yaml   | 160 +++++++++++++++=
++++++
>  1 file changed, 160 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/firmware/fsl,imx-se.yaml b=
/Documentation/devicetree/bindings/firmware/fsl,imx-se.yaml
> new file mode 100644
> index 000000000000..60ad1c4a3dfa
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/firmware/fsl,imx-se.yaml
> @@ -0,0 +1,160 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/firmware/fsl,imx-se.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NXP i.MX HW Secure Enclave(s) EdgeLock Enclave
> +
> +maintainers:
> +  - Pankaj Gupta <pankaj.gupta@nxp.com>
> +
> +description: |
> +  NXP's SoC may contain one or multiple embedded secure-enclave HW
> +  IP(s) like i.MX EdgeLock Enclave, V2X etc. These NXP's HW IP(s)
> +  enables features like
> +    - Hardware Security Module (HSM),
> +    - Security Hardware Extension (SHE), and
> +    - Vehicular to Anything (V2X)
> +
> +  Communication interface to the secure-enclaves is based on the
> +  messaging unit(s).
> +
> +properties:
> +  $nodename:
> +    pattern: "^[0-9a-z]*-if@[0-9a-f]+$"

Just "firmware@<hex>" please.

> +
> +  compatible:
> +    enum:
> +      - fsl,imx8ulp-se
> +      - fsl,imx93-se
> +      - fsl,imx95-se
> +
> +  reg:
> +    maxItems: 1
> +    description: Identifier of the communication interface to secure-enc=
lave.
> +
> +  mboxes:
> +    description: contain a list of phandles to mailboxes.
> +    items:
> +      - description: Specify the mailbox used to send message to se firm=
ware
> +      - description: Specify the mailbox used to receive message from se=
 firmware
> +
> +  mbox-names:
> +    items:
> +      - const: tx
> +      - const: rx
> +      - const: txdb
> +      - const: rxdb
> +    minItems: 2
> +
> +  memory-region:
> +    description: contains a list of phandles to reserved external memory.
> +    items:
> +      - description: It is used by secure-enclave firmware. It is an opt=
ional
> +          property based on compatible and identifier to communication i=
nterface.
> +          (see bindings/reserved-memory/reserved-memory.txt)
> +
> +  sram:
> +    description: contains a list of phandles to sram.

There's only 1 phandle allowed, don't describe it as a list.
Same for memory-region.

> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    items:
> +      - description: Phandle to the device SRAM. It is an optional prope=
rty
> +          based on compatible and identifier to communication interface.
> +
> +allOf:
> +  # memory-region
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - fsl,imx8ulp-se
> +              - fsl,imx93-se
> +    then:
> +      required:
> +        - memory-region

> +    else:
> +      not:
> +        required:
> +          - memory-region

Use

else: properties: memory-region: false

Same for sram. Sort the allOf after required.

> +
> +  # sram
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - fsl,imx8ulp-se
> +    then:
> +      required:
> +        - sram
> +    else:
> +      not:
> +        required:
> +          - sram
> +
> +required:
> +  - compatible
> +  - reg
> +  - mboxes
> +  - mbox-names
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    firmware {

You've made up these firmware "buses" here, what purpose do they serve,
other than allowing you to have a reg property?

> +      #address-cells =3D <1>;
> +      #size-cells =3D <0>;
> +      ele-if@0 {
> +        compatible =3D "fsl,imx8ulp-se";
> +        reg =3D <0x0>;

What does the reg property even do? Is it ever more than 0? Can this
information be provided as a mbox cell?

> +        mboxes =3D <&s4muap 0 0>, <&s4muap 1 0>;
> +        mbox-names =3D "tx", "rx";
> +        sram =3D <&sram0>;
> +        memory-region =3D <&ele_reserved>;
> +      };
> +    };
> +  - |
> +    firmware {

These examples are all basically the same, drop all but one.

Thanks,
Conor.

> +      #address-cells =3D <1>;
> +      #size-cells =3D <0>;
> +      ele-if@0 {
> +        compatible =3D "fsl,imx93-se";
> +        reg =3D <0x0>;
> +        mboxes =3D <&s4muap 0 0>, <&s4muap 1 0>;
> +        mbox-names =3D "tx", "rx";
> +        memory-region =3D <&ele_reserved>;
> +      };
> +    };
> +  - |
> +    firmware {
> +      #address-cells =3D <1>;
> +      #size-cells =3D <0>;
> +      ele-if@0 {
> +        compatible =3D "fsl,imx95-se";
> +        reg =3D <0x0>;
> +        mboxes =3D <&ele_mu0 0 0>, <&ele_mu0 1 0>;
> +        mbox-names =3D "tx", "rx";
> +      };
> +      v2x-if@3 {
> +        compatible =3D "fsl,imx95-se";
> +        reg =3D <0x3>;
> +        mboxes =3D <&v2x_mu 0 0>, <&v2x_mu 1 0>;
> +        mbox-names =3D "tx", "rx";
> +      };
> +      v2x-if@4 {
> +        compatible =3D "fsl,imx95-se";
> +        reg =3D <0x4>;
> +        mboxes =3D <&v2x_mu6 0 0>, <&v2x_mu6 1 0>;
> +        mbox-names =3D "tx", "rx";
> +      };
> +      v2x-if@5 {
> +        compatible =3D "fsl,imx95-se";
> +        reg =3D <0x5>;
> +        mboxes =3D <&v2x_mu7 0 0>, <&v2x_mu7 1 0>;
> +        mbox-names =3D "tx", "rx";
> +      };
> +    };
> +...
>=20
> --=20
> 2.34.1
>=20

--XREzqQ352E1T40zH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZnBmOQAKCRB4tDGHoIJi
0tAXAP402pvcioC0DaeOXVskX4negzgyZdAoXiVDwkiP1xdo9gEAqyiImHAv2t9r
r065PwPrvXtAb0rT2z4PQy6Sv3lSmwM=
=CEQK
-----END PGP SIGNATURE-----

--XREzqQ352E1T40zH--

