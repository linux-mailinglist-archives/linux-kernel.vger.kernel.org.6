Return-Path: <linux-kernel+bounces-310948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E43B996832B
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 11:26:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94C45280198
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 09:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43ECA1C32F1;
	Mon,  2 Sep 2024 09:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aRhyJh5U"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 855FC186287
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 09:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725269174; cv=none; b=sl3UGZvjnQkUE3uTMhvInrlbKFG18BwlFanic3xM012LZYrdak/OJQA13S5yzp+JewY2Bej7CmUWJzPkkgWZNNlTXebpqLqDDoRuLPQCEoLsP0esyYy32wAXbTNbqOwc8Wv+JCC45dEbuv934ePpBoelndoeXNzTK/Ms0xEW6fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725269174; c=relaxed/simple;
	bh=sTMVp/PlQaTLYPI7C29zRBRlIvVnGTN2r5Vf6SvpLlQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GsgAaeNcS47GaXP0TbTI6Z1UDrmImZMJF2TsTMfk3gY1U3cHv4NBWYebJ5VfefLvv/quQgOnIXwFxoabv+E8XmVHyShTqSW9rXsS/+T+LiQ4XOv/uazPeIENDhubi81Zg/56zXDZ0uA9j1PhjZ6z3T0kbD9mrlpHAjzgOlrIwPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aRhyJh5U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C15E0C4CEC2;
	Mon,  2 Sep 2024 09:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725269174;
	bh=sTMVp/PlQaTLYPI7C29zRBRlIvVnGTN2r5Vf6SvpLlQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aRhyJh5U5+0ITuy0LZyPBbTxEhnBFUdwQBxCu2N73+hAlybvhOduiC71m6QzRwA2T
	 9a2sTDjKQ3pfkTl3ujwbqBT3OXN8RS0Vp6wGagqQvmkFTregaWmIxIzNr99LuNO5lC
	 Fmba6HybWjIZYmy5jMBFp9I012cLJr5UaNNMpUr7St43scdMi3u9uJxULzgmeznwxM
	 NvVyJ0ZAqVDBUh5d8UrJG6Mv8G7lNdyvVgyNyt22Dhr9dq98UuzeZK4xSg2tBKbX5+
	 vHGxRcJ9wcwDER6bgYyqk4/NXVOXwea7AVn5tAD27ACLNTUIVtAO1G4VQ2DzThsNAx
	 IASQXU0oO5CcA==
Date: Mon, 2 Sep 2024 11:26:11 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/mipi-dsi: Fix devm unregister & detach
Message-ID: <20240902-refined-smooth-mammoth-fbee81@houat>
References: <20240619-dsi-devres-fix-v1-1-a5c59310a52e@ideasonboard.com>
 <20240626-gabby-ladybug-of-freedom-08e6eb@houat>
 <66ab4206-d1c8-4aad-99a7-c4c316e343a9@ideasonboard.com>
 <20240626-warping-nondescript-mustang-bfce27@houat>
 <b7cf71b8-76fd-4638-a7b6-cc8dbae635bf@ideasonboard.com>
 <20240702-bold-exotic-mamba-fdbba4@houat>
 <7293448e-e8cc-4522-b39c-5ad133e5f732@ideasonboard.com>
 <20240725-natural-giga-crane-d54067@houat>
 <4ed3791f-bc5a-46f1-88e1-2441c7f9c8d4@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="ryjmwhav26o25m53"
Content-Disposition: inline
In-Reply-To: <4ed3791f-bc5a-46f1-88e1-2441c7f9c8d4@ideasonboard.com>


--ryjmwhav26o25m53
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Aug 07, 2024 at 03:19:23PM GMT, Tomi Valkeinen wrote:
> On 25/07/2024 14:28, Maxime Ripard wrote:
> > On Mon, Jul 15, 2024 at 11:32:34AM GMT, Tomi Valkeinen wrote:
> > > On 02/07/2024 14:43, Maxime Ripard wrote:
> > > > Hi Tomi,
> > > >=20
> > > > On Wed, Jun 26, 2024 at 06:53:40PM GMT, Tomi Valkeinen wrote:
> > > > > On 26/06/2024 18:07, Maxime Ripard wrote:
> > > > > > On Wed, Jun 26, 2024 at 12:55:39PM GMT, Tomi Valkeinen wrote:
> > > > > > > On 26/06/2024 11:49, Maxime Ripard wrote:
> > > > > > > > Hi,
> > > > > > > >=20
> > > > > > > > On Wed, Jun 19, 2024 at 12:07:48PM GMT, Tomi Valkeinen wrot=
e:
> > > > > > > > > From: Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard=
=2Ecom>
> > > > > > > > >=20
> > > > > > > > > When a bridge driver uses devm_mipi_dsi_device_register_f=
ull() or
> > > > > > > > > devm_mipi_dsi_attach(), the resource management is moved =
to devres,
> > > > > > > > > which releases the resource automatically when the bridge=
 driver is
> > > > > > > > > unbound.
> > > > > > > > >=20
> > > > > > > > > However, if the DSI host goes away first, the host unregi=
stration code
> > > > > > > > > will automatically detach and unregister any DSI peripher=
als, without
> > > > > > > > > notifying the devres about it. So when the bridge driver =
later is
> > > > > > > > > unbound, the resources are released a second time, leadin=
g to crash.
> > > > > > > >=20
> > > > > > > > That's super surprising. mipi_dsi_device_unregister calls
> > > > > > > > device_unregister, which calls device_del, which in turn ca=
lls
> > > > > > > > devres_release_all.
> > > > > > >=20
> > > > > > > Hmm, right.
> > > > > > >=20
> > > > > > > > If that doesn't work like that, then it's what needs to be =
fixed, and
> > > > > > > > not worked around in the MIPI-DSI bus.
> > > > > > >=20
> > > > > > > Well, something causes a crash for both the device register/u=
nregister case
> > > > > > > and the attach/detach case, and the call stacks and debug pri=
nts showed a
> > > > > > > double unregister/detach...
> > > > > > >=20
> > > > > > > I need to dig up the board and check again why the devres_rel=
ease_all() in
> > > > > > > device_del() doesn't solve this. But I can probably only get =
back to this in
> > > > > > > August, so it's perhaps best to ignore this patch for now.
> > > > > > >=20
> > > > > > > However, the attach/detach case is still valid? I see no devr=
es calls in the
> > > > > > > detach paths.
> > > > > >=20
> > > > > > I'm not sure what you mean by the attach/detach case. Do you ex=
pect
> > > > > > device resources allocated in attach to be freed when detach ru=
n?
> > > > >=20
> > > > > Ah, never mind, the devres_release_all() would of course deal wit=
h that too.
> > > > >=20
> > > > > However, I just realized/remembered why it crashes.
> > > > >=20
> > > > > devm_mipi_dsi_device_register_full() and devm_mipi_dsi_attach() a=
re given a
> > > > > device which is used for the devres. This device is probably alwa=
ys the
> > > > > bridge device. So when the bridge device goes away, so do those r=
esources.
> > > > >=20
> > > > > The mipi_dsi_device_unregister() call deals with a DSI device, wh=
ich was
> > > > > created in devm_mipi_dsi_device_register_full(). Unregistering th=
at DSI
> > > > > device, which does happen when the DSI host is removed, does not =
affect the
> > > > > devres of the bridge.
> > > > >=20
> > > > > So, unloading the DSI host driver causes mipi_dsi_device_unregist=
er() and
> > > > > mipi_dsi_detach() to be called (as part of mipi_dsi_host_unregist=
er()), and
> > > > > unloading the bridge driver causes them to be called again via de=
vres.
> > > >=20
> > > > Sorry, that's one of the things I don't quite get. Both functions a=
re
> > > > exclusively(?) called from I2C bridges, so the device passed there
> > > > should be a i2c_client instance, and thus the MIPI-DSI host going a=
way
> > > > will not remove those i2c devices, only the MIPI-DSI ones, right?
> > >=20
> > > Yes.
> > >=20
> > > > So if we remove the host, the MIPI-DSI device will be detached and
> > > > removed through the path you were explaing with the i2c client ling=
ering
> > > > around. And if we remove the I2C device, then devm will kick in and=
 will
> > > > detach and remove the MIPI-DSI device.
> > >=20
> > > Right.
> > >=20
> > > > Or is it the other way around? That if you remove the host, the dev=
ice
> > > > is properly detached and removed, but there's still the devm actions
> > > > lingering around in the i2c device with pointers to the mipi_dsi_de=
vice
> > > > that was first created, but since destroyed?
> > > >=20
> > > > And thus, if the i2c device ever goes away, we get a use-after-free?
> > >=20
> > > Hmm, I'm not sure I understand what you mean here... Aren't you descr=
ibing
> > > the same thing in both of these cases?
> > >=20
> > > In any case, to expand the description a bit, module unloading is qui=
te
> > > fragile. I do get a crash if I first unload the i2c bridge module, an=
d only
> > > then go and unload the other ones in the DRM pipeline. But I think mo=
dule
> > > unloading will very easily crash, whatever the DRM drivers being used=
 are,
> > > so it's not related to this particular issue.
> > >=20
> > > In my view, the unload sequence that should be supported (for develop=
ment
> > > purposes, not for production) is to start the unload from the display
> > > controller module, which tears down the DRM pipeline, and going from =
there
> > > towards the panels/connectors.
> > >=20
> > > Of course, it would be very nice if the module unloading worked perfe=
ctly,
> > > but afaics fixing all that's related to module unloading would be a
> > > multi-year project... So, I just want to keep the sequence I describe=
d above
> > > working, which allows using modules while doing driver development.
> >=20
> > FTR, I'm all for supporting module unloading. The discussion above was
> > about what is broken exactly, so we can come up with a good solution.
>=20
> Does that mean that you're ok with the patch, or that something should be
> improved?

No, I meant that at the very least the commit log needs to be updated to
reflect what is actually going on, because at least my understanding of
it doesn't match what actually happens.

We want a solution to the problem you're facing, but it's not clear to
me what the problem is exactly at this point, so it's hard to review a
solution.

Maxime

--ryjmwhav26o25m53
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZtWEswAKCRAnX84Zoj2+
dqYWAYDMPWZSBEwFfMOv3MeoMjjbST7pAGaFb7GVqgJ2IsSq7NaN1ImJ2BxrXPYH
KEliCLMBfjPrZZcjvBkpvMSANpKsOasFN6I0WP1hifYShh1mIdLw7nK0hYmbUVCt
ql80NKzRBA==
=db07
-----END PGP SIGNATURE-----

--ryjmwhav26o25m53--

