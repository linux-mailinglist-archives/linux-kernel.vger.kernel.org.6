Return-Path: <linux-kernel+bounces-410749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84EFB9CE0A6
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 14:51:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D6F6B26DDE
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 13:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55C281D5144;
	Fri, 15 Nov 2024 13:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="Ds2g0M2k"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE89518BBBB
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 13:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731678261; cv=none; b=VSkn6a3MP9koT3ale/YCT0h6v7S6bDK66dMX4IMB9SPNdMV9dCD+bNrnIhQW00MVbJMnXKFytF1sjiWtOTpyTx3mQwIbNjQi9UG5aYWLyFYrUmEDU6dIiF/knqYQzEEQcDOMMAd8ngLiu/a9A3J/jnDBhCqSTBNaGtv0Y1uDuqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731678261; c=relaxed/simple;
	bh=S2Sv5mBpK4tHtMNdjlKy/M9/mteRMMEFbbSdKa+H3rc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ec2qeFmS6qdvrgwYFC3j9b/qJ7INn55GSy5maiFk+11UW+JPd94fa5EjtRL5CcBOzqJ7/IODp3poLSb/1+cyN0sXzCQg1ESDqpA9vF0oCwO43pofLTmZYgnvEpNoKImEZoN93y+WGwFDENyFe7DxVzQSuX0a0wtHIDvGiCOvjHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=Ds2g0M2k; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3822b77da55so224664f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 05:44:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1731678258; x=1732283058; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s0uLg12EKex4iHuIi8vOX2y/fQEpOYkajMjZBOLCugw=;
        b=Ds2g0M2kEl/iCgIAxCmJpbfkdmoy8DeuUNP4HJegk4SQUfPtCSHbR7z2eJ+QqNoXFr
         QUHZRO/iLYw1EJJGb7zEM2B91h1cqNcgaJ21rIvowH037seJ1ITqCFMXJ1at+o2wUcW+
         h4TAay3csVp9ITKoZzcTeRnLRCI0f/ju5SAitk/RYHrz+OibiYNUwKrCvOw+YtRab2s+
         Ybl2E0FHuqFGhO+YK7Z730FAodYZoT5CTj0cIRk+7a2DPjPkPVQiIitCZkeceXBpNUNl
         1C7tPVj0kOYSwqRN908wqGM6QYECXYNmU/oJb0D1D+O+9EEchwRhmopgWmIor84At9Gj
         miQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731678258; x=1732283058;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s0uLg12EKex4iHuIi8vOX2y/fQEpOYkajMjZBOLCugw=;
        b=nKlrRFtyD90XP5CkjuB3A5mtdzotHsAn8aiz7R1UGHEC9btYNpVZDx6XibcYT9CZ35
         ySSOAcsYDu5uVCFx39QQYBX/PLCBylpwqZtQQ7SoIGbUMgZpvKeEQFDAem+t8Xjh0g37
         GFRvtlhuV62c3SSAhImQIW+4K4yAtZsc8X77/yEm0Zz9vocIEAfRVpd9mmFcKwmwOzUX
         11MVOUOV7J/UyVCb1hajSJjq03AO3cipPmfn2BLDMUEEww6jiSxR/SrAp98paqvZ4hmo
         /PfO5MUmQhW57hUDDEBEMSzfWDCaVjt5wGm6yubr0gpUcJObyYaa51ISkBxg8HXWZd2P
         aRWA==
X-Forwarded-Encrypted: i=1; AJvYcCXhnL55246aPqITfxNjMGJP9sMzhlxJhjgFUz2cECWYmgjGROvfOn2PPgwAOZWVBFLvfs/r0gzK1c9WX84=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsM9B0O/GIp09PMTaMcunod44i1M89CjIzQmTCELNRvxrglMF+
	cPwA/LlX4ZPyTBrm/Gq9nQ2npJemh0Jrw5O7n3cCm5sl0Cl1vFr9Kp9uIhHWrlY=
X-Google-Smtp-Source: AGHT+IHiipXpIQ3kdeL6mxdRYKqKlgX6st4dDiVc11WZAoqSFbfOF+B5thqjNH+k4/ftDJFh4qWzTA==
X-Received: by 2002:a05:6000:18a2:b0:381:f15a:e91 with SMTP id ffacd0b85a97d-38224e71e84mr2721167f8f.11.1731678258123;
        Fri, 15 Nov 2024 05:44:18 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3821ada3fc9sm4378016f8f.20.2024.11.15.05.44.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 05:44:17 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: geert+renesas@glider.be,
	magnus.damm@gmail.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	p.zabel@pengutronix.de,
	lethal@linux-sh.org,
	g.liakhovetski@gmx.de
Cc: linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-serial@vger.kernel.org,
	claudiu.beznea@tuxon.dev,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v3 4/8] arm64: dts: renesas: r9a08g045: Add the remaining SCIF interfaces
Date: Fri, 15 Nov 2024 15:43:57 +0200
Message-Id: <20241115134401.3893008-5-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241115134401.3893008-1-claudiu.beznea.uj@bp.renesas.com>
References: <20241115134401.3893008-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

The Renesas RZ/G3S SoC has 6 SCIF interfaces. SCIF0 is used as debug
console. Add the remaining ones.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v3:
- none

Changes in v2:
- none

 arch/arm64/boot/dts/renesas/r9a08g045.dtsi | 90 ++++++++++++++++++++++
 1 file changed, 90 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a08g045.dtsi b/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
index be8a0a768c65..5b15ff2482ab 100644
--- a/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
@@ -73,6 +73,96 @@ scif0: serial@1004b800 {
 			status = "disabled";
 		};
 
+		scif1: serial@1004bc00 {
+			compatible = "renesas,scif-r9a08g045", "renesas,scif-r9a07g044";
+			reg = <0 0x1004bc00 0 0x400>;
+			interrupts = <GIC_SPI 325 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 327 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 328 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 326 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 329 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 329 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "eri", "rxi", "txi",
+					  "bri", "dri", "tei";
+			clocks = <&cpg CPG_MOD R9A08G045_SCIF1_CLK_PCK>;
+			clock-names = "fck";
+			power-domains = <&cpg>;
+			resets = <&cpg R9A08G045_SCIF1_RST_SYSTEM_N>;
+			status = "disabled";
+		};
+
+		scif2: serial@1004c000 {
+			compatible = "renesas,scif-r9a08g045", "renesas,scif-r9a07g044";
+			reg = <0 0x1004c000 0 0x400>;
+			interrupts = <GIC_SPI 330 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 332 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 333 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 331 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 334 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 334 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "eri", "rxi", "txi",
+					  "bri", "dri", "tei";
+			clocks = <&cpg CPG_MOD R9A08G045_SCIF2_CLK_PCK>;
+			clock-names = "fck";
+			power-domains = <&cpg>;
+			resets = <&cpg R9A08G045_SCIF2_RST_SYSTEM_N>;
+			status = "disabled";
+		};
+
+		scif3: serial@1004c400 {
+			compatible = "renesas,scif-r9a08g045", "renesas,scif-r9a07g044";
+			reg = <0 0x1004c400 0 0x400>;
+			interrupts = <GIC_SPI 335 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 337 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 338 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 336 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 339 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 339 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "eri", "rxi", "txi",
+					  "bri", "dri", "tei";
+			clocks = <&cpg CPG_MOD R9A08G045_SCIF3_CLK_PCK>;
+			clock-names = "fck";
+			power-domains = <&cpg>;
+			resets = <&cpg R9A08G045_SCIF3_RST_SYSTEM_N>;
+			status = "disabled";
+		};
+
+		scif4: serial@1004c800 {
+			compatible = "renesas,scif-r9a08g045", "renesas,scif-r9a07g044";
+			reg = <0 0x1004c800 0 0x400>;
+			interrupts = <GIC_SPI 340 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 342 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 343 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 341 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 344 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 344 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "eri", "rxi", "txi",
+					  "bri", "dri", "tei";
+			clocks = <&cpg CPG_MOD R9A08G045_SCIF4_CLK_PCK>;
+			clock-names = "fck";
+			power-domains = <&cpg>;
+			resets = <&cpg R9A08G045_SCIF4_RST_SYSTEM_N>;
+			status = "disabled";
+		};
+
+		scif5: serial@1004e000 {
+			compatible = "renesas,scif-r9a08g045", "renesas,scif-r9a07g044";
+			reg = <0 0x1004e000 0 0x400>;
+			interrupts = <GIC_SPI 345 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 347 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 348 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 346 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 349 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 349 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "eri", "rxi", "txi",
+					  "bri", "dri", "tei";
+			clocks = <&cpg CPG_MOD R9A08G045_SCIF5_CLK_PCK>;
+			clock-names = "fck";
+			power-domains = <&cpg>;
+			resets = <&cpg R9A08G045_SCIF5_RST_SYSTEM_N>;
+			status = "disabled";
+		};
+
 		rtc: rtc@1004ec00 {
 			compatible = "renesas,r9a08g045-rtca3", "renesas,rz-rtca3";
 			reg = <0 0x1004ec00 0 0x400>;
-- 
2.39.2


