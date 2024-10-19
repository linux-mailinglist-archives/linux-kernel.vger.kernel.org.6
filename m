Return-Path: <linux-kernel+bounces-372956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36C6F9A4FCF
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 18:28:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACAF61F259D5
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 16:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECB7718D625;
	Sat, 19 Oct 2024 16:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="N6M3KsM1"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0402117C228
	for <linux-kernel@vger.kernel.org>; Sat, 19 Oct 2024 16:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729355294; cv=none; b=ZeKweY8/NjsOHi1F6vOY6pHh4/UMrirWZEn/DAwfw2M61modVJjj9HdzTQlrooZMDaP9QsmL+989/8RaF7gAknZ0S0XgrEaPczfU9kLXysfzqafXzSxVY6NMuUePVjGB2z66KaG9+k+oV/qg6M/Rn8ursNmp7ZOrqkdSffTMuos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729355294; c=relaxed/simple;
	bh=KVKR8rdAu1bTmM0Do0pe/BPyW1sGsETs56bfwx3gRAA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KAcaaXbpAQ1Z5LwpzfSN8MTIq7mTwtnfXN1HVMsJy3d94hxO9YkNqvs0reuyvlMbQ6W50p26/jUGd3nEw0q0+EaW9k711KV0UE6OMvP8b35ooD4db55+vcssd1DcDaV/iKIjNjm5tC8z4rjey5uCeu58dTOK2px8qUUna9U/cTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=N6M3KsM1; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-20cf3e36a76so31868785ad.0
        for <linux-kernel@vger.kernel.org>; Sat, 19 Oct 2024 09:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1729355290; x=1729960090; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OsH0cNinQslXDyIRyfl/9O7pxc4UGpoe6shl8RLD0+8=;
        b=N6M3KsM1DQk4yWUToGPPlMSt3C8/EcBDPg9QXtc+T1MXZP8AOsIH5U6q53bWFCaW/7
         kTBeF/jwS6p/ZspxMNaW4E+JZg+myEQxCrK6ABvQuMm82GVjWaVKUTRx9oEyR3TUedAV
         txnSObjqzk6lGywomYXGRdsbMtumCpCjtBKTdIbJaFHmgNeSe3nfHjIAT5jbuL9Gv0VW
         QQ+UOgnOzxYLZq9DWcLa5ZgxPU2JN3h/FvFwT86awOttS0ChOw1/tDCuoYo0a86xgk0+
         t8ur5LwwBVxhjjotPH2/L5kAfWUEpcY30R+NzDfWooK0hnrqkccAILQLiCSDIkrqQkr8
         oV+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729355290; x=1729960090;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OsH0cNinQslXDyIRyfl/9O7pxc4UGpoe6shl8RLD0+8=;
        b=mdLXUM+VtXhMdOU+5LD2e+1mz5FkKrchHfEyOBU7B691Galp0Ll4SRnZhP8Oi2S8Tk
         QRz2J5JZhaKGlhcFc/YFn+5c8J5O6j34NNl5PObqbJahxfcOYZ6dDuF/Dm8NMIY4N9IW
         s9OnabkuQKGfju2farH5EXHG1fQE08wQ6gXRBgTe1ePk3IeixnhAHI+wXE31IEXIcJ8D
         CHv5BsZ7dlRe9p4OfmatN+iUb03n16kmaJftK0Dvgs6eSEYRsoK/fFAzFuRcUvy7MTa2
         CslIq9OwYppsVHrlEk48sJOj4cC65aPcVrCK9F+FUO7yIOss+2yZ7Z5siHuwQtmTgWUt
         rU7w==
X-Forwarded-Encrypted: i=1; AJvYcCU4VT52GubqcHoIDiXKEMTM4SimwfTgpDDMDhAvdy0PsKu2doEiCp8bl5aFlN6QIyasckIu3MwbkODY1A4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZV4astfIW6SeFce0DKQGOPbZOLJlP496gbYqP3B18vEKIEzl1
	7T8Pe1y6RqV5JeTDrUE/yy1l+EpPDjlwocKC66ePYgfGu/DfF8bQk4ho7uAZnow=
X-Google-Smtp-Source: AGHT+IGYR5eUJwXGMxy7HdyPRDQKE3DHw/4XPlT1k5OHVZitlhHw/yWOFKmVSy270AIpQ0J0HATvDg==
X-Received: by 2002:a17:902:e892:b0:20b:bac2:88f3 with SMTP id d9443c01a7336-20e5a93ab46mr65799075ad.53.1729355290154;
        Sat, 19 Oct 2024 09:28:10 -0700 (PDT)
Received: from localhost.localdomain ([2a11:3:200::30df])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e5a8de4bdsm29567625ad.180.2024.10.19.09.27.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Oct 2024 09:28:09 -0700 (PDT)
From: Guodong Xu <guodong@riscstar.com>
To: Conor Dooley <conor@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Emil Renner Berthing <kernel@esmil.dk>,
	rafal@milecki.pl
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Heiko Stuebner <heiko.stuebner@cherry.de>,
	Michael Zhu <michael.zhu@starfivetech.com>,
	Drew Fustini <drew@beagleboard.org>,
	Alexandru Stan <ams@frame.work>,
	Daniel Schaefer <dhs@frame.work>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sandie Cao <sandie.cao@deepcomputing.io>,
	Yuning Liang <yuning.liang@deepcomputing.io>,
	Huiming Qiu <huiming.qiu@deepcomputing.io>,
	Alex Elder <elder@riscstar.com>,
	linux@frame.work,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Guodong Xu <guodong@riscstar.com>
Subject: [PATCH v4 3/3] riscv: dts: starfive: add DeepComputing FML13V01 board device tree
Date: Sun, 20 Oct 2024 00:26:05 +0800
Message-Id: <20241019162605.308475-4-guodong@riscstar.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241019162605.308475-1-guodong@riscstar.com>
References: <20241019162605.308475-1-guodong@riscstar.com>
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


