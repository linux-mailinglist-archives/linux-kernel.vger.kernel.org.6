Return-Path: <linux-kernel+bounces-337704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 472CF984DD7
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 00:32:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77AA91C2354F
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 22:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09F321AC45A;
	Tue, 24 Sep 2024 22:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C39WWmGg"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF338146019;
	Tue, 24 Sep 2024 22:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727217128; cv=none; b=nlNMXDxFs8UkLn/z/NlTlwp9IhLr3834+ndHFxIRcxGh2XA4LLY88NHo5duSw6b+AxaexkAymZEohg37kRfCxtk+mQB0LlDOWOQ5POT6qn1jbJJ7ViEZRsObkJvjGq2gtGANlsANtDQGi7svWueQO3wWmQlaQBMQWdnx7ge1KU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727217128; c=relaxed/simple;
	bh=JHP0kucEu5cNf6IEZdyNVnwiW4oeLVhE0jcwDKFRP2g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YXDIfoXAt6DVBqAD8GZb30YaKuEMRXOeKpWPcNEfG0lpQT2UgqutRLQNhrLcjAQVMV/CiQ6fQnNcupufuwC47gFmR1z2K+5Pr4hYY9hl+ycFuLy5ZCADUexlh8mOWNEKS3XKFouafK+3GNAufeY7fyfUV/9zh8M6Ujv9Ms8Wmsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C39WWmGg; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727217127; x=1758753127;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JHP0kucEu5cNf6IEZdyNVnwiW4oeLVhE0jcwDKFRP2g=;
  b=C39WWmGgrLBDQfDO86yvaq69TCdxY9DqS3NCdVYheKSZP6N3HWPm0Wga
   hdta2jDfROH/LRUC+LcC34JNXgzxwG6i3oEKvoKKj0RqUOol+ZE54UmnJ
   YL3j52lUv6WycNAsjJC+5PWL0+cpRH+GiJ0CtKfURnsEtUwvwGxQPZ2IX
   CnYxdIbhxhkOwxELlit4xWQEEL4ILhO0DEFdmNdmLZtwcPhSFWKxH3mB6
   4qzHP9dSvsvgDnnOE1bOU8HSPXEJkfnBaRVXDgxqdo5oDjwDKZ7RKhOUq
   PzfYiKrWaNE8zk31g3+RD/g/Qb/Ymv9LaXa19r9bh2RFmOW+AHZjOGlDB
   Q==;
X-CSE-ConnectionGUID: swIGsEUwQ5+mAS+BvieOtg==
X-CSE-MsgGUID: aIVcd1IXQf6CVP8kx+XKyQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11205"; a="36908054"
X-IronPort-AV: E=Sophos;i="6.10,255,1719903600"; 
   d="scan'208";a="36908054"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2024 15:31:54 -0700
X-CSE-ConnectionGUID: YWmSlBm4T3+2j1quPKRsHg==
X-CSE-MsgGUID: dx6f5LTfSGeRmGXbU44K1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,255,1719903600"; 
   d="scan'208";a="102384786"
Received: from laijusti-mobl.amr.corp.intel.com (HELO dsneddon-desk.sneddon.lan) ([10.125.17.198])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2024 15:31:52 -0700
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
Subject: [PATCH 2/6] x86/bugs: Remove MDS command line
Date: Tue, 24 Sep 2024 15:31:36 -0700
Message-Id: <20240924223140.1054918-3-daniel.sneddon@linux.intel.com>
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

Remove MDS command line option since it can be set using the common
clar_cpu_buffers parameter.

Signed-off-by: Daniel Sneddon <daniel.sneddon@linux.intel.com>
---
 .../admin-guide/kernel-parameters.txt         | 32 -------------------
 arch/x86/kernel/cpu/bugs.c                    | 21 ------------
 2 files changed, 53 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 66b567c4dce5..2753a1e51da5 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3231,38 +3231,6 @@
 			Format: <first>,<last>
 			Specifies range of consoles to be captured by the MDA.
 
-	mds=		[X86,INTEL,EARLY]
-			Control mitigation for the Micro-architectural Data
-			Sampling (MDS) vulnerability.
-
-			Certain CPUs are vulnerable to an exploit against CPU
-			internal buffers which can forward information to a
-			disclosure gadget under certain conditions.
-
-			In vulnerable processors, the speculatively
-			forwarded data can be used in a cache side channel
-			attack, to access data to which the attacker does
-			not have direct access.
-
-			This parameter controls the MDS mitigation. The
-			options are:
-
-			full       - Enable MDS mitigation on vulnerable CPUs
-			full,nosmt - Enable MDS mitigation and disable
-				     SMT on vulnerable CPUs
-			off        - Unconditionally disable MDS mitigation
-
-			On TAA-affected machines, mds=off can be prevented by
-			an active TAA mitigation as both vulnerabilities are
-			mitigated with the same mechanism so in order to disable
-			this mitigation, you need to specify tsx_async_abort=off
-			too.
-
-			Not specifying this option is equivalent to
-			mds=full.
-
-			For details see: Documentation/admin-guide/hw-vuln/mds.rst
-
 	mem=nn[KMG]	[HEXAGON,EARLY] Set the memory size.
 			Must be specified, otherwise memory size will be 0.
 
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index b3c9e1eede12..ed5524bc3ee4 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -261,27 +261,6 @@ static void __init mds_select_mitigation(void)
 	}
 }
 
-static int __init mds_cmdline(char *str)
-{
-	if (!boot_cpu_has_bug(X86_BUG_MDS))
-		return 0;
-
-	if (!str)
-		return -EINVAL;
-
-	if (!strcmp(str, "off"))
-		mds_mitigation = MDS_MITIGATION_OFF;
-	else if (!strcmp(str, "full"))
-		mds_mitigation = MDS_MITIGATION_FULL;
-	else if (!strcmp(str, "full,nosmt")) {
-		mds_mitigation = MDS_MITIGATION_FULL;
-		mds_nosmt = true;
-	}
-
-	return 0;
-}
-early_param("mds", mds_cmdline);
-
 #undef pr_fmt
 #define pr_fmt(fmt)	"TAA: " fmt
 
-- 
2.25.1


