Return-Path: <linux-kernel+bounces-514351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4195CA355E4
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 05:53:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EAF51891D32
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 04:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFC4B22092;
	Fri, 14 Feb 2025 04:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Qpdm3v2m"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55280186284
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 04:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739508764; cv=none; b=PENSL68pG8nd+gdPKuj2EM8+sv1vGNVDKC8qr+s5XhJTjthGtdUH6SX5MnqZA3pg3cuZrF09J6gSNOakVSzfAJC2xwzxrmBPpNh4hux1dISpRorDWPHo9QC5wOsDyImjnWssZjmb6/OCFn19/MYgmnYECTtL2kdzIKCYeT3Idmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739508764; c=relaxed/simple;
	bh=5psVqs0h4asKQIjI/bLFrSEEINcrkLgrQXk/4LDvZDc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L9iAaFt57oq5UOqiSwlW9674J/g2c7KRpY2Dx30unbBly4niGV4+BslzZUYEbtSM0BFtbSM5GYvW9RcccCxPi32ksEDctC08bn/WHQ0fxvnQ9fFpu8EejhnjuoID3MKtKQtrRT9HMep/j8Bgy9hl32jWbO71OKphl5P8xKv7yWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Qpdm3v2m; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-21f44e7eae4so30059325ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 20:52:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1739508762; x=1740113562; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N0yPBZnADO0X5Vq2D3cbKq9jy8e5O0FW3A6DJipxArU=;
        b=Qpdm3v2mTss7BDmfe4/9YGiWI9ZWySIjPRTLCbpxdB/dewEkrt/JlPEp7ANjIXuhZH
         9nXdOB0n+Byj6Bzn1D8AbbAmqSVLr18NCmODJURjcj5aHw3NZyaeVKM6z2wx9aHYkn++
         M0pb7QOVX3ATcpVC4yz92EPEGsANC9fM8qdYU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739508762; x=1740113562;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N0yPBZnADO0X5Vq2D3cbKq9jy8e5O0FW3A6DJipxArU=;
        b=WLyAmFYZ2EI04LAHX6EWLfcaGg7nNnP7/Zn8DvkBBUy3BfLke5mseRw7rcAvclCnPJ
         PePMyBTCc4xyXkEBqr1BeSeGZmJuVfGzYWc6au/XiHCYTyeW1s31sO9GC9miTLNUyhyl
         1z6ODFzmLM8ZfkNnGgI+pQ4qwNjoPFj+VjzJRD6GX6iYvGcUsgcULZmJ1JxI2kP4LGnz
         WQSbvnLbKfLAM+pyb1NjKpFdya7HqXlzcXIOjIGNyr74OrnHFNEpS/Bl6UUBvlh4H51q
         2GMew43hiIklaxbNnnRCcerofjA53d9Cx5ZAajxhRMK86XNC/ktnIeSd28KdsHGygv/2
         kz+w==
X-Forwarded-Encrypted: i=1; AJvYcCUZTzMxUIeKSB84fLX91XM8jM/WjXGyj4bVG1rdmLb0Hjt6DRus7ZW5WyyYmo/vzrq5yUgLdO2Jeo24VUQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeRufCJTEGCb2fUybuR3USkz9XL5VWWOJ/R0msUr7uHnZQAeO+
	LP3s5jAw5aPBhty2Mip1UI8bZg2H4kEr5wwxZsk4XqbCvwupESUEixaUUESaIQ==
X-Gm-Gg: ASbGncsyovnOjcI2K4+cqj2eXB8RV26RPIEHU0sO/QYgx8IxENwVzStbIFsXR2aTS5T
	77Vm2oUgWwPemhOzltRl7fyAW5awfY5G21nv+0cWJiTvSFXKE9gNVpv4dJETFosHYMWgKANL0Fp
	rni0Sz6UMgfSwaWSt7KLhbejQTSxmnFcFUNNV1FcVSFXQ0jBsH8EWNcChPVJZa7uGz6vcaJHMRA
	x907u2pP+x9ml/oS8FPZIKum2zY58umT21fN+ncB+aG52oelrLIlHN1P1o0CL7OENzfU+6cupo/
	Zp9lPp70vwb1DogrOQ==
X-Google-Smtp-Source: AGHT+IE0+HWw32m7Iz+CmsIdF7+EuP5uBVLXDu0uGMgAdMpaEB0vwPlOHOUHVWWjUpawD6FafZNm6g==
X-Received: by 2002:a17:903:1ca:b0:220:d257:cdbd with SMTP id d9443c01a7336-220d257ce68mr96793445ad.48.1739508761612;
        Thu, 13 Feb 2025 20:52:41 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:942d:9291:22aa:8126])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-220d545d474sm20667535ad.116.2025.02.13.20.52.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Feb 2025 20:52:41 -0800 (PST)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Yosry Ahmed <yosry.ahmed@linux.dev>,
	Hillf Danton <hdanton@sina.com>,
	Kairui Song <ryncsn@gmail.com>,
	Minchan Kim <minchan@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH v6 04/17] zram: remove max_comp_streams device attr
Date: Fri, 14 Feb 2025 13:50:16 +0900
Message-ID: <20250214045208.1388854-5-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
In-Reply-To: <20250214045208.1388854-1-senozhatsky@chromium.org>
References: <20250214045208.1388854-1-senozhatsky@chromium.org>
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
index 1576fb93f06c..9bdb30901a93 100644
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
index 0c8821b2b2d9..cc4afa01b281 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1146,27 +1146,6 @@ static void zram_debugfs_register(struct zram *zram) {};
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
@@ -2583,7 +2562,6 @@ static DEVICE_ATTR_WO(reset);
 static DEVICE_ATTR_WO(mem_limit);
 static DEVICE_ATTR_WO(mem_used_max);
 static DEVICE_ATTR_WO(idle);
-static DEVICE_ATTR_RW(max_comp_streams);
 static DEVICE_ATTR_RW(comp_algorithm);
 #ifdef CONFIG_ZRAM_WRITEBACK
 static DEVICE_ATTR_RW(backing_dev);
@@ -2605,7 +2583,6 @@ static struct attribute *zram_disk_attrs[] = {
 	&dev_attr_mem_limit.attr,
 	&dev_attr_mem_used_max.attr,
 	&dev_attr_idle.attr,
-	&dev_attr_max_comp_streams.attr,
 	&dev_attr_comp_algorithm.attr,
 #ifdef CONFIG_ZRAM_WRITEBACK
 	&dev_attr_backing_dev.attr,
-- 
2.48.1.601.g30ceb7b040-goog


