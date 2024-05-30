Return-Path: <linux-kernel+bounces-195186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B6C18D48A0
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 11:34:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDBBD286189
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 09:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A733A1534ED;
	Thu, 30 May 2024 09:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uJyu+LBg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0E6145B38
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 09:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717061668; cv=none; b=ekOG13ovlWBr3x5ApROXCyy+foKVrzkhutIPEroYiRKMOEjMsKjcyYQdxWQCafAlRyqU0Wl4x3uE24uY07ahcSYO6UvckRiefd6jxtJNwZOctPPG4KvIyVjLThu1cEBwft3kSTLeZ9K73LaziEXuqIcZV74ErrcPfGx1wDfMKoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717061668; c=relaxed/simple;
	bh=tEQu35CaxhT9+Q6qAEJEskYUshMXy0do6KkUt7ceXLw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sb1YxngAwFj2MOBX3vUJ5tGwVLRkeVjn9vKddkK0CH5GmRVVOen69sRMZNR6lrqnQjJmy/1Sxmo7q+eX83gTDZ1fwDIG+H9vHYRv+HPktMYoSUXuXxg9ORLPWmCNIM9b14EjfbtaMzFnxSyXQef635a5CuZv8xljpknMRbXlp4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uJyu+LBg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F31D2C2BBFC;
	Thu, 30 May 2024 09:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717061667;
	bh=tEQu35CaxhT9+Q6qAEJEskYUshMXy0do6KkUt7ceXLw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uJyu+LBgo9JPAAsFFLlXJ1qJFP+qD0BC7jiXxbKMh0txds+0+h8QZeLsZs5yn95tj
	 rIBoQINUONJ1IgqwfT+eXCz7QwhlNHCdJTj9uHbAcpmwFbhLTzjMbp8PmZ5uQhcJ4q
	 Y2rlMKe+XYLdEFmN0vvC7xw4YLX68qGDBrUEP1fdvx0mxVGbHVNnh8rOc5145zvEWT
	 4NEuknsI7Q1I7vpgAC2eBqe2fxpawGQ4UxsKqZo8dMU17QNWb6kjRL/lz8qxfQ50d8
	 /smnXzxTnDqo2ql3epJ2Hs0c+hYeH615vfDPT43W4MVaqEjCghDVG4XMAtUJ2RlAPl
	 7JjMDbNIB+hWg==
Date: Thu, 30 May 2024 11:34:24 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Jayesh Choudhary <j-choudhary@ti.com>
Cc: linux-kernel@vger.kernel.org, dmitry.baryshkov@linaro.org, 
	andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org, 
	Laurent.pinchart@ideasonboard.com, sam@ravnborg.org, jonas@kwiboo.se, jernej.skrabec@gmail.com, 
	maarten.lankhorst@linux.intel.com, tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch, 
	a-bhatia1@ti.com, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v4 2/2] drm/bridge: Add pixel clock check in atomic_check
Message-ID: <20240530-spiked-psychedelic-monkey-ddd0b0@houat>
References: <20240530092930.434026-1-j-choudhary@ti.com>
 <20240530092930.434026-3-j-choudhary@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="eqvyt5rrxiedz2k4"
Content-Disposition: inline
In-Reply-To: <20240530092930.434026-3-j-choudhary@ti.com>


--eqvyt5rrxiedz2k4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, May 30, 2024 at 02:59:30PM GMT, Jayesh Choudhary wrote:
> Check the pixel clock for the mode in atomic_check and ensure that
> it is within the range supported by the bridge.
>=20
> Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
> ---
>  drivers/gpu/drm/bridge/sii902x.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/bridge/sii902x.c b/drivers/gpu/drm/bridge/si=
i902x.c
> index 6a6055a4ccf9..1bf2f14a772d 100644
> --- a/drivers/gpu/drm/bridge/sii902x.c
> +++ b/drivers/gpu/drm/bridge/sii902x.c
> @@ -494,6 +494,12 @@ static int sii902x_bridge_atomic_check(struct drm_br=
idge *bridge,
>  				       struct drm_crtc_state *crtc_state,
>  				       struct drm_connector_state *conn_state)
>  {
> +	if (crtc_state->mode.clock < SII902X_MIN_PIXEL_CLOCK_KHZ)
> +		return MODE_CLOCK_LOW;
> +
> +	if (crtc_state->mode.clock > SII902X_MAX_PIXEL_CLOCK_KHZ)
> +		return MODE_CLOCK_HIGH;
> +

atomic_check doesn't return drm_mode_status but regular error codes (0
on success, negative error code on failure)

Maxime

--eqvyt5rrxiedz2k4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZlhIIAAKCRAnX84Zoj2+
dmtDAYDKG/BmH6pQDT3/a9jAZw6MLC3PDP1ck88oGHUNjjKiyUhwBwrTl/m0ZG4E
BnoybWsBgMVO4kmBlXkJ4Ee2H26nQTt68ithsfMMFyxYYmZ6gS2qoV6snRnbJ9SF
KUcF31qy8g==
=SvhA
-----END PGP SIGNATURE-----

--eqvyt5rrxiedz2k4--

