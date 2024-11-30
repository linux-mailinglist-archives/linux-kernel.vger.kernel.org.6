Return-Path: <linux-kernel+bounces-426325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E10A9DF1C2
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 16:33:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B79FB20E18
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 15:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AEAB19E97E;
	Sat, 30 Nov 2024 15:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mhUhvnU0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF9B42AA4
	for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 15:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732980807; cv=none; b=WXhlreSoGscfri3O4NHRW0hW9vqGcNFva/pN2A8B+nmNo5/yPqFrxaU8pNaU555I2qcUjPKslr2cYLCT518NbrKMOLJqzjmAY5GsjB+YkjBjtzQZLE8BFVSfFnfx/dXYTGPZoZShVga0yPZJUSs+LEb36eG+Yelv7zTboKKKiCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732980807; c=relaxed/simple;
	bh=aym/4A9156Bez914Qw2rtg50lJsSoqpPIIeg7OlOfh4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PvlPS2vwmHg2NNNalES/O5pFOH/zTFs6KGqhmtR0DpKvmmMocENAXurXoKx3QhO8AC1T/HKKcpzMIarT5lDARzFVQpFJZbWE0KD2AC5XZBoWMCBv4Pc6icK8hNDT/72kHAJM1p0DXtPAAVkok34CQMyRkI7r5xaGuyDQhTaMYY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mhUhvnU0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64EFCC4CECC;
	Sat, 30 Nov 2024 15:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732980807;
	bh=aym/4A9156Bez914Qw2rtg50lJsSoqpPIIeg7OlOfh4=;
	h=From:To:Cc:Subject:Date:From;
	b=mhUhvnU0H52swI1Xu8cVLSMTZRRh+VKLWDPNChBm8tNEYkDzvoYWQUB1Ii0/ncyAR
	 vDYblsR5DGRzRZbIH0P1KyjE5Td08JUD8bVyYACG8e8lVuswJDxsttBB4E2aE8WEJ9
	 AKJtolzSYDARWN9bmxRSWejocd5Ob5KmRUV8J6pHTc/RirYH9HCMMwjkXkVXwRJpLC
	 lKABmc/j6AS0/KTcgZwU7fkROseu9S/icCxwDvP6OfCN7dABMqyEG/eOF+z8BhyTKZ
	 iCld/GsjmC0x3On5DsflD9dCFvISc6Qgvzfry/WhfgpBWwE3Z7FIhlDvpBfmKGY920
	 RRiHeiZAEgoNg==
From: guoren@kernel.org
To: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	guoren@kernel.org,
	bjorn@rivosinc.com,
	conor@kernel.org,
	leobras@redhat.com,
	peterz@infradead.org,
	parri.andrea@gmail.com,
	will@kernel.org,
	longman@redhat.com,
	boqun.feng@gmail.com,
	arnd@arndb.de,
	alexghiti@rivosinc.com
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Guo Ren <guoren@linux.alibaba.com>
Subject: [RESEND PATCH] riscv: Fixup boot failure when CONFIG_DEBUG_RT_MUTEXES=y
Date: Sat, 30 Nov 2024 10:33:10 -0500
Message-Id: <20241130153310.3349484-1-guoren@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Guo Ren <guoren@linux.alibaba.com>

When CONFIG_DEBUG_RT_MUTEXES=y, mutex_lock->rt_mutex_try_acquire
would change from rt_mutex_cmpxchg_acquire to
rt_mutex_slowtrylock():
	raw_spin_lock_irqsave(&lock->wait_lock, flags);
	ret = __rt_mutex_slowtrylock(lock);
	raw_spin_unlock_irqrestore(&lock->wait_lock, flags);

Because queued_spin_#ops to ticket_#ops is changed one by one by
jump_label, raw_spin_lock/unlock would cause a deadlock during the
changing.

That means in arch/riscv/kernel/jump_label.c:
1.
arch_jump_label_transform_queue() ->
mutex_lock(&text_mutex); +-> raw_spin_lock  -> queued_spin_lock
			 |-> raw_spin_unlock -> queued_spin_unlock
patch_insn_write -> change the raw_spin_lock to ticket_lock
mutex_unlock(&text_mutex);
...

2. /* Dirty the lock value */
arch_jump_label_transform_queue() ->
mutex_lock(&text_mutex); +-> raw_spin_lock -> *ticket_lock*
                         |-> raw_spin_unlock -> *queued_spin_unlock*
			  /* BUG: ticket_lock with queued_spin_unlock */
patch_insn_write  ->  change the raw_spin_unlock to ticket_unlock
mutex_unlock(&text_mutex);
...

3. /* Dead lock */
arch_jump_label_transform_queue() ->
mutex_lock(&text_mutex); +-> raw_spin_lock -> ticket_lock /* deadlock! */
                         |-> raw_spin_unlock -> ticket_unlock
patch_insn_write -> change other raw_spin_#op -> ticket_#op
mutex_unlock(&text_mutex);

So, the solution is to disable mutex usage of
arch_jump_label_transform_queue() during early_boot_irqs_disabled, just
like we have done for stop_machine.

Reported-by: Conor Dooley <conor@kernel.org>
Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
Fixes: ab83647fadae ("riscv: Add qspinlock support")
Link: https://lore.kernel.org/linux-riscv/CAJF2gTQwYTGinBmCSgVUoPv0_q4EPt_+WiyfUA1HViAKgUzxAg@mail.gmail.com/T/#mf488e6347817fca03bb93a7d34df33d8615b3775
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/riscv/kernel/jump_label.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/kernel/jump_label.c b/arch/riscv/kernel/jump_label.c
index 6eee6f736f68..654ed159c830 100644
--- a/arch/riscv/kernel/jump_label.c
+++ b/arch/riscv/kernel/jump_label.c
@@ -36,9 +36,15 @@ bool arch_jump_label_transform_queue(struct jump_entry *entry,
 		insn = RISCV_INSN_NOP;
 	}
 
-	mutex_lock(&text_mutex);
-	patch_insn_write(addr, &insn, sizeof(insn));
-	mutex_unlock(&text_mutex);
+	if (early_boot_irqs_disabled) {
+		riscv_patch_in_stop_machine = 1;
+		patch_insn_write(addr, &insn, sizeof(insn));
+		riscv_patch_in_stop_machine = 0;
+	} else {
+		mutex_lock(&text_mutex);
+		patch_insn_write(addr, &insn, sizeof(insn));
+		mutex_unlock(&text_mutex);
+	}
 
 	return true;
 }
-- 
2.40.1


