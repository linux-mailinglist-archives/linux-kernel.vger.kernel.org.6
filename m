Return-Path: <linux-kernel+bounces-190242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F12188CFBE2
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 10:44:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62E24B216DF
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 08:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D95A13B587;
	Mon, 27 May 2024 08:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KcWQk/65"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E94E13AD2F
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 08:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716799369; cv=none; b=XyqnURZuuhV4pVC3p86yIPN0ibSiGwaVy1iRvjpN85RcXvg4Ki1cA0MuJQw/wx1iQpd/BgKHDZZH5C0FK6s2VsL0pU+y3q0YxWnsjEbwJqvtHr3uzPvfptn5NUqyUmlN9TzQZg7+xK9+T+ScR8+WIE3KciBjoOhtrM5GZgI0oW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716799369; c=relaxed/simple;
	bh=VXXtf+CxFirDj8JdDAfT60xN71u6IzO9Gzrn6JM1ZZA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=q8svnRTp66XBgcd++fwX2qS145FacIoPJMkF0QW4C3dlJqPmDCaww9tgJhteLR9nJuaeqiVoSUCUwmDMUB8ixGSxPc5dtSnleBEJy8eRbBTXxduLdZRS05QYY0HOxWl6zfhNuKu/RPsf+n31rlUqovrl/FPesUxYUd/5Y0HZMiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KcWQk/65; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-35507a3a038so2128673f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 01:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716799366; x=1717404166; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D2IsXERwwkHQn+Hp66Wd5IbKCroL6ys71asrAFeZRd0=;
        b=KcWQk/65zyvmnycxb3773BJmaXe7AuKYaCTQT08XcMtIiKPQJIyHKon1Y7Rbvnv2Of
         A3mzpkldN+hGO5b20LD530I9aQY6D2AMpFzcPTqLBYeR+y9YkFCNiT69HgLalCxjNdGQ
         Z1dEfGo18vUBiyuSQKU+Z7mvJUtF5UyL8Cx9npOTyIHFUkr4/lOfP0g2fw6fdfSIhJo3
         2FYbYWrIy9gXdA1RIF51i3x3cqtv3qtkRxrR8thF+NUQdDtPc1KlyIk4anx639i0BSun
         ozmdwergQJFRJp2PZQcZwcKcoyh7WIhlrjxJXMAgtr9wn0uPcGLadS91uxDPpovh2T6w
         ys0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716799366; x=1717404166;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D2IsXERwwkHQn+Hp66Wd5IbKCroL6ys71asrAFeZRd0=;
        b=RSIHqd6QvjEYjMB/O7OPrt9pql6UO0Vl7O6+0AQvAfJ+uWUXqpmUu1dAFqkamEyWaT
         0eXOhZtGvhQjR/+0YU4A3fMYnS2Owwoa2FjCKVtBr6MQMAAmXX8xfI3LYum28qxusc8v
         pSdTMNFNdBInhOJILB2zX+X0sTGXwJ9lZ0hvTYTZqdJ6G0NQrGxcfeUOhaMZ2T4qBmdK
         zi6K4WzRS5w6B2aIK7mfHzFT52TjOFlxU1z4xX+r1NP5bqVMHmNYav49cVs6eJmQ6Ow9
         MmP/eL4iVEBZ8lczxPASl3wzoT4sj8Bmhe+hhP9n4yO3q/TNxZV0uAcd5OmyiHsE6QYB
         Yrwg==
X-Forwarded-Encrypted: i=1; AJvYcCVuRNcE70HJjNJGEAZG228H4iLB8HQNSUqa24lQ/7c65CgdhcIGewm3Jcqtv1VR0S/ACsfwzOz4lVA7NJs7X+2iNvBk809mlYaKON38
X-Gm-Message-State: AOJu0Yw3qqYSj8VnQI3BVuw9h6do/joWF1mATXYqjkgXLq+uRfIFBQ+P
	tXPfSk0sdTndNXo/dXFL0YyKrqYQy0hjUKv8jT/5zUn4sl1qlqo67a4ZQEqSiJ0=
X-Google-Smtp-Source: AGHT+IEuz+Mn+QSgT8qOU9yvwfXCm9findguajR5dYkQSCJG+sgdEJaUN4Qzgzs1gYlk8BZWub0uFQ==
X-Received: by 2002:adf:ef06:0:b0:34d:ae55:9dbc with SMTP id ffacd0b85a97d-35526c2580emr8875481f8f.16.1716799366278;
        Mon, 27 May 2024 01:42:46 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3558889fb57sm8447292f8f.114.2024.05.27.01.42.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 01:42:45 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Mon, 27 May 2024 10:42:34 +0200
Subject: [PATCH v2 2/7] phy: qcom: qmp-combo: store DP phy power state
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240527-topic-sm8x50-upstream-phy-combo-typec-mux-v2-2-a03e68d7b8fc@linaro.org>
References: <20240527-topic-sm8x50-upstream-phy-combo-typec-mux-v2-0-a03e68d7b8fc@linaro.org>
In-Reply-To: <20240527-topic-sm8x50-upstream-phy-combo-typec-mux-v2-0-a03e68d7b8fc@linaro.org>
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1271;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=VXXtf+CxFirDj8JdDAfT60xN71u6IzO9Gzrn6JM1ZZA=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBmVEd9DbrO5eFkHDcV7BFyfcSFoDY9GOFx9L/4cBoo
 QQ6F2O+JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZlRHfQAKCRB33NvayMhJ0Tg/D/
 9Kqa4zSjLeuYBuHqUIvtro8GoSjzdAJC0SVyPEIE3mA+/kNewBJSEfNwiUMMBY1fNo9fWCmc1c48L6
 u8ZGhwLCHzgeaRLimAYjmOnVLkt07nXxitoanFkUB7H9EdvfB27rtRVyInZ2AbN+Di+s6fkts7F6LL
 2GtVJ9Swp1l8Sfyj+13LqoAqlSYAVlWRy2VP3wDxuX1SFfpwNz6AutNluqpWxy81/UeAZzVnOrdHa9
 u7r/Rn8vYHw2SjkswAcNvcrho9SgauKlXFGIl4rjC81ac3kRkNQ744gaEHAwwkqf8RQ5JjCEScknK9
 mFz1nH3KhRfI0eyPGKyA/pC+lorKwuxmWwzSRUWjQfkkTtJyN2kVE33oAPV+MA1xTvGM+688aoMZiI
 pUgcubIpMTm7O6K5/LgufrbYmyI7v0KTQRj6LY+g4N9I6nmIsia3FeUMNQudceI3nJBkTxQh4CMLFa
 GEuvAJSt8xK9oM7vBIiKSLTUW79MKJyCHaZ1Zi0G636u2Ja7sgbZtP6GV+7MlXo5pewjavhK1TwmfI
 JzB5LEVYoc+x05C5qxp72h+GU6A7cOooYQLgie1gTUOS6f4kz87Htmn8NY5k97f+NLvkhq04GY1hsa
 Lf1NjC/fT7WzTs5mkDb5jlQvIOGtZtkAsl7Y8zyhBzhOLQmiC5Ts6MWfWxcg==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Switching the PHY Mode requires the DisplayPort PHY to be powered off,
keep track of the DisplayPort phy power state.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-combo.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
index 7f999e8a433d..183cd9cd1884 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
@@ -1512,6 +1512,7 @@ struct qmp_combo {
 	unsigned int dp_aux_cfg;
 	struct phy_configure_opts_dp dp_opts;
 	unsigned int dp_init_count;
+	bool dp_powered_on;
 
 	struct clk_fixed_rate pipe_clk_fixed;
 	struct clk_hw dp_link_hw;
@@ -2685,6 +2686,8 @@ static int qmp_combo_dp_power_on(struct phy *phy)
 	/* Configure link rate, swing, etc. */
 	cfg->configure_dp_phy(qmp);
 
+	qmp->dp_powered_on = true;
+
 	mutex_unlock(&qmp->phy_mutex);
 
 	return 0;
@@ -2699,6 +2702,8 @@ static int qmp_combo_dp_power_off(struct phy *phy)
 	/* Assert DP PHY power down */
 	writel(DP_PHY_PD_CTL_PSR_PWRDN, qmp->dp_dp_phy + QSERDES_DP_PHY_PD_CTL);
 
+	qmp->dp_powered_on = false;
+
 	mutex_unlock(&qmp->phy_mutex);
 
 	return 0;

-- 
2.34.1


