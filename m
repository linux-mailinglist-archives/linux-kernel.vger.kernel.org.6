Return-Path: <linux-kernel+bounces-250427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED2DA92F7BB
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 11:15:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9413284E68
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 09:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1874155735;
	Fri, 12 Jul 2024 09:15:13 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CE96146D7D
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 09:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720775713; cv=none; b=M1++3NTkMWkgWkAuHWc/WI6fb/lOEqdbSRqmBXkrRseCpDxJWqu7YbW82V+qFPaT9LQO4cYCn2wNEKQf270eVMOUb5D7vIl03sWQP7El/6uxk42bTVJ+qj4LglnjjPwtO62VB+ieVxVGbWW87fYlmHVb3OPfWJMMGzb3RGWunBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720775713; c=relaxed/simple;
	bh=BhMPK+2UGZnPdZ5DBECPNjhuoOBDB1q6Y91Peipk5aE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MMgDGiEObDClJWOaPtFP0kFCpe2BbBqLccJY6yoZRWn0S0TYLkSGgOUt0kf3PEhpbjdKxWVo2vgUC1LQcl4Cn/L0FIeQxOER2AhcwHeZsCdu3aYUi0WouyvfUf/4oNvxhbONE8+zD8rpW6VDYZhT/+IypQb2/OuqrvC57UALJHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8BxrfAd9JBmNqEDAA--.10364S3;
	Fri, 12 Jul 2024 17:15:09 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8BxXcca9JBmW65FAA--.28188S6;
	Fri, 12 Jul 2024 17:15:09 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Huacai Chen <chenhuacai@kernel.org>
Cc: Xi Ruoyao <xry111@xry111.site>,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 4/4] LoongArch: Remove -fno-jump-tables for objtool
Date: Fri, 12 Jul 2024 17:15:06 +0800
Message-ID: <20240712091506.28140-5-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240712091506.28140-1-yangtiezhu@loongson.cn>
References: <20240712091506.28140-1-yangtiezhu@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8BxXcca9JBmW65FAA--.28188S6
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7ur1fAryDXF45AF17ury7XFc_yoW8tr1fpr
	Z7Zr1kKw4kXF4vvry7J3yFgws8ArnrtF4aqF4xWFs5CrW2q34avw48AF4DGa48A3yDJ34I
	gFyfKa4aqa17CwbCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
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

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 arch/loongarch/Kconfig  | 8 +++++++-
 arch/loongarch/Makefile | 6 ++----
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index ddc042895d01..57f28450a2ed 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -143,7 +143,7 @@ config LOONGARCH
 	select HAVE_LIVEPATCH
 	select HAVE_MOD_ARCH_SPECIFIC
 	select HAVE_NMI
-	select HAVE_OBJTOOL if AS_HAS_EXPLICIT_RELOCS && AS_HAS_THIN_ADD_SUB && !CC_IS_CLANG
+	select HAVE_OBJTOOL if TOOLCHAIN_SUPPORTS_OBJTOOL && !CC_IS_CLANG
 	select HAVE_PCI
 	select HAVE_PERF_EVENTS
 	select HAVE_PERF_REGS
@@ -276,6 +276,12 @@ config AS_HAS_LBT_EXTENSION
 config AS_HAS_LVZ_EXTENSION
 	def_bool $(as-instr,hvcl 0)
 
+config CC_HAS_ANNOTATE_TABLEJUMP
+	def_bool $(cc-option,-mannotate-tablejump)
+
+config TOOLCHAIN_SUPPORTS_OBJTOOL
+	def_bool AS_HAS_EXPLICIT_RELOCS && AS_HAS_THIN_ADD_SUB && CC_HAS_ANNOTATE_TABLEJUMP
+
 menu "Kernel type and options"
 
 source "kernel/Kconfig.hz"
diff --git a/arch/loongarch/Makefile b/arch/loongarch/Makefile
index 8674e7e24c4a..186c75c80daa 100644
--- a/arch/loongarch/Makefile
+++ b/arch/loongarch/Makefile
@@ -99,10 +99,8 @@ KBUILD_AFLAGS			+= $(call cc-option,-mno-relax) $(call cc-option,-Wa$(comma)-mno
 KBUILD_CFLAGS			+= $(call cc-option,-mno-relax) $(call cc-option,-Wa$(comma)-mno-relax)
 KBUILD_AFLAGS			+= $(call cc-option,-mthin-add-sub) $(call cc-option,-Wa$(comma)-mthin-add-sub)
 KBUILD_CFLAGS			+= $(call cc-option,-mthin-add-sub) $(call cc-option,-Wa$(comma)-mthin-add-sub)
-
-ifdef CONFIG_OBJTOOL
-KBUILD_CFLAGS			+= -fno-jump-tables
-endif
+KBUILD_AFLAGS			+= $(call cc-option,-mannotate-tablejump) $(call cc-option,-Wa$(comma)-mannotate-tablejump)
+KBUILD_CFLAGS			+= $(call cc-option,-mannotate-tablejump) $(call cc-option,-Wa$(comma)-mannotate-tablejump)
 
 KBUILD_RUSTFLAGS		+= --target=loongarch64-unknown-none-softfloat
 KBUILD_RUSTFLAGS_MODULE		+= -Crelocation-model=pic
-- 
2.42.0


