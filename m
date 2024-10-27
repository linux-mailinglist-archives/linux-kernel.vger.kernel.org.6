Return-Path: <linux-kernel+bounces-383680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 567289B1EFF
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 15:47:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79EF01C209CF
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 14:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 542212AF05;
	Sun, 27 Oct 2024 14:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="UQbaKaLr"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C25FBC13B
	for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2024 14:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730040443; cv=none; b=gH5rDxn4w+X+AXsEAAMo3lTDszaPfWYwopz8GhcCHVYOQxTBSFpkpIExGTwnQtasy497Hxx42IT8pww4EfOkauakZHy1B/amg0n7EGuOThezg3qtDRKC8UXz1Taiz2MQ0AeFDnTdgRyM9PmF8Jz1yYEEuN5y+SzW/8mPkiUHLHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730040443; c=relaxed/simple;
	bh=UC7R2lYJdSqqf3YGf5332838pRZm9+/T17L7BeGyzWY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=a7XY/LwAyf+axVQ0z0rvB6Z1uPEjf6Enl0QrHEtYF7S2ftizAj3N23HDAhTGBfO4kIRigj0R2PG5KzZhJ6AjGD88Nd8xLqjb4/W1kVgFLfDkMdm0EwvbdTmtT0tB0ww7ZsUKlNo1JhM64CqavClRBBDsJwUM7yeMD0fuzIklfMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=UQbaKaLr; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7205646f9ebso1627172b3a.0
        for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2024 07:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1730040441; x=1730645241; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+wvAtnVKug+duYdZaolG15HbB51AquCXywvQfcB1XNM=;
        b=UQbaKaLr1brp/DXihqeXD98svzNLv/Gf29pQR/GW5WrdttWwvi0HBbTl0H1//EvC5g
         81AUhYU3P//3W/OFByQ8YMU5D7yXgHVy0m04PvIRmMjSPXj5rOlDxc66aM6fsuI84q2A
         fT6VXC6bP5YefqRgPaEZL6jghwa7adOFwDH+LrUHVoaiJqMHo10cht+i/yLvDIyPWe4X
         wRA2GqenKNTe1Am7ygsec40DQFoToh5EvCvrb16OjX++YvmBS5wqjpdcV3l3dP/z3fqo
         skUm01/qnxijpHuDNxX8dt3lP03V2FQhecbfUV0f1WEkzi2muibIyAvDHyV/0YHdk88J
         DdXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730040441; x=1730645241;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+wvAtnVKug+duYdZaolG15HbB51AquCXywvQfcB1XNM=;
        b=M5DPFRxB5FeFBzwi8an4HNa3+9GKHSC4LZ2iRyzCx8hzH0SZiNbPEm2N9jG8RBHsNS
         2q7QHbtbjTgamXcODZOfbcNr8e6fz89M27ZYhi4FuUwwD3nh7MTlr+LmZYJnrfVa4Hen
         JdhRlJcDCWCR7SSuKWyTTjR7F+WS8yN+69JkPHKuYvVX73o4rVtPy3gP/DNNfaSZuL6n
         +G01pDoau0EGeD6i8TBaxLAqDEPs6rf2qWxYwgKQmbhKZmCJqCjlL1+SMxL6NsyJazY/
         ZyEMGRbP59J39YkSij7s7YitbS4fsH8uzGmAjmBpQFH/pnE+k79RFOdPr/5yemirrzIg
         gs3A==
X-Forwarded-Encrypted: i=1; AJvYcCUCDZZj3Z25FJT8QD2yU/DXD9kPRs5I6WTiUabKehGlk72olNRQMaxTnvbXXpwXi1E1hMJtrBY0JvzdaZU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcIzH701AoQeHRI1IQgFrnfwfxaVSI38GXnFPl6PQjrzz1zTgT
	E+FTFcNRXgPCDGkYQlyI0XCWV2a8Oeww5LvDGX1NSg9BCgQ7Sco1/7wW5elM38I=
X-Google-Smtp-Source: AGHT+IFZ8JfzRKLnF0QcT9iry3r3kCh6zjZywop0HCotG7xPZgCeXWFldiFXMJMj7ItUcYcarU72Bw==
X-Received: by 2002:a05:6a00:2d84:b0:71e:693c:107c with SMTP id d2e1a72fcca58-72062fb8107mr8106494b3a.11.1730040441113;
        Sun, 27 Oct 2024 07:47:21 -0700 (PDT)
Received: from localhost.localdomain ([2a11:3:200::401b])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72057a0cb06sm4065110b3a.115.2024.10.27.07.47.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Oct 2024 07:47:20 -0700 (PDT)
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
Subject: [PATCH v6 5/5] riscv: dts: starfive: add DeepComputing FML13V01 board device tree
Date: Sun, 27 Oct 2024 22:44:48 +0800
Message-Id: <20241027144448.1813611-6-guodong@riscstar.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241027144448.1813611-1-guodong@riscstar.com>
References: <20241027144448.1813611-1-guodong@riscstar.com>
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

Create the DTS file for the DeepComputing FML13V01 board. Based on
'jh7110-common.dtsi', usb0 is enabled and is set to operate as a "host".

Signed-off-by: Sandie Cao <sandie.cao@deepcomputing.io>
[elder@riscstar.com: revised the description, updated some nodes]
Signed-off-by: Alex Elder <elder@riscstar.com>
Signed-off-by: Guodong Xu <guodong@riscstar.com>
---
v6: Dropped all node status disabled code
    Enabled usb0 and set its operation mode to "host"
v5: No change
v4: Changed model string to "DeepComputing FML13V01"
    Changed dts filename and Makefile accordingly to reflect the change
    Updated device nodes status, and verified functional
    Revised the commit message
v3: Updated the commit message
v2: Changed the model and copmatible strings
    Updated the commit message with board features

 arch/riscv/boot/dts/starfive/Makefile           |  1 +
 .../starfive/jh7110-deepcomputing-fml13v01.dts  | 17 +++++++++++++++++
 2 files changed, 18 insertions(+)
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
index 000000000000..30b0715196b6
--- /dev/null
+++ b/arch/riscv/boot/dts/starfive/jh7110-deepcomputing-fml13v01.dts
@@ -0,0 +1,17 @@
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
+&usb0 {
+	dr_mode = "host";
+	status = "okay";
+};
-- 
2.34.1


