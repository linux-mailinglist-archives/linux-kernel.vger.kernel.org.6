Return-Path: <linux-kernel+bounces-413930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 284939D20AD
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 08:22:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1C421F23C97
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 07:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E60CA19D09C;
	Tue, 19 Nov 2024 07:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cH1kBLfI"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF73B19CD17
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 07:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732000886; cv=none; b=Cp2GbGzZwISF546dK7WVA7eYStHUY8VUtyRrJBNqNMWuxMwzqbfNYv95MS7run+6inFc6ry8+SBMqQdoWMNSRnHl0nZSEURWzoXTN2Kj+GLYBN8yg8k3RudtOOhTM5m6R/NHIbGP+wjnwXdl2xzeCbfwAfmsX7g6Bywuc68wqug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732000886; c=relaxed/simple;
	bh=QZoBI0/NmZPZhWwcjQ/ZUK792oAETFLYk4pewXXZ+jU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ebZgYJJngxI5vnERSLh/W+aniMN9RmSL8i434iHyhKWuxiUM3wKzJYXiSNEsR2s90s4ToJkORvHmoLLhOJbofTvlZuGIJOomSP/B9K+jEiRSA12hDocc1Gw7AQnrjnh9rN9EKuP75WrsILulYUXmsULIEXoFiwdgp9BS0xzvQKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=cH1kBLfI; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-7ee7e87f6e4so2393078a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 23:21:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732000884; x=1732605684; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hh0J+htCkr2Gj1s5kihWh8sqReBGwis+Zxl5bO+P3vk=;
        b=cH1kBLfI7S627hesLmBxpkhCZbuuLv54K6xY+1/lnxNgT5D+QcXR3sYSk54UBzBrD9
         dfgYwG0AI+Sm0187mjSWSZ0Fn7X80VhMXVFxuTHBT52nBnYZAWYKB0sat4l+6iU2IL+n
         nZU8m5YCqPUH8/IabCl6CdBPaRdSoaO2QSU3s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732000884; x=1732605684;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hh0J+htCkr2Gj1s5kihWh8sqReBGwis+Zxl5bO+P3vk=;
        b=rZKUd9uhZqDh/2zo763pqx53FAHZldzLAq00oJefjbn5oLnvKX20K31BqrqBFVjHwS
         3sAvTuyB4hSpSDlxBVSjBns+hZ27jM9S1C9+DHLUEQHG32stnGsNuv+FiRoSxVFzfFNP
         /gaYMK+DQ0g0QRlO+1GZ+xk/voTf8EmWTF7SNB+F7+GbSrq7VHhjAF/XLwix3tye55PE
         PeSXMBE2X1qomXwFLUqbG7qGDJYqXknqf5rH4yXgeVcweHnBIB/Spcy0+/3EscWE8+jS
         FuvAfDMbjslHqlyYFgQ0UsIQN2iRRLuShnGhSsh2aF2M4/hcOGstVc5pfltCa67Ha0+F
         SaaA==
X-Gm-Message-State: AOJu0Yz2MuEU5VnfbDa+Utq2oi+21hC2Dl+ag3PtTCRJMgNyM/MNa9j0
	/q5/4b45p8e1Xmv1rN+Ctjlw70iq63mbaiTj6wO4Lu1LV6fwe/C53rwb2GIGdw==
X-Google-Smtp-Source: AGHT+IG1JymDLGg8WB/V8srdCrB9afMMKLVW52YenEFEkLMOBaJ6xJyBhfnZhwyK7PvnmGZWUg8a/g==
X-Received: by 2002:a05:6a20:748f:b0:1cf:6c86:231c with SMTP id adf61e73a8af0-1dc90b5c503mr20907966637.26.1732000884119;
        Mon, 18 Nov 2024 23:21:24 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:5534:f54c:1465:9438])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-724770eef34sm7475406b3a.8.2024.11.18.23.21.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Nov 2024 23:21:23 -0800 (PST)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv1 6/8] zram: factor out ZRAM_HUGE read
Date: Tue, 19 Nov 2024 16:20:44 +0900
Message-ID: <20241119072057.3440039-7-senozhatsky@chromium.org>
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

Similarly to write, move ZRAM_HUGE read handlig to a separate
function.  This will make more sense with introduction of
multi-handle entries later in the series.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/zram_drv.c | 71 ++++++++++++++++++++++-------------
 1 file changed, 44 insertions(+), 27 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 9101fd0c670f..2b20afcfbb94 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1525,6 +1525,46 @@ static void zram_free_page(struct zram *zram, size_t index)
 	zram_set_obj_size(zram, index, 0);
 }
 
+static int read_incompressible_page(struct zram *zram, struct page *page,
+				    u32 index)
+{
+	unsigned long handle;
+	void *src, *dst;
+
+	handle = zram_get_handle(zram, index);
+	src = zs_map_object(zram->mem_pool, handle, ZS_MM_RO);
+	dst = kmap_local_page(page);
+	copy_page(dst, src);
+	kunmap_local(dst);
+	zs_unmap_object(zram->mem_pool, handle);
+
+	return 0;
+}
+
+static int read_compressible_page(struct zram *zram, struct page *page,
+				  u32 index)
+{
+	struct zcomp_strm *zstrm;
+	unsigned long handle;
+	unsigned int size;
+	void *src, *dst;
+	int ret, prio;
+
+	handle = zram_get_handle(zram, index);
+	size = zram_get_obj_size(zram, index);
+	prio = zram_get_priority(zram, index);
+
+	zstrm = zcomp_stream_get(zram->comps[prio]);
+	src = zs_map_object(zram->mem_pool, handle, ZS_MM_RO);
+	dst = kmap_local_page(page);
+	ret = zcomp_decompress(zram->comps[prio], zstrm, src, size, dst);
+	kunmap_local(dst);
+	zs_unmap_object(zram->mem_pool, handle);
+	zcomp_stream_put(zram->comps[prio]);
+
+	return ret;
+}
+
 /*
  * Reads (decompresses if needed) a page from zspool (zsmalloc).
  * Corresponding ZRAM slot should be locked.
@@ -1532,12 +1572,7 @@ static void zram_free_page(struct zram *zram, size_t index)
 static int zram_read_from_zspool(struct zram *zram, struct page *page,
 				 u32 index)
 {
-	struct zcomp_strm *zstrm;
 	unsigned long handle;
-	unsigned int size;
-	void *src, *dst;
-	u32 prio;
-	int ret;
 
 	handle = zram_get_handle(zram, index);
 	if (!handle || zram_test_flag(zram, index, ZRAM_SAME)) {
@@ -1549,28 +1584,10 @@ static int zram_read_from_zspool(struct zram *zram, struct page *page,
 		return 0;
 	}
 
-	size = zram_get_obj_size(zram, index);
-
-	if (size != PAGE_SIZE) {
-		prio = zram_get_priority(zram, index);
-		zstrm = zcomp_stream_get(zram->comps[prio]);
-	}
-
-	src = zs_map_object(zram->mem_pool, handle, ZS_MM_RO);
-	if (size == PAGE_SIZE) {
-		dst = kmap_local_page(page);
-		copy_page(dst, src);
-		kunmap_local(dst);
-		ret = 0;
-	} else {
-		dst = kmap_local_page(page);
-		ret = zcomp_decompress(zram->comps[prio], zstrm,
-				       src, size, dst);
-		kunmap_local(dst);
-		zcomp_stream_put(zram->comps[prio]);
-	}
-	zs_unmap_object(zram->mem_pool, handle);
-	return ret;
+	if (!zram_test_flag(zram, index, ZRAM_HUGE))
+		return read_compressible_page(zram, page, index);
+	else
+		return read_incompressible_page(zram, page, index);
 }
 
 static int zram_read_page(struct zram *zram, struct page *page, u32 index,
-- 
2.47.0.371.ga323438b13-goog


