Return-Path: <linux-kernel+bounces-448187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C67A9F3C9A
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 22:20:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0F1E1671EE
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 21:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08D531DE2D5;
	Mon, 16 Dec 2024 21:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GJPwkgNF"
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327FA1DB95F
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 21:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734383855; cv=none; b=ilIOrYQLFxE2A35KDk0rq2yIRijTMR7pfBwP+lqTfpOlrdqzhtwDchpdaO0r/fxf5k+J9iLcT36W4afg6RplS66toDGutb9TSOOl5uNeCLqvABWeNSxj4dsYQFPSNVPMmsJE4eGLCd0SP3MsikTmsx92KwSE/UrHZf8vfstMgbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734383855; c=relaxed/simple;
	bh=IKB58y4snq/gqAR94o4C+T0eqQtkn7ecDZk3e6CYE68=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=M4W9mwy76o+BG53LF+qWbJ2ezqfnBAA3YAI/AhJNFQ+SnnvBXnp1m4Px4ladfuvN1LsEKY3XzLHUf5/v2X1LBOvWKMMdsnDuIMK97ekjBDpuUjTZDNEWno9VQF2R1qIJr/it9zu3vwQHfn/HTXqTcbI/LwZ6aWJI4yrqaoJoUgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=GJPwkgNF; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-468f6b3a439so5579291cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 13:17:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1734383852; x=1734988652; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pSt2f8yebuqnlO+DsTFByKH2G3GRiRhWURC3O1KFqeY=;
        b=GJPwkgNFlEuz0Eo+vpfVsbPktf5ec6XKKDuEt1RQ1hOB+pdMWdEJCIRPeOOXTVeD+w
         r8i5ieBBTYy7w/lHAIqLfHDnPQYyxUZjRmC9ayjDAy0tNczRtAvk9T6UpMazzqA33S8W
         Z3PJNYgbgNXTLQ9SEwXsnkjyRnLP7pAENC8LI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734383852; x=1734988652;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pSt2f8yebuqnlO+DsTFByKH2G3GRiRhWURC3O1KFqeY=;
        b=bbcy1gcu2pnufdOnDpG6RtWfR3EzHndKeVIf83Wu4drqzW0LAxbsgA66kDrlTHnICf
         pG90FRFsxE1JPX1kE7eG6chki50F3Wj8GBPzZ2yfsqwufgkGKsfuWkS91tDtUnkDocnJ
         GNtHJsLhAIuRTmRijhGFibkekaP5z+joQ5102FRp0NCb0P03BpqPg3OvVp0hJ4MMm8qc
         vSvQ13msS18K6ORppv1OZEBDb401eOvTJq3GQv72z5VufoYRS8ARBDqnwmQ+3QgBAao/
         84zYbwyZTqoOTQvsvN5a3XebxvQIDWNP1/HJQ+6/2Z+uUxC7rfBWt3eECIaNmTqBg0Ah
         YciA==
X-Forwarded-Encrypted: i=1; AJvYcCVA8+ic9R8KH6k2rkoDLrg7TbgOV0HqjMSanF68WuIOYk2LhyQhstzUq9AVR2WaygGbeytdJUvwsVNRRfw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwH6ySRojb9zvkE4WdDi+OmNcRi2tJOtd3yzFMGMPchmI2Hfubm
	ythdZHaeG0MHMOgrb86F8Zai3XLPQSLxYOoQXmuYIqOGdF8wCXuAvUltNA1r9w==
X-Gm-Gg: ASbGnctJivmaib6aRFATRSD+LFWhiXaPOTLiP+ZIqwIFssVHLFvYhIs/KaDxiwUkzfO
	RJf0NGRupwRBJWxxV3K4/aNx4ZaOFZN8LWTREpMnhbY+9PUp0u0aHDpYRZyVyxFkSJ8fGUqxMjV
	9EuoLQNL7JnsQ14N5uISGhYWdYfRTwjtZuAckVg9afKovqYH1X3tp0kgsqWyVURcPOpw/Uk6x4i
	54q4McacR/+7TyuTjIX8fJxgLxNmPVgR67hSwY12Jo5cV7r52bVgMJzgBK5fxjsDI6DbB7DzXyi
	vWrKEmcs2YOQJrssGmkqxlx9EGwTyd8=
X-Google-Smtp-Source: AGHT+IGA7OE2/+AFr8NJQp1+beNCjHTix5HDCvzlrGBd1KJenMxv6YV5fSV7uyPrfaZdLlcoEJkjrQ==
X-Received: by 2002:ac8:5a93:0:b0:466:a983:a15a with SMTP id d75a77b69052e-467a581d253mr223743851cf.42.1734383852093;
        Mon, 16 Dec 2024 13:17:32 -0800 (PST)
Received: from denia.c.googlers.com (5.236.236.35.bc.googleusercontent.com. [35.236.236.5])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-467b2e85c03sm31927501cf.69.2024.12.16.13.17.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 13:17:31 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 16 Dec 2024 21:17:21 +0000
Subject: [PATCH v5 7/7] media: ipu-bridge: Remove unneeded conditional
 compilations
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241216-fix-ipu-v5-7-3d6b35ddce7b@chromium.org>
References: <20241216-fix-ipu-v5-0-3d6b35ddce7b@chromium.org>
In-Reply-To: <20241216-fix-ipu-v5-0-3d6b35ddce7b@chromium.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Robert Moore <robert.moore@intel.com>, 
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-media@vger.kernel.org, linux-usb@vger.kernel.org, 
 acpica-devel@lists.linux.dev, Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Dan Carpenter <dan.carpenter@linaro.org>, 
 Ricardo Ribalda <ribalda@chromium.org>, 
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
X-Mailer: b4 0.13.0

The ACPI headers have introduced implementations for some of their
functions when the kernel is not configured with ACPI.

Let's use them instead of our conditional compilation. It is easier to
maintain and less prone to errors.

Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Acked-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/pci/intel/ipu-bridge.c | 29 ++++-------------------------
 1 file changed, 4 insertions(+), 25 deletions(-)

diff --git a/drivers/media/pci/intel/ipu-bridge.c b/drivers/media/pci/intel/ipu-bridge.c
index 6cc2614b8f86..be84c100d732 100644
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
@@ -259,12 +253,8 @@ static enum v4l2_fwnode_orientation ipu_bridge_parse_orientation(struct acpi_dev
 {
 	enum v4l2_fwnode_orientation orientation;
 	struct acpi_pld_info *pld = NULL;
-	bool status = false;
 
-#if IS_ENABLED(CONFIG_ACPI)
-	status = acpi_get_physical_device_location(adev->handle, &pld);
-#endif
-	if (!status) {
+	if (!acpi_get_physical_device_location(ACPI_PTR(adev->handle), &pld)) {
 		dev_warn(ADEV_DEV(adev), "_PLD call failed, using default orientation\n");
 		return V4L2_FWNODE_ORIENTATION_EXTERNAL;
 	}
@@ -498,9 +488,7 @@ static void ipu_bridge_create_connection_swnodes(struct ipu_bridge *bridge,
 	if (sensor->csi_dev) {
 		const char *device_hid = "";
 
-#if IS_ENABLED(CONFIG_ACPI)
 		device_hid = acpi_device_hid(sensor->ivsc_adev);
-#endif
 
 		snprintf(sensor->ivsc_name, sizeof(sensor->ivsc_name), "%s-%u",
 			 device_hid, sensor->link);
@@ -671,11 +659,7 @@ static int ipu_bridge_connect_sensor(const struct ipu_sensor_config *cfg,
 	struct acpi_device *adev = NULL;
 	int ret;
 
-#if IS_ENABLED(CONFIG_ACPI)
 	for_each_acpi_dev_match(adev, cfg->hid, NULL, -1) {
-#else
-	while (true) {
-#endif
 		if (!ACPI_PTR(adev->status.enabled))
 			continue;
 
@@ -768,15 +752,10 @@ static int ipu_bridge_ivsc_is_ready(void)
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
2.47.1.613.gc27f4b7a9f-goog


