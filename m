Return-Path: <linux-kernel+bounces-528398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A86B5A4174E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 09:27:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FC00188EACE
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 08:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11BF3199931;
	Mon, 24 Feb 2025 08:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WHyrk0Z2"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8947B185B76
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 08:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740385643; cv=none; b=LrIRYQVd3X99QwMCkQtQacC+jDNhYfws66zvvMNCGibPTbdDoh1cbEOGrTpPEcd+wdEMyhPmRSiIcvINIw8nlPsbZFoalINGPS0oHny6DH31ibT0FiIrDTNIkDeQDLSlz/w1QbMxWT+qepfj437dZ6iRioMBht8x+ycY/rJi3Ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740385643; c=relaxed/simple;
	bh=3T0cL+VEf4J5ClWNfYMV045WOy2JwE+1mmFR9rUZZAQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pluLPHYyxOrxxZ57F2xLp/cqKwm3Vie6cI9rbmvESV2K4StdkDFCg8cbY7wjefxr5roHov4Pp/stBSFpaZdsXzecADrYJA0M+hMheBTyPQlvkFJg9OzQeA7hp1EXxUIlwEEu1HTR1VVeJn6vDRx+u+cGUWdG7gZOSAptUF91Ivc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WHyrk0Z2; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43948021a45so35487835e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 00:27:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740385640; x=1740990440; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aYwMXRGhqPJVeCHmiE25B/8hJ2pbS0pkX4B/uzw0Bpo=;
        b=WHyrk0Z2x598FNKKsW6db/YXYMiaBeUrQVce7sZGtIkf9GHv0aiidCBRB4E5+dZ3iX
         xFwFjRjjF4UsfPa8/y+d+Mh4RC1eqq5ymKvp5bIDYrzurGPi78GDKGIMhH9WyBj9cz0d
         gVkkLqOLWw4b6hwhC/1oVBCvHvi7DKBaV73ACV+ejUf2r5rYe55DKPyYIbxFEQbwBeAd
         rB39jRPDSrAGJ19Z9erIUzkHvhBHePFUQC7TOIVooVIosPYcjWbLMkSCHHpQ1Dr8wejQ
         /SehGHEFjo35z2HnRwEZqyzYSjiuuYXpzdmD7yHbblavEDcqM2qFSMDvuuoTxCroZry3
         Uchg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740385640; x=1740990440;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aYwMXRGhqPJVeCHmiE25B/8hJ2pbS0pkX4B/uzw0Bpo=;
        b=C//7neXOgJ/2PUz9752lsKGcwesSgO5YWg7uJ9BazKTCi5c0l03ctzWkf7Ulrkm6dw
         2++Jm5jJ0s43CEhw96RiwooG+0rmMRO/u8kGLs6bsEUiQdg+w/1lpMjUUlqaVcsVLQ3D
         veHYFBDa2k4wtWVpa9fDsndfty3UXY59OD4SllMEPgL3GACOj5INYgK/6V5sea1beVSa
         7jRW+cKN+xA+G0J7o72eDUcQkYwdjPLveG2VCVouSDpF1fChfh+I2nkRtYkcRKyjhLGp
         GSecWytgTWUUdCNowmvPtcbl0MOOb5Y9w4+ZTUvPu+RKf390WJVRXpWY37n3ei1rNNMj
         +Ijg==
X-Gm-Message-State: AOJu0Yzdn6ACwFSM5Ns9aRZBk4zZASsunfk2PoyyO7O5eJJBAL480VUy
	tdp3aKuDMw6I5Kjfv3NaX/8jADzwupD3m7KEDta5CU8HHMgregd1NJs2j01imEk=
X-Gm-Gg: ASbGnctH1zRZ2ekNr5bXy8P1l290rORwmpXcW8oEPdgBX70ooJfKYSDWoG95eppagOS
	2ZkjbixGFe1pGFKEBIOypJQy9zFJ2YPoyHYLAtRDdhWxX6sK/wkPk2Es66A9oyziAU31NYAdQRr
	q446G92A/LOGzJ9+ABzy0Lt374wwQKjFNg18ntMyumN235NZBlHyCOvZanwz2AAWS4rgqc1SfIn
	HSDX2MAuodytSZs3oA6ekqqecTYYkQF+wydFe04v8aBoorIysUfT63ax2rgW9AqqomECFool7Xs
	cOeUMNeq0tOZIKxM6r1/KBlS0v5Wt6bCQqxoMXO9BiYYoIBLSYyj9pAaBx+1wKJTSF8jOpYoWSk
	Qp0IGjg==
X-Google-Smtp-Source: AGHT+IGZckWvGeOr8E/UDV8u/tU4+iCw1PmLZDRhSbXopZ3hDTSITsUdwNlMxxSGKUNtLevOBuFg4A==
X-Received: by 2002:a05:600c:1396:b0:439:6d7c:48fd with SMTP id 5b1f17b1804b1-439ae1d877dmr101582335e9.4.1740385639804;
        Mon, 24 Feb 2025 00:27:19 -0800 (PST)
Received: from ta2.c.googlers.com (169.178.77.34.bc.googleusercontent.com. [34.77.178.169])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-439b02ce428sm101226065e9.5.2025.02.24.00.27.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 00:27:19 -0800 (PST)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Date: Mon, 24 Feb 2025 08:27:15 +0000
Subject: [PATCH v2 3/6] mailbox: sort headers alphabetically
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250224-mbox-mutex-v2-3-9d699148fe4e@linaro.org>
References: <20250224-mbox-mutex-v2-0-9d699148fe4e@linaro.org>
In-Reply-To: <20250224-mbox-mutex-v2-0-9d699148fe4e@linaro.org>
To: Jassi Brar <jassisinghbrar@gmail.com>
Cc: linux-kernel@vger.kernel.org, andre.draszik@linaro.org, 
 peter.griffin@linaro.org, willmcvicker@google.com, kernel-team@android.com, 
 Tudor Ambarus <tudor.ambarus@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740385635; l=2186;
 i=tudor.ambarus@linaro.org; s=20241212; h=from:subject:message-id;
 bh=3T0cL+VEf4J5ClWNfYMV045WOy2JwE+1mmFR9rUZZAQ=;
 b=KgwNXE0g+z34fknGI4MqhozA71+p94txtbTEk+oADQviMovI34n2DASTu3qUbsm6SCokbRChp
 EcXLw250C8LBwJyeCREXTg6MAyRbh13INCZCU4wWn9/wR4OZbK6Xy0P
X-Developer-Key: i=tudor.ambarus@linaro.org; a=ed25519;
 pk=uQzE0NXo3dIjeowMTOPCpIiPHEz12IA/MbyzrZVh9WI=

Sorting headers alphabetically helps locating duplicates,
and makes it easier to figure out where to insert new headers.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/mailbox/mailbox.c          | 14 +++++++-------
 include/linux/mailbox_client.h     |  2 +-
 include/linux/mailbox_controller.h |  6 +++---
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/mailbox/mailbox.c b/drivers/mailbox/mailbox.c
index 784b56859a06..fa3dcec63940 100644
--- a/drivers/mailbox/mailbox.c
+++ b/drivers/mailbox/mailbox.c
@@ -6,18 +6,18 @@
  * Author: Jassi Brar <jassisinghbrar@gmail.com>
  */
 
-#include <linux/interrupt.h>
-#include <linux/spinlock.h>
-#include <linux/mutex.h>
+#include <linux/bitops.h>
 #include <linux/delay.h>
-#include <linux/slab.h>
-#include <linux/err.h>
-#include <linux/module.h>
 #include <linux/device.h>
-#include <linux/bitops.h>
+#include <linux/err.h>
+#include <linux/interrupt.h>
 #include <linux/mailbox_client.h>
 #include <linux/mailbox_controller.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/of.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
 
 #include "mailbox.h"
 
diff --git a/include/linux/mailbox_client.h b/include/linux/mailbox_client.h
index 734694912ef7..c6eea9afb943 100644
--- a/include/linux/mailbox_client.h
+++ b/include/linux/mailbox_client.h
@@ -7,8 +7,8 @@
 #ifndef __MAILBOX_CLIENT_H
 #define __MAILBOX_CLIENT_H
 
-#include <linux/of.h>
 #include <linux/device.h>
+#include <linux/of.h>
 
 struct mbox_chan;
 
diff --git a/include/linux/mailbox_controller.h b/include/linux/mailbox_controller.h
index 6fee33cb52f5..5fb0b65f45a2 100644
--- a/include/linux/mailbox_controller.h
+++ b/include/linux/mailbox_controller.h
@@ -3,11 +3,11 @@
 #ifndef __MAILBOX_CONTROLLER_H
 #define __MAILBOX_CONTROLLER_H
 
+#include <linux/completion.h>
+#include <linux/device.h>
+#include <linux/hrtimer.h>
 #include <linux/of.h>
 #include <linux/types.h>
-#include <linux/hrtimer.h>
-#include <linux/device.h>
-#include <linux/completion.h>
 
 struct mbox_chan;
 

-- 
2.48.1.601.g30ceb7b040-goog


