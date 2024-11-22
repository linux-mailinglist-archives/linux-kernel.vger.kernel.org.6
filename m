Return-Path: <linux-kernel+bounces-418057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EDBB9D5C84
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 10:55:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B54DB23E2B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 09:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 328B01D7E35;
	Fri, 22 Nov 2024 09:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NgSgd2gf"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB031DE4C4;
	Fri, 22 Nov 2024 09:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732269288; cv=none; b=sjxI0JFIw+xBCsEpZo3Ivtb58+CTCbe6soRUoY9UEklYCEEOQ64jn8MJcHSJ1NI4aS11CZ/s4xGAZVPLsVCAOk8UoYuRAPeUamxnkNCWF5uI2SYk9QWHXc+x4dGtMksrES/M67jGHKKYbvqiHntgqKTCa6fl6cNU0t5nv+Tw0I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732269288; c=relaxed/simple;
	bh=ztOkG1l9yjVcr2pfAMEkRwns7DNCI2dI76C/ri/QF58=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L+2hhim/JwpxwlPYHbe1iWWiqtZyyDFfuz+OXJ6NDZrswq3dSiM0q27RFXxt8/oGYcNqkMi46D6XpHvvWKUxVddZzTtz8xHgC1w+kuFAGRsvk1vGv3ymcy3eAijcAW+bFVIu+JQKDobpRAB81JpBMtF5L9wzuMjBDVfHYBJe5vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NgSgd2gf; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-7fbc29b3145so992173a12.0;
        Fri, 22 Nov 2024 01:54:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732269285; x=1732874085; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AmFdBAmyPJlGFUTTlreUxBYzIDgdjp64ciz7CA5AoGc=;
        b=NgSgd2gfdZyeouWo2q5b1AfqcBa8FPC2522/OOpsw+ge9tWCanQR3WBfLNLV+zzYTV
         tyAp1WvhljRqpIfVftORKm4lkprWEFE96vhkXV/jysCHClobLGl2N9EwpxWWzlRFp0jV
         e8XQkQpfkHUlyMBJNZ1bnk7IOAgurMEmp5LKbdlEV2RgLAw7wruTSSlj9aC/VG+qi40i
         BTfMKgXjK0lN+k/UvmnGLoMzZb/Stv61M86ecY8gA76B/4GtbsXGFVvugTCGQapX1biN
         Y6nlqysHu+PTq4DYks64CwShofSY/g0UTM7R+XA+PQQbIK89kES8ovjBWksu2NU3CWqh
         EBpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732269285; x=1732874085;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AmFdBAmyPJlGFUTTlreUxBYzIDgdjp64ciz7CA5AoGc=;
        b=hWnfc6hnHy8dGea9KDp5A+2144SlRb8Os8lfEXDngbJeECcm6GvVJrkiNUiPkzmqnF
         NyuKwEd98DzOfxjMbPthaXHT5kCSz2yasxqt1zUYEy1/zAkoHFXtx7UkmweNGtxiMc4T
         MRuoE6U1eyCSD8dTdzU9sve4EKx+mbhw9FswDWglWX3DQ8y8ShzQZu+X98BPEFo+A/zU
         xG5rc3zFtNEHPNuuTfDcuIKBT4EWSbed0ckhzkTp4UdNcf2BizIekhGHSAaDPjMiW3lV
         jVCArLvumkGbcHnKH7zGgQJI32JpfmykhKiAjgq8mHht6MmpuNPb+ulFaFqspcBlWd6A
         uRXw==
X-Forwarded-Encrypted: i=1; AJvYcCU49GCLX6l0osHKAoyA76PUxSOgdDAapRQIAmMr6oS7kHMhPPZni0UQzccpp6kDmkwWdtu27ifDO670O/qv@vger.kernel.org, AJvYcCUCCjbcYtQxp0w4RaqwLnqiZvZ/Q96jjfko1mEaNa1dq40tvBGpdSQFxRRD6Ccm4pkxR7WVGHAqqN5s@vger.kernel.org
X-Gm-Message-State: AOJu0YzRzai+NSbtHpmSt0Aaz81P8O5fK6TdJgCA9+/Mg0leLWc8qdlR
	86zQ/ekKI8h4Bzveox4mBHi89LWVAOpCgoWrlLqaYSKT30NWnKJY
X-Gm-Gg: ASbGncvFAlPu1LCGxxhCDTzZgPDdC/yZ2f2kvbYmlDAlIrWtM0lvKLVEzhWE1z+HXPd
	1kMlqiksC3DMx5mC6M2xZrGHuydWzFHKnXmHLJVkOwwRiUWB5fTccoTOZfKpEQgQ6/S8SGHWtG5
	e/XItogfTxvJHns+7p51n+2qCI+ie5R+ONG2egJvJpLE8KYO+IDc67AJBCjMBLd++2IxrAA2cQw
	/ul1JlKXl24OncPLPne6ZjqzESUsZSzRdc8adPMyBSJ3DAm93Cu0WBDzb46QCahoP4=
X-Google-Smtp-Source: AGHT+IFz9q3oc2RE2NYFjE+08PZk/6LU2//+16PK588l/k/No7GlDauB+hoMrmFRQHWGF887IrqsCg==
X-Received: by 2002:a05:6a21:9984:b0:1d9:3acf:8bdd with SMTP id adf61e73a8af0-1e09d9aaf87mr3983535637.22.1732269285104;
        Fri, 22 Nov 2024 01:54:45 -0800 (PST)
Received: from localhost.localdomain ([182.152.110.125])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-7fbcc218a87sm1236332a12.39.2024.11.22.01.54.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 01:54:44 -0800 (PST)
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
Subject: [PATCH v3 RESEND 03/10] arm64: dts: apple: s5l8960x: Add PMGR node
Date: Fri, 22 Nov 2024 17:50:32 +0800
Message-ID: <20241122095136.35046-4-towinchenmi@gmail.com>
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

This adds the PMGR node and all known power state subnodes. Since there
are a large number of them, let's put them in a separate file to include.

Acked-by: Hector Martin <marcan@marcan.st>
Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 arch/arm64/boot/dts/apple/s5l8960x-5s.dtsi    |   4 +
 arch/arm64/boot/dts/apple/s5l8960x-air1.dtsi  |   4 +
 arch/arm64/boot/dts/apple/s5l8960x-mini2.dtsi |   4 +
 arch/arm64/boot/dts/apple/s5l8960x-pmgr.dtsi  | 610 ++++++++++++++++++
 arch/arm64/boot/dts/apple/s5l8960x.dtsi       |  13 +
 5 files changed, 635 insertions(+)
 create mode 100644 arch/arm64/boot/dts/apple/s5l8960x-pmgr.dtsi

diff --git a/arch/arm64/boot/dts/apple/s5l8960x-5s.dtsi b/arch/arm64/boot/dts/apple/s5l8960x-5s.dtsi
index 0b16adf07f79..51c081923657 100644
--- a/arch/arm64/boot/dts/apple/s5l8960x-5s.dtsi
+++ b/arch/arm64/boot/dts/apple/s5l8960x-5s.dtsi
@@ -49,3 +49,7 @@ switch-mute {
 		};
 	};
 };
+
+&framebuffer0 {
+	power-domains = <&ps_disp0 &ps_mipi_dsi>;
+};
diff --git a/arch/arm64/boot/dts/apple/s5l8960x-air1.dtsi b/arch/arm64/boot/dts/apple/s5l8960x-air1.dtsi
index 741c5a9f21dd..7d6e799c933a 100644
--- a/arch/arm64/boot/dts/apple/s5l8960x-air1.dtsi
+++ b/arch/arm64/boot/dts/apple/s5l8960x-air1.dtsi
@@ -49,3 +49,7 @@ switch-mute {
 		};
 	};
 };
+
+&framebuffer0 {
+	power-domains = <&ps_disp0 &ps_dp>;
+};
diff --git a/arch/arm64/boot/dts/apple/s5l8960x-mini2.dtsi b/arch/arm64/boot/dts/apple/s5l8960x-mini2.dtsi
index b27ef5680626..2ba846db2266 100644
--- a/arch/arm64/boot/dts/apple/s5l8960x-mini2.dtsi
+++ b/arch/arm64/boot/dts/apple/s5l8960x-mini2.dtsi
@@ -49,3 +49,7 @@ switch-mute {
 		};
 	};
 };
+
+&framebuffer0 {
+	power-domains = <&ps_disp0 &ps_dp>;
+};
diff --git a/arch/arm64/boot/dts/apple/s5l8960x-pmgr.dtsi b/arch/arm64/boot/dts/apple/s5l8960x-pmgr.dtsi
new file mode 100644
index 000000000000..da265f484307
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/s5l8960x-pmgr.dtsi
@@ -0,0 +1,610 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * PMGR Power domains for the Apple S5L8960X "A7" SoC
+ *
+ * Copyright (c) 2024 Nick Chan <towinchenmi@gmail.com>
+ */
+
+&pmgr {
+	ps_cpu0: power-controller@20000 {
+		compatible = "apple,s5l8960x-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x20000 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "cpu0";
+		apple,always-on; /* Core device */
+	};
+
+	ps_cpu1: power-controller@20008 {
+		compatible = "apple,s5l8960x-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x20008 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "cpu1";
+		apple,always-on; /* Core device */
+	};
+
+	ps_secuart0: power-controller@200f0 {
+		compatible = "apple,s5l8960x-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x200f0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "secuart0";
+		power-domains = <&ps_sio_p>;
+	};
+
+	ps_secuart1: power-controller@200f8 {
+		compatible = "apple,s5l8960x-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x200f8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "secuart1";
+		power-domains = <&ps_sio_p>;
+	};
+
+	ps_cpm: power-controller@20010 {
+		compatible = "apple,s5l8960x-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x20010 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "cpm";
+		apple,always-on; /* Core device */
+	};
+
+	ps_lio: power-controller@20018 {
+		compatible = "apple,s5l8960x-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x20018 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "lio";
+		apple,always-on; /* Core device */
+	};
+
+	ps_iomux: power-controller@20020 {
+		compatible = "apple,s5l8960x-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x20020 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "iomux";
+		apple,always-on; /* Core device */
+	};
+
+	ps_aic: power-controller@20028 {
+		compatible = "apple,s5l8960x-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x20028 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "aic";
+		apple,always-on; /* Core device */
+	};
+
+	ps_debug: power-controller@20030 {
+		compatible = "apple,s5l8960x-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x20030 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "debug";
+	};
+
+	ps_dwi: power-controller@20038 {
+		compatible = "apple,s5l8960x-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x20038 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "dwi";
+	};
+
+	ps_gpio: power-controller@20040 {
+		compatible = "apple,s5l8960x-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x20040 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "gpio";
+	};
+
+	ps_mca0: power-controller@20048 {
+		compatible = "apple,s5l8960x-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x20048 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "mca0";
+		power-domains = <&ps_sio_p>;
+	};
+
+	ps_mca1: power-controller@20050 {
+		compatible = "apple,s5l8960x-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x20050 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "mca1";
+		power-domains = <&ps_sio_p>;
+	};
+
+	ps_mca2: power-controller@20058 {
+		compatible = "apple,s5l8960x-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x20058 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "mca2";
+		power-domains = <&ps_sio_p>;
+	};
+
+	ps_mca3: power-controller@20060 {
+		compatible = "apple,s5l8960x-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x20060 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "mca3";
+		power-domains = <&ps_sio_p>;
+	};
+
+	ps_mca4: power-controller@20068 {
+		compatible = "apple,s5l8960x-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x20068 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "mca4";
+		power-domains = <&ps_sio_p>;
+	};
+
+	ps_pwm0: power-controller@20070 {
+		compatible = "apple,s5l8960x-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x20070 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "pwm0";
+		power-domains = <&ps_sio_p>;
+	};
+
+	ps_i2c0: power-controller@20078 {
+		compatible = "apple,s5l8960x-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x20078 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "i2c0";
+		power-domains = <&ps_sio_p>;
+	};
+
+	ps_i2c1: power-controller@20080 {
+		compatible = "apple,s5l8960x-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x20080 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "i2c1";
+		power-domains = <&ps_sio_p>;
+	};
+
+	ps_i2c2: power-controller@20088 {
+		compatible = "apple,s5l8960x-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x20088 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "i2c2";
+		power-domains = <&ps_sio_p>;
+	};
+
+	ps_i2c3: power-controller@20090 {
+		compatible = "apple,s5l8960x-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x20090 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "i2c3";
+		power-domains = <&ps_sio_p>;
+	};
+
+	ps_spi0: power-controller@20098 {
+		compatible = "apple,s5l8960x-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x20098 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "spi0";
+		power-domains = <&ps_sio_p>;
+	};
+
+	ps_spi1: power-controller@200a0 {
+		compatible = "apple,s5l8960x-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x200a0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "spi1";
+		power-domains = <&ps_sio_p>;
+	};
+
+	ps_spi2: power-controller@200a8 {
+		compatible = "apple,s5l8960x-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x200a8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "spi2";
+		power-domains = <&ps_sio_p>;
+	};
+
+	ps_spi3: power-controller@200b0 {
+		compatible = "apple,s5l8960x-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x200b0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "spi3";
+		power-domains = <&ps_sio_p>;
+	};
+
+	ps_uart0: power-controller@200b8 {
+		compatible = "apple,s5l8960x-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x200b8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "uart0";
+		power-domains = <&ps_sio_p>;
+	};
+
+	ps_uart1: power-controller@200c0 {
+		compatible = "apple,s5l8960x-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x200c0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "uart1";
+		power-domains = <&ps_sio_p>;
+	};
+
+	ps_uart2: power-controller@200c8 {
+		compatible = "apple,s5l8960x-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x200c8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "uart2";
+		power-domains = <&ps_sio_p>;
+	};
+
+	ps_uart3: power-controller@200d0 {
+		compatible = "apple,s5l8960x-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x200d0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "uart3";
+		power-domains = <&ps_sio_p>;
+	};
+
+	ps_uart4: power-controller@200d8 {
+		compatible = "apple,s5l8960x-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x200d8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "uart4";
+		power-domains = <&ps_sio_p>;
+	};
+
+	ps_uart5: power-controller@200e0 {
+		compatible = "apple,s5l8960x-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x200e0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "uart5";
+		power-domains = <&ps_sio_p>;
+	};
+
+	ps_uart6: power-controller@200e8 {
+		compatible = "apple,s5l8960x-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x200e8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "uart6";
+		power-domains = <&ps_sio_p>;
+	};
+
+	ps_sio_p: power-controller@20110 {
+		compatible = "apple,s5l8960x-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x20110 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "sio_p";
+	};
+
+	ps_usb: power-controller@20158 {
+		compatible = "apple,s5l8960x-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x20158 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "usb";
+	};
+
+	ps_usbctrl: power-controller@20160 {
+		compatible = "apple,s5l8960x-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x20160 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "usbctrl";
+		power-domains = <&ps_usb>;
+	};
+
+	ps_usb2host0: power-controller@20170 {
+		compatible = "apple,s5l8960x-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x20170 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "usb2host0";
+		power-domains = <&ps_usbctrl>;
+	};
+
+	ps_usb2host1: power-controller@20180 {
+		compatible = "apple,s5l8960x-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x20180 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "usb2host1";
+		power-domains = <&ps_usbctrl>;
+	};
+
+	ps_disp_busmux: power-controller@201a8 {
+		compatible = "apple,s5l8960x-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x201a8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "disp_busmux";
+	};
+
+	ps_media: power-controller@201d8 {
+		compatible = "apple,s5l8960x-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x201d8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "media";
+	};
+
+	ps_isp: power-controller@201d0 {
+		compatible = "apple,s5l8960x-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x201d0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "isp";
+	};
+
+	ps_msr: power-controller@201e0 {
+		compatible = "apple,s5l8960x-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x201e0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "msr";
+		power-domains = <&ps_media>;
+	};
+
+	ps_jpg: power-controller@201e8 {
+		compatible = "apple,s5l8960x-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x201e8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "jpg";
+		power-domains = <&ps_media>;
+	};
+
+	ps_disp0: power-controller@201b0 {
+		compatible = "apple,s5l8960x-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x201b0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "disp0";
+		power-domains = <&ps_disp_busmux>;
+	};
+
+	ps_aes0: power-controller@20100 {
+		compatible = "apple,s5l8960x-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x20100 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "aes0";
+		power-domains = <&ps_sio_p>;
+	};
+
+	ps_sio: power-controller@20108 {
+		compatible = "apple,s5l8960x-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x20108 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "sio";
+		power-domains = <&ps_sio_p>;
+		apple,always-on; /* Core device */
+	};
+
+	ps_hsic0_phy: power-controller@20118 {
+		compatible = "apple,s5l8960x-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x20118 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "hsic0_phy";
+		power-domains = <&ps_usb2host0>;
+	};
+
+	ps_hsic1_phy: power-controller@20120 {
+		compatible = "apple,s5l8960x-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x20120 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "hsic1_phy";
+		power-domains = <&ps_usb2host0>;
+	};
+
+	ps_hsic2_phy: power-controller@20128 {
+		compatible = "apple,s5l8960x-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x20128 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "hsic2_phy";
+		power-domains = <&ps_usb2host1>;
+	};
+
+	ps_ispsens0: power-controller@20130 {
+		compatible = "apple,s5l8960x-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x20130 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "ispsens0";
+	};
+
+	ps_ispsens1: power-controller@20138 {
+		compatible = "apple,s5l8960x-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x20138 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "ispsens1";
+	};
+
+	ps_mcc: power-controller@20140 {
+		compatible = "apple,s5l8960x-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x20140 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "mcc";
+		apple,always-on; /* Core device */
+	};
+
+	ps_mcu: power-controller@20148 {
+		compatible = "apple,s5l8960x-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x20148 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "mcu";
+		apple,always-on; /* Core device */
+	};
+
+	ps_amp: power-controller@20150 {
+		compatible = "apple,s5l8960x-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x20150 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "amp";
+		apple,always-on; /* Core device */
+	};
+
+	ps_usb2host0_ohci: power-controller@20168 {
+		compatible = "apple,s5l8960x-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x20168 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "usb2host0_ohci";
+		power-domains = <&ps_usb2host0>;
+	};
+
+	ps_usb2host1_ohci: power-controller@20178 {
+		compatible = "apple,s5l8960x-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x20178 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "usb2host1_ohci";
+		power-domains = <&ps_usb2host1>;
+	};
+
+	ps_usbotg: power-controller@20188 {
+		compatible = "apple,s5l8960x-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x20188 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "usbotg";
+		power-domains = <&ps_usbctrl>;
+	};
+
+	ps_smx: power-controller@20190 {
+		compatible = "apple,s5l8960x-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x20190 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "smx";
+		apple,always-on; /* Apple fabric, critical block */
+	};
+
+	ps_sf: power-controller@20198 {
+		compatible = "apple,s5l8960x-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x20198 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "sf";
+		apple,always-on; /* Apple fabric, critical block */
+	};
+
+	ps_cp: power-controller@201a0 {
+		compatible = "apple,s5l8960x-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x201a0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "cp";
+		apple,always-on; /* Core device */
+	};
+
+	ps_mipi_dsi: power-controller@201b8 {
+		compatible = "apple,s5l8960x-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x201b8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "mipi_dsi";
+		power-domains = <&ps_disp_busmux>;
+	};
+
+	ps_dp: power-controller@201c0 {
+		compatible = "apple,s5l8960x-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x201c0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "dp";
+		power-domains = <&ps_disp0>;
+	};
+
+	ps_disp1: power-controller@201c8 {
+		compatible = "apple,s5l8960x-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x201c8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "disp1";
+		power-domains = <&ps_disp_busmux>;
+	};
+
+	ps_vdec: power-controller@201f0 {
+		compatible = "apple,s5l8960x-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x201f0 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "vdec";
+		power-domains = <&ps_media>;
+	};
+
+	ps_venc: power-controller@201f8 {
+		compatible = "apple,s5l8960x-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x201f8 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "venc";
+		power-domains = <&ps_media>;
+	};
+
+	ps_ans: power-controller@20200 {
+		compatible = "apple,s5l8960x-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x20200 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "ans";
+	};
+
+	ps_ans_dll: power-controller@20208 {
+		compatible = "apple,s5l8960x-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x20208 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "ans_dll";
+		power-domains = <&ps_ans>;
+	};
+
+	ps_gfx: power-controller@20218 {
+		compatible = "apple,s5l8960x-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x20218 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "gfx";
+	};
+
+	ps_sep: power-controller@20268 {
+		compatible = "apple,s5l8960x-pmgr-pwrstate", "apple,pmgr-pwrstate";
+		reg = <0x20268 4>;
+		#power-domain-cells = <0>;
+		#reset-cells = <0>;
+		label = "sep";
+		power-domains = <&ps_secuart1>, <&ps_secuart0>;
+		apple,always-on; /* Locked on */
+	};
+};
diff --git a/arch/arm64/boot/dts/apple/s5l8960x.dtsi b/arch/arm64/boot/dts/apple/s5l8960x.dtsi
index 0218ecac1d83..7705215fbdc7 100644
--- a/arch/arm64/boot/dts/apple/s5l8960x.dtsi
+++ b/arch/arm64/boot/dts/apple/s5l8960x.dtsi
@@ -62,9 +62,18 @@ serial0: serial@20a0a0000 {
 			/* Use the bootloader-enabled clocks for now. */
 			clocks = <&clkref>, <&clkref>;
 			clock-names = "uart", "clk_uart_baud0";
+			power-domains = <&ps_uart0>;
 			status = "disabled";
 		};
 
+		pmgr: power-management@20e000000 {
+			compatible = "apple,s5l8960x-pmgr", "apple,pmgr", "syscon", "simple-mfd";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			reg = <0x2 0xe000000 0 0x24000>;
+		};
+
 		wdt: watchdog@20e027000 {
 			compatible = "apple,s5l8960x-wdt", "apple,wdt";
 			reg = <0x2 0x0e027000 0x0 0x1000>;
@@ -78,11 +87,13 @@ aic: interrupt-controller@20e100000 {
 			reg = <0x2 0x0e100000 0x0 0x100000>;
 			#interrupt-cells = <3>;
 			interrupt-controller;
+			power-domains = <&ps_aic>;
 		};
 
 		pinctrl: pinctrl@20e300000 {
 			compatible = "apple,s5l8960x-pinctrl", "apple,pinctrl";
 			reg = <0x2 0x0e300000 0x0 0x100000>;
+			power-domains = <&ps_gpio>;
 
 			gpio-controller;
 			#gpio-cells = <2>;
@@ -111,3 +122,5 @@ timer {
 			     <AIC_FIQ AIC_TMR_GUEST_VIRT IRQ_TYPE_LEVEL_HIGH>;
 	};
 };
+
+#include "s5l8960x-pmgr.dtsi"
-- 
2.47.0


