Return-Path: <linux-kernel+bounces-279777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4396994C1B3
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 17:44:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC6DF1F23B48
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 15:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D675219048D;
	Thu,  8 Aug 2024 15:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O/rg45xc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2583318FC9A;
	Thu,  8 Aug 2024 15:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723131807; cv=none; b=W84e669A1mZDXSiSKBaYKGUZrMx3WJZfyBG8nmVqg3RN4Sz0n1eqvoudYIfGA6VFX+vUsLdDf03pA5ARg6M3D1lwFgRaBLJhF+cqUu8XfdP4WDlmjCg4ppANvTB0E1dadjO5rnvt84nZsxzjiFLn0w8KltVwrJoKU+OZXWK4PFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723131807; c=relaxed/simple;
	bh=sBNWmAsl748mI6sZ5oeJJ5R2kmjFzD4s7IW0KxK/il8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tTGDMlqw/rWhCIlK78xxtR55j/yCINLAPGmA9USnV7N02xqjuSa7SN65J2HI5OL67nl4OdGrqSmWw4ZWKQNgkrhfKFQUxDriPaamFn+5ureqX4KNOSG7oQcqGDFS/nNM5Qd5qIbRBZzYpbliTSkpydPUxaW3IS7lZLztGZPn50A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O/rg45xc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED8E7C4AF0D;
	Thu,  8 Aug 2024 15:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723131806;
	bh=sBNWmAsl748mI6sZ5oeJJ5R2kmjFzD4s7IW0KxK/il8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O/rg45xcVymZlv8kQrmuAWcZdXcLpQCEKNVRMdK56kisTZWqkeWWKAZAmpOKHV2Ok
	 hZT2msqP0Y474oRflWmHww0wLEY8I02uriCZXR66AL3zThGKbC/cV4cu0NL42sSV8o
	 s2a7TILdETHKw4lz238R3obFSKuXN7gEAPgtklHf4XNxAlrDLB4rqv6aWQFsqyXHF1
	 LRBs1+CM9cPhPKlgCeXhsGcxmU2vycuHMgaAkN+Me5S3XNTRePhdng4LtjAU7NUUMV
	 BhE/Te2Nv8W583rf+5VK9mUIlgO+oZeSjQnIRM0vubgzLiWK/4SFgrXIjVZjLK+oGQ
	 TYG+y4jUNAA1Q==
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
Subject: [PATCH v3 6/7] x86/tdx: Add a restriction on access to MMIO address
Date: Thu,  8 Aug 2024 17:42:46 +0200
Message-ID: <89033a0cb3ed3ef4c48db7bc712ec2ea3a956524.1723130802.git.legion@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <6f989aea155817ef2f8a5fd2240ccff3f74d4edd.1722862355.git.legion@kernel.org>
References: <83c9b05e7d359c0486a061f3bd31920ddb5c33a0.camel@intel.com> <6f989aea155817ef2f8a5fd2240ccff3f74d4edd.1722862355.git.legion@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the case of userspace MMIO, if the user instruction + MAX_INSN_SIZE
straddles page, then the "fetch" in the kernel could trigger a #VE. In
this case the kernel would handle this second #VE as a !user_mode() MMIO.
That way, additional address verifications can be avoided.

The scenario of accessing userspace MMIO addresses from kernelspace does
not seem appropriate under normal circumstances. Until there is a
specific usecase for such a scenario it can be disabled.

Signed-off-by: Alexey Gladkov (Intel) <legion@kernel.org>
---
 arch/x86/coco/tdx/tdx.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index dfadb085d2d3..5b3421a89998 100644
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
@@ -641,6 +646,7 @@ static int handle_mmio(struct pt_regs *regs, struct ve_info *ve)
 	unsigned long vaddr;
 	int size, ret;
 
+
 	ret = decode_insn_struct(&insn, regs);
 	if (ret)
 		return ret;
@@ -661,6 +667,9 @@ static int handle_mmio(struct pt_regs *regs, struct ve_info *ve)
 		ret = valid_vaddr(ve, mmio, size, vaddr);
 		if (ret)
 			goto unlock;
+	} else if (!is_kernel_addr(ve->gla)) {
+		WARN_ONCE(1, "Access to userspace address is not supported");
+		return -EINVAL;
 	}
 
 	/*
-- 
2.45.2


