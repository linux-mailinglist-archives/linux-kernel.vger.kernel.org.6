Return-Path: <linux-kernel+bounces-359026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD99A998688
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 14:47:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E01A41C2250B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 12:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF10E1C688A;
	Thu, 10 Oct 2024 12:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h5xlRvyh"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C011C243D;
	Thu, 10 Oct 2024 12:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728564426; cv=none; b=Mvx58W/YYtN5aXlPZoDntqfBJgZJvcMakxwNl6wQjoFzY1yngTT0L6SgNYbq/9fAruzHhnfL46lWTq1Vt64sI/HGfeAlxCp9oBW0pivQ1Lh1tK2It5xjWyVG+bLiBk/hjw4/9Q34qfoync8UpPT/X1IPZ0m7yFGKp/g48N27z7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728564426; c=relaxed/simple;
	bh=i7IRN01DOQbNWJEeqwSy7JUm+KNLjnZhuuu20wF22Fc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X6gf9GwmD8bNdBgumqWlBM1Gn4lUYDcQnsU92kSPTd+r+hZ9bgXapkM1DDbRmB9ZBwSMgW+mw0UB3V9qSQRvxmLkik0KQZekqT7EmJvcOAM856j69551q9XrDHo9yCvwxSkNX2v+oo/XZ6zFz9cuZ2EpZ9J6lsNeRKMvMR/yZ7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h5xlRvyh; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a9953bdc341so30664266b.2;
        Thu, 10 Oct 2024 05:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728564423; x=1729169223; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8ASU8H0E1W7S/5Vk3gj9eaY3W5OKdkak9GOEMENTAdA=;
        b=h5xlRvyhhhucWxVG+zsS8aO7i7bFqur6h/zSM5Ziz+EncVkMGx+i/RBvGsPbVqxUlq
         XnVEY0TLgQlyuamc6HLThv769MvdM43Rp38XBLbX9tc5i9nDBhy8sY+iYlIm/qWNvfqg
         bwwVABMgv6QHSYRe8wR+fsy1bMwJiJzUKgTmqLbpGzyv8xUE21HADxYYDRCHUac9PcXC
         Ge937/nAIzqHekPwKDOs7YzMwp0ru8rqEwD8AGBWKVh4ULFfEIKTC9Sh0NxD02n2G5F6
         TLvbJf4KT7yCIID11DELFL43xE3cWf31hCB5Ho/RuW2XX4ngezJaZuI6d5QUkTk1x/Zi
         aY8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728564423; x=1729169223;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8ASU8H0E1W7S/5Vk3gj9eaY3W5OKdkak9GOEMENTAdA=;
        b=oTSi0fxvBALMXrj+JZGpCDnm6CWDhDhHU1wkn6FRdi+yD2KlTpbDVjs5q+ElK/BrHw
         xDv5Inf0UAJ7glcuMMn4kEmQwwdD9G4wlqxxQirKNJM5B9WJ9Zu8Ct4blcIWpuYtbQNo
         r0wXfF7Dg9oC+k5DFGhvCdPP2seDYxOZisa+SiUoRjjU/X6zejmakDKG9bvmw1Uyy2rh
         cgl+e4+URZTA71gdmfkRaEUX9s4iFR8n4oEWcIWzhUQWRi1qeUP5CvEF8piFSzawp18k
         NqbmNtQ+hKQPJaU7zjWAD+Or/5Mzq2jR3E4euZt9hjp0THMpDblWC5BzrYjc9weHZHbV
         8cFw==
X-Forwarded-Encrypted: i=1; AJvYcCUImdUSXNlTo3oJWvJmdCJbPTLRI3r54iFJ8Qjg5XIJ5yhCp4HsbSeZhfT6/MRwKFWpQ75A5F8CudpkJBcv@vger.kernel.org, AJvYcCUSd7R36ZfDeHl86/StghT9DTo+FlV2rnqPRWxgz1Iufmikq/qaiHIbcUXngkkIbMfBtmPpvLX9hre/@vger.kernel.org, AJvYcCVAULBD3B/UO3Q+1EujA5WvEuiPi4oHL5VPrCnJWI14KJfd3LumGqoZbbLlObUqNp6Z54wo0KBQUwM6@vger.kernel.org
X-Gm-Message-State: AOJu0Ywk4fs5dAWxwXQatn9p7hRzmJmiiYp/5zNCr6btwj5a8+ddXjfM
	FZhHQKocNXiIAOrcwWmSQsS3JZTbhgyaG1TJsTVrCl98sdSBX06F
X-Google-Smtp-Source: AGHT+IEpzYvxLtBe00Wzz05cubrxL4KZmWTzbCoUV1xqMKFZi+wPK8DMQ4Rxgo5JeylwkHtWiWYDQA==
X-Received: by 2002:a17:907:9709:b0:a86:8e3d:86e2 with SMTP id a640c23a62f3a-a998d122007mr559732866b.11.1728564422545;
        Thu, 10 Oct 2024 05:47:02 -0700 (PDT)
Received: from zenbook.agu.edu.tr (89-38-97-199.hosted-by-worldstream.net. [89.38.97.199])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99a80dc5easm85654466b.170.2024.10.10.05.46.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 05:47:02 -0700 (PDT)
From: Yassine Oudjana <yassine.oudjana@gmail.com>
X-Google-Original-From: Yassine Oudjana <y.oudjana@protonmail.com>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Sam Shih <sam.shih@mediatek.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Yassine Oudjana <y.oudjana@protonmail.com>,
	Yassine Oudjana <yassine.oudjana@gmail.com>,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v5 1/2] dt-bindings: clock: Add MediaTek MT6735 clock and reset bindings
Date: Thu, 10 Oct 2024 15:45:25 +0300
Message-ID: <20241010124529.78460-2-y.oudjana@protonmail.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241010124529.78460-1-y.oudjana@protonmail.com>
References: <20241010124529.78460-1-y.oudjana@protonmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yassine Oudjana <y.oudjana@protonmail.com>

Add clock definitions for the main clock and reset controllers of MT6735
(apmixedsys, topckgen, infracfg and pericfg).

Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../bindings/clock/mediatek,apmixedsys.yaml   |  4 +-
 .../bindings/clock/mediatek,infracfg.yaml     |  8 +-
 .../bindings/clock/mediatek,pericfg.yaml      |  1 +
 .../bindings/clock/mediatek,topckgen.yaml     |  4 +-
 MAINTAINERS                                   | 12 +++
 .../clock/mediatek,mt6735-apmixedsys.h        | 16 ++++
 .../clock/mediatek,mt6735-infracfg.h          | 25 ++++++
 .../clock/mediatek,mt6735-pericfg.h           | 37 +++++++++
 .../clock/mediatek,mt6735-topckgen.h          | 79 +++++++++++++++++++
 .../reset/mediatek,mt6735-infracfg.h          | 27 +++++++
 .../reset/mediatek,mt6735-pericfg.h           | 31 ++++++++
 11 files changed, 239 insertions(+), 5 deletions(-)
 create mode 100644 include/dt-bindings/clock/mediatek,mt6735-apmixedsys.h
 create mode 100644 include/dt-bindings/clock/mediatek,mt6735-infracfg.h
 create mode 100644 include/dt-bindings/clock/mediatek,mt6735-pericfg.h
 create mode 100644 include/dt-bindings/clock/mediatek,mt6735-topckgen.h
 create mode 100644 include/dt-bindings/reset/mediatek,mt6735-infracfg.h
 create mode 100644 include/dt-bindings/reset/mediatek,mt6735-pericfg.h

diff --git a/Documentation/devicetree/bindings/clock/mediatek,apmixedsys.yaml b/Documentation/devicetree/bindings/clock/mediatek,apmixedsys.yaml
index db5f48e4dd157..591a9e862c7d4 100644
--- a/Documentation/devicetree/bindings/clock/mediatek,apmixedsys.yaml
+++ b/Documentation/devicetree/bindings/clock/mediatek,apmixedsys.yaml
@@ -12,7 +12,8 @@ maintainers:
 
 description:
   The Mediatek apmixedsys controller provides PLLs to the system.
-  The clock values can be found in <dt-bindings/clock/mt*-clk.h>.
+  The clock values can be found in <dt-bindings/clock/mt*-clk.h>
+  and <dt-bindings/clock/mediatek,mt*-apmixedsys.h>.
 
 properties:
   compatible:
@@ -34,6 +35,7 @@ properties:
           - enum:
               - mediatek,mt2701-apmixedsys
               - mediatek,mt2712-apmixedsys
+              - mediatek,mt6735-apmixedsys
               - mediatek,mt6765-apmixedsys
               - mediatek,mt6779-apmixed
               - mediatek,mt6795-apmixedsys
diff --git a/Documentation/devicetree/bindings/clock/mediatek,infracfg.yaml b/Documentation/devicetree/bindings/clock/mediatek,infracfg.yaml
index 252c46d316ee5..d1d30700d9b0e 100644
--- a/Documentation/devicetree/bindings/clock/mediatek,infracfg.yaml
+++ b/Documentation/devicetree/bindings/clock/mediatek,infracfg.yaml
@@ -11,9 +11,10 @@ maintainers:
 
 description:
   The Mediatek infracfg controller provides various clocks and reset outputs
-  to the system. The clock values can be found in <dt-bindings/clock/mt*-clk.h>,
-  and reset values in <dt-bindings/reset/mt*-reset.h> and
-  <dt-bindings/reset/mt*-resets.h>.
+  to the system. The clock values can be found in <dt-bindings/clock/mt*-clk.h>
+  and <dt-bindings/clock/mediatek,mt*-infracfg.h>, and reset values in
+  <dt-bindings/reset/mt*-reset.h>, <dt-bindings/reset/mt*-resets.h> and
+  <dt-bindings/reset/mediatek,mt*-infracfg.h>.
 
 properties:
   compatible:
@@ -22,6 +23,7 @@ properties:
           - enum:
               - mediatek,mt2701-infracfg
               - mediatek,mt2712-infracfg
+              - mediatek,mt6735-infracfg
               - mediatek,mt6765-infracfg
               - mediatek,mt6795-infracfg
               - mediatek,mt6779-infracfg_ao
diff --git a/Documentation/devicetree/bindings/clock/mediatek,pericfg.yaml b/Documentation/devicetree/bindings/clock/mediatek,pericfg.yaml
index 2f06baecfd233..b98cf45efe2f6 100644
--- a/Documentation/devicetree/bindings/clock/mediatek,pericfg.yaml
+++ b/Documentation/devicetree/bindings/clock/mediatek,pericfg.yaml
@@ -20,6 +20,7 @@ properties:
           - enum:
               - mediatek,mt2701-pericfg
               - mediatek,mt2712-pericfg
+              - mediatek,mt6735-pericfg
               - mediatek,mt6765-pericfg
               - mediatek,mt6795-pericfg
               - mediatek,mt7622-pericfg
diff --git a/Documentation/devicetree/bindings/clock/mediatek,topckgen.yaml b/Documentation/devicetree/bindings/clock/mediatek,topckgen.yaml
index bdf3b55bd56fd..c080fb0a16181 100644
--- a/Documentation/devicetree/bindings/clock/mediatek,topckgen.yaml
+++ b/Documentation/devicetree/bindings/clock/mediatek,topckgen.yaml
@@ -12,7 +12,8 @@ maintainers:
 
 description:
   The Mediatek topckgen controller provides various clocks to the system.
-  The clock values can be found in <dt-bindings/clock/mt*-clk.h>.
+  The clock values can be found in <dt-bindings/clock/mt*-clk.h> and
+  <dt-bindings/clock/mediatek,mt*-topckgen.h>.
 
 properties:
   compatible:
@@ -31,6 +32,7 @@ properties:
           - enum:
               - mediatek,mt2701-topckgen
               - mediatek,mt2712-topckgen
+              - mediatek,mt6735-topckgen
               - mediatek,mt6765-topckgen
               - mediatek,mt6779-topckgen
               - mediatek,mt6795-topckgen
diff --git a/MAINTAINERS b/MAINTAINERS
index b1058f02e613e..a5a8f700f06f4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14567,6 +14567,18 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/mmc/mtk-sd.yaml
 F:	drivers/mmc/host/mtk-sd.c
 
+MEDIATEK MT6735 CLOCK & RESET DRIVERS
+M:	Yassine Oudjana <y.oudjana@protonmail.com>
+L:	linux-clk@vger.kernel.org
+L:	linux-mediatek@lists.infradead.org (moderated for non-subscribers)
+S:	Maintained
+F:	include/dt-bindings/clock/mediatek,mt6735-apmixedsys.h
+F:	include/dt-bindings/clock/mediatek,mt6735-infracfg.h
+F:	include/dt-bindings/clock/mediatek,mt6735-pericfg.h
+F:	include/dt-bindings/clock/mediatek,mt6735-topckgen.h
+F:	include/dt-bindings/reset/mediatek,mt6735-infracfg.h
+F:	include/dt-bindings/reset/mediatek,mt6735-pericfg.h
+
 MEDIATEK MT76 WIRELESS LAN DRIVER
 M:	Felix Fietkau <nbd@nbd.name>
 M:	Lorenzo Bianconi <lorenzo@kernel.org>
diff --git a/include/dt-bindings/clock/mediatek,mt6735-apmixedsys.h b/include/dt-bindings/clock/mediatek,mt6735-apmixedsys.h
new file mode 100644
index 0000000000000..b4705204409c5
--- /dev/null
+++ b/include/dt-bindings/clock/mediatek,mt6735-apmixedsys.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+
+#ifndef _DT_BINDINGS_CLK_MT6735_APMIXEDSYS_H
+#define _DT_BINDINGS_CLK_MT6735_APMIXEDSYS_H
+
+#define CLK_APMIXED_ARMPLL		0
+#define CLK_APMIXED_MAINPLL		1
+#define CLK_APMIXED_UNIVPLL		2
+#define CLK_APMIXED_MMPLL		3
+#define CLK_APMIXED_MSDCPLL		4
+#define CLK_APMIXED_VENCPLL		5
+#define CLK_APMIXED_TVDPLL		6
+#define CLK_APMIXED_APLL1		7
+#define CLK_APMIXED_APLL2		8
+
+#endif
diff --git a/include/dt-bindings/clock/mediatek,mt6735-infracfg.h b/include/dt-bindings/clock/mediatek,mt6735-infracfg.h
new file mode 100644
index 0000000000000..d8dd51e15637e
--- /dev/null
+++ b/include/dt-bindings/clock/mediatek,mt6735-infracfg.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+
+#ifndef _DT_BINDINGS_CLK_MT6735_INFRACFG_H
+#define _DT_BINDINGS_CLK_MT6735_INFRACFG_H
+
+#define CLK_INFRA_DBG			0
+#define CLK_INFRA_GCE			1
+#define CLK_INFRA_TRBG			2
+#define CLK_INFRA_CPUM			3
+#define CLK_INFRA_DEVAPC		4
+#define CLK_INFRA_AUDIO			5
+#define CLK_INFRA_GCPU			6
+#define CLK_INFRA_L2C_SRAM		7
+#define CLK_INFRA_M4U			8
+#define CLK_INFRA_CLDMA			9
+#define CLK_INFRA_CONNMCU_BUS		10
+#define CLK_INFRA_KP			11
+#define CLK_INFRA_APXGPT		12
+#define CLK_INFRA_SEJ			13
+#define CLK_INFRA_CCIF0_AP		14
+#define CLK_INFRA_CCIF1_AP		15
+#define CLK_INFRA_PMIC_SPI		16
+#define CLK_INFRA_PMIC_WRAP		17
+
+#endif
diff --git a/include/dt-bindings/clock/mediatek,mt6735-pericfg.h b/include/dt-bindings/clock/mediatek,mt6735-pericfg.h
new file mode 100644
index 0000000000000..16bc21bbd95b7
--- /dev/null
+++ b/include/dt-bindings/clock/mediatek,mt6735-pericfg.h
@@ -0,0 +1,37 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+
+#ifndef _DT_BINDINGS_CLK_MT6735_PERICFG_H
+#define _DT_BINDINGS_CLK_MT6735_PERICFG_H
+
+#define CLK_PERI_DISP_PWM		0
+#define CLK_PERI_THERM			1
+#define CLK_PERI_PWM1			2
+#define CLK_PERI_PWM2			3
+#define CLK_PERI_PWM3			4
+#define CLK_PERI_PWM4			5
+#define CLK_PERI_PWM5			6
+#define CLK_PERI_PWM6			7
+#define CLK_PERI_PWM7			8
+#define CLK_PERI_PWM			9
+#define CLK_PERI_USB0			10
+#define CLK_PERI_IRDA			11
+#define CLK_PERI_APDMA			12
+#define CLK_PERI_MSDC30_0		13
+#define CLK_PERI_MSDC30_1		14
+#define CLK_PERI_MSDC30_2		15
+#define CLK_PERI_MSDC30_3		16
+#define CLK_PERI_UART0			17
+#define CLK_PERI_UART1			18
+#define CLK_PERI_UART2			19
+#define CLK_PERI_UART3			20
+#define CLK_PERI_UART4			21
+#define CLK_PERI_BTIF			22
+#define CLK_PERI_I2C0			23
+#define CLK_PERI_I2C1			24
+#define CLK_PERI_I2C2			25
+#define CLK_PERI_I2C3			26
+#define CLK_PERI_AUXADC			27
+#define CLK_PERI_SPI0			28
+#define CLK_PERI_IRTX			29
+
+#endif
diff --git a/include/dt-bindings/clock/mediatek,mt6735-topckgen.h b/include/dt-bindings/clock/mediatek,mt6735-topckgen.h
new file mode 100644
index 0000000000000..d4b1e113cc0aa
--- /dev/null
+++ b/include/dt-bindings/clock/mediatek,mt6735-topckgen.h
@@ -0,0 +1,79 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+
+#ifndef _DT_BINDINGS_CLK_MT6735_TOPCKGEN_H
+#define _DT_BINDINGS_CLK_MT6735_TOPCKGEN_H
+
+#define CLK_TOP_AD_SYS_26M_CK		0
+#define CLK_TOP_CLKPH_MCK_O		1
+#define CLK_TOP_DMPLL			2
+#define CLK_TOP_DPI_CK			3
+#define CLK_TOP_WHPLL_AUDIO_CK		4
+
+#define CLK_TOP_SYSPLL_D2		5
+#define CLK_TOP_SYSPLL_D3		6
+#define CLK_TOP_SYSPLL_D5		7
+#define CLK_TOP_SYSPLL1_D2		8
+#define CLK_TOP_SYSPLL1_D4		9
+#define CLK_TOP_SYSPLL1_D8		10
+#define CLK_TOP_SYSPLL1_D16		11
+#define CLK_TOP_SYSPLL2_D2		12
+#define CLK_TOP_SYSPLL2_D4		13
+#define CLK_TOP_SYSPLL3_D2		14
+#define CLK_TOP_SYSPLL3_D4		15
+#define CLK_TOP_SYSPLL4_D2		16
+#define CLK_TOP_SYSPLL4_D4		17
+#define CLK_TOP_UNIVPLL_D2		18
+#define CLK_TOP_UNIVPLL_D3		19
+#define CLK_TOP_UNIVPLL_D5		20
+#define CLK_TOP_UNIVPLL_D26		21
+#define CLK_TOP_UNIVPLL1_D2		22
+#define CLK_TOP_UNIVPLL1_D4		23
+#define CLK_TOP_UNIVPLL1_D8		24
+#define CLK_TOP_UNIVPLL2_D2		25
+#define CLK_TOP_UNIVPLL2_D4		26
+#define CLK_TOP_UNIVPLL2_D8		27
+#define CLK_TOP_UNIVPLL3_D2		28
+#define CLK_TOP_UNIVPLL3_D4		29
+#define CLK_TOP_MSDCPLL_D2		30
+#define CLK_TOP_MSDCPLL_D4		31
+#define CLK_TOP_MSDCPLL_D8		32
+#define CLK_TOP_MSDCPLL_D16		33
+#define CLK_TOP_VENCPLL_D3		34
+#define CLK_TOP_TVDPLL_D2		35
+#define CLK_TOP_TVDPLL_D4		36
+#define CLK_TOP_DMPLL_D2		37
+#define CLK_TOP_DMPLL_D4		38
+#define CLK_TOP_DMPLL_D8		39
+#define CLK_TOP_AD_SYS_26M_D2		40
+
+#define CLK_TOP_AXI_SEL			41
+#define CLK_TOP_MEM_SEL			42
+#define CLK_TOP_DDRPHY_SEL		43
+#define CLK_TOP_MM_SEL			44
+#define CLK_TOP_PWM_SEL			45
+#define CLK_TOP_VDEC_SEL		46
+#define CLK_TOP_MFG_SEL			47
+#define CLK_TOP_CAMTG_SEL		48
+#define CLK_TOP_UART_SEL		49
+#define CLK_TOP_SPI_SEL			50
+#define CLK_TOP_USB20_SEL		51
+#define CLK_TOP_MSDC50_0_SEL		52
+#define CLK_TOP_MSDC30_0_SEL		53
+#define CLK_TOP_MSDC30_1_SEL		54
+#define CLK_TOP_MSDC30_2_SEL		55
+#define CLK_TOP_MSDC30_3_SEL		56
+#define CLK_TOP_AUDIO_SEL		57
+#define CLK_TOP_AUDINTBUS_SEL		58
+#define CLK_TOP_PMICSPI_SEL		59
+#define CLK_TOP_SCP_SEL			60
+#define CLK_TOP_ATB_SEL			61
+#define CLK_TOP_DPI0_SEL		62
+#define CLK_TOP_SCAM_SEL		63
+#define CLK_TOP_MFG13M_SEL		64
+#define CLK_TOP_AUD1_SEL		65
+#define CLK_TOP_AUD2_SEL		66
+#define CLK_TOP_IRDA_SEL		67
+#define CLK_TOP_IRTX_SEL		68
+#define CLK_TOP_DISPPWM_SEL		69
+
+#endif
diff --git a/include/dt-bindings/reset/mediatek,mt6735-infracfg.h b/include/dt-bindings/reset/mediatek,mt6735-infracfg.h
new file mode 100644
index 0000000000000..9df9690903771
--- /dev/null
+++ b/include/dt-bindings/reset/mediatek,mt6735-infracfg.h
@@ -0,0 +1,27 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+
+#ifndef _DT_BINDINGS_RESET_MT6735_INFRACFG_H
+#define _DT_BINDINGS_RESET_MT6735_INFRACFG_H
+
+#define MT6735_INFRA_RST0_EMI_REG		0
+#define MT6735_INFRA_RST0_DRAMC0_AO		1
+#define MT6735_INFRA_RST0_AP_CIRQ_EINT		2
+#define MT6735_INFRA_RST0_APXGPT		3
+#define MT6735_INFRA_RST0_SCPSYS		4
+#define MT6735_INFRA_RST0_KP			5
+#define MT6735_INFRA_RST0_PMIC_WRAP		6
+#define MT6735_INFRA_RST0_CLDMA_AO_TOP		7
+#define MT6735_INFRA_RST0_USBSIF_TOP		8
+#define MT6735_INFRA_RST0_EMI			9
+#define MT6735_INFRA_RST0_CCIF			10
+#define MT6735_INFRA_RST0_DRAMC0		11
+#define MT6735_INFRA_RST0_EMI_AO_REG		12
+#define MT6735_INFRA_RST0_CCIF_AO		13
+#define MT6735_INFRA_RST0_TRNG			14
+#define MT6735_INFRA_RST0_SYS_CIRQ		15
+#define MT6735_INFRA_RST0_GCE			16
+#define MT6735_INFRA_RST0_M4U			17
+#define MT6735_INFRA_RST0_CCIF1			18
+#define MT6735_INFRA_RST0_CLDMA_TOP_PD		19
+
+#endif
diff --git a/include/dt-bindings/reset/mediatek,mt6735-pericfg.h b/include/dt-bindings/reset/mediatek,mt6735-pericfg.h
new file mode 100644
index 0000000000000..a62bb192835a0
--- /dev/null
+++ b/include/dt-bindings/reset/mediatek,mt6735-pericfg.h
@@ -0,0 +1,31 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+
+#ifndef _DT_BINDINGS_RESET_MT6735_PERICFG_H
+#define _DT_BINDINGS_RESET_MT6735_PERICFG_H
+
+#define MT6735_PERI_RST0_UART0			0
+#define MT6735_PERI_RST0_UART1			1
+#define MT6735_PERI_RST0_UART2			2
+#define MT6735_PERI_RST0_UART3			3
+#define MT6735_PERI_RST0_UART4			4
+#define MT6735_PERI_RST0_BTIF			5
+#define MT6735_PERI_RST0_DISP_PWM_PERI		6
+#define MT6735_PERI_RST0_PWM			7
+#define MT6735_PERI_RST0_AUXADC			8
+#define MT6735_PERI_RST0_DMA			9
+#define MT6735_PERI_RST0_IRDA			10
+#define MT6735_PERI_RST0_IRTX			11
+#define MT6735_PERI_RST0_THERM			12
+#define MT6735_PERI_RST0_MSDC2			13
+#define MT6735_PERI_RST0_MSDC3			14
+#define MT6735_PERI_RST0_MSDC0			15
+#define MT6735_PERI_RST0_MSDC1			16
+#define MT6735_PERI_RST0_I2C0			17
+#define MT6735_PERI_RST0_I2C1			18
+#define MT6735_PERI_RST0_I2C2			19
+#define MT6735_PERI_RST0_I2C3			20
+#define MT6735_PERI_RST0_USB			21
+
+#define MT6735_PERI_RST1_SPI0			22
+
+#endif
-- 
2.46.2


