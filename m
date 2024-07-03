Return-Path: <linux-kernel+bounces-239082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 71CF19255F6
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 10:55:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1761DB25526
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 08:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA6CD13BC0B;
	Wed,  3 Jul 2024 08:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="UYlhhlp5"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6F9133291
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 08:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719996911; cv=none; b=RoDrAAuIclZ0md+4gTDTyHaSbl+a67vF/c3b0tWJ1+mapbwthl74c+2zZycawXdxc74AHn7tmizD6ZX8Q0buWi9n8WrATLvTXcYJNnPeDO+XtPTiABn45JdjCv1yH3+Abh5TWpfljv3RNswI7eFPJ+7NXaV3CKpCq5Urbpp+0NI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719996911; c=relaxed/simple;
	bh=TWoIecHkxnmQ5CI1vLC3ZAecLTeVYy7pmZuisYvLqOU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G/t5BMny82dokOocmYP3PDhUespRtCPwCCtee8Q41iw/ex+I5Vrfu5ODm886qkHcy6IqjnK3PaAotd8i6FG4pqNIZoO68f2t3SXYhsZFJEachpBSRM52VE2bCJmaut9LX7/rRKb6uN7dLm3hvjL1wW71uK9FlsM7M+8AXFK4X/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=UYlhhlp5; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from terminus.zytor.com (terminus.zytor.com [IPv6:2607:7c80:54:3:0:0:0:136])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 4638sQ18274819
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Wed, 3 Jul 2024 01:54:32 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 4638sQ18274819
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024061501; t=1719996873;
	bh=+f2c92dRlNI6Bo2LbRHWJ0Bigiez0ZfjI89E6Xah1/g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UYlhhlp528Y1DPjzmqIvsckdKWNWFYRMv0Ylhlm4Z8z7IwfBy+akwwLypwpKtwOmt
	 4zw4Mo9D5Pi3IYAmRQJT+MVJd5YgXRcqVPpC+XzxNP6YnseUlvW7x79NJkMhLaiU3g
	 PTBDTTW+HRYUzh55jD9x/Zk8yTkziLk2IRFWJMBy+3sT8RAze5074FQ7S4l/UOeT/k
	 VMaLB8GvFd+K6tuwkX/nYAbmQZyCbBm8j389AzSiAB0f7FoqcuQWrWleC6U0LHuV2C
	 Czl+JjobdxIHqB3b2evXrDr1xpGV77adGV42KmLefoa9kJVsibesIVSmA/pgMsg4p2
	 bD/LlVdBR5lIQ==
From: "Xin Li (Intel)" <xin@zytor.com>
To: linux-kernel@vger.kernel.org
Cc: hpa@zytor.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, peterz@infradead.org,
        andrew.cooper3@citrix.com, nik.borisov@suse.com,
        houwenlong.hwl@antgroup.com
Subject: [PATCH v1 2/4] x86/fred: Write to FRED MSRs with wrmsrns()
Date: Wed,  3 Jul 2024 01:54:24 -0700
Message-ID: <20240703085426.274801-3-xin@zytor.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240703085426.274801-1-xin@zytor.com>
References: <20240703085426.274801-1-xin@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Do FRED MSR writes with wrmsrns() rather than wrmsrl().

No functional change intended.

Signed-off-by: Xin Li (Intel) <xin@zytor.com>
---
 arch/x86/kernel/fred.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/x86/kernel/fred.c b/arch/x86/kernel/fred.c
index 4bcd8791ad96..b202685b8e77 100644
--- a/arch/x86/kernel/fred.c
+++ b/arch/x86/kernel/fred.c
@@ -26,27 +26,27 @@ void cpu_init_fred_exceptions(void)
 	/* When FRED is enabled by default, remove this log message */
 	pr_info("Initialize FRED on CPU%d\n", smp_processor_id());
 
-	wrmsrl(MSR_IA32_FRED_CONFIG,
-	       /* Reserve for CALL emulation */
-	       FRED_CONFIG_REDZONE |
-	       FRED_CONFIG_INT_STKLVL(0) |
-	       FRED_CONFIG_ENTRYPOINT(asm_fred_entrypoint_user));
+	wrmsrns(MSR_IA32_FRED_CONFIG,
+		/* Reserve for CALL emulation */
+		FRED_CONFIG_REDZONE |
+		FRED_CONFIG_INT_STKLVL(0) |
+		FRED_CONFIG_ENTRYPOINT(asm_fred_entrypoint_user));
 
 	/*
 	 * The purpose of separate stacks for NMI, #DB and #MC *in the kernel*
 	 * (remember that user space faults are always taken on stack level 0)
 	 * is to avoid overflowing the kernel stack.
 	 */
-	wrmsrl(MSR_IA32_FRED_STKLVLS,
-	       FRED_STKLVL(X86_TRAP_DB,  FRED_DB_STACK_LEVEL) |
-	       FRED_STKLVL(X86_TRAP_NMI, FRED_NMI_STACK_LEVEL) |
-	       FRED_STKLVL(X86_TRAP_MC,  FRED_MC_STACK_LEVEL) |
-	       FRED_STKLVL(X86_TRAP_DF,  FRED_DF_STACK_LEVEL));
+	wrmsrns(MSR_IA32_FRED_STKLVLS,
+		FRED_STKLVL(X86_TRAP_DB,  FRED_DB_STACK_LEVEL) |
+		FRED_STKLVL(X86_TRAP_NMI, FRED_NMI_STACK_LEVEL) |
+		FRED_STKLVL(X86_TRAP_MC,  FRED_MC_STACK_LEVEL) |
+		FRED_STKLVL(X86_TRAP_DF,  FRED_DF_STACK_LEVEL));
 
 	/* The FRED equivalents to IST stacks... */
-	wrmsrl(MSR_IA32_FRED_RSP1, __this_cpu_ist_top_va(DB));
-	wrmsrl(MSR_IA32_FRED_RSP2, __this_cpu_ist_top_va(NMI));
-	wrmsrl(MSR_IA32_FRED_RSP3, __this_cpu_ist_top_va(DF));
+	wrmsrns(MSR_IA32_FRED_RSP1, __this_cpu_ist_top_va(DB));
+	wrmsrns(MSR_IA32_FRED_RSP2, __this_cpu_ist_top_va(NMI));
+	wrmsrns(MSR_IA32_FRED_RSP3, __this_cpu_ist_top_va(DF));
 
 	/* Enable FRED */
 	cr4_set_bits(X86_CR4_FRED);
-- 
2.45.2


