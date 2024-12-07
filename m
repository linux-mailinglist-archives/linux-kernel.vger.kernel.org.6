Return-Path: <linux-kernel+bounces-435853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6CA79E7DE6
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 03:00:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6744028703F
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 02:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57B6313B2B6;
	Sat,  7 Dec 2024 01:59:32 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18FE6126BF9
	for <linux-kernel@vger.kernel.org>; Sat,  7 Dec 2024 01:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733536771; cv=none; b=WoVIsE/U1Pt7bSje2DfFjEmEhliOVqFFaEfF+Mmjlsve9ujZ1lrZqMrqu26QM8IuJ+U/rIQwvO145VSablHnuj6DGUrcnoI2rSykAKy/gkvx5wh9EVtG2pBdl3VsLU5yZS5wx4PzoOgv0ntPcsKwl5RzAfbOGTYsXLURGAT6Q64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733536771; c=relaxed/simple;
	bh=B3KZMIw95MBg61/d6zZGkkqFyUQXS571JeCHkftd3nY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k/F7blJgckulZr15wSejqsrXVM9BkpcwzFIJ7rAX4N16VRtGTmPgHHYimCFexNwOjyukz29udoXH7HVjavFlw+iFH3M0nAegDDzCf60fUD0FcyMeO6zMqtM3gNtXww4TxW/Wjo09GxjUhoWfeRIZGU7l5SI1phE88qSSNXo4wBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8AxquEArFNnNa1SAA--.32929S3;
	Sat, 07 Dec 2024 09:59:28 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowMBx_uD1q1Nn3Wd5AA--.42544S10;
	Sat, 07 Dec 2024 09:59:27 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Cc: loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 08/10] LoongArch: Enable jump table for objtool
Date: Sat,  7 Dec 2024 09:59:13 +0800
Message-ID: <20241207015915.1159-9-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20241207015915.1159-1-yangtiezhu@loongson.cn>
References: <20241207015915.1159-1-yangtiezhu@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMBx_uD1q1Nn3Wd5AA--.42544S10
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7uFWDWF4fuF1fAw1xCr1xJFc_yoW8WrW3pw
	s7Zr4kKr4kWF1ktrZrJ3ySgr98JrnrKr43ZF42ga48ArW7Z3yUZr48ta9rXF15AwsxJrWI
	qFWfKasIvFWUJ3XCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9jb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
	kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWrXVW3
	AwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI4
	8JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v26r1Y
	6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7
	AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26ryj6F1UMIIF0xvE
	2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcV
	C2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2Kfnx
	nUUI43ZEXa7IU0E38UUUUUU==

For now, it is time to remove -fno-jump-tables to enable jump table for
objtool if the compiler has -mannotate-tablejump, otherwise it is better
to remain -fno-jump-tables to keep compatibility with older compilers.

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 arch/loongarch/Kconfig  | 3 +++
 arch/loongarch/Makefile | 6 +++++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index dae3a9104ca6..66980d847f4e 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -287,6 +287,9 @@ config AS_HAS_LBT_EXTENSION
 config AS_HAS_LVZ_EXTENSION
 	def_bool $(as-instr,hvcl 0)
 
+config CC_HAS_ANNOTATE_TABLEJUMP
+	def_bool $(cc-option,-mannotate-tablejump)
+
 menu "Kernel type and options"
 
 source "kernel/Kconfig.hz"
diff --git a/arch/loongarch/Makefile b/arch/loongarch/Makefile
index 567bd122a9ee..0304eabbe606 100644
--- a/arch/loongarch/Makefile
+++ b/arch/loongarch/Makefile
@@ -101,7 +101,11 @@ KBUILD_AFLAGS			+= $(call cc-option,-mthin-add-sub) $(call cc-option,-Wa$(comma)
 KBUILD_CFLAGS			+= $(call cc-option,-mthin-add-sub) $(call cc-option,-Wa$(comma)-mthin-add-sub)
 
 ifdef CONFIG_OBJTOOL
-KBUILD_CFLAGS			+= -fno-jump-tables
+ifdef CONFIG_CC_HAS_ANNOTATE_TABLEJUMP
+KBUILD_CFLAGS			+= -mannotate-tablejump
+else
+KBUILD_CFLAGS			+= -fno-jump-tables # keep compatibility with older compilers
+endif
 endif
 
 KBUILD_RUSTFLAGS		+= --target=loongarch64-unknown-none-softfloat -Ccode-model=small
-- 
2.42.0


