Return-Path: <linux-kernel+bounces-439400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7CAF9EAEBC
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 11:55:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0DC528BBFC
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 10:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C34922153C8;
	Tue, 10 Dec 2024 10:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HxTs3O4o"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F47C2153C3
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 10:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733828081; cv=none; b=qX+jjcaLfGp/hZdnEK8vQCLrcFNrgfzLEba3/04ZAqgsZIh0JnUcbHb3l0cfxwaDzyxCFHRNN2dEy0JAv5dlI+SRPA3aE81GEN/hyr+UNhAdl2Qd1ayo0iNZmcc1KDmwC5pdVDzVVBPQElTD/LnYj/05yJbK1E63WgAac4pSx88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733828081; c=relaxed/simple;
	bh=wx8WBB+LSpRt7NmJATPrFzDkMQWmhlNgUIErDvjyDlQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FDhyhsa8x+XT3SjFvdxsnyCVw0zKiu6vObUcQkx8zqADb2T2g5VIt6TmxMJC40VOGDhUX58RpP/dg85SeerPfvhLgsBhOIh/EF7x+IX3gj8XyBZDf1zQiMpx67V+k1KonINC/OrrorXlKRzX4VqlzITsAxQYS79m9bo9/djGwPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=HxTs3O4o; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-725ee27e905so2181366b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 02:54:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733828079; x=1734432879; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iKwO52T3yZJ2DDhYKob9Oz5PyVqqD2cyOj11BfMuDq8=;
        b=HxTs3O4olFPjXNsQmlQGvwinB1CoesiavUQScBHAEnM1M444bHMxjJW+qOCL2t7K3u
         BLe80EpFysr5sciAxP8k6BYMdJjBJJQCzDwbtRSwqiSNi7hlASd2OSfbbySaqCe+8H/O
         +hVfkffq6PowWMlc3z8IVggtchV1LwuN9POXw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733828079; x=1734432879;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iKwO52T3yZJ2DDhYKob9Oz5PyVqqD2cyOj11BfMuDq8=;
        b=TjEZYplg+/MANIHdGa6h7Cwikp11OJBi2aa7Y/n0SuZvrvuh/ehEbRu8rR9pUiWL/L
         W8Hiw/0zAYF2/mkSJnzJprMCYqYKYNdoEL4gLOHo3xErSHm0cIoE2kY1XWub0kkhadnQ
         kXMYQnBiFr3rq26BlaLuFvMNe+cf7xSaiMl+yqReIB43RAPQdvHPvWGTEjET25owi0kM
         AEJSApUllvbD9bfX/cQ4DA3eB7CWNbZ4AdhgjDoAsO/QhuG1h2ztAry+MGZZigYk6Gxd
         d2PQX61uEcFQnqmrMFsX5pADNycmiBJ2W0narnw7w659E0bnKq4i9ZkIak9xMdHME3tf
         5sbA==
X-Forwarded-Encrypted: i=1; AJvYcCX7U6Le6/LDKsKcIpnTOv9dKMy5xJB1Az64Pp4jacSJT2TusztArqdG4uuMVCyTBcIsPXZt1ZXvt2LUDfo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXqVrq7kfoK+5s4v2UrEWC7SwVP4/qmneXlZUwdy2xpqDHic2B
	sSwqcsKLX7WB5ccXltzlDy8N3y4Cz/mQV1+gXtp4Qkb4XZ3hWL9kZLF7gkbHpA==
X-Gm-Gg: ASbGncuU53kEJQHF0uxJdosKV4tt10a7iZJaQrwLLVYMoTj3l7jOOOlOC2eMdABgShw
	6DN53C1zvsvrNstdbQr+bNHW3Tx2biX4MdqoWhJ8JfRGArEAAfZCOTc6YLfi81oZetFBp4S6WOM
	QBMWxhNPxMuO6R4Ot5/QztkKDcXjfNen4mFse9mrYpJOx0V/Uq20AtLxmNqXDA6EtniB/XrpZ0q
	/rCL1cz1mb06wnE1OPPfTDwm99p7xpNLN2HssRoNxEB58NRqXFSLVJd
X-Google-Smtp-Source: AGHT+IErRXJCOaXLeRUpG4Hl6rEasN4Tvyr0d9JMgPgdvJdwPKXGSzgkjjF0vi2lsxTdmpa1OqeSmQ==
X-Received: by 2002:a05:6a00:138a:b0:728:e906:e446 with SMTP id d2e1a72fcca58-728e906e6a4mr346027b3a.24.1733828078853;
        Tue, 10 Dec 2024 02:54:38 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:4d97:9dbf:1a3d:bc59])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-725e4c2defasm4447992b3a.120.2024.12.10.02.54.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Dec 2024 02:54:38 -0800 (PST)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Minchan Kim <minchan@kernel.org>,
	linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH 3/6] zram: remove entry element member
Date: Tue, 10 Dec 2024 19:53:57 +0900
Message-ID: <20241210105420.1888790-4-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
In-Reply-To: <20241210105420.1888790-1-senozhatsky@chromium.org>
References: <20241210105420.1888790-1-senozhatsky@chromium.org>
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
remove it.  We already re-purpose handle to store the
block id a written back page.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/zram_drv.c | 23 +++++------------------
 drivers/block/zram/zram_drv.h |  5 +----
 2 files changed, 6 insertions(+), 22 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 174b4053189b..f68916527846 100644
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
@@ -879,7 +868,7 @@ static ssize_t writeback_store(struct device *dev,
 
 		zram_free_page(zram, index);
 		zram_set_flag(zram, index, ZRAM_WB);
-		zram_set_element(zram, index, blk_idx);
+		zram_set_handle(zram, index, blk_idx);
 		blk_idx = 0;
 		atomic64_inc(&zram->stats.pages_stored);
 		spin_lock(&zram->wb_limit_lock);
@@ -1502,7 +1491,7 @@ static void zram_free_page(struct zram *zram, size_t index)
 
 	if (zram_test_flag(zram, index, ZRAM_WB)) {
 		zram_clear_flag(zram, index, ZRAM_WB);
-		free_block_bdev(zram, zram_get_element(zram, index));
+		free_block_bdev(zram, zram_get_handle(zram, index));
 		goto out;
 	}
 
@@ -1546,12 +1535,10 @@ static int zram_read_from_zspool(struct zram *zram, struct page *page,
 
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
@@ -1597,7 +1584,7 @@ static int zram_read_page(struct zram *zram, struct page *page, u32 index,
 		 */
 		zram_slot_unlock(zram, index);
 
-		ret = read_from_bdev(zram, page, zram_get_element(zram, index),
+		ret = read_from_bdev(zram, page, zram_get_handle(zram, index),
 				     parent);
 	}
 
@@ -1756,7 +1743,7 @@ static int zram_write_page(struct zram *zram, struct page *page, u32 index)
 
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
2.47.1.613.gc27f4b7a9f-goog


