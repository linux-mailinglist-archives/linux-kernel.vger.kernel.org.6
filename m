Return-Path: <linux-kernel+bounces-337123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C5619845B0
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 14:14:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A63D1B251CC
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 12:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D672C1A7250;
	Tue, 24 Sep 2024 12:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eC/GlzIe"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFFA01A76B6
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 12:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727180058; cv=none; b=j6XHlat62DIebXSdPFGGFPqhpBIZNc0p1DyL1so3LikU3sEUVAP33ytOjELVB9S2093Q2eNgWUuGfs1BgYPNJmyJ/44zt2RRNlos0nlU1lwx15IemTCdF8y+sPdkEz8RSZG/ZkGVkJpfKCiOMCmziPwYHU1AOuCAXMu/5HHgZTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727180058; c=relaxed/simple;
	bh=J8v7GgpB8rG4dlH7Vt2s0hHP0fI0x25cARwkAg/ekj4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AjEr6LIgNyVF8ltmUopWr6aLywVkA7V5kZZT/1kcMtsvXTUP7ZI0fH6cfB192SFK6WNGPEhFcTuezZyoJ5rIh4IwFT0gn69CNXZFvk2wj4PuzF4b8JsnoSmK/g/72Y+AINpf62ZiD4MfI7LpV1DiWh96+KyNSoprb/CjiziSMB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eC/GlzIe; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727180056; x=1758716056;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=J8v7GgpB8rG4dlH7Vt2s0hHP0fI0x25cARwkAg/ekj4=;
  b=eC/GlzIeHI7TAHLVEzEZbcy6smL2GhARxmqFGgW7Mqc45fGgozt0h8Ym
   riOcwGCOJLEfL85hcga6ziTd4E1fEdxJemKzdnRrKjecd0ul1s86ZH9Jq
   LPwEyA+riHkZdR9LPSZbw15E7JQw9X8o8TOuOPaXb/yRyI/r0IeDl5km+
   S1If2R6il3QHyS0tjgu+JxGCxLIGbbchsTF3zlfHc2bIGhdlL4FKCuQNT
   vh+FIpTJ5n6hybYq17Kvt1FigZG+++sVBzRu3sKkzka5sjdGhoxR0UKav
   AX85QfCo9Xfuyy413g0j/wa6Sm/EVvIr+qZBPa7qkYyxago5fRjzDxzvV
   g==;
X-CSE-ConnectionGUID: JdCmSTdORqerx+WX//+ckA==
X-CSE-MsgGUID: MhAGmj2wRAGJR9Pr4iQaXw==
X-IronPort-AV: E=McAfee;i="6700,10204,11204"; a="29881857"
X-IronPort-AV: E=Sophos;i="6.10,254,1719903600"; 
   d="scan'208";a="29881857"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2024 05:14:16 -0700
X-CSE-ConnectionGUID: wP8ZaTNGTKKOpsAnGV5sPA==
X-CSE-MsgGUID: qWiZ4lveRTW50MLqzR8JqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,254,1719903600"; 
   d="scan'208";a="71473241"
Received: from ccbilbre-mobl3.amr.corp.intel.com (HELO khuang2-desk.gar.corp.intel.com) ([10.124.221.10])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2024 05:14:12 -0700
From: Kai Huang <kai.huang@intel.com>
To: dave.hansen@intel.com,
	bp@alien8.de,
	tglx@linutronix.de,
	peterz@infradead.org,
	mingo@redhat.com,
	hpa@zytor.com,
	kirill.shutemov@linux.intel.com
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	pbonzini@redhat.com,
	seanjc@google.com,
	dan.j.williams@intel.com,
	thomas.lendacky@amd.com,
	rick.p.edgecombe@intel.com,
	isaku.yamahata@intel.com,
	ashish.kalra@amd.com,
	bhe@redhat.com,
	nik.borisov@suse.com,
	sagis@google.com,
	Dave Young <dyoung@redhat.com>
Subject: [PATCH v7 1/5] x86/kexec: do unconditional WBINVD for bare-metal in stop_this_cpu()
Date: Wed, 25 Sep 2024 00:13:53 +1200
Message-ID: <9fe9a391ba5aec1d0ef6246546f4f6cda3263ec8.1727179214.git.kai.huang@intel.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1727179214.git.kai.huang@intel.com>
References: <cover.1727179214.git.kai.huang@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

TL;DR:

Change to do unconditional WBINVD in stop_this_cpu() for bare metal
to cover kexec support for both AMD SME and Intel TDX, despite there
_was_ some issue preventing from doing so but now it has been fixed.

Long version:

Both AMD SME and Intel TDX can leave caches in an incoherent state due
to memory encryption, which can lead to silent memory corruption during
kexec.  To address this issue, it is necessary to flush the caches
before jumping to the second kernel.

Currently, the kernel only performs WBINVD in stop_this_cpu() when SME
is supported by hardware.  To support TDX, instead of adding one more
vendor-specific check, it is proposed to perform unconditional WBINVD.
Kexec() is a slow path, and the additional WBINVD is acceptable for the
sake of simplicity and maintainability.

It is important to note that WBINVD should only be done for bare-metal
scenarios, as TDX guests and SEV-ES/SEV-SNP guests may not handle the
unexpected exception (#VE or #VC) caused by WBINVD.

Note:

Historically, there _was_ an issue preventing doing unconditional WBINVD
but that has been fixed.

When SME kexec() support was initially added in commit

  bba4ed011a52: ("x86/mm, kexec: Allow kexec to be used with SME")

WBINVD was done unconditionally.  However since then some issues were
reported that different Intel systems would hang or reset due to that
commit.

To try to fix, a later commit

  f23d74f6c66c: ("x86/mm: Rework wbinvd, hlt operation in stop_this_cpu()")

then changed to only do WBINVD when hardware supports SME.

While this commit made the reported issues go away, it didn't pinpoint
the root cause.  Also, it forgot to handle a corner case[*], which
resulted in the reveal of the root cause and the final fix by commit

  1f5e7eb7868e: ("x86/smp: Make stop_other_cpus() more robust")

See [1][2] for more information.

Further testing of doing unconditional WBINVD based on the above fix on
the problematic machines (that issues were originally reported)
confirmed the issues couldn't be reproduced.

See [3][4] for more information.

Therefore, it is safe to do unconditional WBINVD for bare-metal now.

[*] The commit didn't check whether the CPUID leaf is available or not.
Making unsupported CPUID leaf on Intel returns garbage resulting in
unintended WBINVD which caused some issue (followed by the analysis and
the reveal of the final root cause).  The corner case was independently
fixed by commit

  9b040453d444: ("x86/smp: Dont access non-existing CPUID leaf")

Link: https://lore.kernel.org/lkml/28a494ca-3173-4072-921c-6c5f5b257e79@amd.com/ [1]
Link: https://lore.kernel.org/lkml/24844584-8031-4b58-ba5c-f85ef2f4c718@amd.com/ [2]
Link: https://lore.kernel.org/lkml/20240221092856.GAZdXCWGJL7c9KLewv@fat_crate.local/ [3]
Link: https://lore.kernel.org/lkml/CALu+AoSZkq1kz-xjvHkkuJ3C71d0SM5ibEJurdgmkZqZvNp2dQ@mail.gmail.com/ [4]
Signed-off-by: Kai Huang <kai.huang@intel.com>
Suggested-by: Borislav Petkov <bp@alien8.de>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Dave Young <dyoung@redhat.com>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
---

v6 -> v7:
 - Use "Link: <permalink>".

v5 -> v6:
 - No change

v4 -> v5:
 - Add Tom's tag

v3 -> v4:
 - Update part of changelog based on Kirill's version (with minor tweak).
 - Use "exception (#VE or #VC)" for TDX and SEV-ES/SEV-SNP in changelog
   and comments.  (Kirill, Tom)
 - Point out "WBINVD is not necessary for TDX and SEV-ES/SEV-SNP guests"
   in the comment.  (Tom)

v2 -> v3:
 - Change to only do WBINVD for bare metal


---
 arch/x86/kernel/process.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index f63f8fd00a91..d1a20501e686 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -813,18 +813,17 @@ void __noreturn stop_this_cpu(void *dummy)
 	mcheck_cpu_clear(c);
 
 	/*
-	 * Use wbinvd on processors that support SME. This provides support
-	 * for performing a successful kexec when going from SME inactive
-	 * to SME active (or vice-versa). The cache must be cleared so that
-	 * if there are entries with the same physical address, both with and
-	 * without the encryption bit, they don't race each other when flushed
-	 * and potentially end up with the wrong entry being committed to
-	 * memory.
+	 * The kernel could leave caches in incoherent state on SME/TDX
+	 * capable platforms.  Flush cache to avoid silent memory
+	 * corruption for these platforms.
 	 *
-	 * Test the CPUID bit directly because the machine might've cleared
-	 * X86_FEATURE_SME due to cmdline options.
+	 * stop_this_cpu() isn't a fast path, just do WBINVD for bare-metal
+	 * to cover both SME and TDX.  It isn't necessary to perform WBINVD
+	 * in a guest and performing one could result in an exception (#VE
+	 * or #VC) for a TDX or SEV-ES/SEV-SNP guest that the guest may
+	 * not be able to handle (e.g., TDX guest panics if it sees #VE).
 	 */
-	if (c->extended_cpuid_level >= 0x8000001f && (cpuid_eax(0x8000001f) & BIT(0)))
+	if (!boot_cpu_has(X86_FEATURE_HYPERVISOR))
 		native_wbinvd();
 
 	/*
-- 
2.46.0


