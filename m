Return-Path: <linux-kernel+bounces-413928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A99A9D20AB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 08:22:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24BFC1F23814
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 07:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D63D419C54C;
	Tue, 19 Nov 2024 07:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OX87otAt"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D446919067C
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 07:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732000880; cv=none; b=tdQ0eIDHg+OZr8MebAr4UIiqjnXbYjqIhqC17XrOgCx2YFBYmLcyzbWmU/nW6GmiyRDw122L9PgFBIGv8ey3zM9pGHCfOGCowYgB4AMRk+oMgGn5jkWeGacD63ToyEelE7VP8y4ckr6VGWaSIvJ9X68soaOQKevsT6iprXohqF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732000880; c=relaxed/simple;
	bh=xS7ygz96qldG8ayzvqJio0pA3KvNFraN+8nnrp/FX8c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PNL4j0M5uw3xAp3Wkf34753n0ajMuo+tLV6FjxvHTufy+fi2dchRfSMHULq6tS/hGA6sI8qyAXmE7RAH3pfbMnAq5wYsEnV7JZ4Gw4bXUwcPwK8AgEhXS9uEUQ/kt2DJNiqlJI2fwZyf0dEWxxyocrkiOqYK+rm68jilrPbSXRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=OX87otAt; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-20cb7139d9dso5419615ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 23:21:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732000878; x=1732605678; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=enpKZhxs9rfiZ+ov5ec779bccoj8XP4Dk6HgEcENBDU=;
        b=OX87otAtkge1SSnZEZVW2zfQwZOlfZfnwz4cylTjyek/n5Oi/oHNYoCfm2OhgnVzob
         JkpQzH8d/2tAbi52tIRgHmoNx0pz7x2xw0N7Ov/cW7nbZfjUfoIO9yWfe04piNR6ppI1
         7wW+4wSEz6cCdgyzunoufk3XDm3zkggqUT70E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732000878; x=1732605678;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=enpKZhxs9rfiZ+ov5ec779bccoj8XP4Dk6HgEcENBDU=;
        b=IsIgZb4b0GzycQ0jNggMZfyAS7Br/27G8UiX8UfMrxwZERh1vzV4lOm8kMSr/nsaLj
         lxCcMZNpciqi8B3aXBhhMjSEux2FR/gZAndf4vA4w74Zs53jWWL8/oLvJLzOmp4F6nRJ
         J9Q/A2KeXRQNInHw+y/EtGSpvv1V7+c58XC/aTFpvEqFIa7K7C3yX6pfQXXuWUCH/Qnw
         R6aJgk4z/BdE9l1HgnLKZLNZPLd8C3077R1MNXz8n9++aZov00z2HnwEOtVVgipBAew+
         RD6e5oo9j+8SM/iVcjSMfaBhHKzI/MsBOTZkve6OvwnxCxIzck+eeUzck4ZdhjzTJqaR
         G5rg==
X-Gm-Message-State: AOJu0YxnKpfUc6QAZ739VxfZORa4NUS3HgBdWJ65DmRcq+0afWZLXYp+
	hKPdkV3GKX/QJx60RPI779CA1f+fRzMIIZzo131RUyD0ES73ovSn+yXt6fFa5XEnn6ntXnXy9Xo
	=
X-Google-Smtp-Source: AGHT+IGKFu9r2P797y7Vi3Fn5YlQyisoXsV4b47g8ABIi7ZipWC2HqYQ6wonNKoQgYcGLeb5sTAqzg==
X-Received: by 2002:a17:902:e852:b0:20c:98f8:e0fa with SMTP id d9443c01a7336-211d0d62aeemr201884045ad.11.1732000878245;
        Mon, 18 Nov 2024 23:21:18 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:5534:f54c:1465:9438])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-211d0dc30cbsm67977765ad.25.2024.11.18.23.21.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Nov 2024 23:21:17 -0800 (PST)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv1 4/8] zram: factor out ZRAM_SAME write
Date: Tue, 19 Nov 2024 16:20:42 +0900
Message-ID: <20241119072057.3440039-5-senozhatsky@chromium.org>
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

Handling of ZRAM_SAME now uses a goto to the final stages of
zram_write_page() plus it introduces a branch and flags variable,
which is not making the code any simpler.  In reality, we can
handle ZRAM_SAME immediately when we detect such pages and
remove a goto and a branch.

Factor out ZRAM_SAME handling into a separate routine to
simplify zram_write_page().

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/zram_drv.c | 37 ++++++++++++++++++++---------------
 1 file changed, 21 insertions(+), 16 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index e80b4d15b74b..f89af45237c9 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1616,6 +1616,20 @@ static int zram_bvec_read(struct zram *zram, struct bio_vec *bvec,
 	return zram_read_page(zram, bvec->bv_page, index, bio);
 }
 
+static int zram_write_same_filled_page(struct zram *zram, unsigned long fill,
+				       u32 index)
+{
+	zram_slot_lock(zram, index);
+	zram_set_flag(zram, index, ZRAM_SAME);
+	zram_set_handle(zram, index, fill);
+	zram_slot_unlock(zram, index);
+
+	atomic64_inc(&zram->stats.same_pages);
+	atomic64_inc(&zram->stats.pages_stored);
+
+	return 0;
+}
+
 static int zram_write_page(struct zram *zram, struct page *page, u32 index)
 {
 	int ret = 0;
@@ -1625,7 +1639,7 @@ static int zram_write_page(struct zram *zram, struct page *page, u32 index)
 	void *src, *dst, *mem;
 	struct zcomp_strm *zstrm;
 	unsigned long element = 0;
-	enum zram_pageflags flags = 0;
+	bool same_filled;
 
 	/* First, free memory allocated to this slot (if any) */
 	zram_slot_lock(zram, index);
@@ -1633,14 +1647,10 @@ static int zram_write_page(struct zram *zram, struct page *page, u32 index)
 	zram_slot_unlock(zram, index);
 
 	mem = kmap_local_page(page);
-	if (page_same_filled(mem, &element)) {
-		kunmap_local(mem);
-		/* Free memory associated with this sector now. */
-		flags = ZRAM_SAME;
-		atomic64_inc(&zram->stats.same_pages);
-		goto out;
-	}
+	same_filled = page_same_filled(mem, &element);
 	kunmap_local(mem);
+	if (same_filled)
+		return zram_write_same_filled_page(zram, element, index);
 
 compress_again:
 	zstrm = zcomp_stream_get(zram->comps[ZRAM_PRIMARY_COMP]);
@@ -1719,7 +1729,7 @@ static int zram_write_page(struct zram *zram, struct page *page, u32 index)
 	zcomp_stream_put(zram->comps[ZRAM_PRIMARY_COMP]);
 	zs_unmap_object(zram->mem_pool, handle);
 	atomic64_add(comp_len, &zram->stats.compr_data_size);
-out:
+
 	zram_slot_lock(zram, index);
 	if (comp_len == PAGE_SIZE) {
 		zram_set_flag(zram, index, ZRAM_HUGE);
@@ -1727,13 +1737,8 @@ static int zram_write_page(struct zram *zram, struct page *page, u32 index)
 		atomic64_inc(&zram->stats.huge_pages_since);
 	}
 
-	if (flags) {
-		zram_set_flag(zram, index, flags);
-		zram_set_handle(zram, index, element);
-	}  else {
-		zram_set_handle(zram, index, handle);
-		zram_set_obj_size(zram, index, comp_len);
-	}
+	zram_set_handle(zram, index, handle);
+	zram_set_obj_size(zram, index, comp_len);
 	zram_slot_unlock(zram, index);
 
 	/* Update stats */
-- 
2.47.0.371.ga323438b13-goog


