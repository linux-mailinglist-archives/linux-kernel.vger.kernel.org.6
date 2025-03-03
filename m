Return-Path: <linux-kernel+bounces-542375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7945A4C90C
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 18:17:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A1D317359A
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 17:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AB2C25EF90;
	Mon,  3 Mar 2025 16:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WuZfK4Q3"
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A6825E828
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 16:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741020802; cv=none; b=XhrHBrf67Tsu97k2MSJYpoCZcXP0CSPIBo6ZYPm61plFf2KovBEhgHuAtt7+p9QKo2jY4XN2igP7SA3ofBpmU41Me9DAsYjCFdUuZDu5p40N6qlFiiCwYZm6kfj7hpNU9Lnknk2i33g5EhXnN5FP6M+r7ZNBucNEhluPqsTnB+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741020802; c=relaxed/simple;
	bh=52lOENL9T0/nUWxyw+B5/VLu3eMD9wCD80R7uWLaNBQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aJl9KNnMK0AHWGpTZ0gpgVQIJdZkemitGXLQJF7SR9lT8Q+/PTtpX1MMHbgiCLhQqzJSYJbn05EW4IhUlJUl8WLa3UhiVEUlgUDeo49FIbQNjbToe8yE+178IW80lwASbxCeUiU6ydoAFQYDSMY95+x0zFMou3i+y/8gfi3SZI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WuZfK4Q3; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6e6c082eac0so44381896d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 08:53:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741020798; x=1741625598; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZFL4zyI1qItSJ1SO+PACSRk4BcOG2Axak54Fldvg7PY=;
        b=WuZfK4Q3SGVL/VXZc4bDcjUht2CqBFrcTRI2YbvITYiiIM48EzDi89XrfOcav4FfJ/
         9Wbeka9iLYzWgrGbsL4eeSWm0cZqfTayc+BmnjlJJKa7jZ/CAjlpzmwTj/pySmSGzvfW
         fqCJkTmmTx1gR3zbtP6g2Tk8yKPwnn/XmFKl4rvcFIDegAUBDjEcebw27KP4Ue92yAIi
         wvrCtq1Z2akqXFr+dNN5BiOTG40MAeF8kRrdpO4YMeOlpGYa/O7pMSEdtScA20jMSmH9
         CYi9jo9jcD/KgbMO96lIXD0GTy/Iz+Ruw+WQHPtvY6LGSbtS4iLzcWNQcMdzDXdVYPog
         faxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741020798; x=1741625598;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZFL4zyI1qItSJ1SO+PACSRk4BcOG2Axak54Fldvg7PY=;
        b=pXabArvP9y/FoCxGNVgt/C+V31RdvJ+M1SU6dKa2wNhc5Ztnk5G7m19+9A9Ws+JvnK
         oZyU4U9rHP45toixtdRtubzzkFXYCu+gx2Urejk65PgXNeXEHfgj7CCOHp4UaduA8YOP
         LZG5FBlPi/14vaRyeTRqLanFvRN/WFYus32m89bnw90QcBUmzu7v+RUHCCj6nKLf3TyV
         0ogr0wN+MkqPBhhR/XIlceExD3KNuGVRWkfohBaN3719w6EsvaVJyWcG2bjsfLuRH1wc
         0oswqeHi2yDvtSRAYOMkO96Ybhhq/9kqbcNsnNxU74xzRvRifhNI79B4DEDFo0riMh3D
         1Blg==
X-Gm-Message-State: AOJu0YwJIdledxy/wEkd1VCRBhtQBQCk/aBhz1QAUyVLBysxJBBnFO5u
	Tw4z9A24Ef2BMleZ3G547MLH7J+CHmn7ajRaOJtcEX0f3DWKNDZq0yAA
X-Gm-Gg: ASbGncsxRs6fQGZL8EXBJ3QEDTVMFMdoJjhKUNSWTQYFOqp9A+WvnFulbcavp75Om7+
	a095T7Ncb/ccwZjuQaEHneo2CusfXQvPUp/Z72FykhE8brD/30otLTLEaWJ8KeagcTZzWFBm/2c
	/f66jBuvPOpwC1fnpa+al5rpKnLUqb+XwMPD2ll0kIKGL7YeDrWNwPIs3s29H6TXQ+t7zsThpnt
	/stilkEWUM+GtfbXnzmx/FcYXIOmqbE6xEi14kydgb1AEG3wT0AIuleIEiYF1zE2kOqWCbwcg+x
	jJ7tA35IZy6brpX2hmj+nmIbqQ==
X-Google-Smtp-Source: AGHT+IHDnLn/Gr54Fas6oQVfUD7K0AwWpBjA1WqJc6unF9/StNKY4QS33NWtH98wHBAqsEmoTF2f+A==
X-Received: by 2002:ad4:5eca:0:b0:6e5:a0fc:f663 with SMTP id 6a1803df08f44-6e8a0acbcccmr214109246d6.0.1741020798156;
        Mon, 03 Mar 2025 08:53:18 -0800 (PST)
Received: from citadel.lan ([2600:6c4a:4d3f:6d5c::1019])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8976cc9cdsm54730936d6.88.2025.03.03.08.53.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 08:53:16 -0800 (PST)
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
Subject: [PATCH v3 04/11] x86/smp: Move cpu number to percpu hot section
Date: Mon,  3 Mar 2025 11:52:39 -0500
Message-ID: <20250303165246.2175811-5-brgerst@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250303165246.2175811-1-brgerst@gmail.com>
References: <20250303165246.2175811-1-brgerst@gmail.com>
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
index c8508d78ef3e..d9d849535291 100644
--- a/arch/x86/include/asm/smp.h
+++ b/arch/x86/include/asm/smp.h
@@ -6,7 +6,8 @@
 #include <linux/thread_info.h>
 
 #include <asm/cpumask.h>
-#include <asm/current.h>
+
+DECLARE_PER_CPU_CACHE_HOT(int, cpu_number);
 
 DECLARE_PER_CPU_READ_MOSTLY(cpumask_var_t, cpu_sibling_map);
 DECLARE_PER_CPU_READ_MOSTLY(cpumask_var_t, cpu_core_map);
@@ -134,8 +135,8 @@ __visible void smp_call_function_single_interrupt(struct pt_regs *r);
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
index f4859516b190..6e604caa870c 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -21702,12 +21702,12 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 		if (insn->imm == BPF_FUNC_get_smp_processor_id &&
 		    verifier_inlines_helper_call(env, insn->imm)) {
 			/* BPF_FUNC_get_smp_processor_id inlining is an
-			 * optimization, so if pcpu_hot.cpu_number is ever
+			 * optimization, so if cpu_number is ever
 			 * changed in some incompatible and hard to support
 			 * way, it's fine to back out this inlining logic
 			 */
 #ifdef CONFIG_SMP
-			insn_buf[0] = BPF_MOV64_IMM(BPF_REG_0, (u32)(unsigned long)&pcpu_hot.cpu_number);
+			insn_buf[0] = BPF_MOV64_IMM(BPF_REG_0, (u32)(unsigned long)&cpu_number);
 			insn_buf[1] = BPF_MOV64_PERCPU_REG(BPF_REG_0, BPF_REG_0);
 			insn_buf[2] = BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_0, 0);
 			cnt = 3;
-- 
2.48.1


