Return-Path: <linux-kernel+bounces-383488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 846119B1C68
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 08:52:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 105BC1F21895
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 07:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34372137C37;
	Sun, 27 Oct 2024 07:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dlis9No5"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B03126C16
	for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2024 07:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730015497; cv=none; b=ITdWDol9bUK4HeuDCkIClVzNjrBhzPmRrQietxEsB9yxohLS7/Zxszl+gqdCxXqTj2pPq8be5dJGd/gCZOc0L1Pw2skAjSyYSJsAGL3KrAPMe6qq3kmbSpzk4D++QcmMkuVbDmQernPIb2SU/vJAzgCggO/9LgH7RchWXPqVn3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730015497; c=relaxed/simple;
	bh=0tz+h/hAgKYZROcBZNAAejjPVBrffdAhZK9wYZf9Vxc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M/ay0NYAdiLJFI8JfRvk4tCN/1wGgcQ/9LWKoTyRrQAyIzOPw1kztxfCGijlKG72fOmwfz0Gmkt8wzKNGGvMUW0jGErVVawOp8c844kqBkSoFPAPPOojALyeBgkIyznvLSpDyLtha15FL8glMoucOKLaUb+11HrDWyopZPK1tmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dlis9No5; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-71e6cec7227so2736461b3a.0
        for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2024 00:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730015495; x=1730620295; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zOn93d9tLichC+5tHiWOkakuU/3lAA1dF93RrhXoO/E=;
        b=Dlis9No5cbrosCCWIXuQkSyWv3CCAbfGBmOzgwBF2ek6RU6O6IpzWyLr5swrJ7YmQE
         1eO+YNbGbYweJ6iD987Jr4+2AB8LvsKRUZ2e2qeNJ+WQzZjxQ+QKEfZRvc+o9XuG0UD6
         r+aIWzfsyyx1u3p5LhNmk0aTAQ+P1SeS+u8lddfyyeSOkPfQSgyN7B4GIax5/CQW9F4g
         WhDX53KkezMTx3p0XMjYnh0StbKOF2l7Hn+NrahPoRpWQn0FSXsFTTW0O3ON4o39kZtt
         ackdJlXDTYbri0EGSsrggVW37KdBzlE4SX28gy1hZDBNaQ0qM1pCTi7n3t5MUvIUnAeS
         fkdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730015495; x=1730620295;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zOn93d9tLichC+5tHiWOkakuU/3lAA1dF93RrhXoO/E=;
        b=Rk/xbjGH1OlW04JQRmXOlPXtb+5K7vqF9RC0U3Kf9ggOy4oo5YPLBmGzJX63VR8Aok
         vwg/+IFqBZlCU3AaoLzWLxXngrS+HzX7M8cS8qBU6yw3m7BoyO73wqvI54rZrZJqJpmy
         ZMCbiXqHkjuHTgwXrjALCzL8/kTwLuWkEqmFqV7n0+ZiuVJdVxm4Eymwmh+0mUAadgRs
         2lQ/Xh9ccPpoYcDdo8hA/sMIXfH7yL1rE1J4OXfeysp2yYPDquO3OBpXsYB8CRDNGZJY
         NKAx1PNLIh2XK+BuN++z4seHeL8jVXR7fe3yqqBl3uTPdBgvdyAVpoKGB1jdbMkV07Iy
         mncA==
X-Forwarded-Encrypted: i=1; AJvYcCVUHZQ9BYKel3csO42uo8++mphsLd6i3s7cUU2iWPACZ3YHFW/wvFM5rM+9qOtfBZYyU0Zg0pYjjHonlyU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRsEYxWW+qeqva8JXQnwHC94RI+4wHrYi2pFH7W+Yf/2GSpP6h
	NybM/Wgq0fENBaKM+t3Frqgkq0BetRilQk2wLtbqFXBfVEL+9y/l
X-Google-Smtp-Source: AGHT+IHuwf5v8s7V3KbWx323aO0dVtPL/Va9rCXnkmlyIBRqfcRtNaZ7kC0WQpGCrrX/ks4HwY371A==
X-Received: by 2002:a05:6a00:b55:b0:71e:744a:3fbd with SMTP id d2e1a72fcca58-7206306df29mr7284417b3a.20.1730015494847;
        Sun, 27 Oct 2024 00:51:34 -0700 (PDT)
Received: from fedora.. ([2405:201:d007:50c2:b7e7:6df3:9958:a45d])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7205794f9a1sm3785551b3a.90.2024.10.27.00.51.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Oct 2024 00:51:34 -0700 (PDT)
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
Subject: [PATCH 5/5] drm/edid: convert drm_parse_hdr_metadata_block to use struct cea_db *
Date: Sun, 27 Oct 2024 13:21:08 +0530
Message-ID: <20241027075108.14273-6-vamsikrishna.brahmajosyula@gmail.com>
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
in the parser drm_parse_hdr_metadata_block

cea_db contains len and then data. Appropriately change the indices
when referring to individual elements (db[n] becomes data[n-1]).

Signed-off-by: Vamsi Krishna Brahmajosyula <vamsikrishna.brahmajosyula@gmail.com>
---
 drivers/gpu/drm/drm_edid.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
index d9fa994a3acc..8b2b75885027 100644
--- a/drivers/gpu/drm/drm_edid.c
+++ b/drivers/gpu/drm/drm_edid.c
@@ -5418,7 +5418,7 @@ static void drm_calculate_luminance_range(struct drm_connector *connector)
 
 static uint8_t eotf_supported(const u8 *edid_ext)
 {
-	return edid_ext[2] &
+	return edid_ext[1] &
 		(BIT(HDMI_EOTF_TRADITIONAL_GAMMA_SDR) |
 		 BIT(HDMI_EOTF_TRADITIONAL_GAMMA_HDR) |
 		 BIT(HDMI_EOTF_SMPTE_ST2084) |
@@ -5427,28 +5427,29 @@ static uint8_t eotf_supported(const u8 *edid_ext)
 
 static uint8_t hdr_metadata_type(const u8 *edid_ext)
 {
-	return edid_ext[3] &
+	return edid_ext[2] &
 		BIT(HDMI_STATIC_METADATA_TYPE1);
 }
 
 static void
-drm_parse_hdr_metadata_block(struct drm_connector *connector, const u8 *db)
+drm_parse_hdr_metadata_block(struct drm_connector *connector, const struct cea_db *db)
 {
 	u16 len;
 
 	len = cea_db_payload_len(db);
+	const u8 *data = cea_db_data(db);
 
 	connector->hdr_sink_metadata.hdmi_type1.eotf =
-						eotf_supported(db);
+						eotf_supported(data);
 	connector->hdr_sink_metadata.hdmi_type1.metadata_type =
-						hdr_metadata_type(db);
+						hdr_metadata_type(data);
 
 	if (len >= 4)
-		connector->hdr_sink_metadata.hdmi_type1.max_cll = db[4];
+		connector->hdr_sink_metadata.hdmi_type1.max_cll = data[3];
 	if (len >= 5)
-		connector->hdr_sink_metadata.hdmi_type1.max_fall = db[5];
+		connector->hdr_sink_metadata.hdmi_type1.max_fall = data[4];
 	if (len >= 6) {
-		connector->hdr_sink_metadata.hdmi_type1.min_cll = db[6];
+		connector->hdr_sink_metadata.hdmi_type1.min_cll = data[5];
 
 		/* Calculate only when all values are available */
 		drm_calculate_luminance_range(connector);
@@ -6416,9 +6417,6 @@ static void drm_parse_cea_ext(struct drm_connector *connector,
 
 	cea_db_iter_edid_begin(drm_edid, &iter);
 	cea_db_iter_for_each(db, &iter) {
-		/* FIXME: convert parsers to use struct cea_db */
-		const u8 *data = (const u8 *)db;
-
 		if (cea_db_is_hdmi_vsdb(db))
 			drm_parse_hdmi_vsdb_video(connector, db);
 		else if (cea_db_is_hdmi_forum_vsdb(db) ||
@@ -6433,7 +6431,7 @@ static void drm_parse_cea_ext(struct drm_connector *connector,
 		else if (cea_db_is_vcdb(db))
 			drm_parse_vcdb(connector, db);
 		else if (cea_db_is_hdmi_hdr_metadata_block(db))
-			drm_parse_hdr_metadata_block(connector, data);
+			drm_parse_hdr_metadata_block(connector, db);
 		else if (cea_db_tag(db) == CTA_DB_VIDEO)
 			parse_cta_vdb(connector, db);
 		else if (cea_db_tag(db) == CTA_DB_AUDIO)
-- 
2.47.0


