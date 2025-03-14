Return-Path: <linux-kernel+bounces-561962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05D8BA61951
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 19:22:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7FAEC7A60C9
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 18:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4655E2046A3;
	Fri, 14 Mar 2025 18:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gFqvFwcg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D43814A0A3
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 18:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741976567; cv=none; b=mcz35+M9vfTjhGIKrPX6r4UTXsJI9sVOQXQ+jNv1vFxk8uRREjBKlKFrfZNa1P3TRZZS4Lwakfj6dFk7WmayeOz26u5PZfYzLbIuwGHk3NBPN41gL6gfAfq80O20HY3SLjX3f9JmfHaLfW4PR0EewalNEFw/lMKtTLXLUK5iRDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741976567; c=relaxed/simple;
	bh=UtmdOLuPmZWk0pxxXQtUH6qJ+z+EdEd7MNO5TksaWgs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e2N5Q4wiyVOiMu+rGc4nDmSSEQNucwW1jNOACsJC0DaCq7sSo2PqZjtpJEr5Z2e5wYgxjvfv7gCcSiq85uC/ztQ2ITMdWTOq0XBXt6cAnEHlR95bvMjp9UHGHM1EbZ12Aam1S2MAMEUE4PUWR8RKlxCItbJVwhcYwWldhH1xQ7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gFqvFwcg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26A17C4CEE3;
	Fri, 14 Mar 2025 18:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741976567;
	bh=UtmdOLuPmZWk0pxxXQtUH6qJ+z+EdEd7MNO5TksaWgs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gFqvFwcgsb7YEv7074Lwx8jIiruRiFJp/HNrKOJhBsiwLvQNd4gWBiOGUpLJh0aHz
	 zVTYfZMGsJqB+l10ze1hatDxXNh57tLz54o44yZDPUHulJMYTrRJpKsCbeCXX7qZyZ
	 C560N5Q1vDJHGeyvvI9vPFjq2vFtZ7R11rF9LGEG2LYwHbFab0+lt3uP5QN1lby5Nv
	 XAVxI+f1ozbXxv7VxP8jyXENLVHoDVCNTR6enqH0vyk6oqeyKX5T+z1/ndlNv/2lWM
	 GdRVotlR5q6Gy6kaGI5ah6RUeUpsbSEYB34JMxnXtn2rQ/NapD18CLZIYJu4TgTW33
	 OnkIQUEbWMNbw==
Date: Fri, 14 Mar 2025 19:22:45 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Anusha Srivatsa <asrivats@redhat.com>
Cc: Michael Trimarchi <michael@amarulasolutions.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	Tejas Vipin <tejasvipin76@gmail.com>, Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH] drm/panel/synaptics-r63353: Use _multi variants
Message-ID: <20250314-brass-cobra-of-fury-f7fc26@houat>
References: <20250314-b4-mipi-synaptic-v1-1-a64ccb5e5c66@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="yyo7tfsjippm3nta"
Content-Disposition: inline
In-Reply-To: <20250314-b4-mipi-synaptic-v1-1-a64ccb5e5c66@redhat.com>


--yyo7tfsjippm3nta
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] drm/panel/synaptics-r63353: Use _multi variants
MIME-Version: 1.0

Hi

On Fri, Mar 14, 2025 at 12:47:16AM -0400, Anusha Srivatsa wrote:
> Move away from using deprecated API and use _multi
> variants if available. Use mipi_dsi_msleep()
> and mipi_dsi_usleep_range() instead of msleep()
> and usleep_range() respectively.
>=20
> Used Coccinelle to find the _multi variant APIs,
> replacing mpi_dsi_msleep() where necessary and for returning
> dsi_ctx.accum_err in these functions. Manually handled the
> reset step before returning from r63353_panel_activate()
>=20
> v2: Do not skip the reset in case of error during
> panel activate (Dmitry)
> - Convert all usleep_range()
>=20
> v3: mipi_dsi_usleep_range() is to be used only when in
> between _multi commands(Doug)
> - Check for error once in the end while using _multi
> variants (Doug)
>=20
> @rule_1@
> identifier dsi_var;
> identifier r;
> identifier func;
> type t;
> position p;
> expression dsi_device;
> expression list es;
> @@
> t func(...) {
> ...
> struct mipi_dsi_device *dsi_var =3D dsi_device;
> +struct mipi_dsi_multi_context dsi_ctx =3D { .dsi =3D dsi_var };
> <+...
> (
> -r =3D mipi_dsi_dcs_nop(dsi_var)@p;
> +mipi_dsi_dcs_nop_multi(&dsi_ctx);
> |
> -r =3D mipi_dsi_dcs_exit_sleep_mode(dsi_var)@p;
> +mipi_dsi_dcs_exit_sleep_mode_multi(&dsi_ctx);
> |
> -r =3D mipi_dsi_dcs_enter_sleep_mode(dsi_var)@p;
> +mipi_dsi_dcs_enter_sleep_mode_multi(&dsi_ctx);
> |
> -r =3D mipi_dsi_dcs_write_buffer(dsi_var,es)@p;
> +mipi_dsi_dcs_write_buffer_multi(&dsi_ctx,es);
> |
> -r =3D mipi_dsi_dcs_set_display_off(dsi_var,es)@p;
> +mipi_dsi_dcs_set_display_off_multi(&dsi_ctx,es);
> |
> -r =3D mipi_dsi_compression_mode_ext(dsi_var,es)@p;
> +mipi_dsi_compression_mode_ext_multi(&dsi_ctx,es);
> |
> -r =3D mipi_dsi_compression_mode(dsi_var,es)@p;
> +mipi_dsi_compression_mode_multi(&dsi_ctx,es);
> |
> -r =3D mipi_dsi_picture_parameter_set(dsi_var,es)@p;
> +mipi_dsi_picture_parameter_set_multi(&dsi_ctx,es);
> |
> -r =3D mipi_dsi_dcs_set_display_on(dsi_var,es)@p;
> +mipi_dsi_dcs_set_display_on_multi(&dsi_ctx,es);
> |
> -r =3D mipi_dsi_dcs_set_tear_on(dsi_var)@p;
> +mipi_dsi_dcs_set_tear_on_multi(&dsi_ctx);
> |
> -r =3D mipi_dsi_turn_on_peripheral(dsi_var)@p;
> +mipi_dsi_turn_on_peripheral_multi(&dsi_ctx);
> |
> -r =3D mipi_dsi_dcs_soft_reset(dsi_var)@p;
> +mipi_dsi_dcs_soft_reset_multi(&dsi_ctx);
> |
> -r =3D mipi_dsi_dcs_set_display_brightness(dsi_var,es)@p;
> +mipi_dsi_dcs_set_display_brightness_multi(&dsi_ctx,es);
> |
> -r =3D mipi_dsi_dcs_set_pixel_format(dsi_var,es)@p;
> +mipi_dsi_dcs_set_pixel_format_multi(&dsi_ctx,es);
> |
> -r =3D mipi_dsi_dcs_set_column_address(dsi_var,es)@p;
> +mipi_dsi_dcs_set_column_address_multi(&dsi_ctx,es);
> |
> -r =3D mipi_dsi_dcs_set_page_address(dsi_var,es)@p;
> +mipi_dsi_dcs_set_page_address_multi(&dsi_ctx,es);
> |
> -r =3D mipi_dsi_dcs_set_tear_scanline(dsi_var,es)@p;
> +mipi_dsi_dcs_set_tear_scanline_multi(&dsi_ctx,es);
> )
> -if(r < 0) {
> -...
> -}
> ...+>
> }
>=20
> @rule_2@
> identifier dsi_var;
> identifier r;
> identifier func;
> type t;
> position p;
> expression dsi_device;
> expression list es;
> @@
> t func(...) {
> ...
> struct mipi_dsi_multi_context dsi_ctx =3D { .dsi =3D dsi_var };
> <+...
> (
> -r =3D msleep(es)@p;
> +r =3D mipi_dsi_msleep(&dsi_ctx,es);
> |
> -msleep(es)@p;
> +mipi_dsi_msleep(&dsi_ctx,es);
> |
> -r =3D usleep_range(es)@p;
> +r =3D mipi_dsi_usleep_range(&dsi_ctx,es);
> |
> -usleep_range(es)@p;
> +mipi_dsi_usleep_range(&dsi_ctx,es);
> )
> ...+>
> }
>=20
> @rule_3@
> identifier dsi_var;
> identifier func;
> type t;
> position p;
> expression list es;
> @@
> t func(...) {
> ...
> struct mipi_dsi_multi_context dsi_ctx =3D { .dsi =3D dsi_var };
> ...
> -return 0;
> +return dsi_ctx.accum_err;
> }
>=20
> Cc: Maxime Ripard <mripard@kernel.org>
> Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Cc: Tejas Vipin <tejasvipin76@gmail.com>
> Cc: Doug Anderson <dianders@chromium.org>
> Signed-off-by: Anusha Srivatsa <asrivats@redhat.com>

It's looking good, but you forgot to set the version. If you're not
using it already, b4 simplifies that a lot for you, you should be using
it.

Maxime

--yyo7tfsjippm3nta
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZ9Rz9AAKCRAnX84Zoj2+
djb2AX91WL9f2ASG8dZPibCG2xbEW4kv4gpqAKAYRB/GphGgvRw/TSCUnDwTRhBx
ybR0+AEBf1eRPS6Yt2CwPUu9z34ng2XYqdo3TLkD2OkW+6v5m+dJbL2DjE4efwoF
0TRp/cNdyg==
=tkvk
-----END PGP SIGNATURE-----

--yyo7tfsjippm3nta--

