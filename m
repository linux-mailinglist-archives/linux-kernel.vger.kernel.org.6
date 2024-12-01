Return-Path: <linux-kernel+bounces-426660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 641779DF659
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 17:01:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45F6C161A9D
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 16:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 937CB1D6DB0;
	Sun,  1 Dec 2024 16:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TfHyVMi3"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 283EC1D63E7;
	Sun,  1 Dec 2024 16:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733068856; cv=none; b=TQDcq41INAq93hEDzBLYX5bo92lJu97+vu0gclLUGjUoC6E+C8MQnmRTK7smj0n116HmDtNkh4covy+KczIiFtUNytJ2xCCYAEbuj9XD3cXwln8ZnyZI4MkU8CajE60UnhUIdaQ1Hhf1ITkaOTkTuX7HGaTDcXZ9H4xi2qMzJ5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733068856; c=relaxed/simple;
	bh=RMyctZ3lQkmlH7EoPEk8LuXFNMdtp6CSZL620VxW2L0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hAVQkBf3tvL05Nv1cvMLyGUOB6afGpVapmwefsviCRvTC2qL6M3dxGf9NC+WQgqfNWI3Nelwt02uHL4hBKIGJAl04htR5YwVqvoSAsUFh1zpHNhIvN3dcKIwnX1+F8IYBhohtLGgQuvcRTq9TEfto3cCbTV2Up/CorfgsPl5lDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TfHyVMi3; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2ee8647dbb9so656943a91.2;
        Sun, 01 Dec 2024 08:00:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733068853; x=1733673653; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sl28JqWAO2ybsrZo9PmNBAZP6X7ZfV2uPmJyx9zghZ4=;
        b=TfHyVMi3S6yjX41gIzuB9eHViyrvKaya6bP3erxZ1LY1+AvyO2o+AyrCkLhTlMSi9j
         pOnOdZgNf0+W/Z3zeQPdMEcIB+7bbPLBp/QTJEZIO5L1DdVqQgbIx1+QyGnuuoTLYibM
         BgzqlvFydKxirLo9E0QI3o+Uu1vIJagmP0pjJ15gnfBpaWO3dLClBNEJVzsbDSX83oQD
         t4wV1tUZZkYdvZju8Jh+uBWnGfPBGhcEQBc8FRF/ddNr8aRrxrrBZuT4OJ16D/jgrLFe
         uifXXJnvY4MV/bvLyvZmYv8NYSGQpM+fQGnaN7MVq7zYzDHHtwRtRfb7PUD52XqRAJO/
         YuOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733068853; x=1733673653;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sl28JqWAO2ybsrZo9PmNBAZP6X7ZfV2uPmJyx9zghZ4=;
        b=H6cp2xENqLU4Pci1ezWYygoaKoIpmOkj8SFfhJY7FH2f5FwTxW6tTWiES6mtZZgaSo
         6Kpy8rtFlKmyEZUTR1rIPo1cHiljrd+q3J7ht8l3EAJgOqKHglBXzMD+55x4B4qA8izX
         2yvafAedYjQ1+NrxlSywk+P0e7PJZ1XOJCP5NgaYJkubr54OXxxPy4wFvobWW1FLtUC0
         ///VhunYRBJml1h/FCsEGiKDzlM4Qf8tiHdDV710bH29bX7SgrXfaHRg9yP7TXPIgigs
         TPLyvlYKgTvMrA4//rHEZeqcJGPVx7ieNGvVlsoDH9uKIeNuYsT6vPEDESd6d1GV4g7P
         A3/A==
X-Forwarded-Encrypted: i=1; AJvYcCUVZUdJahAV7o0CjtqHZ4yR2DXpHwiKs0kwVAQhgy7e5R9rJUll0ikL4JURPDmlsS3g6UXHCo+bEEyjARuv@vger.kernel.org, AJvYcCWZYHiKp+31rDQMA5SYgiwP71WvLOaODzJRdE8ayi5quzayKRd0OBawVlceyFO/dbiD+3GIqN4wfAX9@vger.kernel.org
X-Gm-Message-State: AOJu0YxBfDekRTVGkTZI+sP1FBLMZ7rAbEpbFfcoqeetL8u3/8idSJux
	v2WBeXz1o8Kr21zRXpzXpp7RM3s7J1i6Vf2nq8/yFD+znZI/VSvj
X-Gm-Gg: ASbGncs8HZufKiJnh78jf2UU+gMNTOPNOOG+ijH5w5cDEd4hn0RxxHkBYX3J9gHE6Uy
	+QVDpehCosw68hbjc+H9zuhSIKlRpO9vr5oBI5ojBzbL3PevT+/DBRLkaO4VtduFkiYP4SLdQGT
	VIpU4MS2csV+0x7i/uRHiQTN6bcaJFmf4VnpImbNoQcPmjsK61DvJA7RJ3RYdgDaaIjjXSG7vY3
	s+yhq8wpjK+bFFyqSyI8SokXmflPpekD08WxZk01op7PM5W18g0kbtcRs9IqrKyrA==
X-Google-Smtp-Source: AGHT+IFFQ953tAp965nbxYYWnP6Y/VoI2HPzD5IYA8zq7+UqjpUucWR6MFtasAGcxD2h+waTEA8DYA==
X-Received: by 2002:a17:90b:4d0d:b0:2ea:5dea:eb0a with SMTP id 98e67ed59e1d1-2ee08e5b8a3mr24534713a91.4.1733068853144;
        Sun, 01 Dec 2024 08:00:53 -0800 (PST)
Received: from localhost.localdomain ([59.188.211.160])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-2ee6ebc4a73sm2395173a91.0.2024.12.01.08.00.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Dec 2024 08:00:52 -0800 (PST)
From: Nick Chan <towinchenmi@gmail.com>
To: Hector Martin <marcan@marcan.st>,
	Sven Peter <sven@svenpeter.dev>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Nick Chan <towinchenmi@gmail.com>
Subject: [PATCH v4 04/10] arm64: dts: apple: t7000: Add PMGR node
Date: Sun,  1 Dec 2024 23:56:41 +0800
Message-ID: <20241201155820.29259-5-towinchenmi@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241201155820.29259-1-towinchenmi@gmail.com>
References: <20241201155820.29259-1-towinchenmi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds the PMGR node and all known power state subnodes. Since there
are a large number of them, let's put them in a separate file to include.

Acked-by: Hector Martin <marcan@marcan.st>
Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 arch/arm64/boot/dts/apple/t7000-6.dtsi     |   4 +
 arch/arm64/boot/dts/apple/t7000-j42d.dts   |   1 +
 arch/arm64/boot/dts/apple/t7000-mini4.dtsi |   4 +
 arch/arm64/boot/dts/apple/t7000-n102.dts   |   4 +
 arch/arm64/boot/dts/apple/t7000-pmgr.dtsi  | 641 +++++++++++++++++++++
 arch/arm64/boot/dts/apple/t7000.dtsi       |  14 +
 6 files changed, 668 insertions(+)
 create mode 100644 arch/arm64/boot/dts/apple/t7000-pmgr.dtsi

diff --git a/arch/arm64/boot/dts/apple/t7000-6.dtsi b/arch/arm64/boot/dts/apple/t7000-6.dtsi
index f60ea4a4a387..77d74d6af1c4 100644
--- a/arch/arm64/boot/dts/apple/t7000-6.dtsi
+++ b/arch/arm64/boot/dts/apple/t7000-6.dtsi
@@ -48,3 +48,7 @@ switch-mute {
 		};
 	};
 };
+
+&framebuffer0 {
+	power-domains = <&ps_disp0 &ps_mipi_dsi>;
+};
diff --git a/arch/arm64/boot/dts/apple/t7000-j42d.dts b/arch/arm64/boot/dts/apple/t7000-j42d.dts
index 2231db6a739d..4de5e6a3f230 100644
--- a/arch/arm64/boot/dts/apple/t7000-j42d.dts
+++ b/arch/arm64/boot/dts/apple/t7000-j42d.dts
@@ -20,6 +20,7 @@ chosen {
 		framebuffer0: framebuffer@0 {
 			compatible = "apple,simple-framebuffer", "simple-framebuffer";
 			reg = <0 0 0 0>; /* To be filled by loader */
+			power-domains = <&ps_disp0 &ps_dp>;
 			/* Format properties will be added by loader */
 			status = "disabled";
 		};
diff --git a/arch/arm64/boot/dts/apple/t7000-mini4.dtsi b/arch/arm64/boot/dts/apple/t7000-mini4.dtsi
index c64ddc402fda..e5a9656045f2 100644
--- a/arch/arm64/boot/dts/apple/t7000-mini4.dtsi
+++ b/arch/arm64/boot/dts/apple/t7000-mini4.dtsi
@@ -49,3 +49,7 @@ switch-mute {
 		};
 	};
 };
+
+&framebuffer0 {
+	power-domains = <&ps_disp0 &ps_dp>;
+};
diff --git a/arch/arm64/boot/dts/apple/t7000-n102.dts b/arch/arm64/boot/dts/apple/t7000-n102.dts
index 9c55d339ba4e..99eb8a2b8c73 100644
--- a/arch/arm64/boot/dts/apple/t7000-n102.dts
+++ b/arch/arm64/boot/dts/apple/t7000-n102.dts
@@ -46,3 +46,7 @@ button-volup {
 		};
 	};
 };
+
+&framebuffer0 {
+	power-domains = <&ps_disp0 &ps_mipi_dsi>;
+};
diff --git a/arch/arm64/boot/dts/apple/t7000-pmgr.dtsi b/arch/arm64/boot/dts/apple/t7000-pmgr.dtsi
new file mode 100644
index 000000000000..5948fa7afffc
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/t7000-pmgr.dtsi
@@ -0,0 +1,641 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * PMGR Power domains for the Apple T7000 "A8" SoC
+ *
+ * Copyright (c) 2024, Nick Chan <towinchenmi@gmail.com>
+ */
+&pmgr {
+	ps_cpu0: power-controller@20000 {
+		compatible = "apple,t7000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x20000 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "cpu0";
+		apple,always-on; /* Core device */
+	};
+
+	ps_cpu1: power-controller@20008 {
+		compatible = "apple,t7000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x20008 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "cpu1";
+		apple,always-on; /* Core device */
+	};
+
+	ps_cpm: power-controller@20040 {
+		compatible = "apple,t7000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x20040 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "cpm";
+		apple,always-on; /* Core device */
+	};
+
+	ps_sio_p: power-controller@201f8 {
+		compatible = "apple,t7000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x201f8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "sio_p";
+	};
+
+	ps_lio: power-controller@20100 {
+		compatible = "apple,t7000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x20100 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "lio";
+		apple,always-on; /* Core device */
+	};
+
+	ps_iomux: power-controller@20108 {
+		compatible = "apple,t7000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x20108 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "iomux";
+		apple,always-on; /* Core device */
+	};
+
+	ps_aic: power-controller@20110 {
+		compatible = "apple,t7000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x20110 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "aic";
+		apple,always-on; /* Core device */
+	};
+
+	ps_debug: power-controller@20118 {
+		compatible = "apple,t7000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x20118 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "debug";
+	};
+
+	ps_dwi: power-controller@20120 {
+		compatible = "apple,t7000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x20120 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "dwi";
+	};
+
+	ps_gpio: power-controller@20128 {
+		compatible = "apple,t7000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x20128 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "gpio";
+	};
+
+	ps_mca0: power-controller@20130 {
+		compatible = "apple,t7000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x20130 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "mca0";
+		power-domains = <&ps_sio_p>;
+	};
+
+	ps_mca1: power-controller@20138 {
+		compatible = "apple,t7000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x20138 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "mca1";
+		power-domains = <&ps_sio_p>;
+	};
+
+	ps_mca2: power-controller@20140 {
+		compatible = "apple,t7000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x20140 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "mca2";
+		power-domains = <&ps_sio_p>;
+	};
+
+	ps_mca3: power-controller@20148 {
+		compatible = "apple,t7000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x20148 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "mca3";
+		power-domains = <&ps_sio_p>;
+	};
+
+	ps_mca4: power-controller@20150 {
+		compatible = "apple,t7000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x20150 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "mca4";
+		power-domains = <&ps_sio_p>;
+	};
+
+	ps_pwm0: power-controller@20158 {
+		compatible = "apple,t7000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x20158 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "pwm0";
+		power-domains = <&ps_sio_p>;
+	};
+
+	ps_i2c0: power-controller@20160 {
+		compatible = "apple,t7000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x20160 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "i2c0";
+		power-domains = <&ps_sio_p>;
+	};
+
+	ps_i2c1: power-controller@20168 {
+		compatible = "apple,t7000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x20168 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "i2c1";
+		power-domains = <&ps_sio_p>;
+	};
+
+	ps_i2c2: power-controller@20170 {
+		compatible = "apple,t7000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x20170 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "i2c2";
+		power-domains = <&ps_sio_p>;
+	};
+
+	ps_i2c3: power-controller@20178 {
+		compatible = "apple,t7000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x20178 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "i2c3";
+		power-domains = <&ps_sio_p>;
+	};
+
+	ps_spi0: power-controller@20180 {
+		compatible = "apple,t7000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x20180 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "spi0";
+		power-domains = <&ps_sio_p>;
+	};
+
+	ps_spi1: power-controller@20188 {
+		compatible = "apple,t7000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x20188 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "spi1";
+		power-domains = <&ps_sio_p>;
+	};
+
+	ps_spi2: power-controller@20190 {
+		compatible = "apple,t7000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x20190 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "spi2";
+		power-domains = <&ps_sio_p>;
+	};
+
+	ps_spi3: power-controller@20198 {
+		compatible = "apple,t7000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x20198 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "spi3";
+		power-domains = <&ps_sio_p>;
+	};
+
+	ps_uart0: power-controller@201a0 {
+		compatible = "apple,t7000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x201a0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "uart0";
+		power-domains = <&ps_sio_p>;
+	};
+
+	ps_uart1: power-controller@201a8 {
+		compatible = "apple,t7000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x201a8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "uart1";
+		power-domains = <&ps_sio_p>;
+	};
+
+	ps_uart2: power-controller@201b0 {
+		compatible = "apple,t7000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x201b0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "uart2";
+		power-domains = <&ps_sio_p>;
+	};
+
+	ps_uart3: power-controller@201b8 {
+		compatible = "apple,t7000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x201b8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "uart3";
+		power-domains = <&ps_sio_p>;
+	};
+
+	ps_uart4: power-controller@201c0 {
+		compatible = "apple,t7000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x201c0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "uart4";
+		power-domains = <&ps_sio_p>;
+	};
+
+	ps_uart5: power-controller@201c8 {
+		compatible = "apple,t7000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x201c8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "uart5";
+		power-domains = <&ps_sio_p>;
+	};
+
+	ps_uart6: power-controller@201d0 {
+		compatible = "apple,t7000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x201d0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "uart6";
+		power-domains = <&ps_sio_p>;
+	};
+
+	ps_uart7: power-controller@201d8 {
+		compatible = "apple,t7000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x201d8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "uart7";
+		power-domains = <&ps_sio_p>;
+	};
+
+	ps_uart8: power-controller@201e0 {
+		compatible = "apple,t7000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x201e0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "uart8";
+		power-domains = <&ps_sio_p>;
+	};
+
+	ps_aes0: power-controller@201e8 {
+		compatible = "apple,t7000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x201e8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "aes0";
+		power-domains = <&ps_sio_p>;
+	};
+
+	ps_sio: power-controller@201f0 {
+		compatible = "apple,t7000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x201f0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "sio";
+		power-domains = <&ps_sio_p>;
+		apple,always-on; /* Core device */
+	};
+
+	ps_usb: power-controller@20248 {
+		compatible = "apple,t7000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x20248 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "usb";
+	};
+
+	ps_usbctrl: power-controller@20250 {
+		compatible = "apple,t7000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x20250 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "usbctrl";
+		power-domains = <&ps_usb>;
+	};
+
+	ps_usb2host0: power-controller@20258 {
+		compatible = "apple,t7000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x20258 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "usb2host0";
+		power-domains = <&ps_usbctrl>;
+	};
+
+	ps_usb2host1: power-controller@20268 {
+		compatible = "apple,t7000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x20268 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "usb2host1";
+		power-domains = <&ps_usbctrl>;
+	};
+
+	ps_usb2host2: power-controller@20278 {
+		compatible = "apple,t7000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x20278 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "usb2host2";
+		power-domains = <&ps_usbctrl>;
+	};
+
+	ps_disp_busmux: power-controller@202a8 {
+		compatible = "apple,t7000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x202a8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "disp_busmux";
+	};
+
+	ps_media: power-controller@202d8 {
+		compatible = "apple,t7000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x202d8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "media";
+	};
+
+	ps_isp: power-controller@202d0 {
+		compatible = "apple,t7000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x202d0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "isp";
+	};
+
+	ps_msr: power-controller@202e0 {
+		compatible = "apple,t7000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x202e0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "msr";
+		power-domains = <&ps_media>;
+	};
+
+	ps_jpg: power-controller@202e8 {
+		compatible = "apple,t7000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x202e8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "jpg";
+		power-domains = <&ps_media>;
+	};
+
+	ps_disp0: power-controller@202b0 {
+		compatible = "apple,t7000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x202b0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "disp0";
+		power-domains = <&ps_disp_busmux>;
+	};
+
+	ps_disp1: power-controller@202c8 {
+		compatible = "apple,t7000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x202c8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "disp1";
+		power-domains = <&ps_disp_busmux>;
+	};
+
+	ps_pcie_ref: power-controller@20220 {
+		compatible = "apple,t7000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x20220 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "pcie_ref";
+	};
+
+	ps_hsic0_phy: power-controller@20200 {
+		compatible = "apple,t7000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x20200 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "hsic0_phy";
+		power-domains = <&ps_usb2host1>;
+	};
+
+	ps_hsic1_phy: power-controller@20208 {
+		compatible = "apple,t7000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x20208 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "hsic1_phy";
+		power-domains = <&ps_usb2host2>;
+	};
+
+	ps_ispsens0: power-controller@20210 {
+		compatible = "apple,t7000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x20210 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "ispsens0";
+	};
+
+	ps_ispsens1: power-controller@20218 {
+		compatible = "apple,t7000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x20218 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "ispsens1";
+	};
+
+	ps_mcc: power-controller@20230 {
+		compatible = "apple,t7000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x20230 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "mcc";
+		apple,always-on; /* Memory cache controller */
+	};
+
+	ps_mcu: power-controller@20238 {
+		compatible = "apple,t7000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x20238 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "mcu";
+		apple,always-on; /* Core device */
+	};
+
+	ps_amp: power-controller@20240 {
+		compatible = "apple,t7000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x20240 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "amp";
+		apple,always-on; /* Core device */
+	};
+
+	ps_usb2host0_ohci: power-controller@20260 {
+		compatible = "apple,t7000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x20260 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "usb2host0_ohci";
+		power-domains = <&ps_usb2host0>;
+	};
+
+	ps_usbotg: power-controller@20288 {
+		compatible = "apple,t7000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x20288 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "usbotg";
+		power-domains = <&ps_usbctrl>;
+	};
+
+	ps_smx: power-controller@20290 {
+		compatible = "apple,t7000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x20290 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "smx";
+		apple,always-on; /* Apple Fabric, critical block */
+	};
+
+	ps_sf: power-controller@20298 {
+		compatible = "apple,t7000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x20298 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "sf";
+		apple,always-on; /* Apple Fabric, critical block */
+	};
+
+	ps_cp: power-controller@202a0 {
+		compatible = "apple,t7000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x202a0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "cp";
+		apple,always-on; /* Core device */
+	};
+
+	ps_mipi_dsi: power-controller@202b8 {
+		compatible = "apple,t7000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x202b8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "mipi_dsi";
+		power-domains = <&ps_disp_busmux>;
+	};
+
+	ps_dp: power-controller@202c0 {
+		compatible = "apple,t7000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x202c0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "dp";
+		power-domains = <&ps_disp0>;
+	};
+
+	ps_vdec: power-controller@202f0 {
+		compatible = "apple,t7000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x202f0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "vdec";
+		power-domains = <&ps_media>;
+	};
+
+	ps_ans: power-controller@20318 {
+		compatible = "apple,t7000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x20318 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "ans";
+	};
+
+	ps_venc: power-controller@20300 {
+		compatible = "apple,t7000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x20300 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "venc";
+		power-domains = <&ps_media>;
+	};
+
+	ps_pcie: power-controller@20308 {
+		compatible = "apple,t7000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x20308 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "pcie";
+	};
+
+	ps_pcie_aux: power-controller@20310 {
+		compatible = "apple,t7000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x20310 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "pcie_aux";
+	};
+
+	ps_gfx: power-controller@20320 {
+		compatible = "apple,t7000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x20320 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "gfx";
+	};
+
+	ps_sep: power-controller@20400 {
+		compatible = "apple,t7000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x20400 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "sep";
+		apple,always-on; /* Locked on */
+	};
+
+	ps_venc_pipe: power-controller@21000 {
+		compatible = "apple,t7000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x21000 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "venc_pipe";
+		power-domains = <&ps_venc>;
+	};
+
+	ps_venc_me0: power-controller@21008 {
+		compatible = "apple,t7000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x21008 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "venc_me0";
+		power-domains = <&ps_venc>;
+	};
+
+	ps_venc_me1: power-controller@21010 {
+		compatible = "apple,t7000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x21010 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "venc_me1";
+		power-domains = <&ps_venc>;
+	};
+};
diff --git a/arch/arm64/boot/dts/apple/t7000.dtsi b/arch/arm64/boot/dts/apple/t7000.dtsi
index a7cc29e84c84..ed1e9a62ba05 100644
--- a/arch/arm64/boot/dts/apple/t7000.dtsi
+++ b/arch/arm64/boot/dts/apple/t7000.dtsi
@@ -62,6 +62,7 @@ serial0: serial@20a0c0000 {
 			/* Use the bootloader-enabled clocks for now. */
 			clocks = <&clkref>, <&clkref>;
 			clock-names = "uart", "clk_uart_baud0";
+			power-domains = <&ps_uart0>;
 			status = "disabled";
 		};
 
@@ -74,9 +75,18 @@ serial6: serial@20a0d8000 {
 			/* Use the bootloader-enabled clocks for now. */
 			clocks = <&clkref>, <&clkref>;
 			clock-names = "uart", "clk_uart_baud0";
+			power-domains = <&ps_uart6>;
 			status = "disabled";
 		};
 
+		pmgr: power-management@20e000000 {
+			compatible = "apple,t7000-pmgr", "apple,pmgr", "syscon", "simple-mfd";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			reg = <0x2 0xe000000 0 0x24000>;
+		};
+
 		wdt: watchdog@20e027000 {
 			compatible = "apple,t7000-wdt", "apple,wdt";
 			reg = <0x2 0x0e027000 0x0 0x1000>;
@@ -90,11 +100,13 @@ aic: interrupt-controller@20e100000 {
 			reg = <0x2 0x0e100000 0x0 0x100000>;
 			#interrupt-cells = <3>;
 			interrupt-controller;
+			power-domains = <&ps_aic>;
 		};
 
 		pinctrl: pinctrl@20e300000 {
 			compatible = "apple,t7000-pinctrl", "apple,pinctrl";
 			reg = <0x2 0x0e300000 0x0 0x100000>;
+			power-domains = <&ps_gpio>;
 
 			gpio-controller;
 			#gpio-cells = <2>;
@@ -123,3 +135,5 @@ timer {
 			     <AIC_FIQ AIC_TMR_GUEST_VIRT IRQ_TYPE_LEVEL_HIGH>;
 	};
 };
+
+#include "t7000-pmgr.dtsi"
-- 
2.47.1


