Return-Path: <linux-kernel+bounces-291653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB8AA956538
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 10:09:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C7161F2261D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 08:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A673D15B0E1;
	Mon, 19 Aug 2024 08:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BtPL0NzN"
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83368A41;
	Mon, 19 Aug 2024 08:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724054946; cv=none; b=WDd90FbpZcgc5LU36aP8kRRFezeMmCQYL4HuyfPbR+UlC5HFvNVgZjNkfoHpWOPlrOVLra553c02Rmdi3iRzkSJqnJeGcl57/pG9u7LnuQsIdPfE5Xadb/W3SABs4/PBb7BK0wLjw869ekj6sW6V5amNYQsTQJ4ygHH0GWhX5Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724054946; c=relaxed/simple;
	bh=fmrtyZH6m98lDrrNjeOwpT241Zn2puah/4W+jvMyTKI=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=ZwVRC6/xuaYKBzvmvLhixX5XCbzWk8zn/gMcbSkxcisEE7bA3S+apmveY9woyQRJRJ9/fmMkVLWrXlHNhLv4zBHcFG3chLQfNkR+i7jmR75xZR+/OOfGB5u0BllN7YiPKGlzLy4JlpAte6IwOxW/L1shsbQKxJ3LiyFBD1Pvf8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BtPL0NzN; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-70c9cda7f1cso1810168a34.3;
        Mon, 19 Aug 2024 01:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724054943; x=1724659743; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=RoQpEAbr6X6DF3JMAeXgzIajk1r2oZJlDoDuARKzu94=;
        b=BtPL0NzNbNPbMl1MJ0c6cQCRs5QV2MCpKyn8Wm3aSSGbJPICOVyFKd7FZCdqT7XpJL
         cgRwr51YB8+Q/KR0D/aizhbXbPVzO6TOhvGZ8DQnaoqTqzwnyKbkXeWSV5q4VSWjz+kW
         fJNGVLkzhWRu66Pb9tvBJG94skNiQBajpvxDEt5o/MbQhaIilGQed34Ic0oFVKKxKEkR
         nC5BFHINyvEcPanAGBmzOBDrNNX3ZAuD7ASnmGwJwccOsZ33Ii8Rd4VdhxqkfMMy+Gva
         8qaAJwPczNucHZh722chH3l0+KSJSFW0QRe+xb5Y1LXerNmnMDNB67TOmV2ItG85XbXA
         f8sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724054943; x=1724659743;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RoQpEAbr6X6DF3JMAeXgzIajk1r2oZJlDoDuARKzu94=;
        b=Q8opAL1NiUCg/mIxgFa64Jfe0FUquNrUMzts0c+Y9qtjk/8SIMd44zndYWvHlXf1Tt
         Fp5B88WvTkbO6h62igIoaboxEWhRGioHYvGO+Cx688U38sZXzR0VIBiwwAMCUjdTlUZF
         POx7rToxWFuGSV9g02Hl+By3nFo+UpqX/JchqoSeq3AI5T+1wi74eZ48tPxX8YczN8e+
         sUnhJS0NkVdz9nF9K2hxgTg+u+6EfCxwtkN2ORWg6ckZzN2tzyjuG72JqdI6wY12rNUP
         zXMDNhEzOYRSa3a8ASsUz+KZrQLwPMpSIQBmRBlpyF35i/9WZ8Q2gHp8OfJMwUXMunLH
         zXiA==
X-Forwarded-Encrypted: i=1; AJvYcCURUylVPj7m/j/hcwORuJfgezRYXy7jdzqu8dWgTySXY/C+MQhQX8KEy2ng9BmcGKFX1XP03uvV4Z0N5k+GW8rfzO8HrOIvYMaDJj2IWRiPSR//kHeY9OytXOVmyWQ88rDj5X/Jd5yfBg==
X-Gm-Message-State: AOJu0YzTAmnV/J7CFeEwkb6wXeWqeZh6mkU4YNfNeVVlSiDFvRH1O83C
	ejdjGO5mhIp7+tr68s5OmXL9nujV6sYwxIzdLpGZQgp1TnV7yMUZTmUxug==
X-Google-Smtp-Source: AGHT+IFod2ekzS/mbwOYQcZZfonp1HP9EFILJJlkZ+G7BPDhSISSpdEZ0Wc89uSKO0iswQcvNkw5tg==
X-Received: by 2002:a05:6870:4726:b0:261:1ffb:4ab2 with SMTP id 586e51a60fabf-2701c3c75a5mr12138640fac.20.1724054943340;
        Mon, 19 Aug 2024 01:09:03 -0700 (PDT)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-270049f7539sm2795526fac.47.2024.08.19.01.09.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 01:09:02 -0700 (PDT)
From: Chen Wang <unicornxw@gmail.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	inochiama@outlook.com,
	unicorn_wang@outlook.com,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	guoren@kernel.org,
	chao.wei@sophgo.com,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	haijiao.liu@sophgo.com,
	xiaoguang.xing@sophgo.com
Subject: [PATCH] riscv: sophgo: dts: add gpio controllers for SG2042 SoC
Date: Mon, 19 Aug 2024 16:08:51 +0800
Message-Id: <20240819080851.1954691-1-unicornxw@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chen Wang <unicorn_wang@outlook.com>

Add support for the GPIO controller of Sophgo SG2042.

SG2042 uses IP from Synopsys DesignWare APB GPIO and has
three GPIO controllers.

Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
---
 arch/riscv/boot/dts/sophgo/sg2042.dtsi | 66 ++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/arch/riscv/boot/dts/sophgo/sg2042.dtsi b/arch/riscv/boot/dts/sophgo/sg2042.dtsi
index eebd6817520e..6aff718dba4a 100644
--- a/arch/riscv/boot/dts/sophgo/sg2042.dtsi
+++ b/arch/riscv/boot/dts/sophgo/sg2042.dtsi
@@ -99,6 +99,72 @@ i2c3: i2c@7030008000 {
 			status = "disabled";
 		};
 
+		gpio0: gpio@7030009000 {
+			compatible = "snps,dw-apb-gpio";
+			reg = <0x70 0x30009000 0x0 0x400>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			clocks = <&clkgen GATE_CLK_APB_GPIO>,
+				 <&clkgen GATE_CLK_GPIO_DB>;
+			clock-names = "bus", "db";
+
+			port0a: gpio-controller@0 {
+				compatible = "snps,dw-apb-gpio-port";
+				gpio-controller;
+				#gpio-cells = <2>;
+				snps,nr-gpios = <32>;
+				reg = <0>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+				interrupt-parent = <&intc>;
+				interrupts = <96 IRQ_TYPE_LEVEL_HIGH>;
+			};
+		};
+
+		gpio1: gpio@703000a000 {
+			compatible = "snps,dw-apb-gpio";
+			reg = <0x70 0x3000a000 0x0 0x400>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			clocks = <&clkgen GATE_CLK_APB_GPIO>,
+				 <&clkgen GATE_CLK_GPIO_DB>;
+			clock-names = "bus", "db";
+
+			port1a: gpio-controller@0 {
+				compatible = "snps,dw-apb-gpio-port";
+				gpio-controller;
+				#gpio-cells = <2>;
+				snps,nr-gpios = <32>;
+				reg = <0>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+				interrupt-parent = <&intc>;
+				interrupts = <97 IRQ_TYPE_LEVEL_HIGH>;
+			};
+		};
+
+		gpio2: gpio@703000b000 {
+			compatible = "snps,dw-apb-gpio";
+			reg = <0x70 0x3000b000 0x0 0x400>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			clocks = <&clkgen GATE_CLK_APB_GPIO>,
+				 <&clkgen GATE_CLK_GPIO_DB>;
+			clock-names = "bus", "db";
+
+			port2a: gpio-controller@0 {
+				compatible = "snps,dw-apb-gpio-port";
+				gpio-controller;
+				#gpio-cells = <2>;
+				snps,nr-gpios = <32>;
+				reg = <0>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+				interrupt-parent = <&intc>;
+				interrupts = <98 IRQ_TYPE_LEVEL_HIGH>;
+			};
+		};
+
 		pllclk: clock-controller@70300100c0 {
 			compatible = "sophgo,sg2042-pll";
 			reg = <0x70 0x300100c0 0x0 0x40>;

base-commit: d9773e09adddf5cd69889545a5feeff119dc9034
-- 
2.34.1


