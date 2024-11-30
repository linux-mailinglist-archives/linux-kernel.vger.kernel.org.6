Return-Path: <linux-kernel+bounces-426066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D99249DEE74
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 02:53:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2FA52B23278
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 01:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE57970802;
	Sat, 30 Nov 2024 01:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KeqEvpgu"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A05EF126C05
	for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 01:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732931564; cv=none; b=uqd8wFnZ3rwQhWvU2IO+iZlx6/B7QM17QBA19haKA9njTlFCwhOeqbD3SxrmzHhcvl99Ec7J/uGtS6fTKRKsynBLkInLgNXBTXWWaxmnyPAwltd+a8UmrT3Mxsnvv1K64yOZOtTot4LEKPWYI4olAOOukh7tfNySr1sY45UKSjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732931564; c=relaxed/simple;
	bh=v8BoSRVhNVLNIqn0L1HvmQQ2nfTsZdUMUqZ1imeVKuY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XJXmgSzlJlnx6aCR1nFxFXMpY3MWvk+rZgnEyRiuSnpC/CWphDzm7dHBbl25hYdHXqE28jSVGhfXn0w3fDtlOGLhnf7F9505zzv9nVmHtDx76xC+5+Z+rjI9EQ8DVqU40oyYTOs3eWGaq94ydhC9jtKtx7COnaIESmi/qoOxIJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KeqEvpgu; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-53df1e063d8so3074842e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 17:52:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732931561; x=1733536361; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b4B0Y8eeW8nijFHMU2wdPBEmou1JUmUHuwSM02tCW6A=;
        b=KeqEvpgutvC0cpWVEakEgILb4XPFDEN7wgpFqKIJvK9ltC2fUT7UQqd09s5avbfSyJ
         vLLuPGtUE31NmexP7tfHbOEK2idqXDT6QGnL8LWke0hV4BsFyCTPIUt1+6ES5hwGkp4G
         6g+nfJmc6+5lVCzxGLOEBJP+OrqvD/9HtRVIgNV8X5zHrD6bV8d7w2eSwYtEMcxMKRiZ
         WqX1OwbzJmvggj69RRaJCCXOuBQnNj8lgSHysAvH2fWBZG07qiriqr5nz5suR5l9x+l/
         5o9chmCZtwsRQZIFiqbJ7RHwCzg3C9bxvRC3xy+vsGRLjlFVLZbyoEcXpuqcvrG99kBB
         3giQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732931561; x=1733536361;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b4B0Y8eeW8nijFHMU2wdPBEmou1JUmUHuwSM02tCW6A=;
        b=HKDU/HQuKVNPAcgeruCf4/qIaCLShiNW/s52ktluR1QBHAqcv8/qofTVxwG2Qw6yS4
         tFdL5JwBk+ScDW4mKUjAOGna1msvCNFPfL3sRdXlfyFS3II08vw0PR4ZBeQQq1VnM6Ta
         KqBkIRjjWdM/f1VToCr5UtHqlopJB0fcZNwPDxfqt7JBiNihsOhQuPoDnevk5izSzWux
         e7XaiKOI8ZbGEkYQ/a+pTIMi4zamcmUxOAVfExAqtPnf+a37yL6vNaVbO+FPVdkA/lov
         aU2mArzC4Wj76QGWeAZok+4tbRrUhKmXoup4meW5UD6OFvGd9uq9V3fSM0Qq2QVfka03
         +POw==
X-Forwarded-Encrypted: i=1; AJvYcCWtWc1x0TFnAjHgSzEhJ/6PoOXIW61zvmydikvGiqYoyYp6um52G2dK6T0g7GmdQVcKLGsNSg5tWGclYLU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPaQ2WLXZkRnQQMxEAew0BGNiOQF0pqPfYGVdqRohwTkZCVQYL
	PQ4l1Tr0SBbd4WjMdkutVmC6OTtwWpfW5TAbbJ9fc6CV9NLtfb0p8k6Scp9wJcA=
X-Gm-Gg: ASbGncsgTFqf9GTbKCDGJs1sVbRbrtOuJX1oCvuzAUQZJvop2w26Ht8LBdu2GElh/XX
	S+YOPk4+i3RM+NKSPtxziuX4o5VauBQtnwfAI3uI0ebz/Ck8sbxFin1pnA5j/Rk64NlJjjnbpZr
	mPvaTK+WylaMXMXLK4RRf5eOviFvvHHoZfFK3DcPvg/3oT14iCbgla8AgZsV9YXxpJh56TRaGTG
	9uEeRwaqfn5HuyfGqganC/2nJg+KxNa8ke7+eQ2bybTD7itxE+VcpWgNA==
X-Google-Smtp-Source: AGHT+IHr7e6eqX9Z0gQvURdKQ1bdtAFQTJZejUyHCz6bKeZj+mC0/lLghPW0EOJgTJMIplS8zy4hNg==
X-Received: by 2002:a05:6512:32c1:b0:53d:a68f:d901 with SMTP id 2adb3069b0e04-53df00d1b06mr7609554e87.15.1732931560699;
        Fri, 29 Nov 2024 17:52:40 -0800 (PST)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53df6443172sm636408e87.84.2024.11.29.17.52.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2024 17:52:39 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sat, 30 Nov 2024 03:52:27 +0200
Subject: [PATCH v5 02/10] drm/tests: hdmi: rename connector creation
 function
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241130-hdmi-mode-valid-v5-2-742644ec3b1f@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=14634;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=v8BoSRVhNVLNIqn0L1HvmQQ2nfTsZdUMUqZ1imeVKuY=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBnSm/fLC3qTV5FPAg0koUKF7mCCVp4yjgnKY2Ob
 7XbeEcO7OuJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZ0pv3wAKCRCLPIo+Aiko
 1W8+B/wK+y74BQCSvsvXrO6Z3w7xSSgmnVQ99HIWNd93CVXPYrCnNdWqf/FAeZisVnWQRjmqeyV
 L0N+uCP5Wt1zYJyCnIFQC4R5WgF8vMQ8v39fsp9Ab3f03lvV/5/BpvWcBC6FQdGTBx6ObXov7xp
 VOVE5CIYcE5LxJWlebKEE2e5J0cZTNEH9IyhHjYq8gERQmh2oAKbBBWHs7HpDuSZta1oid9nUZi
 cdWlFnP4EajV5XBJ6VleF4Ideqv6+Vg/KH7ZUCelcHS5hnxwnbxlw9r1GOLUIc+Gzuk/BCs+E0Y
 uh9d/yk0xHTcrLsNtUfZ36YteFQsA33xM6D/deRqQpwMun9D
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

As pointed out by Maxime, the drm_atomic_helper_connector_hdmi_init()
isn't a good name for a function inside KUnit tests. Rename it to
drm_kunit_helper_connector_hdmi_init().

Suggested-by: Maxime Ripard <mripard@kernel.org>
Reviewed-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c | 202 ++++++++++-----------
 1 file changed, 101 insertions(+), 101 deletions(-)

diff --git a/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c b/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c
index 1e77689af6549f162eb3026c7bd2bbd59516ed98..60b1e37522837ee183c65413e3ba6c6ec4fed341 100644
--- a/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c
+++ b/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c
@@ -164,9 +164,9 @@ static const struct drm_connector_funcs dummy_connector_funcs = {
 
 static
 struct drm_atomic_helper_connector_hdmi_priv *
-drm_atomic_helper_connector_hdmi_init(struct kunit *test,
-				      unsigned int formats,
-				      unsigned int max_bpc)
+drm_kunit_helper_connector_hdmi_init(struct kunit *test,
+				     unsigned int formats,
+				     unsigned int max_bpc)
 {
 	struct drm_atomic_helper_connector_hdmi_priv *priv;
 	struct drm_connector *conn;
@@ -247,9 +247,9 @@ static void drm_test_check_broadcast_rgb_crtc_mode_changed(struct kunit *test)
 	struct drm_crtc *crtc;
 	int ret;
 
-	priv = drm_atomic_helper_connector_hdmi_init(test,
-						     BIT(HDMI_COLORSPACE_RGB),
-						     8);
+	priv = drm_kunit_helper_connector_hdmi_init(test,
+						    BIT(HDMI_COLORSPACE_RGB),
+						    8);
 	KUNIT_ASSERT_NOT_NULL(test, priv);
 
 	ctx = drm_kunit_helper_acquire_ctx_alloc(test);
@@ -310,9 +310,9 @@ static void drm_test_check_broadcast_rgb_crtc_mode_not_changed(struct kunit *tes
 	struct drm_crtc *crtc;
 	int ret;
 
-	priv = drm_atomic_helper_connector_hdmi_init(test,
-						     BIT(HDMI_COLORSPACE_RGB),
-						     8);
+	priv = drm_kunit_helper_connector_hdmi_init(test,
+						    BIT(HDMI_COLORSPACE_RGB),
+						    8);
 	KUNIT_ASSERT_NOT_NULL(test, priv);
 
 	ctx = drm_kunit_helper_acquire_ctx_alloc(test);
@@ -373,9 +373,9 @@ static void drm_test_check_broadcast_rgb_auto_cea_mode(struct kunit *test)
 	struct drm_crtc *crtc;
 	int ret;
 
-	priv = drm_atomic_helper_connector_hdmi_init(test,
-						     BIT(HDMI_COLORSPACE_RGB),
-						     8);
+	priv = drm_kunit_helper_connector_hdmi_init(test,
+						    BIT(HDMI_COLORSPACE_RGB),
+						    8);
 	KUNIT_ASSERT_NOT_NULL(test, priv);
 
 	conn = &priv->connector;
@@ -429,9 +429,9 @@ static void drm_test_check_broadcast_rgb_auto_cea_mode_vic_1(struct kunit *test)
 	struct drm_crtc *crtc;
 	int ret;
 
-	priv = drm_atomic_helper_connector_hdmi_init(test,
-						     BIT(HDMI_COLORSPACE_RGB),
-						     8);
+	priv = drm_kunit_helper_connector_hdmi_init(test,
+						    BIT(HDMI_COLORSPACE_RGB),
+						    8);
 	KUNIT_ASSERT_NOT_NULL(test, priv);
 
 	drm = &priv->drm;
@@ -485,9 +485,9 @@ static void drm_test_check_broadcast_rgb_full_cea_mode(struct kunit *test)
 	struct drm_crtc *crtc;
 	int ret;
 
-	priv = drm_atomic_helper_connector_hdmi_init(test,
-						     BIT(HDMI_COLORSPACE_RGB),
-						     8);
+	priv = drm_kunit_helper_connector_hdmi_init(test,
+						    BIT(HDMI_COLORSPACE_RGB),
+						    8);
 	KUNIT_ASSERT_NOT_NULL(test, priv);
 
 	conn = &priv->connector;
@@ -543,9 +543,9 @@ static void drm_test_check_broadcast_rgb_full_cea_mode_vic_1(struct kunit *test)
 	struct drm_crtc *crtc;
 	int ret;
 
-	priv = drm_atomic_helper_connector_hdmi_init(test,
-						     BIT(HDMI_COLORSPACE_RGB),
-						     8);
+	priv = drm_kunit_helper_connector_hdmi_init(test,
+						    BIT(HDMI_COLORSPACE_RGB),
+						    8);
 	KUNIT_ASSERT_NOT_NULL(test, priv);
 
 	drm = &priv->drm;
@@ -601,9 +601,9 @@ static void drm_test_check_broadcast_rgb_limited_cea_mode(struct kunit *test)
 	struct drm_crtc *crtc;
 	int ret;
 
-	priv = drm_atomic_helper_connector_hdmi_init(test,
-						     BIT(HDMI_COLORSPACE_RGB),
-						     8);
+	priv = drm_kunit_helper_connector_hdmi_init(test,
+						    BIT(HDMI_COLORSPACE_RGB),
+						    8);
 	KUNIT_ASSERT_NOT_NULL(test, priv);
 
 	conn = &priv->connector;
@@ -659,9 +659,9 @@ static void drm_test_check_broadcast_rgb_limited_cea_mode_vic_1(struct kunit *te
 	struct drm_crtc *crtc;
 	int ret;
 
-	priv = drm_atomic_helper_connector_hdmi_init(test,
-						     BIT(HDMI_COLORSPACE_RGB),
-						     8);
+	priv = drm_kunit_helper_connector_hdmi_init(test,
+						    BIT(HDMI_COLORSPACE_RGB),
+						    8);
 	KUNIT_ASSERT_NOT_NULL(test, priv);
 
 	drm = &priv->drm;
@@ -719,9 +719,9 @@ static void drm_test_check_output_bpc_crtc_mode_changed(struct kunit *test)
 	struct drm_crtc *crtc;
 	int ret;
 
-	priv = drm_atomic_helper_connector_hdmi_init(test,
-						     BIT(HDMI_COLORSPACE_RGB),
-						     10);
+	priv = drm_kunit_helper_connector_hdmi_init(test,
+						    BIT(HDMI_COLORSPACE_RGB),
+						    10);
 	KUNIT_ASSERT_NOT_NULL(test, priv);
 
 	conn = &priv->connector;
@@ -793,9 +793,9 @@ static void drm_test_check_output_bpc_crtc_mode_not_changed(struct kunit *test)
 	struct drm_crtc *crtc;
 	int ret;
 
-	priv = drm_atomic_helper_connector_hdmi_init(test,
-						     BIT(HDMI_COLORSPACE_RGB),
-						     10);
+	priv = drm_kunit_helper_connector_hdmi_init(test,
+						    BIT(HDMI_COLORSPACE_RGB),
+						    10);
 	KUNIT_ASSERT_NOT_NULL(test, priv);
 
 	conn = &priv->connector;
@@ -862,11 +862,11 @@ static void drm_test_check_output_bpc_dvi(struct kunit *test)
 	struct drm_crtc *crtc;
 	int ret;
 
-	priv = drm_atomic_helper_connector_hdmi_init(test,
-						     BIT(HDMI_COLORSPACE_RGB) |
-						     BIT(HDMI_COLORSPACE_YUV422) |
-						     BIT(HDMI_COLORSPACE_YUV444),
-						     12);
+	priv = drm_kunit_helper_connector_hdmi_init(test,
+						    BIT(HDMI_COLORSPACE_RGB) |
+						    BIT(HDMI_COLORSPACE_YUV422) |
+						    BIT(HDMI_COLORSPACE_YUV444),
+						    12);
 	KUNIT_ASSERT_NOT_NULL(test, priv);
 
 	conn = &priv->connector;
@@ -911,9 +911,9 @@ static void drm_test_check_tmds_char_rate_rgb_8bpc(struct kunit *test)
 	struct drm_crtc *crtc;
 	int ret;
 
-	priv = drm_atomic_helper_connector_hdmi_init(test,
-						     BIT(HDMI_COLORSPACE_RGB),
-						     8);
+	priv = drm_kunit_helper_connector_hdmi_init(test,
+						    BIT(HDMI_COLORSPACE_RGB),
+						    8);
 	KUNIT_ASSERT_NOT_NULL(test, priv);
 
 	conn = &priv->connector;
@@ -958,9 +958,9 @@ static void drm_test_check_tmds_char_rate_rgb_10bpc(struct kunit *test)
 	struct drm_crtc *crtc;
 	int ret;
 
-	priv = drm_atomic_helper_connector_hdmi_init(test,
-						     BIT(HDMI_COLORSPACE_RGB),
-						     10);
+	priv = drm_kunit_helper_connector_hdmi_init(test,
+						    BIT(HDMI_COLORSPACE_RGB),
+						    10);
 	KUNIT_ASSERT_NOT_NULL(test, priv);
 
 	conn = &priv->connector;
@@ -1005,9 +1005,9 @@ static void drm_test_check_tmds_char_rate_rgb_12bpc(struct kunit *test)
 	struct drm_crtc *crtc;
 	int ret;
 
-	priv = drm_atomic_helper_connector_hdmi_init(test,
-						     BIT(HDMI_COLORSPACE_RGB),
-						     12);
+	priv = drm_kunit_helper_connector_hdmi_init(test,
+						    BIT(HDMI_COLORSPACE_RGB),
+						    12);
 	KUNIT_ASSERT_NOT_NULL(test, priv);
 
 	conn = &priv->connector;
@@ -1056,9 +1056,9 @@ static void drm_test_check_hdmi_funcs_reject_rate(struct kunit *test)
 	struct drm_crtc *crtc;
 	int ret;
 
-	priv = drm_atomic_helper_connector_hdmi_init(test,
-						     BIT(HDMI_COLORSPACE_RGB),
-						     8);
+	priv = drm_kunit_helper_connector_hdmi_init(test,
+						    BIT(HDMI_COLORSPACE_RGB),
+						    8);
 	KUNIT_ASSERT_NOT_NULL(test, priv);
 
 	ctx = drm_kunit_helper_acquire_ctx_alloc(test);
@@ -1112,9 +1112,9 @@ static void drm_test_check_max_tmds_rate_bpc_fallback(struct kunit *test)
 	struct drm_crtc *crtc;
 	int ret;
 
-	priv = drm_atomic_helper_connector_hdmi_init(test,
-						     BIT(HDMI_COLORSPACE_RGB),
-						     12);
+	priv = drm_kunit_helper_connector_hdmi_init(test,
+						    BIT(HDMI_COLORSPACE_RGB),
+						    12);
 	KUNIT_ASSERT_NOT_NULL(test, priv);
 
 	conn = &priv->connector;
@@ -1179,11 +1179,11 @@ static void drm_test_check_max_tmds_rate_format_fallback(struct kunit *test)
 	struct drm_crtc *crtc;
 	int ret;
 
-	priv = drm_atomic_helper_connector_hdmi_init(test,
-						     BIT(HDMI_COLORSPACE_RGB) |
-						     BIT(HDMI_COLORSPACE_YUV422) |
-						     BIT(HDMI_COLORSPACE_YUV444),
-						     12);
+	priv = drm_kunit_helper_connector_hdmi_init(test,
+						    BIT(HDMI_COLORSPACE_RGB) |
+						    BIT(HDMI_COLORSPACE_YUV422) |
+						    BIT(HDMI_COLORSPACE_YUV444),
+						    12);
 	KUNIT_ASSERT_NOT_NULL(test, priv);
 
 	conn = &priv->connector;
@@ -1242,11 +1242,11 @@ static void drm_test_check_output_bpc_format_vic_1(struct kunit *test)
 	struct drm_crtc *crtc;
 	int ret;
 
-	priv = drm_atomic_helper_connector_hdmi_init(test,
-						     BIT(HDMI_COLORSPACE_RGB) |
-						     BIT(HDMI_COLORSPACE_YUV422) |
-						     BIT(HDMI_COLORSPACE_YUV444),
-						     12);
+	priv = drm_kunit_helper_connector_hdmi_init(test,
+						    BIT(HDMI_COLORSPACE_RGB) |
+						    BIT(HDMI_COLORSPACE_YUV422) |
+						    BIT(HDMI_COLORSPACE_YUV444),
+						    12);
 	KUNIT_ASSERT_NOT_NULL(test, priv);
 
 	drm = &priv->drm;
@@ -1305,9 +1305,9 @@ static void drm_test_check_output_bpc_format_driver_rgb_only(struct kunit *test)
 	struct drm_crtc *crtc;
 	int ret;
 
-	priv = drm_atomic_helper_connector_hdmi_init(test,
-						     BIT(HDMI_COLORSPACE_RGB),
-						     12);
+	priv = drm_kunit_helper_connector_hdmi_init(test,
+						    BIT(HDMI_COLORSPACE_RGB),
+						    12);
 	KUNIT_ASSERT_NOT_NULL(test, priv);
 
 	conn = &priv->connector;
@@ -1370,11 +1370,11 @@ static void drm_test_check_output_bpc_format_display_rgb_only(struct kunit *test
 	struct drm_crtc *crtc;
 	int ret;
 
-	priv = drm_atomic_helper_connector_hdmi_init(test,
-						     BIT(HDMI_COLORSPACE_RGB) |
-						     BIT(HDMI_COLORSPACE_YUV422) |
-						     BIT(HDMI_COLORSPACE_YUV444),
-						     12);
+	priv = drm_kunit_helper_connector_hdmi_init(test,
+						    BIT(HDMI_COLORSPACE_RGB) |
+						    BIT(HDMI_COLORSPACE_YUV422) |
+						    BIT(HDMI_COLORSPACE_YUV444),
+						    12);
 	KUNIT_ASSERT_NOT_NULL(test, priv);
 
 	conn = &priv->connector;
@@ -1438,9 +1438,9 @@ static void drm_test_check_output_bpc_format_driver_8bpc_only(struct kunit *test
 	struct drm_crtc *crtc;
 	int ret;
 
-	priv = drm_atomic_helper_connector_hdmi_init(test,
-						     BIT(HDMI_COLORSPACE_RGB),
-						     8);
+	priv = drm_kunit_helper_connector_hdmi_init(test,
+						    BIT(HDMI_COLORSPACE_RGB),
+						    8);
 	KUNIT_ASSERT_NOT_NULL(test, priv);
 
 	conn = &priv->connector;
@@ -1496,11 +1496,11 @@ static void drm_test_check_output_bpc_format_display_8bpc_only(struct kunit *tes
 	struct drm_crtc *crtc;
 	int ret;
 
-	priv = drm_atomic_helper_connector_hdmi_init(test,
-						     BIT(HDMI_COLORSPACE_RGB) |
-						     BIT(HDMI_COLORSPACE_YUV422) |
-						     BIT(HDMI_COLORSPACE_YUV444),
-						     12);
+	priv = drm_kunit_helper_connector_hdmi_init(test,
+						    BIT(HDMI_COLORSPACE_RGB) |
+						    BIT(HDMI_COLORSPACE_YUV422) |
+						    BIT(HDMI_COLORSPACE_YUV444),
+						    12);
 	KUNIT_ASSERT_NOT_NULL(test, priv);
 
 	conn = &priv->connector;
@@ -1593,9 +1593,9 @@ static void drm_test_check_broadcast_rgb_value(struct kunit *test)
 	struct drm_connector_state *conn_state;
 	struct drm_connector *conn;
 
-	priv = drm_atomic_helper_connector_hdmi_init(test,
-						     BIT(HDMI_COLORSPACE_RGB),
-						     8);
+	priv = drm_kunit_helper_connector_hdmi_init(test,
+						    BIT(HDMI_COLORSPACE_RGB),
+						    8);
 	KUNIT_ASSERT_NOT_NULL(test, priv);
 
 	conn = &priv->connector;
@@ -1615,9 +1615,9 @@ static void drm_test_check_bpc_8_value(struct kunit *test)
 	struct drm_connector_state *conn_state;
 	struct drm_connector *conn;
 
-	priv = drm_atomic_helper_connector_hdmi_init(test,
-						     BIT(HDMI_COLORSPACE_RGB),
-						     8);
+	priv = drm_kunit_helper_connector_hdmi_init(test,
+						    BIT(HDMI_COLORSPACE_RGB),
+						    8);
 	KUNIT_ASSERT_NOT_NULL(test, priv);
 
 	conn = &priv->connector;
@@ -1639,9 +1639,9 @@ static void drm_test_check_bpc_10_value(struct kunit *test)
 	struct drm_connector_state *conn_state;
 	struct drm_connector *conn;
 
-	priv = drm_atomic_helper_connector_hdmi_init(test,
-						     BIT(HDMI_COLORSPACE_RGB),
-						     10);
+	priv = drm_kunit_helper_connector_hdmi_init(test,
+						    BIT(HDMI_COLORSPACE_RGB),
+						    10);
 	KUNIT_ASSERT_NOT_NULL(test, priv);
 
 	conn = &priv->connector;
@@ -1663,9 +1663,9 @@ static void drm_test_check_bpc_12_value(struct kunit *test)
 	struct drm_connector_state *conn_state;
 	struct drm_connector *conn;
 
-	priv = drm_atomic_helper_connector_hdmi_init(test,
-						     BIT(HDMI_COLORSPACE_RGB),
-						     12);
+	priv = drm_kunit_helper_connector_hdmi_init(test,
+						    BIT(HDMI_COLORSPACE_RGB),
+						    12);
 	KUNIT_ASSERT_NOT_NULL(test, priv);
 
 	conn = &priv->connector;
@@ -1685,11 +1685,11 @@ static void drm_test_check_format_value(struct kunit *test)
 	struct drm_connector_state *conn_state;
 	struct drm_connector *conn;
 
-	priv = drm_atomic_helper_connector_hdmi_init(test,
-						     BIT(HDMI_COLORSPACE_RGB) |
-						     BIT(HDMI_COLORSPACE_YUV422) |
-						     BIT(HDMI_COLORSPACE_YUV444),
-						     8);
+	priv = drm_kunit_helper_connector_hdmi_init(test,
+						    BIT(HDMI_COLORSPACE_RGB) |
+						    BIT(HDMI_COLORSPACE_YUV422) |
+						    BIT(HDMI_COLORSPACE_YUV444),
+						    8);
 	KUNIT_ASSERT_NOT_NULL(test, priv);
 
 	conn = &priv->connector;
@@ -1707,11 +1707,11 @@ static void drm_test_check_tmds_char_value(struct kunit *test)
 	struct drm_connector_state *conn_state;
 	struct drm_connector *conn;
 
-	priv = drm_atomic_helper_connector_hdmi_init(test,
-						     BIT(HDMI_COLORSPACE_RGB) |
-						     BIT(HDMI_COLORSPACE_YUV422) |
-						     BIT(HDMI_COLORSPACE_YUV444),
-						     12);
+	priv = drm_kunit_helper_connector_hdmi_init(test,
+						    BIT(HDMI_COLORSPACE_RGB) |
+						    BIT(HDMI_COLORSPACE_YUV422) |
+						    BIT(HDMI_COLORSPACE_YUV444),
+						    12);
 	KUNIT_ASSERT_NOT_NULL(test, priv);
 
 	conn = &priv->connector;

-- 
2.39.5


