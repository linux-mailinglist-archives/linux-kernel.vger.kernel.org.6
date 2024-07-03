Return-Path: <linux-kernel+bounces-240071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DFFC9268D3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 21:05:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB7691F2402A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 19:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4552D18F2DF;
	Wed,  3 Jul 2024 19:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e2UtngxE"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E0B18C327
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 19:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720033528; cv=none; b=kp6Bpcg/QpbaF7CF3Ow15swh3fS+7A5hP4xQz6Z8F+evagwIEz9kvrwBYCAp0Y/SzIIg5wAht1T/ZVj9awxlTlc731jchgJOE2lwM5plxx7LAtBFqC+zul2VBUH0U2l8G8jhpiNi73oGZR7jwhCUVKdrAywei5XmPzMzVI2UcHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720033528; c=relaxed/simple;
	bh=y3XlyxbnkcplVPdGQCd/lloyXAdcHjseRVqFWan6jeQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=dKJreAG4EC1XB7C6dTB2cAtLpqvITB7JwZ+0r1F65k3SoxodGxaAiGWqMEsPnfPSaLRpZHHAmSB2RQX5MkaoJ/nxVgaGeJkNnSa8BMvmolQZt6gI9zjOSnWtKwSLW0bwJtUL9GosWv/5/Y3xa2TZUmY/F1R0to1sPij1TV6Qb3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e2UtngxE; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-71871d5e087so3744522a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 12:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720033526; x=1720638326; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ybjxOawFNELGcCsAimw/UPMNpYUyGYyi73rUoZ617jE=;
        b=e2UtngxElfEIzVmWKyaXZEfYWdVj+IsWoL5hLCGce73hBJQRafIaVyzULZQGDSda0k
         4aPNq0gOZRMjY8TVsf9bQKbOGsYCpRHwOMY4GQMtI2jDATkrkHQ+oAZTnvG2zJ6bJTig
         GYdvyf9Y9Zv6DDTui3t5BTirsjU+ajOcMk7TLAce/zJwLwkfgic/zwIx0NSK1Ec7eAZB
         nX6NgZjh8l2r94O1bXVfgR2Wc5F6OBcAqil/2v6WGJCW3+e4sLjvtaAMtWZlKxuyhvzP
         BuTjip/CZrP3EOOaLXiGm8eGNgTdMk9SLscrOYFghBrLfwFSIO72M1TaIS0b1YRO2dVm
         MJhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720033526; x=1720638326;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ybjxOawFNELGcCsAimw/UPMNpYUyGYyi73rUoZ617jE=;
        b=Pi3VBYryW6g9RgW85/bm/4H1AHE54VXkhDvPc/LA/GTly7cY98+umzvzeqewdDnnfK
         UbWZKGWbjVw8oW8qMNg5HZmIxhvALH4W0YQ6Ih2glaWXcet2Wcfxjr/v5JVaq9SHZ4Rb
         KP9QgvV02oM9Pa/xwGcqwhsO48UHKzX/21dXmUUP8onbJKAhzNwHOMdB5ZtFBcwduFMY
         aEJluFYH/EaLkY4pNC527vjkWH38L3EHMd9P2+EDgApKBaqwu4tdDo0M3rq67WrcjmEi
         kashNB+3r1gjTljlIrD0xnhB8536a90bFacSBAy9A/VTHTnHAbFDnYS11Xb0BMzBtIKI
         v9EA==
X-Gm-Message-State: AOJu0YzbvOph4YWUa3M14ahygEKtuPpfqqwAXp2MXkItUPBz/UJqofUv
	EMy3sq/b/oL2q1l8AjsDNNXIMYpx5vGnDXdkulgH/GkQH+b0hfAV
X-Google-Smtp-Source: AGHT+IEWExlHJ6YcRgB1FnHrCD65xeaB0PHoZ4C3jjZ/sFKHcpNiVlJ/OXG0JsLNvNldJZ+zI0g3kw==
X-Received: by 2002:a05:6a21:7885:b0:1be:4c54:b891 with SMTP id adf61e73a8af0-1bef61ed341mr16085739637.47.1720033526270;
        Wed, 03 Jul 2024 12:05:26 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:6993:3d0b:ab92:3a8d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac10e3311sm106699175ad.79.2024.07.03.12.05.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 12:05:25 -0700 (PDT)
Date: Wed, 3 Jul 2024 12:05:23 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Lee Jones <lee@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] mfd: timberdale: attach device properties to tsc2007 board
 info
Message-ID: <ZoWg89A8C4gylTGX@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Switch over to using software nodes/properties to describe the
touchscreen instead of using the legacy platform data. This will
allow to drop support for the platform data from tsc2007 driver
and rely solely on the generic driver properties.

Note: "model" is not part of defined device propertioes and is not
used by the tsc2007 driver, so it can be safely dropped.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/mfd/timberdale.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/mfd/timberdale.c b/drivers/mfd/timberdale.c
index 07e5aa10a146..2fb8e850a81e 100644
--- a/drivers/mfd/timberdale.c
+++ b/drivers/mfd/timberdale.c
@@ -12,6 +12,7 @@
 #include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/mfd/core.h>
+#include <linux/property.h>
 #include <linux/slab.h>
 
 #include <linux/timb_gpio.h>
@@ -25,7 +26,6 @@
 #include <linux/spi/max7301.h>
 #include <linux/spi/mc33880.h>
 
-#include <linux/platform_data/tsc2007.h>
 #include <linux/platform_data/media/timb_radio.h>
 #include <linux/platform_data/media/timb_video.h>
 
@@ -49,16 +49,21 @@ struct timberdale_device {
 
 /*--------------------------------------------------------------------------*/
 
-static struct tsc2007_platform_data timberdale_tsc2007_platform_data = {
-	.model = 2003,
-	.x_plate_ohms = 100
+static const struct property_entry timberdale_tsc2007_properties[] = {
+	PROPERTY_ENTRY_U32("ti,x-plate-ohms", 100),
+	{ }
+};
+
+static const struct software_node timberdale_tsc2007_node = {
+	.name = "tsc2007",
+	.properties = timberdale_tsc2007_properties,
 };
 
 static struct i2c_board_info timberdale_i2c_board_info[] = {
 	{
 		I2C_BOARD_INFO("tsc2007", 0x48),
-		.platform_data = &timberdale_tsc2007_platform_data,
-		.irq = IRQ_TIMBERDALE_TSC_INT
+		.irq = IRQ_TIMBERDALE_TSC_INT,
+		.swnode = &timberdale_tsc2007_node,
 	},
 };
 
-- 
2.45.2.803.g4e1b14247a-goog


-- 
Dmitry

