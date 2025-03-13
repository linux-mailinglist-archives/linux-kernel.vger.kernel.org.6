Return-Path: <linux-kernel+bounces-559557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F13E0A5F57F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 14:10:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E852A880818
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 13:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 640D0267AE8;
	Thu, 13 Mar 2025 13:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EzmPzSu7"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22873262817
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 13:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741871326; cv=none; b=iCcw48QlLyqvufHT6k9HpgYzbZ58y3dq2VIG1D/IHZMZtqRGHU2CXWPUfo0f9a5NpiErOyRTXKOi1I5pNCltYGbbQlN+K+jBt+fMCmN7iKCuL2whmNaxQMPasrYza65Rx44wr1yeUaxOnIgq+IMkA4T3Gysui8aHG83/nr8zkl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741871326; c=relaxed/simple;
	bh=ySl0pH5HVZXBPH/qqDQBOVJ45xXXFTj65gXWcnoIcNM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RaURCfUsJK6YMVlZjcx+d2pR2hDooC909l6mtbT4fPzMtNnkpUdkiWeWQzubcwMTjF3ojSESpne+Pkd2yUIhOSZPWhNmBuwVd5xHDfMywHBJIAM90Kg/2Hyw2SmtusOO7UvjSnI7PfkTVUHRC4PpBboAE342Spr9sQyLVk/vFIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EzmPzSu7; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741871324; x=1773407324;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ySl0pH5HVZXBPH/qqDQBOVJ45xXXFTj65gXWcnoIcNM=;
  b=EzmPzSu7lSMz3SZOlVNPlI7eBV0rUSDfByK1IoEcAgYU/7330z/pnZoj
   AeRRe6O/SIufhnMExPw9uwkS3jrHqoPlkTbdUXkmAOh7iG5zy7HP05wlh
   XrvN/2/KmAisQvjJrFcm7nWqMYyZajfbGoYDQHVkFXcpkqliCmRURxDjE
   vEpPbmBbIbp+6mBe3Q+5HXbfYgJ0z93sdXROsmdbAYLGPyeBbf6ZD+6JD
   gZGVxFNmXPp7FYl8xZiIlQ1wsREsnMYVlMIOnbtozfmbwt+nVKj5ZtKYE
   Ao/96Y2PxS6NynFV6gS6nAbVzDwEDSZc/g/781fFj0uvGY17Wa8X6XlSA
   A==;
X-CSE-ConnectionGUID: /3VYPIDqTQ+XrS1LuZoy4w==
X-CSE-MsgGUID: vO/fvATvTQ2F9kYTvKSUPQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11372"; a="53191636"
X-IronPort-AV: E=Sophos;i="6.14,244,1736841600"; 
   d="scan'208";a="53191636"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 06:08:41 -0700
X-CSE-ConnectionGUID: AaeTMGuvRySW6ZNld0lv3w==
X-CSE-MsgGUID: uO7BIq9SQGyrk75IhtQenA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,244,1736841600"; 
   d="scan'208";a="126011494"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orviesa004.jf.intel.com with ESMTP; 13 Mar 2025 06:08:41 -0700
From: kan.liang@linux.intel.com
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	linux-kernel@vger.kernel.org
Cc: Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V2 2/4] perf/x86/intel/uncore: Support customized MMIO map size
Date: Thu, 13 Mar 2025 06:08:45 -0700
Message-Id: <20250313130847.4081079-2-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20250313130847.4081079-1-kan.liang@linux.intel.com>
References: <20250313130847.4081079-1-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kan Liang <kan.liang@linux.intel.com>

For a server platform, the MMIO map size is always 0x4000. However, a
client platform may have a smaller map size.

Make the map size customizable.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---

No changes since V1

 arch/x86/events/intel/uncore_discovery.c | 2 +-
 arch/x86/events/intel/uncore_snbep.c     | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/uncore_discovery.c b/arch/x86/events/intel/uncore_discovery.c
index 8dc9b712dafb..bfd8af90d02d 100644
--- a/arch/x86/events/intel/uncore_discovery.c
+++ b/arch/x86/events/intel/uncore_discovery.c
@@ -655,7 +655,7 @@ void intel_generic_uncore_mmio_init_box(struct intel_uncore_box *box)
 	}
 
 	addr = unit->addr;
-	box->io_addr = ioremap(addr, UNCORE_GENERIC_MMIO_SIZE);
+	box->io_addr = ioremap(addr, type->mmio_map_size);
 	if (!box->io_addr) {
 		pr_warn("Uncore type %d box %d: ioremap error for 0x%llx.\n",
 			type->type_id, unit->id, (unsigned long long)addr);
diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index 60973c209c0e..48e19b26dca6 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -6495,6 +6495,8 @@ static void uncore_type_customized_copy(struct intel_uncore_type *to_type,
 		to_type->get_topology = from_type->get_topology;
 	if (from_type->cleanup_mapping)
 		to_type->cleanup_mapping = from_type->cleanup_mapping;
+	if (from_type->mmio_map_size)
+		to_type->mmio_map_size = from_type->mmio_map_size;
 }
 
 static struct intel_uncore_type **
-- 
2.38.1


