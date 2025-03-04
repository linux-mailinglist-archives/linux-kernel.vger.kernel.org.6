Return-Path: <linux-kernel+bounces-544965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AB82A4E714
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 17:56:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3235419C4A21
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 16:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3A4D29C34B;
	Tue,  4 Mar 2025 16:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mfMsgv5L"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01CDA29C32E;
	Tue,  4 Mar 2025 16:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741105799; cv=none; b=MD1KPhtfdND2j0SsLjYhwQ6g1gWw50F3IQ30jTEknRQIYBKcGEBy3RFsV2O2CV51DuwO/zV8eUAobwlkk+RUlLB01/ypmNpkABH+Z2Kj7LkpMdR9z5C7iqGAD+Kpb/ZPcJs5OKojXRDf2P5JpH9EfjHs2UQ+NVTS4intfNYBIQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741105799; c=relaxed/simple;
	bh=gynFhESbDtrj69l9vqy5ZqEBuAk+kaMQBtKyg7Ndc6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DwN+FM9uXMe+gA364dBZHnqLWynf1YU/aacewpvQfUZWy9ypvKsPw+Z2OsA4bBJjEFU9gL6QeSL3HMJxkZrLEGnlgHOZXAiBZx9MJZDSiy1YRDDkFvKNRqdgirOKuz1sZ/x6+icRnAFPIFFayuzfq7+KYgtU4H2Cph83qq6zmo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mfMsgv5L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2A20C4CEFF;
	Tue,  4 Mar 2025 16:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741105798;
	bh=gynFhESbDtrj69l9vqy5ZqEBuAk+kaMQBtKyg7Ndc6Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mfMsgv5LapGGy3xlQdJo1Izu+fujpQxnfRCXT0t9G1XzhJMd4VY6W7ZkWl1kX48E9
	 T1a+3o+OSddgcp+wavhJjDSOcc+WRUkFYAkwKkx/F67+sHByi98ZObydrmf7fTR12F
	 php4EpOxzPVacbbTmoN427DcCs9c/IKsNy02UkCpMghKy8vpoIYza7G5l6sI+1BHBh
	 B08BNppLJnJx2ZQKnDYIG9YJWI43/2b61Q2pxqjn5KqAVVMALRpXdTtp/v5AQLvfHw
	 v06XOh6OXN1r2M8I/haxZbpLOULSuyEYShoYM21UtsPJFfcjEt8AzkKDGmyYnW7sWD
	 /0+W7tsIlxUSw==
Date: Tue, 4 Mar 2025 16:29:53 +0000
From: Conor Dooley <conor@kernel.org>
To: florin.leotescu@oss.nxp.com
Cc: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michael Shych <michaelsh@nvidia.com>, linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	viorel.suman@nxp.com, carlos.song@nxp.com,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	festevam@gmail.com, Florin Leotescu <florin.leotescu@nxp.com>
Subject: Re: [PATCH v3 1/3] dt-bindings: hwmon: Add Microchip emc2305 yaml
 schema
Message-ID: <20250304-serving-stem-e059361db2b8@spud>
References: <20250304162136.1963384-1-florin.leotescu@oss.nxp.com>
 <20250304162136.1963384-2-florin.leotescu@oss.nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="xnIqZbRCysQNs4BG"
Content-Disposition: inline
In-Reply-To: <20250304162136.1963384-2-florin.leotescu@oss.nxp.com>


--xnIqZbRCysQNs4BG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 04, 2025 at 06:21:34PM +0200, florin.leotescu@oss.nxp.com wrote:
> From: Florin Leotescu <florin.leotescu@nxp.com>
>=20
> Introduce yaml schema for Microchip emc2305 pwm fan controller.
>=20
> Signed-off-by: Florin Leotescu <florin.leotescu@nxp.com>
> ---
>  .../bindings/hwmon/microchip,emc2305.yaml     | 43 +++++++++++++++++++
>  1 file changed, 43 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/microchip,emc=
2305.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/hwmon/microchip,emc2305.ya=
ml b/Documentation/devicetree/bindings/hwmon/microchip,emc2305.yaml
> new file mode 100644
> index 000000000000..cac0075a65bb
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/microchip,emc2305.yaml
> @@ -0,0 +1,43 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/hwmon/microchip,emc2305.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Microchip EMC2305 SMBus compliant PWM fan controller
> +
> +maintainers:
> +  - Michael Shych <michaelsh@nvidia.com>
> +
> +description: |
> +  Microchip EMC2301/2/3/5 pwm controller which supports up
> +  to five programmable fan control circuits
> +
> +properties:
> +  compatible:
> +    enum:
> +      - microchip,emc2301
> +      - microchip,emc2302
> +      - microchip,emc2303
> +      - microchip,emc2305

Driver has no match data etc, suggesting all of these are compatible.
Please pick one as a fallback compatible.

> +
> +  reg:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg

Missing descriptions of the fans, no?
See max6639 for an example.

> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +
> +        emc2301: pwm@2f {

The emc2301 label here can be dropped, it is not used.
The nodename should be "fan-controller", not pwm here I guess.

Cheers,
Conor.

> +            compatible =3D "microchip,emc2301";
> +            reg =3D <0x2f>;
> +        };
> +    };
> --=20
> 2.34.1
>=20

--xnIqZbRCysQNs4BG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ8cqgQAKCRB4tDGHoIJi
0tl1AQCWUg3opyNCLRMufBSW7mDK6VYOlwUhf8VqZoYesvshgQD9HTXB/SxZHAYY
OHING0K8g/FBO22knM89/3x4tRYM0wM=
=oh90
-----END PGP SIGNATURE-----

--xnIqZbRCysQNs4BG--

