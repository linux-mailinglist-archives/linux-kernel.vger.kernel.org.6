Return-Path: <linux-kernel+bounces-287923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70A01952E44
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 14:30:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEABA1F26981
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 12:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAB5A19D09E;
	Thu, 15 Aug 2024 12:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g/h0Cbnh"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F3AE195B27
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 12:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723724983; cv=none; b=aana3TXMlnU7jHblDihRhLGLL3wN9kGZX5lribR5BFU7As/Yh6ayomMOZIkXmaMCP1Fp2bjSZ41cKvE92mTtFkUBUuh8DHXSd0z73qcgML4LKin+3yJlpP7AqEQgWOo6MBJA/Sl319Sg+YKlc6dtmlZgxQyTz1I/NbbZ19+8UN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723724983; c=relaxed/simple;
	bh=L+mbcBljMEuXXZoBgaNO2Oy4ZFPnKRwYhehnSwcmsKI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WGxaykfGYSiwoFhdTrl7zZRJIMFBuk7+VoFltWAvcsc29AMIuGeU6ML6ZeLWdRbuMhEvWZns4STHWZP+76n/pekObQV4TciyLUNLpONssIhIs+E3NSOGBCoG4wRfOdzFX6uVVALlI0/lm6sABdiYNj6/b8i8Shp6dnlxXxrTwRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g/h0Cbnh; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723724981; x=1755260981;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=L+mbcBljMEuXXZoBgaNO2Oy4ZFPnKRwYhehnSwcmsKI=;
  b=g/h0Cbnh/Q3Qz6IV0XDLPgy6QeWC40nTGi8TED78EDPePWczWNx9oa+s
   Bpl8KAhaselexz64YXTFzEwc+piQqAyvuis/Zv0TWNwh6H629YEorWZN2
   tGIpoNChjrbJoTepIuy57q7aKMqSSV3jlYsSwgerbKCOz819ho0pstk65
   mZhjSGOjT4mIV9YYup4Br3xMt/pJMYmcCl4tYIB+UKz/QgWVAjAl0p4t8
   LHtxBSnWYweInvUlVfVYrYThQHuCwfIlSljKZ5QMaffvZufKlDEeVhnvd
   9/BJTpPSilMjDG2vI7U8mHtdXFMiRwYFPxRci9xXa0TYHgtZ7scuUQ5vT
   g==;
X-CSE-ConnectionGUID: 077c3U3QS5OmWR00w/TmTA==
X-CSE-MsgGUID: K3/3nocPRqSpoSHS073T1w==
X-IronPort-AV: E=McAfee;i="6700,10204,11165"; a="22112226"
X-IronPort-AV: E=Sophos;i="6.10,148,1719903600"; 
   d="scan'208";a="22112226"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2024 05:29:40 -0700
X-CSE-ConnectionGUID: GWJ0iooJSTC1eytdo8LGUA==
X-CSE-MsgGUID: Dzhh/MUbROus9b0da8blUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,148,1719903600"; 
   d="scan'208";a="59489461"
Received: from unknown (HELO khuang2-desk.gar.corp.intel.com) ([10.124.223.78])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2024 05:29:38 -0700
From: Kai Huang <kai.huang@intel.com>
To: dave.hansen@intel.com,
	kirill.shutemov@linux.intel.com,
	bp@alien8.de,
	tglx@linutronix.de,
	peterz@infradead.org,
	mingo@redhat.com
Cc: x86@kernel.org,
	hpa@zytor.com,
	luto@kernel.org,
	linux-kernel@vger.kernel.org,
	thomas.lendacky@amd.com,
	pbonzini@redhat.com,
	seanjc@google.com
Subject: [PATCH v5 1/5] x86/kexec: do unconditional WBINVD for bare-metal in stop_this_cpu()
Date: Fri, 16 Aug 2024 00:29:17 +1200
Message-ID: <84d79d0d7b184625d34d029d779d9e016c82f91d.1723723470.git.kai.huang@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1723723470.git.kai.huang@intel.com>
References: <cover.1723723470.git.kai.huang@intel.com>
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
_was_ some issue preventing from doing so but now has it got fixed.

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

[1]: https://lore.kernel.org/lkml/CALu+AoQKmeixJdkO07t7BtttN7v3RM4_aBKi642bQ3fTBbSAVg@mail.gmail.com/T/#m300f3f9790850b5daa20a71abcc200ae8d94a12a
[2]: https://lore.kernel.org/lkml/CALu+AoQKmeixJdkO07t7BtttN7v3RM4_aBKi642bQ3fTBbSAVg@mail.gmail.com/T/#ma7263a7765483db0dabdeef62a1110940e634846
[3]: https://lore.kernel.org/lkml/CALu+AoQKmeixJdkO07t7BtttN7v3RM4_aBKi642bQ3fTBbSAVg@mail.gmail.com/T/#mc043191f2ff860d649c8466775dc61ac1e0ae320
[4]: https://lore.kernel.org/lkml/CALu+AoQKmeixJdkO07t7BtttN7v3RM4_aBKi642bQ3fTBbSAVg@mail.gmail.com/T/#md23f1a8f6afcc59fa2b0ac1967f18e418e24347c

Signed-off-by: Kai Huang <kai.huang@intel.com>
Suggested-by: Borislav Petkov <bp@alien8.de>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Dave Young <dyoung@redhat.com>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
---

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
index 1b3d417cd6c4..134c8d99758e 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -810,18 +810,17 @@ void __noreturn stop_this_cpu(void *dummy)
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
2.45.2


