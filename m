Return-Path: <linux-kernel+bounces-258023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B856938244
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 19:26:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C23F8B21138
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 17:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4DA81482FC;
	Sat, 20 Jul 2024 17:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O7pnNvgg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24AF113775E
	for <linux-kernel@vger.kernel.org>; Sat, 20 Jul 2024 17:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721496410; cv=none; b=kVvppl77Oz9PWxDuWOfAZnRzTZav3zbf/KCG9oQjXtHnBgjd6X0bi+o+70ood8coEV0ah991VUroJAbYAbaY49mva1cJDv5Ki3WlhCM7CWszqS9abs7X04eQO/hUTNn8SD45NrMYYwIgGUy+ayJ5fM+Kfqz6uQzHeiTsZkkJ2Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721496410; c=relaxed/simple;
	bh=F9nFEV1JgM51nYvYrMahJ9TSsZ4ZPpPIEacugupNX/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X5GjRbGo4kLepi6F1c9EOyFg5Kju5NDbgQ9/209akw84pR6PYA4LP/QJlUazYlJrC9Gs5T8rTDzKKfYVrjN9pGmyZqqCtWUqOKUpFDXk21Db8Si0IkquqH8Gcc/Zuh00/7sQodi0hR3rF2kRDJTQbVKuKqE+oL5t3lHe4WjOH6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O7pnNvgg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14FB6C2BD10;
	Sat, 20 Jul 2024 17:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721496409;
	bh=F9nFEV1JgM51nYvYrMahJ9TSsZ4ZPpPIEacugupNX/Y=;
	h=From:To:Cc:Subject:Date:From;
	b=O7pnNvgg2873Cdm1spRnosdWIHDzZAolV0j2w2rbjIRhpKTtoHycpJqG5/jjQmHam
	 L9MUVtaOabYFyLbo5vG3gABudZB5kaQS4Oq9hqwBKO3xxOpXPutTnFfZ1frf79oQSS
	 3nShmIO9dwIdDRF9B/Z/fcGEgkfFlIltHTuB0F5p0Vat6wyAUPyJclHNmi2XCs3jXW
	 WZZBUdD7EyjjjiO8v73+KeoeO1H7d06VUGJoVmgIvMgWb2cGUN8kkKlVQqyu5c+/8w
	 XlO+Llnq06zMmteuSJEsWbatvt1MQElwTKzh2djQGFSA1pVv1kbWx72d2Q10C5O84O
	 5WbNW9eVZE+zQ==
From: Jisheng Zhang <jszhang@kernel.org>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Deepak Gupta <debug@rivosinc.com>,
	Clement Leger <cleger@rivosinc.com>
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/7] riscv: convert bottom half of exception handling to C
Date: Sun, 21 Jul 2024 01:12:25 +0800
Message-ID: <20240720171232.1753-1-jszhang@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For readability, maintainability and future scalability, convert the
bottom half of the exception handling to C.

During the conversion, I found Anton fixed a performance issue[1]
and my patches will touch the same exception asm code, so this series
is applied against Anton's patch.

patch1 and patch2 are cleanup patches.
patch3~patch7 do the conversion and some cleanup/optimization
after conversion.

Mostly the assembly code is converted to C in a relatively
straightforward manner.

However, there are two modifications I need to mention:

1. the cause I.E the CSR_CAUSE value is passed to do_traps() via. 2nd
param, do_traps() doesn't get it from pt_regs because this way an extra
memory load is needed, the exception handling sits in hot code path,
every instruction matters.

2.To cope with SIFIVE_CIP_453 errata, it looks like we don't need
alternative mechanism any more after the asm->c conversion. Just
replace the excp_vect_table two entries.

Link: https://lore.kernel.org/linux-riscv/20240607061335.2197383-1-cyrilbur@tenstorrent.com/ [1]

since v1:
 - add two clean up patches
 - remove the two patches which fix imbalance in RAS, instead, explicitly
   mark this series is applied against one of them.
 - save cause in pt_regs prior to calling do_traps()
 - do more clean up and optimization after the asm->c conversion:
   staticalize and mark do_irq() as __always_inline.

Jisheng Zhang (7):
  riscv: traps: staticalize handle_break()
  riscv: traps: remove __visible annotation
  riscv: convert bottom half of exception handling to C
  riscv: errata: remove ALT_INSN_FAULT and ALT_PAGE_FAULT
  riscv: errata: sifive: remove NOMMU handling
  riscv: staticalize and remove asmlinkage from updated functions
  riscv: traps: mark do_irq() as __always_inline

 arch/riscv/errata/sifive/errata.c         | 25 +++++++---
 arch/riscv/errata/sifive/errata_cip_453.S |  4 --
 arch/riscv/include/asm/asm-prototypes.h   | 20 +-------
 arch/riscv/include/asm/entry-common.h     |  1 -
 arch/riscv/include/asm/errata_list.h      | 21 ++-------
 arch/riscv/kernel/entry.S                 | 57 +----------------------
 arch/riscv/kernel/kernel_mode_vector.c    |  2 +-
 arch/riscv/kernel/traps.c                 | 55 ++++++++++++++++++----
 8 files changed, 73 insertions(+), 112 deletions(-)

-- 
2.43.0


