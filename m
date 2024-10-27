Return-Path: <linux-kernel+bounces-383484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E1E99B1C62
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 08:51:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A88001F2193F
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 07:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2865F53804;
	Sun, 27 Oct 2024 07:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PrGpVOMn"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79AC552F9B
	for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2024 07:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730015483; cv=none; b=fFithxuHMz6mqZphVeuGHKfxzx3RGRTw7AmfuDesL/egEetnlyvUb7SQnnVAbMLUKG1jwaTVAOtHL7Ze1aw56WU1yuQEQqv2qZKxIvXNvGYAmdLQciST2VMVlHWzJ7dgnLW70i/45DjzTC9XEV0pt+u4eD/Dyzl0ol643EK4ynY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730015483; c=relaxed/simple;
	bh=190ulkEix2nV6LUZ/hPOLvwm0KTSFhVhb79PrfGzt60=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k9BoXZ55708qhKGp12M2VLo/EU+Uem0Df/jnuJV75txPee3j4y1+sNMb3eJQP0EIR/Y+q5dhPtTP/1CmNS4xXNnndK1pw01K8UEHT07F7+k1/XU/OSu4HpU7K54tEyYH3yBKvKSV1syYQuOoxOq0hK4wWFs1XyQGgwzo9e8kvN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PrGpVOMn; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-7ed9f1bcb6bso2156927a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2024 00:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730015480; x=1730620280; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UmZ562TWvSEYWHmls9zLStGOVmuvMcWc95tM3sj3JQY=;
        b=PrGpVOMnJcO6Ze6OInCHnHYEokW0y/r06x/uVZ3WnkdOmVKS4Dx9FMxaGwFsgQdEGb
         B2pc4teNisiwgHF7+0eqIh8EGOo0lRGlNkRKhjbvpwIFt3cAmdCIlT4dSK+ANyYAB5Y/
         s/e3GR04NT/wAOedT99+/FJlWtFwD5CHL8eGeimxr6bVslq2O5uYjW+4ZkjV36F8QvdP
         /ATRAVJf2oGRb/Viy+hCtktf/KHSXFStF0WGG99DLI/M+mlhrFd6bGE2C3TAOwGuAr1e
         rJsVabGZMLNq/VIOsgNPZGwLhuSoZaa2D9tGIBkjrujDUIetUxaEGcOot8NdE5JETMAR
         xcQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730015480; x=1730620280;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UmZ562TWvSEYWHmls9zLStGOVmuvMcWc95tM3sj3JQY=;
        b=CqB0JjHTzwLhwGVVPnq2C0URHVWGydEWzZ/BpMxi6FyQLReQ6Y+4fSLQxvFI0Fsrcy
         5tpI1MdnjyWI3s7NP/397fgkH9JMpSudkWZKffyleNY99fO8fQTjwoJ1Dc/va1qp0TR5
         rxg8e8tqV9hJoZJfIXwjRhqAbfEMi2/wtv6XjSlfVLTooAsvmvbYn/uA1QxX6xMHQMmq
         SQAlxB412/7uTdeM+n6768XcOJHmX9h4iezjFdze/xirtDB1/BolMXso0oNwntqsQ/p5
         0RRW8oJLQm+Avi0f/0KU8zz6qGS0c8Wm6KGR6NGn0OqNc3PILPoKtBRttOG+boeDc38D
         k3bQ==
X-Forwarded-Encrypted: i=1; AJvYcCUpH9MWUcZ3Bs8v/dpuDCQqMI5oLTuAque7xzIiplVjoTEPdiYVJdNbLDBE2ePr3qSrER6ey6S64QUPubw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlGx6viCqBZP3Tk4D4v+nDiHS/gjROg0OcN1VzZdR6WoH/bKic
	wU3lgQxhexHgCGS9zxvd01PIie+CrC1Q3VB+ZV4qyzQunFqmBZcB
X-Google-Smtp-Source: AGHT+IGQOtCWxcizTXgrVFo4n+U3UJmE7USmLMCsyGi09knUS1pUdt+OcSuQZ9umOqmOBlQN2YlcjQ==
X-Received: by 2002:a05:6a20:4c9b:b0:1d9:3b81:cdd3 with SMTP id adf61e73a8af0-1d9a83ab2d9mr5780061637.1.1730015479652;
        Sun, 27 Oct 2024 00:51:19 -0700 (PDT)
Received: from fedora.. ([2405:201:d007:50c2:b7e7:6df3:9958:a45d])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7205794f9a1sm3785551b3a.90.2024.10.27.00.51.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Oct 2024 00:51:19 -0700 (PDT)
From: Vamsi Krishna Brahmajosyula <vamsikrishna.brahmajosyula@gmail.com>
To: maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	jani.nikula@linux.intel.com
Cc: skhan@linuxfoundation.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] drm/edid: convert drm_parse_hdmi_vsdb_video to use struct cea_db *
Date: Sun, 27 Oct 2024 13:21:04 +0530
Message-ID: <20241027075108.14273-2-vamsikrishna.brahmajosyula@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241027075108.14273-1-vamsikrishna.brahmajosyula@gmail.com>
References: <20241027075108.14273-1-vamsikrishna.brahmajosyula@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Address the following
	FIXME: convert parsers to use struct cea_db
in the parser drm_parse_hdmi_vsdb_video

cea_db contains len and then data. Appropriately change the indices
when referring to individual elements (db[n] becomes data[n-1]).

Signed-off-by: Vamsi Krishna Brahmajosyula <vamsikrishna.brahmajosyula@gmail.com>
---
 drivers/gpu/drm/drm_edid.c | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
index 855beafb76ff..e07e39c0caa0 100644
--- a/drivers/gpu/drm/drm_edid.c
+++ b/drivers/gpu/drm/drm_edid.c
@@ -6259,32 +6259,33 @@ static void drm_parse_hdmi_forum_scds(struct drm_connector *connector,
 }
 
 static void drm_parse_hdmi_deep_color_info(struct drm_connector *connector,
-					   const u8 *hdmi)
+					   const struct cea_db *db)
 {
 	struct drm_display_info *info = &connector->display_info;
 	unsigned int dc_bpc = 0;
+	const u8 *hdmi = cea_db_data(db);
 
 	/* HDMI supports at least 8 bpc */
 	info->bpc = 8;
 
-	if (cea_db_payload_len(hdmi) < 6)
+	if (cea_db_payload_len(db) < 6)
 		return;
 
-	if (hdmi[6] & DRM_EDID_HDMI_DC_30) {
+	if (hdmi[5] & DRM_EDID_HDMI_DC_30) {
 		dc_bpc = 10;
 		info->edid_hdmi_rgb444_dc_modes |= DRM_EDID_HDMI_DC_30;
 		drm_dbg_kms(connector->dev, "[CONNECTOR:%d:%s] HDMI sink does deep color 30.\n",
 			    connector->base.id, connector->name);
 	}
 
-	if (hdmi[6] & DRM_EDID_HDMI_DC_36) {
+	if (hdmi[5] & DRM_EDID_HDMI_DC_36) {
 		dc_bpc = 12;
 		info->edid_hdmi_rgb444_dc_modes |= DRM_EDID_HDMI_DC_36;
 		drm_dbg_kms(connector->dev, "[CONNECTOR:%d:%s] HDMI sink does deep color 36.\n",
 			    connector->base.id, connector->name);
 	}
 
-	if (hdmi[6] & DRM_EDID_HDMI_DC_48) {
+	if (hdmi[5] & DRM_EDID_HDMI_DC_48) {
 		dc_bpc = 16;
 		info->edid_hdmi_rgb444_dc_modes |= DRM_EDID_HDMI_DC_48;
 		drm_dbg_kms(connector->dev, "[CONNECTOR:%d:%s] HDMI sink does deep color 48.\n",
@@ -6302,7 +6303,7 @@ static void drm_parse_hdmi_deep_color_info(struct drm_connector *connector,
 	info->bpc = dc_bpc;
 
 	/* YCRCB444 is optional according to spec. */
-	if (hdmi[6] & DRM_EDID_HDMI_DC_Y444) {
+	if (hdmi[5] & DRM_EDID_HDMI_DC_Y444) {
 		info->edid_hdmi_ycbcr444_dc_modes = info->edid_hdmi_rgb444_dc_modes;
 		drm_dbg_kms(connector->dev, "[CONNECTOR:%d:%s] HDMI sink does YCRCB444 in deep color.\n",
 			    connector->base.id, connector->name);
@@ -6312,7 +6313,7 @@ static void drm_parse_hdmi_deep_color_info(struct drm_connector *connector,
 	 * Spec says that if any deep color mode is supported at all,
 	 * then deep color 36 bit must be supported.
 	 */
-	if (!(hdmi[6] & DRM_EDID_HDMI_DC_36)) {
+	if (!(hdmi[5] & DRM_EDID_HDMI_DC_36)) {
 		drm_dbg_kms(connector->dev, "[CONNECTOR:%d:%s] HDMI sink should do DC_36, but does not!\n",
 			    connector->base.id, connector->name);
 	}
@@ -6320,19 +6321,20 @@ static void drm_parse_hdmi_deep_color_info(struct drm_connector *connector,
 
 /* HDMI Vendor-Specific Data Block (HDMI VSDB, H14b-VSDB) */
 static void
-drm_parse_hdmi_vsdb_video(struct drm_connector *connector, const u8 *db)
+drm_parse_hdmi_vsdb_video(struct drm_connector *connector, const struct cea_db *db)
 {
 	struct drm_display_info *info = &connector->display_info;
 	u8 len = cea_db_payload_len(db);
+	const u8 *data = cea_db_data(db);
 
 	info->is_hdmi = true;
 
-	info->source_physical_address = (db[4] << 8) | db[5];
+	info->source_physical_address = (data[3] << 8) | data[4];
 
 	if (len >= 6)
-		info->dvi_dual = db[6] & 1;
+		info->dvi_dual = data[5] & 1;
 	if (len >= 7)
-		info->max_tmds_clock = db[7] * 5000;
+		info->max_tmds_clock = data[6] * 5000;
 
 	/*
 	 * Try to infer whether the sink supports HDMI infoframes.
@@ -6340,7 +6342,7 @@ drm_parse_hdmi_vsdb_video(struct drm_connector *connector, const u8 *db)
 	 * HDMI infoframe support was first added in HDMI 1.4. Assume the sink
 	 * supports infoframes if HDMI_Video_present is set.
 	 */
-	if (len >= 8 && db[8] & BIT(5))
+	if (len >= 8 && data[7] & BIT(5))
 		info->has_hdmi_infoframe = true;
 
 	drm_dbg_kms(connector->dev, "[CONNECTOR:%d:%s] HDMI: DVI dual %d, max TMDS clock %d kHz\n",
@@ -6412,7 +6414,7 @@ static void drm_parse_cea_ext(struct drm_connector *connector,
 		const u8 *data = (const u8 *)db;
 
 		if (cea_db_is_hdmi_vsdb(db))
-			drm_parse_hdmi_vsdb_video(connector, data);
+			drm_parse_hdmi_vsdb_video(connector, db);
 		else if (cea_db_is_hdmi_forum_vsdb(db) ||
 			 cea_db_is_hdmi_forum_scdb(db))
 			drm_parse_hdmi_forum_scds(connector, data);
-- 
2.47.0


