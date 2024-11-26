Return-Path: <linux-kernel+bounces-422079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 286B39D9441
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 10:24:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB0B5283A01
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 09:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E8A21D5ADB;
	Tue, 26 Nov 2024 09:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="ghPR0LO2"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809F21D54D8
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 09:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732612889; cv=none; b=f1BfVDeMDs7LOCxDml0Atac6c7QBsgSWTmPC9WLQBtbYAApb9Oe4jli1SCpQCIOyHc2s5Edx3wcl1oqU3L5hvwUlyGfPk9qSbume20Ds/OPNb6RbZsgqZtHU1QhI0OThtEOei27Zm6MNa9XsA0mNN7OEPuFery42et4EoljTJ7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732612889; c=relaxed/simple;
	bh=pvmXne3/GLaL56C23pmxfpzVcVguFUnVL4SSDyD6KWQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RuUWj8NJEPjfC1Sfoqcjr8hb0bNXFle352fzPYuMI2U3XPJtNyuwb4P6XbFFLj7TDKSr7Pee5K1rI5Dc8U+zC1hlN3VrT01m1wxgfzGkWUejTaAZSBsVICV2o95yadb39yNk+hYv4PuBggUDvrIXgiwpKB4MAE8VgtYJL8p35qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=ghPR0LO2; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-382610c7116so2821227f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 01:21:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1732612886; x=1733217686; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E4M5g4cOSJdZAIQtrKw1Bn/YMzw7ikJ/cpvkoOSwCx8=;
        b=ghPR0LO2pC6YkkfzaTqUNsLDZUcp9bERyEyb9YOZEMdOiWVbT9ZUFiF4YmBxMB+D0h
         Oub/hGH9PTI18stx8oUicM9Zv//kTIHFTaJtBABe/I3aRfGmPoLTemuM3YvtiS+7KenF
         4etSN6/T1d+xHmpNRl2gQ2wJflLDShKIhTM8DEsq3IEBl+VW2rNNIJ6/mP5pXZ7lH5k3
         lWbWjKdZZaU3XAhS2/3vObsoLDHHN/fZ+64m0/8cHOgfGUhrCaE+r/ZFB9lpkc6CP6c0
         OGv6geeuXZTSrY93GlZvKwdyTt3Hn4StKrUnGsFGMOsPjmoCujOlRkDXis81DAb8yqy0
         s1TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732612886; x=1733217686;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E4M5g4cOSJdZAIQtrKw1Bn/YMzw7ikJ/cpvkoOSwCx8=;
        b=vBkgh/I5r2uljVEy0moSLgt1v8nRFm2HSA5WVN9Q2Lr/PfA23OCWRi+QrghYAd1yaz
         D3suZDQXWT6pQLsJ7GO7FQG4lv8+0UN0LRBFXEUMEcs0RKHYzinCgJXPKR27+GH0Igzy
         l0pkf0hOyy1Jvdb4z5Tq0b/bKBmg8A6/NLZoW7iz6g+02Q4CHue6/FoFeffKAczX1BOU
         Y0hqdzDMjqrOjEaQYjYNEu3aCMmS9ICp3dsNZ6A/Qps/kx17Sx2lzMYyupceo7njFcxb
         ujf4i0BFaWegz16/B0UV7/kNgnGDS+s6JW0xkb2FGB7rgZJRabM/8hcagpxZmnPRgtTG
         yQ9Q==
X-Forwarded-Encrypted: i=1; AJvYcCVjBFLobP8AwJ3jMB457KSAHLbg8d3qOET5yFfVT1EgboDco+rWmi2yRzA3HxQRC6PSPPeoddCZBVjTITU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZYMwVlZilVHNgmqdgFRS/70k1R0oWJC9/DqODR9SpxY7cCXnI
	DRLCob8WMolWtbPHfG/kp5pv1C5xMRZFtHCFFQJQZkAOyTSGX8OtzKIOvbDcssM=
X-Gm-Gg: ASbGnctRXmRtg6f0OZuapS5W+tfgJMzVlQllrfWVK7xs9jPAf+rFuPV8T9L4YobpBPA
	/0F6ZeTRUkLFA/JaX2P05dPTJPaO5L0fkeX6nlI2S16sa0TPeAi3eLFq409Pg/tNKZcJP69GYZd
	1vmw9MgbKACyLonba6fJNUANv6v5Te3TbUbu9w/rNlMwI/bVqMNiuxhOkTo6BvlyGGUQ2hL4JSW
	YrZYrFlOq5HWuevKKkDoN58lTXXDbuK505oJI3IisEfSeqBCgLn+PHgOhB4GTrxXJfLSNqm8AA/
	v84=
X-Google-Smtp-Source: AGHT+IFFCuS7xBS3otNkuGr2IzoMyH/CTvsuJMT+O34OiuKVD91ks7D0BrVopsaLaBF4QZUasDuXXQ==
X-Received: by 2002:a05:6000:18ac:b0:37c:d1bc:2666 with SMTP id ffacd0b85a97d-38260b502dcmr12951812f8f.4.1732612885919;
        Tue, 26 Nov 2024 01:21:25 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825fbc3a47sm13027694f8f.73.2024.11.26.01.21.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 01:21:25 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: vkoul@kernel.org,
	kishon@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	p.zabel@pengutronix.de,
	geert+renesas@glider.be,
	magnus.damm@gmail.com,
	gregkh@linuxfoundation.org,
	yoshihiro.shimoda.uh@renesas.com,
	christophe.jaillet@wanadoo.fr
Cc: linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-usb@vger.kernel.org,
	claudiu.beznea@tuxon.dev,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v2 12/15] arm64: dts: renesas: Add #renesas,sysc-signal-cells to system controller node
Date: Tue, 26 Nov 2024 11:20:47 +0200
Message-Id: <20241126092050.1825607-13-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241126092050.1825607-1-claudiu.beznea.uj@bp.renesas.com>
References: <20241126092050.1825607-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

The system controller on RZ/G3S can provide control access to its signals.
To enable this, add the #renesas,sysc-signal-cells DT property. Consumers
can use the renesas,sysc-signal DT property to reference the specific SYSC
signal that needs to be controlled.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v2:
- none; this patch is new


 arch/arm64/boot/dts/renesas/r9a07g043.dtsi | 3 ++-
 arch/arm64/boot/dts/renesas/r9a07g044.dtsi | 3 ++-
 arch/arm64/boot/dts/renesas/r9a07g054.dtsi | 3 ++-
 arch/arm64/boot/dts/renesas/r9a08g045.dtsi | 3 ++-
 4 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r9a07g043.dtsi b/arch/arm64/boot/dts/renesas/r9a07g043.dtsi
index 593c66b27ad1..2ebb951e6a39 100644
--- a/arch/arm64/boot/dts/renesas/r9a07g043.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a07g043.dtsi
@@ -585,8 +585,9 @@ cpg: clock-controller@11010000 {
 		};
 
 		sysc: system-controller@11020000 {
-			compatible = "renesas,r9a07g043-sysc";
+			compatible = "renesas,r9a07g043-sysc", "syscon";
 			reg = <0 0x11020000 0 0x10000>;
+			#renesas,sysc-signal-cells = <2>;
 			status = "disabled";
 		};
 
diff --git a/arch/arm64/boot/dts/renesas/r9a07g044.dtsi b/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
index 6b1c77cd8261..9dd229cbf288 100644
--- a/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
@@ -877,7 +877,7 @@ cpg: clock-controller@11010000 {
 		};
 
 		sysc: system-controller@11020000 {
-			compatible = "renesas,r9a07g044-sysc";
+			compatible = "renesas,r9a07g044-sysc", "syscon";
 			reg = <0 0x11020000 0 0x10000>;
 			interrupts = <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>,
@@ -885,6 +885,7 @@ sysc: system-controller@11020000 {
 				     <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "lpm_int", "ca55stbydone_int",
 					  "cm33stbyr_int", "ca55_deny";
+			#renesas,sysc-signal-cells = <2>;
 			status = "disabled";
 		};
 
diff --git a/arch/arm64/boot/dts/renesas/r9a07g054.dtsi b/arch/arm64/boot/dts/renesas/r9a07g054.dtsi
index 01f59914dd09..31550b8c3143 100644
--- a/arch/arm64/boot/dts/renesas/r9a07g054.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a07g054.dtsi
@@ -884,7 +884,7 @@ cpg: clock-controller@11010000 {
 		};
 
 		sysc: system-controller@11020000 {
-			compatible = "renesas,r9a07g054-sysc";
+			compatible = "renesas,r9a07g054-sysc", "syscon";
 			reg = <0 0x11020000 0 0x10000>;
 			interrupts = <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>,
@@ -892,6 +892,7 @@ sysc: system-controller@11020000 {
 				     <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "lpm_int", "ca55stbydone_int",
 					  "cm33stbyr_int", "ca55_deny";
+			#renesas,sysc-signal-cells = <2>;
 			status = "disabled";
 		};
 
diff --git a/arch/arm64/boot/dts/renesas/r9a08g045.dtsi b/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
index be8a0a768c65..169561386f35 100644
--- a/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
@@ -198,7 +198,7 @@ cpg: clock-controller@11010000 {
 		};
 
 		sysc: system-controller@11020000 {
-			compatible = "renesas,r9a08g045-sysc";
+			compatible = "renesas,r9a08g045-sysc", "syscon";
 			reg = <0 0x11020000 0 0x10000>;
 			interrupts = <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>,
@@ -206,6 +206,7 @@ sysc: system-controller@11020000 {
 				     <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "lpm_int", "ca55stbydone_int",
 					  "cm33stbyr_int", "ca55_deny";
+			#renesas,sysc-signal-cells = <2>;
 			status = "disabled";
 		};
 
-- 
2.39.2


