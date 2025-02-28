Return-Path: <linux-kernel+bounces-538753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 25C59A49CB3
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 16:03:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34907189AA9C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 15:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D772927605D;
	Fri, 28 Feb 2025 14:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="muznHnCB"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E1AE276038
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 14:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740754798; cv=none; b=lUcCMLxNxY9CHwOV8xHTJY/DA4rRubMM7j03I1nBVSiZvTGapeiaW1hjevLkjDxZiWYcQlnf+nvf0/Ui6adr+VpJlNroaMsrAjem6QJrNCnJ7SIG5HolG/lGDYWkPPiOuzhvos3UbDDTYsx3s6hZXkqRFdP06436nrHhepyfLoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740754798; c=relaxed/simple;
	bh=t4qbeog7E1aqUQK6n2S8QKAoBM4UxRfAdV0Upm9NGAg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QTaZh4dvJyPnzq66sKa2+7jYmV/aeorLJkI7CXKapOdb+/4eaoiKG9Yh7Lr37QO+dDGssOpboIpQKj2cgqcnK1nlGLLwz82MaG1bJ6Fk+GlvHeUIxT5f5dvGTEwJejKbJw4qVIZ7x/zgVNRqVQvgo1VhyxGZ19oymv6AdNwPjgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=muznHnCB; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-390d85bcb20so199392f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 06:59:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740754794; x=1741359594; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KQNL0DTFNdponNENZJHjJr9zvCXn2Whem0hBaRtmthU=;
        b=muznHnCBoXdxzfoosIuP7UMAJ+Byu7QIBkxVwEVkqjZj56p5U5CrM5Felc+8Eleq93
         W8QGsWJlfT/8nQuKlwrwyv+c3fF43imPHz6KFZ4wVSoEK8hFLihvAblwcBUDEw527Vst
         gp+ybmtxiwfFwE6dBDE78OdbxWvfwZcLUHNXdO0f4xzttXLl6YUQuUETapiibqqXzrC5
         SMx7glK7OWfid/qP4vUCRXCEEvStcGqivN66hlWs+K3amwOXAkS2J1c0EVEYIfsDTyMk
         eDuC9f5FNNeLRwu3ehg5Yj5DN+GiSidIZ+HvvP8FQzIUwFG1wHXVblWzXzRmzbBBQzbB
         YR6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740754794; x=1741359594;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KQNL0DTFNdponNENZJHjJr9zvCXn2Whem0hBaRtmthU=;
        b=BTSDsgLesYh9//wdalUK9RHoMOljLO7Znx/diCHSAFumM+9Raji+H58trB+9dnLaya
         /d0UX7CjDwsFXFVFhX+cz61BIIAd/B5icpnfbqjR246b04hDIgEvDfJJtMqbTxgkr7Ct
         99MUHQn+WTAEmSa92QCymhp1pxATktiI8tEjlTiZgzka3O8opa5JaRebWmyVxeZPMtPs
         vroLtf7lqsGZdSAe70PPz3s8PrwbOcgNyR2ehOrSKxjIptnSz5SUqc99d1SqjAMS9WYY
         TKzYRaeiEfZWMV/XzlYX1M6Ujc8vuGG99A96qjDOhzA4GUQ74Bpc3E5FsxUEZ26jAfBn
         yc4Q==
X-Forwarded-Encrypted: i=1; AJvYcCXyJrwpsVZH+F/FeOrpoPKNpezJ4gsiS2XGkbPOy9wr8pPmupyjIAOC0QKDXhNcdNbtONoZRHpBQwyx4ag=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5SgUU5dAhOJVzP3daaxtN+ncKha+aco5Zo8NOR1PbdtA5ZtYy
	lPhJIncoayoOohyqsTTlAO6RaZNGS/NXg6lUzJaaYHu69zn9mujXFPr7bzZNU2PYJ6/5An5DDWU
	r2gw=
X-Gm-Gg: ASbGnctgYrZUrT2eyY1xKn2QQpQ+kE7I59wQA5W6wcTc9/4ml3umtc2GQmlUZfqiwTy
	y5Pp2OjVwZOrkxnrBNmnjLVddHSaVn7CUa8vCNosQhFMGZXFCWD4jkO4avZoJfglNF1xGrBS6IE
	G5gS2HZpkuV7u4HKLwcS/sPVb6WndiJTM/NA4FUMoaTZm22j2y3YjQSoDtbGQa1LNgCiSgNeIec
	nckoGlaWN07c/55l6lDgjlmAP6fEGqY9Q9JYH8FNLlf4+7k2qkbgllDr4U9JAwkFJy2ad/v09Ps
	5cYluhulekpU2onOtRrBezPUBSdwF1O5AtnD32HZZw==
X-Google-Smtp-Source: AGHT+IHaKyH9IMjK5CR/eYxW1u4ouesAuRuIcMLAbRK8LKw07p60eIEp1r1put/PmCa158oCnZFqrA==
X-Received: by 2002:a5d:64c4:0:b0:38c:5d0b:71ca with SMTP id ffacd0b85a97d-390ec778bfemr1208401f8f.0.1740754794024;
        Fri, 28 Feb 2025 06:59:54 -0800 (PST)
Received: from [127.0.1.1] ([178.197.206.225])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e485d785sm5450770f8f.83.2025.02.28.06.59.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 06:59:53 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Fri, 28 Feb 2025 15:59:40 +0100
Subject: [PATCH 3/4] clk: qcom: gpucc: Constify 'struct qcom_cc_desc'
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250228-clk-qcom-const-v1-3-611ab80d45e4@linaro.org>
References: <20250228-clk-qcom-const-v1-0-611ab80d45e4@linaro.org>
In-Reply-To: <20250228-clk-qcom-const-v1-0-611ab80d45e4@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1622;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=t4qbeog7E1aqUQK6n2S8QKAoBM4UxRfAdV0Upm9NGAg=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBnwc9h0ypmhFjJZAAVRnFOxkGet0l4nMnufkzto
 m7heEkSSGmJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZ8HPYQAKCRDBN2bmhouD
 1/DMEACDm8+3Ue4EgA2JR8UXp87IcqZBqVGR1/4o07ny+jSXQhFJyUAONT2lQtISto+DHScrI/l
 3WT7889gYQJLr6KqeBoSa5rb73XQ0mdPlwoeN2TORmil5v/FDq/U+Joj93+SpOueKNTZ1Jtsqt7
 iGwUrQWyw1S7aOKBgieFD0GRMKsfoWaifLedquSCuH02rWoFhShsXx2dxMqkn+P/kk0fFxSlMXd
 cafwjW+TdEnWjBPvTIn/0oh1gZ8PGRb0lEGS6lknxt/dMMZouKME5p5deEozTL73r6sRA4ynl7A
 tAKXDDkGM5Ro86bMpKUu4WpPcRYjIBFkC4/NoA8oooJtYaCusGjYrA8CVlvS4Ldu+1gZndq5naU
 yjEoKMMt97nfJ1p7g2zsNSsxs38K1QxlKdfxIexMuIa7qZOaxJj9YEw2e4tQyAXbG88yVWOQ5RT
 wVgzl98RuTHmvRXYY0Wj2+6SNx4pxWqbExMLZ9AYsl9wFbJo7yL4xb05uj013vBiSZgykDR3e79
 OZawkltbqCLamU0lYb10zlF3yj1zGUUZqk7Ngl4uR7S9vbGpt2EhrfgQMrf2y6JOiR4Iva4MOw8
 C6eo2mBGnLPaUlaVHqhfAeDZrZlgnztg20IWgN87FB3nFrilaXOFiomXRBu6mfZI5uei+Aqu5A1
 GBzX54SAjMlw/0A==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

'struct qcom_cc_desc' is passed to qcom_cc_map() and
qcom_cc_really_probe() only as pointer to const, so make the memory
const for safety.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/clk/qcom/gpucc-sc8280xp.c | 2 +-
 drivers/clk/qcom/gpucc-x1p42100.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/qcom/gpucc-sc8280xp.c b/drivers/clk/qcom/gpucc-sc8280xp.c
index 913e17f101967036bf1dde7a3282c0155ae285c7..2645612f1cac514e3e796257b4e7d54742dbdd20 100644
--- a/drivers/clk/qcom/gpucc-sc8280xp.c
+++ b/drivers/clk/qcom/gpucc-sc8280xp.c
@@ -416,7 +416,7 @@ static const struct regmap_config gpu_cc_sc8280xp_regmap_config = {
 	.fast_io = true,
 };
 
-static struct qcom_cc_desc gpu_cc_sc8280xp_desc = {
+static const struct qcom_cc_desc gpu_cc_sc8280xp_desc = {
 	.config = &gpu_cc_sc8280xp_regmap_config,
 	.clks = gpu_cc_sc8280xp_clocks,
 	.num_clks = ARRAY_SIZE(gpu_cc_sc8280xp_clocks),
diff --git a/drivers/clk/qcom/gpucc-x1p42100.c b/drivers/clk/qcom/gpucc-x1p42100.c
index dba7833396130e6f25baf078aeef466c89597976..4031d3ff560a8b18831fdb2480bc5c22d5b5d58e 100644
--- a/drivers/clk/qcom/gpucc-x1p42100.c
+++ b/drivers/clk/qcom/gpucc-x1p42100.c
@@ -523,7 +523,7 @@ static const struct regmap_config gpu_cc_x1p42100_regmap_config = {
 	.fast_io = true,
 };
 
-static struct qcom_cc_desc gpu_cc_x1p42100_desc = {
+static const struct qcom_cc_desc gpu_cc_x1p42100_desc = {
 	.config = &gpu_cc_x1p42100_regmap_config,
 	.clks = gpu_cc_x1p42100_clocks,
 	.num_clks = ARRAY_SIZE(gpu_cc_x1p42100_clocks),

-- 
2.43.0


