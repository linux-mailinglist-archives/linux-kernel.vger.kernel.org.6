Return-Path: <linux-kernel+bounces-517856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DE02A3869B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 15:36:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3769F7A3921
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 14:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EBF02236E9;
	Mon, 17 Feb 2025 14:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="MV+UwdEA"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A88F223300
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 14:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739802965; cv=none; b=c2h70d3TDzTKvTyd9zDopwhAbuhQlY0ymu9VHC88wqlF8osIbatLus6XPBTxmpVlA2Nt7mWb6bEEkWVcxnMGvHVGGTaIqyiJlSAD4ksqnGOt+vF/rUCoc3zENS6eG7RN/4eTT4WFwbTYGNBljIinCgxCwqWKzUvvjGvSJboCV8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739802965; c=relaxed/simple;
	bh=d0seFRCbsm6obDyggndTpMQD/bofnkskpXmGDrRtX50=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gwroJVhm34dsimuHA7V3XCk765hrcRlzXxB159iNcRhQcSUJQzvbqNhRi3oqysUW8Cxgisxfs7FLOlA5W/8qwF9LC1zJM2+K+2LCJlHsuBq5PneOB10b75KWjs11osQkVBuYeO8xpvHmiMMdxt1hk/63PLzb7hGJIFs6s+71wkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=MV+UwdEA; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 3D1453F880
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 14:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1739802962;
	bh=DFCOc2ChWOWoHT2jvhggwm0YHMFaUQk1iMuzmg5CkXY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=MV+UwdEAiO67a51qlUkN7QYMJgyHKuzChZWAdhkEYM6yVLyGiqI5dEbB48M2rinLV
	 /57QSdCJ6VKHwT/PPESt0XcLeUMdlFUWekRQViKsc6zwO7bECwaXflCfu6aQYk/PUa
	 wcvgZ91ax2CjxBmjqnYAg+tqSs1QnGRH1JeMos9OAwL0RJA9BzqRA8jmr4ju6cA8/D
	 HkmdNnhrEQDT9Uju5eo5mtfpnz5Tey+zRZoUmfgDLE3IkCHfN13ZM/binJqusT2RKw
	 80ZXzXOktE7CVQHYEmVGwHLkP0nTOkJh9iTpqgpyrVXWp1/PmPVGdmNJXsPJGJXW4s
	 vb/o8laqICLYw==
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2fbff6426f5so9065812a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 06:36:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739802961; x=1740407761;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DFCOc2ChWOWoHT2jvhggwm0YHMFaUQk1iMuzmg5CkXY=;
        b=gI9Y0AIui3YtWxgU3Ae6rwpYr3WxXlsK139Ql/BRPxPte7S51hESXHUOcP6NxVL79c
         MMyYbbfapWmDtBLr8X+PBtnDALUDjIbZ2cuf71QUxFFxBxEUlv43G8gOACWYNST6ZVB7
         hk3QxqPUFV0FkndJPfcqYo8tzt3xTJyvnnZwXgr7rrukr+QouqNmQLXiqkdRPSre4PaT
         jmb5wLmE05z5qekuzaz3MvJa4S4NnEduD8dD76Ky+ljRRyQEfozaAGtIX3WmiZ1yW+MC
         q2oOMfdHCap3VY1q5zkrA5i41BELqzHlL8G51SySntTOdb8nDZEKtGv9YagHmE7eM2Pm
         Twnw==
X-Forwarded-Encrypted: i=1; AJvYcCVrwGRFCw2R05q25RZGaDS3cHSTrsr66FaKygUfVNgvOgrYcM0Y8mCLPYki3H+auZ31Vqv+Xwn1eS4R9rQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1KNv3piTyX1WISwi688UdmUNLCklm74iAn0cuQfwKMe3cyoCw
	dGIU6i0FU7oQhStOKn/Z/1mg2Zp7VmPi484LLZLjHi5Q5TRi0Q59yeFmu3LOjiHtayss7VFu3qM
	rT7Q0+mqtJSr6mBu96CyYF7dMyEO4m4N12UqzCz0tQzAW8XSW0sWS4kocQXK02Ogf8pAgfc2URW
	Htbw==
X-Gm-Gg: ASbGncsg1mvY0zVtHAqYG50XE82tntMJ0cN67UIO/TvvoIw6VR58Su68xalEguNIjBq
	X3inOehBschsBEMOOxvHVooOGjYBhlDYe5u/3LL8kqfpcRZ4YG2T92oBn3JIJpfh1RSU2nN6TPm
	GRfBp+vJIg6Qqo5qBeoHmxFwXJBsIb8SzhAfGomStj/QdN3siVFUEJj0DQyhqRGXY9M0x2ZHYYE
	E/cp1nV9FAhDdfwGGGcOE5EGCdmSU1Atu+GjSJXRhvhV4uf9JC7uw6+f7KTnGOaa12DQOsOb2Ln
	0fraKyq0ZOG1Ju84fkjkwV0=
X-Received: by 2002:a17:90b:2f86:b0:2ee:e518:c1cb with SMTP id 98e67ed59e1d1-2fc40d14c6emr16850260a91.7.1739802960774;
        Mon, 17 Feb 2025 06:36:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEWwPHNmmXaHJ5chrpk4ksWCsVxcXmVulahEqAC+Tsa1D6AEEkUl9TS6Xitb3nCoTWjymM1cQ==
X-Received: by 2002:a17:90b:2f86:b0:2ee:e518:c1cb with SMTP id 98e67ed59e1d1-2fc40d14c6emr16850227a91.7.1739802960423;
        Mon, 17 Feb 2025 06:36:00 -0800 (PST)
Received: from localhost.localdomain ([240f:74:7be:1:a6da:1fd8:6ba3:4cf3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fbf98b3305sm10057757a91.6.2025.02.17.06.35.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 06:36:00 -0800 (PST)
From: Koichiro Den <koichiro.den@canonical.com>
To: linux-gpio@vger.kernel.org
Cc: brgl@bgdev.pl,
	geert+renesas@glider.be,
	linus.walleij@linaro.org,
	maciej.borzecki@canonical.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/9] gpio: aggregator: protect driver attr handlers against module unload
Date: Mon, 17 Feb 2025 23:35:23 +0900
Message-ID: <20250217143531.541185-2-koichiro.den@canonical.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250217143531.541185-1-koichiro.den@canonical.com>
References: <20250217143531.541185-1-koichiro.den@canonical.com>
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


