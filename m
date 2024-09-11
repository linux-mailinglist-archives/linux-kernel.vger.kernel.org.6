Return-Path: <linux-kernel+bounces-324396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 081E0974BFE
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 10:02:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A0C21C213A9
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 08:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEABA13AD29;
	Wed, 11 Sep 2024 08:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TCjXZcFq"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E992143888
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 08:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726041707; cv=none; b=bZPVHe9FWYKSq1vBEZUuXsxvTUgJiOZP79dGacMUmRj4fpDfx6mU8kt0peCcbZEEzCZA+H+Wge6xBTFSTmPNSuxDX4iDrm3g3dVWpRp8iB5gYkCO8u2lScsiU1qBQXP3qj2EBuJBFgBUrMFB6TQvKh2gNlOF2gcxnohJoqYo6Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726041707; c=relaxed/simple;
	bh=mVkL7p64iZ9keq4GdB2NspvQm9i3kQpUaGhTZNUXJH4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jBfsP2sDbsa224eUca8bJ2dWVbsWPgV2LPTX27G2zxnWkMd/sqyEAS7q00BnrcDSy9ZGMz/BRpfDClucB0DhGatTaalLnz7DNecDXPy+YKk0vSfzTBNrcQkQHn83b48Sorz9gRZSgSiCmPyeOxa5kKJemXjrBN+MdYw5zVVXfqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=TCjXZcFq; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-206aee40676so53348445ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 01:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1726041705; x=1726646505; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9HLUCUcTOHEbZr3FT9+WxYtkzi909Grd+YuDams/I+k=;
        b=TCjXZcFqWfjazn4paZ2q9Y45YSescoYW1eYQ7EDFc+2n3Sj0OvCkAy3KFxsuAiBBKf
         S9uAvxDwKeEcSEVLN1Je+85P/mKcN9I1ZGd+6Tm18OB4dr7Vnna6CnV1CJlgiBI65P+Z
         hoEonHbUelJlF/0MFuiQnMK++trfZFUc8AJi8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726041705; x=1726646505;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9HLUCUcTOHEbZr3FT9+WxYtkzi909Grd+YuDams/I+k=;
        b=AmzezBvefxbFyjhVg63xLT9iHwtDR0KgAWzeDpMilmxVd7vIBuWLHdhiCcuRm/qKpP
         kXf5RuvR8evEZP+MWIM3spJ79xd58h7uArA6/z/JIsQ4trLVyMoOn6tw1Kw2bi0Vg4BS
         nOKz7S0XZT8KmR3dQJniCde8s6RpQtzK5sxONWZ7T4QmwZC3oUDeOlvKJuu/EMNZ9kOu
         ape8hZeH0IIleLMEC5tP17lbxXnNpZLtXn+9scMT8lv7kZnXL69Gmnh144Pd5KrCz3oh
         N+D5Z7N8LF5qgYLUBk/Z5DClLWltLutGwWywhw8TdPYxXwVAXCtcfMvEHfI6CXjIIEmW
         AlOQ==
X-Gm-Message-State: AOJu0Yw+Ntl/r4YWzn/VGv8ZlowZosTnne0wuLzMZGQOjYeysEaD5HAA
	QU4q2DUBaBscI3lh5zbh665naQaHNSgRKREZArqRkLxHslhe4QU+sFvpq+ycGw==
X-Google-Smtp-Source: AGHT+IH62pYvbyIT+lENT5afek1422rnWnAov5igigZqz3EY7Vnadfsgb3a2GqvWMmzG4o++Gd/kNA==
X-Received: by 2002:a17:903:11d2:b0:206:9536:9778 with SMTP id d9443c01a7336-2074c5d3daamr45477825ad.19.1726041704734;
        Wed, 11 Sep 2024 01:01:44 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:d828:3442:b431:2762])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20710e37922sm58737795ad.110.2024.09.11.01.01.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 01:01:44 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv3 2/6] zram: permit only one post-processing operation at a time
Date: Wed, 11 Sep 2024 17:01:10 +0900
Message-ID: <20240911080130.3766632-3-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.46.0.598.g6f2099f65c-goog
In-Reply-To: <20240911080130.3766632-1-senozhatsky@chromium.org>
References: <20240911080130.3766632-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Both recompress and writeback soon will unlock slots
during processing, which makes things too complex wrt
possible race-conditions.  We still want to clear PP_SLOT
in slot_free, because this is how we figure out that
slot that was selected for post-processing has been
released under us and when we start post-processing we
check if slot still has PP_SLOT set.  At the same time,
theoretically, we can have something like this:

CPU0			    CPU1

recompress
scan slots
set PP_SLOT
unlock slot
			slot_free
			clear PP_SLOT

			allocate PP_SLOT
			writeback
			scan slots
			set PP_SLOT
			unlock slot
select PP-slot
test PP_SLOT

So recompress will not detect that slot has been re-used
and re-selected for concurrent writeback post-processing.

Make sure that we only permit on post-processing operation
at a time.  So now recompress and writeback post-processing
don't race against each other, we only need to handle slot
re-use (slot_free and write), which is handled individually
by each pp operation.

Having recompress and writeback competing for the same slots
is not exactly good anyway (can't imagine anyone doing that).

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 Documentation/admin-guide/blockdev/zram.rst |  2 ++
 drivers/block/zram/zram_drv.c               | 16 ++++++++++++++++
 drivers/block/zram/zram_drv.h               |  1 +
 3 files changed, 19 insertions(+)

diff --git a/Documentation/admin-guide/blockdev/zram.rst b/Documentation/admin-guide/blockdev/zram.rst
index 678d70d6e1c3..714a5171bfc0 100644
--- a/Documentation/admin-guide/blockdev/zram.rst
+++ b/Documentation/admin-guide/blockdev/zram.rst
@@ -47,6 +47,8 @@ The list of possible return codes:
 -ENOMEM	  zram was not able to allocate enough memory to fulfil your
 	  needs.
 -EINVAL	  invalid input has been provided.
+-EAGAIN	  re-try operation later (e.g. when attempting to run recompress
+	  and writeback simultaneously).
 ========  =============================================================
 
 If you use 'echo', the returned value is set by the 'echo' utility,
diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index d170bf6cdcd8..c2fa6d3b2183 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -627,6 +627,12 @@ static ssize_t writeback_store(struct device *dev,
 		goto release_init_lock;
 	}
 
+	/* Do not permit concurrent post-processing actions. */
+	if (atomic_xchg(&zram->pp_in_progress, 1)) {
+		ret = -EAGAIN;
+		goto release_init_lock;
+	}
+
 	if (!zram->backing_dev) {
 		ret = -ENODEV;
 		goto release_init_lock;
@@ -753,6 +759,7 @@ static ssize_t writeback_store(struct device *dev,
 		free_block_bdev(zram, blk_idx);
 	__free_page(page);
 release_init_lock:
+	atomic_set(&zram->pp_in_progress, 0);
 	up_read(&zram->init_lock);
 
 	return ret;
@@ -1883,6 +1890,12 @@ static ssize_t recompress_store(struct device *dev,
 		goto release_init_lock;
 	}
 
+	/* Do not permit concurrent post-processing actions. */
+	if (atomic_xchg(&zram->pp_in_progress, 1)) {
+		ret = -EAGAIN;
+		goto release_init_lock;
+	}
+
 	if (algo) {
 		bool found = false;
 
@@ -1950,6 +1963,7 @@ static ssize_t recompress_store(struct device *dev,
 	__free_page(page);
 
 release_init_lock:
+	atomic_set(&zram->pp_in_progress, 0);
 	up_read(&zram->init_lock);
 	return ret;
 }
@@ -2146,6 +2160,7 @@ static void zram_reset_device(struct zram *zram)
 	zram->disksize = 0;
 	zram_destroy_comps(zram);
 	memset(&zram->stats, 0, sizeof(zram->stats));
+	atomic_set(&zram->pp_in_progress, 0);
 	reset_bdev(zram);
 
 	comp_algorithm_set(zram, ZRAM_PRIMARY_COMP, default_compressor);
@@ -2383,6 +2398,7 @@ static int zram_add(void)
 	zram->disk->fops = &zram_devops;
 	zram->disk->private_data = zram;
 	snprintf(zram->disk->disk_name, 16, "zram%d", device_id);
+	atomic_set(&zram->pp_in_progress, 0);
 
 	/* Actual capacity set using sysfs (/sys/block/zram<id>/disksize */
 	set_capacity(zram->disk, 0);
diff --git a/drivers/block/zram/zram_drv.h b/drivers/block/zram/zram_drv.h
index 914cb6629969..73a9d47d76ba 100644
--- a/drivers/block/zram/zram_drv.h
+++ b/drivers/block/zram/zram_drv.h
@@ -140,5 +140,6 @@ struct zram {
 #ifdef CONFIG_ZRAM_MEMORY_TRACKING
 	struct dentry *debugfs_dir;
 #endif
+	atomic_t pp_in_progress;
 };
 #endif
-- 
2.46.0.598.g6f2099f65c-goog


