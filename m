Return-Path: <linux-kernel+bounces-334568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4186897D8F9
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 19:21:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC8791F22AD5
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 17:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4BFF1802AB;
	Fri, 20 Sep 2024 17:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="c4lUKlfC"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1488A17E473
	for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 17:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726852882; cv=none; b=A1dnb6l0HvcLM7SM5fxO/MlTF0tHc6XFmNGODJ3I3zbFYe5VBZ/sUyN6Zd2S8Fz+1vQMxPwkeFc8GXVxSC7rs0u2s1VUbe3gA8zGl6AYgMvGRWKbNc4e6srlmzq7+K92Ngq02ozk6AVn3Qc8Urmwy6cdqCcUwVxK/O4BOWawnRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726852882; c=relaxed/simple;
	bh=i9faMMDzHAYnkwVom/xxkPsv8RRYuaQOLsFwTh6kj24=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=tSOds7Mt1VDjr68N+7RgmLd6KJX0ignNTL5Q01AReAfUIq1RvGlvpuqr9h7AjvM8TUiE/hJryssSI2DyjZXuw8jmKrb+eNZ2L0Bi0hCcibXB+8uZdFBi3X4YNoJ1uZf+7AoJBYAoIWfednnzqmm4MkZQcAYEH3ybSe3qcTcQqoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=c4lUKlfC; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-42e7b7bef42so9642115e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 10:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1726852877; x=1727457677; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fzT2UdLnWWeArmAm4zpcjIK8wgZcrSCFmO4panR9HVc=;
        b=c4lUKlfCeSuf6Py2FMscuOHqmIWil5HbeXBnIrhEFqc5h3PObXjnFPGtAyZaJ7EAHr
         LHQ+h4yJfGuqBRXx1i/IyP1NkcKfceUWNZxhv9So2GZuM6g9qNcBj7lKhg4/u4DhQUVo
         QfB1yO9WL3kMdLB8UIqMKjo7mYN8qWH5pWyc3mA50H1JGiKciqCa2zB3kXV+jC2e1dvK
         PbQ/PMDbL14SD+0OtBf9EWD69ScWL+hW2Ze0+cdjxlAev8dBZ9JpIjKjzfYyLvkjtgCL
         W9G9HPi6Ege6L95+ku1+L86br4PiTp/I/90jYJM2oZ5NlUtTnU245vTQNJU9Ae4FxJOK
         omeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726852877; x=1727457677;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fzT2UdLnWWeArmAm4zpcjIK8wgZcrSCFmO4panR9HVc=;
        b=L1PVtDh75owXNrIHz9S6a2DX36fP210junE9i303MaJPsb95n6uvQtaxvFTjxU8LQt
         pEQl2EUga7Y89+/ulhvqU7UNzVg5EZ79lRfDaNtrObmkNkjPBHvTL+lUT8nEAUN5vkeL
         KliJUEBIJZkNzLm9iG7WcND1oVk3k8LBJC6c/mgnlooAc+tnrr0NsE8RO73rWKpHtRsz
         0wq5ZbezKxFAI2st6cBBG56Run5i5ybMOeIG//nhyz0n9GDQYZadJPKxU7ZbfBNjRfrr
         cZ+rs4RCNjqlVWo+XxyYvx/uBW3TMWzGS4EXZpwbHwRRcFxsd2t8VpHECOyxpWzZEkDm
         hFqQ==
X-Gm-Message-State: AOJu0YyjgbrORnniiq4Cq8+JJWVd3cR0MViSQOkpOlcG9KquyHWq7ml0
	rPqd/grRMyeTRmi4d9N7s1sBl03QoVE2BInJKA+/otuS1Oc3jGHG09xgw0oIqXB8zJ4ok3W6SR8
	w
X-Google-Smtp-Source: AGHT+IG/9kpp0sAvm+IXmEZsCPzdisZx6rPG+QgpIfKok7M8i5Be0gaqmIqgDa7qYzxZsOb4a9+Uzw==
X-Received: by 2002:a05:600c:4f55:b0:426:593c:9361 with SMTP id 5b1f17b1804b1-42e7c193efbmr24211705e9.26.1726852877096;
        Fri, 20 Sep 2024 10:21:17 -0700 (PDT)
Received: from toaster.baylibre.com ([2a01:e0a:3c5:5fb1:8e69:83a7:a29a:ba83])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-378e780028esm18092097f8f.71.2024.09.20.10.21.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2024 10:21:16 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Fri, 20 Sep 2024 19:21:12 +0200
Subject: [PATCH] regulator: do not ignore provided init_data
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240920-regulator-ignored-data-v1-1-7ea4abfe1b0a@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAAev7WYC/x3MywrCMBBG4Vcps3Ygpld9FeliMH/TAUlkUkUof
 XdDl9/inJ0KTFHo3uxk+GrRnCqul4aeq6QI1lBN3vnO3bxjQ/y8ZMvGGlM2BA6yCY8TRpn6fuh
 aUI3fhkV/5/gxH8cfs5w5cWgAAAA=
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, Jerome Brunet <jbrunet@baylibre.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=3021; i=jbrunet@baylibre.com;
 h=from:subject:message-id; bh=i9faMMDzHAYnkwVom/xxkPsv8RRYuaQOLsFwTh6kj24=;
 b=owEBbQKS/ZANAwAKAeb8Dxw38tqFAcsmYgBm7a8L1uNoMc8F0k9yhspRSh3QXxTiECIhw5OSt
 g4gpTtphd2JAjMEAAEKAB0WIQT04VmuGPP1bV8btxvm/A8cN/LahQUCZu2vCwAKCRDm/A8cN/La
 hS8MD/4l9QudZGC/jTEq66j+W+z42XkmBnvn9Tebf2PWE9sikLuEG9dqTm1u+U+jEYyBoKCXYJS
 eu+mljUeGpggG7CZ635EAJL8lLBjdSZ9Ybk8UD7t4ZSGk9uSCr76GuhBLiMZ49jnbc/Qx6O1oCk
 PPWU5Rig9JaS99vIiET3J08Ru9R3p/7lZvgnq+fwPv5PetVXhiHVWDLwQohCkdXwZ0j4fRXAwBM
 VoB0M9UKRradggk8O6tV214MUMJTyT4p5GadVcdedX2JykanQRT0URatvUM+4MPpRYeHq/ZIRFo
 hPdRVDmr8CZL0bGDO/aNQ5UCjXRbj+KRjghth4d87C4yz/UCF/UMYD9CGOvTzSEJwTH8KCTLR7P
 spIqeFaR/Omm5scyvboD2YdRFWH3qXfJt+9GRevlqjJjLw/8i09W6cM8tlhH7s9xS1ei4ZS57bj
 1zoeV4o7+rwnHvKnAu9Qu+40EcHMDUbtaGYNgALGGK5auMZk11KyFxD066gtzcpxT+EzC2UmTFp
 WJAYyIyMIEh0ubG5lHj7rHZQtzuVHkBh4UgyAZXGYRRGG/OIPamzCIWPn4kIewxcxtP/+vqOOqX
 Lj7/O14scbAuOkZyDewv3a45BLsPiDZbTtRfM66PahlzCTG4HH3h35l5JP34a6TPQ72iM+nojUm
 RE+PnFmsyairoLw==
X-Developer-Key: i=jbrunet@baylibre.com; a=openpgp;
 fpr=F29F26CF27BAE1A9719AE6BDC3C92AAF3E60AED9

On DT platforms, if a regulator init_data is provided in config, it is
silently ignored in favor of the DT parsing done by the framework.

If the regulator provider passed init_data it must be because it is useful
somehow. If the driver expects the framework to initialize this data on its
own, it should leave init_data clear.

Adjust the regulator registration accordingly.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
Note that it is probably not problem at the moment since no one complained
about ignored data.
---
 drivers/regulator/core.c | 51 +++++++++++++++++++++++++-----------------------
 1 file changed, 27 insertions(+), 24 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 1179766811f5..fcafebcebf48 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -5681,32 +5681,35 @@ regulator_register(struct device *dev,
 		goto clean;
 	}
 
-	init_data = regulator_of_get_init_data(dev, regulator_desc, config,
-					       &rdev->dev.of_node);
-
-	/*
-	 * Sometimes not all resources are probed already so we need to take
-	 * that into account. This happens most the time if the ena_gpiod comes
-	 * from a gpio extender or something else.
-	 */
-	if (PTR_ERR(init_data) == -EPROBE_DEFER) {
-		ret = -EPROBE_DEFER;
-		goto clean;
-	}
-
-	/*
-	 * We need to keep track of any GPIO descriptor coming from the
-	 * device tree until we have handled it over to the core. If the
-	 * config that was passed in to this function DOES NOT contain
-	 * a descriptor, and the config after this call DOES contain
-	 * a descriptor, we definitely got one from parsing the device
-	 * tree.
-	 */
-	if (!cfg->ena_gpiod && config->ena_gpiod)
-		dangling_of_gpiod = true;
-	if (!init_data) {
+	if (config->init_data) {
 		init_data = config->init_data;
 		rdev->dev.of_node = of_node_get(config->of_node);
+
+	} else {
+		init_data = regulator_of_get_init_data(dev, regulator_desc,
+						       config,
+						       &rdev->dev.of_node);
+
+		/*
+		 * Sometimes not all resources are probed already so we need to
+		 * take that into account. This happens most the time if the
+		 * ena_gpiod comes from a gpio extender or something else.
+		 */
+		if (PTR_ERR(init_data) == -EPROBE_DEFER) {
+			ret = -EPROBE_DEFER;
+			goto clean;
+		}
+
+		/*
+		 * We need to keep track of any GPIO descriptor coming from the
+		 * device tree until we have handled it over to the core. If the
+		 * config that was passed in to this function DOES NOT contain a
+		 * descriptor, and the config after this call DOES contain a
+		 * descriptor, we definitely got one from parsing the device
+		 * tree.
+		 */
+		if (!cfg->ena_gpiod && config->ena_gpiod)
+			dangling_of_gpiod = true;
 	}
 
 	ww_mutex_init(&rdev->mutex, &regulator_ww_class);

---
base-commit: cd87a98b53518e44cf3c1a7c1c07c869ce33bf83
change-id: 20240920-regulator-ignored-data-78e7a855643e

Best regards,
-- 
Jerome


