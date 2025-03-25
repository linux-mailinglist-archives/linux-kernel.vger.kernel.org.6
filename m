Return-Path: <linux-kernel+bounces-575557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16633A70418
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 15:46:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA3533BBFCA
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 14:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 367D525A659;
	Tue, 25 Mar 2025 14:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="hhL2HZqv"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997971891AA
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 14:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742913784; cv=none; b=C6d3NQn6udsRgwEkR2qHGvFEsMAQcbRLFG90n82LPBjJPlYOJfjKdpCTErJ2LDHSOA6gyeQmDstsbf95H6BH0bOaYq+tuwoJADY1wX+gU7G2tN1WZ7WNOLT7HIn2Q7G/sB974xkIlcwCEE8DO7gy9L2YeE3VLq9L+KnSUjUHUpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742913784; c=relaxed/simple;
	bh=LOKRyJPlx4ALshCfaoPz7qjsvhH7B9FDI6EixCfAYBw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LLWuhaQjnrghgp08ZQOgrrWuykY7BgSNJ35yGYdmZzr5EPoXORMYZlBwa39cH0AC9D4OcS2J16KwRcP5zPXb8fjkOqENOkkEoyrTDpIJwZnBdNhvlDEo8/xNY+noOVYMfSCQYFSVRdqsjCk2PgIvBj9lC6wzPjGfRb28dAkjVuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=hhL2HZqv; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-226185948ffso110154225ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 07:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1742913781; x=1743518581; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bljuQ7L2ZXdxWuOFhGPKf4EDYNcT12ia204eGvgijaA=;
        b=hhL2HZqvhhYry6bX5OKLAzx0lFj//cYh5mYGo2u4JwqC95rXSRzwWL2DM/kTkutewg
         5bVf8/S0rRNjZwDM/D0D4p9GyGatrv48Ehm7LMoD4SijVVz3DAs/hGhVXrMRTcvkQ6dA
         usucYgD40uagNNjIGWi8IJP2GTOvogHUwBIxRl25+HHb3EcMLkVCUYRA1CIFRhwCA7bE
         k/Quagx8lYzq0WK8anI1I9F0sEhhpqLJfAnpFcFbWQIWTNa5R32e4UnZ/2UMQuvLIWAy
         +J1uqYfneOCBJ4V3PNMxoTjjSg+X0bk4PIhXEvKa6VMRIiSllleHD/IPFzJWX2KcsiMv
         27jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742913781; x=1743518581;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bljuQ7L2ZXdxWuOFhGPKf4EDYNcT12ia204eGvgijaA=;
        b=dSYDonnWH0n6dXef+e4evmovvujn6LImJQqroGa7pqk19qxbEMg+wJ1d5tm3/ZQXdc
         JMCStVAq51kSwIs6pBYD0lkqQhheM8DkWjPFtFlNg8C/l/zZWb/jNLOotU60gXe6LIR9
         wPiwNmzCLmG1kOL/b+VZFU6A5DG8QwclyhEIBnyOLmdK5Dj5DY/7XJljIelnJO2xA/ic
         ytP6XlZUNN34qNu+P6odoxSbrPcIGiAGU7ih57mjVnWrUcsqFpi3PxkOImkiri1wtuiy
         oAZL8o53Kynb3eM1PuY+/7QMDAmPFoW/EYsRimdEZTe9zTdGasfUeU/b4+ydaY7A7pZA
         rc/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUM6puYLP8K3iz5zz3DCzkbs+w+YZcNXKbIh9xyKDxIcJ9WrYsXyQAppbauWsq0FSkJJGKV+iEiInigBi0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJvBM2QxPrGxCQSmasFeMB8WlI3cEWtv0E+yophaLxziqf33Jn
	dUmeuWpOB9AL9SYEqG+FEwuvGl8yc8G5W06TiPKWJnklRGIh4zmjxF3jxV4vm/c=
X-Gm-Gg: ASbGnctnBhSeMBELVbkJALU+Cl0z59suudu3dvKwV+mH6UbRowErSHg9oY+y5LHPJDB
	IhDebkJHPKyfcYtWCtl9pPtxbsI/RXCmNLAq4aeRd7NPOUHChGhiCumKl5GXfr9gigqA0AcwWfF
	ho7o570YfI5VUwTy3SYCcUy2pf6IkoAFNlHNFPDcY2iHmgPR+R3GY64Y9KX/M8Omun9wVUsDOzG
	xY3j1Tiy+hMSPXvP3xyN7cxMrc43dJZlcjzyuIaMj12nZUDwc51Qu6Y2zVe0MXwR4frWU8Jjwwl
	6YQTJv761cTe15Iqk796hED8RjQxYhZCIoFNIrSJhKk+N83aKNReyjWXKJOehmEqJWUcUfcHY8c
	VM0SXTX114cplzc3Zv0okqQWXtFWzhK8SNBHaHQ==
X-Google-Smtp-Source: AGHT+IHfViq5we3BRjn4gQvEwpQaIGaX5+RcC5JvR41oDoMV13Q99xQsSECoVp76jMvqJK4oIhXprQ==
X-Received: by 2002:a17:902:d484:b0:223:3ef1:a30a with SMTP id d9443c01a7336-22780e239e1mr244870085ad.45.1742913780671;
        Tue, 25 Mar 2025 07:43:00 -0700 (PDT)
Received: from J9GPGXL7NT.bytedance.net ([61.213.176.58])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22780f39656sm90623745ad.5.2025.03.25.07.42.57
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 25 Mar 2025 07:43:00 -0700 (PDT)
From: Xu Lu <luxu.kernel@bytedance.com>
To: tjeznach@rivosinc.com,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	alex@ghiti.fr
Cc: lihangjing@bytedance.com,
	xieyongji@bytedance.com,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev,
	Xu Lu <luxu.kernel@bytedance.com>
Subject: [PATCH] iommu: riscv: Split 8-byte accesses on 32 bit I/O bus platform
Date: Tue, 25 Mar 2025 22:42:52 +0800
Message-Id: <20250325144252.27403-1-luxu.kernel@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce a new configuration CONFIG_RISCV_IOMMU_32BIT to enable
splitting 8-byte access into 4-byte transactions for hardware platform
whose I/O bus limits access to 4-byte transfers.

Signed-off-by: Xu Lu <luxu.kernel@bytedance.com>
---
 drivers/iommu/riscv/Kconfig |  9 +++++++++
 drivers/iommu/riscv/iommu.h | 28 +++++++++++++++++++++++-----
 2 files changed, 32 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/riscv/Kconfig b/drivers/iommu/riscv/Kconfig
index c071816f59a6..b7c9ea22d969 100644
--- a/drivers/iommu/riscv/Kconfig
+++ b/drivers/iommu/riscv/Kconfig
@@ -18,3 +18,12 @@ config RISCV_IOMMU_PCI
 	def_bool y if RISCV_IOMMU && PCI_MSI
 	help
 	  Support for the PCIe implementation of RISC-V IOMMU architecture.
+
+config RISCV_IOMMU_32BIT
+	bool "Support 4-Byte Accesses on RISC-V IOMMU Registers"
+	depends on RISCV_IOMMU
+	default n
+	help
+	  Support hardware platform whose I/O bus limits access to 4-byte
+	  transfers. When enabled, all accesses to IOMMU registers will be
+	  split into 4-byte accesses.
diff --git a/drivers/iommu/riscv/iommu.h b/drivers/iommu/riscv/iommu.h
index 46df79dd5495..0e3552a8142d 100644
--- a/drivers/iommu/riscv/iommu.h
+++ b/drivers/iommu/riscv/iommu.h
@@ -14,6 +14,10 @@
 #include <linux/iommu.h>
 #include <linux/types.h>
 #include <linux/iopoll.h>
+#ifdef CONFIG_RISCV_IOMMU_32BIT
+#include <linux/io-64-nonatomic-hi-lo.h>
+#include <linux/io-64-nonatomic-lo-hi.h>
+#endif
 
 #include "iommu-bits.h"
 
@@ -69,21 +73,35 @@ void riscv_iommu_disable(struct riscv_iommu_device *iommu);
 #define riscv_iommu_readl(iommu, addr) \
 	readl_relaxed((iommu)->reg + (addr))
 
-#define riscv_iommu_readq(iommu, addr) \
-	readq_relaxed((iommu)->reg + (addr))
-
 #define riscv_iommu_writel(iommu, addr, val) \
 	writel_relaxed((val), (iommu)->reg + (addr))
 
+#define riscv_iommu_readl_timeout(iommu, addr, val, cond, delay_us, timeout_us) \
+	readx_poll_timeout(readl_relaxed, (iommu)->reg + (addr), val, cond, \
+			   delay_us, timeout_us)
+
+#ifndef CONFIG_RISCV_IOMMU_32BIT
+#define riscv_iommu_readq(iommu, addr) \
+	readq_relaxed((iommu)->reg + (addr))
+
 #define riscv_iommu_writeq(iommu, addr, val) \
 	writeq_relaxed((val), (iommu)->reg + (addr))
 
 #define riscv_iommu_readq_timeout(iommu, addr, val, cond, delay_us, timeout_us) \
 	readx_poll_timeout(readq_relaxed, (iommu)->reg + (addr), val, cond, \
 			   delay_us, timeout_us)
+#else /* CONFIG_RISCV_IOMMU_32BIT */
+#define riscv_iommu_readq(iommu, addr) \
+	hi_lo_readq_relaxed((iommu)->reg + (addr))
 
-#define riscv_iommu_readl_timeout(iommu, addr, val, cond, delay_us, timeout_us) \
-	readx_poll_timeout(readl_relaxed, (iommu)->reg + (addr), val, cond, \
+#define riscv_iommu_writeq(iommu, addr, val) \
+	((addr == RISCV_IOMMU_REG_IOHPMCYCLES) ? \
+	 lo_hi_writeq_relaxed((val), (iommu)->reg + (addr)) : \
+	 hi_lo_writeq_relaxed((val), (iommu)->reg + (addr)))
+
+#define riscv_iommu_readq_timeout(iommu, addr, val, cond, delay_us, timeout_us) \
+	readx_poll_timeout(hi_lo_readq_relaxed, (iommu)->reg + (addr), val, cond, \
 			   delay_us, timeout_us)
+#endif /* CONFIG_RISCV_IOMMU_32BIT */
 
 #endif
-- 
2.20.1


