Return-Path: <linux-kernel+bounces-240348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA744926C78
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 01:32:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC48C1C22965
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 23:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40B4E178377;
	Wed,  3 Jul 2024 23:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="FCIW4v3K"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10371C68D
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 23:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720049539; cv=none; b=IYl3qyNwXU7i3iEIY7KBss4aDNjo200U+zftL7ZkqcuPHemKc/hNfT0/gII/YXK+1n/JAtvB31nxYujJfSWdpeySfOVDzXKzbuzmgrWobqXgOt7wqJWB69MrI1qH4gab4KrJSpC8riWAIbSK3zWFu+EQIcbLQTMIT8uVrLQ4IX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720049539; c=relaxed/simple;
	bh=kQH17cKo49JscTMErwhxpwT1c+G4HFWtKH1azX3MrHY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KOLsBiErX0SdXpRCIlBP7JFFm0PDGoUYzvqV9EPudNe1ZVN1iLc2j/7YRsbK5bdPhJFtuokhoj+dj6N4gdP3xAQ5YvgFolh+I5bIzi88WdWK5q6rEHuA6iqWzL0aix8yUgMG6fdZ8G/+IUtO+ztQPalHOEkS0LdDgpUEFI2XuWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=FCIW4v3K; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
From: Dragan Simic <dsimic@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1720049533;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=QlysRJGMPVMeOyPkS2J6+X2utP4VEwmmX+EczNyIJjk=;
	b=FCIW4v3KulXCCrJ17Z/KdG0HmI74JNGt56c6V4NKu8hg7IHzTQp3mAQBJhS4VQLZm2EX2I
	T4VlSTAP2VT62fyVvfE5EsO6+7vJ1u63ORQ9OkK0O54pC1GsJL3WicmvVf0Jy+RwGN35fe
	GoVsbiPQlLvi9MNjY7zfPdnDBWTdFPpSP1m5tXBgtMPZ4//8aKWIJpGcmC1GtZ6j9UFtdt
	Csy1+CXnAlOHR0v9MeNF6qh1kwrSeXpzqS7ALiF+X1v415HS6Fs0zVoKToUjZeQaT1Z5Cc
	XS39/nf/pLAio6TxwRuQfXKRY9oFCPbG/MboevgWIlfJjT/mi51pui5lWse4CQ==
To: linux-rockchip@lists.infradead.org,
	dri-devel@lists.freedesktop.org
Cc: heiko@sntech.de,
	hjc@rock-chips.com,
	andy.yan@rock-chips.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	daniel@ffwll.ch,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drm/rockchip: cdn-dp: Remove redundant workarounds for firmware loading
Date: Thu,  4 Jul 2024 01:32:02 +0200
Message-Id: <9b7a9e9b88ad8c7489ee1b4c70b8751eeb5cf6f9.1720049413.git.dsimic@manjaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

After the additional firmware-related module information was introduced by
the commit c0677e41a47f ("drm/rockchip: cdn-dp-core: add MODULE_FIRMWARE
macro"), there's no longer need for the firmware-loading workarounds whose
sole purpose was to prevent the missing firmware blob in an initial ramdisk
from causing driver initialization to fail.  Thus, delete the workarounds,
which removes a sizable chunk of redundant code.

Various utilities used by Linux distributions to generate initial ramdisks
need to obey the firmware-related module information, so we can rely on the
firmware blob being present in the generated initial ramdisks.

Signed-off-by: Dragan Simic <dsimic@manjaro.org>
---
 drivers/gpu/drm/rockchip/cdn-dp-core.c | 53 +++++---------------------
 1 file changed, 10 insertions(+), 43 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/cdn-dp-core.c b/drivers/gpu/drm/rockchip/cdn-dp-core.c
index bd7aa891b839..e1a7c6a1172b 100644
--- a/drivers/gpu/drm/rockchip/cdn-dp-core.c
+++ b/drivers/gpu/drm/rockchip/cdn-dp-core.c
@@ -44,9 +44,9 @@ static inline struct cdn_dp_device *encoder_to_dp(struct drm_encoder *encoder)
 #define DPTX_HPD_DEL		(2 << 12)
 #define DPTX_HPD_SEL_MASK	(3 << 28)
 
-#define CDN_FW_TIMEOUT_MS	(64 * 1000)
 #define CDN_DPCD_TIMEOUT_MS	5000
 #define CDN_DP_FIRMWARE		"rockchip/dptx.bin"
+
 MODULE_FIRMWARE(CDN_DP_FIRMWARE);
 
 struct cdn_dp_data {
@@ -909,61 +909,28 @@ static int cdn_dp_audio_codec_init(struct cdn_dp_device *dp,
 	return PTR_ERR_OR_ZERO(dp->audio_pdev);
 }
 
-static int cdn_dp_request_firmware(struct cdn_dp_device *dp)
-{
-	int ret;
-	unsigned long timeout = jiffies + msecs_to_jiffies(CDN_FW_TIMEOUT_MS);
-	unsigned long sleep = 1000;
-
-	WARN_ON(!mutex_is_locked(&dp->lock));
-
-	if (dp->fw_loaded)
-		return 0;
-
-	/* Drop the lock before getting the firmware to avoid blocking boot */
-	mutex_unlock(&dp->lock);
-
-	while (time_before(jiffies, timeout)) {
-		ret = request_firmware(&dp->fw, CDN_DP_FIRMWARE, dp->dev);
-		if (ret == -ENOENT) {
-			msleep(sleep);
-			sleep *= 2;
-			continue;
-		} else if (ret) {
-			DRM_DEV_ERROR(dp->dev,
-				      "failed to request firmware: %d\n", ret);
-			goto out;
-		}
-
-		dp->fw_loaded = true;
-		ret = 0;
-		goto out;
-	}
-
-	DRM_DEV_ERROR(dp->dev, "Timed out trying to load firmware\n");
-	ret = -ETIMEDOUT;
-out:
-	mutex_lock(&dp->lock);
-	return ret;
-}
-
 static void cdn_dp_pd_event_work(struct work_struct *work)
 {
 	struct cdn_dp_device *dp = container_of(work, struct cdn_dp_device,
 						event_work);
 	struct drm_connector *connector = &dp->connector;
 	enum drm_connector_status old_status;
-
 	int ret;
 
 	mutex_lock(&dp->lock);
 
 	if (dp->suspended)
 		goto out;
 
-	ret = cdn_dp_request_firmware(dp);
-	if (ret)
-		goto out;
+	if (!dp->fw_loaded) {
+		ret = request_firmware(&dp->fw, CDN_DP_FIRMWARE, dp->dev);
+		if (ret) {
+			DRM_DEV_ERROR(dp->dev, "Loading firmware failed: %d\n", ret);
+			goto out;
+		}
+
+		dp->fw_loaded = true;
+	}
 
 	dp->connected = true;
 

