Return-Path: <linux-kernel+bounces-311161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EED1C96858C
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 13:01:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACD742898E7
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 11:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A108D1D6C4D;
	Mon,  2 Sep 2024 10:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EwFE8vwH"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3901D67AB
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 10:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725274658; cv=none; b=WYkSIxgaFIhMh2sA78lwAkdvQvV/pWA18hvQdhuINen57/Gn3dvw6dLTBw6mYE4Vlf27CZiunD/3SavX+7U+WMC1pqs8y/M7K6ARYVtqs4vNtkK8bElc09Dmwu71OPQmYOVc5kF9iznOhYui9K692zVVwUqr5v8YdC1c9QSkdHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725274658; c=relaxed/simple;
	bh=8WtHrsnbFQmPWFujXtrgyDTDVYrmx4nurcHWm7bU060=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DhWvT65KYv4h3b6rU2kxkX9hd4WaVSoPCuZXjvS8zTDWOn+4XKkUYu+GNRo/Jp+E8ZRvAoEU6v9NNrgXKa73pXKBfNfoKo1tCDB+Z7iCXvxFDjx1uvHvqOirTJRt6Jeeav9ryq+oz35ZrRIA2jDhOM3K9NqdO+D1ewJh7krWi4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=EwFE8vwH; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-715c160e231so3535092b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 03:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1725274656; x=1725879456; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nfEDHPmZ2pcmwcESiSv53E6iZyI1iE5jEnAbodimKt0=;
        b=EwFE8vwHY9LpWUOX1WPUrl3IuH1DoC4HoIYTvL1rHH1LABIOJE3yvLk6/TBbUAPDDG
         AM1eBNP0N7o1NB+mDX25qLkevWF7mC4He6yuQJngscqSNaKHwv2csFeOTXmtI7x7azNW
         gyU71cNMqUg8dj6mS6f6sxy8nNstUnYqNWlhs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725274656; x=1725879456;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nfEDHPmZ2pcmwcESiSv53E6iZyI1iE5jEnAbodimKt0=;
        b=Zy7cZFRw7POryCc0uDcM8O0WpYWfUkl4G7vabmrA7/SG3/wXyBhVF5JBri3ywxg/L4
         sOdR0mSzHz+BcR4wcEosKEyggC8EeWPjjZ8HX0aYOtrzYO7jEqOyNskr0NLenIF8L8SH
         hl+SvWrb3q4fcjelwt4Cv91V7JtWPBmcvah/euX6OJb8EsUgnbPB92lZCHEGSMSsHx4j
         PG8M6LumxWyF6V/U1KgeTWnRkSyTwZtztXAUQaU9Bu9GFqg5M2qs/l5ficcWxr7tZk5s
         IQx3gIB5prSsdWZKT7n1Mt4LkK2QDfU7B1hTPfb6QicX+ZSnAwzez9JtWTPAKDspcx+r
         7Hbg==
X-Forwarded-Encrypted: i=1; AJvYcCWxVFq6RCiDLkazZ9xiISZ9L8V2hCk+VNq9wT4uXeclggEJ7Ko7Ut+RlQvf0mMlWRlI/L/mlDFvbl4HHz0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1Vp+jWFRkDx+68dHAEGBCAVd+j7P33BiQg0iKAE5x+NyIDw6w
	4Qlivux3Hvq/fpeWKF6rgFwW7gcyyj6Bc5vSU4QTYpdLOOEsnBpMz+4dlvkSEg==
X-Google-Smtp-Source: AGHT+IEodxeI5lCTvNlwudlkSGJXz7KlF2dLLOF7bAhwq+hvT95QArnZQ5SklUf9vLr62qvKFS5VLg==
X-Received: by 2002:a05:6a00:9444:b0:70d:2a88:a486 with SMTP id d2e1a72fcca58-715dfcf40a7mr13805376b3a.29.1725274655871;
        Mon, 02 Sep 2024 03:57:35 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:43a1:71e3:7464:e91b])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-715e55a51e9sm6633769b3a.78.2024.09.02.03.57.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 03:57:35 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Minchan Kim <minchan@kernel.org>,
	linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv7 16/24] zram: add support for dict comp config
Date: Mon,  2 Sep 2024 19:56:04 +0900
Message-ID: <20240902105656.1383858-17-senozhatsky@chromium.org>
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

Handle dict=path algorithm param so that we can read a
pre-trained compression algorithm dictionary which we
then pass to the backend configuration.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/zram_drv.c | 45 ++++++++++++++++++++++++++++-------
 1 file changed, 36 insertions(+), 9 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index e29e952b99c3..9b29f9e6cb50 100644
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
@@ -1010,7 +1037,7 @@ static ssize_t algorithm_params_store(struct device *dev,
 				      size_t len)
 {
 	s32 prio = ZRAM_PRIMARY_COMP, level = ZCOMP_PARAM_NO_LEVEL;
-	char *args, *param, *val, *algo = NULL;
+	char *args, *param, *val, *algo = NULL, *dict_path = NULL;
 	struct zram *zram = dev_to_zram(dev);
 	int ret;
 
@@ -1039,6 +1066,11 @@ static ssize_t algorithm_params_store(struct device *dev,
 			algo = val;
 			continue;
 		}
+
+		if (!strcmp(param, "dict")) {
+			dict_path = val;
+			continue;
+		}
 	}
 
 	/* Lookup priority by algorithm name */
@@ -1060,7 +1092,7 @@ static ssize_t algorithm_params_store(struct device *dev,
 	if (prio < ZRAM_PRIMARY_COMP || prio >= ZRAM_MAX_COMPS)
 		return -EINVAL;
 
-	ret = comp_params_store(zram, prio, level);
+	ret = comp_params_store(zram, prio, level, dict_path);
 	return ret ? ret : len;
 }
 
@@ -2050,12 +2082,7 @@ static void zram_comp_params_reset(struct zram *zram)
 	u32 prio;
 
 	for (prio = ZRAM_PRIMARY_COMP; prio < ZRAM_MAX_COMPS; prio++) {
-		struct zcomp_params *params = &zram->params[prio];
-
-		vfree(params->dict);
-		params->level = ZCOMP_PARAM_NO_LEVEL;
-		params->dict_sz = 0;
-		params->dict = NULL;
+		comp_params_reset(zram, prio);
 	}
 }
 
-- 
2.46.0.469.g59c65b2a67-goog


