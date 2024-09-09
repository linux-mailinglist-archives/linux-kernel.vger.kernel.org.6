Return-Path: <linux-kernel+bounces-321522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63CCA971BAF
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 15:52:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D86471F2425D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 13:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD78A1BA281;
	Mon,  9 Sep 2024 13:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gBqgWF87"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE361B7909
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 13:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725889903; cv=none; b=DuC3SQUHPoQ40nJzmzAqdricTKGjqnZvzEQ+IdiVPz+xYWB1ScxygvFj92ucc9/uXECYaNNioKpoUwW/+XMC5uvTpZ7NtByTG/OHR7oWe74Roiv9N1U4hK5P/JPHSEk6Bou4GKfTtRdGNe5NS3R9VSI81lzw0dHAz8xaYRTNqJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725889903; c=relaxed/simple;
	bh=8TsG7I4Aag1KJIfppBSqZ8uVGEQPJnXHOI9sdDJkZWs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=u2Qi4Kwu6Cl3jCyEhvtYRisJOmz0YO313++2q1VD0Prmb27Fuy9eaPqxNRZcimee2EUsEZbEKC9zFqVPhkZbu7Rqvt7l67n4Z/rQseNoMy6WVWd3fXrvuXkPoH7jZC0aZqzL0myjDn6wDfacEYIDs/AGXId1g5Gwonmd3ua1bYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gBqgWF87; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a8a91c8cdd5so22182866b.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 06:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725889900; x=1726494700; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V74UlEO/iR2Z+cYu5ZNF8RMi5oBAw+IToxt2LjZmjGY=;
        b=gBqgWF87Z9RnQhQzTOYJyONj4Vlj2QyEORatHSHsDwh5yE82KGr1CPxaTaNCnDJLOR
         WNm4k3/A9700Ym02QOg0fb6moM2BGrHZsi286UuPXQ9rIAH8DnzTyNAWMAxU6g4zOTCd
         hC/gI5hIhvutEh15g7ymS9l77gjI27KUwwIqZTQdmxafByZleQ255zXWtWcN/y7dJBt8
         3j6bzzlx/zwsGMR671aHqCyLhUhLIcPPA5gTn1/swX9Cl8RJZ5K1kMEGFaYEnU6EVgs9
         L3Nb1sIzqHQyZakvV6Y9FgOJdhDLorE+CEvX54clhHfG9PE1yH/44N+oI7Kw+2yQgyf1
         xWOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725889900; x=1726494700;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V74UlEO/iR2Z+cYu5ZNF8RMi5oBAw+IToxt2LjZmjGY=;
        b=o5eZOs4mu85Xd5cWS5Tnp9eeFficDbzH1DHc+qNR882Y16HNcoWa43bw3bc8k6Vikf
         rYr5EQGDhxJEJV65qujb+45G4/qfawOvlFTHlnu4pSiJfAWGZGeom0xr1G9v94UFvykV
         nlyFE5qCnDr54eRraO5Jrpdg4zdR6QNDcjgV9JCwtVaEFqtzNo3QzXGnnSiqA335USk6
         vQAmCImTZ94SsFNf+2c5S7lmzif0iGvVHhiToxEqloAaynMp7s604V1HX56mJBidsuuM
         dq8f7HM3zaaNP+2+ClAjBDyR4JVM2vDB0LLqRAfMWZ4AmfoZYNRrSpDH6aoHWoTWWVFD
         7GvA==
X-Gm-Message-State: AOJu0YxRPU5k59mhex118S2x+KAOtwAHf/GWl6vaNuZdznwRK//JZIOh
	TQREvxiQcB47G4Xe2OvStNuxuEFSmLneO2aI07K+YS67eGWd8cER/CMUE0UY6RE=
X-Google-Smtp-Source: AGHT+IEvFrbQZvkEd16b+cebKNNqLJEpYUuxolVRkSwJ8SAfHDa79KyoDYaIwBLAfAfowNG3uPOfjQ==
X-Received: by 2002:a17:906:f5aa:b0:a8d:2624:1a83 with SMTP id a640c23a62f3a-a8d2624256emr211069766b.14.1725889898953;
        Mon, 09 Sep 2024 06:51:38 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.222.82])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25cf3ad6sm345344566b.148.2024.09.09.06.51.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 06:51:38 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Mon, 09 Sep 2024 15:51:12 +0200
Subject: [PATCH 01/17] regulator: da9052: Constify static data
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240909-regulator-const-v1-1-8934704a5787@linaro.org>
References: <20240909-regulator-const-v1-0-8934704a5787@linaro.org>
In-Reply-To: <20240909-regulator-const-v1-0-8934704a5787@linaro.org>
To: Support Opensource <support.opensource@diasemi.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=3897;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=8TsG7I4Aag1KJIfppBSqZ8uVGEQPJnXHOI9sdDJkZWs=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBm3v1ZDiVz4RaFZ9OBGUmyELamJcU43wcaBdMnp
 7IbKy42NI+JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZt79WQAKCRDBN2bmhouD
 1yUaD/4uEeY8qieO9UVWcfXUAM+yl+Ah/eISeRWtTgnULmCJznpSj1re/9hypLugcAre2+xitID
 Tq8ncG/lwdIQRCidg0yWXhmYTBM0IBnVwqPdTTS5aawbalrzDgmhH7kOl7hnmK3NwAjYipICwVc
 Yf1S5t0yj3dvSYPe8m4cScsFw8Yr1F1xjyMhMZefDWSgOwAUSlhI60QMpc33YtRegPIiWFTquuA
 bwzd3/+R94rpat8S/FDs0drkfSVcnGk2Ex9sYsd1gv5/koShUW2LT2su58Pxk74uJdEVNfF63CB
 i1q+bSTWMacll2wHjWYP2BupjluZtzu+6SHjjvn77ba1cexeY+yc3f4P0IGFhcU5IyrxaXGUhrj
 aTOaasOe3DZVrqd1B9iMU4B7FfCjA5QYSKNtTRqFEVhj19/BLtpp8IZj+lLCikhk82YTEynAF71
 9oh66ez1QhjOsm6PiIee6uzFOMVQjdzOAzcMO1riGr2NltOGAgFULtIAVkZ7zP1rOUV5EYq8Qm2
 Vdwqhs8uM8Q81U+AwEozboyxkthdl79nY6dwR2ANzIomtERLiQH3owdNeOjdXK7nlkbajN5TrRf
 Ott2t9N1PMbBZd1t6MISLvamkah9kJWWx7VCEEjtsC7VXLrMdaCBLyi9BlpEOczRz1Hmnqdr+I7
 MqltipNYXK0CDcA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Driver does not modify static data with regulators description (struct
da9052_regulator_info), so make it const for code safety.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/regulator/da9052-regulator.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/regulator/da9052-regulator.c b/drivers/regulator/da9052-regulator.c
index ab6f5d61b173..fbebe538a648 100644
--- a/drivers/regulator/da9052-regulator.c
+++ b/drivers/regulator/da9052-regulator.c
@@ -67,11 +67,11 @@ struct da9052_regulator_info {
 
 struct da9052_regulator {
 	struct da9052 *da9052;
-	struct da9052_regulator_info *info;
+	const struct da9052_regulator_info *info;
 	struct regulator_dev *rdev;
 };
 
-static int verify_range(struct da9052_regulator_info *info,
+static int verify_range(const struct da9052_regulator_info *info,
 			 int min_uV, int max_uV)
 {
 	if (min_uV > info->max_uV || max_uV < info->min_uV)
@@ -151,7 +151,7 @@ static int da9052_list_voltage(struct regulator_dev *rdev,
 				unsigned int selector)
 {
 	struct da9052_regulator *regulator = rdev_get_drvdata(rdev);
-	struct da9052_regulator_info *info = regulator->info;
+	const struct da9052_regulator_info *info = regulator->info;
 	int id = rdev_get_id(rdev);
 	int volt_uV;
 
@@ -175,7 +175,7 @@ static int da9052_map_voltage(struct regulator_dev *rdev,
 			      int min_uV, int max_uV)
 {
 	struct da9052_regulator *regulator = rdev_get_drvdata(rdev);
-	struct da9052_regulator_info *info = regulator->info;
+	const struct da9052_regulator_info *info = regulator->info;
 	int id = rdev_get_id(rdev);
 	int ret, sel;
 
@@ -206,7 +206,7 @@ static int da9052_regulator_set_voltage_sel(struct regulator_dev *rdev,
 					    unsigned int selector)
 {
 	struct da9052_regulator *regulator = rdev_get_drvdata(rdev);
-	struct da9052_regulator_info *info = regulator->info;
+	const struct da9052_regulator_info *info = regulator->info;
 	int id = rdev_get_id(rdev);
 	int ret;
 
@@ -237,7 +237,7 @@ static int da9052_regulator_set_voltage_time_sel(struct regulator_dev *rdev,
 						 unsigned int new_sel)
 {
 	struct da9052_regulator *regulator = rdev_get_drvdata(rdev);
-	struct da9052_regulator_info *info = regulator->info;
+	const struct da9052_regulator_info *info = regulator->info;
 	int id = rdev_get_id(rdev);
 	int ret = 0;
 
@@ -327,7 +327,7 @@ static const struct regulator_ops da9052_ldo_ops = {
 	.activate_bit = (abits),\
 }
 
-static struct da9052_regulator_info da9052_regulator_info[] = {
+static const struct da9052_regulator_info da9052_regulator_info[] = {
 	DA9052_DCDC(BUCK1, buck1, 25, 500, 2075, 6, 6, DA9052_SUPPLY_VBCOREGO),
 	DA9052_DCDC(BUCK2, buck2, 25, 500, 2075, 6, 6, DA9052_SUPPLY_VBPROGO),
 	DA9052_DCDC(BUCK3, buck3, 25, 950, 2525, 6, 6, DA9052_SUPPLY_VBMEMGO),
@@ -344,7 +344,7 @@ static struct da9052_regulator_info da9052_regulator_info[] = {
 	DA9052_LDO(LDO10, ldo10, 50, 1200, 3600, 6, 6, 0),
 };
 
-static struct da9052_regulator_info da9053_regulator_info[] = {
+static const struct da9052_regulator_info da9053_regulator_info[] = {
 	DA9052_DCDC(BUCK1, buck1, 25, 500, 2075, 6, 6, DA9052_SUPPLY_VBCOREGO),
 	DA9052_DCDC(BUCK2, buck2, 25, 500, 2075, 6, 6, DA9052_SUPPLY_VBPROGO),
 	DA9052_DCDC(BUCK3, buck3, 25, 950, 2525, 6, 6, DA9052_SUPPLY_VBMEMGO),
@@ -361,10 +361,10 @@ static struct da9052_regulator_info da9053_regulator_info[] = {
 	DA9052_LDO(LDO10, ldo10, 50, 1200, 3600, 6, 6, 0),
 };
 
-static inline struct da9052_regulator_info *find_regulator_info(u8 chip_id,
-								 int id)
+static inline const struct da9052_regulator_info *find_regulator_info(u8 chip_id,
+								      int id)
 {
-	struct da9052_regulator_info *info;
+	const struct da9052_regulator_info *info;
 	int i;
 
 	switch (chip_id) {

-- 
2.43.0


