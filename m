Return-Path: <linux-kernel+bounces-243052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B20A9290FA
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 07:01:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1A631F232DC
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 05:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1BAD1292CE;
	Sat,  6 Jul 2024 04:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="elvGz2Ry"
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 590CC7D3E3
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jul 2024 04:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720241847; cv=none; b=nyfptZMelJkW9GQx6vjeB8g1OI/JkapYh/5AZkXvHfgip7LoJR3sDjjaIPVBDZMAhWXYrZcJo47kx7p/CyKJiiGpwE/1cIgnFggf9VT31RYgqoJKOtZA2N0bd5Ag3XXrIfhmuqjnlAMBAFLls2ykIMhTU+Raa8iThCLReh2o5Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720241847; c=relaxed/simple;
	bh=CIHSUmN+DvzEBm09tbVS8h6+ak9GEa6XzAMkK9GfmXk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ws4hsOPlpGnMLCK5IpMnRZCss+vCZiUPFyjMKDMDfcXP85tTk63lyhFTIQHNiPPuDUqYFclsxXJNciXSgYaOwMDZ0zwnvOIcS+0qyHP4pYFCPWoDvAESUG5wMIK6X/jm1YsQDVyebHnY/dWdJ6K0Yi7v+N5nKm1ZabtD25Ut++U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=elvGz2Ry; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-25e43dda1edso800691fac.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2024 21:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1720241845; x=1720846645; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v8IN/hx22BiZG6EnuKDsYGsQS+lcVx3TaUmIhHbV3gc=;
        b=elvGz2RyO08x7rH7SL0cvghRDOdjAJ8kzjT4ZyeYzOB0HTHWVhNcinbA8bfoVK6qPh
         GGIt0DUkk4fbGDwXbz5RoxucZUQcSUmlLC9T2IftcIZ/tLGjSxkcpkkInpP8rANCgRwf
         wxe4aYdPb6xd5EdrINc8z8/uGTIyny+VNqWfE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720241845; x=1720846645;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v8IN/hx22BiZG6EnuKDsYGsQS+lcVx3TaUmIhHbV3gc=;
        b=oK6Mii2zcpd89F0nfbOmvUyu9a9qGmYe7/6Bc5zk24V3zVmzbLmAOpXFTmLWp9LY9w
         cHSpsUkNtPKKAPKzYr74VD3szQSNKbNGCAZHld5eN1Vf1+vu8OE8N2+Xs5jn2r0n1qC5
         k7U/9dRabwaSX7r0+dGT7qKRceCu6hcRUYEZsBhzEajGM7+DUPuu7Rv0FTdWQLW8RmlD
         /ormVHZJRp6Z2aGtDBP5wKehozsipHuUmI1b0z0NU7BnRToOlJTzqpsYZ2t17mBlc0/C
         9fu3T/Bv8L+++ZM4H02/zEDaEQ4HCMWRUWZqv5DUnHjVYWUuRP6s6hQiW6GwSK0rYovC
         B1Xg==
X-Gm-Message-State: AOJu0Yzpz7MZNtgFNFk2OGHD/6YBVHZFF7F1eR2gOvTevqVI7sS+Fu1D
	BxhU9Z4nayVYeH7/6lMnHUVyivupUNHG37lQBOnWlV2vSkzpkT/07bvxhN2oeA==
X-Google-Smtp-Source: AGHT+IGZTyKEwieBJOuqhQF36H6sijD2kGNg62qhcX3VFCCfT5z3hAXjljCfnRoy2azGH+NXeMKX7w==
X-Received: by 2002:a05:6870:63a6:b0:25e:1659:4ce9 with SMTP id 586e51a60fabf-25e2b5a06admr5277027fac.0.1720241845431;
        Fri, 05 Jul 2024 21:57:25 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:88a7:e7d7:713d:ff09])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7623cd854b2sm2784104a12.38.2024.07.05.21.57.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 21:57:25 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv5 16/23] zram: add support for dict comp config
Date: Sat,  6 Jul 2024 13:56:18 +0900
Message-ID: <20240706045641.631961-17-senozhatsky@chromium.org>
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
2.45.2.803.g4e1b14247a-goog


