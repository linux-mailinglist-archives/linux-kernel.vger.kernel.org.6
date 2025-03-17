Return-Path: <linux-kernel+bounces-563823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F859A6492C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 11:15:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C83FF17327B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 10:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5F11239589;
	Mon, 17 Mar 2025 10:14:05 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C66AC2376E1
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 10:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742206445; cv=none; b=beHNIUxSKnCFbXOHMXNsCHl1WNzO3ujNcT7uR4aMYQYMWxo7i2QGPtm171YCX5Sc4BnHNvtKP8lr3yFB3F+JYA1xKv1IJUK3u7Tx1QIw5+uuqstEbS/ESEcJxmn5Rl+/1BMx/N8pLvFGEDgVH+bgT3VB0jbuuYf6OY3XMB6TcBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742206445; c=relaxed/simple;
	bh=xV5MMTtJh2o/E03BwDcI4WhIzb9LIMQcGRUOsL8ojRg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=c8OVHl3QYmhaQXm6WqtTWVDtLvzWbutbkBpcyL9DBsnW+q5+hkXx49TnHFtsof3xQQEjiSkAwJioiusCSQsfv9ajQsa/GAT8gn1ud9eRmMPFW6QHzq2Cj0x80cO+72oKMvXAnlS8jFK9l9vJUXnpf8/fyquHnm0tvLM7GRaqZmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8191913D5;
	Mon, 17 Mar 2025 03:14:12 -0700 (PDT)
Received: from e133711.arm.com (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B20E13F673;
	Mon, 17 Mar 2025 03:14:02 -0700 (PDT)
From: Sudeep Holla <sudeep.holla@arm.com>
Date: Mon, 17 Mar 2025 10:13:21 +0000
Subject: [PATCH 9/9] regulator: dummy: convert to use the faux device
 interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250317-plat2faux_dev-v1-9-5fe67c085ad5@arm.com>
References: <20250317-plat2faux_dev-v1-0-5fe67c085ad5@arm.com>
In-Reply-To: <20250317-plat2faux_dev-v1-0-5fe67c085ad5@arm.com>
To: linux-kernel@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@arm.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Mark Brown <broonie@kernel.org>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3008; i=sudeep.holla@arm.com;
 h=from:subject:message-id; bh=99Apj0NBoQeeN4bVc+HR7nRC+LgtFnkO/+yRk88Cfq4=;
 b=owEBbQKS/ZANAwAIAQBBurwxfuKYAcsmYgBn1/Xbul7UMAeus237x3bLZHa7lEFN1fNczVeGs
 Ot5xC6C34OJAjMEAAEIAB0WIQS6ceUSBvMeskPdk+EAQbq8MX7imAUCZ9f12wAKCRAAQbq8MX7i
 mFgRD/4tSvHl+/pfVasVtz+76+ymy2wgGTFqzFdW9gxjXKXVvnK86HZ2cWErXjlvIALKguOA2Pj
 eEv7HJA6CKTHBWenqOCOQ8GfVej5vybeZC23RVzFhy3AQMkkkfxTnB4ISMKBzvX9F2aujy+aj5z
 kJS4MpymHjMiLLtArIq/LOgr3AxhEdpr2OEq3G/ucXwS0kMFeKd2dKr/4TkGa58ukCseIxqg7+Y
 u/nuPE24Pv9mGKwQBjZTcZCEjKY2RYkAetW9J0VUKYeWgZmAkQYV1BCZf1ax05NC1LY3BT1GyN7
 P+0qu8NTzro8JMIp6DKGZPYwrL7TwiSI33HoWChFqssJ2ufrNt7w57PcayG7304TWdZUlKFMJjQ
 HmDjrzS4no3eraa+VyE/havbcgvGdyvHye+xVy33wLIRLpcRGx3WP4YQy7iPUkBmYh8y4/e7SL3
 U3VDtMjNW/E4+W2z2PrLAynsdbcsy/LnKB4XTRl5P5/OcYI5hL6F9uCJfqv/yiyjjQAu8w1EuLl
 rGh3xDlXZbg5SOMgpa0STxaJwJuKkJFjRTM104WgH8CXKYnVoDGmV3IpqsMY5fDUxMPDtF/cOMr
 GnckETGzeiAhKhUpmHvLyDZvmBNxWVhqo6jdGUXNwh5+uUxNJrgo6TA3mvS4xJUmU3u5H86jzM0
 oI8YpHuKyW9igUg==
X-Developer-Key: i=sudeep.holla@arm.com; a=openpgp;
 fpr=7360A21742ADF5A11767C1C139CFD4755FE2D5B4

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

The dummy regulator driver does not need to create a platform device, it
only did so because it was simple to do.  Change it over to use the
faux bus instead as this is NOT a real platform device, and it makes
the code even smaller than before.

Reviewed-by: Mark Brown <broonie@kernel.org>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Message-Id: <2025021027-outclass-stress-59dd@gregkh>
(sudeep.holla: Made dummy_regulator_driver static)
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/regulator/dummy.c | 37 +++++++++----------------------------
 1 file changed, 9 insertions(+), 28 deletions(-)

diff --git a/drivers/regulator/dummy.c b/drivers/regulator/dummy.c
index 5b9b9e4e762d52151847bb1880377d51b04eeb9d..c3e416fd3c3e29d54278eb65600ab79d828edbde 100644
--- a/drivers/regulator/dummy.c
+++ b/drivers/regulator/dummy.c
@@ -13,7 +13,7 @@
 
 #include <linux/err.h>
 #include <linux/export.h>
-#include <linux/platform_device.h>
+#include <linux/device/faux.h>
 #include <linux/regulator/driver.h>
 #include <linux/regulator/machine.h>
 
@@ -37,15 +37,15 @@ static const struct regulator_desc dummy_desc = {
 	.ops = &dummy_ops,
 };
 
-static int dummy_regulator_probe(struct platform_device *pdev)
+static int dummy_regulator_probe(struct faux_device *fdev)
 {
 	struct regulator_config config = { };
 	int ret;
 
-	config.dev = &pdev->dev;
+	config.dev = &fdev->dev;
 	config.init_data = &dummy_initdata;
 
-	dummy_regulator_rdev = devm_regulator_register(&pdev->dev, &dummy_desc,
+	dummy_regulator_rdev = devm_regulator_register(&fdev->dev, &dummy_desc,
 						       &config);
 	if (IS_ERR(dummy_regulator_rdev)) {
 		ret = PTR_ERR(dummy_regulator_rdev);
@@ -56,36 +56,17 @@ static int dummy_regulator_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static struct platform_driver dummy_regulator_driver = {
-	.probe		= dummy_regulator_probe,
-	.driver		= {
-		.name		= "reg-dummy",
-		.probe_type	= PROBE_PREFER_ASYNCHRONOUS,
-	},
+static struct faux_device_ops dummy_regulator_driver = {
+	.probe = dummy_regulator_probe,
 };
 
-static struct platform_device *dummy_pdev;
+static struct faux_device *dummy_fdev;
 
 void __init regulator_dummy_init(void)
 {
-	int ret;
-
-	dummy_pdev = platform_device_alloc("reg-dummy", -1);
-	if (!dummy_pdev) {
+	dummy_fdev = faux_device_create("reg-dummy", NULL, &dummy_regulator_driver);
+	if (!dummy_fdev) {
 		pr_err("Failed to allocate dummy regulator device\n");
 		return;
 	}
-
-	ret = platform_device_add(dummy_pdev);
-	if (ret != 0) {
-		pr_err("Failed to register dummy regulator device: %d\n", ret);
-		platform_device_put(dummy_pdev);
-		return;
-	}
-
-	ret = platform_driver_register(&dummy_regulator_driver);
-	if (ret != 0) {
-		pr_err("Failed to register dummy regulator driver: %d\n", ret);
-		platform_device_unregister(dummy_pdev);
-	}
 }

-- 
2.34.1


