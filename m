Return-Path: <linux-kernel+bounces-555619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 901B4A5BA55
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 09:00:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2270D3AAC70
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 07:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A87C5223710;
	Tue, 11 Mar 2025 07:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ocB6+Ne3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25A4222572;
	Tue, 11 Mar 2025 07:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741679988; cv=none; b=I6Cm/CeptN2KiWFXiAxVXkLS7E4awVP0500A3/3zNJ406Jh1Iz4HW/eCpnUpowzvTnRCrpBi31JU5mVOFrtKbus0J2FzqiNvNRokajWimad7DyZUGuSGBQ4ffdtF3T58TEnF9y35dFi8s1p3vTQbtdqYRB+Dbgq+ClxHaOj4gak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741679988; c=relaxed/simple;
	bh=AH+p4JW6F+z5XeodYcVKSYSZhEHmVRaoVWCiPMOXiw8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Py8uUGnCyCzqucssRuxz5VApT8DLRg1HjRBBzYh/Dl1fjKrY6DkJWLtRM0Oh/ULgAH/83JmUlCRx6Gdlj/mcztQvIJMJCff34hNTL+94LIrRGqfH9FYI1rXFUEmzJuQxpfwT+4lHXcqfDQVBEZOqjhBXQ25VkhU8bICL7gSrUhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ocB6+Ne3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF0A4C4CEEA;
	Tue, 11 Mar 2025 07:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741679988;
	bh=AH+p4JW6F+z5XeodYcVKSYSZhEHmVRaoVWCiPMOXiw8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ocB6+Ne3bwI510+KrvoPiNBTOEbeV0xxCJArmYfvnNV1F6GJhHmBiF6nYY6cgD21T
	 qqDTrEyvlCKO7yoZSa2d5/G5l03sfbtQ0iMEcERXH3CNb9mnOPX5WWOVtBLmp7Jxtt
	 7Ic+MaOEpw6OI0YEQwB5fi+iVZYVMepCgDhwcU8vyEA3i27Ij2HFPhiGcD1dBSgHNH
	 5ANOcmSeLc0pW0RXlrf0hg/eXrATFVwYbE86AJGyYbEEelFJzKzT5bvPemZ9b4zC8k
	 7bJGUqDdgY8HSvfOXMDm+C3+iP8GAZrTmltrg3SJMEF7s+q3aEh+H7r7fabXSSkiCd
	 rrVTExHAzKPOQ==
Date: Tue, 11 Mar 2025 08:59:45 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Dmitry Baryshkov <lumag@kernel.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Rob Clark <robdclark@gmail.com>, 
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
Message-ID: <20250311-bouncy-hissing-chupacabra-0dff3f@houat>
References: <20250309-drm-hdmi-acr-v1-0-bb9c242f4d4b@linaro.org>
 <20250309-drm-hdmi-acr-v1-1-bb9c242f4d4b@linaro.org>
 <20250310-funny-malamute-of-promotion-bb759e@houat>
 <bensvtxc67i566qqcjketdlffyrwxcnydwarqyjau6b7ibcq4b@d6d4sbm3rubf>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="sgxudawjzyo43qu5"
Content-Disposition: inline
In-Reply-To: <bensvtxc67i566qqcjketdlffyrwxcnydwarqyjau6b7ibcq4b@d6d4sbm3rubf>


--sgxudawjzyo43qu5
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 1/4] drm/display: hdmi: provide central data authority
 for ACR params
MIME-Version: 1.0

On Mon, Mar 10, 2025 at 10:14:52PM +0200, Dmitry Baryshkov wrote:
> On Mon, Mar 10, 2025 at 03:46:33PM +0100, Maxime Ripard wrote:
> > On Sun, Mar 09, 2025 at 10:13:56AM +0200, Dmitry Baryshkov wrote:
> > > From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > >=20
> > > HDMI standard defines recommended N and CTS values for Audio Clock
> > > Regeneration. Currently each driver implements those, frequently in
> > > somewhat unique way. Provide a generic helper for getting those values
> > > to be used by the HDMI drivers.
> > >=20
> > > The helper is added to drm_hdmi_helper.c rather than drm_hdmi_audio.c
> > > since HDMI drivers can be using this helper function even without
> > > switching to DRM HDMI Audio helpers.
> > >=20
> > > Note: currently this only handles the values per HDMI 1.4b Section 7.2
> > > and HDMI 2.0 Section 9.2.1. Later the table can be expanded to
> > > accommodate for Deep Color TMDS char rates per HDMI 1.4 Appendix D
> > > and/or HDMI 2.0 / 2.1 Appendix C).
> > >=20
> > > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > > ---
> > >  drivers/gpu/drm/display/drm_hdmi_helper.c | 164 ++++++++++++++++++++=
++++++++++
> > >  include/drm/display/drm_hdmi_helper.h     |   6 ++
> > >  2 files changed, 170 insertions(+)
> > >=20
> > > diff --git a/drivers/gpu/drm/display/drm_hdmi_helper.c b/drivers/gpu/=
drm/display/drm_hdmi_helper.c
> > > index 74dd4d01dd9bb2c9e69ec1c60b0056bd69417e8a..89d25571bfd21c56c6835=
821d2272a12c816a76e 100644
> > > --- a/drivers/gpu/drm/display/drm_hdmi_helper.c
> > > +++ b/drivers/gpu/drm/display/drm_hdmi_helper.c
> > > @@ -256,3 +256,167 @@ drm_hdmi_compute_mode_clock(const struct drm_di=
splay_mode *mode,
> > >  	return DIV_ROUND_CLOSEST_ULL(clock * bpc, 8);
> > >  }
> > >  EXPORT_SYMBOL(drm_hdmi_compute_mode_clock);
> > > +
> > > +struct drm_hdmi_acr_n_cts_entry {
> > > +	unsigned int n;
> > > +	unsigned int cts;
> > > +};
> > > +
> > > +struct drm_hdmi_acr_data {
> > > +	unsigned long tmds_clock_khz;
> > > +	struct drm_hdmi_acr_n_cts_entry n_cts_32k,
> > > +					n_cts_44k1,
> > > +					n_cts_48k;
> > > +};
> > > +
> > > +static const struct drm_hdmi_acr_data hdmi_acr_n_cts[] =3D {
> > > +	{
> > > +		/* "Other" entry */
> > > +		.n_cts_32k =3D  { .n =3D 4096, },
> > > +		.n_cts_44k1 =3D { .n =3D 6272, },
> > > +		.n_cts_48k =3D  { .n =3D 6144, },
> > > +	}, {
> > > +		.tmds_clock_khz =3D 25175,
> > > +		.n_cts_32k =3D  { .n =3D 4576,  .cts =3D 28125, },
> > > +		.n_cts_44k1 =3D { .n =3D 7007,  .cts =3D 31250, },
> > > +		.n_cts_48k =3D  { .n =3D 6864,  .cts =3D 28125, },
> > > +	}, {
> > > +		.tmds_clock_khz =3D 25200,
> > > +		.n_cts_32k =3D  { .n =3D 4096,  .cts =3D 25200, },
> > > +		.n_cts_44k1 =3D { .n =3D 6272,  .cts =3D 28000, },
> > > +		.n_cts_48k =3D  { .n =3D 6144,  .cts =3D 25200, },
> > > +	}, {
> > > +		.tmds_clock_khz =3D 27000,
> > > +		.n_cts_32k =3D  { .n =3D 4096,  .cts =3D 27000, },
> > > +		.n_cts_44k1 =3D { .n =3D 6272,  .cts =3D 30000, },
> > > +		.n_cts_48k =3D  { .n =3D 6144,  .cts =3D 27000, },
> > > +	}, {
> > > +		.tmds_clock_khz =3D 27027,
> > > +		.n_cts_32k =3D  { .n =3D 4096,  .cts =3D 27027, },
> > > +		.n_cts_44k1 =3D { .n =3D 6272,  .cts =3D 30030, },
> > > +		.n_cts_48k =3D  { .n =3D 6144,  .cts =3D 27027, },
> > > +	}, {
> > > +		.tmds_clock_khz =3D 54000,
> > > +		.n_cts_32k =3D  { .n =3D 4096,  .cts =3D 54000, },
> > > +		.n_cts_44k1 =3D { .n =3D 6272,  .cts =3D 60000, },
> > > +		.n_cts_48k =3D  { .n =3D 6144,  .cts =3D 54000, },
> > > +	}, {
> > > +		.tmds_clock_khz =3D 54054,
> > > +		.n_cts_32k =3D  { .n =3D 4096,  .cts =3D 54054, },
> > > +		.n_cts_44k1 =3D { .n =3D 6272,  .cts =3D 60060, },
> > > +		.n_cts_48k =3D  { .n =3D 6144,  .cts =3D 54054, },
> > > +	}, {
> > > +		.tmds_clock_khz =3D 74176,
> > > +		.n_cts_32k =3D  { .n =3D 11648, .cts =3D 210937, }, /* and 210938 =
*/
> > > +		.n_cts_44k1 =3D { .n =3D 17836, .cts =3D 234375, },
> > > +		.n_cts_48k =3D  { .n =3D 11648, .cts =3D 140625, },
> > > +	}, {
> > > +		.tmds_clock_khz =3D 74250,
> > > +		.n_cts_32k =3D  { .n =3D 4096,  .cts =3D 74250, },
> > > +		.n_cts_44k1 =3D { .n =3D 6272,  .cts =3D 82500, },
> > > +		.n_cts_48k =3D  { .n =3D 6144,  .cts =3D 74250, },
> > > +	}, {
> > > +		.tmds_clock_khz =3D 148352,
> > > +		.n_cts_32k =3D  { .n =3D 11648, .cts =3D 421875, },
> > > +		.n_cts_44k1 =3D { .n =3D 8918,  .cts =3D 234375, },
> > > +		.n_cts_48k =3D  { .n =3D 5824,  .cts =3D 140625, },
> > > +	}, {
> > > +		.tmds_clock_khz =3D 148500,
> > > +		.n_cts_32k =3D  { .n =3D 4096,  .cts =3D 148500, },
> > > +		.n_cts_44k1 =3D { .n =3D 6272,  .cts =3D 165000, },
> > > +		.n_cts_48k =3D  { .n =3D 6144,  .cts =3D 148500, },
> > > +	}, {
> > > +		.tmds_clock_khz =3D 296703,
> > > +		.n_cts_32k =3D  { .n =3D 5824,  .cts =3D 421875, },
> > > +		.n_cts_44k1 =3D { .n =3D 4459,  .cts =3D 234375, },
> > > +		.n_cts_48k =3D  { .n =3D 5824,  .cts =3D 281250, },
> > > +	}, {
> > > +		.tmds_clock_khz =3D 297000,
> > > +		.n_cts_32k =3D  { .n =3D 3072,  .cts =3D 222750, },
> > > +		.n_cts_44k1 =3D { .n =3D 4704,  .cts =3D 247500, },
> > > +		.n_cts_48k =3D  { .n =3D 5120,  .cts =3D 247500, },
> > > +	}, {
> > > +		.tmds_clock_khz =3D 593407,
> > > +		.n_cts_32k =3D  { .n =3D 5824,  .cts =3D 843750, },
> > > +		.n_cts_44k1 =3D { .n =3D 8918,  .cts =3D 937500, },
> > > +		.n_cts_48k =3D  { .n =3D 5824,  .cts =3D 562500, },
> > > +	}, {
> > > +		.tmds_clock_khz =3D 594000,
> > > +		.n_cts_32k =3D  { .n =3D 3072,  .cts =3D 445500, },
> > > +		.n_cts_44k1 =3D { .n =3D 9408,  .cts =3D 990000, },
> > > +		.n_cts_48k =3D  { .n =3D 6144,  .cts =3D 594000, },
> > > +	},
> > > +};
> > > +
> > > +static int drm_hdmi_acr_find_tmds_entry(unsigned long tmds_clock_khz)
> > > +{
> > > +	int i;
> > > +
> > > +	/* skip the "other" entry */
> > > +	for (i =3D 1; i < ARRAY_SIZE(hdmi_acr_n_cts); i++) {
> > > +		if (hdmi_acr_n_cts[i].tmds_clock_khz =3D=3D tmds_clock_khz)
> > > +			return i;
> > > +	}
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +/**
> > > + * drm_hdmi_acr_get_n_cts() - get N and CTS values for Audio Clock R=
egeneration
> > > + *
> > > + * @tmds_char_rate: TMDS clock (char rate) as used by the HDMI conne=
ctor
> > > + * @sample_rate: audio sample rate
> > > + * @out_n: a pointer to write the N value
> > > + * @out_cts: a pointer to write the CTS value
> > > + *
> > > + * Get the N and CTS values (either by calculating them or by return=
ing data
> > > + * from the tables. This follows the HDMI 1.4b Section 7.2 "Audio Sa=
mple Clock
> > > + * Capture and Regeneration".
> > > + */
> >=20
> > I think we need to make it clear that it's for L-PCM only (I think?),
> > either through a format parameter or through the documentation.
>=20
> Ack
>=20
> >=20
> > > +void
> > > +drm_hdmi_acr_get_n_cts(unsigned long long tmds_char_rate,
> > > +		       unsigned int sample_rate,
> > > +		       unsigned int *out_n,
> > > +		       unsigned int *out_cts)
> >=20
> > And we should probably take the connector (or EDID) to make sure the
> > monitor can support the format and sample rates.
>=20
> Interesting perspective, I'll give it a thought. I was really just
> trying to get rid of the duplication.
>=20
> I think that 'supported' parts should be implemented in the hdmi-codec
> instead, parsing the ELD and updating hw constraints. WDYT?

Basically, I want to make sure we cover section 7.3 of HDMI 1.4, ie,
make sure we can't end up (or validate) in a situation that isn't
allowed by the spec.

If ALSA covers it already, then I guess it's fine, but we should
document it and point to where it's dealt with.

Maxime

--sgxudawjzyo43qu5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZ8/tcAAKCRDj7w1vZxhR
xYK1AP9/SASOIb6xDFXNFnI8SsF1/5V5/KTrCBMAV3hTDBsXZgD9FAEbhD7QHdf7
Gow15VWygI2kgzc5wBGMNwZiESQlKgM=
=xbRV
-----END PGP SIGNATURE-----

--sgxudawjzyo43qu5--

