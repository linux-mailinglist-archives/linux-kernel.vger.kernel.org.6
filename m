Return-Path: <linux-kernel+bounces-417774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B7DF9D58EB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 05:50:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C3D01F22D16
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 04:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96DA6166F33;
	Fri, 22 Nov 2024 04:50:29 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3B4B15FD16
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 04:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732251029; cv=none; b=XWg32I7sirfUlSpYwZCkDQ26oQ2Tuqv3sZBBjdkCSKEgbcYuXk4l4R4Cnx9lYtjJ2dJ5SImjbH8qxlqovlu69843kBNGfxtLDrHbWhVwlOz3GXJIe4VUQ2241Cb5VN+ORuU13aIf19bBUZLttVbdNMxV8xx4gZfySzdMUbLIC1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732251029; c=relaxed/simple;
	bh=hpEJE6452kJP+gGj5WwMyHNX5Dc1z8fXf0Rr7Lf363M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NkC/CM2mxuRESs4N8yMxIfbREW3awn/z9zTzdFy5Xc3E2rnYx0gtO3QAubgl40jvijNGuN6EvgmUqmyhgAsCWim/GSvTeezh3n2YK24puavWCoQk4G1K0q434bFCgH/z15H4P1VlzbPIqr1JWfmLLTty04FBcbQXMjFxiX2/Fww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8CxSOGRDUBnGb1FAA--.5039S3;
	Fri, 22 Nov 2024 12:50:25 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowMCxdcCIDUBnIJJiAA--.33733S12;
	Fri, 22 Nov 2024 12:50:24 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Cc: loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 10/10] LoongArch: Enable jump table for objtool
Date: Fri, 22 Nov 2024 12:50:05 +0800
Message-ID: <20241122045005.14617-11-yangtiezhu@loongson.cn>
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
X-CM-TRANSID:qMiowMCxdcCIDUBnIJJiAA--.33733S12
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7uFWDuryUCw13Ww1kuryUJwc_yoW8Wr45pw
	s7Zr4kKw4kXF4vqrZrJrWSgrZ8trnrKr43WF429a4kArW7Z345Zr48ta9rW3WUCws5JrWI
	qFWfGa4avFWUJ3XCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9Ib4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAF
	wI0_Gr1j6F4UJwAaw2AFwI0_Jrv_JF1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2
	xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_
	Wrv_ZF1lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x
	0EwIxGrwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AK
	xVWUXVWUAwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
	AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW7JVWDJwCI
	42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCw
	CI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnI
	WIevJa73UjIFyTuYvjxUVCD7UUUUU

For now, it is time to remove -fno-jump-tables to enable jump table for
objtool if the compiler has -mannotate-tablejump, otherwise it is better
to remain -fno-jump-tables to keep compatibility with the older compilers.

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 arch/loongarch/Kconfig  | 3 +++
 arch/loongarch/Makefile | 4 ++++
 2 files changed, 7 insertions(+)

diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index bb35c34f86d2..500ee9b2cd88 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -284,6 +284,9 @@ config AS_HAS_LBT_EXTENSION
 config AS_HAS_LVZ_EXTENSION
 	def_bool $(as-instr,hvcl 0)
 
+config CC_HAS_ANNOTATE_TABLEJUMP
+	def_bool $(cc-option,-mannotate-tablejump)
+
 menu "Kernel type and options"
 
 source "kernel/Kconfig.hz"
diff --git a/arch/loongarch/Makefile b/arch/loongarch/Makefile
index ae3f80622f4c..6b84e633b8ce 100644
--- a/arch/loongarch/Makefile
+++ b/arch/loongarch/Makefile
@@ -101,8 +101,12 @@ KBUILD_AFLAGS			+= $(call cc-option,-mthin-add-sub) $(call cc-option,-Wa$(comma)
 KBUILD_CFLAGS			+= $(call cc-option,-mthin-add-sub) $(call cc-option,-Wa$(comma)-mthin-add-sub)
 
 ifdef CONFIG_OBJTOOL
+ifdef CONFIG_CC_HAS_ANNOTATE_TABLEJUMP
+KBUILD_CFLAGS			+= $(call cc-option,-mannotate-tablejump)
+else
 KBUILD_CFLAGS			+= -fno-jump-tables
 endif
+endif
 
 KBUILD_RUSTFLAGS		+= --target=loongarch64-unknown-none-softfloat
 KBUILD_RUSTFLAGS_KERNEL		+= -Zdirect-access-external-data=yes
-- 
2.42.0


