Return-Path: <linux-kernel+bounces-363812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2087899C75A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 12:44:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D991B25541
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 10:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3FCE1990D2;
	Mon, 14 Oct 2024 10:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="JqfXECaO"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 610C4176AA5
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 10:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728902636; cv=none; b=jiq5DLkQA62Nbh7/Xye4F2K67P7afe6j2rDaQyG66FFHPCXbawjLiF5sinKNFx38j+1oXei9ml5vo9hWN8vfatC6gDxN8Rbiyt+4B1VwCGicn/a+PCnXOih1119VEKzcwAu/Ta4sWQRgZQJeVrh0c4SLJpNYNHwOPr0p7+joNBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728902636; c=relaxed/simple;
	bh=X42O0O5tbs9Yf3hXbEheFrP3QxsJHxYyKkjub/Ra6JI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kdRwIqusPk2BcWxghw4aUrCOPn9pa9V4ewOigs8UXkNegNm8MSClcWA6rJ7uFZz5Ht76Hhso+naFiUbffljzLKSUy6XwrvgpjCkDZ6tbHz1AvgjppELSYaBJ6Jw8fqfQRB+22AMqEtkfkrQJGSUu18gZo0Zv6c3O6Jy0uMMP6wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=JqfXECaO; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
From: Dragan Simic <dsimic@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1728902630;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WJylQnN6elbJzXOZExAonx34GilCjnyToPejoTdekBk=;
	b=JqfXECaOZIjE2sclZRG6A8LJFcdwPCzB1g0gmiv7dUGa+bRa95TvU6P8YPwi4qdaGxlVTi
	jkL2+S2jkcNBNlBxYbPQuxQlLQgIeGlinByjHqL/50Mfu8PQd+UnvPIS81Q0ryx2zSLvlI
	cHKYOSl0JRWMRej2bHRGEjkITD/xx8WNMDNogJ0hJca8I9XbaApd1xpdFwPpcf4BGk7zZL
	H1gvpZOwKPy6lbnFn8jS86A8BWb69DfMJZwZCcLPssX2+qvm3bGIE65FgR1xTSz1h3q2MC
	rYrC/5togOejEuuWDXXHqERGKHBmpcqk0xM2evIVkeRyra3GTWzqDv7F2UlQOQ==
To: lgirdwood@gmail.com,
	broonie@kernel.org
Cc: linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] regulator: rk808: Use dev_err_probe() in the probe path
Date: Mon, 14 Oct 2024 12:43:40 +0200
Message-Id: <2bfd889a35b1b0454952ec8180a53143bd860192.1728902488.git.dsimic@manjaro.org>
In-Reply-To: <cover.1728902488.git.dsimic@manjaro.org>
References: <cover.1728902488.git.dsimic@manjaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Improve error handling in the probe path by using function dev_err_probe()
instead of function dev_err(), where appropriate.

Signed-off-by: Dragan Simic <dsimic@manjaro.org>
---
 drivers/regulator/rk808-regulator.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/regulator/rk808-regulator.c b/drivers/regulator/rk808-regulator.c
index e81dbb14a29e..f241bb538e27 100644
--- a/drivers/regulator/rk808-regulator.c
+++ b/drivers/regulator/rk808-regulator.c
@@ -1843,8 +1843,8 @@ static int rk808_regulator_dt_parse_pdata(struct device *dev, struct regmap *map
 		pdata->dvs_gpio[i] =
 			devm_gpiod_get_index_optional(dev, "dvs", i, GPIOD_OUT_LOW);
 		if (IS_ERR(pdata->dvs_gpio[i])) {
-			ret = PTR_ERR(pdata->dvs_gpio[i]);
-			dev_err(dev, "failed to get dvs%d gpio (%d)\n", i, ret);
+			ret = dev_err_probe(dev, PTR_ERR(pdata->dvs_gpio[i]),
+					    "failed to get dvs%d gpio\n", i);
 			goto dt_parse_end;
 		}
 
@@ -1920,9 +1920,8 @@ static int rk808_regulator_probe(struct platform_device *pdev)
 		nregulators = RK818_NUM_REGULATORS;
 		break;
 	default:
-		dev_err(&pdev->dev, "unsupported RK8XX ID %lu\n",
-			rk808->variant);
-		return -EINVAL;
+		return dev_err_probe(&pdev->dev, -EINVAL,
+				     "unsupported RK8xx ID %lu\n", rk808->variant);
 	}
 
 	config.dev = &pdev->dev;

