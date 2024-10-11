Return-Path: <linux-kernel+bounces-361170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CC8B99A48F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 15:11:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABAE71F2183A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 13:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8446F21B434;
	Fri, 11 Oct 2024 13:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sGZ0qCjB"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B5721A70B
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 13:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728652184; cv=none; b=moPGbtOM5gldNy6x130RCtzsQH8JiSX2p6RvH4LLFEq50Y39b4myvGuJ2AgueSsn5sia97T9o2PLnA1iRgB1nJC0Kf3+T1XkCiUUmyB8vygYVB7Vx6TrDFrIsmJMkriyuZddyFLNdntHYXQN661kGA1iH/PIScQK1lS7dnr2oz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728652184; c=relaxed/simple;
	bh=pBS8TQcIAnFdQitaxFSWoWQwgTL79cVWX0zRSmeBwdc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oWQ0hz2u8qR1pzQMphE5oHlvZ8hQwSl0bmRONdGyZTRw2TLY9BkYqB830mWB89nf+K7zN+w9fFvYZ+cFa4x/Wg9nHI7dpe1BuPOgVoeOKEhp5n0kIZydReHoH5O1/kLzFYSd9ZpFy2tkkbSe3Bla3wAPqzPAC0nqKnVMqvpC56A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sGZ0qCjB; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4305493bc6dso2251525e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 06:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728652181; x=1729256981; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6nvL93CgMbfP8shaZG6AZK9feEPRQ+TeXPEOzrPPrTU=;
        b=sGZ0qCjBR4Zh1jHwA2Qk4xEFvCFwqXCHpfKG+0Zq5Ic2vKZPcdblf4fczAbObzuESe
         lShuTxVhagaHxPH6rpACXPfQawQnDsEmnrnpM+yR/8fhPvCAmHfsjlfcHEMUbpCFwJqr
         XA87wQEB5lPN04JfK8Kyi4ZWWT5N1vEYZBvqA42bhMqrZfguFydilP2v4kqprQZBXluk
         0xlcZYvalU/5dGaT20dm3UCunlbu3vi9CcXC8mpMIla4qyYrWt0HaD0pfcanMqujwtkN
         GstA3csR6/AwisMCdBsSyeAVZq3u7gFcOx/gWzfzYpOCuckqkEnIapmxHzB7J7a/ApAY
         7f3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728652181; x=1729256981;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6nvL93CgMbfP8shaZG6AZK9feEPRQ+TeXPEOzrPPrTU=;
        b=E+Xzmfzlq9kV7OObIoiWnSWxTE18Q70P7lEIbWC7z9Y2g2xln2pMLfTWX1Cd7DSBXK
         pCpatn6wLhjoipMb1MtDznwRcjtqwQ7PefS7yL0cuNh0p/f+GjFvRvLBCoClc+Jm5t96
         /D7tmb/kSTeQPvsq3HYVLJVh6J7rlgtXIR0HR46Q1zVUjY9fn+W9PJQ39oBWdxwpdc/p
         d4AI9pD+whtAViLFjdcE9TeefSQFELb5lj1ciFtRsZs8m09wtb/qeTohMSihXE2uTG8m
         dB+DuP9/L37S4RTmcN4UAvdfcw+1lj6AVNlMigVqq5uytHolYaSCgFmAbjhwuMUQ+cC2
         52mg==
X-Forwarded-Encrypted: i=1; AJvYcCWFcRbgT2/q5FPuEaUODgqxc2plj/txuhyqGLBIjXbqrPYLJctqqRpNE/lcxLMSEKQ6sJBZ0XyGhC8B2s4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFRGVjGD+RqDjVSM1G1bVwrB2d8fCOGZ5FAgX2mG1ys9DWOzPl
	DUU/saOOnwwK94hQy+ehFLDvotdbOnf331udk/C7mOiucWAXGXXxuUtx7roEJxlz0ND6reimrru
	S
X-Google-Smtp-Source: AGHT+IH3nPKWSxkeqsGiiBuZPE29XSORIeYCMUS0ZZU3V+DNACh4zh7wpyfltKfX3S/gJ9SInhRCtA==
X-Received: by 2002:a05:600c:46c6:b0:42c:b995:20d2 with SMTP id 5b1f17b1804b1-4311debc931mr9560245e9.3.1728652180982;
        Fri, 11 Oct 2024 06:09:40 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.211.167])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431182ff6d3sm41621835e9.12.2024.10.11.06.09.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 06:09:39 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Fri, 11 Oct 2024 15:09:15 +0200
Subject: [PATCH 07/10] remoteproc: qcom_q6v5_mss: Drop redundant error
 printks in probe
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241011-remote-proc-dev-err-probe-v1-7-5abb4fc61eca@linaro.org>
References: <20241011-remote-proc-dev-err-probe-v1-0-5abb4fc61eca@linaro.org>
In-Reply-To: <20241011-remote-proc-dev-err-probe-v1-0-5abb4fc61eca@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2495;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=pBS8TQcIAnFdQitaxFSWoWQwgTL79cVWX0zRSmeBwdc=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBnCSOEIqbUGUHYbYBQ8PjA5fdJUnrpybrUAggm+
 SjFmwH7VtuJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZwkjhAAKCRDBN2bmhouD
 18vPD/93qK6STns0BgbRvtkjkDqZpyczEL4vn5MZygS7dx0x0vzynoJoKhah76d83WYQ0hYbTmT
 fpj+QUQ0n8uFNwULLFrYR4k1y9zgbZpffK+UfBbNr2BNUgvmKaUjY/g/v4UU611aTVwu1sKCJee
 X24JdEcD07ZF42Hru+acq76kRqiyfr+S1TYv6e0cXmc6WgNQUwubg1FI8rUdDXV8VgLTUFpMmsO
 tRUc1v9joNK+RD3RPYTdoKX/qkw9gFQFfdYOU2d6A43FeuZcgZYvDXQ2CBuk87NcHcywBQaY+lF
 hdQNVY61rnVFW+XVXHG/5XWHkOmYs5RqQaSrMvIAolkhULOK1fJZ8kDhPykAIlJfTmbJgwyT+q5
 V8vwPNQfdb/nKhb++ku3av4xzRi+Pz8FbuAfS+jYeiD/FreN2tBNSbqzfEmSTfu4Tp+ygy1R3UW
 5AXP6UaPwIJglFUJrw1wt4yrmgXflLe8xolBuOEffiiXJ7GBKWyAXKNwq3QwUZDZtzFvh/d8ZXL
 /5PS4qT+fRw9GkcnhS371U7+CmVpFS8HTw+1BtLgfICnCbkPVCsSGqwbCbzPkXkFjm8FTallrxa
 l+crJXOc6Ob/2r8iAa4NgFyeOM8bX6nEX0pKkERsKxbQ+4lfgfcgAuNHNfsIyTs8vseXd9zA2J+
 mgHqffLZu2ui32g==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Do not print errors of getting clocks and regulators in probe twice:
once in q6v5_init_clocks() or q6v5_regulator_init() and then again in the
probe function.  This also avoids dmesg flood on deferred probe.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/remoteproc/qcom_q6v5_mss.c | 24 ++++++------------------
 1 file changed, 6 insertions(+), 18 deletions(-)

diff --git a/drivers/remoteproc/qcom_q6v5_mss.c b/drivers/remoteproc/qcom_q6v5_mss.c
index 92212892a53ea4843da62642c39413c33b4c962a..68b8172b023ee62be764ba69e07f3743ce6124e3 100644
--- a/drivers/remoteproc/qcom_q6v5_mss.c
+++ b/drivers/remoteproc/qcom_q6v5_mss.c
@@ -2020,42 +2020,32 @@ static int q6v5_probe(struct platform_device *pdev)
 
 	ret = q6v5_init_clocks(&pdev->dev, qproc->proxy_clks,
 			       desc->proxy_clk_names);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "Failed to get proxy clocks.\n");
+	if (ret < 0)
 		return ret;
-	}
 	qproc->proxy_clk_count = ret;
 
 	ret = q6v5_init_clocks(&pdev->dev, qproc->reset_clks,
 			       desc->reset_clk_names);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "Failed to get reset clocks.\n");
+	if (ret < 0)
 		return ret;
-	}
 	qproc->reset_clk_count = ret;
 
 	ret = q6v5_init_clocks(&pdev->dev, qproc->active_clks,
 			       desc->active_clk_names);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "Failed to get active clocks.\n");
+	if (ret < 0)
 		return ret;
-	}
 	qproc->active_clk_count = ret;
 
 	ret = q6v5_regulator_init(&pdev->dev, qproc->proxy_regs,
 				  desc->proxy_supply);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "Failed to get proxy regulators.\n");
+	if (ret < 0)
 		return ret;
-	}
 	qproc->proxy_reg_count = ret;
 
 	ret = q6v5_regulator_init(&pdev->dev,  qproc->active_regs,
 				  desc->active_supply);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "Failed to get active regulators.\n");
+	if (ret < 0)
 		return ret;
-	}
 	qproc->active_reg_count = ret;
 
 	ret = q6v5_pds_attach(&pdev->dev, qproc->proxy_pds,
@@ -2065,10 +2055,8 @@ static int q6v5_probe(struct platform_device *pdev)
 		ret = q6v5_regulator_init(&pdev->dev,
 					  qproc->fallback_proxy_regs,
 					  desc->fallback_proxy_supply);
-		if (ret < 0) {
-			dev_err(&pdev->dev, "Failed to get fallback proxy regulators.\n");
+		if (ret < 0)
 			return ret;
-		}
 		qproc->fallback_proxy_reg_count = ret;
 	} else if (ret < 0) {
 		dev_err(&pdev->dev, "Failed to init power domains\n");

-- 
2.43.0


