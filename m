Return-Path: <linux-kernel+bounces-418062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B08849D5C8F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 10:56:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F40A1F2154C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 09:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F409D1DEFFD;
	Fri, 22 Nov 2024 09:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PIal3RC1"
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54A881DED55;
	Fri, 22 Nov 2024 09:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732269303; cv=none; b=OvHR982Ax48MYNR1Ld1RdhSZ3IMW5gtOsWNo8KZlDsAzo2I1G5eFOUObsrT7wuL7HMV53Uj4FlfXvBxgHrWEy1uomceXnJTr3X6x7gaCDg2/HjvYYPaQdXdGi6Q1vbQIemWFUniIPWW6XE2A0M9yAZDHVvQSY5wrjQL1d9jBU5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732269303; c=relaxed/simple;
	bh=I91VvFzPAQ/Zx1c1+di+QnLRSJTu6reh4cILL95Vhy4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=joSF+opapRFqDTetb4mo9qhKzePrSzjyPFe1+B0UGNl7XS8zntT7lLGhCtMGabv6Fi/m3XluccahWoTV5DaQfYhQbG6caqqUd9QHyacGVMK0VlbW6cCE45F9kp2MqAz/9h1l3GNSqUh84oV9L5aFChlRF1waqGB0fD3F2LvUWoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PIal3RC1; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7181885ac34so977574a34.3;
        Fri, 22 Nov 2024 01:54:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732269298; x=1732874098; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rSuU39vOJYtf9VtmpOzMUCozYFfB9Bn62QzyUlAKjkI=;
        b=PIal3RC1VASa3+z4t4Z/tu070Q8zzwPex/XZmCwH3MX2GegAcdc6ZByXhZrrZ3JuaF
         xBhmKesVKQYjzWRYJkABRwUn5OaN3ax2wf6WN9Jrs5hFcZk25Mr26pr5XVpbqsapd8Gg
         N1lqLZTABkFOYiKhaaCTHBdE5ELLcG99IyBs7eqSlHRs9qpScnJ0TTT5yaWWErbVEKUq
         mM6jNIb3KO36DJmHWvkfIsocNoTmbr1JRLSTu4aWwiHxd+A6R0gISyTsQlv/nDRe75kQ
         PnDdh6z89Kj5LNGopT9PtLdKJDc1FR2/U7WfcOpgXbwycA827h9lS66e+wIYNF6A5vhf
         Wnog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732269298; x=1732874098;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rSuU39vOJYtf9VtmpOzMUCozYFfB9Bn62QzyUlAKjkI=;
        b=l5A9sTuHff6PWpat6JdZ4AYlG50H5DUiWB5DtVxFC2DCYktlDgTNN7z5FBAVzb0sLr
         L553hPX2c7YvIfM/jrQnKRM+RyIi6qLvmXNa5yWasYeDn0ZQluCv0JA6LzdT8MRCgeA7
         SRphng+ngolcN89uZ4BYcxmrQU0VAvMtOI2NHBTstkOmpLwoGrgwbaNRFddEMxz1KPq0
         90P8DoA9w6lEDnxNmj7Y9XBsClSK00fF/mMtAWx8Z+ogW3W65YvWV35cBnHhip+zv4Oz
         GGnhvL/uj/zQXs+0H+O+umc9+PSM7GS+UtSWGCq9Sj7kIEGt/7RQYLCSSWyVAy+RHy9/
         7IJg==
X-Forwarded-Encrypted: i=1; AJvYcCV7V1Bovjot3Z6UgoPE5zFFhu0b5jnMUTH9ZkJXVRcqZfKr12OLQ2Poa6QQb6fdQaNOnSGVwogq9iINBcxv@vger.kernel.org, AJvYcCXUkbbPZhIQ70nXdbxWVV9SNRh6vOtbh692sKf9pv9q868Ke/5pZjyQhxYF2DynRMHJGxXWSJ9wVT0b@vger.kernel.org
X-Gm-Message-State: AOJu0YzNYVRSda075UZ6Nq/OZ271pCMwnhSPXzJDrhOEpkuixeCWSv4y
	r47I7fnQQ64TtVpuwPTewkebzxvPOzUfXIpre+OIIN8GSfIVBYhJ
X-Gm-Gg: ASbGncvolFPoRYOtTLpm7aS+U1AgjIJOSWtCEjlN8GraauHQ5sZQpSX2xTvsqBRCNVV
	D1QrXcsdv4/TWlDgxq+8TUPHIerIES1aBzcAxwhg1UUVezeukI3jntQ25OhlrPSh+623s3Vw9va
	jFcEbbT1OGFN5vFtDquaSLFYNdNv59B5u4nP2/rxrd3bNkSDaAnPlm6ka5uaqljczngOImWy2Uh
	ys3eM8tp+4Uqd1k7kappD0xm6ClHvgulLS8oW9ebGWe+ckdtwP2HEzu7h77ZXSKtqw=
X-Google-Smtp-Source: AGHT+IHccqTaAG3U7PYCfkpnzKnbR8d6PviFz9S02jnxY8944kPir2vMuf7ack4KAZlfN9/Tm8lbVA==
X-Received: by 2002:a05:6830:6b0c:b0:718:9c03:d216 with SMTP id 46e09a7af769-71c04b9c922mr2524649a34.15.1732269298337;
        Fri, 22 Nov 2024 01:54:58 -0800 (PST)
Received: from localhost.localdomain ([182.152.110.125])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-7fbcc218a87sm1236332a12.39.2024.11.22.01.54.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 01:54:57 -0800 (PST)
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
Subject: [PATCH v3 RESEND 07/10] arm64: dts: apple: s8001: Add PMGR nodes
Date: Fri, 22 Nov 2024 17:50:36 +0800
Message-ID: <20241122095136.35046-8-towinchenmi@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241122095136.35046-1-towinchenmi@gmail.com>
References: <20241122095136.35046-1-towinchenmi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds the two PMGR nodes and all known power state subnodes. Since
there are a large number of them, let's put them in a separate file to
include.

Acked-by: Hector Martin <marcan@marcan.st>
Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 arch/arm64/boot/dts/apple/s8001-common.dtsi   |   1 +
 .../arm64/boot/dts/apple/s8001-j98a-j99a.dtsi |  26 +
 arch/arm64/boot/dts/apple/s8001-j98a.dts      |   1 +
 arch/arm64/boot/dts/apple/s8001-j99a.dts      |   1 +
 arch/arm64/boot/dts/apple/s8001-pmgr.dtsi     | 822 ++++++++++++++++++
 arch/arm64/boot/dts/apple/s8001.dtsi          |  22 +
 6 files changed, 873 insertions(+)
 create mode 100644 arch/arm64/boot/dts/apple/s8001-j98a-j99a.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/s8001-pmgr.dtsi

diff --git a/arch/arm64/boot/dts/apple/s8001-common.dtsi b/arch/arm64/boot/dts/apple/s8001-common.dtsi
index e94d0e77653a..91b06e113894 100644
--- a/arch/arm64/boot/dts/apple/s8001-common.dtsi
+++ b/arch/arm64/boot/dts/apple/s8001-common.dtsi
@@ -24,6 +24,7 @@ chosen {
 		framebuffer0: framebuffer@0 {
 			compatible = "apple,simple-framebuffer", "simple-framebuffer";
 			reg = <0 0 0 0>; /* To be filled by loader */
+			power-domains = <&ps_disp0 &ps_dp0>;
 			/* Format properties will be added by loader */
 			status = "disabled";
 		};
diff --git a/arch/arm64/boot/dts/apple/s8001-j98a-j99a.dtsi b/arch/arm64/boot/dts/apple/s8001-j98a-j99a.dtsi
new file mode 100644
index 000000000000..e66a4c1c138f
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/s8001-j98a-j99a.dtsi
@@ -0,0 +1,26 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Apple iPad Pro (12.9-inch)
+ *
+ * This file contains parts common to iPad Pro (12.9-inch).
+ *
+ * target-type: J98a, J99a
+ *
+ * Copyright (c) 2024, Nick Chan <towinchenmi@gmail.com>
+ */
+
+&ps_dcs4 {
+	apple,always-on; /* LPDDR4 interface */
+};
+
+&ps_dcs5 {
+	apple,always-on; /* LPDDR4 interface */
+};
+
+&ps_dcs6 {
+	apple,always-on; /* LPDDR4 interface */
+};
+
+&ps_dcs7 {
+	apple,always-on; /* LPDDR4 interface */
+};
diff --git a/arch/arm64/boot/dts/apple/s8001-j98a.dts b/arch/arm64/boot/dts/apple/s8001-j98a.dts
index 6d6b841e7ab0..162eca05c2d9 100644
--- a/arch/arm64/boot/dts/apple/s8001-j98a.dts
+++ b/arch/arm64/boot/dts/apple/s8001-j98a.dts
@@ -7,6 +7,7 @@
 /dts-v1/;
 
 #include "s8001-pro.dtsi"
+#include "s8001-j98a-j99a.dtsi"
 
 / {
 	compatible = "apple,j98a", "apple,s8001", "apple,arm-platform";
diff --git a/arch/arm64/boot/dts/apple/s8001-j99a.dts b/arch/arm64/boot/dts/apple/s8001-j99a.dts
index d20194b1cae7..7b765820c69e 100644
--- a/arch/arm64/boot/dts/apple/s8001-j99a.dts
+++ b/arch/arm64/boot/dts/apple/s8001-j99a.dts
@@ -7,6 +7,7 @@
 /dts-v1/;
 
 #include "s8001-pro.dtsi"
+#include "s8001-j98a-j99a.dtsi"
 
 / {
 	compatible = "apple,j99a", "apple,s8001", "apple,arm-platform";
diff --git a/arch/arm64/boot/dts/apple/s8001-pmgr.dtsi b/arch/arm64/boot/dts/apple/s8001-pmgr.dtsi
new file mode 100644
index 000000000000..859ab77ae92b
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/s8001-pmgr.dtsi
@@ -0,0 +1,822 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * PMGR Power domains for the Apple S8001 "A9X" SoC
+ *
+ * Copyright (c) 2024 Nick Chan <towinchenmi@gmail.com>
+ */
+
+&pmgr {
+	ps_cpu0: power-controller@80000 {
+		compatible = "apple,s8000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80000 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "cpu0";
+		apple,always-on; /* Core device */
+	};
+
+	ps_cpu1: power-controller@80008 {
+		compatible = "apple,s8000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80008 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "cpu1";
+		apple,always-on; /* Core device */
+	};
+
+	ps_cpm: power-controller@80040 {
+		compatible = "apple,s8000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80040 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "cpm";
+		apple,always-on; /* Core device */
+	};
+
+	ps_sio_busif: power-controller@80148 {
+		compatible = "apple,s8000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80148 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "sio_busif";
+	};
+
+	ps_sio_p: power-controller@80150 {
+		compatible = "apple,s8000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80150 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "sio_p";
+		power-domains = <&ps_sio_busif>;
+	};
+
+	ps_sbr: power-controller@80100 {
+		compatible = "apple,s8000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80100 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "sbr";
+		apple,always-on; /* Apple fabric, critical block */
+	};
+
+	ps_aic: power-controller@80108 {
+		compatible = "apple,s8000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80108 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "aic";
+		apple,always-on; /* Core device */
+	};
+
+	ps_dwi: power-controller@80110 {
+		compatible = "apple,s8000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80110 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "dwi";
+	};
+
+	ps_gpio: power-controller@80118 {
+		compatible = "apple,s8000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80118 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "gpio";
+	};
+
+	ps_pcie_ref: power-controller@80140 {
+		compatible = "apple,s8000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80140 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "pcie_ref";
+	};
+
+	ps_mca0: power-controller@80160 {
+		compatible = "apple,s8000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80160 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "mca0";
+		power-domains = <&ps_sio_p>;
+	};
+
+	ps_mca1: power-controller@80168 {
+		compatible = "apple,s8000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80168 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "mca1";
+		power-domains = <&ps_sio_p>;
+	};
+
+	ps_mca2: power-controller@80170 {
+		compatible = "apple,s8000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80170 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "mca2";
+		power-domains = <&ps_sio_p>;
+	};
+
+	ps_mca3: power-controller@80178 {
+		compatible = "apple,s8000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80178 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "mca3";
+		power-domains = <&ps_sio_p>;
+	};
+
+	ps_mca4: power-controller@80180 {
+		compatible = "apple,s8000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80180 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "mca4";
+		power-domains = <&ps_sio_p>;
+	};
+
+	ps_pwm0: power-controller@80188 {
+		compatible = "apple,s8000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80188 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "pwm0";
+		power-domains = <&ps_sio_p>;
+	};
+
+	ps_i2c0: power-controller@80190 {
+		compatible = "apple,s8000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80190 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "i2c0";
+		power-domains = <&ps_sio_p>;
+	};
+
+	ps_i2c1: power-controller@80198 {
+		compatible = "apple,s8000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80198 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "i2c1";
+		power-domains = <&ps_sio_p>;
+	};
+
+	ps_i2c2: power-controller@801a0 {
+		compatible = "apple,s8000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x801a0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "i2c2";
+		power-domains = <&ps_sio_p>;
+	};
+
+	ps_i2c3: power-controller@801a8 {
+		compatible = "apple,s8000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x801a8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "i2c3";
+		power-domains = <&ps_sio_p>;
+	};
+
+	ps_spi0: power-controller@801b0 {
+		compatible = "apple,s8000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x801b0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "spi0";
+		power-domains = <&ps_sio_p>;
+	};
+
+	ps_spi1: power-controller@801b8 {
+		compatible = "apple,s8000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x801b8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "spi1";
+		power-domains = <&ps_sio_p>;
+	};
+
+	ps_spi2: power-controller@801c0 {
+		compatible = "apple,s8000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x801c0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "spi2";
+		power-domains = <&ps_sio_p>;
+	};
+
+	ps_spi3: power-controller@801c8 {
+		compatible = "apple,s8000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x801c8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "spi3";
+		power-domains = <&ps_sio_p>;
+	};
+
+	ps_uart0: power-controller@801d0 {
+		compatible = "apple,s8000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x801d0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "uart0";
+		power-domains = <&ps_sio_p>;
+	};
+
+	ps_uart1: power-controller@801d8 {
+		compatible = "apple,s8000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x801d8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "uart1";
+		power-domains = <&ps_sio_p>;
+	};
+
+	ps_uart2: power-controller@801e0 {
+		compatible = "apple,s8000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x801e0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "uart2";
+		power-domains = <&ps_sio_p>;
+	};
+
+	ps_uart3: power-controller@801e8 {
+		compatible = "apple,s8000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x801e8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "uart3";
+		power-domains = <&ps_sio_p>;
+	};
+
+	ps_uart4: power-controller@801f0 {
+		compatible = "apple,s8000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x801f0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "uart4";
+		power-domains = <&ps_sio_p>;
+	};
+
+	ps_uart5: power-controller@801f8 {
+		compatible = "apple,s8000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x801f8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "uart5";
+		power-domains = <&ps_sio_p>;
+	};
+
+	ps_sio: power-controller@80158 {
+		compatible = "apple,s8000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80158 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "sio";
+		power-domains = <&ps_sio_p>;
+		apple,always-on; /* Core device */
+	};
+
+	ps_hsic0_phy: power-controller@80128 {
+		compatible = "apple,s8000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80128 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "hsic0_phy";
+		power-domains = <&ps_usb2host1>;
+	};
+
+	ps_isp_sens0: power-controller@80130 {
+		compatible = "apple,s8000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80130 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "isp_sens0";
+	};
+
+	ps_isp_sens1: power-controller@80138 {
+		compatible = "apple,s8000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80138 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "isp_sens1";
+	};
+
+	ps_pms: power-controller@80120 {
+		compatible = "apple,s8000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80120 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "pms";
+		apple,always-on; /* Core device */
+	};
+
+	ps_usb: power-controller@80278 {
+		compatible = "apple,s8000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80278 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "usb";
+	};
+
+	ps_usbctrl: power-controller@80280 {
+		compatible = "apple,s8000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80280 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "usbctrl";
+		power-domains = <&ps_usb>;
+	};
+
+	ps_usb2host0: power-controller@80288 {
+		compatible = "apple,s8000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80288 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "usb2host0";
+		power-domains = <&ps_usbctrl>;
+	};
+
+	ps_usb2host1: power-controller@80298 {
+		compatible = "apple,s8000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80298 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "usb2host1";
+		power-domains = <&ps_usbctrl>;
+	};
+
+	ps_usb2host2: power-controller@802a8 {
+		compatible = "apple,s8000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x802a8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "usb2host2";
+		power-domains = <&ps_usbctrl>;
+	};
+
+	ps_rtmux: power-controller@802d0 {
+		compatible = "apple,s8000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x802d0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "rtmux";
+		apple,always-on; /* Core device */
+	};
+
+	ps_disp1mux: power-controller@802e8 {
+		compatible = "apple,s8000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x802e8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "disp1mux";
+	};
+
+	ps_disp0: power-controller@802d8 {
+		compatible = "apple,s8000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x802d8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "disp0";
+		power-domains = <&ps_rtmux>;
+	};
+
+	ps_disp1: power-controller@802f0 {
+		compatible = "apple,s8000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x802f0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "disp1";
+		power-domains = <&ps_disp1mux>;
+	};
+
+	ps_uart6: power-controller@80200 {
+		compatible = "apple,s8000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80200 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "uart6";
+		power-domains = <&ps_sio_p>;
+	};
+
+	ps_uart7: power-controller@80208 {
+		compatible = "apple,s8000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80208 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "uart7";
+		power-domains = <&ps_sio_p>;
+	};
+
+	ps_uart8: power-controller@80210 {
+		compatible = "apple,s8000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80210 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "uart8";
+		power-domains = <&ps_sio_p>;
+	};
+
+	ps_aes0: power-controller@80218 {
+		compatible = "apple,s8000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80218 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "aes0";
+		power-domains = <&ps_sio_p>;
+	};
+
+	ps_mcc: power-controller@80230 {
+		compatible = "apple,s8000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80230 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "mcc";
+		apple,always-on; /* Memory cache controller */
+	};
+
+	ps_dcs0: power-controller@80238 {
+		compatible = "apple,s8000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80238 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "dcs0";
+		apple,always-on; /* LPDDR4 interface */
+	};
+
+	ps_dcs1: power-controller@80240 {
+		compatible = "apple,s8000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80240 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "dcs1";
+		apple,always-on; /* LPDDR4 interface */
+	};
+
+	ps_dcs2: power-controller@80248 {
+		compatible = "apple,s8000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80248 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "dcs2";
+		apple,always-on; /* LPDDR4 interface */
+	};
+
+	ps_dcs3: power-controller@80250 {
+		compatible = "apple,s8000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80250 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "dcs3";
+		apple,always-on; /* LPDDR4 interface */
+	};
+
+	ps_dcs4: power-controller@80258 {
+		compatible = "apple,s8000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80258 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "dcs4";
+	};
+
+	ps_dcs5: power-controller@80260 {
+		compatible = "apple,s8000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80260 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "dcs5";
+	};
+
+	ps_dcs6: power-controller@80268 {
+		compatible = "apple,s8000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80268 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "dcs6";
+	};
+
+	ps_dcs7: power-controller@80270 {
+		compatible = "apple,s8000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80270 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "dcs7";
+	};
+
+	ps_usb2host0_ohci: power-controller@80290 {
+		compatible = "apple,s8000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80290 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "usb2host0_ohci";
+		power-domains = <&ps_usb2host0>;
+	};
+
+	ps_usbotg: power-controller@802b8 {
+		compatible = "apple,s8000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x802b8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "usbotg";
+		power-domains = <&ps_usbctrl>;
+	};
+
+	ps_smx: power-controller@802c0 {
+		compatible = "apple,s8000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x802c0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "smx";
+		apple,always-on; /* Apple fabric, critical block */
+	};
+
+	ps_sf: power-controller@802c8 {
+		compatible = "apple,s8000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x802c8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "sf";
+		apple,always-on; /* Apple fabric, critical block */
+	};
+
+	ps_dp0: power-controller@802e0 {
+		compatible = "apple,s8000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x802e0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "dp0";
+		power-domains = <&ps_disp0>;
+	};
+
+	ps_dp1: power-controller@802f8 {
+		compatible = "apple,s8000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x802f8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "dp1";
+		power-domains = <&ps_disp1>;
+	};
+
+	ps_dpa0: power-controller@80220 {
+		compatible = "apple,s8000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80220 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "dpa0";
+	};
+
+	ps_dpa1: power-controller@80228 {
+		compatible = "apple,s8000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80228 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "dpa1";
+	};
+
+	ps_media: power-controller@80308 {
+		compatible = "apple,s8000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80308 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "media";
+	};
+
+	ps_isp: power-controller@80300 {
+		compatible = "apple,s8000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80300 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "isp";
+		power-domains = <&ps_rtmux>;
+	};
+
+	ps_msr: power-controller@80318 {
+		compatible = "apple,s8000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80318 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "msr";
+		power-domains = <&ps_media>;
+	};
+
+	ps_jpg: power-controller@80310 {
+		compatible = "apple,s8000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80310 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "jpg";
+		power-domains = <&ps_media>;
+	};
+
+	ps_venc: power-controller@80340 {
+		compatible = "apple,s8000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80340 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "venc";
+		power-domains = <&ps_media>;
+	};
+
+	ps_pcie: power-controller@80348 {
+		compatible = "apple,s8000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80348 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "pcie";
+	};
+
+	ps_srs: power-controller@80390 {
+		compatible = "apple,s8000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80390 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "srs";
+		power-domains = <&ps_media>;
+	};
+
+	ps_pcie_aux: power-controller@80350 {
+		compatible = "apple,s8000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80350 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "pcie_aux";
+	};
+
+	ps_pcie_link0: power-controller@80358 {
+		compatible = "apple,s8000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80358 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "pcie_link0";
+		power-domains = <&ps_pcie>;
+	};
+
+	ps_pcie_link1: power-controller@80360 {
+		compatible = "apple,s8000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80360 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "pcie_link1";
+		power-domains = <&ps_pcie>;
+	};
+
+	ps_pcie_link2: power-controller@80368 {
+		compatible = "apple,s8000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80368 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "pcie_link2";
+		power-domains = <&ps_pcie>;
+	};
+
+	ps_pcie_link3: power-controller@80370 {
+		compatible = "apple,s8000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80370 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "pcie_link3";
+		power-domains = <&ps_pcie>;
+	};
+
+	ps_pcie_link4: power-controller@80378 {
+		compatible = "apple,s8000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80378 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "pcie_link4";
+		power-domains = <&ps_pcie>;
+	};
+
+	ps_pcie_link5: power-controller@80380 {
+		compatible = "apple,s8000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80380 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "pcie_link5";
+		power-domains = <&ps_pcie>;
+	};
+
+	ps_vdec: power-controller@80330 {
+		compatible = "apple,s8000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80330 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "vdec";
+		power-domains = <&ps_media>;
+	};
+
+	ps_gfx: power-controller@80388 {
+		compatible = "apple,s8000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80388 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "gfx";
+	};
+
+	ps_pmp: power-controller@80320 {
+		compatible = "apple,s8000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80320 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "pmp";
+	};
+
+	ps_pms_sram: power-controller@80328 {
+		compatible = "apple,s8000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80328 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "pms_sram";
+	};
+
+	ps_sep: power-controller@80400 {
+		compatible = "apple,s8000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80400 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "sep";
+		apple,always-on; /* Locked on*/
+	};
+
+	ps_venc_pipe: power-controller@88000 {
+		compatible = "apple,s8000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x88000 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "venc_pipe";
+		power-domains = <&ps_venc>;
+	};
+
+	ps_venc_me0: power-controller@88008 {
+		compatible = "apple,s8000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x88008 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "venc_me0";
+	};
+
+	ps_venc_me1: power-controller@88010 {
+		compatible = "apple,s8000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x88010 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "venc_me1";
+	};
+};
+
+&pmgr_mini {
+	ps_aop: power-controller@80000 {
+		compatible = "apple,s8000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80000 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "aop";
+		power-domains = <&ps_aop_cpu &ps_aop_filter &ps_aop_busif>;
+		apple,always-on; /* Always on processor */
+	};
+
+	ps_debug: power-controller@80008 {
+		compatible = "apple,s8000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80008 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "debug";
+	};
+
+	ps_aop_gpio: power-controller@80010 {
+		compatible = "apple,s8000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80010 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "aop_gpio";
+	};
+
+	ps_aop_cpu: power-controller@80040 {
+		compatible = "apple,s8000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80040 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "aop_cpu";
+	};
+
+	ps_aop_filter: power-controller@80048 {
+		compatible = "apple,s8000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80048 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "aop_filter";
+	};
+
+	ps_aop_busif: power-controller@80050 {
+		compatible = "apple,s8000-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80050 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "aop_busif";
+	};
+};
diff --git a/arch/arm64/boot/dts/apple/s8001.dtsi b/arch/arm64/boot/dts/apple/s8001.dtsi
index 23ee3238844d..3963c6d8ca5e 100644
--- a/arch/arm64/boot/dts/apple/s8001.dtsi
+++ b/arch/arm64/boot/dts/apple/s8001.dtsi
@@ -61,19 +61,30 @@ serial0: serial@20a0c0000 {
 			/* Use the bootloader-enabled clocks for now. */
 			clocks = <&clkref>, <&clkref>;
 			clock-names = "uart", "clk_uart_baud0";
+			power-domains = <&ps_uart0>;
 			status = "disabled";
 		};
 
+		pmgr: power-management@20e000000 {
+			compatible = "apple,s8000-pmgr", "apple,pmgr", "syscon", "simple-mfd";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			reg = <0x2 0xe000000 0 0x8c000>;
+		};
+
 		aic: interrupt-controller@20e100000 {
 			compatible = "apple,s8000-aic", "apple,aic";
 			reg = <0x2 0x0e100000 0x0 0x100000>;
 			#interrupt-cells = <3>;
 			interrupt-controller;
+			power-domains = <&ps_aic>;
 		};
 
 		pinctrl_ap: pinctrl@20f100000 {
 			compatible = "apple,s8000-pinctrl", "apple,pinctrl";
 			reg = <0x2 0x0f100000 0x0 0x100000>;
+			power-domains = <&ps_gpio>;
 
 			gpio-controller;
 			#gpio-cells = <2>;
@@ -95,6 +106,7 @@ pinctrl_ap: pinctrl@20f100000 {
 		pinctrl_aop: pinctrl@2100f0000 {
 			compatible = "apple,s8000-pinctrl", "apple,pinctrl";
 			reg = <0x2 0x100f0000 0x0 0x100000>;
+			power-domains = <&ps_aop_gpio>;
 
 			gpio-controller;
 			#gpio-cells = <2>;
@@ -113,6 +125,14 @@ pinctrl_aop: pinctrl@2100f0000 {
 				     <AIC_IRQ 134 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
+		pmgr_mini: power-management@210200000 {
+			compatible = "apple,s8000-pmgr", "apple,pmgr", "syscon", "simple-mfd";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			reg = <0x2 0x10200000 0 0x84000>;
+		};
+
 		wdt: watchdog@2102b0000 {
 			compatible = "apple,s8000-wdt", "apple,wdt";
 			reg = <0x2 0x102b0000 0x0 0x4000>;
@@ -131,3 +151,5 @@ timer {
 			     <AIC_FIQ AIC_TMR_GUEST_VIRT IRQ_TYPE_LEVEL_HIGH>;
 	};
 };
+
+#include "s8001-pmgr.dtsi"
-- 
2.47.0


