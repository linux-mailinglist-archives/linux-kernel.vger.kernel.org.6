Return-Path: <linux-kernel+bounces-271755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E87199452E9
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 20:40:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F38B28975A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 18:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C837614D435;
	Thu,  1 Aug 2024 18:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pdp7-com.20230601.gappssmtp.com header.i=@pdp7-com.20230601.gappssmtp.com header.b="qbrmKhMn"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B54D14C599
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 18:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722537511; cv=none; b=TJunfrlPNPTocHCxwsY1gC0GznoXIllC0UM8w4BK/NZittCK6fA3JeUMcW/SmR1yXZGqIR1CL2+ueosbb3aPzmiBUwXz1bci3r0KiTVPOpBUcHRZeWjr+nVSTS8NOvA1iUNu3y+CqBoqQPHRuUEduGuXMyaSNMQs7J80GGUo0oY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722537511; c=relaxed/simple;
	bh=EYJYIiAEAfD7NH+H9HMoYZqrRMCnEO9dgrADRI9Gx0E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ND3+dt2HeIYQyAWvT9HgmLAVxmWZSQygMwIwpyktLBU31pxe+qPBx1GH7UNhNXZJIZxfadBGzSh7dhLXrTf3F/UmhyLAgLWzPsHYez9uyJwDHhtCW+VLp+wdUS/qXpvTK2Z0353v+RIx1YPiSlBPebGkgljYsPvzvw3ypo3T0PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pdp7.com; spf=none smtp.mailfrom=pdp7.com; dkim=pass (2048-bit key) header.d=pdp7-com.20230601.gappssmtp.com header.i=@pdp7-com.20230601.gappssmtp.com header.b=qbrmKhMn; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pdp7.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=pdp7.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-7a1be7b5d70so1842458a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 11:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pdp7-com.20230601.gappssmtp.com; s=20230601; t=1722537509; x=1723142309; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V5ZHzEhK/iqIbovaWXtYghu86qtEZ1UEP6cVND/8xFY=;
        b=qbrmKhMnzIky2ze8p/kvf4PGE9tBu82IgyUQk5rUbUjeEK/yUi46oncC/68C5Z1fq8
         hR4HCCXKQqAv3Nvymygf4VqXkKu2YUeE6y4U14PFEggIt80ixs6HTYaJWLa1DxIeVnkA
         HfsBW5/iIArNFQQXFFeR2cghnr2D1B6t8ZBEvTUb02Fkcoxxp0NdQ+oJl9h1UUk1pm1q
         Gb7uJ0CdeqQSqn9rELdE6Srk1mcl4SJEoyFrxVGxSY12weHxeVP2X4rDnl3PrwWjHcbw
         Tb5h0QTlX59i0SX8svzYqxRn9A8TiLjkSTyz4H6RmXbNYGM+06Ap9MKEl6EI/MXFpSKv
         e4yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722537509; x=1723142309;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V5ZHzEhK/iqIbovaWXtYghu86qtEZ1UEP6cVND/8xFY=;
        b=wCJ+ooUrLmpkfUN1ac6n61hSAJ4TCbw062WbS8nD7ADyYsspvrjr7U32WwJQ8mYXQr
         pyCQz8OiNGBYL9t3JP8u+vy96qMp2nXGOduwoPKAXoWWBBLPZCacI6A637JJ4+VAX421
         jqIq9vpKxkLgqZyEikNpUKg7M5Un+zZE9PNJNyqbO1dkxnPig7N+w8N5pWD5PxWJIOJP
         PVX4vdfmQbgPQ8Ixp8/aK1tjnARmHkvgqcmQP4mqgpp4N7qpDFv7E9fE6/oq9UR7OqIO
         xSPH1bU+ZfjZibMnSYImW7im4PRbFUyMbdJ7TEZ2+iL7+BUxnIM9j8Oj0J23xp9rG9pr
         1msA==
X-Forwarded-Encrypted: i=1; AJvYcCW2jBLPbhsPqyTj/0+jdWXkDFhsWMyx0hgBSiNVTjRZyO/9Z4t6nQxjfUP94y8ZCoOLtxjntdbIIKvQ0W1GhzDjH2RG7B4f/LhaLB2/
X-Gm-Message-State: AOJu0YxUwODsXqlchFz+ckMQ9JvAxa023jC2pahFd0ogZeqhOjB9PK1R
	96P4BiewqBVvuIA49InRNgDuL+DMdoglNGhpuukR2KO0He7tWBbruz7v+EHR5DE=
X-Google-Smtp-Source: AGHT+IE7euEhKw9ZvLGZgoJ3nB4r1T+YCPL1oMKPqsmgOUjr5Pfy6QWgZSIFTVenufI1eR46X4W9Ag==
X-Received: by 2002:a17:90b:1a86:b0:2c2:d590:808e with SMTP id 98e67ed59e1d1-2cffa200df2mr1270706a91.13.1722537508634;
        Thu, 01 Aug 2024 11:38:28 -0700 (PDT)
Received: from [127.0.1.1] ([2601:1c2:1802:170:dfa1:41a7:9478:9d47])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cffaf69d54sm279728a91.12.2024.08.01.11.38.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 11:38:27 -0700 (PDT)
From: Drew Fustini <drew@pdp7.com>
Date: Thu, 01 Aug 2024 11:38:10 -0700
Subject: [PATCH 6/6] riscv: dts: thead: change TH1520 SPI node to use clock
 controller
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240801-th1520-clk-dts-v1-6-71077a0614b8@pdp7.com>
References: <20240801-th1520-clk-dts-v1-0-71077a0614b8@pdp7.com>
In-Reply-To: <20240801-th1520-clk-dts-v1-0-71077a0614b8@pdp7.com>
To: Emil Renner Berthing <emil.renner.berthing@canonical.com>, 
 Thomas Bonnefille <thomas.bonnefille@bootlin.com>, 
 Kanak Shilledar <kanakshilledar@gmail.com>, 
 Jisheng Zhang <jszhang@kernel.org>, Guo Ren <guoren@kernel.org>, 
 Fu Wei <wefu@redhat.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
Cc: linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Drew Fustini <drew@pdp7.com>, 
 Drew Fustini <dfustini@tenstorrent.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2303; i=drew@pdp7.com;
 h=from:subject:message-id; bh=GEkmEzaBBCWW5dvp0uJoNHGIioeJZ823d7ZJt1ChQBI=;
 b=owGbwMvMwCF2+43O4ZsaG3kYT6slMaStvibFWr3h3cwewfTJzWvni31U2PSlSjEs/s+V9QuVA
 u9svnPmW0cpC4MYB4OsmCLLpg95F5Z4hX5dMP/FNpg5rEwgQxi4OAVgItc6GRl2PzSIMtz8ppXt
 /dRsHlW5y+9/nrgXM/Gl8X2zvlIB09QnjAy3hfVYV025nBKU4268Y9LKjvjFFRc3OrW/kBd5fir
 tVjg3AA==
X-Developer-Key: i=drew@pdp7.com; a=openpgp;
 fpr=1B6F948213EA489734F3997035D5CD577C1E6010

From: Drew Fustini <dfustini@tenstorrent.com>

Change the clock property in the TH1520 SPI controller node to a clock
provided by AP_SYS clock controller.

Remove spi_clk fixed clock reference from BeagleV Ahead and LPI4a dts.

Link: https://git.beagleboard.org/beaglev-ahead/beaglev-ahead/-/tree/main/docs
Signed-off-by: Drew Fustini <dfustini@tenstorrent.com>
---
 arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts     | 4 ----
 arch/riscv/boot/dts/thead/th1520-lichee-module-4a.dtsi | 4 ----
 arch/riscv/boot/dts/thead/th1520.dtsi                  | 8 +-------
 3 files changed, 1 insertion(+), 15 deletions(-)

diff --git a/arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts b/arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts
index 425f07d73b32..497d961456f3 100644
--- a/arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts
+++ b/arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts
@@ -45,10 +45,6 @@ &osc_32k {
 	clock-frequency = <32768>;
 };
 
-&spi_clk {
-	clock-frequency = <396000000>;
-};
-
 &dmac0 {
 	status = "okay";
 };
diff --git a/arch/riscv/boot/dts/thead/th1520-lichee-module-4a.dtsi b/arch/riscv/boot/dts/thead/th1520-lichee-module-4a.dtsi
index 077dbbe4abb6..78977bdbbe3d 100644
--- a/arch/riscv/boot/dts/thead/th1520-lichee-module-4a.dtsi
+++ b/arch/riscv/boot/dts/thead/th1520-lichee-module-4a.dtsi
@@ -25,10 +25,6 @@ &osc_32k {
 	clock-frequency = <32768>;
 };
 
-&spi_clk {
-	clock-frequency = <396000000>;
-};
-
 &dmac0 {
 	status = "okay";
 };
diff --git a/arch/riscv/boot/dts/thead/th1520.dtsi b/arch/riscv/boot/dts/thead/th1520.dtsi
index 5f4f94ca9cc7..6992060e6a54 100644
--- a/arch/riscv/boot/dts/thead/th1520.dtsi
+++ b/arch/riscv/boot/dts/thead/th1520.dtsi
@@ -216,12 +216,6 @@ osc_32k: 32k-oscillator {
 		#clock-cells = <0>;
 	};
 
-	spi_clk: spi-clock {
-		compatible = "fixed-clock";
-		clock-output-names = "spi_clk";
-		#clock-cells = <0>;
-	};
-
 	soc {
 		compatible = "simple-bus";
 		interrupt-parent = <&plic>;
@@ -256,7 +250,7 @@ spi0: spi@ffe700c000 {
 			compatible = "thead,th1520-spi", "snps,dw-apb-ssi";
 			reg = <0xff 0xe700c000 0x0 0x1000>;
 			interrupts = <54 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&spi_clk>;
+			clocks = <&clk CLK_SPI>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			status = "disabled";

-- 
2.34.1


