Return-Path: <linux-kernel+bounces-436369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B2AB9E850C
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 13:43:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 577462816EA
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 12:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9EB3148FF5;
	Sun,  8 Dec 2024 12:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S5bleanR"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9111474B8
	for <linux-kernel@vger.kernel.org>; Sun,  8 Dec 2024 12:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733661800; cv=none; b=ccNBwnMaye2xKHu87FhL9CAEOg6eY2ZFs+RFwwRbPR9w8Nu4nt4yrQUNPLt2B5jz3vOio/Fv00qQ71su7so5YYJf9IOO+VoMelKlPw1RffKsQ3YJqQvokGw9HQEY8mmTki8ITRKhIS8JSngH5s72mifK2kN9M/WyZw32TepMncE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733661800; c=relaxed/simple;
	bh=cV8Hg5eZG6jFxcgeFU1zqk0tAV2GPOKBp4c5pIY/C0w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MaY1V042B+UlT+VbFTBjrWFL0EKFI5J8XdozqbuIVSw8Iyr6SrC7FL+v1rw8M0DI/rPIK7xK3nEqZJOfFujLtwNntG/OFCufy8O7ZQrQaZHDzDB3vet0MPjL4HDqNBmD14oedeRLlFauj9cMO3OxHpl367mmGtQ5U1Yu2I+66+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S5bleanR; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-434a1833367so20230945e9.1
        for <linux-kernel@vger.kernel.org>; Sun, 08 Dec 2024 04:43:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733661797; x=1734266597; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zT3Eni26hyA5qK0aEbBC6ZG0g7MwOy3gWCJBQdtYR24=;
        b=S5bleanRTwxBcYANygDZfkk+xJ5uChHNEjsTYpLhiVYDawJloRmxPxalfjRg18UuYo
         8ItSJa6n5CSbfETATYTMvTx8gABxqwC9di2C/h0kc30GmKmLZjceTLCDHztevENEy0yg
         Vg4AmPLE0YEUVkESqZ7T3ucfbA0HUM0ZxmGVyJ5m5/mx/xeN6n1GyqxMm5xfgXSvnfua
         8hCjAoKfAwPv73Ggyt+YAHNW1nz84X2g0hV6QgqbTdwvBy3ip6/9HkSYA2q0yHS+upEW
         FBiwbAfFYkJgE9Iazcxuj4J5K014vdrMZZRpui/FQo73XYbi5UGF0ZfMwAabCGR/6JjS
         nTvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733661797; x=1734266597;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zT3Eni26hyA5qK0aEbBC6ZG0g7MwOy3gWCJBQdtYR24=;
        b=gX6wFn3g/dEyiuMDskGiJZkDU/s5Cg2fgyVz+5h90tu5Ltx0zY5ZGx/5fH5jJt0GJr
         LklG59gz2zilvv2RdmiTuj2P8gxVT009MbvYBnG05Ppl2vddMwPZCHrFfNHjFx8z+2go
         /zclPscCyFAoDt+kAekQcIu3j7MJ3Mc+kMOwD7+lgAMHlxiOrqtAOVKxcw0b36QeYZs0
         lX6r33b5Jon5A2uKX/6CJMAUnCkCxUTJM8BtD/qZ70VUDZamNI/BabZfKT7SmjuaU6XC
         qmMr77EvMIvHaZZGSiRClz0lOAer710N1HsW/BswXzN32wiEqVdjYqR/GdcEP0GsE3kB
         gbow==
X-Forwarded-Encrypted: i=1; AJvYcCVBvkdaaF1URsu98gcMgKcAfK8sz0n53klmRM0PJScCNbNNqzhclMu28OUCaDzaKT/Eh7gnYKGx3Oyyh+w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnMTEKK/nhDjph6tjPQqk/9uykSk0w2GulCG8l6pEq5NjxsB1R
	IEOcMcWg0JcVGDAIcB4MZW8xrm8UNk4vkYTmED68f4NcNdYc4aFN
X-Gm-Gg: ASbGncuwZl71vMGoy4liIYUSFrcAMdisBPCkAvWYOJeTwmlePqKHMc7n2UcCfNYYY4o
	OG3aSx4Q3JCSeA8GL4beXZfNwgfM015LpwW5eGlJQoZoceFYR6gvbUwqSKezu1qIFpTMv9iFFkx
	rw6fiK4HNs4Z4F1O1HCfZh7rN3CGz5cZeRbfv0kVMzkN/VgMoqXTxgUN28gxTcNQyqpDum95EHM
	CakpczxnZwo16G4mPVM8IUVXLbCBgT3VVHKKWPpXtOkGfrQUIRZYs+xT6l2glKXv1r3NB0oR8s7
	IHwiHMjCmW5ynHjzq+t5aXnnCyYjYBmIKvLCnjU=
X-Google-Smtp-Source: AGHT+IE0Gpp4fp/4rUeG0Yoj/01lUewFeEDK0CrOBJh/FlAsoKeg+Wb9iz8TZeiZRtq/vlVwyQGRQQ==
X-Received: by 2002:a05:600c:3544:b0:434:a4d3:31f0 with SMTP id 5b1f17b1804b1-434ddeadcd9mr70209765e9.3.1733661796407;
        Sun, 08 Dec 2024 04:43:16 -0800 (PST)
Received: from localhost.localdomain (229.140-242-81.adsl-dyn.isp.belgacom.be. [81.242.140.229])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434f80458cesm4462535e9.10.2024.12.08.04.43.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Dec 2024 04:43:15 -0800 (PST)
From: Philippe Simons <simons.philippe@gmail.com>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	linux-kernel@vger.kernel.org (open list:VOLTAGE AND CURRENT REGULATOR FRAMEWORK)
Cc: Philippe Simons <simons.philippe@gmail.com>,
	Hironori KIKUCHI <kikuchan98@gmail.com>,
	Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH v2] regulator: axp20x: AXP717: set ramp_delay
Date: Sun,  8 Dec 2024 13:43:08 +0100
Message-ID: <20241208124308.5630-1-simons.philippe@gmail.com>
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

For DCDC4, steps is 100mv

Add a AXP_DESC_DELAY macro and update AXP_DESC macro to
expand to AXP_DESC_DELAY with ramp_delay = 0

This patch fix crashes when using CPU DVFS.

Signed-off-by: Philippe Simons <simons.philippe@gmail.com>
Tested-by: Hironori KIKUCHI <kikuchan98@gmail.com>
Tested-by: Chris Morgan <macromorgan@hotmail.com>
---
Changes in v2:
- set ramp_delay for AXP717 DCDC4
- Link to v1: https://lore.kernel.org/all/20241206123751.981977-1-simons.philippe@gmail.com/
---
 drivers/regulator/axp20x-regulator.c | 36 ++++++++++++++++++----------
 1 file changed, 24 insertions(+), 12 deletions(-)

diff --git a/drivers/regulator/axp20x-regulator.c b/drivers/regulator/axp20x-regulator.c
index a8e91d9d0..945d2917b 100644
--- a/drivers/regulator/axp20x-regulator.c
+++ b/drivers/regulator/axp20x-regulator.c
@@ -371,8 +371,8 @@
 		.ops		= &axp20x_ops,					\
 	}
 
-#define AXP_DESC(_family, _id, _match, _supply, _min, _max, _step, _vreg,	\
-		 _vmask, _ereg, _emask) 					\
+#define AXP_DESC_DELAY(_family, _id, _match, _supply, _min, _max, _step, _vreg,	\
+		 _vmask, _ereg, _emask, _ramp_delay) 				\
 	[_family##_##_id] = {							\
 		.name		= (_match),					\
 		.supply_name	= (_supply),					\
@@ -388,9 +388,15 @@
 		.vsel_mask	= (_vmask),					\
 		.enable_reg	= (_ereg),					\
 		.enable_mask	= (_emask),					\
+		.ramp_delay = (_ramp_delay),					\
 		.ops		= &axp20x_ops,					\
 	}
 
+#define AXP_DESC(_family, _id, _match, _supply, _min, _max, _step, _vreg,	\
+		 _vmask, _ereg, _emask) 					\
+	AXP_DESC_DELAY(_family, _id, _match, _supply, _min, _max, _step, _vreg,	\
+		 _vmask, _ereg, _emask, 0)
+
 #define AXP_DESC_SW(_family, _id, _match, _supply, _ereg, _emask)		\
 	[_family##_##_id] = {							\
 		.name		= (_match),					\
@@ -419,8 +425,8 @@
 		.ops		= &axp20x_ops_fixed				\
 	}
 
-#define AXP_DESC_RANGES(_family, _id, _match, _supply, _ranges, _n_voltages,	\
-			_vreg, _vmask, _ereg, _emask)				\
+#define AXP_DESC_RANGES_DELAY(_family, _id, _match, _supply, _ranges, _n_voltages,	\
+			_vreg, _vmask, _ereg, _emask, _ramp_delay)	\
 	[_family##_##_id] = {							\
 		.name		= (_match),					\
 		.supply_name	= (_supply),					\
@@ -436,9 +442,15 @@
 		.enable_mask	= (_emask),					\
 		.linear_ranges	= (_ranges),					\
 		.n_linear_ranges = ARRAY_SIZE(_ranges),				\
+		.ramp_delay = (_ramp_delay),					\
 		.ops		= &axp20x_ops_range,				\
 	}
 
+#define AXP_DESC_RANGES(_family, _id, _match, _supply, _ranges, _n_voltages,	\
+			_vreg, _vmask, _ereg, _emask)				\
+	AXP_DESC_RANGES_DELAY(_family, _id, _match, _supply, _ranges,		\
+		 _n_voltages, _vreg, _vmask, _ereg, _emask, 0)
+
 static const int axp209_dcdc2_ldo3_slew_rates[] = {
 	1600,
 	 800,
@@ -781,21 +793,21 @@ static const struct linear_range axp717_dcdc3_ranges[] = {
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
-	AXP_DESC(AXP717, DCDC4, "dcdc4", "vin4", 1000, 3700, 100,
+			AXP717_DCDC_OUTPUT_CONTROL, BIT(2), 640),
+	AXP_DESC_DELAY(AXP717, DCDC4, "dcdc4", "vin4", 1000, 3700, 100,
 		 AXP717_DCDC4_CONTROL, AXP717_DCDC_V_OUT_MASK,
-		 AXP717_DCDC_OUTPUT_CONTROL, BIT(3)),
+		 AXP717_DCDC_OUTPUT_CONTROL, BIT(3), 6400),
 	AXP_DESC(AXP717, ALDO1, "aldo1", "aldoin", 500, 3500, 100,
 		 AXP717_ALDO1_CONTROL, AXP717_LDO_V_OUT_MASK,
 		 AXP717_LDO0_OUTPUT_CONTROL, BIT(0)),
-- 
2.47.1


