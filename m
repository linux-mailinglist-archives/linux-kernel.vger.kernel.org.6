Return-Path: <linux-kernel+bounces-542759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6573A4CD57
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 22:13:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CA4317433D
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 21:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70DD423907E;
	Mon,  3 Mar 2025 21:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PMasV+w3"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 595B623642B
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 21:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741036379; cv=none; b=uH/ZrxbRUQWDdHId5ae8Y94ZYC7JXo3fvONC8y4giH5WPpnzauYI1tN29ve+vm/YqhO424kwCjqVPWguxpza0x+RE74IAaaWF4+EQkem6IZTLHQ7EAOi8ZFD91yLwY3TvjJVBtHudjCZ3M0PH4bok5hl7jN4ZU7yFgI1nMNZMEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741036379; c=relaxed/simple;
	bh=IFpKm6pYH22rlTaITTCSYACTHmdZpZqNR8MLKCc9PyA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Lnp8+lLzxne35Iy2mIPIF+3mjpXVe4BBWIERKjkHxgzxgl+ePWkSlmZhxAiFJBWjbHFfJAncAfd6BP4bFUmwUT6ItgI6Ks/eMyOAcblmMreiSxuFd6H44Swfm+VjIzlrKFItcNYqbPRdNhqvfN+PXQ8Z+9j6y+jOaNI14Zl7H0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PMasV+w3; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741036378; x=1772572378;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IFpKm6pYH22rlTaITTCSYACTHmdZpZqNR8MLKCc9PyA=;
  b=PMasV+w3XgB0K1ggronEUPjfAmD+gM7UHDN/kkibR1oi4AQKB65LLnVf
   gfd6MPx2o9yoHdzhnxcLnPAPHgLUimbknipnAE+xIYhI1ZHoghMbBr6Gf
   AWvZwHcz4Esrf8jx6mdhiIofJSSpIu99x4nhftF8jDAYVlTTsXkGFfM/o
   ZLGmTDKslSNaGOvGKvlL7eHeSKGQUUACdubIgFwTpP2Zie/bgCEvyhs5F
   4p8jdQwMNzYyVUXIzQ5lPFY2T83djsHtloM34IWgF+u802vs1/elfN7e0
   gK+IbO0mp9h7FWbgfVkBT6A/VoMqP5u8C9RlDBgLhM5bjn+s6R7cAAIkT
   Q==;
X-CSE-ConnectionGUID: hbQmCP3LSp2Q3WE2CDwEOA==
X-CSE-MsgGUID: vVFXI7xaSzGuoQ/AF0SocA==
X-IronPort-AV: E=McAfee;i="6700,10204,11362"; a="67302365"
X-IronPort-AV: E=Sophos;i="6.13,330,1732608000"; 
   d="scan'208";a="67302365"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 13:12:54 -0800
X-CSE-ConnectionGUID: 5g8HEfisS2it4NZZ0eQstg==
X-CSE-MsgGUID: R/2YZyZbS3e6cI6zxMwqkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,330,1732608000"; 
   d="scan'208";a="123106901"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orviesa003.jf.intel.com with ESMTP; 03 Mar 2025 13:12:55 -0800
From: kan.liang@linux.intel.com
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	linux-kernel@vger.kernel.org
Cc: Kan Liang <kan.liang@linux.intel.com>
Subject: [RESEND PATCH 2/4] perf/x86/intel/uncore: Support customized MMIO map size
Date: Mon,  3 Mar 2025 13:13:04 -0800
Message-Id: <20250303211306.3261160-2-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20250303211306.3261160-1-kan.liang@linux.intel.com>
References: <20250303211306.3261160-1-kan.liang@linux.intel.com>
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


