Return-Path: <linux-kernel+bounces-242234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2056D92853A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 11:36:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 948D01F24CA9
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 09:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1859F1487C6;
	Fri,  5 Jul 2024 09:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i+xntHIh"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2DF5146A9B;
	Fri,  5 Jul 2024 09:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720172150; cv=none; b=e5uPSiPp/qyii32gBIjC+sE55jvrBCbfNqkGIeNg86U6p2QSkXQ8ceiXxUS/LEXwg4fhqL4QiGqoptCYVl8JsWmLQjvmZA69hC9PHGZQ8p2FQLb7qXJ8/FWrn6+GWQFhV1pHdSmhWmxW7wxUpJc/bgQApGUYHI0HtcmDLBeovcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720172150; c=relaxed/simple;
	bh=+498PoZQZ+N6jmo2sv5mKMCLtczN0CUibejzmjhNG5o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FZwK6u6RCMeMbNYcYiI6HNwGCMKzjFx4/1wef8WYeBQ/RZGK4+prvdii3Fg2bktEZ1rJBhwILPUACbwiWkM28EhurPXg1hEBrH4+p5iYFUMysNd+uUfRHTWn2HkIgoQImZHhocGYNdaA8tpdtMG1r4SGk9Hv+fiIBJTAsL5ktMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i+xntHIh; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1fb3b7d0d56so6437425ad.1;
        Fri, 05 Jul 2024 02:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720172148; x=1720776948; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TgU+IA8XCyYsTrZ/mEf89X8FSGQS2g4Jad9S/srkmrA=;
        b=i+xntHIhTauCdkYSKkzs/PjUEpYzkexaNlqDSgcZlYqb63rhViU2tz6ZqWnhLmCexr
         tcxtj8eBv1l2KkOHYQvFmAfJpwK3kT3irwhZDTIPmGATLY0IvSWudeJgLsNW7MnjtRWH
         1CsvRIOHdG5i71UL7bQNog8IGxaSaJBnTYY70P5kkE3Y8OtXNErr/FG+bFZoLHNkeWyG
         6bP0sXeXONSlCXIPFjIMJWyp3VJ+kuDchctgtqg14/rCga9s4KB1jOAtRPhqRv89A8FY
         CzcT2Ribd+HSZV1XQ3eY4EnXKrCmYPcrDWraF73KxwGGZ6mwPWwVxlXgNagjx0caF9uW
         C13g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720172148; x=1720776948;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TgU+IA8XCyYsTrZ/mEf89X8FSGQS2g4Jad9S/srkmrA=;
        b=VE7B9BzDzvHbuvLv7rvX9xOXLYXDQ3Nsc+0LNRDSkj9biAkgEn/BZjy1ufVuioEhvZ
         P+bvYprci88IcDfSgILv6ahgBmbr5Zd+fpbCVZ4cGDzFujpAPUixFdEP6F+YXGloDtJU
         vOsSsJTXABAtZTvTKJm5mt1FPhS5lNB+79qM33YAPRbpkdh2vgMLQLCDQ0AwmiEkSN5x
         U4wEuNAOaOUkVEPMHMHBGy+ADAedqideYVznrpRnU2JyEW3wdnrf7+TaoJDCwGjcGnjO
         nJH0ZNjqcN7RIznbuDdZWgAjcpFxwJQC+zHnMsaRWFgG1TvH24uXdFc+nh3K8lTPXr0s
         RayQ==
X-Forwarded-Encrypted: i=1; AJvYcCXg7J1WyWKf+wvc5knl7OwXHKkLHBDGs73pgDLbGN6cglV5/VP/XHxBmaeYujScyqYtPDtdhckGvdW8aZYJqIpvLbL3veBUeUY8tRWQX7Zugk3ZR3QrqQTDCVnNqDCrVa9IGdSsI3PR0Q==
X-Gm-Message-State: AOJu0Yz21rsN4KG6hd/GS3hfQfbVan7+QqMb1+Hi7gTVURD9JcVQ7WvJ
	+eB7rYRiVBEbH7YTbPvgGgDC/DO4+85rQjptSfSSRvEuOgRvf2KT
X-Google-Smtp-Source: AGHT+IFMHxZGAFRx7LiFI3EQg1iAL1RoITUrCiyfvZU4eDXWmlIajOZOFUQI6GbU/7XStDJfAA5iIg==
X-Received: by 2002:a17:902:e5ca:b0:1fb:e95:2993 with SMTP id d9443c01a7336-1fb33f32f3amr33039725ad.62.1720172148189;
        Fri, 05 Jul 2024 02:35:48 -0700 (PDT)
Received: from ga401ii.. ([2401:4900:1c28:7740:14cd:cbce:fd61:6413])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-1fb167dd71esm48552005ad.238.2024.07.05.02.35.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 02:35:47 -0700 (PDT)
From: Kanak Shilledar <kanakshilledar@gmail.com>
To: 
Cc: Kanak Shilledar <kanakshilledar@gmail.com>,
	Jisheng Zhang <jszhang@kernel.org>,
	Guo Ren <guoren@kernel.org>,
	Fu Wei <wefu@redhat.com>,
	Conor Dooley <conor@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Drew Fustini <drew@pdp7.com>
Subject: [PATCH v3 1/1] riscv: dts: thead: add basic spi node
Date: Fri,  5 Jul 2024 15:04:59 +0530
Message-ID: <20240705093503.215787-2-kanakshilledar@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240705093503.215787-1-kanakshilledar@gmail.com>
References: <20240705093503.215787-1-kanakshilledar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

created spi0 node with fixed clock. the spi0 node
uses synopsis designware driver and has the following
compatible "snps,dw-apb-ssi". the spi0 node is connected
to a SPI NOR flash pad which is left unpopulated on the back
side of the board.

Acked-by: Drew Fustini <drew@pdp7.com>
Signed-off-by: Kanak Shilledar <kanakshilledar@gmail.com>
---
Changes in v3:
- Changed the position of "spi" to come after "serial" in
aliases for both the boards.
- Added Acked-by tag.
Changes in v2:
- Separated from a single patch file.
---
 .../boot/dts/thead/th1520-beaglev-ahead.dts      |  9 +++++++++
 .../boot/dts/thead/th1520-lichee-module-4a.dtsi  |  4 ++++
 .../riscv/boot/dts/thead/th1520-lichee-pi-4a.dts |  5 +++++
 arch/riscv/boot/dts/thead/th1520.dtsi            | 16 ++++++++++++++++
 4 files changed, 34 insertions(+)

diff --git a/arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts b/arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts
index d9b4de9e4757..b4d2e1d69bdb 100644
--- a/arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts
+++ b/arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts
@@ -23,6 +23,7 @@ aliases {
 		serial3 = &uart3;
 		serial4 = &uart4;
 		serial5 = &uart5;
+		spi0 = &spi0;
 	};
 
 	chosen {
@@ -52,6 +53,10 @@ &sdhci_clk {
 	clock-frequency = <198000000>;
 };
 
+&spi_clk {
+	clock-frequency = <396000000>;
+};
+
 &uart_sclk {
 	clock-frequency = <100000000>;
 };
@@ -79,3 +84,7 @@ &sdio0 {
 &uart0 {
 	status = "okay";
 };
+
+&spi0 {
+	status = "okay";
+};
diff --git a/arch/riscv/boot/dts/thead/th1520-lichee-module-4a.dtsi b/arch/riscv/boot/dts/thead/th1520-lichee-module-4a.dtsi
index 1365d3a512a3..6939bd36560c 100644
--- a/arch/riscv/boot/dts/thead/th1520-lichee-module-4a.dtsi
+++ b/arch/riscv/boot/dts/thead/th1520-lichee-module-4a.dtsi
@@ -33,6 +33,10 @@ &sdhci_clk {
 	clock-frequency = <198000000>;
 };
 
+&spi_clk {
+	clock-frequency = <396000000>;
+};
+
 &uart_sclk {
 	clock-frequency = <100000000>;
 };
diff --git a/arch/riscv/boot/dts/thead/th1520-lichee-pi-4a.dts b/arch/riscv/boot/dts/thead/th1520-lichee-pi-4a.dts
index 9a3884a73e13..7738d2895c5a 100644
--- a/arch/riscv/boot/dts/thead/th1520-lichee-pi-4a.dts
+++ b/arch/riscv/boot/dts/thead/th1520-lichee-pi-4a.dts
@@ -20,6 +20,7 @@ aliases {
 		serial3 = &uart3;
 		serial4 = &uart4;
 		serial5 = &uart5;
+		spi0 = &spi0;
 	};
 
 	chosen {
@@ -30,3 +31,7 @@ chosen {
 &uart0 {
 	status = "okay";
 };
+
+&spi0 {
+	status = "okay";
+};
diff --git a/arch/riscv/boot/dts/thead/th1520.dtsi b/arch/riscv/boot/dts/thead/th1520.dtsi
index d2fa25839012..f962de663e7e 100644
--- a/arch/riscv/boot/dts/thead/th1520.dtsi
+++ b/arch/riscv/boot/dts/thead/th1520.dtsi
@@ -140,6 +140,12 @@ apb_clk: apb-clk-clock {
 		#clock-cells = <0>;
 	};
 
+	spi_clk: spi-clock {
+		compatible = "fixed-clock";
+		clock-output-names = "spi_clk";
+		#clock-cells = <0>;
+	};
+
 	uart_sclk: uart-sclk-clock {
 		compatible = "fixed-clock";
 		clock-output-names = "uart_sclk";
@@ -183,6 +189,16 @@ clint: timer@ffdc000000 {
 					      <&cpu3_intc 3>, <&cpu3_intc 7>;
 		};
 
+		spi0: spi@ffe700c000 {
+			compatible = "thead,th1520-spi", "snps,dw-apb-ssi";
+			reg = <0xff 0xe700c000 0x0 0x1000>;
+			interrupts = <54 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&spi_clk>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
 		uart0: serial@ffe7014000 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0xff 0xe7014000 0x0 0x100>;
-- 
2.45.2


