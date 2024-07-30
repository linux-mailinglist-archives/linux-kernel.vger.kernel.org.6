Return-Path: <linux-kernel+bounces-267971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1898A941EE7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 19:37:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 437811C21771
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 17:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 901FB18A6DE;
	Tue, 30 Jul 2024 17:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k5kQo9IO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB971A76C6;
	Tue, 30 Jul 2024 17:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722360988; cv=none; b=CNCJ1eveKTTqPnQ7Y8IHmapxtclVtwwuLHCDObAONehhkA/k1bHCqbX1I/lRy15yz/fm9Nw8mKtLVnzpKdfK7zTpdpveEf3lJF7UTMVU2E7+Hy+UFvAO9gb5OjUMhkp+A/H092kk8QUSaiHxMfLq7NesdZzXFrmU0vSWEpnmADk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722360988; c=relaxed/simple;
	bh=xpjzJRz2Yty9K9l0Pcl5A9Xyutcf4oMMCTmjT65gKoo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cl5UnVGsTujyizaepcpBJ2i3y+TaQsoDL8VQImoGQBKn2vIPOhykhzprmdUYETNPgJCvBLOQtf5eM61LXK8jxbTFDpIlu6KEb0E8r6TA0rTUrhZ7USp+HZ88nlrCJtIWMPLxtdd15J5UQKxT/wRAEL1KYxNn4DFLw5mhDX+txtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k5kQo9IO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9259AC32782;
	Tue, 30 Jul 2024 17:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722360988;
	bh=xpjzJRz2Yty9K9l0Pcl5A9Xyutcf4oMMCTmjT65gKoo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k5kQo9IOTnf3lKFfFkx74I6jo0FNPImZaWi5l2BKhFsHi22rcZmvb65b/hp5fnriP
	 8Gd/LBOZQL+7r+HGkaI2wf0yNJJF7XPi5bklM3XWIZyUaUyUo8w6lDociBKsLjoC4O
	 JP3U4uWqNF5hkMCoacj3aT3VCxxuzsEJCYxPP/W/l49ElcVZI8lS9H7qJIbXQyAosz
	 8I04UTfp65FjT6LSVhQ0BmeAh4/Brg8MBW3swytkXJMRHnIIhaZxwtPYPg6p3c1OVA
	 P6+8NuCajlTvW52bFTyw80Fi++BTZpy5tebNsi2+qQp7+CLJVQuz04Y/Eq/IAFYJBi
	 TzP54GsmTN7OA==
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
Subject: [PATCH v1 3/4] x86/tdx: Allow MMIO from userspace
Date: Tue, 30 Jul 2024 19:35:58 +0200
Message-ID: <0331020dce360b77e40c53dfdb0624574dbb249f.1722356794.git.legion@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1722356794.git.legion@kernel.org>
References: <cover.1722356794.git.legion@kernel.org>
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

Signed-off-by: Alexey Gladkov (Intel) <legion@kernel.org>
---
 arch/x86/coco/tdx/tdx.c | 42 +++++++++++++++++++++++++++++++----------
 1 file changed, 32 insertions(+), 10 deletions(-)

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index 8c894ee9c245..26b2e52457be 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -474,6 +474,31 @@ static int valid_vaddr(struct ve_info *ve, enum insn_mmio_type mmio, int size,
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
@@ -554,20 +579,13 @@ static int handle_mmio_read(struct insn *insn, enum insn_mmio_type mmio, int siz
 static int handle_mmio(struct pt_regs *regs, struct ve_info *ve)
 {
 	unsigned long vaddr;
-	char buffer[MAX_INSN_SIZE];
 	enum insn_mmio_type mmio;
 	struct insn insn = {};
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
@@ -763,6 +781,10 @@ static int virt_exception_user(struct pt_regs *regs, struct ve_info *ve)
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


