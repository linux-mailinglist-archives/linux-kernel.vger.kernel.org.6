Return-Path: <linux-kernel+bounces-337706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C7EE984DDB
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 00:32:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC8221F216BB
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 22:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DDA21ACDE0;
	Tue, 24 Sep 2024 22:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PR7pBKUe"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD59E1A7AED;
	Tue, 24 Sep 2024 22:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727217129; cv=none; b=Pw1f8SuxKTgARQF5QfiGgY2gGP42J02iQNqO/1c42hXWbKoS+xjxUrHKABGV5pG7m6ya264QqTQZKXRXFfftiTQHqXn7RWyk2YXoQxNrXKV3RqS86lynCEmOJR5BdqGRsi9DVwAApBB6Ik3FIa4wk/VOMxbzqDfU9MEUVtOavAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727217129; c=relaxed/simple;
	bh=U1C9syef2RALEQr4FL1orPy5enhFgsQ2BjicAItgZ5I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LNTKPEgqvMJjuTHeh19p6NS1/doce1H8JKIZABZ24FoIJisH9dfaefC7QqP4OIbMBLld193SufexMktlJmt10kAn5gy6AQ64RluSbLAFcQvVbVoYhEkl2wQQPbpqAZjLOm1eEe6uVuqNO+EwUZnK68rktPg2HM8VRkoTQs0vo/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PR7pBKUe; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727217128; x=1758753128;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=U1C9syef2RALEQr4FL1orPy5enhFgsQ2BjicAItgZ5I=;
  b=PR7pBKUepqA93S/lj6puLas/0HJVTvlaC5SmP1Fo/EQ1YRaRDboYJifH
   ErW/D80t+gfSqu9mM93iJrWuvKLFilPV4f0OcZk6bKi8w0VCJ+liY8kpi
   YfumWiGX73mUhEY/kdS69AZjZO+obksgHswL8NbkZ7SILVp9hY8IIqUNF
   hSIJayY8HhCrvKlbHqb0PCQwY/FN0XbMuFqZK9KGiQm+Bij+ZwTCKo+C0
   Dbk2lQ+F9ELzMJ0jtX2AuiOEtN2KczLMqUML4IqVbt4CeohKCeroJjHD5
   48yJmUChSiCYmExYFFHwg22k11wFcBdvnoozgaWC2VXcWfmVtWsMVJRDQ
   Q==;
X-CSE-ConnectionGUID: kbHCKfXYRAqJ7vNdHdAH0A==
X-CSE-MsgGUID: KRNq2uWTRombsIgbTHta1w==
X-IronPort-AV: E=McAfee;i="6700,10204,11205"; a="36908078"
X-IronPort-AV: E=Sophos;i="6.10,255,1719903600"; 
   d="scan'208";a="36908078"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2024 15:31:57 -0700
X-CSE-ConnectionGUID: YMxg0qk+TKeklxwfEhmOnQ==
X-CSE-MsgGUID: KbaWO2OrT3aozj9ChF9pEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,255,1719903600"; 
   d="scan'208";a="102384822"
Received: from laijusti-mobl.amr.corp.intel.com (HELO dsneddon-desk.sneddon.lan) ([10.125.17.198])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2024 15:31:55 -0700
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
Subject: [PATCH 4/6] x86/bugs: Remove MMIO kernel parameter
Date: Tue, 24 Sep 2024 15:31:38 -0700
Message-Id: <20240924223140.1054918-5-daniel.sneddon@linux.intel.com>
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

Remove mmio_stale_data kernel parameter since it can be set with the common
clear_cpu_buffers parameter.

Signed-off-by: Daniel Sneddon <daniel.sneddon@linux.intel.com>
---
 .../admin-guide/kernel-parameters.txt         | 34 -------------------
 arch/x86/kernel/cpu/bugs.c                    | 21 ------------
 2 files changed, 55 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 961e637b8126..7afccd044fb8 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3498,40 +3498,6 @@
 			log everything. Information is printed at KERN_DEBUG
 			so loglevel=8 may also need to be specified.
 
-	mmio_stale_data=
-			[X86,INTEL,EARLY] Control mitigation for the Processor
-			MMIO Stale Data vulnerabilities.
-
-			Processor MMIO Stale Data is a class of
-			vulnerabilities that may expose data after an MMIO
-			operation. Exposed data could originate or end in
-			the same CPU buffers as affected by MDS and TAA.
-			Therefore, similar to MDS and TAA, the mitigation
-			is to clear the affected CPU buffers.
-
-			This parameter controls the mitigation. The
-			options are:
-
-			full       - Enable mitigation on vulnerable CPUs
-
-			full,nosmt - Enable mitigation and disable SMT on
-				     vulnerable CPUs.
-
-			off        - Unconditionally disable mitigation
-
-			On MDS or TAA affected machines,
-			mmio_stale_data=off can be prevented by an active
-			MDS or TAA mitigation as these vulnerabilities are
-			mitigated with the same mechanism so in order to
-			disable this mitigation, you need to specify
-			mds=off and tsx_async_abort=off too.
-
-			Not specifying this option is equivalent to
-			mmio_stale_data=full.
-
-			For details see:
-			Documentation/admin-guide/hw-vuln/processor_mmio_stale_data.rst
-
 	<module>.async_probe[=<bool>] [KNL]
 			If no <bool> value is specified or if the value
 			specified is not a valid <bool>, enable asynchronous
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 0a09f0d1a343..63a8cda2fe30 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -414,27 +414,6 @@ static void __init mmio_select_mitigation(void)
 		cpu_smt_disable(false);
 }
 
-static int __init mmio_stale_data_parse_cmdline(char *str)
-{
-	if (!boot_cpu_has_bug(X86_BUG_MMIO_STALE_DATA))
-		return 0;
-
-	if (!str)
-		return -EINVAL;
-
-	if (!strcmp(str, "off")) {
-		mmio_mitigation = MMIO_MITIGATION_OFF;
-	} else if (!strcmp(str, "full")) {
-		mmio_mitigation = MMIO_MITIGATION_VERW;
-	} else if (!strcmp(str, "full,nosmt")) {
-		mmio_mitigation = MMIO_MITIGATION_VERW;
-		mmio_nosmt = true;
-	}
-
-	return 0;
-}
-early_param("mmio_stale_data", mmio_stale_data_parse_cmdline);
-
 #undef pr_fmt
 #define pr_fmt(fmt)	"Register File Data Sampling: " fmt
 
-- 
2.25.1


