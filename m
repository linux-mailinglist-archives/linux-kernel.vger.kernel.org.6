Return-Path: <linux-kernel+bounces-244166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F45392A01C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 12:25:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1D931F227EA
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 10:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAC6978285;
	Mon,  8 Jul 2024 10:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G0WpBMKB"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581B42E85E
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 10:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720434330; cv=none; b=FL2soUZLwuY76ntFv6pBFG9ziPs6rRbeUXUroMB+PiLaD+zAid6qBsDQ1u6A5KTUg+5tQqx2j3CAM26ne80VXak8+CNBA1dy34P2pqFSBspxlnDJA90FsIji77dsAp18Yotu198dyX5yKEuRsJw/B6Qv74v4/MHK6AP9ZtD9WYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720434330; c=relaxed/simple;
	bh=sGBDAvNswctcuk/kjk1ua5TdJz87BTlyYVmswBU0S78=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FLfRMTQB087WlxAoTgw2dGNzLNLevUti17As4szuzLn/dHBMOaJcvM9iTUhmOhGLShoAXlIvPluNKNk0nXhQ3RjZMkRFKMO9qQFw+o9p5Dd1vjN+W4yoTrafc7NCgdS9XmldYYEBVJ5CRoPRFKehLS4WEnMJbdouZOO9SfBv8/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=G0WpBMKB; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-58bac81f40bso4816914a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2024 03:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720434327; x=1721039127; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jI6VExt196cOGjHLMIZgkrjN4DBF+pr/VqM+rA0L/Ng=;
        b=G0WpBMKBfIuP4IelHFiOo5bEjSiKfeC885eWywXecckDzdpGdxk/ROyO+vCcIDDcoe
         x9YEoX5gbSPpzvNT6myY1O4w7ZpWbCAAYH8qmKgeNS/n1WkRlxuZSq//XiYKshRd0fk/
         0XjvPFqXU4PQiKkSDP/BYqdALo/8ATYQGVZayDitXstaFCpIv+X+27XEK7ARRj8qsLJc
         FRxsGW6b9yG3aESEApy06yNW/RI47dQllczv2Tu4zbyT62g4C3bq7jIWQdPEAIEFl60q
         dlTdVIe/z0UEDD/+EkhlacEp8wmuf5SSJMKfTOrB8k0nib8JEBUBsPmTbeybT8p9Knbu
         EBsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720434327; x=1721039127;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jI6VExt196cOGjHLMIZgkrjN4DBF+pr/VqM+rA0L/Ng=;
        b=P/T16LJiYvU0E0wm7xsDcNLYBOSXxPRTgLsrhyltzqJs2Vz2t5WEMKGO6L0oqOMh6L
         paDzYKuGIOHlOIIayZ7VGZ2a0IusxvUJxLa/W9b8LV14YqSAv+pWyDHgbP8dm9LXzjTO
         dg5Ni0TgNdBNVJccRxZbMWUW29kI1JZRfySjr8GVZC+bwGaZBHAadI3aikPslzTZmTH9
         c3axNo730qm7N5fpAjOTJqhImSzqJcIxOU6pHlxJSOh+mrq1KnZhIMUzqbuxVudhaKfW
         zchT0T5gHuf+Owxb1KytvHabmvb18pu6xFWhMNUvyVt9T48MQhVX2GYb6+y8KLwxtMKY
         IBOg==
X-Forwarded-Encrypted: i=1; AJvYcCVPAAMcwefPr9sScLX0dxFld3ho1F3/hFmhkP/yF6ufJHEVwB1ez96bpa3O41/nSFHIdqR8MW8sgvLM6jWt4dV+P2ORQl6ySWfBHE/v
X-Gm-Message-State: AOJu0Yzwap/qLMledfmUuXGtVcIuNAJ4UlyKsAsAjFVsdRqkszE95l3H
	cg7nItTqCfiteyLpLELUaWVnIE44xHh9mnZ7YTIbd2XMKzJD9BwUlSAC1R4O3RE=
X-Google-Smtp-Source: AGHT+IFGnbgPOvevHxHVID3Wzld0NPCwFbKNE9rjCXjOAdsm+hZ7aEjxXKtcxeG1n3/cwquRVy1giw==
X-Received: by 2002:a05:6402:35ca:b0:58d:115c:f529 with SMTP id 4fb4d7f45d1cf-58e5a6ee3f6mr7598736a12.7.1720434326728;
        Mon, 08 Jul 2024 03:25:26 -0700 (PDT)
Received: from krzk-bin.. ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-58b246087e0sm8045437a12.62.2024.07.08.03.25.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 03:25:26 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Peng Fan <peng.fan@nxp.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH PULL] pinctrl: samsung: Use scope based of_node_put() cleanups
Date: Mon,  8 Jul 2024 12:25:19 +0200
Message-ID: <20240708102520.26473-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Peng Fan <peng.fan@nxp.com>

Use scope based of_node_put() cleanup to simplify code.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
Link: https://lore.kernel.org/r/20240504-pinctrl-cleanup-v2-20-26c5f2dc1181@nxp.com
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---

Hi Linus,

I got only this one in the queue, so sending directly.

Best regards,
Krzysztof


 drivers/pinctrl/samsung/pinctrl-exynos.c  | 16 ++++------------
 drivers/pinctrl/samsung/pinctrl-samsung.c | 19 +++++--------------
 2 files changed, 9 insertions(+), 26 deletions(-)

diff --git a/drivers/pinctrl/samsung/pinctrl-exynos.c b/drivers/pinctrl/samsung/pinctrl-exynos.c
index ce5e6783b5b9..b79c211c0374 100644
--- a/drivers/pinctrl/samsung/pinctrl-exynos.c
+++ b/drivers/pinctrl/samsung/pinctrl-exynos.c
@@ -662,7 +662,7 @@ static void exynos_irq_demux_eint16_31(struct irq_desc *desc)
 __init int exynos_eint_wkup_init(struct samsung_pinctrl_drv_data *d)
 {
 	struct device *dev = d->dev;
-	struct device_node *wkup_np = NULL;
+	struct device_node *wkup_np __free(device_node) = NULL;
 	struct device_node *np;
 	struct samsung_pin_bank *bank;
 	struct exynos_weint_data *weint_data;
@@ -692,17 +692,14 @@ __init int exynos_eint_wkup_init(struct samsung_pinctrl_drv_data *d)
 
 		bank->irq_chip = devm_kmemdup(dev, irq_chip, sizeof(*irq_chip),
 					      GFP_KERNEL);
-		if (!bank->irq_chip) {
-			of_node_put(wkup_np);
+		if (!bank->irq_chip)
 			return -ENOMEM;
-		}
 		bank->irq_chip->chip.name = bank->name;
 
 		bank->irq_domain = irq_domain_create_linear(bank->fwnode,
 				bank->nr_pins, &exynos_eint_irqd_ops, bank);
 		if (!bank->irq_domain) {
 			dev_err(dev, "wkup irq domain add failed\n");
-			of_node_put(wkup_np);
 			return -ENXIO;
 		}
 
@@ -715,10 +712,8 @@ __init int exynos_eint_wkup_init(struct samsung_pinctrl_drv_data *d)
 		weint_data = devm_kcalloc(dev,
 					  bank->nr_pins, sizeof(*weint_data),
 					  GFP_KERNEL);
-		if (!weint_data) {
-			of_node_put(wkup_np);
+		if (!weint_data)
 			return -ENOMEM;
-		}
 
 		for (idx = 0; idx < bank->nr_pins; ++idx) {
 			irq = irq_of_parse_and_map(to_of_node(bank->fwnode), idx);
@@ -735,13 +730,10 @@ __init int exynos_eint_wkup_init(struct samsung_pinctrl_drv_data *d)
 		}
 	}
 
-	if (!muxed_banks) {
-		of_node_put(wkup_np);
+	if (!muxed_banks)
 		return 0;
-	}
 
 	irq = irq_of_parse_and_map(wkup_np, 0);
-	of_node_put(wkup_np);
 	if (!irq) {
 		dev_err(dev, "irq number for muxed EINTs not found\n");
 		return 0;
diff --git a/drivers/pinctrl/samsung/pinctrl-samsung.c b/drivers/pinctrl/samsung/pinctrl-samsung.c
index 623df65a5d6f..a7deae4afdcc 100644
--- a/drivers/pinctrl/samsung/pinctrl-samsung.c
+++ b/drivers/pinctrl/samsung/pinctrl-samsung.c
@@ -251,7 +251,6 @@ static int samsung_dt_node_to_map(struct pinctrl_dev *pctldev,
 {
 	struct samsung_pinctrl_drv_data *drvdata;
 	unsigned reserved_maps;
-	struct device_node *np;
 	int ret;
 
 	drvdata = pinctrl_dev_get_drvdata(pctldev);
@@ -266,12 +265,11 @@ static int samsung_dt_node_to_map(struct pinctrl_dev *pctldev,
 							&reserved_maps,
 							num_maps);
 
-	for_each_child_of_node(np_config, np) {
+	for_each_child_of_node_scoped(np_config, np) {
 		ret = samsung_dt_subnode_to_map(drvdata, pctldev->dev, np, map,
 						&reserved_maps, num_maps);
 		if (ret < 0) {
 			samsung_dt_free_map(pctldev, *map, *num_maps);
-			of_node_put(np);
 			return ret;
 		}
 	}
@@ -849,16 +847,12 @@ static struct samsung_pmx_func *samsung_pinctrl_create_functions(
 	 * and create pin groups and pin function lists.
 	 */
 	func_cnt = 0;
-	for_each_child_of_node(dev_np, cfg_np) {
-		struct device_node *func_np;
-
+	for_each_child_of_node_scoped(dev_np, cfg_np) {
 		if (!of_get_child_count(cfg_np)) {
 			ret = samsung_pinctrl_create_function(dev, drvdata,
 							cfg_np, func);
-			if (ret < 0) {
-				of_node_put(cfg_np);
+			if (ret < 0)
 				return ERR_PTR(ret);
-			}
 			if (ret > 0) {
 				++func;
 				++func_cnt;
@@ -866,14 +860,11 @@ static struct samsung_pmx_func *samsung_pinctrl_create_functions(
 			continue;
 		}
 
-		for_each_child_of_node(cfg_np, func_np) {
+		for_each_child_of_node_scoped(cfg_np, func_np) {
 			ret = samsung_pinctrl_create_function(dev, drvdata,
 						func_np, func);
-			if (ret < 0) {
-				of_node_put(func_np);
-				of_node_put(cfg_np);
+			if (ret < 0)
 				return ERR_PTR(ret);
-			}
 			if (ret > 0) {
 				++func;
 				++func_cnt;
-- 
2.43.0


