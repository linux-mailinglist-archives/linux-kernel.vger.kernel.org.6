Return-Path: <linux-kernel+bounces-412747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E7CE9D0F04
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 11:55:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2FDE7B2C0DE
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 10:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0EEA194AD6;
	Mon, 18 Nov 2024 10:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EwbzPl5y"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1322198A35
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 10:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731925890; cv=none; b=RVBrnYxZuwO1qMGkNKGs+e+i/6uOtor3HMqGe/NLgGjHbWlaeahQnEImnU7lK/Mbr3fDMGlqsgRiYUhIIjdrhpAJa/5X5Fi29E9E5r4R4rQVnCt6tQLDJaTVm0XPVqlrfAOGgpMBs0463Yr2q1p+lEz8tC6Kkw3oKnOa9HLF6dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731925890; c=relaxed/simple;
	bh=URZDAqrp93EaHp3z5wCKmGin51pgZg/9Vvo9b4ImMZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N+YcAf018iQ0zIUB1MSbr9Grw4+KWvugtF13s0HL/n9n4qDsVErPVFbuQFygtTkLniPCeqPwVkAiCMuGqyuYaV7jDcfIKXUu7NrbOjdeiOlk1t+5KMs05FDlU1QqxMgenZPBiMdI0jmMID8pN71lLw10mATFpJSGKp/3uIitKZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=EwbzPl5y; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-211a4682fcaso26290995ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 02:31:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1731925887; x=1732530687; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=90w3pZT9FJvUmWsGdeMpl5t+GScBHGHvQ60IcDxysHU=;
        b=EwbzPl5y2Ewa8Z7T3CFoD6o4/YwVNxJH9+wPgkXjXROtjv/OfxKWvrSKXneqW5+w6C
         eLm8+CNBWF/fPBwy99ooXvDNnt258Uz8vLhes2pyy0lvZoh0/EfB/l+8KTcBl7ZhgzUl
         7r/X7GiRFKDOEoYkzDuea9xfwVmU9D5HVeGvk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731925887; x=1732530687;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=90w3pZT9FJvUmWsGdeMpl5t+GScBHGHvQ60IcDxysHU=;
        b=BBIaa6J+96+Y3V33O/LW+n1L1QhbIzyZbGFyF/acijCYbhZ5QV7mv8lu7CiFcN8AU1
         qFSnnESiAR+G2YEqcrcnsoWblC3aOsvlGb7T3/R+bmpkXMZzXd66fi2BmLeClDFNDT4F
         Wivn6/msTlINwtoUuQN0Zk0cHNLIizYSOI96i3UbS4Rs2DlJstG96eE9ZYT6s76q/+gg
         p3MWvj7W8quapTDLuKj4nEwyu1msr+LeHvGsJjpXi6Z4eAwpcOr6cWWQPxbh5vqX78P4
         jynfUZHS7M/K7tPzet6xAp1/zWpdJmldIC30CXTR+VWkPsDsAL1veLkmEk9dqGzwDnys
         j9uQ==
X-Gm-Message-State: AOJu0YwjLX0YuItbT++KtiQT6vnd02EXj2qvNDkSYfCqWCji/Zpz4cxC
	tWoC67uQGgD848aGWOZ3UHAyue+yawWA3xM+n8z2efOpOQdxMEAZ/GmXQQz39bHXu2LcOCoQrJQ
	=
X-Google-Smtp-Source: AGHT+IGx/uWi0Il9dEaPy65pYV4oOs3sdmOEUPIIfBWJ7G3iE5vWr6wc30DSLaD5I+/GGx6VPa0fcA==
X-Received: by 2002:a17:903:32c7:b0:20d:2848:2bee with SMTP id d9443c01a7336-211d0d72d87mr172575205ad.16.1731925887044;
        Mon, 18 Nov 2024 02:31:27 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:8826:78b8:a8fe:1066])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-211d0dc32acsm54573725ad.53.2024.11.18.02.31.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Nov 2024 02:31:26 -0800 (PST)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [RFC PATCH 6/8] zram: factor out ZRAM_HUGE read
Date: Mon, 18 Nov 2024 19:30:37 +0900
Message-ID: <20241118103054.3191944-7-senozhatsky@chromium.org>
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

Similarly to write, move ZRAM_HUGE read handlig to a separate
function.  This will make more sense with introduction of
multi-handle entries later in the series.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/zram_drv.c | 71 ++++++++++++++++++++++-------------
 1 file changed, 44 insertions(+), 27 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 55ffd0534470..745207597e23 100644
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
2.47.0.338.g60cca15819-goog


