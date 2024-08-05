Return-Path: <linux-kernel+bounces-274127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CDF5F9473B5
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 05:10:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FFA928112A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 03:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B98EA13CFB7;
	Mon,  5 Aug 2024 03:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G+X6BGU6"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D7C812
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 03:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722827432; cv=none; b=UpiSYrHj+S5/2GLMuyMdG+PEbb2ROYrzjK2q4Cbpmv4DJLHsNp2L3zybIGJjmPMudzRC60IfaViq5PUYSZVFw8mQKNC+aPBbY6RgaD8rHE8FOWDTI9OKi2BnzD1Sy+Pf+VHx2dHvWizLBXkmUtspZWrBhy3xVoRxjAa4015A4bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722827432; c=relaxed/simple;
	bh=sjJi4ci8CSMJ3+1aGEpOmPLYmSgD57qXbtIeGqxxXps=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QZ3+xlujDvlQlVpTAESzuvpTFKiScXXDRU+dE/sYWpF5dgQm5JpItc1V0u+csNlvs0ilZIC3LWAM/6V3gszkn/jYXkkUapWc3HLx7o+Kge0f/6+gB+gZx88zT+f263rQ/HdIpq7Fcy70/o7ydEwNquAgmNNB8VxWvV9puoo/LIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G+X6BGU6; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722827430; x=1754363430;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=sjJi4ci8CSMJ3+1aGEpOmPLYmSgD57qXbtIeGqxxXps=;
  b=G+X6BGU6iQ6VfiXcRT7EX+QKkINDFdRmkx26uGVr4PEKO8rG+3vE/42y
   GyhYtZobXxQ6GYPKrLrgZWBHP8qecmtVf01qk57GSg+6CD46iOVVj4n2B
   byxkQDN88RHL5QTRAUbwnjPuLC5Ys4cbBfXXs25WlF8DbEMtPPt95yw0R
   RqLFUl+TU7hAA0mXORv3N62bgBJqbkyqLMb+d4AUKMPaYhT+4JsFXJgHE
   pke+zSRYmrxS+XEI/MeqmSDfva+UGPVQFu/5eGg9OZcc1hsb9BQQKL2Po
   pNOyD70vtQDnt9slsGZNI6nuohaJQDmJzomYaTCZmvf159PWmHY9vdBYP
   A==;
X-CSE-ConnectionGUID: gh6M6eoIQiS9ohKlFRMlBw==
X-CSE-MsgGUID: meekJmXhRm69rl3u9l0l5A==
X-IronPort-AV: E=McAfee;i="6700,10204,11154"; a="20650829"
X-IronPort-AV: E=Sophos;i="6.09,263,1716274800"; 
   d="scan'208";a="20650829"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2024 20:10:30 -0700
X-CSE-ConnectionGUID: QjZcPaedR0+3m/2U2W4tEg==
X-CSE-MsgGUID: /nt6f/pBQuum6h4f8E10Lg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,263,1716274800"; 
   d="scan'208";a="86587459"
Received: from haibo-optiplex-7090.sh.intel.com ([10.239.153.94])
  by orviesa002.jf.intel.com with ESMTP; 04 Aug 2024 20:10:24 -0700
From: Haibo Xu <haibo1.xu@intel.com>
To: ajones@ventanamicro.com,
	sunilvl@ventanamicro.com
Cc: xiaobo55x@gmail.com,
	Haibo Xu <haibo1.xu@intel.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Gavin Shan <gshan@redhat.com>,
	James Morse <james.morse@arm.com>,
	Hanjun Guo <guohanjun@huawei.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH v2 1/2] RISC-V: ACPI: NUMA: initialize all values of acpi_early_node_map to NUMA_NO_NODE
Date: Mon,  5 Aug 2024 11:30:23 +0800
Message-Id: <0d362a8ae50558b95685da4c821b2ae9e8cf78be.1722828421.git.haibo1.xu@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, only acpi_early_node_map[0] was initialized to NUMA_NO_NODE.
To ensure all the values were properly initialized, switch to initialize
all of them to NUMA_NO_NODE.

Fixes: eabd9db64ea8 ("ACPI: RISCV: Add NUMA support based on SRAT and SLIT")
Reported-by: Andrew Jones <ajones@ventanamicro.com>
Suggested-by: Andrew Jones <ajones@ventanamicro.com>
Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
Reviewed-by: Sunil V L <sunilvl@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
---
 arch/riscv/kernel/acpi_numa.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/acpi_numa.c b/arch/riscv/kernel/acpi_numa.c
index 0231482d6946..ff95aeebee3e 100644
--- a/arch/riscv/kernel/acpi_numa.c
+++ b/arch/riscv/kernel/acpi_numa.c
@@ -28,7 +28,7 @@
 
 #include <asm/numa.h>
 
-static int acpi_early_node_map[NR_CPUS] __initdata = { NUMA_NO_NODE };
+static int acpi_early_node_map[NR_CPUS] __initdata = { [0 ... NR_CPUS - 1] = NUMA_NO_NODE };
 
 int __init acpi_numa_get_nid(unsigned int cpu)
 {
-- 
2.34.1


