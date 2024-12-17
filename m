Return-Path: <linux-kernel+bounces-448413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30FAB9F3FCE
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 02:11:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A021168869
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 01:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6033F1384BF;
	Tue, 17 Dec 2024 01:09:22 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E880288B1
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 01:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734397762; cv=none; b=MvfvMWWjmXi5k5Y6f10LFzN7wkwXMtwhsEWZWwE0LQ0Xg4VQnvgzAXl8paSLcc7menKe5yRyc2YEXqHymV/04ORN7rBZWu/CJzSbZjR8vfYO31VtV4ldbEd2TgVsTnjYq9JPQUnsBVDGVHhOpebfourUkLjcDZXbdvjduX37yrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734397762; c=relaxed/simple;
	bh=B3KZMIw95MBg61/d6zZGkkqFyUQXS571JeCHkftd3nY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NUrv3UXeWE/Zef+Hwv3O92mnDb40Qt4zqVC+cxC4NjqZUI5rXf/WTG+XC4bOBjG6ynivshI7YUQcTkQl72/5yZgQjFYEmLr9WfVSlMFEzAcgGxz2pv4zAiz/NR4C2P+5ujpqRpRGcTNrqnoLND2UMkY9cp5fvubXFRL/fV3+SSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8CxSOE+z2BnQ5dXAA--.39578S3;
	Tue, 17 Dec 2024 09:09:18 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowMDxPEcyz2BnXNeFAA--.16436S9;
	Tue, 17 Dec 2024 09:09:16 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Cc: loongarch@lists.linux.dev,
	amd-gfx@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 7/9] LoongArch: Enable jump table for objtool
Date: Tue, 17 Dec 2024 09:09:03 +0800
Message-ID: <20241217010905.13054-8-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20241217010905.13054-1-yangtiezhu@loongson.cn>
References: <20241217010905.13054-1-yangtiezhu@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMDxPEcyz2BnXNeFAA--.16436S9
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7uFWDWF4fuF1fAw1xCr1xJFc_yoW8WrW3pw
	s7Zr4kKr4kWF1ktrZrJ3ySgr98JrnrKr43ZF42ga48ArW7Z3yUZr48ta9rXF15AwsxJrWI
	qFWfKasIvFWUJ3XCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUB2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8JVW8Jr1ln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
	xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26rWY
	6Fy7McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64
	vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
	Jr0_Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
	xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0
	cI8IcVAFwI0_Xr0_Ar1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8V
	AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E
	14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU36RRDUUUU

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


