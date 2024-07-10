Return-Path: <linux-kernel+bounces-246864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2547792C824
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 03:56:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A0B11F2320F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 01:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B80CDBA20;
	Wed, 10 Jul 2024 01:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BbGymyEU"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B1A6848E;
	Wed, 10 Jul 2024 01:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720576589; cv=none; b=eqsxTFsVZIdPmiPEv9vMPl3l9fy1Yl6C7Gc3FL1Osd13OXgRREyDu4EGhdUvw6+8erL+9Nw6Ji8s61jPsUNYuJNuukai/E/Lucmaj3T7jlRxJiyOdBMGCJNdBJdnS/XFfzY4mpHYU0LyfKH2hsb4aDLhS5m7GT7POPVbHsvcUoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720576589; c=relaxed/simple;
	bh=DPQSUvhX4PdWA7X3fADcAWaw1ST7AdomkqkRK1Iy0yc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XrYrVL9tP+dM8MdkZ0r393gJzDRJ82IxMWB3E0X2qwTVKskaiwl+OH7ZJi2W/jO/nQcseXmwW+pObkT7UH+rz42lfJP+t+1RQc/8h1R4KBE02WbIO+VRA8LiuRju8Z+ssY/tw+WiFrjt7SZu8DD2xa7iZJGfGf5nXdf0aSQoTLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BbGymyEU; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-710437d0affso3340668a12.3;
        Tue, 09 Jul 2024 18:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720576588; x=1721181388; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=50E7e9XbaKO5ydSbs6JqjTR85kdRi8RGBw5e5A+dUM8=;
        b=BbGymyEUfgXd1WT2g/gD6S7ZSXppcX6bMxgcHFalFKQb4NbfHixdNcsklz6DAtqmLq
         7qbic2/lgjKYouMgnV2OLlapRG9Tf7n9DjPyK7OT3YVQlp7Lx92YME0peNcNk+bnGuKk
         YhSYDwxzjUTm++wkXmYSI2hB0YiQFGazuL5dFWiQNSYnu+z1Nnia/3toJ6CSPyU5/P4g
         4runqKHfNA03/J6FQ4rO8tsilt2HTc0H9bkrh/EVrMcUrEyx8dHK1PsmCO4VshUAIjYq
         caVkwaAWG7fg3B4GrWTYIYww96TeFrIeLQrs9UEHgI5SPsqJn4+jy8iEQKsMmzwZvp6T
         XAGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720576588; x=1721181388;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=50E7e9XbaKO5ydSbs6JqjTR85kdRi8RGBw5e5A+dUM8=;
        b=eHtgXVx+XExKiTWCxk7GVViy0GQlYbdneqm3br3Q9g+PdY2EEGNQZdYJOHVeIvbYGY
         nKULPDI4LFVL9bMRWmWX6cHAKWyXYuemcpfeWVeHfhk2ylFEbn9M2FPP4y5EF2Z8wrsH
         YdMWt95wlkHqf5e1Vphx65wEICjUFEocIpBSoiGvHAp4GKKbnm1/QjmKe5bedKYdQOdA
         PtdZxwoRefU/0cNhOzVsJmRN2JtlsP/7RstQAeE0DR0JTUAj/VKhuP+YWcZhQvuspQ8Z
         QW3CptwoZwJwFiV2tNf+N1cFLMfnINy637zQDYGa4Qr4GMTv7k4HfiwN4NNuwVE7Y8ji
         VMrA==
X-Forwarded-Encrypted: i=1; AJvYcCX5n6BvcoqbRWTUBFKcntGINf6vOVeiRBJ/LDrlYDwVVFsd8wDJ7pXlXOR3T5G9Aigh3F1s8rEKhSAnoLG96kz46nTFaVhrqLjOrjQv2Bz7ufaT/6qTjw4mkCcK1MPPTeIiHgOZlxsgnlU=
X-Gm-Message-State: AOJu0YwZL3RjcC7EqEaq8gF0oIoSqkWjtNxzAVFZbS8vVXqmMxReh9+i
	x0yJBFjllFP+2sJFLOj20zbgKf4jO+GwlTc4Py4UtjxEMUnOonX3GSiw+A==
X-Google-Smtp-Source: AGHT+IEBC9ahW7iL/vncll/jucOxKWPyGm2xZQ8QnkhIwuw4FtjenZMH5/iJ7ygDysNUYtMHWenKeg==
X-Received: by 2002:a05:6a20:daa4:b0:1c0:f5af:7967 with SMTP id adf61e73a8af0-1c29822d023mr4664012637.15.1720576587423;
        Tue, 09 Jul 2024 18:56:27 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ca353cc6cfsm2576310a91.54.2024.07.09.18.56.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 18:56:26 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: Mark Brown <broonie@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Jean Delvare <jdelvare@suse.com>,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>
Subject: [RFC PATCH 1/3] regmap: Implement regmap_multi_reg_read()
Date: Tue,  9 Jul 2024 18:56:20 -0700
Message-Id: <20240710015622.1960522-2-linux@roeck-us.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240710015622.1960522-1-linux@roeck-us.net>
References: <20240710015622.1960522-1-linux@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

regmap_multi_reg_read() is similar to regmap_bilk_read() but reads from
an array of non-sequential registers.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/base/regmap/regmap.c | 103 +++++++++++++++++++++++------------
 include/linux/regmap.h       |   2 +
 2 files changed, 70 insertions(+), 35 deletions(-)

diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index 0a34dd3c4f38..dff6c515305a 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -3101,8 +3101,53 @@ int regmap_fields_read(struct regmap_field *field, unsigned int id,
 }
 EXPORT_SYMBOL_GPL(regmap_fields_read);
 
+static int _regmap_bulk_read(struct regmap *map, unsigned int reg,
+			     unsigned int *regs, void *val, size_t val_count)
+{
+	u32 *u32 = val;
+	u16 *u16 = val;
+	u8 *u8 = val;
+	int ret, i;
+
+	map->lock(map->lock_arg);
+
+	for (i = 0; i < val_count; i++) {
+		unsigned int ival;
+
+		if (regs) {
+			if (!IS_ALIGNED(regs[i], map->reg_stride)) {
+				ret = -EINVAL;
+				goto out;
+			}
+			ret = _regmap_read(map, regs[i], &ival);
+		} else {
+			ret = _regmap_read(map, reg + regmap_get_offset(map, i), &ival);
+		}
+		if (ret != 0)
+			goto out;
+
+		switch (map->format.val_bytes) {
+		case 4:
+			u32[i] = ival;
+			break;
+		case 2:
+			u16[i] = ival;
+			break;
+		case 1:
+			u8[i] = ival;
+			break;
+		default:
+			ret = -EINVAL;
+			goto out;
+		}
+	}
+out:
+	map->unlock(map->lock_arg);
+	return ret;
+}
+
 /**
- * regmap_bulk_read() - Read multiple registers from the device
+ * regmap_bulk_read() - Read multiple sequential registers from the device
  *
  * @map: Register map to read from
  * @reg: First register to be read from
@@ -3132,47 +3177,35 @@ int regmap_bulk_read(struct regmap *map, unsigned int reg, void *val,
 		for (i = 0; i < val_count * val_bytes; i += val_bytes)
 			map->format.parse_inplace(val + i);
 	} else {
-		u32 *u32 = val;
-		u16 *u16 = val;
-		u8 *u8 = val;
-
-		map->lock(map->lock_arg);
-
-		for (i = 0; i < val_count; i++) {
-			unsigned int ival;
-
-			ret = _regmap_read(map, reg + regmap_get_offset(map, i),
-					   &ival);
-			if (ret != 0)
-				goto out;
-
-			switch (map->format.val_bytes) {
-			case 4:
-				u32[i] = ival;
-				break;
-			case 2:
-				u16[i] = ival;
-				break;
-			case 1:
-				u8[i] = ival;
-				break;
-			default:
-				ret = -EINVAL;
-				goto out;
-			}
-		}
-
-out:
-		map->unlock(map->lock_arg);
+		ret = _regmap_bulk_read(map, reg, NULL, val, val_count);
 	}
-
 	if (!ret)
 		trace_regmap_bulk_read(map, reg, val, val_bytes * val_count);
-
 	return ret;
 }
 EXPORT_SYMBOL_GPL(regmap_bulk_read);
 
+/**
+ * regmap_multi_reg_read() - Read multiple non-sequential registers from the device
+ *
+ * @map: Register map to read from
+ * @regs: Array of registers to read from
+ * @val: Pointer to store read value, in native register size for device
+ * @val_count: Number of registers to read
+ *
+ * A value of zero will be returned on success, a negative errno will
+ * be returned in error cases.
+ */
+int regmap_multi_reg_read(struct regmap *map, unsigned int *regs, void *val,
+			  size_t val_count)
+{
+	if (val_count == 0)
+		return -EINVAL;
+
+	return _regmap_bulk_read(map, 0, regs, val, val_count);
+}
+EXPORT_SYMBOL_GPL(regmap_multi_reg_read);
+
 static int _regmap_update_bits(struct regmap *map, unsigned int reg,
 			       unsigned int mask, unsigned int val,
 			       bool *change, bool force_write)
diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index a6bc2980a98b..9c1ddbf82719 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -1237,6 +1237,8 @@ int regmap_noinc_read(struct regmap *map, unsigned int reg,
 		      void *val, size_t val_len);
 int regmap_bulk_read(struct regmap *map, unsigned int reg, void *val,
 		     size_t val_count);
+int regmap_multi_reg_read(struct regmap *map, unsigned int *reg, void *val,
+			  size_t val_count);
 int regmap_update_bits_base(struct regmap *map, unsigned int reg,
 			    unsigned int mask, unsigned int val,
 			    bool *change, bool async, bool force);
-- 
2.39.2


