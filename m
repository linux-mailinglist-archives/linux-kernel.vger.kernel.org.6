Return-Path: <linux-kernel+bounces-252931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D51E931A02
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 20:12:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E4A6B214B9
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 18:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46C9761FC5;
	Mon, 15 Jul 2024 18:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yiv7Ul2N"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867BA1CAB8
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 18:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721067143; cv=none; b=JdstiVTfTqa/otQJB7tiEODLOxqf+/iQ/h/AY32/NZkw3FHl69Pg5j+vg4uUNiBfN4eafyXjkdJ2eBPqro7ThjC6QiZ+bsC5rVxt2RgeSUf7vRv61WEAJKrzfckEC64NOcfQxswRTREh45T99ri++MQd94bjPVF2YMSyj53NzkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721067143; c=relaxed/simple;
	bh=pLUCLcj5O7Hs2oy5g+ASmTVqngMsfK+KdVlmFvVar5w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b8KhezNDC0Kql6swBhn/wY6QGh2Tyw61lMNlAc9f/ZcLW5ScGE8W7MWi/q1G+zZPXAA6fsPI3/2nNOvp/xY/WG/xsf71drgAkMX0YQcjGPchtlhvKiDeJKLKTwRU9OR38Qa8JJnWa0PHkS8lXAu9NFYkinxht/98AEgVlPGvWSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yiv7Ul2N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E91CC32782;
	Mon, 15 Jul 2024 18:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721067143;
	bh=pLUCLcj5O7Hs2oy5g+ASmTVqngMsfK+KdVlmFvVar5w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Yiv7Ul2NS27UxVMf3NjfnzW9ZuxOHjXrHc+tH+VF6XZTqCPEp5pTCGzlRzA/RqL5f
	 NdP6ljzkUmrqWhPjfC0uFEAskBuGLzDW84quwIJLDsHjn0cepStiIEBhB/fEo0ofSc
	 f5Xy3ocpbDkDGr/1VNsWJadJuVCfEe9JPyNFh57tVlg5qUzO7DDEdghkquDaOXG7NH
	 PXD5wgH7NfsoYbccRpFJmy/RMzmsej+HzfQuQJWXvduhuBMJAa8PV/xy0roPkkHvax
	 co2QcNLePB5CDJwd4s7PIUwt+rP7PjFMzIw9l/gJrbGj2Iv7XdaKEv/r7/rRxwfKaf
	 7SVGjW4wtFWyQ==
Date: Mon, 15 Jul 2024 19:12:12 +0100
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
Subject: Re: [PATCH v1 1/2] ASoc: tas2781: Add TAS2563 into the Header
Message-ID: <124ded12-330c-4a4a-814e-2dbf1b9b7ca3@sirena.org.uk>
References: <20240713015145.314-1-shenghao-ding@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="34Rj9qeN6Q5B9sxB"
Content-Disposition: inline
In-Reply-To: <20240713015145.314-1-shenghao-ding@ti.com>
X-Cookie: You'll be sorry...


--34Rj9qeN6Q5B9sxB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Jul 13, 2024 at 09:51:41AM +0800, Shenghao Ding wrote:
> Add TAS2563 into the Header in case of misunderstanding.

> @@ -64,8 +64,8 @@ static int tasdevice_change_chn_book(struct tasdevice_priv *tas_priv,
>  			 */
>  			ret = regmap_write(map, TASDEVICE_PAGE_SELECT, 0);
>  			if (ret < 0) {
> -				dev_err(tas_priv->dev, "%s, E=%d\n",
> -					__func__, ret);
> +				dev_err(tas_priv->dev, "%s, E=%d channel:%d\n",
> +					__func__, ret, chn);
>  				goto out;
>  			}

This is reasonable enough but doesn't match the changelog.

--34Rj9qeN6Q5B9sxB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmaVZnwACgkQJNaLcl1U
h9BeIggAgkYmHKZJ49Lm54AHQh4wEMi2FvlO+BiEd6YTMNcbNq2Zt3R5dCtbIoGE
xSSbxV9/T6WbVdoTjPyXTRIlfZrhJ8VKtdD/+PoiXRtnJv1APcIfs/fDIxRkjxOV
xBRCFrtzW66gIosKXGo2Z+BQ5t+JGzq5XBU3cNynqbSteNHnLSgAjNGaelvJX0wA
/+mS8Cz4/9BBMhsokGT+goQhjPkqmxZ+ByK9LeDpplYjitJm/Xj1JvuUBeHmnf+V
GiuZGsZf1867dV6dOkNiL3DKtUp6rMZJuiQSkRgCoL8NOSOZ80uPJ7GMKYRAw2RK
7FOjSzQuaAJBuLBtT3Mfm0BHHzvOYw==
=DS+E
-----END PGP SIGNATURE-----

--34Rj9qeN6Q5B9sxB--

