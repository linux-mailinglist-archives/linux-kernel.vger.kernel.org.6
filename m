Return-Path: <linux-kernel+bounces-212196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EB5F905C9A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 22:12:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25ECD1F24DAA
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 20:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B4528564B;
	Wed, 12 Jun 2024 20:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RCMfncVk"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D0B84E00;
	Wed, 12 Jun 2024 20:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718223145; cv=none; b=da5e9h+oXrkqllK3jTZcsUxqSknUFdJ0tkskEXXePZ5v2L0PO0FXp9IN9cgLUU1vr1mgwRTeGjE5P40YlUj8ixzjPo0xVi7bFB4S+HwOwFT50j3jTL9yiYEcpyWv7MNnd4zo7eHnLjsN5h67U+9mod2l3nwpXrB0tGkW+wsTf+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718223145; c=relaxed/simple;
	bh=06B2cVIEP81ZIxw3Ms9AJZjrUo3jJoRx+K93bSBW5sc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pLBFIR6zuAfMkjInDzY9UJrmQWrKZdv5LelVAihjE9jf4UUJFm+WZw0cDUcoEYamgKVF2Osq30S3cjSwjxBmi7YfkyXxq9+LyqwZ7JB073Hd1vsxxua1iIc6X6yvWWZv6yVqdFe7Ardoe8CXSjabHI3rVGeGFuvTO+AQL+FOTqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RCMfncVk; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4217c7eb6b4so3240985e9.2;
        Wed, 12 Jun 2024 13:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718223142; x=1718827942; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L57epYYY3nvfIXWp0G2IWvPKM4CJXDaQCqlGAc5Qu2E=;
        b=RCMfncVkkWDe2NO7YAVTjzyvcqQffSIpS7M+PpN8ubxr3CdF+PYdXhzS8mRO3jLexx
         CHFkLHeL26zaLiIUzjKMBR+zfxrey7w2z+7DwsIAV525lJRf5+WijFBZKN9/egfy/pal
         l0+3RQl6gfC8v2RYE6wVLX85uDUofPFncMERMQTrHxKltfqOTSbSmc5N66UO5KGAqql7
         55xuZ8Ozo2DVW3MuuWrYc8vI2hBzgMbKwuBiHc2XPEbzi1y08BzFXGe8QJZ27A8OwLXZ
         H5PvIhCU3DA3dIRtsnHSIGhKPyQ9/Z/F/ptszIAdx8g4HMUXGM9MZJrL2FweC29QNBQP
         gf9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718223142; x=1718827942;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L57epYYY3nvfIXWp0G2IWvPKM4CJXDaQCqlGAc5Qu2E=;
        b=Q9qs8T4I2NuM1tS08MEqd2XP6Ita2tHyLaZFUnA4kEvhcIEawwoe0HMEQyeYWcV8tg
         Pvc/ia2JprcpJm9vrEyFG0i8/x/JAbmvCJPB3aVjK6SdOrrVxpUt1RRofr7uZtcfieXu
         VwND6Xjgvf/AByj/cWwH2eFju74cKqiTY1qzz7ikW79ZpLiH6AhnH47jtJye9Adaqra8
         8dd3xYve2B1clRt/IhgLzY3NhsdQmsDhPV19ckxc56U+lHHC+GwkjzgsVmmMf8cnTbfY
         i75Vl86aMGhFOoYUpsEu3QQLc3CEUUTOH2+Zvi7AdB3VfgUw70MJreAamAQSJ7hf9ZZO
         D7IQ==
X-Forwarded-Encrypted: i=1; AJvYcCV3pZFZy5NgpuqB/gHxeUiyErI8z6YoQ+kwQ0EvVhnkUOf2SIDz9X7+6L6y7LyB6HgDYssVcyYvj3Ijp6jsE3JZqCeQA+p1XYAUKVW/gPNtfa/EIInB6SvrYdHohIRDfV0xgJXTRQ==
X-Gm-Message-State: AOJu0Yy3LNRik/p5Syrf35WyvHOmv8xAzahrwHb5qN9sZz/04VyP2HgV
	YedQOYutiwqNpds7makPjt+guu1vJtxSXzWrNyn8Sf+kT6cMvi5U
X-Google-Smtp-Source: AGHT+IGILVEjmCSzS67jRWgdAuX1q4I+JSG4Yhl0SPgZJBIukT+wdXYEk+gjwPucjvRhmaopkGKifg==
X-Received: by 2002:a05:600c:470b:b0:422:52c3:7fe0 with SMTP id 5b1f17b1804b1-422864aef80mr28544245e9.22.1718223142436;
        Wed, 12 Jun 2024 13:12:22 -0700 (PDT)
Received: from ALPER-PC.. ([178.233.24.52])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42286fe7670sm38110205e9.6.2024.06.12.13.12.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 13:12:21 -0700 (PDT)
From: Alper Nebi Yasak <alpernebiyasak@gmail.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-mediatek@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	devicetree@vger.kernel.org,
	Michael Turquette <mturquette@baylibre.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	Chen-Yu Tsai <wenst@chromium.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	linux-clk@vger.kernel.org,
	Alper Nebi Yasak <alpernebiyasak@gmail.com>
Subject: [PATCH RESEND v2 2/2] arm64: dts: mediatek: mt8173: Fix timer 13 MHz clock description
Date: Wed, 12 Jun 2024 23:11:01 +0300
Message-ID: <20240612201211.91683-2-alpernebiyasak@gmail.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240612201211.91683-1-alpernebiyasak@gmail.com>
References: <20240612201211.91683-1-alpernebiyasak@gmail.com>
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
2.45.1


