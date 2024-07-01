Return-Path: <linux-kernel+bounces-236278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9B6591DFDA
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 14:49:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 846A5281CD4
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 12:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28EA815A85F;
	Mon,  1 Jul 2024 12:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hPDkoDsH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B99115A84E
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 12:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719838154; cv=none; b=G+SbQk9Q07eQpSaYlMJvMGqgFlC4PBStSIOk6HIuSYlAjl84CLeSAa04NCoJHs35r3NfeFU/N/9J2tq6bUnIGHuukRdeP8yUvWFfQK8+xDjW7fK/aOMS6XXOehzkaeb5/cfEB8zdT5m4YWOhVHpojO3qLfzUS1O8G80ss5uScL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719838154; c=relaxed/simple;
	bh=v6qUUZXZ9LbqXsuxzw3IntQUC5PzQoBOqCofNfztNiY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lFd8RLUE79BNAqRLBXrbZV1oCDNiVQ0nEtMUEGxDVGuWQWuG5QY4V/Kez1XHKgATlvlQ6KOPdP1lydR4OLri2CoW6t/TmFjjBjnblAg3JPIozwORrW4/1SG3r4z9EnPnipMm1XgqTkTKlIuEhJnU11cIWVbdnAcuvsIAw1nSU8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hPDkoDsH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E94D1C116B1;
	Mon,  1 Jul 2024 12:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719838154;
	bh=v6qUUZXZ9LbqXsuxzw3IntQUC5PzQoBOqCofNfztNiY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hPDkoDsHsKhklFFx66Tw9CPJ6Y35w1C2i00Ixvq3038M2mKIVwhTlPXmQL6qea+nw
	 nBUrpvaH9kIGPud3BaCKuIGOLXRK6S7HbvDwb0Ma74NyTKqJojhXm2LEd1QbkhICgU
	 oGgWIq5Ky5yeuh8HRGLPty+Y09/BIvF+q7QYRVf9/7yI1//IA1Fth6SPM2aVV9YGHh
	 G/LgZky8C1XmEFfl4bfuGTwN6ZIwmOvrTTZW7VtDtOb7amjh/nhCZME+t4hX/0NkXD
	 NYTcLIts7K9b2AhWyKdVkTfmfceuRKqF8OnKi0T2jEArFWQNUGq4mX7hraYoVrGk4W
	 Eo6dWXqTQHjAw==
Date: Mon, 1 Jul 2024 14:49:11 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Dave Stevenson <dave.stevenson@raspberrypi.com>, 
	Rob Clark <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] drm/bridge-connector: reset the HDMI connector
 state
Message-ID: <20240701-little-sociable-iguana-effa3c@houat>
References: <20240623-drm-bridge-connector-fix-hdmi-reset-v2-0-8590d44912ce@linaro.org>
 <20240623-drm-bridge-connector-fix-hdmi-reset-v2-1-8590d44912ce@linaro.org>
 <20240625-feathered-loon-of-health-ec7e6d@houat>
 <CAA8EJpq314tQFZpkXgL1cYDPfoFRukhB_KiaDvmsqdzHFD512g@mail.gmail.com>
 <20240625-jackrabbit-of-major-ampleness-e0becb@houat>
 <ov4uvlcyzfqw55g567jikyceivpkl7l3ijuol53fqsv2asdgrl@miggxlyyeiek>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="me2klb7invzxbisc"
Content-Disposition: inline
In-Reply-To: <ov4uvlcyzfqw55g567jikyceivpkl7l3ijuol53fqsv2asdgrl@miggxlyyeiek>


--me2klb7invzxbisc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 25, 2024 at 07:38:22PM GMT, Dmitry Baryshkov wrote:
> On Tue, Jun 25, 2024 at 05:49:54PM GMT, Maxime Ripard wrote:
> > On Tue, Jun 25, 2024 at 06:05:33PM GMT, Dmitry Baryshkov wrote:
> > > On Tue, 25 Jun 2024 at 18:02, Maxime Ripard <mripard@kernel.org> wrot=
e:
> > > >
> > > > Hi,
> > > >
> > > > On Sun, Jun 23, 2024 at 08:40:12AM GMT, Dmitry Baryshkov wrote:
> > > > > On HDMI connectors which use drm_bridge_connector and DRM_BRIDGE_=
OP_HDMI
> > > > > IGT chokes on the max_bpc property in several kms_properties test=
s due
> > > > > to the the drm_bridge_connector failing to reset HDMI-related
> > > > > properties.
> > > > >
> > > > > Call __drm_atomic_helper_connector_hdmi_reset() if there is a
> > > > > the drm_bridge_connector has bridge_hdmi.
> > > > >
> > > > > Note, the __drm_atomic_helper_connector_hdmi_reset() is moved to
> > > > > drm_atomic_state_helper.c because drm_bridge_connector.c can not =
depend
> > > > > on DRM_DISPLAY_HDMI_STATE_HELPER. At the same time it is impossib=
le to
> > > > > call this function from HDMI bridges, there is is no function that
> > > > > corresponds to the drm_connector_funcs::reset().
> > > >
> > > > Why can't it depend on DRM_DISPLAY_HDMI_STATE_HELPER?
> > >=20
> > > Is it okay to have DRM_KMS_HELPER to depend unconditionally or select
> > > DRM_DISPLAY_HDMI_STATE_HELPER?
> >=20
> > No, but it's not clear to me why drm_bridge_connector is part of
> > DRM_KMS_HELPER? It doesn't seem to be called from the core but only
> > drivers, just like DRM_PANEL_BRIDGE which has a separate config option
>=20
> But then DRM_PANEL_BRIDGE is also linked into drm_kms_helper.ko.

And we don't seem to have any reason for that, it could be a separate
module afaik.

> I can't really say that I understand the definition of various helper
> modules, but my taste tells me that code from drm/*.c should not
> depend directly on the code from drm/display/*.c.

Sure, but the bridge connector could be under bridge just as well, or
part of the display helpers.

It's really a "leaf" driver as far as helpers are concerned.

Maxime

--me2klb7invzxbisc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZoKlxgAKCRDj7w1vZxhR
xbLGAP9QjGMpGQ4lcq2vmRKwxTrBTwk4ljyI0gIkLVgij7GQ0wEAgUMgxhlK5cT7
vsRyGCD9EB+uJa0VYuy+xOPe+dneSAs=
=OmLd
-----END PGP SIGNATURE-----

--me2klb7invzxbisc--

