Return-Path: <linux-kernel+bounces-391997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C950D9B8E63
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 11:00:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11DFDB227AE
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 09:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F36119D891;
	Fri,  1 Nov 2024 09:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="IPfmRM/w"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4150919B581
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 09:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730455074; cv=none; b=rUi3c7yxmTDtOKsik9+s317wwANx49yc6Y+iLWDsYkt5EGNqpkjyuiw6qPqa4bhzZoT9bqNYXGs2ZhuhJJIK0imPeDKVvTz0k9aOlZjF4LbEzruncZnCsfm8ViWQFR/BB+cz+FIF9fwWvz5i05rZEeVUkH8m2vw+/6aizIyY0Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730455074; c=relaxed/simple;
	bh=yYP16zEPx37dhW8+zaOISLjIJmbRtcBg1hLt5dlVY3E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ITjFX4c52TdXk/bu/hP8sfsycmcKSHTbqoL01Rlw6YZopv9/tyecAJs2zJGYgwwqHJOVDU6i6+D1phzsc8BHGTVKZib/vG0mwINem6KFZkvMUvoI0F3sEMClezY295AZH8WLp84veCjsWbGIphiKA2K1Uy4dzw0gQPh917E0F1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=IPfmRM/w; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a9a16b310f5so264875766b.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 02:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1730455071; x=1731059871; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tfW7W38u73oXDY58ExSVjQCRIYrMmZQTfpbBo08M7pQ=;
        b=IPfmRM/wztKMJUm8ACyqj3S6WT9GBWFyM/hsajp6AbUFzqhNIN19B1zb3MDDlrWVNG
         0BiagiavrNGcicUaNdAOMObAIe4Kw6ABB4Jzw5yjVIsut0uYaVBKD80E4fGRoDO3E+hN
         ZbkdFFcy43kwDVCjTxNmHdd1BE/4EE0NHxBQJXGGmtQRmozzO7q1J131KYDHiw90K30D
         zr7xsq5YUslit+4cIoyYa706URXy/zyJmaDntaNyV1Rhnee/dSoPWHBJP/9akFAS9kBw
         a4deFpwE+QXzaVT3aV3AybTqmRFtPSUYTW6G4zh664bjvwwxJZOlnlIWNq/ECrnjtdH8
         o6OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730455071; x=1731059871;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tfW7W38u73oXDY58ExSVjQCRIYrMmZQTfpbBo08M7pQ=;
        b=IPUc9J8ZslPEJlzj2BXlSklr1h/mHvBU68NOxEIntuF/X3tUBb9THyxGt6EGik+g09
         +Z7Y/Xh7AUrE5q9xOF+W59xOA82NljioMPOuSfNitNjASw2Z+69KFrxrcAoZxoUs0xng
         Un9bK1UG5GLDoEBbruHWUlh9kHs+oaE7x0sZcVjyQY2NO1zzvdIvFzCk0/pIUeNBW6nY
         QDIkPrOgTRDD8obnN0bn9duVmlBa7lIl9UdTQBuIL7UWvcn2PYwWXPZaf3PH+nPeR7g6
         Ovpandwkp2UaLtnNuG4Gua+S4M0JsIBNzfJIWNqLBCVN1P0jQd6J4GcFyXhaV1eEQvp4
         qQhw==
X-Forwarded-Encrypted: i=1; AJvYcCUIEhs0rXHMu/+UyfXJnAgtSVFpr7WjTDMnSpU1KeVH11u5UA4DoLrHbUXshb01kJ5YRToktcWV24uaa9A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOua+RCVBzJbNLnHfDvfiumo0niHpCfjHtbGMBzYSv1MrCjspE
	81kru2Lc0vKBwSjQiDn9K9XckbLSX93Q24bkvCbR45VwuAOF+cjTDugxkHwQK4Q=
X-Google-Smtp-Source: AGHT+IFE0JHqlkVDmb2/TxlqXR6484r4+5y4byueSe80U+33dxBrQC5ZdYOn6F1eecNFW0u/e9w1Bw==
X-Received: by 2002:a17:907:97ce:b0:a9a:e91:68c5 with SMTP id a640c23a62f3a-a9e5093efccmr607271566b.33.1730455070606;
        Fri, 01 Nov 2024 02:57:50 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.190])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ceac7c8d87sm1364136a12.76.2024.11.01.02.57.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 02:57:50 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: geert+renesas@glider.be,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	alexandre.belloni@bootlin.com,
	magnus.damm@gmail.com,
	p.zabel@pengutronix.de
Cc: linux-renesas-soc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rtc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	claudiu.beznea@tuxon.dev,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v6 6/9] arm64: dts: renesas: r9a08g045: Add RTC node
Date: Fri,  1 Nov 2024 11:57:17 +0200
Message-Id: <20241101095720.2247815-7-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241101095720.2247815-1-claudiu.beznea.uj@bp.renesas.com>
References: <20241101095720.2247815-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Add the DT node for the RTC IP available on the Renesas RZ/G3S SoC.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v6:
- none

Changes in v5:
- collected tags

Changes in v4:
- dropped the assigned-clocks, assigned-clock-parents properties as they
  fit better on vbattb node
- moved the RTC close to serial node for ordering

Changes in v3:
- added CPG clock, power domain, reset
- and assigned-clocks, assigned-clock-parents to configure the
  VBATTCLK
- included dt-bindings/clock/r9a08g045-vbattb.h

Changes in v2:
- updated compatibles


 arch/arm64/boot/dts/renesas/r9a08g045.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a08g045.dtsi b/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
index a1d5084b074a..be8a0a768c65 100644
--- a/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
@@ -7,6 +7,7 @@
 
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/clock/r9a08g045-cpg.h>
+#include <dt-bindings/clock/renesas,r9a08g045-vbattb.h>
 
 / {
 	compatible = "renesas,r9a08g045";
@@ -72,6 +73,20 @@ scif0: serial@1004b800 {
 			status = "disabled";
 		};
 
+		rtc: rtc@1004ec00 {
+			compatible = "renesas,r9a08g045-rtca3", "renesas,rz-rtca3";
+			reg = <0 0x1004ec00 0 0x400>;
+			interrupts = <GIC_SPI 315 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 316 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 317 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "alarm", "period", "carry";
+			clocks = <&cpg CPG_MOD R9A08G045_VBAT_BCLK>, <&vbattb VBATTB_VBATTCLK>;
+			clock-names = "bus", "counter";
+			power-domains = <&cpg>;
+			resets = <&cpg R9A08G045_VBAT_BRESETN>;
+			status = "disabled";
+		};
+
 		vbattb: clock-controller@1005c000 {
 			compatible = "renesas,r9a08g045-vbattb";
 			reg = <0 0x1005c000 0 0x1000>;
-- 
2.39.2


