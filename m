Return-Path: <linux-kernel+bounces-522044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1E0EA3C530
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 17:39:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3536A3B7884
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 16:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80B76209F3F;
	Wed, 19 Feb 2025 16:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ze0zzoSJ"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06821FE443
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 16:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739983012; cv=none; b=Jxy5aQg2D0JSsyYU0STv5lwFHQ4QXGtNkA771bWyyn2nJi7g97remAng0aknEMaTty1ljfet85x5qy0Dg8MQMdD1GYDNj7Z/l80XM6pBTCyO9576T2QzregIln1Q+A4HQzvEB51Hlo1N/O5bNGgm3X7Blu1lCKpr0iQvAU3jfzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739983012; c=relaxed/simple;
	bh=+DJ3eXlkCzlIieljPXX3Feo8Y2owvrTAtdRKuEyVaLQ=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=OP7yUrcSS8C/TFb3lEkPhi8VvGN7fu2XMg+xpq4rc1yrVXC1t6xie60wpPqJ4ZT0m3amjOIsHvikJJzNuxtphralAdCtxl81jSpAhJZZozfe1wqJOYoTFwEOjBx+D2EGXtPNmlH3DCRkZmVxPuB7bpzgNPpDs0LJ6gRQzmVDCXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Ze0zzoSJ; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=3l3jBdGgQLX2gy+RZgHHu7XYzFFZN7WRc+HHnGo9En8=; b=Ze0zzoSJwCQiu2oBd76bpyVv8/
	pVR27Fjg3gMDWyb4tVk4bC9wT02Y6dkXxXkWXB3OUZG6TpiCXn2hMICyHo70NMoJaV0DYasiZp55T
	t2iePANm7uwBr2yMlROge3fxWBYA8jpvdnhMBjQQ5h8KFVIzf7JnJkgcr9T/7j+zEI6BsTdP+MO3p
	WLbZ6vjSjsonKDPs/YUzaZ0obqnlXC/PQ7b8adT5/pYZ9ZdammB50dOo3hSRGmEVR3xL4uQ4a+rOf
	Bd1yzmf47S+NnjExgESYmwmQacU2h8vSCQ5a2dgYZa8pVUB0/Nh4lbGBJs8YHeWm30wz1oPNwQEo/
	rnhdC3VA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tkn40-00000002HAH-0JNu;
	Wed, 19 Feb 2025 16:36:44 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id EA670300787; Wed, 19 Feb 2025 17:36:42 +0100 (CET)
Message-ID: <20250219163514.364049576@infradead.org>
User-Agent: quilt/0.66
Date: Wed, 19 Feb 2025 17:21:08 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
 peterz@infradead.org,
 alyssa.milburn@intel.com,
 scott.d.constable@intel.com,
 joao@overdrivepizza.com,
 andrew.cooper3@citrix.com,
 jpoimboe@kernel.org,
 jose.marchesi@oracle.com,
 hjl.tools@gmail.com,
 ndesaulniers@google.com,
 samitolvanen@google.com,
 nathan@kernel.org,
 ojeda@kernel.org,
 kees@kernel.org,
 alexei.starovoitov@gmail.com,
 mhiramat@kernel.org,
 jmill@asu.edu
Subject: [PATCH v3 01/10] x86/cfi: Add warn option
References: <20250219162107.880673196@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

Rebuilding with CFI_PERMISSIVE toggled is such a pain, esp. since
clang is so slow.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/cfi.h    |    1 +
 arch/x86/kernel/alternative.c |    4 ++++
 arch/x86/kernel/cfi.c         |   14 ++++++++++----
 3 files changed, 15 insertions(+), 4 deletions(-)

--- a/arch/x86/include/asm/cfi.h
+++ b/arch/x86/include/asm/cfi.h
@@ -100,6 +100,7 @@ enum cfi_mode {
 };
 
 extern enum cfi_mode cfi_mode;
+extern bool cfi_warn;
 
 struct pt_regs;
 
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -916,6 +916,7 @@ void __init_or_module apply_seal_endbr(s
 #endif
 
 enum cfi_mode cfi_mode __ro_after_init = __CFI_DEFAULT;
+bool cfi_warn __ro_after_init = false;
 
 #ifdef CONFIG_CFI_CLANG
 struct bpf_insn;
@@ -1022,6 +1023,9 @@ static __init int cfi_parse_cmdline(char
 			cfi_mode = CFI_FINEIBT;
 		} else if (!strcmp(str, "norand")) {
 			cfi_rand = false;
+		} else if (!strcmp(str, "warn")) {
+			pr_alert("CFI mismatch non-fatal!\n");
+			cfi_warn = true;
 		} else {
 			pr_err("Ignoring unknown cfi option (%s).", str);
 		}
--- a/arch/x86/kernel/cfi.c
+++ b/arch/x86/kernel/cfi.c
@@ -67,16 +67,17 @@ static bool decode_cfi_insn(struct pt_re
  */
 enum bug_trap_type handle_cfi_failure(struct pt_regs *regs)
 {
-	unsigned long target;
+	unsigned long target, addr = regs->ip;
+	enum bug_trap_type btt;
 	u32 type;
 
 	switch (cfi_mode) {
 	case CFI_KCFI:
-		if (!is_cfi_trap(regs->ip))
+		if (!is_cfi_trap(addr))
 			return BUG_TRAP_TYPE_NONE;
 
 		if (!decode_cfi_insn(regs, &target, &type))
-			return report_cfi_failure_noaddr(regs, regs->ip);
+			return report_cfi_failure_noaddr(regs, addr);
 
 		break;
 
@@ -90,7 +91,12 @@ enum bug_trap_type handle_cfi_failure(st
 		return BUG_TRAP_TYPE_NONE;
 	}
 
-	return report_cfi_failure(regs, regs->ip, &target, type);
+	btt = report_cfi_failure(regs, addr, &target, type);
+	if (btt == BUG_TRAP_TYPE_BUG && cfi_warn) {
+		__warn(NULL, 0, (void *)addr, 0, regs, NULL);
+		btt = BUG_TRAP_TYPE_WARN;
+	}
+	return btt;
 }
 
 /*



