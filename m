Return-Path: <linux-kernel+bounces-563820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E09AA64926
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 11:15:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48DCD170CA1
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 10:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01A42238147;
	Mon, 17 Mar 2025 10:14:02 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09FC62376E6;
	Mon, 17 Mar 2025 10:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742206441; cv=none; b=Je87YVQaAHcsKJPykVROSmrUsLfBGkrpel+dlc02FOJo7lnUTPLjCqYeWdHHE4Cql98BF8wusN709bouAcE3Z71nlJjt4cOylfFt5FpQePSnsZjg3v6N0ahFwa9PhEtj7BV4hx13z2XLhPAk6943Vcua0U3uvKsq4jTs+gUTORw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742206441; c=relaxed/simple;
	bh=x7ZXz4mU9CnfHVM3Z0rwNB7yQx/AvIfPWEc4rRfZlD4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eSj3zy+pAug3PPM2RgmfR+l0HiZ4ftE7OI6ZzfGdIPKtvSnQQV2JhtVdNY6shZr3iCXdgQ7vMWiDM0b86V9P77hsLbn4KYisx007G90R4ur6eL7d1Qnr6jtzxHIlldCJPW/MEgfE4h85Q8ucRhzXzloMh5v3fZAinw4zf87wUOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ADDE325DC;
	Mon, 17 Mar 2025 03:14:08 -0700 (PDT)
Received: from e133711.arm.com (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BA95A3F673;
	Mon, 17 Mar 2025 03:13:58 -0700 (PDT)
From: Sudeep Holla <sudeep.holla@arm.com>
Date: Mon, 17 Mar 2025 10:13:18 +0000
Subject: [PATCH 6/9] ASoC: soc-utils: Transition to the faux device
 interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250317-plat2faux_dev-v1-6-5fe67c085ad5@arm.com>
References: <20250317-plat2faux_dev-v1-0-5fe67c085ad5@arm.com>
In-Reply-To: <20250317-plat2faux_dev-v1-0-5fe67c085ad5@arm.com>
To: linux-kernel@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@arm.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>, 
 linux-sound@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2889; i=sudeep.holla@arm.com;
 h=from:subject:message-id; bh=x7ZXz4mU9CnfHVM3Z0rwNB7yQx/AvIfPWEc4rRfZlD4=;
 b=owEBbQKS/ZANAwAIAQBBurwxfuKYAcsmYgBn1/XbmOULwGG3cHOXBy6u8uWE/0CxGGLIC0/+t
 aN37NJqvBeJAjMEAAEIAB0WIQS6ceUSBvMeskPdk+EAQbq8MX7imAUCZ9f12wAKCRAAQbq8MX7i
 mFuFD/9kHeBWU8kPBSge1BvTUCZIXjgpxVnY7k1Zh+ekqiPVFbfa81bN0OyWbSDu/g/PFRDpNzp
 zWED2iQIlyFANDMYLWij1/l1G+/6tsbL7zDM6fWNP6H5WSTr2VGCXfsCd0D3P3/IttypSKlFdGd
 s9lqG1VyfE73bAyY5ZHXKRotN/LCM0aFbjEx73+FqVv+38qNJy7k7mlcOwpGS7WD41k2cVdXyIt
 7lTETqX1kXnllOce9FSzIc1wRlVuYHzGSr1XIHvz3UmQwA9rp+3tg2FI0CJHMOiWJRIUpJy8cuT
 Pm7n2FPUEJ+iUtfRpNhCIT4LpkxDKwr8+vTV3Jw5fgNh5AAd6Ev/s+eX9jwl7t3X5C5EYcUX9cz
 XJyiI3hmRqnqHjX0KbS52OsEsnR/mRkF0ynMNpSojBvLRkik9vItSJGjTdByLiBex8bks//hgPy
 lH1vZUomA+ToZdQTwgb5nv4aWgI1+qWUR3x9hQIO9GnXjAuj4iw1uplJXBCNMn/HVTwb4EMQSSj
 K6gIuOpc7m7hvrnfrNrEqKJLnfQWU+7xuufhjKJ3SfegdIZeVk/eLhbU9Q+S2Nj1QMqWgR464ES
 mFEJZkzxKyfjZJjOKnXU38L7RahpcfGkYVkTsqQS7ABr9R4j+Zh9jnccK2CaxYMrwLr1VuB93wg
 2dbwUo65FNOwI4g==
X-Developer-Key: i=sudeep.holla@arm.com; a=openpgp;
 fpr=7360A21742ADF5A11767C1C139CFD4755FE2D5B4

The ASoC soc-utils driver does not require the creation of a platform
device. Originally, this approach was chosen for simplicity when the
driver was first implemented.

With the introduction of the lightweight faux device interface, we now
have a more appropriate alternative. Migrate the driver to utilize the
faux bus, given that the platform device it previously created was not
a real one anyway. This will simplify the code, reducing its footprint
while maintaining functionality.

Cc: Mark Brown <broonie@kernel.org>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: linux-sound@vger.kernel.org
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 sound/soc/soc-utils.c | 34 ++++++++++++----------------------
 1 file changed, 12 insertions(+), 22 deletions(-)

diff --git a/sound/soc/soc-utils.c b/sound/soc/soc-utils.c
index aa93e77ac937b0255c5dfa519207693fb560a6d6..a795c21756f79411cf59e209133db9f88edeb44c 100644
--- a/sound/soc/soc-utils.c
+++ b/sound/soc/soc-utils.c
@@ -7,7 +7,7 @@
 // Author: Mark Brown <broonie@opensource.wolfsonmicro.com>
 //         Liam Girdwood <lrg@slimlogic.co.uk>
 
-#include <linux/platform_device.h>
+#include <linux/device/faux.h>
 #include <linux/export.h>
 #include <linux/math.h>
 #include <sound/core.h>
@@ -235,48 +235,38 @@ struct snd_soc_dai_link_component snd_soc_dummy_dlc = {
 };
 EXPORT_SYMBOL_GPL(snd_soc_dummy_dlc);
 
-static int snd_soc_dummy_probe(struct platform_device *pdev)
+static int snd_soc_dummy_probe(struct faux_device *fdev)
 {
 	int ret;
 
-	ret = devm_snd_soc_register_component(&pdev->dev,
+	ret = devm_snd_soc_register_component(&fdev->dev,
 					      &dummy_codec, &dummy_dai, 1);
 	if (ret < 0)
 		return ret;
 
-	ret = devm_snd_soc_register_component(&pdev->dev, &dummy_platform,
+	ret = devm_snd_soc_register_component(&fdev->dev, &dummy_platform,
 					      NULL, 0);
 
 	return ret;
 }
 
-static struct platform_driver soc_dummy_driver = {
-	.driver = {
-		.name = "snd-soc-dummy",
-	},
+static struct faux_device_ops soc_dummy_ops = {
 	.probe = snd_soc_dummy_probe,
 };
 
-static struct platform_device *soc_dummy_dev;
+static struct faux_device *soc_dummy_dev;
 
 int __init snd_soc_util_init(void)
 {
-	int ret;
-
-	soc_dummy_dev =
-		platform_device_register_simple("snd-soc-dummy", -1, NULL, 0);
-	if (IS_ERR(soc_dummy_dev))
-		return PTR_ERR(soc_dummy_dev);
+	soc_dummy_dev = faux_device_create("snd-soc-dummy", NULL,
+					   &soc_dummy_ops);
+	if (!soc_dummy_dev)
+		return -ENODEV;
 
-	ret = platform_driver_register(&soc_dummy_driver);
-	if (ret != 0)
-		platform_device_unregister(soc_dummy_dev);
-
-	return ret;
+	return 0;
 }
 
 void snd_soc_util_exit(void)
 {
-	platform_driver_unregister(&soc_dummy_driver);
-	platform_device_unregister(soc_dummy_dev);
+	faux_device_destroy(soc_dummy_dev);
 }

-- 
2.34.1


