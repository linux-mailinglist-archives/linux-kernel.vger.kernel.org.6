Return-Path: <linux-kernel+bounces-510574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DA1EA31F02
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 07:34:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D8EB3A17B1
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 06:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CE461FFC56;
	Wed, 12 Feb 2025 06:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gQDkTi7o"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3551FC7F0
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 06:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739341964; cv=none; b=k7+6Wg8eYXctq9AATckC9emVlcgR98wwGPcOSfbwAbbQPkZJIPeSIvANLqUh5460UCkvZLhf4UXX9X3tPMmIga1oV7++B6jQzeIZtluMPsq3IJRdxDzpC39Oq9bRAaAP580ZR218jBYQrzEv/ZkDY7JnHAPk+3nNylv6R/ducyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739341964; c=relaxed/simple;
	bh=E0MVDPJMCbp3kVaASHoB5Y9trPKKkPA/EDfpUcdE2uo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CDzQiQB6D0rrFMUCH0EFcM7W7qmveMd08GD1dP3qHqwWUmC5xBafJ87NkW0LXgwRYTWw2n5VmQSWf7OlD84AOSphlrY6Ld/e8LSPN0fzG8taYlARNvYzu1qbHA3ZoLnOD3zxGwORoTfbM/4ppis3h2c4r3Be8AAakd+IEU9mY50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=gQDkTi7o; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-21f6d264221so48916075ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2025 22:32:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1739341962; x=1739946762; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GyNDz1JqW9fZ5TiB72j3x2sTVp+ebBvZsmBm0h5y3g0=;
        b=gQDkTi7oERIonUriwhP/wrK5fI5v5P79BlTHGfecNJhCGbWJk8OKW5oIqAXOqZzmaB
         u/5IxwI2Sktv53xJHKf+A4j5+aw8WIsW+w0mxhHQonQPlP8oax/aIcbHUFdxSWcCBpC9
         bfcEPwAMNvDp3gPv+HO3onNUiC16zXTNNnGKg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739341962; x=1739946762;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GyNDz1JqW9fZ5TiB72j3x2sTVp+ebBvZsmBm0h5y3g0=;
        b=iMnT3nnHEUt7YS3m+6JPjEs/bZb4p7ANwy1Xbh5QVbmdiPkh0MbdxulRVLUyuFip/U
         TxjY3RY2fcdCX+DCS5ea+yQCEQBPZu3auw7q59ppVGTJW2YDlbQXySmPOBscHS4apitx
         sGOXymjHi9tks+dHSV3BbZuj0gfoVRre3uNpTE6G/HPpLMGRhaFYJ/o2pfpLqyYk5COi
         acWIdzAh+9ZHSKQ8ZR6J1i+C+I7iaNHlSEPoAPAx4ZGpP7s3XmFNy7yu8VpJ1X7fRlxX
         rcaW+o3EftvBzxrXT6VxYajn7oZ7Jbl37Q92zoKQWOfjQHAPyP3Oxc4mf+ZcAiDIGfE6
         2MdQ==
X-Forwarded-Encrypted: i=1; AJvYcCVD5M3zMTGXykLV0rJFdNCiObV5C5O0+S8dH+AIiNVHrpqgxxfU49Lba4g6oFkKqXtEn06jivRPisZp0GQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxA4CFuTETGyAZepSsQe4fg5QnkF3KotdRlJGf4P9qjOYUeEnb
	L0Gf08Vnt/gVMGEnTawIEUCZgrf0gHTYwOCcerfW9M0eqHxrb/aBvdgBN/L9MA==
X-Gm-Gg: ASbGncubLTq7ZoQAwezqQfqYCSEMqM+1n8i3ybO8hNi3Qd+kn1UtLGfn7msZLTtKpVW
	gtUvstb6cSi/rT1Qfh9xPmBQFyl+QnrsddlN+H/Fd26RZp3z6T06rXgzO6rUqiOd7eHvYRXr0/b
	RQmjCpBPI71p6MGl+K43pf0xtPiP5zlV32mHOdqxCak9OmimoZee/ZSJG0UrCcUKI0gjfww8BC5
	K0Bc594t0LyPJfq6mpNmLrLCZkYm3h4YSZXRGPNu5h+GaEvDCkSPy6Cz0sZMgafPxDGm/Hywgba
	vhmwMwkntKJZILAsjw==
X-Google-Smtp-Source: AGHT+IHuvm8HCsSAsDPLpNBHM4fkgErNxht0F4ETwuQK+JzFh06XIBG0WxJwETNpSs2/VqRQClDZHQ==
X-Received: by 2002:a05:6a21:600b:b0:1e1:af74:a235 with SMTP id adf61e73a8af0-1ee5c790de5mr4045324637.24.1739341962338;
        Tue, 11 Feb 2025 22:32:42 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:69f5:6852:451e:8142])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-7308e4881fesm4730281b3a.46.2025.02.11.22.32.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Feb 2025 22:32:42 -0800 (PST)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Yosry Ahmed <yosry.ahmed@linux.dev>,
	Kairui Song <ryncsn@gmail.com>,
	Minchan Kim <minchan@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH v5 08/18] zram: filter out recomp targets based on priority
Date: Wed, 12 Feb 2025 15:27:06 +0900
Message-ID: <20250212063153.179231-9-senozhatsky@chromium.org>
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
index 27148f3e5ae9..31bdf5e0ff74 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1822,7 +1822,7 @@ static int zram_bvec_write(struct zram *zram, struct bio_vec *bvec,
 #define RECOMPRESS_IDLE		(1 << 0)
 #define RECOMPRESS_HUGE		(1 << 1)
 
-static int scan_slots_for_recompress(struct zram *zram, u32 mode,
+static int scan_slots_for_recompress(struct zram *zram, u32 mode, u32 prio_max,
 				     struct zram_pp_ctl *ctl)
 {
 	unsigned long nr_pages = zram->disksize >> PAGE_SHIFT;
@@ -1854,6 +1854,10 @@ static int scan_slots_for_recompress(struct zram *zram, u32 mode,
 		    zram_test_flag(zram, index, ZRAM_INCOMPRESSIBLE))
 			goto next;
 
+		/* Already compressed with same of higher priority */
+		if (zram_get_priority(zram, index) + 1 >= prio_max)
+			goto next;
+
 		pps->index = index;
 		place_pp_slot(zram, ctl, pps);
 		pps = NULL;
@@ -1910,6 +1914,16 @@ static int recompress_slot(struct zram *zram, u32 index, struct page *page,
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
@@ -1918,13 +1932,6 @@ static int recompress_slot(struct zram *zram, u32 index, struct page *page,
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
@@ -2149,7 +2156,7 @@ static ssize_t recompress_store(struct device *dev,
 		goto release_init_lock;
 	}
 
-	scan_slots_for_recompress(zram, mode, ctl);
+	scan_slots_for_recompress(zram, mode, prio_max, ctl);
 
 	ret = len;
 	while ((pps = select_pp_slot(ctl))) {
-- 
2.48.1.502.g6dc24dfdaf-goog


