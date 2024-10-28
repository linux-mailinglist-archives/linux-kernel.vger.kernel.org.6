Return-Path: <linux-kernel+bounces-385465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7A4F9B3783
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 18:19:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3779DB2583A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 17:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BAB21DF267;
	Mon, 28 Oct 2024 17:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qOqeRxnH"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC5A1DEFDC
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 17:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730135958; cv=none; b=kW2Dew0j3Zje/SkZlMewT8+oxW9iT2KAGnS5tyebB/h2OiW8Bkr6RAe5NkQ8MlUlVyb378oluPHGLbI958FjFoOb2oyHiTP5aPGNBHD4zCKQOig1mPuvuO52KImobEk5lQ+AO1PBogrF0ASJxXcl/51LDLIWQVs2ahGwzLMfQ+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730135958; c=relaxed/simple;
	bh=RK5VA9S32Yz8dl7njZw5jAITmojkn2XFDc8BEOO9Y1g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hgQBR7B8eGsUZtJ0iqofibtW7Acbd34L2CPaYNErxfOHSrAr78X6+1Cfi+VHuGRNEfMBrdBlZftTy1nhLUuRLXUrfIGYokDRPXWF4H3InL7RhemmzT3Nari4NBXd7R1yyKI9ekXGwnnWkutLl267lQ2BMGQLCKg9yuBLz07XyJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qOqeRxnH; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4315eeb2601so60869585e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 10:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730135954; x=1730740754; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1fkTku/2hlfLuFEUEbfmaTEX5P1Wden2mB6YLijG1sA=;
        b=qOqeRxnH6NhDCI5FZ/QOqwWf9X5sZnfB22CqhimD8YdSXDJLYCYgxTC1wvkOTghIHq
         X1/rCpHyeKgBxykBfJ0kTX8E0I+DKuKsXiWvAGysBBwpi2evaXpwFEqrWdaeQ4vKjGhi
         2CIAWuh9hW1+In+YVZDkf2PkifEMpYyfd50ppjMx8cm+tLHWtDIoU58E1uKjFVpWzUHH
         GOY3nnbvmzT3NsgZGx55/5TTP00DrNhAZMzlhFUBVEsSBuYpIFsxfMbCrSe6cYKA7VhZ
         LLYSiPMmKinVI2rFa20QN27z9Y1rCMsE/J16lf7DATVkGA4OCrp1C8KN8EO54iqkLytE
         vxrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730135954; x=1730740754;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1fkTku/2hlfLuFEUEbfmaTEX5P1Wden2mB6YLijG1sA=;
        b=UR3c06rkAdKcbHV7UWVoP1x5lRL/EhuUVqjF9dRDsWxBxoIUVyk06No5TIt3ep/sXY
         9KCbEl1IsYPkECRddZfjUDUkEM9ssyoUXvXZXgIUZT76rswVO5Qbfz28LIME3I+c9a5X
         RXJLdgchrRMsUAsU8d/WrRIcxP6o0i8QrKBiJgIYQzG0IplOnhalszkrrVtGve+PCyD3
         OHi+AUeOQH2dnpkHXFnMgeSFA24EINdVLbqU9iFuxLTF5xQtDEmAJzDN69wQHTFXA0xy
         uqnqplHgYXhY1j3oLynv44IFvfUKIFNEuYG1ZIeFjUrO761Zaim39uegGmNJd383zHu/
         1klw==
X-Forwarded-Encrypted: i=1; AJvYcCWEBO61efIXt5Yo528MCiOs2AhF8zKJskXM/tStMSJf1g97+bq7wf40jM5kajyXy/fkCzew1eINyZnoS+w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyI+h4qdrZP/F9ST3W/PpDFhokJQS0jb5QCVKfGPo/fgMkmC4cc
	kVu9g0npknp6oQlSvRVZdcgya53syzumo06WOH87g0O0xJ8AzPcPeYJfo74tFoo=
X-Google-Smtp-Source: AGHT+IECm76pRbyYpp6SjkcMtCuO1SyMDPfHW0X9U1Tuvf/svqN92ChLfU5gRa1/AIweI4/7e+k+4A==
X-Received: by 2002:a05:600c:1e03:b0:431:555d:e184 with SMTP id 5b1f17b1804b1-4319ad06917mr98125275e9.25.1730135952130;
        Mon, 28 Oct 2024 10:19:12 -0700 (PDT)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b1c8a9sm10096153f8f.12.2024.10.28.10.19.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 10:19:11 -0700 (PDT)
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: wenst@chromium.org,
	rafael@kernel.org
Cc: Icenowy Zheng <uwu@icenowy.me>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-pm@vger.kernel.org (open list:THERMAL),
	linux-kernel@vger.kernel.org (open list),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/Mediatek SoC support),
	linux-mediatek@lists.infradead.org (moderated list:ARM/Mediatek SoC support)
Subject: [PATCH] thermal/of: support thermal zones w/o trips subnode
Date: Mon, 28 Oct 2024 18:19:01 +0100
Message-ID: <20241028171901.2484882-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241018073139.1268995-1-wenst@chromium.org>
References: <20241018073139.1268995-1-wenst@chromium.org>
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
Reviewed-by: Rafael J. Wysocki <rafael@kernel.org>
Link: https://lore.kernel.org/r/20241018073139.1268995-1-wenst@chromium.org
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/thermal_of.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
index a4caf7899f8e..07e09897165f 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -99,18 +99,15 @@ static struct thermal_trip *thermal_of_trips_init(struct device_node *np, int *n
 	struct device_node *trips;
 	int ret, count;
 
+	*ntrips = 0;
+	
 	trips = of_get_child_by_name(np, "trips");
-	if (!trips) {
-		pr_err("Failed to find 'trips' node\n");
-		return ERR_PTR(-EINVAL);
-	}
+	if (!trips)
+		return NULL;
 
 	count = of_get_child_count(trips);
-	if (!count) {
-		pr_err("No trip point defined\n");
-		ret = -EINVAL;
-		goto out_of_node_put;
-	}
+	if (!count)
+		return NULL;
 
 	tt = kzalloc(sizeof(*tt) * count, GFP_KERNEL);
 	if (!tt) {
@@ -133,7 +130,6 @@ static struct thermal_trip *thermal_of_trips_init(struct device_node *np, int *n
 
 out_kfree:
 	kfree(tt);
-	*ntrips = 0;
 out_of_node_put:
 	of_node_put(trips);
 
@@ -401,11 +397,14 @@ static struct thermal_zone_device *thermal_of_zone_register(struct device_node *
 
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
2.43.0


