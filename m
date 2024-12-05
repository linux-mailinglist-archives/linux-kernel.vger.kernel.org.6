Return-Path: <linux-kernel+bounces-432675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40EC29E4E8D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 08:34:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0F082823AA
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 07:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 657C51C0DF3;
	Thu,  5 Dec 2024 07:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uoWM11E7"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E891B81C1
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 07:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733383999; cv=none; b=N14rH9iBQS6eeLvv0gnOnowjKjkCLvMIYdnYaHotmpvZeAiH1/OzRWi4MZk6AOP+Aec2a0fX9OjquE3C7htGB52b5g+Dfj5R9xezVmjQWcBhXXEGTQCDecc4xfjYCqwXpCZOE4cUHLAfE05vgX7Bn8G4unULDmI9Th1Yl/1soy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733383999; c=relaxed/simple;
	bh=kjL8CHF2jTNzGFGAJHP0ju9sbOFLoVxrk7RH0N2gvDA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NIdlY0NeUFkl+XpWPoz72BQ9+VaG/Z0yzSO61iJNg9U4McvEHfj+r3uZiv+cBKUOGmdgt4eQlcPsv4iL9+EvhhmqRuY9VWXb62ugQVF9uvCYvqoR2vIuS4T2e1WajR3b9S/LozWRfk0aMnzAtYbabZhEEwp9a8GYOxWHlzi0WCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uoWM11E7; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-aa53ebdf3caso103073666b.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 23:33:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733383995; x=1733988795; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XyAJZWh204Jg961AaAOy2+aPUgd1uUQOUoQ33ic9q34=;
        b=uoWM11E7/U8RpE1L8G4I7wfk5bojKhIWnB6k+eBrRGKLoF59RYKuP9R/pIL84j46+5
         l98GN2wMPvTts/0J43fDO2xdApr62/uxi0VBr/Qq2hQPzWQTq4NuWDGUA4GRFGC6yWgA
         iO14+UW6Gf6dtXDeQwHi76038kQbcgUc5/4i4it+yuottwjWLKavZwcy6cISV8unRflb
         JPXOx3ZdTuDizLMxHXKhLU6HayWcjo2jU3enxp6z7I7m974GuNXQVXqwKotwqYgeYDsa
         6PHjxCi+oNAh2UpSAoF+TXhQbGUmA2LO30Lyo//mqVjaG7HWrbu3OsW/j723Shg42+Fn
         K6gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733383995; x=1733988795;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XyAJZWh204Jg961AaAOy2+aPUgd1uUQOUoQ33ic9q34=;
        b=RGEaYijnDjo9YZp/ftRHlZhheHEatdLDUYPldlrYK4xdBuP020Fghdzuab45FsP4I8
         5ijPh9MgX9+Yt089JR3nTZyPX2NMNnaTDrXu+rc3zkz0yFVPj7WqU59WUPXqmMpxA94r
         HBb/IJ04ZKsx0+TOu8d3j3GA+b2HyoYK6kjtzpLS0UKKTOzdYB4pl0VtMiFwQdQfFm8y
         QigKkoG43OmnheyIl8sWyB1Sgb5617E2RJqdkiayWHssPGIkk9zt5eov61f2dSZj567E
         fPtdjSNnLaN68w+hWpyxbyeM2Ks7XIldLrJR/iSVwiyzJfZpBO03jOPFdxVoTu9K7vCh
         iang==
X-Forwarded-Encrypted: i=1; AJvYcCUUaQBhFJesP/mqeKz2q0ad82wBA2EfPOjEKiZyjxJllaC+72N1erFInEjpEtXbEZWvO9nLpfTehWby7qI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8r2vdk2lEzvckegZ6+a+KvMjDLw1Bwr2WPj2RM1tiGXv4mVWt
	tUYAKuS27Bi1J8yEhywzsdUXnPrznCjSDiDPCFnKBwkM7iVy2d48rKpuJ8pw0GquuJ/yDrRQEGi
	akEI=
X-Gm-Gg: ASbGncsIOxJRI4goqIqvWWZo2iHxbQRm1OHlMwrOqoksTYb6cXlUs6qamB9zMjJQgto
	WTB7M6IGd6kQeLAIdWitq2Mq5EPAIo6eACG0UyqQmTbUK84xePTaD2iuIqDasSk2kPiSlvgmLtP
	4bY9l69fkjm7GCdWsp9Ha6RBDohmDuXlRTRVva13KQuHQAZtlSwWlshiYcKRMgP1x1oac2++a07
	hxbaj4/l7rIuAZjClMMSwUw8Aeznwh61kNZ+FlwYsVz67ejjA4nPgALDwYc44W7pZ+reUAZOwPE
	J05/lLqNwrDSvX/LRkeqkOmAzqR7BAuFrA==
X-Google-Smtp-Source: AGHT+IFgMUVAtmrSp5P0iX/M3Y79q6BO4G1fv1/OVbYNaTflw37THP1LL7lHyOBI+yL2Eg8TsZ7fqQ==
X-Received: by 2002:a17:906:3d31:b0:aa4:9ab1:1985 with SMTP id a640c23a62f3a-aa60191ef15mr658488966b.51.1733383995541;
        Wed, 04 Dec 2024 23:33:15 -0800 (PST)
Received: from puffmais.c.googlers.com (64.227.90.34.bc.googleusercontent.com. [34.90.227.64])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa6260888casm53371766b.133.2024.12.04.23.33.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 23:33:15 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Thu, 05 Dec 2024 07:33:15 +0000
Subject: [PATCH v3 4/8] phy: exynos5-usbdrd: fix EDS distribution tuning
 (gs101)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241205-gs101-phy-lanes-orientation-phy-v3-4-32f721bed219@linaro.org>
References: <20241205-gs101-phy-lanes-orientation-phy-v3-0-32f721bed219@linaro.org>
In-Reply-To: <20241205-gs101-phy-lanes-orientation-phy-v3-0-32f721bed219@linaro.org>
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Sylwester Nawrocki <s.nawrocki@samsung.com>, 
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Will McVicker <willmcvicker@google.com>, Roy Luo <royluo@google.com>, 
 kernel-team@android.com, linux-phy@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.13.0

This code's intention is to configure lane0 and lane2 tunings, but for
lane2 there is a typo and it ends up tuning something else.

Fix the typo, as it doesn't appear to make sense to apply different
tunings for lane0 vs lane2.

The same typo appears to exist in the bootloader, hence we restore the
original value in the typo'd registers as well. This can be removed
once / if the bootloader is updated.

Note that this is incorrect in the downstream driver as well - the
values had been copied from there.

Reviewed-by: Peter Griffin <peter.griffin@linaro.org>
Tested-by: Peter Griffin <peter.griffin@linaro.org>
Signed-off-by: André Draszik <andre.draszik@linaro.org>

---
v2:
* collect tags
---
 drivers/phy/samsung/phy-exynos5-usbdrd.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/samsung/phy-exynos5-usbdrd.c b/drivers/phy/samsung/phy-exynos5-usbdrd.c
index ceae4b47cece..2a724d362c2d 100644
--- a/drivers/phy/samsung/phy-exynos5-usbdrd.c
+++ b/drivers/phy/samsung/phy-exynos5-usbdrd.c
@@ -1510,8 +1510,11 @@ static const struct exynos5_usbdrd_phy_tuning gs101_tunes_pipe3_preinit[] = {
 	PHY_TUNING_ENTRY_PMA(0x09e0, -1, 0x00),
 	PHY_TUNING_ENTRY_PMA(0x09e4, -1, 0x36),
 	PHY_TUNING_ENTRY_PMA(0x1e7c, -1, 0x06),
-	PHY_TUNING_ENTRY_PMA(0x1e90, -1, 0x00),
-	PHY_TUNING_ENTRY_PMA(0x1e94, -1, 0x36),
+	PHY_TUNING_ENTRY_PMA(0x19e0, -1, 0x00),
+	PHY_TUNING_ENTRY_PMA(0x19e4, -1, 0x36),
+	/* fix bootloader bug */
+	PHY_TUNING_ENTRY_PMA(0x1e90, -1, 0x02),
+	PHY_TUNING_ENTRY_PMA(0x1e94, -1, 0x0b),
 	/* improve LVCC */
 	PHY_TUNING_ENTRY_PMA(0x08f0, -1, 0x30),
 	PHY_TUNING_ENTRY_PMA(0x18f0, -1, 0x30),

-- 
2.47.0.338.g60cca15819-goog


