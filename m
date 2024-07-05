Return-Path: <linux-kernel+bounces-242565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D7F439289E0
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 15:38:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D4F21F250AD
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 13:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECFE11514F1;
	Fri,  5 Jul 2024 13:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TNsXabrs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A1F914F102
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 13:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720186641; cv=none; b=JuIQj7pB5J1Pw9YgmY9NFphHXS66X4q+Cz6BSW//postO7QBCwyIaG6U5/TiAADI73hH77bM4ryVsiajV/0Jnu/ZdcHRe1IHIuMVsS3XnZktzoV46Fz/DtSjJrQpk3in6H0L2/C/9NwekSEQq7qkfZJeyoGT+G2jX+BXBO8t4/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720186641; c=relaxed/simple;
	bh=bW7SJuoSHC50Ot48nvepYpmST048P10fAOtJVbkOwyc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O7kkqGaF397NI1cr2eX7YLlfwqKaUrAf1lX+lE91wzRqjHrll2gexsYjtgOOBNofGtT+62H4Rk+uQCC6pDs+VcgNG8RTpGnthNjqOhCsJ4uomaszke1PmWCjrC1zAwddROcPdhAb9mOzZ8o1lAhJLocTZzYWie6JuRnswzfWc1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TNsXabrs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8882BC116B1;
	Fri,  5 Jul 2024 13:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720186640;
	bh=bW7SJuoSHC50Ot48nvepYpmST048P10fAOtJVbkOwyc=;
	h=From:To:Cc:Subject:Date:From;
	b=TNsXabrs0ShnwnZTHeRTublv86zHKP2tctDSOXhpV5JHiYkfIquIjJJ/uSOabXsgH
	 r6WWm4zWABnBro+nEL26vAVfoCEFaZyxrKMUyPVy9hgb0aspNOX2ObU5ElrfF5EZ/H
	 kvDmCeaZZH+RpayjjJS3YJIYxosHkWP1ybEuR76B5oY8GDd/KSlLxe44r1Zbc5OT1Y
	 bGKaMlmQtjuBNPU6Jm0MBfQYf+qzOkJwrRBcczWWAB/61gWLNSB0aEk/3R2KVc8+Qi
	 LB7aHVmDqL3urthn8xe+JHynjTsUMmdYia8B+PMtuvrp+5dZJ155uGDlKm7IAOF5im
	 15i4Yan94IOBA==
From: Jisheng Zhang <jszhang@kernel.org>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] riscv: select ARCH_USE_SYM_ANNOTATIONS
Date: Fri,  5 Jul 2024 21:23:08 +0800
Message-ID: <20240705132308.1469-1-jszhang@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After commit 76329c693924 ("riscv: Use SYM_*() assembly macros instead
of deprecated ones"), riscv has been to the new style SYM_ assembler
annotations. So select ARCH_USE_SYM_ANNOTATIONS to ensure the
deprecated macros such as ENTRY(), END(), WEAK() and so on are not
available and we don't regress.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 arch/riscv/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 0525ee2d63c7..c51b32a8ddff 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -62,6 +62,7 @@ config RISCV
 	select ARCH_USE_CMPXCHG_LOCKREF if 64BIT
 	select ARCH_USE_MEMTEST
 	select ARCH_USE_QUEUED_RWLOCKS
+	select ARCH_USE_SYM_ANNOTATIONS
 	select ARCH_USES_CFI_TRAPS if CFI_CLANG
 	select ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH if MMU
 	select ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT if MMU
-- 
2.43.0


