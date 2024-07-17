Return-Path: <linux-kernel+bounces-255028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 048D3933AB8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 12:05:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 284001C222DB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 10:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7441517FAB4;
	Wed, 17 Jul 2024 10:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="taT334pV"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0DDE17F386
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 10:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721210678; cv=none; b=EqlHbXfRdprQS65muwAMricRgeNVQod7lQ3jWt0fixDAE98vJVUlcOP15B08K89dVnaCnc8vdE5rEuTRpMGQ4VxKCMg5Z6zCSNqwlF6ZAM4GsS/g6wpsn7jOUDxPOhoNOVyAMw3wkcQnuc8VgfmpTozTyRKSqppQmKzV0efNDa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721210678; c=relaxed/simple;
	bh=xSYijA7D//yWyt82akVAYXvITlndr/u84aknEBgxoyo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Q+9MSUs4O8UTMbAGWDQCw0AfK8SUi0ZizIdeY+lBJEIMEctUI9elHD8oqALGzIP2h/2YltrkC2JEH0S4acN6Y/PbkRvuOILH1kwQyNOpWq8FAL+tcS9ETVen8xVP1gSyo+LfoGjavLg/tE893qocZce41fOvPSU1xB9yMhiMXKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=taT334pV; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-52ea5dc3c79so9276338e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 03:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721210675; x=1721815475; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XPnyc5RMkvjMPDVMheWRdjLNGsnpzjkjNF2JqNYtYKg=;
        b=taT334pVXXR0R4Wa8fqkhWK4tl22u/A/oDuF5izlUK5ctBObB0+qIyzeoH4CWOlbZu
         3N1dZ1UOXBekWi04bZtMSo0gHFIKxYaY5AAW9Loz2PAskg3e/OBZDmuV1bEhOMVpEFCV
         9KGrvfSl/hZdHWU8UAC4FyEMmLMInX4iASSaBqeufhpt8XutHF7vWoRYmYq9+jq5mQVT
         /QeeEPoGMyipr4+y7N4f9J2hUTMFu6fz4jSAJI6sAkv4tman6pL2LIa78dzw1Ym6Fx31
         iCV5hTYlljr8VwjJYhSMkejz4mP3VTjN6lrJGKpnmy4fEhm5NxdIqFcyxMiiaxFYyK9k
         FbFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721210675; x=1721815475;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XPnyc5RMkvjMPDVMheWRdjLNGsnpzjkjNF2JqNYtYKg=;
        b=a3vEWCKJlXrRyecaUohurIGmeoJE5UpLlPB/uyH4x5b7iXgzHrg9/wFONgmF8FYvQ8
         wQ3UYqnj5vlbWmRWP4i8UfcViHkgJn9h/3gUqzURo8xDGr3Yy2JfwSKKBQnKxoR1GpRn
         xoYeKUVGS+QuqBeetEByjz4rOwN/OfyoL+oPOab2bqh+g3/WGUX93Y7oRcz1HRGpA8ha
         FoUjWU5Q8oDFc0Xwf0YPbukZpsig1Q8t64UVRt8No1sloLMiHdPEJ94cQfCo/m9mejKg
         ghdNFBshlNDWHVCpGBq6ekq8IY5FskcCp6QBzK4mMojJhCyMA2oWU1WXgBNPQWDvYscu
         92Yw==
X-Forwarded-Encrypted: i=1; AJvYcCU4VRk4DC+nAEJwmheHCoPtwXRV4vPdrY595jCywuJy2PK7xvSY2kE8CP4zobkPvJEIVblTswCRo7tPT+ez2/nInYjVqPC6AWPtURfj
X-Gm-Message-State: AOJu0YxmSmsrcDpDX4yaOrMjyCRLEngMnD4kSewWOexstma6Sc2nJWYk
	QzphK9OXW82mE+tMyO93csnDCsyvTAGceJ4nw2UM4GhpLni3vy0n+HtlL7cl3sU=
X-Google-Smtp-Source: AGHT+IEA6Mdd/UDGsZxAFtR5whRjvK4gRiQLU602RckhCnzeOxVqMGQA0IPxSGnwg+GFWv6vue/SWA==
X-Received: by 2002:a05:6512:690:b0:52e:9ebe:7325 with SMTP id 2adb3069b0e04-52ee53d6da1mr915941e87.31.1721210674885;
        Wed, 17 Jul 2024 03:04:34 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ed253924asm1425391e87.262.2024.07.17.03.04.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 03:04:34 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Wed, 17 Jul 2024 13:04:31 +0300
Subject: [PATCH v2 4/7] clk: qcom: dispcc-sm8650: Update the GDSC flags
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240717-dispcc-sm8550-fixes-v2-4-5c4a3128c40b@linaro.org>
References: <20240717-dispcc-sm8550-fixes-v2-0-5c4a3128c40b@linaro.org>
In-Reply-To: <20240717-dispcc-sm8550-fixes-v2-0-5c4a3128c40b@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1043;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=xSYijA7D//yWyt82akVAYXvITlndr/u84aknEBgxoyo=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBml5cux1OaEy/tDtM3ebaQYLIoQtC3coJAZSdD0
 7kX3z2l0C6JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZpeXLgAKCRCLPIo+Aiko
 1W6IB/9s6d1XOqK1r1eJyN1ZKJImtuzDysw4jfpMr3g5Dzd2FR9iawLGuE+DGRm7R2obNkmFCX5
 G9MvSGx9RVBLE1+HF97EZQi7jV+jePFoxovR7NIaXRLgCOuFF72ar4693aWYq/Z3blMxQj9w+ph
 hNduR0jBs4U6lhIeYYsVTbNJk2eFL11ZnMB5sUIaReguy0ixvli0/e7FIy2kNtdPvKqm2OzRjBv
 tgQV0Mf921EXGOYTaQiuMmRxYIyVEOO6chsJp31oN9zJu4BQHEHG/TNNRz/za064OqPFSQDKrmE
 SDZNBk5FqQQZJdm+i88q3EGNFOO5XdiCYxQIQSZZH2YgH13D
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Add missing POLL_CFG_GDSCR to the MDSS GDSC flags.

Fixes: 90114ca11476 ("clk: qcom: add SM8550 DISPCC driver")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/clk/qcom/dispcc-sm8550.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/qcom/dispcc-sm8550.c b/drivers/clk/qcom/dispcc-sm8550.c
index 1604a6a4acdc..eebc4c2258d0 100644
--- a/drivers/clk/qcom/dispcc-sm8550.c
+++ b/drivers/clk/qcom/dispcc-sm8550.c
@@ -1611,7 +1611,7 @@ static struct gdsc mdss_gdsc = {
 		.name = "mdss_gdsc",
 	},
 	.pwrsts = PWRSTS_OFF_ON,
-	.flags = HW_CTRL | RETAIN_FF_ENABLE,
+	.flags = POLL_CFG_GDSCR | HW_CTRL | RETAIN_FF_ENABLE,
 };
 
 static struct gdsc mdss_int2_gdsc = {
@@ -1620,7 +1620,7 @@ static struct gdsc mdss_int2_gdsc = {
 		.name = "mdss_int2_gdsc",
 	},
 	.pwrsts = PWRSTS_OFF_ON,
-	.flags = HW_CTRL | RETAIN_FF_ENABLE,
+	.flags = POLL_CFG_GDSCR | HW_CTRL | RETAIN_FF_ENABLE,
 };
 
 static struct clk_regmap *disp_cc_sm8550_clocks[] = {

-- 
2.39.2


