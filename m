Return-Path: <linux-kernel+bounces-575513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 75AF2A7038D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 15:23:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2D01189800A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 14:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3326B25A34B;
	Tue, 25 Mar 2025 14:19:19 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA73A2561C3
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 14:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742912358; cv=none; b=qUkAr+AGjVeDwhxfmc4uaug+eS5mddYr5Gt+lHr1H9ev5kJl3jNuhgKNJkMZ/O3l4wl8JzbHY8u5SC80BKuLrgkail2/CkZUmkixNYyH87Q3F/3FVeyg/TK/FQsySP/E775sTUdN7yRahYd4gC+WpRT01WwKGyPIAuHjImzncPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742912358; c=relaxed/simple;
	bh=8u4Y3ZSLgNRFVySzx54/EIAWbDGZ4w0oYa5xJjD9FSc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IqVAWH5SoIV5V0+l1p7z4UA2QKpi3eKY4aVMRKwYbK5TLWXEFTHGPnlhbOXt3s6wbfndgTAkaGrZA3PxfmQSOOIPgcVt4gQ2k3la1tomyKl2FbgWfocQMLdAM9s7BtOuKVyoWaRihk5Re0IDzpALRCheQicGQ2hU/vCe6vtlOpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4ZMX3m4lHjz1jBLl;
	Tue, 25 Mar 2025 22:14:28 +0800 (CST)
Received: from kwepemg100001.china.huawei.com (unknown [7.202.181.18])
	by mail.maildlp.com (Postfix) with ESMTPS id C7E2F1800B1;
	Tue, 25 Mar 2025 22:19:06 +0800 (CST)
Received: from huawei.com (10.50.165.33) by kwepemg100001.china.huawei.com
 (7.202.181.18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 25 Mar
 2025 22:19:06 +0800
From: Jinqian Yang <yangjinqian1@huawei.com>
To: <catalin.marinas@arm.com>, <will@kernel.org>, <mark.rutland@arm.com>,
	<oliver.upton@linux.dev>, <maz@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<wangzhou1@hisilicon.com>, <shameerali.kolothum.thodi@huawei.com>,
	<liuyonglong@huawei.com>, <jiangkunkun@huawei.com>,
	<yangjinqian1@huawei.comm>, <xueshan2@huawei.com>, Jinqian Yang
	<yangjinqian1@huawei.com>
Subject: [PATCH] arm64: Add support for HIP09 Spectre-BHB mitigation
Date: Tue, 25 Mar 2025 22:19:00 +0800
Message-ID: <20250325141900.2057314-1-yangjinqian1@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemg100001.china.huawei.com (7.202.181.18)

The HIP09 processor is vulnerable to the Spectre-BHB (Branch History
Buffer) attack, which can be exploited to leak information through
branch prediction side channels. This commit adds the MIDR of HIP09
to the list for software mitigation.

Signed-off-by: Jinqian Yang <yangjinqian1@huawei.com>
---
 arch/arm64/include/asm/cputype.h | 2 ++
 arch/arm64/kernel/proton-pack.c  | 1 +
 2 files changed, 3 insertions(+)

diff --git a/arch/arm64/include/asm/cputype.h b/arch/arm64/include/asm/cputype.h
index 6f3f4142e214..363a9cbe780e 100644
--- a/arch/arm64/include/asm/cputype.h
+++ b/arch/arm64/include/asm/cputype.h
@@ -130,6 +130,7 @@
 #define FUJITSU_CPU_PART_A64FX		0x001
 
 #define HISI_CPU_PART_TSV110		0xD01
+#define HISI_CPU_PART_HIP09			0xD02
 
 #define APPLE_CPU_PART_M1_ICESTORM	0x022
 #define APPLE_CPU_PART_M1_FIRESTORM	0x023
@@ -204,6 +205,7 @@
 #define MIDR_NVIDIA_CARMEL MIDR_CPU_MODEL(ARM_CPU_IMP_NVIDIA, NVIDIA_CPU_PART_CARMEL)
 #define MIDR_FUJITSU_A64FX MIDR_CPU_MODEL(ARM_CPU_IMP_FUJITSU, FUJITSU_CPU_PART_A64FX)
 #define MIDR_HISI_TSV110 MIDR_CPU_MODEL(ARM_CPU_IMP_HISI, HISI_CPU_PART_TSV110)
+#define MIDR_HISI_HIP09 MIDR_CPU_MODEL(ARM_CPU_IMP_HISI, HISI_CPU_PART_HIP09)
 #define MIDR_APPLE_M1_ICESTORM MIDR_CPU_MODEL(ARM_CPU_IMP_APPLE, APPLE_CPU_PART_M1_ICESTORM)
 #define MIDR_APPLE_M1_FIRESTORM MIDR_CPU_MODEL(ARM_CPU_IMP_APPLE, APPLE_CPU_PART_M1_FIRESTORM)
 #define MIDR_APPLE_M1_ICESTORM_PRO MIDR_CPU_MODEL(ARM_CPU_IMP_APPLE, APPLE_CPU_PART_M1_ICESTORM_PRO)
diff --git a/arch/arm64/kernel/proton-pack.c b/arch/arm64/kernel/proton-pack.c
index da53722f95d4..98bb7251a184 100644
--- a/arch/arm64/kernel/proton-pack.c
+++ b/arch/arm64/kernel/proton-pack.c
@@ -866,6 +866,7 @@ u8 spectre_bhb_loop_affected(int scope)
 			MIDR_ALL_VERSIONS(MIDR_CORTEX_A76),
 			MIDR_ALL_VERSIONS(MIDR_CORTEX_A77),
 			MIDR_ALL_VERSIONS(MIDR_NEOVERSE_N1),
+			MIDR_ALL_VERSIONS(MIDR_HISI_HIP09),
 			{},
 		};
 		static const struct midr_range spectre_bhb_k11_list[] = {
-- 
2.33.0


