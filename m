Return-Path: <linux-kernel+bounces-535593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61836A474CD
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 05:44:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 644E83ADCE7
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 04:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADA612356A3;
	Thu, 27 Feb 2025 04:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IeFwPito"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C591F234984
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 04:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740631093; cv=none; b=D1ARMUz7FwlSO9PK1Tmg3Jz+G/vthTKRb1FpKqHuLfvwFOGRjkIY93mJApYRMkW33ltw9Npm8h5uuFHSh421f0Q1NqqLOi3TvM4kpJaXZOSepiQj757i1X6n+prCChedCIV8dg15KeagPxw+OjyhM3GohIw2w3fIdNE/fQXIvjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740631093; c=relaxed/simple;
	bh=ZQwvICLouPvkcjgqyDAqTmLuJUwzgqhQEbOcyyDCppE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KviBmMPm2nrSVVTmdhSsJ0r4OJ2L8xP0WrP8tl6LGwk7BoK7F0NwXnM206MGmICynOrlunrcjVX8nuqyCUj0ygl2/r3iMrUDaV2YPmhmahPOzSTc4PyhtBJ6rSqM6kbNVo8hSP2RNPvVF22rFqhtdrwELjvuFmI2hgCiNx8Qqlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=IeFwPito; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2fe82414cf7so1076274a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 20:38:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740631090; x=1741235890; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hD0ulf0FeWPvWMK0YywecJZZj4meHTFhM9R2+0rTTi4=;
        b=IeFwPitoMeudJxGC7I5dBwI0XTf4DQ6qjd0hrBz04p70fClLMyoLv2T9YKxGCiKrjP
         BQs+dE4ngbMDV/FtL4lxyjw9ajDv8S00XEOaaUdkxuqL94RnTwgZ9Wfdl9AhS4A7pBxL
         kcnk2YnfZ9fOcA1n72R93FOankYyryU+yQTLQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740631090; x=1741235890;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hD0ulf0FeWPvWMK0YywecJZZj4meHTFhM9R2+0rTTi4=;
        b=ekeqh5bwoLBCx45y+C7lQV1Y6WSlAnIl7lOOgI6uG/M3DkMmHKrJ0BjaonEuCVsAuK
         WkVYRQLfNmDYBUdVKsAgg0Th5AFww9CIq5fYaQEil9LoiLkYUJfqtL/Fc8+Aaka7ipkF
         6ZuAy7nMT1mhtfGyKkxqe/W8ImtOwiBjqPXEBJsdKuwi3RWGBREh+XK66o1/JkY8P89A
         y5WjdrylTQS5SgLm4DUC+s8LWGOB2x/7TVZEL8lsl7H6FvIltzqGXMcTtDHeVuOJb+Km
         8sgmTqZMUwQIzkL11ex1bkpyzxbXVSRnG2ifybZumNtr3zitErmTr9QRpyRxU5SaFyk/
         Vj6A==
X-Forwarded-Encrypted: i=1; AJvYcCWWEePN42w2eB8cdyB2IMmoKsiMW8igFggBxWnQNIPDY4TQpPZSr4Mal3qpR8tQ02kmmQ4Cl/yYpwA66Ao=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEzcH1MZCJLeeAhAPbhV3soCVjL+2505QGZ0h+dpBVQdUkuJRt
	Z8ZalREaqS0mheuuVJGLSMc8WR3PPrAdt7jNxzM1VBlv/PK2awKLIIbIFve1Mw==
X-Gm-Gg: ASbGncsgampXe68+1+wjzE744xx6QqJ5GS9VVFa6ZWmb8BjnzrYdhqM+aa/sAtudafz
	zZ0Ysrug1MK9IH4F/trHfAHzNHaca3huyDd0XJWb360+RIcl2YerA1KlhRDYc32ktdWVcJVxEKN
	A34n7y7SrNmv+8exHw04qp2zcnp7mEY5o7ZYNNnfWZRtPBzwKPnVY2OXa5Jwo88BMLsOmGOxq8c
	83+pO5wMpxtyXBRypJVfzAmFkp/4KMHsfMrYGf3pZBqAfzmJgS40q9RQiGbZ6nxA94s63v6VedE
	E3UN9aCriPeevi26PZXms5LJpa3l
X-Google-Smtp-Source: AGHT+IFidzq43r+0NRTs951DcUKcskfAO05VG8wu01wBEQtR1k0fOqC/zriCBDU47fEYDjlBVHYkmQ==
X-Received: by 2002:a17:90b:4c8a:b0:2ee:3cc1:793e with SMTP id 98e67ed59e1d1-2fe692c7f83mr13786908a91.32.1740631090068;
        Wed, 26 Feb 2025 20:38:10 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:a9c0:1bc1:74e3:3e31])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-223501f97cesm5057285ad.60.2025.02.26.20.38.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Feb 2025 20:38:09 -0800 (PST)
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
Subject: [PATCH v9 18/19] zram: do not leak page on writeback_store error path
Date: Thu, 27 Feb 2025 13:35:36 +0900
Message-ID: <20250227043618.88380-19-senozhatsky@chromium.org>
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

Ensure the page used for local object data is freed
on error out path.

Fixes: 330edc2bc059 (zram: rework writeback target selection strategy)
Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/zram_drv.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index e8375fcdb36e..5dac525f4cd3 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -787,7 +787,7 @@ static ssize_t writeback_store(struct device *dev,
 	unsigned long index = 0;
 	struct bio bio;
 	struct bio_vec bio_vec;
-	struct page *page;
+	struct page *page = NULL;
 	ssize_t ret = len;
 	int mode, err;
 	unsigned long blk_idx = 0;
@@ -929,8 +929,10 @@ static ssize_t writeback_store(struct device *dev,
 
 	if (blk_idx)
 		free_block_bdev(zram, blk_idx);
-	__free_page(page);
+
 release_init_lock:
+	if (page)
+		__free_page(page);
 	release_pp_ctl(zram, ctl);
 	atomic_set(&zram->pp_in_progress, 0);
 	up_read(&zram->init_lock);
-- 
2.48.1.658.g4767266eb4-goog


