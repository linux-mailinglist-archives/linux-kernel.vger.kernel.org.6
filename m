Return-Path: <linux-kernel+bounces-232072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB36A91A2B6
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 11:33:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A18272849AD
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 09:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1646713A899;
	Thu, 27 Jun 2024 09:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eyGU99Rz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F59139D0A;
	Thu, 27 Jun 2024 09:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719480793; cv=none; b=fwV8HNqwrcWYFebJVtsNEmVfvo2WauFNAGuoHYeEdCZVv4iAN1KycFdnlmAowDC3SjfVaYX24tncyHjn0vax85HkxahNoOmUmoKZRjvymws3n19l0MSmUmJmM8qYvTv5pOMef0n0Gc9LjOJFd/bhuD6L8TAqcJ/iKqJpAOG4fA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719480793; c=relaxed/simple;
	bh=RRFrL+J8bhE7m7BCU436iQMZWyX7Gr+S0F7mrYU2u5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a7fA5XWc1B4zRUP9PDSaBFv2PwOUMlhUCUI+3CDZyV4IkRcDKJDr2EavYHHx7U9+sFunREqG3ffSK1F+9quD0pCV/j6xY0Pnj3gz2VuClmroJU51AJd3peigkJSkO3kM0DEBTykxBjAX9qS6r86AU8liRyY3eXJKYXsg7YO6ysM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eyGU99Rz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59961C2BBFC;
	Thu, 27 Jun 2024 09:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719480792;
	bh=RRFrL+J8bhE7m7BCU436iQMZWyX7Gr+S0F7mrYU2u5o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eyGU99RzdVrDe1FAhHf9t7pEtCfIZ+EPr5Q1ZWjPe0JNlBsJ61RLBMmmMu1NoKzm6
	 PyCb0hsVRTHd9zzEK23LG2AQ4meIi6rfWRXJYXlrntdEyOI4d6nE7Y4NuUZEQLbsHw
	 7dGUzv8mg9giD1srvBdMlGoaNQp1ph2wiDHvgGpEbZL12DqrJj9K1rdTlcn0plQNpv
	 hlmZolDLYE05CEfkONilKMji2Pq70h/Jh18JI6XAzDHNW7AnXtBetPWZQIZ9E+p+lJ
	 jXAeqo1n77y/WpGXl1JTfs5qZuIL0SD/8hAWsfQGM6ZeYlERzOM2wctJr18T9tpv6H
	 ZDpkSL62pyztg==
Date: Thu, 27 Jun 2024 11:33:10 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org
Subject: Re: [PATCH RFC 4/5] drm/bridge: connector: add support for HDMI
 codec framework
Message-ID: <20240627-vengeful-glorious-stork-a70480@houat>
References: <20240615-drm-bridge-hdmi-connector-v1-0-d59fc7865ab2@linaro.org>
 <20240615-drm-bridge-hdmi-connector-v1-4-d59fc7865ab2@linaro.org>
 <20240621-polite-ruby-hyrax-c4020e@houat>
 <CAA8EJppryh=LR40_5cBH5+0LZdRP5bsZ9iyqHDBFdBqu_H=1=A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="f7enk3sda63umhov"
Content-Disposition: inline
In-Reply-To: <CAA8EJppryh=LR40_5cBH5+0LZdRP5bsZ9iyqHDBFdBqu_H=1=A@mail.gmail.com>


--f7enk3sda63umhov
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 21, 2024 at 02:10:22PM GMT, Dmitry Baryshkov wrote:
> On Fri, 21 Jun 2024 at 12:30, Maxime Ripard <mripard@kernel.org> wrote:
> >
> > On Sat, Jun 15, 2024 at 08:53:33PM GMT, Dmitry Baryshkov wrote:
> > > Add necessary glue code to be able to use new HDMI codec framework fr=
om
> > > the DRM bridge drivers. The drm_bridge implements a limited set of the
> > > hdmi_codec_ops interface, with the functions accepting both
> > > drm_connector and drm_bridge instead of just a generic void pointer.
> > >
> > > This framework is integrated with the DRM HDMI Connector framework, b=
ut
> > > can also be used for DisplayPort connectors.
> > >
> > > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > > ---
> > >  drivers/gpu/drm/drm_bridge_connector.c | 130 +++++++++++++++++++++++=
+++++++++-
> > >  include/drm/drm_bridge.h               |  46 ++++++++++++
> > >  2 files changed, 174 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/drm_bridge_connector.c b/drivers/gpu/drm=
/drm_bridge_connector.c
> > > index 0869b663f17e..71d6fdc2391f 100644
> > > --- a/drivers/gpu/drm/drm_bridge_connector.c
> > > +++ b/drivers/gpu/drm/drm_bridge_connector.c
> > > @@ -20,6 +20,8 @@
> > >  #include <drm/drm_probe_helper.h>
> > >  #include <drm/display/drm_hdmi_state_helper.h>
> > >
> > > +#include <sound/hdmi-codec.h>
> > > +
> > >  /**
> > >   * DOC: overview
> > >   *
> > > @@ -95,6 +97,14 @@ struct drm_bridge_connector {
> > >        * HDMI connector infrastructure, if any (see &DRM_BRIDGE_OP_HD=
MI).
> > >        */
> > >       struct drm_bridge *bridge_hdmi;
> > > +     /**
> > > +      * @bridge_hdmi_codec:
> > > +      *
> > > +      * The bridge in the chain that implements necessary support fo=
r the
> > > +      * HDMI Audio Codec infrastructure, if any (see
> > > +      * &DRM_BRIDGE_OP_HDMI_CODEC).
> > > +      */
> > > +     struct drm_bridge *bridge_hdmi_codec;
> >
> > Can we have a setup where one bridge would support the video stream and
> > another one the audio?
> >
> > I think for now I'd rather make them both provided by the same bridge,
> > and we can always change that later on if we need to.
>=20
> The same point here (and for your second comment): DisplayPort audio
> support.

Well, yeah, but then we can do the same thing for DisplayPort and share
some code when needed.

And like I said, we can change that later if we need to, but there's no
point in trying to make something super flexible if we're not quite sure
what the requirements are.

Maxime

--f7enk3sda63umhov
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZn0x1QAKCRDj7w1vZxhR
xVJGAQCp2RjFO641IHB+23/Wkr8+mhs/+PlOaAPRI9HS0dwhcwEA17Y3DB2cG1za
4a7vJ4jveja5VWnV4JRHQ7O3zqqaQww=
=809M
-----END PGP SIGNATURE-----

--f7enk3sda63umhov--

