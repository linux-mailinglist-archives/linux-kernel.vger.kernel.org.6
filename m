Return-Path: <linux-kernel+bounces-573032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58382A6D21C
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 23:43:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0A3516F655
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 22:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 133CE1F3D5D;
	Sun, 23 Mar 2025 22:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wHd0oSTl"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6631D5CCC
	for <linux-kernel@vger.kernel.org>; Sun, 23 Mar 2025 22:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742769580; cv=none; b=gto631wrD7o3VU2q/8Ru0e/nqtbi7JuYceFNo1xdujSkHTF4NsypY4vYDKqll0esTpbcRtBPTKtkBlRXVxLk9djpfIrwXEIDSNJqmR9U9c+FJtFucWiSQ99v7T0TGPxxTidoE2m8bKyR0MK9ZDt9lbmwR37qA5sXe2l4ZYn4Ryg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742769580; c=relaxed/simple;
	bh=QKL8Ytaf6dGtPsAh1+74H/LNJepm9+/T3Tzf5JXAhIU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iUtgv68yAZHuD4zitC3IUWgZUGFJati+d023gdREZdQiMHhwuE76Ratw9l0adVI2gc8GiInAVtDBGEqgDtAcsKGcqZpuRLf4YXKvJQy9hYshF2ajsQ05zcSKNU+ORQOp/ZZQYkZ6kCVVKcEFMPamKjLQkAfsER5GTdpldYqePxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wHd0oSTl; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ac2c663a3daso769281866b.2
        for <linux-kernel@vger.kernel.org>; Sun, 23 Mar 2025 15:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742769573; x=1743374373; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hTxU1W+gue/BWMRsVQK9iOH//Nw2cf3wcu3aMwThOM8=;
        b=wHd0oSTldpBEK5QJca6xnISTHeraeFQFVQnjZt+SY6MY7+JUtabMdmulosGwhZ9DA6
         9bPOBIXY2zbcSv3Vbbqg1w47xaMHu4BHi2AvF2hZgb+kQg/OvBD+hZzHNwNoBRdTUCKj
         i5b+VrluoDcovZV0C8feIAsVHAx6hBKqBbrgxEQ4viTtYtqNCY4ZmyIdWh07fZtgFEAI
         ytyTII+kLIGQDFmXwgD5GT/D4LaiV0C4tUAQITML60U1piwk+rW94KiMti2AcrwgoFFu
         zp9eEBDIHmNIMkTmy9MWF5L6+KSxxOCBEkvCht0d1Qo2kfoExM8ziQTPDf8dsgHnNVhQ
         rNzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742769573; x=1743374373;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hTxU1W+gue/BWMRsVQK9iOH//Nw2cf3wcu3aMwThOM8=;
        b=nl+69snfEDdvZknnEs/CSnsfysyAkvxjuODp+KTbF7HdI3A3c/xFwInFdoMXr+3n75
         u5tUJrskB5AWFQS4SUN76ClsvIPVtNPYTQfK/h987VD1jiRU8z/CHGClZCZ7MXz5/lhZ
         Z5o9n/QlUh/UbY39BsdYFfWP6P2HRLdAKd3c029+5PnnEh2M0pOkjleIJPJQ+B3MssXK
         xc4WUCESjse+C97nKLVeH6NEWP/bxWRfj1WA3uA28GQIXQZs+L+TyvFCXJfi6VmCkB+r
         VwlfcwimWyb+7Hk5VGbzTaey6nq6QomHbcDRno5oUj/TdeI1iqLeCfzVvmTuE2mP8k6d
         7r0Q==
X-Forwarded-Encrypted: i=1; AJvYcCVEfevKdu+m+01G2+ZGHely2MyoZFT26L+bwW99/0RGe/Co+WhmstQDRGjqXIQc2bNDYnTK60TP5+LxSlY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyf5/ah3iN9Ir32T+RQDV3PwW+ic7aWf/PXS37lHGSy0rZqF9hC
	FWmcAykBK1IfjoEkVT++7yAD02toBvXbC4tFZ04H6SU6Gq2yMIxOHoJgVQe8JbI=
X-Gm-Gg: ASbGncvdX3z/IpzSaG7q16T8T9+lrNGCDNMWq9ym/9fYLzUU3StCJf2CoJoIc0Nb3es
	68r/qPbo2SQZWqas6gvePIpnnk0phUUq+Xp8goYVZBNgsw85OGVkJCvCvSnwYGRaBXJtLBtkbfK
	K5tNiwZxqCur7o/EgRefzT33NhumDpzz3tTaavvHBI5xCYgDOgm0Ql0HThPxlfIzvzr9wbnh0j9
	PzSdnoH5cMn+Sq9JnN95niZ3LtTkBwVmrmol4kucy5TKE5j7mPUvTlvFPo/CUznk4dvAVBEAwDk
	LF789MFETofulNAKcdu0J6AAlDM64KsBGOAkCKdCwFpZ7P5rTV2D+HR3JW1/LbjxIt2XDmnRDei
	XHE0LnjFlVUNJbW0BP1oJsSK7fRDS
X-Google-Smtp-Source: AGHT+IFRwsk7g0/V5N71R/aeNk5DfXRJnWzrEBdlGqW+YmGP+K8r15zEhceKjqCGxIHr3ot1FPPH7A==
X-Received: by 2002:a17:907:96a5:b0:ac3:5c8e:d3f5 with SMTP id a640c23a62f3a-ac3f2238ac9mr1051718066b.27.1742769573042;
        Sun, 23 Mar 2025 15:39:33 -0700 (PDT)
Received: from puffmais.c.googlers.com (8.239.204.35.bc.googleusercontent.com. [35.204.239.8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3ef86e44dsm559686666b.31.2025.03.23.15.39.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Mar 2025 15:39:32 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Sun, 23 Mar 2025 22:39:32 +0000
Subject: [PATCH 16/34] mfd: sec: s2dos05/s2mpu05: use explicit regmap
 config
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250323-s2mpg10-v1-16-d08943702707@linaro.org>
References: <20250323-s2mpg10-v1-0-d08943702707@linaro.org>
In-Reply-To: <20250323-s2mpg10-v1-0-d08943702707@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>, Lee Jones <lee@kernel.org>, 
 Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Sylwester Nawrocki <s.nawrocki@samsung.com>, 
 Chanwoo Choi <cw00.choi@samsung.com>, Alim Akhtar <alim.akhtar@samsung.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Russell King <linux@armlinux.org.uk>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
 linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rtc@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.14.2

When support for PMICs without compatibles was removed in
commit f736d2c0caa8 ("mfd: sec: Remove PMICs without compatibles"),
sec_regmap_config effectively became an orphan, because S5M8763X was
the only user left of it before removal, using the default: case of the
switch statement.

When s2dos05 and s2mpu05 support was added in commit bf231e5febcf
("mfd: sec-core: Add support for the Samsung s2dos05") and commit
ed33479b7beb ("mfd: sec: Add support for S2MPU05 PMIC"), they ended up
using that orphaned regmap_config in a non-obvious way due to the
default: case of the device type switch matching statement taking
effect again.

To make things more obvious, and to help the reader of this code while
reasoning about what the intention might be here, and to ensure future
additions to support new devices in this driver don't forget to add a
regmap config, add an explicit regmap config for these two devices, so
that we can ultimately remove the generic regmap config.

Note that this commit doesn't fix the issue that s2dos05_regmap_config
ands2mpu05_regmap_config really are incomplete, but I have no
documentation on them.

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 drivers/mfd/sec-i2c.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/mfd/sec-i2c.c b/drivers/mfd/sec-i2c.c
index ce1e5af9215a305fbb55157ae4e7bfb9aace86b8..3912baa5c2f918b7ad345e2bbbbe4daf2e49ca6d 100644
--- a/drivers/mfd/sec-i2c.c
+++ b/drivers/mfd/sec-i2c.c
@@ -66,6 +66,11 @@ static const struct regmap_config sec_regmap_config = {
 	.val_bits = 8,
 };
 
+static const struct regmap_config s2dos05_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+};
+
 static const struct regmap_config s2mpa01_regmap_config = {
 	.reg_bits = 8,
 	.val_bits = 8,
@@ -120,6 +125,11 @@ static const struct regmap_config s2mpu02_regmap_config = {
 	.cache_type = REGCACHE_FLAT,
 };
 
+static const struct regmap_config s2mpu05_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+};
+
 static const struct regmap_config s5m8767_regmap_config = {
 	.reg_bits = 8,
 	.val_bits = 8,
@@ -158,6 +168,9 @@ static int sec_pmic_i2c_probe(struct i2c_client *client)
 	device_type = (unsigned long)of_device_get_match_data(&client->dev);
 
 	switch (device_type) {
+	case S2DOS05:
+		regmap = &s2dos05_regmap_config;
+		break;
 	case S2MPA01:
 		regmap = &s2mpa01_regmap_config;
 		break;
@@ -176,6 +189,9 @@ static int sec_pmic_i2c_probe(struct i2c_client *client)
 	case S2MPU02:
 		regmap = &s2mpu02_regmap_config;
 		break;
+	case S2MPU05:
+		regmap = &s2mpu05_regmap_config;
+		break;
 	case S5M8767X:
 		regmap = &s5m8767_regmap_config;
 		break;

-- 
2.49.0.395.g12beb8f557-goog


