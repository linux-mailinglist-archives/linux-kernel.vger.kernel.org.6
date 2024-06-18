Return-Path: <linux-kernel+bounces-220131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 57D7790DD05
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 22:06:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B9E51C217C1
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 20:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 368E816EB59;
	Tue, 18 Jun 2024 20:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="cstjTSA5"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE81816EB5C
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 20:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718741161; cv=none; b=Vnj9jVQ2tAbp2mxAkBfEBp4wxc1DRCr5z1ZuxFaO2MaIYix7lzsQu9S+t6IehALI4xv6rqggPlbsGbmKVQJeAnejHbfTrBeGCoigFs6OzSRsojekK/bdfvOG5riyd8U1ZAh4m5CXUfj4N3oxqXmtNF/5/2sGsIowdZLokgM9ruw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718741161; c=relaxed/simple;
	bh=8U4MSGuxqWWSmiUPJd9aKzBNjP/BbAfdaShtMWYb1UI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ftS54Vt0TvVd4doV7y089+4+7qnnQCcnnoIudSrdVeHRcbHQdSi1+/KgWbYXg3/i8CPzIxWAVyDzS+3Us4I3qA57JJ5fBy6Fnqo2Kq3AgBOmzpDvpjk2u4NiRYDwDQD4xd+mwoIE+6V7en3OugpeVr+0Y0U581Q16OCll6Sp+q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=cstjTSA5; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 90F8440E01F9;
	Tue, 18 Jun 2024 20:05:56 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 45eeiO18hMPn; Tue, 18 Jun 2024 20:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1718741152; bh=Lb9oaHDz6g5o9gk7L0CZU58Y47qnYQz9v3gzUb/WuRw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cstjTSA5jvHj8L1Jx8tS40sgjGO9BPR7BMbX/4phHstZezskwL/zvxpl+ENZj7/Lq
	 pW/xU5IA0a9aYp0ljqLbxbH8bRJUXYKlf4o/7E8S3xl24ylsPh7CdVhn47NkGfUZ9V
	 Q/uUbbenFVjVW2iZ3rjdASTeEAH4Izbu+ZnJ079y6LafgFBuBQsYyZn+fYJ7F0DIvv
	 rGm+nC8FRAZWT5O0jueYfiDAsxQ3MTa5QEC08cMrxLL9ja9DfitwHSq7yeOCs9PWYE
	 Kh5jjhzFACSfAi1C/0EkELuO3D97K9DbBr6dU1TBhckGpiiFtQ9oRod0zxype9dJq7
	 eEHKz/0YaJ9LHte0Z767zAMri3e/foYXToCM8V/yw/MnxnHRBeVgMJLsz/szWs8718
	 9QCJzOxensq30kOqf1DNkvXT0GHOqhz025aDGzg1r2Z+8QJKam0+zMZiYY9zJRCQmh
	 1e2oMp2sUwuxasSvUwCpfN9IfaDyiiCAyT2xfL8EUdQimjbaXzEifFpDUetG3zLmLD
	 CU0SdYFInYqJB84RNwAUvrN0NpDg0KB3PittE/nMypk3bDTLhnTewMuvS89g3SatfX
	 /AHGpCg1TqR2SCTMNzPicVMwVwkKTQsdEmxyVwW7upL3s6zl/fYtnC4CUynenDz2iy
	 UEM9W/DhlAD1eK4OJgWcJ+n8=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 61FB240E021A;
	Tue, 18 Jun 2024 20:05:45 +0000 (UTC)
Date: Tue, 18 Jun 2024 22:05:39 +0200
From: Borislav Petkov <bp@alien8.de>
To: Peter Zijlstra <peterz@infradead.org>
Cc: kernel test robot <lkp@intel.com>,
	Sean Christopherson <seanjc@google.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [PATCH] x86/alternatives, kvm: Fix a couple of CALLs without a frame
 pointer
Message-ID: <20240618200539.GHZnHok3nr60R4BXSK@fat_crate.local>
References: <202406141648.jO9qNGLa-lkp@intel.com>
 <20240614152228.GAZmxgNPmozj7UzRdV@fat_crate.local>
 <20240618104234.GF31592@noisy.programming.kicks-ass.net>
 <20240618104700.GT12673@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240618104700.GT12673@noisy.programming.kicks-ass.net>

Ok, I was able to scratch up this from the whole shebang:

---
From: "Borislav Petkov (AMD)" <bp@alien8.de>
Date: Tue, 18 Jun 2024 21:57:27 +0200

objtool complains:

  arch/x86/kvm/kvm.o: warning: objtool: .altinstr_replacement+0xc5: call without frame pointer save/setup
  vmlinux.o: warning: objtool: .altinstr_replacement+0x2eb: call without frame pointer save/setup

Make sure rSP is an output operand to the respective asm() statements.

The test_cc() hunk courtesy of peterz. Also from him add some helpful
debugging info to the documentation.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202406141648.jO9qNGLa-lkp@intel.com/
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 arch/x86/include/asm/alternative.h      |  2 +-
 arch/x86/kernel/alternative.c           |  2 +-
 arch/x86/kvm/emulate.c                  |  2 +-
 tools/objtool/Documentation/objtool.txt | 19 +++++++++++++++++++
 4 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/alternative.h b/arch/x86/include/asm/alternative.h
index 89fa50d27a08..8cff4626478b 100644
--- a/arch/x86/include/asm/alternative.h
+++ b/arch/x86/include/asm/alternative.h
@@ -248,7 +248,7 @@ static inline int alternatives_text_reserved(void *start, void *end)
  */
 #define alternative_call(oldfunc, newfunc, ft_flags, output, input...)	\
 	asm_inline volatile(ALTERNATIVE("call %c[old]", "call %c[new]", ft_flags) \
-		: output : [old] "i" (oldfunc), [new] "i" (newfunc), ## input)
+		: output, ASM_CALL_CONSTRAINT : [old] "i" (oldfunc), [new] "i" (newfunc), ## input)
 
 /*
  * Like alternative_call, but there are two features and respective functions.
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 37596a417094..333b16181357 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -1657,7 +1657,7 @@ static noinline void __init alt_reloc_selftest(void)
 	 */
 	asm_inline volatile (
 		ALTERNATIVE("", "lea %[mem], %%" _ASM_ARG1 "; call __alt_reloc_selftest;", X86_FEATURE_ALWAYS)
-		: /* output */
+		: ASM_CALL_CONSTRAINT
 		: [mem] "m" (__alt_reloc_selftest_addr)
 		: _ASM_ARG1
 	);
diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
index 5d4c86133453..c8cc578646d0 100644
--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -1069,7 +1069,7 @@ static __always_inline u8 test_cc(unsigned int condition, unsigned long flags)
 
 	flags = (flags & EFLAGS_MASK) | X86_EFLAGS_IF;
 	asm("push %[flags]; popf; " CALL_NOSPEC
-	    : "=a"(rc) : [thunk_target]"r"(fop), [flags]"r"(flags));
+	    : "=a"(rc), ASM_CALL_CONSTRAINT : [thunk_target]"r"(fop), [flags]"r"(flags));
 	return rc;
 }
 
diff --git a/tools/objtool/Documentation/objtool.txt b/tools/objtool/Documentation/objtool.txt
index fe39c2a8ef0d..7c3ee959b63c 100644
--- a/tools/objtool/Documentation/objtool.txt
+++ b/tools/objtool/Documentation/objtool.txt
@@ -284,6 +284,25 @@ the objtool maintainers.
 
    Otherwise the stack frame may not get created before the call.
 
+   objtool can help with pinpointing the exact function where it happens:
+
+   $ OBJTOOL_ARGS="--verbose" make arch/x86/kvm/
+
+   arch/x86/kvm/kvm.o: warning: objtool: .altinstr_replacement+0xc5: call without frame pointer save/setup
+   arch/x86/kvm/kvm.o: warning: objtool:   em_loop.part.0+0x29: (alt)
+   arch/x86/kvm/kvm.o: warning: objtool:   em_loop.part.0+0x0: <=== (sym)
+    LD [M]  arch/x86/kvm/kvm-intel.o
+   0000 0000000000028220 <em_loop.part.0>:
+   0000    28220:  0f b6 47 61             movzbl 0x61(%rdi),%eax
+   0004    28224:  3c e2                   cmp    $0xe2,%al
+   0006    28226:  74 2c                   je     28254 <em_loop.part.0+0x34>
+   0008    28228:  48 8b 57 10             mov    0x10(%rdi),%rdx
+   000c    2822c:  83 f0 05                xor    $0x5,%eax
+   000f    2822f:  48 c1 e0 04             shl    $0x4,%rax
+   0013    28233:  25 f0 00 00 00          and    $0xf0,%eax
+   0018    28238:  81 e2 d5 08 00 00       and    $0x8d5,%edx
+   001e    2823e:  80 ce 02                or     $0x2,%dh
+   ...
 
 2. file.o: warning: objtool: .text+0x53: unreachable instruction
 
-- 
2.43.0

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

