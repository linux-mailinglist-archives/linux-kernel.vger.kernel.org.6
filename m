Return-Path: <linux-kernel+bounces-271819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8177945392
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 21:55:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35D8BB23B33
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 19:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E134B14B964;
	Thu,  1 Aug 2024 19:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="fDEb5ayl"
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54EB814B094
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 19:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722542089; cv=none; b=HJnWYQBabcaFExtpaFymWS8Gd7+H5iX4Gg2YuLf9YBoDMtZE3Noq5DKOLNvycySlKba4GWDtBOusEjeEX2nw+nKBuVzmXFHZNJO7enQ6bgkNDs4AxxUuZ5WGQ9NtHj4ewNGg4LyLuHPgbsJ1OhxqLDEdh6/j1ZIZbt36F0uOSB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722542089; c=relaxed/simple;
	bh=JBlOpox+A9W1aNFkgCFA4RBYqw308foHZKUcX8mCVIs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PKNmjuknt7LgkaLRu/gEDyhQsLmHJLPgJpg/3OP1Nrc10AAOBQNxuhvqFvtrPhdwE/e12VqlYOp0lHWdO2fkPxWxQ0oWwXyKtJTgqyY/CZwbtUkGOW4Thbj8kF6AqMAv0wLvSWBfQg9k3JmqgGfyUSwA6QaoXZMuQBURiFAIVGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=fDEb5ayl; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-81f860c6015so308027039f.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 12:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1722542086; x=1723146886; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9iEVMVSSASUblJN+I5RRNLDh5lLbEMUJopbZEPnk+4E=;
        b=fDEb5aylc7fRvWFnAJk6Eo9IwPiwup06CVXXaOhMRhssdjVIQcAK+FVctJyz0OU3+5
         VGpQaCkD5+bHHRG4aVgXMdHx8Vs0LC2/SBV6rSfu305Co09Lqeo/cnwlKyRi+t2eUXZf
         aDxeNZKeHhfW8JMeKTUT+Nc0hjLJgY5hVdzamfJCW+LSj1bPX8C4+Aq8E76Y1BoCTF+n
         JEdQGJFGbD8IpKmiOU7bxNuC4TdXy7E/E4LV5+8kvHKSSqqCp55HqNZ4DjSaAKJA+LXQ
         xqjyxiTZXVUyJW2TXQ/ucwF9yy2mPWDBGCapfaUwsDSQtmwxP7uDcvRWxh3Ulz5WLQLf
         GeFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722542086; x=1723146886;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9iEVMVSSASUblJN+I5RRNLDh5lLbEMUJopbZEPnk+4E=;
        b=TuuV5hu6E6YtOhk52tJVG9O8GqTYVRJhno0egD/MVVZJA8fig6ks3y+ROPwo4IFbI6
         ulK9cxRYFIvFy8BL45gslZvHWwsoQEXg9SPTEE8iLJYzvt1z7DXaAyDZn6oLZc8nDtHc
         AwE0Rk1bXAozSzjB8+m6z0BohyKqQEYCyi1hCJDxkLiu5kz4snPHEM7Lo6UVmC1h9V/E
         cFNOH0WPyBcnl/J6bOjpb8qraRZyBRzszoUXR1DheAlVImGB1mygTUJEhXj/PzpZLJq8
         9a+YMZ2C6SjSQXJF8FF1cwslEm+IWFh+heU533LkP5GkqGvfT2XMW1jUjf8bZw9lXIgM
         dDGQ==
X-Forwarded-Encrypted: i=1; AJvYcCXvZxq1xKNq31Al7CbqPNLFwHOdMOxkP+Gzf7saZBUo6sUBnz1hEYgS34WvBM/7xI6KyDrrk6HOvqiWp102x+v4EuRx0v9T9W7pP7lj
X-Gm-Message-State: AOJu0YwPeo0d/u8AjPrjGjsZypMrBR2Te3KiN1OszrVmH40QGs8ADs0O
	JiczDpp9G5NYKVb1VmDXoFKRZSZKKa4lNcAsU416WhMAEqXV4vlzafgTki+lF2w=
X-Google-Smtp-Source: AGHT+IGlQleoo3d7L5GSbrK0N1Kufp4Xm1KA+uZah8PmzbYcBVnm34gnq52AA8WceFq1OcOmBdCXRg==
X-Received: by 2002:a05:6602:341f:b0:81f:8bed:702f with SMTP id ca18e2360f4ac-81fd4353a65mr176313939f.1.1722542086410;
        Thu, 01 Aug 2024 12:54:46 -0700 (PDT)
Received: from blmsp.fritz.box ([2001:4091:a245:8609:c1c4:a4f8:94c8:31f2])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-81fd4d1b7ddsm14395039f.3.2024.08.01.12.54.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 12:54:46 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
To: Nishanth Menon <nm@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	Santosh Shilimkar <ssantosh@kernel.org>
Cc: Vibhore Vardhan <vibhore@ti.com>,
	Kevin Hilman <khilman@baylibre.com>,
	Dhruva Gole <d-gole@ti.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Dave Gerlach <d-gerlach@ti.com>,
	Georgi Vlaev <g-vlaev@ti.com>,
	Markus Schneider-Pargmann <msp@baylibre.com>
Subject: [PATCH v8 3/3] firmware: ti_sci: Add system suspend and resume call
Date: Thu,  1 Aug 2024 21:54:22 +0200
Message-ID: <20240801195422.2296347-4-msp@baylibre.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240801195422.2296347-1-msp@baylibre.com>
References: <20240801195422.2296347-1-msp@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vibhore Vardhan <vibhore@ti.com>

Introduce system suspend call that enables the ti_sci driver to support
low power mode when the user space issues a suspend to mem.

Also, write a ti_sci_prepare_system_suspend call to be used in the driver
suspend handler to allow the system to identify the low power mode being
entered and if necessary, send TISCI_MSG_PREPARE_SLEEP with information
about the mode being entered.

Sysfw version >= 10.00.04 support LPM_DM_MANAGED capability [2], where
Device Mgr firmware now manages which low power mode is chosen. Going
forward, this is the default configuration supported for TI AM62 family
of devices. The state chosen by the DM can be influenced by sending
constraints using the new LPM constraint APIs.

In case the firmware does not support LPM_DM_MANAGED mode, the mode
selection logic can be extended as needed. If no suspend-to-RAM modes
are supported, return without taking any action.

We're using "pm_suspend_target_state" to map the kernel's target suspend
state to SysFW low power mode. Make sure this is available only when
CONFIG_SUSPEND is enabled.

Suspend has to be split into two parts, ti_sci_suspend() will send
the prepare sleep message to prepare suspend. ti_sci_suspend_noirq()
sets IO isolation which needs to be done as late as possible to avoid
any issues. On resume this has to be done as early as possible.

Co-developed-by: Dave Gerlach <d-gerlach@ti.com>
Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
Signed-off-by: Georgi Vlaev <g-vlaev@ti.com>
Signed-off-by: Dhruva Gole <d-gole@ti.com>
Signed-off-by: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Vibhore Vardhan <vibhore@ti.com>
Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 drivers/firmware/ti_sci.c | 82 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
index d7a3990a6353..c6544cc12417 100644
--- a/drivers/firmware/ti_sci.c
+++ b/drivers/firmware/ti_sci.c
@@ -24,6 +24,7 @@
 #include <linux/slab.h>
 #include <linux/soc/ti/ti-msgmgr.h>
 #include <linux/soc/ti/ti_sci_protocol.h>
+#include <linux/suspend.h>
 #include <linux/sys_soc.h>
 #include <linux/reboot.h>
 
@@ -3608,6 +3609,84 @@ static int tisci_reboot_handler(struct sys_off_data *data)
 	return NOTIFY_BAD;
 }
 
+#ifdef CONFIG_SUSPEND
+static int ti_sci_prepare_system_suspend(struct ti_sci_info *info)
+{
+	u8 mode;
+
+	/*
+	 * Map and validate the target Linux suspend state to TISCI LPM.
+	 * Default is to let Device Manager select the low power mode.
+	 */
+	switch (pm_suspend_target_state) {
+	case PM_SUSPEND_MEM:
+		if (info->fw_caps & MSG_FLAG_CAPS_LPM_DM_MANAGED)
+			mode = TISCI_MSG_VALUE_SLEEP_MODE_DM_MANAGED;
+		else
+			/* DM Managed is not supported by the firmware. */
+			return -EOPNOTSUPP;
+		break;
+	default:
+		/*
+		 * Do not fail if we don't have action to take for a
+		 * specific suspend mode.
+		 */
+		return 0;
+	}
+
+	return ti_sci_cmd_prepare_sleep(&info->handle, mode, 0, 0, 0);
+}
+
+static int ti_sci_suspend(struct device *dev)
+{
+	struct ti_sci_info *info = dev_get_drvdata(dev);
+	int ret;
+
+	ret = ti_sci_prepare_system_suspend(info);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int ti_sci_suspend_noirq(struct device *dev)
+{
+	struct ti_sci_info *info = dev_get_drvdata(dev);
+	int ret = 0;
+
+	ret = ti_sci_cmd_set_io_isolation(&info->handle, TISCI_MSG_VALUE_IO_ENABLE);
+	if (ret)
+		return ret;
+	dev_dbg(dev, "%s: set isolation: %d\n", __func__, ret);
+
+	return 0;
+}
+
+static int ti_sci_resume_noirq(struct device *dev)
+{
+	struct ti_sci_info *info = dev_get_drvdata(dev);
+	u32 source;
+	u64 time;
+	int ret = 0;
+
+	ret = ti_sci_cmd_set_io_isolation(&info->handle, TISCI_MSG_VALUE_IO_DISABLE);
+	if (ret)
+		return ret;
+	dev_dbg(dev, "%s: disable isolation: %d\n", __func__, ret);
+
+	ti_sci_msg_cmd_lpm_wake_reason(&info->handle, &source, &time);
+	dev_info(dev, "%s: wakeup source: 0x%X\n", __func__, source);
+
+	return 0;
+}
+
+static const struct dev_pm_ops ti_sci_pm_ops = {
+	.suspend = ti_sci_suspend,
+	.suspend_noirq = ti_sci_suspend_noirq,
+	.resume_noirq = ti_sci_resume_noirq,
+};
+#endif  /* CONFIG_SUSPEND */
+
 /* Description for K2G */
 static const struct ti_sci_desc ti_sci_pmmc_k2g_desc = {
 	.default_host_id = 2,
@@ -3777,6 +3856,9 @@ static struct platform_driver ti_sci_driver = {
 		   .name = "ti-sci",
 		   .of_match_table = of_match_ptr(ti_sci_of_match),
 		   .suppress_bind_attrs = true,
+#ifdef CONFIG_SUSPEND
+		   .pm = &ti_sci_pm_ops,
+#endif
 	},
 };
 module_platform_driver(ti_sci_driver);
-- 
2.45.2


