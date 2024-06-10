Return-Path: <linux-kernel+bounces-208716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F74B90286D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 20:12:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42CAF1F22CBF
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 18:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41876150994;
	Mon, 10 Jun 2024 18:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DFQShbpm"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2074314F9E7;
	Mon, 10 Jun 2024 18:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718043058; cv=none; b=qn8vjbQwHy2vRA7LZDp4vBH0515Y5LAp7kW7mwA85QG9nVZ2T4Cv7J33vw1r2PtiaSdWSz//dN8ULm6suo0j98H7LprCF/Q4w3GR2QGYXo4XwZf0H39l8V3yuwcMCQ3BEGUczalPzjNvSg40+9GRUxmVETBelYr+Vs+EONwEl4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718043058; c=relaxed/simple;
	bh=Rs1EQsOg01uvn7Hn/G7LElJnLEEXSqxNDo6raCfoI48=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BxzTWxSBYERjaRiJiXo15XKiqDkhBDyfEHP0GxyRLOQzBsgHIUeZuomIv4VeRe3VmyUN8qa/M5IhfJrwR+2PiPf9SsReaFEegFKD9TZ2CXTBUe3To7zX4IikNnAu3uZlqC7iMbNc/VHfIPcKBv8sTT9Iugu9P0HoWdYsWluM8NQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DFQShbpm; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1f6c7cdec83so38053065ad.0;
        Mon, 10 Jun 2024 11:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718043056; x=1718647856; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BjScR7Hzj+gJrS89xsExlnr/l0kAWC+C16dhfMmwLaM=;
        b=DFQShbpmMlvwqBRDeuF6latViwJg/ZsTyuLq5nUZm3TDA+eSXGU1e3QpS7nd5zjRzR
         sKjpnvsjXAnRTm7AR3+yFXl/mNursqG9GcHUH/ub39s6vwhhajqMXVirlO08cyYFeng6
         HHf+rBDTga0mcOrskMuOqVO6baCQibFZpctWQVamXGFnKgTWab3W+AgWIStsrsgpZckM
         JZ10AS0ZkSw/l3DjS3P05unarlDT7lxVzI9ZXKMA8qakR9nNSt6F0G2GPFctXi9Eb7UK
         OMExXTOTuZphltGOgriHQubWI1xDXYcdoEQ2CLI6/n3XR8AR5G8CQhVahy6PC8vwrtke
         iE8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718043056; x=1718647856;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BjScR7Hzj+gJrS89xsExlnr/l0kAWC+C16dhfMmwLaM=;
        b=Ef+tD0qHj45agfkBzD6Y1Fs2eZaJDMNz8Mk73tVPopM1DmI67BCXv2AjjyTXFupTuh
         9JdQsIDEvYzbnhtmrufdmFHGjbeofe9q7QH6ORMFp2EMM1PsWzErr1UMyYN+m/vcrqbq
         1EFCw/klEYRnCYYmBIhhuewe1RV7DhjiZ0eO1SPYX/hW/a7VCQCNB/tzpDlAJm7T9zUV
         sCkZ7Tfi/nfy7/zlm3AsQe5rom8cF9rODLMzCbVfQLXcuFJ1FozCFNl3gkaxVr2n4G5B
         PJ1APBmnoeeAl8VUoDtRDmf4f/jBMBkMZlYbmLp1732ZpXY02EYVfZ/ohMHF9JoOymfU
         eNug==
X-Forwarded-Encrypted: i=1; AJvYcCV9DIVke+R6gCtvVUreJqWnhchd0WzbA6qBUl4kpWCtrGjDg0h9KtGOgX9+WcrDBU9lLTQgV2UWb1fmGgUJHr7b27xkMX0hFf/yRJzf
X-Gm-Message-State: AOJu0Yxq04t2WS1t2Pf0gcNexS7NtY7U49QInNtwt4a3YMBwTj1ev8eQ
	4oaSJvHLv8be/NcpOgdmfaBmgW0pS59jRda1wUWyVcsDUA490HYAmE58ow==
X-Google-Smtp-Source: AGHT+IGHPmpBl6Bdl8Qp2JyReyGq7gwQ2acm2l6XNo5wrNkRMx+/bDt+7N9rhANpv/GyIIB7hPwqCQ==
X-Received: by 2002:a17:902:e84a:b0:1f7:1a9:bf05 with SMTP id d9443c01a7336-1f701a9c351mr65788585ad.53.1718043055831;
        Mon, 10 Jun 2024 11:10:55 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f71ba3bad1sm15530405ad.218.2024.06.10.11.10.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 11:10:55 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: linux-hwmon@vger.kernel.org
Cc: Rob Herring <robh@kernel.org>,
	linux-kernel@vger.kernel.org,
	Peter Yin <peteryin.openbmc@gmail.com>,
	Potin Lai <potin.lai.pt@gmail.com>,
	Daniel Matyas <daniel.matyas@analog.com>,
	Andrew Davis <afd@ti.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 3/4] hwmon: (pmbus/mp2856) Let enum chips start with index 0
Date: Mon, 10 Jun 2024 11:10:45 -0700
Message-Id: <20240610181046.1991436-4-linux@roeck-us.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240610181046.1991436-1-linux@roeck-us.net>
References: <20240610181046.1991436-1-linux@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Earlier it was assumed that the data pointer in of_device_id must not start
with 0 (NULL) if i2c_get_match_data() is used. However, it turns out that
this is perfectly fine as long as there is also an i2c_device_id array with
the same data, which is used as fallback in that case.

Let enum chips start with 0 to avoid confusion against other drivers
where the enum starts with 0 and i2c_get_match_data() is used as well.

While doing that, remove chip_id from struct mp2856_data since it is only
used in the probe function, and typecast the result of i2c_get_match_data()
to kernel_ulong_t to avoid the double typecast.

Cc: Peter Yin <peteryin.openbmc@gmail.com>
Cc: Potin Lai <potin.lai.pt@gmail.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/pmbus/mp2856.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/hwmon/pmbus/mp2856.c b/drivers/hwmon/pmbus/mp2856.c
index 6969350f5d7d..41bb86667091 100644
--- a/drivers/hwmon/pmbus/mp2856.c
+++ b/drivers/hwmon/pmbus/mp2856.c
@@ -46,7 +46,7 @@
 
 #define MP2856_PAGE_NUM			2
 
-enum chips { mp2856 = 1, mp2857 };
+enum chips { mp2856, mp2857 };
 
 static const int mp2856_max_phases[][MP2856_PAGE_NUM] = {
 	[mp2856] = { MP2856_MAX_PHASE_RAIL1, MP2856_MAX_PHASE_RAIL2 },
@@ -66,7 +66,6 @@ struct mp2856_data {
 	int vout_format[MP2856_PAGE_NUM];
 	int curr_sense_gain[MP2856_PAGE_NUM];
 	int max_phases[MP2856_PAGE_NUM];
-	enum chips chip_id;
 };
 
 #define to_mp2856_data(x)	container_of(x, struct mp2856_data, info)
@@ -397,6 +396,7 @@ static int mp2856_probe(struct i2c_client *client)
 {
 	struct pmbus_driver_info *info;
 	struct mp2856_data *data;
+	enum chips chip_id;
 	int ret;
 
 	data = devm_kzalloc(&client->dev, sizeof(struct mp2856_data),
@@ -404,9 +404,9 @@ static int mp2856_probe(struct i2c_client *client)
 	if (!data)
 		return -ENOMEM;
 
-	data->chip_id = (enum chips)(uintptr_t)i2c_get_match_data(client);
+	chip_id = (kernel_ulong_t)i2c_get_match_data(client);
 
-	memcpy(data->max_phases, mp2856_max_phases[data->chip_id],
+	memcpy(data->max_phases, mp2856_max_phases[chip_id],
 	       sizeof(data->max_phases));
 
 	memcpy(&data->info, &mp2856_info, sizeof(*info));
-- 
2.39.2


