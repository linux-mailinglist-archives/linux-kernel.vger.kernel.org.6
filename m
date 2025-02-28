Return-Path: <linux-kernel+bounces-537661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 28CAFA48ED9
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 03:47:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 035B7189022B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 02:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2631155C97;
	Fri, 28 Feb 2025 02:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lLdAbsJW"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B350D23CB;
	Fri, 28 Feb 2025 02:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740710843; cv=none; b=OgYbTJESbn8Aqyg193kzCkLwAMijnm38qpb37KJwms+nvzVaa8jxLcvxWYfuVomocB3gj/Pf3rlG9qzgCSYLrOZWZWi6IMEsDiwJzsj9sUJPPeududFjtiW6ZOjtmlLGGTiS/jJaoIJOXCRZxHPo7fvphUwPWN5Kp6eJ0bAwaIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740710843; c=relaxed/simple;
	bh=CadUsZNuHdq8T8eYzHT8bwyZSzEW5VSwjR7Y6+NTUvY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Nbh9c3kzfwVwad1Ym4DLQO9Qhwd9m2sjMgC/MUVTldVs7eO2MtgSf2dPgyYWuxbTVxnFdSG9rW5fFab7Ge9eqpC8IxbdyrUpOokEBH0r7JddEP6VzRrXYxalAznqtFR9mb2jWGJ5ZjN0Hu6RPFZVQY+ZpvfRfyeZ0SNXvyk4gdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lLdAbsJW; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2234daaf269so43868675ad.3;
        Thu, 27 Feb 2025 18:47:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740710841; x=1741315641; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HNAmch+SoEKe7ryjnsLMCAL7vRLjtwtIKcvaQelbSko=;
        b=lLdAbsJWHvOT0Dhe6TCv3WT+5SwjSAg7NN6qMqNjie4MKd98tRvyl6SjrlPTXCAw2F
         1aGnxmnZ+p7U3r3xnuIMmRiZa/5szEIAu89TVSMJXS2gIaq4vCH/PIWMOAqAStf7QL4H
         P3ls3LiMGpc0bmxBnJ29bnS6uogyskxPKmGP03jA5udLTsI4pAaYOph9IC2cmG/4971d
         RDscIuIQObTRqNsi307Vhvp9842yogaWTEkA7x/MqGy0LPQGmSk42lBHtQOa4ywJnxZ+
         GDRPsqLAGAPsPxOSHU8vW19PV5YWy4kACbo4T6VMhHYTFeDDlNIcIteLU2uJoaIGPhYT
         uhxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740710841; x=1741315641;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HNAmch+SoEKe7ryjnsLMCAL7vRLjtwtIKcvaQelbSko=;
        b=a9uGIVgBhkNooDFabTQEoa2NkxYY0AjegyHU5h5p9Ou9C4cPkcjhMKDNkiGzymMtgw
         /HqQcRz8DlK/AZG+QJqxtOcZZlyrnJeh3aMcX/oXFM2+x6Ul6ijUlTvArq4CpwxnoSB6
         hdmka8w2YA0OuclzDbgI7W1hb3d8rVntwqulhHPTXJQxEbnGtTE8/34JSS2fX2cDUlQv
         BTslrQztuPViCJT+to41Ij3l+cDbfkpxgNQb3366ysczwE3HNsppY2hTFW8If6DVJjZx
         ydVsG52jYuIG58+lHve6e5noDW0CpmHBE2V3teR/QHcnogh0oy4G5oLfjXqhPl6/aMyo
         nvAw==
X-Forwarded-Encrypted: i=1; AJvYcCUn1HfZWhRExJHHfs0FN5WA7UPW5GBF8oUAGleFCRanvC2s73lfJdYwZaE0alwVZsCmdY7MhhaxRhrdVxg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQZmjxbavEsLV62bOdYF3OWHDucyDmFpUhrrczldylNgjDnRSc
	HNeZdamR72INsB6bPxuB3BcTEn8EQ59SY27GqlxLvTITwMfkJ1Zs
X-Gm-Gg: ASbGncvyUK5/uOBanMOJ1/2f3LZpYU0qAR2N3hO/YzsVlka9wAb4icxZ+sKlDhg91fg
	ImA7ow0svDf2UM9bPyEpJ+r5LW8fZjSM+4nfs5hpKHGZhvBTnk7vreWaM1lMHCA27Li7BVzBVeq
	4HIbUtqS4CiccTryEVbRaQycCisv7mDaPR8HjnoBsafsmAx9unT8Q+qzrZ7HAZ8zFiIBbpzne4x
	hSsvuv5qjizLXrA4Bm3sJWWIoaJ2RwtnxPweQ4DHb1BCHpYnS1q4rWIYWVLMUWSX0Xgq+55AuYK
	LGNrO62hhSp9/zr865jKyLFbCSJ4HflJkKE=
X-Google-Smtp-Source: AGHT+IEkm2n2GFsLQr1/cGIFrqEljjG/OBWtdluCiNaPZ5/OZL835Q+L806wLrDE+32pkVJUZep79Q==
X-Received: by 2002:a05:6a00:1256:b0:732:5954:a815 with SMTP id d2e1a72fcca58-734ac4259d2mr2702592b3a.22.1740710840591;
        Thu, 27 Feb 2025 18:47:20 -0800 (PST)
Received: from [198.18.0.34] ([188.253.5.104])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7349fe2a61fsm2563807b3a.8.2025.02.27.18.47.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 18:47:20 -0800 (PST)
From: Zixian Zeng <sycamoremoon376@gmail.com>
Date: Fri, 28 Feb 2025 10:47:07 +0800
Subject: [PATCH] riscv: dts: sophgo: sg2042: Add spi devices
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250228-sfg-spi-v1-1-b989aed94911@gmail.com>
X-B4-Tracking: v=1; b=H4sIAKojwWcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDIyML3eK0dN3igkzdVOM0o8TU5EQDy8QkJaDqgqLUtMwKsEnRsbW1AMq
 hYU1ZAAAA
X-Change-ID: 20250228-sfg-spi-e3f2aeca09ab
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Chen Wang <unicorn_wang@outlook.com>, Inochi Amaoto <inochiama@outlook.com>
Cc: devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
 linux-kernel@vger.kernel.org, sophgo@lists.linux.dev, 
 Zixian Zeng <sycamoremoon376@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740710836; l=1648;
 i=sycamoremoon376@gmail.com; s=20250113; h=from:subject:message-id;
 bh=CadUsZNuHdq8T8eYzHT8bwyZSzEW5VSwjR7Y6+NTUvY=;
 b=ThU7hdNRi9sZfNgaOFMZLr51i5KJl828qHO66z6YVkz8nA0MlNWjIq98bdnG2Y163XYGVp50R
 7XQ6dEHZAXpARYhDxSXLMK1oHaau0Rj6nwJL94Yv8K6DF2jeJtyD+r4
X-Developer-Key: i=sycamoremoon376@gmail.com; a=ed25519;
 pk=OYfH6Z2Nx3aU1r0UZdvhskmddV6KC6V1nyFjsQQt4J8=

Add spi devices for the sg2042 soc.

Signed-off-by: Zixian Zeng <sycamoremoon376@gmail.com>
---
 arch/riscv/boot/dts/sophgo/sg2042.dtsi | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/riscv/boot/dts/sophgo/sg2042.dtsi b/arch/riscv/boot/dts/sophgo/sg2042.dtsi
index 0fca16c469cc95aa897b6b57e0a287a687b4d251..d413daa47cf081f23284851db1eeceb3a157e9c0 100644
--- a/arch/riscv/boot/dts/sophgo/sg2042.dtsi
+++ b/arch/riscv/boot/dts/sophgo/sg2042.dtsi
@@ -800,5 +800,35 @@ flash@0 {
 				compatible = "jedec,spi-nor";
 			};
 		};
+
+		spi0: spi@7040004000 {
+			compatible = "snps,dw-apb-ssi";
+			#address-cells = <0x01>;
+			#size-cells = <0x00>;
+			reg = <0x70 0x40004000 0x00 0x1000>;
+			interrupt-parent = <&intc>;
+			interrupts = <110 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clkgen GATE_CLK_APB_SPI>,
+					<&clkgen GATE_CLK_SYSDMA_AXI>;
+			clock-frequency = <250000000>;
+			resets = <&rstgen RST_SPI0>;
+			num-cs = <0x02>;
+			status = "okay";
+		};
+
+		spi1: spi@7040005000 {
+			compatible = "snps,dw-apb-ssi";
+			#address-cells = <0x01>;
+			#size-cells = <0x00>;
+			reg = <0x70 0x40005000 0x00 0x1000>;
+			interrupt-parent = <&intc>;
+			interrupts = <111 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clkgen GATE_CLK_APB_SPI>,
+					<&clkgen GATE_CLK_SYSDMA_AXI>;
+			clock-frequency = <250000000>;
+			resets = <&rstgen RST_SPI1>;
+			num-cs = <0x02>;
+			status = "okay";
+		};
 	};
 };

---
base-commit: 9ef5d3235d41a6f5230d3ddf5eb994483853b3e8
change-id: 20250228-sfg-spi-e3f2aeca09ab

Best regards,
-- 
Zixian Zeng <sycamoremoon376@gmail.com>


