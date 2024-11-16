Return-Path: <linux-kernel+bounces-411733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73BA89CFEFF
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 14:10:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8DEB281EF4
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 13:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F012199951;
	Sat, 16 Nov 2024 13:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MF+RSfWc"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88B328FF;
	Sat, 16 Nov 2024 13:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731762632; cv=none; b=rF8fah+5cB4gXWdueiirThSKcN5siobCyNFa28EP/zgpO6i7gEvaMWe/6VrVjnQLAvJUp5Q/xU4r5KbCR2KSmB9cMgKqfrZeo1S4eHWHsRdB3ogwyKgM4IAO+c5M4Bysaq9IRXMUdjtcUDsfgXv/zHvX9k8yRzEKWgQyi1IZOZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731762632; c=relaxed/simple;
	bh=N/fPJoqX8XHfTThI2uadTSKMlOKbv8WAM4HgZcxQ39w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Tp5VcEPk3/4LMPRTDwv0Bfjik//oD18VNVoXC+b3v7L+Lc3KV1CMrN5WL8vYwrL1Iv1hnosE/6cRSE3sKOeSdHWmHbReBh3zgAMVmqwxpgfzLaEM1DodpcVdecx664Zj2MthwRjMXp8aqRlK4DlVIFA+pBHdp8TzjqCJ51oN4Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MF+RSfWc; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-38233de5ec0so82015f8f.2;
        Sat, 16 Nov 2024 05:10:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731762629; x=1732367429; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6lvahr3voQnqygWg6SmKsu+ILVJNmQNV8AWHpGOFC/w=;
        b=MF+RSfWcOqMsxNcYB0Wertdipk99NlJJ1RQiRsYImtJ4P26zQxBYdPLE9ysOW2GV1m
         uZp+e+9MUdkTBn3ZnKpD0E5M9hJ4Yz32t2nVL70CwcGI51z8Ib7j+aFxPuetGTrmTXp8
         N6Wzei6KDtRW0s4bd4+KHsSFYTNMw8Z+q4IcB1h/lFHUSbBrubXseo4vagggf7UZNoa2
         BZ3Wz+Y5KjNu+HVCJjg9XZTaM9lzWykZ2roJgc+HggtAr1WtZUyhtnT2nlJKvD4ddAeJ
         mqX1BvjN9JdlkgeTvVAU3wqiEmsW7EKOK0w6EHg3mbfPcQW6Qhu/Kl0uyXr0we9hm+qd
         t50g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731762629; x=1732367429;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6lvahr3voQnqygWg6SmKsu+ILVJNmQNV8AWHpGOFC/w=;
        b=ZE1sM5KLhVQb5p58crXR2c0j0Z5MEP15qMuror4q03FVObArBH1BvckpsAZjhsT+Ss
         8vvid3a8KOjFqD7zyqRDvmW4FQDlNKcthAJfNW97yoSCJnkxYVJuZB2bd0+/dFOUDNWK
         9gSjvpb95lEA6Bwxga/5qY19lfRt0J4g7NasLVxeGPvVvn01ZykmDPUwdXVbR0pzfYCQ
         4pim3tzEx9/yoMYAi7ukeXk3hMt5lOYv7g79BMuq7mAt0CQbokDYoaCyoQTMv4vVGYq3
         1uZnBBA/XHqpkDCGMIpYb60mDbBCeWL/e+6BD29CwSntW4F+DlpDwV2/0XYynYUxHuoR
         fXYA==
X-Forwarded-Encrypted: i=1; AJvYcCUmCR/3lfk50ZOLsOjLFW9Rvu8sMcGwR7hcB2xzB5IYT9fxdou4j7N4kKdOO3naC8FCXuOSS5betbPZ@vger.kernel.org, AJvYcCVT4oqsXmE+wrBovi/SSox38py6KY3igGmbf0Q1usE90T7hzQ1yc6jvxq/Dd/SxVqz1pBR7HzGjwVgVdGru@vger.kernel.org
X-Gm-Message-State: AOJu0YyaZZ4OYHSBwKEWyndg1kKUr+OCsJrrsWx6M/ofR8hxULcBMxGT
	bKfgzl1xgaaxEucpCaEESERQCZXtH0Gdy4kWem2VhrcgY6/vc6g1
X-Google-Smtp-Source: AGHT+IGTlWxp32ouQm8GcDnJS7ywbIBcYzGpEVAq1n4ywZ3cWVxBbr3FeBzAq30EBVTnCm1W/x3iNQ==
X-Received: by 2002:a05:600c:5250:b0:42c:c0d8:bf34 with SMTP id 5b1f17b1804b1-432df679bfdmr22544135e9.0.1731762628857;
        Sat, 16 Nov 2024 05:10:28 -0800 (PST)
Received: from 5dfbf0f66296.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432da28ba80sm92424375e9.29.2024.11.16.05.10.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Nov 2024 05:10:27 -0800 (PST)
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
Subject: [PATCH v5 01/11] ARM: dts: socfpga: add Enclustra boot-mode dtsi
Date: Sat, 16 Nov 2024 13:10:15 +0000
Message-Id: <20241116131025.114542-2-l.rubusch@gmail.com>
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

Add generic boot-mode support to Enclustra Arria10 and Cyclone5 boards.
Some Enclustra carrier boards need hardware adjustments specific to the
selected boot-mode.

Enclustra's Arria10 SoMs allow for booting from different media. By
muxing certain IO pins, the media can be selected. This muxing can be
done by gpios at runtime e.g. when flashing QSPI from off the
bootloader. But also to have statically certain boot media available,
certain adjustments to the DT are needed:
- SD: QSPI must be disabled
- eMMC: QSPI must be disabled, bus width can be doubled to 8 byte
- QSPI: any mmc is disabled, QSPI then defaults to be enabled

The boot media must be accessible to the bootloader, e.g. to load a
bitstream file, but also to the system to mount the rootfs and to use
the specific performance.

Signed-off-by: Andreas Buerkler <andreas.buerkler@enclustra.com>
Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 .../socfpga_enclustra_mercury_bootmode_emmc.dtsi     | 12 ++++++++++++
 .../socfpga_enclustra_mercury_bootmode_qspi.dtsi     |  8 ++++++++
 .../socfpga_enclustra_mercury_bootmode_sdmmc.dtsi    |  8 ++++++++
 3 files changed, 28 insertions(+)
 create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_enclustra_mercury_bootmode_emmc.dtsi
 create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_enclustra_mercury_bootmode_qspi.dtsi
 create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_enclustra_mercury_bootmode_sdmmc.dtsi

diff --git a/arch/arm/boot/dts/intel/socfpga/socfpga_enclustra_mercury_bootmode_emmc.dtsi b/arch/arm/boot/dts/intel/socfpga/socfpga_enclustra_mercury_bootmode_emmc.dtsi
new file mode 100644
index 000000000..d79cb64da
--- /dev/null
+++ b/arch/arm/boot/dts/intel/socfpga/socfpga_enclustra_mercury_bootmode_emmc.dtsi
@@ -0,0 +1,12 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Copyright (C) 2024 Enclustra GmbH - https://www.enclustra.com
+ */
+
+&qspi {
+	status = "disabled";
+};
+
+&mmc {
+	bus-width = <8>;
+};
diff --git a/arch/arm/boot/dts/intel/socfpga/socfpga_enclustra_mercury_bootmode_qspi.dtsi b/arch/arm/boot/dts/intel/socfpga/socfpga_enclustra_mercury_bootmode_qspi.dtsi
new file mode 100644
index 000000000..5ba21dd8f
--- /dev/null
+++ b/arch/arm/boot/dts/intel/socfpga/socfpga_enclustra_mercury_bootmode_qspi.dtsi
@@ -0,0 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Copyright (C) 2024 Enclustra GmbH - https://www.enclustra.com
+ */
+
+&mmc {
+	status = "disabled";
+};
diff --git a/arch/arm/boot/dts/intel/socfpga/socfpga_enclustra_mercury_bootmode_sdmmc.dtsi b/arch/arm/boot/dts/intel/socfpga/socfpga_enclustra_mercury_bootmode_sdmmc.dtsi
new file mode 100644
index 000000000..2b102e0b6
--- /dev/null
+++ b/arch/arm/boot/dts/intel/socfpga/socfpga_enclustra_mercury_bootmode_sdmmc.dtsi
@@ -0,0 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Copyright (C) 2024 Enclustra GmbH - https://www.enclustra.com
+ */
+
+&qspi {
+	status = "disabled";
+};
-- 
2.39.2


