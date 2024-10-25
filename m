Return-Path: <linux-kernel+bounces-382394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92CB99B0D23
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 20:25:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE90E287C0F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 18:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65FC520EA51;
	Fri, 25 Oct 2024 18:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="E0L114QL"
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EDA120EA2F
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 18:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729880657; cv=none; b=kUYy1fHCK7BNCBwXMqcP7GXFeSYp4aUcnRfY8RzJz04oCjZW+TzXkNCzzUPvg56h4EbofQBdgf8kD12AmA9yOgBlLFIJ3UnU80f1fr/eBeptRS3/Irb91QfaVg3gxHrhjKNzp2MpyZO1IeQC7/59mW1nEJsGe18iKRqQMmZTMH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729880657; c=relaxed/simple;
	bh=QK86OF+M6Cnw2Q+RRRDm2E/w+KGWMmdJhG0adCArxK0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kXXTF9PLVTAB32ONIKCin9Vx+sXa5xnEYf1BEEVMf6UcUF4LWROMh35ZqdzHN07iWEDGnUZgYk0YAxR5rn9A2dLjvjVmw8W4VXg9j4wpeu85k4Vr3XociQ7NaSPltjE6AcgFc1jX2pwd+zUn3Y4hHaG9Tfdp+A7EhVYJTP0fXWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=E0L114QL; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729880652;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4wt7hpGsUlZRR1MZ3fpe3CXoXzKibMI0SDo4lB5jVPg=;
	b=E0L114QLgltFCgRG6Xy5/Zqz8lHJUkqPukCPSaQz59FYFykUgrTSG+jR7y81Sq2JXIQ2hK
	9f92rYIW3JKXdu53D86AsxWmCXRTNx3pdgWPKb7qPdoI0FDpWWIn9ncUtRs6n+7slEc0rD
	6daq2Kplo1Zu1mSaJPSq2foCC2x4WDI=
From: Oliver Upton <oliver.upton@linux.dev>
To: kvmarm@lists.linux.dev
Cc: Marc Zyngier <maz@kernel.org>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Oliver Upton <oliver.upton@linux.dev>
Subject: [PATCH v4 03/18] arm64: sysreg: Migrate MDCR_EL2 definition to table
Date: Fri, 25 Oct 2024 18:23:38 +0000
Message-ID: <20241025182354.3364124-4-oliver.upton@linux.dev>
In-Reply-To: <20241025182354.3364124-1-oliver.upton@linux.dev>
References: <20241025182354.3364124-1-oliver.upton@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Migrate MDCR_EL2 over to the sysreg table and align definitions with
DDI0601 2024-09.

Signed-off-by: Oliver Upton <oliver.upton@linux.dev>
---
 arch/arm64/include/asm/kvm_arm.h | 29 --------------------------
 arch/arm64/tools/sysreg          | 35 ++++++++++++++++++++++++++++++++
 2 files changed, 35 insertions(+), 29 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_arm.h b/arch/arm64/include/asm/kvm_arm.h
index 109a85ee6910..fb8d15f299a4 100644
--- a/arch/arm64/include/asm/kvm_arm.h
+++ b/arch/arm64/include/asm/kvm_arm.h
@@ -311,35 +311,6 @@
 				 GENMASK(19, 18) |	\
 				 GENMASK(15, 0))
 
-/* Hyp Debug Configuration Register bits */
-#define MDCR_EL2_E2TB_MASK	(UL(0x3))
-#define MDCR_EL2_E2TB_SHIFT	(UL(24))
-#define MDCR_EL2_HPMFZS		(UL(1) << 36)
-#define MDCR_EL2_HPMFZO		(UL(1) << 29)
-#define MDCR_EL2_MTPME		(UL(1) << 28)
-#define MDCR_EL2_TDCC		(UL(1) << 27)
-#define MDCR_EL2_HLP		(UL(1) << 26)
-#define MDCR_EL2_HCCD		(UL(1) << 23)
-#define MDCR_EL2_TTRF		(UL(1) << 19)
-#define MDCR_EL2_HPMD		(UL(1) << 17)
-#define MDCR_EL2_TPMS		(UL(1) << 14)
-#define MDCR_EL2_E2PB_MASK	(UL(0x3))
-#define MDCR_EL2_E2PB_SHIFT	(UL(12))
-#define MDCR_EL2_TDRA		(UL(1) << 11)
-#define MDCR_EL2_TDOSA		(UL(1) << 10)
-#define MDCR_EL2_TDA		(UL(1) << 9)
-#define MDCR_EL2_TDE		(UL(1) << 8)
-#define MDCR_EL2_HPME		(UL(1) << 7)
-#define MDCR_EL2_TPM		(UL(1) << 6)
-#define MDCR_EL2_TPMCR		(UL(1) << 5)
-#define MDCR_EL2_HPMN_MASK	(UL(0x1F))
-#define MDCR_EL2_RES0		(GENMASK(63, 37) |	\
-				 GENMASK(35, 30) |	\
-				 GENMASK(25, 24) |	\
-				 GENMASK(22, 20) |	\
-				 BIT(18) |		\
-				 GENMASK(16, 15))
-
 /*
  * FGT register definitions
  *
diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
index 5670e51a6f90..7061cf2d8444 100644
--- a/arch/arm64/tools/sysreg
+++ b/arch/arm64/tools/sysreg
@@ -2414,6 +2414,41 @@ Field	1	AFSR1_EL1
 Field	0	AFSR0_EL1
 EndSysregFields
 
+Sysreg MDCR_EL2		3	4	1	1	1
+Res0	63:51
+Field	50	EnSTEPOP
+Res0	49:44
+Field	43	EBWE
+Res0	42
+Field	41:40	PMEE
+Res0	39:37
+Field	36	HPMFZS
+Res0	35:32
+Field	31:30	PMSSE
+Field	29	HPMFZO
+Field	28	MTPME
+Field	27	TDCC
+Field	26	HLP
+Field	25:24	E2TB
+Field	23	HCCD
+Res0	22:20
+Field	19	TTRF
+Res0	18
+Field	17	HPMD
+Res0	16
+Field	15	EnSPM
+Field	14	TPMS
+Field	13:12	E2PB
+Field	11	TDRA
+Field	10	TDOSA
+Field	9	TDA
+Field	8	TDE
+Field	7	HPME
+Field	6	TPM
+Field	5	TPMCR
+Field	4:0	HPMN
+EndSysreg
+
 Sysreg HFGRTR_EL2	3	4	1	1	4
 Fields	HFGxTR_EL2
 EndSysreg
-- 
2.47.0.163.g1226f6d8fa-goog


