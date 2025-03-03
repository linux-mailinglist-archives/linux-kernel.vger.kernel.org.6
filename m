Return-Path: <linux-kernel+bounces-540890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6D56A4B618
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 03:28:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3267C1890B0B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 02:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B40B61EDA3E;
	Mon,  3 Mar 2025 02:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="glQoVSoj"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA2D61D86DC
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 02:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740968764; cv=none; b=aKyOfqi4RaopuUoc0lFJOq1fcz7VBowzWxxuykt3NbW6Q604DOGr9/rT4cMnaAM4s7mLqP9dHy6Tb/6KcWKfQseLVCqQVUrYq5t5d5o0TcZf/Mjln16jXAL3eO80496iBjqxE8KNZ5GdSYz6T8HZERXyKB5pv2/e2+N5K1Bj3T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740968764; c=relaxed/simple;
	bh=vtzctO98UUy+6GJzvnuXMNw49YXzhxByPxbJICgMnlU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G2d0mNmFVy4+FdbDixR9rmHu6xYhEAYV6fbHgtBq3G9JWp8K0/P/z+GioFfB3f9TSCm9ioBhUFEIBO5La4+DkZM18PB0qa0SLTPhyYrEG4MFASizwabZkaiKMJ/nV65+Fqi5OoXfSAQ1T+30WiQWgyzcSQV4l6uBp1ogx4vaEcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=glQoVSoj; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2f9b91dff71so6176085a91.2
        for <linux-kernel@vger.kernel.org>; Sun, 02 Mar 2025 18:26:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740968762; x=1741573562; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7MsZXmzA7gZttOoABIScoWzRHdPrz6HqbSztfy5OTfM=;
        b=glQoVSoj04RnBu/WPWJxXCL1SMno2vpIQFCA9ZSzwwHfF8g2TN4xJ4p2zdeMXCUbui
         Sl1RGxMT8fAr8mNmYdKX3V6Ua62glHZ+DJ8bzYYPhl6QqkBIhM0us/cBC86/dWbD3Zba
         n0qYduV4ziyyhlGwRAihyo9prHnAsz7974z1I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740968762; x=1741573562;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7MsZXmzA7gZttOoABIScoWzRHdPrz6HqbSztfy5OTfM=;
        b=FnOBavK+uJpcb6fvouObnCk30pcD29gCY/NQHxeJzIEFq8Im8OdMhakde7YSvRpFVA
         WZFkIt9dElAKho+QYyeliiaiCb3PBQVcvwYe9blTU1t17eQ0x7CAmtZM81D5Kz9ZQCfu
         isy4yvrUTAOuzu9WL6f9hX2/zntBoNPxRIbFF2MrQNcPIooqX8gaf4UFsw+gm0/TAVgm
         OR/NiusOyI6T2CeMebrZ/SIJLy/Gir35qkVZwIX27ldTeh08IBiLYCuJvsuZHKh62ZXT
         sN112tIa3buaGX8hBD8oE+SWExhxeVno9i5ovCH1t0hKTgHjuAFgq17b0TNVbspSEin6
         GJzw==
X-Forwarded-Encrypted: i=1; AJvYcCWrdRyExRhMKvm4QK6vy1uuSCGG0JNqj1e4TNiE/SeO6EiHSCPHKU1HlNFgCOiFDjs7A4pTtlIZ7q21HOo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7ua2cYwENRH4/yXqxLrpB4t5BMbPQwXJtoW27JnKKH5QEWa74
	bV9MQGKctO95+PWA7LzCQHLSoMcKJ7k6hMO5zVaLbIzWdjYXJT6y/9cDlTJb1A==
X-Gm-Gg: ASbGncsgedag7N8hoCawm7wql1MpCOs2O5GAbg09romv1KUN6GLbLpYtE92n0l2wcvN
	so9dtLZbTyrBlUiK0NFxB3cZO+i4MAb8xyKhDpoLuEpMxJdYa3yaa/HXhYVA4yyYrAy+ChQmHdm
	bR06bOxuoHcFCwu/BiqsqSHZKuQBWFmm0zbhuhvrCvXWxvp819Wgp4EtgdPqAueCOeYOka2+mfm
	CnkSY6EPrVQFMXrs73c5qgImFphutdclotBDmlok6fqwUGoLQFJnIPyoofeZikxTd8pquZ7x2eO
	pRYOXvOEXig/o6g9cLxkP3zeWvJUjkS+E8y8JkqHTv5ACKM=
X-Google-Smtp-Source: AGHT+IEwLUQ8+oZJN0pj6P2S75Tk9SYQBRSYoeVDDP2x+EgMUD0KKR9qXN1nP4rIBG836Z6i3jCjHQ==
X-Received: by 2002:a17:90b:1ccd:b0:2ee:c918:cd60 with SMTP id 98e67ed59e1d1-2febab78da2mr17797763a91.20.1740968761993;
        Sun, 02 Mar 2025 18:26:01 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:1513:4f61:a4d3:b418])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2fea699090dsm7711363a91.48.2025.03.02.18.25.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Mar 2025 18:26:01 -0800 (PST)
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
Subject: [PATCH v10 18/19] zram: do not leak page on writeback_store error path
Date: Mon,  3 Mar 2025 11:03:27 +0900
Message-ID: <20250303022425.285971-19-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
In-Reply-To: <20250303022425.285971-1-senozhatsky@chromium.org>
References: <20250303022425.285971-1-senozhatsky@chromium.org>
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
index e50a5a216974..fda7d8624889 100644
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
2.48.1.711.g2feabab25a-goog


