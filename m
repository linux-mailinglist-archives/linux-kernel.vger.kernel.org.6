Return-Path: <linux-kernel+bounces-189193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DDD4B8CED03
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 01:38:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54ECF1F21855
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 23:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3C4585C76;
	Fri, 24 May 2024 23:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ica0YS4B"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EDC685934
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 23:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716593857; cv=none; b=N8palOAzFM/OoZFfuDvS5cQjU7BdfRqzU3SmOaUR0vzqJRj3FkKcOmTKmE4+vthyxl0riEYd3JogxjWTsn4hoBry2fhQnSpU3OAF4m1paaor/ewHPKtxRD7d306TZLAqBwpQQxE24r7cnMwBu+b7qsdxedW7oUOhsmOsNVNpTNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716593857; c=relaxed/simple;
	bh=4CIO6artRJ4ZRunAE1h2kRB6vpyNhD0KsLJ2hd/Tayo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Y0XNdcovInJh1C2jkhp0ItprcRZZAGmvAT3CZbFrAEweR977jZH7SCquZIe6GaSCUBCs42J7lh1eDfQZGsSt/UzGZZXvnl1yslgD/rO8Qon0bY6+OGcm+R0bolJzsogs/qyk8XE4yGYUKcBQIypT/tvqRadblS1b3Fyykmme5W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ica0YS4B; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-57822392a0dso6328206a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 16:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716593854; x=1717198654; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mJNcJC3ubId/j8V3zKbBbmUpsocF9nZYwPjWMkiBbRI=;
        b=ica0YS4BQaD78nrTdOh0FPS/pBdNyguxYw7o0jYCw7Cwx5vpNo9RMpg79Rh5WPbdon
         R2FLvSF8s3rqJWAZZYJMdckoU5dW+BxwemrkLLTJSaXZPhdrMQtXvoERd9FWDVhhT73w
         PZDPDWxDG17qW/CVNJo/BFPyG79f1Iu0yv98AN9OxFby3EWKTfnNarupx5EpudBM98kP
         3yW9vPmhbEi8rFefuPyqeDB8E+oK23crygAyzzcY4dQufnN1fzErEM3HfOcmPnXcI0PC
         5CNZxn8C4xeqAkJ47iX43T7ZXF7f+dB323VbN3BIvNylMyhSwZiV9f5JEF8zSO5ig+r4
         Mfiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716593854; x=1717198654;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mJNcJC3ubId/j8V3zKbBbmUpsocF9nZYwPjWMkiBbRI=;
        b=wR3ZYwRA/9Vt/BkzITc83Tf8HDW8bSkPE7Ry5lCAnTj28Up1JIy36LaB0g862wZ/Kb
         zmKLlrnyiPKDBwyXmipyE5go9ZxrzCDPY1/yy3jmlfYhCMWfcJri5kNXCVp/CJVTCWIZ
         dWsuVBL0F6f/uHsI6Iy1sHD7r9FYulh4seczCaO/yihCggGja9ufI/gkTYXc+9Irw5Oh
         ZPL3Fsnmwt79nXJhYo0Qk1OcwuYP8Sao8Xkg3TI+4STye9vnmWUHK5mYi7vaa0rhfN2v
         Lm97et5Y26MTT22ZNYh1qMQ9J0bHCRiuY1kiVgEZQAqqd4S5Wwvj8lbqmr7DaYAfq/Co
         kUaQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+mV42Qa586mjUJ5TRmSyw8VGGI+XUCZhapDtEesjbKOE10eZN9JfWwj+X6uEQTxC8d8GlOwLVpeMADfBDV3Ff8fS36C3HeTIoYf7L
X-Gm-Message-State: AOJu0YzMrx169jmM5K0W8yPcczNUQgEssbocqw3LNNZmgiSglXrj6BhQ
	eJIeNgGb4DSg7B9rG0f4TMCM1/QCn89opbJnR/xlPI+kdyjujhLEmlKqotlEYaYnXHri4br2Wrb
	jHX4=
X-Google-Smtp-Source: AGHT+IHPJ0VtOHp/meGK+w4U8wsWiUsXkAhCNyBm7BoGgef2yPcg/JAZngzYS1ErPBaPD1zCE4RxbQ==
X-Received: by 2002:a17:906:2a05:b0:a59:afbc:1b0 with SMTP id a640c23a62f3a-a6265114f2cmr231846166b.64.1716593853825;
        Fri, 24 May 2024 16:37:33 -0700 (PDT)
Received: from [127.0.1.1] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a626c938815sm189475466b.78.2024.05.24.16.37.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 16:37:33 -0700 (PDT)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Sat, 25 May 2024 01:37:29 +0200
Subject: [PATCH v2 2/2] pinctrl: qcom: spmi: Add PMC8380
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240525-topic-pmc8380_gpio-v2-2-2de50cb28ac1@linaro.org>
References: <20240525-topic-pmc8380_gpio-v2-0-2de50cb28ac1@linaro.org>
In-Reply-To: <20240525-topic-pmc8380_gpio-v2-0-2de50cb28ac1@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.14-dev

PMC8380 is a new chip, featuring 10 GPIOs. Describe it.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/pinctrl/qcom/pinctrl-spmi-gpio.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c b/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
index 4e80c7204e5f..ce576149b7ae 100644
--- a/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
+++ b/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
@@ -1235,6 +1235,7 @@ static const struct of_device_id pmic_gpio_of_match[] = {
 	{ .compatible = "qcom,pm8994-gpio", .data = (void *) 22 },
 	{ .compatible = "qcom,pm8998-gpio", .data = (void *) 26 },
 	{ .compatible = "qcom,pma8084-gpio", .data = (void *) 22 },
+	{ .compatible = "qcom,pmc8380-gpio", .data = (void *) 10 },
 	{ .compatible = "qcom,pmd8028-gpio", .data = (void *) 4 },
 	{ .compatible = "qcom,pmi632-gpio", .data = (void *) 8 },
 	{ .compatible = "qcom,pmi8950-gpio", .data = (void *) 2 },

-- 
2.43.0


