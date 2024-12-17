Return-Path: <linux-kernel+bounces-448407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C04FF9F3FC3
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 02:09:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA7AD7A1FBA
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 01:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE36445C14;
	Tue, 17 Dec 2024 01:09:15 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACA421EF1D
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 01:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734397755; cv=none; b=u2UQ/Pl8kCkUg1hQ7ReeXQjbVzAXOqyZK4LyDoASF1DqMVL7hSlBOHDSrGJGNz1K1Kc0Vt5/aqbOuFObj/ZrOsDaxYgncGI7nID8gDzV6TgMHe2F8m91LfoJ4/M/gTff+6l73C5ObJBIG96zfFEag+55kkkLTjtsyRbzTOwUVw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734397755; c=relaxed/simple;
	bh=ghomW4Asr9nZZDuFvIjfdu8xl+m+xqmzijjXD9V3DHk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XZGDfZfEpEykgOELB9KrZnE4pNIj2ZAThxAEHknkxkic7pUo+9WsUyuh3sNDvJ8rQ6cd6Jba8WxbLAByWfJRbRDtSzd9OpSsgWsAg4kiTjnSXjM+lveAwB6VSQD02ojdKw66lUUYZAUy1EPwnF+rG7q/NsNLxVAiyURtsmaXuhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8CxSOE0z2BnC5dXAA--.39573S3;
	Tue, 17 Dec 2024 09:09:09 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowMDxPEcyz2BnXNeFAA--.16436S2;
	Tue, 17 Dec 2024 09:09:06 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Cc: loongarch@lists.linux.dev,
	amd-gfx@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 0/9] Add jump table support for objtool on LoongArch
Date: Tue, 17 Dec 2024 09:08:56 +0800
Message-ID: <20241217010905.13054-1-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMDxPEcyz2BnXNeFAA--.16436S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7ur48Cr4DurW3Wr47KFWxuFX_yoW8ZrWfpF
	WUCrZ8Kr4rXr97J3srJ34YgFW3Jw4xWr1IqF13Gry5A3yUXw1UJr4fAayDtF1jg3yFgFyI
	qF4rWa1UGF4qyagCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUvEb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
	kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWU
	AwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI4
	8JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v26r1Y
	6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7
	AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE
	2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcV
	C2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73
	UjIFyTuYvjxU2MKZDUUUU

This version is based on tip/tip.git objtool/core branch [1], add some weak
and arch-specific functions to make the generic code more readable, tested
with the latest upstream mainline Binutils, GCC and Clang.

The first 6 patches are preparation for patch #7 to enable jump table for
objtool on LoongArch, the last 2 patches are small enough to fix objtool
warnings "funcA() falls through to next function funcB()", one is under
arch/loongarch and the other is under drm/amd/display.

v6:
  -- Add arch_reloc_size() for x86 and ppc.
  -- Call arch_reloc_size() directly in add_jump_table().
  -- Refine arch_adjust_offset() for LoongArch.
  -- Rename arch_adjust_offset() to arch_jump_table_sym_offset(). 
  -- Get each table size of rodata in time for switch table.
  -- Update the commit message to make it more clear.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/log/?h=objtool/core

Tiezhu Yang (9):
  objtool: Handle various symbol types of rodata
  objtool: Handle different entry size of rodata
  objtool: Handle PC relative relocation type
  objtool: Handle unreachable entry of rodata
  objtool/LoongArch: Add support for switch table
  objtool/LoongArch: Add support for goto table
  LoongArch: Enable jump table for objtool
  LoongArch: Convert unreachable() to BUG()
  drm/amd/display: Mark dc_fixpt_from_fraction() noinline

 arch/loongarch/Kconfig                        |   3 +
 arch/loongarch/Makefile                       |   6 +-
 arch/loongarch/kernel/machine_kexec.c         |   4 +-
 .../drm/amd/display/dc/basics/fixpt31_32.c    |   2 +-
 tools/objtool/arch/loongarch/decode.c         |  28 ++-
 .../objtool/arch/loongarch/include/arch/elf.h |   7 +
 tools/objtool/arch/loongarch/special.c        | 159 +++++++++++++++++-
 tools/objtool/arch/powerpc/decode.c           |  15 ++
 tools/objtool/arch/x86/decode.c               |  13 ++
 tools/objtool/check.c                         |  28 ++-
 tools/objtool/include/objtool/arch.h          |   3 +
 11 files changed, 251 insertions(+), 17 deletions(-)

-- 
2.42.0


