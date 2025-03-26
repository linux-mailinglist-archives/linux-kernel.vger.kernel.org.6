Return-Path: <linux-kernel+bounces-577380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 117B2A71C6E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 17:53:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0502517D442
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 16:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 895571FECA9;
	Wed, 26 Mar 2025 16:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=imgtec.com header.i=@imgtec.com header.b="HIXHV+w0"
Received: from mx08-00376f01.pphosted.com (mx08-00376f01.pphosted.com [91.207.212.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89018145B0B;
	Wed, 26 Mar 2025 16:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743007763; cv=none; b=KE7KJ3duoO5dc+r+GTY+pZchy8A2GsB+FLqx4kqpCV+/elPT/JqNrMrfnXZBbPw/dO1J4O4WA7mTLMcFeTXECV0dBdSRejrl+LnbAPG15We+h5LmHJpxZLtkrhyEyF7rz5LtNgpqVOTdeI6UoGKWZHJcC/bodJd4zMejdblzWQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743007763; c=relaxed/simple;
	bh=6CwbvqSbOGd7fx7owU+KfmuFo7Y4soIYbxsr/qYQ2uU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=n2TTMnrlVfLs0icO4rU+2G9nOy//HtfmqYBtBMCXzFPu/yKxw9mqF7UF+6nPEHNtSv1FgDpa34b2HQ5RCepregrJ16ZDGEnOu6OOYDkpl90gxf5tnAnkxJWOonaxYweWoQU3LPAvKJSDeNwDNDywY2FybYmDsChLGSRP28M81uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=imgtec.com; spf=pass smtp.mailfrom=imgtec.com; dkim=pass (2048-bit key) header.d=imgtec.com header.i=@imgtec.com header.b=HIXHV+w0; arc=none smtp.client-ip=91.207.212.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=imgtec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=imgtec.com
Received: from pps.filterd (m0168888.ppops.net [127.0.0.1])
	by mx08-00376f01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52QBt2Sb012691;
	Wed, 26 Mar 2025 16:48:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=dk201812; bh=T
	h5/N5p9YQP1/vp05NOMfgIfYGVnLTQqXGx9RGMExTA=; b=HIXHV+w0b0y44jMBs
	W67vEKP6MX6ql93HaR798eGqePkC8WXwrYuXvlRKuEdWUIZG1Fm/u/EkAAQJ5lnz
	ViWEjoDCTT8nQ5pvTwHzKKoihqNgdlYLy0U2r78uzMiO+XslIw6MP/azS/bCACNA
	+k1zgCDPHuS31zuDdmiYtqylmFKNlCNYQKr4oINee3o5CrgpuI+Vs6BW7SpsT5Ah
	xABjxbYeAtMHLlZRygpapxlegqQV661tnlc0DmEs4VJEarFIF4pI/aNLqIloeFF/
	05zjK/PjqYmpapWAs/pGT48wxmkAdE6h3zEjDUYKa1RskQDpOqApdvsQLyJtNF59
	cDGRA==
Received: from hhmail05.hh.imgtec.org (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
	by mx08-00376f01.pphosted.com (PPS) with ESMTPS id 45kbmy9d6d-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 26 Mar 2025 16:48:54 +0000 (GMT)
Received: from
 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa
 (172.25.0.133) by HHMAIL05.hh.imgtec.org (10.100.10.120) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 26 Mar 2025 16:48:41 +0000
From: Matt Coster <matt.coster@imgtec.com>
Date: Wed, 26 Mar 2025 16:48:23 +0000
Subject: [PATCH v5 03/18] drm/imagination: Update register defs for newer
 GPUs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250326-sets-bxs-4-64-patch-v1-v5-3-e4c46e8280a9@imgtec.com>
References: <20250326-sets-bxs-4-64-patch-v1-v5-0-e4c46e8280a9@imgtec.com>
In-Reply-To: <20250326-sets-bxs-4-64-patch-v1-v5-0-e4c46e8280a9@imgtec.com>
To: Frank Binns <frank.binns@imgtec.com>,
        Matt Coster
	<matt.coster@imgtec.com>,
        David Airlie <airlied@gmail.com>, Simona Vetter
	<simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
        "Vignesh
 Raghavendra" <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>
CC: <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        Randolph Sapp <rs@ti.com>, Darren Etheridge <detheridge@ti.com>,
        "Michal
 Wilczynski" <m.wilczynski@samsung.com>,
        Alessio Belle
	<alessio.belle@imgtec.com>,
        Alexandru Dadu <alexandru.dadu@imgtec.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=10939;
 i=matt.coster@imgtec.com; h=from:subject:message-id;
 bh=7UZjX1KztdeoZ2y/6Je0m9d/Nq6pGMo6cRsrvuv9yKU=;
 b=owGbwMvMwCFWuUfy8817WRsYT6slMaQ/0X9y5Mlkj6K8v4vXBll6qh27eyXK4ZVD5atv4jOO2
 Pvknf8h3FHKwiDGwSArpsiyY4XlCrU/aloSN34Vw8xhZQIZwsDFKQAT2RnKyHDgwaSqOUuuVdcz
 fA2Y+1/QNE44uGiPXnuWs2SaudRHXSZGhv99h5tEpQLTrh9Ul1we1CD/8NuapC9yD3+IzrRV8/T
 kZwUA
X-Developer-Key: i=matt.coster@imgtec.com; a=openpgp;
 fpr=05A40CFCE7269D61D97100A1747F0A9036F90DFA
X-EXCLAIMER-MD-CONFIG: 15a78312-3e47-46eb-9010-2e54d84a9631
X-Proofpoint-ORIG-GUID: yo1Vz4MvjEZtKoX6AgJ14K0Up13-7bgW
X-Authority-Analysis: v=2.4 cv=L+sdQ/T8 c=1 sm=1 tr=0 ts=67e42ff6 cx=c_pps a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17 a=ETbM1kImDFEA:10 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=VwQbUJbxAAAA:8 a=r_1tXGB3AAAA:8 a=cj9k-Jd43VawDxvwHVkA:9
 a=QEXdDO2ut3YA:10 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-GUID: yo1Vz4MvjEZtKoX6AgJ14K0Up13-7bgW

From: Alessio Belle <alessio.belle@imgtec.com>

Update the register define header to a newer version that covers more
recent GPUs, including BXS-4-64.

Signed-off-by: Alessio Belle <alessio.belle@imgtec.com>
Signed-off-by: Matt Coster <matt.coster@imgtec.com>
---
Changes in v5:
- None
- Link to v4: https://lore.kernel.org/r/20250320-sets-bxs-4-64-patch-v1-v4-3-d987cf4ca439@imgtec.com
Changes in v4:
- None
- Link to v3: https://lore.kernel.org/r/20250310-sets-bxs-4-64-patch-v1-v3-3-143b3dbef02f@imgtec.com
Changes in v3:
- Added
---
 drivers/gpu/drm/imagination/pvr_rogue_cr_defs.h | 153 +++++++++++++++++++++---
 1 file changed, 134 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/imagination/pvr_rogue_cr_defs.h b/drivers/gpu/drm/imagination/pvr_rogue_cr_defs.h
index 2a90d02796d3e071b18e18dead105e29798bcddc..790c97f80a2ac03ac76b933d009a2f9cfc6003f7 100644
--- a/drivers/gpu/drm/imagination/pvr_rogue_cr_defs.h
+++ b/drivers/gpu/drm/imagination/pvr_rogue_cr_defs.h
@@ -827,6 +827,120 @@
 #define ROGUE_CR_EVENT_STATUS_TLA_COMPLETE_CLRMSK 0xFFFFFFFEU
 #define ROGUE_CR_EVENT_STATUS_TLA_COMPLETE_EN 0x00000001U
 
+/* Register ROGUE_CR_EVENT_CLEAR */
+#define ROGUE_CR_EVENT_CLEAR 0x0138U
+#define ROGUE_CR_EVENT_CLEAR__ROGUEXE__MASKFULL 0x00000000E01DFFFFULL
+#define ROGUE_CR_EVENT_CLEAR__SIGNALS__MASKFULL 0x00000000E007FFFFULL
+#define ROGUE_CR_EVENT_CLEAR_MASKFULL 0x00000000FFFFFFFFULL
+#define ROGUE_CR_EVENT_CLEAR_TDM_FENCE_FINISHED_SHIFT 31U
+#define ROGUE_CR_EVENT_CLEAR_TDM_FENCE_FINISHED_CLRMSK 0x7FFFFFFFU
+#define ROGUE_CR_EVENT_CLEAR_TDM_FENCE_FINISHED_EN 0x80000000U
+#define ROGUE_CR_EVENT_CLEAR_TDM_BUFFER_STALL_SHIFT 30U
+#define ROGUE_CR_EVENT_CLEAR_TDM_BUFFER_STALL_CLRMSK 0xBFFFFFFFU
+#define ROGUE_CR_EVENT_CLEAR_TDM_BUFFER_STALL_EN 0x40000000U
+#define ROGUE_CR_EVENT_CLEAR_COMPUTE_SIGNAL_FAILURE_SHIFT 29U
+#define ROGUE_CR_EVENT_CLEAR_COMPUTE_SIGNAL_FAILURE_CLRMSK 0xDFFFFFFFU
+#define ROGUE_CR_EVENT_CLEAR_COMPUTE_SIGNAL_FAILURE_EN 0x20000000U
+#define ROGUE_CR_EVENT_CLEAR_DPX_OUT_OF_MEMORY_SHIFT 28U
+#define ROGUE_CR_EVENT_CLEAR_DPX_OUT_OF_MEMORY_CLRMSK 0xEFFFFFFFU
+#define ROGUE_CR_EVENT_CLEAR_DPX_OUT_OF_MEMORY_EN 0x10000000U
+#define ROGUE_CR_EVENT_CLEAR_DPX_MMU_PAGE_FAULT_SHIFT 27U
+#define ROGUE_CR_EVENT_CLEAR_DPX_MMU_PAGE_FAULT_CLRMSK 0xF7FFFFFFU
+#define ROGUE_CR_EVENT_CLEAR_DPX_MMU_PAGE_FAULT_EN 0x08000000U
+#define ROGUE_CR_EVENT_CLEAR_RPM_OUT_OF_MEMORY_SHIFT 26U
+#define ROGUE_CR_EVENT_CLEAR_RPM_OUT_OF_MEMORY_CLRMSK 0xFBFFFFFFU
+#define ROGUE_CR_EVENT_CLEAR_RPM_OUT_OF_MEMORY_EN 0x04000000U
+#define ROGUE_CR_EVENT_CLEAR_FBA_FC3_FINISHED_SHIFT 25U
+#define ROGUE_CR_EVENT_CLEAR_FBA_FC3_FINISHED_CLRMSK 0xFDFFFFFFU
+#define ROGUE_CR_EVENT_CLEAR_FBA_FC3_FINISHED_EN 0x02000000U
+#define ROGUE_CR_EVENT_CLEAR_FBA_FC2_FINISHED_SHIFT 24U
+#define ROGUE_CR_EVENT_CLEAR_FBA_FC2_FINISHED_CLRMSK 0xFEFFFFFFU
+#define ROGUE_CR_EVENT_CLEAR_FBA_FC2_FINISHED_EN 0x01000000U
+#define ROGUE_CR_EVENT_CLEAR_FBA_FC1_FINISHED_SHIFT 23U
+#define ROGUE_CR_EVENT_CLEAR_FBA_FC1_FINISHED_CLRMSK 0xFF7FFFFFU
+#define ROGUE_CR_EVENT_CLEAR_FBA_FC1_FINISHED_EN 0x00800000U
+#define ROGUE_CR_EVENT_CLEAR_FBA_FC0_FINISHED_SHIFT 22U
+#define ROGUE_CR_EVENT_CLEAR_FBA_FC0_FINISHED_CLRMSK 0xFFBFFFFFU
+#define ROGUE_CR_EVENT_CLEAR_FBA_FC0_FINISHED_EN 0x00400000U
+#define ROGUE_CR_EVENT_CLEAR_RDM_FC3_FINISHED_SHIFT 21U
+#define ROGUE_CR_EVENT_CLEAR_RDM_FC3_FINISHED_CLRMSK 0xFFDFFFFFU
+#define ROGUE_CR_EVENT_CLEAR_RDM_FC3_FINISHED_EN 0x00200000U
+#define ROGUE_CR_EVENT_CLEAR_RDM_FC2_FINISHED_SHIFT 20U
+#define ROGUE_CR_EVENT_CLEAR_RDM_FC2_FINISHED_CLRMSK 0xFFEFFFFFU
+#define ROGUE_CR_EVENT_CLEAR_RDM_FC2_FINISHED_EN 0x00100000U
+#define ROGUE_CR_EVENT_CLEAR_SAFETY_SHIFT 20U
+#define ROGUE_CR_EVENT_CLEAR_SAFETY_CLRMSK 0xFFEFFFFFU
+#define ROGUE_CR_EVENT_CLEAR_SAFETY_EN 0x00100000U
+#define ROGUE_CR_EVENT_CLEAR_RDM_FC1_FINISHED_SHIFT 19U
+#define ROGUE_CR_EVENT_CLEAR_RDM_FC1_FINISHED_CLRMSK 0xFFF7FFFFU
+#define ROGUE_CR_EVENT_CLEAR_RDM_FC1_FINISHED_EN 0x00080000U
+#define ROGUE_CR_EVENT_CLEAR_SLAVE_REQ_SHIFT 19U
+#define ROGUE_CR_EVENT_CLEAR_SLAVE_REQ_CLRMSK 0xFFF7FFFFU
+#define ROGUE_CR_EVENT_CLEAR_SLAVE_REQ_EN 0x00080000U
+#define ROGUE_CR_EVENT_CLEAR_RDM_FC0_FINISHED_SHIFT 18U
+#define ROGUE_CR_EVENT_CLEAR_RDM_FC0_FINISHED_CLRMSK 0xFFFBFFFFU
+#define ROGUE_CR_EVENT_CLEAR_RDM_FC0_FINISHED_EN 0x00040000U
+#define ROGUE_CR_EVENT_CLEAR_TDM_CONTEXT_STORE_FINISHED_SHIFT 18U
+#define ROGUE_CR_EVENT_CLEAR_TDM_CONTEXT_STORE_FINISHED_CLRMSK 0xFFFBFFFFU
+#define ROGUE_CR_EVENT_CLEAR_TDM_CONTEXT_STORE_FINISHED_EN 0x00040000U
+#define ROGUE_CR_EVENT_CLEAR_SHG_FINISHED_SHIFT 17U
+#define ROGUE_CR_EVENT_CLEAR_SHG_FINISHED_CLRMSK 0xFFFDFFFFU
+#define ROGUE_CR_EVENT_CLEAR_SHG_FINISHED_EN 0x00020000U
+#define ROGUE_CR_EVENT_CLEAR_SPFILTER_SIGNAL_UPDATE_SHIFT 17U
+#define ROGUE_CR_EVENT_CLEAR_SPFILTER_SIGNAL_UPDATE_CLRMSK 0xFFFDFFFFU
+#define ROGUE_CR_EVENT_CLEAR_SPFILTER_SIGNAL_UPDATE_EN 0x00020000U
+#define ROGUE_CR_EVENT_CLEAR_COMPUTE_BUFFER_STALL_SHIFT 16U
+#define ROGUE_CR_EVENT_CLEAR_COMPUTE_BUFFER_STALL_CLRMSK 0xFFFEFFFFU
+#define ROGUE_CR_EVENT_CLEAR_COMPUTE_BUFFER_STALL_EN 0x00010000U
+#define ROGUE_CR_EVENT_CLEAR_USC_TRIGGER_SHIFT 15U
+#define ROGUE_CR_EVENT_CLEAR_USC_TRIGGER_CLRMSK 0xFFFF7FFFU
+#define ROGUE_CR_EVENT_CLEAR_USC_TRIGGER_EN 0x00008000U
+#define ROGUE_CR_EVENT_CLEAR_ZLS_FINISHED_SHIFT 14U
+#define ROGUE_CR_EVENT_CLEAR_ZLS_FINISHED_CLRMSK 0xFFFFBFFFU
+#define ROGUE_CR_EVENT_CLEAR_ZLS_FINISHED_EN 0x00004000U
+#define ROGUE_CR_EVENT_CLEAR_GPIO_ACK_SHIFT 13U
+#define ROGUE_CR_EVENT_CLEAR_GPIO_ACK_CLRMSK 0xFFFFDFFFU
+#define ROGUE_CR_EVENT_CLEAR_GPIO_ACK_EN 0x00002000U
+#define ROGUE_CR_EVENT_CLEAR_GPIO_REQ_SHIFT 12U
+#define ROGUE_CR_EVENT_CLEAR_GPIO_REQ_CLRMSK 0xFFFFEFFFU
+#define ROGUE_CR_EVENT_CLEAR_GPIO_REQ_EN 0x00001000U
+#define ROGUE_CR_EVENT_CLEAR_POWER_ABORT_SHIFT 11U
+#define ROGUE_CR_EVENT_CLEAR_POWER_ABORT_CLRMSK 0xFFFFF7FFU
+#define ROGUE_CR_EVENT_CLEAR_POWER_ABORT_EN 0x00000800U
+#define ROGUE_CR_EVENT_CLEAR_POWER_COMPLETE_SHIFT 10U
+#define ROGUE_CR_EVENT_CLEAR_POWER_COMPLETE_CLRMSK 0xFFFFFBFFU
+#define ROGUE_CR_EVENT_CLEAR_POWER_COMPLETE_EN 0x00000400U
+#define ROGUE_CR_EVENT_CLEAR_MMU_PAGE_FAULT_SHIFT 9U
+#define ROGUE_CR_EVENT_CLEAR_MMU_PAGE_FAULT_CLRMSK 0xFFFFFDFFU
+#define ROGUE_CR_EVENT_CLEAR_MMU_PAGE_FAULT_EN 0x00000200U
+#define ROGUE_CR_EVENT_CLEAR_PM_3D_MEM_FREE_SHIFT 8U
+#define ROGUE_CR_EVENT_CLEAR_PM_3D_MEM_FREE_CLRMSK 0xFFFFFEFFU
+#define ROGUE_CR_EVENT_CLEAR_PM_3D_MEM_FREE_EN 0x00000100U
+#define ROGUE_CR_EVENT_CLEAR_PM_OUT_OF_MEMORY_SHIFT 7U
+#define ROGUE_CR_EVENT_CLEAR_PM_OUT_OF_MEMORY_CLRMSK 0xFFFFFF7FU
+#define ROGUE_CR_EVENT_CLEAR_PM_OUT_OF_MEMORY_EN 0x00000080U
+#define ROGUE_CR_EVENT_CLEAR_TA_TERMINATE_SHIFT 6U
+#define ROGUE_CR_EVENT_CLEAR_TA_TERMINATE_CLRMSK 0xFFFFFFBFU
+#define ROGUE_CR_EVENT_CLEAR_TA_TERMINATE_EN 0x00000040U
+#define ROGUE_CR_EVENT_CLEAR_TA_FINISHED_SHIFT 5U
+#define ROGUE_CR_EVENT_CLEAR_TA_FINISHED_CLRMSK 0xFFFFFFDFU
+#define ROGUE_CR_EVENT_CLEAR_TA_FINISHED_EN 0x00000020U
+#define ROGUE_CR_EVENT_CLEAR_ISP_END_MACROTILE_SHIFT 4U
+#define ROGUE_CR_EVENT_CLEAR_ISP_END_MACROTILE_CLRMSK 0xFFFFFFEFU
+#define ROGUE_CR_EVENT_CLEAR_ISP_END_MACROTILE_EN 0x00000010U
+#define ROGUE_CR_EVENT_CLEAR_PIXELBE_END_RENDER_SHIFT 3U
+#define ROGUE_CR_EVENT_CLEAR_PIXELBE_END_RENDER_CLRMSK 0xFFFFFFF7U
+#define ROGUE_CR_EVENT_CLEAR_PIXELBE_END_RENDER_EN 0x00000008U
+#define ROGUE_CR_EVENT_CLEAR_COMPUTE_FINISHED_SHIFT 2U
+#define ROGUE_CR_EVENT_CLEAR_COMPUTE_FINISHED_CLRMSK 0xFFFFFFFBU
+#define ROGUE_CR_EVENT_CLEAR_COMPUTE_FINISHED_EN 0x00000004U
+#define ROGUE_CR_EVENT_CLEAR_KERNEL_FINISHED_SHIFT 1U
+#define ROGUE_CR_EVENT_CLEAR_KERNEL_FINISHED_CLRMSK 0xFFFFFFFDU
+#define ROGUE_CR_EVENT_CLEAR_KERNEL_FINISHED_EN 0x00000002U
+#define ROGUE_CR_EVENT_CLEAR_TLA_COMPLETE_SHIFT 0U
+#define ROGUE_CR_EVENT_CLEAR_TLA_COMPLETE_CLRMSK 0xFFFFFFFEU
+#define ROGUE_CR_EVENT_CLEAR_TLA_COMPLETE_EN 0x00000001U
+
 /* Register ROGUE_CR_TIMER */
 #define ROGUE_CR_TIMER 0x0160U
 #define ROGUE_CR_TIMER_MASKFULL 0x8000FFFFFFFFFFFFULL
@@ -6031,25 +6145,6 @@
 #define ROGUE_CR_MULTICORE_COMPUTE_CTRL_COMMON_GPU_ENABLE_SHIFT 0U
 #define ROGUE_CR_MULTICORE_COMPUTE_CTRL_COMMON_GPU_ENABLE_CLRMSK 0xFFFFFF00U
 
-/* Register ROGUE_CR_ECC_RAM_ERR_INJ */
-#define ROGUE_CR_ECC_RAM_ERR_INJ 0xF340U
-#define ROGUE_CR_ECC_RAM_ERR_INJ_MASKFULL 0x000000000000001FULL
-#define ROGUE_CR_ECC_RAM_ERR_INJ_SLC_SIDEKICK_SHIFT 4U
-#define ROGUE_CR_ECC_RAM_ERR_INJ_SLC_SIDEKICK_CLRMSK 0xFFFFFFEFU
-#define ROGUE_CR_ECC_RAM_ERR_INJ_SLC_SIDEKICK_EN 0x00000010U
-#define ROGUE_CR_ECC_RAM_ERR_INJ_USC_SHIFT 3U
-#define ROGUE_CR_ECC_RAM_ERR_INJ_USC_CLRMSK 0xFFFFFFF7U
-#define ROGUE_CR_ECC_RAM_ERR_INJ_USC_EN 0x00000008U
-#define ROGUE_CR_ECC_RAM_ERR_INJ_TPU_MCU_L0_SHIFT 2U
-#define ROGUE_CR_ECC_RAM_ERR_INJ_TPU_MCU_L0_CLRMSK 0xFFFFFFFBU
-#define ROGUE_CR_ECC_RAM_ERR_INJ_TPU_MCU_L0_EN 0x00000004U
-#define ROGUE_CR_ECC_RAM_ERR_INJ_RASCAL_SHIFT 1U
-#define ROGUE_CR_ECC_RAM_ERR_INJ_RASCAL_CLRMSK 0xFFFFFFFDU
-#define ROGUE_CR_ECC_RAM_ERR_INJ_RASCAL_EN 0x00000002U
-#define ROGUE_CR_ECC_RAM_ERR_INJ_MARS_SHIFT 0U
-#define ROGUE_CR_ECC_RAM_ERR_INJ_MARS_CLRMSK 0xFFFFFFFEU
-#define ROGUE_CR_ECC_RAM_ERR_INJ_MARS_EN 0x00000001U
-
 /* Register ROGUE_CR_ECC_RAM_INIT_KICK */
 #define ROGUE_CR_ECC_RAM_INIT_KICK 0xF348U
 #define ROGUE_CR_ECC_RAM_INIT_KICK_MASKFULL 0x000000000000001FULL
@@ -6163,6 +6258,26 @@
 #define ROGUE_CR_SAFETY_EVENT_CLEAR__ROGUEXE__GPU_PAGE_FAULT_CLRMSK 0xFFFFFFFEU
 #define ROGUE_CR_SAFETY_EVENT_CLEAR__ROGUEXE__GPU_PAGE_FAULT_EN 0x00000001U
 
+/* Register ROGUE_CR_FAULT_FW_STATUS */
+#define ROGUE_CR_FAULT_FW_STATUS 0xF3B0U
+#define ROGUE_CR_FAULT_FW_STATUS_MASKFULL 0x0000000000010001ULL
+#define ROGUE_CR_FAULT_FW_STATUS_CPU_CORRECT_SHIFT 16U
+#define ROGUE_CR_FAULT_FW_STATUS_CPU_CORRECT_CLRMSK 0xFFFEFFFFU
+#define ROGUE_CR_FAULT_FW_STATUS_CPU_CORRECT_EN 0x00010000U
+#define ROGUE_CR_FAULT_FW_STATUS_CPU_DETECT_SHIFT 0U
+#define ROGUE_CR_FAULT_FW_STATUS_CPU_DETECT_CLRMSK 0xFFFFFFFEU
+#define ROGUE_CR_FAULT_FW_STATUS_CPU_DETECT_EN 0x00000001U
+
+/* Register ROGUE_CR_FAULT_FW_CLEAR */
+#define ROGUE_CR_FAULT_FW_CLEAR 0xF3B8U
+#define ROGUE_CR_FAULT_FW_CLEAR_MASKFULL 0x0000000000010001ULL
+#define ROGUE_CR_FAULT_FW_CLEAR_CPU_CORRECT_SHIFT 16U
+#define ROGUE_CR_FAULT_FW_CLEAR_CPU_CORRECT_CLRMSK 0xFFFEFFFFU
+#define ROGUE_CR_FAULT_FW_CLEAR_CPU_CORRECT_EN 0x00010000U
+#define ROGUE_CR_FAULT_FW_CLEAR_CPU_DETECT_SHIFT 0U
+#define ROGUE_CR_FAULT_FW_CLEAR_CPU_DETECT_CLRMSK 0xFFFFFFFEU
+#define ROGUE_CR_FAULT_FW_CLEAR_CPU_DETECT_EN 0x00000001U
+
 /* Register ROGUE_CR_MTS_SAFETY_EVENT_ENABLE */
 #define ROGUE_CR_MTS_SAFETY_EVENT_ENABLE__ROGUEXE 0xF3D8U
 #define ROGUE_CR_MTS_SAFETY_EVENT_ENABLE__ROGUEXE__MASKFULL 0x000000000000007FULL

-- 
2.49.0


