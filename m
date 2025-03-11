Return-Path: <linux-kernel+bounces-555586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9814FA5B9F1
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 08:35:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D82F1170246
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 07:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38463222580;
	Tue, 11 Mar 2025 07:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=einfochips.com header.i=@einfochips.com header.b="c5HDcL62"
Received: from naesa05.arrow.com (naesa05.arrow.com [216.150.161.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0105224B07;
	Tue, 11 Mar 2025 07:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.150.161.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741678490; cv=none; b=lDtAMn2doewn+k4cwNDU7Qeo0rq1Nz3wIkO8wY0N8Rtwxqlv3snF4nzzB+e4SSH90oL9iL3+KfWIB6+1PdkZShcHiNu0y5/0gZs/1nfP5vYUGm8EVJQfoLGuLu9bjHcXGmTEAcahiZAFgj+NKpz/HHah0nkwNCqVkARHZY9UyDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741678490; c=relaxed/simple;
	bh=5heB6PuMYbbcCT5z+UhKDkhRC7FHz+vObUOuQmwwSh4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UQOzKBYgzup116CcAvMPMm2OSRS3Ra+6k8YvwytPw+GpLZA9EtbMs8p7UmtkVorTk0Ie1KXcC/O6G7YxVbOGgOCZBee9Uq0K0BkLHu4aHk/PcRM6+VIDHKvC2ZASlLISiODX1CEBNI6xBs2/5d1bU0iiy9DXDbfcc+w5HFa/jPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=einfochips.com; spf=pass smtp.mailfrom=einfochips.com; dkim=pass (2048-bit key) header.d=einfochips.com header.i=@einfochips.com header.b=c5HDcL62; arc=none smtp.client-ip=216.150.161.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=einfochips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=einfochips.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=einfochips.com; i=@einfochips.com; l=2333; q=dns/txt;
  s=NAESA-Selector1; t=1741678489; x=1773214489;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5heB6PuMYbbcCT5z+UhKDkhRC7FHz+vObUOuQmwwSh4=;
  b=c5HDcL62BxdTgTnh8Zlcopzr2TZthXzhQU0xqttww43dDGzCAnCZJg5Q
   4en4WbkklaaECOV369JFDCcRfivOpK6n476Rz/REjO4MWkcYOgvN41+j3
   3klyJqvQUZ0Ed0UwZWXfpRIUNVi9Y3wcSNL/ZAxOSmlKYZX32eb8ruPn4
   CnGXmSnAN/gUJ/DUqneAFAvdnlcCWmtKEZOD1oTvXRrwaqx+gwyd7aes9
   fl+lG+0fC2kuFUEtKAt/UQLXAu4CcgL77P1pSpa72d8N6HLLcundZt5E+
   XBQ7JVDZ//P6bxnxULx94A7kUVGb7Hemn6qVp/6aRHMgAgY6n5GpbZQIj
   w==;
X-CSE-ConnectionGUID: JDPdzyNDT+uOsW+8r86TvQ==
X-CSE-MsgGUID: WpKqaAXWSwK9HfUpyUXIFg==
X-IronPort-AV: E=Sophos;i="6.14,238,1736838000"; 
   d="scan'208";a="20386418"
Received: from unknown (HELO eicahmirelay01.einfochips.com) ([10.100.49.50])
  by naesa05out.arrow.com with ESMTP; 11 Mar 2025 01:34:47 -0600
Received: from AHMCPU1888.ap.corp.arrow.com ([172.25.5.100]) by eicahmirelay01.einfochips.com with Microsoft SMTPSVC(10.0.14393.4169);
	 Tue, 11 Mar 2025 13:04:33 +0530
From: Pinkesh Vaghela <pinkesh.vaghela@einfochips.com>
To: Conor Dooley <conor@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Min Lin <linmin@eswincomputing.com>,
	Pinkesh Vaghela <pinkesh.vaghela@einfochips.com>,
	Pritesh Patel <pritesh.patel@einfochips.com>,
	Yangyu Chen <cyy@cyyself.name>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Yu Chien Peter Lin <peterlin@andestech.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Kanak Shilledar <kanakshilledar@gmail.com>,
	Darshan Prajapati <darshan.prajapati@einfochips.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Aradhya Bhatia <a-bhatia1@ti.com>,
	rafal@milecki.pl,
	Anup Patel <anup@brainfault.org>,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 10/10] riscv: dts: eswin: add HiFive Premier P550 board device tree
Date: Tue, 11 Mar 2025 13:04:32 +0530
Message-Id: <20250311073432.4068512-11-pinkesh.vaghela@einfochips.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250311073432.4068512-1-pinkesh.vaghela@einfochips.com>
References: <20250311073432.4068512-1-pinkesh.vaghela@einfochips.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 11 Mar 2025 07:34:33.0290 (UTC) FILETIME=[0860CAA0:01DB9258]

From: Min Lin <linmin@eswincomputing.com>

Add initial board data for HiFive Premier P550 Development board

Currently the data populated in this DT file describes the board
DRAM configuration, UART and GPIO.

Signed-off-by: Min Lin <linmin@eswincomputing.com>
Co-developed-by: Pinkesh Vaghela <pinkesh.vaghela@einfochips.com>
Signed-off-by: Pinkesh Vaghela <pinkesh.vaghela@einfochips.com>
Reviewed-by: Samuel Holland <samuel.holland@sifive.com>
Tested-by: Samuel Holland <samuel.holland@sifive.com>
---
 arch/riscv/boot/dts/Makefile                  |  1 +
 arch/riscv/boot/dts/eswin/Makefile            |  2 ++
 .../dts/eswin/eic7700-hifive-premier-p550.dts | 29 +++++++++++++++++++
 3 files changed, 32 insertions(+)
 create mode 100644 arch/riscv/boot/dts/eswin/Makefile
 create mode 100644 arch/riscv/boot/dts/eswin/eic7700-hifive-premier-p550.dts

diff --git a/arch/riscv/boot/dts/Makefile b/arch/riscv/boot/dts/Makefile
index bff887d38abe..286a9939a8cb 100644
--- a/arch/riscv/boot/dts/Makefile
+++ b/arch/riscv/boot/dts/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 subdir-y += allwinner
 subdir-y += canaan
+subdir-y += eswin
 subdir-y += microchip
 subdir-y += renesas
 subdir-y += sifive
diff --git a/arch/riscv/boot/dts/eswin/Makefile b/arch/riscv/boot/dts/eswin/Makefile
new file mode 100644
index 000000000000..224101ae471e
--- /dev/null
+++ b/arch/riscv/boot/dts/eswin/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0
+dtb-$(CONFIG_ARCH_ESWIN) += eic7700-hifive-premier-p550.dtb
diff --git a/arch/riscv/boot/dts/eswin/eic7700-hifive-premier-p550.dts b/arch/riscv/boot/dts/eswin/eic7700-hifive-premier-p550.dts
new file mode 100644
index 000000000000..131ed1fc6b2e
--- /dev/null
+++ b/arch/riscv/boot/dts/eswin/eic7700-hifive-premier-p550.dts
@@ -0,0 +1,29 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright (c) 2024, Beijing ESWIN Computing Technology Co., Ltd.
+ */
+
+/dts-v1/;
+
+#include "eic7700.dtsi"
+
+/ {
+	compatible = "sifive,hifive-premier-p550", "eswin,eic7700";
+	model = "SiFive HiFive Premier P550";
+
+	aliases {
+		serial0 = &uart0;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+};
+
+&uart0 {
+	status = "okay";
+};
+
+&uart2 {
+	status = "okay";
+};
-- 
2.25.1


