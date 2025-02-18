Return-Path: <linux-kernel+bounces-519708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0518A3A0E4
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 16:15:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2A273A6D98
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 15:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D872F26B94B;
	Tue, 18 Feb 2025 15:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FrQjXHQd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A4F23ED69;
	Tue, 18 Feb 2025 15:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739891750; cv=none; b=N0nlZwy5BmoX3Pm1ztXnFLMANMG5FhzQg8oHpqWiyhn+TH7NouiFdPNw1OoINMnH3l6Lh+cAhlL2Xww+fznn+jc8T6+KJxlgcMiHwDOumwfJTRkKFkpqDEsVTRKhayCn/m78WY+x+JNZ255TJXp0YZLSDKNniCCl/7ZS/GDKkDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739891750; c=relaxed/simple;
	bh=Ib4Pm+5C9/8AIMYLPPJHBDj/uTaSeXuNctIV6FJv7Ko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P5fiqA9KjNr6ArnMj/+ILLBh9OKjyzFlOyrgPqcoKuTy4coetYHOswgpy+fihRhDGMme1+xZUfP54XFtKDHj8x9vWRQyEQ9iYdoNdt5GIj3A+gimCfmIFhYXvmNB718QUyponA4I4Oi+HwjdC4lshjVJ6lVVdnyYdnYsShC7bRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FrQjXHQd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 015F9C4CEE7;
	Tue, 18 Feb 2025 15:15:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739891749;
	bh=Ib4Pm+5C9/8AIMYLPPJHBDj/uTaSeXuNctIV6FJv7Ko=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FrQjXHQd850c06d7C4Ku9v0LEKUAyAoQDrNLtIYWqDeFP7kZTV6ft/v5HC/VeMPdU
	 2siDlZ3jDeDqZ2Nj/ibboUMFaqk1q9qDOXY0OlT0B+tTKyFxXoFcxYwZCwPSjk1vR8
	 YOMSozF/WFFJV6ztw87mqpdQoHS+oTSQBz9DyS/8gewkXC9rf1agXY3ZEgz2yivOSb
	 1DLVCmA6V0mxB8IDejYCfkY7yu2NqLZ13GOwNjrr1YrkSdz3QlkLM06ZqXTUfdtwDN
	 FyxMSIquqeLzqHbbPiKwQ8gfRGs3ZkNCMwGebE3XXQrFwBSyQrOO0D7EAC40bcDH6j
	 abiOnIDJ2ecFA==
Date: Tue, 18 Feb 2025 15:15:45 +0000
From: Mark Brown <broonie@kernel.org>
To: James Calligeros <jcalligeros99@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>, Shenghao Ding <shenghao-ding@ti.com>,
	Kevin Lu <kevin-lu@ti.com>, Baojun Xu <baojun.xu@ti.com>,
	Dan Murphy <dmurphy@ti.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shi Fu <shifu0704@thundersoft.com>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Martin =?utf-8?Q?Povi=C5=A1er?= <povik+lin@cutebit.org>,
	Hector Martin <marcan@marcan.st>, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	asahi@lists.linux.dev, linux-hwmon@vger.kernel.org,
	Neal Gompa <neal@gompa.dev>
Subject: Re: [PATCH v2 05/29] ASoC: tas2764: Extend driver to SN012776
Message-ID: <Z7SkIUs_d7ty-GU3@finisterre.sirena.org.uk>
References: <20250218-apple-codec-changes-v2-0-932760fd7e07@gmail.com>
 <20250218-apple-codec-changes-v2-5-932760fd7e07@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="PPOhNaWiX4C4lTj9"
Content-Disposition: inline
In-Reply-To: <20250218-apple-codec-changes-v2-5-932760fd7e07@gmail.com>
X-Cookie: Editing is a rewording activity.


--PPOhNaWiX4C4lTj9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 18, 2025 at 06:35:39PM +1000, James Calligeros wrote:

> +	if (tas2764->devid == DEVID_SN012776) {
> +		ret = snd_soc_component_update_bits(component, TAS2764_PWR_CTRL,
> +					TAS2764_PWR_CTRL_BOP_SRC,
> +					TAS2764_PWR_CTRL_BOP_SRC);

This sort of code is generally better written with switch statements for
extensibility.

> +	if (device_is_compatible(&client->dev, "ti,sn012776"))
> +		tas2764->devid = DEVID_SN012776;
> +	else
> +		tas2764->devid = DEVID_TAS2764;
> +

>  #if defined(CONFIG_OF)
>  static const struct of_device_id tas2764_of_match[] = {
> -	{ .compatible = "ti,tas2764" },
> +	{ .compatible = "ti,tas2764",  },
> +	{ .compatible = "ti,sn012776", },

It would be more usual to use the data field in the of_device_id to look
up the enum.

--PPOhNaWiX4C4lTj9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAme0pCAACgkQJNaLcl1U
h9AavAf+PefPB5tBS+9HAQnlJyDWHiyIub1mLugOQ6Lp9v8dm7nlt1cp4T3GdXq/
8PqSyalqppiie2kJFvhE+BoZmeXuoREbwpbV1ldT1oitu92KbLG2wu8v1uZ5f0Jd
wnyNdyLrxo/Oy0a4F4Cc5PYw8nDOHilFCGlAvtcdTKmSpPXe95SBLLza5HJsYP0X
nYSzqGUmdAuKnn/H4N72JEddaLjxBokHg5/8FCvgYZ8H6SB4gQ/uor9R42IO9VrG
xbnsCQKTdQ3apGSAp1NVHqNvkE/h4itzghJyZ2oKtZbQMgD8AB89B5fyHO4FPOOG
GVCJXefFFikpw8i4b3GEsh/B991FPA==
=Pnbb
-----END PGP SIGNATURE-----

--PPOhNaWiX4C4lTj9--

