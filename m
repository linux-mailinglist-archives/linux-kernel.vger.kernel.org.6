Return-Path: <linux-kernel+bounces-519147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C057EA39891
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 11:19:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D37F53B7649
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 10:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CAFE23958A;
	Tue, 18 Feb 2025 10:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b8ERg8ui"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5031A23644A
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 10:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739873548; cv=none; b=DqkVUaY9meifdB31pxEfmYpquniqYuFQ2G5J+R0ZiY5N55yAXyvrCEHiya9xUs/xDiY8GGtvTxDlJnsgBFgIacO+3YLUPAhOZa7LdyteV+Uzt+ptPxIWDb1E1Ov4OGNM34xV/UVOaWH0XSCnasqxyOH2sjDDwSlQZKJ5pAs12Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739873548; c=relaxed/simple;
	bh=u4vCOB9rAzLsNQV6nXfUhASxHEQbm+Ekq7VBBUVcZyM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n0QhMPEjHTuOzQ28c0IPC8FvnsL8OgmigeRgjqi53ynj6r61dvJt0DKVItGqeS62CyOEPCo8evXIKESJxgjL7zpnfn2VjDzjNvtBQEY5gRJDCmlBlrxqXrI7Ueakgt+BMaS4AIY0Z0oIhA1YLnnu5PfYmV1fInBxsIii8/aPbsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b8ERg8ui; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-38f2f783e4dso2853543f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 02:12:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739873544; x=1740478344; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XyJ4zhCFR8HQ/P+sh2alNxUJOEd+yUChQD9LZjyxME0=;
        b=b8ERg8uiSVaz94GqwBvhgrUbNUEanX6dfDx7ILtcdsxJAEZix5voQ+kaipjz14zmbe
         bj5qT2p86fhG7iJoa+87i1vob9X7KTE1tvQ2hrsTlkxh4ex/yPzUCauWjSZIen2MxU8H
         nOTvIZ/0sefzAsDyZmcwgVU+NzBEtuNhDzyTq8qq2/Y4oQpfWkOWmwWSXlUXGCyubLyk
         YG9BzqFmqPZxvNDQc8bRqABXrATI4CZLnYNGvevPB1rvcWRyN40KN8w89gb4tZEAjBHB
         vEqQ5FEqQXz8aVdPf22kirfVlrkazd6Da8CeGHyMmR97sCrpO8C0z/OMzrml55+0xNTm
         5neg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739873544; x=1740478344;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XyJ4zhCFR8HQ/P+sh2alNxUJOEd+yUChQD9LZjyxME0=;
        b=gVJyi2VikVyWX+8UpNDATXZhajCtGsUqB0Xc7fn0Lg+f+W9GM6QkwUruNk8BWu/mRl
         kSSu8t2i9EwMQC75yFRmm6FfPIWgi1517E511jJdGZdoX0VAbuspdOmC8OABa6Blcpvh
         VpvgyMgWWX73RcecpTtSpUhDPvi5ixW/Pu6mLhMzfeAVVjZO1Da3MSm5aZDmy4iikD2x
         BPiTpxtMqf0HrYhICV5p1FWXXkz4SPB9T82qZe50iUTJb1DMT8ZPg/JeZU/mg3jj5jWf
         Os+racpzr7+s2ZP0qRjhiMr2pv1zpjJjreb1WHlCXAMw7Qei4w7ApqTlK7YJNr403EvW
         /PBQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7v5oO03UPaJx5j370ApPw7x5/VyQDGLuFfHVFfGdhAHx5/JOnw8XV3UScggTa9X7KsdRFavtDdUAkN8A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpAzAgXzmu5TPNGKI8a6G/S0I0lOmjpsx7wzdAiyRadv9NeBWV
	sM3iLqFwtgqbyZcMrXQFYWhZwiATbAkNlHFbzZpjkqLnjOFZenNF
X-Gm-Gg: ASbGnctLEbbrILcaElXyX/pGWLO6L+BC2SvOg/q2HzuqXEY//jeuMd8WHhkhw/Jos6e
	hwF7TcZL9NY7PmkkLjmDNrhq/XoFuixlX5cQEUl6bI+Rxps2LbgPkl0DiTuI3xo8UWkECIscTtC
	dYNWsZbbPFF3rtCOLT6uo2J5uRW37587ds+M7ZQNr9o9X28mQPfAK9L7KlH5P/ng1cVKsE5GHaG
	d/GcN6pqLK7GYYuO2MOis31x8uV/SdLLd+JYmMq4hE6eYLFNyWpzyDyB2dqWTH4FyH84pxhdovJ
	ZK/9KI3+8GlA+7Z0fw==
X-Google-Smtp-Source: AGHT+IFC2iZ3b86dmZHVNKNjYIDDceABsmu1t7eFO+6DJG0rTP5rcTEl6DAhwD/VfnPs4aPOLeh59g==
X-Received: by 2002:a05:6000:1864:b0:38f:3888:33bc with SMTP id ffacd0b85a97d-38f388836bamr11398807f8f.10.1739873544100;
        Tue, 18 Feb 2025 02:12:24 -0800 (PST)
Received: from fedora.. ([213.94.27.232])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259d5e92sm14749720f8f.66.2025.02.18.02.12.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 02:12:23 -0800 (PST)
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
	=?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>,
	Arthur Grillo <arthurgrillo@riseup.net>
Subject: [PATCH v4 03/14] drm/vkms: Add KUnit test scaffolding
Date: Tue, 18 Feb 2025 11:12:03 +0100
Message-ID: <20250218101214.5790-4-jose.exposito89@gmail.com>
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

Add the required boilerplate to start creating KUnit test.

To run the tests:

    $ ./tools/testing/kunit/kunit.py run \
      --kunitconfig=drivers/gpu/drm/vkms/tests

Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
Co-developed-by: Arthur Grillo <arthurgrillo@riseup.net>
Signed-off-by: Arthur Grillo <arthurgrillo@riseup.net>
Co-developed-by: Louis Chauvet <louis.chauvet@bootlin.com>
Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 drivers/gpu/drm/vkms/Kconfig                  | 15 +++++++++++++++
 drivers/gpu/drm/vkms/Makefile                 |  1 +
 drivers/gpu/drm/vkms/tests/.kunitconfig       |  4 ++++
 drivers/gpu/drm/vkms/tests/Makefile           |  3 +++
 drivers/gpu/drm/vkms/tests/vkms_config_test.c | 19 +++++++++++++++++++
 5 files changed, 42 insertions(+)
 create mode 100644 drivers/gpu/drm/vkms/tests/.kunitconfig
 create mode 100644 drivers/gpu/drm/vkms/tests/Makefile
 create mode 100644 drivers/gpu/drm/vkms/tests/vkms_config_test.c

diff --git a/drivers/gpu/drm/vkms/Kconfig b/drivers/gpu/drm/vkms/Kconfig
index 9def079f685b..3c02f928ffe6 100644
--- a/drivers/gpu/drm/vkms/Kconfig
+++ b/drivers/gpu/drm/vkms/Kconfig
@@ -14,3 +14,18 @@ config DRM_VKMS
 	  a VKMS.
 
 	  If M is selected the module will be called vkms.
+
+config DRM_VKMS_KUNIT_TEST
+	tristate "KUnit tests for VKMS" if !KUNIT_ALL_TESTS
+	depends on DRM_VKMS && KUNIT
+	default KUNIT_ALL_TESTS
+	help
+	  This builds unit tests for VKMS. This option is not useful for
+	  distributions or general kernels, but only for kernel
+	  developers working on VKMS.
+
+	  For more information on KUnit and unit tests in general,
+	  please refer to the KUnit documentation in
+	  Documentation/dev-tools/kunit/.
+
+	  If in doubt, say "N".
diff --git a/drivers/gpu/drm/vkms/Makefile b/drivers/gpu/drm/vkms/Makefile
index 6b0615c424f2..c23eee2f3df4 100644
--- a/drivers/gpu/drm/vkms/Makefile
+++ b/drivers/gpu/drm/vkms/Makefile
@@ -10,3 +10,4 @@ vkms-y := \
 	vkms_connector.o
 
 obj-$(CONFIG_DRM_VKMS) += vkms.o
+obj-$(CONFIG_DRM_VKMS_KUNIT_TEST) += tests/
diff --git a/drivers/gpu/drm/vkms/tests/.kunitconfig b/drivers/gpu/drm/vkms/tests/.kunitconfig
new file mode 100644
index 000000000000..6a2d87068edc
--- /dev/null
+++ b/drivers/gpu/drm/vkms/tests/.kunitconfig
@@ -0,0 +1,4 @@
+CONFIG_KUNIT=y
+CONFIG_DRM=y
+CONFIG_DRM_VKMS=y
+CONFIG_DRM_VKMS_KUNIT_TEST=y
diff --git a/drivers/gpu/drm/vkms/tests/Makefile b/drivers/gpu/drm/vkms/tests/Makefile
new file mode 100644
index 000000000000..9ded37b67a46
--- /dev/null
+++ b/drivers/gpu/drm/vkms/tests/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+obj-$(CONFIG_DRM_VKMS_KUNIT_TEST) += vkms_config_test.o
diff --git a/drivers/gpu/drm/vkms/tests/vkms_config_test.c b/drivers/gpu/drm/vkms/tests/vkms_config_test.c
new file mode 100644
index 000000000000..1177e62e19cb
--- /dev/null
+++ b/drivers/gpu/drm/vkms/tests/vkms_config_test.c
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+#include <kunit/test.h>
+
+MODULE_IMPORT_NS("EXPORTED_FOR_KUNIT_TESTING");
+
+static struct kunit_case vkms_config_test_cases[] = {
+	{}
+};
+
+static struct kunit_suite vkms_config_test_suite = {
+	.name = "vkms-config",
+	.test_cases = vkms_config_test_cases,
+};
+
+kunit_test_suite(vkms_config_test_suite);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Kunit test for vkms config utility");
-- 
2.48.1


