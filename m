Return-Path: <linux-kernel+bounces-361401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F66499A7B0
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 17:29:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DC781C2636B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 15:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0369E194C67;
	Fri, 11 Oct 2024 15:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GkilzdJY"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC87194A73
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 15:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728660579; cv=none; b=ctkU2Djef1Zj1Kqzi8h0rBNFXKgyO/Vnl+/pyGUKGVTS9mkgb/1Ud7U5mAS82trXWPVdz6UfGn7zMeCWa623Ju9hO4irho+jnwX0/ZSNo5QqC6oeUOrU8Pd0WotsbnEpCoGycK357csLOEkmeS239BE8pLMQSXtOhxiTe5FiqHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728660579; c=relaxed/simple;
	bh=L673ERW7PV4sz6lc9fVU8t8UBguyJxPILyzb1Mb1tN8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=g0ruSz7A0mE+sjig26wqug5fhZCvuAwo+SXs/VDxzeFlKrlY+T55pf0oU69EOuODN+tAsHoMXSvSLsG0cGQHbPp5TB4R3nRdiaGSgqdLsgptrcPMi7+8/VON8sevz/nWZkJA/ZukoyiajvoK3QtqvJVAMzpt0wrpb7QQ6De1858=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GkilzdJY; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7ae3d7222d4so1792673a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 08:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728660577; x=1729265377; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=d2O0wF//mc3QHjPTSSLktyXdiyqG45d84oFd85Asuek=;
        b=GkilzdJYNosaL/jvi9GUbiMXdm2luLcYEKxI7DNME1gK5s+OLht79KF68gJaShtAfd
         shmTYEl7DBdsbNHON4L2/CaCo0jnB19qxhge+g6Cdarm3wg49Qv6MsDXoQ80ZvAH8WTp
         IdPgVBGwp9e+ORWfUk7gSnYgS5NQpw3mAzMXTql9I8CKd3h5GCIAkYJb3Tfj87GRpJAh
         tIBCB0M2/2LpN+nmET1vTOg0ZVCVSBZmoCBovVjfJDbQCGKFmEpSPLpLIQz+Jpy/qEYn
         9JxY+oi/DXovk5j+rw/AAKmKeX4+GsePTm/r/ceZds/cI4KnmCpFP76YcdKLckLkyyHl
         OnCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728660577; x=1729265377;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d2O0wF//mc3QHjPTSSLktyXdiyqG45d84oFd85Asuek=;
        b=GTOvWHf/iG3OKA8xt9CJE0ZTJb/9JS0vEsQIeKu4bAlrI1xqKdnbFzhVSf1UjUtB5G
         m1Ow/uN6Hm9QYTL5m+WcbvTuOYbNs3fU+KKu974LrZB8q8ZCqvKGPb5ifeAeQcH0fO+f
         RQXr7f5RthxI47ykjK/q0dUDuBGmizNEtFtsroaoAECeCtO/zL9B05SiW5aENlwOg95m
         qdI4V6GGv6tufEaXuriIbJJoCMvdSA22r3RFDRImssxoid0JlySEVmHqv0YIAT8Y3aVr
         tjv2vyRQ9+pbvW0MnQJBQv6mpoi8EiTdhZzfpfTZutvKKk/NRoTi7s3epEOTnVOUwAsu
         cWHg==
X-Forwarded-Encrypted: i=1; AJvYcCUcXJTEpHL9zx2Ji+tMW63+TyvXv5jXpcK4U7uFETjyxUD7bI0QL+0PozDbBeKZNcTWhnDJxy0GOHLOtS0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxItbdbWJxCRl14G9lXQhAdKNsQ36qRLLQ182NREpI62AIVZXgL
	S/7to1/dlhnYppZrJSRSfvUPVaWy3O1BANEbCLcnQKn6CnnhixQeeEwJbDedJlmO4g==
X-Google-Smtp-Source: AGHT+IGuY7K33VVtb1/IVAdFqPLNCq5hLo9e+WM8qmOWVaMyxPlSM6TQvdr4NBnQX4xdH5WWGBJ09g==
X-Received: by 2002:a05:6a21:393:b0:1d2:f00e:47bb with SMTP id adf61e73a8af0-1d8bcf3e69fmr3962128637.21.1728660576451;
        Fri, 11 Oct 2024 08:29:36 -0700 (PDT)
Received: from fedora.. ([2405:201:d007:50c2:4888:86b4:6f32:9ae])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e2ab0a5c1sm2700140b3a.194.2024.10.11.08.29.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 08:29:35 -0700 (PDT)
From: Vamsi Krishna Brahmajosyula <vamsikrishna.brahmajosyula@gmail.com>
To: maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch
Cc: skhan@linuxfoundation.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drm/edid: transition to passing struct cea_db * to cae_db_payload_len
Date: Fri, 11 Oct 2024 20:59:29 +0530
Message-ID: <20241011152929.10145-1-vamsikrishna.brahmajosyula@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Address the FIXME in cea_db_payload_len
	Transition to passing struct cea_db * everywhere

Precompute the payload length in drm_parse_cea_ext and pass to
individual parsers to avoid casting struct cea_db pointer to u8
pointer where length is needed.

Since the type of payload length is inconsistent in the file,
use u8, u16 where it was already in place, use int elsewhere.

Signed-off-by: Vamsi Krishna Brahmajosyula <vamsikrishna.brahmajosyula@gmail.com>
---
 drivers/gpu/drm/drm_edid.c | 63 ++++++++++++++++----------------------
 1 file changed, 27 insertions(+), 36 deletions(-)

diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
index 855beafb76ff..80442e8b8ac6 100644
--- a/drivers/gpu/drm/drm_edid.c
+++ b/drivers/gpu/drm/drm_edid.c
@@ -4977,11 +4977,8 @@ static int cea_db_tag(const struct cea_db *db)
 	return db->tag_length >> 5;
 }
 
-static int cea_db_payload_len(const void *_db)
+static int cea_db_payload_len(const struct cea_db *db)
 {
-	/* FIXME: Transition to passing struct cea_db * everywhere. */
-	const struct cea_db *db = _db;
-
 	return db->tag_length & 0x1f;
 }
 
@@ -5432,22 +5429,18 @@ static uint8_t hdr_metadata_type(const u8 *edid_ext)
 }
 
 static void
-drm_parse_hdr_metadata_block(struct drm_connector *connector, const u8 *db)
+drm_parse_hdr_metadata_block(struct drm_connector *connector, const u8 *db, const u16 payload_len)
 {
-	u16 len;
-
-	len = cea_db_payload_len(db);
-
 	connector->hdr_sink_metadata.hdmi_type1.eotf =
 						eotf_supported(db);
 	connector->hdr_sink_metadata.hdmi_type1.metadata_type =
 						hdr_metadata_type(db);
 
-	if (len >= 4)
+	if (payload_len >= 4)
 		connector->hdr_sink_metadata.hdmi_type1.max_cll = db[4];
-	if (len >= 5)
+	if (payload_len >= 5)
 		connector->hdr_sink_metadata.hdmi_type1.max_fall = db[5];
-	if (len >= 6) {
+	if (payload_len >= 6) {
 		connector->hdr_sink_metadata.hdmi_type1.min_cll = db[6];
 
 		/* Calculate only when all values are available */
@@ -5457,20 +5450,18 @@ drm_parse_hdr_metadata_block(struct drm_connector *connector, const u8 *db)
 
 /* HDMI Vendor-Specific Data Block (HDMI VSDB, H14b-VSDB) */
 static void
-drm_parse_hdmi_vsdb_audio(struct drm_connector *connector, const u8 *db)
+drm_parse_hdmi_vsdb_audio(struct drm_connector *connector, const u8 *db, u8 payload_len)
 {
-	u8 len = cea_db_payload_len(db);
-
-	if (len >= 6 && (db[6] & (1 << 7)))
+	if (payload_len >= 6 && (db[6] & (1 << 7)))
 		connector->eld[DRM_ELD_SAD_COUNT_CONN_TYPE] |= DRM_ELD_SUPPORTS_AI;
 
-	if (len >= 10 && hdmi_vsdb_latency_present(db)) {
+	if (payload_len >= 10 && hdmi_vsdb_latency_present(db)) {
 		connector->latency_present[0] = true;
 		connector->video_latency[0] = db[9];
 		connector->audio_latency[0] = db[10];
 	}
 
-	if (len >= 12 && hdmi_vsdb_i_latency_present(db)) {
+	if (payload_len >= 12 && hdmi_vsdb_i_latency_present(db)) {
 		connector->latency_present[1] = true;
 		connector->video_latency[1] = db[11];
 		connector->audio_latency[1] = db[12];
@@ -5695,7 +5686,7 @@ static void drm_edid_to_eld(struct drm_connector *connector,
 		case CTA_DB_VENDOR:
 			/* HDMI Vendor-Specific Data Block */
 			if (cea_db_is_hdmi_vsdb(db))
-				drm_parse_hdmi_vsdb_audio(connector, (const u8 *)db);
+				drm_parse_hdmi_vsdb_audio(connector, (const u8 *)db, len);
 			break;
 		default:
 			break;
@@ -6122,7 +6113,7 @@ static void drm_parse_ycbcr420_deep_color_info(struct drm_connector *connector,
 }
 
 static void drm_parse_dsc_info(struct drm_hdmi_dsc_cap *hdmi_dsc,
-			       const u8 *hf_scds)
+			       const u8 *hf_scds, int payload_len)
 {
 	hdmi_dsc->v_1p2 = hf_scds[11] & DRM_EDID_DSC_1P2;
 
@@ -6142,7 +6133,7 @@ static void drm_parse_dsc_info(struct drm_hdmi_dsc_cap *hdmi_dsc,
 		/* Supports min 8 BPC if DSC 1.2 is supported*/
 		hdmi_dsc->bpc_supported = 8;
 
-	if (cea_db_payload_len(hf_scds) >= 12 && hf_scds[12]) {
+	if (payload_len >= 12 && hf_scds[12]) {
 		u8 dsc_max_slices;
 		u8 dsc_max_frl_rate;
 
@@ -6188,13 +6179,13 @@ static void drm_parse_dsc_info(struct drm_hdmi_dsc_cap *hdmi_dsc,
 		}
 	}
 
-	if (cea_db_payload_len(hf_scds) >= 13 && hf_scds[13])
+	if (payload_len >= 13 && hf_scds[13])
 		hdmi_dsc->total_chunk_kbytes = hf_scds[13] & DRM_EDID_DSC_TOTAL_CHUNK_KBYTES;
 }
 
 /* Sink Capability Data Structure */
 static void drm_parse_hdmi_forum_scds(struct drm_connector *connector,
-				      const u8 *hf_scds)
+				      const u8 *hf_scds, int payload_len)
 {
 	struct drm_display_info *info = &connector->display_info;
 	struct drm_hdmi_info *hdmi = &info->hdmi;
@@ -6247,8 +6238,8 @@ static void drm_parse_hdmi_forum_scds(struct drm_connector *connector,
 
 	drm_parse_ycbcr420_deep_color_info(connector, hf_scds);
 
-	if (cea_db_payload_len(hf_scds) >= 11 && hf_scds[11]) {
-		drm_parse_dsc_info(hdmi_dsc, hf_scds);
+	if (payload_len >= 11 && hf_scds[11]) {
+		drm_parse_dsc_info(hdmi_dsc, hf_scds, payload_len);
 		dsc_support = true;
 	}
 
@@ -6259,7 +6250,7 @@ static void drm_parse_hdmi_forum_scds(struct drm_connector *connector,
 }
 
 static void drm_parse_hdmi_deep_color_info(struct drm_connector *connector,
-					   const u8 *hdmi)
+					   const u8 *hdmi, const u8 payload_len)
 {
 	struct drm_display_info *info = &connector->display_info;
 	unsigned int dc_bpc = 0;
@@ -6267,7 +6258,7 @@ static void drm_parse_hdmi_deep_color_info(struct drm_connector *connector,
 	/* HDMI supports at least 8 bpc */
 	info->bpc = 8;
 
-	if (cea_db_payload_len(hdmi) < 6)
+	if (payload_len < 6)
 		return;
 
 	if (hdmi[6] & DRM_EDID_HDMI_DC_30) {
@@ -6320,18 +6311,17 @@ static void drm_parse_hdmi_deep_color_info(struct drm_connector *connector,
 
 /* HDMI Vendor-Specific Data Block (HDMI VSDB, H14b-VSDB) */
 static void
-drm_parse_hdmi_vsdb_video(struct drm_connector *connector, const u8 *db)
+drm_parse_hdmi_vsdb_video(struct drm_connector *connector, const u8 *db, const u8 payload_len)
 {
 	struct drm_display_info *info = &connector->display_info;
-	u8 len = cea_db_payload_len(db);
 
 	info->is_hdmi = true;
 
 	info->source_physical_address = (db[4] << 8) | db[5];
 
-	if (len >= 6)
+	if (payload_len >= 6)
 		info->dvi_dual = db[6] & 1;
-	if (len >= 7)
+	if (payload_len >= 7)
 		info->max_tmds_clock = db[7] * 5000;
 
 	/*
@@ -6340,14 +6330,14 @@ drm_parse_hdmi_vsdb_video(struct drm_connector *connector, const u8 *db)
 	 * HDMI infoframe support was first added in HDMI 1.4. Assume the sink
 	 * supports infoframes if HDMI_Video_present is set.
 	 */
-	if (len >= 8 && db[8] & BIT(5))
+	if (payload_len >= 8 && db[8] & BIT(5))
 		info->has_hdmi_infoframe = true;
 
 	drm_dbg_kms(connector->dev, "[CONNECTOR:%d:%s] HDMI: DVI dual %d, max TMDS clock %d kHz\n",
 		    connector->base.id, connector->name,
 		    info->dvi_dual, info->max_tmds_clock);
 
-	drm_parse_hdmi_deep_color_info(connector, db);
+	drm_parse_hdmi_deep_color_info(connector, db, payload_len);
 }
 
 /*
@@ -6410,12 +6400,13 @@ static void drm_parse_cea_ext(struct drm_connector *connector,
 	cea_db_iter_for_each(db, &iter) {
 		/* FIXME: convert parsers to use struct cea_db */
 		const u8 *data = (const u8 *)db;
+		int len = cea_db_payload_len(db);
 
 		if (cea_db_is_hdmi_vsdb(db))
-			drm_parse_hdmi_vsdb_video(connector, data);
+			drm_parse_hdmi_vsdb_video(connector, data, len);
 		else if (cea_db_is_hdmi_forum_vsdb(db) ||
 			 cea_db_is_hdmi_forum_scdb(db))
-			drm_parse_hdmi_forum_scds(connector, data);
+			drm_parse_hdmi_forum_scds(connector, data, len);
 		else if (cea_db_is_microsoft_vsdb(db))
 			drm_parse_microsoft_vsdb(connector, data);
 		else if (cea_db_is_y420cmdb(db))
@@ -6425,7 +6416,7 @@ static void drm_parse_cea_ext(struct drm_connector *connector,
 		else if (cea_db_is_vcdb(db))
 			drm_parse_vcdb(connector, data);
 		else if (cea_db_is_hdmi_hdr_metadata_block(db))
-			drm_parse_hdr_metadata_block(connector, data);
+			drm_parse_hdr_metadata_block(connector, data, len);
 		else if (cea_db_tag(db) == CTA_DB_VIDEO)
 			parse_cta_vdb(connector, db);
 		else if (cea_db_tag(db) == CTA_DB_AUDIO)

base-commit: 1d227fcc72223cbdd34d0ce13541cbaab5e0d72f
-- 
2.47.0


