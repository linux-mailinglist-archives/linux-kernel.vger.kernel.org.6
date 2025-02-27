Return-Path: <linux-kernel+bounces-535565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F67AA47495
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 05:37:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3363188CB41
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 04:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1395C1EB5E2;
	Thu, 27 Feb 2025 04:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aPDGWL2K"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6DF428F3
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 04:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740631016; cv=none; b=sur0MW34/uiyiY9Df1IBoChdWUxv6ton2UMQyIYRJYpljSXNvYZfHAE9MXQXj3rVzHxkDWcSPiszYUCZAM/BJt3dE7EN+0s5DETDFNl9tlqIkoojJwBgSExQKdm3PlWtZF/JMkYcoMsB4VnAA7CN1JyIk5Mvds2coAdQLuYssTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740631016; c=relaxed/simple;
	bh=y13/X5I0NMpONPQH3KE1BqniWLLBNkpo+E2aXCNUnjw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DPKRIdoPE7blaBSVZAkgzdxLIn10rFHjiWY1JdCgmGJNjAACBCkDtCVXWE+jRopG4FqzfD6yTBLXwPAuTZ+TGGgCkOpdZ9AAdeVc7LqFUqG6U8KACWw29bVTBQJVWDtufJ8oFs72qZODepgbExv6yFEkymH+Ifc2xH4rkHZEMpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=aPDGWL2K; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2235908a30aso364035ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 20:36:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740631013; x=1741235813; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DWBUXpwpeVKwHwztQYQNBbUUc1WcNoYn31qV1KKEn5Y=;
        b=aPDGWL2KKM5tveUwOnB/WP/vv3uPOXRS9BxvFreDaWGRT0uHHnk4PwD8KKiZgEdGXA
         0F6cpU+ZfaoQKE8HNPaucwtqgT9dUVQDyMLOpTjs3mu32fhd8HTmDPgcHdpJl66k1tPQ
         e1luhXnKCubZ1xYSXksBba0rCMsl/XhOH7FSg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740631013; x=1741235813;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DWBUXpwpeVKwHwztQYQNBbUUc1WcNoYn31qV1KKEn5Y=;
        b=s9zAAwH3o5nKLudYAYXHxR7pbkxssY8zG1VHR1jbWwaZ0QRJNhkmDpEB5e63vVxFfi
         S6EyQHmeaiRopV5VRgo/ElSu9qxj6hiN0iDBmfJjkfmo9vxc/zW9HsWVU1pI+delhkzx
         3CkH1cPEo+XaEqbOehO1rcVoYT1bJsYvj2JUcisG9sPBr/sK7xDmb0pkXwUGv5QWWj8q
         LZHl7h0dwwT09ZueEGM6geiB9MedmcgR7Hw3ZJ4cumMGsmD3+Wal0PN/k6/TUqWmQrYW
         GTCqVYB3cS0kgxWqDPH+PjmoyhHPA7eiPomPPVcJHqFDXY0bWcwqysDjK4/+m1KpYjxA
         Vnwg==
X-Forwarded-Encrypted: i=1; AJvYcCVmglrHaxFwsgcjZ50Mrz/kfYg9+DOT6fqAj4Apg5vuEvz3rZ1VzCdziSojlUhOSDqt9E+vnnlz2xaNqEY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsCbwV4O1Vic89c7n+OIi2SnsGdRJksUFiarw2hQgkm6Aah2uJ
	zzF5SRAdHws5o2DtVeh3jfbVOgi3NAMi5Oer+CjtVtWxnlAfFOxaIDyd06DV9Q==
X-Gm-Gg: ASbGnct3LBTygnZDM5BTzqCkbMmTZvw3kXrbx3l8lVDrgjvt2ShYChsgXfTFqAhfrzG
	i+13RaLW4PllAoMdek4G1gt16d685hllXJnfR1xaTT/QeKx+wNtZuVe4nzGOo3awes+6glw3Vhs
	uYRyTVqb8XKIDp4ZRcXakbLVrHuCghZqGtA8C66eTiPbNfAZY42rfFzpYtpdih21RsvPV0edMc1
	32RhHr70ob6fYT62CM0ZO/dTJEejOiCtPWv9fJYCOSHMWgeUWjtVQSL3gABSKgmSS+Ojor/zCzt
	gH1x/+DQpjnpRQgNrX8alGJ2uU4N
X-Google-Smtp-Source: AGHT+IHsEmBFpQZ3F93ddNTk7TR/BbwMCem5lOBEnuVdbTxvBpCIY+MLGxmXXQpOcN29GcZXld6Agg==
X-Received: by 2002:a17:902:d2cc:b0:216:3e87:c9fc with SMTP id d9443c01a7336-22320082b84mr97602405ad.5.1740631013020;
        Wed, 26 Feb 2025 20:36:53 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:a9c0:1bc1:74e3:3e31])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2fea6985226sm462165a91.40.2025.02.26.20.36.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Feb 2025 20:36:52 -0800 (PST)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Yosry Ahmed <yosry.ahmed@linux.dev>,
	Hillf Danton <hdanton@sina.com>,
	Kairui Song <ryncsn@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Minchan Kim <minchan@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH v9 04/19] zram: remove max_comp_streams device attr
Date: Thu, 27 Feb 2025 13:35:22 +0900
Message-ID: <20250227043618.88380-5-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.48.1.658.g4767266eb4-goog
In-Reply-To: <20250227043618.88380-1-senozhatsky@chromium.org>
References: <20250227043618.88380-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

max_comp_streams device attribute has been defunct since
May 2016 when zram switched to per-CPU compression streams,
remove it.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 Documentation/ABI/testing/sysfs-block-zram  |  8 -----
 Documentation/admin-guide/blockdev/zram.rst | 36 ++++++---------------
 drivers/block/zram/zram_drv.c               | 23 -------------
 3 files changed, 10 insertions(+), 57 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-block-zram b/Documentation/ABI/testing/sysfs-block-zram
index 1ef69e0271f9..36c57de0a10a 100644
--- a/Documentation/ABI/testing/sysfs-block-zram
+++ b/Documentation/ABI/testing/sysfs-block-zram
@@ -22,14 +22,6 @@ Description:
 		device. The reset operation frees all the memory associated
 		with this device.
 
-What:		/sys/block/zram<id>/max_comp_streams
-Date:		February 2014
-Contact:	Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
-Description:
-		The max_comp_streams file is read-write and specifies the
-		number of backend's zcomp_strm compression streams (number of
-		concurrent compress operations).
-
 What:		/sys/block/zram<id>/comp_algorithm
 Date:		February 2014
 Contact:	Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
diff --git a/Documentation/admin-guide/blockdev/zram.rst b/Documentation/admin-guide/blockdev/zram.rst
index 714a5171bfc0..7ad4c86f8258 100644
--- a/Documentation/admin-guide/blockdev/zram.rst
+++ b/Documentation/admin-guide/blockdev/zram.rst
@@ -54,7 +54,7 @@ The list of possible return codes:
 If you use 'echo', the returned value is set by the 'echo' utility,
 and, in general case, something like::
 
-	echo 3 > /sys/block/zram0/max_comp_streams
+	echo foo > /sys/block/zram0/comp_algorithm
 	if [ $? -ne 0 ]; then
 		handle_error
 	fi
@@ -73,21 +73,7 @@ This creates 4 devices: /dev/zram{0,1,2,3}
 num_devices parameter is optional and tells zram how many devices should be
 pre-created. Default: 1.
 
-2) Set max number of compression streams
-========================================
-
-Regardless of the value passed to this attribute, ZRAM will always
-allocate multiple compression streams - one per online CPU - thus
-allowing several concurrent compression operations. The number of
-allocated compression streams goes down when some of the CPUs
-become offline. There is no single-compression-stream mode anymore,
-unless you are running a UP system or have only 1 CPU online.
-
-To find out how many streams are currently available::
-
-	cat /sys/block/zram0/max_comp_streams
-
-3) Select compression algorithm
+2) Select compression algorithm
 ===============================
 
 Using comp_algorithm device attribute one can see available and
@@ -107,7 +93,7 @@ Examples::
 For the time being, the `comp_algorithm` content shows only compression
 algorithms that are supported by zram.
 
-4) Set compression algorithm parameters: Optional
+3) Set compression algorithm parameters: Optional
 =================================================
 
 Compression algorithms may support specific parameters which can be
@@ -138,7 +124,7 @@ better the compression ratio, it even can take negatives values for some
 algorithms), for other algorithms `level` is acceleration level (the higher
 the value the lower the compression ratio).
 
-5) Set Disksize
+4) Set Disksize
 ===============
 
 Set disk size by writing the value to sysfs node 'disksize'.
@@ -158,7 +144,7 @@ There is little point creating a zram of greater than twice the size of memory
 since we expect a 2:1 compression ratio. Note that zram uses about 0.1% of the
 size of the disk when not in use so a huge zram is wasteful.
 
-6) Set memory limit: Optional
+5) Set memory limit: Optional
 =============================
 
 Set memory limit by writing the value to sysfs node 'mem_limit'.
@@ -177,7 +163,7 @@ Examples::
 	# To disable memory limit
 	echo 0 > /sys/block/zram0/mem_limit
 
-7) Activate
+6) Activate
 ===========
 
 ::
@@ -188,7 +174,7 @@ Examples::
 	mkfs.ext4 /dev/zram1
 	mount /dev/zram1 /tmp
 
-8) Add/remove zram devices
+7) Add/remove zram devices
 ==========================
 
 zram provides a control interface, which enables dynamic (on-demand) device
@@ -208,7 +194,7 @@ execute::
 
 	echo X > /sys/class/zram-control/hot_remove
 
-9) Stats
+8) Stats
 ========
 
 Per-device statistics are exported as various nodes under /sys/block/zram<id>/
@@ -228,8 +214,6 @@ mem_limit         	WO	specifies the maximum amount of memory ZRAM can
 writeback_limit   	WO	specifies the maximum amount of write IO zram
 				can write out to backing device as 4KB unit
 writeback_limit_enable  RW	show and set writeback_limit feature
-max_comp_streams  	RW	the number of possible concurrent compress
-				operations
 comp_algorithm    	RW	show and change the compression algorithm
 algorithm_params	WO	setup compression algorithm parameters
 compact           	WO	trigger memory compaction
@@ -310,7 +294,7 @@ a single line of text and contains the following stats separated by whitespace:
 		Unit: 4K bytes
  ============== =============================================================
 
-10) Deactivate
+9) Deactivate
 ==============
 
 ::
@@ -318,7 +302,7 @@ a single line of text and contains the following stats separated by whitespace:
 	swapoff /dev/zram0
 	umount /dev/zram1
 
-11) Reset
+10) Reset
 =========
 
 	Write any positive value to 'reset' sysfs node::
diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index ff662144b98b..5f2c08337ba9 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1103,27 +1103,6 @@ static void zram_debugfs_register(struct zram *zram) {};
 static void zram_debugfs_unregister(struct zram *zram) {};
 #endif
 
-/*
- * We switched to per-cpu streams and this attr is not needed anymore.
- * However, we will keep it around for some time, because:
- * a) we may revert per-cpu streams in the future
- * b) it's visible to user space and we need to follow our 2 years
- *    retirement rule; but we already have a number of 'soon to be
- *    altered' attrs, so max_comp_streams need to wait for the next
- *    layoff cycle.
- */
-static ssize_t max_comp_streams_show(struct device *dev,
-		struct device_attribute *attr, char *buf)
-{
-	return scnprintf(buf, PAGE_SIZE, "%d\n", num_online_cpus());
-}
-
-static ssize_t max_comp_streams_store(struct device *dev,
-		struct device_attribute *attr, const char *buf, size_t len)
-{
-	return len;
-}
-
 static void comp_algorithm_set(struct zram *zram, u32 prio, const char *alg)
 {
 	/* Do not free statically defined compression algorithms */
@@ -2540,7 +2519,6 @@ static DEVICE_ATTR_WO(reset);
 static DEVICE_ATTR_WO(mem_limit);
 static DEVICE_ATTR_WO(mem_used_max);
 static DEVICE_ATTR_WO(idle);
-static DEVICE_ATTR_RW(max_comp_streams);
 static DEVICE_ATTR_RW(comp_algorithm);
 #ifdef CONFIG_ZRAM_WRITEBACK
 static DEVICE_ATTR_RW(backing_dev);
@@ -2562,7 +2540,6 @@ static struct attribute *zram_disk_attrs[] = {
 	&dev_attr_mem_limit.attr,
 	&dev_attr_mem_used_max.attr,
 	&dev_attr_idle.attr,
-	&dev_attr_max_comp_streams.attr,
 	&dev_attr_comp_algorithm.attr,
 #ifdef CONFIG_ZRAM_WRITEBACK
 	&dev_attr_backing_dev.attr,
-- 
2.48.1.658.g4767266eb4-goog


