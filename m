Return-Path: <linux-kernel+bounces-337140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52A599845DE
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 14:24:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 841141C22CA4
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 12:24:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9C1A1A705D;
	Tue, 24 Sep 2024 12:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SlyGxqDf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4870B3F9D5;
	Tue, 24 Sep 2024 12:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727180661; cv=none; b=QN+MnDi9rJWKpB5ZUugYzdnPNELtbwlTz4MiYtG9yne08hJF4AiCJxojURtvwn3SRJ/NcHEsYOwE471w3nn+eGYiQ7gs79T9vN/lh3oS5OE6us4G4TmEiOuNwiPfgkem1xydK6Ii+2+TsQua3doTraUCWoSs9hiO+njNmv5/618=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727180661; c=relaxed/simple;
	bh=FKNjfvHnnNhwzScnzuAJn6ULWo2QY+BQ9s4h92IJu7g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=okFbYWW1qR7oOl2vF+gpELs9BzEoDnPmhCAu32ZgjjzWzbKDpOB4LTxKNuZvySVaYxuY+I015b7yo8joRKbVzKFkURX1Y90CJ+9+7P4avJzz5DR+ykyofrs4+fSKtC+yDhi5a32D7TZcnKHpWQRGGNDsJ7O8exCMN9hx2KzWTI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SlyGxqDf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D872FC4CEC4;
	Tue, 24 Sep 2024 12:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727180660;
	bh=FKNjfvHnnNhwzScnzuAJn6ULWo2QY+BQ9s4h92IJu7g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SlyGxqDfjhGJkSTQcisVILZeXxSa1edRkJ/4QWRrCE8MHXXy45isCcBswgVR3AKEy
	 aWreqsVZRsT8xtO2bCQQsjhvPbWlJk7kcr+11BvqsUZezHyixVE9RGmJPK4olCXRkt
	 UODvBwuVY70icQDnLYexkGti9iYILqHJz00oPkOxdMo77zZpSRsIhLEdebAc0o48zi
	 eOc0/2pkYYaXnFrXExBNTf6bK7iwsE4Y8Us0E9GAH6RGepsfqMvkPYcTlO6ogZJlGU
	 mj9J6mBcyRx/DvjxCHcAcZcTi12twoncR+W5SufOAi8APADSS8QdqvjD7LXY0KH7b6
	 ULYX86ChFl0dg==
Date: Tue, 24 Sep 2024 14:24:16 +0200
From: Mark Brown <broonie@kernel.org>
To: Igor Prusov <ivprusov@salutedevices.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	kernel@salutedevices.com, prusovigor@gmail.com,
	David Yang <yangxiaohua@everest-semi.com>,
	Martin Kurbanov <mmkurbanov@salutedevices.com>
Subject: Re: [PATCH v2 2/2] ASoC: codecs: add ES7243E ADC driver
Message-ID: <ZvKvcBHJU2pKl809@finisterre.sirena.org.uk>
References: <20240920-es7243e-adc-v2-0-0be019735b81@salutedevices.com>
 <20240920-es7243e-adc-v2-2-0be019735b81@salutedevices.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="orxiphdiU9CDdCkg"
Content-Disposition: inline
In-Reply-To: <20240920-es7243e-adc-v2-2-0be019735b81@salutedevices.com>
X-Cookie: Editing is a rewording activity.


--orxiphdiU9CDdCkg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 20, 2024 at 06:41:08PM +0300, Igor Prusov wrote:

> +config SND_SOC_ES7243E
> +	tristate "Everest Semi ES7243E CODEC"
> +

This is an I2C device, it should depend on I2C.

> @@ -0,0 +1,693 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/**
> + * es7243e.c - ASoC Everest Semiconductor ES7243E audio ADC driver
> + *

Please make the enitre comment a C++ one so things look more
intentional.

> + * Copyright (c) 2024, SaluteDevices. All Rights Reserved.

All rights reserved?

> +static const struct reg_sequence init_sequence[] = {
> +	{ ES7243E_CLK2,			0x00 },
> +	{ ES7243E_SDP,			0x00 },
> +	{ ES7243E_TDM,			0x00 },
> +
> +	/* Set MCLK/LRCK ratio to 256 */
> +	{ ES7243E_ADC_OSR,		0x20 },

This should be dynamically configured rather than hard coded, provide
set_bclk_ratio().

> +	/* Set ADC volume to 0dB */
> +	{ ES7243E_ADC_VOL,		0xbf },

Most things should use the chip defaults, especially things like volumes
- userspace can configure whatever it needs.

> +static int es7243e_suspend(struct snd_soc_component *component)
> +{
> +	struct es7243e_priv *es7243e = snd_soc_component_get_drvdata(component);
> +	int ret;
> +	unsigned int val, mask;
> +
> +	val = FIELD_PREP(ES7243E_SDP_MUTE, 0);
> +	ret = snd_soc_component_update_bits(component, ES7243E_SDP,
> +					    ES7243E_SDP_MUTE, val);
> +	if (ret < 0)
> +		return ret;
> +
> +	val = FIELD_PREP(ES7243E_PGA1_EN, 0);
> +	snd_soc_component_update_bits(component, ES7243E_PGA1,
> +				      ES7243E_PGA1_EN, val);
> +	if (ret < 0)
> +		return ret;
> +
> +	val = FIELD_PREP(ES7243E_PGA2_EN, 0);
> +	snd_soc_component_update_bits(component, ES7243E_PGA2,
> +				      ES7243E_PGA2_EN, val);
> +	if (ret < 0)
> +		return ret;

This looks a lot like you should be using DAPM with events on the PGAs,
that will give power management at runtime as well.

> +	ret = snd_soc_component_write(component, ES7243E_PDN, 0xff);
> +	if (ret < 0)
> +		return ret;
> +
> +	mask = ES7243E_CLK1_ANA_ON | ES7243E_CLK1_ADC_ON;
> +	ret = snd_soc_component_update_bits(component, ES7243E_CLK1, mask, 0);
> +	if (ret < 0)
> +		return ret;
> +
> +	clk_disable_unprepare(es7243e->lrclk);
> +	clk_disable_unprepare(es7243e->sclk);

You could also use set_bias_level() for chip level power, it doesn't
look like there's substantial delay.

> +static int es7243e_resume(struct snd_soc_component *component)
> +{
> +	struct es7243e_priv *es7243e = snd_soc_component_get_drvdata(component);
> +	int ret;
> +	unsigned int val;

This doesn't resync the cache so the user volume settings will be lost.

--orxiphdiU9CDdCkg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmbyr28ACgkQJNaLcl1U
h9C5Kwf/W16rrhnjO3Ye/WN7vpgpY8D0g+YSbt/PXAte3rc5FvsKyZNtqTXUlh2i
fTlQRNZENEbs012in/83m4vs1eCFi1zJffeBQyBCgwX3J9SjY/iHIFVOnbnIrI9P
ngQRinfzA+5RIJxka2MuJcESihk+HL/ZIw2tn4CN0DkarXBW/NnJoC84WC4BoEfY
0jWQYK8S4yoIxSmx4gk+pKPaDwdPuwYC4GdTzmaRTH49xYuScrpRKVbUKxmD5zSp
QPqpH40/6ub+HMq5yR7BZlCmhGb4V7C0CH5josObPNbakuxdLlcd2+FwkmZxWU/G
2pdz0D/vynQx0OOYEjgI/v05xEqiLA==
=QUE8
-----END PGP SIGNATURE-----

--orxiphdiU9CDdCkg--

