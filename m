Return-Path: <linux-kernel+bounces-266829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 62B6494083C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 08:20:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0655B225CE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 06:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D47D19005B;
	Tue, 30 Jul 2024 06:19:13 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8F1B18E766
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 06:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722320352; cv=none; b=I6Xj539xFi2++DFP71epNBWkuP0RTWgVtsu+cnluad1RMF2tlU2A+NMawJFuj7jKp80IbCo1V3r9vepvh0cOZHctJD3I6BV1W1gGzoo5fJ8srNwHyfyYpAF33hyRsqOlTbjbt/u9kaN0gT6jHStXvKEM281dgnsAjWKES+n6St4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722320352; c=relaxed/simple;
	bh=RGBxeBNAsLjNI0RAMKCCiMDIOMWMS7Ex43q2Wq8lM2c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IXfRnmmnU5OWqgISP7P7AA6uWHutGczbUp1dZSDEKA0XuDFWFrOs5vTkUMFrYdhFrh/qJnlc5Ryv9/Kr0SOrq3HdKQXCd/UYV75CGluQ93bZdICBeCSVzWrkW+e5b0DYlDFRraM2Unnck/kSNBqprpwv8vA0mTY+TdDmSHyLc48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8CxvOrYhahm00MEAA--.14883S3;
	Tue, 30 Jul 2024 14:19:04 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowMAxX8fVhahmehYGAA--.30051S4;
	Tue, 30 Jul 2024 14:19:03 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Huacai Chen <chenhuacai@kernel.org>
Cc: loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] LoongArch: Remove STACK_FRAME_NON_STANDARD(do_syscall)
Date: Tue, 30 Jul 2024 14:19:01 +0800
Message-ID: <20240730061901.21485-3-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240730061901.21485-1-yangtiezhu@loongson.cn>
References: <20240730061901.21485-1-yangtiezhu@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMAxX8fVhahmehYGAA--.30051S4
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj9xXoW7JFykXw45KFyrCFWktw4fWFX_yoWfJrX_GF
	1fKw1UWrWrJa12v3Z5t3W5ur4xu3WkJFsakFn29ry7Ka43Jry5Jryav345Cr1q9a1kWrZ5
	WrWkX3s0v34FyosvyTuYvTs0mTUanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUj1kv1TuYvT
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
stack frame".

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


