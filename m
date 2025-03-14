Return-Path: <linux-kernel+bounces-561948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95792A61917
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 19:10:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9594175370
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 18:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D688204098;
	Fri, 14 Mar 2025 18:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V+CccntG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B9C2E3389;
	Fri, 14 Mar 2025 18:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741975844; cv=none; b=r13TGhMJ0jM2dVAjvB1LWW0cRCR22GMipo+cD6BB003oTdvkPASkh7zIZB2+scsZZS1sGaPTl6KHZfgJwa+nkL+jBYoQUHD/47L2wF7XsRqQtoETv3CBPlEUEXa+Q3Ma8ncYedi5qo5WyC9FhcqHs6mdKkUxZKLbxUF4vHlMmH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741975844; c=relaxed/simple;
	bh=GUBpMm6oomjtS9UWURbwiJnVJD5A8VtOUo4HCzFBqOE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pIZ1fN9OHepedXFGuWGIBDZZcfFUq9LW1X8KUxQ9YNZUyoGjS6Q+cLBRQz6TV3CbeDJDRzvV4mEgwvqDBNEnjcbmCGndAPx45yIRr7Kz5mL1CVpCq/2PltYhcRyGqApRRcedVMFkNZGY9ioASQWMpH2YeBgVZGrPakq9kae5dJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V+CccntG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACDEFC4CEE9;
	Fri, 14 Mar 2025 18:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741975844;
	bh=GUBpMm6oomjtS9UWURbwiJnVJD5A8VtOUo4HCzFBqOE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V+CccntGTMKTSI08JPci1UF0sYzB5R0BMqvdDOmRb8mdn77ZEo9aRGjcNEJy3565m
	 q0t3ZFWr3HoSLznR0cfwy8bImJcgwa0vA+K4qzJDlkah9Uy/yuekVB4Dqnt4I3PDbM
	 Auye8C4tt03P717Sri/Y4yjyGBqAcJQE1fqzhEdYe5UJhNXv/TO7spHMH7qfq65Cz7
	 ytUKk5y01X3TjRFROLrShwrI9UjIsqPlypRgMeSbx4/1zPpGZYkbdzIrTzwr32hbeO
	 AWf/qJ5tMqFDsCcNqAxgzv5DI6P8rmf9p7kWYhFaiYq9kW7WEPYTMTkE34OZCr/sBP
	 /s3SvWINwXdHg==
Date: Fri, 14 Mar 2025 19:10:41 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Marek Vasut <marex@denx.de>, Stefan Agner <stefan@agner.ch>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	Inki Dae <inki.dae@samsung.com>, Jagan Teki <jagan@amarulasolutions.com>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
	Anusha Srivatsa <asrivats@redhat.com>, Paul Kocialkowski <paulk@sys-base.io>, 
	Dmitry Baryshkov <lumag@kernel.org>, =?utf-8?B?SGVydsOp?= Codina <herve.codina@bootlin.com>, 
	Hui Pu <Hui.Pu@gehealthcare.com>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v7 06/11] drm/bridge: get the bridge returned by
 drm_bridge_chain_get_first_bridge()
Message-ID: <20250314-aspiring-myrtle-husky-a5f4ac@houat>
References: <20250314-drm-bridge-refcount-v7-0-152571f8c694@bootlin.com>
 <20250314-drm-bridge-refcount-v7-6-152571f8c694@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="isweh2hn5bnofcnk"
Content-Disposition: inline
In-Reply-To: <20250314-drm-bridge-refcount-v7-6-152571f8c694@bootlin.com>


--isweh2hn5bnofcnk
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v7 06/11] drm/bridge: get the bridge returned by
 drm_bridge_chain_get_first_bridge()
MIME-Version: 1.0

On Fri, Mar 14, 2025 at 11:31:19AM +0100, Luca Ceresoli wrote:
> drm_bridge_chain_get_first_bridge() returns a bridge pointer that the
> caller could hold for a long time. Increment the refcount of the returned
> bridge and document it must be put by the caller.
>=20
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
>=20
> ---
>=20
> This patch was added in v7.
> ---
>  include/drm/drm_bridge.h | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>=20
> diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
> index a5accd64c364ebb57903ae1e7459034ad9ebf4f3..d9777d5f2e9ef006f0062e450=
7bce99df4146cd9 100644
> --- a/include/drm/drm_bridge.h
> +++ b/include/drm/drm_bridge.h
> @@ -1105,6 +1105,9 @@ drm_bridge_get_prev_bridge(struct drm_bridge *bridg=
e)
>   * drm_bridge_chain_get_first_bridge() - Get the first bridge in the cha=
in
>   * @encoder: encoder object
>   *
> + * The refcount of the returned bridge is incremented. Use drm_bridge_pu=
t()
> + * when done with it.
> + *
>   * RETURNS:
>   * the first bridge in the chain, or NULL if @encoder has no bridge atta=
ched
>   * to it.
> @@ -1112,8 +1115,8 @@ drm_bridge_get_prev_bridge(struct drm_bridge *bridg=
e)
>  static inline struct drm_bridge *
>  drm_bridge_chain_get_first_bridge(struct drm_encoder *encoder)
>  {
> -	return list_first_entry_or_null(&encoder->bridge_chain,
> -					struct drm_bridge, chain_node);
> +	return drm_bridge_get(list_first_entry_or_null(&encoder->bridge_chain,
> +						       struct drm_bridge, chain_node));
>  }

We'll need to modify drm_bridge_get_next_bridge, drm_bridge_get_prev_bridge=
, and
drm_for_each_bridge_in_chain in a similar manner, but for this one

Reviewed-by: Maxime Ripard <mripard@kernel.org>

Maxime

--isweh2hn5bnofcnk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZ9RxIQAKCRAnX84Zoj2+
dpOTAX0S4kYV1tOUty+kqLjtPal9GsCYRFqXKFnFw8v/vOB6r9g6O1iB9NF6Fuei
eWtscfEBgNdNVATng2hmNpDKPKzMj3MJjHtfjcUN5zb7Je++I+OBx8qk+kLSKPcs
cymXEqjh8g==
=khjF
-----END PGP SIGNATURE-----

--isweh2hn5bnofcnk--

