Return-Path: <linux-kernel+bounces-411741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 10EEB9CFF10
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 14:13:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 954B6B2875F
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 13:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 004FE192D67;
	Sat, 16 Nov 2024 13:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cP7+GAwj"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D601BD003;
	Sat, 16 Nov 2024 13:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731762643; cv=none; b=iG9jI+0GawMyngwZH5GP3NjKJHhlFNvzYWyyECtBfEP3yFvDmWoygw295lTM2mUZX3Yp3YFaoqQ6qKmtGmupp4t0bV8qV5/kW7qLn38H7fXoIIQGm9i2pvP9s2uwNuuTY92vG/YwuBJRRL36w7MOfquqOsj7QQfg97PeJLbdzGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731762643; c=relaxed/simple;
	bh=Mok9Eqm2R+qKa9UoCehjK4ygp/HkMoEY0E+Vkh2yLJM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Iif56APWv1dA1pONwHXgUk76B41UUHWOZoMWYNjEWZcD33nonqQc7jxSJP5eHekHnFmtgXOFXVkvFU7Pkcv7W0NGsdNjxRh19EOy93MPkaGpiFcodmB9qKYX/nnXNQ3/QU/XFo1KQ0EIQzkfA19r1EA+alAoGuPwj8P4Lin//x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cP7+GAwj; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-38226e899feso189739f8f.1;
        Sat, 16 Nov 2024 05:10:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731762639; x=1732367439; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DSxbet86oEBicVxt3ZGD+YsYIZpnYVjjludJtf8eu7M=;
        b=cP7+GAwj9vd1QpwEjuX88P/qupmVYFfnEmTg6ycw969fJC/6vM1595MpAaISfWaauq
         +0fPfvmt74Cs2becRRIgWaWefdlG34C6vOLCsXzvK98ihlNhcuT+0INai9Ap4Xja0l+X
         X86fWfZ/fafcwttDJKm2BrgVLWZL32lC+ueDX4llrd75uPea9z2s3JBlSkKdYWLoNi1X
         0TKMKZU+KXUwkj7JkqKO+h8MCl8pmCcn2qZ5ujh/bfiImwRyz+Ehy7qlC9fCVk05ZQLs
         jxKnCEUWTIRq3i9KWQHisGkuxuTysJtPnVEt+5AuE/xB0JZHbRCPU72Oy/LYzzWkjh1W
         v2Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731762639; x=1732367439;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DSxbet86oEBicVxt3ZGD+YsYIZpnYVjjludJtf8eu7M=;
        b=lHdi0QJTSTIkGElm1rY06T5YVMmsMwLwEWCJprHr6pfB+SqJoujMeo659JXAGCrSQX
         rog++ciENFYSjRw/z3CuJQSEqbnUwUXbKlw/FvEAVwm9LluTyQzkMHjb/DthTqJ3n8Do
         XGghjcqx9U5PTRtVHrFsK2p1RYuNoix+s6NM7GkQLlhX05PwKZ8K1C95HHW1xgV4SGlr
         PWapI2KYk6h0bMIYW6tz8EE9aUKn5G+d77cx/aYnR/E+wOAPuqdQNgvN08OKVFAX4mTH
         Ziru8O6dLf5ry6HdfMMB1tjsfBmKXxXCF9eJ/4Kr6SUL8lN/ZZfl07dDA7USTkJkhASA
         0Xvg==
X-Forwarded-Encrypted: i=1; AJvYcCVY5Se35ayBJzDyA6d6oTDrN6eC2YlRJL61V8dgs/keINRWVh6y4buxxDJ/vkvfLH/wLM4++R5TuFP26fjH@vger.kernel.org, AJvYcCXKlVQBteCyFWEqL153ZJEdCW2K0S45J0E+4CVX/JcGerF6/KxVpc1q5GhmwKo4Yj+WEwjjbog4n+W8@vger.kernel.org
X-Gm-Message-State: AOJu0YwjG/UKdcB3hR6FWPQJEEx56baBDzbyZXu2zfK/KdywJ+imGpL/
	laXYmytJBwzMp/HIsBC7pnwAGQ+ekPGwFde0yiBKolArxExZP8fw
X-Google-Smtp-Source: AGHT+IEruRvbEDZVwSwuDlE4FyNnKYTYWwQBbXGEj5nH4+i6uSd2yEmET9Ob1bzvVOof2hE1POgiDA==
X-Received: by 2002:a05:600c:1d0f:b0:42c:ba6c:d9b1 with SMTP id 5b1f17b1804b1-432df78abf8mr22708075e9.4.1731762638826;
        Sat, 16 Nov 2024 05:10:38 -0800 (PST)
Received: from 5dfbf0f66296.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432da28ba80sm92424375e9.29.2024.11.16.05.10.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Nov 2024 05:10:38 -0800 (PST)
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
Subject: [PATCH v5 09/11] ARM: dts: socfpga: removal of generic PE1 dts
Date: Sat, 16 Nov 2024 13:10:23 +0000
Message-Id: <20241116131025.114542-10-l.rubusch@gmail.com>
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

Remove the older socfpga_arria10_mercury_pe1.dts, since it is duplicate,
the hardware is covered by the combination of Enclustra's .dtsi files.

The older .dts was limited to only the case of having an Enclustra
Mercury+ AA1 on a Mercury+ PE1 base board, booting from sdmmc. This
functionality is provided also by the generic Enclustra dtsi and dts
files, in particular socfpga_arria10_mercury_aa1_pe1_sdmmc.dts. Since
both .dts files cover the same, the older one is to e replaced in
favor of the more modularized approach.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
Acked-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
---
 arch/arm/boot/dts/intel/socfpga/Makefile      |  1 -
 .../socfpga/socfpga_arria10_mercury_pe1.dts   | 55 -------------------
 2 files changed, 56 deletions(-)
 delete mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_arria10_mercury_pe1.dts

diff --git a/arch/arm/boot/dts/intel/socfpga/Makefile b/arch/arm/boot/dts/intel/socfpga/Makefile
index c467828ae..d95862e34 100644
--- a/arch/arm/boot/dts/intel/socfpga/Makefile
+++ b/arch/arm/boot/dts/intel/socfpga/Makefile
@@ -2,7 +2,6 @@
 dtb-$(CONFIG_ARCH_INTEL_SOCFPGA) += \
 	socfpga_arria5_socdk.dtb \
 	socfpga_arria10_chameleonv3.dtb \
-	socfpga_arria10_mercury_pe1.dtb \
 	socfpga_arria10_socdk_nand.dtb \
 	socfpga_arria10_socdk_qspi.dtb \
 	socfpga_arria10_socdk_sdmmc.dtb \
diff --git a/arch/arm/boot/dts/intel/socfpga/socfpga_arria10_mercury_pe1.dts b/arch/arm/boot/dts/intel/socfpga/socfpga_arria10_mercury_pe1.dts
deleted file mode 100644
index cf533f76a..000000000
--- a/arch/arm/boot/dts/intel/socfpga/socfpga_arria10_mercury_pe1.dts
+++ /dev/null
@@ -1,55 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Copyright 2023 Steffen Trumtrar <kernel@pengutronix.de>
- */
-/dts-v1/;
-#include "socfpga_arria10_mercury_aa1.dtsi"
-
-/ {
-	model = "Enclustra Mercury+ PE1";
-	compatible = "enclustra,mercury-pe1", "enclustra,mercury-aa1",
-		     "altr,socfpga-arria10", "altr,socfpga";
-
-	aliases {
-		ethernet0 = &gmac0;
-		serial0 = &uart0;
-		serial1 = &uart1;
-	};
-};
-
-&gmac0 {
-	status = "okay";
-};
-
-&gpio0 {
-	status = "okay";
-};
-
-&gpio1 {
-	status = "okay";
-};
-
-&gpio2 {
-	status = "okay";
-};
-
-&i2c1 {
-	status = "okay";
-};
-
-&mmc {
-	status = "okay";
-};
-
-&uart0 {
-	status = "okay";
-};
-
-&uart1 {
-	status = "okay";
-};
-
-&usb0 {
-	status = "okay";
-	dr_mode = "host";
-};
-- 
2.39.2


