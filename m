Return-Path: <linux-kernel+bounces-365236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F3C799DF53
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 09:30:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD9AA282B90
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 07:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 738EE4C7E;
	Tue, 15 Oct 2024 07:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ta48acNc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C053F18BB88;
	Tue, 15 Oct 2024 07:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728977421; cv=none; b=Zt/uw3w3YmEuZuyOTplEfLG8aGjFB9Jcxi7X5l2qRzaTRw1SFD6Yq7hqgG9hMC7oCUc9VDedRs3vzYjlhneycv6gg6Vg2L+Sn9qQO3mpCvQZ+usxXuzH7DpdrM07DrFCFuW95ZR+DrlE8T99Oh43m2tHLkOsu/nwhCBbdes4cJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728977421; c=relaxed/simple;
	bh=keUb9CjekSjahuXcS0fp1hkqPH8WA5k0uSQIqftR4l8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lKJFCU24wF9ZJgOajS6Gv2ATX6hyLmuN9PRQlCPF7k+KqJyLzElkkdNiML0HA7uNzzdyZ9kYaTn/ryeK+H9eRvMgJisA4ZM1qLeHb2h/1U2w8CQZ/rEwixBmmpHmdNC4e6PKBmhPewl4gixYNAZOuhuIGpjruqQvl2a11HxeBdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ta48acNc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 975B3C4CEC7;
	Tue, 15 Oct 2024 07:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728977421;
	bh=keUb9CjekSjahuXcS0fp1hkqPH8WA5k0uSQIqftR4l8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ta48acNcynUOpgmz3NbgHOdyKvRbF5kdZTeBYj1zR5EWlO/CWkDpGcAR7vaW0KLlo
	 qAkRglYbA8OTOkt3Hhzw4++KYGVUXSV3NhpxOatcTIRPridmwpHPev3rppTCf6xIGi
	 UQz4fgcUuYALT7yVtzCjJBkOWpGhvrtZ/F5ySDIHNZUH3Vhe8MzoLC//15pzUrx21Q
	 UAEMQpgv/CLlluIryWb44OklhFOLmxO4SXPXaj+nayMwtDWc4W6ANKpMaejOSMcT90
	 qYN1aZpf3Q+uP1WKxehU5iXCDsO+gzck9xfu7gsvxJqTrmMdb83QkG/NCwyKzMgruD
	 THf1KiqTBKdrQ==
From: Arnd Bergmann <arnd@kernel.org>
To: Liu Ying <victor.liu@nxp.com>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	dri-devel@lists.freedesktop.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] drm/imx: legacy-bridge: add MODULE_DESCRIPTION
Date: Tue, 15 Oct 2024 07:29:58 +0000
Message-Id: <20241015073004.4066457-2-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241015073004.4066457-1-arnd@kernel.org>
References: <20241015073004.4066457-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

Every module should have a description, without this we get a
build time warning.

Fixes: cc3e8a216d6b ("drm/imx: add internal bridge handling display-timings DT node")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/bridge/imx/imx-legacy-bridge.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/bridge/imx/imx-legacy-bridge.c b/drivers/gpu/drm/bridge/imx/imx-legacy-bridge.c
index 07a78a02a884..3ebf0b9866de 100644
--- a/drivers/gpu/drm/bridge/imx/imx-legacy-bridge.c
+++ b/drivers/gpu/drm/bridge/imx/imx-legacy-bridge.c
@@ -85,3 +85,4 @@ struct drm_bridge *devm_imx_drm_legacy_bridge(struct device *dev,
 EXPORT_SYMBOL_GPL(devm_imx_drm_legacy_bridge);
 
 MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Freescale i.MX DRM bridge driver for legacy DT bindings");
-- 
2.39.5


