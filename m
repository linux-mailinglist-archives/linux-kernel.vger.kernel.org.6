Return-Path: <linux-kernel+bounces-261987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D69493BF03
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 11:25:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 141E51F21F15
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 09:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACA0617623F;
	Thu, 25 Jul 2024 09:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LGpIqwcD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C2E81E;
	Thu, 25 Jul 2024 09:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721899509; cv=none; b=Sq/RbuFTP/kSfBj6j15naH3OEp8XjyUC0snud9o914/EFKY2zOXZCsXu8cFp+jv7Ic4OxJ5cNXxJv3ZX3SS9Ig2XctcOQohWg1O6olBbGrVWYGMXECVIPik5BixfWDgnrjOZ1fyaRAAE78S9C70nnsT9wXbPpPeLilzKgGXaIBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721899509; c=relaxed/simple;
	bh=orwFQpGIZkb3iyMLn0U6jfHJHT7fY4Z3DAltwfRdKbI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EHXl4rzgKlMPBE1e17s6LWwjRpHAbggtBNN/uoblCJp778k+AI9mVBLSGJPScTD+/G+WM9OcALAoVBxxwqknETBTo6O4Zi8mqT1LFJktUKGi7wb7N05MAqnDbQhlB8wtUpxA7VZ20TtEM5AmaVtUrmRHxzKk5X+c/PKDgCUM118=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LGpIqwcD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98FB6C116B1;
	Thu, 25 Jul 2024 09:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721899509;
	bh=orwFQpGIZkb3iyMLn0U6jfHJHT7fY4Z3DAltwfRdKbI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LGpIqwcDxO1bqicM2+zIfvtpAoTn9xNpVP2ckuCop4fve0xOoXWjs+PIVEU7t8W3F
	 XU8zW0K8niQg/RPYCTeeOr1VWgRvgSe5MzoQzmoutdRzlGVDn6SrFLwV1OgtCfAXyX
	 sgAaazGYrDujzm1k17DOo5L9cWDqbpkIqloTp4W+8kSWEt1YruA/cxJ6VaOdrLw30k
	 ccV5yv480+1AZd7DDAh2bPG9vut7mTYLHsF4dQH6cW2WRmcQIKHc31OHgneC3p3Daf
	 pUpbU4XrZb9doubE2ufGgI4YM4EqiHkMfjgqnZ5XowT0bWHJh/8ONRjRYEMq5RIimI
	 BBERal56OP9ig==
Date: Thu, 25 Jul 2024 11:25:06 +0200
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
Subject: Re: [PATCH RFC 3/5] drm/connector: implement generic HDMI codec
 helpers
Message-ID: <20240725-rainbow-nuthatch-of-brotherhood-bbcedc@houat>
References: <20240615-drm-bridge-hdmi-connector-v1-0-d59fc7865ab2@linaro.org>
 <20240615-drm-bridge-hdmi-connector-v1-3-d59fc7865ab2@linaro.org>
 <20240621-glorious-oryx-of-expression-1ad75f@houat>
 <CAA8EJpr=ervT-KD+tYphPeTfrFGDfSaxNaYC5hfzmtVch5v10g@mail.gmail.com>
 <20240626-spiked-heavenly-kakapo-1dafce@houat>
 <pkfbp4xyg5za3vnlpryhbflb6nvp7s3bs3542wk3y5zsonoy7l@y5qcua6kfi4h>
 <20240627-meaty-bullfrog-of-refinement-cc9d85@houat>
 <cwxmu5a37qaqerpaolohxw57nzerkvlumx4dsqwmqwx5t7xhxo@kq6j63hfydra>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="b6qlvgiljxtj67ge"
Content-Disposition: inline
In-Reply-To: <cwxmu5a37qaqerpaolohxw57nzerkvlumx4dsqwmqwx5t7xhxo@kq6j63hfydra>


--b6qlvgiljxtj67ge
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 27, 2024 at 04:29:49PM GMT, Dmitry Baryshkov wrote:
> On Thu, Jun 27, 2024 at 11:49:37AM GMT, Maxime Ripard wrote:
> > On Wed, Jun 26, 2024 at 07:09:34PM GMT, Dmitry Baryshkov wrote:
> > > On Wed, Jun 26, 2024 at 04:05:01PM GMT, Maxime Ripard wrote:
> > > > On Fri, Jun 21, 2024 at 02:09:04PM GMT, Dmitry Baryshkov wrote:
> > > > > On Fri, 21 Jun 2024 at 12:27, Maxime Ripard <mripard@kernel.org> =
wrote:
> > > > > >
> > > > > > Hi,
> > > > > >
> > > > > > Sorry for taking some time to review this series.
> > > > >=20
> > > > > No problem, that's not long.
> > > > >=20
> > > > > >
> > > > > > On Sat, Jun 15, 2024 at 08:53:32PM GMT, Dmitry Baryshkov wrote:
> > > > > > > Several DRM drivers implement HDMI codec support (despite its=
 name it
> > > > > > > applies to both HDMI and DisplayPort drivers). Implement gene=
ric
> > > > > > > framework to be used by these drivers. This removes a require=
ment to
> > > > > > > implement get_eld() callback and provides default implementat=
ion for
> > > > > > > codec's plug handling.
> > > > > > >
> > > > > > > The framework is integrated with the DRM HDMI Connector frame=
work, but
> > > > > > > can be used by DisplayPort drivers.
> > > > > > >
> > > > > > > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > > > > > > ---
> > > > > > >  drivers/gpu/drm/Makefile                   |   1 +
> > > > > > >  drivers/gpu/drm/drm_connector.c            |   8 ++
> > > > > > >  drivers/gpu/drm/drm_connector_hdmi_codec.c | 157 +++++++++++=
++++++++++++++++++
> > > > > > >  include/drm/drm_connector.h                |  33 ++++++
> > > > > > >  4 files changed, 199 insertions(+)
> > > > > > >
> > > > > > > diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makef=
ile
> > > > > > > index 68cc9258ffc4..e113a6eade23 100644
> > > > > > > --- a/drivers/gpu/drm/Makefile
> > > > > > > +++ b/drivers/gpu/drm/Makefile
> > > > > > > @@ -45,6 +45,7 @@ drm-y :=3D \
> > > > > > >       drm_client_modeset.o \
> > > > > > >       drm_color_mgmt.o \
> > > > > > >       drm_connector.o \
> > > > > > > +     drm_connector_hdmi_codec.o \
> > > > > > >       drm_crtc.o \
> > > > > > >       drm_displayid.o \
> > > > > > >       drm_drv.o \
> > > > > > > diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/dr=
m/drm_connector.c
> > > > > > > index 3d73a981004c..66d6e9487339 100644
> > > > > > > --- a/drivers/gpu/drm/drm_connector.c
> > > > > > > +++ b/drivers/gpu/drm/drm_connector.c
> > > > > > > @@ -279,6 +279,7 @@ static int __drm_connector_init(struct dr=
m_device *dev,
> > > > > > >       mutex_init(&connector->mutex);
> > > > > > >       mutex_init(&connector->edid_override_mutex);
> > > > > > >       mutex_init(&connector->hdmi.infoframes.lock);
> > > > > > > +     mutex_init(&connector->hdmi_codec.lock);
> > > > > > >       connector->edid_blob_ptr =3D NULL;
> > > > > > >       connector->epoch_counter =3D 0;
> > > > > > >       connector->tile_blob_ptr =3D NULL;
> > > > > > > @@ -529,6 +530,12 @@ int drmm_connector_hdmi_init(struct drm_=
device *dev,
> > > > > > >
> > > > > > >       connector->hdmi.funcs =3D hdmi_funcs;
> > > > > > >
> > > > > > > +     if (connector->hdmi_codec.i2s || connector->hdmi_codec.=
spdif) {
> > > > > > > +             ret =3D drmm_connector_hdmi_codec_alloc(dev, co=
nnector, hdmi_funcs->codec_ops);
> > > > > > > +             if (ret)
> > > > > > > +                     return ret;
> > > > > > > +     }
> > > > > > > +
> > > > > > >       return 0;
> > > > > > >  }
> > > > > > >  EXPORT_SYMBOL(drmm_connector_hdmi_init);
> > > > > > > @@ -665,6 +672,7 @@ void drm_connector_cleanup(struct drm_con=
nector *connector)
> > > > > > >               connector->funcs->atomic_destroy_state(connecto=
r,
> > > > > > >                                                      connecto=
r->state);
> > > > > > >
> > > > > > > +     mutex_destroy(&connector->hdmi_codec.lock);
> > > > > > >       mutex_destroy(&connector->hdmi.infoframes.lock);
> > > > > > >       mutex_destroy(&connector->mutex);
> > > > > > >
> > > > > > > diff --git a/drivers/gpu/drm/drm_connector_hdmi_codec.c b/dri=
vers/gpu/drm/drm_connector_hdmi_codec.c
> > > > > > > new file mode 100644
> > > > > > > index 000000000000..a3a7ad117f6f
> > > > > > > --- /dev/null
> > > > > > > +++ b/drivers/gpu/drm/drm_connector_hdmi_codec.c
> > > > > > > @@ -0,0 +1,157 @@
> > > > > > > +/*
> > > > > > > + * Copyright (c) 2024 Linaro Ltd
> > > > > > > + *
> > > > > > > + * Permission to use, copy, modify, distribute, and sell thi=
s software and its
> > > > > > > + * documentation for any purpose is hereby granted without f=
ee, provided that
> > > > > > > + * the above copyright notice appear in all copies and that =
both that copyright
> > > > > > > + * notice and this permission notice appear in supporting do=
cumentation, and
> > > > > > > + * that the name of the copyright holders not be used in adv=
ertising or
> > > > > > > + * publicity pertaining to distribution of the software with=
out specific,
> > > > > > > + * written prior permission.  The copyright holders make no =
representations
> > > > > > > + * about the suitability of this software for any purpose.  =
It is provided "as
> > > > > > > + * is" without express or implied warranty.
> > > > > > > + *
> > > > > > > + * THE COPYRIGHT HOLDERS DISCLAIM ALL WARRANTIES WITH REGARD=
 TO THIS SOFTWARE,
> > > > > > > + * INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY AND F=
ITNESS, IN NO
> > > > > > > + * EVENT SHALL THE COPYRIGHT HOLDERS BE LIABLE FOR ANY SPECI=
AL, INDIRECT OR
> > > > > > > + * CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING=
 FROM LOSS OF USE,
> > > > > > > + * DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIG=
ENCE OR OTHER
> > > > > > > + * TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE=
 USE OR PERFORMANCE
> > > > > > > + * OF THIS SOFTWARE.
> > > > > > > + */
> > > > > > > +
> > > > > > > +#include <linux/mutex.h>
> > > > > > > +#include <linux/platform_device.h>
> > > > > > > +
> > > > > > > +#include <drm/drm_connector.h>
> > > > > > > +#include <drm/drm_managed.h>
> > > > > > > +
> > > > > > > +#include <sound/hdmi-codec.h>
> > > > > > > +
> > > > > > > +static int drm_connector_hdmi_codec_get_eld(struct device *d=
ev, void *data,
> > > > > > > +                                         uint8_t *buf, size_=
t len)
> > > > > > > +{
> > > > > > > +     struct drm_connector *connector =3D data;
> > > > > > > +
> > > > > > > +     //  FIXME: locking against drm_edid_to_eld ?
> > > > > > > +     memcpy(buf, connector->eld, min(sizeof(connector->eld),=
 len));
> > > > > > > +
> > > > > > > +     return 0;
> > > > > > > +}
> > > > > > > +
> > > > > > > +static int drm_connector_hdmi_codec_hook_plugged_cb(struct d=
evice *dev,
> > > > > > > +                                                 void *data,
> > > > > > > +                                                 hdmi_codec_=
plugged_cb fn,
> > > > > > > +                                                 struct devi=
ce *codec_dev)
> > > > > > > +{
> > > > > > > +     struct drm_connector *connector =3D data;
> > > > > > > +
> > > > > > > +     mutex_lock(&connector->hdmi_codec.lock);
> > > > > > > +
> > > > > > > +     connector->hdmi_codec.plugged_cb =3D fn;
> > > > > > > +     connector->hdmi_codec.plugged_cb_dev =3D codec_dev;
> > > > > > > +
> > > > > > > +     fn(codec_dev, connector->hdmi_codec.last_state);
> > > > > > > +
> > > > > > > +     mutex_unlock(&connector->hdmi_codec.lock);
> > > > > > > +
> > > > > > > +     return 0;
> > > > > > > +}
> > > > > > > +
> > > > > > > +void drm_connector_hdmi_codec_plugged_notify(struct drm_conn=
ector *connector,
> > > > > > > +                                          bool plugged)
> > > > > > > +{
> > > > > > > +     mutex_lock(&connector->hdmi_codec.lock);
> > > > > > > +
> > > > > > > +     connector->hdmi_codec.last_state =3D plugged;
> > > > > > > +
> > > > > > > +     if (connector->hdmi_codec.plugged_cb &&
> > > > > > > +         connector->hdmi_codec.plugged_cb_dev)
> > > > > > > +             connector->hdmi_codec.plugged_cb(connector->hdm=
i_codec.plugged_cb_dev,
> > > > > > > +                                              connector->hdm=
i_codec.last_state);
> > > > > > > +
> > > > > > > +     mutex_unlock(&connector->hdmi_codec.lock);
> > > > > > > +}
> > > > > > > +EXPORT_SYMBOL(drm_connector_hdmi_codec_plugged_notify);
> > > > > >
> > > > > > I think we should do this the other way around, or rather, like=
 we do
> > > > > > for drm_connector_hdmi_init. We'll need a hotplug handler for m=
ultiple
> > > > > > things (CEC, HDMI 2.0, audio), so it would be best to have a si=
ngle
> > > > > > function to call from drivers, that will perform whatever is ne=
eded
> > > > > > depending on the driver's capabilities.
> > > > >=20
> > > > > I see, this API is probably misnamed. The hdmi_codec_ops use the
> > > > > 'plugged' term,
> > > >=20
> > > > Is it misnamed?
> > > >=20
> > > > It's documented as:
> > > >=20
> > > >   Hook callback function to handle connector plug event. Optional.
> > > >=20
> > > > > but most of the drivers notify the ASoC / codec during atomic_ena=
ble /
> > > > > atomic_disable path, because usually the audio path can not work =
with
> > > > > the video path being disabled.
> > > >=20
> > > > That's not clear to me either:
> > > >=20
> > > >   - rockchip/cdn-dp, msm/dp/dp-audio, dw-hdmi, seem to call it at
> > > >     enable/disable
> > > >=20
> > > >   - anx7625, mtk_hdmi and mtk_dp calls it in detect
> > > >=20
> > > >   - adv7511, ite-it66121, lontium-lt9611, lontium-lt9611uxc, sii902=
x,
> > > >     exynos, tda998x, msm_hdmi, sti, tegra, vc4 don't call it at all.
> > > >=20
> > > > So it doesn't look like there's a majority we can align with, and
> > > > neither should we: we need to figure out what we *need* to do and w=
hen,
> > > > and do that.
> > > >=20
> > > > From the documentation and quickly through the code though, handlin=
g it
> > > > in detect looks like the right call.
> > >=20
> > > It is tempting to have it in the hotplug call. However:
> > >=20
> > > - It is used to send events to the ASoC Jack, marking the output as
> > >   plugged or unplugged. Once the output is plugged, userspace might
> > >   consider using it for the audio output. Please correct me if I'm
> > >   wrong, but I don't think one can output audio to the HDMI plug unle=
ss
> > >   there is a video stream.
> >=20
> > That's something to check in the HDMI spec and with the ALSA
> > maintainers.
>=20
> Mark and Liam are on CC list. I've also pinged Mark on the IRC (on
> #alsa, if the channel logs are preserved somewhere)
>=20
> <lumag> I'm trying to implement a somewhat generic implementation that th=
e drivers can hook in. The main discussion is at [link to this discussion]
> <lumag> So in theory that affects all ASoC platforms having HDMI or DP au=
dio output
> <broonie> In that case I'd be conservative and try to follow the state of=
 the physical connection as closely as possible.
>=20
> So it is really 'plugged'.

Ack.

> > > - Having it in the hotplug notification chain is also troublesome. As
> > >   Dave pointed out in the quoted piece of code, it should come after
> > >   reading the EDID on the connect event. On the disconnect event it
> > >   should probably come before calling the notification chain, to let
> > >   audio code interract correctly with the fully enabled display devic=
es.
> >=20
> > EDIDs are fetched when hotplug is detected anyway, and we need it for
> > other things anyway (like CEC).
>=20
> I see that:
>=20
> - VC4 reads EDID and sets CEC address directly in hotplug notifier and
>   then again in get_modes callback. (why is it necessary in the hotplug
>   notifier, if it's done anyway in get_modes?)

vc4 is probably somewhat correct, but also a bit redundant here: the CEC
physical address is supposed to be set when we detect a sink.

When that sink is removed, we don't have a physical address anymore and
we thus need to call cec_phys_addr_invalidate.

When a sink is plugged again, we need to call cec_s_phys_addr() with the
sink address.

So what vc4_hdmi_handle_hotplug is doing is fine, but the one in the
get_modes might be redundant.

> - sun4i sets CEC address from get_modes

Yeah, that doesn't work.=20

If the display is switched to another one and if the userspace doesn't
react to the hotplug event by calling get_modes, the physical address
will be the old one.

But since it's a polled hotplug, it's a situation that generally sucks.

> - ADV7511 does a trick and sets CEC address from edid_read() callback
>   (with the FIXME from Jani that basically tells us to move this to
>   get_modes)

Same situation than sun4i here, except for the fact that it can handle
hotplug through an interrupt.

> - omapdrm clears CEC address from hpd_notify, but sets it from the
>   edid_read() callback with the same FIXME.

I think it's still broken there. It properly clears the physical address
when the sink is disconnected, but relies on someone calling get_modes
to set it again, which isn't guaranteed.

> - i915 sets CEC address from .detect_ctx callback

That one is vc4 minus the get_modes redundancy.

> So there is no uniformity too. Handling it from drm_bridge_connector() /
> get_modes might help, but that requires clearing one of TODO items.

There's no uniformity, but I guess both vc4 and i915 are much more
battle-tested than sun4i, omapdrm, or adv7511 might be, and they both
behave pretty much the same.

Generally speaking (and it might be sad), but i915 is what userspace
expects, so it's usually what we want to follow.

Maxime

--b6qlvgiljxtj67ge
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZqIZ7gAKCRAnX84Zoj2+
dmCZAX4lgvUboI+YH0rV/NbXD4Z3iTPhdgXyvG3Uma1JXtxpABkJA50aYctkf2q7
Ug28AW8BfRdMmFiFtKkRuvFXPxGR+abCeAtqk1DlYxO9xOOLiYF/4jfAoDpnSk2j
xPJ8Huz4+g==
=LCTB
-----END PGP SIGNATURE-----

--b6qlvgiljxtj67ge--

