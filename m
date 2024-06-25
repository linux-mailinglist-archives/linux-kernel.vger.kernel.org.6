Return-Path: <linux-kernel+bounces-229014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 51C5E9169B8
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 16:01:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6B921F2755C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 14:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17C3716D4C5;
	Tue, 25 Jun 2024 13:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BFVo98BP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44CA3169AE4
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 13:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719323909; cv=none; b=N4WdDFswk8AL7wmS6Y4yYNomDRMSTpjJpFYHzPymS5YW7gObn0qNuuQ/3XYYfpcwbnSDZxyBu/Lk61K/T5cY7z6Fwd3C/00N/phDxARyDXK0ks2EFDJcFSv+c8tn7uxQyixJz8wHy5QpCquz8A2cs0pLYi8RsqU3S4thpay/m0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719323909; c=relaxed/simple;
	bh=z/SrKzFh8FsvTvW1LfwzGcSQlXiVohodF0eVYwHlPW0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=roQHZiU3E5qjfsnpByRVcVrCEvLr3jcmo8dhBPJxlzhz8CyCFLIe3VgzszEaGuwZIv2jWzPlW0DIV9GMJtWr8xsEIMQuZ7Zjd1ZdKVRDyKlx7uPuarKakJ4E39UlDO+hLH8+dEIK16AzBDID3SVLN1z3H2yLrVE63TKgR9i5pkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BFVo98BP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F6C0C32781;
	Tue, 25 Jun 2024 13:58:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719323908;
	bh=z/SrKzFh8FsvTvW1LfwzGcSQlXiVohodF0eVYwHlPW0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BFVo98BP1EpOONpMW26fOQOBm4cwNPwIzH9LM1svSb4OgBjgSQwmp6/8tZtb9wyHO
	 3AGWJAcLChikXIa9hIxaiUmhBt9h4/mtqaobnzZ69jT7iP0/lYDBT+SV0YWEeCd4+X
	 iSsTiCOzeTpniz+UG3sEkP2HU+mXi+iSN6UErJq6R5CisZsXohrQoFREAO5MoGbkad
	 lMFjuCsQJyRU7Qii7T5EXB06nR73vO/sEYZ+15We3a6Dd7emnQGGDJPnF2plMCEJxX
	 e6JvhXyitPLMXkyP4L0u7ALWPLYjpomcP0dju74JPHqomGJxsOdH0UJR72Vph3oArd
	 J1iMXM9gs3vgA==
Date: Tue, 25 Jun 2024 15:58:25 +0200
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
Message-ID: <20240625-enlightened-optimistic-fossa-fdd128@houat>
References: <20240623-drm-bridge-connector-fix-hdmi-reset-v2-0-8590d44912ce@linaro.org>
 <20240623-drm-bridge-connector-fix-hdmi-reset-v2-2-8590d44912ce@linaro.org>
 <99ff549c-f5c4-dc9c-42f3-396dc3d29d6b@quicinc.com>
 <CAA8EJppcH-z275m6xDQaigsxmVhnfJkLVsq68GHLFoAq_p_2GA@mail.gmail.com>
 <30fa4e53-5a03-4030-2be5-f383a1c60077@quicinc.com>
 <CAA8EJpo_dBDqLUVH-SkufhFchu64rhC+vkhVBFdt++E4pdCrQg@mail.gmail.com>
 <20240625-yellow-shrimp-of-genius-17c662@houat>
 <CAA8EJpr_kn=x080KLGfwsLi3PnnNhTjJhvL=hiRNLBD=WqSuZQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2wb3bjjqeq4p5mtd"
Content-Disposition: inline
In-Reply-To: <CAA8EJpr_kn=x080KLGfwsLi3PnnNhTjJhvL=hiRNLBD=WqSuZQ@mail.gmail.com>


--2wb3bjjqeq4p5mtd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 25, 2024 at 10:23:14AM GMT, Dmitry Baryshkov wrote:
> On Tue, 25 Jun 2024 at 10:19, Maxime Ripard <mripard@kernel.org> wrote:
> >
> > Hi,
> >
> > On Tue, Jun 25, 2024 at 09:21:27AM GMT, Dmitry Baryshkov wrote:
> > > On Tue, 25 Jun 2024 at 01:56, Abhinav Kumar <quic_abhinavk@quicinc.co=
m> wrote:
> > > >
> > > >
> > > >
> > > > On 6/24/2024 3:46 PM, Dmitry Baryshkov wrote:
> > > > > On Tue, 25 Jun 2024 at 01:39, Abhinav Kumar <quic_abhinavk@quicin=
c.com> wrote:
> > > > >>
> > > > >> + IGT dev
> > > > >>
> > > > >> On 6/22/2024 10:40 PM, Dmitry Baryshkov wrote:
> > > > >>> With the introduction of the HDMI Connector framework the drive=
r might
> > > > >>> end up creating the max_bpc property with min =3D max =3D 8. IG=
T insists
> > > > >>> that such properties carry the 'immutable' flag. Automatically =
set the
> > > > >>> flag if the driver asks for the max_bpc property with min =3D=
=3D max.
> > > > >>>
> > > > >>
> > > > >> This change does not look right to me.
> > > > >>
> > > > >> I wonder why we need this check because DRM_MODE_PROP_IMMUTABLE =
means
> > > > >> that as per the doc, userspace cannot change the property.
> > > > >>
> > > > >>            * DRM_MODE_PROP_IMMUTABLE
> > > > >>            *     Set for properties whose values cannot be chang=
ed by
> > > > >>            *     userspace. The kernel is allowed to update the =
value of
> > > > >> these
> > > > >>            *     properties. This is generally used to expose pr=
obe state to
> > > > >>            *     userspace, e.g. the EDID, or the connector path=
 property
> > > > >> on DP
> > > > >>            *     MST sinks. Kernel can update the value of an im=
mutable
> > > > >> property
> > > > >>            *     by calling drm_object_property_set_value().
> > > > >>            */
> > > > >>
> > > > >> Here we are allowing userspace to change max_bpc
> > > > >>
> > > > >>
> > > > >> drm_atomic_connector_set_property()
> > > > >> {
> > > > >>          **********
> > > > >>
> > > > >>           } else if (property =3D=3D connector->max_bpc_property=
) {
> > > > >>                   state->max_requested_bpc =3D val;
> > > > >>
> > > > >>          **********
> > > > >> }
> > > > >>
> > > > >> I believe you are referring to this IGT check right?
> > > > >>
> > > > >> https://gitlab.freedesktop.org/drm/igt-gpu-tools/-/blob/master/t=
ests/kms_properties.c#L428
> > > > >
> > > > > Yes
> > > > >
> > > > >>
> > > > >> I think we should fix IGT in this case unless there is some reas=
on we
> > > > >> are missing. Because just because it has the same min and max do=
es not
> > > > >> mean its immutable by the doc of the IMMUTABLE flag.
> > > > >
> > > > > Well, having the same min and max means that it is impossible to
> > > > > change the property. So the property is immutable, but doesn't ha=
ve
> > > > > the flag.
> > > > >
> > > >
> > > > True, then does DRM_MODE_PROP_IMMUTABLE need a doc update too indic=
ating
> > > > that even if the min and max is same, property will be interpreted =
as
> > > > immutable.
> > >
> > > Granted that I'm only doing it for max_bpc property I don't think so.
> >
> > Yeah, I have to agree with Abhinav here, it does look fishy to me too,
> > even more so that it's only ever "documented" through an igt routine
> > that has never documented why we want that.
> >
> > I'm fine with the change if it's indeed what we expect, and it might
> > very well be, but I'd like to clear that up and document it first.
>=20
> Should I also move the setting of the IMMUTABLE flag to a more generic co=
de?

Possibly, but I guess that will depend on the outcome of that discussion

Maxime

--2wb3bjjqeq4p5mtd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZnrNAQAKCRDj7w1vZxhR
xVzsAQCnu6DC0Ka/hvDQ2v8nWmyLROciJ0aE03Y99+Psr1oDQwD+JlXJWLZr4PzM
VUzEa4rZRsI9MAKL3N5mWA5QF0rn5AY=
=3G09
-----END PGP SIGNATURE-----

--2wb3bjjqeq4p5mtd--

