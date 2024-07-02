Return-Path: <linux-kernel+bounces-237841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96F7F923EDA
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 15:25:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB6161C22329
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 13:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40F621B47D0;
	Tue,  2 Jul 2024 13:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EM2vpMSV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50FAF19AD86;
	Tue,  2 Jul 2024 13:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719926708; cv=none; b=c24TMXyLEEDNxFE8UaJoTM/CpC9zip6PyiQ7E96xzu6yOSXoT6ux1TAzXEI6pwBv1CLwWbDqxeTEe6dD04Ge+MZySEcz5iiFNy2yEAUHDCajt7RRa3wJzCmPfsjJR9MRNvvf8RRCzU8FQNRpz62ww2dkfRfiGxwpDC5qtMMe0l8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719926708; c=relaxed/simple;
	bh=XjTXfbCIQa36KxnEEDVA+79Iy+FVRaew9MxgzaZrNtk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BKBp5F2UMcH7rpSQzgmEus5OQEWlDUDtzqo1njLJVb/S/ZGU3mmJaGlzkNiGQ3LeggcLv2HCN6bkD8WZOz/ojdKSQSMZf/uwJORAWZiB5YKjTpq5IKt/gpXPDzMhLzGrNM7yniqdJeCu99O7H1eUgdashY8bF2Ou0cIy7J0agcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EM2vpMSV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48C92C116B1;
	Tue,  2 Jul 2024 13:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719926707;
	bh=XjTXfbCIQa36KxnEEDVA+79Iy+FVRaew9MxgzaZrNtk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EM2vpMSV2xc/Ui/s6I2JoLMw6Ds1fRhwJIKAyvESfSAY39QHKIP3oQ1FBMDZVBgaY
	 A3ZxoBQUvrdPT+cAmx4KpgUyagAFmm6NZVKie4xtDvTnnTHU+vkCgHUpWFlfQH428X
	 GMjTYM6yGERdRrDRxz0nkjX8kPLWvU7+RIpvu9NDrssP34XTVJ0r5CLG3AfK+4fgY/
	 1R5oDTcLB6zpgeutF+iOsp+yLYY2wxgPo8iRW0YYeuDwMNPEHngQ49nO+AzBphHaS6
	 k49poiv9D33hvuCpMEecqEogN+rGxjUJyqE3CUpev+NJMUl5g8IXtgpVyUKr5h3xPj
	 g3APSbpiQKoug==
Date: Tue, 2 Jul 2024 15:25:04 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Sandor Yu <Sandor.yu@nxp.com>
Cc: dmitry.baryshkov@linaro.org, andrzej.hajda@intel.com, 
	neil.armstrong@linaro.org, Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se, 
	jernej.skrabec@gmail.com, airlied@gmail.com, daniel@ffwll.ch, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com, 
	vkoul@kernel.org, dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org, 
	kernel@pengutronix.de, linux-imx@nxp.com, oliver.brown@nxp.com, 
	alexander.stein@ew.tq-group.com, sam@ravnborg.org
Subject: Re: [PATCH v16 4/8] drm: bridge: Cadence: Add MHDP8501 DP/HDMI driver
Message-ID: <20240702-quartz-salamander-of-culture-eec264@houat>
References: <cover.1719903904.git.Sandor.yu@nxp.com>
 <359914108b879e995d4a39de32a33310009f0fab.1719903904.git.Sandor.yu@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lqdlqrw2llhccm2m"
Content-Disposition: inline
In-Reply-To: <359914108b879e995d4a39de32a33310009f0fab.1719903904.git.Sandor.yu@nxp.com>


--lqdlqrw2llhccm2m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

There's still the scrambler issue we discussed on v15, but I have some
more comments.

On Tue, Jul 02, 2024 at 08:22:36PM GMT, Sandor Yu wrote:
> +enum drm_connector_status cdns_mhdp8501_detect(struct cdns_mhdp8501_device *mhdp)
> +{
> +	u8 hpd = 0xf;
> +
> +	hpd = cdns_mhdp8501_read_hpd(mhdp);
> +	if (hpd == 1)
> +		return connector_status_connected;
> +	else if (hpd == 0)
> +		return connector_status_disconnected;
> +
> +	dev_warn(mhdp->dev, "Unknown cable status, hdp=%u\n", hpd);
> +	return connector_status_unknown;
> +}
> +
> +static void hotplug_work_func(struct work_struct *work)
> +{
> +	struct cdns_mhdp8501_device *mhdp = container_of(work,
> +						     struct cdns_mhdp8501_device,
> +						     hotplug_work.work);
> +	enum drm_connector_status status = cdns_mhdp8501_detect(mhdp);
> +
> +	drm_bridge_hpd_notify(&mhdp->bridge, status);
> +
> +	if (status == connector_status_connected) {
> +		/* Cable connected  */
> +		DRM_INFO("HDMI/DP Cable Plug In\n");
> +		enable_irq(mhdp->irq[IRQ_OUT]);
> +	} else if (status == connector_status_disconnected) {
> +		/* Cable Disconnected  */
> +		DRM_INFO("HDMI/DP Cable Plug Out\n");
> +		enable_irq(mhdp->irq[IRQ_IN]);
> +	}
> +}

You shouldn't play with the interrupt being enabled here: hotplug
interrupts should always enabled.

If you can't for some reason, the reason should be documented in your
driver.

> +	/* Mailbox protect for HDMI PHY access */
> +	mutex_lock(&mhdp->mbox_mutex);
> +	ret = phy_init(mhdp->phy);
> +	mutex_unlock(&mhdp->mbox_mutex);
> +	if (ret) {
> +		dev_err(dev, "Failed to initialize PHY: %d\n", ret);
> +		goto clk_disable;
> +	}
> +
> +	/* Mailbox protect for HDMI PHY access */
> +	mutex_lock(&mhdp->mbox_mutex);
> +	ret = phy_set_mode(mhdp->phy, phy_mode);
> +	mutex_unlock(&mhdp->mbox_mutex);
> +	if (ret) {
> +		dev_err(dev, "Failed to configure PHY: %d\n", ret);
> +		goto clk_disable;
> +	}

Why do you need a shared mutex between the phy and HDMI controller?

> +static enum drm_mode_status
> +cdns_hdmi_tmds_char_rate_valid(const struct drm_bridge *bridge,
> +			       const struct drm_display_mode *mode,
> +			       unsigned long long tmds_rate)
> +{
> +	struct cdns_mhdp8501_device *mhdp = bridge->driver_private;
> +	union phy_configure_opts phy_cfg;
> +	int ret;
> +
> +	phy_cfg.hdmi.tmds_char_rate = tmds_rate;
> +
> +	/* Mailbox protect for HDMI PHY access */
> +	mutex_lock(&mhdp->mbox_mutex);
> +	ret = phy_validate(mhdp->phy, PHY_MODE_HDMI, 0, &phy_cfg);
> +	mutex_unlock(&mhdp->mbox_mutex);
> +	if (ret < 0)
> +		return MODE_CLOCK_RANGE;
> +
> +	return MODE_OK;
> +}
> +
> +static enum drm_mode_status
> +cdns_hdmi_bridge_mode_valid(struct drm_bridge *bridge,
> +			    const struct drm_display_info *info,
> +			    const struct drm_display_mode *mode)
> +{
> +	unsigned long long tmds_rate;
> +
> +	/* We don't support double-clocked and Interlaced modes */
> +	if (mode->flags & DRM_MODE_FLAG_DBLCLK ||
> +	    mode->flags & DRM_MODE_FLAG_INTERLACE)
> +		return MODE_BAD;
> +
> +	/* MAX support pixel clock rate 594MHz */
> +	if (mode->clock > 594000)
> +		return MODE_CLOCK_HIGH;

This needs to be in the tmds_char_rate_valid function

> +	if (mode->hdisplay > 3840)
> +		return MODE_BAD_HVALUE;
> +
> +	if (mode->vdisplay > 2160)
> +		return MODE_BAD_VVALUE;
> +
> +	tmds_rate = mode->clock * 1000ULL;
> +	return cdns_hdmi_tmds_char_rate_valid(bridge, mode, tmds_rate);

It will already be called by the core so this is redundant.

> +static void cdns_hdmi_bridge_atomic_enable(struct drm_bridge *bridge,
> +					   struct drm_bridge_state *old_state)
> +{
> +	struct cdns_mhdp8501_device *mhdp = bridge->driver_private;
> +	struct drm_atomic_state *state = old_state->base.state;
> +	struct drm_connector *connector;
> +	struct video_info *video = &mhdp->video_info;
> +	struct drm_crtc_state *crtc_state;
> +	struct drm_connector_state *conn_state;
> +	struct drm_display_mode *mode = &mhdp->mode;
> +	union phy_configure_opts phy_cfg;
> +	int ret;
> +
> +	connector = drm_atomic_get_new_connector_for_encoder(state,
> +							     bridge->encoder);
> +	if (WARN_ON(!connector))
> +		return;
> +
> +	mhdp->curr_conn = connector;
> +
> +	conn_state = drm_atomic_get_new_connector_state(state, connector);
> +	if (WARN_ON(!conn_state))
> +		return;
> +
> +	crtc_state = drm_atomic_get_new_crtc_state(state, conn_state->crtc);
> +	if (WARN_ON(!crtc_state))
> +		return;
> +
> +	video->color_fmt = conn_state->hdmi.output_format;
> +	video->bpc = conn_state->hdmi.output_bpc;
> +
> +	drm_mode_copy(&mhdp->mode, &crtc_state->adjusted_mode);

Why do you need a copy of all these fields? You should pass the
connector / bridge state around and not copy these fields.

> +	/* video mode check */
> +	if (mode->clock == 0 || mode->hdisplay == 0 || mode->vdisplay == 0)
> +		return;

This should be checked in atomic_check, but I'm pretty sure it's redundant.

> +	dev_dbg(mhdp->dev, "Mode: %dx%dp%d\n",
> +		mode->hdisplay, mode->vdisplay, mode->clock);
> +
> +	drm_atomic_helper_connector_hdmi_update_infoframes(connector, state);
> +
> +	/* Line swapping */
> +	cdns_mhdp_reg_write(&mhdp->base, LANES_CONFIG, 0x00400000 | mhdp->lane_mapping);
> +
> +	mhdp->hdmi.char_rate = drm_hdmi_compute_mode_clock(mode,
> +							   mhdp->video_info.bpc,
> +							   mhdp->video_info.color_fmt);

The TMDS char rate is already available in the connector_state so there
no need to recompute it.

> +	phy_cfg.hdmi.tmds_char_rate = mhdp->hdmi.char_rate;

And you shouldn't store a copy either.

> +	/* Mailbox protect for HDMI PHY access */
> +	mutex_lock(&mhdp->mbox_mutex);
> +	ret = phy_configure(mhdp->phy, &phy_cfg);
> +	mutex_unlock(&mhdp->mbox_mutex);
> +	if (ret) {
> +		dev_err(mhdp->dev, "%s: phy_configure() failed: %d\n",
> +			__func__, ret);
> +		return;
> +	}
> +
> +	cdns_hdmi_sink_config(mhdp);
> +
> +	ret = cdns_hdmi_ctrl_init(mhdp);
> +	if (ret < 0) {
> +		dev_err(mhdp->dev, "%s, ret = %d\n", __func__, ret);
> +		return;
> +	}
> +
> +	/* Config GCP */
> +	if (mhdp->video_info.bpc == 8)
> +		cdns_hdmi_disable_gcp(mhdp);
> +	else
> +		cdns_hdmi_enable_gcp(mhdp);
> +
> +	ret = cdns_hdmi_mode_config(mhdp, mode, &mhdp->video_info);
> +	if (ret < 0) {
> +		dev_err(mhdp->dev, "CDN_API_HDMITX_SetVic_blocking ret = %d\n", ret);
> +		return;
> +	}
> +}
> +
> +static int cdns_hdmi_bridge_clear_infoframe(struct drm_bridge *bridge,
> +					    enum hdmi_infoframe_type type)
> +{
> +	return 0;
> +}

Either implement it or don't, but an empty function is dead code.

> +static int cdns_hdmi_bridge_write_infoframe(struct drm_bridge *bridge,
> +					    enum hdmi_infoframe_type type,
> +					    const u8 *buffer, size_t len)
> +{
> +	struct cdns_mhdp8501_device *mhdp = bridge->driver_private;
> +
> +	switch (type) {
> +	case HDMI_INFOFRAME_TYPE_AVI:
> +		cdns_hdmi_config_infoframe(mhdp, 0, len, buffer, HDMI_INFOFRAME_TYPE_AVI);
> +		break;
> +	case HDMI_INFOFRAME_TYPE_SPD:
> +		cdns_hdmi_config_infoframe(mhdp, 1, len, buffer, HDMI_INFOFRAME_TYPE_SPD);
> +		break;
> +	case HDMI_INFOFRAME_TYPE_VENDOR:
> +		cdns_hdmi_config_infoframe(mhdp, 2, len, buffer, HDMI_INFOFRAME_TYPE_VENDOR);
> +		break;
> +	default:
> +		dev_dbg(mhdp->dev, "Unsupported infoframe type %x\n", type);
> +	}
> +
> +	return 0;
> +}
> +
> +static int cdns_hdmi_bridge_atomic_check(struct drm_bridge *bridge,
> +					 struct drm_bridge_state *bridge_state,
> +					 struct drm_crtc_state *crtc_state,
> +					 struct drm_connector_state *conn_state)
> +{
> +	return drm_atomic_helper_connector_hdmi_check(conn_state->connector, conn_state->state);
> +}

You should also call your mode_valid function here.

Maxime

--lqdlqrw2llhccm2m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZoP/rwAKCRDj7w1vZxhR
xbtMAPwOIZGKcI/rVzpcMiT2neBt5WGvMKV0jq/zloFZ/N14pwD/eob5WPgjeYWd
oweE8ti1ed438LG/cKON29OerGxdGw0=
=INSe
-----END PGP SIGNATURE-----

--lqdlqrw2llhccm2m--

