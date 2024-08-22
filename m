Return-Path: <linux-kernel+bounces-296794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1547D95AF37
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 09:25:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0D0D2882C7
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 07:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65C9A16D4EF;
	Thu, 22 Aug 2024 07:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iTQtEtUr"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82EF6183CB5
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 07:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724311272; cv=none; b=fdePprTF7VwFfnTwySLq/cRoh3H4CeYqo5XvfI5AcwxXW2ruqCMx7pCpQWFcVCkcRbTed2t84atAIqx9/c7uvak26Kce3lKSfbCnLz36qAtSODFRKEnBHqHfexa+pEQPRKyeUg+cb3zgXJf5dTBKsQOCRA/gJY8GM40na5w9V3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724311272; c=relaxed/simple;
	bh=IV4SyJehbykvQ8y0yyNptHimzKJq/3QQZb7fgel7Lg8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hTnDQe2YTw7YXPDvdUnFCt5Y3/WsYZRd0TrWZsgc6TmJz+ZqWFotWBNc21cB+Uss0XVRZvxH+EZsjUF9hRjvhYyVMxxqoSe2CdxIMmBK76TxEIqO6lcC3TS1iSfosKJ99VjeOY+rJPBp7R5xgl44YDaQjLODrENqXZesUxwGSU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=iTQtEtUr; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7143185edf2so430466b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 00:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1724311270; x=1724916070; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VmtdE26bYTfUEgEWFh+anX0TX6bAFO2PB6s9GZztsew=;
        b=iTQtEtUr6gmbHpNh8ewVP21RzwhhFcIP85QdpKyQ2+ZYYW8bSzcYttGrL/x0gJnr6n
         RdUvNbffFiC1bMXDHesMgsXP8T4t7lELsZv1jtNig18JUhO1nOhNN92Fz45C2tQyrYJC
         ziHgHyI+y9iqUtqD5LaeWUESlWy+0kePaSfK0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724311270; x=1724916070;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VmtdE26bYTfUEgEWFh+anX0TX6bAFO2PB6s9GZztsew=;
        b=JBYamNZuUFrg0IRKBIpY3iy8Eodjwji4FufX9KMTFRfIfHbqPdvvr2NNirAe63nQJS
         ef7ERA65rpS4APBkV+DyQY9DeROEOqxbYBPunOpLu32iLUoDn5V/qrzOfUlyZnx3K62+
         0t5sNVOa186Y1n1NaXdy/oYmfFUXf6gYXBZO8cSoQACGGvn/S14SrtKM/CcJ89Sjg6sz
         xyTnJIeGnfcxRmXkOPTj5rUmfdKZq67Xowb3mUOZ0u3HeK9qZd57Pd7pVgbfjr0OB6ON
         f5vgJihEwv6OOlCpOKEbvy5YBR/lvr22vZQh8l3yVonNoppvRjNCCnD6crDyrK3h4vQK
         aNlw==
X-Forwarded-Encrypted: i=1; AJvYcCXvu141KVeDatrKmczr7pIIJE7wPcIPDCyL8MZsIzsABWuUoiPaogEOJlF2qCELFSsSOs4Nh5daCuK1kNw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0Sz06RkOLHCgSqBaP4RssxxbzwEI0hal5UbYKbi4t9CGDYYGC
	rel/Fkx/UnxGiUVAROPTiGAQzjq/04gpZbEN8wI/0Lfi+e1V9XPNI2UzsPkrZQ==
X-Google-Smtp-Source: AGHT+IGMB+dxjMGNVTHtpKof2PSsuFIg3K1prvJcIxcnrkvlZkXjsgC23fdUHqucez9Q1lukNxGFiA==
X-Received: by 2002:a05:6a00:10c4:b0:706:29e6:2ed2 with SMTP id d2e1a72fcca58-71436488fd8mr1064777b3a.5.1724311269746;
        Thu, 22 Aug 2024 00:21:09 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:8470:6a67:8877:ce2c])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7cd9ad6e8e9sm615901a12.86.2024.08.22.00.21.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 00:21:09 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 3/3] regulator: Fully clean up on error in of_regulator_bulk_get_all()
Date: Thu, 22 Aug 2024 15:20:46 +0800
Message-ID: <20240822072047.3097740-4-wenst@chromium.org>
X-Mailer: git-send-email 2.46.0.184.g6999bdac58-goog
In-Reply-To: <20240822072047.3097740-1-wenst@chromium.org>
References: <20240822072047.3097740-1-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently in of_regulator_bulk_get_all(), if any regulator request
fails, the error path releases all regulators already requested,
but leaves the |struct regulator_bulk_data| memory to the caller
to free, and also leaves the regulator consumer pointers dangling.
The latter behavior is not documented, and may not be what the
caller is expecting.

Instead, explicitly clean up everything on error, and make it clear
that the result pointer is only update if the whole request succeeds.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/regulator/of_regulator.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/regulator/of_regulator.c b/drivers/regulator/of_regulator.c
index 86b680adbf01..d557f7b1ec7c 100644
--- a/drivers/regulator/of_regulator.c
+++ b/drivers/regulator/of_regulator.c
@@ -747,19 +747,19 @@ static int is_supply_name(const char *name)
  * This helper function allows drivers to get several regulator
  * consumers in one operation.  If any of the regulators cannot be
  * acquired then any regulators that were allocated will be freed
- * before returning to the caller.
+ * before returning to the caller, and @consumers will not be
+ * changed.
  */
 int of_regulator_bulk_get_all(struct device *dev, struct device_node *np,
 			      struct regulator_bulk_data **consumers)
 {
 	int num_consumers = 0;
 	struct regulator *tmp;
+	struct regulator_bulk_data *_consumers = NULL;
 	struct property *prop;
 	int i, n = 0, ret;
 	char name[64];
 
-	*consumers = NULL;
-
 	/*
 	 * first pass: get numbers of xxx-supply
 	 * second pass: fill consumers
@@ -769,7 +769,7 @@ int of_regulator_bulk_get_all(struct device *dev, struct device_node *np,
 		i = is_supply_name(prop->name);
 		if (i == 0)
 			continue;
-		if (!*consumers) {
+		if (!_consumers) {
 			num_consumers++;
 			continue;
 		} else {
@@ -780,25 +780,28 @@ int of_regulator_bulk_get_all(struct device *dev, struct device_node *np,
 				ret = PTR_ERR(tmp);
 				goto error;
 			}
-			(*consumers)[n].consumer = tmp;
+			_consumers[n].consumer = tmp;
 			n++;
 			continue;
 		}
 	}
-	if (*consumers)
+	if (_consumers) {
+		*consumers = _consumers;
 		return num_consumers;
+	}
 	if (num_consumers == 0)
 		return 0;
-	*consumers = kmalloc_array(num_consumers,
+	_consumers = kmalloc_array(num_consumers,
 				   sizeof(struct regulator_bulk_data),
 				   GFP_KERNEL);
-	if (!*consumers)
+	if (!_consumers)
 		return -ENOMEM;
 	goto restart;
 
 error:
 	while (--n >= 0)
-		regulator_put(consumers[n]->consumer);
+		regulator_put(_consumers[n].consumer);
+	kfree(_consumers);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(of_regulator_bulk_get_all);
-- 
2.46.0.184.g6999bdac58-goog


