Return-Path: <linux-kernel+bounces-280463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 76B5C94CAF3
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 09:09:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C41A4B236E5
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 07:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E576C16D9A2;
	Fri,  9 Aug 2024 07:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fl/YGOaz"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC7C716D4FE
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 07:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723187335; cv=none; b=EtN3BwMe0OzEOVln4bFO331fv3AMjEcSp6Wss7hMFOpfuIiSiJCAXgpUHK6fhTPqDxSzLg/+E2XXT7XsvOhlbhQZ6eZoR/eSghUeYyKOov7ttB9tCptm81FsFOXqfyXQgTUNRwHSGdwbXirGFK4VQm11logITx9DOVq4DJ9NoOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723187335; c=relaxed/simple;
	bh=1N26HGLw//R3d32px3tfcAXifr5s/f7rI6nJGtHpe08=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KzRKcqg41Og0SyZOmKOzwsJaIG4BxqiJAn28wZir8CzvJr3xKDGrz7t6nn4qjFPBEwt2e0hHB1cYSfrSQLp1UBAwbQmNsfg2yREUq19NmSri+tRm+wL82T2C4firD3YAAuC/UlCBgYdho8ozTkIBUTP8lvdAaBlY66vzqw+RdX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=fl/YGOaz; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1fc4fccdd78so15455885ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 00:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1723187333; x=1723792133; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TSZy4qeB9prpZkXZFFSCy09Nr7J/x1zL/3+bFofkJV8=;
        b=fl/YGOazmUU8dFbFqU21k8RuxP7J+gnZnpKsbEwNqtEMPOhMvjJoVAvEt7vCkNt3NZ
         zTWgnXORGRooqQ7cloprrqg4/cwPZuTUnDCUk9DCX5I9MHde+1aVgd6hRXtI42IGLp2A
         OqKwcXDxTGRG+DEFj4IV8TeDoQRL3fFXwyIaY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723187333; x=1723792133;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TSZy4qeB9prpZkXZFFSCy09Nr7J/x1zL/3+bFofkJV8=;
        b=svwUxlO0GEd5tcw2o+zn8CdLp197ijdH9M4Ytp6dqTOPjNwheVfI4btQtM0RabzP0/
         WAx6LBgBEFylLis3lMYxpwWpLCTUyIXs4nspLMQeHiuar1uEavCh9KLv3d4gmpNZfF6O
         CNP+xSiN9/Xh190HGsU5gbeShYglLh8xhPkqYoPn7taM/7vdM5fffqITaG3TMsqjm8+t
         rSAJC/IWPF7qeLpEoyQQatIsoICP5w2dSkyNMFrAwdEsTMESaOethZ531g+27Nx2AAq7
         v78uPG/tPhiicHLEW7/sd8LeNYwyDOcwSzs9Tp0JooozjjAJWuMhP4ADrR9LfaHHrBMq
         or7A==
X-Forwarded-Encrypted: i=1; AJvYcCVab9JBudrDidlXvhvrB3vuRRv6BvU+g88XOi3pm3ErMpcR/eygqufcdP3DdPHugrysoZGsFxhvHxH3bIpMVEcGRZVstWIP63KMqkK7
X-Gm-Message-State: AOJu0YxZdZ141+Wqag1Lf7U3RDPMTMO8LgGkIK6nkrvB3qRLrQPhLB0X
	5a0LRJ9MhopkdFodA/UJKz6xtEGwB7fZdqbx6K4Hmsqx0CCPZv2ucDt6Ii/1bw==
X-Google-Smtp-Source: AGHT+IEojA8/Dm/IiJ94OPxhJiSpOpo4eMo23qz6LSsMPk8j238AnhJYY+ravisXXY3kEbh0Zu1A8A==
X-Received: by 2002:a17:903:41ca:b0:1fb:7435:c2cc with SMTP id d9443c01a7336-200ae5e6889mr6909505ad.45.1723187333055;
        Fri, 09 Aug 2024 00:08:53 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:e48b:2b26:14f9:21cb])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff59294515sm136254215ad.244.2024.08.09.00.08.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 00:08:52 -0700 (PDT)
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
Subject: [PATCH v2] thermal/of: support thermal zones w/o trips subnode
Date: Fri,  9 Aug 2024 15:08:19 +0800
Message-ID: <20240809070822.2835371-1-wenst@chromium.org>
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
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
Resurrecting this patch specifically for MediaTek MT8183 Kukui devices.

Changes since v1:
- set *ntrips at beginning of thermal_of_trips_init()
- Keep goto out_of_node_put in of_get_child_count(trips) == 0 branch
- Check return value of thermal_of_trips_init(), if it is -ENXIO, print
  warning and clear |trips| pointer
- Drop |mask| change, as the variable was removed

I kept Mark's reviewed-by since the changes are more stylish than
functional.
---
 drivers/thermal/thermal_of.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
index aa34b6e82e26..f237e74c92fc 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -128,16 +128,17 @@ static struct thermal_trip *thermal_of_trips_init(struct device_node *np, int *n
 	struct device_node *trips, *trip;
 	int ret, count;
 
+	*ntrips = 0;
 	trips = of_get_child_by_name(np, "trips");
 	if (!trips) {
-		pr_err("Failed to find 'trips' node\n");
-		return ERR_PTR(-EINVAL);
+		pr_debug("Failed to find 'trips' node\n");
+		return ERR_PTR(-ENXIO);
 	}
 
 	count = of_get_child_count(trips);
 	if (!count) {
-		pr_err("No trip point defined\n");
-		ret = -EINVAL;
+		pr_debug("No trip point defined\n");
+		ret = -ENXIO;
 		goto out_of_node_put;
 	}
 
@@ -162,7 +163,6 @@ static struct thermal_trip *thermal_of_trips_init(struct device_node *np, int *n
 
 out_kfree:
 	kfree(tt);
-	*ntrips = 0;
 out_of_node_put:
 	of_node_put(trips);
 
@@ -490,8 +490,13 @@ static struct thermal_zone_device *thermal_of_zone_register(struct device_node *
 
 	trips = thermal_of_trips_init(np, &ntrips);
 	if (IS_ERR(trips)) {
-		pr_err("Failed to find trip points for %pOFn id=%d\n", sensor, id);
-		return ERR_CAST(trips);
+		if (PTR_ERR(trips) != -ENXIO) {
+			pr_err("Failed to find trip points for %pOFn id=%d\n", sensor, id);
+			return ERR_CAST(trips);
+		}
+
+		pr_warn("Failed to find trip points for %pOFn id=%d\n", sensor, id);
+		trips = NULL;
 	}
 
 	ret = thermal_of_monitor_init(np, &delay, &pdelay);
-- 
2.46.0.76.ge559c4bf1a-goog


