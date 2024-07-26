Return-Path: <linux-kernel+bounces-263072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B946C93D09C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 11:48:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B94751C20C1A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 09:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A8E7176AAC;
	Fri, 26 Jul 2024 09:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="jOWGv1kf"
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EFE613E3EA
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 09:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721987270; cv=none; b=qPPx8tt4T3D2QgKW8aD1TgtZtVS3kgiTWbmoup9vDAMUuqCbzQtO3SbJ+yuW7hWRB8zMubafzVvp3ok0j04Q9dLEMHrBNCbVWGm8UgiXyXtvRvDIp/nn2y2XrUkaCIWH7WONrHSF9pdOutRu3qZJHLWqzSN32uLMYnn8bk0AJR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721987270; c=relaxed/simple;
	bh=f1Jgm1SW/bZyNrA1MPxl/UUPCfrLD4iDQuVNCuFzFGU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rSnZiHPF53mE98rP8tHUWAVEbasGLG7fY/GCxak1CK7/GHETAZPRAyxfw65rifFVWuwo/+0OmqHL5fTnwnnqpEm8pRW2VvxWEIklsF0sDJQhHuXTQWuVahF9kmw13w8KnP0Sl0upG/8vtqpTuNzNqkYb8tI28E4RwMHGycUmDCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=jOWGv1kf; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1721987259; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=K1O75+dU/oxc7RMbWfEpo6GrZGyE2ZFXuZ+LFp9QDcw=;
	b=jOWGv1kf0f1029Ahsy0Spn2i3SIgsIcfs8c7Q9G7kHyaup6wy9kqjCyUF2iM25XEL8d1PvkPtle2w1pMzqEN+HZ3vhZNY3/LOTQXx2t/JWUOQZMDfGQsLtwwls1g0LJK5YzY4qQM1XSNUDnzuNpEUVfVc031MB7H7niq+BYQ95k=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067109;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0WBLOnXO_1721987249;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0WBLOnXO_1721987249)
          by smtp.aliyun-inc.com;
          Fri, 26 Jul 2024 17:47:38 +0800
From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To: harry.wentland@amd.com
Cc: sunpeng.li@amd.com,
	Rodrigo.Siqueira@amd.com,
	alexander.deucher@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] drm/amd/display: Use ARRAY_SIZE for array length
Date: Fri, 26 Jul 2024 17:47:28 +0800
Message-Id: <20240726094728.1161-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use of macro ARRAY_SIZE to calculate array size minimizes
the redundant code and improves code reusability.

./drivers/gpu/drm/amd/display/dc/spl/dc_spl_scl_easf_filters.c:1552:57-58: WARNING: Use ARRAY_SIZE.
./drivers/gpu/drm/amd/display/dc/spl/dc_spl_scl_easf_filters.c:1561:57-58: WARNING: Use ARRAY_SIZE.
./drivers/gpu/drm/amd/display/dc/spl/dc_spl_scl_easf_filters.c:1573:53-54: WARNING: Use ARRAY_SIZE.
./drivers/gpu/drm/amd/display/dc/spl/dc_spl_scl_easf_filters.c:1578:53-54: WARNING: Use ARRAY_SIZE.
./drivers/gpu/drm/amd/display/dc/spl/dc_spl_scl_easf_filters.c:1592:53-54: WARNING: Use ARRAY_SIZE.
./drivers/gpu/drm/amd/display/dc/spl/dc_spl_scl_easf_filters.c:1597:53-54: WARNING: Use ARRAY_SIZE.
./drivers/gpu/drm/amd/display/dc/spl/dc_spl_scl_easf_filters.c:1611:50-51: WARNING: Use ARRAY_SIZE.
./drivers/gpu/drm/amd/display/dc/spl/dc_spl_scl_easf_filters.c:1616:50-51: WARNING: Use ARRAY_SIZE.
./drivers/gpu/drm/amd/display/dc/spl/dc_spl_scl_easf_filters.c:1630:50-51: WARNING: Use ARRAY_SIZE.
./drivers/gpu/drm/amd/display/dc/spl/dc_spl_scl_easf_filters.c:1635:50-51: WARNING: Use ARRAY_SIZE.
./drivers/gpu/drm/amd/display/dc/spl/dc_spl_scl_easf_filters.c:1649:60-61: WARNING: Use ARRAY_SIZE.
./drivers/gpu/drm/amd/display/dc/spl/dc_spl_scl_easf_filters.c:1663:53-54: WARNING: Use ARRAY_SIZE.
./drivers/gpu/drm/amd/display/dc/spl/dc_spl_scl_easf_filters.c:1677:52-53: WARNING: Use ARRAY_SIZE.
./drivers/gpu/drm/amd/display/dc/spl/dc_spl_scl_easf_filters.c:1691:53-54: WARNING: Use ARRAY_SIZE.
./drivers/gpu/drm/amd/display/dc/spl/dc_spl_scl_easf_filters.c:1705:53-54: WARNING: Use ARRAY_SIZE.
./drivers/gpu/drm/amd/display/dc/spl/dc_spl_scl_easf_filters.c:1719:54-55: WARNING: Use ARRAY_SIZE.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=9580
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 .../display/dc/spl/dc_spl_scl_easf_filters.c  | 63 ++++++-------------
 1 file changed, 20 insertions(+), 43 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/spl/dc_spl_scl_easf_filters.c b/drivers/gpu/drm/amd/display/dc/spl/dc_spl_scl_easf_filters.c
index 09bf82f7d468..e847af94419a 100644
--- a/drivers/gpu/drm/amd/display/dc/spl/dc_spl_scl_easf_filters.c
+++ b/drivers/gpu/drm/amd/display/dc/spl/dc_spl_scl_easf_filters.c
@@ -1530,14 +1530,13 @@ static uint32_t spl_easf_get_scale_ratio_to_reg_value(struct spl_fixed31_32 rati
 	value = lookup_table_index_ptr->reg_value;
 
 	while (count < num_entries) {
-
 		lookup_table_index_ptr = (lookup_table_base_ptr + count);
 		if (lookup_table_index_ptr->numer < 0)
 			break;
 
 		if (ratio.value < spl_fixpt_from_fraction(
-			lookup_table_index_ptr->numer,
-			lookup_table_index_ptr->denom).value) {
+		    lookup_table_index_ptr->numer,
+		    lookup_table_index_ptr->denom).value) {
 			value = lookup_table_index_ptr->reg_value;
 			break;
 		}
@@ -1548,21 +1547,13 @@ static uint32_t spl_easf_get_scale_ratio_to_reg_value(struct spl_fixed31_32 rati
 }
 uint32_t spl_get_v_bf3_mode(struct spl_fixed31_32 ratio)
 {
-	uint32_t value;
-	unsigned int num_entries = sizeof(easf_v_bf3_mode_lookup) /
-		sizeof(struct scale_ratio_to_reg_value_lookup);
-	value = spl_easf_get_scale_ratio_to_reg_value(ratio,
-		easf_v_bf3_mode_lookup, num_entries);
-	return value;
+	unsigned int num_entries = ARRAY_SIZE(easf_v_bf3_mode_lookup);
+	return spl_easf_get_scale_ratio_to_reg_value(ratio, easf_v_bf3_mode_lookup, num_entries);
 }
 uint32_t spl_get_h_bf3_mode(struct spl_fixed31_32 ratio)
 {
-	uint32_t value;
-	unsigned int num_entries = sizeof(easf_h_bf3_mode_lookup) /
-		sizeof(struct scale_ratio_to_reg_value_lookup);
-	value = spl_easf_get_scale_ratio_to_reg_value(ratio,
-		easf_h_bf3_mode_lookup, num_entries);
-	return value;
+	unsigned int num_entries = ARRAY_SIZE(easf_h_bf3_mode_lookup);
+	return spl_easf_get_scale_ratio_to_reg_value(ratio, easf_h_bf3_mode_lookup, num_entries);
 }
 uint32_t spl_get_reducer_gain6(int taps, struct spl_fixed31_32 ratio)
 {
@@ -1570,13 +1561,11 @@ uint32_t spl_get_reducer_gain6(int taps, struct spl_fixed31_32 ratio)
 	unsigned int num_entries;
 
 	if (taps == 4) {
-		num_entries = sizeof(easf_reducer_gain6_4tap_lookup) /
-			sizeof(struct scale_ratio_to_reg_value_lookup);
+		num_entries = ARRAY_SIZE(easf_reducer_gain6_4tap_lookup);
 		value = spl_easf_get_scale_ratio_to_reg_value(ratio,
 			easf_reducer_gain6_4tap_lookup, num_entries);
 	} else if (taps == 6) {
-		num_entries = sizeof(easf_reducer_gain6_6tap_lookup) /
-			sizeof(struct scale_ratio_to_reg_value_lookup);
+		num_entries = ARRAY_SIZE(easf_reducer_gain6_6tap_lookup);
 		value = spl_easf_get_scale_ratio_to_reg_value(ratio,
 			easf_reducer_gain6_6tap_lookup, num_entries);
 	} else
@@ -1589,13 +1578,11 @@ uint32_t spl_get_reducer_gain4(int taps, struct spl_fixed31_32 ratio)
 	unsigned int num_entries;
 
 	if (taps == 4) {
-		num_entries = sizeof(easf_reducer_gain4_4tap_lookup) /
-			sizeof(struct scale_ratio_to_reg_value_lookup);
+		num_entries = ARRAY_SIZE(easf_reducer_gain4_4tap_lookup);
 		value = spl_easf_get_scale_ratio_to_reg_value(ratio,
 			easf_reducer_gain4_4tap_lookup, num_entries);
 	} else if (taps == 6) {
-		num_entries = sizeof(easf_reducer_gain4_6tap_lookup) /
-			sizeof(struct scale_ratio_to_reg_value_lookup);
+		num_entries = ARRAY_SIZE(easf_reducer_gain4_6tap_lookup);
 		value = spl_easf_get_scale_ratio_to_reg_value(ratio,
 			easf_reducer_gain4_6tap_lookup, num_entries);
 	} else
@@ -1608,13 +1595,11 @@ uint32_t spl_get_gainRing6(int taps, struct spl_fixed31_32 ratio)
 	unsigned int num_entries;
 
 	if (taps == 4) {
-		num_entries = sizeof(easf_gain_ring6_4tap_lookup) /
-			sizeof(struct scale_ratio_to_reg_value_lookup);
+		num_entries = ARRAY_SIZE(easf_gain_ring6_4tap_lookup);
 		value = spl_easf_get_scale_ratio_to_reg_value(ratio,
 			easf_gain_ring6_4tap_lookup, num_entries);
 	} else if (taps == 6) {
-		num_entries = sizeof(easf_gain_ring6_6tap_lookup) /
-			sizeof(struct scale_ratio_to_reg_value_lookup);
+		num_entries = ARRAY_SIZE(easf_gain_ring6_6tap_lookup);
 		value = spl_easf_get_scale_ratio_to_reg_value(ratio,
 			easf_gain_ring6_6tap_lookup, num_entries);
 	} else
@@ -1627,13 +1612,11 @@ uint32_t spl_get_gainRing4(int taps, struct spl_fixed31_32 ratio)
 	unsigned int num_entries;
 
 	if (taps == 4) {
-		num_entries = sizeof(easf_gain_ring4_4tap_lookup) /
-			sizeof(struct scale_ratio_to_reg_value_lookup);
+		num_entries = ARRAY_SIZE(easf_gain_ring4_4tap_lookup);
 		value = spl_easf_get_scale_ratio_to_reg_value(ratio,
 			easf_gain_ring4_4tap_lookup, num_entries);
 	} else if (taps == 6) {
-		num_entries = sizeof(easf_gain_ring4_6tap_lookup) /
-			sizeof(struct scale_ratio_to_reg_value_lookup);
+		num_entries = ARRAY_SIZE(easf_gain_ring4_6tap_lookup);
 		value = spl_easf_get_scale_ratio_to_reg_value(ratio,
 			easf_gain_ring4_6tap_lookup, num_entries);
 	} else
@@ -1646,8 +1629,7 @@ uint32_t spl_get_3tap_dntilt_uptilt_offset(int taps, struct spl_fixed31_32 ratio
 	unsigned int num_entries;
 
 	if (taps == 3) {
-		num_entries = sizeof(easf_3tap_dntilt_uptilt_offset_lookup) /
-			sizeof(struct scale_ratio_to_reg_value_lookup);
+		num_entries = ARRAY_SIZE(easf_3tap_dntilt_uptilt_offset_lookup);
 		value = spl_easf_get_scale_ratio_to_reg_value(ratio,
 			easf_3tap_dntilt_uptilt_offset_lookup, num_entries);
 	} else
@@ -1660,8 +1642,7 @@ uint32_t spl_get_3tap_uptilt_maxval(int taps, struct spl_fixed31_32 ratio)
 	unsigned int num_entries;
 
 	if (taps == 3) {
-		num_entries = sizeof(easf_3tap_uptilt_maxval_lookup) /
-			sizeof(struct scale_ratio_to_reg_value_lookup);
+		num_entries = ARRAY_SIZE(easf_3tap_uptilt_maxval_lookup);
 		value = spl_easf_get_scale_ratio_to_reg_value(ratio,
 			easf_3tap_uptilt_maxval_lookup, num_entries);
 	} else
@@ -1674,8 +1655,7 @@ uint32_t spl_get_3tap_dntilt_slope(int taps, struct spl_fixed31_32 ratio)
 	unsigned int num_entries;
 
 	if (taps == 3) {
-		num_entries = sizeof(easf_3tap_dntilt_slope_lookup) /
-			sizeof(struct scale_ratio_to_reg_value_lookup);
+		num_entries = ARRAY_SIZE(easf_3tap_dntilt_slope_lookup);
 		value = spl_easf_get_scale_ratio_to_reg_value(ratio,
 			easf_3tap_dntilt_slope_lookup, num_entries);
 	} else
@@ -1688,8 +1668,7 @@ uint32_t spl_get_3tap_uptilt1_slope(int taps, struct spl_fixed31_32 ratio)
 	unsigned int num_entries;
 
 	if (taps == 3) {
-		num_entries = sizeof(easf_3tap_uptilt1_slope_lookup) /
-			sizeof(struct scale_ratio_to_reg_value_lookup);
+		num_entries = ARRAY_SIZE(easf_3tap_uptilt1_slope_lookup);
 		value = spl_easf_get_scale_ratio_to_reg_value(ratio,
 			easf_3tap_uptilt1_slope_lookup, num_entries);
 	} else
@@ -1702,8 +1681,7 @@ uint32_t spl_get_3tap_uptilt2_slope(int taps, struct spl_fixed31_32 ratio)
 	unsigned int num_entries;
 
 	if (taps == 3) {
-		num_entries = sizeof(easf_3tap_uptilt2_slope_lookup) /
-			sizeof(struct scale_ratio_to_reg_value_lookup);
+		num_entries = ARRAY_SIZE(easf_3tap_uptilt2_slope_lookup);
 		value = spl_easf_get_scale_ratio_to_reg_value(ratio,
 			easf_3tap_uptilt2_slope_lookup, num_entries);
 	} else
@@ -1716,8 +1694,7 @@ uint32_t spl_get_3tap_uptilt2_offset(int taps, struct spl_fixed31_32 ratio)
 	unsigned int num_entries;
 
 	if (taps == 3) {
-		num_entries = sizeof(easf_3tap_uptilt2_offset_lookup) /
-			sizeof(struct scale_ratio_to_reg_value_lookup);
+		num_entries = ARRAY_SIZE(easf_3tap_uptilt2_offset_lookup);
 		value = spl_easf_get_scale_ratio_to_reg_value(ratio,
 			easf_3tap_uptilt2_offset_lookup, num_entries);
 	} else
-- 
2.32.0.3.g01195cf9f


