Return-Path: <linux-kernel+bounces-364539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAD2C99D5E5
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 19:54:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B0271C22CA1
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 17:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD5F41C82E3;
	Mon, 14 Oct 2024 17:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b="I3oDF6nL"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A230A1C729E
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 17:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728928472; cv=none; b=EuVSd7LMMxH5SkJ4IQbqBfzC3Wifxo6g6re7OKQ58aUAevCwg9YiXOg3lWlhA4txaySqM3F6+5Aitzj27MnISdhTiUx5qtcSv8AK25DNyzruOihE0hJjEblS33wI3ENLy5lkIheP3S/OeGUgTOkqW/QJePBHHdSrYEIJzrAieAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728928472; c=relaxed/simple;
	bh=Zm0HShdFQ+d2zWw7auh7jXsJTAswApiih38ucKNWT30=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ousv7EivtTZmQqnpKmGzD5G+WfL6JyGdccNc9qrAEtDowAQzK3tih18kuRlIqUoImcozeZNlGE/5eC7abx5nqlqKh/wS0azYjwSsGSz/QFJJ51bpycgbDq4Z/iVFuE6twH64KkixAC7oEIw8ua0fc3NCGcDgXddCEt85k8cwTFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com; spf=pass smtp.mailfrom=tenstorrent.com; dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b=I3oDF6nL; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tenstorrent.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7ea7e250c54so881358a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 10:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tenstorrent.com; s=google; t=1728928470; x=1729533270; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ehWwjmU9hAOqAMUOWeKIHlX8tN0mNj/IrInipbL2fO8=;
        b=I3oDF6nL5kx8QD7z7lFFqITUdozvQnfZ33ubwhOt5Dop24tV/R6wunFhWPmijyYhl6
         ZJL2bbpk0PPX0s183IjXCaPly7yc1n2CF/NwHStPhrUqiuOIb7He36XvnhgfzXpSaYh7
         CHITeO8Q9+VE+eRcWvJZX6Dd7fTnQbo4Uo8C9+lJ3lUQzpafq0u1iL0bEJJzyyE/Zq1D
         LcpUEWH27lqzZYjsaoDf06FDrVvPWLTFGnlrI+yp7IoivpDXb4P+IcKsNmsFvCr4d942
         wH4d6eH44PcN3fr1XMEAE5E+WUl1z7Jme35WtBAcSWz60RQIdYYamI+aGe3d9BFIrFRq
         fQ/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728928470; x=1729533270;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ehWwjmU9hAOqAMUOWeKIHlX8tN0mNj/IrInipbL2fO8=;
        b=pcv1ioMQDmS1Y0IKoQ7myVNjwvw4FdMjZdLg4vgPm7SyEY+RyvmFIHhZYW99pXFN8v
         vqXf1XsvwQLIIpGfgeK/75Ow0HxuOZ+R57T18hW+KZNwBH+z+FMgaF+S5d+h/0kVyUzt
         c6mzLH1ZMEG+7hPdl32vfG9o4HxV4XDECeAVb3f8k1M36B2fI+5MKTS8Dm4KQ1QxtTaE
         iXiSJmoqRYnV79xXogJb4AO4ZLFeZZpb8LDcgLC3FBVvXBSrKFb43kSvnpk5apbdoeA2
         xNNymqb0FdMm7G1VQfaQhuPKBPn4nUY/vvXo1uFtmDGzU5PVJxAQk1An/SPoDYxUsDaW
         45uA==
X-Forwarded-Encrypted: i=1; AJvYcCWp4QnzdABmG1gHbobm0t00hkIy4aTpYaJFxx3c2e+FlEeDWNVSsD2Nl0a6yK7r+my7pWLn9kGY83t6sGI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDBmLZoEyOH5np1GKJIKseTU+6HVKXWWHN0jRRJvqeB4QClL43
	7p5Rjf0X9zxYzB5tGPOPFV4dv9tMiILeM/ypdpHrJ/XgNKflbldBKAnLg+qEFM4=
X-Google-Smtp-Source: AGHT+IFpeRJRsm2cHiu1T3j3d9xtFI+KxEdYvrO5Pv2dkk4eBm6gnbj2n7uXlqF6jkG+oC+C5j473A==
X-Received: by 2002:a05:6a20:d808:b0:1d7:8fd:2df6 with SMTP id adf61e73a8af0-1d8c9577029mr13745197637.1.1728928469852;
        Mon, 14 Oct 2024 10:54:29 -0700 (PDT)
Received: from [127.0.1.1] (71-34-69-82.ptld.qwest.net. [71.34.69.82])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e49a7e5e7sm5611109b3a.179.2024.10.14.10.54.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 10:54:28 -0700 (PDT)
From: Drew Fustini <dfustini@tenstorrent.com>
Date: Mon, 14 Oct 2024 10:54:18 -0700
Subject: [PATCH 1/8] riscv: dts: thead: Add TH1520 pin control nodes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241014-th1520-pinctrl-dts-v1-1-268592ca786e@tenstorrent.com>
References: <20241014-th1520-pinctrl-dts-v1-0-268592ca786e@tenstorrent.com>
In-Reply-To: <20241014-th1520-pinctrl-dts-v1-0-268592ca786e@tenstorrent.com>
To: Emil Renner Berthing <emil.renner.berthing@canonical.com>, 
 Drew Fustini <drew@pdp7.com>, Guo Ren <guoren@kernel.org>, 
 Fu Wei <wefu@redhat.com>, Linus Walleij <linus.walleij@linaro.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Thomas Bonnefille <thomas.bonnefille@bootlin.com>, 
 Kanak Shilledar <kanakshilledar@gmail.com>
Cc: linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Drew Fustini <dfustini@tenstorrent.com>
X-Mailer: b4 0.14.1

From: Emil Renner Berthing <emil.renner.berthing@canonical.com>

Add nodes for pin controllers on the T-Head TH1520 RISC-V SoC.

Add the missing aonsys_clk for the always-on pin controller as there is
not yet an aon subsys clock controller driver.

Acked-by: Linus Walleij <linus.walleij@linaro.org>
Tested-by: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
Signed-off-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
[dfustini: modify description as there is now an ap_subsys clk driver]
Signed-off-by: Drew Fustini <dfustini@tenstorrent.com>
---
 arch/riscv/boot/dts/thead/th1520.dtsi | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/riscv/boot/dts/thead/th1520.dtsi b/arch/riscv/boot/dts/thead/th1520.dtsi
index 6992060e6a54..93c17f52fbe9 100644
--- a/arch/riscv/boot/dts/thead/th1520.dtsi
+++ b/arch/riscv/boot/dts/thead/th1520.dtsi
@@ -216,6 +216,13 @@ osc_32k: 32k-oscillator {
 		#clock-cells = <0>;
 	};
 
+	aonsys_clk: clock-73728000 {
+		compatible = "fixed-clock";
+		clock-frequency = <73728000>;
+		clock-output-names = "aonsys_clk";
+		#clock-cells = <0>;
+	};
+
 	soc {
 		compatible = "simple-bus";
 		interrupt-parent = <&plic>;
@@ -354,6 +361,13 @@ portd: gpio-controller@0 {
 			};
 		};
 
+		padctrl1_apsys: pinctrl@ffe7f3c000 {
+			compatible = "thead,th1520-pinctrl";
+			reg = <0xff 0xe7f3c000 0x0 0x1000>;
+			clocks = <&clk CLK_PADCTRL1>;
+			thead,pad-group = <2>;
+		};
+
 		gpio0: gpio@ffec005000 {
 			compatible = "snps,dw-apb-gpio";
 			reg = <0xff 0xec005000 0x0 0x1000>;
@@ -392,6 +406,13 @@ portb: gpio-controller@0 {
 			};
 		};
 
+		padctrl0_apsys: pinctrl@ffec007000 {
+			compatible = "thead,th1520-pinctrl";
+			reg = <0xff 0xec007000 0x0 0x1000>;
+			clocks = <&clk CLK_PADCTRL0>;
+			thead,pad-group = <3>;
+		};
+
 		uart2: serial@ffec010000 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0xff 0xec010000 0x0 0x4000>;
@@ -538,6 +559,13 @@ porte: gpio-controller@0 {
 			};
 		};
 
+		padctrl_aosys: pinctrl@fffff4a000 {
+			compatible = "thead,th1520-pinctrl";
+			reg = <0xff 0xfff4a000 0x0 0x2000>;
+			clocks = <&aonsys_clk>;
+			thead,pad-group = <1>;
+		};
+
 		ao_gpio1: gpio@fffff52000 {
 			compatible = "snps,dw-apb-gpio";
 			reg = <0xff 0xfff52000 0x0 0x1000>;

-- 
2.34.1


