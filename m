Return-Path: <linux-kernel+bounces-287370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99921952712
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 02:37:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56D65283D3B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 00:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B48638FA1;
	Thu, 15 Aug 2024 00:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="euA6L5P4"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F7F4084D
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 00:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723682083; cv=none; b=tfUtu7zaZgiyBphRX6Rv/tN7/6hnvMdsmMlRum1GDqcUoqa9mpC8YUkNK8huQ3V2Sy149xuWZIB3f1N6J6zgLgr1MhXZczai1CyQDejkCkqLh6n58DHhS+1MRnh6m1tJzg+aK4zHS19ueNTvkX9tyTVL4bZRuJAgq+indHdUi4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723682083; c=relaxed/simple;
	bh=zD9TsQUncAARnPnLMV9wmixLL+XTxWufmMdyanmITp8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uAN4vLN2uvxfqrgWQtPqfpHd1RCgvtX4cMUyiBhE0S/FNllf/TIpqbEy5C1qpf+7WhiYWj4m+ir372+IIDa0EKib3/OVKaftCqz+851X34tHZYrBn+BNtzsDdef/bfshkbTS0SJIywRiw1hVdwja0ZNzCrruVM1thV8coFaLCIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=euA6L5P4; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-712603f7ba5so311231b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 17:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1723682081; x=1724286881; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cBspZU3HeL7PY6QZuDg6iQx5V3y6UFV5ZGsLfhqF10c=;
        b=euA6L5P4Z3RDfXKdzNRtqrR/ggM2YipZE2nWoxogtce1QXUOj+Z4vvZt58dyV+YkjW
         vUz9Ps6ZLKs1H2WSehP2qZ+BPTPxmjTzXtslqi/h3A80edXzmgbPh5OKxiMVh+uVgSD1
         aBVvY3i31FtQTeVyXGidpy+R2P9uUMKVDz+qQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723682081; x=1724286881;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cBspZU3HeL7PY6QZuDg6iQx5V3y6UFV5ZGsLfhqF10c=;
        b=HvFJEc+E9DK+WzvN3fJhj5ddiBWNCFCHRsrT0ldiPSU5S8srTTr4GNVCLepQ0WS7y/
         MWfEXxn84+yZRgWlq2GqzxLe3ljFoixHyH70ccwIaqfrWZ+l95ZY6H5i01a5m/ioDVR7
         WXh3j2AqemesMIT7onWJnxm28J6ENvA5KgYQ4Zd+ofg6fKXgUG0BnZcBwdsL+WPxutZ4
         FwT2xb8Aky/Gp8RrF3i6Hf9AkhjVzi/hwQ0ghWwDRb9mvMXDgUoEzir7u70ljdLmHrzT
         iLyEciChsIhbDVEi2Q47N/kHqYeW/qzZg6ns87SvcyXiIINAIrmfMStwr1UggpVC00fX
         Fkyw==
X-Gm-Message-State: AOJu0Yx59+JHPzjDr6YFIbRDH4KhTtqbHyCT6Xh/hordA/btWjjotRku
	Dq+LIZYoC807OFqWG39wLhmsiaA05JREQbZJ7MDYroQYH72w96Q4xlGgGi3UfQ==
X-Google-Smtp-Source: AGHT+IF3toalk+6TfBGNRbLO8JKuCUY5aMyE+LAw0Xw9EDSvJ2wZkjR8HAHNKQxh/Te6Kdy5uE3aKw==
X-Received: by 2002:a05:6a00:3c84:b0:70d:1b17:3c5e with SMTP id d2e1a72fcca58-712670e8640mr6076731b3a.6.1723682081340;
        Wed, 14 Aug 2024 17:34:41 -0700 (PDT)
Received: from localhost (210.73.125.34.bc.googleusercontent.com. [34.125.73.210])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-7127ae11b3csm157292b3a.71.2024.08.14.17.34.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Aug 2024 17:34:40 -0700 (PDT)
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
Subject: [PATCH v2 10/11] platform/chrome: cros_ec_typec: Support DP orientation
Date: Wed, 14 Aug 2024 17:34:15 -0700
Message-ID: <20240815003417.1175506-11-swboyd@chromium.org>
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

Handle orientation for the type-c port when the DT node has the
'orientation' property. The 'orientation' property is present when the
DisplayPort lanes are directly wired to the usb-c-connector and the
board design relies on the DP lanes to be remapped by software. The
property wouldn't be present if, for example, the EC controls a port
mapper part that flips the DP lanes for the port orientation.

Pass the port orientation to drm_dp_typec_bridge_assign_pins() when the
DT property is present so that the previous drm_bridge in the bridge
chain can remap the DP lanes to the right usb-c-connector SuperSpeed
pins for the orientation.

Cc: Prashant Malani <pmalani@chromium.org>
Cc: Benson Leung <bleung@chromium.org>
Cc: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: <chrome-platform@lists.linux.dev>
Cc: Pin-yen Lin <treapking@chromium.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/platform/chrome/cros_ec_typec.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
index fa7f7efb9d3f..9b54b3288f5f 100644
--- a/drivers/platform/chrome/cros_ec_typec.c
+++ b/drivers/platform/chrome/cros_ec_typec.c
@@ -28,6 +28,7 @@ struct cros_typec_dp_bridge {
 	struct cros_typec_data *typec_data;
 	struct drm_dp_typec_bridge_dev *dev;
 	struct cros_typec_port *active_port;
+	bool orientation;
 };
 
 #define DP_PORT_VDO	(DP_CONF_SET_PIN_ASSIGN(BIT(DP_PIN_ASSIGN_C) | BIT(DP_PIN_ASSIGN_D)) | \
@@ -449,13 +450,15 @@ static int cros_typec_init_dp_bridge(struct cros_typec_data *typec)
 	struct device *dev = typec->dev;
 	struct cros_typec_dp_bridge *dp_bridge;
 	struct fwnode_handle *ep __free(fwnode_handle);
+	struct fwnode_handle *devnode;
 	struct drm_dp_typec_bridge_dev *dp_dev;
 	int num_lanes;
 	struct drm_dp_typec_bridge_desc desc = {
 		.of_node = dev->of_node,
 	};
 
-	ep = fwnode_graph_get_endpoint_by_id(dev_fwnode(dev), 0, 0, 0);
+	devnode = dev_fwnode(dev);
+	ep = fwnode_graph_get_endpoint_by_id(devnode, 0, 0, 0);
 	if (!ep) {
 		/* There isn't a DP input endpoint. Ignore. */
 		return 0;
@@ -467,6 +470,8 @@ static int cros_typec_init_dp_bridge(struct cros_typec_data *typec)
 	typec->dp_bridge = dp_bridge;
 	dp_bridge->typec_data = typec;
 
+	dp_bridge->orientation = fwnode_property_read_bool(devnode, "orientation");
+
 	num_lanes = fwnode_property_count_u32(ep, "data-lanes");
 	if (num_lanes < 0)
 		num_lanes = 4;
@@ -582,6 +587,7 @@ static int cros_typec_enable_dp(struct cros_typec_data *typec,
 	u32 cable_tbt_vdo;
 	u32 cable_dp_vdo;
 	int ret;
+	enum typec_orientation orientation;
 	bool hpd_asserted = port->mux_flags & USB_PD_MUX_HPD_LVL;
 
 	if (typec->pd_ctrl_ver < 2) {
@@ -622,7 +628,13 @@ static int cros_typec_enable_dp(struct cros_typec_data *typec,
 	}
 
 	if (dp_bridge && dp_bridge->active_port == port) {
-		ret = drm_dp_typec_bridge_assign_pins(dp_bridge->dev, dp_data.conf, 0,
+		orientation = TYPEC_ORIENTATION_NORMAL;
+		if (dp_bridge->orientation &&
+		    port->mux_flags & USB_PD_MUX_POLARITY_INVERTED)
+			orientation = TYPEC_ORIENTATION_REVERSE;
+
+		ret = drm_dp_typec_bridge_assign_pins(dp_bridge->dev, dp_data.conf,
+						      orientation,
 						      port->lane_mapping);
 		if (ret)
 			return ret;
-- 
https://chromeos.dev


