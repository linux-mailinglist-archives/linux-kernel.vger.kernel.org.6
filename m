Return-Path: <linux-kernel+bounces-200925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C2838FB698
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 17:08:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D8501C22D53
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 15:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E12213D538;
	Tue,  4 Jun 2024 15:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="XPkOJh9F"
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E0D0C13B
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 15:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717513708; cv=none; b=lw7YYrXBZLoNjMjXKecb/yPfjrKgUaN+5h53l1L6o33rTqdBHpURJ74dVGT9MvKMSLeqsEh9cs14s4sryQfnbsggzbZ8qzvMRzgXdbWCv1Oj70mnI1SuoAE16GIml7QpQ7t77Iox+71vBwWsGTDp5RvRPn7qVPqWvPx0ZC7v/0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717513708; c=relaxed/simple;
	bh=l+dy70sDHZRUGv472okJcpGybgCB3YYbbShGSa334AE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EW9tMCdD9WA78EHkqkVRiK6Af+Kf31/0V/tAZjcbSvIfOTazEoew3N9+p7gdglZ8ix2XTNpdsEoEHB5gmhw9aQFNLsos2ORB1PduvJyht23AlKipB1KPRmPmu006OG3q8rBbWbYrUoHBMfQVfQLRXEZ2cr63WnZz//DtrkJxHKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=XPkOJh9F; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
	s=default; t=1717513694;
	bh=l+dy70sDHZRUGv472okJcpGybgCB3YYbbShGSa334AE=;
	h=From:To:Cc:Subject:Date:From;
	b=XPkOJh9FSsEt9Ma5ALXJ5TT5tCLPOIr96QoVoqvptlVowV6iJLvqTrhl90/q6GFm5
	 L8lEH66gDtHyMSfNJ2ve+1co7mb+cDXLP6cpEvmA9sJSg8Y++koepPSf1lA4WFG4T4
	 JnOafEoX1iQEpSgb07q3Sqiwnm6Z2JKhbWwJWKCQ=
Received: from stargazer.. (unknown [IPv6:240e:457:1110:1471:fd75:6c0d:bd6f:6068])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id 1C37E67245;
	Tue,  4 Jun 2024 11:08:00 -0400 (EDT)
From: Xi Ruoyao <xry111@xry111.site>
To: Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Youling Tang <tangyouling@kylinos.cn>,
	Jinyang He <hejinyang@loongson.cn>,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	mengqinggang@loongson.cn,
	cailulu@loongson.cn,
	wanglei@loongson.cn,
	luweining@loongson.cn,
	Yujie Liu <yujie.liu@intel.com>,
	Heng Qi <hengqi@linux.alibaba.com>,
	Tejun Heo <tj@kernel.org>,
	Xi Ruoyao <xry111@xry111.site>
Subject: [PATCH] loongarch: Only select HAVE_OBJTOOL and allow ORC unwinder if the inline assembler supports R_LARCH_{32,64}_PCREL
Date: Tue,  4 Jun 2024 23:07:41 +0800
Message-ID: <20240604150741.30252-1-xry111@xry111.site>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

GAS <= 2.41 does not support generating R_LARCH_{32,64}_PCREL for
"label - ." and it generates R_LARCH_{ADD,SUB}{32,64} pairs instead.
objtool cannot handle R_LARCH_{ADD,SUB}{32,64} pair in __jump_table
(static key implementation) and etc. so it will produce some warnings.
This is causing the kernel CI systems to complain everywhere.

For GAS we can check if -mthin-add-sub option is available to know if
R_LARCH_{32,64}_PCREL are supported.

For Clang, we require Clang >= 18 and Clang >= 17 already supports
R_LARCH_{32,64}_PCREL, so we can always assume Clang is fine for
objtool.

Note that __jump_table is not generated by the compiler so
-fno-jump-table is completely irrelevant for this issue.

Fixes: cb8a2ef0848c ("LoongArch: Add ORC stack unwinder support")
Closes: https://lore.kernel.org/loongarch/Zl5m1ZlVmGKitAof@yujie-X299/
Closes: https://lore.kernel.org/loongarch/ZlY1gDDPi_mNrwJ1@slm.duckdns.org/
Closes: https://lore.kernel.org/loongarch/1717478006.038663-1-hengqi@linux.alibaba.com/
Link: https://sourceware.org/git/?p=binutils-gdb.git;a=commitdiff;h=816029e06768
Link: https://github.com/llvm/llvm-project/commit/42cb3c6346fc
Signed-off-by: Xi Ruoyao <xry111@xry111.site>
---
 arch/loongarch/Kconfig       | 5 ++++-
 arch/loongarch/Kconfig.debug | 1 +
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index e38139c576ee..e461a6c59f15 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -143,7 +143,7 @@ config LOONGARCH
 	select HAVE_LIVEPATCH
 	select HAVE_MOD_ARCH_SPECIFIC
 	select HAVE_NMI
-	select HAVE_OBJTOOL if AS_HAS_EXPLICIT_RELOCS
+	select HAVE_OBJTOOL if AS_HAS_EXPLICIT_RELOCS && AS_HAS_THIN_ADD_SUB
 	select HAVE_PCI
 	select HAVE_PERF_EVENTS
 	select HAVE_PERF_REGS
@@ -273,6 +273,9 @@ config AS_HAS_LBT_EXTENSION
 config AS_HAS_LVZ_EXTENSION
 	def_bool $(as-instr,hvcl 0)
 
+config AS_HAS_THIN_ADD_SUB
+	def_bool $(cc-option,-Wa$(comma)-mthin-add-sub) || CC_IS_CLANG
+
 menu "Kernel type and options"
 
 source "kernel/Kconfig.hz"
diff --git a/arch/loongarch/Kconfig.debug b/arch/loongarch/Kconfig.debug
index 98d60630c3d4..8b2ce5b5d43e 100644
--- a/arch/loongarch/Kconfig.debug
+++ b/arch/loongarch/Kconfig.debug
@@ -28,6 +28,7 @@ config UNWINDER_PROLOGUE
 
 config UNWINDER_ORC
 	bool "ORC unwinder"
+	depends on HAVE_OBJTOOL
 	select OBJTOOL
 	help
 	  This option enables the ORC (Oops Rewind Capability) unwinder for
-- 
2.45.2


