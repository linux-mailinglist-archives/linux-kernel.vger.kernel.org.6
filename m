Return-Path: <linux-kernel+bounces-373403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7EA49A5650
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 21:43:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 403EDB25FBA
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 19:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C945D199FB4;
	Sun, 20 Oct 2024 19:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QOui6/4e"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CDE019ABD1;
	Sun, 20 Oct 2024 19:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729453253; cv=none; b=AU/pZso21lcNNDOpLMrOgiO5Idl+k6lSNfuUIoTatl4ph5bGy+xRvrQLLPSH/yCWxfgzNFoGX18x7cCgzPpj0LJybCpPv6nR2hTjoYtjc0QgXjsFApTcxpDPlQ7CWQxgBSoooEhtK7q2OkZSh8ENtDKIuOvPDkt0hnJC2SU9xtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729453253; c=relaxed/simple;
	bh=reEDnU1SNiVxjPpQyMaUfQ5wi7SUa5pz+ceWrg4H+/w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=swV7Xdx6UsH6rIAu1JpJY3/SWd43WSjVZFRrEspyEUlQTSbc+6gIdUzBMLuOE4wpSYbPJ8mHDnhAoGXZxGsTr0FiGyO8APtq+YKhTZhrtgbUcsJpOb8RYRCPHI3LT4TmfeMoMqv96XweJ4IT9h6W4trkbyOjx+szxPMFo4VLLVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QOui6/4e; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5c9ff17eddbso529895a12.3;
        Sun, 20 Oct 2024 12:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729453249; x=1730058049; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8cU5axjCkoX/I8K80a4eMossed80sAlcXC5m6s2aWxA=;
        b=QOui6/4eh0itTizCPr9Cv48G/4tpaYrN3N2EzXRVyWoaDIgBVOJHVFGpAj/l3sZVCS
         NIRtToU4ZAIZHdvtSbhL+OOzHBr71B4kR5FW0DEvNLJzjjm74ZTbxcNfPm1fi1RqTdRJ
         Aa+k3jDJMk19kwvFckSKO2Z15uJnkWt1IOYcZfD+FtwHK+DWkem4YP/rH5AtCMYTlJl2
         ztfiKpcNDOkMMd5HAB448kOTZhqYxczWgO/zTDS1qfLWOx8P3rS5CAZehMgg/GYlHS1K
         xXD/z7i5cNU/oIuHim6Epr5tlSlVZI5dxx9qWtFdh36KM3On3ibsXraPOmY2BHHZJJAt
         9x8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729453249; x=1730058049;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8cU5axjCkoX/I8K80a4eMossed80sAlcXC5m6s2aWxA=;
        b=nHH3elOxBRQXPBF0dNRW9nn45eIdnd1sRl/YHI+P5NNZZ1/7S0NepcYzteXjTaIYMc
         gYn5OmTe86RNaxI3s9t2jKF9lzWNguu46Z+6FbezhzbURen0fAqvp5a8pPGG2oDA08GN
         JaREwYeQlVssNthC60FD1okfPTR4mMXmyoty5o8RrbCuJqQW2kVr3rbaB7GwpAb2w527
         CBk36OXY7vukZYC+MRe9uIjynZDirTrYSxOe2RuzulTqq2HLXLmpSvKD9sa0r5SJT0Be
         jAkNIkitoTYJz2PPZ3VfGC6PnHuLxjhMTYMdliHYwcYFDKtfcvwSF4D/lTEPOCjI9WHj
         iW+A==
X-Forwarded-Encrypted: i=1; AJvYcCUJb5WVsqi2uB/j0oZ00PjgEwf0nnc80D/n8MAFb/05co01DbMYJZB0Nd/z0eRbYmZykVUDs2zaNbnVPwqK@vger.kernel.org, AJvYcCXL9txcvssBezXf8vlccHo0Y7h35pVbN0v+ouKG7ROStygaKSyD3NbByDBDpZ7idcQiHj/WBySUccGu@vger.kernel.org
X-Gm-Message-State: AOJu0YzKEp+btaXyoGLWddvH7J1LLr8zPg23Au41xlrUtzF8+aXkD7QS
	n9Or3sLlfDoydUkJjatlQQLfrEg6e1FntGRDbEV3ImOYFn7It2kb
X-Google-Smtp-Source: AGHT+IE8oPH5vBFVIq28TgQqc0cmRbNxYCFID2yIxxTurfard9w1tWZazLlEM+Rm3govULA3Zh2hAA==
X-Received: by 2002:a17:907:6d0b:b0:a9a:4d32:2c7b with SMTP id a640c23a62f3a-a9a69c98b09mr402839266b.9.1729453249261;
        Sun, 20 Oct 2024 12:40:49 -0700 (PDT)
Received: from e8ff02ae9b18.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a91578129sm120576966b.186.2024.10.20.12.40.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Oct 2024 12:40:48 -0700 (PDT)
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
Subject: [PATCHv2 13/23] ARM: dts: socfpga: add Enclustra boot-mode dtsi
Date: Sun, 20 Oct 2024 19:40:18 +0000
Message-Id: <20241020194028.2272371-14-l.rubusch@gmail.com>
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

Add generic boot-mode support to Enclustra Arria10 and Cyclone5 boards.
Some Enclustra carrier boards need hardware adjustments specific to the
selected boot-mode.

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
2.25.1


