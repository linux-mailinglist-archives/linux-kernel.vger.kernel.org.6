Return-Path: <linux-kernel+bounces-274723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B94FA947BDC
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 15:31:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC8071C21BB2
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 13:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6B354D8B7;
	Mon,  5 Aug 2024 13:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FAqbFiE7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CDD544C7C;
	Mon,  5 Aug 2024 13:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722864633; cv=none; b=aisnuhqpnr1rv8D0y8Lkde+XGSRGdoDutf6V4xVFa+EYzt2Osq9IXjVUogLNmdeRwnzDmKG9QlWGku2DVnFJ/8RZnuSVzrn8u3gseWRcf81tau5e9DAkC66jz7kuPRNkfFouLMFXvVubqzjnzn2MqnnoPT7lRex0CfpgHXY+qSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722864633; c=relaxed/simple;
	bh=HebbKfNaui0e5CTtw/jnZCkv3vdS2QE7Ew+P8EfTDVs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=twGIYwfneAIBuzQL0ri3wH3Uf/M8x10GSk7T0GQg/BGdFPPwFS2h46zaa6WSlS00RzFU/gt+bNzV6fEVLNjpjVHky4tumTGhzqNcV2ZbpFBqgNofv6mvxgtJ29dEGA63WdERkmKGRUHJ8NrFQ4XYmSdqN7byIoi+2Xo/S7Z4h8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FAqbFiE7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16432C4AF0E;
	Mon,  5 Aug 2024 13:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722864632;
	bh=HebbKfNaui0e5CTtw/jnZCkv3vdS2QE7Ew+P8EfTDVs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FAqbFiE7CBcd/+K0P5YLLczF+7n0N7WuLsblk3LgpNUUzudxVArkE2HjxWShzX/WX
	 KP9uKaT50uQLkuPSlb3E6vZplFEoKLVWWBxzlrycm990Re/B7kl/MKFgzHGNRBXnyB
	 bU08nD7+tc6nd9PY21UcP8wIURfwIQjvKZpWJNynfXKjnmyCgC2C9w8mQuB2Rg/IGG
	 NhDOnkTis3YYMcD785yJTeL7YGYA9MSoVr2GAukqqgRVixlqQnkiY4DNpIR2Oc4pc8
	 xVHSXjVzkZhFzna502iFc+4U7Nbrp9pu0pTKvh/8M1uV9uhjmo1JrQzhyuVbGjxe64
	 XSkFp/7Shrn5Q==
From: "Alexey Gladkov (Intel)" <legion@kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Yuan Yao <yuan.yao@intel.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Yuntao Wang <ytcoode@gmail.com>,
	Kai Huang <kai.huang@intel.com>,
	Baoquan He <bhe@redhat.com>,
	Oleg Nesterov <oleg@redhat.com>,
	cho@microsoft.com,
	decui@microsoft.com,
	John.Starks@microsoft.com
Subject: [PATCH v2 5/5] x86/tdx: Implement movs for MMIO
Date: Mon,  5 Aug 2024 15:29:46 +0200
Message-ID: <83aa03c8f95ef00a6cf2fd6fa768c4b13e533d1c.1722862355.git.legion@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1722862355.git.legion@kernel.org>
References: <cover.1722356794.git.legion@kernel.org> <cover.1722862355.git.legion@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add emulation of the MOVS instruction on MMIO regions. MOVS emulation
consists of dividing it into a series of read and write operations,
which in turn will be validated separately.

Signed-off-by: Alexey Gladkov (Intel) <legion@kernel.org>
---
 arch/x86/coco/tdx/tdx.c | 57 ++++++++++++++++++++++++++++++++++++++---
 1 file changed, 53 insertions(+), 4 deletions(-)

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index 4e2fb9bf83a1..8573cb23837e 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -509,6 +509,54 @@ static int decode_insn_struct(struct insn *insn, struct pt_regs *regs)
 	return 0;
 }
 
+static int handle_mmio_movs(struct insn *insn, struct pt_regs *regs, int size, struct ve_info *ve)
+{
+	unsigned long ds_base, es_base;
+	unsigned char *src, *dst;
+	unsigned char buffer[8];
+	int off, ret;
+	bool rep;
+
+	/*
+	 * The in-kernel code must use a special API that does not use MOVS.
+	 * If the MOVS instruction is received from in-kernel, then something
+	 * is broken.
+	 */
+	if (WARN_ON_ONCE(!user_mode(regs)))
+		return -EFAULT;
+
+	ds_base = insn_get_seg_base(regs, INAT_SEG_REG_DS);
+	es_base = insn_get_seg_base(regs, INAT_SEG_REG_ES);
+
+	if (ds_base == -1L || es_base == -1L)
+		return -EINVAL;
+
+	rep = insn_has_rep_prefix(insn);
+
+	do {
+		src = ds_base + (unsigned char *) regs->si;
+		dst = es_base + (unsigned char *) regs->di;
+
+		ret = __get_iomem(src, buffer, size);
+		if (ret)
+			return ret;
+
+		ret = __put_iomem(dst, buffer, size);
+		if (ret)
+			return ret;
+
+		off = (regs->flags & X86_EFLAGS_DF) ? -size : size;
+
+		regs->si += off;
+		regs->di += off;
+
+		if (rep)
+			regs->cx -= 1;
+	} while (rep || regs->cx > 0);
+
+	return insn->length;
+}
+
 static int handle_mmio_write(struct insn *insn, enum insn_mmio_type mmio, int size,
 			     struct pt_regs *regs, struct ve_info *ve)
 {
@@ -530,9 +578,8 @@ static int handle_mmio_write(struct insn *insn, enum insn_mmio_type mmio, int si
 		return insn->length;
 	case INSN_MMIO_MOVS:
 		/*
-		 * MMIO was accessed with an instruction that could not be
-		 * decoded or handled properly. It was likely not using io.h
-		 * helpers or accessed MMIO accidentally.
+		 * MOVS is processed through higher level emulation which breaks
+		 * this instruction into a sequence of reads and writes.
 		 */
 		return -EINVAL;
 	default:
@@ -602,6 +649,9 @@ static int handle_mmio(struct pt_regs *regs, struct ve_info *ve)
 	if (WARN_ON_ONCE(mmio == INSN_MMIO_DECODE_FAILED))
 		return -EINVAL;
 
+	if (mmio == INSN_MMIO_MOVS)
+		return handle_mmio_movs(&insn, regs, size, ve);
+
 	vaddr = (unsigned long)insn_get_addr_ref(&insn, regs);
 
 	if (user_mode(regs)) {
@@ -630,7 +680,6 @@ static int handle_mmio(struct pt_regs *regs, struct ve_info *ve)
 	switch (mmio) {
 	case INSN_MMIO_WRITE:
 	case INSN_MMIO_WRITE_IMM:
-	case INSN_MMIO_MOVS:
 		ret = handle_mmio_write(&insn, mmio, size, regs, ve);
 		break;
 	case INSN_MMIO_READ:
-- 
2.45.2


