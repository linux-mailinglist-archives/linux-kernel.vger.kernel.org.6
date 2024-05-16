Return-Path: <linux-kernel+bounces-180987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F4468C75D3
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 14:18:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5ACBB284C64
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 12:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AF48145FE0;
	Thu, 16 May 2024 12:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ja4iCsqE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582E122075;
	Thu, 16 May 2024 12:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715861887; cv=none; b=RIlP3xvUhrLUyyM9bt6wDpTwjWouQvqmMKX+XEydNYy37qdaUZD8LjWjBXYpqUFnaOyMUHxKUXTbIQ79vb5nNV0ERpHa6Qhn8xYrFvp7GYIFgkaFGQV1oNVmvrlS8k74C/DgTn+LtZRbLCjHONZRBx1ulO2zsNGtCb1neXrqqTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715861887; c=relaxed/simple;
	bh=xIBvgUA3GxPMhfgmzaW4zOWO/kjFOkYCDtn0FkIzZSI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B7VDSViSnP8DqTfHlVSn83lCawXMNPl62x/6oWxHQUjuqMzEY0kHVgvk9VGusyb7peR1LI11vfhQ/YDpNRBFGiAEfxZo6HCbS/HDVwtR8qbyEeqdodYm4Xps4mPZXw73FuOkS9bk8oztB18ko3aWSwUVwbsaUmjI4OQTYWSXUJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ja4iCsqE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65724C113CC;
	Thu, 16 May 2024 12:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715861887;
	bh=xIBvgUA3GxPMhfgmzaW4zOWO/kjFOkYCDtn0FkIzZSI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ja4iCsqEuuzYg8BupkdjBsN2Ry+ctT+W0pZt0icJqpavJRjyEC6s3v3vlQCfyK0s7
	 ovL4vjFh28xGivUCIRHW7v71UTmnB8/VMhCRHqy/zbPf+IavRmmupIfw/iDfIjyDbT
	 tVerabbA1NrsSPHh9hUvUoVLrdw0l6NscBct74hoGACqZ9RlRSY6Ev1cS/DTwXCXWK
	 UZ9SfFemywcbXYcp+Oz60r3FmlZMW4QjeSivnTqEWV69XZeTPkFtCT71vmwnWxJODR
	 dOHSH6To38jOcHOTrHNiWnN8LRAm0axg/+ZEQuQ/NxbNC1m6pIeJgL0VQ5aRt6MfQT
	 nI4tl4RXT24YQ==
Date: Thu, 16 May 2024 13:18:00 +0100
From: Mark Brown <broonie@kernel.org>
To: Elinor Montmasson <elinor.montmasson@savoirfairelinux.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shengjiu Wang <shengjiu.wang@gmail.com>,
	Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <festevam@gmail.com>,
	Nicolin Chen <nicoleotsuka@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
	linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCHv4 8/9] ASoC: fsl-asoc-card: add DT property
 "cpu-system-clock-direction-out"
Message-ID: <20d8eb96-6346-4341-95ee-74729001c01a@sirena.org.uk>
References: <20240515135411.343333-1-elinor.montmasson@savoirfairelinux.com>
 <20240515135411.343333-9-elinor.montmasson@savoirfairelinux.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qyP2+HTgE4Ups3SO"
Content-Disposition: inline
In-Reply-To: <20240515135411.343333-9-elinor.montmasson@savoirfairelinux.com>
X-Cookie: I'm having a MID-WEEK CRISIS!


--qyP2+HTgE4Ups3SO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 15, 2024 at 03:54:10PM +0200, Elinor Montmasson wrote:
> Add new optional DT property "cpu-system-clock-direction-out" to set
> sysclk direction as "out" for the CPU DAI when using the generic codec.
> It is set for both Tx and Rx.
> If not set, the direction is "in".
> The way the direction value is used is up to the CPU DAI driver
> implementation.

This feels like we should be using the clock bindings to specify the
clock input of whatever is using the output from the SoC, though that's
a lot more work.

--qyP2+HTgE4Ups3SO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZF+XcACgkQJNaLcl1U
h9BOcAgAgLtirZZNkJCJym3Zg2exAkuMznCbG3vzhug2rdyPFeYCt7+q3uMqs9QL
ehCjibTUMcmLCA4pJA5G6l+OS+Fy9fAuaZc3tIADu0AcarzVHsy96kWjlUnkJTTo
IIcoydNZKalL0k4wMPB48k5pxCeo4eOjHql//4G+IauEcMgEOHbzwf+17CJPXsq1
x3NqwVfmrKBUy8ze66Rxjis67wEhMd7360LCdRtiOZQIf/JEzKCV0v/s0UwhmHVP
VR8c5o/YUpMNGefA317nPw8Tw9hVgqtLYV1hLwYn/C7QzIrIhGPn7m16h57m6IPz
N8JFnC+MvXIZjtMWx00is/tRmxqM6g==
=T9W3
-----END PGP SIGNATURE-----

--qyP2+HTgE4Ups3SO--

