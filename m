Return-Path: <linux-kernel+bounces-194797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C1DF8D423F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 02:17:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5990E2845C5
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 00:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 453278836;
	Thu, 30 May 2024 00:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="IoyQ5TPv"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B1F20EB
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 00:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717028258; cv=none; b=EwL6l22nmnVIx1JGPCjwxi2tyLbhThLA9QQW6pwCqMAIFNF/CCUciqYOIbRR/ccpqFo/tb1rBFOIQJoWw2Y1VlrpfL/+4QGzks/Y0LVfIOU+Egtqg1KKx5lOijkaaiy3zlQeNi7W8La6kFne9yph6vHtuH6VY2Z5YDCEKfD28uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717028258; c=relaxed/simple;
	bh=5Kwe/U7PxVluGsCYFpMPZL03B/JZXYv8/BfkMbqTtoU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WbVi4ekjaIMcx9zUCSTQMQzo4b8iRNiARNOctAmQdEG5tHowHotHj4kG7BZNJXzycUCUlRW47ez6Yt3JdSr6AxY11ptSPpEmWjHZwtpaNxWvKc8L2wzF6dFmrr+pPC2AY7oLwN5KnlEMCFKetjuNA8TRCxNrWY4nEOJojAm5ydA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=IoyQ5TPv; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6f8e9878514so283188b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 17:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1717028256; x=1717633056; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iGEn7Dcpmrkm/qCwkDxBmXXDS+7v8jGlOPv5lWfc4rI=;
        b=IoyQ5TPvCb2/+BRu/01JNWfp9xi1CPdxlLw11h1BkrDhdDcPXptoxr81kvyBNrr+bV
         yCSFVdQWkml8f2/QBjgz5CSiZl6jwJWOvDfUzTnJKyNEgwZUEiJBfJ6iYijEFiSCvCQA
         A7merkOUVk4MEN14gjdXuxf9xORlT/rgzHVzo09AtOky6n/R2wx1hb198pHqxj4/mBA2
         w0Iu54ahOnvnUlSIp8Un9vecUEn9fOdflf8xrMwZV9LtSrBvt8/AL3rNE/mheaCtDeps
         RLKC2A0dTxpGMWoqMGtaqQpgKl7gXGVEQeiKSL4JiYn6S2OLyy9lUnXl3LLfKQTp4QPv
         Hedg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717028256; x=1717633056;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iGEn7Dcpmrkm/qCwkDxBmXXDS+7v8jGlOPv5lWfc4rI=;
        b=fH1HfG4TdThKVCjnmZvq2aQ1YSy3w4CWYUBnVA+S+XQ3bX6nd4W+/pJwFEC2MtJwvL
         u3ZvtBKtA/GkQC/JXuTwxdobzvc55hixYe4BLadVugaDssF97lvY6CfwZCf1XxPJE+Z/
         GNnVe0mRhSotQ7asoG7/YkjJaZKiqtR4y1oYW69m7lqxyly48JekVX7aPac3vHlWnmld
         jYurK7yLMLC1LuM41XABVGdO5OEYglXJGTQxLq4D69SyHz0vlWRLLAL24PxjDu6jfFt7
         Q+7Wubg3hc5eLgMPzAYkcUVW2UU7bBJmOUU3awajumBTXF6/80Esgy2y2hXh5dJIH+So
         ZI9A==
X-Gm-Message-State: AOJu0YwWglj72WcIPQm+TTQ5NIdTBGuqJ5W6ti5Ibdrk6qbmrK6y3yEP
	rgtKGqdIWZ3qBcS8z8UeuDlhU5VFx5Y3tIHEHOis1+kHZdGrqvhL7BiX5F5jQY8=
X-Google-Smtp-Source: AGHT+IE028Zs3GXZwzDr0NEuUh/9Ff7JfEC5B6eJ6oSGemUdfJZybhS0OU9JqpK9c78Xe9tkO4uwlA==
X-Received: by 2002:a05:6a20:158f:b0:1af:cd4a:1e1d with SMTP id adf61e73a8af0-1b26470f21bmr645349637.40.1717028256348;
        Wed, 29 May 2024 17:17:36 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c1a776e206sm432171a91.20.2024.05.29.17.17.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 17:17:35 -0700 (PDT)
From: Samuel Holland <samuel.holland@sifive.com>
To: Palmer Dabbelt <palmer@dabbelt.com>
Cc: linux-kernel@vger.kernel.org,
	Andy Chiu <andy.chiu@sifive.com>,
	linux-riscv@lists.infradead.org,
	Matthew Bystrin <dev.mbstr@gmail.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH 1/4] riscv: Fix 32-bit call_on_irq_stack() frame pointer ABI
Date: Wed, 29 May 2024 17:15:56 -0700
Message-ID: <20240530001733.1407654-2-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.44.1
In-Reply-To: <20240530001733.1407654-1-samuel.holland@sifive.com>
References: <20240530001733.1407654-1-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

call_on_irq_stack() uses struct member offsets to set up its link in the
frame record list. On riscv32, `struct stackframe` is the wrong size to
maintain stack pointer alignment, so STACKFRAME_SIZE_ON_STACK includes
padding. However, the ABI requires the frame record to be placed
immediately below the address stored in s0, so the padding must come
before the struct members.

Fix the layout by making STACKFRAME_FP and STACKFRAME_RA the negative
offsets from s0, instead of the positive offsets from sp.

Fixes: 82982fdd5133 ("riscv: Deduplicate IRQ stack switching")
Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

 arch/riscv/kernel/asm-offsets.c | 4 ++--
 arch/riscv/kernel/entry.S       | 8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/riscv/kernel/asm-offsets.c b/arch/riscv/kernel/asm-offsets.c
index b09ca5f944f7..84c056f5ee09 100644
--- a/arch/riscv/kernel/asm-offsets.c
+++ b/arch/riscv/kernel/asm-offsets.c
@@ -487,8 +487,8 @@ void asm_offsets(void)
 	OFFSET(SBI_HART_BOOT_STACK_PTR_OFFSET, sbi_hart_boot_data, stack_ptr);
 
 	DEFINE(STACKFRAME_SIZE_ON_STACK, ALIGN(sizeof(struct stackframe), STACK_ALIGN));
-	OFFSET(STACKFRAME_FP, stackframe, fp);
-	OFFSET(STACKFRAME_RA, stackframe, ra);
+	DEFINE(STACKFRAME_FP, offsetof(struct stackframe, fp) - sizeof(struct stackframe));
+	DEFINE(STACKFRAME_RA, offsetof(struct stackframe, ra) - sizeof(struct stackframe));
 
 #ifdef CONFIG_DYNAMIC_FTRACE_WITH_ARGS
 	DEFINE(FREGS_SIZE_ON_STACK, ALIGN(sizeof(struct ftrace_regs), STACK_ALIGN));
diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
index 68a24cf9481a..4c5b22cb7381 100644
--- a/arch/riscv/kernel/entry.S
+++ b/arch/riscv/kernel/entry.S
@@ -246,8 +246,8 @@ SYM_CODE_END(ret_from_fork)
 SYM_FUNC_START(call_on_irq_stack)
 	/* Create a frame record to save ra and s0 (fp) */
 	addi	sp, sp, -STACKFRAME_SIZE_ON_STACK
-	REG_S	ra, STACKFRAME_RA(sp)
-	REG_S	s0, STACKFRAME_FP(sp)
+	REG_S	ra, (STACKFRAME_SIZE_ON_STACK + STACKFRAME_RA)(sp)
+	REG_S	s0, (STACKFRAME_SIZE_ON_STACK + STACKFRAME_FP)(sp)
 	addi	s0, sp, STACKFRAME_SIZE_ON_STACK
 
 	/* Switch to the per-CPU shadow call stack */
@@ -265,8 +265,8 @@ SYM_FUNC_START(call_on_irq_stack)
 
 	/* Switch back to the thread stack and restore ra and s0 */
 	addi	sp, s0, -STACKFRAME_SIZE_ON_STACK
-	REG_L	ra, STACKFRAME_RA(sp)
-	REG_L	s0, STACKFRAME_FP(sp)
+	REG_L	ra, (STACKFRAME_SIZE_ON_STACK + STACKFRAME_RA)(sp)
+	REG_L	s0, (STACKFRAME_SIZE_ON_STACK + STACKFRAME_FP)(sp)
 	addi	sp, sp, STACKFRAME_SIZE_ON_STACK
 
 	ret
-- 
2.44.1


