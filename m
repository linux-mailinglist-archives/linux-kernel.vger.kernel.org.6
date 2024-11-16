Return-Path: <linux-kernel+bounces-411734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0376E9CFF01
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 14:11:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27130B26CF4
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 13:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24B8119C546;
	Sat, 16 Nov 2024 13:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c/jVvXDl"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0BC1957E4;
	Sat, 16 Nov 2024 13:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731762633; cv=none; b=AzdVTrqJwsDjy/U+luRBmJgt/axYj+OeWv6Lur0bdnIgxgONXZ+tM6v5cfpG+in/A/KOuN15JXCormj0CZgsYpEucqLwRTtR8oV+Fa79Zp+XVQ9PRj6B/CDUQ1DI0lhUPf/7jW52sCgcZvdMLin5QVUCLx6IsKeztJ3i3pAcUyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731762633; c=relaxed/simple;
	bh=Kpk4Q4RFqTSQM+9R2Vg2IyQiKK6qcIw6nel1x0dijnk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ed6Q3c4AygTK5x/eUb+O/92KydcDHRbjouhhGL/lwboZQG7l5h7DXpEe8XlcIMeseh1ReNLFXY8wj4/ImZrx/DTdw4WAWPX/BOVJZIF1lMJ6TO77cMop/BhnKmIi850J7nVpeRyNJhf/p8j1AtnvVWCud0Wi8UK0lB8Os6PM17g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c/jVvXDl; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3821a8c7c5cso285885f8f.0;
        Sat, 16 Nov 2024 05:10:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731762630; x=1732367430; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a0IXB9OXrhH5BcHy9T9IDvpJMqaLAeawSRKPPHqIKWg=;
        b=c/jVvXDlwRThWmCdy1ILCthtAoRpcGoVIYYLjpFfpgzyqrwLXnWXT3gokVrHyBbdvF
         +v/7vQ3/ZCaHdbBeiUOBQLPNHCslAfnWMBaN9MQ6MbHIBHvYEb/Yqh7DZT1E3IR5M3Lb
         i4T37CFAxtLe6slZBPPevyDu2B2bZVEjwZ+AF7SZPQTQlZHX7ytRceVnHhU08gpAeoOc
         HhGI1l3NPGfWLRRH5X/i5iLMcFXOTkjHEZ9DCEjrG2jczzQdv03J8B1EmScTLny2acsJ
         yqtC5fKnnz5vjiNVA/MRp7qtGpH05dN8LVjqwJ82aROrfkJ+f2yZofuT5d57Va1BSFz8
         UVNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731762630; x=1732367430;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a0IXB9OXrhH5BcHy9T9IDvpJMqaLAeawSRKPPHqIKWg=;
        b=Vo58yXBMreB9xYP71I3pKTiwJlVHD1HZMZAUrBH/kYrgGNR5SIRUbM59GO2h14XQCt
         InebUPcjHF5Ea+2KklP9ih83zpkzVpudXaEgXY/tI5nM7ViadHSrdH5i6pSQJaP3cngG
         SzUVT2Xxo2IGNMAU97CsAtZ2UpLUcz8wGcSbCk8jrR7qZZhpYrMoqAryi/Bcg7FB4W8Q
         7v4KdClHxQ7GyonZVxRkSrmjcS+QFPUC0Gy66f8SYs04mMzx0tBpM55ht/KbxlV7MMLD
         PefsaGsvMqqkHdp47zSt2m2sqpg4psPG/hrCMHutxjirQSF2J/s9W8eD4FbzXL1ueK7Q
         jFYQ==
X-Forwarded-Encrypted: i=1; AJvYcCV4y6lxptqtnbOpE/9fn3en2yPp9rUofWAerph0uoTHOAI+BlhfF7D30hm2BCM43qF7cfImL3+KCFit@vger.kernel.org, AJvYcCWiVhr1s9BIiS62T7HOCtN7d1mboMySG/U1rHzkE4gzaiwkT9oznBxaUKw0FIrw26rsLZhscrDKev62ps4s@vger.kernel.org
X-Gm-Message-State: AOJu0YxlFjSKsL5C1u3OlMwgnVOIzAFE9KNvbguRPxqLU9mq4GL0AAwx
	RQxKqndfJHHqLpl4OI8nOmC+x+LgwiURmu1/y/Ayfbxy//zH62uf
X-Google-Smtp-Source: AGHT+IHsFDbVq+BdODOLr9pAzCsaxOmapJ69G17FmBug2tVI1RWM4v/91F4IDJyw3M9zvFW+waeMZg==
X-Received: by 2002:a05:600c:3b97:b0:432:7c08:d0fb with SMTP id 5b1f17b1804b1-432df741aa5mr22540435e9.3.1731762629881;
        Sat, 16 Nov 2024 05:10:29 -0800 (PST)
Received: from 5dfbf0f66296.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432da28ba80sm92424375e9.29.2024.11.16.05.10.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Nov 2024 05:10:29 -0800 (PST)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	dinguyen@kernel.org
Cc: marex@denx.de,
	s.trumtrar@pengutronix.de,
	l.rubusch@gmail.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 02/11] ARM: dts: socfpga: add Enclustra base-board dtsi
Date: Sat, 16 Nov 2024 13:10:16 +0000
Message-Id: <20241116131025.114542-3-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241116131025.114542-1-l.rubusch@gmail.com>
References: <20241116131025.114542-1-l.rubusch@gmail.com>
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
index 000000000..abc4bfb7f
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
+	eeprom@57 {
+		status = "okay";
+		compatible = "microchip,24c128";
+		reg = <0x57>;
+		pagesize = <64>;
+		label = "user eeprom";
+		address-width = <16>;
+	};
+
+	lm96080: temperature-sensor@2f {
+		status = "okay";
+		compatible = "national,lm80";
+		reg = <0x2f>;
+	};
+
+	si5338: clock-controller@70 {
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
index 000000000..bc57b0680
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
+			eeprom@56 {
+				status = "okay";
+				compatible = "microchip,24c128";
+				reg = <0x56>;
+				pagesize = <64>;
+				label = "user eeprom";
+				address-width = <16>;
+			};
+
+			lm96080: temperature-sensor@2f {
+				status = "okay";
+				compatible = "national,lm80";
+				reg = <0x2f>;
+			};
+
+			pcal6416: gpio@20 {
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
index 000000000..4c00475f4
--- /dev/null
+++ b/arch/arm/boot/dts/intel/socfpga/socfpga_enclustra_mercury_st1.dtsi
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Copyright (C) 2024 Enclustra GmbH - https://www.enclustra.com
+ */
+
+&i2c_encl {
+	si5338: clock-controller@70 {
+		compatible = "silabs,si5338";
+		reg = <0x70>;
+	};
+};
+
+&i2c_encl_fpga {
+	status = "okay";
+};
-- 
2.39.2


