Return-Path: <linux-kernel+bounces-295663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 55D6F959FC4
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 16:26:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4399B22693
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 14:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7294E1B1D73;
	Wed, 21 Aug 2024 14:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CsZVnKF8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61E81B1D72;
	Wed, 21 Aug 2024 14:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724250359; cv=none; b=KDZnyK3GvIZN+xl+pkIqaKp0G4X0lIGzt8LbRXDXvQyD6L/42wQ3DMRBgHzW9jLnhG5DijYt17V/1ZY6wTAd7rt/jmWrxzXuxePMKSulgJSqYH5LGMAiFfZeHRT6c24JIT7jloAri/GIl8hzB2eYKgyy8qMDCr7FchNcLkfCH2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724250359; c=relaxed/simple;
	bh=VaLKxFNPhXvmxXUd47RV57VILsjFoGbx9brLSVYXouI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZG9QS3FPflINn6SMNm7swXDVCPXm/s/tRr/ry5MvFH7XIQMITYFFnTxndoBykgfwbAYLRa/pkwCmdXn6uEbeRBTdAzZWxhk9hL8FElVMqP7YHAeWQnmhO2ol3+58oaay7rjNLq0ZzXwLa8adkQpAI8o+NJE/jAa5iDmKHoZ581o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CsZVnKF8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C2CDC32786;
	Wed, 21 Aug 2024 14:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724250359;
	bh=VaLKxFNPhXvmxXUd47RV57VILsjFoGbx9brLSVYXouI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CsZVnKF8rqFsoiX6mWmS69pxHFoCtD4TROgyZMxvjoA5uKkuQbog/3NbQOQ6vry6y
	 iIqHKnDj5iXmFw3wIy6VvP07/D/yBxIHvijUp+3A6EFdbIWS5LpIZfwYV6pNoW/cV+
	 UqH4IBwzwosw+OOAXqH5mWJ71tfWxPWJml070WwINL5SQKS8eAeVU6PV40HzDFsAiT
	 i6BqHhiHR+cnijEMqt+2JQZnN1Fj7CTrRcPne3SvQ8jC35OxfyGkBIHSk+ZI/8Q3AC
	 dZnwJbU8Q7r9tAu5W1GJEDPrQDZFx3KXkITOP4PuojNPvFKhENVS0G5fxBomhCK+lv
	 bwzOaT6OnOvig==
From: Alexey Gladkov <legion@kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev
Cc: "Alexey Gladkov (Intel)" <legion@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
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
Subject: [PATCH v4 3/6] x86/tdx: Allow MMIO from userspace
Date: Wed, 21 Aug 2024 16:24:35 +0200
Message-ID: <41b77c0ad25ceed006d59ba259b3c2f0a7ee74e5.1724248680.git.legion@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1724248680.git.legion@kernel.org>
References: <cover.1723807851.git.legion@kernel.org> <cover.1724248680.git.legion@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Alexey Gladkov (Intel)" <legion@kernel.org>

The MMIO emulation is only allowed for kernel space code. It is carried
out through a special API, which uses only certain instructions.

This does not allow userspace to work with virtual devices.

Allow userspace to use the same instructions as kernel space to access
MMIO. Additional checks have been added previously.

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Alexey Gladkov (Intel) <legion@kernel.org>
---
 arch/x86/coco/tdx/tdx.c | 43 +++++++++++++++++++++++++++++++----------
 1 file changed, 33 insertions(+), 10 deletions(-)

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index 99634e12f9a7..5d2d07aa08ce 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -487,6 +487,32 @@ static int valid_vaddr(struct ve_info *ve, enum insn_mmio_type mmio, int size,
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
+	} else {
+		if (copy_from_kernel_nofault(buffer, (void *)regs->ip, MAX_INSN_SIZE))
+			return -EFAULT;
+
+		if (insn_decode(insn, buffer, MAX_INSN_SIZE, INSN_MODE_64))
+			return -EINVAL;
+	}
+
+	if (!insn->immediate.got)
+		return -EINVAL;
+
+	return 0;
+}
+
 static int handle_mmio_write(struct insn *insn, enum insn_mmio_type mmio, int size,
 			     struct pt_regs *regs, struct ve_info *ve)
 {
@@ -567,21 +593,14 @@ static int handle_mmio_read(struct insn *insn, enum insn_mmio_type mmio, int siz
 
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
@@ -777,6 +796,10 @@ static int virt_exception_user(struct pt_regs *regs, struct ve_info *ve)
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


