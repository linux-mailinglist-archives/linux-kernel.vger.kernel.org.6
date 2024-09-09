Return-Path: <linux-kernel+bounces-321537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80C63971BCE
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 15:55:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BDD59B20FF7
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 13:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03EE41BDA96;
	Mon,  9 Sep 2024 13:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hRLE5843"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867E41BD50C
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 13:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725889922; cv=none; b=dx18xLndvQABt+A+4XM8UHNajRhs7PEdbQh0kgvPydlqtgfgXRJACwNCvfT+76hGRrPoadtFzxpZXqVeZisgejFEojMQidP9T9C6OknVup1OyrIZjiNCW1MlyKespeD2YTFkxwGMteCXA2XiDuJ5XUMJhyuYuMHZvUlekFR7VsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725889922; c=relaxed/simple;
	bh=KcmtvuFpgJTQr+NrBtSfkFBmPuXrmTaJALoNQh34mgc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WH6SVHIZsp9tLWjlT8YVN4tzgjKKJu5heft19VGs3DSQhqKfUzZ1NiHx+CbANYOF8UcuIjEzRLXGaCiCA8jq60iPfb7FfDLyLzrp5WWQDhgaLl+nkbAsTdElBwxfFTP0InXDy7fjiwqItn/jcd2wvltorOlKvVxMBZUgybxwMyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hRLE5843; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a866902708fso27001366b.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 06:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725889919; x=1726494719; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=go5+dPyR/CU/+h6S38uOSI6svsd8/ygd6Agr2YKEpkk=;
        b=hRLE58431O4jWlmDRO9pSSIqVkku9/ZqtjQbWzUn0hgeYQY221/VArCutRKpjIziMc
         2fTkeNGPgORNePow5q7ZWpmhFxxLxpJkcLE40y71H96cgUoSAGIr1DgZpHFpBYngaq2R
         dSywm3TXDbRSRpBt4KKQubR3UFjXejn/gjY3Qp9SCoWfamOGcroPyRUzvihK/11PujpA
         U69gCDFuyfnxAOplZEb6QUCCUwuIFmHdzEKswlfGu84CYVC/L7B4lJYsSUTE33ufMEqe
         T+kLnpllsoqgM55XvrZrTmRWTEYOjv9caflIha0tZgMQhPsLKPe1W0QYfMu3G81xOh0R
         ptSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725889919; x=1726494719;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=go5+dPyR/CU/+h6S38uOSI6svsd8/ygd6Agr2YKEpkk=;
        b=G88wYSlfcQh2dNn4MX0vQUmhuC6dC2MxINKcGWfrckNYB9+PrroR9gIf6N8lI7aSfY
         jGaaD2wn9fSS+l41gOYtgJuJ95BdoYrPMSCs6q84z1ifXt++V6bcR4PjBaS30XKLeB7H
         YgnPvhKVY74YJmyvRThP4QCDgbI/OMs8ho3hVwYUj+SKE47XAiEfiIJftZina4iAVh4I
         f03cEJXHkk2S1cf+JGEHyskiXcEgcJ0eZQt+7Lycnjk+Bls8502K91Nc6FIoesMRXp4M
         jKpFHMELsbGX7+8NgTGfW7h55q51BYqyI411dBp5elY/2LoT9oiamQ9YmNA2RsimOCJ1
         8i9A==
X-Gm-Message-State: AOJu0YwdlFjpBDM1nfIlgNA+YW5Pf8tp6Af3P0E1SlMiPWHAxDUk7Huy
	HW09f6B5PgRweKwAy+gtE4QvaZyzOK5oxl2JqEuA5p6Nsv06gz5Rnbd/irUQ63A=
X-Google-Smtp-Source: AGHT+IGy1tiHdaQw1EmLxWCIRZx0QTX7/qecRmbSfYliJR+FY+WlBher2f7vPLzcYnQtkfCEQty3qw==
X-Received: by 2002:a17:907:daa:b0:a86:83b1:5d94 with SMTP id a640c23a62f3a-a8a885fa928mr395447566b.3.1725889918257;
        Mon, 09 Sep 2024 06:51:58 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.222.82])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25cf3ad6sm345344566b.148.2024.09.09.06.51.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 06:51:57 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Mon, 09 Sep 2024 15:51:25 +0200
Subject: [PATCH 14/17] regulator: qcom-refgen: Constify static data
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240909-regulator-const-v1-14-8934704a5787@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1177;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=KcmtvuFpgJTQr+NrBtSfkFBmPuXrmTaJALoNQh34mgc=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBm3v1khpb7WzxyunM5lYXMazdM4ujdBKnR1uNAG
 IJMqHk63k6JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZt79ZAAKCRDBN2bmhouD
 1xTvD/9iDwh1+cEyfWNjyNGqc4y9wqU0ZzDeg3tyTbYWtWgBrDXX4gYRWsD0etQouIuhs83FC5m
 7m67B+n4Q7QjrfQUtSTkfGWvYGHjLQ/RooOdXrg4+dfjO6myAtqeTeaHlNZu74tr0xVQMocpWC2
 CpBT9Ek9UtovGtrVKAqsQhsSbMXSek1w7kB/u3fnRe6Z7N13lKr8XjBaqaaRPsqfS032KXyQ3uv
 Le3dFP+wqoLN+CqPjM6LMPx8iRceIuX1rSb1CpJgJaf+zLVAVMi5ZitneFTPpWjFHEWw9i2ZxX1
 atam2jSgTHB3NgxVpjBoaayFmWv6Rwq5uBmrYvXVpKSK92NHqDmd0hxrq3G3Xl8bF1hpCDtkqVi
 QhNR3/DD87VK4Jt/7pPG4f1RYHZhNl9qJ2jEqQwLFVfK+GqI1xLCRsl5TY3i6dWXHHqV0KTOtw6
 lJn32B6vGS9haLMgSBewc356tSJEBwE6QpycGFI+ENmABZSJvasyHqXQL563bHFyQvHOhCNjsaD
 R1We9KqaUZJALCSELvgzu0qBevYrx9Yw5VqdwW4id3C4UjPXdVOzId9mlYN2laxcb1+RkTbyEIr
 yENminEQ5sFMNejQBF6CUF8SBl08MgdL43RBCT7XKPzK4MbNt9K8Uwgn6NVVVrICJgXS0rscTtM
 y/G9xuQdIzo4sZQ==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Driver does not modify static data with regulator description (struct
regulator_desc), so make it const for code safety.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/regulator/qcom-refgen-regulator.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/qcom-refgen-regulator.c b/drivers/regulator/qcom-refgen-regulator.c
index 063e12c08e75..cfa72ce85bc8 100644
--- a/drivers/regulator/qcom-refgen-regulator.c
+++ b/drivers/regulator/qcom-refgen-regulator.c
@@ -62,7 +62,7 @@ static int qcom_sdm845_refgen_is_enabled(struct regulator_dev *rdev)
 	return 1;
 }
 
-static struct regulator_desc sdm845_refgen_desc = {
+static const struct regulator_desc sdm845_refgen_desc = {
 	.enable_time = 5,
 	.name = "refgen",
 	.owner = THIS_MODULE,
@@ -74,7 +74,7 @@ static struct regulator_desc sdm845_refgen_desc = {
 	},
 };
 
-static struct regulator_desc sm8250_refgen_desc = {
+static const struct regulator_desc sm8250_refgen_desc = {
 	.enable_reg = REFGEN_REG_PWRDWN_CTRL5,
 	.enable_mask = REFGEN_PWRDWN_CTRL5_MASK,
 	.enable_val = REFGEN_PWRDWN_CTRL5_ENABLE,

-- 
2.43.0


