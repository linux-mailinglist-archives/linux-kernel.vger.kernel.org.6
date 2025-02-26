Return-Path: <linux-kernel+bounces-534591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 782E1A468E2
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 19:06:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7180E3AF760
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 18:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA85923535E;
	Wed, 26 Feb 2025 18:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BlIPOyFh"
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AABC2356D1
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 18:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740593156; cv=none; b=BtCU1BXF/1xwIFQYawpAYmd6kIfIif2Y8Gp8xCrK3ZYBS9JIy7MM6tpyAyKPNwih5L6iyaaLIeWHEp+KS9ifP4caFTDz41fPfz4gKILId+tEboSM0IsivY1EfEZ4VNMoVetnd45Gobxkf8C3uw97pjvlMq2mBqsPf/zuItO2JxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740593156; c=relaxed/simple;
	bh=+R4AE2vH5/O6elwe4lTeR/IxdlRNPhicCE/pDetofCk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WOSXW1q5u5/NZMgTuu3n5VDExQ7M6EjWkQfoYSMcczSNndTnpCq/JAYfi951S1WXq7p9aEnL8Yu3g+Dx8XR4B22kU3DkQCgHjPaQpJGW/5Dbg7pyvuBN42TYmu838JEYmA0rC6F3UGson+GEKebXfpvxjGgJnzMsUO/OCAE+lVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BlIPOyFh; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5fcd7d306f3so42777eaf.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 10:05:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740593153; x=1741197953; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ifmVptM9mxgQ/UQ1wElHFd5KU5UJQ5Cl2dkvmNdyxqo=;
        b=BlIPOyFhxFs+TQl73Ph9VnfbzfyF4LvZ6LZGWBxxe325eQsRQcBDWCR/ucpMbe+Xec
         Izcv68j6EQK5/Tp9xbIWDSScrhJHMwp49uTsS/fJtWcL3RpIXiwZcT2MqR7t6iK9X3eu
         DX0p8eicUnxrlGJvxXTBIkdBbGNj6aJQry6hRsqcziAL9UHVWcp7RbOusXoIkz993CSm
         lNyqynKANrsuZyoYEGqwcBb7a3zPMouAXFoXTPJ6nAz05v6sd+SVnUD3Jhd16+jPZD8t
         Yi1mqA+RQ65FJu9RvrSWdqKq0QdUEf5+Oh91FPBBq6Ozrqt+QRHANlgwetYMStvE1vv1
         eDaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740593153; x=1741197953;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ifmVptM9mxgQ/UQ1wElHFd5KU5UJQ5Cl2dkvmNdyxqo=;
        b=cQPfAZUtc+hGw+G9xT04cQWJNm0ZxM/G+PmplSmWWMzY38O/r4Jrh6P7QAk72/KMjh
         m/rp3TNtrWQfyF5Bv4bK/QZUxfIsJ95PEotOJipN4CUhiNm/liNRK11c17rCrEjIpUbF
         1SYUi34NXd7wCk/l3blHGwzvZLSzgiygPm0nAV2rGReqiaXV9s5d6cKqGQDyfnSRtz71
         NQ1xQ6KyqidokX0Xl8rCIkrUStjtwrU39ZcEFbJHok4yZhECsmx/EIwut7zyih0zL2wy
         H7vvqbXts8GA/798lnK/NL8WJal0qVSXNBqwaS/dceMg/++X1g9Ts5EKRlgwrx1DG3tw
         CHSw==
X-Gm-Message-State: AOJu0YzXSXDTyVhk8+mr6SfpAu/OmPI9VvHvr7sahmSsBOpSsOQlQIOu
	k4sA8ZZV+Id4CkzEY0QdHwtphlwrakVrlxH9b/jSe1TPbmPX70jI/DLL
X-Gm-Gg: ASbGnctytFx/vEmj0pbjfpK8tb7hssrI1ZQL6toL2ibwR74Bum1pwRQhihCY5PMGAjr
	D6cNvgqIqRElaVvuUO5k3EAf2AJCr4mEJbh94rv7nKBFjHeZ9k8ibnM1Io2fzmfhIXZ0+kd0/He
	sZsqlUUwmITS/vfQpddf23v2iDGeav3hbmECO9aTyfMXHr5gqfoISVBKfrHyf3brKsMLNMwgpc5
	ubLdCfjOuQTTZMnzRU/jPviw/FVpboEnHWPcClLwuxqaus1CDDX6+AMPWYdwn5/jUe/S+TawDRb
	bQMZpQQ=
X-Google-Smtp-Source: AGHT+IF/ZgHy4vtLZAvsawnyeMz7UU5Be3jh32wQjYh6McKl2h1yO+IqNJydP8JJwsvPil3Dzyt5kw==
X-Received: by 2002:a05:6820:997:b0:5fe:87b7:6ecf with SMTP id 006d021491bc7-5fe9d4a9f2dmr2377092eaf.0.1740593153145;
        Wed, 26 Feb 2025 10:05:53 -0800 (PST)
Received: from citadel.lan ([2600:6c4a:4d3f:6d5c::1019])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5fe9428c8b3sm755069eaf.39.2025.02.26.10.05.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 10:05:51 -0800 (PST)
From: Brian Gerst <brgerst@gmail.com>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org
Cc: Ingo Molnar <mingo@kernel.org>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Ard Biesheuvel <ardb@kernel.org>,
	Uros Bizjak <ubizjak@gmail.com>,
	Linus Torvalds <torvalds@linuxfoundation.org>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Brian Gerst <brgerst@gmail.com>
Subject: [PATCH v2 04/11] x86/smp: Move cpu number to percpu hot section
Date: Wed, 26 Feb 2025 13:05:23 -0500
Message-ID: <20250226180531.1242429-5-brgerst@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250226180531.1242429-1-brgerst@gmail.com>
References: <20250226180531.1242429-1-brgerst@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

No functional change.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
---
 arch/x86/include/asm/current.h | 1 -
 arch/x86/include/asm/smp.h     | 7 ++++---
 arch/x86/kernel/setup_percpu.c | 5 ++++-
 kernel/bpf/verifier.c          | 4 ++--
 4 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/current.h b/arch/x86/include/asm/current.h
index 46a736d6f2ec..f988462d8b69 100644
--- a/arch/x86/include/asm/current.h
+++ b/arch/x86/include/asm/current.h
@@ -14,7 +14,6 @@ struct task_struct;
 
 struct pcpu_hot {
 	struct task_struct	*current_task;
-	int			cpu_number;
 #ifdef CONFIG_MITIGATION_CALL_DEPTH_TRACKING
 	u64			call_depth;
 #endif
diff --git a/arch/x86/include/asm/smp.h b/arch/x86/include/asm/smp.h
index ca073f40698f..d1db2c131b1d 100644
--- a/arch/x86/include/asm/smp.h
+++ b/arch/x86/include/asm/smp.h
@@ -5,9 +5,10 @@
 #include <linux/cpumask.h>
 
 #include <asm/cpumask.h>
-#include <asm/current.h>
 #include <asm/thread_info.h>
 
+DECLARE_PER_CPU_CACHE_HOT(int, cpu_number);
+
 DECLARE_PER_CPU_READ_MOSTLY(cpumask_var_t, cpu_sibling_map);
 DECLARE_PER_CPU_READ_MOSTLY(cpumask_var_t, cpu_core_map);
 DECLARE_PER_CPU_READ_MOSTLY(cpumask_var_t, cpu_die_map);
@@ -133,8 +134,8 @@ __visible void smp_call_function_single_interrupt(struct pt_regs *r);
  * This function is needed by all SMP systems. It must _always_ be valid
  * from the initial startup.
  */
-#define raw_smp_processor_id()  this_cpu_read(pcpu_hot.cpu_number)
-#define __smp_processor_id() __this_cpu_read(pcpu_hot.cpu_number)
+#define raw_smp_processor_id()  this_cpu_read(cpu_number)
+#define __smp_processor_id() __this_cpu_read(cpu_number)
 
 #ifdef CONFIG_X86_32
 extern int safe_smp_processor_id(void);
diff --git a/arch/x86/kernel/setup_percpu.c b/arch/x86/kernel/setup_percpu.c
index 1e7be9409aa2..175afc3ffb12 100644
--- a/arch/x86/kernel/setup_percpu.c
+++ b/arch/x86/kernel/setup_percpu.c
@@ -23,6 +23,9 @@
 #include <asm/cpumask.h>
 #include <asm/cpu.h>
 
+DEFINE_PER_CPU_CACHE_HOT(int, cpu_number);
+EXPORT_PER_CPU_SYMBOL(cpu_number);
+
 DEFINE_PER_CPU_READ_MOSTLY(unsigned long, this_cpu_off);
 EXPORT_PER_CPU_SYMBOL(this_cpu_off);
 
@@ -161,7 +164,7 @@ void __init setup_per_cpu_areas(void)
 	for_each_possible_cpu(cpu) {
 		per_cpu_offset(cpu) = delta + pcpu_unit_offsets[cpu];
 		per_cpu(this_cpu_off, cpu) = per_cpu_offset(cpu);
-		per_cpu(pcpu_hot.cpu_number, cpu) = cpu;
+		per_cpu(cpu_number, cpu) = cpu;
 		setup_percpu_segment(cpu);
 		/*
 		 * Copy data used in early init routines from the
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 9971c03adfd5..604134d33282 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -21687,12 +21687,12 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 		if (insn->imm == BPF_FUNC_get_smp_processor_id &&
 		    verifier_inlines_helper_call(env, insn->imm)) {
 			/* BPF_FUNC_get_smp_processor_id inlining is an
-			 * optimization, so if pcpu_hot.cpu_number is ever
+			 * optimization, so if cpu_number is ever
 			 * changed in some incompatible and hard to support
 			 * way, it's fine to back out this inlining logic
 			 */
 #ifdef CONFIG_SMP
-			insn_buf[0] = BPF_MOV32_IMM(BPF_REG_0, (u32)(unsigned long)&pcpu_hot.cpu_number);
+			insn_buf[0] = BPF_MOV32_IMM(BPF_REG_0, (u32)(unsigned long)&cpu_number);
 			insn_buf[1] = BPF_MOV64_PERCPU_REG(BPF_REG_0, BPF_REG_0);
 			insn_buf[2] = BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_0, 0);
 			cnt = 3;
-- 
2.48.1


