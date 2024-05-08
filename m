Return-Path: <linux-kernel+bounces-172842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2AD38BF760
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 09:45:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A61DA1F216A2
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 07:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DF337173A;
	Wed,  8 May 2024 07:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LBgoz7JA"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D6226CDDF
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 07:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715154186; cv=none; b=jNg22n4heI/jPC3dTxXfqwtZfzU47VUoZqzMTWDgfZ3PTLIXVuGxqeykyFjdI6lE+DldXSX4Gk4f0rEOo6oshrWAf3V2kAOEWwQliSZbUCkQ5+/oQjEpY3J28fOTbtTnZhMaam135xvMdPsfXyf0cV87OX/lIwRqcN6VDx//+zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715154186; c=relaxed/simple;
	bh=d4UQf/ZsLZS7cvretx2WXvAFWLig4xky110hNJGk3Zc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hyITmG7nQED/8miqFILPV+kejt17JN30jzmsy7V8PisxiW1ucxoVOs2DCdtiErIaTZyUC0RbupsJ/WBtYDAIL38/JZmLcug40OPtJruS2yaUItumy7sf+W6J0Uj6oxtmM5wnjjDofI70bsV4ycaOb4nTmzcnjRPIVZdJaZgH4is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=LBgoz7JA; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2b27c660174so2729333a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 00:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715154185; x=1715758985; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wIlqiB/ZJyLpyyyQGB102ierEcV1ZXWEtzUdufZbr+0=;
        b=LBgoz7JAaDMFqYFuIPioP2gVlBeVB6J9DYRtY4AmooUSmgIuYR44FKL3IW4VEu1iiW
         0x6d6cxR+buZz13FZ3fNkblRG89yj+kIz05yo6353ydLY+m67WQap6FREyX7weQXuZhQ
         giZD1fjs6XrscGg2Zk6ePfj3oBW5/pi5ttrAg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715154185; x=1715758985;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wIlqiB/ZJyLpyyyQGB102ierEcV1ZXWEtzUdufZbr+0=;
        b=NNkO5cVraWJjvZ0JiVnCmfdGi3O3LOgoftaDoVOuefmGfE4G+bATwsw43IzWfhnafI
         ASy+v7qVDezzNJqrPT4QgrHb/VccS6yQN2bezPOxPEf2Ihr4E0M3fty3igPrrTtIu0iR
         6UIe7277ARCxJfJm7HLgIJ6JM9hLRg0+MyghJrwKcDchP98XrvnzUwaxRQnhzkSY+pCr
         JIexp8NVNs9SCC7W+CSRUYu4fe308jofqDap9VX1AEtjpcEO5qbXjqczDXG7Yhweud4+
         hk5CxU6Nl65w3qIyRPdpiglDYrH5SP31MQtP++Yudwl0fKlmLVPjkJSACXX8O+gkTGHx
         hktA==
X-Gm-Message-State: AOJu0YyapGKejj2aTYfW6eKxc8p+L6OK2uHSBVJdQR/11iLPjHyOPCrJ
	Pby9pI3PQFrG+gm3rt3y5Et4M8YxvcakP4L5hd3c4zq7kd6K8nQrGqKTmgVy5Q==
X-Google-Smtp-Source: AGHT+IF092QUexa8q6Se5sPjVpV2rmvHb1BXFAsCgfpPU65gIEcc7ohGaINcYFa5GBGvAPDdjivYpw==
X-Received: by 2002:a17:90a:b113:b0:2b1:534f:ea09 with SMTP id 98e67ed59e1d1-2b6166bfd77mr1811833a91.23.1715154184927;
        Wed, 08 May 2024 00:43:04 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:ad4d:5f6c:6699:2da4])
        by smtp.gmail.com with ESMTPSA id l5-20020a17090aec0500b002b328adaa40sm780011pjy.17.2024.05.08.00.43.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 00:43:04 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv3 12/19] zram: support compression level comp config
Date: Wed,  8 May 2024 16:42:05 +0900
Message-ID: <20240508074223.652784-13-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
In-Reply-To: <20240508074223.652784-1-senozhatsky@chromium.org>
References: <20240508074223.652784-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for compression level level=N comp configuration
to comp_algorithm and recomp_algorithm knobs.

Note that zram cannot verify ranges, it's a task of
corresponding backends to make sure that level makes
sense.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/zram_drv.c | 30 ++++++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index bd8433363cbe..89a2eb37e26c 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1013,6 +1013,12 @@ static int __comp_algorithm_store(struct zram *zram, u32 prio, const char *buf)
 	return 0;
 }
 
+static int comp_config_store(struct zram *zram, u32 prio, s32 level)
+{
+	zram->configs[prio].level = level;
+	return 0;
+}
+
 static ssize_t comp_algorithm_show(struct device *dev,
 				   struct device_attribute *attr,
 				   char *buf)
@@ -1030,6 +1036,7 @@ static ssize_t comp_algorithm_store(struct device *dev,
 	struct zram *zram = dev_to_zram(dev);
 	char *args, *param, *val;
 	char *alg = NULL;
+	s32 level = ZCOMP_CONFIG_NO_LEVEL;
 	int ret;
 
 	args = skip_spaces(buf);
@@ -1049,12 +1056,21 @@ static ssize_t comp_algorithm_store(struct device *dev,
 			alg = val;
 			continue;
 		}
+
+		if (!strcmp(param, "level")) {
+			ret = kstrtoint(val, 10, &level);
+			if (ret)
+				return ret;
+			continue;
+		}
 	}
 
 	if (!alg)
 		return -EINVAL;
 
-	ret = __comp_algorithm_store(zram, ZRAM_PRIMARY_COMP, alg);
+	ret = comp_config_store(zram, ZRAM_PRIMARY_COMP, level);
+	if (!ret)
+		ret = __comp_algorithm_store(zram, ZRAM_PRIMARY_COMP, alg);
 	return ret ? ret : len;
 }
 
@@ -1087,6 +1103,7 @@ static ssize_t recomp_algorithm_store(struct device *dev,
 	int prio = ZRAM_SECONDARY_COMP;
 	char *args, *param, *val;
 	char *alg = NULL;
+	s32 level = ZCOMP_CONFIG_NO_LEVEL;
 	int ret;
 
 	args = skip_spaces(buf);
@@ -1107,6 +1124,13 @@ static ssize_t recomp_algorithm_store(struct device *dev,
 				return ret;
 			continue;
 		}
+
+		if (!strcmp(param, "level")) {
+			ret = kstrtoint(val, 10, &level);
+			if (ret)
+				return ret;
+			continue;
+		}
 	}
 
 	if (!alg)
@@ -1115,7 +1139,9 @@ static ssize_t recomp_algorithm_store(struct device *dev,
 	if (prio < ZRAM_SECONDARY_COMP || prio >= ZRAM_MAX_COMPS)
 		return -EINVAL;
 
-	ret = __comp_algorithm_store(zram, prio, alg);
+	ret = comp_config_store(zram, prio, level);
+	if (!ret)
+		ret = __comp_algorithm_store(zram, prio, alg);
 	return ret ? ret : len;
 }
 #endif
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


