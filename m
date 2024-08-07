Return-Path: <linux-kernel+bounces-277595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3209D94A37B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 10:59:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC0CF1F24762
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 08:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B4F81CCB2B;
	Wed,  7 Aug 2024 08:59:14 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E68B91C9ED0
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 08:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723021153; cv=none; b=jMYpeP4L2MuXTtCSVdPESulgHG50HfDciCaMvlnHIt+SBtOxdyhQRW5aAgWN5vaWkvSbJoEwpMne5wfDhsdBCfax1LwUBsbLX2RoKPuA17dQujOIHaMdAX3WbzL+ltumyoa35Y9W0t+G79jdPFDONxOpX25nOtPzr8mLbqKExZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723021153; c=relaxed/simple;
	bh=aDLSs3jcaYViLbBjSbU8F3tnbR37g0VeBK80Qd0aUi0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BTWZNxW12CHzc/aeL49fdtURwdhmFxxrMFKdjJAixUopYyskHsU0fQmiF7xQXoen2JRhAmJY3t3zncDbfknX1CDgSkiJTQTtWaHAOoDjKYsfLuCN8X8HIiTZf24HHEhZbBtqbByp8i3ozg7GUNUs800pachHwkcVHNT0nvtjQmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8Dxh+leN7Nm1i8KAA--.30574S3;
	Wed, 07 Aug 2024 16:59:10 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowMDxvmdaN7NmO8EHAA--.24061S5;
	Wed, 07 Aug 2024 16:59:10 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Huacai Chen <chenhuacai@kernel.org>
Cc: loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/4] LoongArch: Set AS_HAS_THIN_ADD_SUB as y if AS_IS_LLVM
Date: Wed,  7 Aug 2024 16:59:05 +0800
Message-ID: <20240807085906.27397-4-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240807085906.27397-1-yangtiezhu@loongson.cn>
References: <20240807085906.27397-1-yangtiezhu@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMDxvmdaN7NmO8EHAA--.24061S5
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7Kw43tw1xtF4xXF4DZF4rXrc_yoW8Xr4xpw
	42vwn5AFW8WF48AFWDJ3yFg398Jr97Kay2grW7KFWrC398ZrWj9a47trnxKF1UKw4kt3yS
	qr4fCw1aga98JabCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9Fb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
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

When building kernel with "make CC=clang defconfig", LLVM Assembler
is used due to LLVM_IAS=0 is not specified, then AS_HAS_THIN_ADD_SUB
is not set, thus objtool can not be built after enable it for Clang.

config AS_HAS_THIN_ADD_SUB is to check whether -mthin-add-sub option is
available to know R_LARCH_{32,64}_PCREL are supported for GNU Assembler,
there is no this option for LLVM Assembler. The minimal version of Clang
is 18 for building LoongArch kernel, and Clang >= 17 already supports
R_LARCH_{32,64}_PCREL, that is to say, there is no need to depend on
AS_HAS_THIN_ADD_SUB for Clang, so just set AS_HAS_THIN_ADD_SUB as y if
AS_IS_LLVM.

Fixes: 120dd4118e58 ("LoongArch: Only allow OBJTOOL & ORC unwinder if toolchain supports -mthin-add-sub")
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 arch/loongarch/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index 70f169210b52..e1b6cb306d4d 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -265,7 +265,7 @@ config AS_HAS_FCSR_CLASS
 	def_bool $(as-instr,movfcsr2gr \$t0$(comma)\$fcsr0)
 
 config AS_HAS_THIN_ADD_SUB
-	def_bool $(cc-option,-Wa$(comma)-mthin-add-sub)
+	def_bool $(cc-option,-Wa$(comma)-mthin-add-sub) || AS_IS_LLVM
 
 config AS_HAS_LSX_EXTENSION
 	def_bool $(as-instr,vld \$vr0$(comma)\$a0$(comma)0)
-- 
2.42.0


