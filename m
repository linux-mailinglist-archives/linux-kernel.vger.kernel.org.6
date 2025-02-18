Return-Path: <linux-kernel+bounces-519151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A36B5A39882
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 11:16:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36CE61888E3A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 10:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD24023644A;
	Tue, 18 Feb 2025 10:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mkuhy+09"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF0323BFA3
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 10:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739873552; cv=none; b=k03lVChn61aO+KtGl1Nv/of0tNRXNr2wn5oGi0u/3MqmOBK6rcUbheMIbn+/PAMG525EU0f1pkLXHGNgLEGG4ZkumNG1TUXSAFhU4VZZvAMTb6XPGyrj12dtH+IodbT7hxZkwykhmb9rIlZw0cfB2atT8DoeY32Jl7ecVeq8914=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739873552; c=relaxed/simple;
	bh=ezbRlCRRih7ztNQfSrHs4WhtoVlP3GIc2Vb1QT7R4sI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f3877hCaHTe7Is/Ba311asjUek7gCBkAAjSioSS9z6vdwSffzSeAqz9OF+BMt4Injt1KIkP0GxiJRQZNB5HFoy/U6nPXmXAXAInXWqsc3sy2Iy1GPbaqVCVkq+sHwNRH1v2X1tJNybNyd4mFizK3QmwxLzx4vHWdiFj5pij21LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mkuhy+09; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-38f325ddbc2so2476403f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 02:12:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739873548; x=1740478348; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vG84qkV7BJECjcnd+fwOr4EF0zkS6sxDafqd+tmcLZs=;
        b=Mkuhy+094D2Gcr/p8q9NNFuZl7JHGzKHA1pmzOOLaM4BWPelZ05eP4/ri+00QqwB42
         EqOqPp8btyPdUWMUsG104CmPQ+hsAR1CpTB0FpDIoUDyeJJf4VdbepPYiB3CSgf4D+D0
         ozb1zEg/5IZRy/ZUw06T+7/lISKhcE+co5lnAaLiFND8NHPqVP6Ua88t3BUrO0WfMTLd
         4OtMaRs4cNvMUQi1nfcAseyQwvpCxk0PswRYmFNvnEwl/Twpis7tpDaVkPIn+lEVqfsn
         ND/3tvIVnTrlOxxYX92WVsXDZxe+4uh12w5ZIns9dIsm2KWhqdr/fo1jTIudLZKnkAg8
         THRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739873548; x=1740478348;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vG84qkV7BJECjcnd+fwOr4EF0zkS6sxDafqd+tmcLZs=;
        b=VnW9jnKjx4UCTiJmjINMzaJeYob62AmebLQ7zh/7zg/JMwUO3uC1Ud7qouGH/sbuN/
         KZnFlMWW8Idf9vNl+TstPCcoH6lhdfCw6hYb5Z41HdhvXTm45ubwnakhR5KUJI75pSSW
         CrdptOOSqLUBZJg0K8S2qcQnWVStElaGqpb1H0h6jSGvC4Gvue2hlFcJs3sAN2RRLJXG
         GA1rOqQhBJNLDET4S21awWXRMbsFGl584BQ3oZaqJBjsZkM4DDdEcDelorJaIM9ah2HV
         Ir0zR5ULCAUq+9r0jghjuPuQThlIfWQDwmrH+uI0PX/kQvwf4lJkWwzcFAUXup012IsK
         tYCw==
X-Forwarded-Encrypted: i=1; AJvYcCWUZYGpbv6sJ9onEU/3iWay/ieiENvZ2uOglbXJgfrKDdeTvDkUI7jxYavZc2VW4inlRk+7Ul5d+/qdMy8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdJolcXjr8phgAgT6nmbj5xUVfRta8+/GiodPRBmCmJEPacK1V
	DOHY7NHrgCEv3xlMTdp9OEK/mNLCwyFD7Zt4VdwNP4tz9p6ncVQd
X-Gm-Gg: ASbGncuClNvzLr74+RiJbL9oaJmlqJMQfqmBxOCYWP3kHXqEPVLeuBx5ZUPSFDc/q5I
	Q/0mDV6W+AZbqfhHVjODBYr+twtf1XLfLdGWe9DvAKOLF3ZZsjt5qK85geTIlAWiXv/oaVJDm19
	bkwzTD+6VA94TdHakM35ZruAp4TgHlaRYVWSiYbMIn6NZM88b8nOsb/Hw1x0jOND+h3F9RAqExO
	SxKDNsElXrunFM7YZP8+vIj9agJEuZTg8gxHUdsIw2EgYSxhDv4nS96I632z7UMVDH3QcwYP/y4
	CPNL+JmElfRTDQ4k+w==
X-Google-Smtp-Source: AGHT+IFbaa0meB3wBm+TDHc5jyul6WCWSeakV99m+tb4BZHPtJ5c4WpsT4IWxy5+wWc8KfJM1qrkAw==
X-Received: by 2002:a5d:64a3:0:b0:38f:50bd:ad11 with SMTP id ffacd0b85a97d-38f50bdadd5mr2178759f8f.5.1739873548145;
        Tue, 18 Feb 2025 02:12:28 -0800 (PST)
Received: from fedora.. ([213.94.27.232])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259d5e92sm14749720f8f.66.2025.02.18.02.12.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 02:12:27 -0800 (PST)
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
Subject: [PATCH v4 07/14] drm/vkms: Add a validation function for VKMS configuration
Date: Tue, 18 Feb 2025 11:12:07 +0100
Message-ID: <20250218101214.5790-8-jose.exposito89@gmail.com>
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

From: Louis Chauvet <louis.chauvet@bootlin.com>

As the configuration will be used by userspace, add a validator to avoid
creating a broken DRM device.

For the moment, the function always returns true, but rules will be
added in future patches.

Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
Co-developed-by: José Expósito <jose.exposito89@gmail.com>
Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 drivers/gpu/drm/vkms/tests/vkms_config_test.c |  2 ++
 drivers/gpu/drm/vkms/vkms_config.c            |  6 ++++++
 drivers/gpu/drm/vkms/vkms_config.h            | 10 ++++++++++
 drivers/gpu/drm/vkms/vkms_output.c            |  3 +++
 4 files changed, 21 insertions(+)

diff --git a/drivers/gpu/drm/vkms/tests/vkms_config_test.c b/drivers/gpu/drm/vkms/tests/vkms_config_test.c
index 92798590051b..6e07139d261c 100644
--- a/drivers/gpu/drm/vkms/tests/vkms_config_test.c
+++ b/drivers/gpu/drm/vkms/tests/vkms_config_test.c
@@ -54,6 +54,8 @@ static void vkms_config_test_default_config(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, config->writeback, params->enable_writeback);
 	KUNIT_EXPECT_EQ(test, config->overlay, params->enable_overlay);
 
+	KUNIT_EXPECT_TRUE(test, vkms_config_is_valid(config));
+
 	vkms_config_destroy(config);
 }
 
diff --git a/drivers/gpu/drm/vkms/vkms_config.c b/drivers/gpu/drm/vkms/vkms_config.c
index 9fb08d94a351..d1947537834c 100644
--- a/drivers/gpu/drm/vkms/vkms_config.c
+++ b/drivers/gpu/drm/vkms/vkms_config.c
@@ -51,6 +51,12 @@ void vkms_config_destroy(struct vkms_config *config)
 }
 EXPORT_SYMBOL_IF_KUNIT(vkms_config_destroy);
 
+bool vkms_config_is_valid(const struct vkms_config *config)
+{
+	return true;
+}
+EXPORT_SYMBOL_IF_KUNIT(vkms_config_is_valid);
+
 static int vkms_config_show(struct seq_file *m, void *data)
 {
 	struct drm_debugfs_entry *entry = m->private;
diff --git a/drivers/gpu/drm/vkms/vkms_config.h b/drivers/gpu/drm/vkms/vkms_config.h
index fcaa909fb2e0..31c758631c37 100644
--- a/drivers/gpu/drm/vkms/vkms_config.h
+++ b/drivers/gpu/drm/vkms/vkms_config.h
@@ -67,6 +67,16 @@ vkms_config_get_device_name(struct vkms_config *config)
 	return config->dev_name;
 }
 
+/**
+ * vkms_config_is_valid() - Validate a configuration
+ * @config: Configuration to validate
+ *
+ * Returns:
+ * Whether the configuration is valid or not.
+ * For example, a configuration without primary planes is not valid.
+ */
+bool vkms_config_is_valid(const struct vkms_config *config);
+
 /**
  * vkms_config_register_debugfs() - Register a debugfs file to show the device's
  * configuration
diff --git a/drivers/gpu/drm/vkms/vkms_output.c b/drivers/gpu/drm/vkms/vkms_output.c
index 068a7f87ecec..414cc933af41 100644
--- a/drivers/gpu/drm/vkms/vkms_output.c
+++ b/drivers/gpu/drm/vkms/vkms_output.c
@@ -16,6 +16,9 @@ int vkms_output_init(struct vkms_device *vkmsdev)
 	int writeback;
 	unsigned int n;
 
+	if (!vkms_config_is_valid(vkmsdev->config))
+		return -EINVAL;
+
 	/*
 	 * Initialize used plane. One primary plane is required to perform the composition.
 	 *
-- 
2.48.1


