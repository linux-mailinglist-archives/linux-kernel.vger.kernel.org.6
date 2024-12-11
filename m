Return-Path: <linux-kernel+bounces-441626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B128F9ED0DB
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 17:08:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4708C18823C2
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 16:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E6701D9320;
	Wed, 11 Dec 2024 16:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lL97qsk1"
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23EB31DDC0C
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 16:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733933248; cv=none; b=Ssl5zjfoj4+eFs1wV6sDetOIYqsqXYvfvfSi60ZGeCqq7veDT83RnQ8dqMsB1gfbOgG1qIblr1YTKb86Dl7TmewGd1M3oRxdYBhDeJSkVXhp3G59YyoRgnpanUaOfBm1Le0e9IF6TRoCf0UPjGi3axjUgaVVUgKfyjdl+1dVdMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733933248; c=relaxed/simple;
	bh=Rthe3LzHY0QJPosKabOqFJY90O39hBmNGtzh12F+k2M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XA27ZJTtLEPPc+3sAhgSuCein0eLRaENspPBGgNDadjFFaUx3RJToqAnMLit5yjLR/ZRULnsgvEx4On/9CrhZHVfXJCN9WDUeBVwayWSafd+ZD8ODx1nV/GZyTAGDHfcmtNZ5qFwenDyDaSD/lcywQ3OyoZTkHkdgl9rP3cS5YY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=lL97qsk1; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6d8f916b40bso59096906d6.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 08:07:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733933245; x=1734538045; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Essqe2WEjNsh1+1eTJTpKRXpLjov7BKteAS8plE/7UE=;
        b=lL97qsk1wI9Y7/MtqAZcUwUeRNSY/gsIPCf1JH1M2Bb8Rh1KttDMR4rp6aTx+MAoCl
         d9PxQfqX/GZeUaYQXENGtFbyD85QkwrgnY/SqKLtt3lMojMEB8NWZ34MbXSsnCV6mi8U
         GCTdDdJYK+0I7z/5KD/1PCXOcnW76grJYhXPg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733933245; x=1734538045;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Essqe2WEjNsh1+1eTJTpKRXpLjov7BKteAS8plE/7UE=;
        b=R4c4qA7yUQJ0iFVpcFErtpt32PjDr2VbUhL0qobZtXhjo9rb7JH28d5pK653WvquSy
         njbTo07ox3ggJElU69cDgY+PpiDiNZ2RmlFt1RtevBAsctKeHIpHwZC4FgdPdoCZVsqA
         xH4054ZaVeaV8AUGGPbTE2zyBqA3KQM8Bgga7B6j7i7RbK86ZqorNdlGfX9k9OTVJqYL
         E4hG6wgtUFGQ4iTa3IpEg1VUv99D/XxLskAgCABIXa1Yr3+YSHC39eOezqnxzvGygbTJ
         CnnP/LU8ggGbEI5Fllgg7SgixhNBIcL0yXu6ROt23XTtFpzHGSUGJLqMQ66YedXiazjg
         v+Gw==
X-Forwarded-Encrypted: i=1; AJvYcCUTJVfFAkqVMVl50OGspXq3Vb0gg/exPjp9Qaxv/w9JUTcXDYMgEPpqRPJ2H3GEF9Bb8ZcXyfBn/hDE9GY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQrMbYtSy4fvy4Tu35y6DEoW3ssesSf+YfK5hJZVhc+eSPZ9Aj
	634aCZf2Ubu/tAayWCOGGY8gX+VDoTJWYUJm4iEyKPhmeF5BA8856SJLxXRAKRJh1iOkPD8xXio
	=
X-Gm-Gg: ASbGnctQp6LsljGH6ar2YDma4DrubZSRmmReqIGTPEqbTPnD68D2u8fbnZyy5VkJvJI
	nPOFfBkTT53pFkggfB1dbdbC3hdT62VQoh+gHHpQMfbqpIUDSlMOJgdhEkRbTKPB+AwOH64fBk+
	hXRtvM55oYv9mJCDH+64dv7nNCCSP2ky7edNalUcthI2N9GS/RqkeQTc84fFIMMJUOTmlhP/a83
	puBlEg60lijBjmQyPLnwqEwYgpo1F2J+VAwRosHkcGU5e2nfnnxGFgiNVJeXshqz4XTv1g6sui1
	sBmo9uVWxvFE5XYOhLdj5A2t2vvq
X-Google-Smtp-Source: AGHT+IE2ZjzhhF3KT4N00BscK7M3J3K9+kILugqUUTPdX4rGdXCCT0e/jhysbXYNIB+9mUv7WWWTlg==
X-Received: by 2002:ad4:5962:0:b0:6d8:8e0f:8c03 with SMTP id 6a1803df08f44-6d934aec01cmr68660266d6.18.1733933245095;
        Wed, 11 Dec 2024 08:07:25 -0800 (PST)
Received: from denia.c.googlers.com (5.236.236.35.bc.googleusercontent.com. [35.236.236.5])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d8daa00671sm71484946d6.88.2024.12.11.08.07.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 08:07:24 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Wed, 11 Dec 2024 16:07:22 +0000
Subject: [PATCH v4 6/6] media: ipu-bridge: Remove unneeded conditional
 compilations
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241211-fix-ipu-v4-6-4102e97aceb6@chromium.org>
References: <20241211-fix-ipu-v4-0-4102e97aceb6@chromium.org>
In-Reply-To: <20241211-fix-ipu-v4-0-4102e97aceb6@chromium.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 Robert Moore <robert.moore@intel.com>, 
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Dan Carpenter <dan.carpenter@linaro.org>, linux-kernel@vger.kernel.org, 
 linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev, 
 Ricardo Ribalda <ribalda@chromium.org>, 
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
X-Mailer: b4 0.13.0

The ACPI headers have introduced implementations for some of their
functions when the kernel is not configured with ACPI.

Let's use them instead of our conditional compilation. It is easier to
maintain and less prone to errors.

Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Fixes: 8810e055b575 ("media: intel/ipu6: Fix build with !ACPI")
Acked-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/pci/intel/ipu-bridge.c | 28 +++++-----------------------
 1 file changed, 5 insertions(+), 23 deletions(-)

diff --git a/drivers/media/pci/intel/ipu-bridge.c b/drivers/media/pci/intel/ipu-bridge.c
index a0e9a71580b5..1db994338fdf 100644
--- a/drivers/media/pci/intel/ipu-bridge.c
+++ b/drivers/media/pci/intel/ipu-bridge.c
@@ -2,6 +2,7 @@
 /* Author: Dan Scally <djrscally@gmail.com> */
 
 #include <linux/acpi.h>
+#include <acpi/acpi_bus.h>
 #include <linux/cleanup.h>
 #include <linux/device.h>
 #include <linux/i2c.h>
@@ -107,7 +108,6 @@ static const char * const ipu_vcm_types[] = {
 	"lc898212axb",
 };
 
-#if IS_ENABLED(CONFIG_ACPI)
 /*
  * Used to figure out IVSC acpi device by ipu_bridge_get_ivsc_acpi_dev()
  * instead of device and driver match to probe IVSC device.
@@ -127,11 +127,11 @@ static struct acpi_device *ipu_bridge_get_ivsc_acpi_dev(struct acpi_device *adev
 		const struct acpi_device_id *acpi_id = &ivsc_acpi_ids[i];
 		struct acpi_device *consumer, *ivsc_adev;
 
-		acpi_handle handle = acpi_device_handle(adev);
+		acpi_handle handle = acpi_device_handle(ACPI_PTR(adev));
 		for_each_acpi_dev_match(ivsc_adev, acpi_id->id, NULL, -1)
 			/* camera sensor depends on IVSC in DSDT if exist */
 			for_each_acpi_consumer_dev(ivsc_adev, consumer)
-				if (consumer->handle == handle) {
+				if (ACPI_PTR(consumer->handle) == handle) {
 					acpi_dev_put(consumer);
 					return ivsc_adev;
 				}
@@ -139,12 +139,6 @@ static struct acpi_device *ipu_bridge_get_ivsc_acpi_dev(struct acpi_device *adev
 
 	return NULL;
 }
-#else
-static struct acpi_device *ipu_bridge_get_ivsc_acpi_dev(struct acpi_device *adev)
-{
-	return NULL;
-}
-#endif
 
 static int ipu_bridge_match_ivsc_dev(struct device *dev, const void *adev)
 {
@@ -261,9 +255,8 @@ static enum v4l2_fwnode_orientation ipu_bridge_parse_orientation(struct acpi_dev
 	struct acpi_pld_info *pld = NULL;
 	acpi_status status = AE_ERROR;
 
-#if IS_ENABLED(CONFIG_ACPI)
-	status = acpi_get_physical_device_location(adev->handle, &pld);
-#endif
+	status = acpi_get_physical_device_location(ACPI_PTR(adev->handle),
+						   &pld);
 	if (ACPI_FAILURE(status)) {
 		dev_warn(ADEV_DEV(adev), "_PLD call failed, using default orientation\n");
 		return V4L2_FWNODE_ORIENTATION_EXTERNAL;
@@ -498,9 +491,7 @@ static void ipu_bridge_create_connection_swnodes(struct ipu_bridge *bridge,
 	if (sensor->csi_dev) {
 		const char *device_hid = "";
 
-#if IS_ENABLED(CONFIG_ACPI)
 		device_hid = acpi_device_hid(sensor->ivsc_adev);
-#endif
 
 		snprintf(sensor->ivsc_name, sizeof(sensor->ivsc_name), "%s-%u",
 			 device_hid, sensor->link);
@@ -671,11 +662,7 @@ static int ipu_bridge_connect_sensor(const struct ipu_sensor_config *cfg,
 	struct acpi_device *adev = NULL;
 	int ret;
 
-#if IS_ENABLED(CONFIG_ACPI)
 	for_each_acpi_dev_match(adev, cfg->hid, NULL, -1) {
-#else
-	while (true) {
-#endif
 		if (!ACPI_PTR(adev->status.enabled))
 			continue;
 
@@ -768,15 +755,10 @@ static int ipu_bridge_ivsc_is_ready(void)
 	unsigned int i;
 
 	for (i = 0; i < ARRAY_SIZE(ipu_supported_sensors); i++) {
-#if IS_ENABLED(CONFIG_ACPI)
 		const struct ipu_sensor_config *cfg =
 			&ipu_supported_sensors[i];
 
 		for_each_acpi_dev_match(sensor_adev, cfg->hid, NULL, -1) {
-#else
-		while (true) {
-			sensor_adev = NULL;
-#endif
 			if (!ACPI_PTR(sensor_adev->status.enabled))
 				continue;
 

-- 
2.47.0.338.g60cca15819-goog


