Return-Path: <linux-kernel+bounces-338017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EA827985272
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 07:32:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A28111F2414C
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 05:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A22971547C8;
	Wed, 25 Sep 2024 05:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deepcomputing-io.20200927.dkim.feishu.cn header.i=@deepcomputing-io.20200927.dkim.feishu.cn header.b="piCUif4N"
Received: from va-2-36.ptr.blmpb.com (va-2-36.ptr.blmpb.com [209.127.231.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E19A14A62F
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 05:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727242324; cv=none; b=j5gdSaAHQGmsrhOWtrx/PQiDc3VLDI3nEAX4b0P2KHHtQLNyYxV3fddcWsJ0UmdbnXkshGN3CY/v/iX8XJaXRFiI8/3WR/ufv3U0UIRYKbQ3V2ly6Fj3thRUKTtrOwTTVNkPSv2Vmri/nNjgje0n46RsBC6R88f748kGCPPBnrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727242324; c=relaxed/simple;
	bh=oWZmiIbjQT0De+OL/t1G2I6RM9m4+sFQLz18NUIyeRI=;
	h=Mime-Version:To:From:Subject:Content-Type:Date:Message-Id:Cc; b=YdTFg1GYrnAHkh4Lth9H3n4D6nCJXWQ7sbfSwXSiZxIcQCwKntYYV17zJxddRRa8LCxkI5T226L/D6b7cIZeZgFon0hk29V3wgsfWFc00b+tN6MJWhEEG/U5iJazVMTIcq0v80rn8eKqtCcX1qEyZttUwMg8TB0mjzxXDP6bC/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=deepcomputing.io; spf=pass smtp.mailfrom=deepcomputing.io; dkim=pass (2048-bit key) header.d=deepcomputing-io.20200927.dkim.feishu.cn header.i=@deepcomputing-io.20200927.dkim.feishu.cn header.b=piCUif4N; arc=none smtp.client-ip=209.127.231.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=deepcomputing.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deepcomputing.io
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=deepcomputing-io.20200927.dkim.feishu.cn; t=1727242317;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=pGWCgDk61rwIBgwBo0KUX98obiQ99nTGhun7/GfXg38=;
 b=piCUif4NF9SJ+UBY6eg0wjhZXap4PtikstBTPmYfyjoK0YMUH4PzaL/amg/qUVC0/NbCR1
 yDsJzIG2NW84YdayC7WeuVepYqglyDyWzT9YhyYwfC/DBhh92MpH4K/78fd9pt4hbTe9Ow
 iU/trsrV5pLVcpgbEU77Ae0s4ambO8XwqqSpNUCEFEdoD5cqbd9WFNte7Ic3LVHYOd4qX3
 4xMu1hcbixfR/NAhd40NcpdyBpLejLdzS41sRih2QmN5286NK3ImxLGTZJCefu1wz1knjb
 OAors1y5aSGkpu2QevLokLaNdDC1hSKElO6D/+UIbJVKgHxqN6GGG4wqB09gXg==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Received: from roma-MacBookPro.. ([61.141.249.39]) by smtp.feishu.cn with ESMTPS; Wed, 25 Sep 2024 13:31:55 +0800
X-Lms-Return-Path: <lba+266f3a04c+c4f9d9+vger.kernel.org+sandie.cao@deepcomputing.io>
To: "Emil Renner Berthing" <kernel@esmil.dk>
From: "Sandie Cao" <sandie.cao@deepcomputing.io>
Subject: [PATCH v3 3/3] riscv: dts: starfive: add framework dts
Content-Type: text/plain; charset=UTF-8
Date: Wed, 25 Sep 2024 13:31:23 +0800
Message-Id: <20240925053123.1364574-4-sandie.cao@deepcomputing.io>
Cc: "Conor Dooley" <conor@kernel.org>, "Rob Herring" <robh@kernel.org>, 
	"Krzysztof Kozlowski" <krzk+dt@kernel.org>, 
	"Paul Walmsley" <paul.walmsley@sifive.com>, 
	"Palmer Dabbelt" <palmer@dabbelt.com>, 
	"Albert Ou" <aou@eecs.berkeley.edu>, 
	"Heiko Stuebner" <heiko.stuebner@cherry.de>, 
	"Neil Armstrong" <neil.armstrong@linaro.org>, <rafal@milecki.pl>, 
	"Linus Walleij" <linus.walleij@linaro.org>, 
	"Michael Zhu" <michael.zhu@starfivetech.com>, 
	"Drew Fustini" <drew@beagleboard.org>, <linux-riscv@lists.infradead.org>, 
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>, 
	<dhs@frame.work>, <ams@frame.work>, <gregkh@linuxfoundation.org>, 
	<yuning.liang@deepcomputing.io>, <huiming.qiu@deepcomputing.io>, 
	"Sandie Cao" <sandie.cao@deepcomputing.io>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 7bit
X-Original-From: Sandie Cao <sandie.cao@deepcomputing.io>

Add framework dts to support RISC-V Framework Laptop 13 Mainboard.


DeepComputing is creating a RISC-V Framework Laptop 13 Mainboard 
powered by a StarFive JH7110 processor.This is a developer-focused 
product, aimed at making tinkering with RISC-V more accessible.
The Mainboard is under development and we'll share more on functionality, 
compatibility, and availability as the program progresses.

For this Mainboard, the Model name in Framework is Framework FRANME0000;
the Model name in DeepComputing is DeepComputing fm7110.

The board features:

- JH7110 SoC
- 8 GiB LPDDR4 DRAM
- 1x Type-c(PD3.0:60W Max;usb3.2 Gen1;usb2.0;DP1.4:4K@30Hz/2.5K@60Hz)
- 1x Type-c(PD3.0:60W Max,usb3.2 Gen1;usb2.0)
- 2x Type-c(usb3.2 Gen1;usb2.0)
- 1x eMMC slot Support 32G/128G
- 1x MicroSD slot
- 1x QSPI Flash
- 1x PCIe Wi-Fi (Support AMD RZ616 Wi-Fi 6E,Intel Wi-Fi 6E AX210 No vPro)

Signed-off-by: Sandie Cao <sandie.cao@deepcomputing.io>
---
 arch/riscv/boot/dts/starfive/Makefile         |  1 +
 .../boot/dts/starfive/jh7110-framework.dts    | 34 +++++++++++++++++++
 2 files changed, 35 insertions(+)
 create mode 100644 arch/riscv/boot/dts/starfive/jh7110-framework.dts

diff --git a/arch/riscv/boot/dts/starfive/Makefile b/arch/riscv/boot/dts/starfive/Makefile
index 7a163a7d6ba3..3746f7122834 100644
--- a/arch/riscv/boot/dts/starfive/Makefile
+++ b/arch/riscv/boot/dts/starfive/Makefile
@@ -8,6 +8,7 @@ DTC_FLAGS_jh7110-starfive-visionfive-2-v1.3b := -@
 dtb-$(CONFIG_ARCH_STARFIVE) += jh7100-beaglev-starlight.dtb
 dtb-$(CONFIG_ARCH_STARFIVE) += jh7100-starfive-visionfive-v1.dtb
 
+dtb-$(CONFIG_ARCH_STARFIVE) += jh7110-framework.dtb
 dtb-$(CONFIG_ARCH_STARFIVE) += jh7110-milkv-mars.dtb
 dtb-$(CONFIG_ARCH_STARFIVE) += jh7110-pine64-star64.dtb
 dtb-$(CONFIG_ARCH_STARFIVE) += jh7110-starfive-visionfive-2-v1.2a.dtb
diff --git a/arch/riscv/boot/dts/starfive/jh7110-framework.dts b/arch/riscv/boot/dts/starfive/jh7110-framework.dts
new file mode 100644
index 000000000000..ff12c24ebab3
--- /dev/null
+++ b/arch/riscv/boot/dts/starfive/jh7110-framework.dts
@@ -0,0 +1,34 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
+/*
+ * Copyright (C) 2022 StarFive Technology Co., Ltd.
+ * Copyright (C) 2022 Emil Renner Berthing <kernel@esmil.dk>
+ */
+
+/dts-v1/;
+#include "jh7110-common.dtsi"
+
+/ {
+	model = "Framework FRANME0000";
+	compatible = "deepcomputing,fm7110", "starfive,jh7110";
+};
+
+&gmac0 {
+	status = "disabled";
+};
+
+&gmac1 {
+	status = "disabled";
+};
+
+&usb0 {
+	dr_mode = "host";
+	status = "okay";
+};
+
+&pwmdac {
+	status = "disabled";
+};
+
+&pcie0 {
+	status = "disabled";
+};
-- 
2.34.1

