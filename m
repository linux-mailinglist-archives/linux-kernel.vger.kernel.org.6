Return-Path: <linux-kernel+bounces-286080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFFAD95163E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 10:11:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3BCD1C219BF
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 08:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29AB913D8A0;
	Wed, 14 Aug 2024 08:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Wpcj60dY"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9DAC13D635
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 08:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723623095; cv=none; b=AUH3Kpik8LDNjodJCkeQiMPzw0Wt+5yK0ywOY2bqn5ebTBM6Nh0Hyui82IHWw1sYNDb8VVrego9aWENP/atr0NmWGRI+tTKjcfUS9oGk8bCc47X0XLBJD5bWfGstrksQ2q3PgnYxhZuM7z8DxBjyvDZF4okIM6AyWnEAETyHxu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723623095; c=relaxed/simple;
	bh=ff3upR+ZeeRp6uurM2hTh1vGdh6k1qWsgOzOzTpGyn4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VaCSaigVFGPUE40EouWEVzcFW3ZzZgyC7lhhpY/GWvAdF7BXah5wQJ6qb8XGkahhwfY92o4zSEAhBPiNGOJ3Rip5kRTB6rNTM+W3Ynze48Ku6usdI0n98KvnHPDQcMQPr+bFw3Ff0BSEEMkZQN+VmBGIar/r92i5+950cG5KNf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=Wpcj60dY; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1fc4fcbb131so48901175ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 01:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1723623093; x=1724227893; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZPBDT7aylVUsHOeEB1LM43PupNXpIhM1dDweQwhBYlQ=;
        b=Wpcj60dYZz3GYHmIM9hOVlRTb5S/HsG3XaiPGHt6ZAA3isUWlhTOQVdExKwF+XydcC
         GjGGxHJYE/Lwr3fVG/0xWMvIE6TJgckHlDxwtvsjm/3mdKVNGhEoMGb4OrJn6LT0oWGe
         4rHb+dthlkcsywYoE6n5PzJAl+zmns7oC84BfLWYVguWT2ZBNFQk+vg++O0LvW5RPYZ+
         Nzxgarp9MoEXhy06iTL+IBipamQ69UyIpUKt130m+chElJq+BCbiF1SvTwBHxnzvWcNw
         MztAafhH+IR5KQFamR8PYhx0dPaMf7yguK+qdJaPLegHJ7asNIT/tubiSEfbhva3xS7a
         N/5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723623093; x=1724227893;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZPBDT7aylVUsHOeEB1LM43PupNXpIhM1dDweQwhBYlQ=;
        b=L/5NJ3QD7ESHegk7WK2jI32bVwlaSNeRfFvfn1WNWkA/fzek4aMfTewrsJtTgsNNQo
         DgHBWhPkSoIaJHSAg3rT2tTYJkw+3VFMAtOKGtL9xadtCuK0so7JKrpF6ETFMhQWuVDP
         Ap0tZ/EuhAmJQeOUhm8vC8CIDN6E2Vdd0IPJXkUKDoFgB6coosm1nxo48MJRjbMsef2N
         QPqJb3pOQVG7gw1qDXqVL6bWn1JKaC+SERdQb6oYJO3NsjK5jqlielA+ZcKV0JwRaTlP
         WQxompF789bjVN40pvBDfCSUGTXYIKToB0QaloR8z2O98HGu/guGkHDQeoUV5Ow9JrcX
         3Lsg==
X-Forwarded-Encrypted: i=1; AJvYcCVjcrIN2gV+5oGm9I+6QWBNL/8g/UEdVwo4lLxaSJwHPvgNmmUPwtN0ZtDJVIonkHoTHqaw7u58LI6aOEY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMDcbdDFfXK6ryKba3ITjCTLTKEtlz9hTClibjLI0RR0IBEZrX
	+aB9jIRm33twU/QX5MMxY2lXxv8k7k4AfWo4wSPhcvfB+MuKwHmk31hiNBimFYA=
X-Google-Smtp-Source: AGHT+IEqqh03VoThtjgWPQLBrpFrEOpKeAi4wVz6y0BwfWNUlOLSmFDsplnBip1l0vDTl8VOYklDcQ==
X-Received: by 2002:a17:902:ec8c:b0:201:daee:6fae with SMTP id d9443c01a7336-201daee71b6mr9353495ad.48.1723623093101;
        Wed, 14 Aug 2024 01:11:33 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201cd1a94d2sm24559955ad.127.2024.08.14.01.11.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 01:11:32 -0700 (PDT)
From: Samuel Holland <samuel.holland@sifive.com>
To: linux-riscv@lists.infradead.org,
	Palmer Dabbelt <palmer@dabbelt.com>
Cc: Andrew Jones <ajones@ventanamicro.com>,
	Conor Dooley <conor@kernel.org>,
	linux-kernel@vger.kernel.org,
	Deepak Gupta <debug@rivosinc.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Andy Chiu <andy.chiu@sifive.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Evan Green <evan@rivosinc.com>,
	Greentime Hu <greentime.hu@sifive.com>,
	Guo Ren <guoren@kernel.org>,
	Leonardo Bras <leobras@redhat.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Xiao Wang <xiao.w.wang@intel.com>
Subject: [PATCH v4 2/3] riscv: Add support for per-thread envcfg CSR values
Date: Wed, 14 Aug 2024 01:10:55 -0700
Message-ID: <20240814081126.956287-3-samuel.holland@sifive.com>
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

Some bits in the [ms]envcfg CSR, such as the CFI state and pointer
masking mode, need to be controlled on a per-thread basis. Support this
by keeping a copy of the CSR value in struct thread_struct and writing
it during context switches. It is safe to discard the old CSR value
during the context switch because the CSR is modified only by software,
so the CSR will remain in sync with the copy in thread_struct.

Use ALTERNATIVE directly instead of riscv_has_extension_unlikely() to
minimize branchiness in the context switching code.

Since thread_struct is copied during fork(), setting the value for the
init task sets the default value for all other threads.

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Reviewed-by: Deepak Gupta <debug@rivosinc.com>
Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

(no changes since v1)

 arch/riscv/include/asm/processor.h | 1 +
 arch/riscv/include/asm/switch_to.h | 8 ++++++++
 arch/riscv/kernel/cpufeature.c     | 2 +-
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/asm/processor.h
index 8702b8721a27..586e4ab701c4 100644
--- a/arch/riscv/include/asm/processor.h
+++ b/arch/riscv/include/asm/processor.h
@@ -124,6 +124,7 @@ struct thread_struct {
 	unsigned long s[12];	/* s[0]: frame pointer */
 	struct __riscv_d_ext_state fstate;
 	unsigned long bad_cause;
+	unsigned long envcfg;
 	u32 riscv_v_flags;
 	u32 vstate_ctrl;
 	struct __riscv_v_ext_state vstate;
diff --git a/arch/riscv/include/asm/switch_to.h b/arch/riscv/include/asm/switch_to.h
index 7594df37cc9f..9685cd85e57c 100644
--- a/arch/riscv/include/asm/switch_to.h
+++ b/arch/riscv/include/asm/switch_to.h
@@ -70,6 +70,13 @@ static __always_inline bool has_fpu(void) { return false; }
 #define __switch_to_fpu(__prev, __next) do { } while (0)
 #endif
 
+static inline void __switch_to_envcfg(struct task_struct *next)
+{
+	asm volatile (ALTERNATIVE("nop", "csrw " __stringify(CSR_ENVCFG) ", %0",
+				  0, RISCV_ISA_EXT_XLINUXENVCFG, 1)
+			:: "r" (next->thread.envcfg) : "memory");
+}
+
 extern struct task_struct *__switch_to(struct task_struct *,
 				       struct task_struct *);
 
@@ -103,6 +110,7 @@ do {							\
 		__switch_to_vector(__prev, __next);	\
 	if (switch_to_should_flush_icache(__next))	\
 		local_flush_icache_all();		\
+	__switch_to_envcfg(__next);			\
 	((last) = __switch_to(__prev, __next));		\
 } while (0)
 
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index 0139d4ea8426..df3e7e8d6d78 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -922,7 +922,7 @@ unsigned long riscv_get_elf_hwcap(void)
 void riscv_user_isa_enable(void)
 {
 	if (riscv_has_extension_unlikely(RISCV_ISA_EXT_ZICBOZ))
-		csr_set(CSR_ENVCFG, ENVCFG_CBZE);
+		current->thread.envcfg |= ENVCFG_CBZE;
 	else if (any_cpu_has_zicboz)
 		pr_warn_once("Zicboz disabled as it is unavailable on some harts\n");
 }
-- 
2.45.1


