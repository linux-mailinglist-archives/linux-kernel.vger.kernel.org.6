Return-Path: <linux-kernel+bounces-247882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E779792D5E5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 18:12:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69433B2435D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 16:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA6FB195B1A;
	Wed, 10 Jul 2024 16:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D14jCmAJ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DEF71957EA;
	Wed, 10 Jul 2024 16:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720627823; cv=none; b=my4dyX+689RdSQJn6xkB7bPXjJ7mlu0a311pxTIQe05l+oGvTSttTGJHLMreonhwjT9Xia1xpgNab86MSk6q61k61R57xK36hqNEfWMy5I3V6IPalIS6xkPSdToNNjvsqT/p/7UMn+cwyG2wDUl5pQPtfgLRs5Ld3GTR7jPabR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720627823; c=relaxed/simple;
	bh=eOsc9zaDvKNVdNiqXR8+NYBnBvM8/2EfjADFBJEBEps=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=si/zUnA8g1uaY+bsaVTDMCgDuipJz0Bs2Klo66B7CQSzyKBfbVzIFa3uNlECUCtNYTu68fN4OuHBhOIcq1mAek+Nb81lfK2WRsEBMCVbCVoifYK1lCT0FxW5SRg1LX81xHJqQsYj7i/5IhOcqMx9c8VGZ9uQd7958htRbwfQ64M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D14jCmAJ; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720627821; x=1752163821;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eOsc9zaDvKNVdNiqXR8+NYBnBvM8/2EfjADFBJEBEps=;
  b=D14jCmAJAzZM5eYaphpDpGPrX7dpWNNhpgqptnRLTUNv7/Ke2nFW2TZ1
   r8wvfFgFIXyaPo2jz7oSrmfRRn4lFI4ZhaKNAtkg6Xvoe2/qc3H+7S5CX
   v56FnUoQbGmHyHeLxBI7fCBCkveKX2q3qU/N5B5u1vx/osgjx2XQcfKcG
   xTP5MdoTMP6KeJvzUPW7ZFUV249MLB/4YCQUFLu9s6S9AT43uDdBoEOQs
   SzJlo/5QkvA3TedNT0vU18w79SnYZOedYqJ/aiAxRfe4mUVLydg/eU4HK
   EtkS6oXc8B4hevc8CImRji6OAUAqwqWGYw3XmhKjP+utYFjphnT+tmE1N
   g==;
X-CSE-ConnectionGUID: pb5TuZyjRi2V7AcILzKYFQ==
X-CSE-MsgGUID: ZHm4lh+VS4mOKdNiMtuU3A==
X-IronPort-AV: E=McAfee;i="6700,10204,11129"; a="18103229"
X-IronPort-AV: E=Sophos;i="6.09,198,1716274800"; 
   d="scan'208";a="18103229"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2024 09:10:20 -0700
X-CSE-ConnectionGUID: 4xCWndd+RSqdxmLCZg1/XA==
X-CSE-MsgGUID: qw9pSSSuTOGJqO5UQin3WQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,198,1716274800"; 
   d="scan'208";a="53085274"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by orviesa003.jf.intel.com with ESMTP; 10 Jul 2024 09:10:07 -0700
From: Alexander Shishkin <alexander.shishkin@linux.intel.com>
To: Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Xiongwei Song <xiongwei.song@windriver.com>,
	Xin Li <xin3.li@intel.com>,
	"Mike Rapoport (IBM)" <rppt@kernel.org>,
	Brijesh Singh <brijesh.singh@amd.com>,
	Michael Roth <michael.roth@amd.com>,
	Tony Luck <tony.luck@intel.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Alexey Kardashevskiy <aik@amd.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Sohil Mehta <sohil.mehta@intel.com>,
	Ingo Molnar <mingo@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Daniel Sneddon <daniel.sneddon@linux.intel.com>,
	Kai Huang <kai.huang@intel.com>,
	Sandipan Das <sandipan.das@amd.com>,
	Breno Leitao <leitao@debian.org>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Yian Chen <yian.chen@intel.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Hou Tao <houtao1@huawei.com>,
	Juergen Gross <jgross@suse.com>,
	Vegard Nossum <vegard.nossum@oracle.com>,
	Kees Cook <kees@kernel.org>,
	Eric Biggers <ebiggers@google.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Yuntao Wang <ytcoode@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Tejun Heo <tj@kernel.org>,
	Changbin Du <changbin.du@huawei.com>,
	Huang Shijie <shijie@os.amperecomputing.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Namhyung Kim <namhyung@kernel.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-efi@vger.kernel.org,
	Dave Hansen <dave.hansen@intel.com>
Subject: [PATCH v4 09/16] x86/traps: Consolidate user fixups in exc_general_protection()
Date: Wed, 10 Jul 2024 19:06:45 +0300
Message-ID: <20240710160655.3402786-10-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240710160655.3402786-1-alexander.shishkin@linux.intel.com>
References: <20240710160655.3402786-1-alexander.shishkin@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sohil Mehta <sohil.mehta@intel.com>

Move the UMIP exception fixup along with the other user mode fixups,
that is, under the common "if (user_mode(regs))" condition where the
rest of the fixups reside.

No functional change intended.

Suggested-by: Dave Hansen <dave.hansen@intel.com>
Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
---
 arch/x86/kernel/traps.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 4fa0b17e5043..ae34e03739cb 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -652,11 +652,6 @@ DEFINE_IDTENTRY_ERRORCODE(exc_general_protection)
 
 	cond_local_irq_enable(regs);
 
-	if (static_cpu_has(X86_FEATURE_UMIP)) {
-		if (user_mode(regs) && fixup_umip_exception(regs))
-			goto exit;
-	}
-
 	if (v8086_mode(regs)) {
 		local_irq_enable();
 		handle_vm86_fault((struct kernel_vm86_regs *) regs, error_code);
@@ -671,6 +666,9 @@ DEFINE_IDTENTRY_ERRORCODE(exc_general_protection)
 		if (fixup_vdso_exception(regs, X86_TRAP_GP, error_code, 0))
 			goto exit;
 
+		if (cpu_feature_enabled(X86_FEATURE_UMIP) && fixup_umip_exception(regs))
+			goto exit;
+
 		gp_user_force_sig_segv(regs, X86_TRAP_GP, error_code, desc);
 		goto exit;
 	}
-- 
2.43.0


