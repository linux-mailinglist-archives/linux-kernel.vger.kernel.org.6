Return-Path: <linux-kernel+bounces-519154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A7EDA3988B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 11:17:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C14A3189268D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 10:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A97DE24061A;
	Tue, 18 Feb 2025 10:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HH4Dkvbd"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96DC823F296
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 10:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739873556; cv=none; b=PJ+chp5kT4OjP2FHpb8jIMXHzcMGmQ20lkGg3MWsRoMtP38TBlrWy6uSy4x2oiVGRHPOfYO9DQumPVkbRutzQsRyAzxYk6JDkhdMgpoYr5cySbwWvYE0udtAw33KPQGzNULJamRrdvT/B8KkJY0MCLv5vLcJjUBnkXuR26nfZ0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739873556; c=relaxed/simple;
	bh=a4ElrdpwVXpCQL7dKsThLcYntyabpDhRSXfRoVBxI/E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tW1OyTRZUDe4HEjYkrfx2ZieoSGAj/gVSG7XuMBkZdBaIFRFNMffvpUmuwuctGNimGJ8fM8o1SCLMHT6GvP+KbxiG3/FgAPm3U+c4qayFm1A/2NPkC5cKD1KctB5v4AniIfNprruAhGADK93FjyAspqZopR/1RDQdREIkKYcDcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HH4Dkvbd; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43937cf2131so35085095e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 02:12:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739873552; x=1740478352; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rfe2c/w4yYGc2jUSMRT4IzcezaRR9Jxw3SRE879VZ2w=;
        b=HH4Dkvbdou26C9YOCQdCFaekJtdDxI/uP/N/u79rMz99a7foll6Ye2Oh9Kzdojc7ef
         4Uj5GzEFpiexkJgjhfjz/LFurvGo1KDlyL+D66sb1r0nw8/3w74n+CSHGvwcn6HwhB8p
         e9bZFh4NcYiFkH1jHTK15JBDv85yOJ23YD1BEQzWO1SBlElIhYAJ1fYx9jj/Oe4tPI1c
         tMIa+oFqJoWIXrwPg2B8954I9RJ1xiGAnJX+S9B0vStzE3wZ5P6bnrwzSRW/SzKOmlt8
         ZIlE9g/qtuxnWrQ9ub+tG8oV3ne7LjjqkI/0YgjeWYwQzE/PRUan0kP2r7tvGqyASLzE
         S9XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739873552; x=1740478352;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rfe2c/w4yYGc2jUSMRT4IzcezaRR9Jxw3SRE879VZ2w=;
        b=XDzHlw9ueEqXsclVq9YWRRk9H1nWK9oMrChKC0jtS5j8+0CntyV2PD/sGcofUYIa8+
         g6RhLqSTR9cviwUszEAT02rmPo7UuP6CuiI/9ifeLScfBinbN1RdVTk3TYKxKG+uYDC1
         ZOxrDF1PssyiWqvXW5/lltrtmdZoMvF3Rv7Gt/nNrdGrxG9d+/1fFlPqnq2dk9SkEB1O
         92zIdcGksLHHmTcMT69h7K8ZtZGa+DTh7y677zX9/e0ZbTjSQH2KRyGltRTX9BmVunoM
         NWLC6syanTNDtpGR5j9YRsF+fLRjOEk4+eQUJnNDkttGBVHXSbCZEdBH4XYJScJsTHhb
         jW9w==
X-Forwarded-Encrypted: i=1; AJvYcCW9XY4DXt3s6vJP3J+mxq8MuPF5Pq8nvGI2rtJzXt1rt8vEjHGM/s78ac2plfeRncqDzQn2VkoPH2pvTNY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy741X5KseIdIvJv5/sMg2G5N2yfVz/y1+3rz34lkHwI20+Gc6X
	auXMi1rx/iIx46jr0AQ994Rvdgs6weW5oiImURl95tcFmq5w+WZo
X-Gm-Gg: ASbGncuisQd4eyh6T5lHK1TMzm/GjP/rTZw/FJ4O++HSDN/hQVAWUKi0qcnXf2W/F7G
	ZBTaD0ZmsdTSxn/H0kW6NYmPcPKU+m+xmb8d5aBpSQKnzv8YF7+x33HAg5+wBDjl36iiCexK4eh
	T8MFjn99U6prXFvHCBaV8zBW4/meQza3xQNZwliwV+MH+AoIprzewynXKBO67cfXN8KH/wHmJUv
	K6e+end8JZmCoeED5wJXA5LyVjFgJpCt8U9yTz0sMV1+w/rgiiI3TY1iqaJoXxBpTXyjtsXTdft
	Ea4/rS4o8wmnTfAOWg==
X-Google-Smtp-Source: AGHT+IFq19ppFLrzdssvti0OfQMaqZsLO7r8CXrtLyu5zD+ypnAc7vgPsZoR2nQ+w9y/vu8OEG333g==
X-Received: by 2002:a05:600c:a384:b0:439:88bb:d017 with SMTP id 5b1f17b1804b1-43988bbd458mr55401175e9.6.1739873551564;
        Tue, 18 Feb 2025 02:12:31 -0800 (PST)
Received: from fedora.. ([213.94.27.232])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259d5e92sm14749720f8f.66.2025.02.18.02.12.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 02:12:30 -0800 (PST)
From: =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To: louis.chauvet@bootlin.com
Cc: hamohammed.sa@gmail.com,
	simona@ffwll.ch,
	melissa.srw@gmail.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH v4 10/14] drm/vkms: Allow to attach planes and CRTCs
Date: Tue, 18 Feb 2025 11:12:10 +0100
Message-ID: <20250218101214.5790-11-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250218101214.5790-1-jose.exposito89@gmail.com>
References: <20250218101214.5790-1-jose.exposito89@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add a list of possible CRTCs to the plane configuration and helpers to
attach, detach and get the primary and cursor planes attached to a CRTC.

Now that the default configuration has its planes and CRTC correctly
attached, configure the output following the configuration.

Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
Co-developed-by: Louis Chauvet <louis.chauvet@bootlin.com>
Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 .clang-format                                 |   1 +
 drivers/gpu/drm/vkms/tests/vkms_config_test.c | 222 ++++++++++++++++++
 drivers/gpu/drm/vkms/vkms_config.c            | 154 ++++++++++--
 drivers/gpu/drm/vkms/vkms_config.h            |  59 ++++-
 drivers/gpu/drm/vkms/vkms_drv.c               |   3 +-
 drivers/gpu/drm/vkms/vkms_output.c            |  51 ++--
 6 files changed, 454 insertions(+), 36 deletions(-)

diff --git a/.clang-format b/.clang-format
index e7a901c3617d..6f944fa39841 100644
--- a/.clang-format
+++ b/.clang-format
@@ -692,6 +692,7 @@ ForEachMacros:
   - 'virtio_device_for_each_vq'
   - 'vkms_config_for_each_crtc'
   - 'vkms_config_for_each_plane'
+  - 'vkms_config_plane_for_each_possible_crtc'
   - 'while_for_each_ftrace_op'
   - 'xa_for_each'
   - 'xa_for_each_marked'
diff --git a/drivers/gpu/drm/vkms/tests/vkms_config_test.c b/drivers/gpu/drm/vkms/tests/vkms_config_test.c
index 104120c91c39..0997ea924ab7 100644
--- a/drivers/gpu/drm/vkms/tests/vkms_config_test.c
+++ b/drivers/gpu/drm/vkms/tests/vkms_config_test.c
@@ -118,6 +118,18 @@ static void vkms_config_test_default_config(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, vkms_config_crtc_get_writeback(crtc_cfg),
 			params->enable_writeback);
 
+	vkms_config_for_each_plane(config, plane_cfg) {
+		struct vkms_config_crtc *possible_crtc;
+		int n_possible_crtcs = 0;
+		unsigned long idx = 0;
+
+		vkms_config_plane_for_each_possible_crtc(plane_cfg, idx, possible_crtc) {
+			KUNIT_EXPECT_PTR_EQ(test, crtc_cfg, possible_crtc);
+			n_possible_crtcs++;
+		}
+		KUNIT_EXPECT_EQ(test, n_possible_crtcs, 1);
+	}
+
 	KUNIT_EXPECT_TRUE(test, vkms_config_is_valid(config));
 
 	vkms_config_destroy(config);
@@ -230,6 +242,8 @@ static void vkms_config_test_valid_plane_type(struct kunit *test)
 {
 	struct vkms_config *config;
 	struct vkms_config_plane *plane_cfg;
+	struct vkms_config_crtc *crtc_cfg;
+	int err;
 
 	config = vkms_config_default_create(false, false, false);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, config);
@@ -237,16 +251,26 @@ static void vkms_config_test_valid_plane_type(struct kunit *test)
 	plane_cfg = get_first_plane(config);
 	vkms_config_destroy_plane(plane_cfg);
 
+	crtc_cfg = get_first_crtc(config);
+
 	/* Invalid: No primary plane */
 	plane_cfg = vkms_config_create_plane(config);
 	vkms_config_plane_set_type(plane_cfg, DRM_PLANE_TYPE_OVERLAY);
+	err = vkms_config_plane_attach_crtc(plane_cfg, crtc_cfg);
+	KUNIT_EXPECT_EQ(test, err, 0);
 	KUNIT_EXPECT_FALSE(test, vkms_config_is_valid(config));
 
 	/* Invalid: Multiple primary planes */
 	plane_cfg = vkms_config_create_plane(config);
 	vkms_config_plane_set_type(plane_cfg, DRM_PLANE_TYPE_PRIMARY);
+	err = vkms_config_plane_attach_crtc(plane_cfg, crtc_cfg);
+	KUNIT_EXPECT_EQ(test, err, 0);
+
 	plane_cfg = vkms_config_create_plane(config);
 	vkms_config_plane_set_type(plane_cfg, DRM_PLANE_TYPE_PRIMARY);
+	err = vkms_config_plane_attach_crtc(plane_cfg, crtc_cfg);
+	KUNIT_EXPECT_EQ(test, err, 0);
+
 	KUNIT_EXPECT_FALSE(test, vkms_config_is_valid(config));
 
 	/* Valid: One primary plane */
@@ -256,14 +280,50 @@ static void vkms_config_test_valid_plane_type(struct kunit *test)
 	/* Invalid: Multiple cursor planes */
 	plane_cfg = vkms_config_create_plane(config);
 	vkms_config_plane_set_type(plane_cfg, DRM_PLANE_TYPE_CURSOR);
+	err = vkms_config_plane_attach_crtc(plane_cfg, crtc_cfg);
+	KUNIT_EXPECT_EQ(test, err, 0);
+
 	plane_cfg = vkms_config_create_plane(config);
 	vkms_config_plane_set_type(plane_cfg, DRM_PLANE_TYPE_CURSOR);
+	err = vkms_config_plane_attach_crtc(plane_cfg, crtc_cfg);
+	KUNIT_EXPECT_EQ(test, err, 0);
+
 	KUNIT_EXPECT_FALSE(test, vkms_config_is_valid(config));
 
 	/* Valid: One primary and one cursor plane */
 	vkms_config_destroy_plane(plane_cfg);
 	KUNIT_EXPECT_TRUE(test, vkms_config_is_valid(config));
 
+	/* Invalid: Second CRTC without primary plane */
+	crtc_cfg = vkms_config_create_crtc(config);
+	KUNIT_EXPECT_FALSE(test, vkms_config_is_valid(config));
+
+	/* Valid: Second CRTC with a primary plane */
+	plane_cfg = vkms_config_create_plane(config);
+	vkms_config_plane_set_type(plane_cfg, DRM_PLANE_TYPE_PRIMARY);
+	err = vkms_config_plane_attach_crtc(plane_cfg, crtc_cfg);
+	KUNIT_EXPECT_EQ(test, err, 0);
+	KUNIT_EXPECT_TRUE(test, vkms_config_is_valid(config));
+
+	vkms_config_destroy(config);
+}
+
+static void vkms_config_test_valid_plane_possible_crtcs(struct kunit *test)
+{
+	struct vkms_config *config;
+	struct vkms_config_plane *plane_cfg;
+	struct vkms_config_crtc *crtc_cfg;
+
+	config = vkms_config_default_create(false, false, false);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, config);
+
+	plane_cfg = get_first_plane(config);
+	crtc_cfg = get_first_crtc(config);
+
+	/* Invalid: Primary plane without a possible CRTC */
+	vkms_config_plane_detach_crtc(plane_cfg, crtc_cfg);
+	KUNIT_EXPECT_FALSE(test, vkms_config_is_valid(config));
+
 	vkms_config_destroy(config);
 }
 
@@ -290,6 +350,164 @@ static void vkms_config_test_invalid_crtc_number(struct kunit *test)
 	vkms_config_destroy(config);
 }
 
+static void vkms_config_test_attach_different_configs(struct kunit *test)
+{
+	struct vkms_config *config1, *config2;
+	struct vkms_config_plane *plane_cfg1, *plane_cfg2;
+	struct vkms_config_crtc *crtc_cfg1, *crtc_cfg2;
+	int err;
+
+	config1 = vkms_config_create("test1");
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, config1);
+
+	config2 = vkms_config_create("test2");
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, config2);
+
+	plane_cfg1 = vkms_config_create_plane(config1);
+	crtc_cfg1 = vkms_config_create_crtc(config1);
+
+	plane_cfg2 = vkms_config_create_plane(config2);
+	crtc_cfg2 = vkms_config_create_crtc(config2);
+
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, plane_cfg1);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, plane_cfg2);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, crtc_cfg1);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, crtc_cfg2);
+
+	err = vkms_config_plane_attach_crtc(plane_cfg1, crtc_cfg2);
+	KUNIT_EXPECT_NE(test, err, 0);
+	err = vkms_config_plane_attach_crtc(plane_cfg2, crtc_cfg1);
+	KUNIT_EXPECT_NE(test, err, 0);
+
+	vkms_config_destroy(config1);
+	vkms_config_destroy(config2);
+}
+
+static void vkms_config_test_plane_attach_crtc(struct kunit *test)
+{
+	struct vkms_config *config;
+	struct vkms_config_plane *overlay_cfg;
+	struct vkms_config_plane *primary_cfg;
+	struct vkms_config_plane *cursor_cfg;
+	struct vkms_config_crtc *crtc_cfg;
+	int err;
+
+	config = vkms_config_create("test");
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, config);
+
+	overlay_cfg = vkms_config_create_plane(config);
+	vkms_config_plane_set_type(overlay_cfg, DRM_PLANE_TYPE_OVERLAY);
+	primary_cfg = vkms_config_create_plane(config);
+	vkms_config_plane_set_type(primary_cfg, DRM_PLANE_TYPE_PRIMARY);
+	cursor_cfg = vkms_config_create_plane(config);
+	vkms_config_plane_set_type(cursor_cfg, DRM_PLANE_TYPE_CURSOR);
+
+	crtc_cfg = vkms_config_create_crtc(config);
+
+	/* No primary or cursor planes */
+	KUNIT_EXPECT_NULL(test, vkms_config_crtc_primary_plane(config, crtc_cfg));
+	KUNIT_EXPECT_NULL(test, vkms_config_crtc_cursor_plane(config, crtc_cfg));
+
+	/* Overlay plane, but no primary or cursor planes */
+	err = vkms_config_plane_attach_crtc(overlay_cfg, crtc_cfg);
+	KUNIT_EXPECT_EQ(test, err, 0);
+	KUNIT_EXPECT_NULL(test, vkms_config_crtc_primary_plane(config, crtc_cfg));
+	KUNIT_EXPECT_NULL(test, vkms_config_crtc_cursor_plane(config, crtc_cfg));
+
+	/* Primary plane, attaching it twice must fail */
+	err = vkms_config_plane_attach_crtc(primary_cfg, crtc_cfg);
+	KUNIT_EXPECT_EQ(test, err, 0);
+	err = vkms_config_plane_attach_crtc(primary_cfg, crtc_cfg);
+	KUNIT_EXPECT_NE(test, err, 0);
+	KUNIT_EXPECT_PTR_EQ(test,
+			    vkms_config_crtc_primary_plane(config, crtc_cfg),
+			    primary_cfg);
+	KUNIT_EXPECT_NULL(test, vkms_config_crtc_cursor_plane(config, crtc_cfg));
+
+	/* Primary and cursor planes */
+	err = vkms_config_plane_attach_crtc(cursor_cfg, crtc_cfg);
+	KUNIT_EXPECT_EQ(test, err, 0);
+	KUNIT_EXPECT_PTR_EQ(test,
+			    vkms_config_crtc_primary_plane(config, crtc_cfg),
+			    primary_cfg);
+	KUNIT_EXPECT_PTR_EQ(test,
+			    vkms_config_crtc_cursor_plane(config, crtc_cfg),
+			    cursor_cfg);
+
+	/* Detach primary and destroy cursor plane */
+	vkms_config_plane_detach_crtc(overlay_cfg, crtc_cfg);
+	vkms_config_plane_detach_crtc(primary_cfg, crtc_cfg);
+	vkms_config_destroy_plane(cursor_cfg);
+	KUNIT_EXPECT_NULL(test, vkms_config_crtc_primary_plane(config, crtc_cfg));
+	KUNIT_EXPECT_NULL(test, vkms_config_crtc_cursor_plane(config, crtc_cfg));
+
+	vkms_config_destroy(config);
+}
+
+static void vkms_config_test_plane_get_possible_crtcs(struct kunit *test)
+{
+	struct vkms_config *config;
+	struct vkms_config_plane *plane_cfg1, *plane_cfg2;
+	struct vkms_config_crtc *crtc_cfg1, *crtc_cfg2;
+	struct vkms_config_crtc *possible_crtc;
+	unsigned long idx = 0;
+	int n_crtcs = 0;
+	int err;
+
+	config = vkms_config_create("test");
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, config);
+
+	plane_cfg1 = vkms_config_create_plane(config);
+	plane_cfg2 = vkms_config_create_plane(config);
+	crtc_cfg1 = vkms_config_create_crtc(config);
+	crtc_cfg2 = vkms_config_create_crtc(config);
+
+	/* No possible CRTCs */
+	vkms_config_plane_for_each_possible_crtc(plane_cfg1, idx, possible_crtc)
+		KUNIT_FAIL(test, "Unexpected possible CRTC");
+
+	vkms_config_plane_for_each_possible_crtc(plane_cfg2, idx, possible_crtc)
+		KUNIT_FAIL(test, "Unexpected possible CRTC");
+
+	/* Plane 1 attached to CRTC 1 and 2 */
+	err = vkms_config_plane_attach_crtc(plane_cfg1, crtc_cfg1);
+	KUNIT_EXPECT_EQ(test, err, 0);
+	err = vkms_config_plane_attach_crtc(plane_cfg1, crtc_cfg2);
+	KUNIT_EXPECT_EQ(test, err, 0);
+
+	vkms_config_plane_for_each_possible_crtc(plane_cfg1, idx, possible_crtc) {
+		n_crtcs++;
+		if (possible_crtc != crtc_cfg1 && possible_crtc != crtc_cfg2)
+			KUNIT_FAIL(test, "Unexpected possible CRTC");
+	}
+	KUNIT_ASSERT_EQ(test, n_crtcs, 2);
+	n_crtcs = 0;
+
+	vkms_config_plane_for_each_possible_crtc(plane_cfg2, idx, possible_crtc)
+		KUNIT_FAIL(test, "Unexpected possible CRTC");
+
+	/* Plane 1 attached to CRTC 1 and plane 2 to CRTC 2 */
+	vkms_config_plane_detach_crtc(plane_cfg1, crtc_cfg2);
+	vkms_config_plane_for_each_possible_crtc(plane_cfg1, idx, possible_crtc) {
+		n_crtcs++;
+		if (possible_crtc != crtc_cfg1)
+			KUNIT_FAIL(test, "Unexpected possible CRTC");
+	}
+	KUNIT_ASSERT_EQ(test, n_crtcs, 1);
+	n_crtcs = 0;
+
+	err = vkms_config_plane_attach_crtc(plane_cfg2, crtc_cfg2);
+	KUNIT_EXPECT_EQ(test, err, 0);
+	vkms_config_plane_for_each_possible_crtc(plane_cfg2, idx, possible_crtc) {
+		n_crtcs++;
+		if (possible_crtc != crtc_cfg2)
+			KUNIT_FAIL(test, "Unexpected possible CRTC");
+	}
+	KUNIT_ASSERT_EQ(test, n_crtcs, 1);
+
+	vkms_config_destroy(config);
+}
+
 static struct kunit_case vkms_config_test_cases[] = {
 	KUNIT_CASE(vkms_config_test_empty_config),
 	KUNIT_CASE_PARAM(vkms_config_test_default_config,
@@ -298,7 +516,11 @@ static struct kunit_case vkms_config_test_cases[] = {
 	KUNIT_CASE(vkms_config_test_get_crtcs),
 	KUNIT_CASE(vkms_config_test_invalid_plane_number),
 	KUNIT_CASE(vkms_config_test_valid_plane_type),
+	KUNIT_CASE(vkms_config_test_valid_plane_possible_crtcs),
 	KUNIT_CASE(vkms_config_test_invalid_crtc_number),
+	KUNIT_CASE(vkms_config_test_attach_different_configs),
+	KUNIT_CASE(vkms_config_test_plane_attach_crtc),
+	KUNIT_CASE(vkms_config_test_plane_get_possible_crtcs),
 	{}
 };
 
diff --git a/drivers/gpu/drm/vkms/vkms_config.c b/drivers/gpu/drm/vkms/vkms_config.c
index d195db770fae..458385413648 100644
--- a/drivers/gpu/drm/vkms/vkms_config.c
+++ b/drivers/gpu/drm/vkms/vkms_config.c
@@ -52,13 +52,20 @@ struct vkms_config *vkms_config_default_create(bool enable_cursor,
 		goto err_alloc;
 	vkms_config_crtc_set_writeback(crtc_cfg, enable_writeback);
 
+	if (vkms_config_plane_attach_crtc(plane_cfg, crtc_cfg))
+		goto err_alloc;
+
 	if (enable_overlay) {
 		for (n = 0; n < NUM_OVERLAY_PLANES; n++) {
 			plane_cfg = vkms_config_create_plane(config);
 			if (IS_ERR(plane_cfg))
 				goto err_alloc;
+
 			vkms_config_plane_set_type(plane_cfg,
 						   DRM_PLANE_TYPE_OVERLAY);
+
+			if (vkms_config_plane_attach_crtc(plane_cfg, crtc_cfg))
+				goto err_alloc;
 		}
 	}
 
@@ -66,7 +73,11 @@ struct vkms_config *vkms_config_default_create(bool enable_cursor,
 		plane_cfg = vkms_config_create_plane(config);
 		if (IS_ERR(plane_cfg))
 			goto err_alloc;
+
 		vkms_config_plane_set_type(plane_cfg, DRM_PLANE_TYPE_CURSOR);
+
+		if (vkms_config_plane_attach_crtc(plane_cfg, crtc_cfg))
+			goto err_alloc;
 	}
 
 	return config;
@@ -107,7 +118,8 @@ static bool valid_plane_number(const struct vkms_config *config)
 	return true;
 }
 
-static bool valid_plane_type(const struct vkms_config *config)
+static bool valid_planes_for_crtc(const struct vkms_config *config,
+				  struct vkms_config_crtc *crtc_cfg)
 {
 	struct drm_device *dev = config->dev ? &config->dev->drm : NULL;
 	struct vkms_config_plane *plane_cfg;
@@ -115,24 +127,31 @@ static bool valid_plane_type(const struct vkms_config *config)
 	bool has_cursor_plane = false;
 
 	vkms_config_for_each_plane(config, plane_cfg) {
+		struct vkms_config_crtc *possible_crtc;
+		unsigned long idx = 0;
 		enum drm_plane_type type;
 
 		type = vkms_config_plane_get_type(plane_cfg);
 
-		if (type == DRM_PLANE_TYPE_PRIMARY) {
-			if (has_primary_plane) {
-				drm_info(dev, "Multiple primary planes\n");
-				return false;
-			}
+		vkms_config_plane_for_each_possible_crtc(plane_cfg, idx, possible_crtc) {
+			if (possible_crtc != crtc_cfg)
+				continue;
 
-			has_primary_plane = true;
-		} else if (type == DRM_PLANE_TYPE_CURSOR) {
-			if (has_cursor_plane) {
-				drm_info(dev, "Multiple cursor planes\n");
-				return false;
-			}
+			if (type == DRM_PLANE_TYPE_PRIMARY) {
+				if (has_primary_plane) {
+					drm_info(dev, "Multiple primary planes\n");
+					return false;
+				}
 
-			has_cursor_plane = true;
+				has_primary_plane = true;
+			} else if (type == DRM_PLANE_TYPE_CURSOR) {
+				if (has_cursor_plane) {
+					drm_info(dev, "Multiple cursor planes\n");
+					return false;
+				}
+
+				has_cursor_plane = true;
+			}
 		}
 	}
 
@@ -144,6 +163,21 @@ static bool valid_plane_type(const struct vkms_config *config)
 	return true;
 }
 
+static bool valid_plane_possible_crtcs(const struct vkms_config *config)
+{
+	struct drm_device *dev = config->dev ? &config->dev->drm : NULL;
+	struct vkms_config_plane *plane_cfg;
+
+	vkms_config_for_each_plane(config, plane_cfg) {
+		if (xa_empty(&plane_cfg->possible_crtcs)) {
+			drm_info(dev, "All planes must have at least one possible CRTC\n");
+			return false;
+		}
+	}
+
+	return true;
+}
+
 static bool valid_crtc_number(const struct vkms_config *config)
 {
 	struct drm_device *dev = config->dev ? &config->dev->drm : NULL;
@@ -160,15 +194,22 @@ static bool valid_crtc_number(const struct vkms_config *config)
 
 bool vkms_config_is_valid(const struct vkms_config *config)
 {
+	struct vkms_config_crtc *crtc_cfg;
+
 	if (!valid_plane_number(config))
 		return false;
 
 	if (!valid_crtc_number(config))
 		return false;
 
-	if (!valid_plane_type(config))
+	if (!valid_plane_possible_crtcs(config))
 		return false;
 
+	vkms_config_for_each_crtc(config, crtc_cfg) {
+		if (!valid_planes_for_crtc(config, crtc_cfg))
+			return false;
+	}
+
 	return true;
 }
 EXPORT_SYMBOL_IF_KUNIT(vkms_config_is_valid);
@@ -220,6 +261,7 @@ struct vkms_config_plane *vkms_config_create_plane(struct vkms_config *config)
 
 	plane_cfg->config = config;
 	vkms_config_plane_set_type(plane_cfg, DRM_PLANE_TYPE_OVERLAY);
+	xa_init_flags(&plane_cfg->possible_crtcs, XA_FLAGS_ALLOC);
 
 	list_add_tail(&plane_cfg->link, &config->planes);
 
@@ -229,11 +271,45 @@ EXPORT_SYMBOL_IF_KUNIT(vkms_config_create_plane);
 
 void vkms_config_destroy_plane(struct vkms_config_plane *plane_cfg)
 {
+	xa_destroy(&plane_cfg->possible_crtcs);
 	list_del(&plane_cfg->link);
 	kfree(plane_cfg);
 }
 EXPORT_SYMBOL_IF_KUNIT(vkms_config_destroy_plane);
 
+int __must_check vkms_config_plane_attach_crtc(struct vkms_config_plane *plane_cfg,
+					       struct vkms_config_crtc *crtc_cfg)
+{
+	struct vkms_config_crtc *possible_crtc;
+	unsigned long idx = 0;
+	u32 crtc_idx = 0;
+
+	if (plane_cfg->config != crtc_cfg->config)
+		return -EINVAL;
+
+	vkms_config_plane_for_each_possible_crtc(plane_cfg, idx, possible_crtc) {
+		if (possible_crtc == crtc_cfg)
+			return -EEXIST;
+	}
+
+	return xa_alloc(&plane_cfg->possible_crtcs, &crtc_idx, crtc_cfg,
+			xa_limit_32b, GFP_KERNEL);
+}
+EXPORT_SYMBOL_IF_KUNIT(vkms_config_plane_attach_crtc);
+
+void vkms_config_plane_detach_crtc(struct vkms_config_plane *plane_cfg,
+				   struct vkms_config_crtc *crtc_cfg)
+{
+	struct vkms_config_crtc *possible_crtc;
+	unsigned long idx = 0;
+
+	vkms_config_plane_for_each_possible_crtc(plane_cfg, idx, possible_crtc) {
+		if (possible_crtc == crtc_cfg)
+			xa_erase(&plane_cfg->possible_crtcs, idx);
+	}
+}
+EXPORT_SYMBOL_IF_KUNIT(vkms_config_plane_detach_crtc);
+
 struct vkms_config_crtc *vkms_config_create_crtc(struct vkms_config *config)
 {
 	struct vkms_config_crtc *crtc_cfg;
@@ -254,7 +330,57 @@ EXPORT_SYMBOL_IF_KUNIT(vkms_config_create_crtc);
 void vkms_config_destroy_crtc(struct vkms_config *config,
 			      struct vkms_config_crtc *crtc_cfg)
 {
+	struct vkms_config_plane *plane_cfg;
+
+	vkms_config_for_each_plane(config, plane_cfg)
+		vkms_config_plane_detach_crtc(plane_cfg, crtc_cfg);
+
 	list_del(&crtc_cfg->link);
 	kfree(crtc_cfg);
 }
 EXPORT_SYMBOL_IF_KUNIT(vkms_config_destroy_crtc);
+
+/**
+ * vkms_config_crtc_get_plane() - Return the first attached plane to a CRTC with
+ * the specific type
+ * @config: Configuration containing the CRTC and the plane
+ * @crtc_cfg: Only find planes attached to this CRTC
+ * @type: Plane type to search
+ *
+ * Returns:
+ * The first plane found attached to @crtc_cfg with the type @type.
+ */
+static struct vkms_config_plane *vkms_config_crtc_get_plane(const struct vkms_config *config,
+							    struct vkms_config_crtc *crtc_cfg,
+							    enum drm_plane_type type)
+{
+	struct vkms_config_plane *plane_cfg;
+	struct vkms_config_crtc *possible_crtc;
+	enum drm_plane_type current_type;
+	unsigned long idx = 0;
+
+	vkms_config_for_each_plane(config, plane_cfg) {
+		current_type = vkms_config_plane_get_type(plane_cfg);
+
+		vkms_config_plane_for_each_possible_crtc(plane_cfg, idx, possible_crtc) {
+			if (possible_crtc == crtc_cfg && current_type == type)
+				return plane_cfg;
+		}
+	}
+
+	return NULL;
+}
+
+struct vkms_config_plane *vkms_config_crtc_primary_plane(const struct vkms_config *config,
+							 struct vkms_config_crtc *crtc_cfg)
+{
+	return vkms_config_crtc_get_plane(config, crtc_cfg, DRM_PLANE_TYPE_PRIMARY);
+}
+EXPORT_SYMBOL_IF_KUNIT(vkms_config_crtc_primary_plane);
+
+struct vkms_config_plane *vkms_config_crtc_cursor_plane(const struct vkms_config *config,
+							struct vkms_config_crtc *crtc_cfg)
+{
+	return vkms_config_crtc_get_plane(config, crtc_cfg, DRM_PLANE_TYPE_CURSOR);
+}
+EXPORT_SYMBOL_IF_KUNIT(vkms_config_crtc_cursor_plane);
diff --git a/drivers/gpu/drm/vkms/vkms_config.h b/drivers/gpu/drm/vkms/vkms_config.h
index 978418db84b9..ad303b34ee03 100644
--- a/drivers/gpu/drm/vkms/vkms_config.h
+++ b/drivers/gpu/drm/vkms/vkms_config.h
@@ -5,6 +5,7 @@
 
 #include <linux/list.h>
 #include <linux/types.h>
+#include <linux/xarray.h>
 
 #include "vkms_drv.h"
 
@@ -12,14 +13,12 @@
  * struct vkms_config - General configuration for VKMS driver
  *
  * @dev_name: Name of the device
- * @writeback: If true, a writeback buffer can be attached to the CRTC
  * @planes: List of planes configured for the device
  * @crtcs: List of CRTCs configured for the device
  * @dev: Used to store the current VKMS device. Only set when the device is instantiated.
  */
 struct vkms_config {
 	const char *dev_name;
-	bool writeback;
 	struct list_head planes;
 	struct list_head crtcs;
 	struct vkms_device *dev;
@@ -32,6 +31,7 @@ struct vkms_config {
  * @config: The vkms_config this plane belongs to
  * @type: Type of the plane. The creator of configuration needs to ensures that
  *        at least one primary plane is present.
+ * @possible_crtcs: Array of CRTCs that can be used with this plane
  * @plane: Internal usage. This pointer should never be considered as valid.
  *         It can be used to store a temporary reference to a VKMS plane during
  *         device creation. This pointer is not managed by the configuration and
@@ -42,6 +42,7 @@ struct vkms_config_plane {
 	struct vkms_config *config;
 
 	enum drm_plane_type type;
+	struct xarray possible_crtcs;
 
 	/* Internal usage */
 	struct vkms_plane *plane;
@@ -84,6 +85,16 @@ struct vkms_config_crtc {
 #define vkms_config_for_each_crtc(config, crtc_cfg) \
 	list_for_each_entry((crtc_cfg), &(config)->crtcs, link)
 
+/**
+ * vkms_config_plane_for_each_possible_crtc - Iterate over the vkms_config_plane
+ * possible CRTCs
+ * @plane_cfg: &struct vkms_config_plane pointer
+ * @idx: Index of the cursor
+ * @possible_crtc: &struct vkms_config_crtc pointer used as cursor
+ */
+#define vkms_config_plane_for_each_possible_crtc(plane_cfg, idx, possible_crtc) \
+	xa_for_each(&(plane_cfg)->possible_crtcs, idx, (possible_crtc))
+
 /**
  * vkms_config_create() - Create a new VKMS configuration
  * @dev_name: Name of the device
@@ -191,6 +202,22 @@ vkms_config_plane_set_type(struct vkms_config_plane *plane_cfg,
 	plane_cfg->type = type;
 }
 
+/**
+ * vkms_config_plane_attach_crtc - Attach a plane to a CRTC
+ * @plane_cfg: Plane to attach
+ * @crtc_cfg: CRTC to attach @plane_cfg to
+ */
+int __must_check vkms_config_plane_attach_crtc(struct vkms_config_plane *plane_cfg,
+					       struct vkms_config_crtc *crtc_cfg);
+
+/**
+ * vkms_config_plane_detach_crtc - Detach a plane from a CRTC
+ * @plane_cfg: Plane to detach
+ * @crtc_cfg: CRTC to detach @plane_cfg from
+ */
+void vkms_config_plane_detach_crtc(struct vkms_config_plane *plane_cfg,
+				   struct vkms_config_crtc *crtc_cfg);
+
 /**
  * vkms_config_create_crtc() - Add a new CRTC configuration
  * @config: Configuration to add the CRTC to
@@ -231,4 +258,32 @@ vkms_config_crtc_set_writeback(struct vkms_config_crtc *crtc_cfg,
 	crtc_cfg->writeback = writeback;
 }
 
+/**
+ * vkms_config_crtc_primary_plane() - Return the primary plane for a CRTC
+ * @config: Configuration containing the CRTC
+ * @crtc_config: Target CRTC
+ *
+ * Note that, if multiple primary planes are found, the first one is returned.
+ * In this case, the configuration will be invalid. See vkms_config_is_valid().
+ *
+ * Returns:
+ * The primary plane or NULL if none is assigned yet.
+ */
+struct vkms_config_plane *vkms_config_crtc_primary_plane(const struct vkms_config *config,
+							 struct vkms_config_crtc *crtc_cfg);
+
+/**
+ * vkms_config_crtc_cursor_plane() - Return the cursor plane for a CRTC
+ * @config: Configuration containing the CRTC
+ * @crtc_config: Target CRTC
+ *
+ * Note that, if multiple cursor planes are found, the first one is returned.
+ * In this case, the configuration will be invalid. See vkms_config_is_valid().
+ *
+ * Returns:
+ * The cursor plane or NULL if none is assigned yet.
+ */
+struct vkms_config_plane *vkms_config_crtc_cursor_plane(const struct vkms_config *config,
+							struct vkms_config_crtc *crtc_cfg);
+
 #endif /* _VKMS_CONFIG_H_ */
diff --git a/drivers/gpu/drm/vkms/vkms_drv.c b/drivers/gpu/drm/vkms/vkms_drv.c
index ba977ef09b2b..a24d1655f7b8 100644
--- a/drivers/gpu/drm/vkms/vkms_drv.c
+++ b/drivers/gpu/drm/vkms/vkms_drv.c
@@ -181,7 +181,8 @@ static int vkms_create(struct vkms_config *config)
 		goto out_devres;
 	}
 
-	ret = drm_vblank_init(&vkms_device->drm, 1);
+	ret = drm_vblank_init(&vkms_device->drm,
+			      vkms_config_get_num_crtcs(config));
 	if (ret) {
 		DRM_ERROR("Failed to vblank\n");
 		goto out_devres;
diff --git a/drivers/gpu/drm/vkms/vkms_output.c b/drivers/gpu/drm/vkms/vkms_output.c
index 08ea691db299..f63bc8e3014b 100644
--- a/drivers/gpu/drm/vkms/vkms_output.c
+++ b/drivers/gpu/drm/vkms/vkms_output.c
@@ -10,9 +10,8 @@ int vkms_output_init(struct vkms_device *vkmsdev)
 	struct drm_device *dev = &vkmsdev->drm;
 	struct vkms_connector *connector;
 	struct drm_encoder *encoder;
-	struct vkms_output *output;
-	struct vkms_plane *primary = NULL, *cursor = NULL;
 	struct vkms_config_plane *plane_cfg;
+	struct vkms_config_crtc *crtc_cfg;
 	int ret;
 	int writeback;
 
@@ -29,18 +28,37 @@ int vkms_output_init(struct vkms_device *vkmsdev)
 			DRM_DEV_ERROR(dev->dev, "Failed to init vkms plane\n");
 			return PTR_ERR(plane_cfg->plane);
 		}
+	}
+
+	vkms_config_for_each_crtc(vkmsdev->config, crtc_cfg) {
+		struct vkms_config_plane *primary, *cursor;
+
+		primary = vkms_config_crtc_primary_plane(vkmsdev->config, crtc_cfg);
+		cursor = vkms_config_crtc_cursor_plane(vkmsdev->config, crtc_cfg);
 
-		if (type == DRM_PLANE_TYPE_PRIMARY)
-			primary = plane_cfg->plane;
-		else if (type == DRM_PLANE_TYPE_CURSOR)
-			cursor = plane_cfg->plane;
+		crtc_cfg->crtc = vkms_crtc_init(dev, &primary->plane->base,
+						cursor ? &cursor->plane->base : NULL);
+		if (IS_ERR(crtc_cfg->crtc)) {
+			DRM_ERROR("Failed to allocate CRTC\n");
+			return PTR_ERR(crtc_cfg->crtc);
+		}
+
+		/* Initialize the writeback component */
+		if (vkms_config_crtc_get_writeback(crtc_cfg)) {
+			writeback = vkms_enable_writeback_connector(vkmsdev, crtc_cfg->crtc);
+			if (writeback)
+				DRM_ERROR("Failed to init writeback connector\n");
+		}
 	}
 
-	output = vkms_crtc_init(dev, &primary->base,
-				cursor ? &cursor->base : NULL);
-	if (IS_ERR(output)) {
-		DRM_ERROR("Failed to allocate CRTC\n");
-		return PTR_ERR(output);
+	vkms_config_for_each_plane(vkmsdev->config, plane_cfg) {
+		struct vkms_config_crtc *possible_crtc;
+		unsigned long idx = 0;
+
+		vkms_config_plane_for_each_possible_crtc(plane_cfg, idx, possible_crtc) {
+			plane_cfg->plane->base.possible_crtcs |=
+				drm_crtc_mask(&possible_crtc->crtc->crtc);
+		}
 	}
 
 	connector = vkms_connector_init(vkmsdev);
@@ -60,7 +78,9 @@ int vkms_output_init(struct vkms_device *vkmsdev)
 		DRM_ERROR("Failed to init encoder\n");
 		return ret;
 	}
-	encoder->possible_crtcs = drm_crtc_mask(&output->crtc);
+
+	vkms_config_for_each_crtc(vkmsdev->config, crtc_cfg)
+		encoder->possible_crtcs = drm_crtc_mask(&crtc_cfg->crtc->crtc);
 
 	/* Attach the encoder and the connector */
 	ret = drm_connector_attach_encoder(&connector->base, encoder);
@@ -69,13 +89,6 @@ int vkms_output_init(struct vkms_device *vkmsdev)
 		return ret;
 	}
 
-	/* Initialize the writeback component */
-	if (vkmsdev->config->writeback) {
-		writeback = vkms_enable_writeback_connector(vkmsdev, output);
-		if (writeback)
-			DRM_ERROR("Failed to init writeback connector\n");
-	}
-
 	drm_mode_config_reset(dev);
 
 	return ret;
-- 
2.48.1


