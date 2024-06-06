Return-Path: <linux-kernel+bounces-203848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 759058FE12D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 10:39:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8C7828A9D4
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 08:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C8AE13CA97;
	Thu,  6 Jun 2024 08:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WZnTT1W4"
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0553A13C900;
	Thu,  6 Jun 2024 08:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717663068; cv=none; b=BwGleTDn6CfwIJUI9Wnds+UUOs8ZMzClXpnWPrKRPjWmac1QhkP+2615XqFRTR85xRJfK+QmZQk4VuAvBMs/FNLW6rqDJvHF3sDP+ECGOYXGyIjjqJutyPEaVRYIpzvm/JqKbf0iI2KqTGbZQMXMIg1n015P7zbF3HqlMo8X6Dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717663068; c=relaxed/simple;
	bh=HYy0uBIq7a4XYMVsAB46Cm0zvk1JrXNzFX9UbTeng8k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=R1ngDzmjR0Xbe2fvj6kD27xr5tlXswBNbjsYGrpMh2hAWrSwvI8mVE/3/iZW7BvmooeHK74m3omrRM6XKr8vlGGUntFVSV+dpKC0zcxyhWFXUCee0egM5ECtUW3EH5tbzGCPDxZwjsQZQxMg6ZFxle/nIRVCou1WCrUNEAh0eo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WZnTT1W4; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-6f938c18725so375006a34.1;
        Thu, 06 Jun 2024 01:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717663066; x=1718267866; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qXXhn+viEW5QNpw1s0JwBzkpEksiOVn61xZJPP4n0t4=;
        b=WZnTT1W4wHzAVEaakNo6zXCPikupDjNgXzfzF7EGwy4sUU4SRDHCFZA+hQFWdMJ7tq
         mXxlA6j0ansWSi80zDas8j1MozUnzNIvfFWzRA89kSe//r9mYFbXP873BUkR2QeNU2SB
         xEkkHHRzHj03BBVboPbqxbj6u6aWxgHNaIfiq2A0BLG0tksgz3rLVE2BFtq3k2dTj6Uz
         B8S3lHnl3UwG0r3Z+VjsAY56ivCoSkuY1DWaCrYhk6m0TD+VZUVrVNIF7rnM5ebRj2G9
         R5k/twuVvcpl09ldwpp+KbBUKV8R8b9mFmNha7547SOQWZF+W8y+C1Kze4Aw4vlWg6r1
         7cKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717663066; x=1718267866;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qXXhn+viEW5QNpw1s0JwBzkpEksiOVn61xZJPP4n0t4=;
        b=jTQpB6NvPnH+Sp41SR7XF5Iusmg6DYA3FkmOh4xA5otC+bt/fzh9fFwAY8ZMrqv8Sl
         gg/9s1PT5YggYto+2g+eiYFp4vagIi1Glu2/sKKK55xGaYWUFE6hmooobuS0BcN95q/g
         GlHXKAlYGG1UHf4pli6OzT4zIgkfpPGso/Yf2gzhKrflqgfVUMUBVOx03vMfzm0ooEcU
         qR9EQ/32MDm/tJauAt8EOcaJSBFXqr2kaOBkBdfE1iWBqSZuXeTJtSd4k2ehTeyn4WVX
         dN/pKOW9LfaHd4AHOZJUrpCtSIZ3fl+zW5frn64PWb57z7f9lARCqnKnbugqpBaMzMIW
         BmwQ==
X-Forwarded-Encrypted: i=1; AJvYcCW33hewHSPg3rd6WZ2Dh+xDWFa37qwVN6vp0wX6wJQvaXjSGtGquWZLI9/8j19vuEOyhttYGDqEh5ea3jDHXqLL2IRYhNzg+NSFM0yb75jCAsO/e7thupGc92qHHy9mGctyxUd/B+tTLb1kpgtrVVPsZdu2QL+paagU4Zbu/jOEFqVcyQ==
X-Gm-Message-State: AOJu0YzE1DPz77TObRv6yL+UuRq+/MU13swj5JnsY0U4s8W+qNbWFprx
	1HeAm/hfDrLNb3Bmy/ry+DaQ020GyJDMmGjNK2B70qEdzJXL6h+J
X-Google-Smtp-Source: AGHT+IGZlEYKLCxi0RKiEtXK7Ckj+6l6wKfH5lX8OsZs2LFvUkmtRa+80HPxCK7UHmoLIlW9SGRzaw==
X-Received: by 2002:a05:6830:148d:b0:6f0:444c:d534 with SMTP id 46e09a7af769-6f94341474cmr5168489a34.5.1717663065958;
        Thu, 06 Jun 2024 01:37:45 -0700 (PDT)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-6f94dcf4ffcsm210863a34.63.2024.06.06.01.37.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 01:37:45 -0700 (PDT)
From: Chen Wang <unicornxw@gmail.com>
To: aou@eecs.berkeley.edu,
	chao.wei@sophgo.com,
	conor@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	mturquette@baylibre.com,
	palmer@dabbelt.com,
	paul.walmsley@sifive.com,
	richardcochran@gmail.com,
	robh+dt@kernel.org,
	sboyd@kernel.org,
	devicetree@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	haijiao.liu@sophgo.com,
	xiaoguang.xing@sophgo.com,
	guoren@kernel.org,
	jszhang@kernel.org,
	inochiama@outlook.com,
	samuel.holland@sifive.com
Cc: Chen Wang <unicorn_wang@outlook.com>
Subject: [PATCH v16 5/5] riscv: dts: add clock generator for Sophgo SG2042 SoC
Date: Thu,  6 Jun 2024 16:37:39 +0800
Message-Id: <9ff7c8917a2125319316d59973a54ac12c311a19.1717661798.git.unicorn_wang@outlook.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1717661798.git.unicorn_wang@outlook.com>
References: <cover.1717661798.git.unicorn_wang@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chen Wang <unicorn_wang@outlook.com>

Add clock generator node to device tree for SG2042, and enable clock for
uart.

Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
Reviewed-by: Guo Ren <guoren@kernel.org>
---
 .../boot/dts/sophgo/sg2042-milkv-pioneer.dts  | 12 ++++
 arch/riscv/boot/dts/sophgo/sg2042.dtsi        | 55 ++++++++++++++++++-
 2 files changed, 66 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts b/arch/riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts
index 49b4b9c2c101..80cb017974d8 100644
--- a/arch/riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts
+++ b/arch/riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts
@@ -14,6 +14,18 @@ chosen {
 	};
 };
 
+&cgi_main {
+	clock-frequency = <25000000>;
+};
+
+&cgi_dpll0 {
+	clock-frequency = <25000000>;
+};
+
+&cgi_dpll1 {
+	clock-frequency = <25000000>;
+};
+
 &uart0 {
 	status = "okay";
 };
diff --git a/arch/riscv/boot/dts/sophgo/sg2042.dtsi b/arch/riscv/boot/dts/sophgo/sg2042.dtsi
index 81fda312f988..34c802bd3f9b 100644
--- a/arch/riscv/boot/dts/sophgo/sg2042.dtsi
+++ b/arch/riscv/boot/dts/sophgo/sg2042.dtsi
@@ -4,8 +4,10 @@
  */
 
 /dts-v1/;
+#include <dt-bindings/clock/sophgo,sg2042-clkgen.h>
+#include <dt-bindings/clock/sophgo,sg2042-pll.h>
+#include <dt-bindings/clock/sophgo,sg2042-rpgate.h>
 #include <dt-bindings/interrupt-controller/irq.h>
-
 #include <dt-bindings/reset/sophgo,sg2042-reset.h>
 
 #include "sg2042-cpus.dtsi"
@@ -20,12 +22,60 @@ aliases {
 		serial0 = &uart0;
 	};
 
+	cgi_main: oscillator0 {
+		compatible = "fixed-clock";
+		clock-output-names = "cgi_main";
+		#clock-cells = <0>;
+	};
+
+	cgi_dpll0: oscillator1 {
+		compatible = "fixed-clock";
+		clock-output-names = "cgi_dpll0";
+		#clock-cells = <0>;
+	};
+
+	cgi_dpll1: oscillator2 {
+		compatible = "fixed-clock";
+		clock-output-names = "cgi_dpll1";
+		#clock-cells = <0>;
+	};
+
 	soc: soc {
 		compatible = "simple-bus";
 		#address-cells = <2>;
 		#size-cells = <2>;
 		ranges;
 
+		pllclk: clock-controller@70300100c0 {
+			compatible = "sophgo,sg2042-pll";
+			reg = <0x70 0x300100c0 0x0 0x40>;
+			clocks = <&cgi_main>, <&cgi_dpll0>, <&cgi_dpll1>;
+			clock-names = "cgi_main", "cgi_dpll0", "cgi_dpll1";
+			#clock-cells = <1>;
+		};
+
+		rpgate: clock-controller@7030010368 {
+			compatible = "sophgo,sg2042-rpgate";
+			reg = <0x70 0x30010368 0x0 0x98>;
+			clocks = <&clkgen GATE_CLK_RP_CPU_NORMAL>;
+			clock-names = "rpgate";
+			#clock-cells = <1>;
+		};
+
+		clkgen: clock-controller@7030012000 {
+			compatible = "sophgo,sg2042-clkgen";
+			reg = <0x70 0x30012000 0x0 0x1000>;
+			clocks = <&pllclk MPLL_CLK>,
+				 <&pllclk FPLL_CLK>,
+				 <&pllclk DPLL0_CLK>,
+				 <&pllclk DPLL1_CLK>;
+			clock-names = "mpll",
+				      "fpll",
+				      "dpll0",
+				      "dpll1";
+			#clock-cells = <1>;
+		};
+
 		clint_mswi: interrupt-controller@7094000000 {
 			compatible = "sophgo,sg2042-aclint-mswi", "thead,c900-aclint-mswi";
 			reg = <0x00000070 0x94000000 0x00000000 0x00004000>;
@@ -341,6 +391,9 @@ uart0: serial@7040000000 {
 			interrupt-parent = <&intc>;
 			interrupts = <112 IRQ_TYPE_LEVEL_HIGH>;
 			clock-frequency = <500000000>;
+			clocks = <&clkgen GATE_CLK_UART_500M>,
+				 <&clkgen GATE_CLK_APB_UART>;
+			clock-names = "baudclk", "apb_pclk";
 			reg-shift = <2>;
 			reg-io-width = <4>;
 			resets = <&rstgen RST_UART0>;
-- 
2.25.1


