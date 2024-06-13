Return-Path: <linux-kernel+bounces-213724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60A12907981
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 19:15:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D483D1F23E41
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 17:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 169941494D1;
	Thu, 13 Jun 2024 17:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="jM5Eyj1x"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E71D514A088
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 17:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718298894; cv=none; b=EK1JxLY42KobgvenTI9K6rB73d4IcrN3kDvREjt0PbSE6onpb2gF+E9SC67A/FYcjdJIzl40QSgaJS2JuffsqDaF4dUWR9HnqlMhUlrAl5olMqh+6jk4/7cMUIaINrOPfqm/SWFTUlJsRewsMFPZ/9q+sg75GZhQJRNL77k9Ynw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718298894; c=relaxed/simple;
	bh=ikUn9j7um+1PRt+XL0P1n+5KyCeKJKPW6ebX3/KMFFU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F4bX/EGUlrkRL1y5GmALMBW778xtlXraZfdExtTOiT5OaN/1fojxVW65I9mwt6jdBMwmpMvU7QTOWDJPH5NZVs/X8MM0PWy2oM03fVPJlKyj3k+wE5QPS77qCGbkHsC37eDqmlPFtiXeyDpIG14w2liEyj87keZLXUPatFQGa8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=jM5Eyj1x; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1f6f38b1ab0so10582565ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 10:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1718298892; x=1718903692; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aV8R4Wka+kWZfjkzpKS7OzxP5uBoNS2Fqf1rx+C8LXA=;
        b=jM5Eyj1x9kysN/eL2WCOQ1qiVAtBMZcC45qC3lP7BTYkY0Ohuga6CPr/0qFyWK5Pk8
         wZJxW+iNnDzb3aWP4Vr8sCYDmGM3ZeWCjEYchQq/UDczrJEzcEkAxbLeMul8VsQhgy+I
         Y8oWxbTWmzwWhaI5dm0prJ6aUjZo+ByycMi5tmYWjpoXb3vWhkgJnwbvma37nFxsdiWO
         ixk8NUqoirf4NSi3tfnDtnWKvME0+obebDEDPfqmKEFeuFyWNb3BEmRh0a/a/yZdIAS4
         ur1LegVabmg/1DTt8x9/6Z/MdaqxlTcZU9aW/K0Xb233X47STIit+LHnA4y7CNfX/J+h
         8ueg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718298892; x=1718903692;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aV8R4Wka+kWZfjkzpKS7OzxP5uBoNS2Fqf1rx+C8LXA=;
        b=WucOFfKc8QUDoq1aRrSce8XaEiPHTIIt4XX2+NACng5Xi/hg0BgzI5icyEnBpaBAgi
         5DRvph8TRKrjpsw1a8MEbgXrsE0g8UCIYYkEHeUg+D0oURIev2TN36vpW3TfHfr3vt7C
         aghXsYEuUJEu05gL+tyKP+IE1qjl/ut+3ZA0AjvNuwuIaD1eqBuF/oKC1SJN/p/5iLAl
         TxRp30b3xeQmIavdngBNgg7fhNdUBN7gCREOjWcbZpevtrl9I+DAxfZqrKhQtL8S5uMO
         Z9X09zKD84tIXlelf2jSWnobAm8+j28WIZqyvrKpetM8KgafRxhY9UO6H/QfaZs2Zini
         t4Ig==
X-Forwarded-Encrypted: i=1; AJvYcCV+cQ8eiYjfO8TK5vsl3egU51yR5tFC1lQsTImKkI0Oe4SvqTEVKB1vLmrqaMy1eJoiQkGyHLEy/ZuPkET/G39gsVXPYVxCV2QJSR7d
X-Gm-Message-State: AOJu0YyBXAlg+DRim8lU0/hIT1FRzLV4Y8Qagv9FT4EHrT6CS3q5KKwm
	t6UEOGEGd5kZVig/2wuV81M4Znf8QwMi5Q2GqIqk+zLeZgajY5mulaszRTqyRUylUEQbY+2Psay
	O
X-Google-Smtp-Source: AGHT+IE+AuA94KlSOrMmKKMHWCbLkDJ+fe3SrEJ/Bo4TkgvXZJ6nzIlGMF8rhlIZJZU0Xh5kVXXaSg==
X-Received: by 2002:a17:903:41cf:b0:1f7:17c2:118b with SMTP id d9443c01a7336-1f8627c76a1mr3144095ad.27.1718298892234;
        Thu, 13 Jun 2024 10:14:52 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855e55eb0sm16445035ad.18.2024.06.13.10.14.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 10:14:51 -0700 (PDT)
From: Samuel Holland <samuel.holland@sifive.com>
To: linux-riscv@lists.infradead.org,
	Palmer Dabbelt <palmer@dabbelt.com>
Cc: Andrew Jones <ajones@ventanamicro.com>,
	Conor Dooley <conor@kernel.org>,
	linux-kernel@vger.kernel.org,
	Deepak Gupta <debug@rivosinc.com>,
	Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH v2 2/3] riscv: Add support for per-thread envcfg CSR values
Date: Thu, 13 Jun 2024 10:14:40 -0700
Message-ID: <20240613171447.3176616-3-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.44.1
In-Reply-To: <20240613171447.3176616-1-samuel.holland@sifive.com>
References: <20240613171447.3176616-1-samuel.holland@sifive.com>
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

Reviewed-by: Deepak Gupta <debug@rivosinc.com>
Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

(no changes since v1)

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
index 4347c9f91dc3..b5b8773c57e8 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -772,7 +772,7 @@ unsigned long riscv_get_elf_hwcap(void)
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


