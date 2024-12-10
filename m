Return-Path: <linux-kernel+bounces-439404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E34439EAEC2
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 11:56:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 325AD2846F1
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 10:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40EC4215782;
	Tue, 10 Dec 2024 10:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DA6Yt8B4"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11356212D84
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 10:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733828092; cv=none; b=tRpuixcCa68eI7/CuwVMesoFMipSpXqtwdPH2zOILthc2qq6Uj1dMCUmrSAswqFwiV2511DJJpqbp4FsDaWNnOfkcBU8IxGbfharhIikEV/zCLSb9Xa/NDwPvKRJaaQSWuUJSkaCN/Bmy2k29fnYo/zLLF1a2IcxJ/fxZQYW7qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733828092; c=relaxed/simple;
	bh=CEN/kcVfPFI0hWfQlsFCYytcqPd64w8A0GpCq1HazDU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j3UF6wBvpBpNKLdSsSBhq56yF3U8Y9MXLsLuMk+qjf7kU0w55Q3+Oac2ajlAWFlG7Q/m+aFpZTvoFHIjun42ptgYWSAtZOZObRtSZOXpv+WDr+40NQwcTJ4g3crU7a91SpfwGRxYm47/6xLZGQsSPWnXXfYmM9C855q/C4L4+z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=DA6Yt8B4; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-7fbbe0fb0b8so3806413a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 02:54:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733828090; x=1734432890; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S4tnLIiWtc+PvEy1ThvlwDe1w/SkjAwqNX6TrEifnoo=;
        b=DA6Yt8B4ylGxxFPLwgXadQZ9YGVDn+sydPUcP9CADgXuSFG2rAjiCuDUPHYFvlHj1t
         47T2F970xTJh+bQRiYIZOvYEdElDRgxm1HVD5HTA5kyR1JWMeHrf0tROzP7u8UmVP8Dx
         gXJm1m8KwuYLX0kZGpE0q6Nd0IviYRPCV7P9A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733828090; x=1734432890;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S4tnLIiWtc+PvEy1ThvlwDe1w/SkjAwqNX6TrEifnoo=;
        b=dSi7QnYCpE3KCFKjHi3sZ91FMy/6wjxK9J5dgLU2KwM1dql47xwiRcHjpOTuarDQ4G
         wT6A5M1mW/PGmbEO6MrAGnzcilNSMLK+CTC9eJ5mWGOb917anXd29EVHuSKQNc3YPhsk
         tZtoQTNe63FXGuYfN9qxyJfZxd7igYCd/gDcB8g0Amz/N+0w5cZ7f2e9ol3Bt2Gsfjnw
         /E1vnHV7QtbplWSvL76XxgoE+xn5KZKHVOCynzroh9TfLmVuFmBT2a7WrRDNXENFzO5q
         cQKbzZN7s4Wj4AWT+srCyHf/m53Rw548Gv/pmgU5UQAvrirE73qjHCybQjuej+v547sb
         ncXQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2hxDEOjIu+UFGS7gccw4PpyMrNEG6Ma2C43DeWtrC81A9V4JwiJq9SfkCBkdCsg3KRMKg2k0/OMFbOYA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoFWKbY3DGDL2vGa39XE9UIhS4ylPHJ36DgqYZdQpbNRnr9jH3
	8CTCSYjk42b/T1acnv2uJlWmc/8SL5/x2/x3ItDiLXA/35Sck7WonM3JZtJN1A==
X-Gm-Gg: ASbGncsVDfCPwhyzTcFgDc0TvLaMqm+71JNXVBhFseAY0UyXvMKkcXHs3CSTcWD0BHs
	CVo7MhxjBdVxBphRkkyYozGPIA+ouxgBOrQu8hav0MxY+sYszxhsG0LEIlkZfmM1KmRwji9Am4d
	qhAPnsrByr7G/L0TAFAvtZ4XfaxgzwtI6DErkImxxCoALVyw/J9YXU7VozBl5tPuzG3p7drjR8l
	BJ5DztxsStjre/6s3yLOCCfBl7JAFFqAsljLIe/NUr+ZVNS/CekG427
X-Google-Smtp-Source: AGHT+IEtUH17pL5ZO8X4frDDTYwgT73IZVyYi0OGKQpyREJpE6VTQ3CiShhX4tdqrx/2yoLwt/OWVA==
X-Received: by 2002:a05:6a20:4322:b0:1e1:b0b7:b059 with SMTP id adf61e73a8af0-1e1b1a7512emr5388144637.3.1733828090489;
        Tue, 10 Dec 2024 02:54:50 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:4d97:9dbf:1a3d:bc59])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-725e701c042sm4140803b3a.200.2024.12.10.02.54.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Dec 2024 02:54:50 -0800 (PST)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Minchan Kim <minchan@kernel.org>,
	linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH 6/6] zram: factor out different page types read
Date: Tue, 10 Dec 2024 19:54:00 +0900
Message-ID: <20241210105420.1888790-7-senozhatsky@chromium.org>
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

Similarly to write, split the page read code into ZRAM_HUGE
read, ZRAM_SAME read and compressed page read to simplify
the code.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/zram_drv.c | 85 +++++++++++++++++++++--------------
 1 file changed, 52 insertions(+), 33 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 18263e4c208e..e4a7191ec13c 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1528,54 +1528,73 @@ static void zram_free_page(struct zram *zram, size_t index)
 	zram_set_obj_size(zram, index, 0);
 }
 
-/*
- * Reads (decompresses if needed) a page from zspool (zsmalloc).
- * Corresponding ZRAM slot should be locked.
- */
-static int zram_read_from_zspool(struct zram *zram, struct page *page,
+static int read_same_filled_page(struct zram *zram, struct page *page,
 				 u32 index)
 {
-	struct zcomp_strm *zstrm;
+	void *mem;
+
+	mem = kmap_local_page(page);
+	zram_fill_page(mem, PAGE_SIZE, zram_get_handle(zram, index));
+	kunmap_local(mem);
+	return 0;
+}
+
+static int read_incompressible_page(struct zram *zram, struct page *page,
+				    u32 index)
+{
 	unsigned long handle;
-	unsigned int size;
 	void *src, *dst;
-	u32 prio;
-	int ret;
 
 	handle = zram_get_handle(zram, index);
-	if (!handle || zram_test_flag(zram, index, ZRAM_SAME)) {
-		void *mem;
+	src = zs_map_object(zram->mem_pool, handle, ZS_MM_RO);
+	dst = kmap_local_page(page);
+	copy_page(dst, src);
+	kunmap_local(dst);
+	zs_unmap_object(zram->mem_pool, handle);
 
-		mem = kmap_local_page(page);
-		zram_fill_page(mem, PAGE_SIZE, handle);
-		kunmap_local(mem);
-		return 0;
-	}
+	return 0;
+}
 
-	size = zram_get_obj_size(zram, index);
+static int read_compressed_page(struct zram *zram, struct page *page, u32 index)
+{
+	struct zcomp_strm *zstrm;
+	unsigned long handle;
+	unsigned int size;
+	void *src, *dst;
+	int ret, prio;
 
-	if (size != PAGE_SIZE) {
-		prio = zram_get_priority(zram, index);
-		zstrm = zcomp_stream_get(zram->comps[prio]);
-	}
+	handle = zram_get_handle(zram, index);
+	size = zram_get_obj_size(zram, index);
+	prio = zram_get_priority(zram, index);
 
+	zstrm = zcomp_stream_get(zram->comps[prio]);
 	src = zs_map_object(zram->mem_pool, handle, ZS_MM_RO);
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
+	dst = kmap_local_page(page);
+	ret = zcomp_decompress(zram->comps[prio], zstrm, src, size, dst);
+	kunmap_local(dst);
 	zs_unmap_object(zram->mem_pool, handle);
+	zcomp_stream_put(zram->comps[prio]);
+
 	return ret;
 }
 
+/*
+ * Reads (decompresses if needed) a page from zspool (zsmalloc).
+ * Corresponding ZRAM slot should be locked.
+ */
+static int zram_read_from_zspool(struct zram *zram, struct page *page,
+				 u32 index)
+{
+	if (zram_test_flag(zram, index, ZRAM_SAME) ||
+	    !zram_get_handle(zram, index))
+		return read_same_filled_page(zram, page, index);
+
+	if (!zram_test_flag(zram, index, ZRAM_HUGE))
+		return read_compressed_page(zram, page, index);
+	else
+		return read_incompressible_page(zram, page, index);
+}
+
 static int zram_read_page(struct zram *zram, struct page *page, u32 index,
 			  struct bio *parent)
 {
-- 
2.47.1.613.gc27f4b7a9f-goog


