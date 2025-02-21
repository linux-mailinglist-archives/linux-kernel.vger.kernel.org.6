Return-Path: <linux-kernel+bounces-526258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44771A3FC3A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 17:55:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94282172F3C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 16:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B72A3211492;
	Fri, 21 Feb 2025 16:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OSzcCcOx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 002CE204591;
	Fri, 21 Feb 2025 16:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740156649; cv=none; b=RVbKe9ZJM5sS3M5p566A3Znk3/xf5Z9bDIF0THQphXnIQLnRckxXPgsHF0z1Shtngzhk5q78/c2QVHJyCis6Y/vOeCgx5Uh2cMyJPxzVyd8D/ZYWRhk6ZaliXqRF4LW8xwR25HvXdR4lE6engsRkERNPrxYkZ7CR/32OYC450v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740156649; c=relaxed/simple;
	bh=uO7iR3vwn4NjiB7/pnupUzcOgxWEDmguu6o6fY3vzW8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WFE6Fw9H3AqpH28342Tyz9M9yde3In9ToFDWafkFx2vFzhB0fJUPs8l8Ruu1ZiRhRyHF1emJHHDrfvzMGmmaWyeFwHNAUk1qIAxUX/hUPJBhUCD/zMbTAaxkWDP3v5PrdbNbeu/BLN0XhS3iDnqMpDw/Yahj9y2LkOy/xCkKrbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OSzcCcOx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 838B1C4CEE2;
	Fri, 21 Feb 2025 16:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740156648;
	bh=uO7iR3vwn4NjiB7/pnupUzcOgxWEDmguu6o6fY3vzW8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OSzcCcOxnbXByJZxA2vOtL3UurdHn5Afdu4z6JegUF/ksA/IW++PxQQAyHgbfcoQi
	 lwqx5/XecL5La9O8kRRQXU0QoTQcZe/+fiSQdQZFsQTe9fIuhRUVNLykKwN6PGbNZJ
	 0QjVzwGTo0h3uaQ3Aep95jYJqmurhdXd+7PMZiO/5g/FPaV4z+fk9Y7Im+RE4MXdqH
	 LagytwrfNt+zM1XVudXIgJQsG6tFpvNAiGlkjKmdb3RyeniRYLnnxSQicaydoQHytE
	 QAeyatSs6r7WymDv8iiy/iHjAQ/jNnVZS8e3eIuMnLQFlnTzw+Tw6MwdkOikkJGaEA
	 eeyEqkcXD/uAw==
Date: Fri, 21 Feb 2025 16:50:43 +0000
From: Conor Dooley <conor@kernel.org>
To: Lukasz Majewski <lukma@denx.de>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof@spud.smtp.subspace.kernel.org,
	Kozlowski@spud.smtp.subspace.kernel.org,
	Conor Dooley <conor+dt@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Heiko Stuebner <heiko@sntech.de>, Aradhya Bhatia <a-bhatia1@ti.com>,
	rafal@milecki.pl, devicetree@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>,
	Noah Wang <noahwang.wang@outlook.com>, linux-kernel@vger.kernel.org,
	Peter Yin <peteryin.openbmc@gmail.com>,
	Naresh Solanki <naresh.solanki@9elements.com>,
	Alex Vdovydchenko <xzeol@yahoo.com>,
	Grant Peltier <grantpeltier93@gmail.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH 2/2] dt-bindings: trivial-devices: Document SPI
 measurement on LWE boards
Message-ID: <20250221-scuba-rematch-ada1a9b750b1@spud>
References: <20250221155418.1167670-1-lukma@denx.de>
 <20250221155418.1167670-2-lukma@denx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="PJSyUnS8LoRyfgO7"
Content-Disposition: inline
In-Reply-To: <20250221155418.1167670-2-lukma@denx.de>


--PJSyUnS8LoRyfgO7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 21, 2025 at 04:54:18PM +0100, Lukasz Majewski wrote:
> The measurement device on Liebherr's (LWE) boards is used to monitor
> the overall state of the device. It does have SPI interface to
> communicate with Linux host via spidev driver. Document the SPI DT
> binding as trivial SPI device.
>=20
> Signed-off-by: Lukasz Majewski <lukma@denx.de>
> ---
>  Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Doc=
umentation/devicetree/bindings/trivial-devices.yaml
> index fadbd3c041c8..5d736a9792c2 100644
> --- a/Documentation/devicetree/bindings/trivial-devices.yaml
> +++ b/Documentation/devicetree/bindings/trivial-devices.yaml
> @@ -161,6 +161,8 @@ properties:
>            - jedec,spd5118
>              # Linear Technology LTC2488
>            - lineartechnology,ltc2488
> +            # Liebherr on-board measurement SPI device
> +          - lwe,btt

How does "btt" translate to what the device actually is? Seems kinda
random!
Also, where is patch 3, adding the lwe,btt to the spidev driver so that
it will probe?

Cheers,
Conor.

>              # 5 Bit Programmable, Pulse-Width Modulator
>            - maxim,ds1050
>              # 10 kOhm digital potentiometer with I2C interface
> --=20
> 2.39.5
>=20

--PJSyUnS8LoRyfgO7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ7iu4wAKCRB4tDGHoIJi
0njEAQCJAU4ky/SmZbsSouA3DbacjxTLWEZF2BSs2UMXg5A6nwD+OX/OFzEiP1YA
C7uAq+QCmtHUt9si8mNjuvDe22WyjAI=
=vvxq
-----END PGP SIGNATURE-----

--PJSyUnS8LoRyfgO7--

