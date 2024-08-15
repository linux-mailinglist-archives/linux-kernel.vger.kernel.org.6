Return-Path: <linux-kernel+bounces-287369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 947FE952710
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 02:37:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9A831C2166E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 00:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59ED34315D;
	Thu, 15 Aug 2024 00:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gqUNmqSE"
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 829263D96D
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 00:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723682082; cv=none; b=k+Xt0MGMGwga/oiuU9ZYJkUNAcnSzcUo19aznyqFmERVO9mvyVwqOovwcnfe+5VPYNP+nzkwjugrsSx8NTJi7Ml8IwlWsz0yecpoaWya0aBv6bIATNw6Uo6SBivK/gkJrdOIowgZRfpJMxktAFDsalvABuqQJ0o6qGqn/csjPiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723682082; c=relaxed/simple;
	bh=Iyhcfdfc7GV4MbeX+RfzehRh0ODkIdvP4CjwxtvYzHA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gSsMIakSFnowdz3p/1HliS6DxSGC7DktAq1LAxF8o7Y+9ZX+Oyww8X4Gbv+4TdzKrNW1BY77XcX8JfsvdzAKE1Z0kMjWlR8VJGAbFusJp7sBdmfFZBkNIGoFpdckcjLBAUjbw42F03CssjoJDB1kNjSq+sIRkow+Jb3hZ2X+3t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=gqUNmqSE; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-260f033fda3so295901fac.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 17:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1723682079; x=1724286879; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jDcmIdwmZg5Yjp+jQTQGuUvR4WKIJmLUFkwNG0Q1X0U=;
        b=gqUNmqSEJai6spJCJPMec6BIT4Da3epPyKxLdG/5tu1q5i0MVf0+WhS0EmJ4p3j3cj
         7C2RGvjKfnNQaTwazYBSTFUdGsJ6a3MZIUBNM6qmHZ6S/2uNlarJ5w6J08HNK2+hR/q8
         Jkh6jjm00KN5uMr4R87MDxCbzqcj+AJUgjOPA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723682079; x=1724286879;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jDcmIdwmZg5Yjp+jQTQGuUvR4WKIJmLUFkwNG0Q1X0U=;
        b=R/oG4DtMalsxLjX1AwK9yBE4NGAXAvAKLE5wfP045r014IvvbjWiOpytuIipqblQZx
         OyBnETSotBu+gjYGjBuXhO8iXny4Rpo1TaXE0z9hBLcS+eKhP0zDH+NldnIEvXE49tyr
         0mb8qXaZNP5Y9z1Sky2lqsfIVgnODiSIzzbF0zIKdZR3qDUAPcu7lLbIVqEhmPwv2FR6
         UyFCRuCF1Iqx9iDRGFtGN54es/AM585dq2rtshRsZxWyUup/cFOIZ2tau3Gh3NYPggGq
         MYwKc58hSrUhFAsEmTXHxUPv3zJunb0mWfwtOpedKRKg8+NPWb40Mqoe78krvL7QJd6w
         Q1JQ==
X-Gm-Message-State: AOJu0Yw+ZKPetCu2FukvyVCvL5qbJ00yCAhCg7CPgHtmQVUbKvjxa4nz
	uNhZU+lRouJlnfzHlJYQ5bI7IsTL9EVCUoRECPdUh4nfExYMD5KtIzHmNCoyEGwygJrjllsZw1Q
	=
X-Google-Smtp-Source: AGHT+IEa5nlUzRlmODvLmYrrPm9ojtXH+NSdKM66EPsw+jd1PQ0hfX1+/ZLc0IjHpFllU8vz6fMt4Q==
X-Received: by 2002:a05:6870:569e:b0:260:f058:48eb with SMTP id 586e51a60fabf-26fe5abd08bmr5594470fac.20.1723682079581;
        Wed, 14 Aug 2024 17:34:39 -0700 (PDT)
Received: from localhost (210.73.125.34.bc.googleusercontent.com. [34.125.73.210])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-7127aef6ed0sm154177b3a.137.2024.08.14.17.34.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Aug 2024 17:34:39 -0700 (PDT)
From: Stephen Boyd <swboyd@chromium.org>
To: chrome-platform@lists.linux.dev
Cc: linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	devicetree@vger.kernel.org,
	Douglas Anderson <dianders@chromium.org>,
	Pin-yen Lin <treapking@chromium.org>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Benson Leung <bleung@chromium.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Daniel Vetter <daniel@ffwll.ch>,
	David Airlie <airlied@gmail.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	dri-devel@lists.freedesktop.org,
	Guenter Roeck <groeck@chromium.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Lee Jones <lee@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Prashant Malani <pmalani@chromium.org>,
	Robert Foss <rfoss@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Tzung-Bi Shih <tzungbi@kernel.org>
Subject: [PATCH v2 09/11] platform/chrome: cros_ec_typec: Support DP muxing via DRM lane assignment
Date: Wed, 14 Aug 2024 17:34:14 -0700
Message-ID: <20240815003417.1175506-10-swboyd@chromium.org>
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
In-Reply-To: <20240815003417.1175506-1-swboyd@chromium.org>
References: <20240815003417.1175506-1-swboyd@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Most ARM based chromebooks with two usb-c-connector nodes and one DP
controller are muxing the DP lanes between the two USB ports. This is
done so that the type-c ports are at least equal in capability if not
functionality. Either an analog mux is used to steer the DP signal to
one or the other port, or a DP bridge chip has two lanes (DP ML0/ML1)
wired to one type-c port while the other two (DP ML2/ML3) are wired to
another type-c port.

Use drm_dp_typec_bridge_assign_pins() to implement support for DP
altmode configurations like pinconf D and DP muxing to different type-c
ports. In the DP altmode spec, pinconf C assigns all 4 SuperSpeed lanes
in the usb-c-connector node to DP, while pinconf D assigns 2 SuperSpeed
lanes to DP and 2 SuperSpeed lanes to USB. Use the 'data-lanes' property
from the input DP graph endpoint to calculate the maximum number of
lanes coming from the DP source (either 2 or 4) and limit the lanes
requested to the smaller of this or the pin configuration.

Use the 'data-lanes' property from the active type-c output port to
determine which logical DP lanes should be assigned to the output of the
drm_bridge by passing the lane mapping to
drm_dp_typec_bridge_assign_pins(). For now assume the type-c pins are in
the normal orientation.

The EC can mux the DP signal to any number of USB type-c ports. We only
need to make sure that the drm_bridge is mapping the DP lanes to the
appropriate type-c pins for the pin configuration. This means that
having the same type-c port data-lanes property is valid and expected in
cases where an analog mux is used to steer the DP signal to one of many
TCPCs and eventually usb-c-connector nodes.

Cc: Prashant Malani <pmalani@chromium.org>
Cc: Benson Leung <bleung@chromium.org>
Cc: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: <chrome-platform@lists.linux.dev>
Cc: Pin-yen Lin <treapking@chromium.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/platform/chrome/cros_ec_typec.c | 49 +++++++++++++++++++++++--
 drivers/platform/chrome/cros_ec_typec.h |  3 ++
 2 files changed, 49 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
index 5cbc6b3df906..fa7f7efb9d3f 100644
--- a/drivers/platform/chrome/cros_ec_typec.c
+++ b/drivers/platform/chrome/cros_ec_typec.c
@@ -27,6 +27,7 @@
 struct cros_typec_dp_bridge {
 	struct cros_typec_data *typec_data;
 	struct drm_dp_typec_bridge_dev *dev;
+	struct cros_typec_port *active_port;
 };
 
 #define DP_PORT_VDO	(DP_CONF_SET_PIN_ASSIGN(BIT(DP_PIN_ASSIGN_C) | BIT(DP_PIN_ASSIGN_D)) | \
@@ -330,6 +331,20 @@ static int cros_typec_register_port_altmodes(struct cros_typec_data *typec,
 	return 0;
 }
 
+static void cros_typec_init_dp_usbc_lanes(struct cros_typec_port *typec_port)
+{
+	struct cros_typec_data *typec = typec_port->typec_data;
+	unsigned int port_num = typec_port->port_num;
+	struct device *dev = typec->dev;
+	struct fwnode_handle *ep __free(fwnode_handle);
+	const u32 default_lane_mapping[] = { 0, 1, 2, 3 };
+
+	ep = fwnode_graph_get_endpoint_by_id(dev_fwnode(dev), 2, port_num, 0);
+	if (fwnode_property_read_u32_array(ep, "data-lanes", typec_port->lane_mapping,
+					   ARRAY_SIZE(typec_port->lane_mapping)))
+		memcpy(typec_port->lane_mapping, default_lane_mapping, sizeof(default_lane_mapping));
+}
+
 static int cros_typec_init_ports(struct cros_typec_data *typec)
 {
 	struct device *dev = typec->dev;
@@ -387,6 +402,7 @@ static int cros_typec_init_ports(struct cros_typec_data *typec)
 		typec->ports[port_num] = cros_port;
 		cap = &cros_port->caps;
 
+		cros_typec_init_dp_usbc_lanes(cros_port);
 		ret = cros_typec_parse_port_props(cap, fwnode, dev);
 		if (ret < 0)
 			goto unregister_ports;
@@ -434,6 +450,7 @@ static int cros_typec_init_dp_bridge(struct cros_typec_data *typec)
 	struct cros_typec_dp_bridge *dp_bridge;
 	struct fwnode_handle *ep __free(fwnode_handle);
 	struct drm_dp_typec_bridge_dev *dp_dev;
+	int num_lanes;
 	struct drm_dp_typec_bridge_desc desc = {
 		.of_node = dev->of_node,
 	};
@@ -450,6 +467,11 @@ static int cros_typec_init_dp_bridge(struct cros_typec_data *typec)
 	typec->dp_bridge = dp_bridge;
 	dp_bridge->typec_data = typec;
 
+	num_lanes = fwnode_property_count_u32(ep, "data-lanes");
+	if (num_lanes < 0)
+		num_lanes = 4;
+	desc.num_dp_lanes = num_lanes;
+
 	dp_dev = devm_drm_dp_typec_bridge_alloc(dev, &desc);
 	if (IS_ERR(dp_dev))
 		return PTR_ERR(dp_dev);
@@ -555,10 +577,12 @@ static int cros_typec_enable_dp(struct cros_typec_data *typec,
 				struct ec_response_usb_pd_control_v2 *pd_ctrl)
 {
 	struct cros_typec_port *port = typec->ports[port_num];
+	struct cros_typec_dp_bridge *dp_bridge = typec->dp_bridge;
 	struct typec_displayport_data dp_data;
 	u32 cable_tbt_vdo;
 	u32 cable_dp_vdo;
 	int ret;
+	bool hpd_asserted = port->mux_flags & USB_PD_MUX_HPD_LVL;
 
 	if (typec->pd_ctrl_ver < 2) {
 		dev_err(typec->dev,
@@ -566,6 +590,16 @@ static int cros_typec_enable_dp(struct cros_typec_data *typec,
 		return -ENOTSUPP;
 	}
 
+	/*
+	 * Assume the first port to have HPD asserted is the one muxed to DP
+	 * (i.e. active_port). When there's only one port this delays setting
+	 * the active_port until HPD is asserted, but before that the
+	 * drm_connector looks disconnected so active_port doesn't need to be
+	 * set.
+	 */
+	if (dp_bridge && hpd_asserted && !dp_bridge->active_port)
+		dp_bridge->active_port = port;
+
 	if (!pd_ctrl->dp_mode) {
 		dev_err(typec->dev, "No valid DP mode provided.\n");
 		return -EINVAL;
@@ -575,7 +609,7 @@ static int cros_typec_enable_dp(struct cros_typec_data *typec,
 	dp_data.status = DP_STATUS_ENABLED;
 	if (port->mux_flags & USB_PD_MUX_HPD_IRQ)
 		dp_data.status |= DP_STATUS_IRQ_HPD;
-	if (port->mux_flags & USB_PD_MUX_HPD_LVL)
+	if (hpd_asserted)
 		dp_data.status |= DP_STATUS_HPD_STATE;
 
 	/* Configuration VDO. */
@@ -587,6 +621,13 @@ static int cros_typec_enable_dp(struct cros_typec_data *typec,
 			return ret;
 	}
 
+	if (dp_bridge && dp_bridge->active_port == port) {
+		ret = drm_dp_typec_bridge_assign_pins(dp_bridge->dev, dp_data.conf, 0,
+						      port->lane_mapping);
+		if (ret)
+			return ret;
+	}
+
 	port->state.data = &dp_data;
 	port->state.mode = TYPEC_MODAL_STATE(ffs(pd_ctrl->dp_mode));
 
@@ -710,7 +751,7 @@ static int cros_typec_configure_mux(struct cros_typec_data *typec, int port_num,
 		ret = cros_typec_enable_tbt(typec, port_num, pd_ctrl);
 	} else if (dp_enabled) {
 		ret = cros_typec_enable_dp(typec, port_num, pd_ctrl);
-		if (dp_bridge) {
+		if (dp_bridge && dp_bridge->active_port == port) {
 			drm_dp_typec_bridge_notify(dp_bridge->dev,
 						   port->mux_flags & USB_PD_MUX_HPD_LVL ?
 						   connector_status_connected :
@@ -732,8 +773,10 @@ static int cros_typec_configure_mux(struct cros_typec_data *typec, int port_num,
 	}
 
 mux_ack:
-	if (dp_bridge && !dp_enabled)
+	if (dp_bridge && !dp_enabled && dp_bridge->active_port == port) {
 		drm_dp_typec_bridge_notify(dp_bridge->dev, connector_status_disconnected);
+		dp_bridge->active_port = NULL;
+	}
 
 	if (!typec->needs_mux_ack)
 		return ret;
diff --git a/drivers/platform/chrome/cros_ec_typec.h b/drivers/platform/chrome/cros_ec_typec.h
index 37c9a3ae3402..74d062dc03b2 100644
--- a/drivers/platform/chrome/cros_ec_typec.h
+++ b/drivers/platform/chrome/cros_ec_typec.h
@@ -14,6 +14,8 @@
 #include <linux/usb/typec_retimer.h>
 #include <linux/workqueue.h>
 
+#include <drm/bridge/aux-bridge.h>
+
 /* Supported alt modes. */
 enum {
 	CROS_EC_ALTMODE_DP = 0,
@@ -67,6 +69,7 @@ struct cros_typec_port {
 	uint8_t mux_flags;
 	uint8_t role;
 
+	u32 lane_mapping[NUM_USB_SS];
 	struct typec_altmode *port_altmode[CROS_EC_ALTMODE_MAX];
 
 	/* Flag indicating that PD partner discovery data parsing is completed. */
-- 
https://chromeos.dev


