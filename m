Return-Path: <linux-kernel+bounces-337705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B10D984DD9
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 00:32:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC0821C23B0A
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 22:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 916291AC8A5;
	Tue, 24 Sep 2024 22:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZzaQOQJd"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0D2149E1A;
	Tue, 24 Sep 2024 22:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727217128; cv=none; b=UF9Y9U1mgb50sM7u/b1gbc5qHWOlaEyF7+yS74LOwYbWNHcXQkmSir4vxrx+sVHJNlL44gkePWuspQRs9R7ScWdcWatNvcQ8vvmURR+6kJ0qkRFjOGttSpG79JlA8/bFQk75C+1wzMBGf20CKF1uli4F6RCe6GLkc8jkYaAEajY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727217128; c=relaxed/simple;
	bh=c8oaYASoDJzy6qjAvJLp2ZNenSC2MJuCiZfOeEAKnek=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NgHsEiVx8KRx2Ul1dBCwhFQ2IwyaSfNBx8zBRsH/jQCvmu5Wl0zP5qcDFI4iIRIUY5rRsHpZemiVu65HQM+ymYd9rc4tBo8YtAV5xFLldPsORS1ud0kpPkZjlXym71GGsxoDsY8eCY3LqX79w83PEsDH1igjtd2iHY9J8dGrUUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZzaQOQJd; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727217127; x=1758753127;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=c8oaYASoDJzy6qjAvJLp2ZNenSC2MJuCiZfOeEAKnek=;
  b=ZzaQOQJdtm6HZepevIhzOu6arUQoV6cIOsFLQdF+QfOA2t4H8817fxFJ
   ////y6gXkiJ4vJlYYGLAn3Iu8J4OwVjoWE3xwHSxI0tugl6as5LFOdk2n
   Ff//npoynIypuzfaICOjoHusUZyuou0XQ+7pFoZjZ9k/Z1RgdIDZwBgs/
   ClzkN6xJ0CWaeREGt761GNqegbh03pLXd6BVmqKQnEqoTarrdYp9CrYPp
   aarBsOLjAUVxWN0AeaPmig2AITE4mKtMqv7/1S4eZQy8265yYo9gy4n2L
   FVVaS+1pZ0rWl7wXymGEBEZ3Hs/lWtZ8lHIfslATHjSmJX5isCaxdsZt+
   A==;
X-CSE-ConnectionGUID: EOPmgwBSTBKXGi16Agu1wg==
X-CSE-MsgGUID: yNpRgA0ZTciKd1w0SFlbsA==
X-IronPort-AV: E=McAfee;i="6700,10204,11205"; a="36908068"
X-IronPort-AV: E=Sophos;i="6.10,255,1719903600"; 
   d="scan'208";a="36908068"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2024 15:31:55 -0700
X-CSE-ConnectionGUID: yr/7VWW1S5CeuNIW6wKP0Q==
X-CSE-MsgGUID: 1JD9WR8zRpWlCe1+qoQWiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,255,1719903600"; 
   d="scan'208";a="102384800"
Received: from laijusti-mobl.amr.corp.intel.com (HELO dsneddon-desk.sneddon.lan) ([10.125.17.198])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2024 15:31:54 -0700
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
Subject: [PATCH 3/6] x86/bugs: Remove TAA kernel parameter.
Date: Tue, 24 Sep 2024 15:31:37 -0700
Message-Id: <20240924223140.1054918-4-daniel.sneddon@linux.intel.com>
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

Remove tsx_async_abort kernel parameter since it can be set with the common
clar_cpu_buffers parameter.

Signed-off-by: Daniel Sneddon <daniel.sneddon@linux.intel.com>
---
 .../admin-guide/kernel-parameters.txt         | 41 -------------------
 arch/x86/kernel/cpu/bugs.c                    | 21 ----------
 2 files changed, 62 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 2753a1e51da5..961e637b8126 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -6883,47 +6883,6 @@
 			See Documentation/admin-guide/hw-vuln/tsx_async_abort.rst
 			for more details.
 
-	tsx_async_abort= [X86,INTEL,EARLY] Control mitigation for the TSX Async
-			Abort (TAA) vulnerability.
-
-			Similar to Micro-architectural Data Sampling (MDS)
-			certain CPUs that support Transactional
-			Synchronization Extensions (TSX) are vulnerable to an
-			exploit against CPU internal buffers which can forward
-			information to a disclosure gadget under certain
-			conditions.
-
-			In vulnerable processors, the speculatively forwarded
-			data can be used in a cache side channel attack, to
-			access data to which the attacker does not have direct
-			access.
-
-			This parameter controls the TAA mitigation.  The
-			options are:
-
-			full       - Enable TAA mitigation on vulnerable CPUs
-				     if TSX is enabled.
-
-			full,nosmt - Enable TAA mitigation and disable SMT on
-				     vulnerable CPUs. If TSX is disabled, SMT
-				     is not disabled because CPU is not
-				     vulnerable to cross-thread TAA attacks.
-			off        - Unconditionally disable TAA mitigation
-
-			On MDS-affected machines, tsx_async_abort=off can be
-			prevented by an active MDS mitigation as both vulnerabilities
-			are mitigated with the same mechanism so in order to disable
-			this mitigation, you need to specify mds=off too.
-
-			Not specifying this option is equivalent to
-			tsx_async_abort=full.  On CPUs which are MDS affected
-			and deploy MDS mitigation, TAA mitigation is not
-			required and doesn't provide any additional
-			mitigation.
-
-			For details see:
-			Documentation/admin-guide/hw-vuln/tsx_async_abort.rst
-
 	turbografx.map[2|3]=	[HW,JOY]
 			TurboGraFX parallel port interface
 			Format:
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index ed5524bc3ee4..0a09f0d1a343 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -339,27 +339,6 @@ static void __init taa_select_mitigation(void)
 		cpu_smt_disable(false);
 }
 
-static int __init tsx_async_abort_parse_cmdline(char *str)
-{
-	if (!boot_cpu_has_bug(X86_BUG_TAA))
-		return 0;
-
-	if (!str)
-		return -EINVAL;
-
-	if (!strcmp(str, "off")) {
-		taa_mitigation = TAA_MITIGATION_OFF;
-	} else if (!strcmp(str, "full")) {
-		taa_mitigation = TAA_MITIGATION_VERW;
-	} else if (!strcmp(str, "full,nosmt")) {
-		taa_mitigation = TAA_MITIGATION_VERW;
-		taa_nosmt = true;
-	}
-
-	return 0;
-}
-early_param("tsx_async_abort", tsx_async_abort_parse_cmdline);
-
 #undef pr_fmt
 #define pr_fmt(fmt)	"MMIO Stale Data: " fmt
 
-- 
2.25.1


