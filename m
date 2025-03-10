Return-Path: <linux-kernel+bounces-554463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FBF4A59809
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 15:46:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97BFE1887B7A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 14:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A79222069A;
	Mon, 10 Mar 2025 14:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nFeKqGMY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B69E079C4;
	Mon, 10 Mar 2025 14:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741617996; cv=none; b=NYtftlEjtMSUk36qfWqAoeYv4TzypRjlgTkNpsbslAdfPhy5tkPoFpvzW1Cqqtdp5KwloTLA1WNoj/yWrifEklDP6Yji4WUS9B5/Z9R0YxLyXXh/zEES0p7jJ8ZJHLAOx2DOxS+Wtq8btifsAc5Z3J5/1XW8ShYBwA5bYmbrXGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741617996; c=relaxed/simple;
	bh=GLQSltiOgMxAYAZXcLvBH55+/pHocreYQyR1jF4z2Vw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qpB7P6erC/UJE+JfBz/MImNuP2si1H+zOP4iyogYfE2N7wyqW5rikX3h5TY7ObE/IW8ziSpzs3eKk1tCr2LCsn5sjYCW+az54nHqp7lr0EA/rA6EDBZsIwXrun2selmoRyP3GAz6qOplfIuqGQazo8wnHOoXS59iJhSW9Ae/wZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nFeKqGMY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 962F9C4CEE5;
	Mon, 10 Mar 2025 14:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741617996;
	bh=GLQSltiOgMxAYAZXcLvBH55+/pHocreYQyR1jF4z2Vw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nFeKqGMYfaurXgDalKxg+AYAGtSqAHU3aEaxasDv6hEEMGAAByM0ZEqzLvjIdCKRT
	 FztKL0+ONe+sf0GfKVY8um0eL2fzvFk5S7Row4oyRvpYIYOkWNE8FuiWRRswvyd3uv
	 5Wmm6G4MmYPrSdkYLQrPMKvhbD4IDGuQwt0nsNm/WzZys+VtcRcJpBUwz7motpZMDC
	 IKezOJ1nBhW6Pml89+UVl8x0x4pP12T9VIhgg1bXe3S0mIkKKr7TdSHt0wjV8E00FJ
	 aWKOjUI1IGjJvt8/OLW2G3PN8ONYsF+nSIWbtTtoF6ypHr2oWiVjdkxKk6es1oOYgW
	 SsevxLLYAYRLw==
Date: Mon, 10 Mar 2025 15:46:33 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Dmitry Baryshkov <lumag@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Rob Clark <robdclark@gmail.com>, 
	Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, Dave Stevenson <dave.stevenson@raspberrypi.com>, 
	=?utf-8?B?TWHDrXJh?= Canal <mcanal@igalia.com>, Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
	Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Robert Foss <rfoss@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	freedreno@lists.freedesktop.org
Subject: Re: [PATCH 1/4] drm/display: hdmi: provide central data authority
 for ACR params
Message-ID: <20250310-funny-malamute-of-promotion-bb759e@houat>
References: <20250309-drm-hdmi-acr-v1-0-bb9c242f4d4b@linaro.org>
 <20250309-drm-hdmi-acr-v1-1-bb9c242f4d4b@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fzlgoro4mekg644q"
Content-Disposition: inline
In-Reply-To: <20250309-drm-hdmi-acr-v1-1-bb9c242f4d4b@linaro.org>


--fzlgoro4mekg644q
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 1/4] drm/display: hdmi: provide central data authority
 for ACR params
MIME-Version: 1.0

On Sun, Mar 09, 2025 at 10:13:56AM +0200, Dmitry Baryshkov wrote:
> From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>=20
> HDMI standard defines recommended N and CTS values for Audio Clock
> Regeneration. Currently each driver implements those, frequently in
> somewhat unique way. Provide a generic helper for getting those values
> to be used by the HDMI drivers.
>=20
> The helper is added to drm_hdmi_helper.c rather than drm_hdmi_audio.c
> since HDMI drivers can be using this helper function even without
> switching to DRM HDMI Audio helpers.
>=20
> Note: currently this only handles the values per HDMI 1.4b Section 7.2
> and HDMI 2.0 Section 9.2.1. Later the table can be expanded to
> accommodate for Deep Color TMDS char rates per HDMI 1.4 Appendix D
> and/or HDMI 2.0 / 2.1 Appendix C).
>=20
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  drivers/gpu/drm/display/drm_hdmi_helper.c | 164 ++++++++++++++++++++++++=
++++++
>  include/drm/display/drm_hdmi_helper.h     |   6 ++
>  2 files changed, 170 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/display/drm_hdmi_helper.c b/drivers/gpu/drm/=
display/drm_hdmi_helper.c
> index 74dd4d01dd9bb2c9e69ec1c60b0056bd69417e8a..89d25571bfd21c56c6835821d=
2272a12c816a76e 100644
> --- a/drivers/gpu/drm/display/drm_hdmi_helper.c
> +++ b/drivers/gpu/drm/display/drm_hdmi_helper.c
> @@ -256,3 +256,167 @@ drm_hdmi_compute_mode_clock(const struct drm_displa=
y_mode *mode,
>  	return DIV_ROUND_CLOSEST_ULL(clock * bpc, 8);
>  }
>  EXPORT_SYMBOL(drm_hdmi_compute_mode_clock);
> +
> +struct drm_hdmi_acr_n_cts_entry {
> +	unsigned int n;
> +	unsigned int cts;
> +};
> +
> +struct drm_hdmi_acr_data {
> +	unsigned long tmds_clock_khz;
> +	struct drm_hdmi_acr_n_cts_entry n_cts_32k,
> +					n_cts_44k1,
> +					n_cts_48k;
> +};
> +
> +static const struct drm_hdmi_acr_data hdmi_acr_n_cts[] =3D {
> +	{
> +		/* "Other" entry */
> +		.n_cts_32k =3D  { .n =3D 4096, },
> +		.n_cts_44k1 =3D { .n =3D 6272, },
> +		.n_cts_48k =3D  { .n =3D 6144, },
> +	}, {
> +		.tmds_clock_khz =3D 25175,
> +		.n_cts_32k =3D  { .n =3D 4576,  .cts =3D 28125, },
> +		.n_cts_44k1 =3D { .n =3D 7007,  .cts =3D 31250, },
> +		.n_cts_48k =3D  { .n =3D 6864,  .cts =3D 28125, },
> +	}, {
> +		.tmds_clock_khz =3D 25200,
> +		.n_cts_32k =3D  { .n =3D 4096,  .cts =3D 25200, },
> +		.n_cts_44k1 =3D { .n =3D 6272,  .cts =3D 28000, },
> +		.n_cts_48k =3D  { .n =3D 6144,  .cts =3D 25200, },
> +	}, {
> +		.tmds_clock_khz =3D 27000,
> +		.n_cts_32k =3D  { .n =3D 4096,  .cts =3D 27000, },
> +		.n_cts_44k1 =3D { .n =3D 6272,  .cts =3D 30000, },
> +		.n_cts_48k =3D  { .n =3D 6144,  .cts =3D 27000, },
> +	}, {
> +		.tmds_clock_khz =3D 27027,
> +		.n_cts_32k =3D  { .n =3D 4096,  .cts =3D 27027, },
> +		.n_cts_44k1 =3D { .n =3D 6272,  .cts =3D 30030, },
> +		.n_cts_48k =3D  { .n =3D 6144,  .cts =3D 27027, },
> +	}, {
> +		.tmds_clock_khz =3D 54000,
> +		.n_cts_32k =3D  { .n =3D 4096,  .cts =3D 54000, },
> +		.n_cts_44k1 =3D { .n =3D 6272,  .cts =3D 60000, },
> +		.n_cts_48k =3D  { .n =3D 6144,  .cts =3D 54000, },
> +	}, {
> +		.tmds_clock_khz =3D 54054,
> +		.n_cts_32k =3D  { .n =3D 4096,  .cts =3D 54054, },
> +		.n_cts_44k1 =3D { .n =3D 6272,  .cts =3D 60060, },
> +		.n_cts_48k =3D  { .n =3D 6144,  .cts =3D 54054, },
> +	}, {
> +		.tmds_clock_khz =3D 74176,
> +		.n_cts_32k =3D  { .n =3D 11648, .cts =3D 210937, }, /* and 210938 */
> +		.n_cts_44k1 =3D { .n =3D 17836, .cts =3D 234375, },
> +		.n_cts_48k =3D  { .n =3D 11648, .cts =3D 140625, },
> +	}, {
> +		.tmds_clock_khz =3D 74250,
> +		.n_cts_32k =3D  { .n =3D 4096,  .cts =3D 74250, },
> +		.n_cts_44k1 =3D { .n =3D 6272,  .cts =3D 82500, },
> +		.n_cts_48k =3D  { .n =3D 6144,  .cts =3D 74250, },
> +	}, {
> +		.tmds_clock_khz =3D 148352,
> +		.n_cts_32k =3D  { .n =3D 11648, .cts =3D 421875, },
> +		.n_cts_44k1 =3D { .n =3D 8918,  .cts =3D 234375, },
> +		.n_cts_48k =3D  { .n =3D 5824,  .cts =3D 140625, },
> +	}, {
> +		.tmds_clock_khz =3D 148500,
> +		.n_cts_32k =3D  { .n =3D 4096,  .cts =3D 148500, },
> +		.n_cts_44k1 =3D { .n =3D 6272,  .cts =3D 165000, },
> +		.n_cts_48k =3D  { .n =3D 6144,  .cts =3D 148500, },
> +	}, {
> +		.tmds_clock_khz =3D 296703,
> +		.n_cts_32k =3D  { .n =3D 5824,  .cts =3D 421875, },
> +		.n_cts_44k1 =3D { .n =3D 4459,  .cts =3D 234375, },
> +		.n_cts_48k =3D  { .n =3D 5824,  .cts =3D 281250, },
> +	}, {
> +		.tmds_clock_khz =3D 297000,
> +		.n_cts_32k =3D  { .n =3D 3072,  .cts =3D 222750, },
> +		.n_cts_44k1 =3D { .n =3D 4704,  .cts =3D 247500, },
> +		.n_cts_48k =3D  { .n =3D 5120,  .cts =3D 247500, },
> +	}, {
> +		.tmds_clock_khz =3D 593407,
> +		.n_cts_32k =3D  { .n =3D 5824,  .cts =3D 843750, },
> +		.n_cts_44k1 =3D { .n =3D 8918,  .cts =3D 937500, },
> +		.n_cts_48k =3D  { .n =3D 5824,  .cts =3D 562500, },
> +	}, {
> +		.tmds_clock_khz =3D 594000,
> +		.n_cts_32k =3D  { .n =3D 3072,  .cts =3D 445500, },
> +		.n_cts_44k1 =3D { .n =3D 9408,  .cts =3D 990000, },
> +		.n_cts_48k =3D  { .n =3D 6144,  .cts =3D 594000, },
> +	},
> +};
> +
> +static int drm_hdmi_acr_find_tmds_entry(unsigned long tmds_clock_khz)
> +{
> +	int i;
> +
> +	/* skip the "other" entry */
> +	for (i =3D 1; i < ARRAY_SIZE(hdmi_acr_n_cts); i++) {
> +		if (hdmi_acr_n_cts[i].tmds_clock_khz =3D=3D tmds_clock_khz)
> +			return i;
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * drm_hdmi_acr_get_n_cts() - get N and CTS values for Audio Clock Regen=
eration
> + *
> + * @tmds_char_rate: TMDS clock (char rate) as used by the HDMI connector
> + * @sample_rate: audio sample rate
> + * @out_n: a pointer to write the N value
> + * @out_cts: a pointer to write the CTS value
> + *
> + * Get the N and CTS values (either by calculating them or by returning =
data
> + * from the tables. This follows the HDMI 1.4b Section 7.2 "Audio Sample=
 Clock
> + * Capture and Regeneration".
> + */

I think we need to make it clear that it's for L-PCM only (I think?),
either through a format parameter or through the documentation.

> +void
> +drm_hdmi_acr_get_n_cts(unsigned long long tmds_char_rate,
> +		       unsigned int sample_rate,
> +		       unsigned int *out_n,
> +		       unsigned int *out_cts)

And we should probably take the connector (or EDID) to make sure the
monitor can support the format and sample rates.

> +{
> +	/* be a bit more tolerant, especially for the 1.001 entries */
> +	unsigned long tmds_clock_khz =3D DIV_ROUND_CLOSEST_ULL(tmds_char_rate, =
1000);
> +	const struct drm_hdmi_acr_n_cts_entry *entry;
> +	unsigned int n, cts, mult;
> +	int tmds_idx;
> +
> +	tmds_idx =3D drm_hdmi_acr_find_tmds_entry(tmds_clock_khz);
> +
> +	/*
> +	 * Don't change the order, 192 kHz is divisible by 48k and 32k, but it
> +	 * should use 48k entry.
> +	 */
> +	if (sample_rate % 48000 =3D=3D 0) {
> +		entry =3D &hdmi_acr_n_cts[tmds_idx].n_cts_48k;
> +		mult =3D sample_rate / 48000;
> +	} else if (sample_rate % 44100 =3D=3D 0) {
> +		entry =3D &hdmi_acr_n_cts[tmds_idx].n_cts_44k1;
> +		mult =3D sample_rate / 44100;
> +	} else if (sample_rate % 32000 =3D=3D 0) {
> +		entry =3D &hdmi_acr_n_cts[tmds_idx].n_cts_32k;
> +		mult =3D sample_rate / 32000;
> +	} else {
> +		entry =3D NULL;
> +	}
> +
> +	if (entry) {
> +		n =3D entry->n * mult;
> +		cts =3D entry->cts;
> +	} else {
> +		/* Recommended optimal value, HDMI 1.4b, Section 7.2.1 */
> +		n =3D 128 * sample_rate / 1000;
> +		cts =3D 0;
> +	}
> +
> +	if (!cts)
> +		cts =3D DIV_ROUND_CLOSEST_ULL(tmds_char_rate * n,
> +					    128 * sample_rate);
> +
> +	*out_n =3D n;
> +	*out_cts =3D cts;
> +}

EXPORT_SYMBOL?

Also, I'd really like to have some unit tests for this. Not for all the
combinations, obviously, but testing that, say, 44.1kHz with a 148.5 MHz
char rate works as expected, and then all the failure conditions
depending on the monitor capabilities.

Maxime

--fzlgoro4mekg644q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZ877SAAKCRDj7w1vZxhR
xZL/AQCbnrSWHvvcYWV8z2lpIEsk/2tlvNNCVsy3qYsVwLgGfwD/TytjqPeUuusl
NZX6CBh2nab+Vs1DBhdA808Fk/RIiQk=
=omRF
-----END PGP SIGNATURE-----

--fzlgoro4mekg644q--

