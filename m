Return-Path: <linux-kernel+bounces-440228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D622B9EBA7C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 20:58:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93BA91888FF7
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 19:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99B9922B599;
	Tue, 10 Dec 2024 19:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KOLGOKD/"
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58AF722ACE6
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 19:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733860589; cv=none; b=oU1/6ZnoiX0Y24ZBKQPazpN9a1veyOy0L2oKZiokbqBShcAI8CgZcwMrln+G3Xc9vp7l7EzNoXBQ7CqsoH6wpm/7IYPEjqOLIDL5ANo6h9tdTHnCjVlidBPDIv+09lw65T1I22M1g+pao0ZwV3hZuBZLiW9SgfiVhWgVCaiEgNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733860589; c=relaxed/simple;
	bh=ukuL0J/MKKzCt1mPhJR16PHXljadgzBKa2hSze0hLo8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IzPTlfpKAMieOcJb7KoJkchyBgYhUXFGmmKLkxDBi3KaPNorrqXRkfiNi/KIUb8jAbaDhYqGTg+JO+Z9e7vOjHbKQZrX0gG4CSBxyFQAFvGSD0p7JqL+C65kV/Igjv20PIuB5NualMYzQFZAl+5jycXHJqlJujxX9NXYbQNXY/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=KOLGOKD/; arc=none smtp.client-ip=209.85.217.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-4afe7429d37so1088117137.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 11:56:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733860586; x=1734465386; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dngrOjvFkokaO//xpC5ashvyb8OkGy64lo3N8QG5GXU=;
        b=KOLGOKD/qaXR7H25UZLEBaHjq2UOt9wZwomhp1XKtzKewScYKBofXHPpsnMJZe+ifA
         5HP4JV06jQ+vtM1+bAtWxWPG+JLWI7gypWpG2eAeQTrxFyFevK3jzn1/TO159zsY8Gsr
         Be/GAgMEljUWHJYqNzsNKhd1N0/gBjDWG1i20=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733860586; x=1734465386;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dngrOjvFkokaO//xpC5ashvyb8OkGy64lo3N8QG5GXU=;
        b=DHa/dH4jtLXzoMNsfcm+C67BHfEFRmqMQlCY9gTGQ096xIeIziuFO2A3/GMK7D8s94
         4UGj1OSTs4lXt/QeMCjN7PdmVf9VJu+ZhphXKgplvIUyAH/aVf4dKduLhO1NHXMBw5AF
         XTfy4UGzO8RzL14hhZX4u9YpMZLp7ihilzfZcymy1kk8QaOGTploIVaHouAX7O0GYbqR
         Lgq3BQE3iomJr75mKKk+LSTL8hrwLrau1Kw+1oApysR1bu+W6HmvqOZuGN6NTOODNib2
         kg1xkuhueb7Z7OJNjCVfETvuh1DLtMBABNO4XA3d35N1HEYZWxvWr+gDkuFgvAJ2XR6S
         PQFA==
X-Forwarded-Encrypted: i=1; AJvYcCX3pgRsHn4E3EENt8cN+1MhIU2EVhifD4GgWoCMjmqolNi7EjOXcNfOGe1/yGvsGODX6rjAQ4BMeKqtsIU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDzct2gWaed9HJeWh1tq3ARKX9wyDdOUiCM071mXbCTlFTUmyy
	lMyIz5gcPlhhoLY8orMnPyebA86/x1XTxjoQ6WEY+WFqziThRqNec9xm9S1cqQ==
X-Gm-Gg: ASbGnct6DZz9VJuySEFWFaa9hLv50yaGN1o8w24/58+CZabLQ8F8Yf1gOaAcjV91l0U
	2CjqR4b7KWmIChfcTREMSL200XITw/6qdthaGHi3ECv6Pd0qsuzotk0649ts8O4vladMMd5nvjf
	lejtZhoO4TC18XMe/0KUQWWmQb8IU5CfQnfpv9yhrZDvIqUplUX6p6hi6AdaOl0ahuGhCVa85Nw
	aPPWUsA3Puxivp2Cg9gs1T11yfzcBBut7NucZF2b5l6Gx39+qGhWKEmXRLPvhFYICSKr72+FmGv
	vYRZFfvAU+il/jEU96tq426+S+zh
X-Google-Smtp-Source: AGHT+IFCnfB8ydByqooGet6PwgafKh6LnL27DqPrsLgjTnlJDdhRhasDusXRsUEK8BwIHAK84lpL7Q==
X-Received: by 2002:a05:6102:3714:b0:4b0:4d6:bff1 with SMTP id ada2fe7eead31-4b1290040cdmr739077137.14.1733860586240;
        Tue, 10 Dec 2024 11:56:26 -0800 (PST)
Received: from denia.c.googlers.com (5.236.236.35.bc.googleusercontent.com. [35.236.236.5])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-85c2ba7dc70sm1279522241.15.2024.12.10.11.56.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 11:56:25 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 10 Dec 2024 19:56:04 +0000
Subject: [PATCH v3 7/7] media: ipu-bridge: Remove unneeded conditional
 compilations
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241210-fix-ipu-v3-7-00e409c84a6c@chromium.org>
References: <20241210-fix-ipu-v3-0-00e409c84a6c@chromium.org>
In-Reply-To: <20241210-fix-ipu-v3-0-00e409c84a6c@chromium.org>
To: Mauro Carvalho Chehab <mchehab@kernel.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 Robert Moore <robert.moore@intel.com>, 
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Dan Carpenter <dan.carpenter@linaro.org>, linux-media@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
 acpica-devel@lists.linux.dev, Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.13.0

The ACPI headers have introduced implementations for some of their
functions when the kernel is not configured with ACPI.

Let's use them instead of our conditional compilation. It is easier to
maintain and less prone to errors.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/pci/intel/ipu-bridge.c | 28 +++++-----------------------
 1 file changed, 5 insertions(+), 23 deletions(-)

diff --git a/drivers/media/pci/intel/ipu-bridge.c b/drivers/media/pci/intel/ipu-bridge.c
index be82bc3e27d0..1db994338fdf 100644
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
-		while (false) {
-			sensor_adev = NULL;
-#endif
 			if (!ACPI_PTR(sensor_adev->status.enabled))
 				continue;
 

-- 
2.47.0.338.g60cca15819-goog


