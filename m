Return-Path: <linux-kernel+bounces-413911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B5EC9D2083
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 07:58:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7DEB4B22ABE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 06:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9010C19CD17;
	Tue, 19 Nov 2024 06:57:07 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F3AA1991B4
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 06:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731999427; cv=none; b=C8eXV4lQaqAcFIbPdDBTdS7X/hJ6SsSHDAE/sHOfXEf+q23F2BdR1KA7JD/W5mNaJ59X0aZi715i4LXtoC4pTfzEbY0ArKhdqPtdnrUi26BkgQGXAImTurkKf5R9EzaZJhLTbF5CAyRSVhHscoi77oO84XZPUfkfp/pKcxKSsD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731999427; c=relaxed/simple;
	bh=ABz/vWnPLoWfMePrVIQsijD1UvXElWP1z/6f+ice6nw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LIo5I3yq8vgWsvdp5QhDwSslb3OdUCUUpUmKJHREYarYquMlvWjSkV24t+oBT2uSsFK2dINmhCvAzQeWjx9QyGK6GMnCQW7wWyMZ985ATm9d/Lw8v/LvueUoYjOLfuT4Zo7W+83sLbe+cTmXM4Em4AI/WLTnbG+xIDw9Ab5zs8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8DxDeO+NjxnZTZCAA--.63607S3;
	Tue, 19 Nov 2024 14:57:02 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowMCxDuG4NjxnB_5cAA--.5437S6;
	Tue, 19 Nov 2024 14:57:00 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Cc: loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 04/10] objtool: Handle PC relative relocation type
Date: Tue, 19 Nov 2024 14:56:49 +0800
Message-ID: <20241119065655.21123-5-yangtiezhu@loongson.cn>
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
X-CM-TRANSID:qMiowMCxDuG4NjxnB_5cAA--.5437S6
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7uFW7tr1fWw4DuF1kWFW7Awc_yoW8Jw4xpF
	y3u3y5KrsI9r17GwsrKa1kWrW5Cws7Wry7Xry09ry8ZF9xZF15Kay29a15Ca1UWwnYgayI
	vF9xKFy3A3WDA3gCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9Fb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
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
	KfnxnUUI43ZEXa7IU8N6pPUUUUU==

When compling with Clang on LoongArch, there exists 32 bit PC relative
relocation type, it needs to get the offset with "S + A - PC" according
to the spec of "ELF for the LoongArch Architecture".

This is preparation for later patch on LoongArch, there is no effect for
the other archs with this patch.

Link: https://github.com/loongson/la-abi-specs/blob/release/laelf.adoc
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 tools/objtool/check.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index af824bfd0973..eb4c89501493 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -2118,6 +2118,11 @@ static int add_jump_table(struct objtool_file *file, struct instruction *insn,
 		if (reloc->sym->type == STT_SECTION) {
 			/* Addend field in the relocation entry associated with the symbol */
 			offset = reloc_addend(reloc);
+			/* Handle the special cases compiled with Clang on LoongArch */
+			if (file->elf->ehdr.e_machine == EM_LOONGARCH &&
+			    reloc_type(reloc) == R_LARCH_32_PCREL)
+				offset = reloc->sym->offset + reloc_addend(reloc) -
+					 (reloc_offset(reloc) - reloc_offset(table));
 		} else {
 			/* The address of the symbol in the relocation entry */
 			offset = reloc->sym->offset;
-- 
2.42.0


