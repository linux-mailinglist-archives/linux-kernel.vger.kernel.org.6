Return-Path: <linux-kernel+bounces-373404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5449B9A5652
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 21:44:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDA9F1F21CA7
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 19:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4F8D19CC1F;
	Sun, 20 Oct 2024 19:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RgrpGH3l"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF60198833;
	Sun, 20 Oct 2024 19:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729453254; cv=none; b=iGwSylLRP570aytvXsffc1ssqWy6fJNnLdjWprVaAaNH2K4a7c3zkBp8b3W2A3/STn3MJARv5IW7A36+A7wr+7IpjoDgu4hwTl+s/Twa+mCumTrsQXFNdBsazrIdm/0TrUhsaUfw8gBxl9Nx8iLm5p85f5B7MuwgT0JhY5iZzWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729453254; c=relaxed/simple;
	bh=q+R/yLvzBZ1F+I5J/jkSZ1GqhQnL9MtK1KuSrYX1PKI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gDi26QoM7tUhWSQRgyvR9a5Kox9J/XHnwUZam7HiYXArZrxH5q6CYiYerSqzlehhvVU9aGepn2jENeL3nGCdleg4JvhJUhKsT5l2wGJbVPM+xvjD2N07jRL42koAPb9EQTD5pvJTcEdlgzuZvkEH4+ZsPoZNKBnC+6vgK/tXmyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RgrpGH3l; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5c9ff17eddbso529898a12.3;
        Sun, 20 Oct 2024 12:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729453250; x=1730058050; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u0BtAunKdjzqfNoYuPz7DgcoO8tqHEt2iWmizOSxAGw=;
        b=RgrpGH3lyH+d4sbdTtqh1QPuyOFPoud+H4IYJJjZrbjxKdR7/sr0nYqCiidSP5kn/e
         1m6Kt6yNZ7btJ3CF7o+kUBnc4CYuuXLBIv+J6Wh1EEpra+bGCpKVe5FCGk8C45zAX5VJ
         Dg+dd8W9T7aZnmIVvseB7RqQFAa8lFZJ94jA4fqnQKFKnLrQOLFNvUQnp2R0G/6YNnrM
         4gqYfwEQfS5a+C+WmgeLmIHAwkE0rMJiXGQFsK/r381Mhj9rnFf77PHkUnGY0DMdKeJN
         0KDlzcF1IBvgHeTLvvZMrKRACUQTAbjo/5vGUeBJO2LS7bnL6eh7un49XLiWpg4Mkok4
         vgug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729453250; x=1730058050;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u0BtAunKdjzqfNoYuPz7DgcoO8tqHEt2iWmizOSxAGw=;
        b=RU7RV1tlV4bzNhaFEdtBE/mpE7aoY4LyxRue6IEsF+gl44x5NpedNWpkdJHj1cnGfA
         lnngPA+Ut2DbPpdwM86RAlWBh6voPUMCFnhkCPSn34EJ5UeLbb9dLMcNg7Q+QCHp/Pjo
         xX/O3tpVfwMRdeoXS+vzHokPKvbRoBRJgPUyk+ogWtk5bSpJKGdhyKAvEY15cnOkSJzI
         Mh3s3I6U3uMklRGesmgRGCXr5p3eEAPOOlROritAri8wa54szgY7HU5mF03frhbjYIJM
         qSKVjt0bD4IFaE0c4nRq2AJgZF4vyr18cN1uasva4012rKK/VaQ0Zb7ljg3mqNoQrwAh
         of4A==
X-Forwarded-Encrypted: i=1; AJvYcCX+bSD6+K2uN2fDL/S4Ju80/BVd0f/qpWL0Voib6956A53GQSnLwomhKClkkU39xN9Pv6z0HZcTPpH5@vger.kernel.org, AJvYcCXSrW9/+uSm58IshAQrU9P5OIYTQS0ZOp5RTXuS0EUOLE4u2Rtzj3XEVfV3swv6hhMkf+JIQ/kURUMmUtlp@vger.kernel.org
X-Gm-Message-State: AOJu0YzAYtKjk4nE6Dcj0sgxdhh+whaDyDdmZDCx3MjOiBtPLpB4fJGh
	xX8wqh889ccIrXsfBf5pQeJB4aREJYgAzLI50M8O8H+Vcrf4LHnX
X-Google-Smtp-Source: AGHT+IF86dEcCOG0c7gWjYCxhuoi7zk9MiSeeHtvULwuhlZrFfpwpvsu04iK/Q9U1p/9I/Zy4k+GnQ==
X-Received: by 2002:a17:907:7e94:b0:a86:a4cf:a197 with SMTP id a640c23a62f3a-a9a69a762a2mr345702966b.5.1729453250269;
        Sun, 20 Oct 2024 12:40:50 -0700 (PDT)
Received: from e8ff02ae9b18.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a91578129sm120576966b.186.2024.10.20.12.40.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Oct 2024 12:40:49 -0700 (PDT)
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
Subject: [PATCHv2 14/23] ARM: dts: socfpga: add Enclustra base-board dtsi
Date: Sun, 20 Oct 2024 19:40:19 +0000
Message-Id: <20241020194028.2272371-15-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241020194028.2272371-1-l.rubusch@gmail.com>
References: <20241020194028.2272371-1-l.rubusch@gmail.com>
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


