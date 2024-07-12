Return-Path: <linux-kernel+bounces-250186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12E8092F502
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 07:24:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 964251F226B5
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 05:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3165113777A;
	Fri, 12 Jul 2024 05:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="erYCX4dk"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B82136E37
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 05:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720761582; cv=none; b=mYVk+snrj9oSMC5V4tO8Kd9wD/sJr1Bdiw2wRNeEmDvZ2KXIttc/19FLEkLlrGDa9rSpkk6xTq0JAbL5i+1FrxIlc6LFH5Aoddwd977ivLuq5VGWaiW0mLg+5rp0X6cJ2FrKBrFDxxF0j1Eg5vPrIdiEsZGioC5oZxqjJgKrcQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720761582; c=relaxed/simple;
	bh=FlGdiMWI6JvROGTXYpE5PQUIEqfPgjf2CMa2lPVUXkM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o7VNl+VOUPkxj8zhI8sFYBpKr9GH4inDojFjW7RA/gLkKGooqlTn+SCW/6NOkD5YDm1/KW7ych2XHmG2Xgjs2o1jt3QkwRMcNL+dJWzTCbOii/SKD02WuCaRujCx6Ysx0B5h0diNJBS4yqdSl0piHeDE7DrmD9MZqUriOqCheHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=erYCX4dk; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-70afe18837cso1278506b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 22:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1720761580; x=1721366380; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3iaMWnY0DA8eKpdYL2hJc069euaYS8s1eesoaSk2ud8=;
        b=erYCX4dkQBeuDKDoIKWZLbzFi5bfNflzqAKpH8v44HZ1VZakWDEqzFAQtj0icDsBUb
         zIYQXjUFnxmqRQnJmp9TPASOp130jaGnjoPqHJ5FoBbl7p/MFzId8o4DTWP/55Vdr8/+
         gHpT190xJOkoXepyHoReY2r7vXqvuOrW1eg9E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720761580; x=1721366380;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3iaMWnY0DA8eKpdYL2hJc069euaYS8s1eesoaSk2ud8=;
        b=SJ8Y/IVuIdSJfU+pSt7Wj9F2jBl+p0H1gTeu9exaFbCghrLR6Gs8F4aI3MajUA6xNm
         hsX+PGgU9o2oUh86AOW02dqVp4AS4d2tdc+LU4Yfd1rPXfCaKvP835bsO7C0MpWxdcqt
         Sxz4SyswIAGwC2MVXTq30xPIVzhlACHih74o55Kve5/M5Wo21PA2REdhGqlZPIomunmv
         42fIOIx4AblosZtlLtXSjSdfvsEFwTDz2wg7N9m0AsNyVQX+co6TRLIVszmyJwLQiL3p
         aF0hxOreCk+lkHAeL3jdlo+BOfCPjMzxAioVT3Ct7EGfVFAkh65l3EdlC4Iwi/RyKU2b
         2aVQ==
X-Gm-Message-State: AOJu0Ywc6sQHeVv2RdXzVJ7IM9xkNQ4h2SRP+q5bpcrLnKWJQkzMrno3
	467HZgTd0gOm6aRit6g1LhDBjIC59LFih0qgWrnDf8hZAie64ornbBwsSJD2UA==
X-Google-Smtp-Source: AGHT+IE1+8eLPnxPSIoGAKCHwJ7NFEar2HnHMDldY9NBO/A0MAgi7dgMkgox3FcO7Tmi9xQc7B57Fg==
X-Received: by 2002:a05:6a00:1748:b0:70a:f0a3:dbc2 with SMTP id d2e1a72fcca58-70b43623fd1mr10749682b3a.30.1720761580125;
        Thu, 11 Jul 2024 22:19:40 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:15f3:5252:ec56:52ae])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b43967851sm6553436b3a.109.2024.07.11.22.19.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 22:19:39 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH v6 16/23] zram: add support for dict comp config
Date: Fri, 12 Jul 2024 14:18:27 +0900
Message-ID: <20240712051850.484318-17-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.45.2.993.g49e7a77208-goog
In-Reply-To: <20240712051850.484318-1-senozhatsky@chromium.org>
References: <20240712051850.484318-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Handle dict=path param so that we can read a pre-trained
compression algorithm dictionary which we then pass to the
backend configuration.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/zram_drv.c | 60 +++++++++++++++++++++++++++--------
 1 file changed, 46 insertions(+), 14 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index a2c23ca033b5..d471ec14c76a 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -33,6 +33,7 @@
 #include <linux/debugfs.h>
 #include <linux/cpuhotplug.h>
 #include <linux/part_stat.h>
+#include <linux/kernel_read_file.h>
 
 #include "zram_drv.h"
 
@@ -998,8 +999,34 @@ static int __comp_algorithm_store(struct zram *zram, u32 prio, const char *buf)
 	return 0;
 }
 
-static int comp_params_store(struct zram *zram, u32 prio, s32 level)
+static void comp_params_reset(struct zram *zram, u32 prio)
 {
+	struct zcomp_params *params = &zram->params[prio];
+
+	vfree(params->dict);
+	params->level = ZCOMP_PARAM_NO_LEVEL;
+	params->dict_sz = 0;
+	params->dict = NULL;
+}
+
+static int comp_params_store(struct zram *zram, u32 prio, s32 level,
+			     const char *dict_path)
+{
+	ssize_t sz = 0;
+
+	comp_params_reset(zram, prio);
+
+	if (dict_path) {
+		sz = kernel_read_file_from_path(dict_path, 0,
+						&zram->params[prio].dict,
+						INT_MAX,
+						NULL,
+						READING_POLICY);
+		if (sz < 0)
+			return -EINVAL;
+	}
+
+	zram->params[prio].dict_sz = sz;
 	zram->params[prio].level = level;
 	return 0;
 }
@@ -1020,7 +1047,7 @@ static ssize_t comp_algorithm_store(struct device *dev,
 {
 	struct zram *zram = dev_to_zram(dev);
 	char *args, *param, *val;
-	char *alg = NULL;
+	char *alg = NULL, *dict_path = NULL;
 	s32 level = ZCOMP_PARAM_NO_LEVEL;
 	int ret;
 
@@ -1048,12 +1075,17 @@ static ssize_t comp_algorithm_store(struct device *dev,
 				return ret;
 			continue;
 		}
+
+		if (!strcmp(param, "dict")) {
+			dict_path = val;
+			continue;
+		}
 	}
 
 	if (!alg)
 		return -EINVAL;
 
-	ret = comp_params_store(zram, ZRAM_PRIMARY_COMP, level);
+	ret = comp_params_store(zram, ZRAM_PRIMARY_COMP, level, dict_path);
 	if (!ret)
 		ret = __comp_algorithm_store(zram, ZRAM_PRIMARY_COMP, alg);
 	return ret ? ret : len;
@@ -1087,7 +1119,7 @@ static ssize_t recomp_algorithm_store(struct device *dev,
 	struct zram *zram = dev_to_zram(dev);
 	int prio = ZRAM_SECONDARY_COMP;
 	char *args, *param, *val;
-	char *alg = NULL;
+	char *alg = NULL, *dict_path = NULL;
 	s32 level = ZCOMP_PARAM_NO_LEVEL;
 	int ret;
 
@@ -1116,6 +1148,11 @@ static ssize_t recomp_algorithm_store(struct device *dev,
 				return ret;
 			continue;
 		}
+
+		if (!strcmp(param, "dict")) {
+			dict_path = val;
+			continue;
+		}
 	}
 
 	if (!alg)
@@ -1124,7 +1161,7 @@ static ssize_t recomp_algorithm_store(struct device *dev,
 	if (prio < ZRAM_SECONDARY_COMP || prio >= ZRAM_MAX_COMPS)
 		return -EINVAL;
 
-	ret = comp_params_store(zram, prio, level);
+	ret = comp_params_store(zram, prio, level, dict_path);
 	if (!ret)
 		ret = __comp_algorithm_store(zram, prio, alg);
 	return ret ? ret : len;
@@ -2029,17 +2066,12 @@ static void zram_slot_free_notify(struct block_device *bdev,
 	zram_slot_unlock(zram, index);
 }
 
-static void zram_reset_comp_params(struct zram *zram)
+static void zram_comp_params_reset(struct zram *zram)
 {
 	u32 prio;
 
 	for (prio = 0; prio < ZRAM_MAX_COMPS; prio++) {
-		struct zcomp_params *params = &zram->params[prio];
-
-		vfree(params->dict);
-		params->level = ZCOMP_PARAM_NO_LEVEL;
-		params->dict_sz = 0;
-		params->dict = NULL;
+		comp_params_reset(zram, prio);
 	}
 }
 
@@ -2057,7 +2089,7 @@ static void zram_destroy_comps(struct zram *zram)
 		zram->num_active_comps--;
 	}
 
-	zram_reset_comp_params(zram);
+	zram_comp_params_reset(zram);
 }
 
 static void zram_reset_device(struct zram *zram)
@@ -2321,7 +2353,7 @@ static int zram_add(void)
 	if (ret)
 		goto out_cleanup_disk;
 
-	zram_reset_comp_params(zram);
+	zram_comp_params_reset(zram);
 	comp_algorithm_set(zram, ZRAM_PRIMARY_COMP, default_compressor);
 
 	zram_debugfs_register(zram);
-- 
2.45.2.993.g49e7a77208-goog


