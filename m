Return-Path: <linux-kernel+bounces-536611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E15E2A4820C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 15:52:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07FA54248D9
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 14:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07BB623907E;
	Thu, 27 Feb 2025 14:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CRcHZMhe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2119623E23C;
	Thu, 27 Feb 2025 14:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740667197; cv=none; b=CNplnRTbDuiU3c19lYQ+r8G24rEchrjILFiAQuNOQgLoI5Vo4LF22s9n9t3O1AOh9G5jt3fym841M8o8nU2rowXYTuPMym4ZJtO2r3wjEUjhxsSL0Wzx4Uu0DcHalYDlr+OaCcZfHvBsBOSdEw2ulrV7/QAPkrFaoF5yn5naQgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740667197; c=relaxed/simple;
	bh=YeeTFH2ZS8NNOmOAQydfFuyWCzJ2Y1VT1iYWTjiGOj4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N5oEVvYXhZ0GQ0w5ZqVXYcrn/WkOelqPCbOmvOuHoGoag3f824yvPof3e4vSIjROc8FqqEK4VXU/qOrfS7sm2po/flraXDmRESk+pjJSC9PEbW/Cdt96qGNHFar/2p9uXzwhghR7RO7zXKEUt/I6ijEVVnivjToLnzc+jL8KT8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CRcHZMhe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23671C4CEDD;
	Thu, 27 Feb 2025 14:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740667195;
	bh=YeeTFH2ZS8NNOmOAQydfFuyWCzJ2Y1VT1iYWTjiGOj4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CRcHZMheGNmLLYbtEZzWezstF44M04/1PSLciKvBGZF5HAKCnwwQRhMjluHbXEKOb
	 NSmtkB5Ll7sMrT/okvTVUuGCH+WEkBsCdpja3LWxErFseXKn31scOpe8WaOse1+5jD
	 gyPl3ogFVtvjgbp8PpMD7XW6NfmUWpDgObSZZYUnfyJBjPzmh9zJ0jobkmEtGclibd
	 Y1S22GerO+bAGla1YyLN91T63i6V7m/YwpldH+uHoS4YPPmn3tjh02wVkH1qD/vAUK
	 BX/oPsxN0vZhlPF3dTjndqDh5hjDZuxEEQ6vMONtdzHzhFG2WNaFfb/PGXOlrxbKju
	 jwNvzAdSD6BSw==
Date: Thu, 27 Feb 2025 15:39:52 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Simona Vetter <simona@ffwll.ch>, Inki Dae <inki.dae@samsung.com>, 
	Jagan Teki <jagan@amarulasolutions.com>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Daniel Thompson <danielt@kernel.org>, 
	Andrzej Hajda <andrzej.hajda@intel.com>, Jonathan Corbet <corbet@lwn.net>, 
	Sam Ravnborg <sam@ravnborg.org>, Boris Brezillon <bbrezillon@kernel.org>, 
	Nicolas Ferre <nicolas.ferre@microchip.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	Claudiu Beznea <claudiu.beznea@tuxon.dev>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Paul Kocialkowski <contact@paulk.fr>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	=?utf-8?B?SGVydsOp?= Codina <herve.codina@bootlin.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Subject: Re: [PATCH v6 14/26] drm/bridge: add support for refcounted DRM
 bridges
Message-ID: <20250227-macho-convivial-tody-cea7dc@houat>
References: <20250206-hotplug-drm-bridge-v6-0-9d6f2c9c3058@bootlin.com>
 <20250206-hotplug-drm-bridge-v6-14-9d6f2c9c3058@bootlin.com>
 <20250207-ingenious-daffodil-dugong-51be57@houat>
 <20250210181252.5ee028d4@booty>
 <20250211-merciful-nyala-of-justice-a4fabb@houat>
 <20250226152813.4a1ad218@booty>
 <20250227-savvy-monumental-toucan-edffe2@houat>
 <20250227123143.54d4aa03@booty>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="2kfbsn3codjdgoyq"
Content-Disposition: inline
In-Reply-To: <20250227123143.54d4aa03@booty>


--2kfbsn3codjdgoyq
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v6 14/26] drm/bridge: add support for refcounted DRM
 bridges
MIME-Version: 1.0

On Thu, Feb 27, 2025 at 12:31:43PM +0100, Luca Ceresoli wrote:
> On Thu, 27 Feb 2025 10:32:20 +0100
> Maxime Ripard <mripard@kernel.org> wrote:
> > On Wed, Feb 26, 2025 at 03:28:13PM +0100, Luca Ceresoli wrote:
> > > On Tue, 11 Feb 2025 14:10:50 +0100
> > > Maxime Ripard <mripard@kernel.org> wrote: =20
> > > > On Mon, Feb 10, 2025 at 06:12:52PM +0100, Luca Ceresoli wrote: =20
> > > > > On Fri, 7 Feb 2025 12:47:51 +0100
> > > > > Maxime Ripard <mripard@kernel.org> wrote:
> > > > >    =20
> > > > > > > diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridg=
e.h
> > > > > > > index ad7ba444a13e5ecf16f996de3742e4ac67dc21f1..43cef0f6ccd36=
034f64ad2babfebea62db1d9e43 100644
> > > > > > > --- a/include/drm/drm_bridge.h
> > > > > > > +++ b/include/drm/drm_bridge.h
> > > > > > > @@ -31,6 +31,7 @@
> > > > > > >  #include <drm/drm_encoder.h>
> > > > > > >  #include <drm/drm_mode_object.h>
> > > > > > >  #include <drm/drm_modes.h>
> > > > > > > +#include <drm/drm_print.h>
> > > > > > > =20
> > > > > > >  struct device_node;
> > > > > > > =20
> > > > > > > @@ -863,6 +864,22 @@ struct drm_bridge {
> > > > > > >  	const struct drm_bridge_timings *timings;
> > > > > > >  	/** @funcs: control functions */
> > > > > > >  	const struct drm_bridge_funcs *funcs;
> > > > > > > +
> > > > > > > +	/**
> > > > > > > +	 * @container_offset: Offset of this struct within the cont=
ainer
> > > > > > > +	 * struct embedding it. Used for refcounted bridges to free=
 the
> > > > > > > +	 * embeddeing struct when the refcount drops to zero. Unuse=
d on
> > > > > > > +	 * legacy bridges.
> > > > > > > +	 */
> > > > > > > +	size_t container_offset;     =20
> > > > > >=20
> > > > > > This shouldn't be in there. You can create an intermediate stru=
cture and
> > > > > > store both pointers for the action to consume.   =20
> > > > >=20
> > > > > You mean to store container_offset + refcount + is_refcounted?   =
=20
> > > >=20
> > > > No, I meant for the private structure pointer and the drm_bridge
> > > > pointer. refcount should be in drm_bridge, and I think is_refcounted
> > > > should be dropped. =20
> > >=20
> > > Storing the container pointer instead of the offset is a good idea, it
> > > will allow to get rid of is_refcounted: drm_bridge_is_refcounted() can
> > > just return "container !=3D NULL" instead of "bridge->is_refcounted".=
 So
> > > far so good. =20
> >=20
> > Again, I don't think the whole is_refcounted thing is a good idea. Once
> > we have the right API, we should convert all bridges to the new
> > allocation and assume that they are refcounted.
>=20
> Ah, thanks for clarifying, now I understand the reason you'd remove
> is_refecounted while I didn't. In my plan it's for a transition phase
> where not all bridges are converted yet. I should have added a note
> about that, indeed.
>=20
> While I obviously think all bridges should be converted to dynamic
> lifetime, I'm not sure it can happen all in a single run, however.
> Converting bridges to refcounting is mostly easy, but before we should
> switch all bridge users to put the pointers they have, or the bridges
> will never be freed. But the users are more in number and harder to
> convert. However I still haven't tried a real conversion of all of
> them, so it I'm going to reconsider this after I'll have tried.

I mean, you're going to have that issue anyway. There's several calls
that can get a bridge to a consumer:

  - of_drm_find_bridge
  - drm_bridge_get_prev_bridge / drm_bridge_get_next_bridge
  - drm_bridge_chain_get_first_bridge
  - drm_for_each_bridge_in_chain
  - devm_drm_of_get_bridge
  - drmm_of_get_bridge

The last two are easy to deal with: just add an action that will put the
reference, and you're done. devm_drm_of_get_bridge() still is completely
broken and you should deprecate it as well, but the semantics are what
they are already so you're not going to break it more than it already
is.

For all the others though, you do change the semantics of the API, and
you will need to add drm_bridge_put or switch to drmm_of_get_bridge.

Also, is_refcounted doesn't really help. Your problem is that *callers*
might not give back the reference, but the way you set it is how you
allocate the provider.

Even assuming we're not doing the mass-conversion, how do you ensure
that you fixed all the callers that would use the bridge you just
converted?

> Generally speaking, would you be OK with having is_refcounted in a
> transition phase, or do you think we absolutely must convert all bridge
> drivers and users at once?

No, see above.

> > > I'm not sure about the intermediate struct you have in mind though.
> > >=20
> > > Do you mean:
> > >=20
> > > struct drm_bridge_pointers {
> > >     struct drm_bridge *bridge;
> > >     void              *container;
> > > }
> > >=20
> > > ? =20
> >=20
> > Yes
> >=20
> > > If that's what you mean, should it be embedded in drm_struct or
> > > allocated separately? =20
> >=20
> > Separately, but still as part of the bridge allocation function.
> >=20
> > > If you mean to embed that struct in drm_bridge, then I the drm_bridge
> > > pointer inside the intermediate struct would be useless.
> > >=20
> > > If instead you mean to embed it in drm_struct: I'm not sure I see much
>                         ^^^^^^^^^^^^^^^^^^^^^^^^^
> For the records, I (obviously?) meant "allocated separately" here.
>=20
> > > benefit except maybe not exposing the container pointer to drm_bridge
> > > users, but I see a drawbacks: at the last put we need to find the
> > > container pointer to free from a struct kref pointer, which can work
> > > only if the container pointer is in the same struct as struct kref. =
=20
> >=20
> > Yeah, that's true. Storing the container pointer in drm_bridge makes
> > sense to solve this.
>=20
> OK, so when moving the container pointer to drm_bridge, the
> drm_bridge_pointers struct will be left with the drm_bridge pointer
> only:
>=20
> struct drm_bridge_pointer {
>     struct drm_bridge *bridge;
> }
>=20
> So while it would work, I still don't see the added value. We'd have
> one more allocation, we'd need to free both structs at the same time
> (correct?) and drm_bridge_put_void() would have an extra indirection
> step:
>=20
>      static void drm_bridge_put_void(void *data)
>      {
>         struct drm_bridge_pointer *bridge_pointer =3D (struct drm_bridge_=
pointers *)data;
> 	struct drm_bridge *bridge =3D bridge_pointer->bridge;
>=20
> 	drm_bridge_put(bridge);
>      }
>=20
> Can you elaborate on the gain in having such struct, or point me to
> some code using the same pattern?

There's none, if we're going to have a single pointer it's not useful
indeed.

> > I'm still not sure why we need the container offset though: if we have a
> > bridge and container pointer, then the offset is bridge - container, so
> > there's no point in storing it, right?
>=20
> We need either the container_offset or the container pointer, not both.
> I had chosen the offset in v6, I'm going to convert to the pointer in
> v7.

Sounds good

Maxime

--2kfbsn3codjdgoyq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZ8B5OAAKCRAnX84Zoj2+
diwkAX0fAul0N84x9BXCKZFKThWNvSe+QKekTxks6Qt8WDKv5/nOS0pSnZkGwEoY
oljSzRYBfiFM6ejt4tnT9AXPE8zmpP+4bmwlFQibqbNlXf5GpaKRJiwrsWOFKmwx
3UtfIm9ODA==
=qyvw
-----END PGP SIGNATURE-----

--2kfbsn3codjdgoyq--

