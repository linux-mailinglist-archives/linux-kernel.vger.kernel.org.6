Return-Path: <linux-kernel+bounces-286917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FA98952060
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 18:49:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79ADDB245B9
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 16:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A33701BA870;
	Wed, 14 Aug 2024 16:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KYHIl4Bl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBBFC1B9B51
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 16:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723654173; cv=none; b=SepD/iz5JikSDMP/VteLZYiCMD6ueCucMwmE2IeAtsGX4pwR+1IBlHpVER9qvLjDBWJ5FtBDUdmvZp+6d8fzx9xNFHneTgJX5o0VqKFySgtBunrYlNMpiwygDVfp8tjalYXHHaPUwK7VVurofYdcwZ7GwCLPBP0vEctyziJCgas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723654173; c=relaxed/simple;
	bh=meqvXO3+nmuZ5AIXtSVgg8WAYFetsdNizUtH8eryubs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Td2GsL/WiUoKLEPm9dETHtBkxdi5FCdGTpfNwAk24ysEQiF8MDwOd2CM5CYgOOTasCGbRr5QT1mB1mzWxeVJwm+7OFS/sYUXuQ8GoUUlJqU4oXzPhMphsTBxKa7/AdyRxSFj/JeL2WvP3FUEuGh7Er0Hh/ei/f7hU4dZH68Kn6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KYHIl4Bl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCAEBC116B1;
	Wed, 14 Aug 2024 16:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723654172;
	bh=meqvXO3+nmuZ5AIXtSVgg8WAYFetsdNizUtH8eryubs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KYHIl4Blh/i77OC9N5FoMY//D7bQrsyMvbhheGmNID6geQzGDJhyX7DUmhvA9V1HF
	 tDY3heh+p+JbGaZ839bp7GA2+lM0r8oAKIv/iVnVZTDju+OaKOx8ZOPeJt9w1P6sjD
	 d+RH8EEzxly1Soxm/s5yjeh3m6oFqDs+aehkqgQWtoY7OZYqc02KqBPyRIFtueDLR3
	 WQtGxzHr/TKvETyuutYRO9UTjVQElN3zSyuBfpvSgTu3h62KeZkp72bW1sO62TKXvR
	 sGQMKkXvavl3cJUSW6xrvs57Mqchsgn6V/Rf6x6O4IVQQik3GBN7DzDCIjx9w+krD9
	 y3E+zKNE1I85g==
Date: Wed, 14 Aug 2024 17:49:23 +0100
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
	jesse-ji@ti.com, darren.ye@mediatek.com, antheas.dk@gmail.com,
	Jerry2.Huang@lcfuturecenter.com
Subject: Re: [PATCH v1] ASoc: tas2781: Add Calibration Kcontrols for
 Chromebook
Message-ID: <97275835-fff5-49ac-bd15-c6b6c6e89fe0@sirena.org.uk>
References: <20240726084757.369-1-shenghao-ding@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="QnAnomE4bcSDKfDc"
Content-Disposition: inline
In-Reply-To: <20240726084757.369-1-shenghao-ding@ti.com>
X-Cookie: The second best policy is dishonesty.


--QnAnomE4bcSDKfDc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 26, 2024 at 04:47:55PM +0800, Shenghao Ding wrote:
> Add calibration related kcontrol for speaker impedance calibration and
> speaker leakage check for Chromebook

This is pretty hard to understand, it feels like there's a bunch of
cleanup work in here along with the actual control addition and there's
nothing really saying anything concrete about the actual controls to
check that the controls do the right thing.  It's hard to do anything
but the most superficial review here since I don't really understand
what the changes are trying to accomplish.

> -/* pow(10, db/20) * pow(2,30) */
> -static const unsigned char tas2563_dvc_table[][4] =3D {
> -	{ 0X00, 0X00, 0X00, 0X00 }, /* -121.5db */

For example moving this to the header could be done separately (though
perhaps it should just be exported rather than placed in the header)?

> @@ -64,8 +64,8 @@ static int tasdevice_change_chn_book(struct tasdevice_p=
riv *tas_priv,
>  			 */
>  			ret =3D regmap_write(map, TASDEVICE_PAGE_SELECT, 0);
>  			if (ret < 0) {
> -				dev_err(tas_priv->dev, "%s, E=3D%d\n",
> -					__func__, ret);
> +				dev_err(tas_priv->dev, "%s, E=3D%d channel:%d\n",
> +					__func__, ret, chn);
>  				goto out;
>  			}
>  		}

This is another example of a random cleanup.

>  static void tasdev_load_calibrated_data(struct tasdevice_priv *priv, int=
 i)
>  {
> +	struct tasdevice_fw *cal_fmw =3D priv->tasdevice[i].cali_data_fmw;
> +	struct calidata *cali_data =3D &priv->cali_data;
> +	unsigned char *data =3D &cali_data->data[1];
>  	struct tasdevice_calibration *cal;
> -	struct tasdevice_fw *cal_fmw;
> +	int k =3D i * (cali_data->cali_dat_sz + 1);
> +	int j, rc;
> =20
> -	cal_fmw =3D priv->tasdevice[i].cali_data_fmw;
> +	/* Load the calibrated data from cal bin file */
> +	if (!priv->is_user_space_calidata && cal_fmw) {
> +		cal =3D cal_fmw->calibrations;
> =20
> -	/* No calibrated data for current devices, playback will go ahead. */
> -	if (!cal_fmw)
> +		if (cal)
> +			load_calib_data(priv, &cal->dev_data);
>  		return;

It feels like there's an abstraction problem with the different ways to
get calibration data.  Perhaps each way of loading calibration data
should parse the data into a standard format on load and then the rest
of the code doesn't need to worry about where it came from?

> @@ -67,8 +215,13 @@ static int tas2781_digital_getvol(struct snd_kcontrol=
 *kcontrol,
>  	struct tasdevice_priv *tas_priv =3D snd_soc_component_get_drvdata(codec=
);
>  	struct soc_mixer_control *mc =3D
>  		(struct soc_mixer_control *)kcontrol->private_value;
> +	int rc;
> +
> +	mutex_lock(&tas_priv->codec_lock);
> +	rc =3D tasdevice_digital_getvol(tas_priv, ucontrol, mc);
> +	mutex_unlock(&tas_priv->codec_lock);
> =20
> -	return tasdevice_digital_getvol(tas_priv, ucontrol, mc);
> +	return rc;
>  }
> =20

Why all these locking changes?  Could they be split out into a
praparatory change?

> +static int tasdevice_get_chip_id(struct snd_kcontrol *kcontrol,
> +			struct snd_ctl_elem_value *ucontrol)
> +{
> +	struct snd_soc_component *codec =3D snd_soc_kcontrol_component(kcontrol=
);
> +	struct tasdevice_priv *tas_priv =3D snd_soc_component_get_drvdata(codec=
);
> +
> +	ucontrol->value.integer.value[0] =3D tas_priv->chip_id;
> +
> +	return 0;
> +}

Should these chip ID controls be done separately?  They don't seem super
related.

--QnAnomE4bcSDKfDc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAma84BIACgkQJNaLcl1U
h9D5yQf/S2RGcP8shc2wriIE+yF1lZjsRkb33r0Lhu8jdZM2AkDS7vB7WgX5Yq/S
VLHewFCklL8gQF2tyLEBNsjt+nSzE0JBN65sGlLYnebPBb/stXw5Ld2H7j74+mLi
muB6v7LvP77hImPyOFDusq0T3swIU3MNqGpzWFaK428KnD7JOL7uZYuzt7GnKwOj
dJfX7xxOFpV66cwB8SBhY91y6ybBDC/qwC1N+kkSWAwWP6Z62c8bbVeI3rWx8dMq
e7Kq0m6cC2Xp9Xbm5MAvZPxzmrxMWtf6p/ALvDfjM2tEKTADXKYLX6foZK1lSZ62
wl3RVYwBq8rx0rLVJpF6ttXYc3Swhg==
=pFim
-----END PGP SIGNATURE-----

--QnAnomE4bcSDKfDc--

