Return-Path: <linux-kernel+bounces-571510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 93D1EA6BE24
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 16:19:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8EBA7A7006
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 15:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4033F1E98EB;
	Fri, 21 Mar 2025 15:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="dZJ6cQN0"
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8825B1DDC1B
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 15:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742570319; cv=none; b=sZQZkPTB5yhCP6H6MsW4gNKFAd9OuF5JnzsU9HUQei/mxCTQQliWX8dFYzfeq9NyNaABxJN93HthDbiGc9JX92HskK1ARfg4qKt1mdK/1gT2K3LwIUZUZbkgvhY9EO3xJDB/L9Ipqed9eph1C2Q7qAxIjLxBRhxzVm63PPXH73g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742570319; c=relaxed/simple;
	bh=geLdGDfDppztif7o0rQLveIfzRTCzSWPOzmxcCRsJxg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YXR6Pcn0WZIk9q93evegNdaQLCA5xbP8nn2FGoOsQKTee4VJ5v6ZWU8fCNYm+/zxLOZ84CFrC+LvCiQv7vHVPIMXMqMoRUrbzn5FClaXcXT74gNrDrmxZp/EX34HbeT38hyXToE6B/I/3w+oiOoyiYT8Xnu6ufWhXK3Qc3wA3Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=dZJ6cQN0; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-855bd88ee2cso55085239f.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 08:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1742570316; x=1743175116; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BbvEkFGBoxFLcT+B9yfnDSBEgyYVKDqcuGRDBtDVFkg=;
        b=dZJ6cQN0Wj1874MARZtnEtf0VQzjTs5I4qDxGCcEnSgdcDGKx0Z4lQkCal4YED+oJN
         Rwmmv1kPwH2WFLqdbyUVAZRhQJsWi62T8+yotuXph4Y3IiW/1JkYSBFN3cSZ0GAb4e5z
         oCbR3n5/CWmux7LcJ1vx4LTkYVGycvG6fnyzva+5PNJubATxYigG5Zefj0YBF0IZWmWB
         91LCindCy/xV80OQdibM8uiULDPogcOqQX0nNw+M11UfwQzt/LdHECJtc13vxyfKSabR
         E74wrW6kNVcBCkZLwhl1bedxURYKlyqdiVo9Q+lU2BH+D3ed93GVRYILeF+4ANjvTClU
         T1CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742570316; x=1743175116;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BbvEkFGBoxFLcT+B9yfnDSBEgyYVKDqcuGRDBtDVFkg=;
        b=MZg0Na5F9iuh9GLdQx/ZcrB+EO/KwRnNeLTCuM5szfxz4twwbKZ/7jCpx4VMGJ9WK4
         pbKGs0U6/z0gHQdJGuORHNLsabZva7IMJ7snvDwmQ57xJEteEVTV7mouUyVsUAzKOX0L
         YWCYUUmNFATrNZPQ7GKBMR9i9R3OutMjHFgRP9Exrql6m15a+fE35BuCixaEWF5B4aYh
         413JKH3HphMkWFz7rZ2tKzSdC19xj/sWsIJFOO3IFbZUfMW9lmRPtNP95o0/+hcB6FgC
         8XlCiWHY7IxMqJ4ePmYz4gtC9g16WAPCB0K2I9MoM1ShzEP2ePwu2uctb2hmJL6NT7Mx
         iSBA==
X-Forwarded-Encrypted: i=1; AJvYcCWLybqmwxKNmM4zUpzI8tGMG3VbGcH9KtdEIZ60KtL2HW1jAE2mAwZEXlz4VlPOhZBflf9YgklG5QWFZ04=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8tsdHmUwgw5/OeJecxyufhXNT499YIDlqGTiaSBC4R8oA+Bk8
	j2mELSXufqtZhBhMm2uw6zigCL8V7DRiHHzQNc0CbmHba2OwDqSfscHPdO55j3k=
X-Gm-Gg: ASbGnctl2QFd66zT4//q40Sg1SZZfQ9LGLUAituo2jXtvSFYkeIuwMeo4yu4ld3VxQR
	NAznRNxPBHoG7B3GcLRvQqmGgDqc5XzvU/OzzuoXO8v2fk7aBtVbKXNI0bmCeGLUJlFOEPv8con
	X5jH9qnu3zS4qtcSNysEjzZidjTWC3RfN+alv9N+1FSTi/8R6+ueTsOC/Ggh4YYoPPdA0hgO7o/
	qiT4GmcyeEoJX3GlsYT7L3bKrYAKrkoQlD/Zz4UAhDOsV8BxXq7DZzHZVa2BqcfuG8n3JdJHEfs
	rerUfNCfGF+wQkIkhw7fK6ZvdOtiogui+qd/Tn1Y9dihCiIyF3GJkVlr1P6uefWl5/dbeGYVq5Z
	BVwYIQtzxGswPheP9f91bQKyXgcCC2p8r0jQ=
X-Google-Smtp-Source: AGHT+IGSygVVmSm5n3EgZNMIwaZyXbPz0Nj8WZ9kD73xvGvXHdn1/Wg+KQzUhRUK0zu47255GCIESQ==
X-Received: by 2002:a05:6602:6a8a:b0:85b:59f3:2ebe with SMTP id ca18e2360f4ac-85e2cb1d274mr400667339f.11.1742570316462;
        Fri, 21 Mar 2025 08:18:36 -0700 (PDT)
Received: from zoltan.localdomain (c-73-228-159-35.hsd1.mn.comcast.net. [73.228.159.35])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f2cbdd0a21sm475553173.41.2025.03.21.08.18.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 08:18:36 -0700 (PDT)
From: Alex Elder <elder@riscstar.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	p.zabel@pengutronix.de,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	dlan@gentoo.org
Cc: heylenay@4d2.org,
	guodong@riscstar.com,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	spacemit@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND 1/7] dt-bindings: soc: spacemit: define spacemit,k1-ccu resets
Date: Fri, 21 Mar 2025 10:18:24 -0500
Message-ID: <20250321151831.623575-2-elder@riscstar.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250321151831.623575-1-elder@riscstar.com>
References: <20250321151831.623575-1-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are additional SpacemiT syscon CCUs whose registers control both
clocks and resets:  RCPU, RCPU2, and APBC2. Unlike those defined
previously, these will initially support only resets.  They do not
incorporate power domain functionality.

Define the index values for resets associated with all SpacemiT K1
syscon nodes, including those with clocks already defined, as well as
the new ones (without clocks).

Signed-off-by: Alex Elder <elder@riscstar.com>
---
 .../soc/spacemit/spacemit,k1-syscon.yaml      |  13 +-
 include/dt-bindings/clock/spacemit,k1-ccu.h   | 134 ++++++++++++++++++
 2 files changed, 143 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/soc/spacemit/spacemit,k1-syscon.yaml b/Documentation/devicetree/bindings/soc/spacemit/spacemit,k1-syscon.yaml
index 07a6728e6f864..333c28e075b6c 100644
--- a/Documentation/devicetree/bindings/soc/spacemit/spacemit,k1-syscon.yaml
+++ b/Documentation/devicetree/bindings/soc/spacemit/spacemit,k1-syscon.yaml
@@ -19,6 +19,9 @@ properties:
       - spacemit,k1-syscon-apbc
       - spacemit,k1-syscon-apmu
       - spacemit,k1-syscon-mpmu
+      - spacemit,k1-syscon-rcpu
+      - spacemit,k1-syscon-rcpu2
+      - spacemit,k1-syscon-apbc2
 
   reg:
     maxItems: 1
@@ -57,13 +60,15 @@ allOf:
       properties:
         compatible:
           contains:
-            const: spacemit,k1-syscon-apbc
+            enum:
+              - spacemit,k1-syscon-apmu
+              - spacemit,k1-syscon-mpmu
     then:
-      properties:
-        "#power-domain-cells": false
-    else:
       required:
         - "#power-domain-cells"
+    else:
+      properties:
+        "#power-domain-cells": false
 
 additionalProperties: false
 
diff --git a/include/dt-bindings/clock/spacemit,k1-ccu.h b/include/dt-bindings/clock/spacemit,k1-ccu.h
index 4a0c7163257e3..a1e1b1fe714ce 100644
--- a/include/dt-bindings/clock/spacemit,k1-ccu.h
+++ b/include/dt-bindings/clock/spacemit,k1-ccu.h
@@ -78,6 +78,9 @@
 #define CLK_APB			31
 #define CLK_WDT_BUS		32
 
+/*	MPMU resets	*/
+#define RST_WDT			0
+
 /*	APBC clocks	*/
 #define CLK_UART0		0
 #define CLK_UART2		1
@@ -109,6 +112,7 @@
 #define CLK_PWM17		27
 #define CLK_PWM18		28
 #define CLK_PWM19		29
+
 #define CLK_SSP3		30
 #define CLK_RTC			31
 #define CLK_TWSI0		32
@@ -180,6 +184,60 @@
 #define CLK_TSEN_BUS		98
 #define CLK_IPC_AP2AUD_BUS	99
 
+/*	APBC resets	*/
+
+#define RST_UART0		0
+#define RST_UART2		1
+#define RST_UART3		2
+#define RST_UART4		3
+#define RST_UART5		4
+#define RST_UART6		5
+#define RST_UART7		6
+#define RST_UART8		7
+#define RST_UART9		8
+#define RST_GPIO		9
+#define RST_PWM0		10
+#define RST_PWM1		11
+#define RST_PWM2		12
+#define RST_PWM3		13
+#define RST_PWM4		14
+#define RST_PWM5		15
+#define RST_PWM6		16
+#define RST_PWM7		17
+#define RST_PWM8		18
+#define RST_PWM9		19
+#define RST_PWM10		20
+#define RST_PWM11		21
+#define RST_PWM12		22
+#define RST_PWM13		23
+#define RST_PWM14		24
+#define RST_PWM15		25
+#define RST_PWM16		26
+#define RST_PWM17		27
+#define RST_PWM18		28
+#define RST_PWM19		29
+#define RST_SSP3		30
+#define RST_RTC			31
+#define RST_TWSI0		32
+#define RST_TWSI1		33
+#define RST_TWSI2		34
+#define RST_TWSI4		35
+#define RST_TWSI5		36
+#define RST_TWSI6		37
+#define RST_TWSI7		38
+#define RST_TWSI8		39
+#define RST_TIMERS1		40
+#define RST_TIMERS2		41
+#define RST_AIB			42
+#define RST_ONEWIRE		43
+#define RST_SSPA0		44
+#define RST_SSPA1		45
+#define RST_DRO			46
+#define RST_IR			47
+#define RST_TSEN		48
+#define RST_IPC_AP2AUD		49
+#define RST_CAN0		50
+
 /*	APMU clocks	*/
 #define CLK_CCI550		0
 #define CLK_CPU_C0_HI		1
@@ -244,4 +302,80 @@
 #define CLK_V2D			60
 #define CLK_EMMC_BUS		61
 
+/*	APMU resets	*/
+
+#define RST_CCIC_4X		0
+#define RST_CCIC1_PHY		1
+#define RST_SDH_AXI		2
+#define RST_SDH0		3
+#define RST_SDH1		4
+#define RST_SDH2		5
+#define RST_USBP1_AXI		6
+#define RST_USB_AXI		7
+#define RST_USB3_0		8
+#define RST_QSPI		9
+#define RST_QSPI_BUS		10
+#define RST_DMA			11
+#define RST_AES			12
+#define RST_VPU			13
+#define RST_GPU			14
+#define RST_EMMC		15
+#define RST_EMMC_X		16
+#define RST_AUDIO		17
+#define RST_HDMI		18
+#define RST_PCIE0		19
+#define RST_PCIE1		20
+#define RST_PCIE2		21
+#define RST_EMAC0		22
+#define RST_EMAC1		23
+#define RST_JPG			24
+#define RST_CCIC2PHY		25
+#define RST_CCIC3PHY		26
+#define RST_CSI			27
+#define RST_ISP_CPP		28
+#define RST_ISP_BUS		29
+#define RST_ISP			30
+#define RST_ISP_CI		31
+#define RST_DPU_MCLK		32
+#define RST_DPU_ESC		33
+#define RST_DPU_HCLK		34
+#define RST_DPU_SPIBUS		35
+#define RST_DPU_SPI_HBUS	36
+#define RST_V2D			37
+#define RST_MIPI		38
+#define RST_MC			39
+
+/*	RCPU resets	*/
+
+#define RST_RCPU_SSP0		0
+#define RST_RCPU_I2C0		1
+#define RST_RCPU_UART1		2
+#define RST_RCPU_IR		3
+#define RST_RCPU_CAN		4
+#define RST_RCPU_UART0		5
+#define RST_RCPU_HDMI_AUDIO	6
+
+/*	RCPU2 resets	*/
+
+#define RST_RCPU2_PWM0		0
+#define RST_RCPU2_PWM1		1
+#define RST_RCPU2_PWM2		2
+#define RST_RCPU2_PWM3		3
+#define RST_RCPU2_PWM4		4
+#define RST_RCPU2_PWM5		5
+#define RST_RCPU2_PWM6		6
+#define RST_RCPU2_PWM7		7
+#define RST_RCPU2_PWM8		8
+#define RST_RCPU2_PWM9		9
+
+/*	APBC2 resets	*/
+
+#define RST_APBC2_UART1		0
+#define RST_APBC2_SSP2		1
+#define RST_APBC2_TWSI3		2
+#define RST_APBC2_RTC		3
+#define RST_APBC2_TIMERS0	4
+#define RST_APBC2_KPC		5
+#define RST_APBC2_GPIO		6
+
 #endif /* _DT_BINDINGS_SPACEMIT_CCU_H_ */
-- 
2.43.0


