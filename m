Return-Path: <linux-kernel+bounces-171701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 191718BE77C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 17:33:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C7B41C236C0
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 15:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 344381649BF;
	Tue,  7 May 2024 15:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HKhScJgr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE521649C8;
	Tue,  7 May 2024 15:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715095994; cv=none; b=GRM4KkeUFMKUrgw0I71HbWGDuDCnyPryHn1K6QQjvHCpfS9mAu/JwyEr7JkNNW5LLaecvyvxfj7Skr5B7ja277Y8JVcYlS3AcIB8WaLE+QWdqQEx/YurAIu/wSkt3YLL/Jr6OAGHh1aqFjHLt/85jfhxmHOXFlUwwtzJxoTvo4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715095994; c=relaxed/simple;
	bh=Uuw8yqLX+zNb2V3s6736daoABfNqSC9H9+VYeozPtso=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M5kciwYiw8qyAjHh7O9SQcti06g2bbDmdKo3ob9NZtNrCsjWmFmX1cn1PupSQAaIqBIhiH8gmDmsCPaTnxLLzQNJdg6GwZBtZVh7tf+L9AejiJt+0sXWzI93reNXtW0u7MYDAW4SY3DDcm5eOVDv/ThUkqplF8poslGpF1bOhmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HKhScJgr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFABAC2BBFC;
	Tue,  7 May 2024 15:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715095993;
	bh=Uuw8yqLX+zNb2V3s6736daoABfNqSC9H9+VYeozPtso=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HKhScJgrTiIWYZvifQK32YrfBrp/LH9y+F0KXy68fmKvrfE3fbmo4t7V3LrPAmUiQ
	 2Duvw/JI7QJX9gONxzmkbiDr0MezUwA6sIlnRl6T+GuKskZu17FPf1vTxvoz0lTSiS
	 CWPEOwSQ3axTXCMmf0qqvRRJ3a858uEa6yxE5rIzOX8/kDcxVk6/UFCg1O2ZHPDBtU
	 zK6I7yzqBaUTC5jCA0F4Am7yEy+qbv6qdPGaHM7utiWu3+2m7GyxfDD7eCefVMv34y
	 wA/9vCbiWVLxLoFuwU4YIF+Md/1x3n6cuqDdhvwUTRuSIDQYOKA5PgWX8X2ilti0v+
	 evXHnC6DdCq/A==
Date: Tue, 7 May 2024 16:33:08 +0100
From: Conor Dooley <conor@kernel.org>
To: Inochi Amaoto <inochiama@outlook.com>
Cc: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v5 1/2] dt-bindings: hwmon: Add Sophgo SG2042 external
 hardware monitor support
Message-ID: <20240507-mantis-rotten-f4be1961b3f2@spud>
References: <PH7PR20MB4962C6D8FD6989BC79F9483FBB1D2@PH7PR20MB4962.namprd20.prod.outlook.com>
 <IA1PR20MB4953F852CB7A9C5FE45E18EBBB1D2@IA1PR20MB4953.namprd20.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="g3PGoBcSoUn7NI8A"
Content-Disposition: inline
In-Reply-To: <IA1PR20MB4953F852CB7A9C5FE45E18EBBB1D2@IA1PR20MB4953.namprd20.prod.outlook.com>


--g3PGoBcSoUn7NI8A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, May 05, 2024 at 09:18:52AM +0800, Inochi Amaoto wrote:
> Due to the design, Sophgo SG2042 use an external MCU to provide
> hardware information, thermal information and reset control.
>=20
> Add bindings for this monitor device.
>=20
> Signed-off-by: Inochi Amaoto <inochiama@outlook.com>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

> ---
>  .../hwmon/sophgo,sg2042-hwmon-mcu.yaml        | 43 +++++++++++++++++++
>  1 file changed, 43 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/sophgo,sg2042=
-hwmon-mcu.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/hwmon/sophgo,sg2042-hwmon-=
mcu.yaml b/Documentation/devicetree/bindings/hwmon/sophgo,sg2042-hwmon-mcu.=
yaml
> new file mode 100644
> index 000000000000..f0667ac41d75
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/sophgo,sg2042-hwmon-mcu.yaml
> @@ -0,0 +1,43 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/hwmon/sophgo,sg2042-hwmon-mcu.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Sophgo SG2042 onboard MCU support
> +
> +maintainers:
> +  - Inochi Amaoto <inochiama@outlook.com>
> +
> +properties:
> +  compatible:
> +    const: sophgo,sg2042-hwmon-mcu
> +
> +  reg:
> +    maxItems: 1
> +
> +  "#thermal-sensor-cells":
> +    const: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - "#thermal-sensor-cells"
> +
> +allOf:
> +  - $ref: /schemas/thermal/thermal-sensor.yaml#
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +
> +        hwmon@17 {
> +            compatible =3D "sophgo,sg2042-hwmon-mcu";
> +            reg =3D <0x17>;
> +            #thermal-sensor-cells =3D <1>;
> +        };
> +    };
> --
> 2.45.0
>=20

--g3PGoBcSoUn7NI8A
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZjpJtAAKCRB4tDGHoIJi
0ojlAP4qRojNEmxLVCu8LiEozoXxSgRaOnYNdn9jUxygr7Q6ugD+LYcUcNRZ2116
IeAQnV4lJkh7RnQwP1vgqhqwkgq5SwA=
=mbl/
-----END PGP SIGNATURE-----

--g3PGoBcSoUn7NI8A--

