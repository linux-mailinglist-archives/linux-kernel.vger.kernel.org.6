Return-Path: <linux-kernel+bounces-558553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EE96A5E780
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 23:34:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 917F31789FB
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 22:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E0841F09A7;
	Wed, 12 Mar 2025 22:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VD2X01EY"
Received: from mail-ua1-f74.google.com (mail-ua1-f74.google.com [209.85.222.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A4851DFD95
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 22:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741818884; cv=none; b=ersTs9eCPUT8PfpcFTJ5TsKfZKf/9Azrpm05Wzs9tY1rTtUvX4wpEikNU9GdWIFh9vzW0Ze7jKF+HJGhkPp/MBMleNzMa66HWHM7LBoVdSXzy9O5ycXW5m/cRW35doQuDVLvl3Z69ijs1a8xMTj6T1OrYj9Dow2VtIHVZRsGE6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741818884; c=relaxed/simple;
	bh=3KJ0HHsMSHMJk5Iw1GAEfHYOa/Qm3AuHR0tXHGj6P8Y=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=Gq6tJq4HXZVPUziGDl1jbtK7qho5G4Q/fRAcvmnHf8c8677zvFgOt0xFe4PNVBMtey9emJppW3w4MCn3cSe2f1Za6ac5iL35/fSvKoZWOoJH9RO/c6Jxp5XcdXXwC6x5ZfRvfWUNuMrYpgO1pcgsTDVY2TTATh7AZB7yDjVqnCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--royluo.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VD2X01EY; arc=none smtp.client-ip=209.85.222.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--royluo.bounces.google.com
Received: by mail-ua1-f74.google.com with SMTP id a1e0cc1a2514c-85c8a0d07f2so558639241.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 15:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741818882; x=1742423682; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bEqQH7LM/I5fcJh9LOUeg2fjsogabhtbwsRZFdFLct0=;
        b=VD2X01EYriFg4GnANHKz7amRPBXR83ZWyKb7CBpXwzDk9hTGVGwUZh+CXWNBNsWHuU
         q89AXzT+e4bIO4zcwkxFx2UzXFs9hf6+ZhuYt4IjCdGvqcVe/ec933Ndtyk8AoK6NloG
         twkRO+xZYslqAS4J9QlphTmLyiZwO6oLQ7O33B4a6PszifiibMgBbNyOaKtQFSxfadmX
         z0l9M9CGj3kf59grZDReDro21BJDH12OiwJhObox9wXCsbcJkXYHk/YN84HevGkLtUFL
         w7QH8FISdgVevuffs1IwpSnLCOOXbZLztVC3zPLc1AKUe3Z1rcDdENxT1mmEhGC3KXef
         uCVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741818882; x=1742423682;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bEqQH7LM/I5fcJh9LOUeg2fjsogabhtbwsRZFdFLct0=;
        b=ZKBGWtTrcYUXwQ3cKVwabo5cGCJsQ9FrOiD8DuLqvpoBaKFjkfsWHburter0hGo6Ef
         qyNKm1LNtwkAhTb7kOOSgCdjalL4pV2BIXpcPLZffryNybIUxDKCpYSesbFvmvCD4WvV
         RQO7EU8gZl6+NiA1MNH9qUI3Jw6N8rJvlPxpJ3JlukHlb7s5qrq7FGnhPV6QAa7TWnDJ
         h4tNTx/cI8HYF0jnJcysNbZMJFGgUHTS3AQ1c7DqLQ8gv8/n3r63owLPX3XyW2ptOi0T
         uqXam8V0okvpPoQcqB3FkJ13a5ZaLwrDsuys3ZlBTS8FnaYDoTZJskmyP2bv32+4vQEM
         MNkg==
X-Forwarded-Encrypted: i=1; AJvYcCW+nhhfIkFfUOkTukXo/RHCk3cX0fRWHYmILxhfhiK73RV9MGweLvkYAT6EVY+6OCIG9xwCFDOl1PvVgiQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzGSzzLII6b6DJM++iYIAjr8T4q74MSNY+kQr/fFiquZiyhuBI
	n9cV5pjKGSf1jbtirFBY8V0fKuAmT71/Q+lJhVNSd9AYoFGjxYZaeYMJR+ZtJcIyxOnEq6oDo5y
	Q/g==
X-Google-Smtp-Source: AGHT+IH27wghRkbdr4imbrFtDk+BcdkRbtMVrSGmAai6u7+rHjot/T2PaZ6LLZGPr0IT6dxQHj1Y4UAKv7w=
X-Received: from vsvf31.prod.google.com ([2002:a05:6102:151f:b0:4be:7f07:bd02])
 (user=royluo job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6102:38d1:b0:4bb:cbbc:38
 with SMTP id ada2fe7eead31-4c34d1f5651mr10060155137.5.1741818881949; Wed, 12
 Mar 2025 15:34:41 -0700 (PDT)
Date: Wed, 12 Mar 2025 22:34:34 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.rc1.451.g8f38331e32-goog
Message-ID: <20250312223434.3071598-1-royluo@google.com>
Subject: [PATCH v2] usb: dwc3: core: Avoid redundant system suspend/resume callbacks
From: Roy Luo <royluo@google.com>
To: royluo@google.com, Thinh.Nguyen@synopsys.com, gregkh@linuxfoundation.org, 
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

dwc3 device suspend/resume callbacks were being triggered during system
suspend and resume even if the device was already runtime-suspended.
This is redundant for device mode because the suspend and resume routines
are essentially identical for system PM and runtime PM.

To prevent these unnecessary callbacks, indicate to the PM core that it
can safely leave the device in runtime suspend if it's already
runtime-suspended in device mode by returning a positive value in
prepare() callback. This optimization only applies to devices without
pinctrl, as pinctrl has distinct logic tied to system suspend/resume.

Signed-off-by: Roy Luo <royluo@google.com>
---
Changes in v2:
- leave the pinctrl logic untouched, apply the optimization only when
  pinctrl isn't being used.
---
 drivers/usb/dwc3/core.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 66a08b527165..02cdd0727a5e 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -26,6 +26,7 @@
 #include <linux/of_graph.h>
 #include <linux/acpi.h>
 #include <linux/pinctrl/consumer.h>
+#include <linux/pinctrl/devinfo.h>
 #include <linux/reset.h>
 #include <linux/bitfield.h>
 
@@ -2658,14 +2659,31 @@ static void dwc3_complete(struct device *dev)
 		dwc3_writel(dwc->regs, DWC3_GUCTL3, reg);
 	}
 }
+
+static int dwc3_prepare(struct device *dev)
+{
+	struct dwc3	*dwc = dev_get_drvdata(dev);
+
+	/*
+	 * Indicate to the PM core that it may safely leave the device in
+	 * runtime suspend if runtime-suspended already in device mode.
+	 */
+	if (dwc->current_dr_role == DWC3_GCTL_PRTCAP_DEVICE &&
+	    pm_runtime_suspended(dev) &&
+	    !dev_pinctrl(dev))
+		return 1;
+
+	return 0;
+}
 #else
 #define dwc3_complete NULL
+#define dwc3_prepare NULL
 #endif /* CONFIG_PM_SLEEP */
 
 static const struct dev_pm_ops dwc3_dev_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(dwc3_suspend, dwc3_resume)
 	.complete = dwc3_complete,
-
+	.prepare = dwc3_prepare,
 	/*
 	 * Runtime suspend halts the controller on disconnection. It relies on
 	 * platforms with custom connection notification to start the controller

base-commit: 0fed89a961ea851945d23cc35beb59d6e56c0964
-- 
2.49.0.rc1.451.g8f38331e32-goog


