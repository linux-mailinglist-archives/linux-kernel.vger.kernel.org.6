Return-Path: <linux-kernel+bounces-525503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2312A3F0B1
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 10:43:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B0333A7939
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 09:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 459B8208973;
	Fri, 21 Feb 2025 09:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OucQOtz7"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA506204C28
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 09:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740130772; cv=none; b=I89CCXEK3SDwjZaXR2fwcwTyX75TfKk2FYiGB8IqYwP0xODRz8tdPsIOuMm4ZrVebinz9ZjOP0gxXlizL6eTUzhE1p7AHbk+ecb4aMZzEuJCkiOFUatzv/BbUumVbtPq0MXePJm2wdusSCTPBCKWTgZ05DcjJueJcB6Y0Yi91l0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740130772; c=relaxed/simple;
	bh=jnOJzYCzgxpKde1HZP0K8E1XsiPZuvUciCdLehqUngw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sr/UOYTONeOy9jHGz9pwQOS2r4KdgZmW5FOURinwQ0rJYiIC82/jgYOiys7LR2TiFNjvANudWVXHNUrw5CGW8XLepQJZLaZFK3tB5yc2OlDG949iaso1K5g9+7Yw2gZalXKsdOvYN+ZS7cAURYQbHqcWM0Y5WyD8r7AC7l5dOmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=OucQOtz7; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2f42992f608so3075169a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 01:39:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740130767; x=1740735567; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Ti7CmEaorHMBg5DWvmUEjK7cf0LUhuuwHacW6S7Q+w=;
        b=OucQOtz7VG9XLq3rWVThwLf7oJCX+ip5cQoPvu3dt77VRt1Wq1RWqPRuHsXTTlhcZs
         ShVtoKMa5h1hq0h3Cf+/fhlphlw41digLyEFtis7U/H2sBcRzIBuwCBXYDkYw8QGP5DQ
         M3kKKl0zuiVsnvpaXIlmOZq1gg5MVTvJYzN3E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740130767; x=1740735567;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Ti7CmEaorHMBg5DWvmUEjK7cf0LUhuuwHacW6S7Q+w=;
        b=ey9RaX59IgNQ6hd6ffx+4y1aKJS8b/vTEApIOvTMSIji3gXyfAyPxRVePU6xMaEgQ9
         lLlcaX/DleoumCCNV/WVBJeA4/g3KpRO+01zO8H9jfrDThRoQynAP3taEUdU7YOmTUyh
         vDYItoAti8J7BZMAvmJdQJ0OtPVMQE3SvQrdq6P/b0FrSQu1x2M4HxYkcmOTRgwanN3S
         FsAKTDL4/1W6S3S7rUOZhkto8EnoRKKxnhgVBhW/N1k/1HsH0WirJvCXII+Rbyk/1v9z
         kDK8Dvg8B4N88FTgc/NmaLeOjZi5srMM/O3f3Q9oJW87BUxsSsDF3zqSkeCy7dnyN0Bi
         JYOg==
X-Forwarded-Encrypted: i=1; AJvYcCWgHwiblfMCjV51EXiQzIwcHI3MCTzFbVFqlTyv6vXLLa7KC6M6GXRlYG8G29egKhUBiwDPzguz6n2I4LI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdqgVhZSsNLREykYzeSKEwxUSfcgrQ+vVFCX2k8I317p0tyRAT
	1Hw+qkJzUf2SnOVSN79GA6DU7velkP+BmA6pDpinDNB7K8LGEiqQma2bSaqC4Q==
X-Gm-Gg: ASbGnctqQlQfDPP8GpDOZy1P2oSGdVlvWGg1ifSayjwr48XvTMMzeKhcSIACZs3XbGw
	IOoTAgo0/DGM4g7cilg46IZ49C2SdYQ3l9xF8BzApWDDPK8/87jSan47/AWhnH7KFHczxtlVuzH
	kw4kSkMpLDtbQ98iyoHE7sW3aKGf19RRKau59bzQAA/kgw3gYB7ack0xR2AxFh1xKa4RKKOznqH
	fCQGv45CU5qTol0BJOrXDoR0SFjBHeYtqYaWsMYTm65VbjRgSGn6AH4KUul1afAMoAkbM3Jam1n
	r45PwrLEOsP4WB/6uwY5h57KzOw=
X-Google-Smtp-Source: AGHT+IFkEw5rhjwVGmuiSJO9ZqK4LoqieklxjbVlzdvGmp36x+X05fC+JwKkd7RRpGwQHuo2CguWWw==
X-Received: by 2002:a17:90b:5303:b0:2fa:1a8a:cfe8 with SMTP id 98e67ed59e1d1-2fce7b3ad90mr4368050a91.29.1740130767623;
        Fri, 21 Feb 2025 01:39:27 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:f987:e1e:3dbb:2191])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2fceb05f715sm900785a91.24.2025.02.21.01.39.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Feb 2025 01:39:27 -0800 (PST)
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
Subject: [PATCH v7 08/17] zram: filter out recomp targets based on priority
Date: Fri, 21 Feb 2025 18:38:01 +0900
Message-ID: <20250221093832.1949691-9-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
In-Reply-To: <20250221093832.1949691-1-senozhatsky@chromium.org>
References: <20250221093832.1949691-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Do no select for post processing slots that are already
compressed with same or higher priority compression
algorithm.

This should save some memory, as previously we would still
put those entries into corresponding post-processing buckets
and filter them out later in recompress_slot().

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/zram_drv.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index a886827f0b3c..a1880e621895 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1827,7 +1827,7 @@ static int zram_bvec_write(struct zram *zram, struct bio_vec *bvec,
 #define RECOMPRESS_IDLE		(1 << 0)
 #define RECOMPRESS_HUGE		(1 << 1)
 
-static int scan_slots_for_recompress(struct zram *zram, u32 mode,
+static int scan_slots_for_recompress(struct zram *zram, u32 mode, u32 prio_max,
 				     struct zram_pp_ctl *ctl)
 {
 	unsigned long nr_pages = zram->disksize >> PAGE_SHIFT;
@@ -1859,6 +1859,10 @@ static int scan_slots_for_recompress(struct zram *zram, u32 mode,
 		    zram_test_flag(zram, index, ZRAM_INCOMPRESSIBLE))
 			goto next;
 
+		/* Already compressed with same of higher priority */
+		if (zram_get_priority(zram, index) + 1 >= prio_max)
+			goto next;
+
 		pps->index = index;
 		place_pp_slot(zram, ctl, pps);
 		pps = NULL;
@@ -1915,6 +1919,16 @@ static int recompress_slot(struct zram *zram, u32 index, struct page *page,
 	zram_clear_flag(zram, index, ZRAM_IDLE);
 
 	class_index_old = zs_lookup_class_index(zram->mem_pool, comp_len_old);
+
+	prio = max(prio, zram_get_priority(zram, index) + 1);
+	/*
+	 * Recompression slots scan should not select slots that are
+	 * already compressed with a higher priority algorithm, but
+	 * just in case
+	 */
+	if (prio >= prio_max)
+		return 0;
+
 	/*
 	 * Iterate the secondary comp algorithms list (in order of priority)
 	 * and try to recompress the page.
@@ -1923,13 +1937,6 @@ static int recompress_slot(struct zram *zram, u32 index, struct page *page,
 		if (!zram->comps[prio])
 			continue;
 
-		/*
-		 * Skip if the object is already re-compressed with a higher
-		 * priority algorithm (or same algorithm).
-		 */
-		if (prio <= zram_get_priority(zram, index))
-			continue;
-
 		num_recomps++;
 		zstrm = zcomp_stream_get(zram->comps[prio]);
 		src = kmap_local_page(page);
@@ -2154,7 +2161,7 @@ static ssize_t recompress_store(struct device *dev,
 		goto release_init_lock;
 	}
 
-	scan_slots_for_recompress(zram, mode, ctl);
+	scan_slots_for_recompress(zram, mode, prio_max, ctl);
 
 	ret = len;
 	while ((pps = select_pp_slot(ctl))) {
-- 
2.48.1.601.g30ceb7b040-goog


