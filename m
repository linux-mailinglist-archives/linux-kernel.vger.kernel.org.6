Return-Path: <linux-kernel+bounces-437959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B5029E9AFE
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 16:58:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3317E18872E3
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 15:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF23513B787;
	Mon,  9 Dec 2024 15:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="3DxMm+RY"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D1B2233139
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 15:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733759866; cv=none; b=mdV7mScLD7YZkaO5F/Tv1CA3ExGkERIllJZmMwxogScaPBVN0aaFncYtfrgWDDGKWes7s1EqWeawPWVbLF31yMwMUz5Y1Aof+ftIe4jbNUPigDMrMmX0Cf+r7FNFbE6cwf9Dwnj5cG25Nvk88I4/+41e8PpKUYccQHGxoDaNJd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733759866; c=relaxed/simple;
	bh=uXKsVOPQQOjKhT5uGKQlTgHj38iXml1HtM1n7maqc/o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VcXjSVslZ1CrOdv4k5V7KS6weFw59RAlHQbybbBTAphhhTnOroCYgpqX6M/frZMXeyydRKE+ETNIB6Wu/TqlIKiwOVWwVhz0439kArIYqYRC48UpWHr6qNSa16d39zFE3tDS3+CnXl68OONeNPci1ptf/gyz5mGvdQvFjIfBj2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=3DxMm+RY; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-725c24f3a89so2424477b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 07:57:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1733759864; x=1734364664; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HJgfJRwWboyVVdp2yBixPX3pFCmRzBh4c7ZZuQR90II=;
        b=3DxMm+RYqwVNRlEzHqwwjLhn6oDKB4VbrcFhc3TbwakkNewzJ+hPB42zPmcaszqYFQ
         Xv/wVL5VFmkHM1O5yS1VzAcFfOL8fxbdv1q2PokDmXnWQXsvTmKFuFwiaT/dUiCg6ytH
         3cIK3gVnFs8Dxv3+pkodvRHvia1f4uNPsTrIcbVVxBZlIQoL9nJ7Cw4C94fahxXwSgpK
         68QXZkpyukdcSgr+HzjpyR6JvBBktJOMMeJgcnIXAVC9PGP5Zj3cwPXKTc6Yh4K5zwsR
         CXPjeoEaoenjgqpwuHCiJ/mUXgyBjgz6mMWtx2dYqzEuRmIDfUrIZLgjuAiDnN0t/VXz
         fjnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733759864; x=1734364664;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HJgfJRwWboyVVdp2yBixPX3pFCmRzBh4c7ZZuQR90II=;
        b=amLBlo9i7yP8nPz5ROBdmO7uRs6PYcvMwXSHklMzqcQZj67+Xmm/vrlzsIT8e3XwZw
         eLJDjgflc4sak86cDnEj1g0qn+u2dmgHnlZj6c32e936PPl78jdyLuw4mo/d9wdE9LsE
         s9JaQyQ+Jf+A9/hO8fyTMDfUKnkMcn1GoI+xm6/IC74DAyT4dWe7LJhAdJBfql87MPqS
         5mHDzc64nLq5mi0A+OO0sppCA+R1KwvuLIrEOPPGVBLHQKTyfUVTX4kUYXTLT+bdDR5p
         Fy87qPcBgBVqM6gSNnchHklBcLKNHxJz1ZJRQgzLxN5N3pSyuTcHRfYX4SLU6sNrxUQa
         IIMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUWMAmtMtPjuV9jGyWPVgpr9vPkAiFT7J/2GcsFCUHPphtKyBQzHC41zJOs8GOmmT4zT/dDz6CRZ4r3St0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwM30fy0Lu2J1wyMhE3XxGRFoM1iDM9XHwIjkdd8bwzU3FDCLhg
	aDkCjw543BP5HPs7vVtqX95fpp3CED5CLHGiy0sS34dKDq7MVeydedJLFr1+sIY=
X-Gm-Gg: ASbGncveEyXwXtf+EDv6arth5MM8CjVO2FIjJJgD48LXTgCXrnUABTGopAIDeFs3F3D
	VkKKUVGA52svtpzPKhgl4kwHKimI9Q+47rVqCbGqyv/TIDj+W+xTvr3oRafH+ntCqPQD2KTFbwY
	sC9e1t7Pp9b9KsTvcPKYWIGMjTa2uaPRjKS+lUdydxd1z1xqfrHmuNYP6KtjtayDqKxCGQkWM0+
	dh16WjP3UlssDxrC3N9oai+ZoOq/ap6cN0F7VEq+I45JhHbVdY=
X-Google-Smtp-Source: AGHT+IF3SUxS6Oqh6v3V6CqksS4a3Vo4POx1ea0PFAbtVS5ly1340Tat37ZVq9GoRLgSr76MMFbbzQ==
X-Received: by 2002:a05:6a00:9289:b0:725:e499:5b8b with SMTP id d2e1a72fcca58-725e4995cc6mr7699800b3a.17.1733759863799;
        Mon, 09 Dec 2024 07:57:43 -0800 (PST)
Received: from carbon-x1.. ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725d16e7132sm4295833b3a.152.2024.12.09.07.57.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 07:57:43 -0800 (PST)
From: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	linux-riscv@lists.infradead.org (open list:RISC-V ARCHITECTURE),
	linux-kernel@vger.kernel.org (open list)
Cc: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Anton Blanchard <antonb@tenstorrent.com>
Subject: [PATCH] riscv: stacktrace: fix backtracing through exceptions
Date: Mon,  9 Dec 2024 16:57:12 +0100
Message-ID: <20241209155714.1239665-1-cleger@rivosinc.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Prior to commit 5d5fc33ce58e ("riscv: Improve exception and system call
latency"), backtrace through exception worked since ra was filled with
ret_from_exception symbol address and the stacktrace code checked 'pc' to
be equal to that symbol. Now that handle_exception uses regular 'call'
instructions, this isn't working anymore and backtrace stops at
handle_exception(). Since there are multiple call site to C code in the
exception handling path, rather than checking multiple potential return
addresses, add a new symbol at the end of exception handling and check pc
to be in that range.

Fixes: 5d5fc33ce58e ("riscv: Improve exception and system call latency")
Signed-off-by: Clément Léger <cleger@rivosinc.com>

---
 arch/riscv/kernel/entry.S      | 1 +
 arch/riscv/kernel/stacktrace.c | 4 +++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
index 216581835eb0..33a5a9f2a0d4 100644
--- a/arch/riscv/kernel/entry.S
+++ b/arch/riscv/kernel/entry.S
@@ -278,6 +278,7 @@ SYM_CODE_START_NOALIGN(ret_from_exception)
 #else
 	sret
 #endif
+SYM_INNER_LABEL(ret_from_exception_end, SYM_L_GLOBAL)
 SYM_CODE_END(ret_from_exception)
 ASM_NOKPROBE(ret_from_exception)
 
diff --git a/arch/riscv/kernel/stacktrace.c b/arch/riscv/kernel/stacktrace.c
index 153a2db4c5fa..d4355c770c36 100644
--- a/arch/riscv/kernel/stacktrace.c
+++ b/arch/riscv/kernel/stacktrace.c
@@ -17,6 +17,7 @@
 #ifdef CONFIG_FRAME_POINTER
 
 extern asmlinkage void handle_exception(void);
+extern unsigned long ret_from_exception_end;
 
 static inline int fp_is_valid(unsigned long fp, unsigned long sp)
 {
@@ -71,7 +72,8 @@ void notrace walk_stackframe(struct task_struct *task, struct pt_regs *regs,
 			fp = frame->fp;
 			pc = ftrace_graph_ret_addr(current, &graph_idx, frame->ra,
 						   &frame->ra);
-			if (pc == (unsigned long)handle_exception) {
+			if (pc >= (unsigned long)handle_exception &&
+			    pc < (unsigned long)&ret_from_exception_end) {
 				if (unlikely(!__kernel_text_address(pc) || !fn(arg, pc)))
 					break;
 
-- 
2.45.2


