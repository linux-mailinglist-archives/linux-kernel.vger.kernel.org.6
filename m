Return-Path: <linux-kernel+bounces-287362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 303BA952702
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 02:35:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 502E61C217C9
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 00:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26A47DF5C;
	Thu, 15 Aug 2024 00:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DOeZyHR6"
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C8318D641
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 00:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723682068; cv=none; b=Ni4bh020JC0xparacFILMA65LkMlVXKHBwNrBsqy8x3gEdSHELUM4N/PDtlAjmwNHfA/vdZac1QrRoOGSrG+xltqbXKdcxz7rv4DOnKRb/MZnxj5k0nW1WhTLqqt2bJ++/c3PYKvFs+hqfddDYj0dCWEVtXkpyHwZTdu+5BKJ90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723682068; c=relaxed/simple;
	bh=ahxFCtg/v93x1OwOq6O28bHFegCWP8HatZ1/V+oQ4yo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hR5IJlWRHbpIQFKUHJDqlChdCD8Bmf+zAN8+4S/3VdAGflO8Hj/1A0Jrhn2WOAnosts7iye6FcqElTKTUOcDt+0K+eyO7Pt17+NoAhsS+VlDRRaPqGMtr127XRyEnQb63G4Pxn5r9CfcDSPI6g4ql+QnMX3kcDUonNj9rRNQmuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=DOeZyHR6; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-260f057aa9bso314292fac.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 17:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1723682065; x=1724286865; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d8LFD02UwCQn/9JJcB/9igBsgy8I8NKOocEuza3szqI=;
        b=DOeZyHR62lYCrecFmEUldCLqq0VyVX+VfJzo6hSBGZ+7V7nl6hRCNPC1nuoX2OfqXM
         GXNtJIEQfkecHh9j/MsW5/SCw7oTNEJuAKjAymdWwP8Os5+kWhWiogAh4ZajxOgRFnBM
         UJQe3Uwgi32PEZywQ2+c+L5jrawaEB61J4e+k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723682065; x=1724286865;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d8LFD02UwCQn/9JJcB/9igBsgy8I8NKOocEuza3szqI=;
        b=MuTMmVEVjIzA+fxDQ2XYtJLjcvMIdQYZc52bAXDAQIz0RlpLS7UEftTk92jH6l9qBb
         avHS0e7hS42lOcbqBh7p7x09QO/caZ5Lh/OtatS/FXR/spo5DxmOUaKQqBNOX8FvhsEL
         AXU8/kJZxrQnwzzEh3xlHrhwAi6+bdmjiUoUp4eijGqgrIXDq7X60pQ//lhse12RWLYZ
         UtiNgVHxu57hFrBmJUNcmLdXNZz5ZPhpmdnS49SeJ3Ee5itnFNNHMvGIVPuI4lf5bCxt
         G0OHX9luihu4YaZ2ek/rJOtLkUSgYuuvr8liEnI6e3V95a/XtyIpIHBaQ2EGdh+ObakX
         Z5Fg==
X-Gm-Message-State: AOJu0YxCNJPv6faQiJhakO8vtf0YTRzrv6p33XCYfLCi45m0txrk5Ib6
	/bEL445l0kYu+ePPflCsFQ+sx0pxuv7C7ZO2pk0Jdbu2osDUarouDJmySqMW9g==
X-Google-Smtp-Source: AGHT+IHQ7gSlptFP9Id6oIfb1DYj5dhoaDHNDxGZJ/4xjnv8noXdgyY+U3CVRT3wmtzXjxj/nEvUrg==
X-Received: by 2002:a05:6870:89a4:b0:260:f5c6:e9ec with SMTP id 586e51a60fabf-26fe5a70546mr5180121fac.17.1723682065111;
        Wed, 14 Aug 2024 17:34:25 -0700 (PDT)
Received: from localhost (210.73.125.34.bc.googleusercontent.com. [34.125.73.210])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-7127af3fae8sm151797b3a.208.2024.08.14.17.34.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Aug 2024 17:34:24 -0700 (PDT)
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
Subject: [PATCH v2 02/11] drm/bridge: Verify lane assignment is going to work during atomic_check
Date: Wed, 14 Aug 2024 17:34:07 -0700
Message-ID: <20240815003417.1175506-3-swboyd@chromium.org>
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

Verify during drm_atomic_bridge_check() that the lane assignment set in
a bridge's atomic_check() callback is going to be satisfied by the
previous bridge. If the next bridge is requiring something besides the
default 1:1 lane assignment on its input then there must be an output
lane assignment on the previous bridge's output. Otherwise the next
bridge won't get the lanes assigned that it needs.

Cc: Andrzej Hajda <andrzej.hajda@intel.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Robert Foss <rfoss@kernel.org>
Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Cc: Jonas Karlman <jonas@kwiboo.se>
Cc: Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: David Airlie <airlied@gmail.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: <dri-devel@lists.freedesktop.org>
Cc: Pin-yen Lin <treapking@chromium.org>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/gpu/drm/drm_bridge.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
index bd18c1e91dee..68c7a321b9b3 100644
--- a/drivers/gpu/drm/drm_bridge.c
+++ b/drivers/gpu/drm/drm_bridge.c
@@ -860,6 +860,10 @@ static int drm_atomic_bridge_check(struct drm_bridge *bridge,
 				   struct drm_crtc_state *crtc_state,
 				   struct drm_connector_state *conn_state)
 {
+	u8 num_input_lanes, num_output_lanes = 0;
+	const struct drm_lane_cfg *input_lanes;
+	int i;
+
 	if (bridge->funcs->atomic_check) {
 		struct drm_bridge_state *bridge_state;
 		int ret;
@@ -873,12 +877,24 @@ static int drm_atomic_bridge_check(struct drm_bridge *bridge,
 						  crtc_state, conn_state);
 		if (ret)
 			return ret;
+		num_output_lanes = bridge_state->output_bus_cfg.num_lanes;
 	} else if (bridge->funcs->mode_fixup) {
 		if (!bridge->funcs->mode_fixup(bridge, &crtc_state->mode,
 					       &crtc_state->adjusted_mode))
 			return -EINVAL;
 	}
 
+	input_lanes = drm_bridge_next_bridge_lane_cfg(bridge,
+						      crtc_state->state,
+						      &num_input_lanes);
+	/*
+	 * Ensure this bridge is aware that the next bridge wants to
+	 * reassign lanes.
+	 */
+	for (i = 0; i < num_input_lanes; i++)
+		if (i != input_lanes[i].logical && !num_output_lanes)
+			return -ENOTSUPP;
+
 	return 0;
 }
 
-- 
https://chromeos.dev


