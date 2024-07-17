Return-Path: <linux-kernel+bounces-255029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0E24933ABE
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 12:05:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F304D1C20BA1
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 10:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5D4D180058;
	Wed, 17 Jul 2024 10:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Cc+EyKcd"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84D417F4F6
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 10:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721210679; cv=none; b=e+6rn1inEa5e2xm36zPeoCXcMJkach2cYXMJ7dkz1dof+RRRflfIJc8rfeZINtIhhsVhW4nnwFzbULR2DE7Ux+m8e+8Xc/BN+9C/Bm0RDzSGSwy41GnbuU2pXJKRiOexCtBKOWFSEOKJJRmK5eDCvl+uQPySwTigFdT2IYNFey8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721210679; c=relaxed/simple;
	bh=1SHzX/4uku2BSzz1JoOSyunNDM5LXA7dO1BSM2h+qfg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lET1b9hxlGvwZ7TGTmH9pXwJBtq6m9IcKfmN8b3J0qetPRQuL3+H4vUGyYsqFtmpWX7yOC2v4PMDL5i5eoSHWR+4GGu4wNYkuakzSxQEBPD/mvgcgAlYjJ9ibiYgfS65bHbQzX5eDU4mU9ZLEDxB3dIxsLhD0uamvSmuiecv5Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Cc+EyKcd; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-52e9a920e73so7440597e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 03:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721210676; x=1721815476; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ob6H+KTmv7s1Rzde0S99FhzJiSqflM7VrBPJjyTS6zU=;
        b=Cc+EyKcdxBrcoKD9K/PVNP1ThsIqWaL/6cqG0WfIdSJ4lJ0mY+WXyQEgUqXZSuDLZp
         epEld2ECR+EVo2fFqqB9OlHYT3UJohjEhpfmZ/MsBbL66CK7um9xycHvVr3XKgma2MyF
         8GqyepRmTNFztDNj8fo/E05AiM66VIZxgtJeSAtCbEgQF14d4/EizKmFpIAoo0Ctqv2B
         ctTiVrbiRRVrgLZO+zKCNo9G4WxNb3jceuSJI7W2xhSfoZwM2SAsWOL0zmK9AsGw8B3d
         oxk805r8VN0/rrbY6+07/57Rf/e0fRal6LiqAmRw0s4X+1vvlCUVGe+nUOS4I3r+R/h2
         vgwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721210676; x=1721815476;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ob6H+KTmv7s1Rzde0S99FhzJiSqflM7VrBPJjyTS6zU=;
        b=OrY1IQjBiA26XzICMRpqVaowc4FLEKnTc66AoD+b/egKIce6un3LVr37cJeoqPsblE
         JVy8KASHkxJ7MDWUiG2vDu9ZYmPmtf/Impt1F1tR3qT53D3bMyH+a4YpFzgK+WE2IQmY
         AakFzG+y+S72oMyyh8dVU/HXa6OVkuMgvgivSM7PMmgfWzZx7N668qr9xNiabpxKQa7P
         3+y9OAKVylq10+VOGJ7/oLBl8aWdecCgXptFxzezLtHvgwo5qfKigNWaw5VKz0IWMO02
         hA/Htm4up16x47uQsnk229LLJm/Ope66rTNtD/mLA3b6ibZMGF/uVJIefBhElvBUK2gA
         ovKg==
X-Forwarded-Encrypted: i=1; AJvYcCXgHRQ/s05nC2z1LVmCv08uJw0uou01SfazsT4hpTN6K+4bl+SDAU6DTC2wtOzMc/4bZS6xe0L7Ge5C9eR45Z/lk69KTqQJ5zm6Q4pc
X-Gm-Message-State: AOJu0YzZb1vEnkz+G5giEkTBYaO1z/uj7SdeEn9BY+QLpn5a1Rk8uZcj
	DZ2vA872E81Fly6pmomYTxEGjMR6xISt79VQfRdy4aKEnXI5xXij2Nx36yf2TVo=
X-Google-Smtp-Source: AGHT+IGtmH4R/tEmsRK9JZGrQhGH89O2TPrLe7vuBJbJE7Dapbywn77la111N2y6uMAZOrGNe3Q/+A==
X-Received: by 2002:a05:6512:2384:b0:52c:88d7:ae31 with SMTP id 2adb3069b0e04-52ee54271b9mr922045e87.48.1721210675862;
        Wed, 17 Jul 2024 03:04:35 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ed253924asm1425391e87.262.2024.07.17.03.04.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 03:04:35 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Wed, 17 Jul 2024 13:04:32 +0300
Subject: [PATCH v2 5/7] clk: qcom: dispcc-sm8550: use rcg2_shared_ops for
 ESC RCGs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240717-dispcc-sm8550-fixes-v2-5-5c4a3128c40b@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1142;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=1SHzX/4uku2BSzz1JoOSyunNDM5LXA7dO1BSM2h+qfg=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBml5cugqBKyuVhQFvmN51DuCTngJDeb5sBDF/Q4
 zSGnSN2FV6JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZpeXLgAKCRCLPIo+Aiko
 1U39CACRuxgKzRLpsillvacFNUbAIcul2uqYpxxIfVzVv4nLB+f0+x4+kIyaNeZn2qgtRw+XPDk
 hmVQkGuuF755g6WCZ8HeswxWbgVCJm/m29vTEYks4uf+jmI4P9T27OMbMntxDjz9hBj5bui4Zmh
 gUb2z9zy3p9suvDeiTk41aUM/FqiucfWqhviLUIIXS2zW3QwJa/DXsbzh7UIgZHL5Km3VM0VJBO
 nMXnpzPHJfMOUv6BajfbfHUyEgmJLcOtHIVgLdKiTurNQTQSe0dSFtJxNd2URgG+TGs9qtethv9
 OMdyJWSJN9kfCfJfi0dxObZ/VDpyaEfI78Eb7DOsQgoAgwJz
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Follow the recommendations and park disp_cc_mdss_esc[01]_clk_src to the
XO instead of disabling the clocks by using the clk_rcg2_shared_ops.

Fixes: 90114ca11476 ("clk: qcom: add SM8550 DISPCC driver")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/clk/qcom/dispcc-sm8550.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/qcom/dispcc-sm8550.c b/drivers/clk/qcom/dispcc-sm8550.c
index eebc4c2258d0..1d884e30d461 100644
--- a/drivers/clk/qcom/dispcc-sm8550.c
+++ b/drivers/clk/qcom/dispcc-sm8550.c
@@ -562,7 +562,7 @@ static struct clk_rcg2 disp_cc_mdss_esc0_clk_src = {
 		.parent_data = disp_cc_parent_data_5,
 		.num_parents = ARRAY_SIZE(disp_cc_parent_data_5),
 		.flags = CLK_SET_RATE_PARENT,
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_shared_ops,
 	},
 };
 
@@ -577,7 +577,7 @@ static struct clk_rcg2 disp_cc_mdss_esc1_clk_src = {
 		.parent_data = disp_cc_parent_data_5,
 		.num_parents = ARRAY_SIZE(disp_cc_parent_data_5),
 		.flags = CLK_SET_RATE_PARENT,
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_shared_ops,
 	},
 };
 

-- 
2.39.2


