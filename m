Return-Path: <linux-kernel+bounces-237782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E668B923E09
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 14:40:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9835828D6BE
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 12:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0A1C16A947;
	Tue,  2 Jul 2024 12:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rwjQ6HVu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F46823DE;
	Tue,  2 Jul 2024 12:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719924001; cv=none; b=TQiE7qrZdXa76xG1eIdA26toPOE3OaxZytk3F4HPBj6U3Il2n931/6nOAAIJ+MrnW8bm09lS3oAMEyyJTM2HWsRYp6J8G0gOLYfNVnGHBoJ7HqDHzQgFHMHjfgniKmX8NYEs3Of0GU+P11ERPWyRaB63p9bA/gcd0d/GW7PrQ0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719924001; c=relaxed/simple;
	bh=G4lrwOm8PBJDnOGCzEkhxC+Ha38BeZflLdrxWcXKBnM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DBxCFmeHWDW5fUz62zxRkrwOhu13M8McSqIEgM5yy/4Ft7bFUlhlpDVBeOvHLE/A8YCiRw9J+LTafDCW6CVxkASlGDVT0JL35Q1h94QS+WA18TL+aiNkRE00S6/jr38WiSoH5CiG7ggeVIcmGvHdP3y9WPYXvbVOkdzOO+WdMS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rwjQ6HVu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9379C2BD10;
	Tue,  2 Jul 2024 12:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719924001;
	bh=G4lrwOm8PBJDnOGCzEkhxC+Ha38BeZflLdrxWcXKBnM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rwjQ6HVugtneW0zEDQh2DOGLqh/YDpFk5SsPlLV3JbU74z3nTMKyEJ/emzLvEzFh9
	 pKNW9MRtdBvly3m1k9QNn7gVYamGu9uxV4xSMJCYzJXatRyCvKTtAs55uTryWhy5cs
	 9nG6RDyRrT7h5KYD9We4nUCvpBiWwwxtEj7umJHvdD6qzdQKiQxnqn/Y8YCLHY/0NC
	 dNcdlXyStmPdpi1O2expbN5C2PfHqosWCtrRBBUXkuEljiIcw4e6zy3vBjUkZRmFs2
	 NPt3g+cAdKeqt689Oiz2mlq9VlufZS2MTa1BPuvz4ga9uihPEsqcoN7oLIOOFQx005
	 KupHQdPmkLNKw==
Date: Tue, 2 Jul 2024 14:39:58 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Sandor Yu <sandor.yu@nxp.com>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>, 
	Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Robert Foss <rfoss@kernel.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, 
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>, 
	"imx@lists.linux.dev" <imx@lists.linux.dev>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux@ew.tq-group.com" <linux@ew.tq-group.com>
Subject: Re: [PATCH v15 4/8] drm: bridge: Cadence: Add MHDP8501 DP/HDMI driver
Message-ID: <20240702-seahorse-of-unreal-brotherhood-dce5d0@houat>
References: <20240306101625.795732-1-alexander.stein@ew.tq-group.com>
 <20240306101625.795732-5-alexander.stein@ew.tq-group.com>
 <20240306-mysterious-hoatzin-of-faith-49aec0@houat>
 <PAXPR04MB9448829F4BA8F8AF18F371F3F4DC2@PAXPR04MB9448.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3bvkkyl5thqxineu"
Content-Disposition: inline
In-Reply-To: <PAXPR04MB9448829F4BA8F8AF18F371F3F4DC2@PAXPR04MB9448.eurprd04.prod.outlook.com>


--3bvkkyl5thqxineu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jul 02, 2024 at 12:13:16PM GMT, Sandor Yu wrote:
> > Subject: [EXT] Re: [PATCH v15 4/8] drm: bridge: Cadence: Add MHDP8501
> > DP/HDMI driver
> >=20
> > Hi,
> >=20
> > On Wed, Mar 06, 2024 at 11:16:21AM +0100, Alexander Stein wrote:
> > > +static int cdns_mhdp8501_read_hpd(struct cdns_mhdp8501_device
> > *mhdp)
> > > +{
> > > +	u8 status;
> > > +	int ret;
> > > +
> > > +	mutex_lock(&mhdp->mbox_mutex);
> > > +
> > > +	ret =3D cdns_mhdp_mailbox_send(&mhdp->base,
> > MB_MODULE_ID_GENERAL,
> > > +				     GENERAL_GET_HPD_STATE, 0, NULL);
> > > +	if (ret)
> > > +		goto err_get_hpd;
> > > +
> > > +	ret =3D cdns_mhdp_mailbox_recv_header(&mhdp->base,
> > MB_MODULE_ID_GENERAL,
> > > +					    GENERAL_GET_HPD_STATE,
> > > +					    sizeof(status));
> > > +	if (ret)
> > > +		goto err_get_hpd;
> > > +
> > > +	ret =3D cdns_mhdp_mailbox_recv_data(&mhdp->base, &status,
> > sizeof(status));
> > > +	if (ret)
> > > +		goto err_get_hpd;
> > > +
> > > +	mutex_unlock(&mhdp->mbox_mutex);
> > > +
> > > +	return status;
> > > +
> > > +err_get_hpd:
> > > +	dev_err(mhdp->dev, "read hpd  failed: %d\n", ret);
> > > +	mutex_unlock(&mhdp->mbox_mutex);
> > > +
> > > +	return ret;
> > > +}
> > > +
> > > +enum drm_connector_status cdns_mhdp8501_detect(struct
> > > +cdns_mhdp8501_device *mhdp) {
> > > +	u8 hpd =3D 0xf;
> > > +
> > > +	hpd =3D cdns_mhdp8501_read_hpd(mhdp);
> > > +	if (hpd =3D=3D 1)
> > > +		return connector_status_connected;
> > > +	else if (hpd =3D=3D 0)
> > > +		return connector_status_disconnected;
> > > +
> > > +	dev_warn(mhdp->dev, "Unknown cable status, hdp=3D%u\n", hpd);
> > > +	return connector_status_unknown;
> > > +}
> > > +
> > > +static void hotplug_work_func(struct work_struct *work) {
> > > +	struct cdns_mhdp8501_device *mhdp =3D container_of(work,
> > > +						     struct cdns_mhdp8501_device,
> > > +						     hotplug_work.work);
> > > +	enum drm_connector_status status =3D cdns_mhdp8501_detect(mhdp);
> > > +
> > > +	drm_bridge_hpd_notify(&mhdp->bridge, status);
> > > +
> > > +	if (status =3D=3D connector_status_connected) {
> > > +		/* Cable connected  */
> > > +		DRM_INFO("HDMI/DP Cable Plug In\n");
> > > +		enable_irq(mhdp->irq[IRQ_OUT]);
> > > +	} else if (status =3D=3D connector_status_disconnected) {
> > > +		/* Cable Disconnected  */
> > > +		DRM_INFO("HDMI/DP Cable Plug Out\n");
> > > +		enable_irq(mhdp->irq[IRQ_IN]);
> > > +	}
> > > +}
> > > +
> > > +static irqreturn_t cdns_mhdp8501_irq_thread(int irq, void *data) {
> > > +	struct cdns_mhdp8501_device *mhdp =3D data;
> > > +
> > > +	disable_irq_nosync(irq);
> > > +
> > > +	mod_delayed_work(system_wq, &mhdp->hotplug_work,
> > > +			 msecs_to_jiffies(HOTPLUG_DEBOUNCE_MS));
> > > +
> > > +	return IRQ_HANDLED;
> > > +}
> >=20
> > AFAICT from the rest of the driver, you support HDMI modes with a chara=
cter
> > rate > 340Mchar/s, and thus you need to enable the scrambler.
> >=20
> > If you unplug/replug a monitor with the scrambler enabled though, and if
> > there's no userspace component to react to the userspace event, the cod=
e you
> > have here won't enable the scrambler again.
> >=20
> > You can test that by using modetest with a 4k@60Hz mode or something, a=
nd
> > then disconnecting / reconnecting the monitor.
> >=20
> > We addressed it in vc4 in commit 6bed2ea3cb38 ("drm/vc4: hdmi: Reset li=
nk
> > on hotplug").
> >=20
> > Arguably, the whole handling of the HDMI scrambling setup should be tur=
ned
> > into a helper, and I wanted to extend the work I've been doing around t=
he
> > HDMI infra to support the scrambler setup once it landed.
> >=20
>=20
> Yes, for userspace components that do not handle HPD events (such as
> modetest), if they are connected to a 4K display and enable scramble
> then the cable is unplugged/plugged, HDMI will not work. However, this
> is a userspace component limitation.

No, it's not.

I mean, yes, it's something the userspace *could* do. But it doesn't
have to, and the expectation is very much that the display keeps
working.

> fbdev and weston could work well for this case.

Yeah, they could work well. We don't want them to possibly work, we want
them to work, period. That's why amdgpu, i915 and vc4 all have that code.

> The patch for vc4 in commit 6bed2ea3cb38 ("drm/vc4: hdmi: Reset link
> on hotplug") assumes unplug/replug the same monitor as stated in its
> commit log.

Indeed.

> It does not support the case where unplug/plug to different displays.=20
> For example, if the cable is unplugged from a 4K monitor and then plugged=
 into a 1080p monitor,=20
> 4K video mode will be output to the 1080p monitor because this userspace =
component cannot respond to the monitor change.
> Therefore, for userspace components that do not handle HPD events (such a=
s modetest),=20
> this patch can only partially solve the limitation, but it is not a perfe=
ct solution.

You're looking at it from the wrong PoV. What matters is the behaviour
we offer from userspace. Userspace is in charge of setting the mode, and
it's expectation is that the mode is going to be output until it either
changes the mode or disables the display.

Reenabling the scrambler when a display is disconnected and reconnected
matches that expectation. If we ignore the case where the display has
changed, we still match that expectation: the userspace is in control of
the mode.

If it wants to react to monitors being unplugged, it can. But it doesn't
have to, and it should keep working as long as you don't change the
moniter / panel.

And you're also completely ignoring things like AV amplifiers that
really like to do those kind of short HPD pulses.

> If helper functions are used to restore the HDMI scramble bit after
> hotplug, I would like to use it.

Those helpers don't exist yet, so feel free to work on them.

Maxime

--3bvkkyl5thqxineu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZoP1HQAKCRDj7w1vZxhR
xdkwAP40UCWrNOV2VLiJyvMg4LRN4JC8s6714BNQ8fq8rI1Q2wD+LrtpkGVb424r
IxBXtjaaRMRF0KCaST36XTcm25I57Qc=
=5pfl
-----END PGP SIGNATURE-----

--3bvkkyl5thqxineu--

