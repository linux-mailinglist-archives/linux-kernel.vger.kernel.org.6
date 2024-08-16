Return-Path: <linux-kernel+bounces-289757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69D63954B5A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 15:47:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B159B20E97
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 13:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E39321BD016;
	Fri, 16 Aug 2024 13:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qF1dMihl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F49F1BD02A;
	Fri, 16 Aug 2024 13:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723815927; cv=none; b=FAnVpRGnDIeChAM+iZVjxoEiPRrXA7HCq4qzfABlKnj7LCwVDKamdsfywbWjHLvALwU9GUeKoLwVtP8QzmqTb+7hqnkSuOtL3AV8eLkqJQjoNIcUh7igeH2v5pAky2G6mMgshni5vgxSjwMuFokxUNMyPeLtP7GIKAqoD+y6EbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723815927; c=relaxed/simple;
	bh=fWwOfudJtdwdjI/VfKTv2mK20greegDMKRi2pde9jE4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qVMniI40vhAGjfylW36GNxlTRjIobkts3TVy69kAPRD8dVD/OQCVsUMt8e2mD/6ddG9cbSdoItDYvXrQbI58V8ztj/Lj1K2w0xHCRlag3e8/5lbtNVrwlJDZgOp8c5aSBA38eUEkkkktDFhBubhL0Mnq+cSr+J1qf3CKhbB4sK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qF1dMihl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01364C32782;
	Fri, 16 Aug 2024 13:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723815926;
	bh=fWwOfudJtdwdjI/VfKTv2mK20greegDMKRi2pde9jE4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qF1dMihlaeFZyRaL7rG8ySi2nOSxwWEk62XyuOoWIKniyf5MJhdn9Mt7vcCBnyfUQ
	 FNkyJ4kpGSMClMbp75Mrc46dJFy6m9llqGJSG+xWcS9b5kktEIR9gktiMvhoxs/2oP
	 of48Q6zi50VDRsa2NR7dQ8yc3Pg936pUfm/HUpvzME8JEzlCvJK+/5rz6oFUCFkooi
	 MSkRfjMKXPPGRYzNYE6Es42tbxHy1YqHYrTdkj6nVvT2xJb3Er6a6NKkv5rhLkmj8g
	 FKSObC8hxqSDESel8NQlMa/Kw7CyJlPNCRzXFsQFeczHAQxcaQ8lXXdTy0q0Eq5OP8
	 0zizwPXiKb+Ew==
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
Subject: [PATCH v3 08/10] x86/tdx: Add a restriction on access to MMIO address
Date: Fri, 16 Aug 2024 15:43:58 +0200
Message-ID: <7a4c51f7ccd11c3197f05a1affd6fdbcfad6baad.1723807851.git.legion@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1723807851.git.legion@kernel.org>
References: <cover.1722862355.git.legion@kernel.org> <cover.1723807851.git.legion@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Alexey Gladkov (Intel)" <legion@kernel.org>

In the case of userspace MMIO, if the user instruction + MAX_INSN_SIZE
straddles page, then the "fetch" in the kernel could trigger a #VE. In
this case the kernel would handle this second #VE as a !user_mode() MMIO.
That way, additional address verifications can be avoided.

The scenario of accessing userspace MMIO addresses from kernelspace does
not seem appropriate under normal circumstances. Until there is a
specific usecase for such a scenario it can be disabled.

Signed-off-by: Alexey Gladkov (Intel) <legion@kernel.org>
---
 arch/x86/coco/tdx/tdx.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index e3d692342603..94541ee724db 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -411,6 +411,11 @@ static inline bool is_private_gpa(u64 gpa)
 	return gpa == cc_mkenc(gpa);
 }
 
+static inline bool is_kernel_addr(unsigned long addr)
+{
+	return (long)addr < 0;
+}
+
 static int get_phys_addr(unsigned long addr, phys_addr_t *phys_addr, bool *writable)
 {
 	unsigned int level;
@@ -592,6 +597,7 @@ static int handle_mmio(struct pt_regs *regs, struct ve_info *ve)
 	unsigned long vaddr;
 	int size, ret;
 
+
 	ret = decode_insn_struct(&insn, regs);
 	if (ret)
 		return ret;
@@ -600,6 +606,11 @@ static int handle_mmio(struct pt_regs *regs, struct ve_info *ve)
 	if (WARN_ON_ONCE(mmio == INSN_MMIO_DECODE_FAILED))
 		return -EINVAL;
 
+	if (!user_mode(regs) && !is_kernel_addr(ve->gla)) {
+		WARN_ONCE(1, "Access to userspace address is not supported");
+		return -EINVAL;
+	}
+
 	vaddr = (unsigned long)insn_get_addr_ref(&insn, regs);
 
 	if (current->mm) {
-- 
2.45.2


