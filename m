Return-Path: <linux-kernel+bounces-210182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D0A7904082
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 17:52:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 610291C23C30
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 15:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C4B938F98;
	Tue, 11 Jun 2024 15:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="v05AxTpp"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [167.172.40.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7505B38F82
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 15:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.172.40.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718121122; cv=none; b=EGEnsx5twh37II5NaS6yHDvI+Gc3UdxDNJgPNcDA2jEPbJwV+mjKA+GhFCeB9ROWCQ87VWEmqwAS8yriAOMshp2+aefaRRX+DEBFLEpKqQBehMzGGnS6E7MEOVpSEMI8Br01ejmdI1a1pchKm4yeQUZ/0tORe9w0ksFHolRLTGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718121122; c=relaxed/simple;
	bh=jjoPpoRjL3DOZo4yXBvOoton5pxjTMU09QetBxLUSxY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kBKHchrws2jh6euF+7ScZCbLFGYMsjMRQs3abeB/1OvR9yqV9g/c4Au9w3B8sxKcY7a5PHw94JsbLXsuHg94pz7GnG7qY/E/jCaYHkRdWDHax4WRq1pXQggnk1tkVaRtt1OpLA9PhBmkjc8d0Jz4fmsGegRq5Z92D5+utUY51cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=v05AxTpp; arc=none smtp.client-ip=167.172.40.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1718121105; bh=OS3NU+RvpotAQqpVjqqkbRKiRgEhuSmytUWvvgOanmg=;
 b=v05AxTppFIZAnx6pivBSAocoIXCSk72tNXct89QH0vLTjj2N9Fedkxsim6hpGp8t/La0s9q9w
 rPBOve6d6peAr5cnMtsANUd4VvCRUjgHfYSXwdC8zrackxQDlpj45/pMcIvn9jIQYkAnxRzeK3h
 dm5FHbTTMrS7sIEwtzESyymn91LsZUW9Kvi4gs+R1peWmsvVUnmrnrTHPz1lwb/iDlcNTYUPhzd
 OfA7Q3/zB6oBogbX4K7t1RUWp+Ha0JisskoPqNzdYnp9yWSAQnrR9xFwDiemvfipKTWcIGCcfU5
 apGdY+6rX8Lk5+F39j+82pbynb2zHwR2PhRFKEdYvE1w==
From: Jonas Karlman <jonas@kwiboo.se>
To: Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David
 Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, Laurent
 Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman
 <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 6/8] drm: bridge: dw_hdmi: Remove cec_notifier_mutex
Date: Tue, 11 Jun 2024 15:50:58 +0000
Message-ID: <20240611155108.1436502-7-jonas@kwiboo.se>
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
X-ForwardEmail-ID: 6668728fb913b04293b6dc8a

With CEC phys addr invalidation moved away from the irq handler there is
no longer a need for cec_notifier_mutex, remove it.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
index 0814ca181f04..256e00a97a9a 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
@@ -189,7 +189,6 @@ struct dw_hdmi {
 	void (*enable_audio)(struct dw_hdmi *hdmi);
 	void (*disable_audio)(struct dw_hdmi *hdmi);
 
-	struct mutex cec_notifier_mutex;
 	struct cec_notifier *cec_notifier;
 
 	hdmi_codec_plugged_cb plugged_cb;
@@ -2459,11 +2458,8 @@ dw_hdmi_connector_detect(struct drm_connector *connector, bool force)
 
 	status = dw_hdmi_detect(hdmi);
 
-	if (status == connector_status_disconnected) {
-		mutex_lock(&hdmi->cec_notifier_mutex);
+	if (status == connector_status_disconnected)
 		cec_notifier_phys_addr_invalidate(hdmi->cec_notifier);
-		mutex_unlock(&hdmi->cec_notifier_mutex);
-	}
 
 	return status;
 }
@@ -2577,9 +2573,7 @@ static int dw_hdmi_connector_create(struct dw_hdmi *hdmi)
 	if (!notifier)
 		return -ENOMEM;
 
-	mutex_lock(&hdmi->cec_notifier_mutex);
 	hdmi->cec_notifier = notifier;
-	mutex_unlock(&hdmi->cec_notifier_mutex);
 
 	return 0;
 }
@@ -2877,10 +2871,8 @@ static void dw_hdmi_bridge_detach(struct drm_bridge *bridge)
 {
 	struct dw_hdmi *hdmi = bridge->driver_private;
 
-	mutex_lock(&hdmi->cec_notifier_mutex);
 	cec_notifier_conn_unregister(hdmi->cec_notifier);
 	hdmi->cec_notifier = NULL;
-	mutex_unlock(&hdmi->cec_notifier_mutex);
 }
 
 static enum drm_mode_status
@@ -3303,7 +3295,6 @@ struct dw_hdmi *dw_hdmi_probe(struct platform_device *pdev,
 
 	mutex_init(&hdmi->mutex);
 	mutex_init(&hdmi->audio_mutex);
-	mutex_init(&hdmi->cec_notifier_mutex);
 	spin_lock_init(&hdmi->audio_lock);
 
 	ret = dw_hdmi_parse_dt(hdmi);
-- 
2.45.2


