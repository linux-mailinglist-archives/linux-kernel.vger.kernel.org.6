Return-Path: <linux-kernel+bounces-373262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 817169A5469
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 15:52:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D5BC282D35
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 13:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F019193063;
	Sun, 20 Oct 2024 13:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="FUn7EJhd"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D7F1925B8
	for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2024 13:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729432315; cv=none; b=ttIPcpnfjqc1u1FFccZf98BXld6axUmnAHi+VeQhZsnK/KBkQ1g6husZaXdAZRGpigo5XhhP9sqg8xnKvAPrPvdH3eSunjPHUKZQCMZy/G4yjPZLS94ImxNsCv0Jirl/p1nJITl8OIOrCQyQI/p5pUtnNrkcRLtrYvTScHPDKjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729432315; c=relaxed/simple;
	bh=RsFNGv22sG4fCdMOrDoSctiX3RPx7FkgVT6SE5QOBYw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rWjyOa3p3cKqnEBqsMoGNf4DpPYLVBbqw6M0En0xOz3Uyz57N3WKtA4rpMCNA9sWLdZarGWmoJ0hycQoXSoL0LiOVJapxRS0p/2KTofRechwCKtQG8pwf4bA4u5SyOixirhyLKcSDlv8yAXxSRmtY3iEUq41WKEgkCa8nQ1TZ40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=FUn7EJhd; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-20cbb1cf324so32219605ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2024 06:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1729432312; x=1730037112; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dihnrmjt0Cx1sW6hIV5b9q9IzCAC+S03ZrQpLAf6DXI=;
        b=FUn7EJhdgluPG9DXTJ6HoWFURIpaljxZo/R0/IdrAVIh9e1l1XVzBpsWFWdSvRbRcz
         LX25N52AjOH/aWjUWGLOy7vYzcyWzdb02LsluouCL2TDps989ejZTpFMVlRtTyCESbJV
         jORj5vXidUZedyrIZKtay9axZ963wkw2i+uP75aRm36jwMvVVkLE1Gayfnz+Z942ETw+
         WONj1DsrzTOOc6IMC41Mzi4MeA6moTr1D+xfG7LAID256zr6QViqeGlxuepdQKbK2wdx
         sZguucfJcp/0bYEEVlIyDYygXT1sd4FLHmy9HK8ANtDX3ztw5k1TXFReLHbnXQqWfabb
         1cmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729432312; x=1730037112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dihnrmjt0Cx1sW6hIV5b9q9IzCAC+S03ZrQpLAf6DXI=;
        b=FkiVF9BwG2AaohLbUg1jDWVJs/QChg9to4SFHzWTr/RthtgCscrFqbEAb+pChEu0b3
         IulUeN/EieTIfNkdoI8zTDTuYYR+gvMsxdOCdOj4HcNxrIQD1tVOdgFJ6GqbkBhOtL0j
         6p3kX5TAJtCVFrG6pp/Ul93S5XQVDT8fVM2WcGXCRre/KatlojNbjVW65q8r1+bq6BfB
         9W06EhiyDC9kiehpfAXjZSg/wgppvbuwd7MX+WXPKgp/Qe8sPMmSlMR+G3HTDnWS5i+c
         NUb2neFOB3Hetr/R24cTK5QPbhZ5AJ33AD4qOjPZ5mKUgMyGJve88ahSw03tukZPrmPo
         xr+Q==
X-Forwarded-Encrypted: i=1; AJvYcCW5Vvm88CixhGTVh7McfIf9NmOAf21Tu5YTtdXSn5vlAD4gh9G+TDRvyNa6lOhh10Xubc7/y/ZOr/cfZBk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEAthDZT+8Rq4E/cMyY+OAVuE/VUMEVnJgjgh4NVWantkAQDSd
	xr8Oyw9o1HDXbApPljM/adm/ijo2Q7f0wdFsCaHuz+qetqKgbM3lrvPgBPUqAgc=
X-Google-Smtp-Source: AGHT+IE0C8U3ppaL1ZcOhngjMTld2ijPjY1NBwe1b/U8l0HwDFa5HUPH4SIbia5o3FNaHcPCORuA4g==
X-Received: by 2002:a17:902:e845:b0:20b:ab4b:544a with SMTP id d9443c01a7336-20e5a8ee9e6mr114664235ad.43.1729432311986;
        Sun, 20 Oct 2024 06:51:51 -0700 (PDT)
Received: from localhost.localdomain ([2a11:3:200::40df])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e7eee63f0sm10554935ad.3.2024.10.20.06.51.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Oct 2024 06:51:51 -0700 (PDT)
From: Guodong Xu <guodong@riscstar.com>
To: Conor Dooley <conor@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Emil Renner Berthing <kernel@esmil.dk>,
	rafal@milecki.pl,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Heiko Stuebner <heiko.stuebner@cherry.de>,
	Michael Zhu <michael.zhu@starfivetech.com>,
	Drew Fustini <drew@beagleboard.org>,
	Alexandru Stan <ams@frame.work>,
	Daniel Schaefer <dhs@frame.work>,
	Sandie Cao <sandie.cao@deepcomputing.io>,
	Yuning Liang <yuning.liang@deepcomputing.io>,
	Huiming Qiu <huiming.qiu@deepcomputing.io>,
	Alex Elder <elder@riscstar.com>,
	linux@frame.work,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Guodong Xu <guodong@riscstar.com>
Subject: [PATCH v5 3/3] riscv: dts: starfive: add DeepComputing FML13V01 board device tree
Date: Sun, 20 Oct 2024 21:49:59 +0800
Message-Id: <20241020134959.519462-4-guodong@riscstar.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241020134959.519462-1-guodong@riscstar.com>
References: <20241020134959.519462-1-guodong@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sandie Cao <sandie.cao@deepcomputing.io>

The FML13V01 board from DeepComputing incorporates a StarFive JH7110 SoC.
It is a mainboard designed for the Framework Laptop 13 Chassis, which has
(Framework) SKU FRANHQ0001.

The FML13V01 board features:
- StarFive JH7110 SoC
- LPDDR4 8GB
- eMMC 32GB or 128GB
- QSPI Flash
- MicroSD Slot
- PCIe-based Wi-Fi
- 4 USB-C Ports
 - Port 1: PD 3.0 (60W Max), USB 3.2 Gen 1, DP 1.4 (4K@30Hz/2.5K@60Hz)
 - Port 2: PD 3.0 (60W Max), USB 3.2 Gen 1
 - Port 3 & 4: USB 3.2 Gen 1

Create the DTS file for the DeepComputing FML13V01 board. Seven device
nodes have been verified functional and remain enabled: i2c2, i2c5, i2c6
qspi, mmc0, mmc1 and usb0.  All others remain disabled, or are disabled
by nodes in "jh7110-deepcomputing-fml13v01.dts".

Signed-off-by: Sandie Cao <sandie.cao@deepcomputing.io>
[elder@riscstar.com: revised the description, updated some nodes]
Signed-off-by: Alex Elder <elder@riscstar.com>
Signed-off-by: Guodong Xu <guodong@riscstar.com>
---
v5: No change
v4: Changed model string to "DeepComputing FML13V01"
    Changed dts filename and Makefile accordingly to reflect the change
    Updated device nodes status, and verified functional
    Revised the commit message
v3: Updated the commit message
v2: Changed the model and copmatible strings
    Updated the commit message with board features

 arch/riscv/boot/dts/starfive/Makefile         |  1 +
 .../jh7110-deepcomputing-fml13v01.dts         | 44 +++++++++++++++++++
 2 files changed, 45 insertions(+)
 create mode 100644 arch/riscv/boot/dts/starfive/jh7110-deepcomputing-fml13v01.dts

diff --git a/arch/riscv/boot/dts/starfive/Makefile b/arch/riscv/boot/dts/starfive/Makefile
index 7a163a7d6ba3..b3bb12f78e7d 100644
--- a/arch/riscv/boot/dts/starfive/Makefile
+++ b/arch/riscv/boot/dts/starfive/Makefile
@@ -8,6 +8,7 @@ DTC_FLAGS_jh7110-starfive-visionfive-2-v1.3b := -@
 dtb-$(CONFIG_ARCH_STARFIVE) += jh7100-beaglev-starlight.dtb
 dtb-$(CONFIG_ARCH_STARFIVE) += jh7100-starfive-visionfive-v1.dtb
 
+dtb-$(CONFIG_ARCH_STARFIVE) += jh7110-deepcomputing-fml13v01.dtb
 dtb-$(CONFIG_ARCH_STARFIVE) += jh7110-milkv-mars.dtb
 dtb-$(CONFIG_ARCH_STARFIVE) += jh7110-pine64-star64.dtb
 dtb-$(CONFIG_ARCH_STARFIVE) += jh7110-starfive-visionfive-2-v1.2a.dtb
diff --git a/arch/riscv/boot/dts/starfive/jh7110-deepcomputing-fml13v01.dts b/arch/riscv/boot/dts/starfive/jh7110-deepcomputing-fml13v01.dts
new file mode 100644
index 000000000000..b515b7d04c37
--- /dev/null
+++ b/arch/riscv/boot/dts/starfive/jh7110-deepcomputing-fml13v01.dts
@@ -0,0 +1,44 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
+/*
+ * Copyright (C) 2024 DeepComputing (HK) Limited
+ */
+
+/dts-v1/;
+#include "jh7110-common.dtsi"
+
+/ {
+	model = "DeepComputing FML13V01";
+	compatible = "deepcomputing,fml13v01", "starfive,jh7110";
+};
+
+&camss {
+	status = "disabled";
+};
+
+&csi2rx {
+	status = "disabled";
+};
+
+&gmac0 {
+	status = "disabled";
+};
+
+&i2c0 {
+	status = "disabled";
+};
+
+&pwm {
+	status = "disabled";
+};
+
+&pwmdac {
+	status = "disabled";
+};
+
+&spi0 {
+	status = "disabled";
+};
+
+&usb0 {
+	dr_mode = "host";
+};
-- 
2.34.1


