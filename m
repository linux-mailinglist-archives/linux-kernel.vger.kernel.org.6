Return-Path: <linux-kernel+bounces-274143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44D839473E3
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 05:27:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BF721C20DC6
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 03:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 734011422AB;
	Mon,  5 Aug 2024 03:27:08 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34C5C13D521
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 03:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722828428; cv=none; b=jFwKxfW9APLhG3ryDp5Lnxkfe2QIqj3PCOHhyNEWNXB13dpyyd7OpUpMFfycFTrWuvIUPF+gi6vqYcbJ3PN9gMfFYWBvuOwUANqOTus+CO4VB35mEz9O/l+J4J5XSrTMQ4lU4OKAoO+GkFmPE9IlxVjxfsBv1Zy2MCT3NgvwJ8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722828428; c=relaxed/simple;
	bh=dQdc4zvokUMe37PQ1p3xMiSz2t9xWE7Hfgtf9NLWvBE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f2aNJvAQyK9GzC2oSSOR6rd99IZa48poAqyshIlMI3mnnehVFC0alSnstg63qpoRxHZVgoXS6UnNsEjmOW7BrZUWgq92nuC24alx54mJQmKb9XxPyHHO23am8TvjfnWOyUXuPV3UuRTh+HdRZYgMW98fNWy+tl+/ZbRiFdjR0o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8Dxh+mHRrBmI9AHAA--.25346S3;
	Mon, 05 Aug 2024 11:27:03 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowMDxkeGFRrBmgeADAA--.20473S5;
	Mon, 05 Aug 2024 11:27:03 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Huacai Chen <chenhuacai@kernel.org>
Cc: loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] LoongArch: Remove STACK_FRAME_NON_STANDARD(do_syscall)
Date: Mon,  5 Aug 2024 11:27:00 +0800
Message-ID: <20240805032700.16038-4-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240805032700.16038-1-yangtiezhu@loongson.cn>
References: <20240805032700.16038-1-yangtiezhu@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMDxkeGFRrBmgeADAA--.20473S5
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj9xXoW7JFykWr15JFyDtw4fWr48uFX_yoWDWrg_WF
	1xKw1UWrWrtF42v3Z5t3W5uF4xZw1kJFsakFn2gry7Ka43JrZ8JFyYv345CF1q9aykWrZ5
	urWkX3s0y34FyosvyTuYvTs0mTUanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUb38YFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267AKxVW8
	JVW8Jr1ln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2
	x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q6rW5
	McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr4
	1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_Jrv_
	JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17
	CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0
	I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I
	8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73
	UjIFyTuYvjxU4AhLUUUUU

For now, it can remove STACK_FRAME_NON_STANDARD(do_syscall) because
there is no objtool warning "do_syscall+0x11c: return with modified
stack frame", then there is handle_syscall() which is the previous
frame of do_syscall() in the call trace when executing the command
"echo l > /proc/sysrq-trigger".

Fixes: a0f7085f6a63 ("LoongArch: Add RANDOMIZE_KSTACK_OFFSET support")
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 arch/loongarch/kernel/syscall.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/loongarch/kernel/syscall.c b/arch/loongarch/kernel/syscall.c
index ba5d0930a74f..168bd97540f8 100644
--- a/arch/loongarch/kernel/syscall.c
+++ b/arch/loongarch/kernel/syscall.c
@@ -79,7 +79,3 @@ void noinstr __no_stack_protector do_syscall(struct pt_regs *regs)
 
 	syscall_exit_to_user_mode(regs);
 }
-
-#ifdef CONFIG_RANDOMIZE_KSTACK_OFFSET
-STACK_FRAME_NON_STANDARD(do_syscall);
-#endif
-- 
2.42.0


