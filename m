Return-Path: <linux-kernel+bounces-226808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CDF5C914437
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 10:06:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83C6B1F210A9
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 08:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4962F5339E;
	Mon, 24 Jun 2024 08:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NKL4DMcg"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F0B4964E
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 08:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719216364; cv=none; b=NHDQ69xE4F8e+iFAqxS5m/V218FUlVOU+Q4jw9I/3BSYMGzB7Y8pQMqp3t6NvfMmfmDUsTuYZXWkc+l8t78ggFfRhSmvS54XhqZ0HQpYvFl87xUegF3i7ul9hkFZjSs8PjyNS790zYBJhLt0sIrg8xmZWTm9CQ1ty5jVS75sWvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719216364; c=relaxed/simple;
	bh=CVZ99XGO1/Q0YNiabuHR8pXC7UWmuLN1weDi3HiCVx0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ehTf3fow77WOgHaG9sivjFmWqj/0/yXtrCQrc2hIlyNos3DPJQbyHKxZuMPbKe0XkHGqalLl7DvvMpotJBIFzlZENvOVc02gdy2BdgE9wfTafLfDCDHZkyMP8/WiBjw05vaAXhae+k5M/66gvKm3RRwBzJr4Kmlb+VTJpFGQGdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NKL4DMcg; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2ec50a5e230so25644411fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 01:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719216361; x=1719821161; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vq027QwJPOPWERgfAacSQ3tvZEtk9hRZ+RB+oxWkMp0=;
        b=NKL4DMcgbnffaiAxBIiQ/hfa597L+CN9JPSQ5wzOeRxJb3aCKkUGd+ZmvCukpsDLve
         bG5yltpPfgnVg8BmXo+vjJhGaKa+rL2p3pPSxXYcYaJyAw3XpO42sO7yXVeNbUaEgHJo
         cpAIsw8IIJx6zHZ3oTY7t705s1R9YNTrGq65XaAzrWlgoCQhdIjVtHZd/WCE9lZSYTwU
         jnonGyjVPpXRYGgNwWs69Yq6r0bKICN0ZYq0by/vOiwNyV30Y0tSZ2kl6tRilEhVLYjP
         p/Tja+Za73ugkXLilAycGCqW1jlLKqbWwlknOsyUv1tXMwR8/zTjZfLwCsCKLdcM8pQh
         LEag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719216361; x=1719821161;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vq027QwJPOPWERgfAacSQ3tvZEtk9hRZ+RB+oxWkMp0=;
        b=mW6fTk8Dmlgiy5UivLUqXnHZ1zIFzOYB3ioZd6rQDkrsUmCKqhn5vT2jKfx9OhQGz+
         QSCr3oh0TE1890l6JMBpHjw9gXUDgr5j7dFesPPySFcq5N+qwcELUbcIlWENlpwUek5i
         GXcoORYHpiJxN96frpWhj0f/EWGmLpnIGOJfGy2GMO+R6shUlLu3emlzG5Ds3P05RMSH
         1I9m46s6kidkzd2h2lhG1RMrdLzfTYbXMCgbHN3eMUdtplWFwfcIwnycvcomA3lssMXz
         oh8ouTdS04oMTxfD4JTjrTUMWWnofcspozYQDAUQimtzXiEFko6T3Pd0CRvnP6XIKEMu
         SQnQ==
X-Forwarded-Encrypted: i=1; AJvYcCWsFk3IbLmYAT2XdnY2n4sfvVgI0P6sguoA5wTz0n5IcwtNwpGTdQuY1VtuvrcMFwZIuEp38O0AGQkvk+Rs4RM47tcfKRPUCY4MD38C
X-Gm-Message-State: AOJu0Yx/ykU7R1/bs3eeE+7e32tniP+v7tbviBRvNB4VCgeyeDyAtNIw
	yp3OGqI6951FvNZNnYSPjaRRZSY84FtSRPXbmOSGNqvjwc2ZWGrMQgg5qutSm5E=
X-Google-Smtp-Source: AGHT+IG/DPxnHbM7vQbL/qKAQhWp6hBWMKXWzAs6fPLsVWWBybzmDb2augTjpN3BOnV6Yt5fPZiukQ==
X-Received: by 2002:a19:4312:0:b0:52b:e800:25d8 with SMTP id 2adb3069b0e04-52ce183559fmr1934089e87.25.1719216360895;
        Mon, 24 Jun 2024 01:06:00 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3663a8c8b27sm9280284f8f.104.2024.06.24.01.06.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 01:06:00 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Mon, 24 Jun 2024 10:05:52 +0200
Subject: [PATCH v2 3/3] clk: qcom: dispcc-sm8650: Update the GDSC flags
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240624-topic-sm8650-upstream-fix-dispcc-v2-3-ddaa13f3b207@linaro.org>
References: <20240624-topic-sm8650-upstream-fix-dispcc-v2-0-ddaa13f3b207@linaro.org>
In-Reply-To: <20240624-topic-sm8650-upstream-fix-dispcc-v2-0-ddaa13f3b207@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Taniya Das <quic_tdas@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1126;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=CVZ99XGO1/Q0YNiabuHR8pXC7UWmuLN1weDi3HiCVx0=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBmeSjkAeoEtuUidH3qVRWlVXt8JDsc/aFpbUPsBrJe
 q5pehxCJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZnko5AAKCRB33NvayMhJ0eFuEA
 C8JXkUajsSIicgsyO769Yk5BjDrbB9kB3guwEeXo3oprRY/WUl/HT6yibZ1Oi1X5cIlHITEq8XNWqN
 oVxE8WUl9SqnCwWqgqK3ov01vVl4BbPYmb7O9rU+EInhhLrgOITUtaaEVvHntcGNRvDPyHBzmPISwa
 ViJUZOn6sKJzzOvoMIst5zLfl910mgHHq3UtS3VN1KwiRg9HWGlfZBrwEkL4UxDwjg9l1gKwOgVl2i
 EtmNHy8TpuQuxy9nLGsxwueMRrKb8mLsROR1kivNbIp4rj6Mgc++9Qwu6MBAhuG5xKjQCvaZYRKUQg
 ETHgKC5R05N7kz9aNTAhi6PvOmUfebRRBhK21TjVJoVppTc6xXx2xTZyP9tWsXTG4Mgc7OtvHC3m2F
 sHc3AOgifIekEtqAC/S3PInL2/vDPWsUx1sfH6gbKCl8fgCGkgA4fmtbP94PL9V4RtRYoyWXjie4bd
 5kWWpQJe87aW2zwGogFIYepGHHH+7s80JQAiKS2rrQCnwZRTIWpTWG8rLXRafh4+vZJ5kMjASqh1vc
 0t+GKcfG3g8jhqDlEN3CbTzrCMCGM/IU9w4342QpFTTOINs0DjeWGivTwimjg1tBP69jtd/jhq4NU+
 6Tf/khTOmvmy6maWpHsphyzm5JUkcLb6jxiyuIdL3wKtItlEHBRZVrewfTLA==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Update the GDSC flags by adding missing POLL_CFG_GDSCR flag.

Fixes: 9e939f008338 ("clk: qcom: add the SM8650 Display Clock Controller driver")
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/clk/qcom/dispcc-sm8650.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/qcom/dispcc-sm8650.c b/drivers/clk/qcom/dispcc-sm8650.c
index 1222a26c45c8..85d8809e31e7 100644
--- a/drivers/clk/qcom/dispcc-sm8650.c
+++ b/drivers/clk/qcom/dispcc-sm8650.c
@@ -1610,7 +1610,7 @@ static struct gdsc mdss_gdsc = {
 		.name = "mdss_gdsc",
 	},
 	.pwrsts = PWRSTS_OFF_ON,
-	.flags = HW_CTRL | RETAIN_FF_ENABLE,
+	.flags = POLL_CFG_GDSCR | HW_CTRL | RETAIN_FF_ENABLE,
 };
 
 static struct gdsc mdss_int2_gdsc = {
@@ -1619,7 +1619,7 @@ static struct gdsc mdss_int2_gdsc = {
 		.name = "mdss_int2_gdsc",
 	},
 	.pwrsts = PWRSTS_OFF_ON,
-	.flags = HW_CTRL | RETAIN_FF_ENABLE,
+	.flags = POLL_CFG_GDSCR | HW_CTRL | RETAIN_FF_ENABLE,
 };
 
 static struct clk_regmap *disp_cc_sm8650_clocks[] = {

-- 
2.34.1


