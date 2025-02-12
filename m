Return-Path: <linux-kernel+bounces-510570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9A34A31EFA
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 07:33:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 519091661EC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 06:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3BB11FBCAD;
	Wed, 12 Feb 2025 06:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fqZ2zMxc"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638091FF1AF
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 06:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739341945; cv=none; b=WIsrSgoWCbBdgM6tWQca3oHmSR6wMjUwaLQG6Xw3iIh4X3rG4kH5TtStwde1Vu61C601OaA2muyNYUYw1swvCHcFWeov6GQUHLaDreGAFmWQzUC2sWd2vahU6NdmCzMpYCanfFvnaZzee58H4gr4QxPw7KKjxWKH96qQpzG3vdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739341945; c=relaxed/simple;
	bh=XskcwS482bSYecJNApb530j9dirKULlpuwXW4GKTrhI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I7B3cJcXoen7Ovn6wdc5HWrZIqAG4XP9u8EGQaQFycg3II+MEPRhMyuR8Trojfa/bV9V27OQIyBiZ20cu72sgZE22NsNmBh1WvDlK3qcVRkVA4OD/pgihgBPi5FkMA89UhcUZZfEThX4WDJTAKTYfk5j3BP07fw/M4ARMSUqdzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=fqZ2zMxc; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-21f61b01630so7532355ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2025 22:32:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1739341942; x=1739946742; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h2AQA5cUglzG6yhVm3aKj+975OMRekO7mg4bKTRqdCs=;
        b=fqZ2zMxcSxnq+hZyc3HER6NTxk+sFsjMtpjbyy7EFFiwRgh0jyMHTdPr0jaXp6sFaz
         XrT2/bJ9b/J/pHnSaoK45CesJgytcgViXmI6muqDPoy/AfhPM0cte6x5FJJM8e6qufGe
         Y762nI2WwedmFWH+fOAXXq+wVyneJx2enbPCU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739341942; x=1739946742;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h2AQA5cUglzG6yhVm3aKj+975OMRekO7mg4bKTRqdCs=;
        b=lWqO31seRhoCmXL3sxv66lpwIHxbWOFQV2HfASrikgDPFCXx8UMTtkJlgHzYaboJk0
         qsIvL+zBhu1rV+FvpopTIjA9XfrhMZL7QTOVCzqc4TZd4w15a+TGmvxzjfAOjGZA0ZS6
         /+IVokm0+lSNsXOHrHr/1Xph77PcAFK1bJajb81qA3fyP2x18GIB1PyLR2kjNDzaZuxi
         b9ewOoB4drfxeaYPRc3morviE/CLH/F37ZUEGxlFeNixqVqoqmivw5QIFEhl5B63IjXA
         VDvkTKzGk+CiywYjJsiHXKsEhgY0Kb7dppWdcGXhrGS0p4REgPfnu/ouoLEJUucxUJ2g
         u/AQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxR4qjAsVh1HJRmKJm+//8VLDz2cn0QjX7YujsloGVrXJ3GyjmoEtsE/dTURdR54OXj2U5/ipSXy40cmc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxmi9TFtf9DNQE4/jELZ3XPVMOaRV34mv+oUlWXRBMlBgD1oamu
	2+n8S4WjROpGUGT2V+AFI1TKvXMBW6zDhabXdckRY08LTU1hi5WqVu+YME/ofA==
X-Gm-Gg: ASbGnctP3pEVyXJBbgGRuJFCeeZm9+PDh8iO0b+AwbgyThQSGV+EtqoIl2oNHjnbWml
	/d7TILwBf9g8a6cXq2TWlSIe6kGV3QoZeXi2TqgufIM0ORdyEbqjcVI4Q0WJqDpHaI4LHh0lYek
	lnlJb2SMqli5OAZOCOpc0enm+UVhu2SGH8g9/AKCeji5hPblu7hWte3cF04THMnQXA/x8yKgkhV
	JWX59FHJX1e+OVUqAEXP3QNr6+uzO13ipQ2Qt2lnEX0F7SJkre1aYI9PhicZ2GKVygDi0wPfFhr
	VXfNugWH5YgrfJq6Lw==
X-Google-Smtp-Source: AGHT+IFvCaT4j3C930RCMRawLzcITwesvr3FnYejPnLHFg8E648OUmGxFSWdbEBwV5fB9AnLznY3OA==
X-Received: by 2002:a05:6a21:398f:b0:1d9:a94:feec with SMTP id adf61e73a8af0-1ee5cea8113mr3339152637.2.1739341942625;
        Tue, 11 Feb 2025 22:32:22 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:69f5:6852:451e:8142])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-730918f6ec7sm4475974b3a.37.2025.02.11.22.32.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Feb 2025 22:32:22 -0800 (PST)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Yosry Ahmed <yosry.ahmed@linux.dev>,
	Kairui Song <ryncsn@gmail.com>,
	Minchan Kim <minchan@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH v5 04/18] zram: remove max_comp_streams device attr
Date: Wed, 12 Feb 2025 15:27:02 +0900
Message-ID: <20250212063153.179231-5-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.48.1.502.g6dc24dfdaf-goog
In-Reply-To: <20250212063153.179231-1-senozhatsky@chromium.org>
References: <20250212063153.179231-1-senozhatsky@chromium.org>
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
index 12fb260e3355..e0e64b2610d6 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1104,27 +1104,6 @@ static void zram_debugfs_register(struct zram *zram) {};
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
@@ -2541,7 +2520,6 @@ static DEVICE_ATTR_WO(reset);
 static DEVICE_ATTR_WO(mem_limit);
 static DEVICE_ATTR_WO(mem_used_max);
 static DEVICE_ATTR_WO(idle);
-static DEVICE_ATTR_RW(max_comp_streams);
 static DEVICE_ATTR_RW(comp_algorithm);
 #ifdef CONFIG_ZRAM_WRITEBACK
 static DEVICE_ATTR_RW(backing_dev);
@@ -2563,7 +2541,6 @@ static struct attribute *zram_disk_attrs[] = {
 	&dev_attr_mem_limit.attr,
 	&dev_attr_mem_used_max.attr,
 	&dev_attr_idle.attr,
-	&dev_attr_max_comp_streams.attr,
 	&dev_attr_comp_algorithm.attr,
 #ifdef CONFIG_ZRAM_WRITEBACK
 	&dev_attr_backing_dev.attr,
-- 
2.48.1.502.g6dc24dfdaf-goog


