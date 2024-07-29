Return-Path: <linux-kernel+bounces-265060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 82D4C93EC05
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 05:51:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B31D51C210AC
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 03:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C21E280BFC;
	Mon, 29 Jul 2024 03:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cVZo8jFW"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7153F2AD15
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 03:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722225067; cv=none; b=JTtolXUSfgBjur0IHw3A1D8abZpFi9FC5enC1hfhJrWZo0KExLxhb+yDf+3LdNN+k42SPT/7QhkEuAsPM0W33PJJ6zc+0LbcDxnJxOIjviQn16ExhrgF63vYxbriigt8Kmtinb5t59dPy0zN9uSYGAgoSvdyWp5a9QJJE5gauMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722225067; c=relaxed/simple;
	bh=ZpwWrfhr0BCpVCzOb3mGLsmOC01fvDnLhqm5077dkm4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ob5YAU9+eyLJJFTBB58vyn9W4RKE9LxNrr81At950AprAG39WHaqYx/yo4eeqXgiBCDs+/LRzD3/0Qv23C9Bpe2Af0kgZkFsIpDSfNu18XSQkpa0QAhzc+/ZdTTLGpFd4Zv10b7CkdRPaVAFJHBuAqh4Fb7HUXQR/h3fHwqemdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cVZo8jFW; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722225065; x=1753761065;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ZpwWrfhr0BCpVCzOb3mGLsmOC01fvDnLhqm5077dkm4=;
  b=cVZo8jFWlYirI+RAL3iSu44diEYV+8dR/KRnmIX/LRH0UMJpYjpSu5C5
   Bp69FIDFzKcTyWkfoCHc/JbF0kkNiwQor3EphpcQF3DK9EMFZL9xiaK0y
   TLLFQ9sAmseCeClHRPc5jMpaVB48ntUjskP8SfCjMzsbkYcOTJfm44Iv3
   8P0TTvCH2CIExd0hgkT6gHSCHNp9pOJXDV6xekgLbt9InHhZpNXlRsm/7
   C/681I45I1K9KllyNX0uqvuHPYYEHO3JUG+lFdyzr0IG7BlsIQ52HpKJJ
   bwIiBxh0b/H8hN+JihOcHCRxyJRuK87MgPqVKfsEAKECJ97LB5VnSbqvg
   w==;
X-CSE-ConnectionGUID: quoBMvN/SZux2SgOJpOxdA==
X-CSE-MsgGUID: hbHb1ga1RPGtLNNcrAp9rQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11147"; a="30615178"
X-IronPort-AV: E=Sophos;i="6.09,245,1716274800"; 
   d="scan'208";a="30615178"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2024 20:39:53 -0700
X-CSE-ConnectionGUID: 0zLNhc/mRxOz496DDR05WA==
X-CSE-MsgGUID: ZPSBfYE3S8WC5jwhC9pzLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,245,1716274800"; 
   d="scan'208";a="58418026"
Received: from haibo-optiplex-7090.sh.intel.com ([10.239.153.94])
  by fmviesa004.fm.intel.com with ESMTP; 28 Jul 2024 20:39:47 -0700
From: Haibo Xu <haibo1.xu@intel.com>
To: sunilvl@ventanamicro.com
Cc: xiaobo55x@gmail.com,
	ajones@ventanamicro.com,
	Haibo Xu <haibo1.xu@intel.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Gavin Shan <gshan@redhat.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	James Morse <james.morse@arm.com>,
	Hanjun Guo <guohanjun@huawei.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH] ACPI: NUMA: initialize all values of acpi_early_node_map to NUMA_NO_NODE
Date: Mon, 29 Jul 2024 11:59:55 +0800
Message-Id: <20240729035958.1957185-1-haibo1.xu@intel.com>
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

Suggested-by: Andrew Jones <ajones@ventanamicro.com>
Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
---
 arch/arm64/kernel/acpi_numa.c | 2 +-
 arch/riscv/kernel/acpi_numa.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/acpi_numa.c b/arch/arm64/kernel/acpi_numa.c
index 0c036a9a3c33..2465f291c7e1 100644
--- a/arch/arm64/kernel/acpi_numa.c
+++ b/arch/arm64/kernel/acpi_numa.c
@@ -27,7 +27,7 @@
 
 #include <asm/numa.h>
 
-static int acpi_early_node_map[NR_CPUS] __initdata = { NUMA_NO_NODE };
+static int acpi_early_node_map[NR_CPUS] __initdata = { [0 ... NR_CPUS - 1] = NUMA_NO_NODE };
 
 int __init acpi_numa_get_nid(unsigned int cpu)
 {
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


