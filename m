Return-Path: <linux-kernel+bounces-426294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 646C99DF157
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 15:54:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24288281540
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 14:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE59D19EEC2;
	Sat, 30 Nov 2024 14:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="j9ymIdNo"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A94B146A68
	for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 14:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732978442; cv=none; b=rqTmq0uUjbj7nEX6APCoHwDTDGBzVXbAsJcBP9L3Ow3GqjoslH4FJPT7Lt7LiSWssncSc3IAvkKd9KndH9xJiS+n28szRJt9X2yDcI69uUVZrtuqrTHQm7JQeU7CqqmKJKEQOzog45n+XqaQlyiZetphENDe84n7kAp8EKMU58Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732978442; c=relaxed/simple;
	bh=KXZ3g46ZGg7f/iC0+oUPjcmJI5u7vEpntocDHxCb0aU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ag9WtomgpBDD5OUJgLAugWocc5+EYNki3KBCKnv2cTQkqcauLYtZfiAC44G57fNcJgANh53rkt0UgiE/pFHCGQzFkOOTv28nGI7kCOfALtVSo6LmxP/xTrVAF4TU9H50WiYmQWHcVUjQbU+VPLWGNBsjSz9FLbkZbBnPE2wB5dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=j9ymIdNo; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-434a8b94fb5so16486935e9.0
        for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 06:53:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1732978437; x=1733583237; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CpFrrOTLGr3RFQFCUUv1pCgo8CbioVSw3fd+gaG+5uc=;
        b=j9ymIdNoWgrd9eEZPnsjTw07ZKmmtD0NYPGcZhmm8Ogout+f0/EOqKVNNms3UCx7Od
         WLPpYf+5aOHuvfN43JgTwFBQWt9VCbWC1vT2HhjvupqujxBF4ii398cHahgYOk5xc5Wq
         uUtARJ1qmIIPSvYfKn9Abz+WHIKnxeeJ0FrGsCvuZ0o5lVXheR+SswpR1+8aFMluakyK
         CjEpJ03Rm4tKj/LiAI2KTEeGEuWkAm+HxzK926rUZy73mi73ODrAxeIMHa1eHitleA7d
         cyyuZIQJ2+g/LelcfxS3nn1oropAfQe/YAoNduZBSupqOislahYm1893kr5wOJZhB6u9
         DWTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732978437; x=1733583237;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CpFrrOTLGr3RFQFCUUv1pCgo8CbioVSw3fd+gaG+5uc=;
        b=mSDJLaPHdXgMrzo+BhTm+mZypHoc/epwOE+i0beZBOkDzvemAWUPQJwfjIF8arnoaA
         Poo0GVWxo+z7LOL8hFKJaRjsvZeszN33tR7qOAjPmjljEnk8CkHnATuByrC3mT9lL814
         fjkxqZN0fGYK/Iz35R1DF2y5Am0q9IyK6KmVdRZbiefl7H+QVoR4lZDT9efSamyYKuiV
         MI8sgfhwCuUqRUFqmPnSp93IuVwWKLFxvd2fTYSimP1dmxUaNIpacz+oYnkIsUUQSJk6
         799LP926F6uoVTtYnhjNoO+3u+fvpP2wse+yVGNpPwtLRig8QttRCL2+G5sjNt3cxpzn
         QElg==
X-Forwarded-Encrypted: i=1; AJvYcCV5F+d1i6ipN/oOOzBWcXaaT2A2UCtoFyN02jut0nRqvpnRhd6xcAPYeH5sMGbl3VTqIMVWQDyYVMdekC4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdetPqH6BIpAOHYShYyCJenVugtU3piZCqgeHEfIDhDC/y+CJP
	vgqaw8qGyiUGpBSYPRumsG5WTaEP228vFAk0tn+VcMrZZzi4dA/U5tu31NvkY1c=
X-Gm-Gg: ASbGncsRK01iZuUULD6azEA2dwluY+ik1tzohm2+9mHxNfJ7UEEQuqoXCHZA0yO5M2q
	E28z/jbbACvKUikgsSQtgzmEZmLPJSrxSt3EsDrwx7xyktX4NPjFyDqqJN+U6ado2pjIPZoWGHz
	E0SGtKs3TSfLK2WeFlDJEw1C1NHxTc8DQqJ6LI0U5mb3mSbk2HFz/1NhtMuSvp21QpVTnIn3vEt
	172Y3ChSKtpYy+76A9iZZDjR7D+QGrwS7ljpc34rF9wdO39gQ==
X-Google-Smtp-Source: AGHT+IGrynxoFgzJT6PAs7OFtv48vmNwvaUskq+U4o+wWjvVE477AQcSVTslrt5OwnhmboCvp40VYQ==
X-Received: by 2002:a05:600c:1c01:b0:434:9d55:620 with SMTP id 5b1f17b1804b1-434afbd337amr103748095e9.11.1732978437237;
        Sat, 30 Nov 2024 06:53:57 -0800 (PST)
Received: from localhost ([2a02:8071:b783:6940:7ca4:5604:f5:65])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385e4a54b71sm1537613f8f.79.2024.11.30.06.53.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Nov 2024 06:53:56 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Richard Cochran <richardcochran@gmail.com>
Cc: Yangbo Lu <yangbo.lu@nxp.com>,
	David Woodhouse <dwmw2@infradead.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ptp: Switch back to struct platform_driver::remove()
Date: Sat, 30 Nov 2024 15:53:49 +0100
Message-ID: <20241130145349.899477-2-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=4567; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=KXZ3g46ZGg7f/iC0+oUPjcmJI5u7vEpntocDHxCb0aU=; b=owGbwMvMwMXY3/A7olbonx/jabUkhnRvtX8f2z3CV89J8TVjO2Ao2PnoFqd03qwT3KkvOK1lz 5tw3d/cyWjMwsDIxSArpshi37gm06pKLrJz7b/LMINYmUCmMHBxCsBEqjPY/4d/FHwd7fpD45Zv bdna5Lc6rdWLWO+zrWFeJSIZLjsloZt7U7Bu2maJFa6xaeqnLwX5ehS+un53m80RD5tXbAFri2d 8sZz3iOVjmd7TqVKaS56tezJxvup8lbMSQs+ve8qLyJawmdULKXwVn8fsurfLUWhTR1cdi9fhUq GvzYUKIk1+HhyZLZH89Sn8jfkfg9Skv+S4XPs2vyL63z/79E8fTA3i0+uVeI7Usl/pThQWbgkO7 RO8nSV+6Pj8fWGdeVc1VoktUQt4d+H0t5Tm2ckW8taZp+T/LJ36QVerZnfnyZWnJgr4lv2OvxP0 jEt8jfaBu29Y9ackfI48olrLNSl/Uf2+9mNnn0Zkeh0CAA==
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

After commit 0edb555a65d1 ("platform: Make platform_driver::remove()
return void") .remove() is (again) the right callback to implement for
platform drivers.

Convert all platform drivers below drivers/ptp to use .remove(), with
the eventual goal to drop struct platform_driver::remove_new(). As
.remove() and .remove_new() have the same prototypes, conversion is done
by just changing the structure member name in the driver initializer.

While touching these drivers, make the alignment of the touched
initializers consistent.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
Hello,

this is based on Friday's next, feel free to drop changes that result in
a conflict when you come around to apply this. I'll care for the fallout
at a later time then. (Having said that, if you use b4 am -3 and git am
-3, there should be hardly any conflict.)

This is merge window material.

Best regards
Uwe

 drivers/ptp/ptp_clockmatrix.c | 2 +-
 drivers/ptp/ptp_dte.c         | 4 ++--
 drivers/ptp/ptp_fc3.c         | 2 +-
 drivers/ptp/ptp_idt82p33.c    | 2 +-
 drivers/ptp/ptp_ines.c        | 4 ++--
 drivers/ptp/ptp_qoriq.c       | 2 +-
 drivers/ptp/ptp_vmclock.c     | 2 +-
 7 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/ptp/ptp_clockmatrix.c b/drivers/ptp/ptp_clockmatrix.c
index b6f1941308b1..fbb3fa8fc60b 100644
--- a/drivers/ptp/ptp_clockmatrix.c
+++ b/drivers/ptp/ptp_clockmatrix.c
@@ -2471,7 +2471,7 @@ static struct platform_driver idtcm_driver = {
 		.name = "8a3400x-phc",
 	},
 	.probe = idtcm_probe,
-	.remove_new = idtcm_remove,
+	.remove = idtcm_remove,
 };
 
 module_platform_driver(idtcm_driver);
diff --git a/drivers/ptp/ptp_dte.c b/drivers/ptp/ptp_dte.c
index 449ff90927be..372168578a30 100644
--- a/drivers/ptp/ptp_dte.c
+++ b/drivers/ptp/ptp_dte.c
@@ -326,8 +326,8 @@ static struct platform_driver ptp_dte_driver = {
 		.pm = PTP_DTE_PM_OPS,
 		.of_match_table = ptp_dte_of_match,
 	},
-	.probe    = ptp_dte_probe,
-	.remove_new = ptp_dte_remove,
+	.probe = ptp_dte_probe,
+	.remove = ptp_dte_remove,
 };
 module_platform_driver(ptp_dte_driver);
 
diff --git a/drivers/ptp/ptp_fc3.c b/drivers/ptp/ptp_fc3.c
index 879b82f03535..cfced36c70bc 100644
--- a/drivers/ptp/ptp_fc3.c
+++ b/drivers/ptp/ptp_fc3.c
@@ -1003,7 +1003,7 @@ static struct platform_driver idtfc3_driver = {
 		.name = "rc38xxx-phc",
 	},
 	.probe = idtfc3_probe,
-	.remove_new = idtfc3_remove,
+	.remove = idtfc3_remove,
 };
 
 module_platform_driver(idtfc3_driver);
diff --git a/drivers/ptp/ptp_idt82p33.c b/drivers/ptp/ptp_idt82p33.c
index d5732490ed9d..b2fd94d4f863 100644
--- a/drivers/ptp/ptp_idt82p33.c
+++ b/drivers/ptp/ptp_idt82p33.c
@@ -1461,7 +1461,7 @@ static struct platform_driver idt82p33_driver = {
 		.name = "82p33x1x-phc",
 	},
 	.probe = idt82p33_probe,
-	.remove_new = idt82p33_remove,
+	.remove = idt82p33_remove,
 };
 
 module_platform_driver(idt82p33_driver);
diff --git a/drivers/ptp/ptp_ines.c b/drivers/ptp/ptp_ines.c
index 14a23d3a27f2..3d723a2aa6bb 100644
--- a/drivers/ptp/ptp_ines.c
+++ b/drivers/ptp/ptp_ines.c
@@ -781,8 +781,8 @@ static const struct of_device_id ines_ptp_ctrl_of_match[] = {
 MODULE_DEVICE_TABLE(of, ines_ptp_ctrl_of_match);
 
 static struct platform_driver ines_ptp_ctrl_driver = {
-	.probe  = ines_ptp_ctrl_probe,
-	.remove_new = ines_ptp_ctrl_remove,
+	.probe = ines_ptp_ctrl_probe,
+	.remove = ines_ptp_ctrl_remove,
 	.driver = {
 		.name = "ines_ptp_ctrl",
 		.of_match_table = ines_ptp_ctrl_of_match,
diff --git a/drivers/ptp/ptp_qoriq.c b/drivers/ptp/ptp_qoriq.c
index 879cfc1537ac..4d488c1f1941 100644
--- a/drivers/ptp/ptp_qoriq.c
+++ b/drivers/ptp/ptp_qoriq.c
@@ -670,7 +670,7 @@ static struct platform_driver ptp_qoriq_driver = {
 		.of_match_table	= match_table,
 	},
 	.probe       = ptp_qoriq_probe,
-	.remove_new  = ptp_qoriq_remove,
+	.remove      = ptp_qoriq_remove,
 };
 
 module_platform_driver(ptp_qoriq_driver);
diff --git a/drivers/ptp/ptp_vmclock.c b/drivers/ptp/ptp_vmclock.c
index cdca8a3ad1aa..0a2cfc8ad3c5 100644
--- a/drivers/ptp/ptp_vmclock.c
+++ b/drivers/ptp/ptp_vmclock.c
@@ -601,7 +601,7 @@ MODULE_DEVICE_TABLE(acpi, vmclock_acpi_ids);
 
 static struct platform_driver vmclock_platform_driver = {
 	.probe		= vmclock_probe,
-	.remove_new	= vmclock_remove,
+	.remove		= vmclock_remove,
 	.driver	= {
 		.name	= "vmclock",
 		.acpi_match_table = vmclock_acpi_ids,

base-commit: f486c8aa16b8172f63bddc70116a0c897a7f3f02
-- 
2.45.2


