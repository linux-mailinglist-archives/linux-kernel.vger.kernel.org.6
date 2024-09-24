Return-Path: <linux-kernel+bounces-336576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DF446983CA2
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 08:05:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54B6CB21E47
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 06:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 013891B85F1;
	Tue, 24 Sep 2024 06:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NyMufHwO"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB3226A33F;
	Tue, 24 Sep 2024 06:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727157912; cv=none; b=XMuxwhat7gR8ZvdQxogyLxfWdDWnQNVm0tP9mtk5ePNomRK/7Ej1gcu1WBm2AxOKuXs8PHKG0a//q7FqZUuUwUR689s+/IIXEsu/RnJRr9A+oDcu+ddpqdiAgqyTWKvqL4ypqYKd1QZxLsWGp0u2wjr9a4C3tFmuY0Ul+JuHi8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727157912; c=relaxed/simple;
	bh=YeUX0ZgsBkSD9fZFIZk9WqH84ss35yIi50Nvd7SNfQI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YkKdWKfdbgxZrzPWFFH2tCT0Aycm3euIyfn3p2/KA0kryHLBUhx7xuxhguyjCpNbMK631Z01uUFtf8fZYed2zui9qmldswJU7LaCBISB0ogiFzbR+s+LCr1FeKnMGt2L2aAfUlZswJLVTQWiEic0YQIMh51JTSDdEmE8vzAVt4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NyMufHwO; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2d88c0f8e79so4092383a91.3;
        Mon, 23 Sep 2024 23:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727157910; x=1727762710; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mz3nKts0utmgs04ieZ/p598fLVtnPylqw2MjQFSirMk=;
        b=NyMufHwOWy4LVHAVSiuM47QqDrOa5UW0GGG2FcW9jQFqOl9KxVrCpgFiRBfVR8DyAo
         LM/H/kyBsax3bkxB7eHki8X5M4DYeON8dlJvfBpsUpmXUw3SV05cPXT3Pe754JX31IKT
         OTXe51m/HPS3xo0wZJgKFuQOJzJ49FoESQjd6m9PWzd/8+Zs8JVGnfJvcPBS7yKMVAZd
         H69DNkERNho3rCJN7lr9YokC1eSVIQKDSF9whTCyMswOrcz1IhLAQ+XYXvbLSkR9oAJu
         K4nFwe2QGGQQFEpH/Dzvv1YWNCMfU/2Qnca7/eRXzH88xNCBoffQVYX8RYOCWU+5f9C1
         9xSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727157910; x=1727762710;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mz3nKts0utmgs04ieZ/p598fLVtnPylqw2MjQFSirMk=;
        b=ZEAJOFJxORCasD3IPSey17d6XyHWU6wYeoPih8wqMDoI0DlOkG+pOBT/XNwNEpSG2m
         6UOXB/YIPrllS/mdzH1Q5H2dwrd0RU9LTLccy7HMMiPM8jPCUnoqBiptGWHWgRxUf4r5
         0uIBC+ZWUu6MfTRzgI/fFq9/ZdAPXQk9oM7YxtnYHLzttfbIigw52Tt7rirZaaXeZEOt
         kjWAKdu2XxirMOyKgtK8PBPuotJ/g0fyeY+aX1BabgplUCxyAO4TpCqBd+8gjlE3VpWx
         Wlg9Ny+gY8WCINVCinuhK9aUhAzhaewK65o1rXxkaIQ6kXClul7F2vSmw4TxWHkPHWxj
         D9Qw==
X-Forwarded-Encrypted: i=1; AJvYcCWkYKfuYSegszaf64MSpuABHHLs2/r2bhPCsTtwqJZrR5+BwrZzZF0xT5kjH2N3CVhEF3CFYGkJhriv7rM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXSIfVpGOuM1gV6GRCkN8XC+Sy3+pILO0lUIDbSt4e7hsCJYHS
	ypeS23k4dhQa5WbIGWnunksb16C6DbiOg8z7OGeQfoplXMINQLV7
X-Google-Smtp-Source: AGHT+IHEs5JTbd4Uy1AB7v5TYcvGJHt0D51ZNLLFLBKASZdOZKuuLvZv6oT6qTCDrvsfz5Vq/NGhBw==
X-Received: by 2002:a17:90a:fe8b:b0:2cf:f3e9:d5c8 with SMTP id 98e67ed59e1d1-2dd80c9662dmr17655048a91.31.1727157909895;
        Mon, 23 Sep 2024 23:05:09 -0700 (PDT)
Received: from localhost ([188.253.115.253])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e05904a314sm632095a91.54.2024.09.23.23.05.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 23:05:09 -0700 (PDT)
From: Junhui Liu <liujh2818@gmail.com>
X-Google-Original-From: Junhui Liu <liujh2818@outlook.com>
Date: Tue, 24 Sep 2024 14:00:40 +0800
Subject: [PATCH 1/2] dt-bindings: reset: Add support for canaan,k230-rst
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240924-k230-reset-v1-1-d0cdc11989eb@outlook.com>
References: <20240924-k230-reset-v1-0-d0cdc11989eb@outlook.com>
In-Reply-To: <20240924-k230-reset-v1-0-d0cdc11989eb@outlook.com>
To: Philipp Zabel <p.zabel@pengutronix.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Junhui Liu <liujh2818@outlook.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-riscv@lists.infradead.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727157904; l=4188;
 i=liujh2818@outlook.com; s=20240831; h=from:subject:message-id;
 bh=7fBWxyB98XXovcKl78F8c4WOs4siCf6giYXUMRNF5yk=;
 b=RkZHstqExAXr2yLqjQiqAiWnrpe7I3Nnyar3ZPDYw2XZRAGTcqJluSjV83DbzF0RZ9jYbjkIi
 durMfCI1CCNB5tUlv/+aJPseRabHn0bhBnbeoJz4D0W/MRzsFrpJhTz
X-Developer-Key: i=liujh2818@outlook.com; a=ed25519;
 pk=UPJ4WEhX1Oe+1ABSe4UlisQyfljdECO+XeTLv1VxTuY=

From: Junhui Liu <liujh2818@outlook.com>

Introduces a reset controller driver for the Kendryte K230 SoC,
resposible for managing the reset functionality of the CPUs and
various sub-modules.

Signed-off-by: Junhui Liu <liujh2818@outlook.com>
---
 .../devicetree/bindings/reset/canaan,k230-rst.yaml | 39 ++++++++++
 include/dt-bindings/reset/canaan,k230-rst.h        | 90 ++++++++++++++++++++++
 2 files changed, 129 insertions(+)

diff --git a/Documentation/devicetree/bindings/reset/canaan,k230-rst.yaml b/Documentation/devicetree/bindings/reset/canaan,k230-rst.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..ede02dd01ee53a6e20e3387dec51a34e685aa0e1
--- /dev/null
+++ b/Documentation/devicetree/bindings/reset/canaan,k230-rst.yaml
@@ -0,0 +1,39 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/reset/canaan,k230-rst.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Canaan Kendryte K230 Reset Controller
+
+maintainers:
+  - Junhui Liu <liujh2818@outlook.com>
+
+description:
+  The Canaan Kendryte K230 reset controller is part of the SoC's system
+  controller and controls the reset registers for CPUs and various peripherals.
+
+properties:
+  compatible:
+    const: canaan,k230-rst
+
+  reg:
+    maxItems: 1
+
+  '#reset-cells':
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - '#reset-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    reset-controller@91101000 {
+      compatible = "canaan,k230-rst";
+      reg = <0x91101000 0x1000>;
+      #reset-cells = <1>;
+    };
diff --git a/include/dt-bindings/reset/canaan,k230-rst.h b/include/dt-bindings/reset/canaan,k230-rst.h
new file mode 100644
index 0000000000000000000000000000000000000000..5960705636fbab70859624437862bf06d7fb65cd
--- /dev/null
+++ b/include/dt-bindings/reset/canaan,k230-rst.h
@@ -0,0 +1,90 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2023-2024 Canaan Bright Sight Co., Ltd
+ * Copyright (C) 2024 Junhui Liu <liujh2818@outlook.com>
+ */
+#ifndef _DT_BINDINGS_CANAAN_K230_RST_H_
+#define _DT_BINDINGS_CANAAN_K230_RST_H_
+
+#define RST_CPU0		0
+#define RST_CPU1		1
+#define RST_CPU0_FLUSH		2
+#define RST_CPU1_FLUSH		3
+#define RST_AI			4
+#define RST_VPU			5
+#define RST_HS			6
+#define RST_HS_AHB		7
+#define RST_SDIO0		8
+#define RST_SDIO1		9
+#define RST_SDIO_AXI		10
+#define RST_USB0		11
+#define RST_USB1		12
+#define RST_USB0_AHB		13
+#define RST_USB1_AHB		14
+#define RST_SPI0		15
+#define RST_SPI1		16
+#define RST_SPI2		17
+#define RST_SEC			18
+#define RST_PDMA		19
+#define RST_SDMA		20
+#define RST_DECOMPRESS		21
+#define RST_SRAM		22
+#define RST_SHRM_AXIM		23
+#define RST_SHRM_AXIS		24
+#define RST_NONAI2D		25
+#define RST_MCTL		26
+#define RST_ISP			27
+#define RST_ISP_DW		28
+#define RST_DPU			29
+#define RST_DISP		30
+#define RST_GPU			31
+#define RST_AUDIO		32
+#define RST_TIMER0		33
+#define RST_TIMER1		34
+#define RST_TIMER2		35
+#define RST_TIMER3		36
+#define RST_TIMER4		37
+#define RST_TIMER5		38
+#define RST_TIMER_APB		39
+#define RST_HDI			40
+#define RST_WDT0		41
+#define RST_WDT1		42
+#define RST_WDT0_APB		43
+#define RST_WDT1_APB		44
+#define RST_TS_APB		45
+#define RST_MAILBOX		46
+#define RST_STC			47
+#define RST_PMU			48
+#define RST_LS_APB		49
+#define RST_UART0		50
+#define RST_UART1		51
+#define RST_UART2		52
+#define RST_UART3		53
+#define RST_UART4		54
+#define RST_I2C0		55
+#define RST_I2C1		56
+#define RST_I2C2		57
+#define RST_I2C3		58
+#define RST_I2C4		59
+#define RST_JAMLINK0_APB	60
+#define RST_JAMLINK1_APB	61
+#define RST_JAMLINK2_APB	62
+#define RST_JAMLINK3_APB	63
+#define RST_CODEC_APB		64
+#define RST_GPIO_DB		65
+#define RST_GPIO_APB		66
+#define RST_ADC			67
+#define RST_ADC_APB		68
+#define RST_PWM_APB		69
+#define RST_SHRM_APB		70
+#define RST_CSI0		71
+#define RST_CSI1		72
+#define RST_CSI2		73
+#define RST_CSI_DPHY		74
+#define RST_ISP_AHB		75
+#define RST_M0			76
+#define RST_M1			77
+#define RST_M2			78
+#define RST_SPI2AXI		79
+
+#endif

-- 
2.46.1


