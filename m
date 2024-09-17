Return-Path: <linux-kernel+bounces-331251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C17F397AA59
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 04:10:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 836E0286943
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 02:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5382A15AF6;
	Tue, 17 Sep 2024 02:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Vqo9Zcd8"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA4B3B1A2
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 02:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726539033; cv=none; b=S2xM7y4BFPJ+scDmvj7xnjfhbC+b5EfW7UCG4VWHyIMZhMch3YwHt5FwosiL4jcJKYc402t8B4QQ0DdgBBVRg/6z0RC9ghdNEX7SPU1XDigCu3ohUGE8zQnLfaYfiKsOLoEYbRfvUWuKBQMaMdwDcIqhEYnBaSnlnhePw+HsPHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726539033; c=relaxed/simple;
	bh=pCNOlP9y5PFyA818TtLchVQPaUxrv0jSnsTmr9g9Z2s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oo/bwMScwFNERm7Y22rNPIkpI/nPzc3JE83fh1QU6Y74qdhbeFG1CRghzvM/Q3icSgzAqowLEGve/WN/LkVlLLTdi+ysk4PGqefrxMJc0JgzqELC9kpqVCO2CTK0tadT93Q/nbhLXMA/Inu06T4gusRKbxKHV7ruPW41wE+IZPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Vqo9Zcd8; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2d88690837eso4151345a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 19:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1726539031; x=1727143831; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZhTBoAWfGdKQ585H98MwgnvKBszcs4TGX5DhJFeIfIQ=;
        b=Vqo9Zcd8SPAz6Ac7VUkwdYV09YFlc7GoxKzIvHcF+FnazAdNutixrHxZqHwGU6v862
         bzsZQRcJKoDKpFUNRAfesgSJAZHXWGKKPiB9EVzFSIHV5+PpUfaUEYfLinb9d+JNjqWP
         AWqdxQ35DhFcuPHOON4ntU8cNgdwBRrkeEN2o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726539031; x=1727143831;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZhTBoAWfGdKQ585H98MwgnvKBszcs4TGX5DhJFeIfIQ=;
        b=YDDKkqTPnJuvPz7Xwmje8HD6tEiOF5Ok+BJex5fOIRXpTpWg1AoEPy18/BRSZAj0UE
         g/3WTOi1yG7/e4HuQoX3y84k8oPZoYDG3qmNTyQ8UXw7YEybyTUamiWJ0k3PRZnjQOLe
         pjKuPXNnfu1oL+RBy8Uduj30BfP14SOTWQoBYA+AQSO5GPXVxKjJ03f7ry8Oi1k3kfLZ
         Ui82JzWCyM00NPTH3tQPUcLv4F+lfHX8Lc7efBANP9CiwVaHyucWHe5YIVQutbHxRNaG
         fLPq6D50KlXkm7FApEeWx5i1c6iiq+wIMyoQT6rToJpMiVvNRAah/KQWD2Bee9e85V2O
         vZhg==
X-Gm-Message-State: AOJu0YyzlKdI+KieLSDwdelc6ZR+H2VZn+gxdrPGcAIGOKhf9Ay/wee0
	Q2ZqygdNoyUEGapH1hO68XALpCl7QlfQxOngS7Y2gJ9xyS5yoWXqOJNPGNJvmQ==
X-Google-Smtp-Source: AGHT+IGcqIskqlLQtZnytZWQ2RYuLUW45cV4WAfu6U9blGvncLxKnZKCgoGaid5OwQ0zaXO7zTpU/A==
X-Received: by 2002:a17:90a:c915:b0:2d3:d063:bdb6 with SMTP id 98e67ed59e1d1-2db9ffa1624mr20734530a91.4.1726539031411;
        Mon, 16 Sep 2024 19:10:31 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:693c:b4a9:5e6e:c397])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dbcfd9313fsm6037293a91.44.2024.09.16.19.10.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 19:10:31 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv5 2/7] zram: permit only one post-processing operation at a time
Date: Tue, 17 Sep 2024 11:09:07 +0900
Message-ID: <20240917021020.883356-3-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.46.0.662.g92d0881bb0-goog
In-Reply-To: <20240917021020.883356-1-senozhatsky@chromium.org>
References: <20240917021020.883356-1-senozhatsky@chromium.org>
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
2.46.0.662.g92d0881bb0-goog


