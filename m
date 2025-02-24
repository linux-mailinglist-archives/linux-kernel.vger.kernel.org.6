Return-Path: <linux-kernel+bounces-529373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FE7BA4245C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 15:55:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36C5B444EED
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 14:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A523C23370B;
	Mon, 24 Feb 2025 14:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="H9wS+l2g"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E1C1624F3
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 14:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740408006; cv=none; b=Dw8KEIH/4DeauBHLLY+YjsPEwsROAxuQk4KY/XefQ3wwDraOMtiGGda29A0cWDLYrOnoAzaCSm1eESHDhPK4+mQZJDeSlC4YItrP7CqagOQ5pyQDHrtthTtPw8KyuGluD9HVQ1FRkRDCvrOnQUWBib1pUZZkV7pKMzT297iP6pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740408006; c=relaxed/simple;
	bh=d0seFRCbsm6obDyggndTpMQD/bofnkskpXmGDrRtX50=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ndg78AJqmRPT7cPsPMs9ckiqolYTRGJKXrWFb8se/EBXuGM6qtyXlSk/JbMDb4eLinYEinwTb0s/mGrYa3XmvOnP3uWdn0uuW0ZZSsHZ9l1QMfEJX5dvwOpwN1l07CsLr2NKOO5UeqKwnOF0Io6yELUwNWz+X/+dRcmsH2QxF5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=H9wS+l2g; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 978EE3F735
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 14:31:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1740407506;
	bh=DFCOc2ChWOWoHT2jvhggwm0YHMFaUQk1iMuzmg5CkXY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=H9wS+l2gCjVX2c1wmzWycoO/usRKeST/u4Bny0tia2Bkz8umW3lCyrSp4hmYO4/mV
	 seF48UkbefCNpxPK9fe3ggRurmN5SpZAO+8Q3+yLwiOkMnCqtnWq2xi0WZmYE3y4NR
	 /e0N5sLWelG15uDrv2KzM8WmZtsuaZRBeh4UqdpPWgjc7fpkExCkxcCu06EF57rK0K
	 rPku9DESToJ3aAN/L8bgOu3S7iz3/Ex8uXeVIjm0/bdwIze7CYo4VUh8sU6iRq7c40
	 wHbeqn0CKtqpiDIC1XbOWQgflmHmbM0GrO/bLdqetTwXuvN+SOom6VZwavtHLI7LCZ
	 hCE9FCcIid/ag==
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-220e1593b85so85692005ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 06:31:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740407504; x=1741012304;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DFCOc2ChWOWoHT2jvhggwm0YHMFaUQk1iMuzmg5CkXY=;
        b=Jn0zhC5bKRkjxX+3IY5C8lOhVv0LOki3xyWbNxoxk35P1mfosz+j78YcngNRGuQMHp
         7+9PveFV3BpYkdJJXsvblNBD8fo0RuEfVUih+pdox8g+AFQYyzXR7hhnX4OVT1/Ft5z3
         uasgYBV3INvt/be2mjB8KI8ZHOoFcnt8rx/GzixEfbly9idjnAtQPdRuRr1+A7WluRc2
         LyzcV0rn7976Af+kbJNyDIBhhlPrOnOloBnH4uJz4Q0/U9xzGpdlUr2X/42HI/wM4w5v
         r+Pk0T5z4LyYkN8/M1sH2qeI80YBnihhzy7thfkh6C4T2mgsHPTzKV/Mk1pgdV2RMeCP
         NK0Q==
X-Forwarded-Encrypted: i=1; AJvYcCWUZhJCRGK3IMwv1OR+Psp3IiMSzEzEjEmztmi4BnEvxKHNqBnXL6HZPiSkrgB4VEbHxaJ74YEAcNyufIg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/MfjFQsD/T/EY9xGKgMSSNAsH+O/k8TXBMT6GMi3LhWPEdJva
	VcOB2y28Ds14pdAn9riyevlNsFncMgusHVsdqFO9OzpvwU+KVepkrfezjVsKDqZseIn1cEJLdlC
	9G8k/LbeTswfeY/lFj80GY1au1IWjOIgc30OI4nUFu9oOb2SKoglg8fVPWihDd+EtOw5alVD1Y4
	2LzA==
X-Gm-Gg: ASbGncvC4bveYVayU2u+NThKBEEd5z+7SUwTpW/Vg7BN9uN2NI3PgsA9p2CthuipvYb
	Cnm9fqdXAjOXKZUcpUcrfFJYm5XW3SKThk1zDhIjR6OlgaYkRnETGnzAXWK3eSnDvGqgbp8K5ZK
	/fBy79+5gzps/XGSMciNbWlJCgd+3caJ8Hh5X5r9b3BBQ8L2poVVxx1USW+nLBwMCgnkwXEp531
	52EwOvVGHOjuJ+I6hYkzq4TyiSDUKeRe8ZPD7RR4qcOM7xB5p6ALWxgfZn/87lxVLnu/3groAH7
	672vFZRborwxTUvN
X-Received: by 2002:a17:902:fc48:b0:21f:61a5:67a5 with SMTP id d9443c01a7336-2219ffdde5fmr233722265ad.42.1740407504525;
        Mon, 24 Feb 2025 06:31:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEVvBJFcEolR1dcNIqGBCvi0trfSSSLEJ+FOzuCFIVoYboEgvcnU6lXykfPq61XLxr8UBX64A==
X-Received: by 2002:a17:902:fc48:b0:21f:61a5:67a5 with SMTP id d9443c01a7336-2219ffdde5fmr233721845ad.42.1740407504118;
        Mon, 24 Feb 2025 06:31:44 -0800 (PST)
Received: from z790sl.. ([240f:74:7be:1:de7b:58db:ab85:24ee])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d545d067sm177613895ad.109.2025.02.24.06.31.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 06:31:43 -0800 (PST)
From: Koichiro Den <koichiro.den@canonical.com>
To: linux-gpio@vger.kernel.org
Cc: brgl@bgdev.pl,
	geert+renesas@glider.be,
	linus.walleij@linaro.org,
	maciej.borzecki@canonical.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 1/9] gpio: aggregator: protect driver attr handlers against module unload
Date: Mon, 24 Feb 2025 23:31:26 +0900
Message-ID: <20250224143134.3024598-2-koichiro.den@canonical.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250224143134.3024598-1-koichiro.den@canonical.com>
References: <20250224143134.3024598-1-koichiro.den@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Both new_device_store and delete_device_store touch module global
resources (e.g. gpio_aggregator_lock). To prevent race conditions with
module unload, a reference needs to be held.

Add try_module_get() in these handlers.

For new_device_store, this eliminates what appears to be the most dangerous
scenario: if an id is allocated from gpio_aggregator_idr but
platform_device_register has not yet been called or completed, a concurrent
module unload could fail to unregister/delete the device, leaving behind a
dangling platform device/GPIO forwarder. This can result in various issues.
The following simple reproducer demonstrates these problems:

  #!/bin/bash
  while :; do
    # note: whether 'gpiochip0 0' exists or not does not matter.
    echo 'gpiochip0 0' > /sys/bus/platform/drivers/gpio-aggregator/new_device
  done &
  while :; do
    modprobe gpio-aggregator
    modprobe -r gpio-aggregator
  done &
  wait

  Starting with the following warning, several kinds of warnings will appear
  and the system may become unstable:

  ------------[ cut here ]------------
  list_del corruption, ffff888103e2e980->next is LIST_POISON1 (dead000000000100)
  WARNING: CPU: 1 PID: 1327 at lib/list_debug.c:56 __list_del_entry_valid_or_report+0xa3/0x120
  [...]
  RIP: 0010:__list_del_entry_valid_or_report+0xa3/0x120
  [...]
  Call Trace:
   <TASK>
   ? __list_del_entry_valid_or_report+0xa3/0x120
   ? __warn.cold+0x93/0xf2
   ? __list_del_entry_valid_or_report+0xa3/0x120
   ? report_bug+0xe6/0x170
   ? __irq_work_queue_local+0x39/0xe0
   ? handle_bug+0x58/0x90
   ? exc_invalid_op+0x13/0x60
   ? asm_exc_invalid_op+0x16/0x20
   ? __list_del_entry_valid_or_report+0xa3/0x120
   gpiod_remove_lookup_table+0x22/0x60
   new_device_store+0x315/0x350 [gpio_aggregator]
   kernfs_fop_write_iter+0x137/0x1f0
   vfs_write+0x262/0x430
   ksys_write+0x60/0xd0
   do_syscall_64+0x6c/0x180
   entry_SYSCALL_64_after_hwframe+0x76/0x7e
   [...]
   </TASK>
  ---[ end trace 0000000000000000 ]---

Fixes: 828546e24280 ("gpio: Add GPIO Aggregator")
Signed-off-by: Koichiro Den <koichiro.den@canonical.com>
---
 drivers/gpio/gpio-aggregator.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/gpio/gpio-aggregator.c b/drivers/gpio/gpio-aggregator.c
index 65f41cc3eafc..d668ddb2e81d 100644
--- a/drivers/gpio/gpio-aggregator.c
+++ b/drivers/gpio/gpio-aggregator.c
@@ -119,10 +119,15 @@ static ssize_t new_device_store(struct device_driver *driver, const char *buf,
 	struct platform_device *pdev;
 	int res, id;
 
+	if (!try_module_get(THIS_MODULE))
+		return -ENOENT;
+
 	/* kernfs guarantees string termination, so count + 1 is safe */
 	aggr = kzalloc(sizeof(*aggr) + count + 1, GFP_KERNEL);
-	if (!aggr)
-		return -ENOMEM;
+	if (!aggr) {
+		res = -ENOMEM;
+		goto put_module;
+	}
 
 	memcpy(aggr->args, buf, count + 1);
 
@@ -161,6 +166,7 @@ static ssize_t new_device_store(struct device_driver *driver, const char *buf,
 	}
 
 	aggr->pdev = pdev;
+	module_put(THIS_MODULE);
 	return count;
 
 remove_table:
@@ -175,6 +181,8 @@ static ssize_t new_device_store(struct device_driver *driver, const char *buf,
 	kfree(aggr->lookups);
 free_ga:
 	kfree(aggr);
+put_module:
+	module_put(THIS_MODULE);
 	return res;
 }
 
@@ -203,13 +211,19 @@ static ssize_t delete_device_store(struct device_driver *driver,
 	if (error)
 		return error;
 
+	if (!try_module_get(THIS_MODULE))
+		return -ENOENT;
+
 	mutex_lock(&gpio_aggregator_lock);
 	aggr = idr_remove(&gpio_aggregator_idr, id);
 	mutex_unlock(&gpio_aggregator_lock);
-	if (!aggr)
+	if (!aggr) {
+		module_put(THIS_MODULE);
 		return -ENOENT;
+	}
 
 	gpio_aggregator_free(aggr);
+	module_put(THIS_MODULE);
 	return count;
 }
 static DRIVER_ATTR_WO(delete_device);
-- 
2.45.2


