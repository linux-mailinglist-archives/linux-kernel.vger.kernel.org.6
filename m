Return-Path: <linux-kernel+bounces-393107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DD019B9BE9
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 02:12:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BFD6281B8A
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 01:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1D6A15886D;
	Sat,  2 Nov 2024 01:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U9pdD/sn"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7DD85260;
	Sat,  2 Nov 2024 01:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730509872; cv=none; b=tRhRozIbEjlVYbkJ/nFlVaUZ9BlsSsqJnLtWWxHgU6rui/YsPFgBl7dBvK3+4eMjxv8Da/3dn+nX7Jopsusj8aZ6/dToWB13jHkOedXnsqILKn9jsWNBgGHQ5EiSrqlVH262icOebvnHkar/85BGJ6ZMZ0VmyJAbvumc7FnvZyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730509872; c=relaxed/simple;
	bh=E287hdr2yK7DDmU71fW+k10h3L/phh71DM/Yd74KdvQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HT9YEoRuS5yFd6nDToS3+6f3fSXvOrqQOjfo2rdq/8mpaBwZiDkhDpkH4nYPfsF/oWOqAWlxpSAmRKySWCVf9J4v2eiZHL+b5RNmgyM3xGK/uGdDtOTqWh7o91qxGjIj5PLItkv0fiECz/2q75IYmXOc1xuTTSqTb78IjFLAETs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U9pdD/sn; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-720d14c8dbfso1123542b3a.0;
        Fri, 01 Nov 2024 18:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730509869; x=1731114669; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4acb0zzH0RVDx0VE0fX9E/tjB9F/UJThn5Nofg2rVU4=;
        b=U9pdD/sn+14jllE0HOfY7DmnYqDIBqMtTydv/9oyCN+mbMmGhzOILSnX2Be2ky+goX
         jc/KyXArYPgX0Il6B8vaWIm6F/RBXgpaIoMACdb0C4CTUck2+Cxd94QoWO49hLk8IlZq
         rDXCymMJk3ePU0RLY/vXr+LCO5wpf4gv8oIIjgjPU7MB30D0qRRlue4MCl4rY8W0tkpf
         j67veVtb4XD6bnJGrPViyKr3e88WUWdIF/xcpmRhoaocQPq+t9YyA5pu0PoFKoC/xWcA
         ip/HkqVsv+aTqCxhnQMgV93eertArZqk/7k55Bqk66kXaXqH2C0h0bBEezw59VGgTpDC
         2X3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730509869; x=1731114669;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4acb0zzH0RVDx0VE0fX9E/tjB9F/UJThn5Nofg2rVU4=;
        b=BHBoLH7o33XLCOLB+ExSA5hi9qMAdiEyHkqliTDt2BVoPlRYR1o6it1ghqJXrMY+Fa
         Q4wnqyA0k5YbaeixuQP8PZhf6xmxsp6JSq1HucofOTziFGljujXiZr/mzcjkmOGV2Bf6
         5x3h7MqBnxTxR1/rJuZw3tRNv0ACzkZgq5zVMiRI3bN8Ylnl3PeXYV+ESGWXlfIC47aJ
         600CKJ1VhuHpili7nSGyzk7H3JT5iCo06pnSWD1qxcGjHvKqMwOAczNsKRjApg+GeWh6
         n64SOcx2BdJhLh4dfttr5Ryq4BESosaLNXTzAmGlMrAc0vPdWoxWQq79KTn8Ah3rTgL8
         nUAw==
X-Forwarded-Encrypted: i=1; AJvYcCWgIjS2VpoQhWZpVBnXNP1jDmKRQU2LskVA5pM6E5qaP1H3AbYlAjbRCLP7R1N8bNt8oJwW86idIMhyYvV3@vger.kernel.org, AJvYcCXdMCxLECRfye7E9jcv6t9tDcVcS9/Kz1EnlloZBu4E0LV2bmF4lZJwA+QfAAa4zzTqVpVjceagjvk1@vger.kernel.org
X-Gm-Message-State: AOJu0YwOokQPoDPEQiEm5T+2UYT2PNdrT0x+wNTWbBuYYH+0B/kJ9+gs
	zttisVE8WNYs8NfRQuaNb2zVrh/McVXNCzS2d9VPnyekM3UWnroF
X-Google-Smtp-Source: AGHT+IFHp2FpJWE+uSOMJtEnar8bcMSO8cLkQEyoiJuOuareWtc1sB8I7wWjPwmo4S4vxkpqq+mMcA==
X-Received: by 2002:a05:6a00:885:b0:71e:64fe:965f with SMTP id d2e1a72fcca58-720b9daefcdmr12730569b3a.20.1730509868665;
        Fri, 01 Nov 2024 18:11:08 -0700 (PDT)
Received: from localhost.localdomain ([49.130.42.137])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-720bc2c38adsm3287708b3a.133.2024.11.01.18.11.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 18:11:08 -0700 (PDT)
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
Subject: [PATCH v2 10/10] arm64: dts: apple: t8015: Add PMGR nodes
Date: Sat,  2 Nov 2024 09:08:32 +0800
Message-ID: <20241102011004.59339-11-towinchenmi@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241102011004.59339-1-towinchenmi@gmail.com>
References: <20241102011004.59339-1-towinchenmi@gmail.com>
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
 arch/arm64/boot/dts/apple/t8015-common.dtsi |   1 +
 arch/arm64/boot/dts/apple/t8015-pmgr.dtsi   | 931 ++++++++++++++++++++
 arch/arm64/boot/dts/apple/t8015.dtsi        |  21 +
 3 files changed, 953 insertions(+)
 create mode 100644 arch/arm64/boot/dts/apple/t8015-pmgr.dtsi

diff --git a/arch/arm64/boot/dts/apple/t8015-common.dtsi b/arch/arm64/boot/dts/apple/t8015-common.dtsi
index 69258a33ea50..498f58fb9715 100644
--- a/arch/arm64/boot/dts/apple/t8015-common.dtsi
+++ b/arch/arm64/boot/dts/apple/t8015-common.dtsi
@@ -24,6 +24,7 @@ chosen {
 		framebuffer0: framebuffer@0 {
 			compatible = "apple,simple-framebuffer", "simple-framebuffer";
 			reg = <0 0 0 0>; /* To be filled by loader */
+			power-domains = <&ps_disp0_be &ps_mipi_dsi &ps_disp0_hilo &ps_disp0_ppp>;
 			/* Format properties will be added by loader */
 			status = "disabled";
 		};
diff --git a/arch/arm64/boot/dts/apple/t8015-pmgr.dtsi b/arch/arm64/boot/dts/apple/t8015-pmgr.dtsi
new file mode 100644
index 000000000000..ef0f75262ad4
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/t8015-pmgr.dtsi
@@ -0,0 +1,931 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * PMGR Power domains for the Apple T8015 "A11" SoC
+ *
+ * Copyright (c) 2024, Nick Chan <towinchenmi@gmail.com>
+ */
+
+&pmgr {
+	ps_cpu0: power-controller@80000 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80000 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "cpu0";
+		apple,always-on; /* Core device */
+	};
+
+	ps_cpu1: power-controller@80008 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80008 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "cpu1";
+		apple,always-on; /* Core device */
+	};
+
+	ps_cpu2: power-controller@80010 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80010 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "cpu2";
+		apple,always-on; /* Core device */
+	};
+
+	ps_cpu3: power-controller@80018 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80018 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "cpu3";
+		apple,always-on; /* Core device */
+	};
+
+	ps_cpu4: power-controller@80020 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80020 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "cpu4";
+		apple,always-on; /* Core device */
+	};
+
+	ps_cpu5: power-controller@80028 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80028 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "cpu5";
+		apple,always-on; /* Core device */
+	};
+
+	ps_cpm: power-controller@80040 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80040 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "cpm";
+		apple,always-on; /* Core device */
+	};
+
+	ps_sio_busif: power-controller@80158 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80158 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "sio_busif";
+	};
+
+	ps_sio_p: power-controller@80160 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80160 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "sio_p";
+		power-domains = <&ps_sio_busif>;
+	};
+
+	ps_sbr: power-controller@80100 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80100 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "sbr";
+		apple,always-on; /* Apple fabric, critical block */
+	};
+
+	ps_aic: power-controller@80108 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80108 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "aic";
+		apple,always-on; /* Core device */
+	};
+
+	ps_dwi: power-controller@80110 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80110 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "dwi";
+	};
+
+	ps_gpio: power-controller@80118 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80118 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "gpio";
+	};
+
+	ps_pms: power-controller@80120 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80120 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "pms";
+		apple,always-on; /* Core device */
+	};
+
+	ps_pcie_ref: power-controller@80148 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80148 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "pcie_ref";
+	};
+
+	ps_mca0: power-controller@80170 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80170 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "mca0";
+		power-domains = <&ps_sio_p>;
+	};
+
+	ps_mca1: power-controller@80178 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80178 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "mca1";
+		power-domains = <&ps_sio_p>;
+	};
+
+	ps_mca2: power-controller@80180 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80180 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "mca2";
+		power-domains = <&ps_sio_p>;
+	};
+
+	ps_mca3: power-controller@80188 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80188 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "mca3";
+		power-domains = <&ps_sio_p>;
+	};
+
+	ps_mca4: power-controller@80190 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80190 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "mca4";
+		power-domains = <&ps_sio_p>;
+	};
+
+	ps_pwm0: power-controller@801a0 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x801a0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "pwm0";
+		power-domains = <&ps_sio_p>;
+	};
+
+	ps_i2c0: power-controller@801a8 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x801a8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "i2c0";
+		power-domains = <&ps_sio_p>;
+	};
+
+	ps_i2c1: power-controller@801b0 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x801b0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "i2c1";
+		power-domains = <&ps_sio_p>;
+	};
+
+	ps_i2c2: power-controller@801b8 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x801b8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "i2c2";
+		power-domains = <&ps_sio_p>;
+	};
+
+	ps_i2c3: power-controller@801c0 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x801c0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "i2c3";
+		power-domains = <&ps_sio_p>;
+	};
+
+	ps_spi0: power-controller@801c8 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x801c8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "spi0";
+		power-domains = <&ps_sio_p>;
+	};
+
+	ps_spi1: power-controller@801d0 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x801d0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "spi1";
+		power-domains = <&ps_sio_p>;
+	};
+
+	ps_spi2: power-controller@801d8 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x801d8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "spi2";
+		power-domains = <&ps_sio_p>;
+	};
+
+	ps_spi3: power-controller@801e0 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x801e0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "spi3";
+		power-domains = <&ps_sio_p>;
+	};
+
+	ps_uart0: power-controller@801e8 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x801e8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "uart0";
+		power-domains = <&ps_sio_p>;
+	};
+
+	ps_uart1: power-controller@801f0 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x801f0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "uart1";
+		power-domains = <&ps_sio_p>;
+	};
+
+	ps_uart2: power-controller@801f8 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x801f8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "uart2";
+		power-domains = <&ps_sio_p>;
+	};
+
+	ps_sio: power-controller@80168 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80168 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "sio";
+		power-domains = <&ps_sio_p>;
+		apple,always-on; /* Core device */
+	};
+
+	ps_hsicphy: power-controller@80128 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80128 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "hsicphy";
+		power-domains = <&ps_usb2host1>;
+	};
+
+	ps_ispsens0: power-controller@80130 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80130 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "ispsens0";
+	};
+
+	ps_ispsens1: power-controller@80138 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80138 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "ispsens1";
+	};
+
+	ps_ispsens2: power-controller@80140 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80140 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "ispsens2";
+	};
+
+	ps_mca5: power-controller@80198 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80198 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "mca5";
+		power-domains = <&ps_sio_p>;
+	};
+
+	ps_usb: power-controller@80270 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80270 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "usb";
+	};
+
+	ps_usbctlreg: power-controller@80278 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80278 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "usbctlreg";
+		power-domains = <&ps_usb>;
+	};
+
+	ps_usb2host0: power-controller@80280 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80280 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "usb2host0";
+		power-domains = <&ps_usbctlreg>;
+	};
+
+	ps_usb2host1: power-controller@80290 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80290 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "usb2host1";
+		power-domains = <&ps_usbctlreg>;
+	};
+
+	ps_rtmux: power-controller@802b0 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x802b0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "rtmux";
+	};
+
+	ps_media: power-controller@802f0 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x802f0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "media";
+	};
+
+	ps_jpg: power-controller@802f8 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x802f8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "jpg";
+		power-domains = <&ps_media>;
+	};
+
+	ps_disp0_fe: power-controller@802b8 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x802b8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "disp0_fe";
+		power-domains = <&ps_rtmux>;
+	};
+
+	ps_disp0_be: power-controller@802c0 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x802c0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "disp0_be";
+		power-domains = <&ps_disp0_fe>;
+	};
+
+	ps_disp0_gp: power-controller@802c8 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x802c8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "disp0_gp";
+		power-domains = <&ps_disp0_be>;
+		status = "disabled";
+	};
+
+	ps_uart3: power-controller@80200 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80200 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "uart3";
+		power-domains = <&ps_sio_p>;
+	};
+
+	ps_uart4: power-controller@80208 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80208 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "uart4";
+		power-domains = <&ps_sio_p>;
+	};
+
+	ps_uart5: power-controller@80210 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80210 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "uart5";
+		power-domains = <&ps_sio_p>;
+	};
+
+	ps_uart6: power-controller@80218 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80218 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "uart6";
+		power-domains = <&ps_sio_p>;
+	};
+
+	ps_uart7: power-controller@80220 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80220 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "uart7";
+		power-domains = <&ps_sio_p>;
+	};
+
+	ps_uart8: power-controller@80228 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80228 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "uart8";
+		power-domains = <&ps_sio_p>;
+	};
+
+	ps_hfd0: power-controller@80238 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80238 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "hfd0";
+		power-domains = <&ps_sio_p>;
+	};
+
+	ps_mcc: power-controller@80248 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80248 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "mcc";
+		apple,always-on; /* Memory cache controller */
+	};
+
+	ps_dcs0: power-controller@80250 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80250 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "dcs0";
+		apple,always-on; /* LPDDR4X interface */
+	};
+
+	ps_dcs1: power-controller@80258 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80258 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "dcs1";
+		apple,always-on; /* LPDDR4X interface */
+	};
+
+	ps_dcs2: power-controller@80260 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80260 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "dcs2";
+		apple,always-on; /* LPDDR4X interface */
+	};
+
+	ps_dcs3: power-controller@80268 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80268 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "dcs3";
+		apple,always-on; /* LPDDR4X interface */
+	};
+
+	ps_usb2host0_ohci: power-controller@80288 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80288 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "usb2host0_ohci";
+		power-domains = <&ps_usb2host0>;
+	};
+
+	ps_usb2dev: power-controller@80298 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80298 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "usb2dev";
+		power-domains = <&ps_usbctlreg>;
+	};
+
+	ps_smx: power-controller@802a0 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x802a0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "smx";
+		apple,always-on; /* Apple fabric, critical block */
+	};
+
+	ps_sf: power-controller@802a8 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x802a8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "sf";
+		apple,always-on; /* Apple fabric, critical block */
+	};
+
+	ps_mipi_dsi: power-controller@802d8 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x802d8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "mipi_dsi";
+		power-domains = <&ps_rtmux>;
+	};
+
+	ps_dp: power-controller@802e0 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x802e0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "dp";
+		power-domains = <&ps_disp0_be>;
+	};
+
+	ps_dpa: power-controller@80230 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80230 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "dpa";
+	};
+
+	ps_disp0_be_2x: power-controller@802d0 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x802d0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "disp0_be_2x";
+		power-domains = <&ps_disp0_be>;
+	};
+
+	ps_isp_sys: power-controller@80350 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80350 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "isp_sys";
+		power-domains = <&ps_rtmux>;
+	};
+
+	ps_msr: power-controller@80300 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80300 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "msr";
+		power-domains = <&ps_media>;
+	};
+
+	ps_venc_sys: power-controller@80398 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80398 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "venc_sys";
+		power-domains = <&ps_media>;
+	};
+
+	ps_pmp: power-controller@80308 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80308 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "pmp";
+		apple,always-on;
+	};
+
+	ps_pms_sram: power-controller@80310 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80310 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "pms_sram";
+	};
+
+	ps_pcie: power-controller@80318 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80318 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "pcie";
+	};
+
+	ps_pcie_aux: power-controller@80320 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80320 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "pcie_aux";
+	};
+
+	ps_vdec0: power-controller@80388 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80388 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "vdec0";
+		power-domains = <&ps_media>;
+	};
+
+	ps_gfx: power-controller@80338 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80338 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "gfx";
+	};
+
+	ps_ans2: power-controller@80328 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80328 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "ans2";
+		apple,always-on;
+	};
+
+	ps_pcie_direct: power-controller@80330 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80330 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "pcie_direct";
+		apple,always-on;
+	};
+
+	ps_avd_sys: power-controller@803a8 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x803a8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "avd_sys";
+		power-domains = <&ps_media>;
+	};
+
+	ps_sep: power-controller@80400 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80400 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "sep";
+		apple,always-on; /* Locked on */
+	};
+
+	ps_disp0_gp0: power-controller@80830 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80830 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "disp0_gp0";
+		power-domains = <&ps_disp0_gp>;
+		status = "disabled";
+	};
+
+	ps_disp0_gp1: power-controller@80838 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80838 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "disp0_gp1";
+		status = "disabled";
+	};
+
+	ps_disp0_ppp: power-controller@80840 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80840 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "disp0_ppp";
+	};
+
+	ps_disp0_hilo: power-controller@80848 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80848 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "disp0_hilo";
+	};
+
+	ps_isp_rsts0: power-controller@84000 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x84000 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "isp_rsts0";
+		power-domains = <&ps_isp_sys>;
+	};
+
+	ps_isp_rsts1: power-controller@84008 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x84008 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "isp_rsts1";
+		power-domains = <&ps_isp_sys>;
+	};
+
+	ps_isp_vis: power-controller@84010 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x84010 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "isp_vis";
+		power-domains = <&ps_isp_sys>;
+	};
+
+	ps_isp_be: power-controller@84018 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x84018 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "isp_be";
+		power-domains = <&ps_isp_sys>;
+	};
+
+	ps_isp_pearl: power-controller@84020 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x84020 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "isp_pearl";
+		power-domains = <&ps_isp_sys>;
+	};
+
+	ps_dprx: power-controller@84028 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x84028 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "dprx";
+		power-domains = <&ps_isp_sys>;
+	};
+
+	ps_isp_cnv: power-controller@84030 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x84030 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "isp_cnv";
+		power-domains = <&ps_isp_sys>;
+	};
+
+	ps_venc_dma: power-controller@88000 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x88000 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "venc_dma";
+	};
+
+	ps_venc_pipe4: power-controller@88010 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x88010 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "venc_pipe4";
+	};
+
+	ps_venc_pipe5: power-controller@88018 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x88018 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "venc_pipe5";
+	};
+
+	ps_venc_me0: power-controller@88020 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x88020 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "venc_me0";
+	};
+
+	ps_venc_me1: power-controller@88028 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x88028 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "venc_me1";
+	};
+};
+
+&pmgr_mini {
+	ps_aop_base: power-controller@80008 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80008 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "aop_base";
+		power-domains = <&ps_aop_cpu &ps_aop_filter>;
+		apple,always-on; /* Always on processor */
+	};
+
+	ps_debug: power-controller@80050 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80050 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "debug";
+	};
+
+	ps_aop_cpu: power-controller@80020 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80020 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "aop_cpu";
+	};
+
+	ps_aop_filter: power-controller@80000 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80000 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "aop_filter";
+	};
+
+	ps_spmi: power-controller@80058 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80058 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "spmi";
+	};
+
+	ps_smc_i2cm1: power-controller@800a8 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x800a8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "smc_i2cm1";
+	};
+
+	ps_smc_fabric: power-controller@80030 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80030 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "smc_fabric";
+	};
+
+	ps_smc_cpu: power-controller@80140 {
+		compatible = "apple,t8015-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x80140 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "smc_cpu";
+		power-domains = <&ps_smc_fabric &ps_smc_i2cm1>;
+	};
+};
diff --git a/arch/arm64/boot/dts/apple/t8015.dtsi b/arch/arm64/boot/dts/apple/t8015.dtsi
index 8828d830e5be..fbff3a6c0ba4 100644
--- a/arch/arm64/boot/dts/apple/t8015.dtsi
+++ b/arch/arm64/boot/dts/apple/t8015.dtsi
@@ -119,6 +119,7 @@ serial0: serial@22e600000 {
 			/* Use the bootloader-enabled clocks for now. */
 			clocks = <&clkref>, <&clkref>;
 			clock-names = "uart", "clk_uart_baud0";
+			power-domains = <&ps_uart0>;
 			status = "disabled";
 		};
 
@@ -127,11 +128,21 @@ aic: interrupt-controller@232100000 {
 			reg = <0x2 0x32100000 0x0 0x8000>;
 			#interrupt-cells = <3>;
 			interrupt-controller;
+			power-domains = <&ps_aic>;
+		};
+
+		pmgr: power-management@232000000 {
+			compatible = "apple,t8015-pmgr", "apple,pmgr", "syscon", "simple-mfd";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			reg = <0x2 0x32000000 0 0x8c000>;
 		};
 
 		pinctrl_ap: pinctrl@233100000 {
 			compatible = "apple,t8015-pinctrl", "apple,pinctrl";
 			reg = <0x2 0x33100000 0x0 0x1000>;
+			power-domains = <&ps_gpio>;
 
 			gpio-controller;
 			#gpio-cells = <2>;
@@ -188,6 +199,14 @@ pinctrl_nub: pinctrl@2351f0000 {
 				     <AIC_IRQ 170 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
+		pmgr_mini: power-management@235200000 {
+			compatible = "apple,t8015-pmgr", "apple,pmgr", "syscon", "simple-mfd";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			reg = <0x2 0x35200000 0 0x84000>;
+		};
+
 		wdt: watchdog@2352b0000 {
 			compatible = "apple,t8015-wdt", "apple,wdt";
 			reg = <0x2 0x352b0000 0x0 0x4000>;
@@ -232,3 +251,5 @@ timer {
 			     <AIC_FIQ AIC_TMR_GUEST_VIRT IRQ_TYPE_LEVEL_HIGH>;
 	};
 };
+
+#include "t8015-pmgr.dtsi"
-- 
2.47.0


