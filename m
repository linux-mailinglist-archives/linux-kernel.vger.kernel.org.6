Return-Path: <linux-kernel+bounces-274721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6B34947BDA
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 15:31:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C3AA1F235C3
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 13:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A96542AA9;
	Mon,  5 Aug 2024 13:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dgXs2uID"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CDBB41C65;
	Mon,  5 Aug 2024 13:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722864624; cv=none; b=MpjKlm6ZYqj49nneFZq+RRs3anxbNbuNwpHUFsiuhyd7PvfCRBSOVjqdBm0YiNwXwfpeuvuZWGOksYeRAJ+eIvyEPBS98UXn6jadpmgQ5hRQIxO7P/4CGbVMS1NHkTOd6myxXGFcqgIJElBk3+d75SR+Ias56zrPqyCHij92wHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722864624; c=relaxed/simple;
	bh=bZByem6u/WWAKyXoQLMIss6NWXsjus+uY2+EQu/RwbQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I1yGgPAabvx3jnM0oy83CKeCiIjmsJEeDeUFNImRrRti0lFkE7thoMt3YYXz2zEWGkBrHapuM4v1uLUdF+zASnrYX92VSGpHI3ErNGWWSryMJn//G2sSJJd4Uu+m9DoK0xp0k7xJZyoZcamLIF3SayZplNqyJ6qmEihriEtYqnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dgXs2uID; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFA10C4AF0D;
	Mon,  5 Aug 2024 13:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722864624;
	bh=bZByem6u/WWAKyXoQLMIss6NWXsjus+uY2+EQu/RwbQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dgXs2uIDj2T5U4SJgixwNLnCpoUL/xDW+D4HZq29O26nS+7rahDU1gc1g3NbOJyBU
	 HCZFP6t6Ig+tZnTtQbopJ6C8f/Ve48COmerpmKXiESCLiartZkA9ky73/UjWM8Paa8
	 XcEbSXoFGnqcatRxylqHJx2ggpJjfqfQGBiJyIRJvy0ivPi1neEqfUPzdl2Z6LdvlH
	 Ra6MsXW1OwqHm6OqLu2psnwFAIBaZAGiGCt8lbeu5WK42yI1xemd8z4FIOfUYCftfE
	 DUtO48b+yWTpkQ4Z63/e0yzngew4nUkqznm/S4l9r+54gxRHJFK4BQ+Gq8oF8k3k7P
	 diKb7m7f0Tn+Q==
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
Subject: [PATCH v2 3/5] x86/tdx: Allow MMIO from userspace
Date: Mon,  5 Aug 2024 15:29:44 +0200
Message-ID: <c48dd1ab33488d326c1526f5c9152c809cf2698f.1722862355.git.legion@kernel.org>
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

The MMIO emulation is only allowed for kernel space code. It is carried
out through a special API, which uses only certain instructions.

This does not allow userspace to work with virtual devices.

Allow userspace to use the same instructions as kernel space to access
MMIO. So far, no additional checks have been made.

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Alexey Gladkov (Intel) <legion@kernel.org>
---
 arch/x86/coco/tdx/tdx.c | 42 +++++++++++++++++++++++++++++++----------
 1 file changed, 32 insertions(+), 10 deletions(-)

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index 95f2ff49728c..4e2fb9bf83a1 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -484,6 +484,31 @@ static int valid_vaddr(struct ve_info *ve, enum insn_mmio_type mmio, int size,
 	return 0;
 }
 
+static int decode_insn_struct(struct insn *insn, struct pt_regs *regs)
+{
+	char buffer[MAX_INSN_SIZE];
+
+	if (user_mode(regs)) {
+		int nr_copied = insn_fetch_from_user(regs, buffer);
+
+		if (nr_copied <= 0)
+			return -EFAULT;
+
+		if (!insn_decode_from_regs(insn, regs, buffer, nr_copied))
+			return -EINVAL;
+
+		if (!insn->immediate.got)
+			return -EINVAL;
+	} else {
+		if (copy_from_kernel_nofault(buffer, (void *)regs->ip, MAX_INSN_SIZE))
+			return -EFAULT;
+
+		if (insn_decode(insn, buffer, MAX_INSN_SIZE, INSN_MODE_64))
+			return -EINVAL;
+	}
+	return 0;
+}
+
 static int handle_mmio_write(struct insn *insn, enum insn_mmio_type mmio, int size,
 			     struct pt_regs *regs, struct ve_info *ve)
 {
@@ -564,21 +589,14 @@ static int handle_mmio_read(struct insn *insn, enum insn_mmio_type mmio, int siz
 
 static int handle_mmio(struct pt_regs *regs, struct ve_info *ve)
 {
-	char buffer[MAX_INSN_SIZE];
 	enum insn_mmio_type mmio;
 	struct insn insn = {};
 	unsigned long vaddr;
 	int size, ret;
 
-	/* Only in-kernel MMIO is supported */
-	if (WARN_ON_ONCE(user_mode(regs)))
-		return -EFAULT;
-
-	if (copy_from_kernel_nofault(buffer, (void *)regs->ip, MAX_INSN_SIZE))
-		return -EFAULT;
-
-	if (insn_decode(&insn, buffer, MAX_INSN_SIZE, INSN_MODE_64))
-		return -EINVAL;
+	ret = decode_insn_struct(&insn, regs);
+	if (ret)
+		return ret;
 
 	mmio = insn_decode_mmio(&insn, &size);
 	if (WARN_ON_ONCE(mmio == INSN_MMIO_DECODE_FAILED))
@@ -774,6 +792,10 @@ static int virt_exception_user(struct pt_regs *regs, struct ve_info *ve)
 	switch (ve->exit_reason) {
 	case EXIT_REASON_CPUID:
 		return handle_cpuid(regs, ve);
+	case EXIT_REASON_EPT_VIOLATION:
+		if (is_private_gpa(ve->gpa))
+			panic("Unexpected EPT-violation on private memory.");
+		return handle_mmio(regs, ve);
 	default:
 		pr_warn("Unexpected #VE: %lld\n", ve->exit_reason);
 		return -EIO;
-- 
2.45.2


