Return-Path: <linux-kernel+bounces-326066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FCD5976217
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 09:04:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D5EE285433
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 07:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 131D818CC0F;
	Thu, 12 Sep 2024 07:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TGV4Zc/R"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9DF718C920
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 07:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726124670; cv=none; b=J2wLdeeknwq8BOATCKOhRisVitXNLbTB9b28B2CyDbpCllgBFbqwL85X4b3TRBNX3d/t5+FT7ge1guxbI/m7NPL78OzUjonA0Pxk0WGYLfb2+D4V1re1FwhFWKF6NHsnAVia6G/KfdbvM6vrS8aV4o5VHVbLLQ4G1ka69iMHKBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726124670; c=relaxed/simple;
	bh=tJIwMwWYOHuMMebMB2tQEB+hQA+Iobdc9qsuNS6ewxo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ks6rkAT3eukamEa2thhH3+OrQGARLBHWEnPiG9H4LcUxWWVvk0t960N4jD39R3dupAIQFzYAGQJESy7zSASmIGju0IjZRAMzm6nAMhpE1YW55Y1jfM67wUt+64NleQtDfkI/Az6grhI0cy0tV1rqp9D5nCyCooKYV82XfWu5lU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=TGV4Zc/R; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-71781f42f75so470251b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 00:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1726124668; x=1726729468; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ivRYctFtAHjZnxxMEveMODYRdfT+M4UTh4BuUvLN5kA=;
        b=TGV4Zc/R71zknBu7IEgmo1CvOoo3Tyr6Pv6F5eSUW6jP1cQBD0U6miBq5xwb424VhN
         gEREuYBi50qCG2Q989Y8pI6VU3mRV2Ego2mVbwmHCG6WXIgTEYT0hV+2Tm0lcMcCA8ua
         wvRbtHK/YmbDP1HTHBb8HrIgCBjyzcGzCASTM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726124668; x=1726729468;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ivRYctFtAHjZnxxMEveMODYRdfT+M4UTh4BuUvLN5kA=;
        b=XX+GAnK8UEeRbAgWVsjR9nhWZVVJtSZnHwwDRu1Kt0XJrrCr/unkjPLzLcy7rAoOwl
         G4Qa+DZYm5j41ikn3TglfSIa/78+UDx5KMr3xCppI7O/dL2s0bPJl4iaIt0b6HwSXfTs
         SYdlPqSG8q2m61cEQQAvm7jGx2sp24G7JRh0tnu0/PFbo9YIVna0s8oD9wchaTUHqqBB
         V7P5ermD8MTwtEzGN6GcTOZtKt/wGaP6Lvp3vqTCr0n5bCBUgTFi3cMdS//jLhKLfKR0
         WFt813EcGLImr2G50nYH7MgSzKq1QQJg6fV0MvTLY/DRT+PAC2j5Q8YTYwhGrJeZZWVn
         YteQ==
X-Gm-Message-State: AOJu0YyD2tDc/VtRK6tTK/oVb+Gl4l7by+1agpxc0CF1JKgcAEPy+QKx
	E40qcaS8A/FOjFeX14sMcFIwMQ5YXsAW3AY4ZL44lDOq36wBsDNnVx64BjPATA==
X-Google-Smtp-Source: AGHT+IEQoVR8mYge+xgG6bMMFiRWvL7ZNtijIlLe+Em8CHNjt4EJO+5x9k12b2SUxBys0IPLfx3luw==
X-Received: by 2002:a05:6a20:3f24:b0:1cf:7bc0:3e14 with SMTP id adf61e73a8af0-1cf7bc045a1mr1007889637.17.1726124668127;
        Thu, 12 Sep 2024 00:04:28 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:2fb2:d683:de5d:c3cb])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7db1fbb5a23sm1101543a12.31.2024.09.12.00.04.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 00:04:27 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv4 2/6] zram: permit only one post-processing operation at a time
Date: Thu, 12 Sep 2024 16:02:17 +0900
Message-ID: <20240912070413.4179924-3-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.46.0.598.g6f2099f65c-goog
In-Reply-To: <20240912070413.4179924-1-senozhatsky@chromium.org>
References: <20240912070413.4179924-1-senozhatsky@chromium.org>
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
index d170bf6cdcd8..37622268104e 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -627,6 +627,12 @@ static ssize_t writeback_store(struct device *dev,
 		goto release_init_lock;
 	}
 
+	/* Do not permit concurrent post-processing actions. */
+	if (atomic_xchg(&zram->pp_in_progress, 1)) {
+		up_read(&zram->init_lock);
+		return -EAGAIN;
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
+		up_read(&zram->init_lock);
+		return -EAGAIN;
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


