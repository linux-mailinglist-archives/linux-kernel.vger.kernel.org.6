Return-Path: <linux-kernel+bounces-353402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96F48992D4B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 15:31:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C84021C22798
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 13:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8F141D460E;
	Mon,  7 Oct 2024 13:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R+hyn+Ew"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D4311D356C;
	Mon,  7 Oct 2024 13:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728307884; cv=none; b=qbFdnHmouGz6ctOkNkfboQsma2JEPhEZMAf9vfmp8I/0dwyjDJYuVU005y/0a78mb+LCapq9mV8rtr0r08MZvdff+bwFh4buyf6PJpaRt76hTY18vIDGLIj/TUwshYQzXR3LHVQH1P29Vq5PmFaNyhPgF9mdWzmmTUeKkpUclsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728307884; c=relaxed/simple;
	bh=reEDnU1SNiVxjPpQyMaUfQ5wi7SUa5pz+ceWrg4H+/w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iZOLkN/9lppFbJft1eVVJVNEq1TtCvPXpjTExQjtCj4fkKDKIOL3QAa8m/sLBHiiG1jSpGdEptt5kyQ/oNMdUfW2bXS+I7RRsdXvUF+mnPBHKiTc9H5HJ2J4aAmynnFKJMLf7lOpnCX/JHzvlXSW5u/8yELoDDCONc+tryMlaGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R+hyn+Ew; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-42cae563348so7176715e9.0;
        Mon, 07 Oct 2024 06:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728307881; x=1728912681; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8cU5axjCkoX/I8K80a4eMossed80sAlcXC5m6s2aWxA=;
        b=R+hyn+Ewdq/DeVNMb05deTk+qQsUcKxqAXgF51OkQKAwclyaF+9owQu6rOu7TqWjiO
         T58g2oZhRinAvDLArPTiywXet7b95GOMGGy+IT+9Bp1eSMTBidgqbH4GlRzIdZnLghPa
         dWkl22YX2Th1VDanEvGgpwLWBYktkUZdAXPjQ+u2Zp+I6v9IbeDSbNwlN5K5mt9sVDyB
         F5IQ+IjXiX7iN9Qyljiji2awf4A6WSQKeWk4Abgjjm+ghboCpaLK+dLimjUQ9o6lDi2W
         ARk9BXSMeX9LlWO2EmB8kzPLyECJd3BEP6IBN9VB+qYmjEXyLuX+RhLo/BJC4Tl219Ek
         W6Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728307881; x=1728912681;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8cU5axjCkoX/I8K80a4eMossed80sAlcXC5m6s2aWxA=;
        b=VxSkzbc6cPgK1Ow9YFd9xS+l5Wu6i+kSl0Hkz8Q+sJJ4+50aSd4gVQF9nTqwrhOAcu
         kUfVHJtY/ttDoq2ILaLLRxgmnc5013SBg61dQBYrUOP+fYINZIxcL4gR3prrYo1Y53/0
         qqfg+r9llY8vbdtZSdouDI+s3SL+hyDfslpx372B1GFsWnZ0cnbmo/QxvaYR8j08Zxw0
         vDWnzvfKqoAb51zIux7RvOzOTuXeaXPKZ1iQxqgt34z9qtJQDIm8CKZN9wXuhtsXeXxx
         +TPdplJXNrI3KErzTfTN0u6bmjmGv7xW2qdBx3/6cZbf7NH+rPz4m8z0iVTTUmr6z/xI
         wMzQ==
X-Forwarded-Encrypted: i=1; AJvYcCUTU5j5H+9JHyLPmIRsix+OXJbWrsmVn6IlUOxyZQLqe8GCxTF4vWmkgxN5xAKGR3qzC0SQpx08RKgp9RvQ@vger.kernel.org, AJvYcCXzU3Yojyta1tzWh+1L6UjkYw0Z4BfssTQnpB1WjCLp3l/5wnuE/aLmURxQLFg7DrVEKzXYrAjevkKe@vger.kernel.org
X-Gm-Message-State: AOJu0Yyr/ILLLh3SINpVoX6RARUS6T0TstIGQbaLlCV3/ctU0GwKTtac
	QaR/RcUtDHGojI4x1i500t9/5n4xMdFvF5zC2IO7kUw+PQ1TsYZn
X-Google-Smtp-Source: AGHT+IGrcZeC51Htx3ZBzVXMPmuQXdGlBVtF2G+Yixr/dMCNj2XyahVA33cxnN13A2op8BuEbPdCsA==
X-Received: by 2002:a05:6000:400a:b0:374:bde8:3b46 with SMTP id ffacd0b85a97d-37d0e6ccff0mr3208224f8f.2.1728307880782;
        Mon, 07 Oct 2024 06:31:20 -0700 (PDT)
Received: from e8ff02ae9b18.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c8e05eb34csm3193089a12.59.2024.10.07.06.31.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 06:31:20 -0700 (PDT)
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
Subject: [PATCH 2/8] ARM: dts: socfpga: add Enclustra boot-mode dtsi
Date: Mon,  7 Oct 2024 13:31:09 +0000
Message-Id: <20241007133115.1482619-3-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241007133115.1482619-1-l.rubusch@gmail.com>
References: <20241007133115.1482619-1-l.rubusch@gmail.com>
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


