Return-Path: <linux-kernel+bounces-373413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C3F709A5664
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 21:46:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4835DB27072
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 19:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C6DE1A0737;
	Sun, 20 Oct 2024 19:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NfIA00Dp"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 438EE19F411;
	Sun, 20 Oct 2024 19:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729453268; cv=none; b=W3T8IDJP2X8x/+eSLRbLunAzUfIlRgq1pF86T+t2IpSrWGLkLu4Aop144nzaqWv2fO7PSYCKKSW3rp7Nlxr1RL5Mo/ug6pOi/e51o4r+Fj496PQFYTc9V/kjtLXv9mK+QzDDaa5fPJy3HmPGzXf7SkpCTRmpG8pQKFsZoUDrle4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729453268; c=relaxed/simple;
	bh=BKcROuWUYTw9JhFiD7stJcvz4b+0cKybV+ykIP65zt4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uHJcP1/TNAjRFMkHa+OqvxlyUfgnLYCKw2UXWaB4vnjPatQehJGtDRmy9U0rvwSCl2HwabGLBwA7XotijCQCH08tjZrGd9aUOcSi9NnHEd8mDOxp5vNN5PbojvJ4z+iQu1UjTY+uL11o3TQHu/EHfBSuSlcgiO8/v8TeMSM3ZKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NfIA00Dp; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5c9589ba577so519595a12.1;
        Sun, 20 Oct 2024 12:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729453263; x=1730058063; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=58/Yp9z5BeuiNsOYUdEfHyKptWKflHI/Ww9dE/OYykM=;
        b=NfIA00DpppjA4Jc4hhaT7PGW8m9uExhsu3m5pcgd+Muv7zacrFaj7owVGrhi0IkJ7V
         MMUMD4QR4bM7xQbBV7uAfuwVvLrYWvd5AgiVI0oNwH+d2zv8fMs2JtxpjZGc2o9LlnNO
         i0aywaCayp9P6DbYfYl/32n4fGm/dyRWZpFD2bOAi5Ff3mWB5VhzmBSvnOtamRqtemwr
         oykIh+2pSzeEoXzUNwYstO6UDfDHF4siURN1z97JM6+w/wpjOh4Ye8ViExzdEyfXexqH
         TnuZXUCN+UYs/MHqLLIuES15BBOP3OtM72xb93BoS77Y7V2/5fagD1Jn5bUQ2xvQJWpv
         jHtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729453263; x=1730058063;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=58/Yp9z5BeuiNsOYUdEfHyKptWKflHI/Ww9dE/OYykM=;
        b=KGVJAx8ST2noJKZ/IHzsKI/XDpm+5dkjf31yfbaDI4L/CPm3PSgKSwcxVElImOesnW
         osRsQzB1PZjRj62+vh50iPNPcItx3xfFuq7VQw+NRhwYzayAqgfqmYP5UPfyDjppzUqa
         cvohKj3yCoabiOtvioycQiLP2ZmD19jvU0B9QPEZJMhZFivPFOvIMqM2RbxxWVZYx49c
         n3iUOd5kHEzopIXIMBGHvMABQvMnOyAKl2zKySAHSHXx3K4JF3Y8J2si/NaABLtIf9m1
         +JSSsbdpwlcIVIZ5b7keDl+cyTyC/XPTghEk7W/ty7oLjbV5o5JOK8Ho24u/zkciM0lv
         nJcQ==
X-Forwarded-Encrypted: i=1; AJvYcCV9H3zU/3ndLX5uc1wlBs4SbWTBjSiilYL7zNSO1pcFYEIXskqYyr35hni451sgLqBdWn2TsQ6qxeOJgYK7@vger.kernel.org, AJvYcCWnLPdeIPjfSGN5qB9c8WKsDxIsjMakKHtgI8asuOqERIeKi947g33r/rICwD/o4Q9eTpktZTE7aP5Y@vger.kernel.org
X-Gm-Message-State: AOJu0YxRDDWa8UKG3OLIpOlqSJnrdxMBpCpHQND2DKhGLpyfDLnlyvra
	dKsgr1umVLdUrBWLGOtNtOzN8iAAB87frDPZx1zmMR/xKsyABi8/
X-Google-Smtp-Source: AGHT+IG+u/HiorUNZvdcujWejFMP2LtxT7MumZe4fUaCUbX19p36C3evsUqvejXKc2kAeH+sCbER2Q==
X-Received: by 2002:a17:907:6ea1:b0:a99:5a3d:3cb with SMTP id a640c23a62f3a-a9a69ba6422mr431511866b.8.1729453263186;
        Sun, 20 Oct 2024 12:41:03 -0700 (PDT)
Received: from e8ff02ae9b18.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a91578129sm120576966b.186.2024.10.20.12.41.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Oct 2024 12:41:02 -0700 (PDT)
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
Subject: [PATCHv2 23/23] ARM: dts: socfpga: add Enclustra SoM dts files
Date: Sun, 20 Oct 2024 19:40:28 +0000
Message-Id: <20241020194028.2272371-24-l.rubusch@gmail.com>
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

Add the approach to set up a combination of Enclustra's SoM on a carrier
board and corresponding boot-mode as single device-tree target.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 arch/arm/boot/dts/intel/socfpga/Makefile      | 24 +++++++++++++++++++
 .../socfpga_arria10_mercury_aa1_pe1_emmc.dts  | 16 +++++++++++++
 .../socfpga_arria10_mercury_aa1_pe1_qspi.dts  | 16 +++++++++++++
 .../socfpga_arria10_mercury_aa1_pe1_sdmmc.dts | 16 +++++++++++++
 .../socfpga_arria10_mercury_aa1_pe3_emmc.dts  | 16 +++++++++++++
 .../socfpga_arria10_mercury_aa1_pe3_qspi.dts  | 16 +++++++++++++
 .../socfpga_arria10_mercury_aa1_pe3_sdmmc.dts | 16 +++++++++++++
 .../socfpga_arria10_mercury_aa1_st1_emmc.dts  | 16 +++++++++++++
 .../socfpga_arria10_mercury_aa1_st1_qspi.dts  | 16 +++++++++++++
 .../socfpga_arria10_mercury_aa1_st1_sdmmc.dts | 16 +++++++++++++
 .../socfpga_cyclone5_mercury_sa1_pe1_emmc.dts | 16 +++++++++++++
 .../socfpga_cyclone5_mercury_sa1_pe1_qspi.dts | 16 +++++++++++++
 ...socfpga_cyclone5_mercury_sa1_pe1_sdmmc.dts | 16 +++++++++++++
 .../socfpga_cyclone5_mercury_sa1_pe3_emmc.dts | 16 +++++++++++++
 .../socfpga_cyclone5_mercury_sa1_pe3_qspi.dts | 16 +++++++++++++
 ...socfpga_cyclone5_mercury_sa1_pe3_sdmmc.dts | 16 +++++++++++++
 .../socfpga_cyclone5_mercury_sa1_st1_emmc.dts | 16 +++++++++++++
 .../socfpga_cyclone5_mercury_sa1_st1_qspi.dts | 16 +++++++++++++
 ...socfpga_cyclone5_mercury_sa1_st1_sdmmc.dts | 16 +++++++++++++
 .../socfpga_cyclone5_mercury_sa2_pe1_qspi.dts | 16 +++++++++++++
 ...socfpga_cyclone5_mercury_sa2_pe1_sdmmc.dts | 16 +++++++++++++
 .../socfpga_cyclone5_mercury_sa2_pe3_qspi.dts | 16 +++++++++++++
 ...socfpga_cyclone5_mercury_sa2_pe3_sdmmc.dts | 16 +++++++++++++
 .../socfpga_cyclone5_mercury_sa2_st1_qspi.dts | 16 +++++++++++++
 ...socfpga_cyclone5_mercury_sa2_st1_sdmmc.dts | 16 +++++++++++++
 25 files changed, 408 insertions(+)
 create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_arria10_mercury_aa1_pe1_emmc.dts
 create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_arria10_mercury_aa1_pe1_qspi.dts
 create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_arria10_mercury_aa1_pe1_sdmmc.dts
 create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_arria10_mercury_aa1_pe3_emmc.dts
 create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_arria10_mercury_aa1_pe3_qspi.dts
 create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_arria10_mercury_aa1_pe3_sdmmc.dts
 create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_arria10_mercury_aa1_st1_emmc.dts
 create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_arria10_mercury_aa1_st1_qspi.dts
 create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_arria10_mercury_aa1_st1_sdmmc.dts
 create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa1_pe1_emmc.dts
 create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa1_pe1_qspi.dts
 create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa1_pe1_sdmmc.dts
 create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa1_pe3_emmc.dts
 create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa1_pe3_qspi.dts
 create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa1_pe3_sdmmc.dts
 create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa1_st1_emmc.dts
 create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa1_st1_qspi.dts
 create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa1_st1_sdmmc.dts
 create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa2_pe1_qspi.dts
 create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa2_pe1_sdmmc.dts
 create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa2_pe3_qspi.dts
 create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa2_pe3_sdmmc.dts
 create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa2_st1_qspi.dts
 create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa2_st1_sdmmc.dts

diff --git a/arch/arm/boot/dts/intel/socfpga/Makefile b/arch/arm/boot/dts/intel/socfpga/Makefile
index d95862e34..861880560 100644
--- a/arch/arm/boot/dts/intel/socfpga/Makefile
+++ b/arch/arm/boot/dts/intel/socfpga/Makefile
@@ -2,6 +2,30 @@
 dtb-$(CONFIG_ARCH_INTEL_SOCFPGA) += \
 	socfpga_arria5_socdk.dtb \
 	socfpga_arria10_chameleonv3.dtb \
+	socfpga_arria10_mercury_aa1_pe1_emmc.dtb \
+	socfpga_arria10_mercury_aa1_pe1_qspi.dtb \
+	socfpga_arria10_mercury_aa1_pe1_sdmmc.dtb \
+	socfpga_arria10_mercury_aa1_pe3_emmc.dtb \
+	socfpga_arria10_mercury_aa1_pe3_qspi.dtb \
+	socfpga_arria10_mercury_aa1_pe3_sdmmc.dtb \
+	socfpga_arria10_mercury_aa1_st1_emmc.dtb \
+	socfpga_arria10_mercury_aa1_st1_qspi.dtb \
+	socfpga_arria10_mercury_aa1_st1_sdmmc.dtb \
+	socfpga_cyclone5_mercury_sa1_pe1_emmc.dtb \
+	socfpga_cyclone5_mercury_sa1_pe1_qspi.dtb \
+	socfpga_cyclone5_mercury_sa1_pe1_sdmmc.dtb \
+	socfpga_cyclone5_mercury_sa1_pe3_emmc.dtb \
+	socfpga_cyclone5_mercury_sa1_pe3_qspi.dtb \
+	socfpga_cyclone5_mercury_sa1_pe3_sdmmc.dtb \
+	socfpga_cyclone5_mercury_sa1_st1_emmc.dtb \
+	socfpga_cyclone5_mercury_sa1_st1_qspi.dtb \
+	socfpga_cyclone5_mercury_sa1_st1_sdmmc.dtb \
+	socfpga_cyclone5_mercury_sa2_pe1_qspi.dtb \
+	socfpga_cyclone5_mercury_sa2_pe1_sdmmc.dtb \
+	socfpga_cyclone5_mercury_sa2_pe3_qspi.dtb \
+	socfpga_cyclone5_mercury_sa2_pe3_sdmmc.dtb \
+	socfpga_cyclone5_mercury_sa2_st1_qspi.dtb \
+	socfpga_cyclone5_mercury_sa2_st1_sdmmc.dtb \
 	socfpga_arria10_socdk_nand.dtb \
 	socfpga_arria10_socdk_qspi.dtb \
 	socfpga_arria10_socdk_sdmmc.dtb \
diff --git a/arch/arm/boot/dts/intel/socfpga/socfpga_arria10_mercury_aa1_pe1_emmc.dts b/arch/arm/boot/dts/intel/socfpga/socfpga_arria10_mercury_aa1_pe1_emmc.dts
new file mode 100644
index 000000000..b6cca0b5f
--- /dev/null
+++ b/arch/arm/boot/dts/intel/socfpga/socfpga_arria10_mercury_aa1_pe1_emmc.dts
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Copyright (C) 2024 Enclustra GmbH - https://www.enclustra.com
+ */
+
+/dts-v1/;
+
+#include "socfpga_arria10_mercury_aa1.dtsi"
+#include "socfpga_enclustra_mercury_pe1.dtsi"
+#include "socfpga_enclustra_mercury_bootmode_emmc.dtsi"
+
+/ {
+	model = "Enclustra Mercury SA1 on Mercury+ PE1 Base Board";
+	compatible = "enclustra,mercury-sa1-pe1", "enclustra,mercury-sa1",
+		     "altr,socfpga-cyclone5", "altr,socfpga";
+};
diff --git a/arch/arm/boot/dts/intel/socfpga/socfpga_arria10_mercury_aa1_pe1_qspi.dts b/arch/arm/boot/dts/intel/socfpga/socfpga_arria10_mercury_aa1_pe1_qspi.dts
new file mode 100644
index 000000000..6ad023477
--- /dev/null
+++ b/arch/arm/boot/dts/intel/socfpga/socfpga_arria10_mercury_aa1_pe1_qspi.dts
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Copyright (C) 2024 Enclustra GmbH - https://www.enclustra.com
+ */
+
+/dts-v1/;
+
+#include "socfpga_arria10_mercury_aa1.dtsi"
+#include "socfpga_enclustra_mercury_pe1.dtsi"
+#include "socfpga_enclustra_mercury_bootmode_qspi.dtsi"
+
+/ {
+	model = "Enclustra Mercury+ AA1 on Mercury+ PE1 Base Board";
+	compatible = "enclustra,mercury-aa1-pe1", "enclustra,mercury-aa1",
+		     "altr,socfpga-arria10", "altr,socfpga";
+};
diff --git a/arch/arm/boot/dts/intel/socfpga/socfpga_arria10_mercury_aa1_pe1_sdmmc.dts b/arch/arm/boot/dts/intel/socfpga/socfpga_arria10_mercury_aa1_pe1_sdmmc.dts
new file mode 100644
index 000000000..653c9a865
--- /dev/null
+++ b/arch/arm/boot/dts/intel/socfpga/socfpga_arria10_mercury_aa1_pe1_sdmmc.dts
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Copyright (C) 2024 Enclustra GmbH - https://www.enclustra.com
+ */
+
+/dts-v1/;
+
+#include "socfpga_arria10_mercury_aa1.dtsi"
+#include "socfpga_enclustra_mercury_pe1.dtsi"
+#include "socfpga_enclustra_mercury_bootmode_sdmmc.dtsi"
+
+/ {
+	model = "Enclustra Mercury+ AA1 on Mercury+ PE1 Base Board";
+	compatible = "enclustra,mercury-aa1-pe1", "enclustra,mercury-aa1",
+		     "altr,socfpga-arria10", "altr,socfpga";
+};
diff --git a/arch/arm/boot/dts/intel/socfpga/socfpga_arria10_mercury_aa1_pe3_emmc.dts b/arch/arm/boot/dts/intel/socfpga/socfpga_arria10_mercury_aa1_pe3_emmc.dts
new file mode 100644
index 000000000..ae9c7c6a2
--- /dev/null
+++ b/arch/arm/boot/dts/intel/socfpga/socfpga_arria10_mercury_aa1_pe3_emmc.dts
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Copyright (C) 2024 Enclustra GmbH - https://www.enclustra.com
+ */
+
+/dts-v1/;
+
+#include "socfpga_arria10_mercury_aa1.dtsi"
+#include "socfpga_enclustra_mercury_pe3.dtsi"
+#include "socfpga_enclustra_mercury_bootmode_emmc.dtsi"
+
+/ {
+	model = "Enclustra Mercury+ AA1 on Mercury+ PE3 Base Board";
+	compatible = "enclustra,mercury-aa1-pe3", "enclustra,mercury-aa1",
+		     "altr,socfpga-arria10", "altr,socfpga";
+};
diff --git a/arch/arm/boot/dts/intel/socfpga/socfpga_arria10_mercury_aa1_pe3_qspi.dts b/arch/arm/boot/dts/intel/socfpga/socfpga_arria10_mercury_aa1_pe3_qspi.dts
new file mode 100644
index 000000000..c3a0c30a0
--- /dev/null
+++ b/arch/arm/boot/dts/intel/socfpga/socfpga_arria10_mercury_aa1_pe3_qspi.dts
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Copyright (C) 2024 Enclustra GmbH - https://www.enclustra.com
+ */
+
+/dts-v1/;
+
+#include "socfpga_arria10_mercury_aa1.dtsi"
+#include "socfpga_enclustra_mercury_pe3.dtsi"
+#include "socfpga_enclustra_mercury_bootmode_qspi.dtsi"
+
+/ {
+	model = "Enclustra Mercury+ AA1 on Mercury+ PE3 Base Board";
+	compatible = "enclustra,mercury-aa1-pe3", "enclustra,mercury-aa1",
+		     "altr,socfpga-arria10", "altr,socfpga";
+};
diff --git a/arch/arm/boot/dts/intel/socfpga/socfpga_arria10_mercury_aa1_pe3_sdmmc.dts b/arch/arm/boot/dts/intel/socfpga/socfpga_arria10_mercury_aa1_pe3_sdmmc.dts
new file mode 100644
index 000000000..dc1e1ad20
--- /dev/null
+++ b/arch/arm/boot/dts/intel/socfpga/socfpga_arria10_mercury_aa1_pe3_sdmmc.dts
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Copyright (C) 2024 Enclustra GmbH - https://www.enclustra.com
+ */
+
+/dts-v1/;
+
+#include "socfpga_arria10_mercury_aa1.dtsi"
+#include "socfpga_enclustra_mercury_pe3.dtsi"
+#include "socfpga_enclustra_mercury_bootmode_sdmmc.dtsi"
+
+/ {
+	model = "Enclustra Mercury+ AA1 on Mercury+ PE3 Base Board";
+	compatible = "enclustra,mercury-aa1-pe3", "enclustra,mercury-aa1",
+		     "altr,socfpga-arria10", "altr,socfpga";
+};
diff --git a/arch/arm/boot/dts/intel/socfpga/socfpga_arria10_mercury_aa1_st1_emmc.dts b/arch/arm/boot/dts/intel/socfpga/socfpga_arria10_mercury_aa1_st1_emmc.dts
new file mode 100644
index 000000000..61d5e4c85
--- /dev/null
+++ b/arch/arm/boot/dts/intel/socfpga/socfpga_arria10_mercury_aa1_st1_emmc.dts
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Copyright (C) 2024 Enclustra GmbH - https://www.enclustra.com
+ */
+
+/dts-v1/;
+
+#include "socfpga_arria10_mercury_aa1.dtsi"
+#include "socfpga_enclustra_mercury_st1.dtsi"
+#include "socfpga_enclustra_mercury_bootmode_emmc.dtsi"
+
+/ {
+	model = "Enclustra Mercury+ AA1 on Mercury+ ST1 Base Board";
+	compatible = "enclustra,mercury-aa1-st1", "enclustra,mercury-aa1",
+		     "altr,socfpga-arria10", "altr,socfpga";
+};
diff --git a/arch/arm/boot/dts/intel/socfpga/socfpga_arria10_mercury_aa1_st1_qspi.dts b/arch/arm/boot/dts/intel/socfpga/socfpga_arria10_mercury_aa1_st1_qspi.dts
new file mode 100644
index 000000000..a3b99c9b1
--- /dev/null
+++ b/arch/arm/boot/dts/intel/socfpga/socfpga_arria10_mercury_aa1_st1_qspi.dts
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Copyright (C) 2024 Enclustra GmbH - https://www.enclustra.com
+ */
+
+/dts-v1/;
+
+#include "socfpga_arria10_mercury_aa1.dtsi"
+#include "socfpga_enclustra_mercury_st1.dtsi"
+#include "socfpga_enclustra_mercury_bootmode_qspi.dtsi"
+
+/ {
+	model = "Enclustra Mercury+ AA1 on Mercury+ ST1 Base Board";
+	compatible = "enclustra,mercury-aa1-st1", "enclustra,mercury-aa1",
+		     "altr,socfpga-arria10", "altr,socfpga";
+};
diff --git a/arch/arm/boot/dts/intel/socfpga/socfpga_arria10_mercury_aa1_st1_sdmmc.dts b/arch/arm/boot/dts/intel/socfpga/socfpga_arria10_mercury_aa1_st1_sdmmc.dts
new file mode 100644
index 000000000..5deb289e2
--- /dev/null
+++ b/arch/arm/boot/dts/intel/socfpga/socfpga_arria10_mercury_aa1_st1_sdmmc.dts
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Copyright (C) 2024 Enclustra GmbH - https://www.enclustra.com
+ */
+
+/dts-v1/;
+
+#include "socfpga_arria10_mercury_aa1.dtsi"
+#include "socfpga_enclustra_mercury_st1.dtsi"
+#include "socfpga_enclustra_mercury_bootmode_sdmmc.dtsi"
+
+/ {
+	model = "Enclustra Mercury+ AA1 on Mercury+ ST1 Base Board";
+	compatible = "enclustra,mercury-aa1-st1", "enclustra,mercury-aa1",
+		     "altr,socfpga-arria10", "altr,socfpga";
+};
diff --git a/arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa1_pe1_emmc.dts b/arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa1_pe1_emmc.dts
new file mode 100644
index 000000000..85d6146da
--- /dev/null
+++ b/arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa1_pe1_emmc.dts
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Copyright (C) 2024 Enclustra GmbH - https://www.enclustra.com
+ */
+
+/dts-v1/;
+
+#include "socfpga_cyclone5_mercury_sa1.dtsi"
+#include "socfpga_enclustra_mercury_pe1.dtsi"
+#include "socfpga_enclustra_mercury_bootmode_emmc.dtsi"
+
+/ {
+	model = "Enclustra Mercury SA1 on Mercury+ PE1 Base Board";
+	compatible = "enclustra,mercury-sa1-pe1", "enclustra,mercury-aa1",
+		     "altr,socfpga-arria10", "altr,socfpga";
+};
diff --git a/arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa1_pe1_qspi.dts b/arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa1_pe1_qspi.dts
new file mode 100644
index 000000000..770ab680a
--- /dev/null
+++ b/arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa1_pe1_qspi.dts
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Copyright (C) 2024 Enclustra GmbH - https://www.enclustra.com
+ */
+
+/dts-v1/;
+
+#include "socfpga_cyclone5_mercury_sa1.dtsi"
+#include "socfpga_enclustra_mercury_pe1.dtsi"
+#include "socfpga_enclustra_mercury_bootmode_qspi.dtsi"
+
+/ {
+	model = "Enclustra Mercury SA1 on Mercury+ PE1 Base Board";
+	compatible = "enclustra,mercury-sa1-pe1", "enclustra,mercury-sa1",
+		     "altr,socfpga-cyclone5", "altr,socfpga";
+};
diff --git a/arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa1_pe1_sdmmc.dts b/arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa1_pe1_sdmmc.dts
new file mode 100644
index 000000000..990ca0fec
--- /dev/null
+++ b/arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa1_pe1_sdmmc.dts
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Copyright (C) 2024 Enclustra GmbH - https://www.enclustra.com
+ */
+
+/dts-v1/;
+
+#include "socfpga_cyclone5_mercury_sa1.dtsi"
+#include "socfpga_enclustra_mercury_pe1.dtsi"
+#include "socfpga_enclustra_mercury_bootmode_sdmmc.dtsi"
+
+/ {
+	model = "Enclustra Mercury SA1 on Mercury+ PE1 Base Board";
+	compatible = "enclustra,mercury-sa1-pe1", "enclustra,mercury-sa1",
+		     "altr,socfpga-cyclone5", "altr,socfpga";
+};
diff --git a/arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa1_pe3_emmc.dts b/arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa1_pe3_emmc.dts
new file mode 100644
index 000000000..6c8fd5b0d
--- /dev/null
+++ b/arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa1_pe3_emmc.dts
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Copyright (C) 2024 Enclustra GmbH - https://www.enclustra.com
+ */
+
+/dts-v1/;
+
+#include "socfpga_cyclone5_mercury_sa1.dtsi"
+#include "socfpga_enclustra_mercury_pe3.dtsi"
+#include "socfpga_enclustra_mercury_bootmode_emmc.dtsi"
+
+/ {
+	model = "Enclustra Mercury SA1 on Mercury+ PE3 Base Board";
+	compatible = "enclustra,mercury-sa1-pe3", "enclustra,mercury-sa1",
+		     "altr,socfpga-cyclone5", "altr,socfpga";
+};
diff --git a/arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa1_pe3_qspi.dts b/arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa1_pe3_qspi.dts
new file mode 100644
index 000000000..329242607
--- /dev/null
+++ b/arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa1_pe3_qspi.dts
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Copyright (C) 2024 Enclustra GmbH - https://www.enclustra.com
+ */
+
+/dts-v1/;
+
+#include "socfpga_cyclone5_mercury_sa1.dtsi"
+#include "socfpga_enclustra_mercury_pe3.dtsi"
+#include "socfpga_enclustra_mercury_bootmode_qspi.dtsi"
+
+/ {
+	model = "Enclustra Mercury SA1 on Mercury+ PE3 Base Board";
+	compatible = "enclustra,mercury-sa1-pe3", "enclustra,mercury-sa1",
+		     "altr,socfpga-cyclone5", "altr,socfpga";
+};
diff --git a/arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa1_pe3_sdmmc.dts b/arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa1_pe3_sdmmc.dts
new file mode 100644
index 000000000..1eb10b524
--- /dev/null
+++ b/arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa1_pe3_sdmmc.dts
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Copyright (C) 2024 Enclustra GmbH - https://www.enclustra.com
+ */
+
+/dts-v1/;
+
+#include "socfpga_cyclone5_mercury_sa1.dtsi"
+#include "socfpga_enclustra_mercury_pe3.dtsi"
+#include "socfpga_enclustra_mercury_bootmode_sdmmc.dtsi"
+
+/ {
+	model = "Enclustra Mercury SA1 on Mercury+ PE3 Base Board";
+	compatible = "enclustra,mercury-sa1-pe3", "enclustra,mercury-sa1",
+		     "altr,socfpga-cyclone5", "altr,socfpga";
+};
diff --git a/arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa1_st1_emmc.dts b/arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa1_st1_emmc.dts
new file mode 100644
index 000000000..8c97b5b3a
--- /dev/null
+++ b/arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa1_st1_emmc.dts
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Copyright (C) 2024 Enclustra GmbH - https://www.enclustra.com
+ */
+
+/dts-v1/;
+
+#include "socfpga_cyclone5_mercury_sa1.dtsi"
+#include "socfpga_enclustra_mercury_st1.dtsi"
+#include "socfpga_enclustra_mercury_bootmode_emmc.dtsi"
+
+/ {
+	model = "Enclustra Mercury SA1 on Mercury+ ST1 Base Board";
+	compatible = "enclustra,mercury-sa1-st1", "enclustra,mercury-sa1",
+		     "altr,socfpga-cyclone5", "altr,socfpga";
+};
diff --git a/arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa1_st1_qspi.dts b/arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa1_st1_qspi.dts
new file mode 100644
index 000000000..e6d14b22e
--- /dev/null
+++ b/arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa1_st1_qspi.dts
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Copyright (C) 2024 Enclustra GmbH - https://www.enclustra.com
+ */
+
+/dts-v1/;
+
+#include "socfpga_cyclone5_mercury_sa1.dtsi"
+#include "socfpga_enclustra_mercury_st1.dtsi"
+#include "socfpga_enclustra_mercury_bootmode_qspi.dtsi"
+
+/ {
+	model = "Enclustra Mercury SA1 on Mercury+ ST1 Base Board";
+	compatible = "enclustra,mercury-sa1-st1", "enclustra,mercury-sa1",
+		     "altr,socfpga-cyclone5", "altr,socfpga";
+};
diff --git a/arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa1_st1_sdmmc.dts b/arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa1_st1_sdmmc.dts
new file mode 100644
index 000000000..beaeca94d
--- /dev/null
+++ b/arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa1_st1_sdmmc.dts
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Copyright (C) 2024 Enclustra GmbH - https://www.enclustra.com
+ */
+
+/dts-v1/;
+
+#include "socfpga_cyclone5_mercury_sa1.dtsi"
+#include "socfpga_enclustra_mercury_st1.dtsi"
+#include "socfpga_enclustra_mercury_bootmode_sdmmc.dtsi"
+
+/ {
+	model = "Enclustra Mercury SA1 on Mercury+ ST1 Base Board";
+	compatible = "enclustra,mercury-sa1-st1", "enclustra,mercury-sa1",
+		     "altr,socfpga-cyclone5", "altr,socfpga";
+};
diff --git a/arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa2_pe1_qspi.dts b/arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa2_pe1_qspi.dts
new file mode 100644
index 000000000..6f79d9ed1
--- /dev/null
+++ b/arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa2_pe1_qspi.dts
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Copyright (C) 2024 Enclustra GmbH - https://www.enclustra.com
+ */
+
+/dts-v1/;
+
+#include "socfpga_cyclone5_mercury_sa2.dtsi"
+#include "socfpga_enclustra_mercury_pe1.dtsi"
+#include "socfpga_enclustra_mercury_bootmode_qspi.dtsi"
+
+/ {
+	model = "Enclustra Mercury+ SA2 on Mercury+ PE1 Base Board";
+	compatible = "enclustra,mercury-sa2-pe1", "enclustra,mercury-sa2",
+		     "altr,socfpga-cyclone5", "altr,socfpga";
+};
diff --git a/arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa2_pe1_sdmmc.dts b/arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa2_pe1_sdmmc.dts
new file mode 100644
index 000000000..b94bd8baf
--- /dev/null
+++ b/arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa2_pe1_sdmmc.dts
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Copyright (C) 2024 Enclustra GmbH - https://www.enclustra.com
+ */
+
+/dts-v1/;
+
+#include "socfpga_cyclone5_mercury_sa2.dtsi"
+#include "socfpga_enclustra_mercury_pe1.dtsi"
+#include "socfpga_enclustra_mercury_bootmode_sdmmc.dtsi"
+
+/ {
+	model = "Enclustra Mercury+ SA2 on Mercury+ PE1 Base Board";
+	compatible = "enclustra,mercury-sa2-pe1", "enclustra,mercury-sa2",
+		     "altr,socfpga-cyclone5", "altr,socfpga";
+};
diff --git a/arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa2_pe3_qspi.dts b/arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa2_pe3_qspi.dts
new file mode 100644
index 000000000..51fc4a229
--- /dev/null
+++ b/arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa2_pe3_qspi.dts
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Copyright (C) 2024 Enclustra GmbH - https://www.enclustra.com
+ */
+
+/dts-v1/;
+
+#include "socfpga_cyclone5_mercury_sa2.dtsi"
+#include "socfpga_enclustra_mercury_pe3.dtsi"
+#include "socfpga_enclustra_mercury_bootmode_qspi.dtsi"
+
+/ {
+	model = "Enclustra Mercury+ SA2 on Mercury+ PE3 Base Board";
+	compatible = "enclustra,mercury-sa2-pe3", "enclustra,mercury-sa2",
+		     "altr,socfpga-cyclone5", "altr,socfpga";
+};
diff --git a/arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa2_pe3_sdmmc.dts b/arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa2_pe3_sdmmc.dts
new file mode 100644
index 000000000..e4209209f
--- /dev/null
+++ b/arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa2_pe3_sdmmc.dts
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Copyright (C) 2024 Enclustra GmbH - https://www.enclustra.com
+ */
+
+/dts-v1/;
+
+#include "socfpga_cyclone5_mercury_sa2.dtsi"
+#include "socfpga_enclustra_mercury_pe3.dtsi"
+#include "socfpga_enclustra_mercury_bootmode_sdmmc.dtsi"
+
+/ {
+	model = "Enclustra Mercury+ SA2 on Mercury+ PE3 Base Board";
+	compatible = "enclustra,mercury-sa2-pe3", "enclustra,mercury-sa2",
+		     "altr,socfpga-cyclone5", "altr,socfpga";
+};
diff --git a/arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa2_st1_qspi.dts b/arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa2_st1_qspi.dts
new file mode 100644
index 000000000..ab4549a0d
--- /dev/null
+++ b/arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa2_st1_qspi.dts
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Copyright (C) 2024 Enclustra GmbH - https://www.enclustra.com
+ */
+
+/dts-v1/;
+
+#include "socfpga_cyclone5_mercury_sa2.dtsi"
+#include "socfpga_enclustra_mercury_st1.dtsi"
+#include "socfpga_enclustra_mercury_bootmode_qspi.dtsi"
+
+/ {
+	model = "Enclustra Mercury+ SA2 on Mercury+ ST1 Base Board";
+	compatible = "enclustra,mercury-sa2-st1", "enclustra,mercury-sa2",
+		     "altr,socfpga-cyclone5", "altr,socfpga";
+};
diff --git a/arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa2_st1_sdmmc.dts b/arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa2_st1_sdmmc.dts
new file mode 100644
index 000000000..ebe62879c
--- /dev/null
+++ b/arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa2_st1_sdmmc.dts
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Copyright (C) 2024 Enclustra GmbH - https://www.enclustra.com
+ */
+
+/dts-v1/;
+
+#include "socfpga_cyclone5_mercury_sa2.dtsi"
+#include "socfpga_enclustra_mercury_st1.dtsi"
+#include "socfpga_enclustra_mercury_bootmode_sdmmc.dtsi"
+
+/ {
+	model = "Enclustra Mercury+ SA2 on Mercury+ ST1 Base Board";
+	compatible = "enclustra,mercury-sa2-st1", "enclustra,mercury-sa2",
+		     "altr,socfpga-cyclone5", "altr,socfpga";
+};
-- 
2.25.1


