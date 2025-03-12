Return-Path: <linux-kernel+bounces-557620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F41FCA5DBA2
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 12:34:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27D9F174888
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 11:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6987D1E51EE;
	Wed, 12 Mar 2025 11:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mf5Tf8j6"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1190C23F38A
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 11:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741779284; cv=none; b=ZkNBSlC8Chc8so3zD2bHuHGK2Z4qt2wZ03PmJUirQtl4YflA2g/wDe7NKWQe8cmcWWCXYG1zpvkITdPreijvkl4Z+BRcDTOHG4pqnew0eEI7m94qobrqtFFQ5KzxswkUBG6k6tz1WXvgfRv5t7zH+gnPgRkFteRF7feJrxA7FS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741779284; c=relaxed/simple;
	bh=EfG/g3ntDBqLTUOmxcrU8a+zoCSn9m09nTwIQsOjBis=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=foIb27Bdw+B1W9sp6iMFJuxbSyg5JIfNXLwxdRBLYmYFkny4IxR+W8Vv6Cutda50INEAmv7oJOAdU4GRaLYE2bercaq0pYMQbJGw1YTPOqszrSbVWtxgUwVPeb0crfpiW+c4uv5UKYna0F/CLRX2QFsq6WiCOeIgDG8X3hVPj2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mf5Tf8j6; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741779283; x=1773315283;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EfG/g3ntDBqLTUOmxcrU8a+zoCSn9m09nTwIQsOjBis=;
  b=mf5Tf8j6cg8UPKCClduE0odXEf7Yylwoeo758YRHoDI2ZeMonBNscDRp
   fp6wsivs52BhNwXloa9/VFJOQ3Tvt7O8nur2Suau9geGTDC3pk2OaOjF7
   Q6UNZshu7vBiO74haoRBtLh5T6/Cs5JTMY+/HLk3Mr77daB01ixgzZKk2
   SYuypCTsbJj0ZYxqkqMN/eSa523vf+SNj1ieaYDmeQW7+9WgE5FBjQQGx
   Gt+kkbpDn7AbGT8nxNOfP5vqrvcFPqKM/QMdqpTOeBKnemR4OxOnNowbK
   9IFCCzj5R1znE50WtKK357wSEQ3e87eq7fHkRDpklg8+CYKCyyRFYQkke
   Q==;
X-CSE-ConnectionGUID: G8Nj4U3aQiinA6W7qyezQw==
X-CSE-MsgGUID: 3Isk6VHiT4uURUs4n4wQZQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11370"; a="42985135"
X-IronPort-AV: E=Sophos;i="6.14,241,1736841600"; 
   d="scan'208";a="42985135"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 04:34:42 -0700
X-CSE-ConnectionGUID: 0TdLM2mxTsaS+ye9OUh2Tw==
X-CSE-MsgGUID: iW2MqBzpSdeN0peTCAChNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,241,1736841600"; 
   d="scan'208";a="124775987"
Received: from iweiny-desk3.amr.corp.intel.com (HELO khuang2-desk.gar.corp.intel.com) ([10.124.221.164])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 04:34:37 -0700
From: Kai Huang <kai.huang@intel.com>
To: dave.hansen@intel.com,
	bp@alien8.de,
	tglx@linutronix.de,
	peterz@infradead.org,
	mingo@redhat.com,
	kirill.shutemov@linux.intel.com
Cc: hpa@zytor.com,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	pbonzini@redhat.com,
	seanjc@google.com,
	rick.p.edgecombe@intel.com,
	reinette.chatre@intel.com,
	isaku.yamahata@intel.com,
	dan.j.williams@intel.com,
	thomas.lendacky@amd.com,
	ashish.kalra@amd.com,
	dwmw@amazon.co.uk,
	bhe@redhat.com,
	nik.borisov@suse.com,
	sagis@google.com,
	Dave Young <dyoung@redhat.com>
Subject: [RFC PATCH 1/5] x86/kexec: Do unconditional WBINVD for bare-metal in stop_this_cpu()
Date: Thu, 13 Mar 2025 00:34:13 +1300
Message-ID: <e9ee3c7ffc3ba6feb97247faa40789684e39ffd0.1741778537.git.kai.huang@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1741778537.git.kai.huang@intel.com>
References: <cover.1741778537.git.kai.huang@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

TL;DR:

Change to do unconditional WBINVD in stop_this_cpu() for bare metal to
cover kexec support for both AMD SME and Intel TDX.  Previously there
_was_ some issue preventing from doing so but now it has been fixed.

Long version:

AMD SME uses the C-bit to determine whether to encrypt the memory or
not.  For the same physical memory address, dirty cachelines with and
without the C-bit can coexist and the CPU can flush them back to memory
in random order.  To support kexec for SME, the old kernel uses WBINVD
to flush cache before booting to the new kernel so that no stale dirty
cacheline are left over by the old kernel which could otherwise corrupt
the new kernel's memory.

TDX uses 'KeyID' bits in the physical address for memory encryption and
has the same requirement.  To support kexec for TDX, the old kernel
needs to flush cache of TDX private memory.

Currently, the kernel only performs WBINVD in stop_this_cpu() when SME
is supported by hardware.  Perform unconditional WBINVD to support TDX
instead of adding one more vendor-specific check.  Kexec is a slow path,
and the additional WBINVD is acceptable for the sake of simplicity and
maintainability.

Only do WBINVD on bare-metal.  Doing WBINVD in guest triggers unexpected
exception (#VE or #VC) for TDX and SEV-ES/SEV-SNP guests and the guest
may not be able to handle such exception (e.g., TDX guests panics if it
sees such #VE).

History of SME and kexec WBINVD:

There _was_ an issue preventing doing unconditional WBINVD but that has
been fixed.

Initial SME kexec support added an unconditional WBINVD in commit

  bba4ed011a52: ("x86/mm, kexec: Allow kexec to be used with SME")

This commit caused different Intel systems to hang or reset.

Without a clear root cause, a later commit

  f23d74f6c66c: ("x86/mm: Rework wbinvd, hlt operation in stop_this_cpu()")

fixed the Intel system hang issues by only doing WBINVD when hardware
supports SME.

A corner case [*] revealed the root cause of the system hang issues and
was fixed by commit

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
 arch/x86/kernel/process.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 9c75d701011f..8475d9d2d8c4 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -819,18 +819,19 @@ void __noreturn stop_this_cpu(void *dummy)
 	mcheck_cpu_clear(c);
 
 	/*
-	 * Use wbinvd on processors that support SME. This provides support
-	 * for performing a successful kexec when going from SME inactive
-	 * to SME active (or vice-versa). The cache must be cleared so that
-	 * if there are entries with the same physical address, both with and
-	 * without the encryption bit, they don't race each other when flushed
-	 * and potentially end up with the wrong entry being committed to
-	 * memory.
+	 * Use wbinvd to support kexec for both SME (from inactive to active
+	 * or vice-versa) and TDX.  The cache must be cleared so that if there
+	 * are entries with the same physical address, both with and without
+	 * the encryption bit(s), they don't race each other when flushed and
+	 * potentially end up with the wrong entry being committed to memory.
 	 *
-	 * Test the CPUID bit directly because the machine might've cleared
-	 * X86_FEATURE_SME due to cmdline options.
+	 * stop_this_cpu() isn't a fast path, just do unconditional WBINVD for
+	 * bare-metal to cover both SME and TDX.  Do not do WBINVD in a guest
+	 * since performing one will result in an exception (#VE or #VC) for
+	 * TDX or SEV-ES/SEV-SNP guests which the guest may not be able to
+	 * handle (e.g., TDX guest panics if it sees #VE).
 	 */
-	if (c->extended_cpuid_level >= 0x8000001f && (cpuid_eax(0x8000001f) & BIT(0)))
+	if (!boot_cpu_has(X86_FEATURE_HYPERVISOR))
 		wbinvd();
 
 	/*
-- 
2.48.1


