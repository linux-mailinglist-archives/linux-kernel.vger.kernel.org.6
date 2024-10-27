Return-Path: <linux-kernel+bounces-383672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44E079B1EED
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 15:41:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04891280F55
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 14:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BEF81F5EA;
	Sun, 27 Oct 2024 14:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gahMWV1E"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E8D18F2C3;
	Sun, 27 Oct 2024 14:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730039852; cv=none; b=dd86212v0OlQ/3W6VKKnPNMRRBQDxwvXNBRxO7VxF6gev4NO4cqKrJ6L/sXLy9Llx2Od+gaGPfSAzaLzbQnP90LV4VJ16Y/XX+YdKefZ0pqdew8ySn8fL8mR0TbtdzDGx6JnKzK3Dty7p9MbDphB68SBZKehYV1jvtlPhGSR1uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730039852; c=relaxed/simple;
	bh=BKcROuWUYTw9JhFiD7stJcvz4b+0cKybV+ykIP65zt4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=q+MRlo5+xf9LlXPZbPjF+YyaB1+BVKy5q2ORQFvwMyvjX0BVqL345E3MZXadrbyzappThTP/Aob/O7PvrLR9B54YSBbYJ+OnO0FPf4J0/EQS3n4cSvdXgy3C8fCaAtBi8xjisiM1doN4Fahx4AqHVHRW3BsN0U5/oX9Rdg25gNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gahMWV1E; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5c937982445so527064a12.2;
        Sun, 27 Oct 2024 07:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730039847; x=1730644647; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=58/Yp9z5BeuiNsOYUdEfHyKptWKflHI/Ww9dE/OYykM=;
        b=gahMWV1EFrctG11dfb+2/bndOWvukvyJJ6mqzLRTHofQsZljmOdjvDZqxWYPDx/vTz
         JIdh8fkCuglt3TRDBP9sjIWgAZvzeoEOBXdy+xsdVly4UGblVND3Tyv7LEeGAt70womX
         jJuxJRrGpGHT5dbnm96F4NDYFaAXplxOa0+4RRJQxEESxgL9adUiu4eHdz3MhbLT/4RH
         6BbI211p63lYg2U9QXwk6sZPLxtqXzFMhfIQ82/rudMaw9DkIIBJ6GG+XnKefWG4f2dV
         QyNytpUTIRbBENdtFxdG/UQb5vOKCTuSfAZbYB3CSMJGOoaJ/NBgbPbTfFsz/cCpLPpW
         ckNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730039847; x=1730644647;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=58/Yp9z5BeuiNsOYUdEfHyKptWKflHI/Ww9dE/OYykM=;
        b=Um7DVHRv1wCRJvck90QXfsj0i8xoo6Yp50OOmurP1bp4yaVr5WXjiuDjXDCk95cBor
         tcUI2eWIbAEF+SF+yW6hY4iW+4KONachUbZYeEUdDf8i71LfukVJcbkepXpB/NL0YkYk
         DP6FuUdc7NGVkUwIXkagkUvi2PljQk8DtobusHmnqMdHvydgakExKcwll8TSw+9N7MIp
         lnAFIr5l6ejb67oFgL6DOKWe9zapcD0PgraFHaiMjUQ4rdweRq2SdzNS7kDEf5lx6m1a
         HVCA+5t7c5wFFQsDUXbqEKRH4wHpig/1U4L+qsUyKFhuSMtqBtlviSl1NHSc+ipdi5dc
         E92A==
X-Forwarded-Encrypted: i=1; AJvYcCUv5oVOvKV6+fUsQ+HR6AuRZQ+/+QIBByZgPJV7Y96KGR6DGvnegnw5I0wIM/r6ClnnitfINijQOmH4@vger.kernel.org, AJvYcCWPkqbzcw7rmM75oFAvar3dWudWuiFgz9a32imYyAeWIcjzC2H8rTVASI44F9sk4OViOtu24i3OKQv5UtLF@vger.kernel.org
X-Gm-Message-State: AOJu0YwzDNGlCACJOJw3++3mws3iW30WU3qwqWIeeD1eHTMoygJwF5r6
	O7iDhPco0PB5Y+kjLEpm9UWMessSrnVRPDMSoCBqWO9a/BoXf3Nr
X-Google-Smtp-Source: AGHT+IE+pjGwZzKFkmHylEKCUTmyYa+kJ9yEhD3yJWlDNWJeGM5ifCDRuBS/Pu+XIelNocd5xzrkpg==
X-Received: by 2002:a17:906:794a:b0:a9a:2523:b4fa with SMTP id a640c23a62f3a-a9de5ceafaemr234347866b.4.1730039846425;
        Sun, 27 Oct 2024 07:37:26 -0700 (PDT)
Received: from 6c1d2e1f4cf4.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b331b0d44sm281127966b.187.2024.10.27.07.37.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Oct 2024 07:37:25 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	a.fatoum@pengutronix.de
Cc: conor+dt@kernel.org,
	dinguyen@kernel.org,
	marex@denx.de,
	s.trumtrar@pengutronix.de,
	l.rubusch@gmail.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCHv3 22/22] ARM: dts: socfpga: add Enclustra SoM dts files
Date: Sun, 27 Oct 2024 14:36:54 +0000
Message-Id: <20241027143654.28474-23-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241027143654.28474-1-l.rubusch@gmail.com>
References: <20241027143654.28474-1-l.rubusch@gmail.com>
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


