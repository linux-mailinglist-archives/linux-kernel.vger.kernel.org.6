Return-Path: <linux-kernel+bounces-233868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1416491BE84
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 14:27:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 452EE1C221B5
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 12:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EEB21586C4;
	Fri, 28 Jun 2024 12:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uxhYQTOz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C809D27733
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 12:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719577665; cv=none; b=CPIitKV7Q5Jh26JamRUWOO6QrRHFwyJziBWJqG93fZtjItydoyC6wS6ARI8220jrdZcuPXSPxmY3t520hqTUxwpjCee+0sPGtYkgsNyg9bm/Fth2bD9FgK0JV4L9m99NXN6AhNHDwiEdlSuAYx5cNAffMRLjKi3ZRue2RQmX/R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719577665; c=relaxed/simple;
	bh=hJK0wVcohUrm/QMAdA241PXIxwDTFNwjJipFh5DJ78s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PJO/8GqWXPMGXspVL0wD1n/u3ohaccfByQuDumTuoxC9nOW5g03b6eiD2DVAvOE9MpKY+gh/+2WMXwMTufGPJ4ERaAK7JhpxMrKTE5dudmY2wXKhrtuuU+JxCdykoGn6an3HWawqobQQcFmqvdKrt7S2tspaBxp2VrxBoQdP+iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uxhYQTOz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91BA2C116B1;
	Fri, 28 Jun 2024 12:27:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719577665;
	bh=hJK0wVcohUrm/QMAdA241PXIxwDTFNwjJipFh5DJ78s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uxhYQTOzDvadvS7QMAwBzg5aiD/rX8maTKwQpgxF/vtp04sRNVjUoCI02+UFbURAZ
	 VlXABhW1gKOH+a3yY0P/Tlwa1KcXkDFLTG83ds2P0LsI+jKIunAqq8qt7aNrY48O/+
	 6fHdM7IPhFrWHF8OvHEG9KZPy6bYQFTseSXXeAV2iFu5kyttIQZfiPCGQPHOCdXvNF
	 dWQX5IHAp3G5A0I+J2P3/B6DlPy//GNn+pgwPwY6VB80qUH0Uu+hJZOBjtFqw/Zoo3
	 PDZl5ITBHF++Z+9gZa5snOFP+kB7ZIcmGhflk+eO6wg2xrt+1sj8X0RcGGPCVN7wcb
	 qz05o+kvMskcQ==
Date: Fri, 28 Jun 2024 13:27:36 +0100
From: Mark Brown <broonie@kernel.org>
To: Shenghao Ding <shenghao-ding@ti.com>
Cc: andriy.shevchenko@linux.intel.com, lgirdwood@gmail.com, perex@perex.cz,
	pierre-louis.bossart@linux.intel.com, 13916275206@139.com,
	zhourui@huaqin.com, alsa-devel@alsa-project.org, i-salazar@ti.com,
	linux-kernel@vger.kernel.org, j-chadha@ti.com,
	liam.r.girdwood@intel.com, jaden-yue@ti.com,
	yung-chuan.liao@linux.intel.com, dipa@ti.com, yuhsuan@google.com,
	henry.lo@ti.com, tiwai@suse.de, baojun.xu@ti.com, soyer@irl.hu,
	Baojun.Xu@fpt.com, judyhsiao@google.com, navada@ti.com,
	cujomalainey@google.com, aanya@ti.com, nayeem.mahmud@ti.com,
	savyasanchi.shukla@netradyne.com, flaviopr@microsoft.com,
	jesse-ji@ti.com, darren.ye@mediatek.com
Subject: Re: [PATCH v1] ASoc: tas2781: Add new Kontrol to set tas2563 digital
 gain
Message-ID: <fc4aaa9d-53e3-4709-a20b-2f77d718e815@sirena.org.uk>
References: <20240628041844.1776-1-shenghao-ding@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="XEMZY2HieQ0Ithcn"
Content-Disposition: inline
In-Reply-To: <20240628041844.1776-1-shenghao-ding@ti.com>
X-Cookie: divorce, n:


--XEMZY2HieQ0Ithcn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 28, 2024 at 12:18:43PM +0800, Shenghao Ding wrote:

> -static int tas2781_force_fwload_get(struct snd_kcontrol *kcontrol,
> +static int tasdev_force_fwload_get(struct snd_kcontrol *kcontrol,
>  	struct snd_ctl_elem_value *ucontrol)
>  {
>  	struct snd_soc_component *component =3D
> @@ -118,7 +119,7 @@ static int tas2781_force_fwload_get(struct snd_kcontr=
ol *kcontrol,
>  	return 0;
>  }
> =20
> -static int tas2781_force_fwload_put(struct snd_kcontrol *kcontrol,
> +static int tasdev_force_fwload_put(struct snd_kcontrol *kcontrol,
>  	struct snd_ctl_elem_value *ucontrol)

Are these fwload changes really related to the rest of the change?  They
feel like they should be a separate patch, even if it's a peparatory one
for this.

> +static int tas2563_digital_gain_put(
> +	struct snd_kcontrol *kcontrol,
> +	struct snd_ctl_elem_value *ucontrol)
> +{

> +	for (i =3D 0; i < tas_dev->ndev; i++) {
> +		ret =3D tasdevice_dev_bulk_write(tas_dev, i, reg,
> +			(unsigned char *)tas2563_dvc_table[vol], 4);
> +		if (ret)
> +			dev_err(tas_dev->dev,
> +				"%s, set digital vol error in device %d\n",
> +				__func__, i);
> +	}
> +
> +out:
> +	mutex_unlock(&tas_dev->codec_lock);
> +	return ret;
> +}

This needs to return 1 if the value is being changed, the mixer-test
selftest will tell you about this and other issues.

> +static const struct snd_kcontrol_new tas2563_snd_controls[] =3D {
> +	SOC_SINGLE_RANGE_EXT_TLV("Speaker Digital Gain", TAS2563_DVC_LVL, 0,
> +		0, ARRAY_SIZE(tas2563_dvc_table) - 1, 0,
> +		tas2563_digital_gain_get, tas2563_digital_gain_put,
> +		tas2563_dvc_tlv),
>  };

Volume controls should end in Volume, again mixer-test will tell you
this - please run mixer-test.

>  static int tasdevice_codec_probe(struct snd_soc_component *codec)
>  {
>  	struct tasdevice_priv *tas_priv =3D snd_soc_component_get_drvdata(codec=
);
> +	int rc;
> +
> +	if (tas_priv->chip_id =3D=3D TAS2781) {
> +	} else {

If you write this as a switch statement it'll be more extensible.

--XEMZY2HieQ0Ithcn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZ+rDgACgkQJNaLcl1U
h9BGpAf+MRghGzscAmxRBjyebKkh1iaVhHcFCK++zjP+ZPE9MOGExz2lX+WYMHoe
SAltr4Fys7zepRaRzf2QKM2tjnCTQi0EayXEE/6C4KkoiWevl4NXLAYNjn0KtjqT
uVdgH4CxrAelgeBw1rWXg4K5/enCe1sYJk1cfIUwbrVn1GT0xd/1sIeH6uXR8drk
mRq+D270Ce2YIotP7+0xOev5uOPaUzQeTI3p1tocmDrHlzgoZ6T+hAZ6T9NENnom
SVhnEB7ZmHslxO8YVyPfkuoOUn/J/WgjwhfAD4/TawYoppkWhrWk1zayHeAnjX57
zunLfO6R8hnixDTySiHyXVgwy7Te7A==
=OGLo
-----END PGP SIGNATURE-----

--XEMZY2HieQ0Ithcn--

