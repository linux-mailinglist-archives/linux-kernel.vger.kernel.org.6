Return-Path: <linux-kernel+bounces-412744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9604D9D0E91
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 11:31:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56E10281365
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 10:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 346111946CD;
	Mon, 18 Nov 2024 10:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Y7B4ZCc3"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B7221946A1
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 10:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731925879; cv=none; b=StL1qOFDOn5VTLDV7KswbRum7as3pb7m/oE9M/4KfoIENnwrsHLORqaK58U90ay4t3qQ8TbpscqkcOrRFJic3xAUy/MFPBMmr98yLvJeE213tCYKFasQ18EYQkUVRwfCAZ0VMxbO/uYXcz81Zc3OWzXxdTinPVqy3mQ1GVT41Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731925879; c=relaxed/simple;
	bh=Yz9Nexpl0EVIA2bJU+qi4XgK/SkBCABbsb+hclhAJIc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ao7vidVxTUhuB7VMDub0mkEYkxbzAOtf3zZvjiynoDzODgbqVNdVg9V3xk5iBQrcsewNkFVjfLpBLI7MYRUdfHGCjDWmxydsRWgd8TdcoV0chMG2JF1e3T+4niJj+Gm2908Emat5tc6iqZlPDvbNjXhGRjr8fNjPLGW72ETIetU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Y7B4ZCc3; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2120f9ec28eso6300235ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 02:31:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1731925876; x=1732530676; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f+QCKNKqCnC0lwbQ04xjWB43TgDsU0jXExoWEZYBF2o=;
        b=Y7B4ZCc3nWT+OElFSEXQH+kTmi3UCTI96TotYwML+FFVizsdZlVZfFIKFtGc6kF9xO
         IH4YhNkkyMrbTWVt9xZ7vYItLbTotB0LzeJUkhfL7dWUy3LHyQDSt37fQ2FPKfo2w5N8
         NmJeXL0B89qrkwNtgLfA1Gzb1PycbZhmca7eA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731925876; x=1732530676;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f+QCKNKqCnC0lwbQ04xjWB43TgDsU0jXExoWEZYBF2o=;
        b=QrXltQ3X07LT1PX1ti1fsNY9mqJJJGD7ppOQPabRnzYW9SkC0mVerFYqkN2lcih5VS
         yhmoRWXSOAd47kcimAv14E+PcynTVQZQFWR6IsQYbdJIL5w+f8FeYU8/6+x7wnNt7cdS
         DBvsXtjC38lTNmrjtFsBfj38llZ6RZl0B1596iTebeVX9khDoqK1gw+sCR05Qh9OCtru
         2kUXTKFyt91Q7jp6lPYu8UVz7uDliS6XLsK0mcSwFbDDikf5oqP4sVf9oofy//IouS+c
         1bH0L1YN336k08JeMXEgV+Zk30cVdLyuza7lNP/BKbqZKODgWSCGLajFn0WxNU6tXzEe
         87bw==
X-Gm-Message-State: AOJu0YwwASsYmkkn7bosNWift/XNet5Yj0jlnbcFjjXC1sqgTUAHQ/xy
	DIAAbGhceXLVCTaCPfUo/CC3AdhjpO4sFAzpEwpzW60LVdRSo3EWx+ukcDzyTlAivX0mA7U0BNU
	=
X-Google-Smtp-Source: AGHT+IFOjKJUn7Imh7y1iaNZa2OAFuXSL2vTdjy9vBoribW9ja/Y+3zukd9hwr07nuUCTisIT/gkvg==
X-Received: by 2002:a17:902:d509:b0:212:4b3:1080 with SMTP id d9443c01a7336-21204b3158bmr76843935ad.13.1731925876498;
        Mon, 18 Nov 2024 02:31:16 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:8826:78b8:a8fe:1066])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-7f8c1c644c8sm5600494a12.47.2024.11.18.02.31.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Nov 2024 02:31:15 -0800 (PST)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [RFC PATCH 3/8] zram: remove entry element member
Date: Mon, 18 Nov 2024 19:30:34 +0900
Message-ID: <20241118103054.3191944-4-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
In-Reply-To: <20241118103054.3191944-1-senozhatsky@chromium.org>
References: <20241118103054.3191944-1-senozhatsky@chromium.org>
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
2.47.0.338.g60cca15819-goog


