Return-Path: <linux-kernel+bounces-179563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FAB88C6177
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 09:20:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2FFA1C21CBC
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 07:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 502835C613;
	Wed, 15 May 2024 07:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Gx3LeW9i"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B345BAFC
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 07:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715757448; cv=none; b=NPwrBJHKV8nuSHBCeYo7RJoYyE+ao6xHgkGEsxhw+flxM2+PJj+w3xh6cIpkgRMeaqMUk/WAN6jqv4Vz2SGrwiO5UrYml9vPPBxilfBRQvITy0AmT02b7OdaGAxKu7zCNXnMMGVy7NvQeXc54nADSfFw4m8U+xnBEuCG6ElbHkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715757448; c=relaxed/simple;
	bh=NSsCiPGcIxF0zOQ6vdufDUaR67+LlToiDZLTG5tQTr0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EKQlHEldBCGjZF8Vc0Wfk7+KattgRp7FXzEI5I44DzPh+HYg2Nzf2pAR7yX4u3N4WjYOncpl+ulEU6oI789sUOLIQZ5mfd6OoyNEeDBxIIsi00+/1NlkhP5Tcg555rZCXkhYrum5Uix0hplMRGusFttAK36wfStDYqV783bUWb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Gx3LeW9i; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1f082d92864so16527275ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 00:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715757446; x=1716362246; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7bmm+z3Y++HgLKjqUQ1k19xvJfVuFLOPQwKCzZQr8AY=;
        b=Gx3LeW9iM9+zmkNIGCPmc35XkwEQn2XcILyOSg9atjScgmafLHd2uMc1E3NnjIsjEi
         CALrMw1t6+7leFD8H2qJj0ZJZ7ikkBrsXgjd7+2BJzsQtlzaD3YOWZfZ3LoLdjrXFz2n
         efgxwgrHjEHQJ1DjBW4GNolYqmi3u+U/W4kr4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715757446; x=1716362246;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7bmm+z3Y++HgLKjqUQ1k19xvJfVuFLOPQwKCzZQr8AY=;
        b=va3jrkGZF7Twbee2Vk55PrNvhgUUM8ztdGccwHFsLIwnCSNoO9fAGw6x41yTGSmbAt
         +r17KIIgP1OvJHGhJOHbNwX0HE9CrsW7YWkcAoPpR1/5alwcP3X3z1hSLXyBrtfzTU3H
         51adCKal2aQJi8qRnaVxOMUriW2d4jf3BevlEgovO+oPxVOdW+kBCRImt26IIXIajapv
         XFRh/fZZCbHKrHFTe8tnvbwv2EPKAXDmFS0++L/R8GxnSNjr6MkTBf1emN19xL3acSiw
         hyWLKQ36EjzY3dLRkyF3sGtPfTZaIJFhYASjfwhuOOkSWboWacC0dZvutmwsa5Gw+yRE
         newQ==
X-Gm-Message-State: AOJu0YxuUUk80zKYoDrOK+BokcnEapHIgkmyElhe/iQeSGou7IkbLsa2
	EVsr9/2fRoZkQ+VPzs/KoOMILoIs8MFYJmQFTXc9TGKs/3Lxdengnu/RGwJACw==
X-Google-Smtp-Source: AGHT+IFqYYiz6/dbTR0wwd7ijHcmxpeWPZVSroUIYlUMxCGV540oRKNRsxU3YgCNTEN6VkVK7MOiHA==
X-Received: by 2002:a17:902:ce11:b0:1e7:d482:9e32 with SMTP id d9443c01a7336-1ef43c0e8d6mr184387855ad.7.1715757446224;
        Wed, 15 May 2024 00:17:26 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:111d:a618:3172:cd5b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0c136d53sm110941605ad.254.2024.05.15.00.17.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 00:17:25 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv4 12/21] zram: support compression level comp config
Date: Wed, 15 May 2024 16:12:49 +0900
Message-ID: <20240515071645.1788128-13-senozhatsky@chromium.org>
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
index 7eb500c8fdaa..91706889b63f 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -998,6 +998,12 @@ static int __comp_algorithm_store(struct zram *zram, u32 prio, const char *buf)
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
@@ -1015,6 +1021,7 @@ static ssize_t comp_algorithm_store(struct device *dev,
 	struct zram *zram = dev_to_zram(dev);
 	char *args, *param, *val;
 	char *alg = NULL;
+	s32 level = ZCOMP_CONFIG_NO_LEVEL;
 	int ret;
 
 	args = skip_spaces(buf);
@@ -1034,12 +1041,21 @@ static ssize_t comp_algorithm_store(struct device *dev,
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
 
@@ -1072,6 +1088,7 @@ static ssize_t recomp_algorithm_store(struct device *dev,
 	int prio = ZRAM_SECONDARY_COMP;
 	char *args, *param, *val;
 	char *alg = NULL;
+	s32 level = ZCOMP_CONFIG_NO_LEVEL;
 	int ret;
 
 	args = skip_spaces(buf);
@@ -1092,6 +1109,13 @@ static ssize_t recomp_algorithm_store(struct device *dev,
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
@@ -1100,7 +1124,9 @@ static ssize_t recomp_algorithm_store(struct device *dev,
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


