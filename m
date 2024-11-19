Return-Path: <linux-kernel+bounces-413902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B47D9D2072
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 07:51:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 472942816CE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 06:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A94AC146D6E;
	Tue, 19 Nov 2024 06:51:28 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86B9D10F4
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 06:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731999088; cv=none; b=nRowQj6tmQSZTgJb2M8J3BTYSkrPeMUODXVq4J3gFLVVdFaTeUfnZ2FT46zv1qn60mR/osz8mHij1m8neRd/GWHCv/CEhi3LsExwYVPezUcW6M/JdRIsqIQkrhzg+oeJi7GdDl/kzkP6s1sJYT/17lpYgfeOXm3hhINMOHt1DNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731999088; c=relaxed/simple;
	bh=pQXaoanQc1vO50305oWY4AHRdDTnkO5qKs5Z2mC+6zQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qpT5ei/WN9YhSeYHi9XRFVogXknFS+YL36vqe+lfMGZ8zMwrglSs+SlPITkvMJj7ylPm55qi/s95kiOcXA4u8v5rxzUB+n2eaeSV8X38Bb24XkrLjSKM+VXTOnG+5JfggCNAQwUGdTlWKor62i2YZWhYaiSDZYi+vzT3XE7AknQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8AxQK1cNTxn6DRCAA--.25475S3;
	Tue, 19 Nov 2024 14:51:08 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowMAxDEdaNTxnWPxcAA--.28167S2;
	Tue, 19 Nov 2024 14:51:07 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] LoongArch: Fix build failure with GCC 15 (-std=gnu23)
Date: Tue, 19 Nov 2024 14:50:51 +0800
Message-ID: <20241119065051.18449-1-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMAxDEdaNTxnWPxcAA--.28167S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7WFWxtF1kZr17Cr4DXF1fAFc_yoW8Kw4Dpa
	nF9r1kGF4UWryIkryDA34avryDX34UGw12gay29Fy8CFyIgr1xXr409F98ZF18tw4jka4I
	ga43GwnxWayUZwcCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUkFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
	1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv
	67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2
	Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
	6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17MIIYrxkI7VAKI48JMIIF0x
	vE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE
	42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6x
	kF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07URa0PUUUUU=

Whenever I try to build the kernel with upcoming GCC 15 which defaults
to -std=gnu23 I get a build failure:

  CC      arch/loongarch/vdso/vgetcpu.o
In file included from ./include/uapi/linux/posix_types.h:5,
                 from ./include/uapi/linux/types.h:14,
                 from ./include/linux/types.h:6,
                 from ./include/linux/kasan-checks.h:5,
                 from ./include/asm-generic/rwonce.h:26,
                 from ./arch/loongarch/include/generated/asm/rwonce.h:1,
                 from ./include/linux/compiler.h:317,
                 from ./include/asm-generic/bug.h:5,
                 from ./arch/loongarch/include/asm/bug.h:60,
                 from ./include/linux/bug.h:5,
                 from ./include/linux/mmdebug.h:5,
                 from ./include/linux/mm.h:6,
                 from ./arch/loongarch/include/asm/vdso.h:10,
                 from arch/loongarch/vdso/vgetcpu.c:6:
./include/linux/stddef.h:11:9: error: expected identifier before 'false'
   11 |         false   = 0,
      |         ^~~~~
./include/linux/types.h:35:33: error: two or more data types in declaration specifiers
   35 | typedef _Bool                   bool;
      |                                 ^~~~
./include/linux/types.h:35:1: warning: useless type name in empty declaration
   35 | typedef _Bool                   bool;
      | ^~~~~~~

The kernel builds explicitly with -std=gnu11 in top Makefile, but
arch/loongarch/vdso does not use KBUILD_CFLAGS from the rest of the
kernel, just add -std=gnu11 flag to arch/loongarch/vdso/Makefile.

By the way, commit e8c07082a810 ("Kbuild: move to -std=gnu11") did a
similar change for arch/arm64/kernel/vdso32/Makefile.

Fixes: c6b99bed6b8f ("LoongArch: Add VDSO and VSYSCALL support")
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 arch/loongarch/vdso/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/loongarch/vdso/Makefile b/arch/loongarch/vdso/Makefile
index 40c1175823d6..fdde1bcd4e26 100644
--- a/arch/loongarch/vdso/Makefile
+++ b/arch/loongarch/vdso/Makefile
@@ -19,7 +19,7 @@ ccflags-vdso := \
 cflags-vdso := $(ccflags-vdso) \
 	-isystem $(shell $(CC) -print-file-name=include) \
 	$(filter -W%,$(filter-out -Wa$(comma)%,$(KBUILD_CFLAGS))) \
-	-O2 -g -fno-strict-aliasing -fno-common -fno-builtin \
+	-std=gnu11 -O2 -g -fno-strict-aliasing -fno-common -fno-builtin \
 	-fno-stack-protector -fno-jump-tables -DDISABLE_BRANCH_PROFILING \
 	$(call cc-option, -fno-asynchronous-unwind-tables) \
 	$(call cc-option, -fno-stack-protector)
-- 
2.42.0


