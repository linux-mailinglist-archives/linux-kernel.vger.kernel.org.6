Return-Path: <linux-kernel+bounces-286081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C404595163F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 10:12:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 522D41F20DD5
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 08:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08C981428E8;
	Wed, 14 Aug 2024 08:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="lLe+wz+x"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFEC013FD99
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 08:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723623097; cv=none; b=VR/T8ywDd56Rj3XktUOXmri4AW01HJh/HzC4W1dXuIfhcZIUNEK56lYDBZDo0f2Va94XNfa2x2ILARGnKYTuRdAczAG1wJcBcUwE70MDIeoqPDXthToc2RibyK8w9njL7VG7Fj3zs+LYnz7i1qJtKDft6fudasQY1WXGCJPgeRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723623097; c=relaxed/simple;
	bh=ZCWblSguAztupw7KNMH8hQmXQE1g3UJUzk1V7YFddmg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tJzZGRlG1y/c1IK3Gx1xZ3K1mckj0GxCPbu8xpoG7zZ9JjAHXaZQvBMQChIDSpBm7z79Jq0vFei/dyJ9SEHDKCFrmrmSUwpMV30qM5ycXX287vQuJQOjfQvtDbxykst0Q88SGYa91Cs58ujR89lyiBhHO/IkM1fROuIn4sTdYtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=lLe+wz+x; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-70d18d4b94cso4797422b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 01:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1723623095; x=1724227895; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HRg7k8b1pNHrGkCawN5XlEnE++zRqhFin8UtxZvnPiA=;
        b=lLe+wz+xCoqVAI+FVhekMuGmQWmKOKN862wtM2Iu/5/UJ1P0/HOmMMoxjiig8ql7mr
         pxq2ZcIWJ872cMK5tNejoiNH8Ysa6c/gbkjo9CAV1KVzM8l6Jt2lwTTBk1DDuKHbBWjo
         VgoNtaZeAI692rIRYnjhg83U8VKe5WrxdZs4Y2EFSUGa0Whse0SveB9kWyedYby7RYg7
         6KPTXljltbTkyPiV0rs5EeCU50Hj84SFYszYq+RKkSMbllm1aRor4wyCkQsT2kpkl1Q+
         zhnNo7sj8QvL4o5gF1xvlFHP8qQq7lANb1JhKO7qvdIJHUEgllmOWlaC4IYAm0DBsNnC
         GdfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723623095; x=1724227895;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HRg7k8b1pNHrGkCawN5XlEnE++zRqhFin8UtxZvnPiA=;
        b=Kr+pvsqWlK36MUtx/hgtaojknDqL0cOiit3CZd0Bh2RK6rXqHzCCKdSgM5wszH8QQX
         mBK+gaG+esXQOzLv3n/o3f6IKN3y5oiO2qaxbJlNSVwR2dRm647SI/6WhgLVkzPspNXq
         x5wW/uV6F4fEsJqGMBXLX6WHY3oesPi1DLt+nJPUpeIbXoMNATjkuKFBQ7TzgHvVSt0V
         8Sq4HJ2qO8poHLpWC/YmjxPXfL3wlpwzC1OYnO20cIxjZ+mqj/iqrgLSumUylnuz4bn+
         reQIn/aghY82qDLvUBsoswgkHAT8BQAVcg9cY55OuP6lD6osrvewZ8TUvgELgpui4JDG
         e7OA==
X-Forwarded-Encrypted: i=1; AJvYcCXC2eWSxMvQkzmnA9lBxAT6Nu9CTGgU2UERgrFg9yvCTYvuA9vKvJd5gwRkXXFsQSPqEzvalpsMaGPL/FOVE5GQpGpqXGRiadE1sVU8
X-Gm-Message-State: AOJu0YynfQuEpxlPgTxNWijD1XvpuEhEP4SLKsg5mx0eKmKJQMBgJ2ak
	9JMMbIxoxpAFuX/lu6FwOFkdEsDgtVigTsVzdoBymAIVQgw2uc1IHMcEgkCGKIw=
X-Google-Smtp-Source: AGHT+IH0hIuDifGPsQ/ifvUQj74P9NaxskpxaUYin4TYlEuYI0bGgoYZnDTa7sdcogfJRcGcPQNb/Q==
X-Received: by 2002:a05:6a20:8b1a:b0:1c8:eb6e:5817 with SMTP id adf61e73a8af0-1c8eb6e5864mr1613115637.5.1723623095015;
        Wed, 14 Aug 2024 01:11:35 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201cd1a94d2sm24559955ad.127.2024.08.14.01.11.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 01:11:34 -0700 (PDT)
From: Samuel Holland <samuel.holland@sifive.com>
To: linux-riscv@lists.infradead.org,
	Palmer Dabbelt <palmer@dabbelt.com>
Cc: Andrew Jones <ajones@ventanamicro.com>,
	Conor Dooley <conor@kernel.org>,
	linux-kernel@vger.kernel.org,
	Deepak Gupta <debug@rivosinc.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Andy Chiu <andy.chiu@sifive.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Evan Green <evan@rivosinc.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Xiao Wang <xiao.w.wang@intel.com>,
	Zhao Ke <ke.zhao@shingroup.cn>
Subject: [PATCH v4 3/3] riscv: Call riscv_user_isa_enable() only on the boot hart
Date: Wed, 14 Aug 2024 01:10:56 -0700
Message-ID: <20240814081126.956287-4-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240814081126.956287-1-samuel.holland@sifive.com>
References: <20240814081126.956287-1-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that the [ms]envcfg CSR value is maintained per thread, not per
hart, riscv_user_isa_enable() only needs to be called once during boot,
to set the value for the init task. This also allows it to be marked as
__init.

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Deepak Gupta <debug@rivosinc.com>
Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

Changes in v4:
 - Rebase on riscv/for-next (v6.11-rc)
 - Add Conor's Reviewed-by tags from v2 (missed in v3)

Changes in v3:
 - Drop use of __initdata due to conflicts with cpufeature.c refactoring

Changes in v2:
 - Rebase on riscv/for-next

 arch/riscv/include/asm/cpufeature.h | 2 +-
 arch/riscv/kernel/cpufeature.c      | 4 ++--
 arch/riscv/kernel/smpboot.c         | 2 --
 3 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/riscv/include/asm/cpufeature.h b/arch/riscv/include/asm/cpufeature.h
index 45f9c1171a48..ce9a995730c1 100644
--- a/arch/riscv/include/asm/cpufeature.h
+++ b/arch/riscv/include/asm/cpufeature.h
@@ -31,7 +31,7 @@ DECLARE_PER_CPU(struct riscv_cpuinfo, riscv_cpuinfo);
 /* Per-cpu ISA extensions. */
 extern struct riscv_isainfo hart_isa[NR_CPUS];
 
-void riscv_user_isa_enable(void);
+void __init riscv_user_isa_enable(void);
 
 #define _RISCV_ISA_EXT_DATA(_name, _id, _subset_exts, _subset_exts_size, _validate) {	\
 	.name = #_name,									\
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index df3e7e8d6d78..b3b9735cb19a 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -919,12 +919,12 @@ unsigned long riscv_get_elf_hwcap(void)
 	return hwcap;
 }
 
-void riscv_user_isa_enable(void)
+void __init riscv_user_isa_enable(void)
 {
 	if (riscv_has_extension_unlikely(RISCV_ISA_EXT_ZICBOZ))
 		current->thread.envcfg |= ENVCFG_CBZE;
 	else if (any_cpu_has_zicboz)
-		pr_warn_once("Zicboz disabled as it is unavailable on some harts\n");
+		pr_warn("Zicboz disabled as it is unavailable on some harts\n");
 }
 
 #ifdef CONFIG_RISCV_ALTERNATIVE
diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
index 0f8f1c95ac38..e36d20205bd7 100644
--- a/arch/riscv/kernel/smpboot.c
+++ b/arch/riscv/kernel/smpboot.c
@@ -233,8 +233,6 @@ asmlinkage __visible void smp_callin(void)
 	numa_add_cpu(curr_cpuid);
 	set_cpu_online(curr_cpuid, true);
 
-	riscv_user_isa_enable();
-
 	/*
 	 * Remote cache and TLB flushes are ignored while the CPU is offline,
 	 * so flush them both right now just in case.
-- 
2.45.1


