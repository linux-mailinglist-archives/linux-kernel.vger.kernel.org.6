Return-Path: <linux-kernel+bounces-352798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91BB499243B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 08:11:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 160B91F22F6C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 06:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66CA016D9C2;
	Mon,  7 Oct 2024 06:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Mj2x03bj"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC45F15B987
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 06:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728281394; cv=none; b=LAVPf1yQYY7c8bFmQbKzwNUvdlx4fICDXjhgIVW3vxVasuUGHAcyxJ66gJmFafaD7HlbapLKyKmxpH3VwsC8x88ESe66/Txvvg1sx5YRu7Gedcp57ZC8A/DHrW3Y3r5srQxr+UuwX2bRrt8sl8V+IQWfMqW7t/INRA3rNQZMbv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728281394; c=relaxed/simple;
	bh=51vJexiIZraFrEpebOvAh01zLZDQthCgMztxQmaLz20=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Y5ahQrDFSPwiaVNSxv8wpOWroWQ/bHgYtVRb4qSCVO3MSwDKsMB/7Beg3wD7dIoFkH96WTxX3xW8kOPZIBzpBhCdM7uSrqpcGWIUars/1icujkoYv0dLp/anYVW6iNUFAA7n2+GHVZkwxLXKsB7ovgqxa3TpClPGKMVnW2e1Azs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Mj2x03bj; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2fadc95ccfcso41636101fa.1
        for <linux-kernel@vger.kernel.org>; Sun, 06 Oct 2024 23:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1728281391; x=1728886191; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UJT6fTnyK7gt6GR+f50pMFXilJq+FtbxEdBurZINfZs=;
        b=Mj2x03bjiUxlGqaG1i7h7n2atoZKW8I4gLVxxyAL7FCe3/1X0t6EZh26f//CT3i+1I
         maRO7zzSKfnbdQ9FsERdUbRk9jg2ncwScc2b26AezjX+yEf122DcBuDPInohqDnBy4QK
         pYy1QfDSQ9IqDWnrVdEr4tRj1TfAuZ4walS0SbNsU1ZxCrTi+5nDYkyYObBI8o9X9CFS
         clyAmxPDKGkE9Q1QhpCL8TS+tHM8GquEXYgJAHS1OtwerSLltwqTpQGvLHQE7g0CdTW3
         SnQdc7ub6YoFG4ZmvkyEaXrWdkOZGoxD5t65vD+s1/v+8U9I+RZUE3tLYyzKLZrpwMnj
         u/mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728281391; x=1728886191;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UJT6fTnyK7gt6GR+f50pMFXilJq+FtbxEdBurZINfZs=;
        b=WR0z7tA6lvvFMEqMTBCXIlSxlqk7HmuZRSOrPtsEo7Zp8UbVNO/ZOFGZ3UYRh9GtRc
         ts+TNIiHQmwT5PjE2LUqyDDa6g/zEDq/K2dMxkFY1B9/DAwP0OMgcGeyVOBvzihcHB2t
         LHR1gsV21/pbfWY2m/z31If0IOWBV9AeohniIMlPJKWYK/xVFvuoa9N/mTZptg3v/JUm
         8vSE84RzQFKYYxFCoc0dawRZU60GBv4/i1hxG56I7/A6ynytH0BgZ12zhMzCJyYSghyN
         2Sr7d6rbsYWooicrNrYVaJ285EY2CR1VL5XFmn5h12QEJowFZWdXENvWxJ/UMHGfCetC
         QjSA==
X-Forwarded-Encrypted: i=1; AJvYcCWgaCLVOyoyThnnPzrZEs1X6EXa8LEWpVQQg7VDGCQ7sQVAqVm7uFoH1h12ySrczccSC+rlUcDZpl6NIok=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0Icw7cgKtCjZE/TzZwGU+BULL3+vsp0KbsMhpYzszmx5a+a9f
	vWV0KPFeG70N4UNUeq9j5SazHHUXLdSPAJY2WOdIy3ZfKKXHugMIsjotRx1jFY0=
X-Google-Smtp-Source: AGHT+IHtE2q22c15mrUYBlM+XI4odC6qvh6wx9Y3PGlMgpn4Cp7+WRFxPbnEvB1ZDfNUB5pdtDtNEg==
X-Received: by 2002:a2e:be83:0:b0:2fa:bb65:801f with SMTP id 38308e7fff4ca-2faf3c5e66bmr50601771fa.10.1728281390896;
        Sun, 06 Oct 2024 23:09:50 -0700 (PDT)
Received: from localhost ([2001:4090:a244:83ae:2517:2666:43c9:d0d3])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c8e05acccbsm2780061a12.32.2024.10.06.23.09.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Oct 2024 23:09:50 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
Date: Mon, 07 Oct 2024 08:08:58 +0200
Subject: [PATCH v13 5/5] firmware: ti_sci: add CPU latency constraint
 management
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241007-tisci-syssuspendresume-v13-5-ed54cd659a49@baylibre.com>
References: <20241007-tisci-syssuspendresume-v13-0-ed54cd659a49@baylibre.com>
In-Reply-To: <20241007-tisci-syssuspendresume-v13-0-ed54cd659a49@baylibre.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>, 
 Len Brown <len.brown@intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Nishanth Menon <nm@ti.com>, 
 Tero Kristo <kristo@kernel.org>, Santosh Shilimkar <ssantosh@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, Kamlesh Gurudasani <kamlesh@ti.com>, 
 Kevin Hilman <khilman@baylibre.com>, Dhruva Gole <d-gole@ti.com>, 
 Vishal Mahaveer <vishalm@ti.com>, 
 Markus Schneider-Pargmann <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2464; i=msp@baylibre.com;
 h=from:subject:message-id; bh=NmQkSN4+LhFVHdywGiboPnzzPp0wfB+96FsAiBdv9Qw=;
 b=owGbwMvMwCGm0rPl0RXRdfaMp9WSGNKZqxUvCp2K/vhz+/eUX41npyxZLcdVcG3OoumNm+2+s
 W3gFNeW6ihlYRDjYJAVU2S5+2Hhuzq56wsi1j1yhJnDygQyhIGLUwAmEv6V4X/FxGWnbquJz/vg
 JWZx+/jUtczageXbGK0Nor9nZuVeaZJj+B9vfGb+CbPq/0o9s75t9Z8ePZHn7bqoJXPfvw1nt+N
 tWs0JAA==
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41

From: Kevin Hilman <khilman@baylibre.com>

During system-wide suspend, check if any of the CPUs have PM QoS
resume latency constraints set.  If so, set TI SCI constraint.

TI SCI has a single system-wide latency constraint, so use the max of
any of the CPU latencies as the system-wide value.

Note: DM firmware clears all constraints at resume time, so
constraints need to be checked/updated/sent at each system suspend.

Co-developed-by: Vibhore Vardhan <vibhore@ti.com>
Signed-off-by: Vibhore Vardhan <vibhore@ti.com>
Reviewed-by: Dhruva Gole <d-gole@ti.com>
Signed-off-by: Dhruva Gole <d-gole@ti.com>
Signed-off-by: Kevin Hilman <khilman@baylibre.com>
Tested-by: Dhruva Gole <d-gole@ti.com>
Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 drivers/firmware/ti_sci.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
index b67c35c93802b50ed3ba7b97a216fb39d6c46ebc..555e41cc08080c78b3991a8d6c06f5030a576d72 100644
--- a/drivers/firmware/ti_sci.c
+++ b/drivers/firmware/ti_sci.c
@@ -9,6 +9,7 @@
 #define pr_fmt(fmt) "%s: " fmt, __func__
 
 #include <linux/bitmap.h>
+#include <linux/cpu.h>
 #include <linux/debugfs.h>
 #include <linux/export.h>
 #include <linux/io.h>
@@ -19,6 +20,7 @@
 #include <linux/of.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
+#include <linux/pm_qos.h>
 #include <linux/property.h>
 #include <linux/semaphore.h>
 #include <linux/slab.h>
@@ -3666,7 +3668,27 @@ static int ti_sci_prepare_system_suspend(struct ti_sci_info *info)
 static int __maybe_unused ti_sci_suspend(struct device *dev)
 {
 	struct ti_sci_info *info = dev_get_drvdata(dev);
-	int ret;
+	struct device *cpu_dev, *cpu_dev_max = NULL;
+	s32 val, cpu_lat = 0;
+	int i, ret;
+
+	if (info->fw_caps & MSG_FLAG_CAPS_LPM_DM_MANAGED) {
+		for_each_possible_cpu(i) {
+			cpu_dev = get_cpu_device(i);
+			val = dev_pm_qos_read_value(cpu_dev, DEV_PM_QOS_RESUME_LATENCY);
+			if (val != PM_QOS_RESUME_LATENCY_NO_CONSTRAINT) {
+				cpu_lat = max(cpu_lat, val);
+				cpu_dev_max = cpu_dev;
+			}
+		}
+		if (cpu_dev_max) {
+			dev_dbg(cpu_dev_max, "%s: sending max CPU latency=%u\n", __func__, cpu_lat);
+			ret = ti_sci_cmd_set_latency_constraint(&info->handle,
+								cpu_lat, TISCI_MSG_CONSTRAINT_SET);
+			if (ret)
+				return ret;
+		}
+	}
 
 	ret = ti_sci_prepare_system_suspend(info);
 	if (ret)

-- 
2.45.2


