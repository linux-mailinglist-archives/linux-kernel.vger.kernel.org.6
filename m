Return-Path: <linux-kernel+bounces-573220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F05F9A6D468
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 07:50:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 269DE3AD3C6
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 06:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5513A204876;
	Mon, 24 Mar 2025 06:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bHi0JjS3"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78AFD202C22
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 06:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742799044; cv=none; b=V03sUTZfXrJAn5fIooqgJMXa6cnsPmRwKuAAzq1v1vtTA7HTGrtMfoZYHcQesatEMPJ5BqbytASU0Rbs/0MvLPTx4SZK4Q9RV9LZ1aIJb1XsNbrX7Ub0aadIjbEcclA8WSvIq8XrkG/Gsk9FKBUDqQ/9jdgBSNWpqV7aU+NI9Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742799044; c=relaxed/simple;
	bh=M09LmhIqIlIyginCsSvh/BagsZ9bVjN34vx92jzU2hY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pHjJ7lChlB3oHf0AxUHT/kWP6ldCA/HL9Ik8dgPiXMiiXF3eavhDmU2c9Tj0w29LdCi4OiQASsZ6H6aekvtV8DFUDe38AwRoWnyNEMXw5U9KO/8LYgwIjayLN2ho7KO0uzUbsImOO0AfeVBWm4lPbkor1PfNyb92ijN0rUsKem4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=bHi0JjS3; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2ff80290e44so8224036a91.0
        for <linux-kernel@vger.kernel.org>; Sun, 23 Mar 2025 23:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1742799042; x=1743403842; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LLL+9DMmaVUqwscH1bkBTLnfJnHgTU+E8Jec+bX8fVQ=;
        b=bHi0JjS35zstmE0EQDyLM6CvsbTA+vY+xA/pjgl/GZMb+80wbV3neTJs+PeFjfic4+
         2br6ErlyD/kD7cvyeg45QThlAgeI+0riMuvefg/uejZNtMsRr4tHFjeGUu0dInXCPX9H
         fyIGJp+lftORWgSLz4H8GarCOYbWcc90SUdqw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742799042; x=1743403842;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LLL+9DMmaVUqwscH1bkBTLnfJnHgTU+E8Jec+bX8fVQ=;
        b=tOR+Fz3r6UOKpw/oOD+mhVuS7bQHOUhLdjYsfDJPRnxYvrpcHVBKE6D5aIGKAjo5kP
         hHiS2f73gDUcuu3g5ZOFVWwAIjJwWYm15hnu4t4MLmKHiIvsWtmezQXSktkrWlvrzz46
         JCR3plNrierBrV4at/D/RORW8ft/8YnN+4pYLEE3sSFrAawyAPpsUilivZrukgroRfE4
         bmRF8xwe7omEg6MUEi58FmSxYWL+5kcXR1AHkOBuVGItb1P7oAxHTx+ELj3y5HaN0g/a
         Kqi55DZQaeRE6MHwXlcy44iwGWVMUdvRPPT2YDGLM/OcNXLblyDKWR3PsqPCG0kVkrD7
         fUEw==
X-Forwarded-Encrypted: i=1; AJvYcCW2iAUEMJYHOujNvjBpgWrAd54ZNax1VSkaDytUEVadWZIEb1CcllNYPYB/NDBcG5YPPAfXYq33tCEUeiA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxk5hdrLTy8hBIFPfwqaULKHD/svBNIUE1h5Qpxwbd3MXXjFuFK
	cEqfC/bQKsMPv/g+FO9uF92NplsgPMl2iCR0vmeY/I9BM4V2sq676ykfH4wlMQ==
X-Gm-Gg: ASbGncuvsZUsph13l2RIA1WYnBrgYxYy0rqIK949M5RK8unQPSkgTqD02d8LB+XQdHe
	oMgse8zfAsPbdfW8XUFeuRUS+J+NI94RPWANc77HR+qzOzeJqOOq4Hn1tz9bducQIuI4ZS8c+ld
	vOezEpyNNCvklVd/lY2a5zpFGbyOGfdghYJv9mJqB2ylhqgxsEHYRL7a8ADibyyXPACwQjNM8VG
	rDXcDYFp0KFI4W8cHdavNsGVJXYGB3PUD3n4t8wOESFG+uIi/eLQnM8wiZbSPgxmL5xAj5Eu08m
	nSEgTkgbh5b/skUbHQ5jGR1exyvMtUZ+M3FGpXGRuJUm+JrbaCXB0fFpYh1Q2QeDrwBGD5w=
X-Google-Smtp-Source: AGHT+IGGlsqYLSJ+JbPuzVrZ5UsBm7u6btr3xvOBimzw90wo4bRNTekWhe+qlA6m4iUPxdSuobgV8w==
X-Received: by 2002:a17:90b:1f86:b0:2ee:c91a:acf7 with SMTP id 98e67ed59e1d1-3030fe856d7mr18173815a91.4.1742799041532;
        Sun, 23 Mar 2025 23:50:41 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:f38f:d38c:cfee:a113])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3030f5d22dcsm7238535a91.12.2025.03.23.23.50.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Mar 2025 23:50:40 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>,
	Brian Geffon <bgeffon@google.com>
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [RFC PATCH] zram: introduce writeback_ext interface
Date: Mon, 24 Mar 2025 15:45:41 +0900
Message-ID: <20250324065029.3077450-1-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

writeback_ext is going to replace the existing writeback interface in
the future.  For starters writeback_ext extends page writeback with
page indices ranges.  The legacy interface can write only one page at
a time:

    echo page_index=100 > zram0/writeback
    ...
    echo page_index=200 > zram0/writeback
    echo page_index=500 > zram0/writeback
    ...
    echo page_index=700 > zram0/writeback

One obvious downside is that it increases the number of syscalls.
Less obvious but significantly more important downside is that when
given only one page to post-process zram cannot perform an optimal
target selection.  This becomes critical when writeback_limit is
enabled, because under writeback_limit we want to guarantee the
highest memory savings.  The new interface supports multiple page
indices ranges in a single call:

    echo page_index_range=100-200 \
 	 page_index_range=500-700 > zram0/writeback_ext

This gives zram a chance to apply an optimal target selection
strategy on each iteration of the writeback loop.

Apart from that the new file unifies parameters passing and
resembles other "modern" zram device attributes (e.g. recompression),
while the old interface used a mixed scheme: values-less parameters
for mode and a key=value format for page_index.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---


Alternatively I can just extend writeback and say something like
"starting from 6.16 it also accepts indices ranges" in zram's
documentation.


 Documentation/ABI/testing/sysfs-block-zram  |   8 +
 Documentation/admin-guide/blockdev/zram.rst |  26 ++
 drivers/block/zram/zram_drv.c               | 332 +++++++++++++-------
 3 files changed, 261 insertions(+), 105 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-block-zram b/Documentation/ABI/testing/sysfs-block-zram
index 36c57de0a10a..17b43bba57ab 100644
--- a/Documentation/ABI/testing/sysfs-block-zram
+++ b/Documentation/ABI/testing/sysfs-block-zram
@@ -105,6 +105,7 @@ Contact:	Minchan Kim <minchan@kernel.org>
 Description:
 		The writeback file is write-only and trigger idle and/or
 		huge page writeback to backing device.
+		This file is deprecated, please use writeback_ext.
 
 What:		/sys/block/zram<id>/bd_stat
 Date:		November 2018
@@ -150,3 +151,10 @@ Contact:	Sergey Senozhatsky <senozhatsky@chromium.org>
 Description:
 		The algorithm_params file is write-only and is used to setup
 		compression algorithm parameters.
+
+What:		/sys/block/zram<id>/writeback_ext
+Date:		March 2025
+Contact:	Sergey Senozhatsky <senozhatsky@chromium.org>
+Description:
+		The writeback_ext file is write-only and is used for extended
+		writeabck (e.g. a writeback of page index ranges.)
diff --git a/Documentation/admin-guide/blockdev/zram.rst b/Documentation/admin-guide/blockdev/zram.rst
index 9bdb30901a93..6571891d033a 100644
--- a/Documentation/admin-guide/blockdev/zram.rst
+++ b/Documentation/admin-guide/blockdev/zram.rst
@@ -320,6 +320,9 @@ Optional Feature
 writeback
 ---------
 
+Note that `/sys/block/zramX/writeback` is considered deprecated
+and is superseded by `/sys/block/zramX/writeback_ext`.
+
 With CONFIG_ZRAM_WRITEBACK, zram can write idle/incompressible page
 to backing storage rather than keeping it in memory.
 To use the feature, admin should set up backing device via::
@@ -417,6 +420,29 @@ budget in next setting is user's job.
 If admin wants to measure writeback count in a certain period, they could
 know it via /sys/block/zram0/bd_stat's 3rd column.
 
+writeback_ext
+-------------
+
+This interface is expected to replace writeback interface in the future.
+There are several key differences.
+
+First, this interface switches to `key=value` format for all parameters,
+which simplifies future extension. For example, in order to writeback all
+huge pages the writeback type now needs to be specified using `type=`
+parameter::
+
+	echo "type=huge" > /sys/block/zramX/writeback_ext
+
+Second, this interface supports `page_index_range` parameters (multiple
+ranges can be provided at once), which specify `LOW-HIGH` ranges of pages
+to be written-back.  This reduces the number of syscalls, but more
+importantly this enables optimal post-processing target selection strategy.
+Usage example::
+
+	echo "page_index_range=1-100" > /sys/block/zramX/writeback_ext
+
+The rest (writeback_limit, etc.) remains the same.
+
 recompression
 -------------
 
diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index fda7d8624889..7d9a6332a189 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -734,114 +734,19 @@ static void read_from_bdev_async(struct zram *zram, struct page *page,
 	submit_bio(bio);
 }
 
-#define PAGE_WB_SIG "page_index="
-
-#define PAGE_WRITEBACK			0
-#define HUGE_WRITEBACK			(1<<0)
-#define IDLE_WRITEBACK			(1<<1)
-#define INCOMPRESSIBLE_WRITEBACK	(1<<2)
-
-static int scan_slots_for_writeback(struct zram *zram, u32 mode,
-				    unsigned long nr_pages,
-				    unsigned long index,
-				    struct zram_pp_ctl *ctl)
-{
-	for (; nr_pages != 0; index++, nr_pages--) {
-		bool ok = true;
-
-		zram_slot_lock(zram, index);
-		if (!zram_allocated(zram, index))
-			goto next;
-
-		if (zram_test_flag(zram, index, ZRAM_WB) ||
-		    zram_test_flag(zram, index, ZRAM_SAME))
-			goto next;
-
-		if (mode & IDLE_WRITEBACK &&
-		    !zram_test_flag(zram, index, ZRAM_IDLE))
-			goto next;
-		if (mode & HUGE_WRITEBACK &&
-		    !zram_test_flag(zram, index, ZRAM_HUGE))
-			goto next;
-		if (mode & INCOMPRESSIBLE_WRITEBACK &&
-		    !zram_test_flag(zram, index, ZRAM_INCOMPRESSIBLE))
-			goto next;
-
-		ok = place_pp_slot(zram, ctl, index);
-next:
-		zram_slot_unlock(zram, index);
-		if (!ok)
-			break;
-	}
-
-	return 0;
-}
-
-static ssize_t writeback_store(struct device *dev,
-		struct device_attribute *attr, const char *buf, size_t len)
+static int zram_writeback_slots(struct zram *zram, struct zram_pp_ctl *ctl)
 {
-	struct zram *zram = dev_to_zram(dev);
-	unsigned long nr_pages = zram->disksize >> PAGE_SHIFT;
-	struct zram_pp_ctl *ctl = NULL;
+	unsigned long blk_idx = 0;
+	struct page *page = NULL;
 	struct zram_pp_slot *pps;
-	unsigned long index = 0;
-	struct bio bio;
 	struct bio_vec bio_vec;
-	struct page *page = NULL;
-	ssize_t ret = len;
-	int mode, err;
-	unsigned long blk_idx = 0;
-
-	if (sysfs_streq(buf, "idle"))
-		mode = IDLE_WRITEBACK;
-	else if (sysfs_streq(buf, "huge"))
-		mode = HUGE_WRITEBACK;
-	else if (sysfs_streq(buf, "huge_idle"))
-		mode = IDLE_WRITEBACK | HUGE_WRITEBACK;
-	else if (sysfs_streq(buf, "incompressible"))
-		mode = INCOMPRESSIBLE_WRITEBACK;
-	else {
-		if (strncmp(buf, PAGE_WB_SIG, sizeof(PAGE_WB_SIG) - 1))
-			return -EINVAL;
-
-		if (kstrtol(buf + sizeof(PAGE_WB_SIG) - 1, 10, &index) ||
-				index >= nr_pages)
-			return -EINVAL;
-
-		nr_pages = 1;
-		mode = PAGE_WRITEBACK;
-	}
-
-	down_read(&zram->init_lock);
-	if (!init_done(zram)) {
-		ret = -EINVAL;
-		goto release_init_lock;
-	}
-
-	/* Do not permit concurrent post-processing actions. */
-	if (atomic_xchg(&zram->pp_in_progress, 1)) {
-		up_read(&zram->init_lock);
-		return -EAGAIN;
-	}
-
-	if (!zram->backing_dev) {
-		ret = -ENODEV;
-		goto release_init_lock;
-	}
+	struct bio bio;
+	int ret, err;
+	u32 index;
 
 	page = alloc_page(GFP_KERNEL);
-	if (!page) {
-		ret = -ENOMEM;
-		goto release_init_lock;
-	}
-
-	ctl = init_pp_ctl();
-	if (!ctl) {
-		ret = -ENOMEM;
-		goto release_init_lock;
-	}
-
-	scan_slots_for_writeback(zram, mode, nr_pages, index, ctl);
+	if (!page)
+		return -ENOMEM;
 
 	while ((pps = select_pp_slot(ctl))) {
 		spin_lock(&zram->wb_limit_lock);
@@ -929,10 +834,217 @@ static ssize_t writeback_store(struct device *dev,
 
 	if (blk_idx)
 		free_block_bdev(zram, blk_idx);
-
-release_init_lock:
 	if (page)
 		__free_page(page);
+
+	return ret;
+}
+
+#define PAGE_WRITEBACK			0
+#define HUGE_WRITEBACK			(1 << 0)
+#define IDLE_WRITEBACK			(1 << 1)
+#define INCOMPRESSIBLE_WRITEBACK	(1 << 2)
+
+static int parse_page_index(char *val, unsigned long nr_pages,
+			    unsigned long *lo, unsigned long *hi)
+{
+	int ret;
+
+	ret = kstrtoul(val, 10, lo);
+	if (ret)
+		return ret;
+	*hi = *lo + 1;
+	if (*lo >= nr_pages || *hi > nr_pages)
+		return -ERANGE;
+	return 0;
+}
+
+static int parse_page_index_range(char *val, unsigned long nr_pages,
+				  unsigned long *lo, unsigned long *hi)
+{
+	char *delim;
+	int ret;
+
+	delim = strchr(val, '-');
+	if (!delim)
+		return -EINVAL;
+
+	*delim = 0x00;
+	ret = kstrtoul(val, 10, lo);
+	if (ret)
+		return ret;
+	if (*lo >= nr_pages)
+		return -ERANGE;
+
+	ret = kstrtoul(delim + 1, 10, hi);
+	if (ret)
+		return ret;
+	if (*hi >= nr_pages || *lo > *hi)
+		return -ERANGE;
+	*hi += 1;
+	return 0;
+}
+
+static int parse_mode(char *val, u32 *mode)
+{
+	*mode = 0;
+
+	if (!strcmp(val, "idle"))
+		*mode = IDLE_WRITEBACK;
+	if (!strcmp(val, "huge"))
+		*mode = HUGE_WRITEBACK;
+	if (!strcmp(val, "huge_idle"))
+		*mode = IDLE_WRITEBACK | HUGE_WRITEBACK;
+	if (!strcmp(val, "incompressible"))
+		*mode = INCOMPRESSIBLE_WRITEBACK;
+
+	if (*mode == 0)
+		return -EINVAL;
+	return 0;
+}
+
+static int scan_slots_for_writeback(struct zram *zram, u32 mode,
+				    unsigned long lo, unsigned long hi,
+				    struct zram_pp_ctl *ctl)
+{
+	u32 index = lo;
+
+	while (index < hi) {
+		bool ok = true;
+
+		zram_slot_lock(zram, index);
+		if (!zram_allocated(zram, index))
+			goto next;
+
+		if (zram_test_flag(zram, index, ZRAM_WB) ||
+		    zram_test_flag(zram, index, ZRAM_SAME))
+			goto next;
+
+		if (mode & IDLE_WRITEBACK &&
+		    !zram_test_flag(zram, index, ZRAM_IDLE))
+			goto next;
+		if (mode & HUGE_WRITEBACK &&
+		    !zram_test_flag(zram, index, ZRAM_HUGE))
+			goto next;
+		if (mode & INCOMPRESSIBLE_WRITEBACK &&
+		    !zram_test_flag(zram, index, ZRAM_INCOMPRESSIBLE))
+			goto next;
+
+		ok = place_pp_slot(zram, ctl, index);
+next:
+		zram_slot_unlock(zram, index);
+		if (!ok)
+			break;
+		index++;
+	}
+
+	return 0;
+}
+
+static ssize_t writeback_ext_store(struct device *dev,
+				   struct device_attribute *attr,
+				   const char *buf, size_t len)
+{
+	struct zram *zram = dev_to_zram(dev);
+	u64 nr_pages = zram->disksize >> PAGE_SHIFT;
+	unsigned long lo = 0, hi = nr_pages;
+	struct zram_pp_ctl *ctl = NULL;
+	char *args, *param, *val;
+	ssize_t ret = len;
+	int err, mode = 0;
+
+	down_read(&zram->init_lock);
+	if (!init_done(zram)) {
+		up_read(&zram->init_lock);
+		return -EINVAL;
+	}
+
+	/* Do not permit concurrent post-processing actions. */
+	if (atomic_xchg(&zram->pp_in_progress, 1)) {
+		up_read(&zram->init_lock);
+		return -EAGAIN;
+	}
+
+	if (!zram->backing_dev) {
+		ret = -ENODEV;
+		goto release_init_lock;
+	}
+
+	ctl = init_pp_ctl();
+	if (!ctl) {
+		ret = -ENOMEM;
+		goto release_init_lock;
+	}
+
+	args = skip_spaces(buf);
+	while (*args) {
+		args = next_arg(args, &param, &val);
+
+		/*
+		 * Workaround to support the old writeback interface. Will be
+		 * reworked once the (deprecated) writeback interface is gone.
+		 *
+		 * The old writeback interface has a minor inconsistency and
+		 * requires key=value only for page_index parameter, while
+		 * writeback mode is a valueless parameter.
+		 *
+		 * This is not the case anymore and now all parameters are
+		 * required to have values, however, we need to support the
+		 * legacy writeback interface that's why we check if we can
+		 * recognize a valueless parameter as a (legacy) writeback
+		 * mode.
+		 */
+		if (!val || !*val) {
+			err = parse_mode(param, &mode);
+			if (err) {
+				ret = err;
+				goto release_init_lock;
+			}
+
+			scan_slots_for_writeback(zram, mode, lo, hi, ctl);
+			break;
+		}
+
+		if (!strcmp(param, "type")) {
+			err = parse_mode(val, &mode);
+			if (err) {
+				ret = err;
+				goto release_init_lock;
+			}
+
+			scan_slots_for_writeback(zram, mode, lo, hi, ctl);
+			break;
+		}
+
+		if (!strcmp(param, "page_index")) {
+			err = parse_page_index(val, nr_pages, &lo, &hi);
+			if (err) {
+				ret = err;
+				goto release_init_lock;
+			}
+
+			scan_slots_for_writeback(zram, mode, lo, hi, ctl);
+			break;
+		}
+
+		/* There can be several page index ranges */
+		if (!strcmp(param, "page_index_range")) {
+			err = parse_page_index_range(val, nr_pages, &lo, &hi);
+			if (err) {
+				ret = err;
+				goto release_init_lock;
+			}
+
+			scan_slots_for_writeback(zram, mode, lo, hi, ctl);
+			continue;
+		}
+	}
+
+	err = zram_writeback_slots(zram, ctl);
+	if (err)
+		ret = err;
+
+release_init_lock:
 	release_pp_ctl(zram, ctl);
 	atomic_set(&zram->pp_in_progress, 0);
 	up_read(&zram->init_lock);
@@ -940,6 +1052,14 @@ static ssize_t writeback_store(struct device *dev,
 	return ret;
 }
 
+static ssize_t writeback_store(struct device *dev,
+			       struct device_attribute *attr,
+			       const char *buf, size_t len)
+{
+	pr_info_once("deprecated attr: consider using writeback_ext\n");
+	return writeback_ext_store(dev, attr, buf, len);
+}
+
 struct zram_work {
 	struct work_struct work;
 	struct zram *zram;
@@ -2490,6 +2610,7 @@ static DEVICE_ATTR_RW(backing_dev);
 static DEVICE_ATTR_WO(writeback);
 static DEVICE_ATTR_RW(writeback_limit);
 static DEVICE_ATTR_RW(writeback_limit_enable);
+static DEVICE_ATTR_WO(writeback_ext);
 #endif
 #ifdef CONFIG_ZRAM_MULTI_COMP
 static DEVICE_ATTR_RW(recomp_algorithm);
@@ -2511,6 +2632,7 @@ static struct attribute *zram_disk_attrs[] = {
 	&dev_attr_writeback.attr,
 	&dev_attr_writeback_limit.attr,
 	&dev_attr_writeback_limit_enable.attr,
+	&dev_attr_writeback_ext.attr,
 #endif
 	&dev_attr_io_stat.attr,
 	&dev_attr_mm_stat.attr,
-- 
2.49.0.395.g12beb8f557-goog


