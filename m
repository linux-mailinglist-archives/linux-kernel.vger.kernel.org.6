Return-Path: <linux-kernel+bounces-569486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F794A6A391
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 11:25:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F0F019C1EAB
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 10:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1318E22422D;
	Thu, 20 Mar 2025 10:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="Zw5ciXRY"
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B80224229
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 10:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742466295; cv=none; b=M0ZvHN5ET9pHHSCx0PwCJznVOHVao+fkPSXp6LcqJgbMi99WHlMgOl4FvBHyutF57CiEtfdZ1CJb/BM5wca9QlRfSq2i7vJOUqQFZkmtf1Km0EYrHx7UQpgvKUWqPzLOI/9vZrH4f/zcPqRUAIYEAeBuONHGQjGKvdJBDn4CeuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742466295; c=relaxed/simple;
	bh=P6Cyg6ZZOL/bdfJ/B4iOaMgGeE2iSEc4uJhQIlA74AE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kSCmezvXtKLnOvdvoml64BpvddjLpygr/bYTzjabZgW045dwTBAUNPtgicTx2HyyXIFQAhOBDmKjrORnq3tsikTIQbOcTzIVqOk20mk234tWbnZaZev1WIh2UY5ueBZb4DMMAUtML1C+qTUnOyVJ+4rowrIQEBATYxS1ySIA76w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=Zw5ciXRY; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1742466212;
	bh=UQkpjbCZSJNKsn4kZHUA6N+b2zXax0ohSXZNeMcNv0g=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=Zw5ciXRYbGkdhcv38Eo7qJsiJcfVw1tKKJ+zMxZ4/H3NerxzVK9nOB6WYtz7a6/qd
	 /hq5rBtaJGTmwyttjh8mLyRZF87n4KF3qtAITC0yU6Kj4FZY+lxixN9GVpO93UDcK2
	 En78vzqpnJRm1VNwEuU4z5YxdomM8iYysK5fsro0=
X-QQ-mid: bizesmtpip3t1742466200t1f8q4h
X-QQ-Originating-IP: QU9FNwBoxjDpk5O9q9jrJU66DqalOoSS7/8913wuNAA=
Received: from localhost.localdomain ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 20 Mar 2025 18:23:18 +0800 (CST)
X-QQ-SSF: 0002000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 2980775555184553124
From: WangYuli <wangyuli@uniontech.com>
To: chenhuacai@kernel.org,
	kernel@xen0n.name
Cc: wangyuli@uniontech.com,
	guanwentao@uniontech.com,
	wentao@uniontech.com,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	zhangqing@loongson.cn,
	zhoubinbin@loongson.cn,
	lihui@loongson.cn,
	rdunlap@infradead.org,
	chenhuacai@loongson.cn,
	zhanjun@uniontech.com,
	niecheng1@uniontech.com
Subject: [PATCH] LoongArch: KGDB: Do not inline arch_kgdb_breakpoint()
Date: Thu, 20 Mar 2025 18:23:14 +0800
Message-ID: <EE51449BC2104F82+20250320102314.2062639-1-wangyuli@uniontech.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: NN51gi9eLBwaVbYlzEPeqmTIAxDuFI36Ki08YPBgNwm/yRt3mfSfrJCv
	TE2U+KCj3AZFXkxn62OALKtprdcV4NHLd9XL7yR89UfbijJuL4HZoWybDEAbr4mbACTMx4o
	o++QCDM7BUWGYlHFM9DxuXOnmLYg8I7lj5GQEWpKwx472iw4dJhdoviYMbls96vtuvOWKcC
	gbr5uHT1+W49P+gQoH1kQ38/UUAcdEQ3iGx9hZCBqtrQirw+yy6VCc+nE4d88duDRhxBI1H
	YgwUhsthaBAuopAhGYZ+UXYsyRXdPK2PzP22FzfyeHYAD6dH4Y4ZvVzRYOcx7+Bt0UtoaaS
	g0qpdEDHT7f3YNPg9TLuJa5AOjTTXSMp7ctnM1V4Ih5Gnet+FD9QeEGE0ELy3p8c7nVvXiT
	gbH5ZdXfLMRoTkvr+mN4Qoo8dxshAHI8wiPqotHbyKnDk2jFXXBNiBcc3YnZS8VDSBfBUbE
	zzTl8+1/P3x9kVNDw67uEBns7q5bgy8eUaPx39ZuJfJ5dHI/uUT//Wk2J2Ioke//fZfvh4q
	5g+4x/sllujMjrjWvPXNK55GxTxpfP+kU1LuhEk3K3+ZD8rSvevcMo8GaJbjh6PbnkVWAdK
	agNBbV6XyylBSkHNxgBBFA3XHKuKi2toQ9A1l/7sVRnRiiQ+rlrUUrbICcvcJulMTnmWBr5
	UJYSSIFcYZttBVMCGHNh8SpfrCj8tPsIIvpwVlB133bGnBsfz5XE2U+5cLpes4rU741GkDK
	ueRsHCYflA6NyNrAswwVJO2i+IEUgSEit+5HCv2btGBs8k09icJJbJimfeYP1iwg1YWUpSp
	/MoVQbt+hna5s/7fY8LY7IHnXtzHQaihb5WCT30zG6D3l9eD96hNsU4pyRTw4YK6LhdijrL
	yS2R7O4nG+UKqOsoESKIuJ8XjzYkiQUECKgvCAdhauPrsdRZmi47M8ewkBGtfIz5ilsFZI7
	k15vLblILXT09F3Wl0fqReIsVAdTqJxISmUHHaef95pohIopVr/PNwH6TVZoFV+eN6qgjPp
	SMmmF+U48Jgu2///kHTp4Ig2hSqD0=
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
X-QQ-RECHKSPAM: 0

The arch_kgdb_breakpoint() function defines the kgdb_breakinst
symbol using inline assembly.

There's a potential issue where the compiler might inline
arch_kgdb_breakpoint(), which would then define the kgdb_breakinst
symbol multiple times, leading to a linker error.

To prevent this, declare arch_kgdb_breakpoint() as noline.

Fix follow error with LLVM-19 *only* when LTO_CLANG_FULL:
    LD      vmlinux.o
  ld.lld-19: error: ld-temp.o <inline asm>:3:1: symbol 'kgdb_breakinst' is already defined
  kgdb_breakinst: break 2
  ^

Fixes: e14dd076964e ("LoongArch: Add basic KGDB & KDB support")
Co-developed-by: Winston Wen <wentao@uniontech.com>
Signed-off-by: Winston Wen <wentao@uniontech.com>
Co-developed-by: Wentao Guan <guanwentao@uniontech.com>
Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
Tested-by: Yuli Wang <wangyuli@uniontech.com>
Signed-off-by: Yuli Wang <wangyuli@uniontech.com>
---
 arch/loongarch/kernel/kgdb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/loongarch/kernel/kgdb.c b/arch/loongarch/kernel/kgdb.c
index 445c452d72a7..03ad4632e720 100644
--- a/arch/loongarch/kernel/kgdb.c
+++ b/arch/loongarch/kernel/kgdb.c
@@ -224,7 +224,7 @@ void kgdb_arch_set_pc(struct pt_regs *regs, unsigned long pc)
 	regs->csr_era = pc;
 }
 
-void arch_kgdb_breakpoint(void)
+noinline void arch_kgdb_breakpoint(void)
 {
 	__asm__ __volatile__ (			\
 		".globl kgdb_breakinst\n\t"	\
-- 
2.49.0


