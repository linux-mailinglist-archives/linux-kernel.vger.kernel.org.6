Return-Path: <linux-kernel+bounces-243048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD3D79290F6
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 07:00:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 943B7281504
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 05:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94C386BFBA;
	Sat,  6 Jul 2024 04:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AOGMVkXi"
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5904955896
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jul 2024 04:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720241838; cv=none; b=QAe2hEPF1i+2gTivu+P+OijHizDqyV8qexY03DSC/hdmMZjRbhIapCpXWxfiDOBQdoSPXn1MiQXEiJLhKN5bEzKA3uL6LhoGY4XFF2O85BCgBKPUzOwfsHG2ULb0d+TARL8k599zzZxHRZCZ7GKpKOJczEfCrDYcDqc0fd29nsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720241838; c=relaxed/simple;
	bh=MtTIDYOtiMGws4Y9w3SNbG9mqa/kEzm7Lktyux70ZbI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R1NTulYnNc4BsnVaF8R8qSQ6ZjfvE18ePVt5o51n55wY8EiV8asuoCaPpgdsFUb/27yxhX9yYdJMnc1b8z5SahAumR/an0to3ko0U1nrdvDJ+z369Ph5+cLBziP3a2CLy0L+c8gv1ZoCqZid77HRRKacWfZKVp1qIInI7vTL7hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=AOGMVkXi; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-64b417e1511so21411387b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2024 21:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1720241836; x=1720846636; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AAvxUDrK8ysZTYfpY5kDw/1zXA0+zlpvPoo9FszJCFE=;
        b=AOGMVkXiMukBv/lDCd67SRnNQehqNA2Muud5QONZmTtr9hnBIBvhUM1Lx8scPdePsx
         S+9ohIuaufBOKRa4+Jw09D0CR0g5Aa/q4htsOAUnJANNQ02Puepnaft6gzW02A7bilHf
         4DIJtWe1CkU+MPdn6yiNs4FjOeOklSRZpka6s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720241836; x=1720846636;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AAvxUDrK8ysZTYfpY5kDw/1zXA0+zlpvPoo9FszJCFE=;
        b=MvL2bL1MexsbqIHJrBiaEczeYgbqvlxUyg5p5aBJtSMAzBOE9rmGgHbCAiJX/c1H1m
         35uELQTVCofpnNyVo895MOx5KMZ+zCYLibIO+n1MpKbm2vJZEyACVTGQn5BzXzgkYRbD
         QYBNm4QItTHQ+f7XFem/7FBsOPvhn76YM75/VM5bJBdDc96RIASum2mbACdPCzUI0vik
         ottfsKEMaMShkY+BbliECRuXULRPxntCutObt1PU+SPUYuB2xRd3bb2FqUHv4z1VfcdD
         BUBtnUInyBk4dTAY3MQqHdKbi9dZ0E5D8nwt0MDCN1X+4vb80fyOKh8mWCCk+dzYgNwd
         fCgQ==
X-Gm-Message-State: AOJu0YzgXRAyUx4Jz7S7DVfAOJRFDaYg2yCXY7HoFDX2SgpCSiWvgkqb
	EKki8DE8LGQogAgtNRmEULsnBTqIHhwCa4YKjmyFwI1p0JyhS5F2QMI7oMvhqg==
X-Google-Smtp-Source: AGHT+IH0w+48P4lsEfTcbcYPgK0q6CF033pwSERgXciwKxFtduwKXQXU9dlNHxwqtQDKqXMk1QWSTg==
X-Received: by 2002:a05:690c:4d82:b0:62c:e6c0:e887 with SMTP id 00721157ae682-652d543fdbbmr79682517b3.9.1720241836335;
        Fri, 05 Jul 2024 21:57:16 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:88a7:e7d7:713d:ff09])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7623cd854b2sm2784104a12.38.2024.07.05.21.57.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 21:57:15 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv5 12/23] zram: check that backends array has at least one backend
Date: Sat,  6 Jul 2024 13:56:14 +0900
Message-ID: <20240706045641.631961-13-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
In-Reply-To: <20240706045641.631961-1-senozhatsky@chromium.org>
References: <20240706045641.631961-1-senozhatsky@chromium.org>
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
index ddc19853ea96..40e035468de2 100644
--- a/drivers/block/zram/Kconfig
+++ b/drivers/block/zram/Kconfig
@@ -15,12 +15,6 @@ config ZRAM
 
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
@@ -51,6 +45,19 @@ config ZRAM_BACKEND_842
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
index 280dcc48fb5e..1888d4dd9245 100644
--- a/drivers/block/zram/zcomp.c
+++ b/drivers/block/zram/zcomp.c
@@ -191,6 +191,14 @@ struct zcomp *zcomp_create(const char *alg)
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
2.45.2.803.g4e1b14247a-goog


