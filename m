Return-Path: <linux-kernel+bounces-431069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E3AF9E3893
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 12:17:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B6EC168786
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 11:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB3271B87EE;
	Wed,  4 Dec 2024 11:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Na93sqEf"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF2E1B81DC;
	Wed,  4 Dec 2024 11:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733310908; cv=none; b=Oaq7zFMDaTkJSIj0lZJy3BYn7JVxrXbLSNkMj/MmuqPhhYXSRTaRgvaOGOOE9GbsUl8dYIv0CNh5sgUnzOgVJyrUU2qHigUbbIa1tppSt5cTFePGrGrBh2BZYInqScaQ6MYQ9XhinXo/uyllIQqCNmMFs/wLFUeGPkBC9jeeXmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733310908; c=relaxed/simple;
	bh=nK4VznMub4fzu5XArxtd5UVSvlrfttVgr+fEVQNC1dg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rPFs3cYuWIJHzEUAqUStD5feFWDjpWRomcnx++yb8I0BPJ/cGfANS27z6NMIFA1ZTtn5ZKd+tBIGs6Yv+vou7Vaa6dzO5B5wu20gRfwDRkhVPb3R6s1gc2E1EL5wvPRqdCof5zXLQJzYurq7mwAyX1rzXB16WNkBFlCIpJ0mSoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Na93sqEf; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-53dd59a2bc1so7034690e87.2;
        Wed, 04 Dec 2024 03:15:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733310904; x=1733915704; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Xbp3m6Cn2heC+155S7bxZ4ivlSk42YF62OspC6ro8GA=;
        b=Na93sqEfTgtjP5olLsWNgUX6ASKMXboosFTKw/ntdVI2bOv17rVbTPwuTqXF5b2qvL
         7lVRdphqKT0YhODp9M+4LWN4d2IwRgSE0IUwu3L8wgS0TF6uBgKLPLpYxl5e5mquHBaB
         pLxCFFvfKZfteKQHO52Cux99ijaRYLOxU1AIFmBs+QIhI+ZlA0BJ2luHzSjSn8pkLjcE
         yhV2k0IbPJFAP4ytrfgmdpNcPW1Zk8ZiFCB6IsqNPXhqSzRjv+9BZ+mqR6cTVfWxGudT
         K0NZXP80fTuX5xPHSXOH7qPlpmUcYfkwigqewv9ASlVaK9w0F5xwk0Apb0Ia8tdxO+ff
         Ispg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733310904; x=1733915704;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xbp3m6Cn2heC+155S7bxZ4ivlSk42YF62OspC6ro8GA=;
        b=NE+lEKpi2jsQ9XwBBqkGlZ0/uw2ArKlBXUn3J/9G2DkbrxF+S0B2py1juhszUg0fsZ
         1Cpctx5l4hhZHTYE8ElB9DrBcm8B5VV1i1Jls2nO4ie6R3emaYRhhTc1hiiD5ysgQcgx
         4HAynwnBPRr/jN9zYeWWPltutB/BnbhzrTePG1CHbTlp4luHUNlfccxOcqKUoXE5LdH7
         sZgqrGVEpmUOWMgNeDHMgr49K2VRpyAiVcYS6LroFr+kD577OaeEqdr4nkMBeDJYkOLy
         gvBMaVMZRB729uWbStCGEnTgv4phBLwd4noBYIVe0+N9LOwozwwfp32u5Y66SmcVMGcP
         GZCA==
X-Forwarded-Encrypted: i=1; AJvYcCUZIjMG0lz7t4qnz50LVCidAFCiiCzdXybHqfhdi1yFeV3PLFGXyLxUheiPGjYpDCMPeJiz0vddjEZ9QAKR@vger.kernel.org, AJvYcCXGDq3LVNvOgooD0Z9uTVC/V2PU+L9ycWKPRj3mq0K+6YIRujmB4igowb/2UDde8qOtbVzkxiT2UHQe@vger.kernel.org
X-Gm-Message-State: AOJu0YzluQLFaQWFuXjy2msyITuZCfUk4sZDRlnjnhrylBtyc8sBdLPT
	kttsOtfFF0jttRHuMsVJNyheHBzhMLS8K5dSkK1/d17ozbeZClIo
X-Gm-Gg: ASbGnct25FclzXxfqSbJhReM8OqDR3D8U2VqbwrW6iBZXGBgmyIyvXFjRd9oYpTlBON
	KM/4SmxwaK1QQpIZEl6Z0bMleAsJwzicMwuNmak5ZuDgZYgkqJ4/60et8xpridFNgRlV0A/V4ZK
	XETogVqWLcAKHm36/yoX8zGOK2V2R0Uo1Sw2W5/GHO10t9+fC6QSsTR3ktnip/sNHGyp5gN3fVX
	GNf5NIdkVKADzBmc5d34OPL4V6uPHoVLHolJhzXhBBzVDvb1Lw2Lm1ma2LtSjb92dGkqB8qkPPl
	UsjMCFA=
X-Google-Smtp-Source: AGHT+IF8VqagoVcsT3PrjFrHxvDph9cZFCYIL4WHBAhaQL6GIgucsdHTtT8Sn/F7Qa4T5hbQ2dudAg==
X-Received: by 2002:a05:6512:3b27:b0:53d:eef4:8acf with SMTP id 2adb3069b0e04-53e12a2d5dfmr2237633e87.45.1733310904141;
        Wed, 04 Dec 2024 03:15:04 -0800 (PST)
Received: from wpc.yadro.com (host-93-124-60-94.dsl.sura.ru. [93.124.60.94])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53e18b2df6csm455727e87.8.2024.12.04.03.15.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 03:15:03 -0800 (PST)
From: bigunclemax@gmail.com
To: 
Cc: bigunclemax@gmail.com,
	Drew Fustini <drew@pdp7.com>,
	Guo Ren <guoren@kernel.org>,
	Fu Wei <wefu@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] riscv: dts: thead: Fix TH1520 emmc and shdci clock rate
Date: Wed,  4 Dec 2024 14:14:23 +0300
Message-ID: <20241204111424.263055-1-bigunclemax@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Maksim Kiselev <bigunclemax@gmail.com>

In accordance with LicheePi 4A BSP the clock that comes to emmc/sdhci
is 198Mhz.

But changing from fixed-clock to CLK_EMMC_SDIO leads to increasing input
clock from 198Mhz to 792Mhz. Because the CLK_EMMC_SDIO is actually 792Mhz.

Therefore calculation of output SDCLK is incorrect now.
The mmc driver sets the divisor to 4 times larger than it should be
and emmc/sd works 4 times slower.

This can be confirmed with fio test:
Sequential read of emmc with fixed 198Mz clock:
READ: bw=289MiB/s (303MB/s)

Sequential read with CLK_EMMC_SDIO clock:
READ: bw=82.6MiB/s (86.6MB/s)

Let's fix this issue by providing fixed-factor-clock that divides
CLK_EMMC_SDIO by 4 for emmc/sd nodes.

Fixes: 03a20182e1e0 ("riscv: dts: thead: change TH1520 mmc nodes to use clock controller")
Signed-off-by: Maksim Kiselev <bigunclemax@gmail.com>
---
 arch/riscv/boot/dts/thead/th1520.dtsi | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/boot/dts/thead/th1520.dtsi b/arch/riscv/boot/dts/thead/th1520.dtsi
index acfe030e803a..6c20965cd10c 100644
--- a/arch/riscv/boot/dts/thead/th1520.dtsi
+++ b/arch/riscv/boot/dts/thead/th1520.dtsi
@@ -229,6 +229,14 @@ stmmac_axi_config: stmmac-axi-config {
 		snps,blen = <0 0 64 32 0 0 0>;
 	};
 
+	sdhci_clk: sdhci-clock {
+		compatible = "fixed-factor-clock";
+		clocks = <&clk CLK_EMMC_SDIO>;
+		#clock-cells = <0>;
+		clock-div = <4>;
+		clock-mult = <1>;
+	};
+
 	soc {
 		compatible = "simple-bus";
 		interrupt-parent = <&plic>;
@@ -328,7 +336,7 @@ emmc: mmc@ffe7080000 {
 			compatible = "thead,th1520-dwcmshc";
 			reg = <0xff 0xe7080000 0x0 0x10000>;
 			interrupts = <62 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&clk CLK_EMMC_SDIO>;
+			clocks = <&sdhci_clk>;
 			clock-names = "core";
 			status = "disabled";
 		};
@@ -337,7 +345,7 @@ sdio0: mmc@ffe7090000 {
 			compatible = "thead,th1520-dwcmshc";
 			reg = <0xff 0xe7090000 0x0 0x10000>;
 			interrupts = <64 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&clk CLK_EMMC_SDIO>;
+			clocks = <&sdhci_clk>;
 			clock-names = "core";
 			status = "disabled";
 		};
@@ -346,7 +354,7 @@ sdio1: mmc@ffe70a0000 {
 			compatible = "thead,th1520-dwcmshc";
 			reg = <0xff 0xe70a0000 0x0 0x10000>;
 			interrupts = <71 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&clk CLK_EMMC_SDIO>;
+			clocks = <&sdhci_clk>;
 			clock-names = "core";
 			status = "disabled";
 		};
-- 
2.45.2


