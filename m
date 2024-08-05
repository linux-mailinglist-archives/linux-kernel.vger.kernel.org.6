Return-Path: <linux-kernel+bounces-274128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61CDF9473BC
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 05:10:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EEA4DB20C55
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 03:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F47813D53B;
	Mon,  5 Aug 2024 03:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EUON4bCr"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08CFF812
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 03:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722827439; cv=none; b=J4Lgoiywgs/JRmJ9pe0efZpiBIPf9TbYfVZ3YNENPVa+mT5ZfC6XFfb/kxl3TBfjSiYUNOZhNyc1HNkMs4CdtihJwOWU5Vb+AKonXdG7RvvY9vCZEWi49HlwQatrNFNPQf3imNxZ/wIjwv0vsNopkC98NkmQHz6KBTj9KewyL28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722827439; c=relaxed/simple;
	bh=qIx1iuVHdoJtgpswxLF4/++ux2wkjECjyNV1k7XLWV8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mQNGXPMLUyY2WxqzaiAHj1mow0ZYKVsCsqhPj68Bb0v/uqb4ow6KxXWv7Jm73ACgpPLknLbbWTdC5W0WhVLbnOp15g5MH08hCiPWMy9UX5+BT8+7/3e6M8k8lOhoUn/0elek+tXSqHSDSSUYLDuliKeAj/+hfEFLJWNuPjJXtsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EUON4bCr; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722827438; x=1754363438;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qIx1iuVHdoJtgpswxLF4/++ux2wkjECjyNV1k7XLWV8=;
  b=EUON4bCrR3SzMFY8tErpGdqRi9pbEGd4w9q3DM/WsQ+zkMkt9NjDOsTx
   orNnGkqFIb9RODOzhADWO+oUYW7k6n57poIhV03XQsZYoKBZl8yV6Q2LJ
   hORel3WCEiEqlldwGbDCCWI/euDyRYjoG6h6/EFnurEI9WzxXnLVb0MVu
   7D8b86fTjlh48GJtglnTlThAz1uzMVj+a+j656Y1Vbx2YD9+QKgLEj9n5
   vkp1M3Kz/zXEj9aXKH5Ux7kW5yJ/lL/0poXzsW1t/UXDjOWrmuvNHDg96
   pLqpRpL9KzpbRrlldHm5Os6tZkBiaOlihqS2XgfkZQgXiHqGm2bXUbsJ9
   Q==;
X-CSE-ConnectionGUID: BkmIcTfDSfCNBF6fkWGugA==
X-CSE-MsgGUID: SFvVEYn6QEmzGgId72cN4Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11154"; a="20650853"
X-IronPort-AV: E=Sophos;i="6.09,263,1716274800"; 
   d="scan'208";a="20650853"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2024 20:10:37 -0700
X-CSE-ConnectionGUID: 6qWHaDcHTeOGQGgVMqLL2g==
X-CSE-MsgGUID: vY3YV1i0Q5u5gHgs3If29A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,263,1716274800"; 
   d="scan'208";a="86587491"
Received: from haibo-optiplex-7090.sh.intel.com ([10.239.153.94])
  by orviesa002.jf.intel.com with ESMTP; 04 Aug 2024 20:10:33 -0700
From: Haibo Xu <haibo1.xu@intel.com>
To: ajones@ventanamicro.com,
	sunilvl@ventanamicro.com
Cc: xiaobo55x@gmail.com,
	Haibo Xu <haibo1.xu@intel.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Hanjun Guo <guohanjun@huawei.com>,
	James Morse <james.morse@arm.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH v2 2/2] arm64: ACPI: NUMA: initialize all values of acpi_early_node_map to NUMA_NO_NODE
Date: Mon,  5 Aug 2024 11:30:24 +0800
Message-Id: <853d7f74aa243f6f5999e203246f0d1ae92d2b61.1722828421.git.haibo1.xu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <0d362a8ae50558b95685da4c821b2ae9e8cf78be.1722828421.git.haibo1.xu@intel.com>
References: <0d362a8ae50558b95685da4c821b2ae9e8cf78be.1722828421.git.haibo1.xu@intel.com>
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

Fixes: e18962491696 ("arm64: numa: rework ACPI NUMA initialization")
Reported-by: Andrew Jones <ajones@ventanamicro.com>
Suggested-by: Andrew Jones <ajones@ventanamicro.com>
Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
Reviewed-by: Sunil V L <sunilvl@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
---
 arch/arm64/kernel/acpi_numa.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

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
-- 
2.34.1


