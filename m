Return-Path: <linux-kernel+bounces-177408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AD4B8C3E22
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 11:30:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7233CB20B09
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 09:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEF351487E8;
	Mon, 13 May 2024 09:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q3aIE0UI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B7F31474B1
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 09:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715592602; cv=none; b=hHD+pXWe4Nd0Kdra3FXHO8gDJR7QGNP/kCdygbNBliHHDlPxc0I1RKWdx+E5hWSiMc3SRlNUWxNX4hNF221cXk+03cTEIORXJo2ZIX/u/QGHfdKgQAkvJMhI7CGL+h2kcv4qzb3llxZDrP4ujdTgdVfgYePz2TJ847o0m9O5bP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715592602; c=relaxed/simple;
	bh=SgD0haG+Licdrhd4sV75XBEAf7AIJuM4HFLb1qTh+Yo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T8Yvg3PgNohs9aOac+arB+LgQcUBZ/CcTL7kPRyPLobZFFmkBJJ6ThASOliGPA4bzhj1cOLVGzQbLl66+rnHxvHt7BXIOhaKlSZXVPywbgFeGmeudFo98uF4IbZuY8AFGyialtrgekQNnhEkQk5FFz8w07UTpwQwxgIbuvYeDag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q3aIE0UI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CBA3C32782;
	Mon, 13 May 2024 09:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715592601;
	bh=SgD0haG+Licdrhd4sV75XBEAf7AIJuM4HFLb1qTh+Yo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q3aIE0UIWqAIA8I+MAyr39jtZfjZM6dAhsRWYX9NlXVgRpSrcLpmKXzu1G+Oqn53N
	 E9N9vUfOKytKJ3N4k+DiS5pA34dwHy1V9qzC17G7YA2OFPpxN22ynKvSe8GcFsdoEV
	 lzwAWGW3dno95Db/dVZ7eR64cXPbcAOV1tAm6FM0JBGKiqqYtpz3BB1sgb/g74PZbT
	 MKyJC+S1DO0/RMUa+ZEt7OfNXsF8DUqBb1DuHDAoLQGqN4zs7OHhPEXEgBUxfC4Rsk
	 692uyI9EpObLGvVkfXNQzG6KpWtBO4wSRDNjiJbl5bvP2T+ZLhIOher3YtqFzR5Y4J
	 HhjwVyt444hMA==
Date: Mon, 13 May 2024 11:29:58 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Douglas Anderson <dianders@chromium.org>
Cc: dri-devel@lists.freedesktop.org, 
	lvzhaoxiong@huaqin.corp-partner.google.com, Jani Nikula <jani.nikula@linux.intel.com>, 
	Hsin-Yi Wang <hsinyi@google.com>, Linus Walleij <linus.walleij@linaro.org>, 
	Javier Martinez Canillas <javierm@redhat.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Cong Yang <yangcong5@huaqin.corp-partner.google.com>, Sam Ravnborg <sam@ravnborg.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Joel Selvaraj <jo@jsfamily.in>, 
	Brian Norris <briannorris@chromium.org>, Daniel Vetter <daniel@ffwll.ch>, 
	David Airlie <airlied@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/9] drm/mipi-dsi: Reduce driver bloat of
 mipi_dsi_*_write_seq()
Message-ID: <20240513-solemn-yak-of-refinement-cb778a@penduick>
References: <20240508205222.2251854-1-dianders@chromium.org>
 <20240508135148.v4.4.Id15fae80582bc74a0d4f1338987fa375738f45b9@changeid>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="fdnrbzflhblyceom"
Content-Disposition: inline
In-Reply-To: <20240508135148.v4.4.Id15fae80582bc74a0d4f1338987fa375738f45b9@changeid>


--fdnrbzflhblyceom
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, May 08, 2024 at 01:51:46PM -0700, Douglas Anderson wrote:
> Through a cooperative effort between Hsin-Yi Wang and Dmitry
> Baryshkov, we have realized the dev_err() in the
> mipi_dsi_*_write_seq() macros was causing quite a bit of bloat to the
> kernel. Let's hoist this call into drm_mipi_dsi.c by adding a "chatty"
> version of the functions that includes the print. While doing this,
> add a bit more comments to these macros making it clear that they
> print errors and also that they return out of _the caller's_ function.
>=20
> Without any changes to clients this gives a nice savings. Specifically
> the macro was inlined and thus the error report call was inlined into
> every call to mipi_dsi_dcs_write_seq() and
> mipi_dsi_generic_write_seq(). By using a call to a "chatty" function,
> the usage is reduced to one call in the chatty function and a function
> call at the invoking site.
>=20
> Building with my build system shows one example:
>=20
> $ scripts/bloat-o-meter \
>   .../before/panel-novatek-nt36672e.ko \
>   .../after/panel-novatek-nt36672e.ko
> add/remove: 0/0 grow/shrink: 0/1 up/down: 0/-4404 (-4404)
> Function                                     old     new   delta
> nt36672e_1080x2408_60hz_init               10640    6236   -4404
> Total: Before=3D15055, After=3D10651, chg -29.25%
>=20
> Note that given the change in location of the print it's harder to
> include the "cmd" in the printout for mipi_dsi_dcs_write_seq() since,
> theoretically, someone could call the new chatty function with a
> zero-size array and it would be illegal to dereference data[0].
> There's a printk format to print the whole buffer and this is probably
> more useful for debugging anyway. Given that we're doing this for
> mipi_dsi_dcs_write_seq(), let's also print the buffer for
> mipi_dsi_generic_write_seq() in the error case.
>=20
> It should be noted that the current consensus of DRM folks is that the
> mipi_dsi_*_write_seq() should be deprecated due to the non-intuitive
> return behavior. A future patch will formally mark them as deprecated
> and provide an alternative.
>=20
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
>=20
> Changes in v4:
> - Update wording as per Linus W.
>=20
> Changes in v3:
> - Rebased upon patch to remove ratelimit of prints.
>=20
> Changes in v2:
> - Add some comments to the macros about printing and returning.
> - Change the way err value is handled in prep for next patch.
> - Modify commit message now that this is part of a series.
> - Rebased upon patches to avoid theoretical int overflow.
>=20
>  drivers/gpu/drm/drm_mipi_dsi.c | 56 ++++++++++++++++++++++++++++++++++
>  include/drm/drm_mipi_dsi.h     | 47 +++++++++++++++-------------
>  2 files changed, 82 insertions(+), 21 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/drm_mipi_dsi.c b/drivers/gpu/drm/drm_mipi_ds=
i.c
> index 795001bb7ff1..8593d9ed5891 100644
> --- a/drivers/gpu/drm/drm_mipi_dsi.c
> +++ b/drivers/gpu/drm/drm_mipi_dsi.c
> @@ -764,6 +764,34 @@ ssize_t mipi_dsi_generic_write(struct mipi_dsi_devic=
e *dsi, const void *payload,
>  }
>  EXPORT_SYMBOL(mipi_dsi_generic_write);
> =20
> +/**
> + * mipi_dsi_generic_write_chatty() - mipi_dsi_generic_write() w/ an erro=
r log
> + * @dsi: DSI peripheral device
> + * @payload: buffer containing the payload
> + * @size: size of payload buffer
> + *
> + * Like mipi_dsi_generic_write() but includes a dev_err_ratelimited()

You mention in both functions that it's calling dev_err_ratelimited() ...

> + * call for you and returns 0 upon success, not the number of bytes sent.
> + *
> + * Return: 0 on success or a negative error code on failure.
> + */
> +int mipi_dsi_generic_write_chatty(struct mipi_dsi_device *dsi,
> +				  const void *payload, size_t size)
> +{
> +	struct device *dev =3D &dsi->dev;
> +	ssize_t ret;
> +
> +	ret =3D mipi_dsi_generic_write(dsi, payload, size);
> +	if (ret < 0) {
> +		dev_err(dev, "sending generic data %*ph failed: %zd\n",
> +			(int)size, payload, ret);

=2E.. but it doesn't.

Maxime

--fdnrbzflhblyceom
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZkHdlQAKCRAnX84Zoj2+
diZ2AX0ajvUjOrMjYhcEJ0oy4LnmXzL5YVKvIJSrsnbZiFstJ7Iu/29/qZDI+bj4
2hLYzgwBf0LBOJ9ls41o8vJ+Ao1IEB+FzXCnQih+aw0fAA7GW1cexEJXpPuBunqS
QQ2tpJtGdA==
=rJ0G
-----END PGP SIGNATURE-----

--fdnrbzflhblyceom--

