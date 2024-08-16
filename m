Return-Path: <linux-kernel+bounces-289753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27092954B56
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 15:46:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AD381C20B1A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 13:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 353431BC9F9;
	Fri, 16 Aug 2024 13:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LJ2oiF6i"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B251AD41D;
	Fri, 16 Aug 2024 13:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723815909; cv=none; b=brIh6KFUbO1KaIZLpP6QG003gWIRULEKOyhqmx9yoOnuTNbrdI8EO0go8c1+LO9R+yoIcHWfq4aOIXkjB3D2TwgM0b7PgUn8syzE8uWlucrEq2eNjZHLcAzU4C5d70kD1zu+1Hm81bnkG0CmQ8amUtZWkJjpT3hSBHZMrfW5g6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723815909; c=relaxed/simple;
	bh=UmfOwHRSoQh66VG7xeNgJsIpyeVJCPweXU97i/kW76g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=US4c6Ca7rHSezezR1jM3PQQe+a+CCPP9H2mFx/kVwX/xVNvGOCysRMFDVlVD5wFAbLFYXjc0xznMiyPgdoZuTYHYqtCCwt7Oj4jua/r1ZjhwtTbJjF0eDLs1fhknLFZ+DckgvokzLHZw9UbgfBPQUzjClMsMO3BvGjyJ8li7zeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LJ2oiF6i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1CEAC4AF0C;
	Fri, 16 Aug 2024 13:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723815909;
	bh=UmfOwHRSoQh66VG7xeNgJsIpyeVJCPweXU97i/kW76g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LJ2oiF6ibBfEWVue4Wx+zaW1OlnkoVUo+A/tsYDxA9Lgi685PXJLGDIZqJJqm0/yK
	 FVcVhK9DXQf+NH1jW9az5sQ9I1qIwcxQQIBgPiej/kMtLOqEOxXoZq4Qi8xz8Vaeai
	 0JAFiUqcnfJDP10gKU3Sw9X/L4PaqoEIXf8H90eyHE4d18LZ6lRPallGwzqicZz2zX
	 hF8A+CENcOfAhw/sqN2EKJ6wd1err2DI3txRvEILNI0+yKwaEM3hSrxTWqaCYlwvYH
	 4XbPkhuL54H/IWkLlFWOcpRCMC68ZCKZyTnDmehIJErfBM3YB6pgYFlibC0+lLTVIb
	 QVRudgm5G7KWQ==
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
	Tom Lendacky <thomas.lendacky@amd.com>,
	Kevin Loughlin <kevinloughlin@google.com>,
	Nikunj A Dadhania <nikunj@amd.com>,
	cho@microsoft.com,
	decui@microsoft.com,
	John.Starks@microsoft.com
Subject: [PATCH v3 04/10] x86/insn: Read and decode insn without crossing the page boundary
Date: Fri, 16 Aug 2024 15:43:54 +0200
Message-ID: <9704da6a35d62932d464d33b39953fc5b2fd74ea.1723807851.git.legion@kernel.org>
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

In case the instruction is close to the page boundary, reading
MAX_INSN_SIZE may cross the page boundary. The second page might be
from a different VMA and reading can have side effects.

The problem is that the actual size of the instruction is not known.

The solution might be to try read the data to the end of the page and
try parse it in the hope that the instruction is smaller than the
maximum buffer size.

Co-developed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Alexey Gladkov (Intel) <legion@kernel.org>
---
 arch/x86/include/asm/insn-eval.h | 15 +++++++++
 arch/x86/lib/insn-eval.c         | 55 ++++++++++++++++++++++++++++++++
 2 files changed, 70 insertions(+)

diff --git a/arch/x86/include/asm/insn-eval.h b/arch/x86/include/asm/insn-eval.h
index 54368a43abf6..160e483bde99 100644
--- a/arch/x86/include/asm/insn-eval.h
+++ b/arch/x86/include/asm/insn-eval.h
@@ -32,6 +32,21 @@ int insn_fetch_from_user_inatomic(struct pt_regs *regs,
 bool insn_decode_from_regs(struct insn *insn, struct pt_regs *regs,
 			   unsigned char buf[MAX_INSN_SIZE], int buf_size);
 
+int insn_fetch_decode_from_user_common(struct insn *insn, struct pt_regs *regs,
+				       bool inatomic);
+
+static inline int insn_fetch_decode_from_user(struct insn *insn,
+					      struct pt_regs *regs)
+{
+	return insn_fetch_decode_from_user_common(insn, regs, false);
+}
+
+static inline int insn_fetch_decode_from_user_inatomic(struct insn *insn,
+						       struct pt_regs *regs)
+{
+	return insn_fetch_decode_from_user_common(insn, regs, true);
+}
+
 enum insn_mmio_type {
 	INSN_MMIO_DECODE_FAILED,
 	INSN_MMIO_WRITE,
diff --git a/arch/x86/lib/insn-eval.c b/arch/x86/lib/insn-eval.c
index 98631c0e7a11..67bfb645df67 100644
--- a/arch/x86/lib/insn-eval.c
+++ b/arch/x86/lib/insn-eval.c
@@ -1668,3 +1668,58 @@ enum insn_mmio_type insn_decode_mmio(struct insn *insn, int *bytes)
 
 	return type;
 }
+
+/**
+ * insn_fetch_decode_from_user_common() - Copy and decode instruction bytes
+ *                                        from user-space memory
+ * @buf:	Array to store the fetched instruction
+ * @regs:	Structure with register values as seen when entering kernel mode
+ * @inatomic	boolean flag whether function is used in atomic context
+ *
+ * Gets the linear address of the instruction and copies the instruction bytes
+ * and decodes the instruction.
+ *
+ * Returns:
+ *
+ * - 0 on success.
+ * - -EFAULT if the copy from userspace fails.
+ * - -EINVAL if the linear address of the instruction could not be calculated.
+ */
+int insn_fetch_decode_from_user_common(struct insn *insn, struct pt_regs *regs,
+				bool inatomic)
+{
+	char buffer[MAX_INSN_SIZE];
+	int nr_copied, size;
+	unsigned long ip;
+
+	if (insn_get_effective_ip(regs, &ip))
+		return -EINVAL;
+
+	/*
+	 * On the first attempt, read up to MAX_INSN_SIZE, but do not cross a
+	 * page boundary. The second page might be from a different VMA and
+	 * reading can have side effects (i.e. reading from MMIO).
+	 */
+	size = min(MAX_INSN_SIZE, PAGE_SIZE - offset_in_page(ip));
+retry:
+	nr_copied = size;
+
+	if (inatomic)
+		nr_copied -= __copy_from_user_inatomic(buffer, (void __user *)ip, size);
+	else
+		nr_copied -= copy_from_user(buffer, (void __user *)ip, size);
+
+	if (nr_copied <= 0)
+		return -EFAULT;
+
+	if (!insn_decode_from_regs(insn, regs, buffer, nr_copied)) {
+		/* If decode failed, try to copy across page boundary */
+		if (size < MAX_INSN_SIZE) {
+			size = MAX_INSN_SIZE;
+			goto retry;
+		}
+		return -EINVAL;
+	}
+
+	return 0;
+}
-- 
2.45.2


