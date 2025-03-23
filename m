Return-Path: <linux-kernel+bounces-573037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAD13A6D223
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 23:45:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFC7416E54E
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 22:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B09B81F7910;
	Sun, 23 Mar 2025 22:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FjTp/XUQ"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88731EA7FD
	for <linux-kernel@vger.kernel.org>; Sun, 23 Mar 2025 22:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742769584; cv=none; b=sI41eTpUzPpaPm8p+rWJa2DwhgmrQ8c9R6hIkmVrISLJmMEfmYgIqEajAy+nli/DwHNJIwh7PO1XelHVn30l0JAzlbY1xYmXAJVDsA5IJia1qcZZNJqpBeLOTKR8JMCFaOZ95nOh20D/LMw8h9WCeX+cqknN8Dc1xxNUpUPALto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742769584; c=relaxed/simple;
	bh=/OXCrEd9LUPrpcKww+A0Kr+dM/K8OFFL8Z6qLEQS07c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ISj3eXPE/hf+djR5422w0p+R3+zGf2xDVs+wDa/bmreHVQFO3Eqr3REEJC7mNZgtnzi7Kr5e5x++Dx6ltgmDVwAxJTVBZuKZqD7mD2y8/bWZaUvj6g0BvUstJ9l8IjRzT3xl7TQCbnY2qWJzKSONY9/Ks7pq7OIO5GjdGVqyxp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FjTp/XUQ; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ac345bd8e13so673823766b.0
        for <linux-kernel@vger.kernel.org>; Sun, 23 Mar 2025 15:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742769578; x=1743374378; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MtwK6mOFDS+3HmyCw+zVaAjjy/x9ridjjJuIuDjP5y8=;
        b=FjTp/XUQBGfShXnTuX3CmHx6Ok4Dut8B0ibb0vSOCJNDotKOrZEqOLCTWulKfPQHMZ
         7hBe0vWxxKL+b3W85RBg4Y+aZAtHRK0VhQwukCv4lkIItO3e0FKC8hBNFTenmRTCJtKh
         iBPJ3q/PZv6i03YZku2cZpHUAp4bAY5M6UN2+2Rd/g0fbCWyLlDvXTELsHb5XNLPUNvy
         FrmYUCCX+qHaMXCut1EkE+K9pybz1E7KWJn6DDXDU3CrJkNtx1mob/HsKgZnYPOFTxEh
         jL8sXe1qYedjrbNwNBuWGJS+jXVyoKGwKq1b7bQk/W0FSLClmyE2lxT8bskJ1zyweLrW
         j9Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742769578; x=1743374378;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MtwK6mOFDS+3HmyCw+zVaAjjy/x9ridjjJuIuDjP5y8=;
        b=rGas5yE+9KSzM6s0pVtT3DL2sOkdfISub8VequPY0ggt4CG7S1ZBCi0YdfFjEDUlXl
         JuHMq8JI5WnxLIpHzysGvnvSL9i6n1VRQdL6bv7j2K5tmeks5+I23lv9nrEfwcHUFSpZ
         V7gX6VIq7r3r6hxIRX2j0OYgrHJhcPXuh0CUr+J1fGcrXynNuF60vbv4TSednbbDUDhF
         OPVKJJ0G8B3olCkNDEQc7TDFH8C1yYf3/ZRnSDsRECNxuiCLes0GzxOFhoRTv9wLviOG
         Cs0BRev4/egeAyBm5nwnXvCAuUtl9yQZ0GcCkoarsyygmJ82bHFV/qO08FT0dnjxeviz
         pB4Q==
X-Forwarded-Encrypted: i=1; AJvYcCXa+DabwfCSZM7yEYgLo/0UxSu/J8xczmL3ZTJYMVG1gmOkG7KtA52W1RU/ZAoN76Ua3Z/loETqpFHp5dg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNw8mexDvw2gFl0oPfSF0EaBdEhoELq3N9MVnzNfUf37o3NCK5
	5WKn5QpIKNqtXAOOd8rbEqkfj59hdn1nDHM9CwM7Zp3irp3d68rYVAuBQcb0Xyo=
X-Gm-Gg: ASbGncsGdsCMfkDd6va+jWZhDNn04ucxVvfBisIXZ/JzFwcpufpp31vA65FEX0svnCq
	/uJwLTMION7EHsT+x2F0JrMWo7UMAxLT5Bs2SkgI31B4rV1alQrapOlfBmj1Te6/51EeO0TlPNI
	hU/usuhSvxUVhmtFnsNHD++Ys9ela7uZYyjENC+KPMKeOBz7Fux+cjTog2YbPEUqY1m0iOHEPNZ
	y/ad7zoQhB+/7aLPujh+WSE9okckOZkOdWdNpbbOQVVHJLhtjxDYdkb4mXbtP9yJRam8+5Zfda4
	AgxwUbKNXdDErl9mJzh9EEj5ZJYWH3DOD2028xaCri2YC1O8fPE2WhG8dUR6abHjcIyXB0rVppV
	pfYP0PQ6gk3RSN/gekR78Nnmt8r8r
X-Google-Smtp-Source: AGHT+IGSiAkDAFqSZ3rMyd/nphhDlOTX1hDDy7CmBLGPyAROlgJin8tD1xxjQmFA6VfwByP2ficCYA==
X-Received: by 2002:a17:906:f5a3:b0:ac2:bb97:e56f with SMTP id a640c23a62f3a-ac3f2559a5emr850721866b.53.1742769577873;
        Sun, 23 Mar 2025 15:39:37 -0700 (PDT)
Received: from puffmais.c.googlers.com (8.239.204.35.bc.googleusercontent.com. [35.204.239.8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3ef86e44dsm559686666b.31.2025.03.23.15.39.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Mar 2025 15:39:37 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Sun, 23 Mar 2025 22:39:40 +0000
Subject: [PATCH 24/34] mfd: sec: convert to using MFD_CELL macros
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250323-s2mpg10-v1-24-d08943702707@linaro.org>
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

Use MFD_CELL macro helpers instead of open coding. This makes the code
a bit shorter and more obvious.

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 drivers/mfd/sec-common.c | 57 ++++++++++++++++++------------------------------
 1 file changed, 21 insertions(+), 36 deletions(-)

diff --git a/drivers/mfd/sec-common.c b/drivers/mfd/sec-common.c
index 5ebc77d7edacbc1b7a3debb9069bb489109d57d7..77298e92642021679ea1eb95d338907fec098aea 100644
--- a/drivers/mfd/sec-common.c
+++ b/drivers/mfd/sec-common.c
@@ -23,16 +23,13 @@
 #include "sec-core.h"
 
 static const struct mfd_cell s5m8767_devs[] = {
-	{ .name = "s5m8767-pmic", },
-	{ .name = "s5m-rtc", },
-	{
-		.name = "s5m8767-clk",
-		.of_compatible = "samsung,s5m8767-clk",
-	},
+	MFD_CELL_NAME("s5m8767-pmic"),
+	MFD_CELL_NAME("s5m-rtc"),
+	MFD_CELL_OF("s5m8767-clk", NULL, NULL, 0, 0, "samsung,s5m8767-clk"),
 };
 
 static const struct mfd_cell s2dos05_devs[] = {
-	{ .name = "s2dos05-regulator", },
+	MFD_CELL_NAME("s2dos05-regulator"),
 };
 
 static const struct mfd_cell s2mpg10_devs[] = {
@@ -44,53 +41,41 @@ static const struct mfd_cell s2mpg10_devs[] = {
 };
 
 static const struct mfd_cell s2mps11_devs[] = {
-	{ .name = "s2mps11-regulator", },
-	{ .name = "s2mps14-rtc", },
-	{
-		.name = "s2mps11-clk",
-		.of_compatible = "samsung,s2mps11-clk",
-	},
+	MFD_CELL_NAME("s2mps11-regulator"),
+	MFD_CELL_NAME("s2mps14-rtc"),
+	MFD_CELL_OF("s2mps11-clk", NULL, NULL, 0, 0, "samsung,s2mps11-clk"),
 };
 
 static const struct mfd_cell s2mps13_devs[] = {
-	{ .name = "s2mps13-regulator", },
-	{ .name = "s2mps13-rtc", },
-	{
-		.name = "s2mps13-clk",
-		.of_compatible = "samsung,s2mps13-clk",
-	},
+	MFD_CELL_NAME("s2mps13-regulator"),
+	MFD_CELL_NAME("s2mps13-rtc"),
+	MFD_CELL_OF("s2mps13-clk", NULL, NULL, 0, 0, "samsung,s2mps13-clk"),
 };
 
 static const struct mfd_cell s2mps14_devs[] = {
-	{ .name = "s2mps14-regulator", },
-	{ .name = "s2mps14-rtc", },
-	{
-		.name = "s2mps14-clk",
-		.of_compatible = "samsung,s2mps14-clk",
-	},
+	MFD_CELL_NAME("s2mps14-regulator"),
+	MFD_CELL_NAME("s2mps14-rtc"),
+	MFD_CELL_OF("s2mps14-clk", NULL, NULL, 0, 0, "samsung,s2mps14-clk"),
 };
 
 static const struct mfd_cell s2mps15_devs[] = {
-	{ .name = "s2mps15-regulator", },
-	{ .name = "s2mps15-rtc", },
-	{
-		.name = "s2mps13-clk",
-		.of_compatible = "samsung,s2mps13-clk",
-	},
+	MFD_CELL_NAME("s2mps15-regulator"),
+	MFD_CELL_NAME("s2mps15-rtc"),
+	MFD_CELL_OF("s2mps13-clk", NULL, NULL, 0, 0, "samsung,s2mps13-clk"),
 };
 
 static const struct mfd_cell s2mpa01_devs[] = {
-	{ .name = "s2mpa01-pmic", },
-	{ .name = "s2mps14-rtc", },
+	MFD_CELL_NAME("s2mpa01-pmic"),
+	MFD_CELL_NAME("s2mps14-rtc"),
 };
 
 static const struct mfd_cell s2mpu02_devs[] = {
-	{ .name = "s2mpu02-regulator", },
+	MFD_CELL_NAME("s2mpu02-regulator"),
 };
 
 static const struct mfd_cell s2mpu05_devs[] = {
-	{ .name = "s2mpu05-regulator", },
-	{ .name = "s2mps15-rtc", },
+	MFD_CELL_NAME("s2mpu05-regulator"),
+	MFD_CELL_NAME("s2mps15-rtc"),
 };
 
 static void sec_pmic_dump_rev(struct sec_pmic_dev *sec_pmic)

-- 
2.49.0.395.g12beb8f557-goog


