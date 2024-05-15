Return-Path: <linux-kernel+bounces-179560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F64D8C6171
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 09:19:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35DA41F21001
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 07:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5CBB45970;
	Wed, 15 May 2024 07:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XOXQbRcc"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 146635F47D
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 07:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715757442; cv=none; b=ecYdz3gbDhrUkL7tWEaw3C67wFIiYP9XadNBP7D6lCOd+f+wv4Qmqw8vagVYjtvGRdKVUde45BlTG8jbxSwnv4VJp+wuDtIrzYvDftaabGAMuYt6TzszLhl3hCEr5jVUVoOvaKfO5YoDjnOQmvCCQP2P3XHRKqJFjXhuK8z0DaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715757442; c=relaxed/simple;
	bh=fkmGnp5H4sYk5AcEucbfVYS4PjNz7ma3EYQ0ecKZnDQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jLPXX3HKDFmyJAwelmpFxprrQm81SxsMK+A679ObErPNTu3GFahfk0PK7cBtZwxFtKPspRWGOR19iKs1GkQQmcJHiaaZpkXNAzxP+tHhAKzFr4oFARSG778SKK9ePJQPGHHJV2l8iLqvEzGBSpZGdIJyvlvOSbjsjEzQP6RsUFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=XOXQbRcc; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1ed0abbf706so47979145ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 00:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715757439; x=1716362239; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0eIYrOQ3BkMXJCk6zuaDE2ECawMW63bMTlaOVOjCrZU=;
        b=XOXQbRcc/5Eftf81qGGiSFwKljbAd4Yaidd1Ll+OYJc1YSaOujkIsUt95xcblTUgGa
         V+P41TKB3jvve5g/CeVM5fTaP+t/MKEeA0RT2uJbXUSzOVHZVgd4zCVkX4ygALurVlqO
         1SLZeoSzKdm7kodbWBX5OvYelcO4/ssndEb50=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715757439; x=1716362239;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0eIYrOQ3BkMXJCk6zuaDE2ECawMW63bMTlaOVOjCrZU=;
        b=iihMZbhxOJnEsPKIw3SaINnB4koulYEvXprnDSeJbeDu0cM0JGcmsnfNSzyTPzTbdj
         q7TQffQ/bmCuusZHrqe939Io5kSuqtMHofnckLGA+4jz7vIcaurNLONfGR6QG3e5n0EY
         w1mkcRanf1Vv1fIoJRuicxJ97pfH9LE23AIJoFQKSpvB0cWBMp71TuYhKD4v4tMQ4SLB
         0AvndRZrg3PSePPpu1Y54IC1hsrkSWWpk5RNOIShMs1wjW0T2YDRFPdtlh3KILJsuoIp
         zhvbOyLdLwJZ1k2qjDLEnl68xE5X1KBeDoF7F1hCa5llvkPlocQowB2FEqN2YoE+eZtm
         t3dw==
X-Gm-Message-State: AOJu0YyWhjhFcryy3Q6msxwyXg6m1aHXRxWb747jI5Gs/ar7MjoXZH9U
	7O83yxQsprLUPT8x8q/0Yytet3x9jNa0Qox/UMoUVd8ekm439Vdc8dfTo13APg==
X-Google-Smtp-Source: AGHT+IFvQPQbFdswaG8pKMdD1k7IMUK032+vZt0K46ITPMQuokgurkpbNqiMOKMg6mMbkrns6C8dzQ==
X-Received: by 2002:a17:902:bcc4:b0:1ee:c491:ab62 with SMTP id d9443c01a7336-1ef43d2ea47mr134926055ad.25.1715757439167;
        Wed, 15 May 2024 00:17:19 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:111d:a618:3172:cd5b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0c136d53sm110941605ad.254.2024.05.15.00.17.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 00:17:18 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv4 09/21] zram: check that backends array has at least one backend
Date: Wed, 15 May 2024 16:12:46 +0900
Message-ID: <20240515071645.1788128-10-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
In-Reply-To: <20240515071645.1788128-1-senozhatsky@chromium.org>
References: <20240515071645.1788128-1-senozhatsky@chromium.org>
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
index 2a38126f4da3..d49791f724e9 100644
--- a/drivers/block/zram/zcomp.c
+++ b/drivers/block/zram/zcomp.c
@@ -209,6 +209,14 @@ struct zcomp *zcomp_create(const char *alg)
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
2.45.0.rc1.225.g2a3ae87e7f-goog


