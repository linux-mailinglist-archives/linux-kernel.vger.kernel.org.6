Return-Path: <linux-kernel+bounces-421342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DDBE9D89DC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 17:01:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2BD5284C39
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 16:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F4A41B3725;
	Mon, 25 Nov 2024 16:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BTXAXBwj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5B22500D2;
	Mon, 25 Nov 2024 16:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732550459; cv=none; b=rMJFy84gZKQUeCzgetzGHa2ht3t6Tqq33jZur8Q1N9koxRapWcN9B12b8pYoWXvtsRcq5o/onEqoNhRGmKpfQgQQDabiidtFqKlrtcCJrov29ts0tKrpAcCXzsduLPT4FOj46777qQgW7/eKv/fiaTA8OsRaRJguGf2hIy2zN04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732550459; c=relaxed/simple;
	bh=e8G0lW8ogmFnCkbf2xG8A2bDIU0/6g5brVU3VCxn4pI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OKJsZev7ztroQaQrDs/zfvw5wSj/0VDLceY8viVzt5NAyKi8OErXsIsSW+EUNvVRImdI1nk+a21aeZK/D1EhqfvYsrQ4OMLU3+rBfhb8PInR9mzMItk87yIPtoWiOucPyT1/PBn6/RbbijNPlsscyMJL8MV04Z/AsDR94fwYhLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BTXAXBwj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE3F0C4CECE;
	Mon, 25 Nov 2024 16:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732550459;
	bh=e8G0lW8ogmFnCkbf2xG8A2bDIU0/6g5brVU3VCxn4pI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BTXAXBwjhY/HJi/6PiReBk/XD60n4+dRiLQDWeRuAyfeiuKnNmqheHpR0ZSmbzgZ7
	 YxKNbpxOYg9NSgQF7keI83FZKEzB2vI5gJ1TQKHU3TI7Yjh7otMEEFLAOGf7KjBFv3
	 /TB4P+rbIPEoDj/F/E9FH2/SFgWnIolBMdF6kCyl5S7eKQ3499lALGhJAqIbp3K+PX
	 7idtOc4jU0njV8sdmH+10anm/HP18wjyhafgbp1Pg5IfoaIeFfDDN7fYhdUbuRuRV7
	 gmQXVBNZwc7DHgPtrBVs2esgTF4A+4zaaJZ+2gRgKTHlbXQCc59U/8MXdJNmxuGvVT
	 PXfMDBruc0IXQ==
Date: Mon, 25 Nov 2024 17:00:56 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Sean Nyekjaer <sean@geanix.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Chen-Yu Tsai <wens@csie.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Yannick Fertre <yannick.fertre@foss.st.com>, Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>, 
	Philippe Cornu <philippe.cornu@foss.st.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
	linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH v2 1/3] drm/modes: introduce drm_mode_validate_mode()
 helper function
Message-ID: <20241125-gleaming-anteater-of-perfection-42bd2b@houat>
References: <20241125-dsi-relax-v2-0-9113419f4a40@geanix.com>
 <20241125-dsi-relax-v2-1-9113419f4a40@geanix.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="7iaeslrnyclrukm7"
Content-Disposition: inline
In-Reply-To: <20241125-dsi-relax-v2-1-9113419f4a40@geanix.com>


--7iaeslrnyclrukm7
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 1/3] drm/modes: introduce drm_mode_validate_mode()
 helper function
MIME-Version: 1.0

Hi Sean,

On Mon, Nov 25, 2024 at 02:49:26PM +0100, Sean Nyekjaer wrote:
> Check if the required pixel clock is in within .5% range of the
> desired pixel clock.
> This will match the requirement for HDMI where a .5% tolerance is allowed.
>=20
> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> ---
>  drivers/gpu/drm/drm_modes.c | 34 ++++++++++++++++++++++++++++++++++
>  include/drm/drm_modes.h     |  2 ++
>  2 files changed, 36 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/drm_modes.c b/drivers/gpu/drm/drm_modes.c
> index 6ba167a3346134072d100af0adbbe9b49e970769..4068b904759bf80502efde6e4=
d977b297f5d5359 100644
> --- a/drivers/gpu/drm/drm_modes.c
> +++ b/drivers/gpu/drm/drm_modes.c
> @@ -1623,6 +1623,40 @@ bool drm_mode_equal_no_clocks_no_stereo(const stru=
ct drm_display_mode *mode1,
>  }
>  EXPORT_SYMBOL(drm_mode_equal_no_clocks_no_stereo);
> =20
> +/**
> + * drm_mode_validate_mode
> + * @mode: mode to check
> + * @rounded_rate: output pixel clock
> + *
> + * VESA DMT defines a tolerance of 0.5% on the pixel clock, while the
> + * CVT spec reuses that tolerance in its examples, so it looks to be a
> + * good default tolerance for the EDID-based modes. Define it to 5 per
> + * mille to avoid floating point operations.
> + *
> + * Returns:
> + * The mode status
> + */
> +enum drm_mode_status drm_mode_validate_mode(const struct drm_display_mod=
e *mode,
> +					    unsigned long long rounded_rate)
> +{
> +	enum drm_mode_status status;
> +	unsigned long long rate =3D mode->clock * 1000;
> +	unsigned long long lowest, highest;
> +
> +	lowest =3D rate * (1000 - 5);
> +	do_div(lowest, 1000);
> +	if (rounded_rate < lowest)
> +		return MODE_CLOCK_LOW;
> +
> +	highest =3D rate * (1000 + 5);
> +	do_div(highest, 1000);
> +	if (rounded_rate > highest)
> +		return MODE_CLOCK_HIGH;
> +
> +	return MODE_OK;
> +}
> +EXPORT_SYMBOL(drm_mode_validate_mode);

Thanks a lot for doing that!

I wonder about the naming though (and prototype). I doesn't really
validates a mode, but rather makes sure that a given rate is a good
approximation of a pixel clock. So maybe something like
drm_mode_check_pixel_clock?

We probably need some kunit tests here too.

Maxime

--7iaeslrnyclrukm7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZ0SfMwAKCRAnX84Zoj2+
dp/LAX9KInEW+AE031WPvNsZu9uS0+xLFqEfIThuSCuXbnCM2H3Nz9ARAE+st+tg
1gd7pvABgIRkWDpLPaiGD3xvUJX3GM3Ebv50pWcCZHCWEhySv4P6zkew6y8w3RWs
hqB4Vy/oAA==
=kJ1A
-----END PGP SIGNATURE-----

--7iaeslrnyclrukm7--

