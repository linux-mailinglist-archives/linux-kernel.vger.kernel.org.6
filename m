Return-Path: <linux-kernel+bounces-517317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95429A37F45
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 11:04:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A37103A36A5
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 10:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EC9121771E;
	Mon, 17 Feb 2025 10:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WjhHDUHW"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF0FF217652
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 10:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739786493; cv=none; b=FNupN4NEX4Cq7Xp0wQZ549oIYZPGhW4g5w4eXneGmUw21l1tiTsjPtbEc7rAv7TjQC52zW1l0DXk/eZbn7Q6eyrqkG1nZdv3k9t7rhm3Jz8w3Pxbt+7qYHfTDxxaQKaTsWqPSrMcBjz8obC7GOQ/tnQeLZ+UuVLpUhh/DueWpb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739786493; c=relaxed/simple;
	bh=ECz5X7I3+CKYQXuInRYoI309iDJXr8+oXd0YASKhnBw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IyCuM4u0q12lCAaKUG1fNFsNerC9TvgpPCcfFqe4zkcno5gCgZLRJqn/CO1yrJianJL2RM0EfRPVM8egj7Lt6g+om892D+/7m1Uwk/sjQG9b4us2iq3KY3xmHNdGCg7CljksCYEWySgGgoZh8i0QQGSTjvpH4OONHJheibYix2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WjhHDUHW; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4395dddb07dso43338365e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 02:01:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739786490; x=1740391290; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=an4ZlObHhfs530zfnSQ9jtNvfBOIXbJcmgdk2xLIJkM=;
        b=WjhHDUHWHoE2ms8Zf6D+2E28QgvF6kvtPqrFYHzICBYXxIr9kMZad+2zgisN2315KS
         FF1AKvzCFoNyZaYD1LVdaiv4HDHW5GiBjf2Tocwn9jHZnHTF2xlmzhRiO7+buvW+kXnc
         BnzkQBGrpVJkY1SKpVddwAyCcqQzge9+6lHacjD7XNhIspAuRomkwnT72g2aNgZxnqo6
         iKr4+PM8r5bZ79JgUSUtz+g1Zj1cDNgiGNEV/oGYYdXXU7CFhPgjJvR/EGvSGGcJR2XX
         Bht2UHupD7c4vM/4AQv0U4gnUXsW5OYoOJ6YNGzJTtCko6slcy4vqb+k2LAjzyHdomuH
         EC9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739786490; x=1740391290;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=an4ZlObHhfs530zfnSQ9jtNvfBOIXbJcmgdk2xLIJkM=;
        b=rombdL2tUyOl9KiwoXAS/tRSwRSYzWegnvFS4F46oFF7BJkggfv2nfTD+Td5s1wvZk
         JsbjV9qIPxC0cJ26+3piqP90uY5OgUlv/icPt0S4tXYRBa1HF70yZW2XcwpZHho0UXXQ
         YS8o8p+OaxVNiWhvwv53/f/9+20zEOcEzQE15+fkER97aeX9LkuitmiOHLc4siBZ9Fqm
         0Vht72Sf+ZMCyhPGjY7ADiSDJNMmlgYiV2GwisMazcQ7gpVnHnmECA/MMvUaCt8r9aVP
         Ub2mhPEZyyJ9hKzeFtKQ1TPdPhcB2ZmQq6ERrd1t6nFYpHO2019nXp/tto6QW1zoE4hz
         Y8+g==
X-Forwarded-Encrypted: i=1; AJvYcCVmiP57WI2UHDi0brelUJERl26cLRLuHuY20lnP6/8QGXBYPcNYnyPIh4GTXXatR2iLhe8bj1Nq9aW+JtI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvY9oCVqGK4JIRtzCaMFaQZBEWF9lowRmdDoZtocs7WjcXiJn7
	azqrNQc8j/jEret9yqlema2bTuIjRe+cNNB78g1BziH1aH+/BvlB
X-Gm-Gg: ASbGnctfGx9Iix4mvAlpPL8vySntV3ta/4fkoFiAkuZLEGtv1OEgzs1CCmzsildzdEf
	HDLEwXH+HNpoSesvGRQ0s9qUIzpBnFBJOnoVJRO/NaRUYZT2chadexuVxfLcSTCh0ToC96kBDaT
	KxMKqO2HISIFxCSzBWdxLyiR24fvdH1h0nJ9zNc7aFQayT04Sqjlrn/DHSCZQDmm+YOCHpoPAdV
	XFKLE4cdL5z3c7iDG0k7Pw1VwkFES8cRndn3xAZWFHsBMdLSIgbAvr4FRSbz60TTaOtC/W1n5ue
	d6zDfttn6gAh/682Dw==
X-Google-Smtp-Source: AGHT+IH4CwihIwVZG7tSArR4NUMsOT3lALCUrNrAZruadVHeYFhmux5YvQbpgfyRoPVEoAAf3qpcFg==
X-Received: by 2002:a5d:5f4e:0:b0:38f:329a:270f with SMTP id ffacd0b85a97d-38f3406787cmr9234492f8f.39.1739786489831;
        Mon, 17 Feb 2025 02:01:29 -0800 (PST)
Received: from fedora.. ([213.94.27.232])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259f7fe6sm11591901f8f.86.2025.02.17.02.01.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 02:01:29 -0800 (PST)
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
Subject: [PATCH v3 05/14] drm/vkms: Move default_config creation to its own function
Date: Mon, 17 Feb 2025 11:01:11 +0100
Message-ID: <20250217100120.7620-6-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250217100120.7620-1-jose.exposito89@gmail.com>
References: <20250217100120.7620-1-jose.exposito89@gmail.com>
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


