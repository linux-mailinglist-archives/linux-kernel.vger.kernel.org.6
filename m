Return-Path: <linux-kernel+bounces-224585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1BFF912446
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 13:47:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F205E1C23B0C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 11:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3ACF178390;
	Fri, 21 Jun 2024 11:41:50 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C2FF17837C
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 11:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718970110; cv=none; b=JSISvn9RBRv4sj4eUftjhMdJseERFY+XOKDaX8w6Y4GGYaQzxbuo5K4cQUv6vzrw2F8e0l63V17p8CPsWDe4pJ8DHvLyYqLab3Zr2TkxD0QqdGFsFpjtbbK0UpIF5ylkpL70pugoU18HsiVVxyDDeA4LHuhgiDzAAh7nnIMYSqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718970110; c=relaxed/simple;
	bh=NkRjYRRgPY2pxFysJad/qIZDlWc4+7rcFnCsrgCUrMw=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WHgGSOw+D2aZPXo7SJOoRCQq1Y/q94lYvq69G1iGM8+JqP0bDxwn+etDHNVrmupWHb5pXgVnCK2vR3ptQLf9vtjmPQ9jLBmJlmJTpda+LndkibMRaFAC4qOq4zNjpO4/W+7GUBtIS2u//j2GXmCPITN5tuTLMZJgdvBQVDI9ZhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1sKcdd-0007pj-RL; Fri, 21 Jun 2024 13:41:05 +0200
Received: from [2a0a:edc0:0:900:1d::4e] (helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1sKcdY-003voe-7z; Fri, 21 Jun 2024 13:41:00 +0200
Received: from pza by lupine with local (Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1sKcdY-0008gu-0V;
	Fri, 21 Jun 2024 13:41:00 +0200
Message-ID: <fa9aee7a6cbe4f1320a83db1097a4a486ca1781c.camel@pengutronix.de>
Subject: Re: [PATCH v3 2/3] hwrng: add Rockchip SoC hwrng driver
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Daniel Golle <daniel@makrotopia.org>, Aurelien Jarno
 <aurelien@aurel32.net>,  Olivia Mackall <olivia@selenic.com>, Herbert Xu
 <herbert@gondor.apana.org.au>, Rob Herring <robh@kernel.org>,  Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Heiko
 Stuebner <heiko@sntech.de>, Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?=
 <ukleinek@debian.org>,  Sebastian Reichel
 <sebastian.reichel@collabora.com>, Anand Moon <linux.amoon@gmail.com>,
 Dragan Simic <dsimic@manjaro.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Martin Kaiser <martin@kaiser.cx>, Ard Biesheuvel <ardb@kernel.org>, 
 linux-crypto@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org
Date: Fri, 21 Jun 2024 13:41:00 +0200
In-Reply-To: <57a7fb13451f066ddc8d1d9339d8f6c1e1946bf1.1718921174.git.daniel@makrotopia.org>
References: <cover.1718921174.git.daniel@makrotopia.org>
	 <57a7fb13451f066ddc8d1d9339d8f6c1e1946bf1.1718921174.git.daniel@makrotopia.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Hi,

On Fr, 2024-06-21 at 02:25 +0100, Daniel Golle wrote:
> From: Aurelien Jarno <aurelien@aurel32.net>
>=20
> Rockchip SoCs used to have a random number generator as part of their
> crypto device, and support for it has to be added to the corresponding
> driver. However newer Rockchip SoCs like the RK356x have an independent
> True Random Number Generator device. This patch adds a driver for it,
> greatly inspired from the downstream driver.
>=20
> The TRNG device does not seem to have a signal conditionner and the FIPS
> 140-2 test returns a lot of failures. They can be reduced by increasing
> RK_RNG_SAMPLE_CNT, in a tradeoff between quality and speed. This value
> has been adjusted to get ~90% of successes and the quality value has
> been set accordingly.
>=20
> Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
> [daniel@makrotpia.org: code style fixes]
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
>  MAINTAINERS                           |   1 +
>  drivers/char/hw_random/Kconfig        |  14 ++
>  drivers/char/hw_random/Makefile       |   1 +
>  drivers/char/hw_random/rockchip-rng.c | 229 ++++++++++++++++++++++++++
>  4 files changed, 245 insertions(+)
>  create mode 100644 drivers/char/hw_random/rockchip-rng.c
>=20
[...]
> diff --git a/drivers/char/hw_random/rockchip-rng.c b/drivers/char/hw_rand=
om/rockchip-rng.c
> new file mode 100644
> index 000000000000..6070abb73847
> --- /dev/null
> +++ b/drivers/char/hw_random/rockchip-rng.c
> @@ -0,0 +1,229 @@
[...]
>=20
> +static int rk_rng_probe(struct platform_device *pdev)
> +{
> +	struct device *dev =3D &pdev->dev;
> +	struct rk_rng *rk_rng;
> +	int ret;
> +
> +	rk_rng =3D devm_kzalloc(dev, sizeof(*rk_rng), GFP_KERNEL);
> +	if (!rk_rng)
> +		return -ENOMEM;
> +
> +	rk_rng->base =3D devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(rk_rng->base))
> +		return PTR_ERR(rk_rng->base);
> +
> +	rk_rng->clk_num =3D devm_clk_bulk_get_all(dev, &rk_rng->clk_bulks);
> +	if (rk_rng->clk_num < 0)
> +		return dev_err_probe(dev, rk_rng->clk_num,
> +				     "Failed to get clks property\n");
> +
> +	rk_rng->rst =3D devm_reset_control_array_get(&pdev->dev, false, false);

Please use devm_reset_control_array_get_exclusive() instead.


regards
Philipp

