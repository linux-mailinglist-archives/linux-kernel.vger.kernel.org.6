Return-Path: <linux-kernel+bounces-413909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F418C9D2081
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 07:57:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9FA5DB2128F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 06:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13212198A1A;
	Tue, 19 Nov 2024 06:57:05 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6E471547FF
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 06:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731999424; cv=none; b=Ld+UQdD9PMZ2gsABJ0Gsb1X/93DBxipk0Cr1q6tFyHH/jleh6FTxBoKbdUtxWqryRhBQoRjiTJYYZQavPzRV6VVph9TMWDuqGtHP1eSlpN0VJfJBtnTffRSNVrioq4Cp9foNhly8J7xBor4SQxL2PCzHTVZ8PADFvDNXOSvD4rA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731999424; c=relaxed/simple;
	bh=VDrSLNl8UiJkkF4mdSCSNIyphHZaNfU7cjWq9cSfkdk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hHx4XePhe8M8T7Ulow3qyPKcfjGg3J13AM1hWOWxiOEKjry127at+uTown9E9YqMImMRwA0zGKV1LDmwoSz5dWumb5g0BGyDfBCVMwiDe2K1DdwfQr7HxFsHJLxERSh6Olk4RdT+spHKEicXW6wyUF3svawB0BF0dYJEa6aqFe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8CxyuG8NjxnXzZCAA--.856S3;
	Tue, 19 Nov 2024 14:57:00 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowMCxDuG4NjxnB_5cAA--.5437S5;
	Tue, 19 Nov 2024 14:56:59 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Cc: loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 03/10] objtool: Handle different entry size of rodata
Date: Tue, 19 Nov 2024 14:56:48 +0800
Message-ID: <20241119065655.21123-4-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20241119065655.21123-1-yangtiezhu@loongson.cn>
References: <20241119065655.21123-1-yangtiezhu@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMCxDuG4NjxnB_5cAA--.5437S5
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7ur1fCr4kWw48AFW5ur1xJFc_yoW8Wry8pF
	13G3yrtrsYqry3WanrKan5urZ8uw42gry8JFZ7Kry8twnxXr1rJFZak34YkFWUX3sYg3Wf
	Zr98Kry8CF4DA3gCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9Fb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	tVWrXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7V
	AKI48JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v2
	6r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17
	CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26ryj6F1UMIIF
	0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIx
	AIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2
	KfnxnUUI43ZEXa7IU8EeHDUUUUU==

In the most cases, the entry size of rodata is 8 bytes because the
relocation type is 64 bit, but when compling with Clang on LoongArch,
there exists 32 bit relocation type, the entry size of rodata should
be 4 bytes in this case.

This is preparation for later patch on LoongArch, there is no effect
for the other archs with this patch.

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 tools/objtool/check.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 6607cd56459b..af824bfd0973 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -2092,6 +2092,7 @@ static int add_jump_table(struct objtool_file *file, struct instruction *insn,
 	struct reloc *reloc = table;
 	struct alternative *alt;
 	unsigned long offset;
+	unsigned long rodata_entry_size;
 
 	/*
 	 * Each @reloc is a switch table relocation which points to the target
@@ -2103,8 +2104,15 @@ static int add_jump_table(struct objtool_file *file, struct instruction *insn,
 		if (reloc != table && reloc == next_table)
 			break;
 
+		/* Handle the special cases compiled with Clang on LoongArch */
+		if (file->elf->ehdr.e_machine == EM_LOONGARCH &&
+		    reloc_type(reloc) == R_LARCH_32_PCREL)
+			rodata_entry_size = 4;
+		else
+			rodata_entry_size = 8;
+
 		/* Make sure the table entries are consecutive: */
-		if (prev_offset && reloc_offset(reloc) != prev_offset + 8)
+		if (prev_offset && reloc_offset(reloc) != prev_offset + rodata_entry_size)
 			break;
 
 		if (reloc->sym->type == STT_SECTION) {
-- 
2.42.0


