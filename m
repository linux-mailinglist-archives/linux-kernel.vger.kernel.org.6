Return-Path: <linux-kernel+bounces-563109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E12AA63712
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 19:57:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 322A17A6164
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 18:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 170401F8ADF;
	Sun, 16 Mar 2025 18:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="awCJv31Z"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8038C1EEA29;
	Sun, 16 Mar 2025 18:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742151411; cv=none; b=FHxprYp8OP/KqdY0ESxGsC0freAE0cnSQSXPvPhWsr+cW7xst/PrkaYuL2Db3d+1uej4Xa1k/gcO+F0ANL5Vu6rrv7eUxkGsSd/DKlD46vI4UwanSR3T6N2UsNoBCy7gHPiTmi8DivIOG4FOMq7R93ZPUOJ0oKihDb4SaQf0LOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742151411; c=relaxed/simple;
	bh=vooiAA7iCXb4etNJQXR1mlqUeD1VnrvY7Zyyfhq2AfU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UMzVl8oUKxHxgp2bKrxtJ1jW2bhmZrOSNpLhDY2QZEyeMBYR459iD5YquivPczYu/LNC4nDlxgGaSABgiyc5Py0yqOFwAUV10Wu19nJiCVBgR93GVtoz/A9y+F5HYCrVYHOWy0DdoM2YJSYTzowQEsjRWc/AWh2RSIOj2NJK1b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=awCJv31Z; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43948021a45so14782465e9.1;
        Sun, 16 Mar 2025 11:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742151408; x=1742756208; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pb1dxZGebo6nHqsuNHV+lx93/PLHdbwZTSKy7EcNex0=;
        b=awCJv31ZF05fE1QKiNBXUKSIdijTpqzooDGtiVQlwruH7QgvUEhhl5MoKvcQPmsus6
         DZICsNbH37NCmfmLtsuMlbMdoU3Eik94MdyPEg64QaW0hRWxFcoqeMpw767li+j3Qr9Y
         0mD8umb9UpjCgx+m9Hm9VAA8R5WbuQS+rBfhUgjqxmh4com1AuLP8bTRpB9zpr1DRoyX
         fvaGMoy7Rlv1ML1HZ8y08hQNLRz61IlP9jlDZX6aCqh2fKcrYaRUVDTsSfjzgqQfo4Hi
         9FSd/TPlbyo7r2tn8RHJc2XweGEEeNLmpDseBM1RptCdc6i+6AQggd3pQAQVBbKnZuzW
         KqlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742151408; x=1742756208;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pb1dxZGebo6nHqsuNHV+lx93/PLHdbwZTSKy7EcNex0=;
        b=cn5kt+3oT05bhdqPDucgsUZahGmK7vjFXhOUkQPWvA7Re9voqYvXIn56Q6pEOc1zGs
         s1M9Fr8iCzoD9Juc7sVHH1h+RdZSSMqxKnok3mIgU4A60CoyMZL/PZWryXO0ohZzOdvN
         ssu+rOjSRrh7x80uHZrlCfnjDag0ajBvg4vx+4ZkYW9t+K3jS2tXKf+pRGhcWR6YO0aB
         ijjEZQ6hvNl0ukemAW4fE2TrVkd8h+VVJRvhrNyxEr1CfrPTxNCyhiu4oVy+ecwyLaRF
         K1BtLkz+jvDS9Od44s/qukxj+kN3rmh6U0QCVobjycqBS/xqcrOR/IR2MwVWioLDEnOv
         bnWg==
X-Forwarded-Encrypted: i=1; AJvYcCW2+DtdqafawVD5SAtSatEEQb4tVgIc9PDkM4CicBYx7o4b0zWtYlwHKIv+826NVi7FkgzTIPxvBnxT@vger.kernel.org, AJvYcCXqqdA8vP02B5ttDXfMi8llVEP7N+8/mWJvhdgmY9mWADFkeikfJwILCbwACMIiGPs/nsyys55XcCEC7sMS@vger.kernel.org
X-Gm-Message-State: AOJu0YyWLwROVd2ixe3faSuYNV2RVppjOOlw6WY5KLbAWwmXcuGK2pf+
	z7Dwqza8xs30kHo2RaZbFMCONuFdiaSL7qwN1O42DXQeQ869VpEE
X-Gm-Gg: ASbGncs2zUN1hClgxnlHJC8gDjiysAH1d1+a/B1WAi1S6oEelsPYBbBMFhIIq3/Lkh/
	gN6RlffMKushZtLXBdT4/Zvi+Fmdc/mt5wNXMe9yhCgl16Z17bLrnwCy5ca59kN1K8jU/2i6uOi
	oUZhvHXZbImLNg0Gqf8unOBzktUaxA/Hnf2JzE+xdzHDY84KrogQesADEUH/GauLEJ9joP21Wje
	pIdt4HkG0SGy8Ix/981F+Z8HN3i1c0Z5bgtVWS0Es9YXPeyj+3aRsDtGlwYGPlRtu4lyeu7WB5k
	FRjxQh2rEuJDyeme53CwovEI9t2t49x0UAeBAEpbf8lH1pfGtV8rUuaR/w==
X-Google-Smtp-Source: AGHT+IHFZy+0lw/Dp6DjLzQfA/ftWygxBDcebBKg38wTFmBJaPs8U389GwX3qDbhTwDISEehh/tR+A==
X-Received: by 2002:a5d:5f94:0:b0:391:4914:3c6a with SMTP id ffacd0b85a97d-3971e1b49ccmr12926932f8f.29.1742151407582;
        Sun, 16 Mar 2025 11:56:47 -0700 (PDT)
Received: from giga-mm.. ([2a02:1210:861b:6f00:82ee:73ff:feb8:99e3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d1ffb6292sm84692335e9.1.2025.03.16.11.56.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Mar 2025 11:56:47 -0700 (PDT)
From: Alexander Sverdlin <alexander.sverdlin@gmail.com>
To: sophgo@lists.linux.dev,
	soc@lists.linux.dev
Cc: Alexander Sverdlin <alexander.sverdlin@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Jisheng Zhang <jszhang@kernel.org>,
	Haylen Chu <heylenay@outlook.com>,
	Chao Wei <chao.wei@sophgo.com>,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v5 4/7] arm64: dts: sophgo: Add Duo Module 01
Date: Sun, 16 Mar 2025 19:56:34 +0100
Message-ID: <20250316185640.3750873-5-alexander.sverdlin@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250316185640.3750873-1-alexander.sverdlin@gmail.com>
References: <20250316185640.3750873-1-alexander.sverdlin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Duo Module 01 is a compact module with integrated SG2000,
WI-FI6/BTDM5.4, and eMMC.
Add only support for UART and SDHCI.

Signed-off-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
---
Changelog:
v5:
v4:
v3:
v2:
- sorted all nodes according to DT coding style;
- added "compatible" property;
- renamed the new .dtsi not to use underscores;
- added status = "okay" instead of deleting it;

 .../sophgo/sg2000-milkv-duo-module-01.dtsi    | 85 +++++++++++++++++++
 1 file changed, 85 insertions(+)
 create mode 100644 arch/arm64/boot/dts/sophgo/sg2000-milkv-duo-module-01.dtsi

diff --git a/arch/arm64/boot/dts/sophgo/sg2000-milkv-duo-module-01.dtsi b/arch/arm64/boot/dts/sophgo/sg2000-milkv-duo-module-01.dtsi
new file mode 100644
index 000000000000..bb52cdad990a
--- /dev/null
+++ b/arch/arm64/boot/dts/sophgo/sg2000-milkv-duo-module-01.dtsi
@@ -0,0 +1,85 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+
+#include <dt-bindings/pinctrl/pinctrl-sg2000.h>
+#include "sg2000.dtsi"
+
+/ {
+	model = "Milk-V Duo Module 01";
+	compatible = "milkv,duo-module-01", "sophgo,sg2000";
+
+	aliases {
+		serial0 = &uart0;
+		serial1 = &uart1;
+		serial2 = &uart2;
+		serial3 = &uart3;
+		serial4 = &uart4;
+	};
+};
+
+&osc {
+	clock-frequency = <25000000>;
+};
+
+&pinctrl {
+	sdhci0_cfg: sdhci0-cfg {
+		sdhci0-cd-pins {
+			pinmux = <PINMUX(PIN_SD0_CD, 0)>;
+			bias-pull-up;
+			drive-strength-microamp = <10800>;
+			power-source = <3300>;
+		};
+
+		sdhci0-clk-pins {
+			pinmux = <PINMUX(PIN_SD0_CLK, 0)>;
+			bias-pull-up;
+			drive-strength-microamp = <16100>;
+			power-source = <3300>;
+		};
+
+		sdhci0-cmd-pins {
+			pinmux = <PINMUX(PIN_SD0_CMD, 0)>;
+			bias-pull-up;
+			drive-strength-microamp = <10800>;
+			power-source = <3300>;
+		};
+
+		sdhci0-data-pins {
+			pinmux = <PINMUX(PIN_SD0_D0, 0)>,
+				 <PINMUX(PIN_SD0_D1, 0)>,
+				 <PINMUX(PIN_SD0_D2, 0)>,
+				 <PINMUX(PIN_SD0_D3, 0)>;
+			bias-pull-up;
+			drive-strength-microamp = <10800>;
+			power-source = <3300>;
+		};
+	};
+
+	uart0_cfg: uart0-cfg {
+		uart0-pins {
+			pinmux = <PINMUX(PIN_UART0_TX, 0)>,
+				 <PINMUX(PIN_UART0_RX, 0)>;
+			bias-pull-up;
+			drive-strength-microamp = <10800>;
+			power-source = <3300>;
+		};
+	};
+};
+
+&emmc {
+	bus-width = <4>;
+	no-1-8-v;
+	cap-mmc-hw-reset;
+	no-sd;
+	no-sdio;
+	non-removable;
+	status = "okay";
+};
+
+/* Wi-Fi */
+&sdhci1 {
+	bus-width = <4>;
+	cap-sdio-irq;
+	no-mmc;
+	no-sd;
+	non-removable;
+};
-- 
2.48.1


