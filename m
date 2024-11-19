Return-Path: <linux-kernel+bounces-413927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C1599D20AA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 08:22:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A62321F23510
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 07:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9F9818A950;
	Tue, 19 Nov 2024 07:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fsBu3vpB"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E602199FA1
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 07:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732000877; cv=none; b=PT/zwwZx2LE9WJR0ku5nhYcwft0RG5O3yilEiTfk6RfNt0b1wf5uAddEoO/UODGUr6s7vH/2YC+nnTAJZeVP4LY4rOYh6s5X6lVQsm/xYhzG6Zw3egAe3MBt2vV7TD8h4yVZPNKe52ZXURLkQP2jzQfBFyvmI01UFkjZMH4lxBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732000877; c=relaxed/simple;
	bh=E9npFG0X9F8KtazdPCWKZz4Vb4U/GOdKlZTFjHDE72o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b9Z3drabVjXaEmB6lzaOewNLt2432hgIYNURpTIghCsk0Y4d1lVbedUN+WMvMvVwsap1188KTm1suuS/lCVpKtNqns8rxdl3uI8Naq0upQT3N7pY+ixBlKcpb+B7Zt2ZnGeVvFiFjgvUbzqm7Eyxr3eYXLzN0+jrFDw/u58OxIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=fsBu3vpB; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-20c70abba48so24131105ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 23:21:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732000875; x=1732605675; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Eyx+9in/HQFchdWYfQyVaWbKUcXPbHYEL1OWiH5aBP4=;
        b=fsBu3vpBqEL6lrivQVpzk151qgBelDx1KpVnJ+o9O/XUQX4EAIQ0Th5/YmNdHdr2p7
         sBBBzaZlR1jWAbF0y3SrVPnvi/BSuTrfTJaW2Gs3Q+YJkRisBvbNWKB2casDbHyvHD08
         geYYdawfgmdh+N+GUhuVcRHYPFgOfQn8xz/n0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732000875; x=1732605675;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Eyx+9in/HQFchdWYfQyVaWbKUcXPbHYEL1OWiH5aBP4=;
        b=MN6InCcAydPCiGEW9V1SHPsMDBe8i0FoALFUgH9zYqRkq4NU3yxoBIl6fs5q88lUIX
         SDMVmO/PQziHHKuElyTzdlWAMDDTWYvFDtXF41AOqD8t3wTuFDzrFAen4CKurGfpw503
         TJDHZIbKzQe/V69YSZEHPivDH2BEMruPnToWLlsGowMylpoSWHiB/webYkPEdQeMFBNU
         IHkKE0NVFzMLsIw++X3UUSLTBf1U04o4y8O2Ab/niGMx4W6IYgYrM994Our6/+aV5c7g
         ql6+MrO5OLIUKWFWXdnsQzZ7ameZvfbZTtPruWt1a34FOVFT7tQCtjGPaJpFvdcczEBK
         o9kw==
X-Gm-Message-State: AOJu0YzxHv8SD0zcDHhNS7eX0q+PA4IiR2mBf8coqKJTXyay0p2sbc+4
	J4Pi9bvp+N2A1UbQYq2RWsolJg4i2LKo9QHuMThioz2URYPeoxya53E9PLOc1A==
X-Google-Smtp-Source: AGHT+IE8NzADorKVHeq5Bw9SIPLPudEHsKk/E9RPk636fHjChjYwBWoLJcm0pCwpZnFlUeKeomsUjw==
X-Received: by 2002:a17:902:e54f:b0:212:37e:3fcd with SMTP id d9443c01a7336-212037e488fmr124581995ad.56.1732000874945;
        Mon, 18 Nov 2024 23:21:14 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:5534:f54c:1465:9438])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-211d0f346d7sm67654955ad.138.2024.11.18.23.21.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Nov 2024 23:21:14 -0800 (PST)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv1 3/8] zram: remove entry element member
Date: Tue, 19 Nov 2024 16:20:41 +0900
Message-ID: <20241119072057.3440039-4-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.47.0.371.ga323438b13-goog
In-Reply-To: <20241119072057.3440039-1-senozhatsky@chromium.org>
References: <20241119072057.3440039-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Element is in the same anon union as handle and hence
holds the same value, which makes code below sort of
confusing

    handle = zram_get_handle()
    if (!handle)
	element = zram_get_element()

Element doesn't really simplify the code, let's just
remove it.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/zram_drv.c | 23 +++++------------------
 drivers/block/zram/zram_drv.h |  5 +----
 2 files changed, 6 insertions(+), 22 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 987d72f2249c..e80b4d15b74b 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -112,17 +112,6 @@ static void zram_clear_flag(struct zram *zram, u32 index,
 	zram->table[index].flags &= ~BIT(flag);
 }
 
-static inline void zram_set_element(struct zram *zram, u32 index,
-			unsigned long element)
-{
-	zram->table[index].element = element;
-}
-
-static unsigned long zram_get_element(struct zram *zram, u32 index)
-{
-	return zram->table[index].element;
-}
-
 static size_t zram_get_obj_size(struct zram *zram, u32 index)
 {
 	return zram->table[index].flags & (BIT(ZRAM_FLAG_SHIFT) - 1);
@@ -873,7 +862,7 @@ static ssize_t writeback_store(struct device *dev,
 
 		zram_free_page(zram, index);
 		zram_set_flag(zram, index, ZRAM_WB);
-		zram_set_element(zram, index, blk_idx);
+		zram_set_handle(zram, index, blk_idx);
 		blk_idx = 0;
 		atomic64_inc(&zram->stats.pages_stored);
 		spin_lock(&zram->wb_limit_lock);
@@ -1496,7 +1485,7 @@ static void zram_free_page(struct zram *zram, size_t index)
 
 	if (zram_test_flag(zram, index, ZRAM_WB)) {
 		zram_clear_flag(zram, index, ZRAM_WB);
-		free_block_bdev(zram, zram_get_element(zram, index));
+		free_block_bdev(zram, zram_get_handle(zram, index));
 		goto out;
 	}
 
@@ -1540,12 +1529,10 @@ static int zram_read_from_zspool(struct zram *zram, struct page *page,
 
 	handle = zram_get_handle(zram, index);
 	if (!handle || zram_test_flag(zram, index, ZRAM_SAME)) {
-		unsigned long value;
 		void *mem;
 
-		value = handle ? zram_get_element(zram, index) : 0;
 		mem = kmap_local_page(page);
-		zram_fill_page(mem, PAGE_SIZE, value);
+		zram_fill_page(mem, PAGE_SIZE, handle);
 		kunmap_local(mem);
 		return 0;
 	}
@@ -1591,7 +1578,7 @@ static int zram_read_page(struct zram *zram, struct page *page, u32 index,
 		 */
 		zram_slot_unlock(zram, index);
 
-		ret = read_from_bdev(zram, page, zram_get_element(zram, index),
+		ret = read_from_bdev(zram, page, zram_get_handle(zram, index),
 				     parent);
 	}
 
@@ -1742,7 +1729,7 @@ static int zram_write_page(struct zram *zram, struct page *page, u32 index)
 
 	if (flags) {
 		zram_set_flag(zram, index, flags);
-		zram_set_element(zram, index, element);
+		zram_set_handle(zram, index, element);
 	}  else {
 		zram_set_handle(zram, index, handle);
 		zram_set_obj_size(zram, index, comp_len);
diff --git a/drivers/block/zram/zram_drv.h b/drivers/block/zram/zram_drv.h
index 134be414e210..db78d7c01b9a 100644
--- a/drivers/block/zram/zram_drv.h
+++ b/drivers/block/zram/zram_drv.h
@@ -62,10 +62,7 @@ enum zram_pageflags {
 
 /* Allocated for each disk page */
 struct zram_table_entry {
-	union {
-		unsigned long handle;
-		unsigned long element;
-	};
+	unsigned long handle;
 	unsigned int flags;
 	spinlock_t lock;
 #ifdef CONFIG_ZRAM_TRACK_ENTRY_ACTIME
-- 
2.47.0.371.ga323438b13-goog


