Return-Path: <linux-kernel+bounces-320230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0ACA9707D2
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 15:30:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A061D282D8B
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 13:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0FCC16B39E;
	Sun,  8 Sep 2024 13:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="SiliM5Y4"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC9416A95C
	for <linux-kernel@vger.kernel.org>; Sun,  8 Sep 2024 13:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.215.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725802172; cv=none; b=n7xotr28lR+uYgGO7BBzjyrEiWcx5ecX0+cerN0nj4+M3KKqfXx5+QVBuG0ThVBNYWK3IQLKhPt8qPmY8lMr40jZFEkL59yn8CQVF49lubeqrzhU60UQen6XIAQBgNm6Q1lnWF6D1RFdG34yDojQfTyhldLyCt4fKMcD+2Hgkns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725802172; c=relaxed/simple;
	bh=TLnE+I3Km3LhX9uCXy0i3BsVfFWkyan3TgA0dDhpGwM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aZqrqg8nU5hwDWj+5jCNsRZxvAXYtenWPALr4Bo0d3JRTGXkWGnsIA5XCnU/WyPXNmfC2Ci4eH0gCLgNhOeF6mOf9l7YieW3mSegUYKovjq4NhAQbj58iN0ofeqgGt7rfi66dgOfbcRkP/IDPZgPJ0lWjZtwTTjXd45d2iLw4OU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=SiliM5Y4; arc=none smtp.client-ip=149.28.215.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1725802151; bh=8TqgWjT3UGoq8NhlqNVT+UNBc/OTSgrzdmn4WedFMlo=;
 b=SiliM5Y4uv2xAzqEW+kAAu/blbSllSL/y+qZapkThn+8tepqhlG7/P7tSN2kHBjMZC4w2sG+u
 pnwbz7P1CW2jtYTM281z1BbT1beKCMT0MYyHw/qfWsO5vReUYcv7WHjcsrcafdKlmcKBmzuBi+8
 pzccuCRELE62qQZDcSZZEMRl8o+QArmL+MLBcRDnnh/hirA/ZAMNXm05NEILgtpMXxP+dc1fFt4
 lndVGtMo4nRVI5gmoNjfeok1QR79uMa+KbE4ag0ViHB0EQgWT4mYzk//NXd/ZX/xNGxKRMVPiWV
 2J2xgcKLljj5FSlSFiET7xcG+nerpJYh8sJCvmK13nyw==
From: Jonas Karlman <jonas@kwiboo.se>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: Christian Hewitt <christianshewitt@gmail.com>,
	Diederik de Haas <didi.debian@cknow.org>,
	Christopher Obbard <chris.obbard@collabora.com>,
	dri-devel@lists.freedesktop.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 09/10] drm: bridge: dw_hdmi: Update EDID during hotplug processing
Date: Sun,  8 Sep 2024 13:28:11 +0000
Message-ID: <20240908132823.3308029-10-jonas@kwiboo.se>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240908132823.3308029-1-jonas@kwiboo.se>
References: <20240908132823.3308029-1-jonas@kwiboo.se>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 66dda6a63c9877b4595879b6

Update successfully read EDID during hotplug processing to ensure the
connector diplay_info is always up-to-date.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
v2: No change
---
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
index c19307120909..7bd9f895f03f 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
@@ -2457,6 +2457,18 @@ dw_hdmi_connector_detect(struct drm_connector *connector, bool force)
 
 	status = dw_hdmi_detect(hdmi);
 
+	/* Update EDID during hotplug processing (force=false) */
+	if (status == connector_status_connected && !force) {
+		const struct drm_edid *drm_edid;
+
+		drm_edid = dw_hdmi_edid_read(hdmi, connector);
+		if (drm_edid)
+			drm_edid_connector_update(connector, drm_edid);
+		cec_notifier_set_phys_addr(hdmi->cec_notifier,
+			connector->display_info.source_physical_address);
+		drm_edid_free(drm_edid);
+	}
+
 	if (status == connector_status_disconnected)
 		cec_notifier_phys_addr_invalidate(hdmi->cec_notifier);
 
-- 
2.46.0


