Return-Path: <linux-kernel+bounces-417775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D29779D58EF
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 05:51:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C4F9B21451
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 04:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 761BD16F839;
	Fri, 22 Nov 2024 04:50:30 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 869AC2309A3
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 04:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732251029; cv=none; b=OY0l9hO8lg2U2pAYr7iRLmNlpukR+Fnk1xKyl+tO3qOgmF2vFNoG5/pFO1h6H2RMKrvcxzjrWEYKsvObs6PrnwhM6fC/wGOkSMIpwCI2k2vy3PuYjcJ1pR9RxPq29NHss7TbPFuxVxDyipR4FfpyaHzIPhkdgO+khl9nl1u8Kdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732251029; c=relaxed/simple;
	bh=vOolnWiiYZj7d9EwA89wL2WhopR966rxwOdfgnLlMsQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uS3TcReyfbSqh0g48dF5Lem1UXfbvqotYyq6hHl7GKNIH8VnJiIuxH5a3KNK3iFqoM6zXXaJpcaB900rlKNazJ+5S8M6yBBH3Xl2PrRecU/ZDRwg7XjpmumkISO0ZQkHS/o7vV7lPBFPfelz4sq8xLU1jU2gYX1XG1XNSVUyvdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8DxQK+KDUBn97xFAA--.46944S3;
	Fri, 22 Nov 2024 12:50:18 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowMCxdcCIDUBnIJJiAA--.33733S4;
	Fri, 22 Nov 2024 12:50:18 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Cc: loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 02/10] objtool: Handle special cases of dead end insn
Date: Fri, 22 Nov 2024 12:49:57 +0800
Message-ID: <20241122045005.14617-3-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20241122045005.14617-1-yangtiezhu@loongson.cn>
References: <20241122045005.14617-1-yangtiezhu@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMCxdcCIDUBnIJJiAA--.33733S4
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7CF4kuryfGr4DKr17uw47ZFc_yoW8CF48pF
	Z8Cay5Jr4DXr4xW3W3Wr4rCr93Kw4fArWUXryfJ3yUK3s8Xwn5t3Z7tay2yas8Cw13W3W2
	vFs0k34UuF1UArcCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9Yb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1ln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
	xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q
	6rW5McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64
	vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_
	Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1V
	AY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Gr0_Xr1lIxAI
	cVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42
	IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIev
	Ja73UjIFyTuYvjxU4AhLUUUUU

There are some "unreachable instruction" objtool warnings when compling
with Clang on LoongArch, this is because the "break" instruction is set
as dead end due to its type is INSN_BUG in decode_instructions() at the
beginning, and it does not set insn->dead_end of the "break" instruction
as false after checking ".rela.discard.reachable" in add_dead_ends(), so
the next instruction of "break" is marked as unreachable.

Actually, it can find the reachable instruction after parsing the section
".rela.discard.reachable", in some cases, the "break" instruction may not
be the first previous instruction with scheduling by Machine Instruction
Scheduler of LLVM, it should find more times and then set insn->dead_end
of the "break" instruction as false.

This is preparation for later patch on LoongArch, there is no effect for
the other archs with this patch.

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 tools/objtool/check.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 9601235e908d..191950551352 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -22,6 +22,10 @@
 #include <linux/static_call_types.h>
 #include <linux/string.h>
 
+#ifndef EM_LOONGARCH
+#define EM_LOONGARCH		258
+#endif
+
 struct alternative {
 	struct alternative *next;
 	struct instruction *insn;
@@ -711,6 +715,18 @@ static int add_dead_ends(struct objtool_file *file)
 		}
 
 		insn->dead_end = false;
+
+		/* Handle the special cases compiled with Clang on LoongArch */
+		if (file->elf->ehdr.e_machine == EM_LOONGARCH &&
+		    reloc->sym->type == STT_SECTION) {
+			while (insn && insn_func(insn)) {
+				insn = prev_insn_same_sym(file, insn);
+				if (insn && insn->dead_end) {
+					insn->dead_end = false;
+					break;
+				}
+			}
+		}
 	}
 
 	return 0;
-- 
2.42.0


