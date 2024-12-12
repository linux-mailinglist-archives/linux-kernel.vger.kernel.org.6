Return-Path: <linux-kernel+bounces-442420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D38A59EDC92
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 01:32:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFDF51889A26
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 00:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B53DC2C697;
	Thu, 12 Dec 2024 00:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FCm8BLgy"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 939CD2B9A2
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 00:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733963535; cv=none; b=GObWU4YcRbOHiTUcNEifrBD4EF/K0/uQ4udCW194KgCiMGlwXJn3mkYO8t+v1/1aqfX/CaTMqQSVvM9CyzIPlZHnAM0CsFKWzRJtadVlanvivKBciK6fh330xujlmpD7YP1U4GOzXrGJbp+zPp67VXym473ti90n9DfHSR6J2j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733963535; c=relaxed/simple;
	bh=y5nwWgTVBI2UXYuNENiRQFzqncmPN23qxZLRHMtG29c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XJnkizfZXg6XZnOPJxPn67RhdAkw1HFhRPGx85SDa2RHlpJaIrQvRyKOjDjQjgcQR+QmEZsxWSJj8R793zkOJZvRjRs+1/OBprZm+8QUqTIFOMjsqixhFEU8Xrk1cgQzcYe779S9YNxKEPuA2IKRaL9GBtWxnhLua5ulXsrLBog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=FCm8BLgy; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2161eb95317so320555ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 16:32:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733963533; x=1734568333; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3AVQu3QWop0H0c+IcZ6mMGnn73hEqL5BKjdosgsTiGA=;
        b=FCm8BLgyqZ79CS2uNCVdS/VBz04o89PGFfnlwXzBFac9Yb0nn6pKl4+cz+yP2qthbo
         TrVe2jYTHdVLDSH2VyerbPlA39oUCqOU35A/TkrNIOZy6/CRZTtR36vrCMqkzdFHRiSW
         Lo6JXXHTA0XlgC/kjG2a5d9O6t29PGw08nxKQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733963533; x=1734568333;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3AVQu3QWop0H0c+IcZ6mMGnn73hEqL5BKjdosgsTiGA=;
        b=Ijgz1ZI1MPvjThHYrBlvjKk0mBGf/Nm9FGVql9tR2JrDp3rlu6dO0FiQkQYk4DUEeO
         7C5NhQUnQ0tbSFoRR3/tV+3aOcy0uLgN/Fn99nns0IEgDgp1BjSusrEcCVBiBtCLLUug
         BREB2uyRK4ZnS5IynDHHIJ6epesrow927FU046lDTFi1I6ZAz6LkEkrzV0sgVqGfNQRo
         0DEdPPwy0DN/4t+i1HitF4JI3rh0HHD8aLGgvTdwgdo64hRDpt8562wqikNeiG0q2jFY
         /FO/lDOSwSXpZHWNa/djI8jyQ9mrdpqrS9/njz5vUEVaQsgqg+vunU3mdRzDnRivIbiL
         tfpg==
X-Forwarded-Encrypted: i=1; AJvYcCW681iY8YJFdM8etJzWVe/W/ZBzpA/F8aJID2OAO6a69VvIDvowCQBKk/YJVXgvp8yz6fLJ4WfWDMU6QIc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxblpcb4sh7rXhhcsBQP7pKNetoqFKoVcjBQn2lyS11sVbEvefT
	BG1UyCr9d4is7OdMuMIu9VcQM7CrDQyDiuUeM1AJaWsznooCbqcbncIHmfFMcA==
X-Gm-Gg: ASbGncvlB92DNPZwrNHbniehWckxbtwh/VO8aocgdH46fiGIHYYgBDIZwda81xzGprG
	tPsb9o+7FZXlHj1/T++pqhuYXB+aBNZ2XlfoYC1j1sA0QOgfDaKZ38qPd3OZWWNOS8PS+bYmjYb
	QvOB9o5vFvcsNM1D65Ug5ILR1cd4SNJB1tb5fsoTk+5BGcE+Vib/zh9uv9N247UCDHq/xNq/LnL
	enqbZ8VPbabe7HZOKLbmdBBMYPZnf3d1einNudpTfNIBP8EVA7t+781Bs2PBEq/4HidQyKyRuLe
	2bFIxn8ujP7tNF+sMls=
X-Google-Smtp-Source: AGHT+IEGLgadsxVUtkYmrldWfxFt3dO7ayUdfAi8DTpzJjhNb3S1+xd9gbNu33I+qMnncuaz+9QyRQ==
X-Received: by 2002:a17:902:cecc:b0:215:a3e4:d251 with SMTP id d9443c01a7336-21778395944mr84017305ad.6.1733963532911;
        Wed, 11 Dec 2024 16:32:12 -0800 (PST)
Received: from localhost ([2a00:79e0:2e14:7:b1a5:9c72:5742:89e0])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-216338fee40sm75395405ad.94.2024.12.11.16.32.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Dec 2024 16:32:12 -0800 (PST)
From: Brian Norris <briannorris@chromium.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kunit-dev@googlegroups.com,
	Maxime Ripard <mripard@kernel.org>,
	David Gow <davidgow@google.com>,
	Rae Moar <rmoar@google.com>,
	linux-kselftest@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Brian Norris <briannorris@chromium.org>
Subject: [PATCH v2 3/3] drivers: base: test: Add ...find_device_by...(... NULL) tests
Date: Wed, 11 Dec 2024 16:31:41 -0800
Message-ID: <20241212003201.2098123-4-briannorris@chromium.org>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
In-Reply-To: <20241212003201.2098123-1-briannorris@chromium.org>
References: <20241212003201.2098123-1-briannorris@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We recently updated these device_match*() (and therefore, various
*find_device_by*()) functions to return a consistent 'false' value when
trying to match a NULL handle. Add tests for this.

This provides regression-testing coverage for the sorts of bugs that
underly commit 5c8418cf4025 ("PCI/pwrctrl: Unregister platform device
only if one actually exists").

Signed-off-by: Brian Norris <briannorris@chromium.org>
---

Changes in v2:
 * Keep "devm" and "match" tests in separate suites

 drivers/base/test/platform-device-test.c | 42 +++++++++++++++++++++++-
 1 file changed, 41 insertions(+), 1 deletion(-)

diff --git a/drivers/base/test/platform-device-test.c b/drivers/base/test/platform-device-test.c
index ea05b8785743..c8d4b0a385f2 100644
--- a/drivers/base/test/platform-device-test.c
+++ b/drivers/base/test/platform-device-test.c
@@ -3,6 +3,8 @@
 #include <kunit/resource.h>
 
 #include <linux/device.h>
+#include <linux/device/bus.h>
+#include <linux/of_platform.h>
 #include <linux/platform_device.h>
 
 #define DEVICE_NAME "test"
@@ -217,7 +219,45 @@ static struct kunit_suite platform_device_devm_test_suite = {
 	.test_cases = platform_device_devm_tests,
 };
 
-kunit_test_suite(platform_device_devm_test_suite);
+static void platform_device_find_by_null_test(struct kunit *test)
+{
+	struct platform_device *pdev;
+	int ret;
+
+	pdev = platform_device_alloc(DEVICE_NAME, PLATFORM_DEVID_NONE);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, pdev);
+
+	ret = platform_device_add(pdev);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	KUNIT_EXPECT_PTR_EQ(test, of_find_device_by_node(NULL), NULL);
+
+	KUNIT_EXPECT_PTR_EQ(test, bus_find_device_by_of_node(&platform_bus_type, NULL), NULL);
+	KUNIT_EXPECT_PTR_EQ(test, bus_find_device_by_fwnode(&platform_bus_type, NULL), NULL);
+	KUNIT_EXPECT_PTR_EQ(test, bus_find_device_by_acpi_dev(&platform_bus_type, NULL), NULL);
+
+	KUNIT_EXPECT_FALSE(test, device_match_of_node(&pdev->dev, NULL));
+	KUNIT_EXPECT_FALSE(test, device_match_fwnode(&pdev->dev, NULL));
+	KUNIT_EXPECT_FALSE(test, device_match_acpi_dev(&pdev->dev, NULL));
+	KUNIT_EXPECT_FALSE(test, device_match_acpi_handle(&pdev->dev, NULL));
+
+	platform_device_unregister(pdev);
+}
+
+static struct kunit_case platform_device_match_tests[] = {
+	KUNIT_CASE(platform_device_find_by_null_test),
+	{}
+};
+
+static struct kunit_suite platform_device_match_test_suite = {
+	.name = "platform-device-match",
+	.test_cases = platform_device_match_tests,
+};
+
+kunit_test_suites(
+	&platform_device_devm_test_suite,
+	&platform_device_match_test_suite,
+);
 
 MODULE_DESCRIPTION("Test module for platform devices");
 MODULE_AUTHOR("Maxime Ripard <mripard@kernel.org>");
-- 
2.47.0.338.g60cca15819-goog


