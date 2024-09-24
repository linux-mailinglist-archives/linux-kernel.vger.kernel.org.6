Return-Path: <linux-kernel+bounces-337702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D0623984DD3
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 00:32:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8464B1F21C5A
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 22:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46C431474A5;
	Tue, 24 Sep 2024 22:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WfVj78TD"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00554146A6C;
	Tue, 24 Sep 2024 22:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727217126; cv=none; b=JTGDADw2L3jX/ya4lmsGtGr+gGNrEegp870oKlTxlKauF/QJNANMwn7IDcBvrwOvxix0oZayDawp13byTvkx5oZlWYu697yflTvxoy+J8oETQkKpZdLI/9NXAjOrChavX/eD29IcCDUzb6tCToFeb6JSGUC2KkRfQZfoEhpPFPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727217126; c=relaxed/simple;
	bh=zWD3/hrw9NBGVzXNUXaFiaMtx2BgEk+Qq27PFVjELSk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WwRU6JwDpppwNIpBTdENVZ6bcJm46Dr1e6qjC4rwdjqn2shE0Dcqc1IJfWgd3nnd+rZ8oddpZhLl80V4ycx7rYQwH8jCUjhd3xw6yT6rhcVCvFXgQTSqFtbwWtvmlEHDBEGJTp+8U9KdzLJv7ZKeYGc3CGPkk/kuumUFfbpK2pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WfVj78TD; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727217125; x=1758753125;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zWD3/hrw9NBGVzXNUXaFiaMtx2BgEk+Qq27PFVjELSk=;
  b=WfVj78TDxSiUi1z3gq67FObECse0HPZXMd3HZxWqCXRzpNxWSZQiGT8v
   6KCqik+7DSglF73t73G5BwJXtNYxLQsw8IN9x3aWSwfqYXF0TZHXTdR2f
   fok1rYUhqlzyoB/hOThMGw3swMLM7XjCQXo2yFNHxL9ksHnE6p1x9h4Um
   83N3CpCT1iA22pGIoZDJOWJhhxMMjSi5+8KRS1+YEZsTGeNbP7PVCqYHE
   oitp4EODxQSiqffSg/+bHFI+sbJHIHOBxGcAomptPNYvHOphoxvs63Vc+
   MfIWv9fUMOg3Zu5dMz0WaV3I5YFvntEm4PWbvMmkXi+Hhh9DNx8GkETEs
   w==;
X-CSE-ConnectionGUID: BBALKv7HTOe+G7j5gEjugA==
X-CSE-MsgGUID: Nbp4fyjdSviAx/Shb8zmnw==
X-IronPort-AV: E=McAfee;i="6700,10204,11205"; a="36908043"
X-IronPort-AV: E=Sophos;i="6.10,255,1719903600"; 
   d="scan'208";a="36908043"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2024 15:31:52 -0700
X-CSE-ConnectionGUID: lIDJBlAYTZm0OwxbQXV2XQ==
X-CSE-MsgGUID: 0TdwgHPBQ1OuLqRzui+wmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,255,1719903600"; 
   d="scan'208";a="102384766"
Received: from laijusti-mobl.amr.corp.intel.com (HELO dsneddon-desk.sneddon.lan) ([10.125.17.198])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2024 15:31:51 -0700
From: Daniel Sneddon <daniel.sneddon@linux.intel.com>
To: Jonathan Corbet <corbet@lwn.net>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org
Cc: hpa@zytor.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pawan.kumar.gupta@linux.intel.com
Subject: [PATCH 1/6] x86/bugs: Create single parameter for VERW based mitigations
Date: Tue, 24 Sep 2024 15:31:35 -0700
Message-Id: <20240924223140.1054918-2-daniel.sneddon@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240924223140.1054918-1-daniel.sneddon@linux.intel.com>
References: <20240924223140.1054918-1-daniel.sneddon@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are currently 4 mitigations that use VERW to flush different cpu
buffers. This can cause confusion when trying to disable all the
different VERW mitigations. Simplify enabling/disabling these
mitigations by creating a single parameter for controlling them.

Future work will focus on combining similar code used in selecting
these mitigations to further simplify.

Signed-off-by: Daniel Sneddon <daniel.sneddon@linux.intel.com>
---
 .../admin-guide/kernel-parameters.txt         | 16 +++++++++
 arch/x86/kernel/cpu/bugs.c                    | 34 +++++++++++++++++++
 2 files changed, 50 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 09126bb8cc9f..66b567c4dce5 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -628,6 +628,21 @@
 	cio_ignore=	[S390]
 			See Documentation/arch/s390/common_io.rst for details.
 
+	clear_cpu_buffers=
+			[X86]
+			Controls the mitigations that use
+			X86_FEATURE_CLEAR_CPU_BUF, namely
+			Micro-architectrual Data Sampling (MDS)
+			MMIO Stale Data
+			TSX Async Abort (TAA)
+			Register File Data Sampling (RFDS)
+
+			The options are:
+			on		- Enable cpu buffer clearing
+			on,nosmt	- Enable cpu buffer clearing and disable
+					  SMT
+			off		- Disables cpu buffer clearing
+
 	clearcpuid=X[,X...] [X86]
 			Disable CPUID feature X for the kernel. See
 			arch/x86/include/asm/cpufeatures.h for the valid bit
@@ -3461,6 +3476,7 @@
 				improves system performance, but it may also
 				expose users to several CPU vulnerabilities.
 				Equivalent to: if nokaslr then kpti=0 [ARM64]
+					       clear_cpu_buffers=off [X86]
 					       gather_data_sampling=off [X86]
 					       kvm.nx_huge_pages=off [X86]
 					       l1tf=off [X86]
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 45675da354f3..b3c9e1eede12 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -531,6 +531,40 @@ early_param("reg_file_data_sampling", rfds_parse_cmdline);
 #undef pr_fmt
 #define pr_fmt(fmt)     "" fmt
 
+static int __init clear_cpu_buffers_cmdline(char *str)
+{
+	if (!str)
+		return -EINVAL;
+
+	if (!boot_cpu_has_bug(X86_BUG_MDS) &&
+	    !boot_cpu_has_bug(X86_BUG_TAA) &&
+	    !boot_cpu_has_bug(X86_BUG_MMIO_STALE_DATA) &&
+	    !boot_cpu_has_bug(X86_BUG_RFDS))
+		return 0;
+
+	if (!strcmp(str, "off")) {
+		mds_mitigation = MDS_MITIGATION_OFF;
+		taa_mitigation = TAA_MITIGATION_OFF;
+		mmio_mitigation = MMIO_MITIGATION_OFF;
+		rfds_mitigation = RFDS_MITIGATION_OFF;
+	} else if (!strcmp(str, "on")) {
+		mds_mitigation = MDS_MITIGATION_FULL;
+		taa_mitigation = TAA_MITIGATION_VERW;
+		mmio_mitigation = MMIO_MITIGATION_VERW;
+		rfds_mitigation = RFDS_MITIGATION_VERW;
+	} else if (!strcmp(str, "on,nosmt")) {
+		mds_mitigation = MDS_MITIGATION_FULL;
+		taa_mitigation = TAA_MITIGATION_VERW;
+		mmio_mitigation = MMIO_MITIGATION_VERW;
+		rfds_mitigation = RFDS_MITIGATION_VERW;
+		mds_nosmt = true;
+		taa_nosmt = true;
+		mmio_nosmt = true;
+	}
+	return 0;
+}
+early_param("clear_cpu_buffers", clear_cpu_buffers_cmdline);
+
 static void __init md_clear_update_mitigation(void)
 {
 	if (cpu_mitigations_off())
-- 
2.25.1


