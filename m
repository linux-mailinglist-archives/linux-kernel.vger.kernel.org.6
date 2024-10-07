Return-Path: <linux-kernel+bounces-353403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F178B992D4D
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 15:32:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8CEE284055
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 13:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FD631D54CD;
	Mon,  7 Oct 2024 13:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VuD/to1L"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEEE91D4351;
	Mon,  7 Oct 2024 13:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728307885; cv=none; b=Bqc55VMaqhjN2stku2s+UsD/GIWdkYW9KZUCmvMKkZkYO6SCzp2kSBezcjtaXPEAVdx8iTi+geghz/cc9XARoRy5UFyaURVnBLSUq08W3/7OM81LmLERnBOZCBYQhXztsfo6efQMwzlmY4AyAlmxpS9WKTa0C7F2JIUt/VjtD/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728307885; c=relaxed/simple;
	bh=q+R/yLvzBZ1F+I5J/jkSZ1GqhQnL9MtK1KuSrYX1PKI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IAH1wQEI+dmZ5o5GvN9VZD65rxk+2VuD6lkhn60OUuVl/dffd3kM9LUZbSur4kzUbbgzBa5G7tV4UF7FDJL3uGo3/Nu9ljFt7kSyN+/JrM7U8+9esahQTFv6uE0giXfMNtMGpbep/H/tX6PcyyEmuUIgJXnMOYHVnVQT5wPm8iE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VuD/to1L; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5c3df1a3cb6so870525a12.2;
        Mon, 07 Oct 2024 06:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728307882; x=1728912682; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u0BtAunKdjzqfNoYuPz7DgcoO8tqHEt2iWmizOSxAGw=;
        b=VuD/to1L4QCbZyAYsWCIDiG9iczvtnnXN3OhMWAOrcD4YdepYjm39G9fgUdCQRh/q4
         g531IGPUksRrBTvg/1rMCo2N+YZ4yfjGIAn6V5D8g6iVBGqIG7emzXq6gzGOd9qHy0bw
         bGnmpTsQ0PvzkzH7xdAdDgsE2MOFPan2HCGzdxk+buN59bc1y+74Ifn7gOSu/pHoeuW8
         9nIMsyG7FmqqE2g09hSyVScKkZoentg6pnqfXVfwMQRfT6HZLzvtjpQFB1/aj2JJ4Rlr
         l0wdmyoWewHubmuS/VaoBDJoPKtEiuoh60a7g8Qy2Af3Y+5+87R9WJsF32ELDaxleNcI
         /LLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728307882; x=1728912682;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u0BtAunKdjzqfNoYuPz7DgcoO8tqHEt2iWmizOSxAGw=;
        b=JAs7ZP3gyqM3GSCC865hn1Bl73HaKVGI3E1npZCplwR0RI8JrZgLU80HRH/ynKAEtr
         LqaRF+PYFIZ9KuFi7k5Sdrhlj25Bnm//VGnOnTNKlgnc8j/g7cPzrHJQ79z90OPEv53N
         WZ9/lllHnKD61WK920bIjaBuzVYOWFxwiHCfmpkXZ83TMO9jnflIHf78ly/AsO25dTXJ
         OlY2D2yqkIY420QsT4JbXYvL40YPBu6knpiAU2dQ8gdsG4UwucsYCP6MFn9JT2pMSmIg
         fYSMxedxPg0Mu5RBENIOl0e+gLuM8dSE3+l+DhWLDmxNti8718g3B33DJaRhd10vD79O
         rPag==
X-Forwarded-Encrypted: i=1; AJvYcCUrOXVjS0/fTxlybYeVr3+N8KS2bAz9w7mzaUffc3bM90e91bo8HCF57e2hdwHshuVax+WEHh0u2DEFs89y@vger.kernel.org, AJvYcCV9vv9XU7Hs73bJKqng6IRDTN2dDRxd7grSdpeYJq/1gdnH/tiMV3JR3xJcR0Gwp/jBbhYy0JRMckSx@vger.kernel.org
X-Gm-Message-State: AOJu0YygUx7s0Wj4E8+RAE3bF4ofGRTkwHi0wgjy3uV7FmHkJl9EGL4Z
	bSBJXZ7Juv2mWafAPoTyog4udY5ycBza0jy4G8PIFE6+dElOv82l
X-Google-Smtp-Source: AGHT+IG6ELoI5rAJUZQk2aGuEZOitd8OLpeIs+BHwY/ayT8ufk2ANINAUz4xNohxJuMOJdbR2JDUHA==
X-Received: by 2002:a50:cb88:0:b0:5c9:3f3:ae0 with SMTP id 4fb4d7f45d1cf-5c903f30b38mr260060a12.5.1728307881796;
        Mon, 07 Oct 2024 06:31:21 -0700 (PDT)
Received: from e8ff02ae9b18.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c8e05eb34csm3193089a12.59.2024.10.07.06.31.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 06:31:21 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	dinguyen@kernel.org,
	marex@denx.de,
	s.trumtrar@pengutronix.de
Cc: l.rubusch@gmail.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/8] ARM: dts: socfpga: add Enclustra base-board dtsi
Date: Mon,  7 Oct 2024 13:31:10 +0000
Message-Id: <20241007133115.1482619-4-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241007133115.1482619-1-l.rubusch@gmail.com>
References: <20241007133115.1482619-1-l.rubusch@gmail.com>
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


