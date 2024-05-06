Return-Path: <linux-kernel+bounces-169455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FA9E8BC8EA
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 10:02:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A39921F219B1
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 08:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E27C91419B4;
	Mon,  6 May 2024 07:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mURkW0J1"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC38143884
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 07:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714982356; cv=none; b=Uhr9rjS2GEKn61PAC6CNjqeOpwY4lmo2hF1J9a82AWQ6TTM6YEtRV+q0n33z2QGMtBTypgH+8zhSRSvFt2aM4BofLGDuxQp8z5p2fkLJo4sAsW+xHv+lrLSMwC8CwI7cu0RO2gRys1O5cAmJ0W7b8U/UWUuZckY1goNUeAtI9MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714982356; c=relaxed/simple;
	bh=d4UQf/ZsLZS7cvretx2WXvAFWLig4xky110hNJGk3Zc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RlwL5KONHECkKvQC4hbFZckFlB6HkBdyF7lxIXAOMg/48d2i852lUAArEJytXSuCheAbyh3DZ8gE8rzGKT/IqRWO19LOZu3SPk3aXYXG9fLG0MW+Z7rYqJYWlyjtnNi9HlKa8huvu5qbq24rMGtNpRtnIykAr9A7YCdijSRogRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=mURkW0J1; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1e3c3aa8938so9163715ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2024 00:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714982354; x=1715587154; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wIlqiB/ZJyLpyyyQGB102ierEcV1ZXWEtzUdufZbr+0=;
        b=mURkW0J12TLZ9IAGFzMJD7zTYRO3Ji6THYvcqwKHdIMigAmVH2G102S1sPzby08G8M
         CeRG9SSaYjBxJi85pBHskG8rYFSwnLftoJ8Jy5LlCSS1D/rY6UmmGanVNhFx1hu6AaiR
         BmQwbrULcPsgFOMiAGIo24Fd84LhwSKdIhExg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714982354; x=1715587154;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wIlqiB/ZJyLpyyyQGB102ierEcV1ZXWEtzUdufZbr+0=;
        b=SiY9Z/KTkORbnkryEIdhTcD0lNe0bwLUrfSItgvgLfhttwiAh5se0xOjET6YxLD/gK
         QqsxRfkqFhoiufLQOlpWX4/16Tzr0q/yiHXR32rQQFmC20efHdT61jG+CYFNgZi6gQW+
         AJC/0HH5+7Jcfp1vT7fjIU7T7KF+rKdONoptjwTDFvX/Z9E1hbSLpA1JcaGPZYCSCg95
         JBeYkerxRVMfsppY37TCpeuQEe+ZZuwhPx/HQWc95scyynDKD1GWMPpFMqksCzZ+6W4+
         ifjxbc24hFg81tRk2oLKePrGuhuCFcAaSdN7jM6HpQrNelivrUDDRpvBzPetqwpq10Yf
         7Ezg==
X-Gm-Message-State: AOJu0Ywpy/7lwIEF+flqw+6Pau2GSNsERSEBDjYMdhuxu1QxG9JxaAQv
	LiiKXsGKfWHl6jm9V8ODOBOlRFAxw72N2G20Rjtfiwkrsgz9j75qfZCLUlztXQ==
X-Google-Smtp-Source: AGHT+IEu8xJh6jdUx6bHxS7wt8XM4/kzzQzw9kZsTgvT5qkc9pX/gCVBcFkVCQ4l1y2x/J0OVqYbhA==
X-Received: by 2002:a17:902:6806:b0:1e0:e85f:3882 with SMTP id h6-20020a170902680600b001e0e85f3882mr9682647plk.38.1714982354399;
        Mon, 06 May 2024 00:59:14 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:4e24:10c3:4b65:e126])
        by smtp.gmail.com with ESMTPSA id h6-20020a170902f54600b001ec64b128dasm7633772plf.129.2024.05.06.00.59.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 00:59:14 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv2 12/17] zram: support compression level comp config
Date: Mon,  6 May 2024 16:58:25 +0900
Message-ID: <20240506075834.302472-13-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
In-Reply-To: <20240506075834.302472-1-senozhatsky@chromium.org>
References: <20240506075834.302472-1-senozhatsky@chromium.org>
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


