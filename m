Return-Path: <linux-kernel+bounces-210183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70193904083
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 17:52:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1747A281C25
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 15:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96B583A27B;
	Tue, 11 Jun 2024 15:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="iKfQvn1O"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [167.172.40.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D2F3A1CC
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 15:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.172.40.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718121128; cv=none; b=baUTDbVsxxfdAFcq/t9HLHwebzbuc6oCDySrQ13xgm5HhCxkme//rc134m7wz2Gr/CQWpoMEdlNlMjZjvj7VSTPEIitB8TNo/rE8UUQgM036zhMLue1D5fHz1iFmi8PJJSm0Nlqawk5STLUf2DY0vsEe4Wyp9rJVvpiOJ0gp9rM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718121128; c=relaxed/simple;
	bh=yBC9kQONjNrJ10/RZH427oO18lkJ1ICXuw0hBd94P1k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=edasMcvQpDoFpiHxT288v+W3I5D25BDOxW71hAd5fmnC9cf+Jx4Dz3TA6++EWhGwa4/Xx7TfnZP5i/U1MkawZWrOI3wmK0V0p5BgzB7AhmKwGXIu1wRnKjkt3koPZKm6YXGC+qA/6fM7UlOTrhOHECYWomMSLPgRvQBMbxgHASc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=iKfQvn1O; arc=none smtp.client-ip=167.172.40.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1718121111; bh=nlK/Kivspo5uHUE2bxjdk8Lq1XFHOztjsLHLbVDbKeE=;
 b=iKfQvn1O8EKG3eIiPvHO1sPFkbmRf/Ic9+RLLhZhZcWpeSuAzacBvv767nXy6BAh58bj6Czo5
 D3uuDOXwjUJrvM72YInKc9JjaOIyhPLdr+hxKT2tMD96cUmvEJJCIX2a8wKi2ETa6fVqFUXwryD
 0VyJBIVQEmjGted3Gf6xWvu7c0ZN/S/W13vl5IbEuuoQjGWTWASDd9p7aoDoyAqgwWvlvIuNzNn
 BWMGwa5iVQ9ypkOcDuAKjBfo55FeIVDw/0CieNbcpHOCr4xUShPIZ3SxJXDC3f6d/q+rkhgWaqh
 NvxhZGNU1ICPNL+1nhrUL1LZ0N5cmcINC1VT/WvGQnjg==
From: Jonas Karlman <jonas@kwiboo.se>
To: Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David
 Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, Laurent
 Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman
 <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 7/8] drm: bridge: dw_hdmi: Update EDID during hotplug processing
Date: Tue, 11 Jun 2024 15:50:59 +0000
Message-ID: <20240611155108.1436502-8-jonas@kwiboo.se>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240611155108.1436502-1-jonas@kwiboo.se>
References: <20240611155108.1436502-1-jonas@kwiboo.se>
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
 167.172.40.54
X-ForwardEmail-ID: 66687294b913b04293b6dca0

Update successfully read EDID during hotplug processing to ensure the
connector diplay_info is always up-to-date.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
index 256e00a97a9a..a9c39584d31b 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
@@ -2458,6 +2458,18 @@ dw_hdmi_connector_detect(struct drm_connector *connector, bool force)
 
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
2.45.2


