Return-Path: <linux-kernel+bounces-426852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A68E9DF970
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 04:19:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BEA41B2156A
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 03:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63ECA37171;
	Mon,  2 Dec 2024 03:19:06 +0000 (UTC)
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C661C32;
	Mon,  2 Dec 2024 03:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733109546; cv=none; b=t6zEVIci1hTF5a1Z8u9IDHwCoQtfyPDcu2o+e7bvCDq5e0ALEzTSuSKk/3d/ztDVKcd7xfYpWdqUiq9iP21Oo/B/0H7L0WHJSh1UHx5eqD1IEOoOE8XUAhp1dBfi5FHRsisY0/XSQa3cO+evFFUit7N3lfZKwzrY5o49F8UafzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733109546; c=relaxed/simple;
	bh=zQI9LNrAw0U3W1yd1RZC4APDtdDOsYbvXPLl2bx7gCQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=C/x3QrjpjIMqsTrkXw6YbHDU4u4zCiXrRZrMPlneeu76nHWWMmPBmXBAcMFmIxFQrIYDe+qCFMr/ph5y7wen6Hh+acBRtVrLDVzT5eGhzrozFEwhLI6Zw6nrSDrTmKai0i2J52Go+W2psJcM0sFCjum5PwkiRAwRPPz3GXaw+CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-7f4325168c8so1756301a12.1;
        Sun, 01 Dec 2024 19:19:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733109542; x=1733714342;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qhhdmVzb03dDHwEnyn8Hx0xwKg5F3kJKkUjzhUBPrK0=;
        b=tfDsU/3tVGl7YAxoAypkbLo0h+3l4FHTknhxdaGOM8SPeOeo966wjiz51cP+sUrD/3
         p1lxv1+vlDMwNesQwxpIFBQekxunqsqjut0MPDTCdXOOFgXO9tGyq6tL1gsJ1+7nLyWi
         oGMD1EupWfT110wRv7N6fLBUmJynGwLjmT+/i3qdVyMONiRuSMqKztakuH9yTMROvfx5
         I9r6Qvstl618w9uWkMe0r1J+w+mNzuubICVvT9hok9CXGH6b6LLwyLcjANYVh+EoFhTL
         feJ1ZLl82W1mp3L5aoxDrYHp5+uqNuhSgIjl2+nPpkSjTI0M6iaPBG9vEbhhMZnJWdsI
         R8wg==
X-Forwarded-Encrypted: i=1; AJvYcCUeCCvQ+riT0DBWMpZ1GtWBfCKkvw8eC6z75f7zptWLLEb/57pkT2u1w6MBZqY8jc6VT781nEX/YmecSuo=@vger.kernel.org, AJvYcCVc7givL7DurxkoEn5ti9NNcyZ/6N+hi63+jIZXNOS8h4D/DwKs4wbEeg1jNs//OpBF36kNVnZm81W5@vger.kernel.org
X-Gm-Message-State: AOJu0YwNG3pLLhvPiQ2qD0tClxM1Lak26GQ/z69frNdJD07GtKdTN7vM
	Rm3u0E9Pp4cAvVMvZSEbV5VzSFU/o+9DBLJ6Ewy5nQtpo7hcNLOIws4HRxmWqpk=
X-Gm-Gg: ASbGncvp9UgrC/QcZL3t+GV2NtpYTKeoh9Z3nsM6HF4oKCNfzolng3NaQKf9W1Ft5jx
	pckjCW5jvx8CYW60d9hlawI8gAnh0sJ7JbaMsW8UmC1B+13mSqG4O4ojD08KrsxDCxJkVYyD1s3
	sIXNMX6COd45psWqIy5Yf16mZe9YreZbP9ULtFH0CVRsM+Y6oGTh3HE4UoVxoIl0qn/VwEc4Na6
	iQnJLpTW5Z+e/zoHS2WhwnjXJ6sUO8rGxnnuQHGXOmfCOx6Fcgf/6bAH9pbzypkGHA=
X-Google-Smtp-Source: AGHT+IFAQDbWrqzcyspSaGD4Zoo5g+jmeo5Y50m6GjcwjnjubJ0iH0V0gqND+RXJSBaLwv1tsGTUkA==
X-Received: by 2002:a05:6a20:9150:b0:1db:d8a5:7c82 with SMTP id adf61e73a8af0-1e0e0ac3171mr31721623637.5.1733109542310;
        Sun, 01 Dec 2024 19:19:02 -0800 (PST)
Received: from localhost.localdomain ([116.128.244.171])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fc9c2d38dbsm6816138a12.15.2024.12.01.19.18.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Dec 2024 19:19:01 -0800 (PST)
From: xiehongyu1@kylinos.cn
To: mathias.nyman@intel.com
Cc: gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hongyu Xie <xiehongyu1@kylinos.cn>
Subject: [PATCH] usb: xhci: Add module param for compliance quirk checking
Date: Mon,  2 Dec 2024 11:18:55 +0800
Message-Id: <20241202031855.1319821-1-xiehongyu1@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hongyu Xie <xiehongyu1@kylinos.cn>

In the old way, vendor name and product name need to be put in
xhci_compliance_mode_recovery_timer_quirk_check, it's not convenient.

So add two module param for convenience.

usage: put xhci-hcd.compliance_vendor=[vendor name]
xhci-hcd.compliance_product=[product name] in cmdline.

In Ubuntu you can use "dmidecode -t system" to get vendor name and
product name.

Signed-off-by: Hongyu Xie <xiehongyu1@kylinos.cn>
---
 drivers/usb/host/xhci.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index 5ebde8cae4fc..2007c27bfaf4 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -39,6 +39,14 @@ static unsigned long long quirks;
 module_param(quirks, ullong, S_IRUGO);
 MODULE_PARM_DESC(quirks, "Bit flags for quirks to be enabled as default");
 
+static char *compliance_product;
+module_param(compliance_product, charp, 0644);
+MODULE_PARM_DESC(compliance_product, "Product name for compliance comparison");
+
+static char *compliance_vendor;
+module_param(compliance_vendor, charp, 0644);
+MODULE_PARM_DESC(compliance_vendor, "Vendor name for compliance comparison");
+
 static bool td_on_ring(struct xhci_td *td, struct xhci_ring *ring)
 {
 	struct xhci_segment *seg;
@@ -442,13 +450,19 @@ static bool xhci_compliance_mode_recovery_timer_quirk_check(void)
 	if (!dmi_product_name || !dmi_sys_vendor)
 		return false;
 
-	if (!(strstr(dmi_sys_vendor, "Hewlett-Packard")))
+	if (!(strstr(dmi_sys_vendor, "Hewlett-Packard")) && !compliance_vendor)
+		return false;
+
+	if (compliance_vendor && !(strstr(dmi_sys_vendor,
+				  compliance_vendor)))
 		return false;
 
 	if (strstr(dmi_product_name, "Z420") ||
 			strstr(dmi_product_name, "Z620") ||
 			strstr(dmi_product_name, "Z820") ||
-			strstr(dmi_product_name, "Z1 Workstation"))
+			strstr(dmi_product_name, "Z1 Workstation") ||
+			(compliance_product && strstr(dmi_product_name,
+						     compliance_product)))
 		return true;
 
 	return false;
-- 
2.25.1


