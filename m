Return-Path: <linux-kernel+bounces-566917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74295A67E47
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 21:51:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51E7C42490D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 20:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22633212D62;
	Tue, 18 Mar 2025 20:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OxVJC8OR"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F251F4CBE
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 20:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742331112; cv=none; b=iyJUqOilomov5xf9XHhYTQe+KeX9OxMY3GJ8ixrHLlDDCMwEeTOOXKelQJnJpz5FkOO9eTachHD2beGumYiVWD8xJ3BSKIJJ/P7Yx8jPFRNa8AONr6Q4YU8YxRBHAYMVFFvFNyzhYsTyEIs+5wMCm5ZFvImPiesCF2yvA7xS6qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742331112; c=relaxed/simple;
	bh=9/2VjLmXYDOUl51TmK2ovJL3zJio4lGfeAtl2DW9qiU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FZJ7F/we3AkNvluDItqBQd3Zh9O46UbTGoSrHorW32XQMSFfufLc2lMBs8lEsc/UMpgbQRnmkh+QelK/2ziN1U7YG134IN80HuWg93/hN8Zn2S3rMPxLD3iYNBAQFqB4p4qnCNW5uLxXKYlqXXyd40+OGvUFGGYo3T1CztBjLK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OxVJC8OR; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ac2902f7c2aso244311666b.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 13:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742331109; x=1742935909; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=287DJZhzBThsZN7DhGmtPMIiH7Cji9cmvAJ0TdlRH04=;
        b=OxVJC8ORG0f3XzQHPAjvmZ5jvFxZ8K65/Kb8j/dATQ4lHZlHvxSSJZP7mYCI7AxSIC
         BwoyFCyeQV6mW3p4p/GYMy/WE034URZ78sFrTzeWreH3q3t0MX/GboZ45ml4DG8/h7WL
         LGa88hI/i+MCeqR7Q/9lsVCudtBoAWC1PlAnemAV8rOlQxgYZfd+LruWXUzLaX3vjxQU
         ytXN/P8O6L2VqBBTvoDRZDXgtZISkD3pEnUzkiYq47xS/aw4GU1Nr94QZbv/r/8bjUAG
         L83PllaeHzz5sF6cuAnMqJkHHJK3CJDL9dAMcuqbORf2PWgss7vNElWl4bLPH0r2KpPs
         HVSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742331109; x=1742935909;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=287DJZhzBThsZN7DhGmtPMIiH7Cji9cmvAJ0TdlRH04=;
        b=XVb/m4BDjYROpN73InlCPrZbZX9ksmz2PRzKZVDoxetfo9Yl6EWlFh3HyF0jlwb6IU
         aJW352v7AtIhITgTWYyL23GEMsFASoc+mDz9xY7q/E5GvM6sF7jkuBxuzk/xFtLmIpfl
         oCVRXgl1tFg4JgrAAj0Z3qUOvTXwPIIY3Szohvo4kLuhPOwf9KqlOYRn2VdXnxhoAxlN
         XFxvGmiRPF2yUWs7olTs27SVsPVxLTX1YKavWBUsd+cOJIJNMAeBU5ofHpqcte1lkxo5
         isZVZY+aAJEKKhqn77sDgyPNVsYSym4CbGlqFlfIn8rOc3PaCUY9FZOjIZqGUgSOncyq
         jL3A==
X-Forwarded-Encrypted: i=1; AJvYcCWjmYhV7B2Mo8kadVILTBiHeSbkKBFYYujMdDYOYHeT7XweL7Z3qlj598A7bz1uLVewlhCGViBw11+fJeg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMw4n1HYF8SPNzp76l9RNs/Y6zEET3Samdd78xnGDYHwhzS0UJ
	F8xxi4WXFwLwVewtliRW0m8FC7eiZgmD2nM3EyPAP8N5bHPYk7c/
X-Gm-Gg: ASbGncuh8V60Iz7NApe9FHfR51Qk9C6YFfeJbnvtfDJdogpeoa+zCXl/kzbvUiw7J6+
	t4uKidIcMTIg3sDWLQRKVa6m+NV50PzIG5nZsiDpqJemTPCrDtKOpRPISmyIIivj75qvM9HTDn6
	jtkm5wxYLp+pu+nnj95sClw5fes/lQEGhhpY3h5Ha7GOlG5dCXmkZJpJLIJXYK3anuJ3UaK6mYp
	Bj4o2tGSFVlSG2vXs8NBTG5W/Jslsz5/vBlraFPx9yAtIWlZ51QfH8lq237+K30w5UJMTRYb7FZ
	38vwK6BoLjK3xU+Q5tfarUjZIquM6v3rk4NNysAAHbs3s8J6vBH8NGW6Bw6pJcf6yIC/txJM1HS
	LtMQyDKDhr5iioEY8M6+dHdLx+XMsRwc=
X-Google-Smtp-Source: AGHT+IHI+7J8oFywjgkkoSQEmHM4c8CUSUaxXtKSa4lTwBK54Unhu8Fi2Ub2aElRQNYRqArfETsGFg==
X-Received: by 2002:a17:907:868c:b0:ac2:ba52:f918 with SMTP id a640c23a62f3a-ac3b7d929c7mr8943266b.23.1742331108825;
        Tue, 18 Mar 2025 13:51:48 -0700 (PDT)
Received: from localhost.localdomain (146.10-240-81.adsl-dyn.isp.belgacom.be. [81.240.10.146])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3147f0ecdsm893238366b.73.2025.03.18.13.51.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 13:51:48 -0700 (PDT)
From: Philippe Simons <simons.philippe@gmail.com>
To: Chen-Yu Tsai <wens@csie.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	linux-kernel@vger.kernel.org,
	Andre Przywara <andre.przywara@arm.com>
Subject: [PATCH] regulator: axp20x: AXP717: dcdc4 doesn't have delay
Date: Tue, 18 Mar 2025 21:51:47 +0100
Message-ID: <20250318205147.42850-1-simons.philippe@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

According to AXP717 user manual, DCDC4 doesn't have a ramp delay like
DCDC1/2/3 do.

Remove it from the description and cleanup the macros.

Signed-off-by: Philippe Simons <simons.philippe@gmail.com>
---
 drivers/regulator/axp20x-regulator.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/regulator/axp20x-regulator.c b/drivers/regulator/axp20x-regulator.c
index dca99cfb7cbb..da891415efc0 100644
--- a/drivers/regulator/axp20x-regulator.c
+++ b/drivers/regulator/axp20x-regulator.c
@@ -371,8 +371,8 @@
 		.ops		= &axp20x_ops,					\
 	}
 
-#define AXP_DESC_DELAY(_family, _id, _match, _supply, _min, _max, _step, _vreg,	\
-		 _vmask, _ereg, _emask, _ramp_delay) 				\
+#define AXP_DESC(_family, _id, _match, _supply, _min, _max, _step, _vreg,	\
+		 _vmask, _ereg, _emask)						\
 	[_family##_##_id] = {							\
 		.name		= (_match),					\
 		.supply_name	= (_supply),					\
@@ -388,15 +388,9 @@
 		.vsel_mask	= (_vmask),					\
 		.enable_reg	= (_ereg),					\
 		.enable_mask	= (_emask),					\
-		.ramp_delay = (_ramp_delay),					\
 		.ops		= &axp20x_ops,					\
 	}
 
-#define AXP_DESC(_family, _id, _match, _supply, _min, _max, _step, _vreg,	\
-		 _vmask, _ereg, _emask) 					\
-	AXP_DESC_DELAY(_family, _id, _match, _supply, _min, _max, _step, _vreg,	\
-		 _vmask, _ereg, _emask, 0)
-
 #define AXP_DESC_SW(_family, _id, _match, _supply, _ereg, _emask)		\
 	[_family##_##_id] = {							\
 		.name		= (_match),					\
@@ -805,9 +799,9 @@ static const struct regulator_desc axp717_regulators[] = {
 			axp717_dcdc3_ranges, AXP717_DCDC3_NUM_VOLTAGES,
 			AXP717_DCDC3_CONTROL, AXP717_DCDC_V_OUT_MASK,
 			AXP717_DCDC_OUTPUT_CONTROL, BIT(2), 640),
-	AXP_DESC_DELAY(AXP717, DCDC4, "dcdc4", "vin4", 1000, 3700, 100,
+	AXP_DESC(AXP717, DCDC4, "dcdc4", "vin4", 1000, 3700, 100,
 		 AXP717_DCDC4_CONTROL, AXP717_DCDC_V_OUT_MASK,
-		 AXP717_DCDC_OUTPUT_CONTROL, BIT(3), 6400),
+		 AXP717_DCDC_OUTPUT_CONTROL, BIT(3)),
 	AXP_DESC(AXP717, ALDO1, "aldo1", "aldoin", 500, 3500, 100,
 		 AXP717_ALDO1_CONTROL, AXP717_LDO_V_OUT_MASK,
 		 AXP717_LDO0_OUTPUT_CONTROL, BIT(0)),
-- 
2.48.1


