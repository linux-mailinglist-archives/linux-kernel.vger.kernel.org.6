Return-Path: <linux-kernel+bounces-324262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43A3A974A63
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 08:27:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 950721F263D2
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 06:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0B8880604;
	Wed, 11 Sep 2024 06:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="G0gnMDAF"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6907FBA2
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 06:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726035968; cv=none; b=smEiUjhyPk0ZjzV29Z4D/1k+I1nrV5qNZzyZJQKT006RNqyYePizNkckK/fmiQXM/8RNAwWWgdv3VdDDcRJLS1qLA+7UUFqZRRP8Ctqj9hduVYkKHLdWW/KSK+RQcy5o8XlOjKRLeX7epLUn8fJL7knOOcfD5piRT9FCCVjkezA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726035968; c=relaxed/simple;
	bh=ctvgdKfWlqX37F8bNJDrqvyIa01iPe2Bj6lA/bw6rIE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jrbeP/+kOC/QZT9Zq9JsQx/I3PdBGysUAhHwbvOAuWfVmgT+DCQU20ds2EYXmA4OSdz1gwaaYcZ6B2aWfnMKPoN3wB3D2en5mzbwjh3AgcaMYqLfRoKdx4vNVcqjCWhTH7qy0g61wPjUWaj0fB0AQdkSyJrtSRpfcBN2t2cS8Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=G0gnMDAF; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a8a7929fd64so845176666b.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 23:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1726035964; x=1726640764; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TS38gRRfpfKYnJN2adE5o9tQ7YB9jk+C3AuiCfmnxxc=;
        b=G0gnMDAFN6rhhHvU0kntnJgeDa2S7U01Q9iJfZ3OrVCUAFPPaslgLuUiDzI5aHAyAn
         F2oo6k1ZOZc8PZ4TjCzFeT89eeNAnXB/E1aZ7e2LYk3h0/lUJZq5LNvP7T0xDg2S8JlP
         4r1QzUhA+GJIrX3qPB5Kt0zXkn4UYUgqjT7aNPpcSFFyKpNKIXkSF7bZwkE+TqSoM7mH
         21qcOz9/Npu6pP+0cSX5DRWlC79ZKtKCEJqBGyxOktX3bGTOS72M4aRU70ayafWp1ckB
         rP4efIfy2LFuizEtCbtqssah7VhxoBu0MalwGUskLE34K35+rw9vTVEYMsNx+s3UU93s
         IpZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726035964; x=1726640764;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TS38gRRfpfKYnJN2adE5o9tQ7YB9jk+C3AuiCfmnxxc=;
        b=McsFa/274icGx6Tdv3qvcnHWZ+5FuwQZSgK0I3xM03n8MBuqE9hW8W1Q+x35Q7wUI7
         EdPG4hRbm5m2CaCipuVpe4E4SxujqgVNdiNH2Zqyg/tH/C59FLRU6mC9xpBwfCldKU2b
         xtgARy5fY8tYXIg0zPcBjsf3jy8uMdVWTAESud/cKjj39+Xk23z+aEYkWBOY051ddxMN
         zDV1hRfXYP73Iyf8k6uVX7HPjO92Jl3/qMyoNl0LJPUO5BnPiqUrD7N3+azOsFfBR8w1
         +4cUK0nD64k5DSTPfqPy5QRHV8FbBT2GfMhb4G4S86yPIJgDOu7YFMa9lC4GA6tfTDCy
         vZWw==
X-Forwarded-Encrypted: i=1; AJvYcCVa9uz1cre2ogua+7pIpW2cK2ayfWNzW/lIZwaCcIS6QdFZuOf7OYKn3Y774fQIu1oKqtlS6Wk7f4BupB4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0UQ1gl8pO0ShX3xfheq3i1TMN0txc+M0RfPEx9SMy8agWJmCl
	69jMIIN+O7nUjQC/oAE3xjKTaOpHT7HbxenpyIfjj44mc2ADHf/evaWJ+5jEIeE=
X-Google-Smtp-Source: AGHT+IEglpLGt1uQfLgBQXEuVmi2OgNyWUtaCqWmbNWp5mcRvfSmXt5/NOojbUUXI3mq8fY/Dij/SA==
X-Received: by 2002:a17:907:97ce:b0:a8a:9054:8392 with SMTP id a640c23a62f3a-a8ffa8651d4mr244911666b.0.1726035963876;
        Tue, 10 Sep 2024 23:26:03 -0700 (PDT)
Received: from fedora.sec.9e.network (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25a43365sm575545366b.94.2024.09.10.23.26.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 23:26:03 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de,
	linux-kernel@vger.kernel.org
Cc: Simon Glass <sjg@chromium.org>,
	Patrick Rudolph <patrick.rudolph@9elements.com>,
	Matthias Brugger <mbrugger@suse.com>,
	Peter Robinson <pbrobinson@gmail.com>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 24/30] arm: mach-bcm283x: Bring in some header files from tianocore
Date: Wed, 11 Sep 2024 08:24:14 +0200
Message-ID: <20240911062511.494855-25-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240911062511.494855-1-patrick.rudolph@9elements.com>
References: <20240911062511.494855-1-patrick.rudolph@9elements.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Simon Glass <sjg@chromium.org>

These header files presumably duplicate things already in the U-Boot
devicetree. For now, bring them in to get the ASL code and ACPI table
code to compile.

Signed-off-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
Cc: Matthias Brugger <mbrugger@suse.com>
Cc: Peter Robinson <pbrobinson@gmail.com>
Cc: Tom Rini <trini@konsulko.com>
---
 .../mach-bcm283x/include/mach/acpi/bcm2711.h  | 152 ++++++++++++++++++
 .../mach-bcm283x/include/mach/acpi/bcm2836.h  | 127 +++++++++++++++
 .../include/mach/acpi/bcm2836_gpio.h          |  19 +++
 .../include/mach/acpi/bcm2836_gpu.h           |  47 ++++++
 .../include/mach/acpi/bcm2836_pwm.h           |  33 ++++
 .../include/mach/acpi/bcm2836_sdhost.h        |  18 +++
 .../include/mach/acpi/bcm2836_sdio.h          |  21 +++
 drivers/pci/pcie_brcmstb.c                    | 101 ++----------
 8 files changed, 427 insertions(+), 91 deletions(-)
 create mode 100644 arch/arm/mach-bcm283x/include/mach/acpi/bcm2711.h
 create mode 100644 arch/arm/mach-bcm283x/include/mach/acpi/bcm2836.h
 create mode 100644 arch/arm/mach-bcm283x/include/mach/acpi/bcm2836_gpio.h
 create mode 100644 arch/arm/mach-bcm283x/include/mach/acpi/bcm2836_gpu.h
 create mode 100644 arch/arm/mach-bcm283x/include/mach/acpi/bcm2836_pwm.h
 create mode 100644 arch/arm/mach-bcm283x/include/mach/acpi/bcm2836_sdhost.h
 create mode 100644 arch/arm/mach-bcm283x/include/mach/acpi/bcm2836_sdio.h

diff --git a/arch/arm/mach-bcm283x/include/mach/acpi/bcm2711.h b/arch/arm/mach-bcm283x/include/mach/acpi/bcm2711.h
new file mode 100644
index 0000000000..a86875b183
--- /dev/null
+++ b/arch/arm/mach-bcm283x/include/mach/acpi/bcm2711.h
@@ -0,0 +1,152 @@
+/* SPDX-License-Identifier: BSD-2-Clause-Patent */
+/**
+ *
+ *  Copyright (c) 2019, Jeremy Linton
+ *  Copyright (c) 2019, Pete Batard <pete@akeo.ie>.
+ *
+ **/
+
+#ifndef BCM2711_H__
+#define BCM2711_H__
+
+#define BCM2711_SOC_REGISTERS              0xfc000000
+#define BCM2711_SOC_REGISTER_LENGTH        0x02000000
+
+#define BCM2711_ARM_LOCAL_REGISTERS        0xfe000000
+#define BCM2711_ARM_LOCAL_REGISTER_LENGTH  0x02000000
+
+/* arm local addresses */
+#define BCM2711_ARMC_OFFSET                0x0000b000
+#define BCM2711_ARMC_BASE_ADDRESS          (BCM2711_ARM_LOCAL_REGISTERS + BCM2711_ARMC_OFFSET)
+#define BCM2711_ARMC_LENGTH                0x00000400
+
+#define BCM2711_ARM_LOCAL_OFFSET           0x01800000
+#define BCM2711_ARM_LOCAL_BASE_ADDRESS     (BCM2711_ARM_LOCAL_REGISTERS + BCM2711_ARM_LOCAL_OFFSET)
+#define BCM2711_ARM_LOCAL_LENGTH           0x00000080
+
+#define BCM2711_GIC400_OFFSET              0x01840000
+#define BCM2711_GIC400_BASE_ADDRESS        (BCM2711_ARM_LOCAL_REGISTERS + BCM2711_GIC400_OFFSET)
+#define BCM2711_GIC400_LENGTH              0x00008000
+
+/* Generic PCI addresses */
+#define PCIE_TOP_OF_MEM_WIN                0xf8000000
+#define PCIE_CPU_MMIO_WINDOW               0x600000000
+#define PCIE_BRIDGE_MMIO_LEN               0x3ffffff
+
+/* PCI root bridge control registers location */
+#define PCIE_REG_BASE                      0xfd500000
+#define PCIE_REG_LIMIT                     0x9310
+
+/* PCI root bridge control registers */
+#define BRCM_PCIE_CAP_REGS                        0x00ac
+#define PCIE_RC_CFG_VENDOR_VENDOR_SPECIFIC_REG1   0x0188
+#define  VENDOR_SPECIFIC_REG1_LITTLE_ENDIAN          0x0
+#define PCIE_RC_CFG_PRIV1_ID_VAL3                 0x043c
+#define PCIE_RC_CFG_PRIV1_LINK_CAPABILITY         0x04dc
+#define  LINK_CAPABILITY_ASPM_SUPPORT_MASK         0xc00
+
+#define PCIE_RC_DL_MDIO_ADDR                      0x1100
+#define PCIE_RC_DL_MDIO_WR_DATA                   0x1104
+#define PCIE_RC_DL_MDIO_RD_DATA                   0x1108
+
+#define PCIE_MISC_MISC_CTRL                       0x4008
+#define  MISC_CTRL_SCB_ACCESS_EN_MASK             0x1000
+#define  MISC_CTRL_CFG_READ_UR_MODE_MASK          0x2000
+#define  MISC_CTRL_MAX_BURST_SIZE_MASK            0x300000
+#define  MISC_CTRL_MAX_BURST_SIZE_128             0x0
+#define  MISC_CTRL_SCB0_SIZE_MASK                 0xf8000000
+
+#define PCIE_MISC_CPU_2_PCIE_MEM_WIN0_LO          0x400c
+#define PCIE_MISC_CPU_2_PCIE_MEM_WIN0_HI          0x4010
+#define PCIE_MEM_WIN0_LO(win)	\
+		PCIE_MISC_CPU_2_PCIE_MEM_WIN0_LO + ((win) * 4)
+
+#define PCIE_MEM_WIN0_HI(win)	\
+		PCIE_MISC_CPU_2_PCIE_MEM_WIN0_HI + ((win) * 4)
+#define PCIE_MISC_RC_BAR1_CONFIG_LO               0x402c
+#define  RC_BAR1_CONFIG_LO_SIZE_MASK                0x1f
+#define PCIE_MISC_RC_BAR2_CONFIG_LO               0x4034
+#define  RC_BAR2_CONFIG_LO_SIZE_MASK                0x1f
+#define PCIE_MISC_RC_BAR2_CONFIG_HI               0x4038
+#define PCIE_MISC_RC_BAR3_CONFIG_LO               0x403c
+#define  RC_BAR3_CONFIG_LO_SIZE_MASK                0x1f
+#define PCIE_MISC_PCIE_STATUS                     0x4068
+#define  STATUS_PCIE_PORT_MASK                      0x80
+#define  STATUS_PCIE_PORT_SHIFT                        7
+#define  STATUS_PCIE_DL_ACTIVE_MASK                 0x20
+#define  STATUS_PCIE_DL_ACTIVE_SHIFT                   5
+#define  STATUS_PCIE_PHYLINKUP_MASK                 0x10
+#define  STATUS_PCIE_PHYLINKUP_SHIFT                   4
+#define PCIE_MISC_REVISION                        0x406c
+#define PCIE_MISC_CPU_2_PCIE_MEM_WIN0_BASE_LIMIT  0x4070
+#define  MEM_WIN0_BASE_LIMIT_LIMIT_MASK           0xfff00000
+#define  MEM_WIN0_BASE_LIMIT_BASE_MASK            0xfff0
+#define  MEM_WIN0_BASE_LIMIT_BASE_HI_SHIFT        12
+#define PCIE_MEM_WIN0_BASE_LIMIT(win)	\
+	 PCIE_MISC_CPU_2_PCIE_MEM_WIN0_BASE_LIMIT + ((win) * 4)
+#define PCIE_MISC_CPU_2_PCIE_MEM_WIN0_BASE_HI     0x4080
+#define  MEM_WIN0_BASE_HI_BASE_MASK               0xff
+#define PCIE_MEM_WIN0_BASE_HI(win)	\
+	 PCIE_MISC_CPU_2_PCIE_MEM_WIN0_BASE_HI + ((win) * 8)
+#define PCIE_MISC_CPU_2_PCIE_MEM_WIN0_LIMIT_HI    0x4084
+#define  PCIE_MEM_WIN0_LIMIT_HI_LIMIT_MASK        0xff
+#define PCIE_MEM_WIN0_LIMIT_HI(win)	\
+	 PCIE_MISC_CPU_2_PCIE_MEM_WIN0_LIMIT_HI + ((win) * 8)
+
+#define PCIE_MISC_HARD_PCIE_HARD_DEBUG            0x4204
+#define  PCIE_HARD_DEBUG_SERDES_IDDQ_MASK         0x08000000
+
+#define PCIE_INTR2_CPU_STATUS                 0x4300
+#define PCIE_INTR2_CPU_SET                    0x4304
+#define PCIE_INTR2_CPU_CLR                    0x4308
+#define PCIE_INTR2_CPU_MASK_STATUS            0x430c
+#define PCIE_INTR2_CPU_MASK_SET               0x4310
+#define PCIE_INTR2_CPU_MASK_CLR               0x4314
+
+#define PCIE_MSI_INTR2_CLR                    0x4508
+#define PCIE_MSI_INTR2_MASK_SET               0x4510
+
+#define PCIE_RGR1_SW_INIT_1                   0x9210
+#define PCIE_EXT_CFG_INDEX                    0x9000
+/* A small window pointing at the ECAM of the device selected by CFG_INDEX */
+#define PCIE_EXT_CFG_DATA                     0x8000
+
+#define PCIE_RC_CFG_VENDOR_VENDOR_SPECIFIC_REG1_ENDIAN_MODE_BAR2_MASK 0xc
+#define PCIE_RC_CFG_PRIV1_ID_VAL3_CLASS_CODE_MASK                     0xffffff
+
+#define PCIE_MISC_MISC_CTRL_SCB_ACCESS_EN_MASK                  0x1000
+#define PCIE_MISC_MISC_CTRL_CFG_READ_UR_MODE_MASK               0x2000
+#define PCIE_MISC_MISC_CTRL_MAX_BURST_SIZE_MASK                 0x300000
+#define PCIE_MISC_MISC_CTRL_SCB0_SIZE_MASK                      0xf8000000
+#define PCIE_MISC_MISC_CTRL_SCB1_SIZE_MASK                      0x7c00000
+#define PCIE_MISC_MISC_CTRL_SCB2_SIZE_MASK                      0x1f
+#define PCIE_MISC_RC_BAR2_CONFIG_LO_SIZE_MASK                   0x1f
+
+#define PCIE_RGR1_SW_INIT_1_INIT_MASK                           0x2
+#define PCIE_RGR1_SW_INIT_1_PERST_MASK                          0x1
+
+#define PCIE_MISC_HARD_PCIE_HARD_DEBUG_SERDES_IDDQ_MASK         0x08000000
+
+#define PCIE_MISC_HARD_PCIE_HARD_DEBUG_CLKREQ_DEBUG_ENABLE_MASK 0x2
+
+#define PCIE_MISC_CPU_2_PCIE_MEM_WIN0_BASE_LIMIT_LIMIT_MASK     0xfff00000
+#define PCIE_MISC_CPU_2_PCIE_MEM_WIN0_BASE_LIMIT_BASE_MASK      0xfff0
+#define PCIE_MISC_CPU_2_PCIE_MEM_WIN0_BASE_HI_BASE_MASK         0xff
+#define PCIE_MISC_CPU_2_PCIE_MEM_WIN0_LIMIT_HI_LIMIT_MASK       0xff
+#define PCIE_MISC_CPU_2_PCIE_MEM_WIN0_MASK_BITS                 0xc
+
+#define PCIE_MISC_REVISION_MAJMIN_MASK                          0xffff
+
+#define BURST_SIZE_128          0
+#define BURST_SIZE_256          1
+#define BURST_SIZE_512          2
+
+#define BCM2711_THERM_SENSOR_OFFSET           0x015d2200
+#define BCM2711_THERM_SENSOR_BASE_ADDRESS     (BCM2711_SOC_REGISTERS + BCM2711_THERM_SENSOR_OFFSET)
+#define BCM2711_THERM_SENSOR_LENGTH           0x00000008
+
+#define BCM2711_GENET_BASE_OFFSET             0x01580000
+#define BCM2711_GENET_BASE_ADDRESS            (BCM2711_SOC_REGISTERS + BCM2711_GENET_BASE_OFFSET)
+#define BCM2711_GENET_LENGTH                  0x10000
+
+#endif /* BCM2711_H__ */
diff --git a/arch/arm/mach-bcm283x/include/mach/acpi/bcm2836.h b/arch/arm/mach-bcm283x/include/mach/acpi/bcm2836.h
new file mode 100644
index 0000000000..64cec36a94
--- /dev/null
+++ b/arch/arm/mach-bcm283x/include/mach/acpi/bcm2836.h
@@ -0,0 +1,127 @@
+/* SPDX-License-Identifier: BSD-2-Clause-Patent */
+/**
+ *
+ *  Copyright (c) 2019, ARM Limited. All rights reserved.
+ *  Copyright (c) 2017, Andrei Warkentin <andrey.warkentin@gmail.com>
+ *  Copyright (c) 2016, Linaro Limited. All rights reserved.
+ *
+ **/
+
+#ifndef __BCM2836_H__
+#define __BCM2836_H__
+
+/*
+ * Both "core" and SoC perpherals (1M each).
+ */
+#define BCM2836_SOC_REGISTERS                 0xfe000000
+#define BCM2836_SOC_REGISTER_LENGTH           0x02000000
+
+/*
+ * Offset between the CPU's view and the VC's view of system memory.
+ */
+#define BCM2836_DMA_DEVICE_OFFSET             0xc0000000
+
+/* watchdog constants */
+#define BCM2836_WDOG_OFFSET                   0x00100000
+#define BCM2836_WDOG_BASE_ADDRESS             (BCM2836_SOC_REGISTERS + BCM2836_WDOG_OFFSET)
+#define BCM2836_WDOG_PASSWORD                 0x5a000000
+#define BCM2836_WDOG_RSTC_OFFSET              0x0000001c
+#define BCM2836_WDOG_WDOG_OFFSET              0x00000024
+#define BCM2836_WDOG_RSTC_WRCFG_MASK          0x00000030
+#define BCM2836_WDOG_RSTC_WRCFG_FULL_RESET    0x00000020
+
+/* clock manager constants */
+#define BCM2836_CM_OFFSET                     0x00101000
+#define BCM2836_CM_BASE                       (BCM2836_SOC_REGISTERS + BCM2836_CM_OFFSET)
+#define BCM2836_CM_GEN_CLOCK_CONTROL          0x0000
+#define BCM2836_CM_GEN_CLOCK_DIVISOR          0x0004
+#define BCM2836_CM_VPU_CLOCK_CONTROL          0x0008
+#define BCM2836_CM_VPU_CLOCK_DIVISOR          0x000c
+#define BCM2836_CM_SYSTEM_CLOCK_CONTROL       0x0010
+#define BCM2836_CM_SYSTEM_CLOCK_DIVISOR       0x0014
+#define BCM2836_CM_H264_CLOCK_CONTROL         0x0028
+#define BCM2836_CM_H264_CLOCK_DIVISOR         0x002c
+#define BCM2836_CM_PWM_CLOCK_CONTROL          0x00a0
+#define BCM2836_CM_PWM_CLOCK_DIVISOR          0x00a4
+#define BCM2836_CM_UART_CLOCK_CONTROL         0x00f0
+#define BCM2836_CM_UART_CLOCK_DIVISOR         0x00f4
+#define BCM2836_CM_SDC_CLOCK_CONTROL          0x01a8
+#define BCM2836_CM_SDC_CLOCK_DIVISOR          0x01ac
+#define BCM2836_CM_ARM_CLOCK_CONTROL          0x01b0
+#define BCM2836_CM_ARM_CLOCK_DIVISOR          0x01b4
+#define BCM2836_CM_EMMC_CLOCK_CONTROL         0x01c0
+#define BCM2836_CM_EMMC_CLOCK_DIVISOR         0x01c4
+
+/* mailbox interface constants */
+#define BCM2836_MBOX_OFFSET                   0x0000b880
+#define BCM2836_MBOX_BASE_ADDRESS             (BCM2836_SOC_REGISTERS + BCM2836_MBOX_OFFSET)
+#define BCM2836_MBOX_LENGTH                   0x00000024
+#define BCM2836_MBOX_READ_OFFSET              0x00000000
+#define BCM2836_MBOX_STATUS_OFFSET            0x00000018
+#define BCM2836_MBOX_CONFIG_OFFSET            0x0000001c
+#define BCM2836_MBOX_WRITE_OFFSET             0x00000020
+
+#define BCM2836_MBOX_STATUS_FULL              0x1f
+#define BCM2836_MBOX_STATUS_EMPTY             0x1e
+
+#define BCM2836_MBOX_NUM_CHANNELS             16
+
+/* interrupt controller constants */
+#define BCM2836_INTC_TIMER_CONTROL_OFFSET     0x00000040
+#define BCM2836_INTC_TIMER_PENDING_OFFSET     0x00000060
+
+/* usb constants */
+#define BCM2836_USB_OFFSET                    0x00980000
+#define BCM2836_USB_BASE_ADDRESS              (BCM2836_SOC_REGISTERS + BCM2836_USB_OFFSET)
+#define BCM2836_USB_LENGTH                    0x00010000
+
+/* serial based protocol constants */
+#define BCM2836_PL011_UART_OFFSET             0x00201000
+#define BCM2836_PL011_UART_BASE_ADDRESS       (BCM2836_SOC_REGISTERS + BCM2836_PL011_UART_OFFSET)
+#define BCM2836_PL011_UART_LENGTH             0x00001000
+
+#define BCM2836_MINI_UART_OFFSET              0x00215000
+#define BCM2836_MINI_UART_BASE_ADDRESS        (BCM2836_SOC_REGISTERS + BCM2836_MINI_UART_OFFSET)
+#define BCM2836_MINI_UART_LENGTH              0x00000070
+
+#define BCM2836_I2C0_OFFSET                   0x00205000
+#define BCM2836_I2C0_BASE_ADDRESS             (BCM2836_SOC_REGISTERS + BCM2836_I2C0_OFFSET)
+#define BCM2836_I2C0_LENGTH                   0x00000020
+
+#define BCM2836_I2C1_OFFSET                   0x00804000
+#define BCM2836_I2C1_BASE_ADDRESS             (BCM2836_SOC_REGISTERS + BCM2836_I2C1_OFFSET)
+#define BCM2836_I2C1_LENGTH                   0x00000020
+
+#define BCM2836_I2C2_OFFSET                   0x00805000
+#define BCM2836_I2C2_BASE_ADDRESS             (BCM2836_SOC_REGISTERS + BCM2836_I2C2_OFFSET)
+#define BCM2836_I2C2_LENGTH                   0x00000020
+
+#define BCM2836_SPI0_OFFSET                   0x00204000
+#define BCM2836_SPI0_BASE_ADDRESS             (BCM2836_SOC_REGISTERS + BCM2836_SPI0_OFFSET)
+#define BCM2836_SPI0_LENGTH                   0x00000020
+
+#define BCM2836_SPI1_OFFSET                   0x00215080
+#define BCM2836_SPI1_LENGTH                   0x00000040
+#define BCM2836_SPI1_BASE_ADDRESS             (BCM2836_SOC_REGISTERS + BCM2836_SPI1_OFFSET)
+
+#define BCM2836_SPI2_OFFSET                   0x002150C0
+#define BCM2836_SPI2_LENGTH                   0x00000040
+#define BCM2836_SPI2_BASE_ADDRESS             (BCM2836_SOC_REGISTERS + BCM2836_SPI2_OFFSET)
+
+#define BCM2836_SYSTEM_TIMER_OFFSET           0x00003000
+#define BCM2836_SYSTEM_TIMER_LENGTH           0x00000020
+#define BCM2836_SYSTEM_TIMER_ADDRESS          (BCM2836_SOC_REGISTERS + BCM2836_SYSTEM_TIMER_OFFSET)
+
+/* dma constants */
+#define BCM2836_DMA0_OFFSET                   0x00007000
+#define BCM2836_DMA0_BASE_ADDRESS             (BCM2836_SOC_REGISTERS + BCM2836_DMA0_OFFSET)
+
+#define BCM2836_DMA15_OFFSET                  0x00E05000
+#define BCM2836_DMA15_BASE_ADDRESS            (BCM2836_SOC_REGISTERS + BCM2836_DMA15_OFFSET)
+
+#define BCM2836_DMA_CTRL_OFFSET               0x00007FE0
+#define BCM2836_DMA_CTRL_BASE_ADDRESS         (BCM2836_SOC_REGISTERS + BCM2836_DMA_CTRL_OFFSET)
+
+#define BCM2836_DMA_CHANNEL_LENGTH            0x00000100
+
+#endif /*__BCM2836_H__ */
diff --git a/arch/arm/mach-bcm283x/include/mach/acpi/bcm2836_gpio.h b/arch/arm/mach-bcm283x/include/mach/acpi/bcm2836_gpio.h
new file mode 100644
index 0000000000..c5b858b412
--- /dev/null
+++ b/arch/arm/mach-bcm283x/include/mach/acpi/bcm2836_gpio.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: BSD-2-Clause-Patent */
+/**
+ *
+ *  Copyright (c) 2020, Pete Batard <pete@akeo.ie>
+ *  Copyright (c) 2018, Andrei Warkentin <andrey.warkentin@gmail.com>
+ *  Copyright (c) Microsoft Corporation. All rights reserved.
+ *
+ **/
+
+#include <asm/arch/acpi/bcm2836.h>
+
+#ifndef __BCM2836_GPIO_H__
+#define __BCM2836_GPIO_H__
+
+#define GPIO_OFFSET        0x00200000
+#define GPIO_BASE_ADDRESS  (BCM2836_SOC_REGISTERS + GPIO_OFFSET)
+#define GPIO_LENGTH        0x000000B4
+
+#endif /* __BCM2836_GPIO_H__ */
diff --git a/arch/arm/mach-bcm283x/include/mach/acpi/bcm2836_gpu.h b/arch/arm/mach-bcm283x/include/mach/acpi/bcm2836_gpu.h
new file mode 100644
index 0000000000..5857d7581a
--- /dev/null
+++ b/arch/arm/mach-bcm283x/include/mach/acpi/bcm2836_gpu.h
@@ -0,0 +1,47 @@
+/* SPDX-License-Identifier: BSD-2-Clause-Patent */
+/**
+ *
+ *  Copyright (c) 2020, Pete Batard <pete@akeo.ie>
+ *
+ **/
+
+#include <asm/arch/acpi/bcm2836.h>
+
+#ifndef __BCM2836_GPU_H__
+#define __BCM2836_GPU_H__
+
+/* VideoCore constants */
+
+#define BCM2836_VCHIQ_OFFSET                  0x0000B840
+#define BCM2836_VCHIQ_BASE_ADDRESS            (BCM2836_SOC_REGISTERS + BCM2836_VCHIQ_OFFSET)
+#define BCM2836_VCHIQ_LENGTH                  0x00000010
+
+#define BCM2836_V3D_BUS_OFFSET                0x00C00000
+#define BCM2836_V3D_BUS_BASE_ADDRESS          (BCM2836_SOC_REGISTERS + BCM2836_V3D_BUS_OFFSET)
+#define BCM2836_V3D_BUS_LENGTH                0x00001000
+
+#define BCM2836_HVS_OFFSET                    0x00400000
+#define BCM2836_HVS_BASE_ADDRESS              (BCM2836_SOC_REGISTERS + BCM2836_HVS_OFFSET)
+#define BCM2836_HVS_LENGTH                    0x00006000
+
+#define BCM2836_PV0_OFFSET                    0x00206000
+#define BCM2836_PV0_BASE_ADDRESS              (BCM2836_SOC_REGISTERS + BCM2836_PV0_OFFSET)
+#define BCM2836_PV0_LENGTH                    0x00000100
+
+#define BCM2836_PV1_OFFSET                    0x00207000
+#define BCM2836_PV1_BASE_ADDRESS              (BCM2836_SOC_REGISTERS + BCM2836_PV1_OFFSET)
+#define BCM2836_PV1_LENGTH                    0x00000100
+
+#define BCM2836_PV2_OFFSET                    0x00807000
+#define BCM2836_PV2_BASE_ADDRESS              (BCM2836_SOC_REGISTERS + BCM2836_PV2_OFFSET)
+#define BCM2836_PV2_LENGTH                    0x00000100
+
+#define BCM2836_HDMI0_OFFSET                  0x00902000
+#define BCM2836_HDMI0_BASE_ADDRESS            (BCM2836_SOC_REGISTERS + BCM2836_HDMI0_OFFSET)
+#define BCM2836_HDMI0_LENGTH                  0x00000600
+
+#define BCM2836_HDMI1_OFFSET                  0x00808000
+#define BCM2836_HDMI1_BASE_ADDRESS            (BCM2836_SOC_REGISTERS + BCM2836_HDMI1_OFFSET)
+#define BCM2836_HDMI1_LENGTH                  0x00000100
+
+#endif /* __BCM2836_MISC_H__ */
diff --git a/arch/arm/mach-bcm283x/include/mach/acpi/bcm2836_pwm.h b/arch/arm/mach-bcm283x/include/mach/acpi/bcm2836_pwm.h
new file mode 100644
index 0000000000..78a8486673
--- /dev/null
+++ b/arch/arm/mach-bcm283x/include/mach/acpi/bcm2836_pwm.h
@@ -0,0 +1,33 @@
+/* SPDX-License-Identifier: BSD-2-Clause-Patent */
+/**
+ *
+ *  Copyright (c) 2020, Pete Batard <pete@akeo.ie>
+ *
+ **/
+
+#include <asm/arch/acpi/bcm2836.h>
+
+#ifndef __BCM2836_PWM_H__
+#define __BCM2836_PWM_H__
+
+/* PWM controller constants */
+
+#define BCM2836_PWM_DMA_OFFSET                 0x00007B00
+#define BCM2836_PWM_DMA_BASE_ADDRESS           (BCM2836_SOC_REGISTERS + BCM2836_PWM_DMA_OFFSET)
+#define BCM2836_PWM_DMA_LENGTH                 0x00000100
+
+#define BCM2836_PWM_CLK_OFFSET                 0x001010A0
+#define BCM2836_PWM_CLK_BASE_ADDRESS           (BCM2836_SOC_REGISTERS + BCM2836_PWM_CLK_OFFSET)
+#define BCM2836_PWM_CLK_LENGTH                 0x00000008
+
+#define BCM2836_PWM_CTRL_OFFSET                0x0020C000
+#define BCM2836_PWM_CTRL_BASE_ADDRESS          (BCM2836_SOC_REGISTERS + BCM2836_PWM_CTRL_OFFSET)
+#define BCM2836_PWM_CTRL_LENGTH                0x00000028
+
+#define BCM2836_PWM_BUS_BASE_ADDRESS           0x7E20C000
+#define BCM2836_PWM_BUS_LENGTH                 0x00000028
+
+#define BCM2836_PWM_CTRL_UNCACHED_BASE_ADDRESS 0xFF20C000
+#define BCM2836_PWM_CTRL_UNCACHED_LENGTH       0x00000028
+
+#endif /* __BCM2836_PWM_H__ */
diff --git a/arch/arm/mach-bcm283x/include/mach/acpi/bcm2836_sdhost.h b/arch/arm/mach-bcm283x/include/mach/acpi/bcm2836_sdhost.h
new file mode 100644
index 0000000000..9b1afe8440
--- /dev/null
+++ b/arch/arm/mach-bcm283x/include/mach/acpi/bcm2836_sdhost.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: BSD-2-Clause-Patent */
+/**
+ *
+ *  Copyright (c) 2017, Andrei Warkentin <andrey.warkentin@gmail.com>
+ *  Copyright (c) Microsoft Corporation. All rights reserved.
+ *
+ **/
+
+#include <asm/arch/acpi/bcm2836.h>
+
+#ifndef __BCM2836_SDHOST_H__
+#define __BCM2836_SDHOST_H__
+
+#define SDHOST_OFFSET               0x00202000
+#define SDHOST_BASE_ADDRESS         (BCM2836_SOC_REGISTERS + SDHOST_OFFSET)
+#define SDHOST_LENGTH               0x00000100
+
+#endif /*__BCM2836_SDHOST_H__ */
diff --git a/arch/arm/mach-bcm283x/include/mach/acpi/bcm2836_sdio.h b/arch/arm/mach-bcm283x/include/mach/acpi/bcm2836_sdio.h
new file mode 100644
index 0000000000..48d073d434
--- /dev/null
+++ b/arch/arm/mach-bcm283x/include/mach/acpi/bcm2836_sdio.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: BSD-2-Clause-Patent */
+/**
+ *
+ *  Copyright (c) Microsoft Corporation. All rights reserved.
+ *
+ **/
+
+#include <asm/arch/acpi/bcm2836.h>
+
+#ifndef __BCM2836_SDIO_H__
+#define __BCM2836_SDIO_H__
+
+// MMC/SD/SDIO1 register definitions.
+#define MMCHS1_OFFSET     0x00300000
+#define MMCHS2_OFFSET     0x00340000
+#define MMCHS1_BASE       (BCM2836_SOC_REGISTERS + MMCHS1_OFFSET)
+#define MMCHS2_BASE       (BCM2836_SOC_REGISTERS + MMCHS2_OFFSET)
+#define MMCHS1_LENGTH     0x00000100
+#define MMCHS2_LENGTH     0x00000100
+
+#endif /* __BCM2836_SDIO_H__ */
diff --git a/drivers/pci/pcie_brcmstb.c b/drivers/pci/pcie_brcmstb.c
index f978c64365..f089c48f02 100644
--- a/drivers/pci/pcie_brcmstb.c
+++ b/drivers/pci/pcie_brcmstb.c
@@ -12,6 +12,7 @@
  * Copyright (C) 2020 Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
  */
 
+#include <asm/arch/acpi/bcm2711.h>
 #include <errno.h>
 #include <dm.h>
 #include <dm/ofnode.h>
@@ -21,88 +22,6 @@
 #include <linux/log2.h>
 #include <linux/iopoll.h>
 
-/* Offset of the mandatory PCIe capability config registers */
-#define BRCM_PCIE_CAP_REGS				0x00ac
-
-/* The PCIe controller register offsets */
-#define PCIE_RC_CFG_VENDOR_SPECIFIC_REG1		0x0188
-#define  VENDOR_SPECIFIC_REG1_ENDIAN_MODE_BAR2_MASK	0xc
-#define  VENDOR_SPECIFIC_REG1_LITTLE_ENDIAN		0x0
-
-#define PCIE_RC_CFG_PRIV1_ID_VAL3			0x043c
-#define  CFG_PRIV1_ID_VAL3_CLASS_CODE_MASK		0xffffff
-
-#define PCIE_RC_CFG_PRIV1_LINK_CAPABILITY			0x04dc
-#define  PCIE_RC_CFG_PRIV1_LINK_CAPABILITY_ASPM_SUPPORT_MASK	0xc00
-
-#define PCIE_RC_DL_MDIO_ADDR				0x1100
-#define PCIE_RC_DL_MDIO_WR_DATA				0x1104
-#define PCIE_RC_DL_MDIO_RD_DATA				0x1108
-
-#define PCIE_MISC_MISC_CTRL				0x4008
-#define  MISC_CTRL_SCB_ACCESS_EN_MASK			0x1000
-#define  MISC_CTRL_CFG_READ_UR_MODE_MASK		0x2000
-#define  MISC_CTRL_MAX_BURST_SIZE_MASK			0x300000
-#define  MISC_CTRL_MAX_BURST_SIZE_128			0x0
-#define  MISC_CTRL_SCB0_SIZE_MASK			0xf8000000
-
-#define PCIE_MISC_CPU_2_PCIE_MEM_WIN0_LO		0x400c
-#define PCIE_MEM_WIN0_LO(win)	\
-		PCIE_MISC_CPU_2_PCIE_MEM_WIN0_LO + ((win) * 4)
-
-#define PCIE_MISC_CPU_2_PCIE_MEM_WIN0_HI		0x4010
-#define PCIE_MEM_WIN0_HI(win)	\
-		PCIE_MISC_CPU_2_PCIE_MEM_WIN0_HI + ((win) * 4)
-
-#define PCIE_MISC_RC_BAR1_CONFIG_LO			0x402c
-#define  RC_BAR1_CONFIG_LO_SIZE_MASK			0x1f
-
-#define PCIE_MISC_RC_BAR2_CONFIG_LO			0x4034
-#define  RC_BAR2_CONFIG_LO_SIZE_MASK			0x1f
-#define PCIE_MISC_RC_BAR2_CONFIG_HI			0x4038
-
-#define PCIE_MISC_RC_BAR3_CONFIG_LO			0x403c
-#define  RC_BAR3_CONFIG_LO_SIZE_MASK			0x1f
-
-#define PCIE_MISC_PCIE_STATUS				0x4068
-#define  STATUS_PCIE_PORT_MASK				0x80
-#define  STATUS_PCIE_PORT_SHIFT				7
-#define  STATUS_PCIE_DL_ACTIVE_MASK			0x20
-#define  STATUS_PCIE_DL_ACTIVE_SHIFT			5
-#define  STATUS_PCIE_PHYLINKUP_MASK			0x10
-#define  STATUS_PCIE_PHYLINKUP_SHIFT			4
-
-#define PCIE_MISC_CPU_2_PCIE_MEM_WIN0_BASE_LIMIT	0x4070
-#define  MEM_WIN0_BASE_LIMIT_LIMIT_MASK			0xfff00000
-#define  MEM_WIN0_BASE_LIMIT_BASE_MASK			0xfff0
-#define  MEM_WIN0_BASE_LIMIT_BASE_HI_SHIFT		12
-#define PCIE_MEM_WIN0_BASE_LIMIT(win)	\
-	 PCIE_MISC_CPU_2_PCIE_MEM_WIN0_BASE_LIMIT + ((win) * 4)
-
-#define PCIE_MISC_CPU_2_PCIE_MEM_WIN0_BASE_HI		0x4080
-#define  MEM_WIN0_BASE_HI_BASE_MASK			0xff
-#define PCIE_MEM_WIN0_BASE_HI(win)	\
-	 PCIE_MISC_CPU_2_PCIE_MEM_WIN0_BASE_HI + ((win) * 8)
-
-#define PCIE_MISC_CPU_2_PCIE_MEM_WIN0_LIMIT_HI		0x4084
-#define  PCIE_MEM_WIN0_LIMIT_HI_LIMIT_MASK		0xff
-#define PCIE_MEM_WIN0_LIMIT_HI(win)	\
-	 PCIE_MISC_CPU_2_PCIE_MEM_WIN0_LIMIT_HI + ((win) * 8)
-
-#define PCIE_MISC_HARD_PCIE_HARD_DEBUG			0x4204
-#define  PCIE_HARD_DEBUG_SERDES_IDDQ_MASK		0x08000000
-
-#define PCIE_MSI_INTR2_CLR				0x4508
-#define PCIE_MSI_INTR2_MASK_SET				0x4510
-
-#define PCIE_EXT_CFG_DATA				0x8000
-
-#define PCIE_EXT_CFG_INDEX				0x9000
-
-#define PCIE_RGR1_SW_INIT_1				0x9210
-#define  RGR1_SW_INIT_1_PERST_MASK			0x1
-#define  RGR1_SW_INIT_1_INIT_MASK			0x2
-
 /* PCIe parameters */
 #define BRCM_NUM_PCIE_OUT_WINS				4
 
@@ -447,7 +366,7 @@ static int brcm_pcie_probe(struct udevice *dev)
 	 * This will need to be changed when support for other SoCs is added.
 	 */
 	setbits_le32(base + PCIE_RGR1_SW_INIT_1,
-		     RGR1_SW_INIT_1_INIT_MASK | RGR1_SW_INIT_1_PERST_MASK);
+		     PCIE_RGR1_SW_INIT_1_INIT_MASK | PCIE_RGR1_SW_INIT_1_PERST_MASK);
 	/*
 	 * The delay is a safety precaution to preclude the reset signal
 	 * from looking like a glitch.
@@ -455,7 +374,7 @@ static int brcm_pcie_probe(struct udevice *dev)
 	udelay(100);
 
 	/* Take the bridge out of reset */
-	clrbits_le32(base + PCIE_RGR1_SW_INIT_1, RGR1_SW_INIT_1_INIT_MASK);
+	clrbits_le32(base + PCIE_RGR1_SW_INIT_1, PCIE_RGR1_SW_INIT_1_INIT_MASK);
 
 	clrbits_le32(base + PCIE_MISC_HARD_PCIE_HARD_DEBUG,
 		     PCIE_HARD_DEBUG_SERDES_IDDQ_MASK);
@@ -508,7 +427,7 @@ static int brcm_pcie_probe(struct udevice *dev)
 
 	/* Unassert the fundamental reset */
 	clrbits_le32(pcie->base + PCIE_RGR1_SW_INIT_1,
-		     RGR1_SW_INIT_1_PERST_MASK);
+		     PCIE_RGR1_SW_INIT_1_PERST_MASK);
 
 	/*
 	 * Wait for 100ms after PERST# deassertion; see PCIe CEM specification
@@ -552,7 +471,7 @@ static int brcm_pcie_probe(struct udevice *dev)
 	 * a PCIe-PCIe bridge (the default setting is to be EP mode).
 	 */
 	clrsetbits_le32(base + PCIE_RC_CFG_PRIV1_ID_VAL3,
-			CFG_PRIV1_ID_VAL3_CLASS_CODE_MASK, 0x060400);
+			PCIE_RC_CFG_PRIV1_ID_VAL3_CLASS_CODE_MASK, 0x060400);
 
 	if (pcie->ssc) {
 		ret = brcm_pcie_set_ssc(pcie->base);
@@ -570,8 +489,8 @@ static int brcm_pcie_probe(struct udevice *dev)
 	       nlw, ssc_good ? "(SSC)" : "(!SSC)");
 
 	/* PCIe->SCB endian mode for BAR */
-	clrsetbits_le32(base + PCIE_RC_CFG_VENDOR_SPECIFIC_REG1,
-			VENDOR_SPECIFIC_REG1_ENDIAN_MODE_BAR2_MASK,
+	clrsetbits_le32(base + PCIE_RC_CFG_VENDOR_VENDOR_SPECIFIC_REG1,
+			PCIE_RC_CFG_VENDOR_VENDOR_SPECIFIC_REG1_ENDIAN_MODE_BAR2_MASK,
 			VENDOR_SPECIFIC_REG1_LITTLE_ENDIAN);
 
 	/*
@@ -584,7 +503,7 @@ static int brcm_pcie_probe(struct udevice *dev)
 	 * let's instead just unadvertise ASPM support.
 	 */
 	clrbits_le32(base + PCIE_RC_CFG_PRIV1_LINK_CAPABILITY,
-		     PCIE_RC_CFG_PRIV1_LINK_CAPABILITY_ASPM_SUPPORT_MASK);
+		     LINK_CAPABILITY_ASPM_SUPPORT_MASK);
 
 	return 0;
 }
@@ -595,14 +514,14 @@ static int brcm_pcie_remove(struct udevice *dev)
 	void __iomem *base = pcie->base;
 
 	/* Assert fundamental reset */
-	setbits_le32(base + PCIE_RGR1_SW_INIT_1, RGR1_SW_INIT_1_PERST_MASK);
+	setbits_le32(base + PCIE_RGR1_SW_INIT_1, PCIE_RGR1_SW_INIT_1_PERST_MASK);
 
 	/* Turn off SerDes */
 	setbits_le32(base + PCIE_MISC_HARD_PCIE_HARD_DEBUG,
 		     PCIE_HARD_DEBUG_SERDES_IDDQ_MASK);
 
 	/* Shutdown bridge */
-	setbits_le32(base + PCIE_RGR1_SW_INIT_1, RGR1_SW_INIT_1_INIT_MASK);
+	setbits_le32(base + PCIE_RGR1_SW_INIT_1, PCIE_RGR1_SW_INIT_1_INIT_MASK);
 
 	return 0;
 }
-- 
2.46.0


