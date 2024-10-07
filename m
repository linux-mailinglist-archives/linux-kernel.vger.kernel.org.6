Return-Path: <linux-kernel+bounces-353015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A5419992748
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 10:41:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C2C01F23A2C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 08:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BBB118C930;
	Mon,  7 Oct 2024 08:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZH2WuKN/"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1CA18C320
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 08:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728290392; cv=none; b=rs33M+m3YAJOn8hlE5366DKxmqYrmVBRxbYcqSc/B1Fw6dgc/jn3Cfl3HzNK3BzCKxOAVc24tIptsadXFQraHDdmtC//HoDmMV0gkIrBi0GYYJI1DL48t9Z7Grbs6Gupje0855SrzzfiPZdU9YKFXy1kF6vi9T4LBTnAl4GVNWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728290392; c=relaxed/simple;
	bh=Ut2lcSavUtGyPeqZkUohdMVHJn/A1rbJ5pE/G3PfoOw=;
	h=Message-Id:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=ZmQYBiS0nCOFNKPzFNLo8eUpspU5RtXfOiRkVN20jDeI0ZWJgX52Pp0mUSk3IMOSZOrZRuPQWSXC72MO1V906qCjDOp+ft6RXioiAaB9wBdzsTh++cH91vBBKRUv06BW//7GOExkbxDwEumweflrLkO0xahkY0CUs+on6dmVRpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ZH2WuKN/; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=s1RO5cKcyIN6ns8T+miEdu09ZPebYXBl3XbyqJEzmio=; b=ZH2WuKN/frKoinsqLIBeS52WDO
	MFH/l1IUEv09O0ADoyHUx0u5+TAGUMEw1yUgXOvYl8NLJ1IjZMG8cvFaVC+Xzr4SETZY+Aquxovnp
	k20byD9WsPnl9I4aXZAHhCp+sCRQDgRtdR+gyQY8z2pAIL9GhFSQcHweNYtLifuKYiBcBmhVL7Rj+
	anb+G0PiztAdZ0RGykHtSzaZv8W4KORMHsFM6gEQ1NsvghVkEa9xWyHKmAAukkQKeP347ou+x7W+J
	3qG3dezjJBjq01eyqoAP9k8aRgX3cBDrZPOffL/iWCjMt+IS6p521tf04RxRkjjaphxkO8DvZn3cV
	M6wKe5sQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1sxjHN-00000004OLz-3KaS;
	Mon, 07 Oct 2024 08:39:46 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id E4C5C30221D; Mon,  7 Oct 2024 10:39:44 +0200 (CEST)
Message-Id: <20241007083844.119369498@infradead.org>
User-Agent: quilt/0.65
Date: Mon, 07 Oct 2024 10:32:12 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: bp@alien8.de,
 david.kaplan@amd.com,
 jpoimboe@redhat.com
Cc: linux-kernel@vger.kernel.org,
 peterz@infradead.org,
 x86@kernel.org
Subject: [RFC][PATCH 2/2] x86: Clean up default rethunk warning
References: <20241007083210.043925135@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

Replace the funny __warn_thunk thing with a more regular
WARN_ON_ONCE(), and simplify the ifdeffery.

Notably this avoids RET from having recursive RETs (once from the
thunk and once from the C function) -- recursive RET makes my head
hurt for no good reason.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/entry/entry.S               |    3 ---
 arch/x86/include/asm/nospec-branch.h |    2 --
 arch/x86/kernel/cpu/bugs.c           |    5 -----
 arch/x86/lib/retpoline.S             |   20 ++++++++++++--------
 4 files changed, 12 insertions(+), 18 deletions(-)

--- a/arch/x86/entry/entry.S
+++ b/arch/x86/entry/entry.S
@@ -10,8 +10,6 @@
 #include <asm/segment.h>
 #include <asm/cache.h>
 
-#include "calling.h"
-
 .pushsection .noinstr.text, "ax"
 
 SYM_FUNC_START(entry_ibpb)
@@ -45,4 +43,3 @@ EXPORT_SYMBOL_GPL(mds_verw_sel);
 
 .popsection
 
-THUNK warn_thunk_thunk, __warn_thunk
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -387,8 +387,6 @@ extern void clear_bhb_loop(void);
 
 extern void (*x86_return_thunk)(void);
 
-extern void __warn_thunk(void);
-
 #ifdef CONFIG_MITIGATION_CALL_DEPTH_TRACKING
 extern void call_depth_return_thunk(void);
 
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -3025,8 +3025,3 @@ ssize_t cpu_show_reg_file_data_sampling(
 	return cpu_show_common(dev, attr, buf, X86_BUG_RFDS);
 }
 #endif
-
-void __warn_thunk(void)
-{
-	WARN_ONCE(1, "Unpatched return thunk in use. This should not happen!\n");
-}
--- a/arch/x86/lib/retpoline.S
+++ b/arch/x86/lib/retpoline.S
@@ -12,9 +12,14 @@
 #include <asm/percpu.h>
 #include <asm/frame.h>
 #include <asm/nops.h>
+#include <asm/bug.h>
 
-	.section .text..__x86.indirect_thunk
+#define WARN_ONCE							\
+	1: ALTERNATIVE "", "ud2", X86_FEATURE_ALWAYS ;			\
+	ASM_BUGTABLE_FLAGS(1b, 0, 0, BUGFLAG_WARNING | BUGFLAG_ONCE) ;	\
+	REACHABLE
 
+	.section .text..__x86.indirect_thunk
 
 .macro POLINE reg
 	ANNOTATE_INTRA_FUNCTION_CALL
@@ -382,16 +387,15 @@ SYM_FUNC_END(call_depth_return_thunk)
 SYM_CODE_START(__x86_return_thunk)
 	UNWIND_HINT_FUNC
 	ANNOTATE_NOENDBR
-#if defined(CONFIG_MITIGATION_UNRET_ENTRY) || \
-    defined(CONFIG_MITIGATION_SRSO) || \
-    defined(CONFIG_MITIGATION_CALL_DEPTH_TRACKING)
-	ALTERNATIVE __stringify(ANNOTATE_UNRET_SAFE; ret), \
-		   "jmp warn_thunk_thunk", X86_FEATURE_ALWAYS
-#else
+
+#ifdef CONFIG_X86_64
+	WARN_ONCE
+#endif
+
 	ANNOTATE_UNRET_SAFE
 	ret
-#endif
 	int3
+
 SYM_CODE_END(__x86_return_thunk)
 EXPORT_SYMBOL(__x86_return_thunk)
 



