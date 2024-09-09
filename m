Return-Path: <linux-kernel+bounces-321529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 325BD971BBC
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 15:53:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEA0E284186
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 13:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A0DE1BB6AC;
	Mon,  9 Sep 2024 13:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hFWi8444"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A20651BAED9
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 13:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725889910; cv=none; b=N1uP6O0MuetSS9Zqc6dU+m2R/aUH+VfbPurx4/FCKPuN6AhctAA3ZiQ615GhNxYLjKs4OYI3QXq/FaRRSlBr/VzA+x7afXucNif8mikji89Cq7rKuivaOl1USPaTDXx/RXdSFPj15PgUdHjnydr5tuviW8TpuqconIuk8owf70Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725889910; c=relaxed/simple;
	bh=j2zwQ1BCa3xviw33TQ1yU9leknMd45i2193Hd7keRfQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cavrBa+EDUrNv6k6XRC1qNI4gTE+g60DWfgPOPkvnyIeeKHQ8RMQKpl5hjVRP8FW4I5ycHd551YFd0QXEnRWCl4oSuioRulra/LcCX0Yh4EkqRd0KKIdqvaVJXpeU9/L68vw7o9xY6HS6eOyvTitI6XLe+n61nQJCahos00jCi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hFWi8444; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-374c6ed1af6so134431f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 06:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725889907; x=1726494707; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FzRjkUKpUqQXpsK4/eDUhuJEBuZIqvcSWctdz6VolTM=;
        b=hFWi8444h/YAQ5XB1Mel9v3J1UfXDekUDqw9fOMYHbrzuL/ziK2W4OQf66KXvJpr22
         HKjVoQG17Pj1Qm1HslCuKTe9F6zMk/OlFCV4Bjh5GdcGEI04//IoMqBimf6prrEcAnmB
         FCPt6sGMTkGNHN1j0bhmZTE7S+y0ITIb+2L2QGC94FwmfcRGIj6sbnu8aJN8PObHWqoO
         BaPCcTQSILX54hoNp5DQ3x9Mf55dv9ObuRXD+RX2dYPIWZQYmAlg/kir+8m5oH0bu4Nr
         FY4OGHW//JuYIHsEHR16Hi1LUh9fCojd7YaligQhkmrhNI913QtulooS7WmLaZiTQ38c
         NX/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725889907; x=1726494707;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FzRjkUKpUqQXpsK4/eDUhuJEBuZIqvcSWctdz6VolTM=;
        b=EnIVZ4dLuCOLeuCS1xGehOmxAGVN1SRhRhhD+zIthO7K6Jz49MGFN/v88tUiMsDB79
         quTo7BpUa2JRkVQAtF75p14YSq756gEpCczdoFAUPICFkgzqXnafBZy5fECD9S6T6jzI
         d12z1UGdmFgeHLVoq0WWq7wxGjFXLcIiIUvJL5ME4PD/5Q6igxaXVpKzQbAhk9zeSZfC
         iojI4rpCoqRipCD7aHGbJjGaYBm+TA6Rb+xbRAr1yPmwYa1oY0/UTJJ0e7tM8ziGEuTq
         4KeUNzYpshgM2oyHBzN5Gs9f1PBJBnUeoXHPG+owGBCcjr2W4BuWbNX5E1u+9zFx/A2J
         j6Ew==
X-Gm-Message-State: AOJu0YxyaR4ZXSgaAsx4j2sP6u2YR/5e99Zwsyx4IhItw+V3gphEeV+T
	AKWs8j/FcsUShBmNx4nEODOi72zo6dHDazfmEXl4N+wBWPGIi6+PWsYyuU8WCKA=
X-Google-Smtp-Source: AGHT+IG784y6TviUcaC0Sy4/IOqmsR+O7VMUlzzzng9cVnZEltHKULUPHrwBEN/dEMaMq7ZQr9+LCw==
X-Received: by 2002:a5d:6484:0:b0:374:cd3e:7d7a with SMTP id ffacd0b85a97d-378895c38c4mr3364134f8f.2.1725889906747;
        Mon, 09 Sep 2024 06:51:46 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.222.82])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25cf3ad6sm345344566b.148.2024.09.09.06.51.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 06:51:46 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Mon, 09 Sep 2024 15:51:17 +0200
Subject: [PATCH 06/17] regulator: hi6421: Constify static data
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240909-regulator-const-v1-6-8934704a5787@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3081;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=j2zwQ1BCa3xviw33TQ1yU9leknMd45i2193Hd7keRfQ=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBm3v1dar5m8pWkgX0YQ41g0FmZeSQHS5Ldzu5oS
 VY/Jxr8BWyJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZt79XQAKCRDBN2bmhouD
 196TD/9RCl439qn314C+1T07HG8J93zopFOVXqjRy5Chbs5rO9u7m7CWkTeYHrZRX11Lsv/pD8I
 92sYpTkK7vooauJ0uvcp3EMdJb5DiMrjs6ZmG+mXxH6XVliP1laV5MM0KiyDQeQoxAPO9tqmen3
 yL4kC7BbpHsME4uSggz2G7SUJ/oHzaJ70GDRgB/BYnqnNvqJbP0KMsLHyhg3AxgRRw2mNawPdHe
 kwMomDZN92uAzVczA1Ynpj7p74RF9KBVIZvAlIl1efcitCaJUMOj3gEYTwRfA0jWDBKMAiCYdyE
 1JNU01he7Duw2eMYTuSdroWOk81VkunYCpFrGvuSxFvttiFIAuwhPZhVks4dAfOtRlLbqdZ1qsE
 emRlIThRFUeb+glNUU7QLIG6JXpXtd6lGIEGK1SktsF7A3zQgo1M6ukdkioa5k7PxK8kZk+FszD
 /PSqRFLSiLqTZVz66TJNUcNs+hSOo3gzi6GBco5mW02vsquNRXrREUBVUseeCvWtI8v9lPwwIIN
 zbD3lqgTWX025GXQhLUk9I56pMObo+qAux80yYS2enK5o5hc9EJjf7SC8kMWhO6BmmMDYyoViuw
 wMWN4XPk2B1WZtQb3TGYlMlGotK1q6KnFPgSzICh+WNwhXYyOorLxMRRaJl/YA2eTuoxfKpiIt9
 xHhe5ucd9x/ZU6Q==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Driver does not modify static data with regulator description (struct
hi6421_regulator_info), so make it const for code safety.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/regulator/hi6421-regulator.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/regulator/hi6421-regulator.c b/drivers/regulator/hi6421-regulator.c
index 82e9e364d4d4..69d24728d6a4 100644
--- a/drivers/regulator/hi6421-regulator.c
+++ b/drivers/regulator/hi6421-regulator.c
@@ -303,7 +303,7 @@ static const struct regulator_ops hi6421_buck345_ops;
 	}
 
 /* HI6421 regulator information */
-static struct hi6421_regulator_info
+static const struct hi6421_regulator_info
 		hi6421_regulator_info[HI6421_NUM_REGULATORS] = {
 	HI6421_LDO(LDO0, hi6421_vout0, ldo_0_voltages, 0x20, 0x07, 0x20, 0x10,
 		   10000, 0x20, 8000),
@@ -384,7 +384,7 @@ static int hi6421_regulator_enable(struct regulator_dev *rdev)
 
 static unsigned int hi6421_regulator_ldo_get_mode(struct regulator_dev *rdev)
 {
-	struct hi6421_regulator_info *info;
+	const struct hi6421_regulator_info *info;
 	unsigned int reg_val;
 
 	info = container_of(rdev->desc, struct hi6421_regulator_info, desc);
@@ -397,7 +397,7 @@ static unsigned int hi6421_regulator_ldo_get_mode(struct regulator_dev *rdev)
 
 static unsigned int hi6421_regulator_buck_get_mode(struct regulator_dev *rdev)
 {
-	struct hi6421_regulator_info *info;
+	const struct hi6421_regulator_info *info;
 	unsigned int reg_val;
 
 	info = container_of(rdev->desc, struct hi6421_regulator_info, desc);
@@ -411,7 +411,7 @@ static unsigned int hi6421_regulator_buck_get_mode(struct regulator_dev *rdev)
 static int hi6421_regulator_ldo_set_mode(struct regulator_dev *rdev,
 						unsigned int mode)
 {
-	struct hi6421_regulator_info *info;
+	const struct hi6421_regulator_info *info;
 	unsigned int new_mode;
 
 	info = container_of(rdev->desc, struct hi6421_regulator_info, desc);
@@ -436,7 +436,7 @@ static int hi6421_regulator_ldo_set_mode(struct regulator_dev *rdev,
 static int hi6421_regulator_buck_set_mode(struct regulator_dev *rdev,
 						unsigned int mode)
 {
-	struct hi6421_regulator_info *info;
+	const struct hi6421_regulator_info *info;
 	unsigned int new_mode;
 
 	info = container_of(rdev->desc, struct hi6421_regulator_info, desc);
@@ -462,7 +462,7 @@ static unsigned int
 hi6421_regulator_ldo_get_optimum_mode(struct regulator_dev *rdev,
 			int input_uV, int output_uV, int load_uA)
 {
-	struct hi6421_regulator_info *info;
+	const struct hi6421_regulator_info *info;
 
 	info = container_of(rdev->desc, struct hi6421_regulator_info, desc);
 
@@ -539,7 +539,7 @@ static int hi6421_regulator_probe(struct platform_device *pdev)
 {
 	struct hi6421_pmic *pmic = dev_get_drvdata(pdev->dev.parent);
 	struct hi6421_regulator_pdata *pdata;
-	struct hi6421_regulator_info *info;
+	const struct hi6421_regulator_info *info;
 	struct regulator_config config = { };
 	struct regulator_dev *rdev;
 	int i;

-- 
2.43.0


