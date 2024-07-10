Return-Path: <linux-kernel+bounces-246865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FB4192C826
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 03:56:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 267D21F23A30
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 01:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72926171CC;
	Wed, 10 Jul 2024 01:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VpDFl7X7"
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3FDB647;
	Wed, 10 Jul 2024 01:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720576591; cv=none; b=qXUKNp0eoPS3EMh8K34h5oIyQo7eqHCcGX5oSL+vdE9lWNTPhfHowWBBha/98Ekt0i8DRKfz5D7gNYYmxm7B/eGeGcl6E5XZcKJ+3nX9EpfTkPxpgN0GAox1Ay7D4eHSqc+ccQ6kBFuS9sukL1Wqpwh7uy2sKCOV59a0bzgCjWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720576591; c=relaxed/simple;
	bh=Y1mdpr9XQdu5XHaFoKoLviUoJjMeQqle7EYcHlrpHkA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=e+NxepdU0F6G+hv+2X9g8VWvAE2j/l1T8nu6Ujb+Un6vOf45dP8gEuTR3M3k+Ro9mnFNUY0fnEGRUJxBkVxI4T7iWKCjGUDSfltLYUNJrsRjaENofIMgkwiavjPBp7aq8zPK/qe8s+LKGjpNxqys+H7yya8mWwgYVIwZj3ir0Ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VpDFl7X7; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3d9da46ca13so319644b6e.2;
        Tue, 09 Jul 2024 18:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720576589; x=1721181389; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YyOWpYNkYzIiMpmxD1xm3Y7YW6/4GApHOEr/JS0DEEc=;
        b=VpDFl7X70SqiwdewR6Kyo5tFCKxuxoXzSm9h47Y+GQEDrrSwO1GJD2SNTgeMuyqx12
         8285ROHBgLJGzNdSHla9aK+aU6kOXn9ipg0NqGV2hLSO//JtOjl6olZJUZTdbPX2kiaB
         TaP5zew3W89OX407lJK1MJvhJq80r58Wbw84KBQWkH1lTWgm/fN260o4yG4Y4HXHmCFm
         7KPxvGKTOWGIcjdjIDRHI0B240pt7xO6hFSDSC6MJnRmyH1T9hSksBCioPP5oJDw3FkM
         X3tgHvSJJvotTCaSg3iyP6XoiihBG5CBj/yQeMpeWmm5bEa2uIXZ7A9KNVWAwvTZeRws
         mwZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720576589; x=1721181389;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YyOWpYNkYzIiMpmxD1xm3Y7YW6/4GApHOEr/JS0DEEc=;
        b=jexzAfXfVxNqO1HAWmd4ldUOBZY7EauX9LklyzGwDua6t2BPyqtWJJRUyVkK6gPIFh
         ZOcK3MevGpLMBvsDRAvZFgjvy9f0VQ05mB6/T1pXQL9/HOqa7tXQWyIr+cXvstM5yQS2
         MHcjIisq7nAPCyXGEDUH5+F2ECeLLMO6TcklYeLME8f/8s5/metlId344wFMbKGkkBLJ
         tQI2HCHYg18A9uJm1FxWiKrXwvEc+xKa6JcU2AJJJ2e9BqTD8JGzQvApItLJzW8eT2Pv
         xj6GoEiWL45FwKfo6Z6dFp1DQ2fd3VsVmz/KuX0YJTM9OXVOjkb1ozr8AHjle97A4YMM
         eYqQ==
X-Forwarded-Encrypted: i=1; AJvYcCVpw6WArkxDehlXl9OLuV3xyXaqNgD2syih/VJvb5eB0A4Ks2m3qz6ETQ/6FYDOWBJK9T2Ptc2p2qPC3mP+YbqlmjsBx8jCk61EyP+ZGlzGv4OutJNtIcYgaPxI3NOuTp+fYfXASbxxor8=
X-Gm-Message-State: AOJu0Yz4fGKykQqWH3KNVH2WTvkOeYuW5eBEm0uwsIuqLUtP6VPWoMxL
	ou7xRzHkXjBEoTNfKj8+2ZmO0TJceXwOt0nYbkHe3F+R6Mz1ib7+u6WyFg==
X-Google-Smtp-Source: AGHT+IE5AHL4/vtQqyuZ9UbrCmX7+hEX6L9dqIBONCxJi56T4LFcIDDzIdWkwQlMBrHj9zMN/Ax3SQ==
X-Received: by 2002:a05:6808:191d:b0:3d9:b33e:d3e2 with SMTP id 5614622812f47-3d9b33ed905mr2468289b6e.19.1720576588986;
        Tue, 09 Jul 2024 18:56:28 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b439673f4sm2507662b3a.117.2024.07.09.18.56.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 18:56:28 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: Mark Brown <broonie@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Jean Delvare <jdelvare@suse.com>,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>
Subject: [RFC PATCH 2/3] hwmon: (adt7470) Use multi-byte regmap operations
Date: Tue,  9 Jul 2024 18:56:21 -0700
Message-Id: <20240710015622.1960522-3-linux@roeck-us.net>
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

Use multi-byte regmap operations where possible to reduce code size
and the need for mutex protection.

No functional change.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/adt7470.c | 22 +++++++---------------
 1 file changed, 7 insertions(+), 15 deletions(-)

diff --git a/drivers/hwmon/adt7470.c b/drivers/hwmon/adt7470.c
index 517248d2994e..dbee6926fa05 100644
--- a/drivers/hwmon/adt7470.c
+++ b/drivers/hwmon/adt7470.c
@@ -728,30 +728,22 @@ static const int adt7470_freq_map[] = {
 static int pwm1_freq_get(struct device *dev)
 {
 	struct adt7470_data *data = dev_get_drvdata(dev);
-	unsigned int cfg_reg_1, cfg_reg_2;
+	unsigned int regs[2] = {ADT7470_REG_CFG, ADT7470_REG_CFG_2};
+	u8 cfg_reg[2];
 	int index;
 	int err;
 
-	mutex_lock(&data->lock);
-	err = regmap_read(data->regmap, ADT7470_REG_CFG, &cfg_reg_1);
-	if (err < 0)
-		goto out;
-	err = regmap_read(data->regmap, ADT7470_REG_CFG_2, &cfg_reg_2);
-	if (err < 0)
-		goto out;
-	mutex_unlock(&data->lock);
+	err = regmap_multi_reg_read(data->regmap, regs, cfg_reg, 2);
+	if (err)
+		return err;
 
-	index = (cfg_reg_2 & ADT7470_FREQ_MASK) >> ADT7470_FREQ_SHIFT;
-	if (!(cfg_reg_1 & ADT7470_CFG_LF))
+	index = (cfg_reg[1] & ADT7470_FREQ_MASK) >> ADT7470_FREQ_SHIFT;
+	if (!(cfg_reg[0] & ADT7470_CFG_LF))
 		index += 8;
 	if (index >= ARRAY_SIZE(adt7470_freq_map))
 		index = ARRAY_SIZE(adt7470_freq_map) - 1;
 
 	return adt7470_freq_map[index];
-
-out:
-	mutex_unlock(&data->lock);
-	return err;
 }
 
 static int adt7470_pwm_read(struct device *dev, u32 attr, int channel, long *val)
-- 
2.39.2


