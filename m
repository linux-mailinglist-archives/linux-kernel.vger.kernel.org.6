Return-Path: <linux-kernel+bounces-346319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 67E8598C31D
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 18:19:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 998E71C23BE0
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 16:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6897D1CCB28;
	Tue,  1 Oct 2024 16:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U1dnFUCr"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB9DC1CB334
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 16:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727799060; cv=none; b=rGLTP7ybjFZNwMebC2qMshhbctS+xOQqKBh0BsN7Wtv6ZCztk0f/G6wRBOIeUR+C6LiO+3jhyoFQv/PRWpe3abAQlwc7k7ODHtV2NezsTA3l4EOCf3kq1uEZ+WPQznENnPl34SrSbyM/Btdx30+y+QSCNtz5UKoTxCgQxx044mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727799060; c=relaxed/simple;
	bh=020IFNVs8v20nR2gGfIY28qsRD6d12oC/VrgjCyMxCs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VAmnYe9oARmpiI7bsRlWA+ryiOYxrdgIf5Ob30Toe7LykJe99XVSF1W4891L7canofAnwwnhBbJyk2RxO6+D0HYijiSnjcOfovyKkAp9xjLp1T6RTzfgl4N3WmK3LV8/pgN2/bGInK3sErgjk8RIjzMJvCQF6KEd8+EzjWlInbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U1dnFUCr; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727799058; x=1759335058;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=020IFNVs8v20nR2gGfIY28qsRD6d12oC/VrgjCyMxCs=;
  b=U1dnFUCrc+7D+osj6C1Y6nPrKVkqC2nHrQ3lgXDtE+afQmA6Jg+TgXgS
   HgEW6KzVUeEDkt4grKQG8DpN6Y+RKUtBid+YcVAatdsPyS1jhMmKW2C5t
   GJYkLtqe89CcFTHDnsIuj7dTO0BeeBe6JIpIs/m/k1/aYC2/kUI2yALS1
   BgyzGqDOVW8KAIuUR0tC13O/pI3BZQMoGJPxjNyP2HZls0e3jsXTh96vq
   ajh6SfRu23j858PMoSCV+OKV9YdoVCDCL3InWvMNPmxQxE0BDpFtBdfPi
   7SDl9JawfmP+IEpBLAXp2aY4XLUFU4BED/xxgUj3Z6vADvKBNbFTKPzM4
   A==;
X-CSE-ConnectionGUID: BUJsndZ6TBuu3yS5KJ1cQw==
X-CSE-MsgGUID: bgSNlx8wRCqqcwKvQ1TQJw==
X-IronPort-AV: E=McAfee;i="6700,10204,11212"; a="37539371"
X-IronPort-AV: E=Sophos;i="6.11,167,1725346800"; 
   d="scan'208";a="37539371"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2024 09:10:58 -0700
X-CSE-ConnectionGUID: UrsGFBloSKiKd0F25IFIiQ==
X-CSE-MsgGUID: H5v3WwTlRGCf6MYULlAtoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,167,1725346800"; 
   d="scan'208";a="78585972"
Received: from cbae1-mobl.amr.corp.intel.com (HELO cbae1-mobl.intel.com) ([10.124.136.21])
  by orviesa003.jf.intel.com with ESMTP; 01 Oct 2024 09:10:58 -0700
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	chang.seok.bae@intel.com,
	Yan Hua Wu <yanhua1.wu@intel.com>,
	William Xie <william.xie@intel.com>,
	Ashok Raj <ashok.raj@intel.com>
Subject: [PATCH RFC 1/7] x86/microcode/intel: Remove unnecessary cache writeback and invalidation
Date: Tue,  1 Oct 2024 09:10:36 -0700
Message-Id: <20241001161042.465584-2-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241001161042.465584-1-chang.seok.bae@intel.com>
References: <20241001161042.465584-1-chang.seok.bae@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, an unconditional cache flush is performed during every
microcode update. Although the original changelog did not mention a
specific erratum, this measure was primarily intended to address a
specific microcode bug, the load of which has already been blocked by
is_blacklisted(). Therefore, this cache flush is no longer necessary.

Additionally, the side effects of doing this have been overlooked. It
increases CPU rendezvous time during late loading, where the cache flush
takes between 1x to 3.5x longer than the actual microcode update.

Remove native_wbinvd() and update the erratum name to align with the
latest errata documentation:

    https://cdrdv2.intel.com/v1/dl/getContent/334165
    # Document 334163 Version 022US

Fixes: 91df9fdf5149 ("x86/microcode/intel: Writeback and invalidate caches before updating microcode")
Reported-by: Yan Hua Wu <yanhua1.wu@intel.com>
Reported-by: William Xie <william.xie@intel.com>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Tested-by: Yan Hua Wu <yanhua1.wu@intel.com>
Acked-by: Ashok Raj <ashok.raj@intel.com>
---
The original patch [1] was posted earlier, with a cover letter [2]
providing context on the prior investigation into the cache flush.

Changes in this revision include:
* Added Ashok's acknowledgment tag
* Corrected the subject prefix
* Included the link to the errata documentation in the changelog
* Refined the changelog

This fix is particularly relevant to staging, as the cache flush was
found to significantly increase latency during staged late loading.

[1]: https://lore.kernel.org/all/20240701212012.21499-2-chang.seok.bae@intel.com/
[2]: https://lore.kernel.org/all/20240701212012.21499-1-chang.seok.bae@intel.com/
---
 arch/x86/kernel/cpu/microcode/intel.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
index 815fa67356a2..f3d534807d91 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -319,12 +319,6 @@ static enum ucode_state __apply_microcode(struct ucode_cpu_info *uci,
 		return UCODE_OK;
 	}
 
-	/*
-	 * Writeback and invalidate caches before updating microcode to avoid
-	 * internal issues depending on what the microcode is updating.
-	 */
-	native_wbinvd();
-
 	/* write microcode via MSR 0x79 */
 	native_wrmsrl(MSR_IA32_UCODE_WRITE, (unsigned long)mc->bits);
 
@@ -574,14 +568,14 @@ static bool is_blacklisted(unsigned int cpu)
 	/*
 	 * Late loading on model 79 with microcode revision less than 0x0b000021
 	 * and LLC size per core bigger than 2.5MB may result in a system hang.
-	 * This behavior is documented in item BDF90, #334165 (Intel Xeon
+	 * This behavior is documented in item BDX90, #334165 (Intel Xeon
 	 * Processor E7-8800/4800 v4 Product Family).
 	 */
 	if (c->x86_vfm == INTEL_BROADWELL_X &&
 	    c->x86_stepping == 0x01 &&
 	    llc_size_per_core > 2621440 &&
 	    c->microcode < 0x0b000021) {
-		pr_err_once("Erratum BDF90: late loading with revision < 0x0b000021 (0x%x) disabled.\n", c->microcode);
+		pr_err_once("Erratum BDX90: late loading with revision < 0x0b000021 (0x%x) disabled.\n", c->microcode);
 		pr_err_once("Please consider either early loading through initrd/built-in or a potential BIOS update.\n");
 		return true;
 	}
-- 
2.43.0


