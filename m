Return-Path: <linux-kernel+bounces-326503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F345997692D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 14:30:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59C31B21539
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 12:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 530A31A4F1A;
	Thu, 12 Sep 2024 12:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E7YnRWng"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C8F41A4E8A;
	Thu, 12 Sep 2024 12:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726144204; cv=none; b=IhfSbvTRKi4sO4IOWS81JKShwOM9MnHrGxB0CRd/VNjrgC6KmXO+iivrxvXQ1EZc6eJUWF6+LbsAbch3yjr76LjTpRilB+S7ctzUZXRLWYoSyyzE51hBHRpyqN7diWOV1PRPFIzjDRAhhYiDPSMcc5ygR+RhSlxDIeP1I1dbfSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726144204; c=relaxed/simple;
	bh=rC/IckTRtEJyVb/IPxL3i6IwaLij7O4xfaquM3pJMDk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ELoKoASLzeElIVxVoTrGQnN7eAT+DJBxpyl9eyOfXi11rrL/ftkKBLIKbbB2k6sTQFAddXRUmuuK431lQiKqvS1sJ/gokeIFYZSeJWHxXTIOW3KAwsA2kh4je019HicfA1h2Jj48JZCAx5MNpbzMzfjFxH7aCk9Jhv4y+q26ODk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E7YnRWng; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70790C4CEC3;
	Thu, 12 Sep 2024 12:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726144203;
	bh=rC/IckTRtEJyVb/IPxL3i6IwaLij7O4xfaquM3pJMDk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E7YnRWngPdl7KimbKVKa9bfMIjdAle664Knyo4Bbtiq2AkZqgPOTm5msSZxb8YhIV
	 ZsqOEvPWtuiVPHqowVxaTngDirlCS6LqggKG0WU1TFDVMAXF7rk7LST/9E/K+1Ghbh
	 gq8tJC57+lAup85+uEXpJBqffumtKICsSlOvZcOmLHAJHTwvl+LimWuOMCidPug4E7
	 kHrugplzgV1v7cHBxt/KQul1SibQ//JezQpJ0h1/mVUf+lJwIFoyjQ7DJv3u/NR3tv
	 RffNAI++IDpMDS1ejqdI5ihr513LFUieJfurvinbi336AcXQ8X8Oh0xyi+/AKUGOoR
	 Fi6eASeCMs+xw==
Date: Thu, 12 Sep 2024 14:30:01 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Sandor Yu <sandor.yu@nxp.com>
Cc: "dmitry.baryshkov@linaro.org" <dmitry.baryshkov@linaro.org>, 
	"andrzej.hajda@intel.com" <andrzej.hajda@intel.com>, "neil.armstrong@linaro.org" <neil.armstrong@linaro.org>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, "jonas@kwiboo.se" <jonas@kwiboo.se>, 
	"jernej.skrabec@gmail.com" <jernej.skrabec@gmail.com>, "airlied@gmail.com" <airlied@gmail.com>, 
	"daniel@ffwll.ch" <daniel@ffwll.ch>, "robh+dt@kernel.org" <robh+dt@kernel.org>, 
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>, "shawnguo@kernel.org" <shawnguo@kernel.org>, 
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>, 
	"vkoul@kernel.org" <vkoul@kernel.org>, 
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>, "kernel@pengutronix.de" <kernel@pengutronix.de>, 
	dl-linux-imx <linux-imx@nxp.com>, Oliver Brown <oliver.brown@nxp.com>, 
	"alexander.stein@ew.tq-group.com" <alexander.stein@ew.tq-group.com>, "sam@ravnborg.org" <sam@ravnborg.org>
Subject: Re: [EXT] Re: [PATCH v16 4/8] drm: bridge: Cadence: Add MHDP8501
 DP/HDMI driver
Message-ID: <20240912-zippy-mongoose-of-domination-2ebc1d@houat>
References: <cover.1719903904.git.Sandor.yu@nxp.com>
 <359914108b879e995d4a39de32a33310009f0fab.1719903904.git.Sandor.yu@nxp.com>
 <20240702-quartz-salamander-of-culture-eec264@houat>
 <PAXPR04MB94480AB0490BBF00D2BA17BBF4932@PAXPR04MB9448.eurprd04.prod.outlook.com>
 <20240903-gay-capable-hound-3cbef2@houat>
 <PAXPR04MB9448EF507CB5C18A43239A80F49E2@PAXPR04MB9448.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="vicghtzdcgvwj5cg"
Content-Disposition: inline
In-Reply-To: <PAXPR04MB9448EF507CB5C18A43239A80F49E2@PAXPR04MB9448.eurprd04.prod.outlook.com>


--vicghtzdcgvwj5cg
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 06, 2024 at 02:50:08AM GMT, Sandor Yu wrote:
> > On Tue, Sep 03, 2024 at 06:07:25AM GMT, Sandor Yu wrote:
> > > > -----Original Message-----
> > > > From: dri-devel <dri-devel-bounces@lists.freedesktop.org> On Behalf
> > > > Of Maxime Ripard
> > > > Sent: 2024=E5=B9=B47=E6=9C=882=E6=97=A5 21:25
> > > > To: Sandor Yu <sandor.yu@nxp.com>
> > > > Cc: dmitry.baryshkov@linaro.org; andrzej.hajda@intel.com;
> > > > neil.armstrong@linaro.org; Laurent Pinchart
> > > > <laurent.pinchart@ideasonboard.com>; jonas@kwiboo.se;
> > > > jernej.skrabec@gmail.com; airlied@gmail.com; daniel@ffwll.ch;
> > > > robh+dt@kernel.org; krzysztof.kozlowski+dt@linaro.org;
> > > > shawnguo@kernel.org; s.hauer@pengutronix.de; festevam@gmail.com;
> > > > vkoul@kernel.org; dri-devel@lists.freedesktop.org;
> > > > devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> > > > linux-kernel@vger.kernel.org; linux-phy@lists.infradead.org;
> > > > kernel@pengutronix.de; dl-linux-imx <linux-imx@nxp.com>; Oliver
> > > > Brown <oliver.brown@nxp.com>; alexander.stein@ew.tq-group.com;
> > > > sam@ravnborg.org
> > > > Subject: [EXT] Re: [PATCH v16 4/8] drm: bridge: Cadence: Add
> > > > MHDP8501 DP/HDMI driver
> > > >
> > > > Hi,
> > > >
> > > > There's still the scrambler issue we discussed on v15, but I have
> > > > some more comments.
> > > >
> > > > On Tue, Jul 02, 2024 at 08:22:36PM GMT, Sandor Yu wrote:
> > > > > +enum drm_connector_status cdns_mhdp8501_detect(struct
> > > > > +cdns_mhdp8501_device *mhdp) {
> > > > > +	u8 hpd =3D 0xf;
> > > > > +
> > > > > +	hpd =3D cdns_mhdp8501_read_hpd(mhdp);
> > > > > +	if (hpd =3D=3D 1)
> > > > > +		return connector_status_connected;
> > > > > +	else if (hpd =3D=3D 0)
> > > > > +		return connector_status_disconnected;
> > > > > +
> > > > > +	dev_warn(mhdp->dev, "Unknown cable status, hdp=3D%u\n", hpd);
> > > > > +	return connector_status_unknown; }
> > > > > +
> > > > > +static void hotplug_work_func(struct work_struct *work) {
> > > > > +	struct cdns_mhdp8501_device *mhdp =3D container_of(work,
> > > > > +						     struct cdns_mhdp8501_device,
> > > > > +						     hotplug_work.work);
> > > > > +	enum drm_connector_status status =3D
> > cdns_mhdp8501_detect(mhdp);
> > > > > +
> > > > > +	drm_bridge_hpd_notify(&mhdp->bridge, status);
> > > > > +
> > > > > +	if (status =3D=3D connector_status_connected) {
> > > > > +		/* Cable connected  */
> > > > > +		DRM_INFO("HDMI/DP Cable Plug In\n");
> > > > > +		enable_irq(mhdp->irq[IRQ_OUT]);
> > > > > +	} else if (status =3D=3D connector_status_disconnected) {
> > > > > +		/* Cable Disconnected  */
> > > > > +		DRM_INFO("HDMI/DP Cable Plug Out\n");
> > > > > +		enable_irq(mhdp->irq[IRQ_IN]);
> > > > > +	}
> > > > > +}
> > > >
> > > > You shouldn't play with the interrupt being enabled here: hotplug
> > > > interrupts should always enabled.
> > > >
> > > > If you can't for some reason, the reason should be documented in yo=
ur
> > driver.
> > >
> > > iMX8MQ have two HPD interrupters, one for plugout and the other for
> > > plugin, because they could not be masked, so we have to enable one and
> > disable the other.
> > > I will add more comments here.
> >=20
> > Right, but why do you need to enable and disable them? Do you get spuri=
ous
> > interrupts?
>=20
> They don't have status registers and cannot be masked. If they are not di=
sabled,=20
> they will continuously generate interrupts. Therefore, I have to disable =
one and enable the other.

Sorry, I still don't get it. How can it be useful to detect hotplug
interrupts if it constantly sends spurious interrupts when it's enabled?

> > > > > +	/* Mailbox protect for HDMI PHY access */
> > > > > +	mutex_lock(&mhdp->mbox_mutex);
> > > > > +	ret =3D phy_init(mhdp->phy);
> > > > > +	mutex_unlock(&mhdp->mbox_mutex);
> > > > > +	if (ret) {
> > > > > +		dev_err(dev, "Failed to initialize PHY: %d\n", ret);
> > > > > +		goto clk_disable;
> > > > > +	}
> > > > > +
> > > > > +	/* Mailbox protect for HDMI PHY access */
> > > > > +	mutex_lock(&mhdp->mbox_mutex);
> > > > > +	ret =3D phy_set_mode(mhdp->phy, phy_mode);
> > > > > +	mutex_unlock(&mhdp->mbox_mutex);
> > > > > +	if (ret) {
> > > > > +		dev_err(dev, "Failed to configure PHY: %d\n", ret);
> > > > > +		goto clk_disable;
> > > > > +	}
> > > >
> > > > Why do you need a shared mutex between the phy and HDMI controller?
> > >
> > > Both PHY and HDMI controller could access to the HDMI firmware by
> > > mailbox, So add mutex to avoid race condition.
> >=20
> > That should be handled at either the phy or mailbox level, not in your =
hdmi
> > driver.
>
> In both HDMI driver and PHY driver, every mailbox access had protected
> by its owns mutex. However, this mutex can only protect each mailbox
> access within their respective drivers, and it cannot provide
> protection for access between the HDMI and PHY drivers.
>=20
> The PHY driver only provides two API functions, and these functions
> are only called in the HDMI driver. Therefore, when accessing these
> functions, we use a mutex to protect them. This ensures that mailbox
> access is protected across different PHY and HDMI drivers.

It's really about abstraction. You're using a publicly defined API, and
change the semantics for your driver only, and that's not ok.

Why can't the mailbox driver itself serialize the accesses from any
user, HDMI and PHY drivers included?

> > > >
> > > > > +static enum drm_mode_status
> > > > > +cdns_hdmi_tmds_char_rate_valid(const struct drm_bridge *bridge,
> > > > > +			       const struct drm_display_mode *mode,
> > > > > +			       unsigned long long tmds_rate) {
> > > > > +	struct cdns_mhdp8501_device *mhdp =3D bridge->driver_private;
> > > > > +	union phy_configure_opts phy_cfg;
> > > > > +	int ret;
> > > > > +
> > > > > +	phy_cfg.hdmi.tmds_char_rate =3D tmds_rate;
> > > > > +
> > > > > +	/* Mailbox protect for HDMI PHY access */
> > > > > +	mutex_lock(&mhdp->mbox_mutex);
> > > > > +	ret =3D phy_validate(mhdp->phy, PHY_MODE_HDMI, 0, &phy_cfg);
> > > > > +	mutex_unlock(&mhdp->mbox_mutex);
> > > > > +	if (ret < 0)
> > > > > +		return MODE_CLOCK_RANGE;
> > > > > +
> > > > > +	return MODE_OK;
> > > > > +}
> > > > > +
> > > > > +static enum drm_mode_status
> > > > > +cdns_hdmi_bridge_mode_valid(struct drm_bridge *bridge,
> > > > > +			    const struct drm_display_info *info,
> > > > > +			    const struct drm_display_mode *mode) {
> > > > > +	unsigned long long tmds_rate;
> > > > > +
> > > > > +	/* We don't support double-clocked and Interlaced modes */
> > > > > +	if (mode->flags & DRM_MODE_FLAG_DBLCLK ||
> > > > > +	    mode->flags & DRM_MODE_FLAG_INTERLACE)
> > > > > +		return MODE_BAD;
> > > > > +
> > > > > +	/* MAX support pixel clock rate 594MHz */
> > > > > +	if (mode->clock > 594000)
> > > > > +		return MODE_CLOCK_HIGH;
> > > >
> > > > This needs to be in the tmds_char_rate_valid function
> > > This clock rate check is covered by function tmds_char_rate_valid() It
> > > could be removed if keep function tmds_char_rate_valid() be called by
> > mode_valid.
> >=20
> > Yeah, it's not something you should have to duplicate.
> >=20
> > > >
> > > > > +	if (mode->hdisplay > 3840)
> > > > > +		return MODE_BAD_HVALUE;
> > > > > +
> > > > > +	if (mode->vdisplay > 2160)
> > > > > +		return MODE_BAD_VVALUE;
> > > > > +
> > > > > +	tmds_rate =3D mode->clock * 1000ULL;
> > > > > +	return cdns_hdmi_tmds_char_rate_valid(bridge, mode, tmds_rate);
> > > >
> > > > It will already be called by the core so this is redundant.
> > >
> > > mode_valid function is use to filter the mode list in
> > > drm_helper_probe_single_connector_modes(),
> > > if function cdns_hdmi_tmds_char_rate_valid() is not called, unsupport=
ed
> > modes will in mode list.
> >=20
> > It's probably something we should deal with in the core somehow. I'm not
> > entirely sure how to reconcile drm_bridge_connector and the hdmi
> > framework there, but we should at the very least provide a mode_valid
> > helper for bridges.
>
> I agree with that. In fact, I'm a bit confused about the current
> mode_valid and tmds_char_rate_valid functions. Ideally, we should find
> a way to make tmds_char_rate_valid also work for filtering out the
> mode list, rather than just during atomic_check.

Yeah, definitely. The way we did so on vc4 for example was to compute
the rate for a 8bpc, RGB, output and try to validate that. I think it
would be reasonable to start with that.

Maxime

--vicghtzdcgvwj5cg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZuLexQAKCRAnX84Zoj2+
dpXIAYDwp4QqM+gxv4Ut07NLWDuIpy7iJnl2M21sl17DQP9KmComIqPanJMDobep
InNhLfIBgKw7XRPw4mZGgL9zgnr5dsyvqyu4/lJnrajrzSPBSn1UjOZyoL6DRkcG
tk1OTY2CEg==
=PfXv
-----END PGP SIGNATURE-----

--vicghtzdcgvwj5cg--

