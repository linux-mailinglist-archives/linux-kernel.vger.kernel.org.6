Return-Path: <linux-kernel+bounces-435845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DA5E9E7DDE
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 02:59:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 167C4282708
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 01:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42C941BC2A;
	Sat,  7 Dec 2024 01:59:26 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA09722C6EB
	for <linux-kernel@vger.kernel.org>; Sat,  7 Dec 2024 01:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733536765; cv=none; b=HoW4OrvWrXUndfZTjOEITLqduW1npPcO6Pj8OuE1X39jjzmqXEDiPIIxIiNrqm5RMpX6u/AKjCex06Ya3D0avhQZPk6FVLevHDo9y180IKst2Y5y2xoAxc8XtrWcYDITpgVOl4KIC2HB5DLhI1hdAZiQhnVkmcE9iLJD5aVErMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733536765; c=relaxed/simple;
	bh=+Yo60HJbO1w1xRhZcdknx9CjoWsBzS+fiO+D0jDFnjg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c24hJn/LSFwD2PHFkVDB7g1Kn8kdy/DYoNt9bYEblrAKvkwxthpx26eMPEOV5bKrxbDlSjOPCM0ZfdquEhnbk40KGrlFZJoDCcEnCLZnwJEvmoWUQrKi29pPLq3tm6Sj5IGOE/211kSV4DhoG8/27Yk0AZ0nW7I7OPPbLlFb7no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8Dx_674q1NnDq1SAA--.56358S3;
	Sat, 07 Dec 2024 09:59:20 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowMBx_uD1q1Nn3Wd5AA--.42544S2;
	Sat, 07 Dec 2024 09:59:18 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Cc: loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 00/10] Add jump table support for objtool on LoongArch
Date: Sat,  7 Dec 2024 09:59:05 +0800
Message-ID: <20241207015915.1159-1-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMBx_uD1q1Nn3Wd5AA--.42544S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7ur48Cry7Gr17tw4xGF48GrX_yoW8Jw4kpF
	43CrZFgr18Xr97A3srJ34YgFW3Ga1xWr1Iq3W3Jry5AFWUXr1UJr4fZayDtFyjgw4YgFWI
	qF1rW3WUGF4qy3gCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
	8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AK
	xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64
	vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK
	8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
	0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07j1WlkUUUUU=

This version is based on tip/tip.git objtool/core branch [1], add some weak
and arch-specific functions to make the generic code more readable, tested
with the latest upstream mainline Binutils, GCC and Clang.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/log/?h=objtool/core

Tiezhu Yang (10):
  objtool: Handle various symbol types of rodata
  objtool: Handle different entry size of rodata
  objtool: Handle PC relative relocation type
  objtool: Handle unreachable entry of rodata
  objtool/LoongArch: Add support for switch table
  objtool/LoongArch: Get each table size of rodata
  objtool/LoongArch: Add support for goto table
  LoongArch: Enable jump table for objtool
  LoongArch: Convert unreachable() to BUG()
  drm/amd/display: Mark dc_fixpt_from_fraction() noinline

 arch/loongarch/Kconfig                        |   3 +
 arch/loongarch/Makefile                       |   6 +-
 arch/loongarch/kernel/machine_kexec.c         |   4 +-
 .../drm/amd/display/dc/basics/fixpt31_32.c    |   2 +-
 tools/objtool/arch/loongarch/decode.c         |  31 +++-
 .../objtool/arch/loongarch/include/arch/elf.h |   7 +
 tools/objtool/arch/loongarch/special.c        | 164 +++++++++++++++++-
 tools/objtool/check.c                         |  36 +++-
 tools/objtool/include/objtool/arch.h          |   3 +
 9 files changed, 239 insertions(+), 17 deletions(-)

-- 
2.42.0


