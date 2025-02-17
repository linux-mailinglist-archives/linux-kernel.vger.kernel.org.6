Return-Path: <linux-kernel+bounces-517315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F931A37F40
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 11:03:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4878A3A801B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 10:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC898217663;
	Mon, 17 Feb 2025 10:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FC9dPITG"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88AE321661C
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 10:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739786491; cv=none; b=LiBXy9dD8pas1MctUYpFJNts8GaTEGhjT3NpGEzVASXjZrzvkEh3YTghMaPlRWG2D7CFG4Q8Lf+Swdl1h9rnrhucmGKP6gLn8xSQ+tpwdiR2XcXIbRGt0GO4qgWHEDhZRtp+K7Mhexb9zDbur5thPg/ckdn7WfG4sNYbc1alSJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739786491; c=relaxed/simple;
	bh=u4vCOB9rAzLsNQV6nXfUhASxHEQbm+Ekq7VBBUVcZyM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XQHTSZCxtzzTgiMcDcXrV1MXQtHcD5UuVjD+KwncdxJs0PE6cvxqwWfMtB866NZVkI6RL1M4EKy12r0bxYdJhPso6hvS6+F8bi7k4RacWsbSA21zuZPY9/QA6lQEiVRbMhA9jcLKvCeiTWm94BX0Nr2yd9MaeO4pG629MHVWjGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FC9dPITG; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-38a8b17d7a7so2332120f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 02:01:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739786488; x=1740391288; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XyJ4zhCFR8HQ/P+sh2alNxUJOEd+yUChQD9LZjyxME0=;
        b=FC9dPITG0iaMNi/X+dKWmfqer70rZoheT5iwBerT/FIvDIiVnWaUqj1IH1Mz3eu38r
         KFTsH3ZsmCfLKkStJOvA4SXDnVjCxIXnfsOc5vjiCrnClaTtU/XQ3VXywLGN9TqbYpA6
         Ja9FrPAy72fmIxK832DdcRcn+2ECnA9r2pgbg1GUc4JLuXEvnLDbjxgqYHFL7VBhB/mg
         Dh2RRs3HEkgfC1CtWgUKDQuVDFRDL6+mjdW6lomBpSwh1F3qhNdHsoEmxfOKM+lB5RUd
         fhUm7kUa7uo4F+ut06O85MoxBlePq31fS3glWE3DSRxkzeG/S0rpH6ytPLz2Tmah4cfF
         nx5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739786488; x=1740391288;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XyJ4zhCFR8HQ/P+sh2alNxUJOEd+yUChQD9LZjyxME0=;
        b=AQha3fClHJOwtWEXGyjRo194cQTDIBBJUm1iQCVD9+yqzA3XhMLVbPBDnuCyE7Fuqr
         iS9NUALMIBQirdQYelXcD645UKJ5SdfkqaWq9dzHq0z2rUJLscUJfyKZQkVRQ3ZtFlBF
         F7/bySTKQMnBxjy8krzAvMLKAVp2rHyDTd7OzM5ZwhKcPyf51gHZXmx9i0dNtObq6qUh
         tf8QK7f3xJP3zhgEcAlTqB9DrTNwubXjLQbmRVIEEFab9p4fYtrROUCWv3a50k/NvEtw
         Z6QPI4wzou1yEb5GoEgTl5hJTUHc3rGCeEGoDmWvcTKbKsjGpYP1ZyB+gfC33SHUD/Mf
         mLMA==
X-Forwarded-Encrypted: i=1; AJvYcCWB/Pq1rjvC2ucahsJ7n9DO4he+V1TeCwSnn5t6YOntTH6Ffb3DGmSsPomijmhnOVItE6NAnM2UG3giSs4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRC5+YjNPoeqOb8nSdpmJ9m9ggmq/RHdDRx8rRQs6L/EvxCewh
	1j54olJ34y1NAKg4SbsTQh1sx9nYIyi0OJmG8UpkS55idjOKBEdj1Yb1c5uB
X-Gm-Gg: ASbGncvxTxWwn+s7a5dfNdWVNMaZ07cZ/1BY7fXDyoM4NOH1zpOaxrCAFRqA03lhHyj
	ur1D1nsCt5l45CLnA/9oqF4pVXGVepoPNgz921fqcxw0kwlwAhrHlFvY4u7mhak4vOW8EzbnSPC
	AQnRWCzDKgx2jSVhskVXledZUrTC45JVyYaQgOIrJFclkQklHpMX57iFOsn0aiBYZhpnV6fZhoG
	E9zFT5KnE1kygwONCy9omjFaS1qIkb5bKpHhSrsy9ANo9ifm62vW8GS2Zkey0Mp/Lu9f0CZe+Xd
	Y/y3ogL4c7RnQsJvWw==
X-Google-Smtp-Source: AGHT+IEgChZS1TM0yOWscdOUtGj2+t/pNHUL4Ncpoj0PJEzTn8rZEI3vhQLyexaVQtcmkHYF3tLn/w==
X-Received: by 2002:a05:6000:18a9:b0:38f:2193:f8c2 with SMTP id ffacd0b85a97d-38f33f34e32mr8698968f8f.31.1739786487650;
        Mon, 17 Feb 2025 02:01:27 -0800 (PST)
Received: from fedora.. ([213.94.27.232])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259f7fe6sm11591901f8f.86.2025.02.17.02.01.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 02:01:26 -0800 (PST)
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
Subject: [PATCH v3 03/14] drm/vkms: Add KUnit test scaffolding
Date: Mon, 17 Feb 2025 11:01:09 +0100
Message-ID: <20250217100120.7620-4-jose.exposito89@gmail.com>
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


