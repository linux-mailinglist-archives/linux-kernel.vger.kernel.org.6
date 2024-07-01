Return-Path: <linux-kernel+bounces-237058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D93891EA6B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 23:37:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC76A283B20
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 21:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 281E4171E52;
	Mon,  1 Jul 2024 21:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DgXDedHz"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E89C716F831
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 21:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719869829; cv=none; b=MY47Ab+hPfqelBiCJqF6HwqT2vAf0B7mBvgR0gPTBg0iVv7c0AeObK6Vyt1QWZAz70U8ClS4NQMZ4ApuXZsXbIoGiPM3BVIj1FlZY4pLTzxIiZhGuzEF1+n31LnTkdUe34YpXCxkLcbI9OVSNvEUs7MJW5eFX1KkMotEnkuBYUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719869829; c=relaxed/simple;
	bh=zYFcS/mAY8Y1smJXouJkcNRDcnplrvX8orck+zV0CzI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bEG2WOnA6VZ5FJks5eGujKjGXpwPXXjTJZyC5W5YeVdPGI3H/lVy5d+WdfMQtAzHkbbddjRTGF+0iYkmQXOu3b+uf/LC95/77wItLhZBMwEVRYKfugzWLioedRu9VjxPWBcru0x4+IGEDksDMgB89/Mf8QlIkSqu98eB/hKB9vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DgXDedHz; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719869828; x=1751405828;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zYFcS/mAY8Y1smJXouJkcNRDcnplrvX8orck+zV0CzI=;
  b=DgXDedHzCWvT75bgnR7AerCwaj+6QnE/ew92aLusDLXrsZBX1hR42jAX
   pvltsC5DzjHxy4+l5NgETUVGkB+hsK9i7wBdglQ8orCPtVVxTAIWTPKUN
   wYdcrbxEUrMEiy976ct312VRSh5W90RsoZC480xFR8iURiBSTDPVN9iLD
   +l8UVHMQ3B+YUkA0WKQjHtAe3zrflVlRFNki0R4QKbRYcPpWemdUYLK8G
   PKgjGosdCk1IkkA5q0D0/MvRxFHnkVAbYAU86VUx6HBizC6PboQ9lFWDt
   dQdhkE3l8b3ANQbPuMMMjoIu0IZwXJA4WaiAf2svQHHAeFJvjpbldOHrm
   A==;
X-CSE-ConnectionGUID: Qy7uMcT8Siq0R9ofT9mQfA==
X-CSE-MsgGUID: xngS5lEURfmj1deeFqqN7w==
X-IronPort-AV: E=McAfee;i="6700,10204,11120"; a="16685006"
X-IronPort-AV: E=Sophos;i="6.09,177,1716274800"; 
   d="scan'208";a="16685006"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2024 14:37:05 -0700
X-CSE-ConnectionGUID: hV9IZlhsSC6b8tFJnSJWhA==
X-CSE-MsgGUID: yfFGstZkTmeGYoyJG95kiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,177,1716274800"; 
   d="scan'208";a="46093048"
Received: from chang-linux-3.sc.intel.com ([172.25.66.177])
  by orviesa006.jf.intel.com with ESMTP; 01 Jul 2024 14:37:05 -0700
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	tony.luck@intel.com,
	ashok.raj@intel.com,
	chang.seok.bae@intel.com,
	Yan Hua Wu <yanhua1.wu@intel.com>,
	William Xie <william.xie@intel.com>
Subject: [PATCH 1/1] arch/x86/microcode/intel: Remove unnecessary cache writeback and invalidation
Date: Mon,  1 Jul 2024 14:20:12 -0700
Message-Id: <20240701212012.21499-2-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240701212012.21499-1-chang.seok.bae@intel.com>
References: <20240701212012.21499-1-chang.seok.bae@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, an unconditional cache flush is conducted during every
microcode update. Although its changelog did not specify any erratum,
this was primarily intended to address a specific microcode bug, a load
of which has already been blocked by is_blacklisted(). Therefore, this
flush is unnecessary.

Additionally, the side effects of doing this have been overlooked. It
extends the CPU rendezvous time for late loading. The cache flush takes
about 1x to 3.5x more time than needed for updating the microcode.

Remove native_wbinvd() and update the erratum name to align with the
latest errata documentation.

Fixes: 91df9fdf5149 ("x86/microcode/intel: Writeback and invalidate caches before updating microcode")
Reported-by: Yan Hua Wu <yanhua1.wu@intel.com>
Reported-by: William Xie <william.xie@intel.com>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Tested-by: Yan Hua Wu <yanhua1.wu@intel.com>
---
Note: Errata names have been updated from BDF to BDX according to the
latest documentation:
https://www.intel.com/content/dam/www/public/us/en/documents/specification-updates/xeon-e7-v4-spec-update.pdf
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
2.34.1


