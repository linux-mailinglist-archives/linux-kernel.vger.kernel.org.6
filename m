Return-Path: <linux-kernel+bounces-535571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7992AA474B8
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 05:40:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D3987A48FE
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 04:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 409E91EB5C7;
	Thu, 27 Feb 2025 04:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IenRPQ5T"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 421DD2153E9
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 04:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740631042; cv=none; b=EID3sufJROJmzV/JVWU9MQ/An3R2/4F6szkVkVNov4oTC4kZmXyLEwK3trXWZKLATf/qLQWvv6TjPL9qdjw2003BHUaxxH1LZh15Xvx5H8e//+JvCDWXa8t7sr9s6w/wNbHCdc7O4a6Gp5Khmpb5y7sbUdLRla+kIOZj688hPAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740631042; c=relaxed/simple;
	bh=gOI0PnqaEgWx1Mwwhgi1f4gyeDamR4aCRebnN7RFpjI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DFD4tC4oAjG3ptbNz1CR8BtYZeVEeXweVyXUsUnpgV/ZvTk0FkQoL3BoTHyOWx/QcX1w2Et447ZMWZqeHeYkYMETK3APl2jv1yte4kJHtja5WM04rhz4c4MUnbc6otMR7dlR5F4JjXXoGHLIUQ9f8rcbEudaARrIWog+28pwjSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=IenRPQ5T; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-22359001f1aso523055ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 20:37:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740631040; x=1741235840; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k2tj7S14ByHudFFBWtU70rdMhsyqSn6b6QKduoDJaoI=;
        b=IenRPQ5TOzCYad4bDUl0adSP95w8LWbsFiGg7EBgxR7fLHUYXJ/lcSB1xoNk6sbNtK
         iuLGpVLQX/QVgbt8SsW3bZMCTMKFB0VaTs6PZq7slw4xokSbh85HEjSj60tXKLsR+9Zp
         5ft7+/8MLwPhztwpGZNUD1BoC8TX/GdFgaYAA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740631040; x=1741235840;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k2tj7S14ByHudFFBWtU70rdMhsyqSn6b6QKduoDJaoI=;
        b=rCpdIwzc5010zdpzP3LF6zGVmSxuPxYdwY1jwfR7KcYJyJIBpnxO+xspw7CVt6z7JV
         Eh3/RwqKjFC6zIrSFRN4lIswtUUvsIlyBKmkBK1NxQ2GpRy9Zz0DvReidbcjH3FcJC3N
         SYZWC4bfNWWLk13AebCOSlu1guM4FiVTh0WAc7K5yrFceHCC4HXNTRTFxpqH5c3lBM7G
         zaxJSxKUt5GiRD/8EAHnMwZI+OSwTHID8OpvP3MOruDqaC+i0ThN09tE3WL8Vb6hc9uX
         5GUyybqhTVMo5NBEp8ZGi+jWQWLNlhQ/OXv3IdpQYoxbsclUBH6oGpq5JTrzRPpxkQII
         NGzw==
X-Forwarded-Encrypted: i=1; AJvYcCUY1DlvhlJySb+/cYT25mU6Jpp+frNNbv0cqNk3V77CbI/h785rGnWDmkxLFUbHvLhJ5oSc7xp+Np2d9aU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyl5dLrsqqUac46bzPy2F/iOivQiDBsgTifmtPkmG3A37eJE4mO
	W/cHtlpn2Pm1QzigK+rQGYOjusg92NiDoBVeLpV/twmMFkxivnlSa0ytd+V1ug==
X-Gm-Gg: ASbGncuv0CoQjUBiOoL6ad+YYtwezU9GzqeTwXk+A6j4saVlVqSf6bQfQz2ZOrMy+m4
	7eEHuHUnZty30bygn0PtrP+9IzqMqjkq6GTHxt2Q05utqFOHXqMUlPkG/o+YSvdPK4HvDCEFLYA
	eJu7xwk+rm38x+6rjnwawfmBaF1Sy8+yI7qxI+aJsOTZDddsxQ+AfrWMxLoqd2N4nkYGUVjYohv
	82Kg91n3S7lm54hFzR4Tso2IKbmnldyOxSOvjhlAg4sKa1X4qvsaSxi4eXeOR88GeXjuZLMEzkD
	LQ3QrVw71meT6t0/t07brLteiOVh
X-Google-Smtp-Source: AGHT+IEN+RE7KRyg5caAuRJqhyxwCNu+Sch604nCRIaPUWr0NHMHIZpiZPkRYwWAzDLUylZbTZZtGw==
X-Received: by 2002:a17:902:d4cd:b0:220:f795:5f14 with SMTP id d9443c01a7336-221a10de0c0mr360128185ad.27.1740631040453;
        Wed, 26 Feb 2025 20:37:20 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:a9c0:1bc1:74e3:3e31])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-223501fb1f7sm5039955ad.98.2025.02.26.20.37.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Feb 2025 20:37:20 -0800 (PST)
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
Subject: [PATCH v9 09/19] zram: filter out recomp targets based on priority
Date: Thu, 27 Feb 2025 13:35:27 +0900
Message-ID: <20250227043618.88380-10-senozhatsky@chromium.org>
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
index 12b99a557667..3a23dfed9542 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1823,7 +1823,7 @@ static int zram_bvec_write(struct zram *zram, struct bio_vec *bvec,
 #define RECOMPRESS_IDLE		(1 << 0)
 #define RECOMPRESS_HUGE		(1 << 1)
 
-static int scan_slots_for_recompress(struct zram *zram, u32 mode,
+static int scan_slots_for_recompress(struct zram *zram, u32 mode, u32 prio_max,
 				     struct zram_pp_ctl *ctl)
 {
 	unsigned long nr_pages = zram->disksize >> PAGE_SHIFT;
@@ -1855,6 +1855,10 @@ static int scan_slots_for_recompress(struct zram *zram, u32 mode,
 		    zram_test_flag(zram, index, ZRAM_INCOMPRESSIBLE))
 			goto next;
 
+		/* Already compressed with same of higher priority */
+		if (zram_get_priority(zram, index) + 1 >= prio_max)
+			goto next;
+
 		pps->index = index;
 		place_pp_slot(zram, ctl, pps);
 		pps = NULL;
@@ -1911,6 +1915,16 @@ static int recompress_slot(struct zram *zram, u32 index, struct page *page,
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
@@ -1919,13 +1933,6 @@ static int recompress_slot(struct zram *zram, u32 index, struct page *page,
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
@@ -2150,7 +2157,7 @@ static ssize_t recompress_store(struct device *dev,
 		goto release_init_lock;
 	}
 
-	scan_slots_for_recompress(zram, mode, ctl);
+	scan_slots_for_recompress(zram, mode, prio_max, ctl);
 
 	ret = len;
 	while ((pps = select_pp_slot(ctl))) {
-- 
2.48.1.658.g4767266eb4-goog


