Return-Path: <linux-kernel+bounces-383485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 602BC9B1C65
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 08:51:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 922522820E5
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 07:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 504F144375;
	Sun, 27 Oct 2024 07:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X5QHZrfe"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70ED955887
	for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2024 07:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730015486; cv=none; b=MPfTVy+zFcaDoCFp72tjyi1CGkhsXz3gpCuFUmiMxFWXXFJOhxmAlkZ7h8ClWB+m1wf1hU8aTyyxhTYmNjdyJZ89Nw4AJfMliG1EF1OTO24ZMrTtYzQUmLXE/7vrkucodB65Et86pdMU9+uZ6+WZyO0OLA0QGCkQofO9FC1JRx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730015486; c=relaxed/simple;
	bh=em/8I6c3qdd19cHs/Y7FFzt6/b44wvDCtW1ZAQKODt8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RH3KU7ybXEyqZojEqy662ZU8YdhJrTEOUagp+t4IG1ambeD5LmDzLTZcfPMPLuNJg+66Dh8m2AgQVfDJcijpuYLsUFcqapmkm42vvOLiaGsGi7Mxu2IGipWvmPCyiBxgaJEdQSA2tVmamMgfHoKHwqZhb7yqzp+q7+xe0+kBHZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X5QHZrfe; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-71e52582cf8so2387553b3a.2
        for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2024 00:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730015484; x=1730620284; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZG1M3TOUyG+goANQU6k5RDo7M15PqSr1tl6HcqlXoB0=;
        b=X5QHZrfet6cYNf0a5xVPaCvRo1RZmrTGB+QauQp4apKlhBe7nL+3Rupzf2R3X/7D72
         AIud/DrTy4BB9f0PG5e77LQJOwo1ljAXZmkSfEmZa5W6MHR+xSxvfOs6j3HTg1iasEnq
         fSAMb7YjPqHVAt5FXUjaUVNdH/OgVPEncymtfcr2uNEZ/ykMTTts3M/sc0NdZFvZznvB
         2r3+/mP1bwugMpKGAdSnaY1JA/OE4BqZm8LKYQs0IGi4ZkLIOm/DYWJ3SpDIEfgFqtQ5
         MwB2VgdWSacD75evp1mKZHq9ImcT7gQrotnA/6xm7NJnpN0dtNr87nfeS4ckqRdtFfvi
         CxcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730015484; x=1730620284;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZG1M3TOUyG+goANQU6k5RDo7M15PqSr1tl6HcqlXoB0=;
        b=map2RP51BAhr2xcmmRKHOhPh3Vbcs4YJpBTw+fTn0s2OrxIcLjV4a8n6LCO+KO60fx
         0RxUkbKNh3gSBdKZo5R290ma6hvPE1nVv5I3Rbht/MoqM77AyXk2CA34lNc817zMuZ1b
         ybDKJHibDFP/hdRfukzsmA7knlJPpJB8NaqYWAXinAjqlDhFCp/M6UhFLkynR42SGpNf
         3fbk+3ontLe2QeDAcYbYKruDCJJgbGqAYdTqwVlxU1z34tspd2vngagmPLGr0ZLLHltX
         98u41WkMRTLwicagECdpofV4fhu3rBH4O2yVUDN7sd3Gws1fXg1/xgTP/M5MGr5wAIj+
         FOKA==
X-Forwarded-Encrypted: i=1; AJvYcCXrcbwAxqzwGi8Dc8joQbqw0vjOBh8KHEKVguv/WlHBEL1lARccBXeyb+e+xjSS9JlKpT2X+8uNG1gDyYo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIc42PTpQ9uIC5MnKTn/58JFFmgll60dzKJLHFTssb2IA2PQTY
	4REevE4bXGgHNQGJEE03Mf29jlOtmfFQOhgFq5m9iZfeOHBmD9dR
X-Google-Smtp-Source: AGHT+IHIMFVfUloVq/h0b+q0MYGiJAE0Rd6mTPhC9+G2coAhYQIVYiwDm9CC3QiVWcu7OqTvAjY4fA==
X-Received: by 2002:a05:6a00:c85:b0:71e:f4:dbc with SMTP id d2e1a72fcca58-7206309375fmr7351107b3a.25.1730015483426;
        Sun, 27 Oct 2024 00:51:23 -0700 (PDT)
Received: from fedora.. ([2405:201:d007:50c2:b7e7:6df3:9958:a45d])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7205794f9a1sm3785551b3a.90.2024.10.27.00.51.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Oct 2024 00:51:22 -0700 (PDT)
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
Subject: [PATCH 2/5] drm/edid: convert drm_parse_hdmi_forum_scds to use struct cea_db *
Date: Sun, 27 Oct 2024 13:21:05 +0530
Message-ID: <20241027075108.14273-3-vamsikrishna.brahmajosyula@gmail.com>
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
in the parser drm_parse_hdmi_forum_scds and related methods

cea_db contains len and then data. Appropriately change the indices
when referring to individual elements (db[n] becomes data[n-1]).

Signed-off-by: Vamsi Krishna Brahmajosyula <vamsikrishna.brahmajosyula@gmail.com>
---
 drivers/gpu/drm/drm_edid.c | 56 ++++++++++++++++++++------------------
 1 file changed, 30 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
index e07e39c0caa0..f79d8fbdb62b 100644
--- a/drivers/gpu/drm/drm_edid.c
+++ b/drivers/gpu/drm/drm_edid.c
@@ -6112,45 +6112,48 @@ void drm_get_max_frl_rate(int max_frl_rate, u8 *max_lanes, u8 *max_rate_per_lane
 }
 
 static void drm_parse_ycbcr420_deep_color_info(struct drm_connector *connector,
-					       const u8 *db)
+					       const struct cea_db *db)
 {
 	u8 dc_mask;
 	struct drm_hdmi_info *hdmi = &connector->display_info.hdmi;
+	const u8 *data = cea_db_data(db);
 
-	dc_mask = db[7] & DRM_EDID_YCBCR420_DC_MASK;
+	dc_mask = data[6] & DRM_EDID_YCBCR420_DC_MASK;
 	hdmi->y420_dc_modes = dc_mask;
 }
 
 static void drm_parse_dsc_info(struct drm_hdmi_dsc_cap *hdmi_dsc,
-			       const u8 *hf_scds)
+			       const struct cea_db *db)
 {
-	hdmi_dsc->v_1p2 = hf_scds[11] & DRM_EDID_DSC_1P2;
+	const u8 *hf_scds = cea_db_data(db);
+
+	hdmi_dsc->v_1p2 = hf_scds[10] & DRM_EDID_DSC_1P2;
 
 	if (!hdmi_dsc->v_1p2)
 		return;
 
-	hdmi_dsc->native_420 = hf_scds[11] & DRM_EDID_DSC_NATIVE_420;
-	hdmi_dsc->all_bpp = hf_scds[11] & DRM_EDID_DSC_ALL_BPP;
+	hdmi_dsc->native_420 = hf_scds[10] & DRM_EDID_DSC_NATIVE_420;
+	hdmi_dsc->all_bpp = hf_scds[10] & DRM_EDID_DSC_ALL_BPP;
 
-	if (hf_scds[11] & DRM_EDID_DSC_16BPC)
+	if (hf_scds[10] & DRM_EDID_DSC_16BPC)
 		hdmi_dsc->bpc_supported = 16;
-	else if (hf_scds[11] & DRM_EDID_DSC_12BPC)
+	else if (hf_scds[10] & DRM_EDID_DSC_12BPC)
 		hdmi_dsc->bpc_supported = 12;
-	else if (hf_scds[11] & DRM_EDID_DSC_10BPC)
+	else if (hf_scds[10] & DRM_EDID_DSC_10BPC)
 		hdmi_dsc->bpc_supported = 10;
 	else
 		/* Supports min 8 BPC if DSC 1.2 is supported*/
 		hdmi_dsc->bpc_supported = 8;
 
-	if (cea_db_payload_len(hf_scds) >= 12 && hf_scds[12]) {
+	if (cea_db_payload_len(db) >= 12 && hf_scds[11]) {
 		u8 dsc_max_slices;
 		u8 dsc_max_frl_rate;
 
-		dsc_max_frl_rate = (hf_scds[12] & DRM_EDID_DSC_MAX_FRL_RATE_MASK) >> 4;
+		dsc_max_frl_rate = (hf_scds[11] & DRM_EDID_DSC_MAX_FRL_RATE_MASK) >> 4;
 		drm_get_max_frl_rate(dsc_max_frl_rate, &hdmi_dsc->max_lanes,
 				     &hdmi_dsc->max_frl_rate_per_lane);
 
-		dsc_max_slices = hf_scds[12] & DRM_EDID_DSC_MAX_SLICES;
+		dsc_max_slices = hf_scds[11] & DRM_EDID_DSC_MAX_SLICES;
 
 		switch (dsc_max_slices) {
 		case 1:
@@ -6188,26 +6191,27 @@ static void drm_parse_dsc_info(struct drm_hdmi_dsc_cap *hdmi_dsc,
 		}
 	}
 
-	if (cea_db_payload_len(hf_scds) >= 13 && hf_scds[13])
-		hdmi_dsc->total_chunk_kbytes = hf_scds[13] & DRM_EDID_DSC_TOTAL_CHUNK_KBYTES;
+	if (cea_db_payload_len(db) >= 13 && hf_scds[12])
+		hdmi_dsc->total_chunk_kbytes = hf_scds[12] & DRM_EDID_DSC_TOTAL_CHUNK_KBYTES;
 }
 
 /* Sink Capability Data Structure */
 static void drm_parse_hdmi_forum_scds(struct drm_connector *connector,
-				      const u8 *hf_scds)
+				      const struct cea_db *db)
 {
 	struct drm_display_info *info = &connector->display_info;
 	struct drm_hdmi_info *hdmi = &info->hdmi;
 	struct drm_hdmi_dsc_cap *hdmi_dsc = &hdmi->dsc_cap;
+	const u8 *hf_scds = cea_db_data(db);
 	int max_tmds_clock = 0;
 	u8 max_frl_rate = 0;
 	bool dsc_support = false;
 
 	info->has_hdmi_infoframe = true;
 
-	if (hf_scds[6] & 0x80) {
+	if (hf_scds[5] & 0x80) {
 		hdmi->scdc.supported = true;
-		if (hf_scds[6] & 0x40)
+		if (hf_scds[5] & 0x40)
 			hdmi->scdc.read_request = true;
 	}
 
@@ -6220,11 +6224,11 @@ static void drm_parse_hdmi_forum_scds(struct drm_connector *connector,
 	 * Lets check it out.
 	 */
 
-	if (hf_scds[5]) {
+	if (hf_scds[4]) {
 		struct drm_scdc *scdc = &hdmi->scdc;
 
 		/* max clock is 5000 KHz times block value */
-		max_tmds_clock = hf_scds[5] * 5000;
+		max_tmds_clock = hf_scds[4] * 5000;
 
 		if (max_tmds_clock > 340000) {
 			info->max_tmds_clock = max_tmds_clock;
@@ -6234,21 +6238,21 @@ static void drm_parse_hdmi_forum_scds(struct drm_connector *connector,
 			scdc->scrambling.supported = true;
 
 			/* Few sinks support scrambling for clocks < 340M */
-			if ((hf_scds[6] & 0x8))
+			if ((hf_scds[5] & 0x8))
 				scdc->scrambling.low_rates = true;
 		}
 	}
 
-	if (hf_scds[7]) {
-		max_frl_rate = (hf_scds[7] & DRM_EDID_MAX_FRL_RATE_MASK) >> 4;
+	if (hf_scds[6]) {
+		max_frl_rate = (hf_scds[6] & DRM_EDID_MAX_FRL_RATE_MASK) >> 4;
 		drm_get_max_frl_rate(max_frl_rate, &hdmi->max_lanes,
 				     &hdmi->max_frl_rate_per_lane);
 	}
 
-	drm_parse_ycbcr420_deep_color_info(connector, hf_scds);
+	drm_parse_ycbcr420_deep_color_info(connector, db);
 
-	if (cea_db_payload_len(hf_scds) >= 11 && hf_scds[11]) {
-		drm_parse_dsc_info(hdmi_dsc, hf_scds);
+	if (cea_db_payload_len(db) >= 11 && hf_scds[10]) {
+		drm_parse_dsc_info(hdmi_dsc, db);
 		dsc_support = true;
 	}
 
@@ -6417,7 +6421,7 @@ static void drm_parse_cea_ext(struct drm_connector *connector,
 			drm_parse_hdmi_vsdb_video(connector, db);
 		else if (cea_db_is_hdmi_forum_vsdb(db) ||
 			 cea_db_is_hdmi_forum_scdb(db))
-			drm_parse_hdmi_forum_scds(connector, data);
+			drm_parse_hdmi_forum_scds(connector, db);
 		else if (cea_db_is_microsoft_vsdb(db))
 			drm_parse_microsoft_vsdb(connector, data);
 		else if (cea_db_is_y420cmdb(db))
-- 
2.47.0


