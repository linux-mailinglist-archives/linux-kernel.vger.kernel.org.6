Return-Path: <linux-kernel+bounces-517319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7778DA37F56
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 11:07:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E50EE1898532
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 10:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9FFB21661B;
	Mon, 17 Feb 2025 10:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SjkUAOuj"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F4F9217737
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 10:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739786497; cv=none; b=LsUWs1r6UG+wl9nT0LiW9EmbLqCslYYaQXSuSDVFs/9OFpqcSP72M51pnUVCrrpXc9NpieYkfCENQIOgN4KvvS+cKFUDOaTyafrVppwpI0ImC4eQ3EbDUBhzsCVGtHsOVN83h3uHowylh69boCeVykjJ93m4cVeiRJtIbjEZhUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739786497; c=relaxed/simple;
	bh=ezbRlCRRih7ztNQfSrHs4WhtoVlP3GIc2Vb1QT7R4sI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tqoOvw2x6YDbFSVUUMFUNSfgcNMll/eYyBK855g/OQI1itltMt9pYPuy4d712zEQlWP/naOxODZ+eECVboReQHa/5Vk9KGWVXRluXhMUyoVSfrxcldmxfLLZeyw11tAs29wXjBqEARUtURLnWQej+8LsISESR3vO2FtUdQbJEvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SjkUAOuj; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-38f22fe889aso3169867f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 02:01:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739786493; x=1740391293; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vG84qkV7BJECjcnd+fwOr4EF0zkS6sxDafqd+tmcLZs=;
        b=SjkUAOujxUI4HR6wuPWVHuNgfRzxlU0j6/vgweAGFuiy19w4PVsXwaRcN8cwanvjur
         OuNmnjoigvSeI0vAcMSXZ92658lBvgqEgr2MTk/IZ91HJruR+T3grDJLOrV9eqq9c0LD
         +wwL6DDV2NQyImDAQBlCIL24ncFONJeF3quSbuVhiV7voptGAb0jk9fFJ0PcdgxPEJDl
         TDzkqf2yiuH0LI+y2JJUBqfODFi6rwRj1AHBpzX2iLh9c+tD5j7nnrQoUVee9B4Qf2dO
         WN+Zw2FQa8+U5/12IxZabkw63EHFpDsX867rS+FaRbjBaqsqywSle54pm+nJAvAmRX3X
         cKHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739786493; x=1740391293;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vG84qkV7BJECjcnd+fwOr4EF0zkS6sxDafqd+tmcLZs=;
        b=UUzkkwR2lbbbbqz5lwwQJJUMazWsNSTNKDrPuSPBWL95LxQyFDz57jPlzNFyywZLWt
         JPb0OVjETGcxzlvpe8MrGigeWh1k3WqN1m6mXgPcCvBQ+4By51OpUub2xPpKjYk3u38Z
         t6aOFGA0V7P7ymZ9wNyJbF3OUJnPky6leHKYSfF9nltAs84aQsoxmOkwfgzukfw/WEhH
         uSIRE27F17sOU7+Rqxv68mYclKf/s13lmaWEXsj/C8q0Al311osgazwGAjmtINlhwprN
         I3AEv5O6va0QBNIB2F0UzPetmuYyIJnKpE0s73wh9t7WeRlwclblTouMUZ0DP/DWy/2j
         9iLQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/WMLtaTvGWKMX/4aa70tLJMvyAf6P8vRrVljmke2JG0lzm1QjwDfdF2ZC0BoY+Rc8BqOWt6FLn1oXKuU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJr70r+X+UbJnEMaK/roUicdRn4Lt54b8GZJE2G3AoGkYl/nHj
	G1mzANIOCFsbtHMphA4yVc6Xkx02X0X6SyFY1rj81RGdK1X8qXTu
X-Gm-Gg: ASbGncvdEZu8AmpkUJubwVhvSCw+DA1wEF4YLeEQHU6lmu1xOlfPvRfqr9KTOT9sgU3
	6cmMe9ftyGiImqMOvI7/uLBFeTr070xG/7RMn9C2+ti7LRds0l+mIIOtB9waDxMALtJwr5Ys20a
	cR8PhPJfB1caltQqezU7yBpEmu7cPEwVt6cVmq/Rd3SgMQZGUcWBi2L+Gjj1Ia80ghwPfL2nUlS
	AMgEwmJU0QnHFnZ15VFdSbNT2QxVsmeDbzcMS4IA6Jqdukq1A+dSaVwl6YINfpABwzd4l0y0oWv
	bkyhxxtisqlPNg+v2Q==
X-Google-Smtp-Source: AGHT+IFGNiAYm97F/rvajIu8CyZRnvNveqnN8T22WAtQI5gMJGrMZ9dUcF45LtAZOYQGxLfI+woL/w==
X-Received: by 2002:a05:6000:1f87:b0:38d:d8fb:e91a with SMTP id ffacd0b85a97d-38f33f35862mr8662918f8f.27.1739786492575;
        Mon, 17 Feb 2025 02:01:32 -0800 (PST)
Received: from fedora.. ([213.94.27.232])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259f7fe6sm11591901f8f.86.2025.02.17.02.01.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 02:01:31 -0800 (PST)
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
Subject: [PATCH v3 07/14] drm/vkms: Add a validation function for VKMS configuration
Date: Mon, 17 Feb 2025 11:01:13 +0100
Message-ID: <20250217100120.7620-8-jose.exposito89@gmail.com>
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


