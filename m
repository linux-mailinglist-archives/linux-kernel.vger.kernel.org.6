Return-Path: <linux-kernel+bounces-439401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DC1C9EAEBD
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 11:55:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46E711635C1
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 10:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6DC22153E8;
	Tue, 10 Dec 2024 10:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CNeuadsl"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9129D210F6E
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 10:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733828085; cv=none; b=uTc5BvJezrenYeBiI6KowgXH9sCjNESbKkOKeeJieKtO8HGEgqX7BqXb2m+Dxfz9u+bvu60Cmxm9AlhWd4wURnaTLqkQmLEQMu2ADNknbEKNDWh/ARyJNLyqVhOG3B7ZjiW9bgy4bNhXxzR2sn7Bez2LOnv+ukxvDZjLTIyHLg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733828085; c=relaxed/simple;
	bh=ZXBlYIaSsAAGDts7TVkJFRHDXa87VVCI/N5cH9om97w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tHBdcnhirHHkzUI8WGXDnEc3Q27o56aHEamzh7uNO3xqV5O4g8LkQ/drsiBEBrxgyKTnM0Moxmb0Caq4wjIuznWeAEmyRNlUq920k4Xc29vBgLn35T2ZkShkfnYrkj4tJAQmkwkYkUcTDUEtpLretN0racgd0DCe2EjsjI9Ok1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=CNeuadsl; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2161eb94cceso24188235ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 02:54:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733828083; x=1734432883; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5nJ15+aC3WpUqIo+C9NRk5n2cCREumGOutUYIZdyZx0=;
        b=CNeuadsliFBXGDGsoKl91pq0yIqqPKVfPYCOluz8uuAkQcZW+fotkM2sIFk+ZyvidF
         bUh41rLpuGJgPz6UDVYm2ISKSE9kOiJJu1T6zAfkSIBWf3iWaHDjYDQlGD0I3RdWMuQN
         MJufXlJ7mAaDBpYoJX3H+nJzoaf8/8wNOlMV4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733828083; x=1734432883;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5nJ15+aC3WpUqIo+C9NRk5n2cCREumGOutUYIZdyZx0=;
        b=WF0vDFCcEQ5edKTemgxzf082f5+IBUckR2LyJjqzP/vjuLtt4B1CAAA2ppg84CxW/4
         06K3rSd+Mz9FS0hMKkeHWnhWu6ubmiemwSLehWE2nqVj6uVXad47qiYPu3qzLvEC1IUD
         NUibBQbJiuWbWruTEcLQIYnp5GUzdx3Dj2nUG4GwrS8lV6N6YG1SZfaFI1B0YnQljmLZ
         G1JIOeVUuO2cas19gM1lkAHoOIl7N2y6bvkg5D+soUILUwOUpO1A/bfrx4ESRWfhZcf0
         TEYsN8tGvadrlxP5Aji1/skMaT2tcO83INYdFNr/HggLSI5QCB+yhHmVAeddGCZ1TyDn
         Oysg==
X-Forwarded-Encrypted: i=1; AJvYcCVVgTK4ZEYhjKcPpdgt3Dt8+lsKTy8BV8zvQO9uK+rP4RUos15eGG8KGSFVranzWJrQBmIA6WeZareVyxs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTuNDI2kpk6SF+5yTKMC5II0J6e2dBBegyAGDwd4+gZ24iglFJ
	8pkKOPxqI5e1JNi4B1pREQ2xhKz9m2KcUhhDkCYXvk+EEbHc+Ma7crcE1eAQrw==
X-Gm-Gg: ASbGnctTnmgadA6eB7lx69hkSHrbYXzg8Na+ayvuH5ZCJplljbbpH7TgIDG1IFNWlcH
	nfeIl9MF5PMbIp8RlEfYhrNzGhs09hnw5RqnCLO1xiy10Qn8p3rZaFx2bAhh5yaxvO7yn3Khmdq
	ZtkA2/XBRsDYmnf7/717GBq+ohACtOR2kdW3FPU+BdRbA+1WOVyGEE92ZEtLTHI7QBAbdOVkQeQ
	NaSXA4kn3cghYVGTI1daMD8f7LrWWmLnRnUCyrWtvw6j58B/pG/BHLS
X-Google-Smtp-Source: AGHT+IE2oedNmDoWlCU5nbMKOQmVbtBNZZvZVd+r8RjHbSMRaGXyNC66mAg+I+IlsrFSqlWIjfLTRA==
X-Received: by 2002:a17:902:cf11:b0:216:2a5a:89d3 with SMTP id d9443c01a7336-2162a5a8cedmr157330425ad.25.1733828082922;
        Tue, 10 Dec 2024 02:54:42 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:4d97:9dbf:1a3d:bc59])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-21653b0d4f5sm30196395ad.70.2024.12.10.02.54.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Dec 2024 02:54:42 -0800 (PST)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Minchan Kim <minchan@kernel.org>,
	linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH 4/6] zram: factor out ZRAM_SAME write
Date: Tue, 10 Dec 2024 19:53:58 +0900
Message-ID: <20241210105420.1888790-5-senozhatsky@chromium.org>
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
index f68916527846..22c6ab363ae6 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1622,6 +1622,20 @@ static int zram_bvec_read(struct zram *zram, struct bio_vec *bvec,
 	return zram_read_page(zram, bvec->bv_page, index, bio);
 }
 
+static int write_same_filled_page(struct zram *zram, unsigned long fill,
+				  u32 index)
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
@@ -1632,7 +1646,7 @@ static int zram_write_page(struct zram *zram, struct page *page, u32 index)
 	void *src, *dst, *mem;
 	struct zcomp_strm *zstrm;
 	unsigned long element = 0;
-	enum zram_pageflags flags = 0;
+	bool same_filled;
 
 	/* First, free memory allocated to this slot (if any) */
 	zram_slot_lock(zram, index);
@@ -1640,14 +1654,10 @@ static int zram_write_page(struct zram *zram, struct page *page, u32 index)
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
+		return write_same_filled_page(zram, element, index);
 
 compress_again:
 	zstrm = zcomp_stream_get(zram->comps[ZRAM_PRIMARY_COMP]);
@@ -1733,7 +1743,7 @@ static int zram_write_page(struct zram *zram, struct page *page, u32 index)
 	zcomp_stream_put(zram->comps[ZRAM_PRIMARY_COMP]);
 	zs_unmap_object(zram->mem_pool, handle);
 	atomic64_add(comp_len, &zram->stats.compr_data_size);
-out:
+
 	zram_slot_lock(zram, index);
 	if (comp_len == PAGE_SIZE) {
 		zram_set_flag(zram, index, ZRAM_HUGE);
@@ -1741,13 +1751,8 @@ static int zram_write_page(struct zram *zram, struct page *page, u32 index)
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
2.47.1.613.gc27f4b7a9f-goog


