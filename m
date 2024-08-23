Return-Path: <linux-kernel+bounces-299241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 792B995D1EA
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 17:45:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2592A1F21BE7
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 15:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 025A618BC0C;
	Fri, 23 Aug 2024 15:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j6JXTcaM"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B60718A6C4
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 15:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724427800; cv=none; b=h8k90JprT2wFFf9Dm/vjp46IfD0UaNmQZROgBPTlAPwqo3MpD3qSPAI/tZBcvm9ooMD+yOHGkzDMpmzvaNcP4ybrCll9ZL2ISqlZ0kwpcKFK3aCgJd+fjTqy4L2McYxccH1yN2ynZbePpYkYAITpDNGmwKmL54kBHLa97RBurU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724427800; c=relaxed/simple;
	bh=UAAKsIvCmNiVqRTFLcLoUi86VSU3tPObaOIJAs0+nhA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RR7Itb3qG32mLtdWh6EHyZ88M22RWqYBqZFeuGUPM97ZN85/hWPU8LzwQf/sbTD4q/OJavsW4An18mttI03eX62PkWJQgFfshUa/5wJMIxPlLFn4pbQadO5y5XMD35Re9e/CT6pVk450foDu4Bgt2cCdfLgCTae/gtDnxuuu4ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=j6JXTcaM; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4281faefea9so16149805e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 08:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724427797; x=1725032597; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WtnMpPUERM2pDdBMnHXsV0NgdHCRPYPmkwqv5dMYPzQ=;
        b=j6JXTcaMvgKn5W8iLbZSxd/KiNkvIXjagBaCFCH0AmkafB75u79rJ1/bfmI2svJ0q1
         3KECHqtSVgrLjKE8aXuDgrcgtEJ5wgT9SGxKGnET8iT85j96/QXBJVATQbYS9HuIicGo
         HCwlOCH8IJ8sxHwnRlfQ6VkB9apBKaxvbt0mjlTU8oEm2jRxszXX4CXVL8YOC0V6CJZJ
         CozDTSmB6q0BW1qxSJs/x++PPSRgVASqz+pvPilliMlYpvZN3Y6M0EbIecdg3XYGyXJJ
         DnJ/n9CxiF7kXGLglZmEajvJY+9AEQ9pvFPMM14HITJyFbsN4k8ymB+AX/S8UhvKa+PY
         lgPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724427797; x=1725032597;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WtnMpPUERM2pDdBMnHXsV0NgdHCRPYPmkwqv5dMYPzQ=;
        b=uSJqj4yNKPwSq7F8ng8CAw2+WuQBA152YSaRaJ2cT4s1XCjJcuBf2C7gHJ9xs8Siq3
         8uD82kHZhOSZZoCGODggAmuYOnsVmkxNchIiWJnvb7qsiEKu7OQFCBJIj4ePje3pIadW
         nD31AfSYYcrzMv/QzNcIkAJ3mDG9XPGA8iE2JDV/Gfs2xPDYLqQZtB2hzSgEnC7qcFnG
         yMkRCDsXY0raelHpj0keDsPlt6OwAYH4mUTcbUyxCFqQ86xrS195EJmyLiSAL680jOHd
         bhj1E4mibrZWN83vqXx0Rx1vkLMe4cuvfBLSA4qUSJNQK1gFjwrHx4JTe48bWInh2Chy
         0DsA==
X-Forwarded-Encrypted: i=1; AJvYcCWT4GylVIgWXlsg/bqNCfeEUhbYcL2vVhT6qnWnyeqXTbv2svKNiFPBGU8j2C8WGc9TWJfwde8sBFolbKA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywio35j9g0EgRrSFSpt9oOQ73usmCKqG7gJK4gJjX/7fWHyA8wF
	HjXuw9+twmt7QRZNb9ptC/aMXbaq+vKC0gv01w1ixp9iWIosCx6LnHl9ak2as4o=
X-Google-Smtp-Source: AGHT+IH/51VXtSOjuCnDyuonQwj6xZRhLMvkaTQ3d7h/0AoF41O+/4rayP6IPnGDhi6+Curs1LtZsg==
X-Received: by 2002:a05:600c:4a9d:b0:427:ac40:d4b1 with SMTP id 5b1f17b1804b1-42b89bf4d11mr6601865e9.27.1724427796647;
        Fri, 23 Aug 2024 08:43:16 -0700 (PDT)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-373081ff5b8sm4395891f8f.85.2024.08.23.08.43.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 08:43:16 -0700 (PDT)
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: daniel.lezcano@linaro.org,
	rafael@kernel.org
Cc: linux-pm@vger.kernel.org,
	=?UTF-8?q?J=C3=A9r=C3=A9mie=20Garcia?= <jgarcia@baylibre.com>,
	Alexandre Bailon <abailon@baylibre.com>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [RFC PATCH 2/2] thermal/of: Use thermal_zone_device_param
Date: Fri, 23 Aug 2024 17:42:44 +0200
Message-ID: <20240823154245.1553458-2-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240823154245.1553458-1-daniel.lezcano@linaro.org>
References: <20240823154245.1553458-1-daniel.lezcano@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

As we can use the thermal_zone_device_param structure to pass the
thermal zone parameters, let's use it in thermal-of code.

Cc: Jérémie Garcia <jgarcia@baylibre.com>
Cc: Alexandre Bailon <abailon@baylibre.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/thermal_of.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
index 1f252692815a..3e494ff88648 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -474,12 +474,9 @@ static struct thermal_zone_device *thermal_of_zone_register(struct device_node *
 {
 	struct thermal_zone_device_ops of_ops = *ops;
 	struct thermal_zone_device *tz;
-	struct thermal_trip *trips;
-	struct thermal_zone_params tzp = {};
+	struct thermal_zone_params tzp = { .devdata = data, .ops = &of_ops };
 	struct device_node *np;
 	const char *action;
-	int delay, pdelay;
-	int ntrips;
 	int ret;
 
 	np = of_thermal_zone_find(sensor, id);
@@ -489,14 +486,14 @@ static struct thermal_zone_device *thermal_of_zone_register(struct device_node *
 		return ERR_CAST(np);
 	}
 
-	trips = thermal_of_trips_init(np, &ntrips);
-	if (IS_ERR(trips)) {
+	tzp.trips = thermal_of_trips_init(np, &tzp.num_trips);
+	if (IS_ERR(tzp.trips)) {
 		pr_err("Failed to find trip points for %pOFn id=%d\n", sensor, id);
 		ret = PTR_ERR(trips);
 		goto out_of_node_put;
 	}
 
-	ret = thermal_of_monitor_init(np, &delay, &pdelay);
+	ret = thermal_of_monitor_init(np, &tzp.polling_delay, &tzp.passive_delay);
 	if (ret) {
 		pr_err("Failed to initialize monitoring delays from %pOFn\n", np);
 		goto out_kfree_trips;
@@ -512,9 +509,7 @@ static struct thermal_zone_device *thermal_of_zone_register(struct device_node *
 		if (!of_ops.critical && !strcasecmp(action, "reboot"))
 			of_ops.critical = thermal_zone_device_critical_reboot;
 
-	tz = thermal_zone_device_register_with_trips(np->name, trips, ntrips,
-						     data, &of_ops, &tzp,
-						     pdelay, delay);
+	tz = thermal_zone_device_register(np->name, &tzp);
 	if (IS_ERR(tz)) {
 		ret = PTR_ERR(tz);
 		pr_err("Failed to register thermal zone %pOFn: %d\n", np, ret);
@@ -522,7 +517,7 @@ static struct thermal_zone_device *thermal_of_zone_register(struct device_node *
 	}
 
 	of_node_put(np);
-	kfree(trips);
+	kfree(tzp.trips);
 
 	ret = thermal_zone_device_enable(tz);
 	if (ret) {
@@ -535,7 +530,7 @@ static struct thermal_zone_device *thermal_of_zone_register(struct device_node *
 	return tz;
 
 out_kfree_trips:
-	kfree(trips);
+	kfree(tzp.trips);
 out_of_node_put:
 	of_node_put(np);
 
-- 
2.43.0


