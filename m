Return-Path: <linux-kernel+bounces-234102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30E9191C23F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 17:15:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0E9D284B08
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 15:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ECFF1C8FB6;
	Fri, 28 Jun 2024 15:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VgIGT0fX"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 211361C8FCD;
	Fri, 28 Jun 2024 15:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719587643; cv=none; b=R9pwN0uB+uvPmqyTq/ZNlMr+h/sJ6p6jDZqQQlY34ETNRX/XO83me/Vd1MXM1I25Nrn9CLH8MqwlgRgMwK7M6LhpR5Um5gUe9TI0H3GBmZXzIaOgs6Sxx/KV1CgfBpbdvKmUqlqGTDRjvdrJN9PTEou/dsurxrd+c/p5+9/WBCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719587643; c=relaxed/simple;
	bh=LPsHvyhPi0NAqAqAHrD4tpDxpxtOTqe2gPC7Izmxq8U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=R43sfpnM3uIqS/bTogwTxkuebRuNhF464dRvL+n+uFz7Krfx6xM1aRzqUctZKylCbmcjedFtP4KxpmmT9nBYD2ug1IkDeQKT/nJnNK2txRO7vdJR65JNrKOflpCU+EpLLqYn6ZVUqQ+v/mOLf5TfxnDGvnRHraBLGXQy713ZlEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VgIGT0fX; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-70a078edb8aso57276b3a.1;
        Fri, 28 Jun 2024 08:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719587641; x=1720192441; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RSfP1MHnLnGUcfVfM2NqaHUyr+LblKMCMxBJCwu9uFk=;
        b=VgIGT0fXolXj/U/joHJI08bjLovoN4dw2S9ADFHY9J22DZl9fPqLpimkj0an962p8U
         tY9HAfV98BuE7IYVAi68sCVU3gHEG2CqVEiPMPwWns5P5DQxnPs75PpKNT1OyeR0zTPA
         QkkT4BeHoJfsZoYZx87e/iapM6vHkQ8l5hZIJxvBmyQGBMV70F3RRfVQ5/KJwiGtpz6o
         PGy0lmkpCdbHr5pIwwR8nsvxxVLBxm12geLpILUNAHNs9ydggOUGENJPmwqY2a1ACxbD
         MPpcniBG5E2eY+Q8hE7q2pJ9p0bJtEl7k9CRhD+zD+kJG/+rzcW82FmAAxVNUGrFOGFb
         VFUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719587641; x=1720192441;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RSfP1MHnLnGUcfVfM2NqaHUyr+LblKMCMxBJCwu9uFk=;
        b=dCiirF+Yec3POnBkHHXwxg2uJchg1RuNfZvtcI5dusl6I8j+McZKiCOGoL3jlUXKN8
         xR9dcjFznI1BBL+9DteY1/nx3uj7zAEi7O0pVYbgJx9P9qcnDzsTepwWCm/dF4IwdciK
         H/NPctBH3kL9WDCmrDL4CQ8nkk36QXeZ81LcFiUho7vGDLGSRohHfZFntF5vRrV5LvOw
         k9QiVGIMAo/gMDSo5P9QvAZnEuZWK6r0V5/G+DFEmOBJ1ZfdEySuiAVJMxgO8xS4UxxO
         TjKxSuwN1skCQygsBb0cEjoWnY3M1OyYryjX3jMYF1YGhHf3QTa8wMu1xHO4gIywkHKh
         mJsg==
X-Gm-Message-State: AOJu0Yy9z4rymjGNITAEV+0BLzEdKroK7evlBH9l7qdllIPWjvl/TC6t
	iNffXAzUKBrOBhTef/fR2s/55vd/ndOz7QHdgB9+bdSJxQLibOmTTdngIw==
X-Google-Smtp-Source: AGHT+IFSFruCwsgJcLv7Q414hO/8xYSg5dB4F2TJeAIN3zulCnk8xgUsbDPVmK0MyNwbG11EPpnyBA==
X-Received: by 2002:a05:6a00:14c8:b0:706:5b39:2b18 with SMTP id d2e1a72fcca58-708531f355cmr3424596b3a.11.1719587640946;
        Fri, 28 Jun 2024 08:14:00 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-708045a9998sm1716902b3a.158.2024.06.28.08.14.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 08:14:00 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: linux-hwmon@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Farouk Bouabid <farouk.bouabid@cherry.de>,
	Quentin Schulz <quentin.schulz@cherry.de>,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 05/10] hwmon: (amc2821) Reorder include files, drop unnecessary ones
Date: Fri, 28 Jun 2024 08:13:41 -0700
Message-Id: <20240628151346.1152838-6-linux@roeck-us.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240628151346.1152838-1-linux@roeck-us.net>
References: <20240628151346.1152838-1-linux@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reorder include files to alphabetic order to simplify maintenance,
and drop the unnecessary kernel.h include.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/amc6821.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/hwmon/amc6821.c b/drivers/hwmon/amc6821.c
index 8801208430df..0ac073f83c19 100644
--- a/drivers/hwmon/amc6821.c
+++ b/drivers/hwmon/amc6821.c
@@ -8,16 +8,15 @@
  * Copyright (C) 2007 Hans J. Koch <hjk@hansjkoch.de>
  */
 
-#include <linux/kernel.h>	/* Needed for KERN_INFO */
-#include <linux/module.h>
-#include <linux/init.h>
-#include <linux/slab.h>
-#include <linux/jiffies.h>
-#include <linux/i2c.h>
+#include <linux/err.h>
 #include <linux/hwmon.h>
 #include <linux/hwmon-sysfs.h>
-#include <linux/err.h>
+#include <linux/i2c.h>
+#include <linux/init.h>
+#include <linux/jiffies.h>
+#include <linux/module.h>
 #include <linux/mutex.h>
+#include <linux/slab.h>
 
 /*
  * Addresses to scan.
-- 
2.39.2


