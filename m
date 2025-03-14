Return-Path: <linux-kernel+bounces-561519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 698A3A612FC
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 14:48:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD0A546362A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 13:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C6251FF7B5;
	Fri, 14 Mar 2025 13:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CJfW3Gme"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FDC412FF6F
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 13:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741960076; cv=none; b=faSCEQhgWfGDJhRTTqZUmB/9xJipunfeFl6wvEDD7bas1UnFlXwSDmhSA9j7z4yEYwMmd5P8i/5nSncTscQM/lCXxXC52L3dMUTydlejOZdWot+MxiYUFjooycNLYHk0SSba2keTRqJXeSC0RpP+1a6Yg6nVoI32zJGK00fU5iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741960076; c=relaxed/simple;
	bh=Iplf0rc4WP8tVInazpAqt6fsMArNe+JUl/q0eXEstFg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u8oGskVS7AE3NFiCGGB5C8p/ahiS+miZKVmk8bnNrpQFHIkvjWOjOBnDlrjHAJ/9rhm8+S+FnOciI6k/8+hvJuffdaOyxuy3+eNOz6iEmh7ssQ43tih6gbjI0jVkMddYjdygkhsnympnGQ0j6Hv3a3cZ2TZQXGg8I4VeB1uPulU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CJfW3Gme; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07CC5C4CEE3;
	Fri, 14 Mar 2025 13:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741960076;
	bh=Iplf0rc4WP8tVInazpAqt6fsMArNe+JUl/q0eXEstFg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CJfW3Gmez/TlxTfCxDrypT1DCSrRCdOQLmkKtB5L3UPcCA+3eoelslGxA+nDn2qEz
	 iwUerXDao77z5BQjr4IUT169cBbh05WbohS32j9DItacpzfgQAYFpEcxMaPGZPqDIz
	 D95iravls+Y0Ge6i12D27Adr5XSkTvfnToi3dX5vVUiF5NYUrXdEEbnY+ke+ykHAsM
	 rJR+/Sdt9BEVJP6D2jrdmoPR9tFt48NyAW6AJr0f/uTvQGMH/5vPZl2OTEmmZTw1PC
	 MQNkuYuOYSmGPnF/fh5gNBxXnhlQvOmFCm+Chpjnt9FmRIkWmbKjFLOQGftG6+t3QA
	 dbF3wpetXwFgQ==
Date: Fri, 14 Mar 2025 14:47:53 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Dmitry Baryshkov <lumag@kernel.org>
Cc: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Dave Stevenson <dave.stevenson@raspberrypi.com>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	kernel@collabora.com, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/7] drm/connector: hdmi: Use YUV420 output format as
 an RGB fallback
Message-ID: <20250314-airborne-magenta-corgi-afd52c@houat>
References: <20250311-hdmi-conn-yuv-v2-0-fbdb94f02562@collabora.com>
 <20250311-hdmi-conn-yuv-v2-4-fbdb94f02562@collabora.com>
 <20250311-hypersonic-mature-leopard-d3afdc@houat>
 <g25hgb2mocl4sjny26k4nzn2hwpwhlodenqganzcqfzzg6itms@herenniualnw>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="js5xpba5a2kvuwvy"
Content-Disposition: inline
In-Reply-To: <g25hgb2mocl4sjny26k4nzn2hwpwhlodenqganzcqfzzg6itms@herenniualnw>


--js5xpba5a2kvuwvy
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 4/7] drm/connector: hdmi: Use YUV420 output format as
 an RGB fallback
MIME-Version: 1.0

On Tue, Mar 11, 2025 at 09:46:39PM +0200, Dmitry Baryshkov wrote:
> On Tue, Mar 11, 2025 at 04:55:17PM +0100, Maxime Ripard wrote:
> > Hi,
> >=20
> > I think the first thing we need to address is that we will need to
> > differentiate between HDMI 1.4 devices and HDMI 2.0.
> >=20
> > It applies to YUV420, which is HDMI 2.0-only, and I guess your patches
> > are good enough if you consider YUV420 support only, but scrambler setup
> > for example is a thing we want to support in that infrastructure
> > eventually, and is conditioned on HDMI 2.0 as well.
> >=20
> > On Tue, Mar 11, 2025 at 12:57:36PM +0200, Cristian Ciocaltea wrote:
> > > Try to make use of YUV420 when computing the best output format and
> > > RGB cannot be supported for any of the available color depths.
> > >=20
> > > Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> > > ---
> > >  drivers/gpu/drm/display/drm_hdmi_state_helper.c | 69 +++++++++++++--=
----------
> > >  1 file changed, 35 insertions(+), 34 deletions(-)
> > >=20
>=20
> [...]
>=20
> > >  	return -EINVAL;
> > >  }
> > > =20
> > > +static int
> > > +hdmi_compute_config(const struct drm_connector *connector,
> > > +		    struct drm_connector_state *conn_state,
> > > +		    const struct drm_display_mode *mode)
> > > +{
> > > +	unsigned int max_bpc =3D clamp_t(unsigned int,
> > > +				       conn_state->max_bpc,
> > > +				       8, connector->max_bpc);
> > > +	int ret;
> > > +
> > > +	ret =3D hdmi_try_format(connector, conn_state, mode, max_bpc,
> > > +			      HDMI_COLORSPACE_RGB);
> > > +	if (!ret)
> > > +		return 0;
> > > +
> > > +	if (connector->ycbcr_420_allowed)
> > > +		ret =3D hdmi_try_format(connector, conn_state, mode, max_bpc,
> > > +				      HDMI_COLORSPACE_YUV420);
> >=20
> > I think that's conditioned on a few more things:
> >   - That the driver supports HDMI 2.0
>=20
> Isn't that included into connector->ycbcr_420_allowed? I'd expect that
> HDMI 1.4-only drivers don't set that flag.

Yeah, I guess that's one way to do it, but we don't have any way to
express it at the moment

Maxime

--js5xpba5a2kvuwvy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZ9QziQAKCRAnX84Zoj2+
dsDJAX44hfiYxa3/CLfwf3gbHbyOce6ss/IJSLR3qokZjM7FFv+z4UC8vvcNDmC6
39Y9thkBf0Cr3jegqHhUz1MQcYVtshuo858Bvk3LgNN0AV4jDyqq63UqD0Dx2nEZ
UKoAruDLaQ==
=O4VN
-----END PGP SIGNATURE-----

--js5xpba5a2kvuwvy--

