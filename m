Return-Path: <linux-kernel+bounces-250185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC2E392F500
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 07:24:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 571301F22F9A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 05:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B3F813775C;
	Fri, 12 Jul 2024 05:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="StBi8Drx"
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5706B136678
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 05:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720761580; cv=none; b=DaIwhfsMjHQF6th1tRDzO/cR74/Pzp1Exb8GstYtCLc+a4k7UhorxWkPuhouqxR5T+bXmwEPCRqbF/UFN2Gk3eiie3V5G19rqUIIdLvp33iG7Xlwx6dTaQVpWsxT9o74oM3WuzUFyauFfinXKpW+J1e4FzHYeW+qY+J9NWYMYTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720761580; c=relaxed/simple;
	bh=Mq09Qqko1C92YSX/82Xz3dlSA8ydenpUZ/gVqONOj0s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QEeSz2BnOGfDpxUMMCf/up79gJpY01SnfrvrfPPwUbNcDtSYo4Vh5O6/NzUWLRKR1jlkBUmovb7Fj61+Vma11Ktq4Tdai75oExR/cFJ4jmXDWamc1MOEMz9MI8NBirCfbajqJ8YM4g5IR6kiaJNWSmN/qj7R2eyerfGoGKU2PMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=StBi8Drx; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5cbc5b63939so631262eaf.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 22:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1720761578; x=1721366378; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Bg4orkmRxzAWf8JG1gKZYQxqN5DtLQaEOXdZ5SstOU=;
        b=StBi8Drx2F3MQwU9nwshqjzIUFn9OoGjDRkYZdPpdsGjffhP5o+XNtPYzqnYO0X+h+
         8jmxha5YSmLkV6VajFIYLeoW1W4cU7FLxeSuk5P92sIjC5Ashgdar5SR4ZPaH8YSQ7Vr
         2VMAFLcemTNPZy+sW6+UaZPieV1KWHuVDR0J4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720761578; x=1721366378;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1Bg4orkmRxzAWf8JG1gKZYQxqN5DtLQaEOXdZ5SstOU=;
        b=wA2VKjU9d30OKT1mrYrXJQ4q4hsuDGeVJ9YBuJB/rJiKgcX6bFxmF+AMCOD7Tc8/Mz
         OXOvtEZPFpiVQ9XJ5OfHnN6CUbS+zp0xTLiWs87JhDsRnKK0vnFiN6ARJw6co1x1+dOM
         cQNDD8lcsETIukCFurmGnORmdwSfOgbWPd3OphMbFIy6+AHKxQpn3eG50uyzgAoK6t2M
         pCUOxgFV68s1lZlC+fUmCaI9ZjzdLctQo1sv6q6czlRX9/bqRA+321WPNRJgI6lsWQlq
         3R6tMVBi6IDQnafPjAKU0U5/yayieSpw7GekNaQgHIAD/En63CJ05hahasR2B2y/BP4m
         5FIw==
X-Gm-Message-State: AOJu0Yx3CM0qNefYT3ueuOfb45Rk3dJUM9yq2xeWkEvWmjzHM+FMPcOq
	VZKX6sK7MvLsRpdHNE9CKIY2NCU904j2hidOmIR23SFsmsldnsPQdNSihvSChwhxRuQdHpU7+dA
	2ayIx
X-Google-Smtp-Source: AGHT+IED1M3PNf6PKwCFu6+5F3NEZcXsYFrVpwObFAgIUOSjAZmrWyoXt0ihMlz0wO0Xb2gyiU3DYA==
X-Received: by 2002:a05:6870:1603:b0:259:cdf1:b8af with SMTP id 586e51a60fabf-25eaec1389bmr9553210fac.46.1720761578129;
        Thu, 11 Jul 2024 22:19:38 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:15f3:5252:ec56:52ae])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b43967851sm6553436b3a.109.2024.07.11.22.19.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 22:19:37 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH v6 15/23] zram: extend comp_algorithm attr write handling
Date: Fri, 12 Jul 2024 14:18:26 +0900
Message-ID: <20240712051850.484318-16-senozhatsky@chromium.org>
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

Previously comp_algorithm device attr would accept only
algorithm name param, however in order to enabled comp
configuration we need to extend comp_algorithm_store()
with param=value support.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/zram_drv.c | 54 +++++++++++++++++++++++++++++++++--
 1 file changed, 52 insertions(+), 2 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 84757f0c8166..a2c23ca033b5 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -998,6 +998,12 @@ static int __comp_algorithm_store(struct zram *zram, u32 prio, const char *buf)
 	return 0;
 }
 
+static int comp_params_store(struct zram *zram, u32 prio, s32 level)
+{
+	zram->params[prio].level = level;
+	return 0;
+}
+
 static ssize_t comp_algorithm_show(struct device *dev,
 				   struct device_attribute *attr,
 				   char *buf)
@@ -1013,9 +1019,43 @@ static ssize_t comp_algorithm_store(struct device *dev,
 				    size_t len)
 {
 	struct zram *zram = dev_to_zram(dev);
+	char *args, *param, *val;
+	char *alg = NULL;
+	s32 level = ZCOMP_PARAM_NO_LEVEL;
 	int ret;
 
-	ret = __comp_algorithm_store(zram, ZRAM_PRIMARY_COMP, buf);
+	args = skip_spaces(buf);
+	while (*args) {
+		args = next_arg(args, &param, &val);
+
+		/*
+		 * We need to support 'param' without value, which is an
+		 * old format for this attr (algorithm name only).
+		 */
+		if (!val || !*val) {
+			alg = param;
+			continue;
+		}
+
+		if (!strcmp(param, "algo")) {
+			alg = val;
+			continue;
+		}
+
+		if (!strcmp(param, "level")) {
+			ret = kstrtoint(val, 10, &level);
+			if (ret)
+				return ret;
+			continue;
+		}
+	}
+
+	if (!alg)
+		return -EINVAL;
+
+	ret = comp_params_store(zram, ZRAM_PRIMARY_COMP, level);
+	if (!ret)
+		ret = __comp_algorithm_store(zram, ZRAM_PRIMARY_COMP, alg);
 	return ret ? ret : len;
 }
 
@@ -1048,6 +1088,7 @@ static ssize_t recomp_algorithm_store(struct device *dev,
 	int prio = ZRAM_SECONDARY_COMP;
 	char *args, *param, *val;
 	char *alg = NULL;
+	s32 level = ZCOMP_PARAM_NO_LEVEL;
 	int ret;
 
 	args = skip_spaces(buf);
@@ -1068,6 +1109,13 @@ static ssize_t recomp_algorithm_store(struct device *dev,
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
@@ -1076,7 +1124,9 @@ static ssize_t recomp_algorithm_store(struct device *dev,
 	if (prio < ZRAM_SECONDARY_COMP || prio >= ZRAM_MAX_COMPS)
 		return -EINVAL;
 
-	ret = __comp_algorithm_store(zram, prio, alg);
+	ret = comp_params_store(zram, prio, level);
+	if (!ret)
+		ret = __comp_algorithm_store(zram, prio, alg);
 	return ret ? ret : len;
 }
 #endif
-- 
2.45.2.993.g49e7a77208-goog


