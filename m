Return-Path: <linux-kernel+bounces-413908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6F009D2080
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 07:57:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC44E2826C6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 06:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FE5519755B;
	Tue, 19 Nov 2024 06:57:04 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DB96147C71
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 06:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731999424; cv=none; b=PaR38U63cXK2YH0qAt9O9h1gppA+LH0rNQQSLvVIBbvE1jCuNBB+2Ehh9eWkSu7NYizGR44dGiLRjupWmJubky+wOx28Z2WiYWnyfFpLCQNu+ci0lAMNZ05HeTAC6wB4AdOw0uLn4mk6/C+I39bbs2rtgRy8TeR0E0GdXX6gi+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731999424; c=relaxed/simple;
	bh=WuYh2QNbB1DXYMDkZ4MpKfVONFKDR2ri1ITDB4mHoqs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TLqeqEi08iSYP1f+7V5RqHgWnbhxqd2x9FAqmgdhETDjfJWcUgYxi+y/N4wVPO0TAxTkszDPlIu5PrTf7DrAW7yZH1tI6mUESyeSlfR+kcn1tx3Aws2Yqz+RBQpHqmjxwqBUVtWGXJvIcGQW0a63agxUbVMgNHEX8rnOSautcWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8DxL627NjxnWTZCAA--.25528S3;
	Tue, 19 Nov 2024 14:56:59 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowMCxDuG4NjxnB_5cAA--.5437S4;
	Tue, 19 Nov 2024 14:56:58 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Cc: loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 02/10] objtool: Handle special cases of dead end insn
Date: Tue, 19 Nov 2024 14:56:47 +0800
Message-ID: <20241119065655.21123-3-yangtiezhu@loongson.cn>
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
X-CM-TRANSID:qMiowMCxDuG4NjxnB_5cAA--.5437S4
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7CF4kuryfGr4DKr17uw47ZFc_yoW8WF4Dpa
	y5Cay3Jr4DXr48W3W7Wws5WryfKw4fGrW8XryfJ34UK3s8Xwn5KFn3tay2v3Zxua1ag3Wa
	qFsI934UZF1DArcCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
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
	CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r4j6ryUMIIF
	0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIx
	AIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2
	KfnxnUUI43ZEXa7IU8EeHDUUUUU==

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
 tools/objtool/check.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 9601235e908d..6607cd56459b 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -711,6 +711,18 @@ static int add_dead_ends(struct objtool_file *file)
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


