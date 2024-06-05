Return-Path: <linux-kernel+bounces-203217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 087FB8FD7F7
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 22:57:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42580B214A1
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 20:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF5CC15FA8E;
	Wed,  5 Jun 2024 20:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="RQrgwp5e"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E7815F304
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 20:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717621025; cv=none; b=BVQwG9vprJuDUFVC3kFt7NoK5Npul0ihef/te+1OxX8xYx5b0WfzBqKph8OE7Ppb7a9Xk4UPxA+gCoiiapq0Fxqru+HyYsP9olnkNqMuPHnLHRY356UWcMShuY3FxXRv6gt5TA8alC84Ea+MLpE9LkiIJDuvu9fz2yDkvpJ8OZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717621025; c=relaxed/simple;
	bh=mG512uQGDJDRQSetHea6N15e1/E0RyLER/3LVj9tvKM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eiqRDO2A91tsUc1mEE8JXG9uov9uIp9cgzJoHW+0U9hLsXcAclM+/9T8juRZdgFOL04s1FA7+fKKqzBkQBOf5Ap/QEaVwkqxwMSA9b07+fIlQVepYKGa0rl482ODai1W2pIPeRd7Yj9nKnaArnvpS7D+VSenHKaWLqX+UQnWZCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=RQrgwp5e; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1f4a5344ec7so1506065ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 13:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1717621023; x=1718225823; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3r1mxtMIe36MczsOX0LoCkPpmMGMczt9refp0xJPcqI=;
        b=RQrgwp5ewpAQLstIZ0JznsxEMCcChoEV2o1G5I3PuyyflVWfJF7BQSWOJ6m643WXmH
         V9D9xDct0DNXvP7NNGsylGUt3bJjFo9jKHf/iY3CUPKcpOr0oRtHyYYA6CdOq208XygF
         5fzDkaB9jotoSVcrS2smx7Y9iqYrafkM8xDI6OJLuIwKI0jM8F69wCeasRZYaKqQuVwl
         30FQDufNwosimaaMoBA1TgqD4Qxy3ZkrCSCpCbr3QnLBSY6arR6VfJEsq6TH8xUUCUBb
         WPwtFhpoGWa+K2UjE+9SghfTT5oOO4k/0kqy1RbNEPbLiemqNQ80DdpTDFaOzdice3cS
         pdPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717621023; x=1718225823;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3r1mxtMIe36MczsOX0LoCkPpmMGMczt9refp0xJPcqI=;
        b=CzQkX7GGjePrrCdXCftNTOhQDad5CR6is+toz4NvXH9exBAcdsy0m3XPdrr5/S31Xc
         W3H2mavUYMrfNWXPKuPvn6WHfEDI4hCInFDW8pzFD4wu9rw7ywYGNjIqrMcdYAC9afwW
         mp9mq1NGIuPH31lMq0OApB+Ek7FuGahxICRrwjMLUANx0SqNtyjwhKeyZCc7aXUz8CnM
         HvtMl682/81xd2zk3D122hCkGFfE4YgqjViOR/wdGHbWaAdpF5sYliUlRX4JrvohNa9o
         CzRsECerc/m1To4QQHV8snlv+Dlp/fbwK8fEd9lPe/Y8Ikp0dyISF8zqDAMjeSsgU5Ky
         KAaQ==
X-Forwarded-Encrypted: i=1; AJvYcCWoJxkI6vhBStZP3EovuOKKTUuapxXh1tN/d41rqSNcB4NWN91hnzmLoLxucvQawLxhHDkt0eycTGxA80V2MQi1wSnyvre9BWGuRU/+
X-Gm-Message-State: AOJu0Yyzx1XGichpYR3OEzAsJtkDUsOlQUJGri8doAiOVuXmO7oDNJHC
	ChFlZXVh/ANoq97WYpaCwDW62zaHSkobkVrl/FcwZpboEJ5f1CXtToyHrCOaQa8=
X-Google-Smtp-Source: AGHT+IGYEMlz2TI2K028q2R9LiSsS1U83s3xkaZ3dDH4PwwxuERT+O3HCrcKeci9losqt5I2efFSAQ==
X-Received: by 2002:a17:902:dac9:b0:1f4:808e:9f6e with SMTP id d9443c01a7336-1f6b8ee5023mr9974405ad.21.1717621022907;
        Wed, 05 Jun 2024 13:57:02 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6323dd86esm107332135ad.121.2024.06.05.13.57.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 13:57:02 -0700 (PDT)
From: Samuel Holland <samuel.holland@sifive.com>
To: linux-riscv@lists.infradead.org,
	Palmer Dabbelt <palmer@dabbelt.com>
Cc: Andrew Jones <ajones@ventanamicro.com>,
	Conor Dooley <conor@kernel.org>,
	linux-kernel@vger.kernel.org,
	Deepak Gupta <debug@rivosinc.com>,
	Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH 2/3] riscv: Add support for per-thread envcfg CSR values
Date: Wed,  5 Jun 2024 13:56:46 -0700
Message-ID: <20240605205658.184399-3-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.44.1
In-Reply-To: <20240605205658.184399-1-samuel.holland@sifive.com>
References: <20240605205658.184399-1-samuel.holland@sifive.com>
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

Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

 arch/riscv/include/asm/processor.h | 1 +
 arch/riscv/include/asm/switch_to.h | 8 ++++++++
 arch/riscv/kernel/cpufeature.c     | 2 +-
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/asm/processor.h
index 68c3432dc6ea..0838922bd1c8 100644
--- a/arch/riscv/include/asm/processor.h
+++ b/arch/riscv/include/asm/processor.h
@@ -118,6 +118,7 @@ struct thread_struct {
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
index 2879e26dbcd8..1153b96346ae 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -728,7 +728,7 @@ unsigned long riscv_get_elf_hwcap(void)
 void riscv_user_isa_enable(void)
 {
 	if (riscv_has_extension_unlikely(RISCV_ISA_EXT_ZICBOZ))
-		csr_set(CSR_ENVCFG, ENVCFG_CBZE);
+		current->thread.envcfg |= ENVCFG_CBZE;
 	else if (any_cpu_has_zicboz)
 		pr_warn_once("Zicboz disabled as it is unavailable on some harts\n");
 }
-- 
2.44.1


