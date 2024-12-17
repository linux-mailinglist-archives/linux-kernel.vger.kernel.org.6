Return-Path: <linux-kernel+bounces-449678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B12D29F5434
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 18:38:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F459189213D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 17:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 871E51FA8EE;
	Tue, 17 Dec 2024 17:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wo/XjA1m"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB301FA8E0;
	Tue, 17 Dec 2024 17:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734456655; cv=none; b=qTYVeDnDISEDQK4TMHiT8SAtvXLpe27Ol0cvvqmbxycAbIMIVHycETU+6MVkU+sS87YB7cKeCFiKHWA3BJfJ7YJUruOPMK2YmbaU5ZfkmfpV222+jtSfuIhoSoWkCzADHsGJKPg182E0zaxqXzKgEs4fosSHq38yBDkKCapIz3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734456655; c=relaxed/simple;
	bh=RBSJMFhUNwwLj0YsUUz9OY82tBCJme5IpUfYAxQ+j3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wvpzowpyezv8g0E/QRXTBw0FWaiHgRxWeO8CGCqVkxOK5hYFLTwb/GuaPChyp6DcgCME+XO5uauA21O+t26M0HWmlolssAlv+oSwcTYfln70JJTJO0ghZVByrnYiKGHlLEPlB22mi1jqcb7yVp9UdwCa78tbCZgirf62L8aZhIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wo/XjA1m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DECF3C4CED3;
	Tue, 17 Dec 2024 17:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734456655;
	bh=RBSJMFhUNwwLj0YsUUz9OY82tBCJme5IpUfYAxQ+j3I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Wo/XjA1mFSaYsupbAAUr8bULLRg6N53vo/Rm+ZLZj0IMcY3Vids2lwWA+pRRKsvZ6
	 fJuIGhqzoqFEMEoikkuTFNX+tCxZmkLDd6QR7K1057P0A6QQYZf/cqVUN/I4ig3ezu
	 /zzCuA89neUs26M6Wrmruvc8JTWJJeUtUcM3ta8Hs3zZnrWfhJYtPNwCb5ejebyMTk
	 0fxt7EbxZ3jRdKu5SRpjC98OzXjRF5ouuZMobUMcOFRBBmzW225X65tSSLHMG2uwI0
	 inQVDerFjjbeglVktHJFFiKuZSYDrUWQfPvtmZ/RxmV8UVTMdbyeUraH+7wW4DuUpa
	 D+jIa2Xzm47Xw==
Date: Tue, 17 Dec 2024 18:30:52 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Herve Codina <herve.codina@bootlin.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Marek Vasut <marex@denx.de>, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Louis Chauvet <louis.chauvet@bootlin.com>, Luca Ceresoli <luca.ceresoli@bootlin.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v2 3/3] drm: bridge: ti-sn65dsi83: Add error recovery
 mechanism
Message-ID: <20241217-tangible-nostalgic-salamander-27edaa@houat>
References: <20241217143216.658461-1-herve.codina@bootlin.com>
 <20241217143216.658461-4-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="xewikwxfd6p4z2uo"
Content-Disposition: inline
In-Reply-To: <20241217143216.658461-4-herve.codina@bootlin.com>


--xewikwxfd6p4z2uo
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 3/3] drm: bridge: ti-sn65dsi83: Add error recovery
 mechanism
MIME-Version: 1.0

On Tue, Dec 17, 2024 at 03:32:15PM +0100, Herve Codina wrote:
> In some cases observed during ESD tests, the TI SN65DSI83 cannot recover
> from errors by itself. A full restart of the bridge is needed in those
> cases to have the bridge output LVDS signals again.
>=20
> Also, during tests, cases were observed where reading the status of the
> bridge was not even possible. Indeed, in those cases, the bridge stops
> to acknowledge I2C transactions. Only a full reset of the bridge (power
> off/on) brings back the bridge to a functional state.
>=20
> The TI SN65DSI83 has some error detection capabilities. Introduce an
> error recovery mechanism based on this detection.
>=20
> The errors detected are signaled through an interrupt. On system where
> this interrupt is not available, the driver uses a polling monitoring
> fallback to check for errors. When an error is present or when reading
> the bridge status leads to an I2C failure, the recovery process is
> launched.
>=20
> Restarting the bridge needs to redo the initialization sequence. This
> initialization sequence has to be done with the DSI data lanes driven in
> LP11 state. In order to do that, the recovery process resets the whole
> output path (i.e the path from the encoder to the connector) where the
> bridge is located.
>=20
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> ---
>  drivers/gpu/drm/bridge/ti-sn65dsi83.c | 142 ++++++++++++++++++++++++++
>  1 file changed, 142 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi83.c b/drivers/gpu/drm/brid=
ge/ti-sn65dsi83.c
> index e6264514bb3f..f3d66d17f28c 100644
> --- a/drivers/gpu/drm/bridge/ti-sn65dsi83.c
> +++ b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
> @@ -35,9 +35,12 @@
>  #include <linux/of_graph.h>
>  #include <linux/regmap.h>
>  #include <linux/regulator/consumer.h>
> +#include <linux/timer.h>
> +#include <linux/workqueue.h>
> =20
>  #include <drm/drm_atomic_helper.h>
>  #include <drm/drm_bridge.h>
> +#include <drm/drm_drv.h> /* DRM_MODESET_LOCK_ALL_BEGIN() need drm_drv_us=
es_atomic_modeset() */
>  #include <drm/drm_mipi_dsi.h>
>  #include <drm/drm_of.h>
>  #include <drm/drm_panel.h>
> @@ -147,6 +150,9 @@ struct sn65dsi83 {
>  	struct regulator		*vcc;
>  	bool				lvds_dual_link;
>  	bool				lvds_dual_link_even_odd_swap;
> +	bool				use_irq;
> +	struct delayed_work		monitor_work;
> +	struct work_struct		reset_work;
>  };
> =20
>  static const struct regmap_range sn65dsi83_readable_ranges[] =3D {
> @@ -328,6 +334,106 @@ static u8 sn65dsi83_get_dsi_div(struct sn65dsi83 *c=
tx)
>  	return dsi_div - 1;
>  }
> =20
> +static int sn65dsi83_reset_drm_output(struct sn65dsi83 *sn65dsi83)
> +{
> +	struct drm_atomic_state *state =3D ERR_PTR(-EINVAL);
> +	struct drm_device *dev =3D sn65dsi83->bridge.dev;
> +	struct drm_modeset_acquire_ctx ctx;
> +	struct drm_connector *connector;
> +	int err;
> +
> +	/*
> +	 * Reset components available from the encoder to the connector.
> +	 * To do that, we disable then re-enable the connector linked to the
> +	 * encoder.
> +	 *
> +	 * This way, drm core will reconfigure each components. In our case,
> +	 * this will force the previous component to go back in LP11 mode and
> +	 * so allow the reconfiguration of SN64DSI83 bridge.
> +	 *
> +	 * Keep the lock during the whole operation to be atomic.
> +	 */
> +
> +	DRM_MODESET_LOCK_ALL_BEGIN(dev, ctx, 0, err);
> +
> +	state =3D drm_atomic_helper_duplicate_state(dev, &ctx);
> +	if (IS_ERR(state)) {
> +		err =3D PTR_ERR(state);
> +		goto unlock;
> +	}
> +
> +	connector =3D drm_atomic_get_old_connector_for_encoder(state,
> +							     sn65dsi83->bridge.encoder);
> +	if (!connector) {
> +		err =3D -EINVAL;
> +		goto unlock;
> +	}
> +
> +	err =3D drm_atomic_helper_disable_connector(connector, &ctx);
> +	if (err < 0)
> +		goto unlock;
> +
> +	/* Restore original state to re-enable the connector */
> +	err =3D drm_atomic_helper_commit_duplicated_state(state, &ctx);
> +
> +unlock:
> +	DRM_MODESET_LOCK_ALL_END(dev, ctx, err);
> +	if (!IS_ERR(state))
> +		drm_atomic_state_put(state);
> +	return err;
> +}

In the previous version, we advised to create a generic helper similar
to vc4 and i915 reset_pipe() and and intel_modeset_commit_pipes().

It looks like you chose a different path. Can you expand why?

Maxime

--xewikwxfd6p4z2uo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZ2G1SwAKCRAnX84Zoj2+
djH4AX9tMX7N6ta8NhRqAqOqM7/GAzG8t26WiCFfHiqEFJ4H/qRCwyp5ysuEtp3R
Xs71qTwBf3EkvbAlYzvKRAVSraxZX1CgnFZXcCxA0FefEt/4o1IVEGwsZ/ehmoBp
pnroUS5Mtg==
=WBgd
-----END PGP SIGNATURE-----

--xewikwxfd6p4z2uo--

