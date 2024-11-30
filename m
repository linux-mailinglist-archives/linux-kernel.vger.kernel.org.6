Return-Path: <linux-kernel+bounces-426067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 41C349DEE75
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 02:53:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAEDC160F88
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 01:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E32FF139D05;
	Sat, 30 Nov 2024 01:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ht02jFeB"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1481013212A
	for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 01:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732931567; cv=none; b=mfTfb5coq89aPqn8A82BrFZvhMsTpcqSFnZFvZDISlmk0j+S2+bpOx2eujYfky40+1Vj7DLlO/2ZV/D4faj6wl3hb0wry97nFwiIoDjP6mSSNCUzpxDjX90a8sohQWUYowz7vQUJeCKuNLyEXsjM9MGrJqNuxQF1Tt+89h2xB1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732931567; c=relaxed/simple;
	bh=SFx9qDoDtf8/ClhxV5ehooUfNSt8Uly/4cPlmvRLZS8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Fs2shs4hCdqlNPD78l/p4rvzoJnIXY4B85aBUQEPxP2l+FADU9BLZpQ7PlmBOSh6u6s5BYEeUAZhgO5Cr0TlN58sm8yt45Jbq/2RpW5VpnP0B6IKznTommsx0i3zST594fxPzlq+cI2zN+OCD1YXMk+19+sYDDdUST7aenYldBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ht02jFeB; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-53df7f6a133so2580600e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 17:52:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732931563; x=1733536363; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4GXhZxLlG0np8t2RRMsMP/s3gGMuI1S/859XP5wOxy4=;
        b=ht02jFeB8FsDM7XHYjt35sd/CDk+5zPonCbYR0Ki1itJGSLhBsU5liRDkGsUZA/UZL
         aOKWjN1mvsr3i+hdCHku8g+tcppLk9zhiYFPQcq7L1LZPSwHxjxH77v0c/BtNGT+LFNk
         lmuS4ed6EnDW2Ej4XAPW/mKBPFTXR9yaJyQptO0PX8ZpVgDChqmXrMg4F2eNHeOhqxuJ
         jZzWepW+2PWIiTj9kEi7/9k6uHz6BUlhdz4jxgDixzlbCHwZGuvsUGnI7m7XGxWPLx2j
         XPZ1plMOCWYmqrw7fILDe6GT1x0vABiAnWoyTL6THqrI7uG+NTzXLNPQ4ZkFb5fL/mfA
         /ddg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732931563; x=1733536363;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4GXhZxLlG0np8t2RRMsMP/s3gGMuI1S/859XP5wOxy4=;
        b=mSI6t1QjnmJ7usNjC7fQzFilMSm1MvFHjr0TPRWdzNqvytnNOpPOVV9/otK47L1yAC
         wlLnvA1sUNItjBoPaep2/9A2Zl1cguqMvfla32JzFF67BSn5i6yp1mXcz1gBcsjakpzS
         MquPkbyMm6llpQMXYc9xi5eabUubghHAPR7Syo94N4tszJbveJlFeCvlxVcpE9Mft+7B
         7XEhswyJJdo3tu/ypUMSFi8zGi9BCupqVrFvE6HgiZyvHOFXzwJ8Tu756F09O33Rb1eJ
         ct6hYzV4AhkNXlMBu2owxyeFCESKuNbDa0EvdAZkKe8ZHXMcNTLMcDG4yDfCTnEa8nJY
         idDg==
X-Forwarded-Encrypted: i=1; AJvYcCWd+evXy/BI+WELARSHE7A7rl4SGWc5DWliKlFrqpi7Z6wLIJI/4Idj3PKuGjU+JxrIGZcDv74Lc7+x/sI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdbR/F4P8nAf7JeA6cmo8w1Rzwd2ssQu1Y0S3qyURcX9nNznpS
	ypkXn/KrC8/Lk93gH2nD4ssoG136gUG4BNqyCc8tEfbsV+H/RAyD1QjAvmzITKs=
X-Gm-Gg: ASbGncskdxpxqF3M5jTXc6WwiNKN3cgcN2pWAMvfNrvDi4c0DSsoxjRPdfOn4J65C3N
	e5ZMEEuvgGeWz9/j+fEykr6xOzbmkZSR4ULg8xo129eXbFypCsMjiuUlI2aCsJSzSFE0lvfhKuJ
	zQOnaqZS4rfBCccpKzbXNN/AlMygMAITLXl/wwIUWYqprOHraEPFwC+5wbZXYoH4mdwpgAXvA37
	S2CI8MYBCvRmkL8qNkND82A5ph1yUUpQEZQ44+dq5JjcuKljW7FGWk//Q==
X-Google-Smtp-Source: AGHT+IHzCC3VLal2t09KyGXdTrnZqoBD6s9H1e6w27VJXRZNs+63jZodp+vebQZsEqxm+fisMjZw8Q==
X-Received: by 2002:a05:6512:3c99:b0:536:56d8:24b4 with SMTP id 2adb3069b0e04-53df00a923fmr9270762e87.5.1732931563212;
        Fri, 29 Nov 2024 17:52:43 -0800 (PST)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53df6443172sm636408e87.84.2024.11.29.17.52.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2024 17:52:41 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sat, 30 Nov 2024 03:52:28 +0200
Subject: [PATCH v5 03/10] drm/tests: hdmi: return meaningful value from
 set_connector_edid()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241130-hdmi-mode-valid-v5-3-742644ec3b1f@linaro.org>
References: <20241130-hdmi-mode-valid-v5-0-742644ec3b1f@linaro.org>
In-Reply-To: <20241130-hdmi-mode-valid-v5-0-742644ec3b1f@linaro.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6746;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=SFx9qDoDtf8/ClhxV5ehooUfNSt8Uly/4cPlmvRLZS8=;
 b=owEBbAGT/pANAwAKAYs8ij4CKSjVAcsmYgBnSm/gMsVCqTL6OubCQChCuT6FJSmh8jZERRg6K
 mfxFGFGwIqJATIEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZ0pv4AAKCRCLPIo+Aiko
 1fWhB/Yueq7VUzSoNF1ykS3TOU4hZM/Wy5aQNvwGjGZRLL2XZ74rBCytu7GaWpVv7hE+pXMrui9
 CTRaZIPBqf6Kn2MNM+N8abOOWui4Z/C2UTZXkZPowCqw33bWHNblznkVc9KnGbOKT0EtMG3nwyz
 r9ftIFGbIZ69qTaaZ828GCaEqe3Xt7wvlxW+40Sa+PWyptvIbmIHUMMo9PaYlGg/hpJGZYv6wy6
 JXT3qIJaJkIii1Y8Pt6y+ESHaEH+qrXD6tPQS15YZEfZXA/46ycMW8c7o0hmVS/I6jdy0AVlMRU
 SYPq95rIpN4camq5/fFFTYRe4Aa4xO7HKZ2a+lg77K+Vdr4=
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

The set_connector_edid() function returns a bogus 0, performing the
check on the connector->funcs->fill_modes() result internally. Make the
function pass the fill_modes()'s return value to the caller and move
corresponding checks to the caller site.

Reviewed-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c | 31 +++++++++++-----------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c b/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c
index 60b1e37522837ee183c65413e3ba6c6ec4fed341..19384b5ff28100b96add35cee86d40cd7d555f1f 100644
--- a/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c
+++ b/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c
@@ -105,9 +105,8 @@ static int set_connector_edid(struct kunit *test, struct drm_connector *connecto
 	mutex_lock(&drm->mode_config.mutex);
 	ret = connector->funcs->fill_modes(connector, 4096, 4096);
 	mutex_unlock(&drm->mode_config.mutex);
-	KUNIT_ASSERT_GT(test, ret, 0);
 
-	return 0;
+	return ret;
 }
 
 static const struct drm_connector_hdmi_funcs dummy_connector_hdmi_funcs = {
@@ -223,7 +222,7 @@ drm_kunit_helper_connector_hdmi_init(struct kunit *test,
 	ret = set_connector_edid(test, conn,
 				 test_edid_hdmi_1080p_rgb_max_200mhz,
 				 ARRAY_SIZE(test_edid_hdmi_1080p_rgb_max_200mhz));
-	KUNIT_ASSERT_EQ(test, ret, 0);
+	KUNIT_ASSERT_GT(test, ret, 0);
 
 	return priv;
 }
@@ -728,7 +727,7 @@ static void drm_test_check_output_bpc_crtc_mode_changed(struct kunit *test)
 	ret = set_connector_edid(test, conn,
 				 test_edid_hdmi_1080p_rgb_yuv_dc_max_200mhz,
 				 ARRAY_SIZE(test_edid_hdmi_1080p_rgb_yuv_dc_max_200mhz));
-	KUNIT_ASSERT_EQ(test, ret, 0);
+	KUNIT_ASSERT_GT(test, ret, 0);
 
 	ctx = drm_kunit_helper_acquire_ctx_alloc(test);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
@@ -802,7 +801,7 @@ static void drm_test_check_output_bpc_crtc_mode_not_changed(struct kunit *test)
 	ret = set_connector_edid(test, conn,
 				 test_edid_hdmi_1080p_rgb_yuv_dc_max_200mhz,
 				 ARRAY_SIZE(test_edid_hdmi_1080p_rgb_yuv_dc_max_200mhz));
-	KUNIT_ASSERT_EQ(test, ret, 0);
+	KUNIT_ASSERT_GT(test, ret, 0);
 
 	ctx = drm_kunit_helper_acquire_ctx_alloc(test);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
@@ -873,7 +872,7 @@ static void drm_test_check_output_bpc_dvi(struct kunit *test)
 	ret = set_connector_edid(test, conn,
 				 test_edid_dvi_1080p,
 				 ARRAY_SIZE(test_edid_dvi_1080p));
-	KUNIT_ASSERT_EQ(test, ret, 0);
+	KUNIT_ASSERT_GT(test, ret, 0);
 
 	info = &conn->display_info;
 	KUNIT_ASSERT_FALSE(test, info->is_hdmi);
@@ -920,7 +919,7 @@ static void drm_test_check_tmds_char_rate_rgb_8bpc(struct kunit *test)
 	ret = set_connector_edid(test, conn,
 				 test_edid_hdmi_1080p_rgb_max_200mhz,
 				 ARRAY_SIZE(test_edid_hdmi_1080p_rgb_max_200mhz));
-	KUNIT_ASSERT_EQ(test, ret, 0);
+	KUNIT_ASSERT_GT(test, ret, 0);
 
 	ctx = drm_kunit_helper_acquire_ctx_alloc(test);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
@@ -967,7 +966,7 @@ static void drm_test_check_tmds_char_rate_rgb_10bpc(struct kunit *test)
 	ret = set_connector_edid(test, conn,
 				 test_edid_hdmi_1080p_rgb_yuv_dc_max_340mhz,
 				 ARRAY_SIZE(test_edid_hdmi_1080p_rgb_yuv_dc_max_340mhz));
-	KUNIT_ASSERT_EQ(test, ret, 0);
+	KUNIT_ASSERT_GT(test, ret, 0);
 
 	ctx = drm_kunit_helper_acquire_ctx_alloc(test);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
@@ -1014,7 +1013,7 @@ static void drm_test_check_tmds_char_rate_rgb_12bpc(struct kunit *test)
 	ret = set_connector_edid(test, conn,
 				 test_edid_hdmi_1080p_rgb_yuv_dc_max_340mhz,
 				 ARRAY_SIZE(test_edid_hdmi_1080p_rgb_yuv_dc_max_340mhz));
-	KUNIT_ASSERT_EQ(test, ret, 0);
+	KUNIT_ASSERT_GT(test, ret, 0);
 
 	ctx = drm_kunit_helper_acquire_ctx_alloc(test);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
@@ -1121,7 +1120,7 @@ static void drm_test_check_max_tmds_rate_bpc_fallback(struct kunit *test)
 	ret = set_connector_edid(test, conn,
 				 test_edid_hdmi_1080p_rgb_yuv_dc_max_200mhz,
 				 ARRAY_SIZE(test_edid_hdmi_1080p_rgb_yuv_dc_max_200mhz));
-	KUNIT_ASSERT_EQ(test, ret, 0);
+	KUNIT_ASSERT_GT(test, ret, 0);
 
 	info = &conn->display_info;
 	KUNIT_ASSERT_TRUE(test, info->is_hdmi);
@@ -1190,7 +1189,7 @@ static void drm_test_check_max_tmds_rate_format_fallback(struct kunit *test)
 	ret = set_connector_edid(test, conn,
 				 test_edid_hdmi_1080p_rgb_yuv_dc_max_200mhz,
 				 ARRAY_SIZE(test_edid_hdmi_1080p_rgb_yuv_dc_max_200mhz));
-	KUNIT_ASSERT_EQ(test, ret, 0);
+	KUNIT_ASSERT_GT(test, ret, 0);
 
 	info = &conn->display_info;
 	KUNIT_ASSERT_TRUE(test, info->is_hdmi);
@@ -1254,7 +1253,7 @@ static void drm_test_check_output_bpc_format_vic_1(struct kunit *test)
 	ret = set_connector_edid(test, conn,
 				 test_edid_hdmi_1080p_rgb_yuv_dc_max_200mhz,
 				 ARRAY_SIZE(test_edid_hdmi_1080p_rgb_yuv_dc_max_200mhz));
-	KUNIT_ASSERT_EQ(test, ret, 0);
+	KUNIT_ASSERT_GT(test, ret, 0);
 
 	info = &conn->display_info;
 	KUNIT_ASSERT_TRUE(test, info->is_hdmi);
@@ -1314,7 +1313,7 @@ static void drm_test_check_output_bpc_format_driver_rgb_only(struct kunit *test)
 	ret = set_connector_edid(test, conn,
 				 test_edid_hdmi_1080p_rgb_yuv_dc_max_200mhz,
 				 ARRAY_SIZE(test_edid_hdmi_1080p_rgb_yuv_dc_max_200mhz));
-	KUNIT_ASSERT_EQ(test, ret, 0);
+	KUNIT_ASSERT_GT(test, ret, 0);
 
 	info = &conn->display_info;
 	KUNIT_ASSERT_TRUE(test, info->is_hdmi);
@@ -1381,7 +1380,7 @@ static void drm_test_check_output_bpc_format_display_rgb_only(struct kunit *test
 	ret = set_connector_edid(test, conn,
 				 test_edid_hdmi_1080p_rgb_max_200mhz,
 				 ARRAY_SIZE(test_edid_hdmi_1080p_rgb_max_200mhz));
-	KUNIT_ASSERT_EQ(test, ret, 0);
+	KUNIT_ASSERT_GT(test, ret, 0);
 
 	info = &conn->display_info;
 	KUNIT_ASSERT_TRUE(test, info->is_hdmi);
@@ -1447,7 +1446,7 @@ static void drm_test_check_output_bpc_format_driver_8bpc_only(struct kunit *test
 	ret = set_connector_edid(test, conn,
 				 test_edid_hdmi_1080p_rgb_yuv_dc_max_340mhz,
 				 ARRAY_SIZE(test_edid_hdmi_1080p_rgb_yuv_dc_max_340mhz));
-	KUNIT_ASSERT_EQ(test, ret, 0);
+	KUNIT_ASSERT_GT(test, ret, 0);
 
 	info = &conn->display_info;
 	KUNIT_ASSERT_TRUE(test, info->is_hdmi);
@@ -1507,7 +1506,7 @@ static void drm_test_check_output_bpc_format_display_8bpc_only(struct kunit *tes
 	ret = set_connector_edid(test, conn,
 				 test_edid_hdmi_1080p_rgb_max_340mhz,
 				 ARRAY_SIZE(test_edid_hdmi_1080p_rgb_max_340mhz));
-	KUNIT_ASSERT_EQ(test, ret, 0);
+	KUNIT_ASSERT_GT(test, ret, 0);
 
 	info = &conn->display_info;
 	KUNIT_ASSERT_TRUE(test, info->is_hdmi);

-- 
2.39.5


