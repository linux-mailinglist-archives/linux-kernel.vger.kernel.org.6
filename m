Return-Path: <linux-kernel+bounces-371158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 06D6E9A372B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 09:32:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB3C31F23326
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 07:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6547818872C;
	Fri, 18 Oct 2024 07:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jkkEY8UW"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B64D17C7C2
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 07:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729236711; cv=none; b=bAH1LE9MNQlgchGFmYza1yMjEUG1KguTfEUan+asGWqbgyh5ChWqdfsd/MFRzlk4ZTOS1NImPITSXtAgKm+N2yO5xfOJMLW2z8XngFGI3LxPo5lVFconyvANhaZDElH7DDy0doOGW1lu1abVK0vvlkcqTnbD8Jfu1VjrQwPZhiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729236711; c=relaxed/simple;
	bh=NH+L9Jxf2wkMM71Yi6LYSc5pR0cezzW0842zQcofwrQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sudhNhzjJ+51Fg+UX1+SAWwVwohJBeI3JF1vjEFaEk6n3an7pngIiOEceTP5gOFNW3EyhVC4p6ZW1Smf4y3mbnKALZ80kXcKon9fQhquCnwbPPfzCVU6HzzeRbq06uPf7PijljR6suzdiozVywn9OM2DKGGP9XnS217Ckb9yHJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=jkkEY8UW; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-20ca7fc4484so12613415ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 00:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1729236708; x=1729841508; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IlPybqmG9m/ZAU4ubVutLFbdpffPKHkEonNeryEzP1o=;
        b=jkkEY8UWc8kP09AaEoby7XyFsIt05PR4zqinhng5MwPk0ZKsAPZDD+mg/SDBUA8FRt
         GUIrRdqa4nQriRIiJqAeT8sIM0gj6pV4KPDMpGvMvkXduNzi7ZHyInNxJHyYr+o0bD3d
         hj1Qzzu7snOoyCa0y1UrtEsGJA5Fw/5OtX5QQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729236708; x=1729841508;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IlPybqmG9m/ZAU4ubVutLFbdpffPKHkEonNeryEzP1o=;
        b=jmO461VFDkhssQT2z0v5cgBVSSCyV6JhCyGHSeuarp4Z2sSPatiZnUz9LVqqwjXK71
         7AIWOWEuLZQplcv0du7sWGbIzQB5X4NqSp+/r3IOnPO0ALOw3YRnV/HDO2Lotbre0x0W
         SmYxPLh9ULWfBb2f49zC+5V0byG0r69J8BODvaiFZJ7FCXqm1rSHwsF0wfPb0Tf/fqWb
         nE5WM0heD6d1Ix9zCiGKtbuCuZmadXosbNFRvHetmMs3mEJ68kEjZttq7bR4Y/yF0fkl
         d1YIc9YbaSRZhx0/H9JDkVaXoh1k3ji3dp7xpCe76Y8Inp6ccHXqZNsBi1lJURJ5JZ9k
         1oTg==
X-Forwarded-Encrypted: i=1; AJvYcCWFl9Phr9hn1JrjTWH/tDXf76jONntsHPRH1LyucRtWZvk8CEYOOxjVwu2qFvpYCO7Ulx2vXEbsfXNabvI=@vger.kernel.org
X-Gm-Message-State: AOJu0YymU8Zcko7F8P7g2cwy0l/3+jyNr/zV0pKGKnoZA6daOn6vXdQu
	tDy+Uij7XhEiMGmdy6f41MF79f64bUaduzyqXBYwLIYhvXz4BNPwHKNnughcJg==
X-Google-Smtp-Source: AGHT+IHLIrR9ytIHJoh0tpY7PloSKaVtl6gokdxvrnHnBae8s/7gjJhQ59rft77DxeV3cTP3OmeRAA==
X-Received: by 2002:a05:6a21:70c8:b0:1d9:575:6659 with SMTP id adf61e73a8af0-1d92c58fa40mr2750256637.49.1729236708639;
        Fri, 18 Oct 2024 00:31:48 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:5e77:354e:2385:7baa])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7eacc229a7dsm745320a12.20.2024.10.18.00.31.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 00:31:48 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>
Cc: Icenowy Zheng <uwu@icenowy.me>,
	Mark Brown <broonie@kernel.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	=?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= <nfraprado@collabora.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-mediatek@lists.infradead.org,
	Hsin-Te Yuan <yuanhsinte@chromium.org>,
	Chen-Yu Tsai <wenst@chromium.org>
Subject: [PATCH v4] thermal/of: support thermal zones w/o trips subnode
Date: Fri, 18 Oct 2024 15:31:36 +0800
Message-ID: <20241018073139.1268995-1-wenst@chromium.org>
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
[wenst@chromium.org: Reworked logic and kernel log messages]
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
This patch is based on Krzysztof's cleanup patches
  - thermal: of: Use scoped memory and OF handling to simplify thermal_of_trips_init() [1]

Changes since v3:
  - Set *ntrips = 0 and return NULL from thermal_of_trips_init() if
    no trip points are found in the device tree (Rafael)
  - Dropped log level of "no trip points found" message to INFO
  - Reworded new "failed to find trip points" message to "no trip points
    found"
  - Reworded existing "failed to find trip points" message to "failed to
    parse trip points"

I dropped Mark's reviewed-by because of the new changes.

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

---
 drivers/thermal/thermal_of.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
index 93f7c6f8d06d..abafce22c91f 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -99,14 +99,16 @@ static struct thermal_trip *thermal_of_trips_init(struct device_node *np, int *n
 
 	struct device_node *trips __free(device_node) = of_get_child_by_name(np, "trips");
 	if (!trips) {
-		pr_err("Failed to find 'trips' node\n");
-		return ERR_PTR(-EINVAL);
+		pr_debug("Failed to find 'trips' node\n");
+		*ntrips = 0;
+		return NULL;
 	}
 
 	count = of_get_child_count(trips);
 	if (!count) {
-		pr_err("No trip point defined\n");
-		return ERR_PTR(-EINVAL);
+		pr_debug("No trip point defined\n");
+		*ntrips = 0;
+		return NULL;
 	}
 
 	struct thermal_trip *tt __free(kfree) = kzalloc(sizeof(*tt) * count, GFP_KERNEL);
@@ -386,11 +388,14 @@ static struct thermal_zone_device *thermal_of_zone_register(struct device_node *
 
 	trips = thermal_of_trips_init(np, &ntrips);
 	if (IS_ERR(trips)) {
-		pr_err("Failed to find trip points for %pOFn id=%d\n", sensor, id);
+		pr_err("Failed to parse trip points for %pOFn id=%d\n", sensor, id);
 		ret = PTR_ERR(trips);
 		goto out_of_node_put;
 	}
 
+	if (!trips)
+		pr_info("No trip points found for %pOFn id=%d\n", sensor, id);
+
 	ret = thermal_of_monitor_init(np, &delay, &pdelay);
 	if (ret) {
 		pr_err("Failed to initialize monitoring delays from %pOFn\n", np);
-- 
2.47.0.rc1.288.g06298d1525-goog


