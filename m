Return-Path: <linux-kernel+bounces-217266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0545290AD97
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 14:07:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C3311C22E6B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 12:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C8CC194C6C;
	Mon, 17 Jun 2024 12:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oUPASJIm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A6E17FAA2;
	Mon, 17 Jun 2024 12:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718626068; cv=none; b=BoUnPfn+LGl5/QGTEPw81h9i1xmVju8Ms2a02dYlmFaydAHDj38auRGQWPwE9galxbBuj3lQCT/26PB3iL7+s+DVkhRMprCC2rhOTWSSxRtDXcLmNT80wnn8ECzQ8UAfqpGRBG8lVlCkVTs752TgdASxgAWrDFXDeydSTGYojMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718626068; c=relaxed/simple;
	bh=lLf4l6RsdqXzGuno7XkQH16nzoJvIKQHVIIM8S2lni0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c+iNWeoeTUA/rEjJKzs1GWK7TMrqMDM+cFGBmiIXpa1H0oF1SeQ9JtLpHe2ibmh+yA8LWnyIBvoGKaSW8BcEJVK5N3tZxEmYX6dHmz9+r32u/wtCb5RNKeP2GCFpaW1PY2n3yKFQZQgpDDZiC8B67npzqb2UhlzYY2ktxcYqsz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oUPASJIm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49683C2BD10;
	Mon, 17 Jun 2024 12:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718626067;
	bh=lLf4l6RsdqXzGuno7XkQH16nzoJvIKQHVIIM8S2lni0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oUPASJIm+bV/3LFwysjCkUOcpMLIYbDiZ1PD4hYFkmBiXBoBkA4pY9t79A8lWV39S
	 2qzpeq0ChuXqAOb02aApgiGRL25ykRONP+EUNZIEbEf1JrBLPXpx2RitWtp0iFC+Cl
	 ktyOmX93LLc/ser+JfArp97qVcvyPu3ZURfWBQ1v8HtjtruLjTtyLjizI+5o3XPVH/
	 IvfnH3lWgeXcvPqsFWRfy1yXaAM7ra8Sl/7hqXzPTvQRj8A+pgZ245HKUyfJixFvyH
	 uK7FhMFEhFb67bSQU3tDyPQk6k3Z6BKIdQ65yAJb98zLRs9K/wEJPSFoM91ldCrJe7
	 AirYH7yy/G1BQ==
Date: Mon, 17 Jun 2024 13:07:39 +0100
From: Mark Brown <broonie@kernel.org>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org
Subject: Re: [PATCH RFC 2/5] ASoC: hdmi-codec: pass data to get_dai_id too
Message-ID: <723df0d7-fd52-4b14-bc59-254d94369721@sirena.org.uk>
References: <20240615-drm-bridge-hdmi-connector-v1-0-d59fc7865ab2@linaro.org>
 <20240615-drm-bridge-hdmi-connector-v1-2-d59fc7865ab2@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="XtVbdI0Tw2PNjcEk"
Content-Disposition: inline
In-Reply-To: <20240615-drm-bridge-hdmi-connector-v1-2-d59fc7865ab2@linaro.org>
X-Cookie: Life is the urge to ecstasy.


--XtVbdI0Tw2PNjcEk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Jun 15, 2024 at 08:53:31PM +0300, Dmitry Baryshkov wrote:
> The upcoming DRM connector HDMI codec implementation is going to use
> codec-specific data in the .get_dai_id to get drm_connector. Pass data
> to the callback, as it is done with other hdmi_codec_ops callbacks.

Acked-by: Mark Brown <broonie@kernel.org>

--XtVbdI0Tw2PNjcEk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZwJwsACgkQJNaLcl1U
h9Ddiwf7B9RIPxE1KgzuGsGiFXQOUSUjl3Yznz5/+WBr2xZJpAlBHYswQFGUEikT
Gu6kk6LDHX6vF9wV+Z1Uq1U/LRSjYfPa+zl2+R+4A9vvyUxooQSTDpTu4KNcBDX7
D3TpXv9axeb9RPmfH0fw6FX4ABxz3Tpwz2fQGFzLAh6PaVA9O9CNNWgkDKvE61Ke
4EWvmr6GB1erLa97l68vEGCjTTejAs97ZXFxZYGPdmK/FqjeyR2dEPUYfgzQmgi3
W1uA0uI3jqFGv74skoytSEOR3i1eToyvYzidUkhO6Gz7nIBLBlbw/i/j5tV0UeoB
HW4EKT4EkpO2IGygQWnl0C0tH4PJpw==
=gM/U
-----END PGP SIGNATURE-----

--XtVbdI0Tw2PNjcEk--

