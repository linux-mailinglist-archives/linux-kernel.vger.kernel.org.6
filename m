Return-Path: <linux-kernel+bounces-527426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23331A40B1F
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 20:08:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A182B3B3383
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 19:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 750B520B213;
	Sat, 22 Feb 2025 19:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lxhrArhU"
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC031E7C24
	for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 19:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740251204; cv=none; b=hcUNRyXaODLyw9miNFyImP/t4l77g/RAB3ED74Z498ZJKTiGthFFcV7Yg9iIUCtwZlRNcziTSIvO5XoxT73NyaPb1xPivP5mgQsjCAVXWp+tAGx8jglnHaAeJ+Kk4Jhb6XDPy4rXeDHV+svV3rNPVP6kL3ur1MqTrEF5bNdToW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740251204; c=relaxed/simple;
	bh=pY81Pf0J2Mda6k+mwhlw8D99MebxoATiJa08HmwXH1g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jbsa8xDmIIsEteNifKldBd6bzPeh2gdI09EgzL2sP8mzRu4vCBCKLCmXG9ScWQ6MUCrQx+UuYuOD2m8P+yD9MXk+PSxCAaqGuzkmd2CH9xdKrUhZpAiBChY8mi8vI6Oh7OBV7sHa7F4d9cYvImkOna0ubloZGIU8fapcV7WPSjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lxhrArhU; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7c0a3d6a6e4so299915185a.1
        for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 11:06:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740251201; x=1740856001; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d8vjxJjSFTpAMGQl6LtUKE5Ud48F2ROpDpIRh9DuarI=;
        b=lxhrArhUpyJSGaD/YnqGKlt2Jt/MtxjVyUZ+V86Y++z97BYmljA2n1UpEjwtG66Koy
         TTYRlIoxS48z1IT5rmiyG03nf6N2dA/ePjukTmTuUFFkNWeqIwb/UnFu94VyhLHzwVS9
         1FmsoLUHjpkdnTdZCKkKWeJetLXXADQt/0nfC75ptw6TuQDbe8QsJpTimAYCgj7k/jhr
         rJEfkHADmixt9iyggN/J1lFbg/hGmx83JFH++VttRGWRGALp1B37/r+OXX37SsBkOb3V
         w1pdKFTfywGx+9kj6WBoqDm5CUzH1i32EaClg2QV64V1U1H9GMH7HQnrkyjEUrD5EWuG
         IvOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740251201; x=1740856001;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d8vjxJjSFTpAMGQl6LtUKE5Ud48F2ROpDpIRh9DuarI=;
        b=kzFDP+Y3JMLxlyIeqYWwp7tIpKp0GaTBSJR74X4mPdRWdtDRz6132M1XCrWp6idkS/
         t7YVafvYN1GDsKKaN+2wvBSHcCaU3uc+vjeEQo2adOaTrqWkpppT00vOWGf+JI+w5Vja
         YrfEmwvd1r0gCaouUhDYxlvFh5VLwlAA+2C2BIBsT/b0uUOGGzYnyXzF3bSZx8J8klAz
         OGeGyBP3NIqbbfBXrrbqFXFRNIdhFDJFoHsdgyQP1ibGNreMstjspmGapylH7Quo/ykZ
         6p+J7UczXolJwMh8yvhfYSxK+oV5uEtl5BRfGrwMVhAlXS1ae/KVZkfQqj1M9mAv7/4K
         F4jQ==
X-Gm-Message-State: AOJu0Yx55DvIyXyxTkwWSz8SUPI9IgNtK/qFZgDEzUrofu/8pEIw/zPH
	iReBf3gkEywBZQOxunqbEHqSiwtNHkOz8DYOnZ82NEGGH8RsuQlgkg3d
X-Gm-Gg: ASbGncuz13h2lrLu0+sYC8sSr86/sBI6B/C5W9fRA7zC0dQautuG6M09FIKF//82xGs
	g9Xzk4dZEdDMUEIokFLu+lwZnQi0FEdSIm0TOnTUBAigZK2/60Fm3seNNUT/491TaWNCn1ZsRQM
	omCbWZmgrguIiExf+kZNF1QBGDLfL1rnPYi5p28U2U77wpGC+zjBXz58PLv5lt8Po12OlR5LB+q
	6FM0KhM/S8mogJvIuFjtng2B2pfQ67UoO/u+3VwjlM6Nizr3/VipQSkFuudL+B2+KdkpkHJ9zbp
	B17UacI=
X-Google-Smtp-Source: AGHT+IEbJkf2NLkdpxnoYBolL3+34rvNiPGTiEKBNQzOGJnaONuN5mT3WVORaaLBpVmEcJHBeDzJBA==
X-Received: by 2002:a05:620a:450c:b0:7c0:c282:702a with SMTP id af79cd13be357-7c0cef484a4mr1063643285a.39.1740251201177;
        Sat, 22 Feb 2025 11:06:41 -0800 (PST)
Received: from citadel.lan ([2600:6c4a:4d3f:6d5c::1019])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c0b1ef73b8sm550185285a.65.2025.02.22.11.06.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Feb 2025 11:06:39 -0800 (PST)
From: Brian Gerst <brgerst@gmail.com>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org
Cc: Ingo Molnar <mingo@kernel.org>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Ard Biesheuvel <ardb@kernel.org>,
	Uros Bizjak <ubizjak@gmail.com>,
	Brian Gerst <brgerst@gmail.com>
Subject: [RFC PATCH 03/11] x86/smp: Move cpu number to percpu hot section
Date: Sat, 22 Feb 2025 14:06:15 -0500
Message-ID: <20250222190623.262689-4-brgerst@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250222190623.262689-1-brgerst@gmail.com>
References: <20250222190623.262689-1-brgerst@gmail.com>
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
index 9a2fe2fd7d74..119099431c76 100644
--- a/arch/x86/include/asm/current.h
+++ b/arch/x86/include/asm/current.h
@@ -16,7 +16,6 @@ struct pcpu_hot {
 	union {
 		struct {
 			struct task_struct	*current_task;
-			int			cpu_number;
 #ifdef CONFIG_MITIGATION_CALL_DEPTH_TRACKING
 			u64			call_depth;
 #endif
diff --git a/arch/x86/include/asm/smp.h b/arch/x86/include/asm/smp.h
index ca073f40698f..a249f9991708 100644
--- a/arch/x86/include/asm/smp.h
+++ b/arch/x86/include/asm/smp.h
@@ -5,9 +5,10 @@
 #include <linux/cpumask.h>
 
 #include <asm/cpumask.h>
-#include <asm/current.h>
 #include <asm/thread_info.h>
 
+DECLARE_PER_CPU_HOT(int, cpu_number);
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
index 1e7be9409aa2..0ea3443433c5 100644
--- a/arch/x86/kernel/setup_percpu.c
+++ b/arch/x86/kernel/setup_percpu.c
@@ -23,6 +23,9 @@
 #include <asm/cpumask.h>
 #include <asm/cpu.h>
 
+DEFINE_PER_CPU_HOT(int, cpu_number);
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


