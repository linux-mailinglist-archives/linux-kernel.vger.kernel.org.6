Return-Path: <linux-kernel+bounces-336314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79C7D983910
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 23:23:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36AEB282966
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 21:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6B9E83A19;
	Mon, 23 Sep 2024 21:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DWW5WqUH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 108AD7F7DB;
	Mon, 23 Sep 2024 21:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727126625; cv=none; b=kgVSVevF0A/SVitUBB5z9yb1o9bE4DVyAn0gLGYS92RXvctUNdezeiosQTjn0hg40ieipOdvy2pey/cvsFk/n05aItf4TQMsiZpV8a0Xcoehb7dlo0/YJ2tV+czM32pElTTtevcXIZqMZeNbLDaeYgmXFVTNJEag3OpHoAWgT4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727126625; c=relaxed/simple;
	bh=tj4LmrvGayH3XbbYtlkUr8l9vC6zcGbXYX0A15TEu4g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OaU6twdVZX+/+l+wYwKyWmgbdcNQ/cAYLUMOFe3mXkbrGcYbW6Y7F0aKpbgCmA9zy0AE3SDeMAE6b8Ifl5K5A0MHjTe1D7JylG5RLhyyKRjvOfrrT5MQDbjiBqZOjYuUpJrzB9owoIhCBelgEkE0Cq6KznXjBj8UVNLuxnCGaG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DWW5WqUH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B7E3C4CEC4;
	Mon, 23 Sep 2024 21:23:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727126624;
	bh=tj4LmrvGayH3XbbYtlkUr8l9vC6zcGbXYX0A15TEu4g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DWW5WqUHlB0Iq+flr9vUnaEgwPU099aociYwPrcfIJx1AP1dhptayX/uq4praF4Mq
	 rDz8VfnovTd9r3b7esT4ClSZnrzkpgWIv0r8DTH+jgp3JHMLA0rq/R8Ex4jS06S2Xf
	 Ma3WgsvmHom2mPKXHZehZJPTd6WzvdGTafcuqm0kiOZ7HBWpPEF3b1tHyWOFuDxPyq
	 2yUwWwNhVYxfe1icSyFWank+6OZ3cU0aGkU7+zGchOSBpxH1FQoLW6lACbHMpQgm0y
	 VpO5ZHcEkk42YguFpHIK6StJbu3RZqr/eSpVCHHFK/oVTKuGfsmVZNkjSh2OhFubqL
	 jj+kEjArkoVog==
Date: Mon, 23 Sep 2024 22:23:39 +0100
From: Conor Dooley <conor@kernel.org>
To: Chanh Nguyen <chanh@os.amperecomputing.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Peter Yin <peteryin.openbmc@gmail.com>,
	Noah Wang <noahwang.wang@outlook.com>, Marek Vasut <marex@denx.de>,
	Fabio Estevam <festevam@gmail.com>, Lukas Wunner <lukas@wunner.de>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	OpenBMC Maillist <openbmc@lists.ozlabs.org>,
	Phong Vo <phong@os.amperecomputing.com>,
	Thang Nguyen <thang@os.amperecomputing.com>,
	Quan Nguyen <quan@os.amperecomputing.com>,
	Khanh Pham <khpham@amperecomputing.com>,
	Open Source Submission <patches@amperecomputing.com>
Subject: Re: [PATCH v2] dt-bindings: trivial-devices: add onnn,adt7462
Message-ID: <20240923-private-grower-af6a7c1fca09@spud>
References: <20240923093800.892949-1-chanh@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qNZzXI/TECE47qmF"
Content-Disposition: inline
In-Reply-To: <20240923093800.892949-1-chanh@os.amperecomputing.com>


--qNZzXI/TECE47qmF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 23, 2024 at 09:38:00AM +0000, Chanh Nguyen wrote:
> The adt7462 supports monitoring and controlling up to
> four PWM Fan drive outputs and eight TACH inputs measures.
> The adt7462 supports reading a single on chip temperature
> sensor and three remote temperature sensors. There are up
> to 13 voltage monitoring inputs.
>=20
> Add device tree bindings for the adt7462 device.
>=20
> Signed-off-by: Chanh Nguyen <chanh@os.amperecomputing.com>
> ---
> Change in v2:
>    - Add onnn,adt7462 to the list of trivial devices       [Guenter]

Is this really a trivial device? If it monitors and controls fans, how
come those do not need to be represented in the devicetree? How is it
possible to tell the difference between monitoring 1 and 4 fans without
the extra detail?

Curious,
Conor.

> ---
>  Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Doc=
umentation/devicetree/bindings/trivial-devices.yaml
> index 0108d7507215..15f89d7ecf73 100644
> --- a/Documentation/devicetree/bindings/trivial-devices.yaml
> +++ b/Documentation/devicetree/bindings/trivial-devices.yaml
> @@ -311,6 +311,8 @@ properties:
>            - nuvoton,w83773g
>              # OKI ML86V7667 video decoder
>            - oki,ml86v7667
> +            # ON Semiconductor ADT7462 Temperature, Voltage Monitor and =
Fan Controller
> +          - onnn,adt7462
>              # 48-Lane, 12-Port PCI Express Gen 2 (5.0 GT/s) Switch
>            - plx,pex8648
>              # Pulsedlight LIDAR range-finding sensor
> --=20
> 2.43.0
>=20

--qNZzXI/TECE47qmF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZvHcWgAKCRB4tDGHoIJi
0sNEAQCC3S9W5Yf6XyOTvzS2qKXG/O9P9J+FP7FXrlBEWIaLLAEAkw9U5FDVFaoq
TX1eEOoIoUhUMlOZ+Tb/wSbZKUP1IQw=
=I636
-----END PGP SIGNATURE-----

--qNZzXI/TECE47qmF--

