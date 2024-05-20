Return-Path: <linux-kernel+bounces-184244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9230F8CA4A1
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 00:49:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C39071C20FF7
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 22:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 257FD13B5AF;
	Mon, 20 May 2024 22:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PoXzJOBm"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0828A13AA43
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 22:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716245205; cv=none; b=dalsPhmtaUC/cwMXWINxx+y81s5FxVNqIHCLR89r6WXTbPqaVtxKAjw8OXIAIjk2wE2rHhh0rHaNZfIaCxNxXEjzATGAuvEBjGjviNZyGm8vNmIPgvpOJ/ciM9IVm8OqfqKO3/jz0wCCDWE1K1/+cnLBkfb4TBOYIdgxguHGATA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716245205; c=relaxed/simple;
	bh=+UQNNygVvHL0lbB54Mr3z0CgDvDdGlE3GhIkG4XeQL0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E5S3+SetxEJHYukHf5jF8Kl4ImOap3ivYQt8jAjqeRAFdxMrtyvhtYGTGaAvV+koWLGg3XNbTwpMYVQSQMdtrnCc9ftBf7aaB8zXi3GsXpOqh2wB6u893PQvE7Zo9SGTeQHTkZAZRee1l279zMPQhR7Vit6sYyF4Y9SIKQl/sZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PoXzJOBm; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716245204; x=1747781204;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+UQNNygVvHL0lbB54Mr3z0CgDvDdGlE3GhIkG4XeQL0=;
  b=PoXzJOBmW8RJq2P6HyDVipxV1lMx1hPv6O9BrPmlW/vhNSapEXZ4rW8N
   kG5ueVE5R9GEtlm1mHhnQqVBvOLoQXCGlvrNCQbfkUZa2If4yk1eDGs8P
   eoXrEgYLAJ3ikxcSeK+PnamGI0Qd6ML4voDmVD9U2qDoeALJHaYp26/UT
   peMpOYf5an7GkB6TTfX2N2GLEnTh7kPBA0X/Qo7hNn5/ZzeR2NSOzkyGt
   dS0ZWtPnB1kfHTMyCdgB/r802396QMYoEnAsUch/sA2+bOLcn3EApYRtC
   jDc3f2a3ZurB2TOUkSNjWHP1eY45Y8u545iFP8xoJPZ4RmX8x+8OibMLc
   g==;
X-CSE-ConnectionGUID: JSOWwr4NQYCbJfuiRWSg3w==
X-CSE-MsgGUID: 22Ln9z02RXOEa4b8A7JDfQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11078"; a="12199678"
X-IronPort-AV: E=Sophos;i="6.08,176,1712646000"; 
   d="scan'208";a="12199678"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2024 15:46:37 -0700
X-CSE-ConnectionGUID: taxNCoufTfmAQsh/88M6PA==
X-CSE-MsgGUID: oeQaGbR7Qj2nAkjo+F4IZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,176,1712646000"; 
   d="scan'208";a="32593430"
Received: from agluck-desk3.sc.intel.com ([172.25.222.70])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2024 15:46:37 -0700
From: Tony Luck <tony.luck@intel.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Uros Bizjak <ubizjak@gmail.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Tony Luck <tony.luck@intel.com>,
	Mateusz Guzik <mjguzik@gmail.com>,
	Thomas Renninger <trenn@suse.de>,
	Andi Kleen <ak@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	Andy Shevchenko <andy@kernel.org>
Subject: [PATCH v6 16/49] x86/platform/intel-mid: Switch to new Intel CPU model defines
Date: Mon, 20 May 2024 15:45:47 -0700
Message-ID: <20240520224620.9480-17-tony.luck@intel.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240520224620.9480-1-tony.luck@intel.com>
References: <20240520224620.9480-1-tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

New CPU #defines encode vendor and family as well as model.

Signed-off-by: Tony Luck <tony.luck@intel.com>
Acked-by: Andy Shevchenko <andy@kernel.org>
---
 arch/x86/platform/intel-mid/intel-mid.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/x86/platform/intel-mid/intel-mid.c b/arch/x86/platform/intel-mid/intel-mid.c
index 7be71c2cdc83..8b8173fb0a43 100644
--- a/arch/x86/platform/intel-mid/intel-mid.c
+++ b/arch/x86/platform/intel-mid/intel-mid.c
@@ -22,6 +22,7 @@
 #include <asm/mpspec_def.h>
 #include <asm/hw_irq.h>
 #include <asm/apic.h>
+#include <asm/cpu_device_id.h>
 #include <asm/io_apic.h>
 #include <asm/intel-mid.h>
 #include <asm/io.h>
@@ -55,9 +56,9 @@ static void __init intel_mid_time_init(void)
 
 static void intel_mid_arch_setup(void)
 {
-	switch (boot_cpu_data.x86_model) {
-	case 0x3C:
-	case 0x4A:
+	switch (boot_cpu_data.x86_vfm) {
+	case INTEL_HASWELL:
+	case INTEL_ATOM_SILVERMONT_MID:
 		x86_platform.legacy.rtc = 1;
 		break;
 	default:
-- 
2.45.0


