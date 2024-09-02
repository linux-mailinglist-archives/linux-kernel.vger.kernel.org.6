Return-Path: <linux-kernel+bounces-311157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE3A3968586
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 13:00:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78F901F23AE0
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 11:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40F761D61AD;
	Mon,  2 Sep 2024 10:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OjU/pEHE"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 345481D6183
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 10:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725274649; cv=none; b=msMVIJd/ZKuv4ld+P/l2bP9M3Cj2LEY+YJxLkxAaFobrDkJW6RXiHM5MIobkQXvboznofXbHdv0SlwwUwt0q/xHYuHnXIOKqfASph7PoBi0HngEva5KyXdXFv1JIXD/vYAbRFKuurznQH8fRbw0wcfKb49k/vOaQkuFgBQSA4dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725274649; c=relaxed/simple;
	bh=y6oVPY95hI6wp4VX9zDxwmcLDQba2r1t2gOhqRyalgI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZPJqkQyhHeE77Bw2a3jEpwA4/Yf7YRhrU09lgdKfjjOT1qat4XxN88bEvZ8xdeeezA5gfvXR7Htt9nb3cSdqhM4aVU/d7swpZi9tA/d1VPDRmlcfQqKuBSNUCuC2akGOHtoMaSNKDwgxRsCexsygjgBIKNO91qShPIdQ1XmRKRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=OjU/pEHE; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7142e4dddbfso3220134b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 03:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1725274647; x=1725879447; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VVkEtaUOd/P2C4s98tzJPKsbzfPdZ+JthmVGTD72tXY=;
        b=OjU/pEHE99ZNLJfBmniiZ0Rv8jGqd9cI65P2A8ov3iASGgkugkv6sjj4l/CIvbEN/M
         2h2qiGPcR8UJP5e0uZWOJUvw11dhG+XIXt7keHFd5hgBiJfendYxP4KrsmtakdyInswu
         r3jfFnUgYJd+Kyf+a8r2mHHdjFwJnJEVX62LY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725274647; x=1725879447;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VVkEtaUOd/P2C4s98tzJPKsbzfPdZ+JthmVGTD72tXY=;
        b=cppBoyoDm7ukcMtWrZW5w8kIr0Ol7MqFceV2Es225q/gcfJxzW3w8YI1aIG8lGHD2R
         tRf5gVCOLRi7kpSKl77v0XveSt65DlY3gEDmw+dXy5/nbidrboPJYybfqj+MJOqi1AWZ
         Y4G6qbgIfnK0QTgOVPU90ZdtHMibfaHgzCWJjlMKwrOj3FLzepOOma5FVASbSplX6JAy
         F74khGicy+WLEPEQXRTt3rf4YGcF+jgaRUriB6ZHAFmUIYV15BlnTERIJMBeXT+YtI2z
         /8OUCe9kNgKYfpEPTcGqgIcWSrUoj+cWpd11zVFa3GKWT8oIIdp3lMXkxttI1g4vUo5G
         O8Ng==
X-Forwarded-Encrypted: i=1; AJvYcCWfIIPXe0jCyaOseSiXhFnkjRUzqAJrMHdcAimY/Bp0wKlR36cE3VK06FS+XMf9iGVVBMaTlZEBjZKQ3Rw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+FtXnuG0141RMAHah63ryOvQizCUTS2BJAE6EWTl7anpyuSS0
	o1rtU3GPBuu3w9JW3jeFmPdk3PZ3hqw+7wiDpSd3lhhcCpBUKJbiXJqqdF2arw==
X-Google-Smtp-Source: AGHT+IFNmfeHi1XlA7HPam38xO45YdgPVufNvpyIcGqlL7D9BOq5m7yQC7SM9L4RPus9T5UB2frDEQ==
X-Received: by 2002:a05:6a00:853:b0:710:7efe:a870 with SMTP id d2e1a72fcca58-717449b2017mr5621187b3a.19.1725274647376;
        Mon, 02 Sep 2024 03:57:27 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:43a1:71e3:7464:e91b])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-715e55a51e9sm6633769b3a.78.2024.09.02.03.57.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 03:57:27 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Minchan Kim <minchan@kernel.org>,
	linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv7 12/24] zram: check that backends array has at least one backend
Date: Mon,  2 Sep 2024 19:56:00 +0900
Message-ID: <20240902105656.1383858-13-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
In-Reply-To: <20240902105656.1383858-1-senozhatsky@chromium.org>
References: <20240902105656.1383858-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make sure that backends array has anything apart from the
sentinel NULL value.

We also select LZO_BACKEND if none backends were selected.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/Kconfig | 19 +++++++++++++------
 drivers/block/zram/zcomp.c |  8 ++++++++
 2 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/drivers/block/zram/Kconfig b/drivers/block/zram/Kconfig
index 1e0e7e5910b8..6aea609b795c 100644
--- a/drivers/block/zram/Kconfig
+++ b/drivers/block/zram/Kconfig
@@ -14,12 +14,6 @@ config ZRAM
 
 	  See Documentation/admin-guide/blockdev/zram.rst for more information.
 
-config ZRAM_BACKEND_LZO
-	bool "lzo and lzo-rle compression support"
-	depends on ZRAM
-	select LZO_COMPRESS
-	select LZO_DECOMPRESS
-
 config ZRAM_BACKEND_LZ4
 	bool "lz4 compression support"
 	depends on ZRAM
@@ -50,6 +44,19 @@ config ZRAM_BACKEND_842
 	select 842_COMPRESS
 	select 842_DECOMPRESS
 
+config ZRAM_BACKEND_FORCE_LZO
+	depends on ZRAM
+	def_bool !ZRAM_BACKEND_LZ4 && !ZRAM_BACKEND_LZ4HC && \
+		!ZRAM_BACKEND_ZSTD && !ZRAM_BACKEND_DEFLATE && \
+		!ZRAM_BACKEND_842
+
+config ZRAM_BACKEND_LZO
+	bool "lzo and lzo-rle compression support" if !ZRAM_BACKEND_FORCE_LZO
+	depends on ZRAM
+	default ZRAM_BACKEND_FORCE_LZO
+	select LZO_COMPRESS
+	select LZO_DECOMPRESS
+
 choice
 	prompt "Default zram compressor"
 	default ZRAM_DEF_COMP_LZORLE
diff --git a/drivers/block/zram/zcomp.c b/drivers/block/zram/zcomp.c
index 94e1c9503267..76d21ee77067 100644
--- a/drivers/block/zram/zcomp.c
+++ b/drivers/block/zram/zcomp.c
@@ -192,6 +192,14 @@ struct zcomp *zcomp_create(const char *alg)
 	struct zcomp *comp;
 	int error;
 
+	/*
+	 * The backends array has a sentinel NULL value, so the minimum
+	 * size is 1. In order to be valid the array, apart from the
+	 * sentinel NULL element, should have at least one compression
+	 * backend selected.
+	 */
+	BUILD_BUG_ON(ARRAY_SIZE(backends) <= 1);
+
 	comp = kzalloc(sizeof(struct zcomp), GFP_KERNEL);
 	if (!comp)
 		return ERR_PTR(-ENOMEM);
-- 
2.46.0.469.g59c65b2a67-goog


