Return-Path: <linux-kernel+bounces-369479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE9939A1DCF
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 11:05:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B490E282F69
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 09:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 996FE1D88BF;
	Thu, 17 Oct 2024 09:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="h7AaFduF"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D880B1D6DAA
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 09:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729155925; cv=none; b=RvYXPHGl/h4VELUnKakaYDXkaAjB+G/Z4qVVDj8++ew0CWoGBauXAXh4MUlvRturVkrr8OlkB/wvebxZCYEuysdoVw56Mx4gHrTjd36lY1H6owH7K9mfq5coMhMvhR2oJnKvwCac1+xQzjFSmniH5ptVNI6NCTPNI8Epyn9KK4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729155925; c=relaxed/simple;
	bh=2YS4VB+nzvo1FXm3ikwmkzLGH9i8Mu04PEhbAh5W068=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RKX7oayozMI7nvJcmoTBopoo4fJW0UUYVE1xBo+RBNNmTqhzcLsEGTrYtnfxm4ugXsya9MgHkjPHSYqrbHJNa7TBJoFSLaSHoXWaWIFZIx451eNH5+bxodQ40iAQExo225LaOiXaWdXJMiY8kdLD0UY9lDEuClzxoQnqr4tLxrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=h7AaFduF; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2e30db524c2so530476a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 02:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1729155920; x=1729760720; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eq4DcLX81xhHJQxcCvF71zsYnZphDuzGs7+nmZig8nY=;
        b=h7AaFduFHHBOtt5gdSRyHJI4s/q3VUjwY0fXeRu1ba6wsIF9zMwcHwJnrnlL56dVe2
         tdxLdR5RbpCA+6ssaYSEClMpO/V7IrBsXZ2MIWuN2s478J6XKsK/tADWn3zsmzqDSu+q
         7hFOVQO99xoNX6xoTK6yiQPNull8fowFVs8bY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729155920; x=1729760720;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eq4DcLX81xhHJQxcCvF71zsYnZphDuzGs7+nmZig8nY=;
        b=qIkyuFRNOlZXDGxMyUgvpNxfRHJ+9iUtr8kGnz9lCL/rhMbtkw8yiYSKL59nRunpq/
         SQvI8qGAp9+gscjXS+oTy7Oh8nthqngfyfEf5MVOkYZTrmIOsnKhvP5XrbxRh0jfFGNf
         gr3rqgmT7EQQ46/bfAZz6UxNC4KgSgM30YoTEoQabggx21JjAxbhPP2PTEEqrUFWn/is
         UWxa9k4qZmCHjT9/6Nt9Zx01mdRR/5NW1FA1/9W3HR1lBwQl6Vg0pOLusPlvYIM2PxrP
         A09+1m11E5J70GfURE8JQ/KTyipg5Qt7n9cc7NuOcjSaFD9wrfjwkfm47n9lUoC2ww97
         +P3w==
X-Forwarded-Encrypted: i=1; AJvYcCVDbUIhK+Lr1/EPMvNNZ5kmGC7JKsRMwYOnGKbIzIyXQ3p5wv+tBLnjSQTPZHqG5B51C17xW29OMOYdtJ8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywr2PiK67MjLt/RRDawECobwAcGblfY3+DSJjBCn6vLVOUoYN53
	82QLwcPVgibT4Fh5otQOtMHQQGltuFA3AwPfO0yIcqURPsAU5ii5OqnL6/Lbyg==
X-Google-Smtp-Source: AGHT+IE8sc7gGXO+epscpZQ4+3ix7OqJhkRjhM95PD83qJR77jaGJm3mMk8J1ijNb16KGYomMx1MwA==
X-Received: by 2002:a17:90a:fe18:b0:2e2:af52:a7b7 with SMTP id 98e67ed59e1d1-2e31536e834mr19968279a91.34.1729155920193;
        Thu, 17 Oct 2024 02:05:20 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:fabb:a7ab:3d7:9aaa])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e3e08c0405sm1344305a91.14.2024.10.17.02.05.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 02:05:19 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Daniel Lezcano <daniel.lezcano@linaro.org>,
	Amit Kucheria <amitk@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>
Cc: Icenowy Zheng <uwu@icenowy.me>,
	Mark Brown <broonie@kernel.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	=?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= <nfraprado@collabora.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	linux-mediatek@lists.infradead.org,
	Hsin-Te Yuan <yuanhsinte@chromium.org>,
	Chen-Yu Tsai <wenst@chromium.org>
Subject: [PATCH v3] thermal/of: support thermal zones w/o trips subnode
Date: Thu, 17 Oct 2024 17:05:02 +0800
Message-ID: <20241017090503.1006068-1-wenst@chromium.org>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Icenowy Zheng <uwu@icenowy.me>

Although the current device tree binding of thermal zones require the
trips subnode, the binding in kernel v5.15 does not require it, and many
device trees shipped with the kernel, for example,
allwinner/sun50i-a64.dtsi and mediatek/mt8183-kukui.dtsi in ARM64, still
comply to the old binding and contain no trips subnode.

Allow the code to successfully register thermal zones w/o trips subnode
for DT binding compatibility now.

Furtherly, the inconsistency between DTs and bindings should be resolved
by either adding empty trips subnode or dropping the trips subnode
requirement.

Fixes: d0c75fa2c17f ("thermal/of: Initialize trip points separately")
Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
Reviewed-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
Changes since v2:
- Stacked on top of Krzysztof's cleanup patches
  - thermal: of: Use scoped memory and OF handling to simplify thermal_of_trips_init() [1]
- Adjusted to account for eliminated error path

[1] https://lore.kernel.org/all/20241010-b4-cleanup-h-of-node-put-thermal-v4-2-bfbe29ad81f4@linaro.org/

Changes since v1:
- set *ntrips at beginning of thermal_of_trips_init()
- Keep goto out_of_node_put in of_get_child_count(trips) == 0 branch
- Check return value of thermal_of_trips_init(), if it is -ENXIO, print
  warning and clear |trips| pointer
- Drop |mask| change, as the variable was removed

I kept Mark's reviewed-by since the changes are more stylish than
functional.
---
 drivers/thermal/thermal_of.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
index 93f7c6f8d06d..be1fa6478c21 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -99,14 +99,14 @@ static struct thermal_trip *thermal_of_trips_init(struct device_node *np, int *n
 
 	struct device_node *trips __free(device_node) = of_get_child_by_name(np, "trips");
 	if (!trips) {
-		pr_err("Failed to find 'trips' node\n");
-		return ERR_PTR(-EINVAL);
+		pr_debug("Failed to find 'trips' node\n");
+		return ERR_PTR(-ENXIO);
 	}
 
 	count = of_get_child_count(trips);
 	if (!count) {
-		pr_err("No trip point defined\n");
-		return ERR_PTR(-EINVAL);
+		pr_debug("No trip point defined\n");
+		return ERR_PTR(-ENXIO);
 	}
 
 	struct thermal_trip *tt __free(kfree) = kzalloc(sizeof(*tt) * count, GFP_KERNEL);
@@ -386,9 +386,15 @@ static struct thermal_zone_device *thermal_of_zone_register(struct device_node *
 
 	trips = thermal_of_trips_init(np, &ntrips);
 	if (IS_ERR(trips)) {
-		pr_err("Failed to find trip points for %pOFn id=%d\n", sensor, id);
-		ret = PTR_ERR(trips);
-		goto out_of_node_put;
+		if (PTR_ERR(trips) != -ENXIO) {
+			pr_err("Failed to find trip points for %pOFn id=%d\n", sensor, id);
+			ret = PTR_ERR(trips);
+			goto out_of_node_put;
+		}
+
+		pr_warn("Failed to find trip points for %pOFn id=%d\n", sensor, id);
+		trips = NULL;
+		ntrips = 0;
 	}
 
 	ret = thermal_of_monitor_init(np, &delay, &pdelay);
-- 
2.47.0.rc1.288.g06298d1525-goog


