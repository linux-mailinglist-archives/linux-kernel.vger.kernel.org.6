Return-Path: <linux-kernel+bounces-286709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9152A951E1C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 17:07:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07D4FB2BFA5
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 15:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DBED1B3F3D;
	Wed, 14 Aug 2024 15:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pdS568tv"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA201B8EAA
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 15:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723647874; cv=none; b=jJAD9JWj/QATXSKJc87rAaGrI2chSR6mLI+JEihitQ1E6NgQSWfripIeqg0RQdywDC1sOQH0MvCH5xADcFPKoG+YY+3coBrtdc++txyeH4Cjuo8XpkmQw1r+EYgoC9eVfdNWo0OPPNN85e1IXTOIjiFEPmNYsF5uHmf7kYMJovs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723647874; c=relaxed/simple;
	bh=OoJl37VhWa2/ok3yWXn0smE+qe2VclKzB2yD7J0hAwk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SOk+X+5ubYSINOWCwmwmqlO29jnJxCEv8ZBbUznABaRJw0OhlAN5tBX+kar2q7sQmtjaaBwETKuYAEoalckEi/9tQqYTH2SeQQbQt1baxh0iDJFLBBKIUUG+wnSPnecEzduAUlLBD/54y6zsOii65JJAJ5q6irGoDYMetvmtkwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pdS568tv; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-368440b073bso622611f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 08:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723647870; x=1724252670; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ACUznNue5Vc1PvREpF5uL8d3frSCLJ2XL4UNUgbbF6Q=;
        b=pdS568tvUza2UEI4RAWVRTasjZ4Rk2RWjZ/u9U5hltwn0ye8WDmEAJMPTu/Dn9UNS5
         XS256qiK8h4BKzp29peHYAgJc/yH18Nmoz7lTmJSV+rOeXgHZvkIsps0K+1H8muiLZUf
         Nvpnp467wUma71cs7GYegcX0TG6Pb2YqVNvZmNRcqwBgzf0rtDgISBUfR5g6PMpNeijs
         voI7Ynvs39+fuBgED6KMqvHmsqPWiA0Av4zwHaIf6ExEbuRyr61RQ/fOPleKkltRtwOo
         rKdkGj55it/rtP1GJF9rD/rasTv3yl3ADgBWnUW7WwnJS1I7is26aLbP2xO96B9rYLk9
         Enbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723647870; x=1724252670;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ACUznNue5Vc1PvREpF5uL8d3frSCLJ2XL4UNUgbbF6Q=;
        b=BoOvKq0pM34QPWa4bXc1lHJ6PSJXp7mIb6M1snwW//V+srMNM/2WVXt/20cyyoqwlK
         kC0D88ccIrFBYO2+vWCLKVNr3PnH7PYVzMe7X0q7m4Lwz55K0iYR7wLEgfx/WnTDkQ4t
         ktVBUCtvoSzdW2wk0oYa+CFbiyOGOMLjeuUXtYO7qMeqd4+UYJxNCMdAdaceL9LQo/Wt
         0WxLXBT0ZMFdkz+Y9SW6DyvHQtT+/h09YDJi4hF0hUAdKyT63rRPOh7n/1JRMUK4unre
         N/sH3N/XOOSw0l8BQjycQqmwhU/qYyizl9w8ZHxzMhwGZAtHLUqv+Urxn3X5gdaVOfP2
         n/sA==
X-Gm-Message-State: AOJu0YyP2Eu6eVQ54kFLZBcvEF52nTYdiAvm5PqL5O7nNqeJySColeGL
	UsyLJj32p5xJ9NpUxtKs/yW5lY38nVNdEo32uWHimq43ZhPGsyKHIb2ueetB+zY=
X-Google-Smtp-Source: AGHT+IF+u9tmYTlfOnF0EY/D0BDpgP+0OTvzQjNTeJeoB9+1fHj7S8CddXYLDq5O/F0RKg2kn5vuxw==
X-Received: by 2002:adf:f3ce:0:b0:36b:bb7b:9244 with SMTP id ffacd0b85a97d-3716e3eaecamr5350141f8f.1.1723647870395;
        Wed, 14 Aug 2024 08:04:30 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.215.209])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ded7cfbasm22313425e9.45.2024.08.14.08.04.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 08:04:29 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 14 Aug 2024 17:04:11 +0200
Subject: [PATCH 7/7] regulator: scmi: Simplify with scoped for each OF
 child loop
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240814-cleanup-h-of-node-put-regulator-v1-7-87151088b883@linaro.org>
References: <20240814-cleanup-h-of-node-put-regulator-v1-0-87151088b883@linaro.org>
In-Reply-To: <20240814-cleanup-h-of-node-put-regulator-v1-0-87151088b883@linaro.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Krzysztof Kozlowski <krzk@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>, 
 Cristian Marussi <cristian.marussi@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, arm-scmi@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1391;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=OoJl37VhWa2/ok3yWXn0smE+qe2VclKzB2yD7J0hAwk=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmvMdt9P9crcfh3Lp+LZmfqSw+yRnKP3vsTTgTz
 4j9XGKy5+2JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZrzHbQAKCRDBN2bmhouD
 14guEACS3kV18JgvbTMljOcJKLNuprPK6EWt3rzyAwJz6S/prQ5m8/dJcjR0LfXPOSIKpr8T07P
 RjGOLmrYXsdGs5RKuWilAcUETR+HBy75Fd7L6qWKvOgiEkF3f/zxxnrGJr1TywAhiJzNyZxnc7e
 D1oX9a00U9Nq/G7TzzId+WggIZVkMhVb6Wjvy6bMT13co6O7OJ3S2DwWuqW7vrG/rt09V6amwTJ
 c6fr5IINXgPXbfdgZMIlT3hSoZP5vCY+3hIUGQgFPNOtjR8oFIR7BHtnTgftiqqg2U0a2B7RdYv
 PIRFwmhK1wP5Ld75kd11lTS47+YajB59ydM6XTotcBcPYK5fTlwqInYN2s6SX1igw8axui7mYsT
 X8kDCi6zpnihNFTmXGZlTK5gqt+yZrPnMWUGyBl54qGI8nTq9zw9zGGNdp2ZAFPUFU2ARCibepr
 orZZAgeDiuFQUSQaaHd5uYLBmthqW3vWYl1uxEpgbX6l+0tvLNwN2//N9rM9sEnvHkwbLkhunWV
 9gw9jKHQVdg4JHI3Fw2hzYoFwshNDapb7HWbJa0qU8g0nyVCFAvdfJix3aqSJwiQIkLO5dAbsJI
 l2VZSD4h0HLaesOv1QiiAOvn8x5X1Js77S24usuDWoCHb0yL60XqMFejLhdxqcKPm+rWOYnvO7r
 HL18HE2d+32PggQ==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Use scoped for_each_available_child_of_node_scoped() when iterating over
device nodes to make code a bit simpler.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/regulator/scmi-regulator.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/regulator/scmi-regulator.c b/drivers/regulator/scmi-regulator.c
index 29ab217297d6..9df726f10ad1 100644
--- a/drivers/regulator/scmi-regulator.c
+++ b/drivers/regulator/scmi-regulator.c
@@ -297,7 +297,7 @@ static int process_scmi_regulator_of_node(struct scmi_device *sdev,
 static int scmi_regulator_probe(struct scmi_device *sdev)
 {
 	int d, ret, num_doms;
-	struct device_node *np, *child;
+	struct device_node *np;
 	const struct scmi_handle *handle = sdev->handle;
 	struct scmi_regulator_info *rinfo;
 	struct scmi_protocol_handle *ph;
@@ -341,13 +341,11 @@ static int scmi_regulator_probe(struct scmi_device *sdev)
 	 */
 	of_node_get(handle->dev->of_node);
 	np = of_find_node_by_name(handle->dev->of_node, "regulators");
-	for_each_child_of_node(np, child) {
+	for_each_child_of_node_scoped(np, child) {
 		ret = process_scmi_regulator_of_node(sdev, ph, child, rinfo);
 		/* abort on any mem issue */
-		if (ret == -ENOMEM) {
-			of_node_put(child);
+		if (ret == -ENOMEM)
 			return ret;
-		}
 	}
 	of_node_put(np);
 	/*

-- 
2.43.0


