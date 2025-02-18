Return-Path: <linux-kernel+bounces-519149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79FB9A39880
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 11:16:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84D9D1679B9
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 10:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D9A023A58F;
	Tue, 18 Feb 2025 10:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SupFqq6R"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A74E923956D
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 10:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739873550; cv=none; b=tWbauNGNm1GhzDK2jz40sEap0vNTYO5g50SyMAY1U+o5tPzpLdOG6+HONkRY/P/8DCJ7Dd/vhf0vKoycQ6FEzKj9E8db+6z46UpyZdIO+eCXrfiUr+fyWkH25yPVQLwbZVWig/b7w8m2ufLgvd17k9DMEhLa1FyGnXFe/udvkns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739873550; c=relaxed/simple;
	bh=ECz5X7I3+CKYQXuInRYoI309iDJXr8+oXd0YASKhnBw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NctWA0Z0qBHi1cj2ycIHTZHUEwSwYapNfmwc5QTk0/qbPy0u0bKw+Z8LYTaoeV0gCnpmY7rH2XPA17OSwIuw5aryGGw3HZENtoQHfyztcQ76GzAGlW0bjqHtmhh0FSPBvGj5+ulgMSYk1ZVTgMjbvO8BaEsIwV7M/VHZga+W9Yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SupFqq6R; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-38f3486062eso2252178f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 02:12:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739873547; x=1740478347; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=an4ZlObHhfs530zfnSQ9jtNvfBOIXbJcmgdk2xLIJkM=;
        b=SupFqq6RzZ1VqyY40ipA5RnBExCJUC24BJK0JBkECQxElRnCzwIfJmryKeYgnIl6FE
         1DiqwrsffTLOp3J2G1okJmjcj3Z8HscLQxh3yZN+uALH23DMIHjp/bo5bUkhzPhU1Ust
         SRNyKhKsU0X6Xng8TIewNrnARYdX5oeoJJIW3DuSqzINWzfFIJSku3qmOW7cYza+nnha
         vyBVo1x4uTkrLZSLJsog2rcOvh2cgNiUMVE8W60QDunY3FvH3uhb03AHEip6hvkAbfiJ
         Rxq37fT8/KZ9699Me+mmp7C5TtASSlKGah7WjR1GREkDaOSfqhe5f0/BxRifJ8gez/Ie
         XCwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739873547; x=1740478347;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=an4ZlObHhfs530zfnSQ9jtNvfBOIXbJcmgdk2xLIJkM=;
        b=KJeO/yow41zWjkwpvHwrZGWuKBoYcTLxUq/bWle1SNuW6VDaFvXj/hKSWy5qqrVQYK
         tigxH2TG5RhP5XkkYvjnxdxRT60/p9LVeIzm9YWO3iKWEZUFHLFqRiZpQPL+Xvpi/5/F
         Qki/6s27yDP8GMtPGz1ZFwTKhj1xWM0N+x/MZlgbPmf5EbqO/ImITLMqBIg6yhoNsbEA
         niIRr79m3N8bb4NMq3mjKMAx5kEIL2002p94pIVeeXaQzaUvOlBzOF4AnqGuxLy9D8Fd
         NQnY7pEMdSJdzQ5uVpS5aio6jGrUUlDYBD2Vrvfe6CGRLPNIgc809w73CH7SpBNL+Yz7
         RjnQ==
X-Forwarded-Encrypted: i=1; AJvYcCWI9g3z+AjhkaE3eSZx8rPqoxnSXG2ZkpzBSkOIsccmpuhIDK0EFbK86pCxaXTxedaHxSRc+rZbDJ9GS4I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpYauEIbsYHQ7aeKGMWDflWa+zn8ADIpDBPvrJXqwjcs9ZhCPM
	QxMSXbT8OyAj6eb1aTLx6J3zo32D2R+D/YUd/iAEQOW8d4tQ8q4sOYPWfc7k
X-Gm-Gg: ASbGnctaEDeYGcz/Nisjb0Eno1r/1DRCjrE0lu1825kZaiKCMATJ+OWR0RQ0j/553UF
	baEje2JnUkugMNIFxV2WodOsJn1RsRptBiRKaYc9blQG9BPszvO1ygsw7B81iusqlLEc1DGU2z9
	Kyw8uysPTeLPndRX8YUmkxZcId1I2ElCag7sgrmYqYgj5KMSIOevQIdAi8x3uefQ3ABNsxHIKMp
	MV4Hr+J0xj396NUuSBd+2c3pJD4ABEanypgpYujTdycps44HqJJEyGfYvMZ5X1lf0T4B9P6XbtD
	lSOgWuUf65EpdfkBGQ==
X-Google-Smtp-Source: AGHT+IGJxHESmAAuUrG/TzfS69sJTg+tzboHhcOfguDL/BJgytBJbYzlmkjBEB91eQfNa8ZNIOKnVA==
X-Received: by 2002:a5d:64c2:0:b0:38f:470c:932e with SMTP id ffacd0b85a97d-38f470c9576mr5637822f8f.29.1739873546478;
        Tue, 18 Feb 2025 02:12:26 -0800 (PST)
Received: from fedora.. ([213.94.27.232])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259d5e92sm14749720f8f.66.2025.02.18.02.12.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 02:12:25 -0800 (PST)
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
Subject: [PATCH v4 05/14] drm/vkms: Move default_config creation to its own function
Date: Tue, 18 Feb 2025 11:12:05 +0100
Message-ID: <20250218101214.5790-6-jose.exposito89@gmail.com>
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

Extract the initialization of the default configuration to a function.
Refactor, no functional changes.

Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
Co-developed-by: Louis Chauvet <louis.chauvet@bootlin.com>
Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 drivers/gpu/drm/vkms/tests/vkms_config_test.c | 38 +++++++++++++++++++
 drivers/gpu/drm/vkms/vkms_config.c            | 18 +++++++++
 drivers/gpu/drm/vkms/vkms_config.h            | 14 +++++++
 drivers/gpu/drm/vkms/vkms_drv.c               |  6 +--
 4 files changed, 71 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/vkms/tests/vkms_config_test.c b/drivers/gpu/drm/vkms/tests/vkms_config_test.c
index a7060504f3dc..d8644a1e3e18 100644
--- a/drivers/gpu/drm/vkms/tests/vkms_config_test.c
+++ b/drivers/gpu/drm/vkms/tests/vkms_config_test.c
@@ -6,6 +6,12 @@
 
 MODULE_IMPORT_NS("EXPORTED_FOR_KUNIT_TESTING");
 
+struct default_config_case {
+	bool enable_cursor;
+	bool enable_writeback;
+	bool enable_overlay;
+};
+
 static void vkms_config_test_empty_config(struct kunit *test)
 {
 	struct vkms_config *config;
@@ -16,8 +22,40 @@ static void vkms_config_test_empty_config(struct kunit *test)
 	vkms_config_destroy(config);
 }
 
+static struct default_config_case default_config_cases[] = {
+	{ false, false, false },
+	{ true, false, false },
+	{ true, true, false },
+	{ true, false, true },
+	{ false, true, false },
+	{ false, true, true },
+	{ false, false, true },
+	{ true, true, true },
+};
+
+KUNIT_ARRAY_PARAM(default_config, default_config_cases, NULL);
+
+static void vkms_config_test_default_config(struct kunit *test)
+{
+	const struct default_config_case *params = test->param_value;
+	struct vkms_config *config;
+
+	config = vkms_config_default_create(params->enable_cursor,
+					    params->enable_writeback,
+					    params->enable_overlay);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, config);
+
+	KUNIT_EXPECT_EQ(test, config->cursor, params->enable_cursor);
+	KUNIT_EXPECT_EQ(test, config->writeback, params->enable_writeback);
+	KUNIT_EXPECT_EQ(test, config->overlay, params->enable_overlay);
+
+	vkms_config_destroy(config);
+}
+
 static struct kunit_case vkms_config_test_cases[] = {
 	KUNIT_CASE(vkms_config_test_empty_config),
+	KUNIT_CASE_PARAM(vkms_config_test_default_config,
+			 default_config_gen_params),
 	{}
 };
 
diff --git a/drivers/gpu/drm/vkms/vkms_config.c b/drivers/gpu/drm/vkms/vkms_config.c
index 42caa421876e..0af8e6dc0a01 100644
--- a/drivers/gpu/drm/vkms/vkms_config.c
+++ b/drivers/gpu/drm/vkms/vkms_config.c
@@ -20,6 +20,24 @@ struct vkms_config *vkms_config_create(void)
 }
 EXPORT_SYMBOL_IF_KUNIT(vkms_config_create);
 
+struct vkms_config *vkms_config_default_create(bool enable_cursor,
+					       bool enable_writeback,
+					       bool enable_overlay)
+{
+	struct vkms_config *config;
+
+	config = vkms_config_create();
+	if (IS_ERR(config))
+		return config;
+
+	config->cursor = enable_cursor;
+	config->writeback = enable_writeback;
+	config->overlay = enable_overlay;
+
+	return config;
+}
+EXPORT_SYMBOL_IF_KUNIT(vkms_config_default_create);
+
 void vkms_config_destroy(struct vkms_config *config)
 {
 	kfree(config);
diff --git a/drivers/gpu/drm/vkms/vkms_config.h b/drivers/gpu/drm/vkms/vkms_config.h
index ced10f56a812..d0868750826a 100644
--- a/drivers/gpu/drm/vkms/vkms_config.h
+++ b/drivers/gpu/drm/vkms/vkms_config.h
@@ -31,6 +31,20 @@ struct vkms_config {
  */
 struct vkms_config *vkms_config_create(void);
 
+/**
+ * vkms_config_default_create() - Create the configuration for the default device
+ * @enable_cursor: Create or not a cursor plane
+ * @enable_writeback: Create or not a writeback connector
+ * @enable_overlay: Create or not overlay planes
+ *
+ * Returns:
+ * The default vkms_config or an error. Call vkms_config_destroy() to free the
+ * returned configuration.
+ */
+struct vkms_config *vkms_config_default_create(bool enable_cursor,
+					       bool enable_writeback,
+					       bool enable_overlay);
+
 /**
  * vkms_config_destroy() - Free a VKMS configuration
  * @config: vkms_config to free
diff --git a/drivers/gpu/drm/vkms/vkms_drv.c b/drivers/gpu/drm/vkms/vkms_drv.c
index 37de0658e6ee..582d5825f42b 100644
--- a/drivers/gpu/drm/vkms/vkms_drv.c
+++ b/drivers/gpu/drm/vkms/vkms_drv.c
@@ -211,14 +211,10 @@ static int __init vkms_init(void)
 	int ret;
 	struct vkms_config *config;
 
-	config = vkms_config_create();
+	config = vkms_config_default_create(enable_cursor, enable_writeback, enable_overlay);
 	if (IS_ERR(config))
 		return PTR_ERR(config);
 
-	config->cursor = enable_cursor;
-	config->writeback = enable_writeback;
-	config->overlay = enable_overlay;
-
 	ret = vkms_create(config);
 	if (ret) {
 		vkms_config_destroy(config);
-- 
2.48.1


