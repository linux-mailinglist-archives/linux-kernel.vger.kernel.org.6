Return-Path: <linux-kernel+bounces-277593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5AEB94A379
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 10:59:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BD611F25364
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 08:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF9491CB32D;
	Wed,  7 Aug 2024 08:59:13 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 572FA1C9ECF
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 08:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723021153; cv=none; b=atzhsZ9F6FejlbcfgppV3Hdgj7eNo1WZhxCwKoXY+ZvByu5sRK8+HvaaV32J0TWJnFCvdMApli9/7blzI/G+H/XvRWz8ZMONC9Msak7ln3HDqu0hYwzg0REGRcZOBn6yBuKE3+Z5ZwSEhgNmTWsZs9GNlo9ue6FQWbZk0Z2SDA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723021153; c=relaxed/simple;
	bh=dQdc4zvokUMe37PQ1p3xMiSz2t9xWE7Hfgtf9NLWvBE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BXGzJhhe+LMQt1+eXA0vX+6W4a45ussAsKAd+u+35zNLONk8dRpXBMwoSEl14STBzTTgqHHtzRtsW37P/n2yPDSwlHNJy45nyCWRMKlCH5ixMRBEDGSQvIsEl35SErsRaCQVWc/E91YQHWu4zaggzd6vWw7tuOYTwQcaIFrkzOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8Bx35teN7Nm0S8KAA--.5526S3;
	Wed, 07 Aug 2024 16:59:10 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowMDxvmdaN7NmO8EHAA--.24061S4;
	Wed, 07 Aug 2024 16:59:09 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Huacai Chen <chenhuacai@kernel.org>
Cc: loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/4] LoongArch: Remove STACK_FRAME_NON_STANDARD(do_syscall)
Date: Wed,  7 Aug 2024 16:59:04 +0800
Message-ID: <20240807085906.27397-3-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240807085906.27397-1-yangtiezhu@loongson.cn>
References: <20240807085906.27397-1-yangtiezhu@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMDxvmdaN7NmO8EHAA--.24061S4
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj9xXoW7JFykWr15JFyDtw4fWr48uFX_yoWDWrg_WF
	1xKw1UWrWrtF42v3Z5t3W5uF4xZw1kJFsakFn2gry7Ka43JrZ8JFyYv345CF1q9aykWrZ5
	urWkX3s0y34FyosvyTuYvTs0mTUanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUb3AYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1ln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
	xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q
	6rW5McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64
	vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_
	Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1V
	AY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Gr0_Xr1lIxAI
	cVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42
	IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIev
	Ja73UjIFyTuYvjxU4AhLUUUUU

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


