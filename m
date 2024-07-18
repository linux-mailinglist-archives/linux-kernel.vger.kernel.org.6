Return-Path: <linux-kernel+bounces-255814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 412F2934578
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 02:56:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCAA01F226AA
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 00:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7AF83A1DB;
	Thu, 18 Jul 2024 00:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Ha1bOfRo"
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8773286A8
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 00:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721263717; cv=none; b=OmUVsSF1lK9dPqn0XCqRG4Flbggi+SikBR4Zn9oRY6uNep24x741dDYmaApBjhOcyiM6P9eq6Gz0ivelv+nh3cK22Yek6Q8PEwd0ThvV5SxHWllmlJuZbQOpoWKBZHCgiGpxMoC83OpapKUR9WUgd5AwW6doZgkyhqdlxDNudYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721263717; c=relaxed/simple;
	bh=hmKpDCFEog/ciMbNur3/GrkuPzJrWO1HrIYd74nYWyA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Smedwem3XSIWJFGXuyyAiuKoXy6AhOJKJHc3gtX0UQmXbs4hIweUENJNUy4JVeet4d2Aj0TFFm8qBoSWU7Ux6Fd8jc8svhG2+LOnRc7WzwlS2sHLfHz7oNRw13Ku6S6X/j01PnaQB8w29O/Q51LWmVylV3r2srFpnxhcN9URJTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=Ha1bOfRo; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5c694d5c5adso98375eaf.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 17:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1721263695; x=1721868495; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0yshoBMmTilnB7Tn31CojFxfms9fcaLBu92AZXjz1tU=;
        b=Ha1bOfRoqyd7mS0TFCt0UWa/o8wrCWtYMCFkpE/1YRCdq9PrZrnKyVlS7qgle8VNiw
         8fAsS15ko29Txl+eAYbKXw8R/rkHkhOhE91eqHW9/NQQw/3tKK88BK35MXo6iyqHS9bC
         lGYOM5u+saXOL+hssT4/8zLYKBC2OkuJBIMf2ZhnIDQraXgYm3Puxcgf9VLcuk0HMoRO
         gPd+yS4XiWmEYQy2guFhbLmLe7JnlQxbvcwjdOFaP3ORia3GIuorWKZrsDseOlMQIHlH
         Mb6ryOQEkC6+a8oQKadYZN4srkgqZb9TKQ5r/YedFjwDpF/YW0H2VvNvhyulYezjK2Ri
         E5Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721263695; x=1721868495;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0yshoBMmTilnB7Tn31CojFxfms9fcaLBu92AZXjz1tU=;
        b=CRuNcobRrsyM/l/gvfGJR3vNGFjakiO9KFH5tOih1mw+3Ps3P/sFU8O95RlsXET78W
         OjnAUdno7L6n8ghdgApnheExJs5nvvMHw4R8Dcrf6Fc1uMk7LGOZ7iWd2ZaFprvJLU+L
         pJLKGUCIJpokynOlkPgSX4ed980cYr1oEx6xtMrShtVKIWsMuHZhJ9NWIB4lSimGUM77
         4GVnJ1JKCpxbDYZWyRHW0vNHVe0wt5eCMzEn4KI2d625S9J/gdFeXgHRGCmmg9UY0fkw
         eyeQM43vMW198L39QqS0yJiPTnRQZFb0V+WZ4M7FqqAGVlhcAuJ3K6IRX1UlDSYxDyTC
         rrWQ==
X-Forwarded-Encrypted: i=1; AJvYcCWNyweinKl3SIGK0IW4AJhESSgW1YhN54yQNjpBfqZv+O/p7vhznPrb2x7nx0q0a6S2tI8OSly/RSxK1dKJV7cE7vFhuRupXV8/xlfw
X-Gm-Message-State: AOJu0YzEQwcjZdfO6Hc2YXShP2J9F8GMvMhAla83ooQkUy9d+M06cjW4
	xKezmJLNmci2rw2mMOQ0FrEo6l+7ApYhBEbGoBEYT+PwezhSBbly84ufCVOSsU4=
X-Google-Smtp-Source: AGHT+IFRqJmu713tBVUOkgi8JXhj0gBme+e9qJOsn5K+mQGju57nj8Rza2na6vwCvpeIB6ToTiVXyQ==
X-Received: by 2002:a05:6820:3095:b0:5c6:9320:4f1e with SMTP id 006d021491bc7-5d41d0c0709mr4511184eaf.6.1721263695492;
        Wed, 17 Jul 2024 17:48:15 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-78e386d53e4sm5694300a12.70.2024.07.17.17.48.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 17:48:14 -0700 (PDT)
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
Subject: [PATCH v3 2/3] riscv: Add support for per-thread envcfg CSR values
Date: Wed, 17 Jul 2024 17:47:55 -0700
Message-ID: <20240718004808.2246354-3-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240718004808.2246354-1-samuel.holland@sifive.com>
References: <20240718004808.2246354-1-samuel.holland@sifive.com>
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
index 4efaf12b470e..43fdae953379 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -878,7 +878,7 @@ unsigned long riscv_get_elf_hwcap(void)
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


