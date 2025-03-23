Return-Path: <linux-kernel+bounces-573049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3658BA6D230
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 23:46:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 033D21896115
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 22:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B5C91FBCA1;
	Sun, 23 Mar 2025 22:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sg/BoZUo"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159DB1E9B28
	for <linux-kernel@vger.kernel.org>; Sun, 23 Mar 2025 22:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742769592; cv=none; b=VmhqCgwsmcKY+GmKT0N9Cqql2ZUv4TNnep8mdMViQpXCAk4nS44fY+TqOH9JaOfK+w+itkH5AhpYLZCS4piGfy+1fl+oZaNbkXToJuGsrHd1PssY4KIC+8zMygltvZiz7Xi3WLXJU4QBI2u3jR/Q/F41UpAq5ynBQhY7w3A7hSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742769592; c=relaxed/simple;
	bh=H9PnjiGdaPmfWukTzjrtFxLU+96UeMWEkuYWR2ErP7k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gBAHqkpyvwt94hXaSE7E8LspzRJ4+7/6uar6fzZNO8aCkh/zkDgwCSu17Xy9JDk+zsSIcdt31gMZE6ozOEt5Y1g2+sZIycBfyPmX/1p+rhpNGRmTFjOJFrGIv7yUhk+taOr/+olFepVDbQg5DRZBz8fa34RBZHMVkdu1AC3V+WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sg/BoZUo; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-aaecf50578eso713685566b.2
        for <linux-kernel@vger.kernel.org>; Sun, 23 Mar 2025 15:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742769583; x=1743374383; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+9zuZxWNg3rbrJTairaqhANzxAqu72T6zzPhxq7UOmE=;
        b=sg/BoZUoO1vvhUz/iyXWR/MXNTeBGwofC6UNpxJQrUNNiw4KK7eE2KsY4y7RmEDrgc
         CJDWqICOsVStbXFUlcoIpWqaRqmNNCv3c12rcDsZ/VNGnK6VtAlsbYR3wNoU3zuaC46C
         fwz7FHf6mwR9L+LRktEj+XD8Vfg6qal8O9QomUJ2Tt536IPiTrdB1ffkNYE9bqYyKMlc
         tnWoNjR9gAQhM8yrQ9ooN+jhbYkfFc/NTsvVLHYDekiMBbo3Lw/btgm3ML3LS3PXwz/t
         kOBqxBnV5cVs/bHhMlwVsJk84DAfki4LbUB/W/IVthCI0pHuv19sX6FD39us8LONlxYz
         8GjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742769583; x=1743374383;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+9zuZxWNg3rbrJTairaqhANzxAqu72T6zzPhxq7UOmE=;
        b=NvBy8nthfZJ0ExI9zL8NXrI5RMeK/pP8qjj7ukz/WGIQo1jwmvOw58zCU2k972KFzb
         7UivbB1feOBG//tRRQ5Ya9G2fJFJffcyCFtIcFPZ20E+UFlNlcH7Qa9IuZY6WfU/F0w/
         aDvL6AVNxBNYYTkiVw+doPzJpYBQgQNhXOmIixQu4+ko0TrHp9DV2iAZ1OTqzFj4Ymms
         5woRwhrndCy7Fg1w0DZ7G41tBLghwSUaNRanIv30QnRUeBrlDRDaBf7yiYmDWPyp/SRN
         GcDBdWcTwFWNICFY5WteDpQeYo4vmfmp8ii8GuVzycgwgoB3pKnUvITcp7JJext/IA2K
         AEqQ==
X-Forwarded-Encrypted: i=1; AJvYcCVstsE4kSRp/C+Bd2yEcPTHwLJf48MxMrgP1IwcRFnPmAoZ167ugKa3OaqMDBnMVAYSX8E/zYlIkMtiyOo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywp4onr6Zra7edIgcw/RvDFE2nZcXeicU7TDaYC8Act3yrgDpwD
	wf1mQ2sD0mvuBQHKFxKRcIjP4ETS8bl3UOcC2M7Bu+GR9UUOG0O9RDAfZvZ2DH8=
X-Gm-Gg: ASbGncscI5L2BYGICwi5z2CnU1hYtLOh5aHfnCsHmMkNbWe/fXiulArdbw4uNIWY3Mt
	WVu1xCTb5/YtD1T7MfFjfgetdKfx49vFbyiHpcCVgjl6AO3yXQIVbpytPbPThJODXQR9ezSM5xS
	9+UDKwBYmvIo5NlRRfv0n6RTdpZnSKJNGroVK+IFGyTogHdXDMLxeeeVnrbIH34h04xSpRk222E
	RfqcPdMb72jIoqYOPFxUY9luWwqSMJM+D4SQC1l5yNQt5cIeoqshSmWfbbE+hx4lr1Gbis7bJSf
	/EBcgU1IgwrNTm6SsapSHilpUjgkiHinJHxdU7rATHtCXGZxUMmQ1zU+HcpX45yTW0xJOm19y/k
	ItycAdnnG+T764SAn0Gf9JP4kDtAjvTLfqdxyMYw=
X-Google-Smtp-Source: AGHT+IFs4xHKZtefwGlVOQ1hTfmO2hUQ+8e+EVgI4+xRTbfzM8/S+AZdGH6X4/sL+XMu2751zvkyBQ==
X-Received: by 2002:a17:907:7f0d:b0:ac3:3cfc:a59c with SMTP id a640c23a62f3a-ac3f20b9b10mr1154328366b.11.1742769583314;
        Sun, 23 Mar 2025 15:39:43 -0700 (PDT)
Received: from puffmais.c.googlers.com (8.239.204.35.bc.googleusercontent.com. [35.204.239.8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3ef86e44dsm559686666b.31.2025.03.23.15.39.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Mar 2025 15:39:42 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Sun, 23 Mar 2025 22:39:49 +0000
Subject: [PATCH 33/34] rtc: s5m: replace open-coded read/modify/write
 registers with regmap helpers
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250323-s2mpg10-v1-33-d08943702707@linaro.org>
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

Instead of the open-coded read/modify/write sequence, we can simply use
the regmap helpers regmap_set_bits() and regmap_update_bits()
respectively.

This makes the code easier to read, and avoids extra works in case the
underlying bus supports updating bits via
struct regmap_bus::reg_update_bits() directly (which is the case for
S2MPG10 on gs101 where this driver communicates via ACPM).

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 drivers/rtc/rtc-s5m.c | 28 +++++++---------------------
 1 file changed, 7 insertions(+), 21 deletions(-)

diff --git a/drivers/rtc/rtc-s5m.c b/drivers/rtc/rtc-s5m.c
index fb65a8e439d72d9070751c00f5826a403ac0b416..2ad01fb3bc72fe9259a8307584c9cf3a839bd492 100644
--- a/drivers/rtc/rtc-s5m.c
+++ b/drivers/rtc/rtc-s5m.c
@@ -279,17 +279,9 @@ static int s5m_check_pending_alarm_interrupt(struct s5m_rtc_info *info,
 static int s5m8767_rtc_set_time_reg(struct s5m_rtc_info *info)
 {
 	int ret;
-	unsigned int data;
-
-	ret = regmap_read(info->regmap, info->regs->udr_update, &data);
-	if (ret < 0) {
-		dev_err(info->dev, "failed to read update reg(%d)\n", ret);
-		return ret;
-	}
-
-	data |= info->regs->write_time_udr_mask;
 
-	ret = regmap_write(info->regmap, info->regs->udr_update, data);
+	ret = regmap_set_bits(info->regmap, info->regs->udr_update,
+			      info->regs->write_time_udr_mask);
 	if (ret < 0) {
 		dev_err(info->dev, "failed to write update reg(%d)\n", ret);
 		return ret;
@@ -303,19 +295,12 @@ static int s5m8767_rtc_set_time_reg(struct s5m_rtc_info *info)
 static int s5m8767_rtc_set_alarm_reg(struct s5m_rtc_info *info)
 {
 	int ret;
-	unsigned int data;
-
-	ret = regmap_read(info->regmap, info->regs->udr_update, &data);
-	if (ret < 0) {
-		dev_err(info->dev, "%s: fail to read update reg(%d)\n",
-			__func__, ret);
-		return ret;
-	}
+	unsigned int udr_mask;
 
-	data |= info->regs->write_alarm_udr_mask;
+	udr_mask = info->regs->write_alarm_udr_mask;
 	switch (info->device_type) {
 	case S5M8767X:
-		data &= ~S5M_RTC_TIME_EN_MASK;
+		udr_mask |= S5M_RTC_TIME_EN_MASK;
 		break;
 	case S2MPG10:
 	case S2MPS15X:
@@ -327,7 +312,8 @@ static int s5m8767_rtc_set_alarm_reg(struct s5m_rtc_info *info)
 		return -EINVAL;
 	}
 
-	ret = regmap_write(info->regmap, info->regs->udr_update, data);
+	ret = regmap_update_bits(info->regmap, info->regs->udr_update,
+				 udr_mask, info->regs->write_alarm_udr_mask);
 	if (ret < 0) {
 		dev_err(info->dev, "%s: fail to write update reg(%d)\n",
 			__func__, ret);

-- 
2.49.0.395.g12beb8f557-goog


