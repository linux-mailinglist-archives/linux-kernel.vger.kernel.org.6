Return-Path: <linux-kernel+bounces-336967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 065F298436D
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 12:18:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D20CB2794D
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 10:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B30F0176FB8;
	Tue, 24 Sep 2024 10:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e/XEEtun"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0FCC14885D;
	Tue, 24 Sep 2024 10:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727172991; cv=none; b=JzyEFSEHAa8KizcrdwpOs0YHYW9Ib/Zv/YDXwv4JPS/2AAKCmL3LYqeKIGBhdbMQulI+Qo2UFsLqz7V7H7c4v4u74FyAkKkASo0wDuQV34YsjIDhXZb1neXUn+l09eC4MQDIKtN1thqFpHSvfvqH94gsVwFkqX3xEBJPTiDhh7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727172991; c=relaxed/simple;
	bh=BIfBUYnZpf/ZbIfP5zMwi903n2DDlT4Z8VkDbMxBlx4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oKjzQFtyUx2mEJ65aM6T++EJwlg2FBxv+/aRSA1dismlP/3+kXds8fbshct5Xzky8XoHY0SWLmxeMZnxCNv0ZcWwUnvIM7GOzjAx1q6W6zJTenIT5jpd395J1gr2DAc+18wkBUA8ODgqF440OYKk0TWwDMGysp/n7O+mmhmuZ/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e/XEEtun; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AC32C4CEC4;
	Tue, 24 Sep 2024 10:16:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727172990;
	bh=BIfBUYnZpf/ZbIfP5zMwi903n2DDlT4Z8VkDbMxBlx4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e/XEEtun7n+xcrJRCsT9MSg8Idu+O8bc9THa6/VEHnvxOvfOU59/ePIm7qxbOi+X3
	 lsJ39YQKcU3uIkNLszNz6MW5XvRi+ShFkdBCLjV9ZVU7h02uj/pdwPeUN44GB3xSir
	 XziJBbr1XnkIGMG4/HdojdG9ux/nLeJ9xUd7yXzi5affi3PEE/wqZwbgZOGejtuf9W
	 oZo3FjbM8xqh30fUnfPelddFBm++prvDkYXzWx24tCIrl7R4qWiuSWyn4Q7F2aarQe
	 bM0SeKPjw72+1dHDMORFx1MIHitbFVM/mTvx2HDdpeWWx15v3AgyLKKyJFnhXhECpp
	 ZzocJHYLqnkrw==
Date: Tue, 24 Sep 2024 12:16:27 +0200
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
Subject: Re: [PATCH v17 4/8] drm: bridge: Cadence: Add MHDP8501 DP/HDMI driver
Message-ID: <20240924-mottled-psychedelic-lorikeet-ef8f4c@houat>
References: <cover.1727159906.git.Sandor.yu@nxp.com>
 <8bdf573bfd7e3feb45d7ccb53765a978a685ce2d.1727159906.git.Sandor.yu@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="ngfrob2xnxqm3qya"
Content-Disposition: inline
In-Reply-To: <8bdf573bfd7e3feb45d7ccb53765a978a685ce2d.1727159906.git.Sandor.yu@nxp.com>


--ngfrob2xnxqm3qya
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 24, 2024 at 03:36:49PM GMT, Sandor Yu wrote:
> +static int cdns_mhdp8501_read_hpd(struct cdns_mhdp8501_device *mhdp)
> +{
> +	u8 status;
> +	int ret;
> +
> +	mutex_lock(&mhdp_mailbox_mutex);
> +
> +	ret = cdns_mhdp_mailbox_send(&mhdp->base, MB_MODULE_ID_GENERAL,
> +				     GENERAL_GET_HPD_STATE, 0, NULL);
> +	if (ret)
> +		goto err_get_hpd;
> +
> +	ret = cdns_mhdp_mailbox_recv_header(&mhdp->base, MB_MODULE_ID_GENERAL,
> +					    GENERAL_GET_HPD_STATE,
> +					    sizeof(status));
> +	if (ret)
> +		goto err_get_hpd;
> +
> +	ret = cdns_mhdp_mailbox_recv_data(&mhdp->base, &status, sizeof(status));
> +	if (ret)
> +		goto err_get_hpd;
> +
> +	mutex_unlock(&mhdp_mailbox_mutex);

That's better I guess, but it's still not a good API design. If you
can't have concurrent accesses, then cdns_mhdp_mailbox_send et al.
should take the mutex themselves.

> +	return status;
> +
> +err_get_hpd:
> +	dev_err(mhdp->dev, "read hpd  failed: %d\n", ret);
> +	mutex_unlock(&mhdp_mailbox_mutex);
> +
> +	return ret;
> +}
> +
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

This is already logged, there's no need to add a message there.

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

You might want to log it using drm_dev_debug, but anything else is a big
stretch.

> +		enable_irq(mhdp->irq[IRQ_OUT]);
> +
> +		/* Reset HDMI/DP link with sink */
> +		if (mhdp->connector_type == DRM_MODE_CONNECTOR_HDMIA)
> +			cdns_hdmi_reset_link(mhdp);
> +		else
> +			cdns_dp_check_link_state(mhdp);
> +
> +	} else if (status == connector_status_disconnected) {
> +		/* Cable Disconnected  */
> +		DRM_INFO("HDMI/DP Cable Plug Out\n");
> +		enable_irq(mhdp->irq[IRQ_IN]);
> +	}
> +}
> +
> +static irqreturn_t cdns_mhdp8501_irq_thread(int irq, void *data)
> +{
> +	struct cdns_mhdp8501_device *mhdp = data;
> +
> +	disable_irq_nosync(irq);
> +
> +	mod_delayed_work(system_wq, &mhdp->hotplug_work,
> +			 msecs_to_jiffies(HOTPLUG_DEBOUNCE_MS));
> +
> +	return IRQ_HANDLED;
> +}

disable_irq_nosync doesn't guarantee that you won't be called before
interrupts are reenabled. What will happen if this handler is called
multiple times?

> +
> +static int cdns_mhdp8501_dt_parse(struct cdns_mhdp8501_device *mhdp,
> +				  struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct device_node *np = dev->of_node;
> +	struct device_node *remote;
> +
> +	remote = of_graph_get_remote_node(np, 1, 0);
> +	if (!remote) {
> +		dev_err(dev, "fail to get remote node\n");
> +		of_node_put(remote);
> +		return -EINVAL;
> +	}
> +
> +	/* get connector type */
> +	if (of_device_is_compatible(remote, "hdmi-connector")) {
> +		mhdp->connector_type = DRM_MODE_CONNECTOR_HDMIA;
> +
> +	} else if (of_device_is_compatible(remote, "dp-connector")) {
> +		mhdp->connector_type = DRM_MODE_CONNECTOR_DisplayPort;
> +
> +	} else {
> +		dev_err(dev, "Unknown connector type\n");
> +		of_node_put(remote);
> +		return -EINVAL;
> +	}
> +
> +	of_node_put(remote);
> +
> +	if (of_property_read_u32(np, "lane-mapping", &mhdp->lane_mapping)) {
> +		dev_warn(dev, "Failed to get lane_mapping - using default\n");

debug logging as well.

> +		mhdp->lane_mapping = LANE_MAPPING_FLIPPED;
> +	}
> +
> +	return true;
> +}
> +
> +static void cdns_mhdp8501_add_bridge(struct cdns_mhdp8501_device *mhdp)
> +{
> +	mhdp->bridge.type = mhdp->connector_type;
> +	mhdp->bridge.driver_private = mhdp;
> +	mhdp->bridge.of_node = mhdp->dev->of_node;
> +	mhdp->bridge.vendor = "NXP";
> +	mhdp->bridge.product = "i.MX8";
> +	mhdp->bridge.ops = DRM_BRIDGE_OP_DETECT | DRM_BRIDGE_OP_EDID |
> +			   DRM_BRIDGE_OP_HPD;
> +
> +	if (mhdp->connector_type == DRM_MODE_CONNECTOR_HDMIA) {
> +		mhdp->bridge.funcs = &cdns_hdmi_bridge_funcs;
> +		mhdp->bridge.ops |= DRM_BRIDGE_OP_HDMI;
> +	} else if (mhdp->connector_type == DRM_MODE_CONNECTOR_DisplayPort) {
> +		mhdp->bridge.funcs = &cdns_dp_bridge_funcs;
> +	} else {
> +		dev_err(mhdp->dev, "Unsupported connector type!\n");
> +		return;
> +	}

If this function can error out, then it should return an error code.

> +static int cdns_hdmi_scdc_write(struct cdns_mhdp8501_device *mhdp, u8 addr, u8 value)
> +{
> +	u8 msg[5], reg[5];
> +	int ret;
> +
> +	msg[0] = 0x54;
> +	msg[1] = addr;
> +	msg[2] = 0;
> +	msg[3] = 1;
> +	msg[4] = value;
> +
> +	mutex_lock(&mhdp_mailbox_mutex);
> +
> +	ret = cdns_mhdp_mailbox_send(&mhdp->base, MB_MODULE_ID_HDMI_TX, HDMI_TX_WRITE,
> +				     sizeof(msg), msg);
> +	if (ret)
> +		goto err_scdc_write;
> +
> +	ret = cdns_mhdp_mailbox_recv_header(&mhdp->base, MB_MODULE_ID_HDMI_TX,
> +					    HDMI_TX_WRITE, sizeof(reg));
> +	if (ret)
> +		goto err_scdc_write;
> +
> +	ret = cdns_mhdp_mailbox_recv_data(&mhdp->base, reg, sizeof(reg));
> +	if (ret)
> +		goto err_scdc_write;
> +
> +	if (reg[0] != 0)
> +		ret = -EINVAL;
> +
> +err_scdc_write:
> +
> +	mutex_unlock(&mhdp_mailbox_mutex);
> +
> +	if (ret)
> +		dev_err(mhdp->dev, "scdc write failed: %d\n", ret);
> +	return ret;
> +}

You should be using SCDC helpers there instead of hand crafting your
messages.

> +static void cdns_hdmi_sink_config(struct cdns_mhdp8501_device *mhdp)
> +{
> +	struct drm_display_info *display = &mhdp->curr_conn->display_info;
> +	struct drm_connector_state *conn_state = mhdp->curr_conn->state;

That looks a bit hackish to me. We should probably provide a helper to
get the connector state the bridge is attached to.

> +	struct drm_scdc *scdc = &mhdp->curr_conn->display_info.hdmi.scdc;
> +	u8 buff = 0;
> +
> +	/* check sink type (HDMI or DVI) */
> +	if (!display->is_hdmi) {
> +		mhdp->hdmi.hdmi_type = MODE_DVI;
> +		return;
> +	}
> +
> +	/* Default work in HDMI1.4 */
> +	mhdp->hdmi.hdmi_type = MODE_HDMI_1_4;
> +
> +	/* check sink support SCDC or not */
> +	if (!scdc->supported) {
> +		dev_info(mhdp->dev, "Sink Not Support SCDC\n");

drm_dev_debug

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
> +	ret = phy_validate(mhdp->phy, PHY_MODE_HDMI, 0, &phy_cfg);
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
> +	if (mode->hdisplay > 3840)
> +		return MODE_BAD_HVALUE;
> +
> +	if (mode->vdisplay > 2160)
> +		return MODE_BAD_VVALUE;
> +
> +	tmds_rate = mode->clock * 1000ULL;
> +	return cdns_hdmi_tmds_char_rate_valid(bridge, mode, tmds_rate);
> +}

Didn't we agree on creating a mode_valid helper?

> +static void cdns_hdmi_bridge_atomic_enable(struct drm_bridge *bridge,
> +					   struct drm_bridge_state *old_state)
> +{
> +	struct cdns_mhdp8501_device *mhdp = bridge->driver_private;
> +	struct drm_atomic_state *state = old_state->base.state;
> +	struct drm_connector *connector;
> +	struct video_info *video_info = &mhdp->video_info;
> +	struct drm_crtc_state *crtc_state;
> +	struct drm_connector_state *conn_state;
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
> +	video_info->color_fmt = conn_state->hdmi.output_format;
> +	video_info->bpc = conn_state->hdmi.output_bpc;
> +
> +	drm_atomic_helper_connector_hdmi_update_infoframes(connector, state);
> +
> +	/* Line swapping */
> +	cdns_mhdp_reg_write(&mhdp->base, LANES_CONFIG, 0x00400000 | mhdp->lane_mapping);
> +
> +	phy_cfg.hdmi.tmds_char_rate = conn_state->hdmi.tmds_char_rate;
> +
> +	ret = phy_configure(mhdp->phy, &phy_cfg);
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
> +		dev_err(mhdp->dev, "hdmi ctrl init failed = %d\n",  ret);
> +		return;
> +	}
> +
> +	/* Config GCP */
> +	if (video_info->bpc == 8)
> +		cdns_hdmi_disable_gcp(mhdp);
> +	else
> +		cdns_hdmi_enable_gcp(mhdp);
> +
> +	ret = cdns_hdmi_mode_config(mhdp, &crtc_state->adjusted_mode, video_info);
> +	if (ret < 0) {
> +		dev_err(mhdp->dev, "CDN_API_HDMITX_SetVic_blocking ret = %d\n", ret);
> +		return;
> +	}

If the only thing you're doing is filling video_info and passing it
there, why do you need that structure at all? Just pass the
connector_state pointer.

Maxime

--ngfrob2xnxqm3qya
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZvKRewAKCRAnX84Zoj2+
dpoOAYD41qitcYXB5WaMdorEwUm7B3ubdFEWIJEps105LfIzrWMMbfSkRtfZG7ni
fXXk8SYBgMPje3xq+wu1oHYlR5nIMZEmr1YqTY+lLWWiy6a3nQVA+V10Ot8XDfeS
fT+tUGPLEg==
=5ACm
-----END PGP SIGNATURE-----

--ngfrob2xnxqm3qya--

