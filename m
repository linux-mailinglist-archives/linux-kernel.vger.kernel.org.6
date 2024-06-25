Return-Path: <linux-kernel+bounces-228433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B0BB915FDD
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 09:19:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEA3A1F2307B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 07:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F796146D60;
	Tue, 25 Jun 2024 07:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T5eI8rTw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC22173463
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 07:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719299956; cv=none; b=gGQrTl71w46t5aUtRP3UdVYHPrdkNieGdI9nKTgtpyH/NFjQlKwiZz6iBEh2g9Scx7XvCFjv0ldEPxKvgO4t34F7C12cRd86rCtvnMTnljd3z6gSVL5KLyG105xz994PXdqbBKm7wNzBydzoqDUmG8M+Cg8us5P9k2txtdtCxb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719299956; c=relaxed/simple;
	bh=7Enk3nbHRyO3mcH1zOAvTdvzTBkTu1WEIbhy19CEkLM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pJeK7qzOnThMzSiKT3rbLSe0+rg/jZeeK6RduSe4Z2M+V5134tKLTilj/8DDuHikuyMGVMj9rWOi98lmxh7yxVi5tnVAFtwsePrAraStDFascbMRlR5fQKr/2KC9h6FiexkiLZsPj9KEZJJNkIc4Z0nLQ5t91Yir5NK4X7VCgRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T5eI8rTw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9AD6C32781;
	Tue, 25 Jun 2024 07:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719299956;
	bh=7Enk3nbHRyO3mcH1zOAvTdvzTBkTu1WEIbhy19CEkLM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T5eI8rTws6G5chXR+dlbtaIr8xsuDRAaL8Y9q4k642Te3IPTMYAR4CMzchG4LHEhC
	 k9e1Mgjo62r1ty3AjgKj+/8Y7FE5MkA5Pc4ajw+s3rdFvn8iz+dx8RtS1tHlPPi5JL
	 GjbXql4hX/AczEFMyoI4iTFToOo1jMGEyg3rGz/REtrZ6+xOvKqEIj+ZQ2QcTaSGna
	 Vp+1IhhacPHsvlqNqcBR95TK4aYTbyDxMMmjqMykYL0nirBcedo7shfx3ozGiIqA9Z
	 z8MdwZ4KL7Ieno4koK4B2E0o+eImIhZPpiQOkPbMwqY9i9UnNcDkFqGo9NXxIpc6rM
	 esR/kVAWWbqXA==
Date: Tue, 25 Jun 2024 09:19:12 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Robert Foss <rfoss@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Dave Stevenson <dave.stevenson@raspberrypi.com>, "igt-dev@lists.freedesktop.org" <igt-dev@lists.freedesktop.org>, 
	Petri Latvala <adrinael@adrinael.net>, Kamil Konieczny <kamil.konieczny@linux.intel.com>, 
	Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>, Rob Clark <robdclark@gmail.com>, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] drm/connector: automatically set immutable flag
 for max_bpc property
Message-ID: <20240625-yellow-shrimp-of-genius-17c662@houat>
References: <20240623-drm-bridge-connector-fix-hdmi-reset-v2-0-8590d44912ce@linaro.org>
 <20240623-drm-bridge-connector-fix-hdmi-reset-v2-2-8590d44912ce@linaro.org>
 <99ff549c-f5c4-dc9c-42f3-396dc3d29d6b@quicinc.com>
 <CAA8EJppcH-z275m6xDQaigsxmVhnfJkLVsq68GHLFoAq_p_2GA@mail.gmail.com>
 <30fa4e53-5a03-4030-2be5-f383a1c60077@quicinc.com>
 <CAA8EJpo_dBDqLUVH-SkufhFchu64rhC+vkhVBFdt++E4pdCrQg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rfnpoh6eg6ld7cwc"
Content-Disposition: inline
In-Reply-To: <CAA8EJpo_dBDqLUVH-SkufhFchu64rhC+vkhVBFdt++E4pdCrQg@mail.gmail.com>


--rfnpoh6eg6ld7cwc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jun 25, 2024 at 09:21:27AM GMT, Dmitry Baryshkov wrote:
> On Tue, 25 Jun 2024 at 01:56, Abhinav Kumar <quic_abhinavk@quicinc.com> w=
rote:
> >
> >
> >
> > On 6/24/2024 3:46 PM, Dmitry Baryshkov wrote:
> > > On Tue, 25 Jun 2024 at 01:39, Abhinav Kumar <quic_abhinavk@quicinc.co=
m> wrote:
> > >>
> > >> + IGT dev
> > >>
> > >> On 6/22/2024 10:40 PM, Dmitry Baryshkov wrote:
> > >>> With the introduction of the HDMI Connector framework the driver mi=
ght
> > >>> end up creating the max_bpc property with min =3D max =3D 8. IGT in=
sists
> > >>> that such properties carry the 'immutable' flag. Automatically set =
the
> > >>> flag if the driver asks for the max_bpc property with min =3D=3D ma=
x.
> > >>>
> > >>
> > >> This change does not look right to me.
> > >>
> > >> I wonder why we need this check because DRM_MODE_PROP_IMMUTABLE means
> > >> that as per the doc, userspace cannot change the property.
> > >>
> > >>            * DRM_MODE_PROP_IMMUTABLE
> > >>            *     Set for properties whose values cannot be changed by
> > >>            *     userspace. The kernel is allowed to update the valu=
e of
> > >> these
> > >>            *     properties. This is generally used to expose probe =
state to
> > >>            *     userspace, e.g. the EDID, or the connector path pro=
perty
> > >> on DP
> > >>            *     MST sinks. Kernel can update the value of an immuta=
ble
> > >> property
> > >>            *     by calling drm_object_property_set_value().
> > >>            */
> > >>
> > >> Here we are allowing userspace to change max_bpc
> > >>
> > >>
> > >> drm_atomic_connector_set_property()
> > >> {
> > >>          **********
> > >>
> > >>           } else if (property =3D=3D connector->max_bpc_property) {
> > >>                   state->max_requested_bpc =3D val;
> > >>
> > >>          **********
> > >> }
> > >>
> > >> I believe you are referring to this IGT check right?
> > >>
> > >> https://gitlab.freedesktop.org/drm/igt-gpu-tools/-/blob/master/tests=
/kms_properties.c#L428
> > >
> > > Yes
> > >
> > >>
> > >> I think we should fix IGT in this case unless there is some reason we
> > >> are missing. Because just because it has the same min and max does n=
ot
> > >> mean its immutable by the doc of the IMMUTABLE flag.
> > >
> > > Well, having the same min and max means that it is impossible to
> > > change the property. So the property is immutable, but doesn't have
> > > the flag.
> > >
> >
> > True, then does DRM_MODE_PROP_IMMUTABLE need a doc update too indicating
> > that even if the min and max is same, property will be interpreted as
> > immutable.
>=20
> Granted that I'm only doing it for max_bpc property I don't think so.

Yeah, I have to agree with Abhinav here, it does look fishy to me too,
even more so that it's only ever "documented" through an igt routine
that has never documented why we want that.

I'm fine with the change if it's indeed what we expect, and it might
very well be, but I'd like to clear that up and document it first.

Maxime

--rfnpoh6eg6ld7cwc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZnpvbwAKCRDj7w1vZxhR
xYL7AP4na9CAkY5cDVnbxhLQv33jSeSLQInVW9ElpqxxOPBHmwEAh4YpYXXsISCQ
QnyvgFsJStn63FTZJJOa70VwWzXotgI=
=g3NN
-----END PGP SIGNATURE-----

--rfnpoh6eg6ld7cwc--

