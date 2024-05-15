Return-Path: <linux-kernel+bounces-179668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A6E518C6310
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 10:52:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D18181C223E7
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 08:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FF1957CBA;
	Wed, 15 May 2024 08:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ehau8T/9"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B7224EB2C;
	Wed, 15 May 2024 08:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715763121; cv=none; b=dKE3XndicLvjYMs2vYF4/whqJmVRg7/gJlQvtwFgrruVO/Srajr5y+6Sxae7QZYA7pDQEWPdyH3fwbnKPl+RSKHmBOx2YkSCSVEiCCf0lQWj1TMqjD55u3DGiIuSt511wBVJKRubzH0d5bCQIptkuDXMmKln3J8rEu9PTfBjDno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715763121; c=relaxed/simple;
	bh=oTabfecnA5D6rgAYnH/cITmgBhG9NMBzhJBXZpNVt9U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YVuxA94TSepeaZNFn1dxD40WrTMUQlpidBqoKPsJIBKQGUtd9rOewiGCHxdMJesnmG7JLUj+WNZs34VeWm8Ds12Kgr5ad+eR/KBxtT3qxLNtyjIeew1GcH4LKCazUa/HVpdYCQ2xGmRQ4ebcmD1dEkXk/D3PpIqHitZdsafXBac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ehau8T/9; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3504f34a086so4123575f8f.1;
        Wed, 15 May 2024 01:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715763118; x=1716367918; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FPZC2tLZzoMwQUMQ/NsgDeMOgcmg6uOukKnCCk0Jz0k=;
        b=ehau8T/9aqP24xoVvkdyLfjY72TLtg2sqIZzglkBztULwZWHgZzx2ZX9M/7LDH4w57
         qEFXaLtHrygpeimU7vx8TbdMpcfF05SQ2Vpl0KarOlhN0MJaaq3Ei6otaT0oHVSWdyBY
         9KVOSW55K//WW8anXsLPfHE/+Afyfff1mUb0qohFPEE3hrl4dN9zKR93o2bk8bmd2eUs
         EgoGtMbhpVu8W+jBsMdwgNH7h3sy/PNTE/89ZtVt3mtCwmZDxm2HVrHnFXiO/j26N1ua
         mEYSVDxxGYwsfx0ORBZZK+D5nrU4TxMAFAFuasgTt9AQJbxQmr+6uDEQ6ZDja8FbIbi3
         WLww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715763118; x=1716367918;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FPZC2tLZzoMwQUMQ/NsgDeMOgcmg6uOukKnCCk0Jz0k=;
        b=ipS0YFsrR87xpxubAWnon6b7yJMwwOcntdZWJM1bu5XgBSg2JPHLfMBH7AnxG3bGed
         mftdAJ59nkkDMrOcJOwGQ9Q3Ph8dlH7m4Y09udH2VoK5Ety+ZlWx6YgbGLwkW/KODMWt
         bYS/3MWZGqA0GNcst9yCKjZ1Lmkg+N6R3D1A1ixx0ruDYxpIou8D+2ckWognBj+j6QKR
         A65D5cXRurSVG6K6Y82ElaG3MLy3iAB95Z0OHjGG+9wtxKzQgFFZdaSRBciwMWGAexT3
         SDJtYzeJBsI18391jEPy7swGBWkrAW/lkZFrcwcweHqwxX5vGwvPl59TdVoxka9XO6rW
         G8vQ==
X-Forwarded-Encrypted: i=1; AJvYcCWTTxbJ9NB3PddSdUakpR7fcyXr7FRl3T8r5DRnezRDomRhO5ptJCE8PpTrXm7fyXOG7GDfeMp+NmlKvkxOYI3bL5OwmevDxk14tEapfk72eMnyT9mP16XRsQiRIA20Jy5V6C/a3Q==
X-Gm-Message-State: AOJu0YyMdlxBiZwy8erGY2DCs607jDwMQHkCa4m97+eTkh9uveY406dt
	YCL1MBU+iAxSld6dyOcRIpcBlhKAppZnTwceQAIt92GD1zkTrty2hlADpw==
X-Google-Smtp-Source: AGHT+IG0SgB8ilO2X7vWlAcw0j1o8wIr1Ltsv+huCeg2g2aeWDyRUcSAab3sNsKxpfx63E9tmVfbbg==
X-Received: by 2002:adf:fc08:0:b0:34c:cca6:3d18 with SMTP id ffacd0b85a97d-3504aa66a33mr10191172f8f.68.1715763113485;
        Wed, 15 May 2024 01:51:53 -0700 (PDT)
Received: from ALPER-PC.. ([178.233.24.52])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502b8a8454sm15825034f8f.56.2024.05.15.01.51.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 01:51:53 -0700 (PDT)
From: Alper Nebi Yasak <alpernebiyasak@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Rob Herring <robh@kernel.org>,
	linux-clk@vger.kernel.org,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	linux-mediatek@lists.infradead.org,
	Michael Turquette <mturquette@baylibre.com>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Chen-Yu Tsai <wenst@chromium.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Stephen Boyd <sboyd@kernel.org>,
	devicetree@vger.kernel.org,
	Alper Nebi Yasak <alpernebiyasak@gmail.com>
Subject: [RESEND PATCH v2 2/2] arm64: dts: mediatek: mt8173: Fix timer 13 MHz clock description
Date: Wed, 15 May 2024 11:51:05 +0300
Message-ID: <20240515085137.2842804-2-alpernebiyasak@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240515085137.2842804-1-alpernebiyasak@gmail.com>
References: <20240515085137.2842804-1-alpernebiyasak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

A previous patch fixes an issue with the mt8173-infracfg clock driver
when working as a module, but has the side effect of skipping set up of
CLK_INFRA_CLK_13M in that case. This clock is used by the timer device.

Similar to the MT8183, MT8192, MT8195 and MT8186 cases [1], change the
input clock of the timer block a fixed factor divide-by-2 clock that
takes the 26 MHz oscillator as its input.

Also remove the RTC clock from the timer node while we're here. According
to commit 59311b19d7f63 ("clocksource/drivers/timer-mediatek: Add system
timer bindings") it is no longer used.

[1] https://lore.kernel.org/all/20221201084229.3464449-1-wenst@chromium.org/

Signed-off-by: Alper Nebi Yasak <alpernebiyasak@gmail.com>
---
Tested on a MT8173 Chromebook. But I'm not sure I understand all of
this, so review with a pinch of salt.

Changes in v2:
- Add this patch

 arch/arm64/boot/dts/mediatek/mt8173.dtsi | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
index 3458be7f7f61..809b379b6818 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
@@ -244,6 +244,15 @@ psci {
 		cpu_on	 = <0x84000003>;
 	};
 
+	clk13m: fixed-factor-clock-13m {
+		compatible = "fixed-factor-clock";
+		#clock-cells = <0>;
+		clocks = <&clk26m>;
+		clock-div = <2>;
+		clock-mult = <1>;
+		clock-output-names = "clk13m";
+	};
+
 	clk26m: oscillator0 {
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
@@ -530,8 +539,7 @@ timer: timer@10008000 {
 				     "mediatek,mt6577-timer";
 			reg = <0 0x10008000 0 0x1000>;
 			interrupts = <GIC_SPI 144 IRQ_TYPE_LEVEL_LOW>;
-			clocks = <&infracfg CLK_INFRA_CLK_13M>,
-				 <&topckgen CLK_TOP_RTC_SEL>;
+			clocks = <&clk13m>;
 		};
 
 		pwrap: pwrap@1000d000 {
-- 
2.43.0


