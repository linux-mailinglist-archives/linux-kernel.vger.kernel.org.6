Return-Path: <linux-kernel+bounces-246866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D912392C828
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 03:57:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83BF61F22A65
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 01:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79AE922075;
	Wed, 10 Jul 2024 01:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AeM1VTcg"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625D1D535;
	Wed, 10 Jul 2024 01:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720576592; cv=none; b=k9m+lDDqMEUqY5kmKNY0pB8o5XpCIdxrgWIWBUbbP50njXhXHSdDzq9RkqwRA5qGNO/laksJtqtGXnRlC7TqMeAPdlr/VVZMlXD/EGARLLLwxsL6najHLQgU1Haw1q3yIqtRRVPZRUOF3slts8Q7u2l/GL9RSlwfyRSWgO818ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720576592; c=relaxed/simple;
	bh=yVwBcqo4n7dV6025dgqgRj70ZSUioMAfZgJ1GaxdRSs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EK351j1fN/gPphMMdhGqLPmgl4/7EicR1dfwYfZ+FOFeJYG4Zo8L+Le9rs7JUdn8jPxWKS+Wd6ap56wz5DWVUOCvRNzy+A/Jyfo9o0EEEvY0njPfSBzeG+IHoEzU1yK7Yr4m2rFWhy3vyehtBKyBs6QnkLRik4LS1nRir//s+C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AeM1VTcg; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-75c3afd7a50so3044818a12.2;
        Tue, 09 Jul 2024 18:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720576591; x=1721181391; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ytinKlxNOsRvdg10ANmVnaYKwTMMTQXNjKLYhperoZ4=;
        b=AeM1VTcgMGdUIfwtVRWbyPlF6MK33r1nOIE9zwsUT7Svmw/KrSp69oGYnSzyhOHqAn
         w8fSjtyDPvwJgCS5f53aI4wq5ap0U5HMlS0EO6Qts+o+r4QMsJJHdiU9HBt4ZqemvOMo
         5I3Mh65X1F+x16wdkDk3WYWFzZQHhW6EJfhzmXZ/3Bl4YuorHlYCBQYWIuiciVn94WC2
         ++Lb+NAU2SWsIOqWqhO5Xbzz1DtSRIQa/H5luyXQd0tjy+gQFPXExaWutETu3mPQQbK6
         4wQ4FIV8NHFda8AENFY+TxnTadwjpGk/kCpyYYZ7WuPVEM70tv3qn1EvdfYwqsCZZ0mQ
         llug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720576591; x=1721181391;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ytinKlxNOsRvdg10ANmVnaYKwTMMTQXNjKLYhperoZ4=;
        b=tiBHivrshmNhgWy8lj+A11ME3OjoGkPXj/WJscnUHtD+A80v1s1mR/jCjIUt2dm2GU
         9XRER7c53BFLeX/Pp8d8yCVzgrgpYaVaHr8HEwyhumPlKGg+bl4u4VL+O1r3TLqdXW5G
         aHh2xQzMTeD+0rbQwMgNTU/dsdXf4CiT1j/RIxUqebVWaHXmzjgvFN7PTgbe+oVGyWSR
         iSo1cZu4fGNqnofC+BYUmQldNOYNQPvZzhMC/bgJQXMrFNq9f8m8DKRlq/7I0waP2IX8
         F6VdtY2MltCBP/IDcIF7VgwgkA2JpUKySAg3bEbjtEQvLzJXDSDnn33Na1sA9idtzQre
         T7kQ==
X-Forwarded-Encrypted: i=1; AJvYcCXXgfR8Q2l2k7Q+QSRuIXFcrJCmG6drEuACpLsJj6jntbq3cxxmi4O6TgB0DnUDe4wGj1k8BYv6my9W7bcPjUzWibnA08e/UpsXMdpfeltnV+rHE26lVdj+VeHpL9f7i4qsQ+xGLh1A1BM=
X-Gm-Message-State: AOJu0Yy5vHKljA2Nar3ssaNsGKlqXAdfACiQn63oHTBqhfXqyPH3R/FP
	dHPgXRG8oqfuIVCU2tXpNorkLsnVUwy/U30i602KG8i+StScqSE2
X-Google-Smtp-Source: AGHT+IGsQHA1+z9NEfnc6SwgPlZp/8CqOTvpjdPg6Ag3ZGwmLc/fCDreMoAXNkD7OJQA24cVEhV7fQ==
X-Received: by 2002:a05:6a20:3ca4:b0:1b3:d59f:2d87 with SMTP id adf61e73a8af0-1c2984e10b8mr4616766637.55.1720576590556;
        Tue, 09 Jul 2024 18:56:30 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fbb6acfe85sm22342955ad.253.2024.07.09.18.56.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 18:56:30 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: Mark Brown <broonie@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Jean Delvare <jdelvare@suse.com>,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>
Subject: [RFC PATCH 3/3] hwmon: (tmp401) Use multi-byte regmap operations
Date: Tue,  9 Jul 2024 18:56:22 -0700
Message-Id: <20240710015622.1960522-4-linux@roeck-us.net>
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
 drivers/hwmon/tmp401.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/drivers/hwmon/tmp401.c b/drivers/hwmon/tmp401.c
index df1b45a62e80..8a1497cca2d2 100644
--- a/drivers/hwmon/tmp401.c
+++ b/drivers/hwmon/tmp401.c
@@ -308,7 +308,9 @@ static int tmp401_temp_read(struct device *dev, u32 attr, int channel, long *val
 {
 	struct tmp401_data *data = dev_get_drvdata(dev);
 	struct regmap *regmap = data->regmap;
+	unsigned int regs[2];
 	unsigned int regval;
+	u16 regvals[2];
 	int reg, ret;
 
 	switch (attr) {
@@ -325,20 +327,13 @@ static int tmp401_temp_read(struct device *dev, u32 attr, int channel, long *val
 		*val = tmp401_register_to_temp(regval, data->extended_range);
 		break;
 	case hwmon_temp_crit_hyst:
-		mutex_lock(&data->update_lock);
-		reg = TMP401_TEMP_MSB[3][channel];
-		ret = regmap_read(regmap, reg, &regval);
-		if (ret < 0)
-			goto unlock;
-		*val = tmp401_register_to_temp(regval, data->extended_range);
-		ret = regmap_read(regmap, TMP401_TEMP_CRIT_HYST, &regval);
-		if (ret < 0)
-			goto unlock;
-		*val -= regval * 1000;
-unlock:
-		mutex_unlock(&data->update_lock);
+		regs[0] = TMP401_TEMP_MSB[3][channel];
+		regs[1] = TMP401_TEMP_CRIT_HYST;
+		ret = regmap_multi_reg_read(regmap, regs, regvals, 2);
 		if (ret < 0)
 			return ret;
+		*val = tmp401_register_to_temp(regvals[0], data->extended_range) -
+							(regvals[1] * 1000);
 		break;
 	case hwmon_temp_fault:
 	case hwmon_temp_min_alarm:
-- 
2.39.2


