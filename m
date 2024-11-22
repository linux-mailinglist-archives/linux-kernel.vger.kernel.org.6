Return-Path: <linux-kernel+bounces-417994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0FAB9D5BAB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 10:16:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6177D1F21817
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 09:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01A361DDC16;
	Fri, 22 Nov 2024 09:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lo4XKYKI"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94FF81D799D
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 09:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732266798; cv=none; b=nqYSyAvqqsIG8Y3zTWmhkDYPG1O+ur7E2cw0ZJPWXwNvojMuQ6DHBhwxhkR4ewO1bj0ou2P6h83mOMdwx4RWDeeoiZlDZk0l6b6ApiPlqdfcehSphvPDSrKqe0DyDi+Pu3WCX0dT9hss4ST/2b7CmzA4+Isoory1SPPU1suslzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732266798; c=relaxed/simple;
	bh=g90UV4snbYK1PCsg8Vi4l6YeLj+54jyCttfyA/beoL8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Kzvfgf/XN6kNkIoudztPxJmRDzaamXfoUx3+tyfleix/9CKenjU9HDpgQqFy5LDesIpMuXvSu+BhYheGKSrAZI7chXp4OExyX/04XXK5WVkqEmw/YcVYhF0rdgDfdm9Chn+vQLU49rNJ2MfNY2OBQlYWpU0V7KNgKX6gXAqdxRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lo4XKYKI; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-53da5a27771so2162899e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 01:13:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732266794; x=1732871594; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HoL3aWMtjL9qLbqtGe43c2BpbewS4aE5M6KHnAUYZyA=;
        b=lo4XKYKI14TuY9Oa5RhkrXTcvMhCfs1y8RQ0FMJntPlI4y/LQ8EDlvNZBHZrxiRi2g
         OjlhgrFr3hIRNv+/0Fak03o9M4ZvC6Ox/8YofHd4W+I88z2UGz0jIESZsbc2D4iv1Dov
         5objygzhKDlQOszHiuTZ+Q2G7mSApe1su0DDjA7pdmC+6UAjknaIX+KME40mSKB01S82
         7iCEhsPKViB6V3IjXO+NyMuS7lBPuQUHZgmj32J5eZEX60rViVXKnzwp/oko9prVoroM
         JKrfZk9mPyfYOpJ0yQcMvNPi7IDOxnuDwJc+Z+PeG6wtCy0HlHRivXwxApCrPLjCF7iu
         r9DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732266794; x=1732871594;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HoL3aWMtjL9qLbqtGe43c2BpbewS4aE5M6KHnAUYZyA=;
        b=pU1DVb+iRz8y8/OfA+Kfz23CiihJsRXNMAlj8W/3cnUY5LJu3yAiLXhFyPt5Ut8Fdg
         S+mdicyFABgayw/Hv7R4dKj6pEpu6DZYwMY/Z9OPMGglMbqOKtqHnwgTMRpPwIV1vaD0
         16Qv/jhFne85sLwnQG5nY3pDm0f4V70c0ZPiYdGyeyF3TgHhnLBKiez8fU95cPkqq/BI
         hSWEaoB785HGgei68EVuF9/t1Re24Hb/9i49Ct1pal9ugVspqBU42nn8ZOfQRsPG+Jxk
         3lQhbKJIFgZ6uFZpxV52zb8T1sv5nIqHTX0gSKUGvEk8u3HYVwCMjEvwAIBZ3WApa+ck
         u4aQ==
X-Forwarded-Encrypted: i=1; AJvYcCVsSRqQOu5Tc5qkOQlv5yTs85X0kzshUUGSEG+Z09L+U+cdsv4X+vNXKV4RlK6q+vlLq99vJQVRCqca9c0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw18kCdq5beAfvKu4Mwr6ZT8yUsA7xAI5rc832JWG+PvzLCjd7m
	bPwTz5pmGkCOj0v9P3dQ+EVagnFyU73c5T13RwH6L7MUfkKLs1QSugj69EjG/i/E75+UJcgo+cn
	u
X-Gm-Gg: ASbGncv3RlOq1eDkXrqdj7WvZY2QpgPFfUd1a9FuD9rBSj1lwD5/kSb4al2mTvEDcb3
	tExI6NAOZEezkO2oS+j3iy6zbJKs6PTiU2Olle5SrS3gp7K4X6fugeGpKAkFbrBe4sQgGPqu3a8
	908bX79ipFQl5uUye9w+hzUoTIO6B4MXx/wzJrsWxdvfw6TZYeUSTBcrcJZi4IZ84fs37b80Goa
	1bqLwF8oDYaC9VE3XW0Pw6UxC9FM6vO9fIAMRStHlDCAjqc3N6bfI81QA==
X-Google-Smtp-Source: AGHT+IGsVNjOq27k776zE/cKgwN70tM6uYhT0eEceng2yr5gRWog07KJFnzoL9IEms+6bvRWR289/w==
X-Received: by 2002:a05:6512:b8a:b0:53d:d2d0:7c8f with SMTP id 2adb3069b0e04-53dd389d8c5mr910882e87.34.1732266794264;
        Fri, 22 Nov 2024 01:13:14 -0800 (PST)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53dd2451386sm299530e87.77.2024.11.22.01.13.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 01:13:12 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 22 Nov 2024 11:12:58 +0200
Subject: [PATCH v4 02/10] drm/tests: hdmi: rename connector creation
 function
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241122-hdmi-mode-valid-v4-2-2fee4a83ab79@linaro.org>
References: <20241122-hdmi-mode-valid-v4-0-2fee4a83ab79@linaro.org>
In-Reply-To: <20241122-hdmi-mode-valid-v4-0-2fee4a83ab79@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=11003;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=g90UV4snbYK1PCsg8Vi4l6YeLj+54jyCttfyA/beoL8=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBnQEshr58WmNMo81MG4tiQNHQeSCPOdq5T4NQZ4
 z8ZTDVJEraJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZ0BLIQAKCRCLPIo+Aiko
 1fMGB/9ZOhAOQVgQ06z4Dsew8aMKvh7Gsx2b8vApxlPuSYhFhnespRjpeyhSCxW5AAYYPlS87N3
 OpezjjaXuXIKqiV1jqN8LW1Mdu4T94LRA30YeLbaImenTe4zJULUTIPgSb0YhDqlBtKMplZ+ztr
 xZa14xzq/fyMB1B0/kW6cpcS8Aija2dpwz7SD2cUXZ+WnR2224RqWvRC5r+3Yh3JTatsclMYRqT
 zFyZjeJDH8l2dK/pK7ipe0HJbkZdttc3WuNvlFBXzitXJaNC1t8gP7mfTF4ENXVC6Tna2YUX3un
 gPH6KVG+TF4XJf8zdGy9/ks9y9P+2SD6uG+UcQHbET/Akc4+
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

As pointed out by Maxime, the drm_atomic_helper_connector_hdmi_init()
isn't a good name for a function inside KUnit tests. Rename it to
drm_kunit_helper_connector_hdmi_init().

Suggested-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c | 58 +++++++++++-----------
 1 file changed, 29 insertions(+), 29 deletions(-)

diff --git a/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c b/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c
index 1e77689af6549f162eb3026c7bd2bbd59516ed98..d81254d46975e8af0d782249928217a1ebb7646e 100644
--- a/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c
+++ b/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c
@@ -164,7 +164,7 @@ static const struct drm_connector_funcs dummy_connector_funcs = {
 
 static
 struct drm_atomic_helper_connector_hdmi_priv *
-drm_atomic_helper_connector_hdmi_init(struct kunit *test,
+drm_kunit_helper_connector_hdmi_init(struct kunit *test,
 				      unsigned int formats,
 				      unsigned int max_bpc)
 {
@@ -247,7 +247,7 @@ static void drm_test_check_broadcast_rgb_crtc_mode_changed(struct kunit *test)
 	struct drm_crtc *crtc;
 	int ret;
 
-	priv = drm_atomic_helper_connector_hdmi_init(test,
+	priv = drm_kunit_helper_connector_hdmi_init(test,
 						     BIT(HDMI_COLORSPACE_RGB),
 						     8);
 	KUNIT_ASSERT_NOT_NULL(test, priv);
@@ -310,7 +310,7 @@ static void drm_test_check_broadcast_rgb_crtc_mode_not_changed(struct kunit *tes
 	struct drm_crtc *crtc;
 	int ret;
 
-	priv = drm_atomic_helper_connector_hdmi_init(test,
+	priv = drm_kunit_helper_connector_hdmi_init(test,
 						     BIT(HDMI_COLORSPACE_RGB),
 						     8);
 	KUNIT_ASSERT_NOT_NULL(test, priv);
@@ -373,7 +373,7 @@ static void drm_test_check_broadcast_rgb_auto_cea_mode(struct kunit *test)
 	struct drm_crtc *crtc;
 	int ret;
 
-	priv = drm_atomic_helper_connector_hdmi_init(test,
+	priv = drm_kunit_helper_connector_hdmi_init(test,
 						     BIT(HDMI_COLORSPACE_RGB),
 						     8);
 	KUNIT_ASSERT_NOT_NULL(test, priv);
@@ -429,7 +429,7 @@ static void drm_test_check_broadcast_rgb_auto_cea_mode_vic_1(struct kunit *test)
 	struct drm_crtc *crtc;
 	int ret;
 
-	priv = drm_atomic_helper_connector_hdmi_init(test,
+	priv = drm_kunit_helper_connector_hdmi_init(test,
 						     BIT(HDMI_COLORSPACE_RGB),
 						     8);
 	KUNIT_ASSERT_NOT_NULL(test, priv);
@@ -485,7 +485,7 @@ static void drm_test_check_broadcast_rgb_full_cea_mode(struct kunit *test)
 	struct drm_crtc *crtc;
 	int ret;
 
-	priv = drm_atomic_helper_connector_hdmi_init(test,
+	priv = drm_kunit_helper_connector_hdmi_init(test,
 						     BIT(HDMI_COLORSPACE_RGB),
 						     8);
 	KUNIT_ASSERT_NOT_NULL(test, priv);
@@ -543,7 +543,7 @@ static void drm_test_check_broadcast_rgb_full_cea_mode_vic_1(struct kunit *test)
 	struct drm_crtc *crtc;
 	int ret;
 
-	priv = drm_atomic_helper_connector_hdmi_init(test,
+	priv = drm_kunit_helper_connector_hdmi_init(test,
 						     BIT(HDMI_COLORSPACE_RGB),
 						     8);
 	KUNIT_ASSERT_NOT_NULL(test, priv);
@@ -601,7 +601,7 @@ static void drm_test_check_broadcast_rgb_limited_cea_mode(struct kunit *test)
 	struct drm_crtc *crtc;
 	int ret;
 
-	priv = drm_atomic_helper_connector_hdmi_init(test,
+	priv = drm_kunit_helper_connector_hdmi_init(test,
 						     BIT(HDMI_COLORSPACE_RGB),
 						     8);
 	KUNIT_ASSERT_NOT_NULL(test, priv);
@@ -659,7 +659,7 @@ static void drm_test_check_broadcast_rgb_limited_cea_mode_vic_1(struct kunit *te
 	struct drm_crtc *crtc;
 	int ret;
 
-	priv = drm_atomic_helper_connector_hdmi_init(test,
+	priv = drm_kunit_helper_connector_hdmi_init(test,
 						     BIT(HDMI_COLORSPACE_RGB),
 						     8);
 	KUNIT_ASSERT_NOT_NULL(test, priv);
@@ -719,7 +719,7 @@ static void drm_test_check_output_bpc_crtc_mode_changed(struct kunit *test)
 	struct drm_crtc *crtc;
 	int ret;
 
-	priv = drm_atomic_helper_connector_hdmi_init(test,
+	priv = drm_kunit_helper_connector_hdmi_init(test,
 						     BIT(HDMI_COLORSPACE_RGB),
 						     10);
 	KUNIT_ASSERT_NOT_NULL(test, priv);
@@ -793,7 +793,7 @@ static void drm_test_check_output_bpc_crtc_mode_not_changed(struct kunit *test)
 	struct drm_crtc *crtc;
 	int ret;
 
-	priv = drm_atomic_helper_connector_hdmi_init(test,
+	priv = drm_kunit_helper_connector_hdmi_init(test,
 						     BIT(HDMI_COLORSPACE_RGB),
 						     10);
 	KUNIT_ASSERT_NOT_NULL(test, priv);
@@ -862,7 +862,7 @@ static void drm_test_check_output_bpc_dvi(struct kunit *test)
 	struct drm_crtc *crtc;
 	int ret;
 
-	priv = drm_atomic_helper_connector_hdmi_init(test,
+	priv = drm_kunit_helper_connector_hdmi_init(test,
 						     BIT(HDMI_COLORSPACE_RGB) |
 						     BIT(HDMI_COLORSPACE_YUV422) |
 						     BIT(HDMI_COLORSPACE_YUV444),
@@ -911,7 +911,7 @@ static void drm_test_check_tmds_char_rate_rgb_8bpc(struct kunit *test)
 	struct drm_crtc *crtc;
 	int ret;
 
-	priv = drm_atomic_helper_connector_hdmi_init(test,
+	priv = drm_kunit_helper_connector_hdmi_init(test,
 						     BIT(HDMI_COLORSPACE_RGB),
 						     8);
 	KUNIT_ASSERT_NOT_NULL(test, priv);
@@ -958,7 +958,7 @@ static void drm_test_check_tmds_char_rate_rgb_10bpc(struct kunit *test)
 	struct drm_crtc *crtc;
 	int ret;
 
-	priv = drm_atomic_helper_connector_hdmi_init(test,
+	priv = drm_kunit_helper_connector_hdmi_init(test,
 						     BIT(HDMI_COLORSPACE_RGB),
 						     10);
 	KUNIT_ASSERT_NOT_NULL(test, priv);
@@ -1005,7 +1005,7 @@ static void drm_test_check_tmds_char_rate_rgb_12bpc(struct kunit *test)
 	struct drm_crtc *crtc;
 	int ret;
 
-	priv = drm_atomic_helper_connector_hdmi_init(test,
+	priv = drm_kunit_helper_connector_hdmi_init(test,
 						     BIT(HDMI_COLORSPACE_RGB),
 						     12);
 	KUNIT_ASSERT_NOT_NULL(test, priv);
@@ -1056,7 +1056,7 @@ static void drm_test_check_hdmi_funcs_reject_rate(struct kunit *test)
 	struct drm_crtc *crtc;
 	int ret;
 
-	priv = drm_atomic_helper_connector_hdmi_init(test,
+	priv = drm_kunit_helper_connector_hdmi_init(test,
 						     BIT(HDMI_COLORSPACE_RGB),
 						     8);
 	KUNIT_ASSERT_NOT_NULL(test, priv);
@@ -1112,7 +1112,7 @@ static void drm_test_check_max_tmds_rate_bpc_fallback(struct kunit *test)
 	struct drm_crtc *crtc;
 	int ret;
 
-	priv = drm_atomic_helper_connector_hdmi_init(test,
+	priv = drm_kunit_helper_connector_hdmi_init(test,
 						     BIT(HDMI_COLORSPACE_RGB),
 						     12);
 	KUNIT_ASSERT_NOT_NULL(test, priv);
@@ -1179,7 +1179,7 @@ static void drm_test_check_max_tmds_rate_format_fallback(struct kunit *test)
 	struct drm_crtc *crtc;
 	int ret;
 
-	priv = drm_atomic_helper_connector_hdmi_init(test,
+	priv = drm_kunit_helper_connector_hdmi_init(test,
 						     BIT(HDMI_COLORSPACE_RGB) |
 						     BIT(HDMI_COLORSPACE_YUV422) |
 						     BIT(HDMI_COLORSPACE_YUV444),
@@ -1242,7 +1242,7 @@ static void drm_test_check_output_bpc_format_vic_1(struct kunit *test)
 	struct drm_crtc *crtc;
 	int ret;
 
-	priv = drm_atomic_helper_connector_hdmi_init(test,
+	priv = drm_kunit_helper_connector_hdmi_init(test,
 						     BIT(HDMI_COLORSPACE_RGB) |
 						     BIT(HDMI_COLORSPACE_YUV422) |
 						     BIT(HDMI_COLORSPACE_YUV444),
@@ -1305,7 +1305,7 @@ static void drm_test_check_output_bpc_format_driver_rgb_only(struct kunit *test)
 	struct drm_crtc *crtc;
 	int ret;
 
-	priv = drm_atomic_helper_connector_hdmi_init(test,
+	priv = drm_kunit_helper_connector_hdmi_init(test,
 						     BIT(HDMI_COLORSPACE_RGB),
 						     12);
 	KUNIT_ASSERT_NOT_NULL(test, priv);
@@ -1370,7 +1370,7 @@ static void drm_test_check_output_bpc_format_display_rgb_only(struct kunit *test
 	struct drm_crtc *crtc;
 	int ret;
 
-	priv = drm_atomic_helper_connector_hdmi_init(test,
+	priv = drm_kunit_helper_connector_hdmi_init(test,
 						     BIT(HDMI_COLORSPACE_RGB) |
 						     BIT(HDMI_COLORSPACE_YUV422) |
 						     BIT(HDMI_COLORSPACE_YUV444),
@@ -1438,7 +1438,7 @@ static void drm_test_check_output_bpc_format_driver_8bpc_only(struct kunit *test
 	struct drm_crtc *crtc;
 	int ret;
 
-	priv = drm_atomic_helper_connector_hdmi_init(test,
+	priv = drm_kunit_helper_connector_hdmi_init(test,
 						     BIT(HDMI_COLORSPACE_RGB),
 						     8);
 	KUNIT_ASSERT_NOT_NULL(test, priv);
@@ -1496,7 +1496,7 @@ static void drm_test_check_output_bpc_format_display_8bpc_only(struct kunit *tes
 	struct drm_crtc *crtc;
 	int ret;
 
-	priv = drm_atomic_helper_connector_hdmi_init(test,
+	priv = drm_kunit_helper_connector_hdmi_init(test,
 						     BIT(HDMI_COLORSPACE_RGB) |
 						     BIT(HDMI_COLORSPACE_YUV422) |
 						     BIT(HDMI_COLORSPACE_YUV444),
@@ -1593,7 +1593,7 @@ static void drm_test_check_broadcast_rgb_value(struct kunit *test)
 	struct drm_connector_state *conn_state;
 	struct drm_connector *conn;
 
-	priv = drm_atomic_helper_connector_hdmi_init(test,
+	priv = drm_kunit_helper_connector_hdmi_init(test,
 						     BIT(HDMI_COLORSPACE_RGB),
 						     8);
 	KUNIT_ASSERT_NOT_NULL(test, priv);
@@ -1615,7 +1615,7 @@ static void drm_test_check_bpc_8_value(struct kunit *test)
 	struct drm_connector_state *conn_state;
 	struct drm_connector *conn;
 
-	priv = drm_atomic_helper_connector_hdmi_init(test,
+	priv = drm_kunit_helper_connector_hdmi_init(test,
 						     BIT(HDMI_COLORSPACE_RGB),
 						     8);
 	KUNIT_ASSERT_NOT_NULL(test, priv);
@@ -1639,7 +1639,7 @@ static void drm_test_check_bpc_10_value(struct kunit *test)
 	struct drm_connector_state *conn_state;
 	struct drm_connector *conn;
 
-	priv = drm_atomic_helper_connector_hdmi_init(test,
+	priv = drm_kunit_helper_connector_hdmi_init(test,
 						     BIT(HDMI_COLORSPACE_RGB),
 						     10);
 	KUNIT_ASSERT_NOT_NULL(test, priv);
@@ -1663,7 +1663,7 @@ static void drm_test_check_bpc_12_value(struct kunit *test)
 	struct drm_connector_state *conn_state;
 	struct drm_connector *conn;
 
-	priv = drm_atomic_helper_connector_hdmi_init(test,
+	priv = drm_kunit_helper_connector_hdmi_init(test,
 						     BIT(HDMI_COLORSPACE_RGB),
 						     12);
 	KUNIT_ASSERT_NOT_NULL(test, priv);
@@ -1685,7 +1685,7 @@ static void drm_test_check_format_value(struct kunit *test)
 	struct drm_connector_state *conn_state;
 	struct drm_connector *conn;
 
-	priv = drm_atomic_helper_connector_hdmi_init(test,
+	priv = drm_kunit_helper_connector_hdmi_init(test,
 						     BIT(HDMI_COLORSPACE_RGB) |
 						     BIT(HDMI_COLORSPACE_YUV422) |
 						     BIT(HDMI_COLORSPACE_YUV444),
@@ -1707,7 +1707,7 @@ static void drm_test_check_tmds_char_value(struct kunit *test)
 	struct drm_connector_state *conn_state;
 	struct drm_connector *conn;
 
-	priv = drm_atomic_helper_connector_hdmi_init(test,
+	priv = drm_kunit_helper_connector_hdmi_init(test,
 						     BIT(HDMI_COLORSPACE_RGB) |
 						     BIT(HDMI_COLORSPACE_YUV422) |
 						     BIT(HDMI_COLORSPACE_YUV444),

-- 
2.39.5


