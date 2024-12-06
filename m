Return-Path: <linux-kernel+bounces-435011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F08D9E6E5E
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 13:38:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 208CE2850C7
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 12:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2565A20125F;
	Fri,  6 Dec 2024 12:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RHLFyVS3"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CABD31FC107
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 12:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733488679; cv=none; b=iEW+vKjMwqJ7v3gfEW3HjhhKIy720ix9f/t/YGaYX47tnnWiSyUIzLNp4x/lqtoEQhNVL7K1T3R96JxANNFgL1Nyc0nwx75NCqvfgblfHrZKPRhZA/HySCjEV3z2f9vUrts6tTgqtR7U+TtrnH3RzIR2QsADAzonWHLRzxOKx+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733488679; c=relaxed/simple;
	bh=A/dVvZHrB4+vVP5iSkc0I3eF4l7mdBpVs1TJojDmmB0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a7bO0fxnfSkYVAXAnN8maVVs0o6Mh+CgHwRYOChg8vcpImvq6TQBr6GuX+5haOjwToSHX3Lqyke/gO2LpKwOPXH4NuDGr7bUl+O+83dFWTGno3FfrdV0ty6YPTYei8mwhuT+KsF1ctykUgEdwV6fFRGpgaiy5dmNMi8VqyzBnKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RHLFyVS3; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2ff976ab0edso20932691fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2024 04:37:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733488676; x=1734093476; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lLQn9prp1pAIQSJwQj8nE4pKGTXIIBlYH8IH0WOA7oM=;
        b=RHLFyVS3gjnZ+noK1sWhCBiuX1guuD3dJGu6vSBINOYxNXXzv+nLncJM/2w6TuRflR
         B4SuoBdVVaOzN+8469PdVuGNrq3zSgawiYj4HrVeX0/kTg7ySiyFpYMISMa7P8oKENAP
         djg6hMjAapBAsV1bA7FwqbY996oO3KM+3YDwrasxwgpsPzTHNB0u+lFREUZsUdW+t502
         xt85y/FMQy4jZenWogPBShfVAwWsw8IidmAu1ElWDG7BZA2Y1V5hkbHVuqq8Zp4tYRxL
         kxA3jfNEioQdZ7nbJjfjj9bD+ev+OyhZDBnjFoxkxD0k45QYHdDv++u1qvSQ687Z3Cto
         6ZmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733488676; x=1734093476;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lLQn9prp1pAIQSJwQj8nE4pKGTXIIBlYH8IH0WOA7oM=;
        b=lGK6VeJhj/T6U55IpzQRDTDZchQOSoQVz/FC8kdAIcXOBYr7l1/M7JEoHYVS+BR/RL
         CVddf+1rKhP0ghGtvEMnLmJX7vbNXrX25BhyBdOwC6/K8H+6drwfQTfbnoomZe/gPEDH
         TKeoT6aVwufXGcno6AyHFwDb00d4ECl/9cXvE0bCOnSg2os4O+wueupGKV0LLwhy3qr+
         cgFAqklYKrT7gUcpUQNyDbibaLJuifDkT5Gt27mOqHIKHirBO6PoxMYw46TaJ/HC3n5/
         F6ThQWtAcvqYg58JwIXBCMolEJm7zzbA/Zr+sA8rjzA/bsKbBB9X2p7OWSiaV1Nz5ez/
         pV1g==
X-Forwarded-Encrypted: i=1; AJvYcCWQAcgI1L5Qkef7fVWnSCwpDJmDaQAZVWErDxndkej7IAQ41VO0xIasGfeCKM8KzUP9xdG+T4a+tyrXxe0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBgcI5yAxASlIgyeJtjV4W7JPh/CTSO7iAVn4PZkedj8Q/+nK1
	h9oF85/N84gVP1Cvj3EsTXT1N5n0NqpLKuIC7PO41AtHGnpc8g6s
X-Gm-Gg: ASbGncuLRY/XqSpts93t5RedT2Atc6VlcrqdrY8Ahe3IvVNzlQ2tlS6lVCssvKDf0tu
	BEO9lSVGpILgxvZhnpis9yKUtURuBI5CCHcMMDV/z2BjZju0FLEi8FU8asj9llTpXquk0xXFPBb
	3g5TrzW+07jv/FDYm/GgPk6l+1ZNBKes84ukIjvPhoevaHPqo3B7wLhP1nsYl6bdCO22aS8RwvR
	qMaAzKK5cGRprkEZNOouo++M5lTqRATu7uGgmPHaY9JrvVu2XOrijLze6kkKgOTicOBvQJKJg/V
	DsViYb0yfLvjJMyOaZTcEJsru6SMM1CBqjU+qnY=
X-Google-Smtp-Source: AGHT+IFLI9RNfDNESBnp+s7xvjFcUBJcBGxdzAj/4UL+5mM3cw4Hp4eLlJ36BWcPfz6BcRpclAWrAw==
X-Received: by 2002:ac2:5e29:0:b0:53e:2e3a:4f24 with SMTP id 2adb3069b0e04-53e2e3a4fb7mr1209858e87.43.1733488675576;
        Fri, 06 Dec 2024 04:37:55 -0800 (PST)
Received: from localhost.localdomain (229.140-242-81.adsl-dyn.isp.belgacom.be. [81.242.140.229])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa6260e048asm234713166b.175.2024.12.06.04.37.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 04:37:55 -0800 (PST)
From: Philippe Simons <simons.philippe@gmail.com>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	linux-kernel@vger.kernel.org (open list:VOLTAGE AND CURRENT REGULATOR FRAMEWORK)
Cc: Philippe Simons <simons.philippe@gmail.com>
Subject: [PATCH] regulator: axp20x: AXP717: set ramp_delay
Date: Fri,  6 Dec 2024 13:37:51 +0100
Message-ID: <20241206123751.981977-1-simons.philippe@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

AXP717 datasheet says that regulator ramp delay is 15.625 us/step,
which is 10mV in our case.

Add a AXP_DESC_RANGES_DELAY macro and update AXP_DESC_RANGES macro to
expand to AXP_DESC_RANGES_DELAY with ramp_delay = 0

Signed-off-by: Philippe Simons <simons.philippe@gmail.com>
---
 drivers/regulator/axp20x-regulator.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/regulator/axp20x-regulator.c b/drivers/regulator/axp20x-regulator.c
index a8e91d9d0..8f035db13 100644
--- a/drivers/regulator/axp20x-regulator.c
+++ b/drivers/regulator/axp20x-regulator.c
@@ -419,8 +419,8 @@
 		.ops		= &axp20x_ops_fixed				\
 	}
 
-#define AXP_DESC_RANGES(_family, _id, _match, _supply, _ranges, _n_voltages,	\
-			_vreg, _vmask, _ereg, _emask)				\
+#define AXP_DESC_RANGES_DELAY(_family, _id, _match, _supply, _ranges, _n_voltages,	\
+			_vreg, _vmask, _ereg, _emask, _ramp_delay)	\
 	[_family##_##_id] = {							\
 		.name		= (_match),					\
 		.supply_name	= (_supply),					\
@@ -437,8 +437,15 @@
 		.linear_ranges	= (_ranges),					\
 		.n_linear_ranges = ARRAY_SIZE(_ranges),				\
 		.ops		= &axp20x_ops_range,				\
+		.ramp_delay = (_ramp_delay),			\
 	}
 
+#define AXP_DESC_RANGES(_family, _id, _match, _supply, _ranges, _n_voltages,	\
+			_vreg, _vmask, _ereg, _emask)				\
+	AXP_DESC_RANGES_DELAY(_family, _id, _match, _supply, _ranges, _n_voltages,	\
+		_vreg, _vmask, _ereg, _emask, 0)
+
+
 static const int axp209_dcdc2_ldo3_slew_rates[] = {
 	1600,
 	 800,
@@ -781,18 +788,18 @@ static const struct linear_range axp717_dcdc3_ranges[] = {
 };
 
 static const struct regulator_desc axp717_regulators[] = {
-	AXP_DESC_RANGES(AXP717, DCDC1, "dcdc1", "vin1",
+	AXP_DESC_RANGES_DELAY(AXP717, DCDC1, "dcdc1", "vin1",
 			axp717_dcdc1_ranges, AXP717_DCDC1_NUM_VOLTAGES,
 			AXP717_DCDC1_CONTROL, AXP717_DCDC_V_OUT_MASK,
-			AXP717_DCDC_OUTPUT_CONTROL, BIT(0)),
-	AXP_DESC_RANGES(AXP717, DCDC2, "dcdc2", "vin2",
+			AXP717_DCDC_OUTPUT_CONTROL, BIT(0), 640),
+	AXP_DESC_RANGES_DELAY(AXP717, DCDC2, "dcdc2", "vin2",
 			axp717_dcdc2_ranges, AXP717_DCDC2_NUM_VOLTAGES,
 			AXP717_DCDC2_CONTROL, AXP717_DCDC_V_OUT_MASK,
-			AXP717_DCDC_OUTPUT_CONTROL, BIT(1)),
-	AXP_DESC_RANGES(AXP717, DCDC3, "dcdc3", "vin3",
+			AXP717_DCDC_OUTPUT_CONTROL, BIT(1), 640),
+	AXP_DESC_RANGES_DELAY(AXP717, DCDC3, "dcdc3", "vin3",
 			axp717_dcdc3_ranges, AXP717_DCDC3_NUM_VOLTAGES,
 			AXP717_DCDC3_CONTROL, AXP717_DCDC_V_OUT_MASK,
-			AXP717_DCDC_OUTPUT_CONTROL, BIT(2)),
+			AXP717_DCDC_OUTPUT_CONTROL, BIT(2), 640),
 	AXP_DESC(AXP717, DCDC4, "dcdc4", "vin4", 1000, 3700, 100,
 		 AXP717_DCDC4_CONTROL, AXP717_DCDC_V_OUT_MASK,
 		 AXP717_DCDC_OUTPUT_CONTROL, BIT(3)),
-- 
2.47.1


