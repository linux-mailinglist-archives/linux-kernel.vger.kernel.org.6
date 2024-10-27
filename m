Return-Path: <linux-kernel+bounces-383663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79AD79B1EDB
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 15:39:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38A84281C30
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 14:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA07318A921;
	Sun, 27 Oct 2024 14:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KmEpwLTl"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B4C188CC6;
	Sun, 27 Oct 2024 14:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730039839; cv=none; b=cW5qGKtQxBS/3KyEfFptpkB/1YAuOQcix1p+68lf5vm5LK18ExmI5phknz6KownvGAPhPHl6JtOKsHeLpCogR2gtzN0OSXXptjL1VxOTOjFwAfDvtmjv+fZAxrFWrxvmcuwo1Jvf1/b+XjkMkHwH3MSSMvHGsfrRTUFUMvmnjbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730039839; c=relaxed/simple;
	bh=q+R/yLvzBZ1F+I5J/jkSZ1GqhQnL9MtK1KuSrYX1PKI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lIQRNs3sMmq2mNaSsv9dbYurZ0Jr1YumAh4Te2FOkyMoaxLAY85PgoVM4ARLfqkBxBcKQaK+0OjQcpps4EPEncY2nV5n+VV+8t7b4jYC6KvKxVCHYTZhVMN8TVFqvaJWYIfbm8XziKveqFg7oxzu+0ENYm3dadow7p9g6Q2lhHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KmEpwLTl; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5c935ca63ceso457784a12.0;
        Sun, 27 Oct 2024 07:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730039835; x=1730644635; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u0BtAunKdjzqfNoYuPz7DgcoO8tqHEt2iWmizOSxAGw=;
        b=KmEpwLTl8nYv/ALQKHV/VzXklWRl1UY2GTPSRxU8Vxrxqw+kX5YvLwfbev1eo17sYq
         A8167mGaIXvJ1jLvWbMEf3CRSMwAGOiZGRZ6fldI5mVseyNxj6vtRoPD3j4JdBevj/Ng
         lUZSaBNw7+m+pq1/EuJi+XHuoDMkeDfDS9fbwW0iZQjn//SFeFscYiSzgKnK0CY75omH
         yPXAl+kfqXG1bGk1xS27CfSpKHaZfxn08zHPaq2XUqfeuUwRpje1b/P54Nfl98BORqE8
         zbYc/86Inp5Vb7B01bUvV16yB8unk17u7250P9nbhO1NTK2ImNiPjflYdYe9jsOrAaGP
         b2Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730039835; x=1730644635;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u0BtAunKdjzqfNoYuPz7DgcoO8tqHEt2iWmizOSxAGw=;
        b=GKi39qCuvy2uztcH/RkWfO8xM9zIbaTbrMhNKQBNgAeLnsCGs9gDCcVpzGBMy5iPIU
         jvu5A3OIm34IrNfpdFRdaL7T6sNNqkBTEiK2lc7i8vDZ3ztxPwpbvrMpD6nQ1Yx1ATpM
         KXqUwf7KBHNaUHCCMQd7DP25fY5pRA5v6Jyep+2fSxekiD6BkiF0UCf+cMSCI+F+wf/N
         9O4R9AuaZ7tKysHkSSP0kF9/d9bB/BkAWfi0MCOs9PQIT1GBNegd2a9zqTTjAv+WYov+
         2EkyjOVpVKf599Vzla/ioTcfHX6TdKtd1XB3kr5cMSqgECQO0QIVNChp2YvCfbK6H1RJ
         jFHw==
X-Forwarded-Encrypted: i=1; AJvYcCUg370hAtSGguIY6/PA99RHuKwwxOBWrbjYAv5bxQg7YqKk+8YmGuYaD596d+rqDlSLj2JhUp/5G5iw@vger.kernel.org, AJvYcCWo5eXHRZ5OJY75uDEk8AjuLjNZx/aSZMBp2W5hiPxH/Y7KjV91ZDLEOSSfkMeBIxkIA1Ys3O9pviTvvUi+@vger.kernel.org
X-Gm-Message-State: AOJu0YxDZrJXFxx0p+Sdyp6xSu4anR/kZc1wpvrpGfh9R84B7LFscOB8
	hoxrXzaYPnu5D1mUJ+EA/PTcCgTq2ytV5VINQkyd3iFIHwbg2sjq
X-Google-Smtp-Source: AGHT+IHNTDno6fJ+DrgkoLics+LdIv9LqSCfdvREtYA90684Wd8PKPPNwDwt5cXE7s8AY1y/inRN1w==
X-Received: by 2002:a17:907:74b:b0:a99:fbb6:4956 with SMTP id a640c23a62f3a-a9de6175f57mr254392566b.10.1730039834988;
        Sun, 27 Oct 2024 07:37:14 -0700 (PDT)
Received: from 6c1d2e1f4cf4.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b331b0d44sm281127966b.187.2024.10.27.07.37.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Oct 2024 07:37:13 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	a.fatoum@pengutronix.de
Cc: conor+dt@kernel.org,
	dinguyen@kernel.org,
	marex@denx.de,
	s.trumtrar@pengutronix.de,
	l.rubusch@gmail.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCHv3 13/22] ARM: dts: socfpga: add Enclustra base-board dtsi
Date: Sun, 27 Oct 2024 14:36:45 +0000
Message-Id: <20241027143654.28474-14-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241027143654.28474-1-l.rubusch@gmail.com>
References: <20241027143654.28474-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add generic Enclustra base-board support for the Mercury+ PE1, the
Mercury+ PE3 and the Mercury+ ST1 board. The carrier boards can be
freely combined with the SoMs Mercury+ AA1, Mercury SA1 and
Mercury+ SA2.

Signed-off-by: Andreas Buerkler <andreas.buerkler@enclustra.com>
Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 .../socfpga_enclustra_mercury_pe1.dtsi        | 33 +++++++++++
 .../socfpga_enclustra_mercury_pe3.dtsi        | 55 +++++++++++++++++++
 .../socfpga_enclustra_mercury_st1.dtsi        | 15 +++++
 3 files changed, 103 insertions(+)
 create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_enclustra_mercury_pe1.dtsi
 create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_enclustra_mercury_pe3.dtsi
 create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_enclustra_mercury_st1.dtsi

diff --git a/arch/arm/boot/dts/intel/socfpga/socfpga_enclustra_mercury_pe1.dtsi b/arch/arm/boot/dts/intel/socfpga/socfpga_enclustra_mercury_pe1.dtsi
new file mode 100644
index 000000000..11f418e88
--- /dev/null
+++ b/arch/arm/boot/dts/intel/socfpga/socfpga_enclustra_mercury_pe1.dtsi
@@ -0,0 +1,33 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Copyright (C) 2024 Enclustra GmbH - https://www.enclustra.com
+ */
+
+&i2c_encl {
+	status = "okay";
+
+	24aa128@57 {
+		status = "okay";
+		compatible = "microchip,24c128";
+		reg = <0x57>;
+		pagesize = <64>;
+		label = "user eeprom";
+		address-width = <16>;
+	};
+
+	lm96080@2f {
+		status = "okay";
+		compatible = "national,lm80";
+		reg = <0x2f>;
+	};
+
+	si5338@70 {
+		compatible = "silabs,si5338";
+		reg = <0x70>;
+	};
+
+};
+
+&i2c_encl_fpga {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/intel/socfpga/socfpga_enclustra_mercury_pe3.dtsi b/arch/arm/boot/dts/intel/socfpga/socfpga_enclustra_mercury_pe3.dtsi
new file mode 100644
index 000000000..9fbde91ad
--- /dev/null
+++ b/arch/arm/boot/dts/intel/socfpga/socfpga_enclustra_mercury_pe3.dtsi
@@ -0,0 +1,55 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Copyright (C) 2024 Enclustra GmbH - https://www.enclustra.com
+ */
+
+&i2c_encl {
+	i2c-mux@74 {
+		status = "okay";
+		compatible = "nxp,pca9547";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <0x74>;
+
+		i2c@0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+
+			24aa128@56 {
+				status = "okay";
+				compatible = "microchip,24c128";
+				reg = <0x56>;
+				pagesize = <64>;
+				label = "user eeprom";
+				address-width = <16>;
+			};
+
+			lm96080@2f {
+				status = "okay";
+				compatible = "national,lm80";
+				reg = <0x2f>;
+			};
+
+			pcal6416@20 {
+				status = "okay";
+				compatible = "nxp,pcal6416";
+				reg = <0x20>;
+				gpio-controller;
+				#gpio-cells = <2>;
+			};
+		};
+	};
+};
+
+&i2c_encl_fpga {
+	status = "okay";
+
+	i2c-mux@75 {
+		status = "okay";
+		compatible = "nxp,pca9547";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <0x75>;
+	};
+};
diff --git a/arch/arm/boot/dts/intel/socfpga/socfpga_enclustra_mercury_st1.dtsi b/arch/arm/boot/dts/intel/socfpga/socfpga_enclustra_mercury_st1.dtsi
new file mode 100644
index 000000000..ffcef353e
--- /dev/null
+++ b/arch/arm/boot/dts/intel/socfpga/socfpga_enclustra_mercury_st1.dtsi
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Copyright (C) 2024 Enclustra GmbH - https://www.enclustra.com
+ */
+
+&i2c_encl {
+	si5338@70 {
+		compatible = "silabs,si5338";
+		reg = <0x70>;
+	};
+};
+
+&i2c_encl_fpga {
+	status = "okay";
+};
-- 
2.25.1


