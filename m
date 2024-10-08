Return-Path: <linux-kernel+bounces-355559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF930995409
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 18:08:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 47AD2B2753F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 16:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 188BA1E0DCE;
	Tue,  8 Oct 2024 16:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="QqXhyUKv"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3967284A35
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 16:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728403668; cv=none; b=C59qPCZDToMU4ksgXWnWesMvB88M3bDQRhaq/GJTGKr4jmYo4wrXUEGYdtDGbbgbODqgrZVKMpRmqNYm0RVIgjLBmjoHZrCMKFfW8hvnkNS6W45D4jTT1+ZCPgcV5eeLgTjbLnxzQxmOqdpEH49robSJvCbM0TgzjVsBsO87IkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728403668; c=relaxed/simple;
	bh=SLpYYIhwuRweVEWtXaaExUucJuJAaFTutEyzIFc19Ys=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CDbgtvHG/v94o2UmwC3w/gFTaaNkZue3IzJwbe8VuLO1ArVysQbNO/yFLr9bZU1oPpql3gGU/lTtOE8SAETHyumKM6beLw3PeLX81S06zlO+kpBILUpO2P+ET00PRIq18bikoGr/D1ov5IPW3kjePVwpmQF/+7RqNuUy8NiilLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=QqXhyUKv; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-42cb2191107so52396345e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2024 09:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1728403664; x=1729008464; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xDbgGqNHBzRgP8skRhDRSOpGwGytoSrr7Q6T0y3qesI=;
        b=QqXhyUKvmcZ6S6JtErEvLORzY+4WmK1uRkocfnFV/qQjMZDG/LkmbJPL0wGgSsquX+
         UMSMaBlzb3bpfdfhDMsS/UzNGiwq02iZGn0c8bcwaScoMI6F1wGfaPI13GsRP3lbgWe6
         DFDxJExcTawlfOp3z8Oso2/aXE1qByI1p/fXtWCTufZ4qNP6LNNPzC+rBDATCxxfUZbn
         S4BTg+f6f30qXz/rTJMcijaLulROfN+vH94L8IKN3fL79r2WmwL3Pflvtf5Ah/G75M/M
         2nFpWWhlcM3f52pa3BmH7Xyt5m+pHyDTzInefCfh3fB5Q3ejcBq005qHkTGm9t29selF
         zpaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728403664; x=1729008464;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xDbgGqNHBzRgP8skRhDRSOpGwGytoSrr7Q6T0y3qesI=;
        b=wpQ9u2XUdymbYFyZ6CDoPB2NewrGC7Su1fGwGdy72m+SJBJgTBbRlQjrz6v7u0fBCA
         Qtn2LdGw+FYw2k/FwiEafBbb3EZqXbR9d7sugNO8zIByPwGFONnkZ25pr76z2YcrO2Ls
         o4H1bcNt5zCsH1yzNLT/CHhcwr/TTlWg7OzEI1gpAREKKWAa4vzPjRLK1CErXegzdfRt
         4ZdHN8GN6nfvyzlKh2Zk5vwkPi4jrU3DxqAxHXOrUUdc7wj9MyeJyDuTRs0IxFPyiQl+
         9Neju2KqpvRuaXT0Ze2VX5UbUpOlhiHvRq4jd/+MvPmO5q2VBXAYMTfDiqIOqiSwVbSQ
         hwCg==
X-Gm-Message-State: AOJu0YzE2d+4i785bFNGZlI0h+gVFBgrzYEzUL8q4iO1GjahRuiRnsJD
	lZgcFQ3tEoE2Q9tReZJdmdC8qbC9xf6Y5gAdaC3vclHio8khNL428rRVjZFB0z8=
X-Google-Smtp-Source: AGHT+IGXf5QLoPw16k9d991f5pOjDzBf+dRdwCs0K8OQU+2mi8LSHFPyk3LIsmXp9D0e6YZQzkEVNw==
X-Received: by 2002:a05:600c:4f15:b0:426:554a:e0bf with SMTP id 5b1f17b1804b1-42f85ac0af7mr128799175e9.16.1728403664475;
        Tue, 08 Oct 2024 09:07:44 -0700 (PDT)
Received: from toaster.baylibre.com ([2a01:e0a:3c5:5fb1:41f2:4244:ce34:c273])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-42f86a20537sm131509375e9.15.2024.10.08.09.07.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 09:07:43 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Tue, 08 Oct 2024 18:07:02 +0200
Subject: [PATCH v2 2/3] regulator: core: add callback to perform runtime
 init
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241008-regulator-ignored-data-v2-2-d1251e0ee507@baylibre.com>
References: <20241008-regulator-ignored-data-v2-0-d1251e0ee507@baylibre.com>
In-Reply-To: <20241008-regulator-ignored-data-v2-0-d1251e0ee507@baylibre.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, 
 Jerome Brunet <jbrunet@baylibre.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1560; i=jbrunet@baylibre.com;
 h=from:subject:message-id; bh=SLpYYIhwuRweVEWtXaaExUucJuJAaFTutEyzIFc19Ys=;
 b=owEBbQKS/ZANAwAKAeb8Dxw38tqFAcsmYgBnBVjLCQGgCHGjYMW07hkUpd8/1wsZMwG2DyQqm
 9ahPocghOSJAjMEAAEKAB0WIQT04VmuGPP1bV8btxvm/A8cN/LahQUCZwVYywAKCRDm/A8cN/La
 hakcD/9MpkrwSCOdq50efCzV2yjgLNTwlu4tEX+4aJGvg+62GIfQ24VWjNB/+eCiDcbkoHOhPtJ
 RrMfm692x+OXYXwmlcKigsFiGYjVakMSzwaesI/WyP7F+JSY8BYY6310gfM6oVaS4fIolkrkQtj
 CyVcGIs4OF5Mt9IajLJ14vPLp5AtMggjR3GTK6kk8sYQtLudud5kQUYlqrymoHU7467IxAMBY4c
 wuzCkbkA1+f4gihDoQ3oDHJlTMXHgXVc3paNI0/jKopbDp3cAfmP/F1ZKu0qphI+pLyBCZWeN9z
 sEYLTAeIp0QupbZ+rAWOHbSdqTrF5mDhC/qhoZwveVz5PKNxXacks1RnJ3gkoCP1vBHseKTlsYj
 4gdaKOusA5mnKkSanHQjJiu5zw53Aw4UvytHlKiNrr+6OzH+VjOYkZUtStUxTzkW2x5kdgNuGpj
 JWzqkWj0gHwZukq4b2o/PNUl2Pi4vtyH5OFbXueRRu3o3LwCOc3VY0EGZ2HjRjw29NsYuTh6PhV
 FdT4EIihqmcZaMwB426loSAfM2JMqNJkA3bIJAh9GAQTEB1xiNViOOoSFbFMmHhvFTNWn6rjnds
 pnH48R+jeObUnC9jEpYB9W4Rq7FshcxfOIZbanSzHhWUJkY/zCt6CULRfQcDMunTE+L3YuW37Ve
 j5qzStF/TsAmV0Q==
X-Developer-Key: i=jbrunet@baylibre.com; a=openpgp;
 fpr=F29F26CF27BAE1A9719AE6BDC3C92AAF3E60AED9

Provide an initialisation callback to handle runtime parameters.
The idea is similar to the regulator_init() callback, but it provides
regulator specific structures, instead of just the driver specific data.

As an example, this allows the driver to amend the regulator constraints
based on runtime parameters if necessary.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/regulator/core.c         | 6 ++++++
 include/linux/regulator/driver.h | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index a58a9db3d9c7..f8b5d596f59d 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -5758,6 +5758,12 @@ regulator_register(struct device *dev,
 		goto wash;
 	}
 
+	if (regulator_desc->init_cb) {
+		ret = regulator_desc->init_cb(rdev, config);
+		if (ret < 0)
+			goto wash;
+	}
+
 	if ((rdev->supply_name && !rdev->supply) &&
 		(rdev->constraints->always_on ||
 		 rdev->constraints->boot_on)) {
diff --git a/include/linux/regulator/driver.h b/include/linux/regulator/driver.h
index f230a472ccd3..d2f4427504f0 100644
--- a/include/linux/regulator/driver.h
+++ b/include/linux/regulator/driver.h
@@ -365,6 +365,8 @@ struct regulator_desc {
 	int (*of_parse_cb)(struct device_node *,
 			    const struct regulator_desc *,
 			    struct regulator_config *);
+	int (*init_cb)(struct regulator_dev *,
+		       struct regulator_config *);
 	int id;
 	unsigned int continuous_voltage_range:1;
 	unsigned n_voltages;

-- 
2.45.2


